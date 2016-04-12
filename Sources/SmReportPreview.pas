unit SmReportPreview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, Main, DataModule, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, SmReportParams, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfSmReportPreview = class(TSmForm)
    dsMain: TDataSource;
    qrMain: TFDQuery;
    grMain: TJvDBGrid;
    pnlBott: TPanel;
    btnClose: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    REPORT_ID: Variant;
  public
  end;

///	<summary>
///	  Процедура генерации вьюшки отчета
///	</summary>
///	<param name="AREPORT_ID">
///	  ID отчета
///	</param>
///	<param name="AReportParams">
///	  Форма выбора параметров отчета
///	</param>
///	<param name="AOwner">
///	  Контрол для автоматического размешения вьюшки на нем
///	</param>
///	<param name="AMDIMode">
///	  Вызов в MDI режиме
///	</param>
procedure ShowReport(const AREPORT_ID: Variant; const AReportParams: TfSmReportParams;
  const AOwner: TWinControl = nil; const AMDIMode: Boolean = True);

implementation

uses SmReportEdit;

{$R *.dfm}

procedure ShowReport(const AREPORT_ID: Variant; const AReportParams: TfSmReportParams;
  const AOwner: TWinControl = nil; const AMDIMode: Boolean = True);
var
  f: TfSmReportPreview;
  res: Variant;
  i: Integer;
begin
  f := TfSmReportPreview.Create(AOwner, AREPORT_ID);
  AReportParams.WriteReportParams(f.qrMain);
  res := BuildReport(f.REPORT_ID);
  if VarIsNull(res) then
  begin
    FreeAndNil(f);
    Exit;
  end;
  f.qrMain.SQL.Text := res[0];
  f.qrMain.Active := True;
  for i := 0 to f.grMain.Columns.Count - 1 do
  begin
    f.grMain.Columns[i].Title.Caption := res[1][i];
    f.grMain.Columns[i].Title.Alignment := taCenter;
  end;

  if AOwner <> nil then
  begin
    f.Parent := AOwner;
    f.Align := alClient;
    f.BorderStyle := bsNone;
  end
  else
  begin
    if AMDIMode then
      f.FormStyle := fsMDIChild;
    FormMain.CreateButtonOpenWindow(f.Caption, f.Caption, f, 1);
  end;
  f.Show;
end;

procedure TfSmReportPreview.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfSmReportPreview.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Self);
end;

procedure TfSmReportPreview.FormDestroy(Sender: TObject);
begin
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Self);
end;

procedure TfSmReportPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qrMain.Active := False;
  Action := caFree;
end;

procedure TfSmReportPreview.FormCreate(Sender: TObject);
var
  cnt: Integer;
begin
  cnt := 0;
  REPORT_ID := InitParams;
  Caption := 'Отчет - ' + FastSelectSQLOne('SELECT REPORT_NAME FROM REPORT WHERE REPORT_ID=:0',
    VarArrayOf([REPORT_ID])) + IIF(cnt > 1, '(' + IntToStr(cnt) + ')', '');
end;



end.
