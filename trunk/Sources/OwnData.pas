unit OwnData;

interface

uses
  Windows, Messages, Classes, Controls, Forms, Buttons, ExtCtrls, fFrameRates,
  fFramePriceMaterials, fFramePriceMechanizms, fFrameEquipments;

type
  TFormOwnData = class(TForm)

    PanelOwnData: TPanel;

    SpeedButtonMaterials: TSpeedButton;
    SpeedButtonMechanisms: TSpeedButton;
    SpeedButtonEquipments: TSpeedButton;
    SpeedButtonRates: TSpeedButton;

    constructor Create(AOwner: TComponent; const vDataBase: Char; const vPriceColumn: Boolean);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure HideAllFrames;

    procedure SpeedButtonRatesClick(Sender: TObject);
    procedure SpeedButtonMaterialsClick(Sender: TObject);
    procedure SpeedButtonMechanizmsClick(Sender: TObject);
    procedure SpeedButtonEquipmentsClick(Sender: TObject);

  protected
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  public
    FrameRates: TFrameRates;
    FramePriceMaterials: TFramePriceMaterial;
    FramePriceMechanisms: TFramePriceMechanizm;
    FrameEquipments: TFrameEquipment;
  end;

var
  FormOwnData: TFormOwnData;

implementation

uses Main, Waiting;

{$R *.dfm}

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.WMSysCommand(var Msg: TMessage);
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
    ShowWindow(FormOwnData.Handle, SW_HIDE); // Скрываем панель свёрнутой формы
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFormOwnData.Create(AOwner: TComponent; const vDataBase: Char; const vPriceColumn: Boolean);
begin
  inherited Create(AOwner);

  // ----------------------------------------

  FormMain.PanelCover.Visible := True; // Показываем панель на главной форме

  // ----------------------------------------

  // Настройка размеров и положения формы

  ClientWidth := FormMain.ClientWidth;
  ClientHeight := FormMain.ClientHeight;
  Top := (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNameOwnData;

  // ----------------------------------------

  FrameRates := TFrameRates.Create(Self, vDataBase, False);
  FrameRates.Parent := Self;
  FrameRates.Align := alClient;
  FrameRates.Visible := True;

  FramePriceMaterials := TFramePriceMaterial.Create(Self, vDataBase, vPriceColumn, False, False);
  FramePriceMaterials.Parent := Self;
  FramePriceMaterials.Align := alClient;
  FramePriceMaterials.Visible := False;

  FramePriceMechanisms := TFramePriceMechanizm.Create(Self, vDataBase, vPriceColumn, False);
  FramePriceMechanisms.Parent := Self;
  FramePriceMechanisms.Align := alClient;
  FramePriceMechanisms.Visible := False;

  FrameEquipments := TFrameEquipment.Create(Self, vDataBase, False);
  FrameEquipments.Parent := Self;
  FrameEquipments.Align := alClient;
  FrameEquipments.Visible := False;

  FormWaiting.Show;
  Application.ProcessMessages;

  FrameRates.ReceivingAll;
  FramePriceMaterials.ReceivingAll;
  FramePriceMechanisms.ReceivingAll;
  FrameEquipments.ReceivingAll;

  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;

  // ----------------------------------------

  FormMain.CreateButtonOpenWindow(CaptionButtonOwnData, HintButtonOwnData, FormMain.ShowOwnData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(CaptionButtonOwnData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.FormDestroy(Sender: TObject);
begin
  FormOwnData := nil;

  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButtonOwnData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.HideAllFrames;
begin
  FrameRates.Visible := False;
  FramePriceMaterials.Visible := False;
  FramePriceMechanisms.Visible := False;
  FrameEquipments.Visible := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.SpeedButtonRatesClick(Sender: TObject);
begin
  HideAllFrames;

  with FrameRates do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.SpeedButtonMaterialsClick(Sender: TObject);
begin
  HideAllFrames;

  with FramePriceMaterials do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.SpeedButtonMechanizmsClick(Sender: TObject);
begin
  HideAllFrames;

  with FramePriceMechanisms do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.SpeedButtonEquipmentsClick(Sender: TObject);
begin
  HideAllFrames;

  with FrameEquipments do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
