unit TariffsMechanism;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ExtCtrls, AppEvnts, SysUtils;

type
  TFormTariffsMechanism = class(TForm)

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);

  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  end;

  // ����� ������
  TQueryMechanizms = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  FormTariffsMechanism: TFormTariffsMechanism;

implementation

uses Main, Waiting, fFramePriceMechanizms;

{$R *.dfm}

var
  FramePriceMechanizm: TFramePriceMechanizm;

  // ---------------------------------------------------------------------------------------------------------------------

  // ��������� ���������� ������
procedure TQueryMechanizms.Execute;
begin
  FormWaiting.Show;
  FramePriceMechanizm.ReceivingAll;
  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsMechanism.WMSysCommand(var Msg: TMessage);
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
    ShowWindow(FormTariffsMechanism.Handle, SW_HIDE); // �������� ������ �������� �����
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsMechanism.FormCreate(Sender: TObject);
var
  Query: TQueryMechanizms;
begin
  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10; // (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := 10; // GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNamePriceMechanizms;

  // ----------------------------------------

  // FramePriceMechanizm := TFramePriceMechanizm.Create(FormTariffsMechanism);

  Query := TQueryMechanizms.Create(False); // C����� ��������� ������
  Query.Priority := tpHighest;
  Query.Resume;

  // ----------------------------------------

  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(CaptionButtonPriceMechanizms, HintButtonPriceMechanizms,
    FormMain.ShowTariffsMechanism);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsMechanism.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButtonPriceMechanizms);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsMechanism.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  FramePriceMechanizm.Destroy;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsMechanism.FormDestroy(Sender: TObject);
begin
  FormTariffsMechanism := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButtonPriceMechanizms);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsMechanism.FormPaint(Sender: TObject);
begin
  if FramePriceMechanizm.Parent = nil then
    FramePriceMechanizm.Parent := FormTariffsMechanism;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
