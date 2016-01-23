unit SmReportParamsEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataModule, Tools, Main, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TfSmReportParamsEdit = class(TSmForm)
    pnl1: TPanel;
    grReportParam: TJvDBGrid;
    qrReportParam: TFDQuery;
    dsReportParam: TDataSource;
    dbnvgr1: TDBNavigator;
    btnClose: TBitBtn;
    qrReportParamREPORT_PARAM_ID: TFDAutoIncField;
    qrReportParamREPORT_ID: TIntegerField;
    qrReportParamREPORT_PARAM_TYPE_ID: TIntegerField;
    qrReportParamREPORT_PARAM_NAME: TStringField;
    qrReportParamREPORT_PARAM_LABEL: TStringField;
    qrReportParamREPORT_LIST_SQL_ID: TIntegerField;
    qrReportParamPOS: TIntegerField;
    qrReportParamFL_ALLOW_ALL: TBooleanField;
    qrReportParamFL_REQUIRED: TBooleanField;
    qrReportParamType: TFDQuery;
    qrReportParamLookType: TStringField;
    qrReportListSql: TFDQuery;
    qrReportParamLookList: TStringField;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure qrReportParamBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure qrReportParamNewRecord(DataSet: TDataSet);
  private

  public
    { Public declarations }
  end;

var
  fSmReportParamsEdit: TfSmReportParamsEdit;

implementation

{$R *.dfm}

procedure TfSmReportParamsEdit.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfSmReportParamsEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qrReportParam.CheckBrowseMode;
  Action := caFree;
end;

procedure TfSmReportParamsEdit.FormCreate(Sender: TObject);
begin
  qrReportParamType.Active := True;
  qrReportListSql.Active := True;
  qrReportParam.Active := True;
end;

procedure TfSmReportParamsEdit.FormDestroy(Sender: TObject);
begin
  fSmReportParamsEdit := nil;
end;

procedure TfSmReportParamsEdit.qrReportParamBeforeOpen(DataSet: TDataSet);
begin
  qrReportParam.ParamByName('REPORT_ID').Value := InitParams;
end;

procedure TfSmReportParamsEdit.qrReportParamNewRecord(DataSet: TDataSet);
begin
  qrReportParam.FieldByName('REPORT_ID').Value := InitParams;
end;

end.
