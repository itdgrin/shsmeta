unit TariffsTransportanion;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ExtCtrls;

type
  TFormTariffsTransportation = class(TForm)

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);

  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  end;

  // ����� ������
  TQueryDatabase = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  FormTariffsTransportation: TFormTariffsTransportation;

implementation

uses Main, Waiting, fFramePriceTransportations;

{$R *.dfm}

var
  FramePriceTransportation: TFramePriceTransportations;

  // ---------------------------------------------------------------------------------------------------------------------

  // ��������� ���������� ������
procedure TQueryDatabase.Execute;
begin
  FormWaiting.Show;
  FramePriceTransportation.ReceivingAll;
  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsTransportation.WMSysCommand(var Msg: TMessage);
begin
  // SC_MAXIMIZE - �������������� ����� �� ���� �����
  // SC_RESTORE - ������������ ����� � ����
  // SC_MINIMIZE - ������������ ����� � ��������� ������

  if (Msg.WParam = SC_MAXIMIZE) or (Msg.WParam = SC_RESTORE) then
  begin
    FormMain.PanelCover.Visible := True;
    inherited;
    FormMain.PanelCover.Visible := False;
  end
  else if Msg.WParam = SC_MINIMIZE then
  begin
    FormMain.PanelCover.Visible := True;
    inherited;
    ShowWindow(FormTariffsTransportation.Handle, SW_HIDE); // �������� ������ �������� �����
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsTransportation.FormCreate(Sender: TObject);
var
  Query: TQueryDatabase;
begin
  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10; // (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := 10; // GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNamePriceMaterials;

  // ----------------------------------------

  FramePriceTransportation := TFramePriceTransportations.Create(FormTariffsTransportation);
  FramePriceTransportation.Align := alClient;

  Query := TQueryDatabase.Create(False); // C����� ��������� ������
  Query.Priority := tpHighest;
  Query.Resume;

  // ----------------------------------------

  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(CaptionButtonPriceTransportation, HintButtonPriceTransportation,
    FormMain.ShowTariffsTransportation);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsTransportation.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButtonPriceTransportation);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsTransportation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  FramePriceTransportation.Destroy;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsTransportation.FormDestroy(Sender: TObject);
begin
  FormTariffsTransportation := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButtonPriceTransportation);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsTransportation.FormPaint(Sender: TObject);
begin
  if Parent = nil then
    FramePriceTransportation.Parent := FormTariffsTransportation;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
