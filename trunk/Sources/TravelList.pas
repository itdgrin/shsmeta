unit TravelList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Tools, Main;

type
  TfTravelList = class(TForm)
    JvDBGrid1: TJvDBGrid;
    qrObject: TFDQuery;
    dsObject: TDataSource;
    pnlTop: TPanel;
    lbl1: TLabel;
    dblkcbbNAME: TDBLookupComboBox;
    pnl1: TPanel;
    btnClose: TButton;
    qrTravel: TFDQuery;
    dsTravel: TDataSource;
    qrActList: TFDQuery;
    dsActList: TDataSource;
    dbnvgr1: TDBNavigator;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure qrTravelNewRecord(DataSet: TDataSet);
    procedure qrTravelBeforeEdit(DataSet: TDataSet);
  private
    { Private declarations }
  public
    procedure LocateObject(Object_ID: Integer);
  end;

var
  fTravelList: TfTravelList;

implementation

{$R *.dfm}

uses CalcTravel;

procedure TfTravelList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

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
 // FormMain.CreateButtonOpenWindow(Caption, Caption, FormMain.N6Click);
 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  CloseOpen(qrObject);
  CloseOpen(qrActList);
  CloseOpen(qrTravel);
  LoadDBGridSettings(JvDBGrid1);
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

procedure TfTravelList.qrTravelBeforeEdit(DataSet: TDataSet);
begin
  if (not Assigned(fCalcTravel)) then
    fCalcTravel := TfCalcTravel.Create(Self);

  fCalcTravel.ID_ACT := 0;
  fCalcTravel.ID_TRAVEL := 0;

  fCalcTravel.Show;
end;

procedure TfTravelList.qrTravelNewRecord(DataSet: TDataSet);
begin
  if (not Assigned(fCalcTravel)) then
    fCalcTravel := TfCalcTravel.Create(Self);

  qrTravel.FieldByName('travel_date').AsDateTime := Now;

  fCalcTravel.ID_ACT := 0;
  fCalcTravel.ID_TRAVEL := 0;

  fCalcTravel.Show;
end;

end.
