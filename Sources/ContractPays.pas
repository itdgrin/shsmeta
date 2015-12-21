unit ContractPays;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, DataModule, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, JvExDBGrids,
  JvDBGrid, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.DateUtils, Main, Vcl.Buttons, System.UITypes,
  JvComponentBase, JvFormPlacement;

type
  TfContractPays = class(TSmForm)
    pnlTopEstimate: TPanel;
    pnlTopSourceData: TPanel;
    pnlClient: TPanel;
    lblEstimate: TLabel;
    dbedtFN_getSMName: TDBEdit;
    grMain: TJvDBGrid;
    qrHead: TFDQuery;
    dsHead: TDataSource;
    GridPanel2: TGridPanel;
    lbl1: TLabel;
    dbtxtBEG_STROJ: TDBText;
    lbl2: TLabel;
    dbtxtBEG_STROJ2: TDBText;
    lbl3: TLabel;
    dbtxtSROK_STROJ: TDBText;
    qrMain: TFDQuery;
    dsMain: TDataSource;
    FormStorage: TJvFormStorage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qrHeadBeforeOpen(DataSet: TDataSet);
    procedure qrMainBeforePost(DataSet: TDataSet);
    procedure grMainCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
    procedure grMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    idObject: Integer;
    procedure ReloadMain;
  public
    { Public declarations }
  end;

var
  fContractPays: TfContractPays;

implementation

{$R *.dfm}

procedure TfContractPays.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfContractPays.FormCreate(Sender: TObject);
var
  i: Integer;
  tmpDate: TDate;
begin
  idObject := InitParams[0];

  qrHead.Active := True;
  // Создаем месяца расчета, если не созданы
  for i := -1 to qrHead.FieldByName('SROK_STROJ').AsInteger - 1 do
  begin
    tmpDate := IncMonth(qrHead.FieldByName('BEG_STROJ2').AsDateTime, i);
    if VarIsNull(FastSelectSQLOne('SELECT OBJ_ID FROM contract_pay WHERE OBJ_ID=:0 AND OnDate="' +
      FormatDateTime('yyyy-mm-dd', tmpDate) + '"', VarArrayOf([idObject]))) then
      FastExecSQL('INSERT INTO contract_pay(OBJ_ID, OnDate) VALUES(:0, "' + FormatDateTime('yyyy-mm-dd',
        tmpDate) + '")', VarArrayOf([idObject]));
  end;
  ReloadMain;
end;

procedure TfContractPays.FormDestroy(Sender: TObject);
begin
  fContractPays := nil;
end;

procedure TfContractPays.grMainCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
begin
  AllowEdit := (qrMain.FieldByName('EDITABLE').AsInteger = 1) and (Field.Index > 3) and
    (qrHead.FieldByName('FL_CONTRACT_PRICE_DONE').Value = 0);
end;

procedure TfContractPays.grMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
var
  headerLines: Integer;
begin
  // Процедура наложения стилей отрисовки таблиц по умолчанию
  with (Sender AS TJvDBGrid).Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    if not(qrMain.FieldByName('EDITABLE').Value = 1) or (DataCol <= 1) or
      (qrHead.FieldByName('FL_CONTRACT_PRICE_DONE').Value = 1) then
      Brush.Color := clBtnFace; // сlSilver

    headerLines := 1;
    if not(dgTitles in (Sender AS TJvDBGrid).Options) then
      headerLines := 0;

    // Строка в фокусе
    if (Assigned(TMyDBGrid((Sender AS TJvDBGrid)).DataLink) and
      ((Sender AS TJvDBGrid).Row = TMyDBGrid((Sender AS TJvDBGrid)).DataLink.ActiveRecord + headerLines)) then
    begin
      Brush.Color := PS.BackgroundSelectRow;
      Font.Color := PS.FontSelectRow;
    end;
    // Ячейка в фокусе
    if (gdSelected in State) then
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
      Font.Style := Font.Style + [fsbold];
    end;
    { if (qrMain.FieldByName('EDITABLE').Value = 1) and (DataCol > 1) then
      Brush.Color := MixColors(clMoneyGreen, Brush.Color, 80); }
  end;
  (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfContractPays.grMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      begin
        if (Sender AS TJvDBGrid).EditorMode and ((Sender AS TJvDBGrid).DataSource.DataSet.State in [dsEdit])
        then
          (Sender AS TJvDBGrid).DataSource.DataSet.CheckBrowseMode;
      end;
  end;
end;

procedure TfContractPays.qrHeadBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('OBJ_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('OBJ_ID').Value := idObject;
end;

procedure TfContractPays.qrMainBeforePost(DataSet: TDataSet);
var
  i: Integer;
  tmpDate: TDate;
  FN: string;
  // flNeedRecalc: Boolean;
begin
  // flNeedRecalc := False;
  if qrMain.FieldByName('EDITABLE').AsInteger = 1 then
  begin
    for i := -1 to qrHead.FieldByName('SROK_STROJ').AsInteger - 1 do
    begin
      tmpDate := IncMonth(qrHead.FieldByName('BEG_STROJ2').AsDateTime, i);
      FN := 'M' + IntToStr(MonthOf(tmpDate)) + 'Y' + IntToStr(YearOf(tmpDate));
      if qrMain.FieldByName(FN).Value <> qrMain.FieldByName(FN).OldValue then
        case qrMain.FieldByName('CODE').AsInteger of
          8:
            begin
              FastExecSQL('UPDATE contract_pay SET PRE_PAY_MAT=:0 WHERE OBJ_ID=:1 AND OnDate="' +
                FormatDateTime('yyyy-mm-dd', tmpDate) + '"',
                VarArrayOf([qrMain.FieldByName(FN).Value, idObject]));
            end;
          9:
            begin
              FastExecSQL('UPDATE contract_pay SET PRE_PAY_WORK=:0 WHERE OBJ_ID=:1 AND OnDate="' +
                FormatDateTime('yyyy-mm-dd', tmpDate) + '"',
                VarArrayOf([qrMain.FieldByName(FN).Value, idObject]));
              /// / Возводим флаг - требование пересчитать все остальные месяца
              // flNeedRecalc := True;
            end;
        end;
    end;
    // пересчитать все месяца
    // if flNeedRecalc then
    FastExecSQL('UPDATE contract_pay SET OBJ_ID=:0 WHERE OBJ_ID=:1', VarArrayOf([idObject, idObject]));
    CloseOpen(qrMain);
  end;
end;

procedure TfContractPays.ReloadMain;
var
  i: Integer;
  tmpDate: TDate;
  TOTAL_FIELDS, CALC_SUM_FIELDS, PRE_PAY_MAT_FIELDS, PRE_PAY_WORK_FIELDS, MAT_PODR_IND_FIELDS,
    DEVICE_PODR_IND_FIELDS, CONTRACT_PRICE_FIELDS, EMPTY_FIELDS, FN: string;

  function getMonthField(AFN: string): string;
  begin
    Result := '  FN_ROUND((SELECT SUM(cp.' + AFN +
      ') FROM contract_price AS cp, smetasourcedata AS s, objcards AS o ' +
      'WHERE s.OBJ_ID=:OBJ_ID AND o.OBJ_ID=s.OBJ_ID AND s.SM_ID=cp.SM_ID AND s.ACT=0 AND s.SM_TYPE=(CASE o.CONTRACT_PRICE_TYPE_ID WHEN 1 THEN 3 WHEN 2 THEN 1 WHEN 3 THEN 2 ELSE 0 END) AND cp.OnDate="'
      + FormatDateTime('yyyy-mm-dd', tmpDate) + '")/1000000.0, 0.001, 0) AS ' + FN + ','#13#10;
  end;

  function getMonthField2(AFN: string): string;
  begin
    Result := '  (SELECT SUM(cp.' + AFN + ') FROM contract_pay AS cp WHERE cp.OBJ_ID=:OBJ_ID AND cp.OnDate="'
      + FormatDateTime('yyyy-mm-dd', tmpDate) + '") AS ' + FN + ','#13#10;
  end;

begin
  grMain.Columns.Clear;
  addCol(grMain, 'ROW_NAME', 'Наименование', 350);
  addCol(grMain, 'TOTAL', 'Всего', 80);
  // Создаем колонки по месяцам
  CONTRACT_PRICE_FIELDS := '';
  MAT_PODR_IND_FIELDS := '';
  DEVICE_PODR_IND_FIELDS := '';
  TOTAL_FIELDS := '';
  CALC_SUM_FIELDS := '';
  PRE_PAY_MAT_FIELDS := '';
  PRE_PAY_WORK_FIELDS := '';
  EMPTY_FIELDS := '';
  for i := -1 to qrHead.FieldByName('SROK_STROJ').AsInteger - 1 do
  begin
    tmpDate := IncMonth(qrHead.FieldByName('BEG_STROJ2').AsDateTime, i);
    FN := 'M' + IntToStr(MonthOf(tmpDate)) + 'Y' + IntToStr(YearOf(tmpDate));
    addCol(grMain, FN, AnsiUpperCase(FormatDateTime('mmmm yyyy', tmpDate)), 90);

    CONTRACT_PRICE_FIELDS := CONTRACT_PRICE_FIELDS + getMonthField('CONTRACT_PRICE');
    MAT_PODR_IND_FIELDS := MAT_PODR_IND_FIELDS + getMonthField('MAT_PODR_IND');
    DEVICE_PODR_IND_FIELDS := DEVICE_PODR_IND_FIELDS + getMonthField('DEVICE_PODR_IND');
    TOTAL_FIELDS := TOTAL_FIELDS + getMonthField2('TOTAL');
    CALC_SUM_FIELDS := CALC_SUM_FIELDS + getMonthField2('CALC_SUM');
    PRE_PAY_MAT_FIELDS := PRE_PAY_MAT_FIELDS + getMonthField2('PRE_PAY_MAT');
    PRE_PAY_WORK_FIELDS := PRE_PAY_WORK_FIELDS + getMonthField2('PRE_PAY_WORK');
    EMPTY_FIELDS := EMPTY_FIELDS + 'NULL AS ' + FN + ','#13#10;
  end;
  // Обрезаем лишнюю часть
  CONTRACT_PRICE_FIELDS := Copy(CONTRACT_PRICE_FIELDS, 1, Length(CONTRACT_PRICE_FIELDS) - 3);
  MAT_PODR_IND_FIELDS := Copy(MAT_PODR_IND_FIELDS, 1, Length(MAT_PODR_IND_FIELDS) - 3);
  DEVICE_PODR_IND_FIELDS := Copy(DEVICE_PODR_IND_FIELDS, 1, Length(DEVICE_PODR_IND_FIELDS) - 3);
  TOTAL_FIELDS := Copy(TOTAL_FIELDS, 1, Length(TOTAL_FIELDS) - 3);
  CALC_SUM_FIELDS := Copy(CALC_SUM_FIELDS, 1, Length(CALC_SUM_FIELDS) - 3);
  PRE_PAY_MAT_FIELDS := Copy(PRE_PAY_MAT_FIELDS, 1, Length(PRE_PAY_MAT_FIELDS) - 3);
  PRE_PAY_WORK_FIELDS := Copy(PRE_PAY_WORK_FIELDS, 1, Length(PRE_PAY_WORK_FIELDS) - 3);
  EMPTY_FIELDS := Copy(EMPTY_FIELDS, 1, Length(EMPTY_FIELDS) - 3);

  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#CONTRACT_PRICE_FIELDS#', CONTRACT_PRICE_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#MAT_PODR_IND_FIELDS#', MAT_PODR_IND_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#DEVICE_PODR_IND_FIELDS#', DEVICE_PODR_IND_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#TOTAL_FIELDS#', TOTAL_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#CALC_SUM_FIELDS#', CALC_SUM_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#PRE_PAY_MAT_FIELDS#', PRE_PAY_MAT_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#PRE_PAY_WORK_FIELDS#', PRE_PAY_WORK_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#EMPTY_FIELDS#', EMPTY_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);

  CloseOpen(qrMain);
end;

end.
