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
    lbl1: TLabel;
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
    dbedtFULL_NAME: TDBEdit;
    dbchkFL_CONTRACT_PRICE: TDBCheckBox;
    dbchkFL_CONTRACT_PRICE1: TDBCheckBox;
    qrIndexType: TFDQuery;
    dsIndexType: TDataSource;
    qrIndexTypeDate: TFDQuery;
    dsIndexTypeDate: TDataSource;
    dbrgrpCONTRACT_PRICE_TYPE: TDBRadioGroup;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qrOBJBeforeOpen(DataSet: TDataSet);
    procedure qrOBJAfterOpen(DataSet: TDataSet);
    procedure btnRecalcClick(Sender: TObject);
    procedure qrOBJAfterPost(DataSet: TDataSet);
    procedure dbrgrpCONTRACT_PRICE_TYPEClick(Sender: TObject);
  private
    idObject, idEstimate: Integer;
  public
    { Public declarations }
  end;

var
  fContractPrice: TfContractPrice;

implementation

{$R *.dfm}

procedure TfContractPrice.btnRecalcClick(Sender: TObject);
begin
  // Перерасчет
end;

procedure TfContractPrice.dbrgrpCONTRACT_PRICE_TYPEClick(Sender: TObject);
begin
  qrOBJ.Edit;
  qrOBJ.FieldByName('CONTRACT_PRICE_TYPE').Value := dbrgrpCONTRACT_PRICE_TYPE.ItemIndex + 1;
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

  CloseOpen(qrMain);
end;

procedure TfContractPrice.qrOBJAfterPost(DataSet: TDataSet);
begin
  CloseOpen(qrMain);
end;

procedure TfContractPrice.qrOBJBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('OBJ_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('OBJ_ID').Value := idObject;
end;

end.
