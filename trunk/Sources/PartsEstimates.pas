unit PartsEstimates;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ComCtrls, ExtCtrls;

type
  TFormPartsEstimates = class(TForm)
    Panel: TPanel;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    const CaptionButton = '����� ����';
    const HintButton = '���� ������ ����';
  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
  end;

var
  FormPartsEstimates: TFormPartsEstimates;

implementation

uses Main, fPartsEstimates;

var
  FramePartsEstimates: TFramePartsEstimates;

{$R *.dfm}

  // ---------------------------------------------------------------------------------------------------------------------

procedure TFormPartsEstimates.WMSysCommand(var Msg: TMessage);
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
  else if (Msg.WParam = SC_MINIMIZE) then
  begin
    FormMain.PanelCover.Visible := True;
    inherited;
    ShowWindow(FormPartsEstimates.Handle, SW_HIDE); // �������� ������ �������� �����
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPartsEstimates.FormCreate(Sender: TObject);
begin
  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 20;
  Left := 20;

  WindowState := wsMaximized;
  Caption := FormNamePartsEstimates;

  // -----------------------------------------

  Panel.Align := alClient;

  FramePartsEstimates := TFramePartsEstimates.Create(Self);
  with FramePartsEstimates do
  begin
    Parent := Panel;
    Align := alClient;
    Visible := True;
  end;

  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(CaptionButton, HintButton, Self);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPartsEstimates.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPartsEstimates.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPartsEstimates.FormDestroy(Sender: TObject);
begin
  FramePartsEstimates.Destroy;

  FormPartsEstimates := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
