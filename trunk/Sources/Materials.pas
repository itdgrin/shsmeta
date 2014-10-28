unit Materials;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ExtCtrls, fFramePriceMaterials;

type
  TFormMaterials = class(TForm)

    constructor Create(AOwner: TComponent; const vDataBase: Char;
      const vPriceColumn, vAllowAddition, vAllowReplacement: Boolean); overload;

    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

  private
    AllowReplacement: Boolean; // Разрешено/запрещено заменять неучтённые метериалы из фрейма

    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  public
    FramePriceMaterials: TFramePriceMaterial;

  end;

var
  FormMaterials: TFormMaterials;

implementation

uses Main, Waiting, CalculationEstimate;

{$R *.dfm}

procedure TFormMaterials.WMSysCommand(var Msg: TMessage);
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
    inherited;
    ShowWindow(Self.Handle, SW_HIDE); // Скрываем панель свёрнутой формы
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFormMaterials.Create(AOwner: TComponent; const vDataBase: Char;
  const vPriceColumn, vAllowAddition, vAllowReplacement: Boolean);
begin
  inherited Create(AOwner);

  // ----------------------------------------

  FormMain.PanelCover.Visible := True; // Показываем панель на главной форме

  // ----------------------------------------

  // Настройка размеров и положения формы

  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10; // (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := 10; // GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNameReplacementMaterials;

  // ----------------------------------------

  AllowReplacement := vAllowReplacement;

  FramePriceMaterials := TFramePriceMaterial.Create(Self, vDataBase, vPriceColumn, vAllowAddition, vAllowReplacement);
  FramePriceMaterials.Parent := Self;
  FramePriceMaterials.Align := alClient;
  FramePriceMaterials.Visible := true;

  FormWaiting.Show;
  Application.ProcessMessages;

  FramePriceMaterials.ReceivingAll;

  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;
  // ----------------------------------------

  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(CaptionButtonReplacementMaterials, HintButtonReplacementMaterials,
    FormMain.ShowMaterials);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormMaterials.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(CaptionButtonReplacementMaterials);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormMaterials.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  if AllowReplacement then
  begin
    FormMain.PanelCover.Visible := True;
    FormCalculationEstimate.WindowState := wsMaximized;
    FormMain.PanelCover.Visible := False;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormMaterials.FormDestroy(Sender: TObject);
begin
  FormMaterials := nil;

  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButtonReplacementMaterials);
end;

end.
