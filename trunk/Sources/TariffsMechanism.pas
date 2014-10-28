unit TariffsMechanism;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ExtCtrls, AppEvnts, SysUtils,
  fFramePriceMechanizms;

type
  TFormTariffsMechanism = class(TForm)

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  public
    FramePriceMechanizm: TFramePriceMechanizm;

  end;

var
  FormTariffsMechanism: TFormTariffsMechanism;

implementation

uses Main, Waiting;

{$R *.dfm}

procedure TFormTariffsMechanism.WMSysCommand(var Msg: TMessage);
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
  else if Msg.WParam = SC_MINIMIZE then
  begin
    FormMain.PanelCover.Visible := True;
    inherited;
    ShowWindow(FormTariffsMechanism.Handle, SW_HIDE); // Скрываем панель свёрнутой формы
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsMechanism.FormCreate(Sender: TObject);
begin
  // Настройка размеров и положения формы
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10; // (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := 10; // GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNamePriceMechanizms;

  // ----------------------------------------

  FramePriceMechanizm := TFramePriceMechanizm.Create(Self, 'g', True, True);
  FramePriceMechanizm.Parent := Self;

  FormWaiting.Show;
  Application.ProcessMessages;

  FramePriceMechanizm.ReceivingAll;

  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;

  // ----------------------------------------

  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(CaptionButtonPriceMechanizms, HintButtonPriceMechanizms,
    FormMain.ShowTariffsMechanism);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsMechanism.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(CaptionButtonPriceMechanizms);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsMechanism.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsMechanism.FormDestroy(Sender: TObject);
begin
  FormTariffsMechanism := nil;

  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButtonPriceMechanizms);
end;

end.
