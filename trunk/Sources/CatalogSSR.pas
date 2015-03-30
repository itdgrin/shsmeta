unit CatalogSSR;

interface

uses
  Forms, Classes, Controls, ExtCtrls, fFrameSSR;

type
  TFormCatalogSSR = class(TForm)

    Timer: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure HideAllFrames;
    procedure TimerTimer(Sender: TObject);
  private
    const ButtonCaption = '����������� ���';
    const ButtonHint = '���� ������������ ���';
  private
    FrameSSR: TFrameSSR;
    InitialFrames: Integer;

  public

  end;

var
  FormCatalogSSR: TFormCatalogSSR;

implementation

uses Main;

{$R *.dfm}

procedure TFormCatalogSSR.FormCreate(Sender: TObject);
begin
  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 20;
  Left := 20;

  WindowState := wsMaximized;

  // -----------------------------------------

  FrameSSR := TFrameSSR.Create(FormCatalogSSR);

  InitialFrames := 1;

  HideAllFrames;

  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(ButtonCaption, ButtonHint, Self);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCatalogSSR.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(ButtonCaption);

  if Timer.Tag = 0 then
    Timer.Enabled := True;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCatalogSSR.FormPaint(Sender: TObject);
begin
  if InitialFrames = 1 then
  begin
    FrameSSR.Parent := FormCatalogSSR;
    FrameSSR.Visible := False;

    InitialFrames := 0;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCatalogSSR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCatalogSSR.FormDestroy(Sender: TObject);
begin
  FormCatalogSSR := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(ButtonCaption);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCatalogSSR.HideAllFrames;
begin
  with FrameSSR do
  begin
    Visible := False;
    Align := alnone;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCatalogSSR.TimerTimer(Sender: TObject);
begin
  if Timer.Tag = 10 then
  begin
    Timer.Enabled := False;

    with FrameSSR do
    begin
      Align := alClient;
      ReceivingAll;
      Visible := True;
      SetFocus;
    end;
  end
  else
    Timer.Tag := Timer.Tag + 1;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
