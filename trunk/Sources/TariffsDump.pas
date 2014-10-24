unit TariffsDump;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ExtCtrls;

type
  TFormTariffsDump = class(TForm)

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
  FormTariffsDump: TFormTariffsDump;

implementation

uses Main, Waiting, fFramePriceDumps;

{$R *.dfm}

var
  FramePriceDump: TFramePriceDumps;

  // ---------------------------------------------------------------------------------------------------------------------

  // ��������� ���������� ������
procedure TQueryDatabase.Execute;
begin
  FormWaiting.Show;
  FramePriceDump.ReceivingAll;
  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

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
var
  Query: TQueryDatabase;
begin
  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10; // (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := 10; // GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNamePriceDumps;

  // ----------------------------------------

  FramePriceDump := TFramePriceDumps.Create(FormTariffsDump);
  FramePriceDump.Align := alClient;

  Query := TQueryDatabase.Create(False); // C����� ��������� ������
  Query.Priority := tpHighest;
  Query.Resume;

  // ----------------------------------------

  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(CaptionButtonPriceDumps, HintButtonPriceDumps, FormMain.ShowTariffsDump);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsDump.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButtonPriceDumps);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsDump.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  FramePriceDump.Destroy;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsDump.FormDestroy(Sender: TObject);
begin
  FormTariffsDump := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButtonPriceDumps);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsDump.FormPaint(Sender: TObject);
begin
  if Parent = nil then
    FramePriceDump.Parent := FormTariffsDump;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
