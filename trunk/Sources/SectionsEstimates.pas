unit SectionsEstimates;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ComCtrls, ExtCtrls;

type
  TFormSectionsEstimates = class(TForm)
    Panel: TPanel;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
  end;

var
  FormSectionsEstimates: TFormSectionsEstimates;

implementation

uses Main, fSectionsEstimates;

var
  FrameSectionsEstimates: TFrameSectionsEstimates;

{$R *.dfm}

  // ---------------------------------------------------------------------------------------------------------------------

procedure TFormSectionsEstimates.WMSysCommand(var Msg: TMessage);
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
    ShowWindow(FormSectionsEstimates.Handle, SW_HIDE); // �������� ������ �������� �����
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormSectionsEstimates.FormCreate(Sender: TObject);
begin
  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 20;
  Left := 20;

  WindowState := wsMaximized;
  Caption := FormNameSectionsEstimates;

  // -----------------------------------------

  Panel.Align := alClient;

  FrameSectionsEstimates := TFrameSectionsEstimates.Create(FormSectionsEstimates);
  with FrameSectionsEstimates do
  begin
    Parent := Panel;
    Align := alClient;
    Visible := True;
  end;

  // -----------------------------------------

  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(CaptionButtonSectionsEstimates, HintButtonSectionsEstimates,
    FormMain.ShowSectionsEstimates);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormSectionsEstimates.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButtonSectionsEstimates);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormSectionsEstimates.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormSectionsEstimates.FormDestroy(Sender: TObject);
begin
  FrameSectionsEstimates.Destroy;

  FormSectionsEstimates := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButtonSectionsEstimates);
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
