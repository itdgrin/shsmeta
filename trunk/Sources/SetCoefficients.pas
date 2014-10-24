unit SetCoefficients;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ComCtrls, ExtCtrls;

type
  TFormSetCoefficients = class(TForm)
    Panel: TPanel;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  end;

var
  FormSetCoefficients: TFormSetCoefficients;

implementation

uses Main, fCoefficientsRates;

var
  FrameCoefficientsRates: TFrameCoefficientsRates;

{$R *.dfm}

  // ---------------------------------------------------------------------------------------------------------------------

procedure TFormSetCoefficients.WMSysCommand(var Msg: TMessage);
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
    ShowWindow(FormSetCoefficients.Handle, SW_HIDE); // Скрываем панель свёрнутой формы
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormSetCoefficients.FormCreate(Sender: TObject);
begin
  // Настройка размеров и положения формы
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 20;
  Left := 20;

  WindowState := wsMaximized;
  Caption := FormNameSetCoefficients;

  // -----------------------------------------

  Panel.Align := alClient;

  FrameCoefficientsRates := TFrameCoefficientsRates.Create(Self);
  with FrameCoefficientsRates do
  begin
    Parent := Panel;
    Align := alClient;
    Visible := True;
  end;

  // -----------------------------------------

  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(CaptionButtonSetCoefficients, HintButtonSetCoefficients,
    FormMain.ShowSetCoefficients);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormSetCoefficients.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(CaptionButtonSetCoefficients);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormSetCoefficients.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormSetCoefficients.FormDestroy(Sender: TObject);
begin
  FormSetCoefficients := nil;

  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButtonSetCoefficients);
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
