unit SmReportListSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataModule, Tools, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  SmReportParamSelect, Main, JvComponentBase, JvFormPlacement;

type
  TfSmReportListSQL = class(TSmForm)
    qrMain: TFDQuery;
    dsMain: TDataSource;
    grMain: TJvDBGrid;
    pnlBot: TPanel;
    dbnvgr1: TDBNavigator;
    btnClose: TBitBtn;
    dbmmoREPORT_LIST_SQL_DESCR: TDBMemo;
    dbmmoREPORT_LIST_SQL_SRC: TDBMemo;
    lbl1: TLabel;
    dbedtREPORT_LIST_SQL_NAME: TDBEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    btn1: TBitBtn;
    FormStorage: TJvFormStorage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qrMainNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSmReportListSQL: TfSmReportListSQL;

implementation

{$R *.dfm}

procedure TfSmReportListSQL.btn1Click(Sender: TObject);
var
  res: Variant;
begin
  qrMain.CheckBrowseMode;
  res := TfSmReportParamSelect.Select(qrMain.FieldByName('REPORT_LIST_SQL_ID').Value, Null);
  if not VarIsNull(res) then
  begin
    ShowMessage('Выбрано значение из справочника:'#13 + VarToStr(res[0]) + ' : "' + VarToStr(res[1]) + '"');
  end;
end;

procedure TfSmReportListSQL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qrMain.CheckBrowseMode;
  Action := caFree;
end;

procedure TfSmReportListSQL.FormCreate(Sender: TObject);
begin
  qrMain.Active := True;
end;

procedure TfSmReportListSQL.FormDestroy(Sender: TObject);
begin
  fSmReportListSQL := nil;
end;

procedure TfSmReportListSQL.qrMainNewRecord(DataSet: TDataSet);
begin
  dbedtREPORT_LIST_SQL_NAME.SetFocus;
end;

end.
