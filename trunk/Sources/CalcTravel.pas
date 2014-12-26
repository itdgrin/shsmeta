unit CalcTravel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Tools, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfCalcTravel = class(TForm)
    lbl1: TLabel;
    dbedt1: TDBEdit;
    dbedt2: TDBEdit;
    lbl3: TLabel;
    dbedt3: TDBEdit;
    lbl4: TLabel;
    btnExit: TBitBtn;
    btnSave: TBitBtn;
    JvDBGrid1: TJvDBGrid;
    dsCalcKomandir: TDataSource;
    qrCalcKomandir: TFDQuery;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    ID_ACT: Integer;
    ID_TRAVEL: Integer;
  end;

var
  fCalcTravel: TfCalcTravel;

implementation

{$R *.dfm}

uses Main, TravelList;

procedure TfCalcTravel.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfCalcTravel.btnSaveClick(Sender: TObject);
begin
  Close;
end;

procedure TfCalcTravel.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;
  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfCalcTravel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCalcTravel.FormCreate(Sender: TObject);
begin
  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(Caption, Caption, fTravelList.btnAddClick);
  LoadDBGridSettings(JvDBGrid1);
  CloseOpen(qrCalcKomandir);
end;

procedure TfCalcTravel.FormDestroy(Sender: TObject);
begin
  Self := nil;
  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

end.
