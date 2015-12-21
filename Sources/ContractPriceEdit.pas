unit ContractPriceEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, DataModule, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, JvExDBGrids,
  JvDBGrid, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.DateUtils, Main, Vcl.Buttons, System.UITypes,
  JvComponentBase, JvFormPlacement;

type
  TfContractPriceEdit = class(TSmForm)
    pnlTopEstimate: TPanel;
    pnlTopSourceData: TPanel;
    pnlClient: TPanel;
    pnlBottom: TPanel;
    lblEstimate: TLabel;
    dbedtFN_getSMName: TDBEdit;
    grMain: TJvDBGrid;
    qrHead: TFDQuery;
    dsHead: TDataSource;
    GridPanel1: TGridPanel;
    lbl4: TLabel;
    dbedtFULL_NAME: TDBEdit;
    lbl5: TLabel;
    dbedtFULL_NAME1: TDBEdit;
    lbl6: TLabel;
    dbedtFULL_NAME2: TDBEdit;
    lbl7: TLabel;
    dbedtFULL_NAME3: TDBEdit;
    lbl8: TLabel;
    dbedtFULL_NAME4: TDBEdit;
    lbl9: TLabel;
    dbedtFULL_NAME5: TDBEdit;
    lbl10: TLabel;
    dbedtFULL_NAME6: TDBEdit;
    GridPanel2: TGridPanel;
    lbl1: TLabel;
    dbtxtBEG_STROJ: TDBText;
    lbl2: TLabel;
    dbtxtBEG_STROJ2: TDBText;
    lbl3: TLabel;
    dbtxtSROK_STROJ: TDBText;
    qrMain: TFDQuery;
    dsMain: TDataSource;
    lbl11: TLabel;
    dbtxtINDEX_NAME: TDBText;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    dbedtSUM_START: TDBEdit;
    dbedtSUM_START1: TDBEdit;
    dbedtSUM_START2: TDBEdit;
    dbedtSUM_START3: TDBEdit;
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
    procedure qrMainAfterPost(DataSet: TDataSet);
  private
    idObject, idEstimate: Integer;
    procedure ReloadMain;
  public
    { Public declarations }
  end;

var
  fContractPriceEdit: TfContractPriceEdit;

implementation

{$R *.dfm}

procedure TfContractPriceEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfContractPriceEdit.FormCreate(Sender: TObject);
var
  i: Integer;
  tmpDate: TDate;
begin
  idObject := InitParams[0];
  idEstimate := InitParams[1];

  qrHead.Active := True;
  // Создаем месяца расчета, если не созданы
  for i := 0 to qrHead.FieldByName('SROK_STROJ').AsInteger - 1 do
  begin
    tmpDate := IncMonth(qrHead.FieldByName('BEG_STROJ2').AsDateTime, i);
    if VarIsNull(FastSelectSQLOne('SELECT SM_ID FROM contract_price WHERE SM_ID=:0 AND OnDate="' +
      FormatDateTime('yyyy-mm-dd', tmpDate) + '"', VarArrayOf([idEstimate]))) then
      FastExecSQL('INSERT INTO contract_price(SM_ID, OnDate) VALUES(:0, "' + FormatDateTime('yyyy-mm-dd',
        tmpDate) + '")', VarArrayOf([idEstimate]));
  end;
  ReloadMain;
end;

procedure TfContractPriceEdit.FormDestroy(Sender: TObject);
begin
  fContractPriceEdit := nil;
end;

procedure TfContractPriceEdit.grMainCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
begin
  AllowEdit := (qrMain.FieldByName('EDITABLE').AsInteger = 1) and (Field.Index > 3);
end;

procedure TfContractPriceEdit.grMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
var
  headerLines: Integer;
begin
  // Процедура наложения стилей отрисовки таблиц по умолчанию
  with (Sender AS TJvDBGrid).Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    if not(qrMain.FieldByName('EDITABLE').Value = 1) or (DataCol <= 1) then
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

procedure TfContractPriceEdit.grMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfContractPriceEdit.qrHeadBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('SM_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('SM_ID').Value := idEstimate;

  if (DataSet as TFDQuery).FindParam('OBJ_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('OBJ_ID').Value := idObject;
end;

procedure TfContractPriceEdit.qrMainAfterPost(DataSet: TDataSet);
begin
  CloseOpen(qrHead);
end;

procedure TfContractPriceEdit.qrMainBeforePost(DataSet: TDataSet);
var
  i: Integer;
  tmpDate: TDate;
  FN: string;
  flSumNoIndexChange: Boolean;
begin
  flSumNoIndexChange := False;
  if qrMain.FieldByName('EDITABLE').AsInteger = 1 then
  begin
    for i := 0 to qrHead.FieldByName('SROK_STROJ').AsInteger - 1 do
    begin
      tmpDate := IncMonth(qrHead.FieldByName('BEG_STROJ2').AsDateTime, i);
      FN := 'M' + IntToStr(MonthOf(tmpDate)) + 'Y' + IntToStr(YearOf(tmpDate));
      if qrMain.FieldByName(FN).Value <> qrMain.FieldByName(FN).OldValue then
        case qrMain.FieldByName('CODE').AsInteger of
          1:
            begin
              if (qrMain.FieldByName(FN).Value > 100) or (qrMain.FieldByName(FN).Value < 0) then
              begin
                Application.MessageBox('Значение должно быть от 0 до 100!', 'Настройка расчета',
                  MB_OK + MB_ICONSTOP + MB_TOPMOST);
                grMain.SelectedField := qrMain.FieldByName(FN);
                Abort;
              end;

              FastExecSQL('UPDATE contract_price SET PER_NORM_STROJ=:0 WHERE SM_ID=:1 AND OnDate="' +
                FormatDateTime('yyyy-mm-dd', tmpDate) + '"',
                VarArrayOf([qrMain.FieldByName(FN).Value, idEstimate]));
            end;
          2:
            begin
              if (qrMain.FieldByName(FN).Value > 100) or (qrMain.FieldByName(FN).Value < 0) then
              begin
                Application.MessageBox('Значение должно быть от 0 до 100!', 'Настройка расчета',
                  MB_OK + MB_ICONSTOP + MB_TOPMOST);
                grMain.SelectedField := qrMain.FieldByName(FN);
                Abort;
              end;

              FastExecSQL('UPDATE contract_price SET PER_NORM_DEVICE=:0 WHERE SM_ID=:1 AND OnDate="' +
                FormatDateTime('yyyy-mm-dd', tmpDate) + '"',
                VarArrayOf([qrMain.FieldByName(FN).Value, idEstimate]));
            end;
          10:
            begin
              FastExecSQL('UPDATE contract_price SET SUM_NO_INDEX=:0 WHERE SM_ID=:1 AND OnDate="' +
                FormatDateTime('yyyy-mm-dd', tmpDate) + '"',
                VarArrayOf([qrMain.FieldByName(FN).Value, idEstimate]));
              // Возводим флаг - требование пересчитать все остальные месяца
              flSumNoIndexChange := True;
            end;
        end;
    end;
    // пересчитать все месяца
    if flSumNoIndexChange then
      FastExecSQL('UPDATE contract_price SET SM_ID=:0 WHERE SM_ID=:1', VarArrayOf([idEstimate, idEstimate]));
    CloseOpen(qrMain);
  end;
end;

procedure TfContractPriceEdit.ReloadMain;
var
  i: Integer;
  tmpDate: TDate;
  PER_NORM_STROJ_FIELDS, INDEX_FIELDS, PER_NORM_DEVICE_FIELDS, PRICE_NO_DEVICE_FIELDS, MAT_PODR_FIELDS,
    DEVICE_PODR_FIELDS, PRICE_NO_DEVICE_IND_FIELDS, MAT_PODR_IND_FIELDS, DEVICE_PODR_IND_FIELDS,
    SUM_NO_INDEX_FIELDS, CONTRACT_PRICE_FIELDS, FN: string;

  function getMonthField(AFN: string): string;
  begin
    Result := '  (SELECT ' + AFN + ' FROM contract_price WHERE SM_ID=:SM_ID AND OnDate="' +
      FormatDateTime('yyyy-mm-dd', tmpDate) + '") AS ' + FN + ','#13#10;
  end;

begin
  grMain.Columns.Clear;
  addCol(grMain, 'ROW_NAME', 'Наименование', 350);
  addCol(grMain, 'TOTAL', 'Стоимость', 80);
  // Создаем колонки по месяцам
  PER_NORM_STROJ_FIELDS := '';
  PER_NORM_DEVICE_FIELDS := '';
  MAT_PODR_FIELDS := '';
  DEVICE_PODR_FIELDS := '';
  PRICE_NO_DEVICE_IND_FIELDS := '';
  MAT_PODR_IND_FIELDS := '';
  DEVICE_PODR_IND_FIELDS := '';
  SUM_NO_INDEX_FIELDS := '';
  CONTRACT_PRICE_FIELDS := '';
  INDEX_FIELDS := '';
  for i := 0 to qrHead.FieldByName('SROK_STROJ').AsInteger - 1 do
  begin
    tmpDate := IncMonth(qrHead.FieldByName('BEG_STROJ2').AsDateTime, i);
    FN := 'M' + IntToStr(MonthOf(tmpDate)) + 'Y' + IntToStr(YearOf(tmpDate));
    addCol(grMain, FN, AnsiUpperCase(FormatDateTime('mmmm yyyy', tmpDate)), 90);

    PER_NORM_STROJ_FIELDS := PER_NORM_STROJ_FIELDS + getMonthField('PER_NORM_STROJ');
    PER_NORM_DEVICE_FIELDS := PER_NORM_DEVICE_FIELDS + getMonthField('PER_NORM_DEVICE');
    PRICE_NO_DEVICE_FIELDS := PRICE_NO_DEVICE_FIELDS + getMonthField('PRICE_NO_DEVICE');
    MAT_PODR_FIELDS := MAT_PODR_FIELDS + getMonthField('MAT_PODR');
    DEVICE_PODR_FIELDS := DEVICE_PODR_FIELDS + getMonthField('DEVICE_PODR');
    PRICE_NO_DEVICE_IND_FIELDS := PRICE_NO_DEVICE_IND_FIELDS + getMonthField('PRICE_NO_DEVICE_IND');
    MAT_PODR_IND_FIELDS := MAT_PODR_IND_FIELDS + getMonthField('MAT_PODR_IND');
    DEVICE_PODR_IND_FIELDS := DEVICE_PODR_IND_FIELDS + getMonthField('DEVICE_PODR_IND');
    SUM_NO_INDEX_FIELDS := SUM_NO_INDEX_FIELDS + getMonthField('SUM_NO_INDEX');
    CONTRACT_PRICE_FIELDS := CONTRACT_PRICE_FIELDS + getMonthField('CONTRACT_PRICE');
    INDEX_FIELDS := INDEX_FIELDS + getMonthField('IND');
  end;
  // Обрезаем лишнюю часть
  PER_NORM_STROJ_FIELDS := Copy(PER_NORM_STROJ_FIELDS, 1, Length(PER_NORM_STROJ_FIELDS) - 3);
  PER_NORM_DEVICE_FIELDS := Copy(PER_NORM_DEVICE_FIELDS, 1, Length(PER_NORM_DEVICE_FIELDS) - 3);
  PRICE_NO_DEVICE_FIELDS := Copy(PRICE_NO_DEVICE_FIELDS, 1, Length(PRICE_NO_DEVICE_FIELDS) - 3);
  INDEX_FIELDS := Copy(INDEX_FIELDS, 1, Length(INDEX_FIELDS) - 3);
  MAT_PODR_FIELDS := Copy(MAT_PODR_FIELDS, 1, Length(MAT_PODR_FIELDS) - 3);
  DEVICE_PODR_FIELDS := Copy(DEVICE_PODR_FIELDS, 1, Length(DEVICE_PODR_FIELDS) - 3);
  PRICE_NO_DEVICE_IND_FIELDS := Copy(PRICE_NO_DEVICE_IND_FIELDS, 1, Length(PRICE_NO_DEVICE_IND_FIELDS) - 3);
  MAT_PODR_IND_FIELDS := Copy(MAT_PODR_IND_FIELDS, 1, Length(MAT_PODR_IND_FIELDS) - 3);
  DEVICE_PODR_IND_FIELDS := Copy(DEVICE_PODR_IND_FIELDS, 1, Length(DEVICE_PODR_IND_FIELDS) - 3);
  SUM_NO_INDEX_FIELDS := Copy(SUM_NO_INDEX_FIELDS, 1, Length(SUM_NO_INDEX_FIELDS) - 3);
  CONTRACT_PRICE_FIELDS := Copy(CONTRACT_PRICE_FIELDS, 1, Length(CONTRACT_PRICE_FIELDS) - 3);

  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#PER_NORM_STROJ_FIELDS#', PER_NORM_STROJ_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#PER_NORM_DEVICE_FIELDS#', PER_NORM_DEVICE_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#PRICE_NO_DEVICE_FIELDS#', PRICE_NO_DEVICE_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#INDEX_FIELDS#', INDEX_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#MAT_PODR_FIELDS#', MAT_PODR_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#DEVICE_PODR_FIELDS#', DEVICE_PODR_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#PRICE_NO_DEVICE_IND_FIELDS#',
    PRICE_NO_DEVICE_IND_FIELDS, [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#MAT_PODR_IND_FIELDS#', MAT_PODR_IND_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#DEVICE_PODR_IND_FIELDS#', DEVICE_PODR_IND_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#SUM_NO_INDEX_FIELDS#', SUM_NO_INDEX_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#CONTRACT_PRICE_FIELDS#', CONTRACT_PRICE_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);

  CloseOpen(qrMain);
end;

end.
