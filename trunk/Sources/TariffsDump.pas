unit TariffsDump;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ExtCtrls, fFramePriceDumps;

type
  TFormTariffsDump = class(TForm)

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    const CaptionButton = '���. �� �������';
    const HintButton = '���� ������ �� �������';
  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
  public
    FramePriceDump: TFramePriceDumps;

  end;

var
  FormTariffsDump: TFormTariffsDump;

implementation

uses Main, Waiting;

{$R *.dfm}

procedure TFormTariffsDump.WMSysCommand(var Msg: TMessage);
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
    ShowWindow(FormTariffsDump.Handle, SW_HIDE); // �������� ������ �������� �����
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsDump.FormCreate(Sender: TObject);
begin
  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10; // (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := 10; // GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNamePriceDumps;

  // ----------------------------------------

  FramePriceDump := TFramePriceDumps.Create(Self);
  FramePriceDump.Parent := Self;
  FramePriceDump.Align := alClient;
  FramePriceDump.Visible := true;

  FormWaiting.Show;
  Application.ProcessMessages;

  FramePriceDump.ReceivingAll;

  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;

  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(CaptionButton, HintButton, Self, 1);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsDump.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsDump.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsDump.FormDestroy(Sender: TObject);
begin
  FormTariffsDump := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButton);
end;

end.
