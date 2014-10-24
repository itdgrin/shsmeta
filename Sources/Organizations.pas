unit Organizations;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ComCtrls, ExtCtrls;

type
  TFormOrganizations = class(TForm)
    Panel: TPanel;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  end;

var
  FormOrganizations: TFormOrganizations;

implementation

uses Main, fOrganizations;

var
  FrameOrganizations: TFrameOrganizations;

{$R *.dfm}
  // ---------------------------------------------------------------------------------------------------------------------

procedure TFormOrganizations.WMSysCommand(var Msg: TMessage);
begin
  // SC_MAXIMIZE - Разворачивание формы во весь экран
  // SC_RESTORE - Сворачивание формы в окно
  // SC_MINIMIZE - Сворачивание формы в маленькую панель

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
    ShowWindow(FormOrganizations.Handle, SW_HIDE); // Скрываем панель свёрнутой формы
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOrganizations.FormCreate(Sender: TObject);
begin
  // Настройка размеров и положения формы
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 20;
  Left := 20;

  WindowState := wsMaximized;
  Caption := FormNameOrganizations;

  // -----------------------------------------

  Panel.Align := alClient;

  FrameOrganizations := TFrameOrganizations.Create(FormOrganizations);
  with FrameOrganizations do
  begin
    Parent := Panel;
    Align := alClient;
    Visible := True;
  end;

  // -----------------------------------------

  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(CaptionButtonOrganizations, HintButtonOrganizations, FormMain.ShowOrganizations);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOrganizations.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(CaptionButtonOrganizations);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOrganizations.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOrganizations.FormDestroy(Sender: TObject);
begin
  FrameOrganizations.Destroy;

  FormOrganizations := nil;

  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButtonOrganizations);
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
