unit fCopyEstimRow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, JvExComCtrls, JvDBTreeView,
  Tools;

type
  TFormCopyEstimRow = class(TSmForm)
    pnlLeft: TPanel;
    pnlRigth: TPanel;
    gbObjects: TGroupBox;
    gbTreeData: TGroupBox;
    gbRate: TGroupBox;
    qrObjects: TFDQuery;
    dsObjects: TDataSource;
    dbgrdObjects: TJvDBGrid;
    qrTreeData: TFDQuery;
    dsTreeData: TDataSource;
    tvEstimates: TJvDBTreeView;
    qrRatesEx: TFDQuery;
    strngfldRatesExSORT_ID: TStringField;
    qrRatesExITERATOR: TIntegerField;
    qrRatesExOBJ_CODE: TStringField;
    qrRatesExOBJ_NAME: TStringField;
    qrRatesExOBJ_UNIT: TStringField;
    qrRatesExID_TYPE_DATA: TIntegerField;
    qrRatesExDATA_ESTIMATE_OR_ACT_ID: TIntegerField;
    qrRatesExID_TABLES: TIntegerField;
    qrRatesExSM_ID: TIntegerField;
    qrRatesExWORK_ID: TIntegerField;
    qrRatesExZNORMATIVS_ID: TIntegerField;
    qrRatesExAPPLY_WINTERPRISE_FLAG: TShortintField;
    qrRatesExID_RATE: TIntegerField;
    qrRatesExOBJ_COUNT: TFloatField;
    qrRatesExADDED_COUNT: TIntegerField;
    qrRatesExREPLACED_COUNT: TIntegerField;
    qrRatesExINCITERATOR: TIntegerField;
    strngfldRatesExSORT_ID2: TStringField;
    qrRatesExNUM_ROW: TIntegerField;
    qrRatesExID_REPLACED: TIntegerField;
    qrRatesExCONS_REPLASED: TIntegerField;
    qrRatesExCOEF_ORDERS: TIntegerField;
    qrRatesExNOM_ROW_MANUAL: TIntegerField;
    qrRatesExMarkRow: TShortintField;
    dsRatesEx: TDataSource;
    grRatesEx: TJvDBGrid;
    SplitterCenter: TSplitter;
    Splitter1: TSplitter;
    procedure qrObjectsAfterOpen(DataSet: TDataSet);
    procedure qrObjectsAfterScroll(DataSet: TDataSet);
    procedure qrObjectsBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses GlobsAndConst;

{$R *.dfm}

procedure TFormCopyEstimRow.FormShow(Sender: TObject);
begin
  CloseOpen(qrObjects);
  ShowMessage(IntToStr(qrObjects.RecordCount));
end;

procedure TFormCopyEstimRow.qrObjectsAfterOpen(DataSet: TDataSet);
begin
  CloseOpen(qrTreeData);
end;

procedure TFormCopyEstimRow.qrObjectsAfterScroll(DataSet: TDataSet);
begin
  CloseOpen(qrTreeData, False);
end;

procedure TFormCopyEstimRow.qrObjectsBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('USER_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('USER_ID').Value := G_USER_ID;
end;

end.
