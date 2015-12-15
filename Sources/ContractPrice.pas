{ .$. DEFINE DUBUG1 }
unit ContractPrice;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, DataModule, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Buttons, System.DateUtils;

type
  TfContractPrice = class(TSmForm)
    pnlTop: TPanel;
    pnlClient: TPanel;
    grMain: TJvDBGrid;
    dsMain: TDataSource;
    qrMain: TFDQuery;
    grp3: TGroupBox;
    cbbMonthSmeta: TComboBox;
    seYearSmeta: TSpinEdit;
    grp1: TGroupBox;
    cbbMonthBeginStroj: TComboBox;
    seYearBeginStroj: TSpinEdit;
    grp2: TGroupBox;
    seYearEndStroj: TSpinEdit;
    cbbMonthEndStroj: TComboBox;
    grp4: TGroupBox;
    lbl5: TLabel;
    qrOBJ: TFDQuery;
    dsOBJ: TDataSource;
    dbchkFL_CONTRACT_PRICE: TDBCheckBox;
    dbchkFL_CONTRACT_PRICE1: TDBCheckBox;
    qrIndexType: TFDQuery;
    dsIndexType: TDataSource;
    qrIndexTypeDate: TFDQuery;
    dsIndexTypeDate: TDataSource;
    pnl1: TPanel;
    lbl2: TLabel;
    dblkcbbindex_type_id: TDBLookupComboBox;
    lbl3: TLabel;
    dblkcbbindex_type_date_id: TDBLookupComboBox;
    btn1: TBitBtn;
    btnRecalc: TBitBtn;
    dbedtSROK_STROJ: TDBEdit;
    cbbViewType: TComboBox;
    lbl4: TLabel;
    dsCONTRACT_PRICE_TYPE: TDataSource;
    qrCONTRACT_PRICE_TYPE: TFDQuery;
    dblkcbbindex_type_id1: TDBLookupComboBox;
    lbl1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qrOBJBeforeOpen(DataSet: TDataSet);
    procedure qrOBJAfterOpen(DataSet: TDataSet);
    procedure btnRecalcClick(Sender: TObject);
    procedure qrOBJAfterPost(DataSet: TDataSet);
    procedure dblkcbbindex_type_id1CloseUp(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    idObject, idEstimate: Integer;
    // Процедура заполнения основной таблицы
    procedure ReloadMain();
    // Функция возврящает True, если можно редактировать текущую строку
    function canEditRow(): Boolean;
  public
    { Public declarations }
  end;

var
  fContractPrice: TfContractPrice;

implementation

{$R *.dfm}

uses ContractPriceEdit;

procedure TfContractPrice.btn1Click(Sender: TObject);
begin
  // График платежей
end;

procedure TfContractPrice.btnRecalcClick(Sender: TObject);
begin
  // Расчет
  if (not Assigned(fContractPriceEdit)) then
    fContractPriceEdit := TfContractPriceEdit.Create(Self,
      VarArrayOf([idObject, qrMain.FieldByName('SM_ID').Value,
      qrOBJ.FieldByName('CONTRACT_PRICE_TYPE_ID').Value]));
  fContractPriceEdit.ShowModal;
  CloseOpen(qrMain);
end;

function TfContractPrice.canEditRow: Boolean;
begin
  // Функция возврящает True, если можно редактировать текущую строку
  Result := False;
  if not CheckQrActiveEmpty(qrMain) then
    Exit;

  case qrOBJ.FieldByName('CONTRACT_PRICE_TYPE_ID').AsInteger of
    // по ПТМ
    1:
      begin
        Result := qrMain.FieldByName('SM_TYPE').AsInteger = 3;
      end;
    // по сметам
    2:
      begin
        Result := qrMain.FieldByName('SM_TYPE').AsInteger = 1;
      end;
    // по объекту
    3:
      begin
        Result := qrMain.FieldByName('SM_TYPE').AsInteger = 2;
      end;
  end;
end;

procedure TfContractPrice.dblkcbbindex_type_id1CloseUp(Sender: TObject);
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
  qrIndexTypeDate.Active := True;
  qrCONTRACT_PRICE_TYPE.Active := True;
  qrOBJ.Active := True;
end;

procedure TfContractPrice.FormDestroy(Sender: TObject);
begin
  fContractPrice := nil;
end;

procedure TfContractPrice.qrOBJAfterOpen(DataSet: TDataSet);
var
  endDate: TDate;
begin
  endDate := IncMonth(qrOBJ.FieldByName('BEG_STROJ2').AsDateTime, qrOBJ.FieldByName('SROK_STROJ')
    .AsInteger - 1);
  cbbMonthSmeta.ItemIndex := MonthOf(qrOBJ.FieldByName('BEG_STROJ').AsDateTime) - 1;
  seYearSmeta.Value := YearOf(qrOBJ.FieldByName('BEG_STROJ').AsDateTime);

  cbbMonthBeginStroj.ItemIndex := MonthOf(qrOBJ.FieldByName('BEG_STROJ2').AsDateTime) - 1;
  seYearBeginStroj.Value := YearOf(qrOBJ.FieldByName('BEG_STROJ2').AsDateTime);

  cbbMonthEndStroj.ItemIndex := MonthOf(endDate) - 1;
  seYearEndStroj.Value := YearOf(endDate);

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
end;

procedure TfContractPrice.ReloadMain;
var
  i: Integer;
  tmpDate: TDate;
  MONTH_FIELDS, FN: string;
begin
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
      '  (SELECT IFNULL(cp.CONTRACT_PRICE, 0) FROM contract_price AS cp WHERE cp.SM_ID=s.SM_ID AND cp.Ondate="'
      + FormatDateTime('yyyy-mm-dd', tmpDate) + '") AS ' + FN + ','#13#10;
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
