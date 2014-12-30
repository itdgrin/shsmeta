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
    btnDel: TButton;
    btnEdit: TButton;
    btnAdd: TButton;
    btnClose: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
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

procedure TfTravelList.btnAddClick(Sender: TObject);
begin
  if (not Assigned(fCalcTravel)) then
    fCalcTravel := TfCalcTravel.Create(Self);

  fCalcTravel.ID_ACT := 0;
  fCalcTravel.ID_TRAVEL := 0;

  fCalcTravel.Show;
end;

procedure TfTravelList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfTravelList.btnEditClick(Sender: TObject);
begin
  if (not Assigned(fCalcTravel)) then
    fCalcTravel := TfCalcTravel.Create(Self);

  fCalcTravel.ID_ACT := 0;
  fCalcTravel.ID_TRAVEL := 0;

  fCalcTravel.Show;
end;

procedure TfTravelList.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;
  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfTravelList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfTravelList.FormCreate(Sender: TObject);
begin
  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(Caption, Caption, FormMain.N6Click);
  CloseOpen(qrObject);
  LoadDBGridSettings(JvDBGrid1);
end;

procedure TfTravelList.FormDestroy(Sender: TObject);
begin
  fTravelList := nil;
  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

procedure TfTravelList.LocateObject(Object_ID: Integer);
begin
  dblkcbbNAME.KeyValue := Object_ID;
end;

end.