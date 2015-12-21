{ .$. DEFINE DUBUG1 }
unit ContractPrice;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, DataModule, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Buttons, System.DateUtils, Main, Vcl.ComCtrls, System.UITypes, Vcl.Menus;

type
  TfContractPrice = class(TSmForm)
    pnlTop: TPanel;
    pnlClient: TPanel;
    grMain: TJvDBGrid;
    dsMain: TDataSource;
    qrMain: TFDQuery;
    grpSmetaStart: TGroupBox;
    cbbMonthSmeta: TComboBox;
    seYearSmeta: TSpinEdit;
    grpBuildStart: TGroupBox;
    cbbMonthBeginStroj: TComboBox;
    seYearBeginStroj: TSpinEdit;
    grpSrok: TGroupBox;
    lblMonth: TLabel;
    qrOBJ: TFDQuery;
    dsOBJ: TDataSource;
    dbchkFL_CONTRACT_PRICE: TDBCheckBox;
    dbchkFL_CONTRACT_PRICE1: TDBCheckBox;
    qrIndexType: TFDQuery;
    dsIndexType: TDataSource;
    pnlIndex: TPanel;
    lblTypeIndex: TLabel;
    dblkcbbindex_type_id: TDBLookupComboBox;
    btnContractPays: TBitBtn;
    btnCalc: TBitBtn;
    dbedtSROK_STROJ: TDBEdit;
    cbbViewType: TComboBox;
    lblViewType: TLabel;
    dsCONTRACT_PRICE_TYPE: TDataSource;
    qrCONTRACT_PRICE_TYPE: TFDQuery;
    dblkcbbindex_type_id1: TDBLookupComboBox;
    lblCalcType: TLabel;
    pm: TPopupMenu;
    mRecalcAll: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qrOBJBeforeOpen(DataSet: TDataSet);
    procedure qrOBJAfterOpen(DataSet: TDataSet);
    procedure btnCalcClick(Sender: TObject);
    procedure qrOBJAfterPost(DataSet: TDataSet);
    procedure dblkcbbindex_type_id1CloseUp(Sender: TObject);
    procedure btnContractPaysClick(Sender: TObject);
    procedure qrMainAfterScroll(DataSet: TDataSet);
    procedure grMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grMainCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
    procedure dbchkFL_CONTRACT_PRICE1Click(Sender: TObject);
    procedure dblkcbbindex_type_idCloseUp(Sender: TObject);
    procedure cbbViewTypeCloseUp(Sender: TObject);
    procedure mRecalcAllClick(Sender: TObject);
    procedure qrMainBeforePost(DataSet: TDataSet);
    procedure pmPopup(Sender: TObject);

  private
    idObject, idEstimate: Integer;
    // Процедура заполнения основной таблицы
    procedure ReloadMain();
    // Функция возврящает True, если можно редактировать текущую строку
    function canEditRow(): Boolean;
    function CanEditField(Field: TField): Boolean;
  public
    { Public declarations }
  end;

var
  fContractPrice: TfContractPrice;

implementation

{$R *.dfm}

uses ContractPriceEdit, ContractPays;

procedure TfContractPrice.btnContractPaysClick(Sender: TObject);
begin
  // График платежей
  qrOBJ.CheckBrowseMode;
  if (not Assigned(fContractPays)) then
    fContractPays := TfContractPays.Create(Self, VarArrayOf([idObject]));
  fContractPays.ShowModal;
end;

procedure TfContractPrice.btnCalcClick(Sender: TObject);
begin
  // Расчет
  if not btnCalc.Enabled then
    Exit;
  qrOBJ.CheckBrowseMode;
  if (not Assigned(fContractPriceEdit)) then
    fContractPriceEdit := TfContractPriceEdit.Create(Self,
      VarArrayOf([idObject, qrMain.FieldByName('SM_ID').Value]));
  fContractPriceEdit.ShowModal;
  CloseOpen(qrMain);
end;

function TfContractPrice.canEditRow: Boolean;
begin
  // Функция возврящает True, если можно редактировать текущую строку
  Result := False;
  if not CheckQrActiveEmpty(qrMain) then
    Exit;

  // Если КЦ сформирована, то тоже нельзя ничего редактировать
  if dbchkFL_CONTRACT_PRICE.Checked then
    Exit;

  case qrOBJ.FieldByName('CONTRACT_PRICE_TYPE_ID').AsInteger of
    // по ПТМ
    1:
      Result := qrMain.FieldByName('SM_TYPE').AsInteger = 3;
    // по сметам
    2:
      Result := qrMain.FieldByName('SM_TYPE').AsInteger = 1;
    // по объекту
    3:
      Result := qrMain.FieldByName('SM_TYPE').AsInteger = 2;
  end;
end;

procedure TfContractPrice.cbbViewTypeCloseUp(Sender: TObject);
begin
  // Меняем вид просмотра
  CloseOpen(qrMain);
end;

procedure TfContractPrice.dbchkFL_CONTRACT_PRICE1Click(Sender: TObject);
begin
  grMain.Repaint;
  qrMainAfterScroll(qrMain);
end;

procedure TfContractPrice.dblkcbbindex_type_id1CloseUp(Sender: TObject);
begin
  qrOBJ.CheckBrowseMode;
end;

procedure TfContractPrice.dblkcbbindex_type_idCloseUp(Sender: TObject);
begin
  qrOBJ.CheckBrowseMode;
end;

procedure TfContractPrice.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qrOBJ.CheckBrowseMode;
  Action := caFree;
end;

procedure TfContractPrice.FormCreate(Sender: TObject);
begin
  idObject := InitParams[0];
  idEstimate := InitParams[1];

  qrIndexType.Active := True;
  qrCONTRACT_PRICE_TYPE.Active := True;
  qrOBJ.Active := True;
end;

procedure TfContractPrice.FormDestroy(Sender: TObject);
begin
  fContractPrice := nil;
end;

function TfContractPrice.CanEditField(Field: TField): Boolean;
begin
  Result := False;

  if not CheckQrActiveEmpty(qrMain) or not canEditRow or (Field = grMain.Columns[0].Field) or
    (Field = grMain.Columns[1].Field) or (Field = grMain.Columns[2].Field) or not dbchkFL_CONTRACT_PRICE1.Checked
  then
    Exit;

  Result := True;
end;

procedure TfContractPrice.grMainCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
begin
  AllowEdit := CanEditField(Field);
end;

procedure TfContractPrice.grMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
var
  headerLines: Integer;
begin
  // Процедура наложения стилей отрисовки таблиц по умолчанию
  with (Sender AS TJvDBGrid).Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    if not(CanEditField(Column.Field)) then
      Brush.Color := clBtnFace;

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
  end;
  (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfContractPrice.mRecalcAllClick(Sender: TObject);
begin
  qrMain.CheckBrowseMode;
  FastExecSQL('UPDATE `contract_price` SET SM_ID=SM_ID WHERE SM_ID IN (SELECT SM_ID'#13 +
    'FROM `smetasourcedata` WHERE OBJ_ID=:0)', VarArrayOf([idObject]));
  FastExecSQL('UPDATE `contract_pay` SET OBJ_ID=OBJ_ID WHERE OBJ_ID=:0', VarArrayOf([idObject]));
  CloseOpen(qrMain);
end;

procedure TfContractPrice.pmPopup(Sender: TObject);
begin
  mRecalcAll.Visible := not dbchkFL_CONTRACT_PRICE1.Checked and not dbchkFL_CONTRACT_PRICE.Checked;
end;

procedure TfContractPrice.qrMainAfterScroll(DataSet: TDataSet);
begin
  btnCalc.Enabled := canEditRow and not dbchkFL_CONTRACT_PRICE1.Checked;
end;

procedure TfContractPrice.qrMainBeforePost(DataSet: TDataSet);
var
  i: Integer;
  tmpDate: TDate;
  FN: string;
begin
  for i := 0 to qrOBJ.FieldByName('SROK_STROJ').AsInteger - 1 do
  begin
    tmpDate := IncMonth(qrOBJ.FieldByName('BEG_STROJ2').AsDateTime, i);
    FN := 'M' + IntToStr(MonthOf(tmpDate)) + 'Y' + IntToStr(YearOf(tmpDate));
    if qrMain.FieldByName(FN).Value <> qrMain.FieldByName(FN).OldValue then
      case cbbViewType.ItemIndex of
        0:
          FastExecSQL('UPDATE contract_price SET contract_price=:0 WHERE SM_ID=:1 AND OnDate="' +
            FormatDateTime('yyyy-mm-dd', tmpDate) + '"',
            VarArrayOf([qrMain.FieldByName(FN).Value, qrMain.FieldByName('SM_ID').Value]));
        1:
          FastExecSQL
            ('UPDATE contract_price SET PER_NORM_STROJ=:0, PER_NORM_DEVICE=PER_NORM_STROJ WHERE SM_ID=:1 AND OnDate="'
            + FormatDateTime('yyyy-mm-dd', tmpDate) + '"',
            VarArrayOf([qrMain.FieldByName(FN).Value, qrMain.FieldByName('SM_ID').Value]));
      end;
  end;
  CloseOpen(qrMain);
end;

procedure TfContractPrice.qrOBJAfterOpen(DataSet: TDataSet);
{ var
  endDate: TDate; }
begin
  { endDate := IncMonth(qrOBJ.FieldByName('BEG_STROJ2').AsDateTime, qrOBJ.FieldByName('SROK_STROJ')
    .AsInteger - 1); }
  cbbMonthSmeta.ItemIndex := MonthOf(qrOBJ.FieldByName('BEG_STROJ').AsDateTime) - 1;
  seYearSmeta.Value := YearOf(qrOBJ.FieldByName('BEG_STROJ').AsDateTime);

  cbbMonthBeginStroj.ItemIndex := MonthOf(qrOBJ.FieldByName('BEG_STROJ2').AsDateTime) - 1;
  seYearBeginStroj.Value := YearOf(qrOBJ.FieldByName('BEG_STROJ2').AsDateTime);
  {
    cbbMonthEndStroj.ItemIndex := MonthOf(endDate) - 1;
    seYearEndStroj.Value := YearOf(endDate);
  }
  ReloadMain;
end;

procedure TfContractPrice.qrOBJAfterPost(DataSet: TDataSet);
begin
  ReloadMain;
end;

procedure TfContractPrice.qrOBJBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('OBJ_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('OBJ_ID').Value := idObject;

  if (DataSet as TFDQuery).FindParam('VIEW_TYPE') <> nil then
    (DataSet as TFDQuery).ParamByName('VIEW_TYPE').Value := cbbViewType.ItemIndex;
end;

procedure TfContractPrice.ReloadMain;
var
  i: Integer;
  tmpDate: TDate;
  MONTH_FIELDS, FN: string;
  Key: Variant;
begin
  Key := Null;
  if qrMain.Active then
  begin
    Key := qrMain.FieldByName('SM_ID').Value;
    CloseOpen(qrMain);
    Exit;
  end;
  grMain.Columns.Clear;
  addCol(grMain, 'SM_NUMBER', ' ', 40);
  addCol(grMain, 'NAME', 'Наименование', 250);
  addCol(grMain, 'TOTAL', 'Всего', 80);
  // Создаем колонки по месяцам
  MONTH_FIELDS := '';
  for i := 0 to qrOBJ.FieldByName('SROK_STROJ').AsInteger - 1 do
  begin
    tmpDate := IncMonth(qrOBJ.FieldByName('BEG_STROJ2').AsDateTime, i);
    FN := 'M' + IntToStr(MonthOf(tmpDate)) + 'Y' + IntToStr(YearOf(tmpDate));
    addCol(grMain, FN, AnsiUpperCase(FormatDateTime('mmmm yyyy', tmpDate)), 90);
    MONTH_FIELDS := MONTH_FIELDS +
      '  (SELECT SUM(IF(:VIEW_TYPE=0, IFNULL(cp.CONTRACT_PRICE, 0), IFNULL(cp.PER_NORM_STROJ, 0)))/IF(:VIEW_TYPE=0, 1, COUNT(*)) FROM contract_price AS cp WHERE cp.SM_ID IN'#13
      + '(SELECT SM_ID FROM smetasourcedata WHERE DELETED=0 AND CASE o.CONTRACT_PRICE_TYPE_ID'#13 +
      'WHEN 1 THEN SM_TYPE=3 WHEN 2 THEN SM_TYPE=1 WHEN 3 THEN SM_TYPE=2 END AND'#13 +
      '((smetasourcedata.SM_ID = s.SM_ID) OR (smetasourcedata.PARENT_ID = s.SM_ID) OR '#13 +
      ' (smetasourcedata.PARENT_ID IN (SELECT SM_ID FROM smetasourcedata '#13 +
      '    WHERE PARENT_ID = s.SM_ID AND DELETED=0)))) AND cp.Ondate="' +
      FormatDateTime('yyyy-mm-dd', tmpDate) + '") AS ' + FN + ','#13#10;
  end;
  // Обрезаем лишнюю часть
  MONTH_FIELDS := Copy(MONTH_FIELDS, 1, Length(MONTH_FIELDS) - 3);
  qrMain.SQL.Text := StringReplace(qrMain.SQL.Text, '#MONTH_FIELDS#', MONTH_FIELDS,
    [rfReplaceAll, rfIgnoreCase]);
{$IFDEF DEBUG}
  // ShowMessage(qrMain.SQL.Text);
{$ENDIF}
  CloseOpen(qrMain);
end;

end.
