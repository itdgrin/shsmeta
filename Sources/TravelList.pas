unit TravelList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Tools, Main, Vcl.ComCtrls;

type
  TfTravelList = class(TForm)
    qrObject: TFDQuery;
    dsObject: TDataSource;
    pnlTop: TPanel;
    lbl1: TLabel;
    dblkcbbNAME: TDBLookupComboBox;
    pnl1: TPanel;
    qrTravel: TFDQuery;
    dsTravel: TDataSource;
    dbnvgr1: TDBNavigator;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    ts3: TTabSheet;
    grTravel: TJvDBGrid;
    grTravelWork: TJvDBGrid;
    grWorkerDepartment: TJvDBGrid;
    qrTravelWork: TFDQuery;
    dsTravelWork: TDataSource;
    qrWorkerDepartment: TFDQuery;
    dsWorkerDepartment: TDataSource;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qrTravelNewRecord(DataSet: TDataSet);
    procedure qrTravelBeforeEdit(DataSet: TDataSet);
    procedure pgc1Change(Sender: TObject);
    procedure qrTravelWorkBeforeEdit(DataSet: TDataSet);
    procedure qrTravelWorkNewRecord(DataSet: TDataSet);
    procedure qrWorkerDepartmentBeforeEdit(DataSet: TDataSet);
    procedure qrWorkerDepartmentNewRecord(DataSet: TDataSet);
  private
  public
    procedure LocateObject(Object_ID: Integer);
  end;

var
  fTravelList: TfTravelList;

implementation

{$R *.dfm}

uses CalcTravel, CalcTravelWork, CalcWorkerDepartment;

procedure TfTravelList.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfTravelList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfTravelList.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(Caption, Caption, Self, 1);
  LoadDBGridSettings(grTravel);
  LoadDBGridSettings(grTravelWork);
  LoadDBGridSettings(grWorkerDepartment);
  CloseOpen(qrObject);
  pgc1.ActivePageIndex := 0;
  pgc1Change(Sender);
end;

procedure TfTravelList.FormDestroy(Sender: TObject);
begin
  fTravelList := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

procedure TfTravelList.LocateObject(Object_ID: Integer);
begin
  dblkcbbNAME.KeyValue := Object_ID;
end;

procedure TfTravelList.pgc1Change(Sender: TObject);
begin
  case pgc1.ActivePageIndex of
    0:
      begin
        dbnvgr1.DataSource := dsTravel;
        CloseOpen(qrTravel);
      end;
    1:
      begin
        dbnvgr1.DataSource := dsTravelWork;
        CloseOpen(qrTravelWork);
      end;
    2:
      begin
        dbnvgr1.DataSource := dsWorkerDepartment;
        CloseOpen(qrWorkerDepartment);
      end;
  end;
end;

procedure TfTravelList.qrTravelBeforeEdit(DataSet: TDataSet);
begin
  if (not Assigned(fCalcTravel)) then
    fCalcTravel := TfCalcTravel.Create(Self);
  FormMain.ReplaceButtonOpenWindow(Self, fCalcTravel);
  fCalcTravel.InitParams;
  fCalcTravel.Show;
end;

procedure TfTravelList.qrTravelNewRecord(DataSet: TDataSet);
begin
  qrTravel.FieldByName('OnDate').AsDateTime := Now;
  if (not Assigned(fCalcTravel)) then
    fCalcTravel := TfCalcTravel.Create(Self);
  FormMain.ReplaceButtonOpenWindow(Self, fCalcTravel);
  fCalcTravel.InitParams;
  fCalcTravel.Show;
end;

procedure TfTravelList.qrTravelWorkBeforeEdit(DataSet: TDataSet);
begin
  if (not Assigned(fCalcTravelWork)) then
    fCalcTravelWork := TfCalcTravelWork.Create(Self);
  FormMain.ReplaceButtonOpenWindow(Self, fCalcTravelWork);
  fCalcTravelWork.InitParams;
  fCalcTravelWork.Show;
end;

procedure TfTravelList.qrTravelWorkNewRecord(DataSet: TDataSet);
begin
  qrTravelWork.FieldByName('OnDate').AsDateTime := Now;
  if (not Assigned(fCalcTravelWork)) then
    fCalcTravelWork := TfCalcTravelWork.Create(Self);
  FormMain.ReplaceButtonOpenWindow(Self, fCalcTravelWork);
  fCalcTravelWork.InitParams;
  fCalcTravelWork.Show;
end;

procedure TfTravelList.qrWorkerDepartmentBeforeEdit(DataSet: TDataSet);
begin
  if (not Assigned(fCalcWorkerDepartment)) then
    fCalcWorkerDepartment := TfCalcWorkerDepartment.Create(Self);
  FormMain.ReplaceButtonOpenWindow(Self, fCalcWorkerDepartment);
  fCalcWorkerDepartment.InitParams;
  fCalcWorkerDepartment.Show;
end;

procedure TfTravelList.qrWorkerDepartmentNewRecord(DataSet: TDataSet);
begin
  qrWorkerDepartment.FieldByName('OnDate').AsDateTime := Now;
  if (not Assigned(fCalcWorkerDepartment)) then
    fCalcWorkerDepartment := TfCalcWorkerDepartment.Create(Self);
  FormMain.ReplaceButtonOpenWindow(Self, fCalcWorkerDepartment);
  fCalcWorkerDepartment.InitParams;
  fCalcWorkerDepartment.Show;
end;

end.
