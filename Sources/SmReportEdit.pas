unit SmReportEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Tools, Main, DataModule, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Clipbrd,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons,
  JvComponentBase, JvBalloonHint, Vcl.Samples.Spin;

type
  TfSmReportEdit = class(TSmForm)
    pgc: TPageControl;
    tsData: TTabSheet;
    tsView: TTabSheet;
    pgcData: TPageControl;
    tsRows: TTabSheet;
    tsFields: TTabSheet;
    grRows: TJvDBGrid;
    qrRows: TFDQuery;
    dsRows: TDataSource;
    qrCols: TFDQuery;
    dsCols: TDataSource;
    geCols: TJvDBGrid;
    tsCalc: TTabSheet;
    grCell: TJvDBGrid;
    tsVar: TTabSheet;
    grVars: TJvDBGrid;
    qrVars: TFDQuery;
    dsVars: TDataSource;
    qrRepCell: TFDQuery;
    dsRepCell: TDataSource;
    tsPreView: TTabSheet;
    qrPreview: TFDQuery;
    dsPreview: TDataSource;
    JvDBGrid5: TJvDBGrid;
    pnl1: TPanel;
    mmoLog: TMemo;
    mmoInParams: TMemo;
    pnl2: TPanel;
    dbnvgr4: TDBNavigator;
    pnl3: TPanel;
    dbnvgr1: TDBNavigator;
    pnl4: TPanel;
    dbnvgr2: TDBNavigator;
    qrVarType: TFDQuery;
    dsVarType: TDataSource;
    btnTest: TButton;
    pnl5: TPanel;
    lbl1: TLabel;
    edtFormul: TEdit;
    btnSaveFormul: TSpeedButton;
    qrVarsREPORT_VAR_ID: TFDAutoIncField;
    qrVarsREPORT_ID: TIntegerField;
    qrVarsREPORT_VAR_NAME: TStringField;
    qrVarsREPORT_VAR_DESCR: TStringField;
    qrVarsREPORT_VAR_VAL: TStringField;
    qrVarsREPORT_VAR_TYPE: TIntegerField;
    qrVarsLK_TYPE: TStringField;
    lblCellLink: TLabel;
    bh: TBalloonHint;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure qrRowsBeforeOpen(DataSet: TDataSet);
    procedure qrRowsNewRecord(DataSet: TDataSet);
    procedure pgcDataChange(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure grCellColEnter(Sender: TObject);
    procedure grCellCellClick(Column: TColumn);
    procedure btnSaveFormulClick(Sender: TObject);
    procedure lblCellLinkClick(Sender: TObject);
    procedure qrRepCellAfterScroll(DataSet: TDataSet);
  private
    REPORT_ID: Variant;
    ROW_ID, COL_ID: Variant;
    procedure buildReport(const AREPORT_ID: Integer);
  public
    { Public declarations }
  end;

var
  fSmReportEdit: TfSmReportEdit;

implementation

{$R *.dfm}

procedure TfSmReportEdit.btnSaveFormulClick(Sender: TObject);
begin
  // Если были изменения в фомуле расчета
  if not VarIsNull(COL_ID) and (qrRepCell.FieldByName(grCell.SelectedField.FieldName).AsString
    <> edtFormul.Text) then
  begin
    FastExecSQL('INSERT INTO report_cell(REPORT_CELL_VAL, ROW_ID, COL_ID, REPORT_ID) VALUES(:0,:1,:2,:3) ON DUPLICATE KEY UPDATE REPORT_CELL_VAL=:4;',
      VarArrayOf([Trim(edtFormul.Text), ROW_ID, COL_ID, REPORT_ID, Trim(edtFormul.Text)]));
    CloseOpen(qrRepCell);
  end;
end;

procedure TfSmReportEdit.btnTestClick(Sender: TObject);
begin
  buildReport(REPORT_ID);
end;

procedure TfSmReportEdit.buildReport(const AREPORT_ID: Integer);
var
  fullQuery, qr, SELECT, INTO, TABLE, FORMUL: string;
  OLD_REPORT_VAR_TYPE, formulCache: Variant;
  q, qrCol: TFDQuery;
  startTime: Int64;
  rowCnt: Integer;

  procedure InitVariableType(const AREPORT_VAR_TYPE: Integer);
  begin
    qr := 'SELECT ' + SELECT + ''#13 + 'INTO ' + INTO + ''#13 + 'FROM ' + TABLE + ''#13;
    case OLD_REPORT_VAR_TYPE of
      // Настройка расчета (@OBJ_ID/@SM_ID) - не/обязательные входные параметры
      1:
        begin
          qr := qr +
            'WHERE ((@OBJ_ID IS NULL) OR (OBJ_ID = @OBJ_ID)) AND IFNULL(SM_ID, 0) = IFNULL(@SM_ID, 0) LIMIT 1;';
        end;
      // Сводный сметный расчет (@OBJ_ID/@SM_ID) - не/обязательные входные параметры
      2:
        begin
          qr := qr +
            'INNER JOIN smetasourcedata s ON s.SM_ID = summary_calculation.SM_ID'#13 +
            '  AND s.ACT = 0'#13 +  //  Пока только для смет
            '  AND ((@OBJ_ID IS NULL) OR (s.OBJ_ID = @OBJ_ID))'#13 +
            '  AND ((@SM_ID IS NULL) OR (s.TREE_PATH LIKE CONCAT((SELECT s2.TREE_PATH FROM smetasourcedata s2 WHERE s2.SM_ID=@SM_ID), "%")));';
        end;
      // Объект  (@OBJ_ID) - обязательный входной параметр
      3:
        begin
          qr := qr +
            'WHERE OBJ_ID = @OBJ_ID';
        end;
      4:
        begin

        end;

    end;
    // Записываем глобальные переменные
    FastExecSQL(qr, VarArrayOf([]));
    // Собираем общий скрипт сборки
    fullQuery := qr + ''#13;
    SELECT := '';
    INTO := '';
  end;

  function GetFormul(const R_ID, C_ID: Variant): string;
  var
    L, H, I, C: Integer;
  begin
    Result := '';

    L := 0;
    H := VarArrayHighBound(formulCache, 1) - 1;
    while L <= H do
    begin
      I := (L + H) shr 1;
      if (formulCache[I][0] = R_ID) and (formulCache[I][1] = C_ID) then
        C := 0
      else
        if (formulCache[I][0] * 10000 + formulCache[I][1]) <= (R_ID * 10000 + C_ID) then
          C := -1
        else
          C := 1;
      if C < 0 then
        L := I + 1
      else
      begin
        H := I - 1;
        if C = 0 then
        begin
          Result := formulCache[I][2];
          Break;
        end;
      end;
    end;
  end;

  function SetFormul(const R_ID, C_ID: Variant; var AFormul: string): Boolean;
  var
    L, H, I, C: Integer;
    tmp: Variant;
  begin
    Result := False;

    L := 0;
    H := VarArrayHighBound(formulCache, 1) - 1;
    while L <= H do
    begin
      I := (L + H) shr 1;
      if (formulCache[I][0] = R_ID) and (formulCache[I][1] = C_ID) then
        C := 0
      else
        if (formulCache[I][0] * 10000 + formulCache[I][1]) <= (R_ID * 10000 + C_ID) then
          C := -1
        else
          C := 1;
      if C < 0 then
        L := I + 1
      else
      begin
        H := I - 1;
        if C = 0 then
        begin
          Result := True;
          tmp := formulCache[I];
          tmp[2] := FastSelectSQLOne('SELECT ' + AFormul, VarArrayOf([]));
          AFormul := tmp[2];
          formulCache[I] := tmp;
          Break;
        end;
      end;
    end;
  end;

  // Функция парсинга формулы
  function ParseFormul(const AFormul: string): string;
  var
    ROW_ID, COL_ID, sp, fp, offset: Integer;
    SubLinkFormul: string;
  begin
    Result := AFormul;
    offset := 1;
    while Pos('[', Result, offset) > 0 do
    begin
      sp := Pos('[', Result, offset);
      fp := Pos(']', Result, sp);
      SubLinkFormul := Copy(Result, sp + 1, fp - sp - 1);
      ROW_ID := StrToInt(Copy(SubLinkFormul, 0, Pos(':', SubLinkFormul) - 1));
      COL_ID := StrToInt(Copy(SubLinkFormul, Pos(':', SubLinkFormul) + 1, length
        (SubLinkFormul) - 1));
      SubLinkFormul := GetFormul(ROW_ID, COL_ID);
      if SubLinkFormul <> '' then
        SubLinkFormul := '(' + SubLinkFormul + ')';
      Result := Copy(Result, 0, sp - 1) + SubLinkFormul + Copy(Result, fp + 1, length(Result) - 1);
      offset := sp;
    end;
    if (Result <> '') then
      SetFormul(q.FieldByName('ROW_ID').Value, qrCol.FieldByName('COL_ID').Value, Result);
  end;

begin
  // Процедуда постройки отчета
  // DEBUG-->
  FastExecSQL(mmoInParams.Text, VarArrayOf([]));
  // <--DEBUG
  formulCache := FastSelectSQL('SELECT ROW_ID, COL_ID, REPORT_CELL_VAL, NULL FROM report_cell WHERE REPORT_ID=:0 ORDER BY ROW_ID, COL_ID', VarArrayOf([AREPORT_ID]));
  q := DM.qrDifferent;
  qrCol := DM.qrDifferent1;
  fullQuery := '';
  // Инициализация переменных отчета-->
  q.SQL.Text := 'SELECT'#13 +
    '  rv.`REPORT_VAR_NAME`,'#13 +
    '  rv.`REPORT_VAR_TYPE`,'#13 +
    '  rvt.`TABLE_NAME`,'#13 +
    '  rv.`REPORT_VAR_VAL`'#13 +
    'FROM `report_var` rv '#13 +
    'LEFT JOIN `report_var_type` rvt ON rvt.`REPORT_VAR_TYPE_ID`=rv.`REPORT_VAR_TYPE`'#13 +
    'WHERE rv.`REPORT_ID` = :REPORT_ID'#13 +
    'ORDER BY rv.REPORT_VAR_TYPE';
  q.ParamByName('REPORT_ID').Value := AREPORT_ID;
  q.Active := True;
  q.First;
  SELECT := '';
  INTO := '';
  qr := '';
  OLD_REPORT_VAR_TYPE := q.FieldByName('REPORT_VAR_TYPE').Value;
  while not q.Eof do
  begin
    if q.FieldByName('REPORT_VAR_TYPE').Value <> OLD_REPORT_VAR_TYPE then
    begin
      InitVariableType(OLD_REPORT_VAR_TYPE);
      OLD_REPORT_VAR_TYPE := q.FieldByName('REPORT_VAR_TYPE').Value;
    end;

    SELECT := IIF(SELECT = '', '', SELECT + ', ') + q.FieldByName('REPORT_VAR_VAL').AsString;
    INTO := IIF(INTO = '', '@', INTO + ', @') + q.FieldByName('REPORT_VAR_NAME').AsString;
    TABLE := q.FieldByName('TABLE_NAME').AsString;

    q.Next;
  end;
  q.Active := False;
  InitVariableType(OLD_REPORT_VAR_TYPE);
  // <--Инициализация переменных отчета
  // mmoLog.Lines.Add(fullQuery);

  // Сборка общего запроса на вывод отчета-->
  fullQuery := '';
  startTime := GetTickCount;
  // Строки отчета
  q.SQL.Text := 'SELECT *'#13 +
    'FROM report_row'#13 +
    'WHERE REPORT_ID = :REPORT_ID'#13 +
    'ORDER BY POS';
  q.ParamByName('REPORT_ID').Value := AREPORT_ID;
  q.Active := True;
  q.First;
  // Колонки отчета
  qrCol.SQL.Text := 'SELECT *'#13 +
    'FROM report_col'#13 +
    'WHERE REPORT_ID = :REPORT_ID'#13 +
    'ORDER BY POS';
  qrCol.ParamByName('REPORT_ID').Value := AREPORT_ID;
  qrCol.Active := True;

  // Формируем шапку таблицы
  {
  qrCol.First;
  SELECT := '';
  while not qrCol.Eof do
  begin
    SELECT := IIF(SELECT = '', '"', SELECT + ', "') + qrCol.FieldByName('REPORT_COL_LABEL').AsString + '"';
    qrCol.Next;
  end;
  fullQuery := 'SELECT ' + SELECT + ''#13;
  }

  // Проходим все источники строк отчета
  rowCnt := 0;
  while not q.Eof do
  begin
    if fullQuery <> '' then
      fullQuery := fullQuery + 'UNION ALL'#13;

    qrCol.First;
    SELECT := '';
    // Проходим все колонки отчета
    while not qrCol.Eof do
    begin
      if qrCol.FieldByName('FL_PRINT_ROW_NAME').Value = 1 then
        FORMUL := '"' + q.FieldByName('REPORT_ROW_NAME').AsString + '"'
      else
        FORMUL := ParseFormul(GetFormul(q.FieldByName('ROW_ID').Value, qrCol.FieldByName('COL_ID').Value));
      SELECT := IIF(SELECT = '', '', SELECT + ', ') + IIF(FORMUL = '', 'NULL', FORMUL);

        if q.RecNo = 1 then
        SELECT := SELECT + ' AS F' {+ qrCol.FieldByName
        ('REPORT_COL_LABEL').AsString + '"'};

      qrCol.Next;
    end;
    fullQuery := fullQuery + 'SELECT ' + SELECT + ''#13;
    q.Next;
    Inc(rowCnt);
  end;
  q.Active := False;
  qrCol.Active := False;
  mmoLog.Lines.Add('Prepare time: ' + IntToStr(GetTickCount - startTime));
  // <--Сборка общего запроса на вывод отчета
  qrPreview.SQL.Text := fullQuery;
//qrPreview.SQL.SaveToFile('c:\report.sql');
  startTime := GetTickCount;
  qrPreview.Active := True;
  mmoLog.Lines.Add('Exec time: ' + IntToStr(GetTickCount - startTime));
end;

procedure TfSmReportEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qrRows.CheckBrowseMode;
  qrCols.CheckBrowseMode;
  qrVars.CheckBrowseMode;
  qrVars.Active := False;
  qrRows.Active := False;
  qrCols.Active := False;
  qrVarType.Active := False;
  Action := caFree;
end;

procedure TfSmReportEdit.FormCreate(Sender: TObject);
begin
  REPORT_ID := InitParams;
  qrRows.Active := True;
  qrCols.Active := True;
  qrVars.Active := True;
  qrVarType.Active := True;
end;

procedure TfSmReportEdit.FormDestroy(Sender: TObject);
begin
  fSmReportEdit := nil;
end;

procedure TfSmReportEdit.grCellCellClick(Column: TColumn);
begin
  grCellColEnter(nil);
end;

procedure TfSmReportEdit.grCellColEnter(Sender: TObject);
begin
  //dbedtROW_NAME.DataField := grCell.SelectedField.FieldName; //  Column.FieldName;
  edtFormul.Text := qrRepCell.FieldByName(grCell.SelectedField.FieldName).AsString;
  ROW_ID := qrRepCell.FieldByName('ROW_ID').Value;
  if qrRepCell.FindField('ID' + grCell.SelectedField.FieldName) <> nil then
  begin
    COL_ID := qrRepCell.FieldByName('ID' + grCell.SelectedField.FieldName).Value;
    lblCellLink.Caption := '[' + IntToStr(ROW_ID) + ':' + IntToStr(COL_ID) + ']'
  end
  else
  begin
    COL_ID := Null;
    lblCellLink.Caption := '';
  end;
end;

procedure TfSmReportEdit.lblCellLinkClick(Sender: TObject);
var
  point: TPoint;
begin
  // Копируем ссылку на ячейку в буфер
  Clipboard.AsText := lblCellLink.Caption;
  bh.Title := 'Информция';
  bh.Description := 'Значение скопировано в буфер обмена';
  point.X := lblCellLink.Width;
  point.Y := lblCellLink.Height;
  bh.ShowHint(lblCellLink.ClientToScreen(point));
end;

procedure TfSmReportEdit.pgcDataChange(Sender: TObject);
var
  fields: string;
  fCount: Integer;
begin
  if pgcData.ActivePage <> tsCalc then
    Exit;

  ROW_ID := Null;
  COL_ID := Null;

  grCell.Columns.Clear;
  fields := 'SELECT r.REPORT_ROW_NAME AS ROW_NAME';
  addCol(grCell, 'ROW_ID', '', 30);
  addCol(grCell, 'ROW_NAME', 'Нименование', 300);
  fCount := 1;
  qrCols.First;

  while not qrCols.Eof do
  begin
    fields := fields +
      ', (SELECT REPORT_CELL_VAL FROM report_cell WHERE REPORT_ID=r.REPORT_ID AND ROW_ID=r.ROW_ID AND COL_ID=' +
      qrCols.FieldByName('COL_ID').AsString + ') AS F' + IntToStr(fCount) + ''#13;
    fields := fields + ', ' + qrCols.FieldByName('COL_ID').AsString +
      ' AS IDF' + IntToStr(fCount) + ''#13;

    if qrCols.FieldByName('FL_PRINT_ROW_NAME').Value <> 1 then
      addCol(grCell, 'F' + IntToStr(fCount), qrCols.FieldByName('REPORT_COL_LABEL').AsString,
      100);
    Inc(fCount);
    qrCols.Next;
  end;

  fields := fields + ', r.ROW_ID' + ''#13;

  qrRepCell.SQL.Text := fields +
    'FROM report_row r WHERE r.REPORT_ID=:REPORT_ID ORDER BY r.POS';
  CloseOpen(qrRepCell);
end;

procedure TfSmReportEdit.qrRepCellAfterScroll(DataSet: TDataSet);
begin
  grCellColEnter(nil);
end;

procedure TfSmReportEdit.qrRowsBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('REPORT_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('REPORT_ID').Value := REPORT_ID;
end;

procedure TfSmReportEdit.qrRowsNewRecord(DataSet: TDataSet);
begin
  (DataSet as TFDQuery).FieldByName('REPORT_ID').Value := REPORT_ID;
end;

end.
