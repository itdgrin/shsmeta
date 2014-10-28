unit ReferenceData;

interface

uses
  Windows, Messages, Classes, Controls, Forms, Buttons, ExtCtrls, Vcl.Dialogs,
  fFrameRates, fFramePriceMaterials, fFramePriceMechanizms, fFrameEquipments,
  fFrameOXROPR, fFrameWinterPrice, fFrameSSR;

type
  TFormReferenceData = class(TForm)

    PanelReferenceData: TPanel;

    SpeedButtonRates: TSpeedButton;
    SpeedButtonMaterials: TSpeedButton;
    SpeedButtonMechanizms: TSpeedButton;
    SpeedButtonEquipments: TSpeedButton;
    SpeedButtonOXROPR: TSpeedButton;
    SpeedButtonWinterPrices: TSpeedButton;
    SpeedButtonSSR: TSpeedButton;
    SpeedButtonAlgorithmsCalculation: TSpeedButton;

    constructor Create(AOwner: TComponent; const vDataBase: Char; const vPriceColumn: Boolean);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure HideAllFrames;

    procedure SpeedButtonRatesClick(Sender: TObject);
    procedure SpeedButtonMaterialsClick(Sender: TObject);
    procedure SpeedButtonMechanizmsClick(Sender: TObject);
    procedure SpeedButtonEquipmentsClick(Sender: TObject);
    procedure SpeedButtonOXROPRClick(Sender: TObject);
    procedure SpeedButtonWinterPricesClick(Sender: TObject);
    procedure SpeedButtonSSRClick(Sender: TObject);
    function GetLeftIndentForFormSborniks(): Integer;
    function GetTopIndentForFormSborniks(): Integer;

  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  public
    FrameRates: TFrameRates;
    FramePriceMaterials: TFramePriceMaterial;
    FramePriceMechanizms: TFramePriceMechanizm;
    FrameEquipments: TFrameEquipment;
    FrameOXROPR: TFrameOXROPR;
    FrameWinterPrices: TFrameWinterPrice;
    FrameSSR: TFrameSSR;
  end;

var
  FormReferenceData: TFormReferenceData;

implementation

uses Main, Waiting;

{$R *.dfm}

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.WMSysCommand(var Msg: TMessage);
var
  WS: TWindowState;
  i: Integer;
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
    ShowWindow(FormReferenceData.Handle, SW_HIDE); // Скрываем панель свёрнутой формы
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFormReferenceData.Create(AOwner: TComponent; const vDataBase: Char; const vPriceColumn: Boolean);
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
  Caption := FormNameReferenceData;

  // ----------------------------------------
  FrameRates := TFrameRates.Create(Self, vDataBase, False);
  FrameRates.Parent := Self;
  FrameRates.Align := alClient;
  FrameRates.Visible := True;

  FramePriceMaterials := TFramePriceMaterial.Create(Self, vDataBase, vPriceColumn, False, False);
  FramePriceMaterials.Parent := Self;
  FramePriceMaterials.Align := alClient;
  FramePriceMaterials.Visible := False;

  FramePriceMechanizms := TFramePriceMechanizm.Create(Self, vDataBase, vPriceColumn, False);
  FramePriceMechanizms.Parent := Self;
  FramePriceMechanizms.Align := alClient;
  FramePriceMechanizms.Visible := False;

  FrameEquipments := TFrameEquipment.Create(Self, vDataBase, False);
  FrameEquipments.Parent := Self;
  FrameEquipments.Align := alClient;
  FrameEquipments.Visible := False;

  FrameOXROPR := TFrameOXROPR.Create(Self);
  FrameOXROPR.Parent := Self;
  FrameOXROPR.Align := alClient;
  FrameOXROPR.Visible := False;

  FrameWinterPrices := TFrameWinterPrice.Create(Self);
  FrameWinterPrices.Parent := Self;
  FrameWinterPrices.Align := alClient;
  FrameWinterPrices.Visible := False;

  FrameSSR := TFrameSSR.Create(Self);
  FrameSSR.Parent := Self;
  FrameSSR.Align := alClient;
  FrameSSR.Visible := False;

  FormWaiting.Show;
  Application.ProcessMessages;

  FrameRates.ReceivingAll;
  FramePriceMaterials.ReceivingAll;
  FramePriceMechanizms.ReceivingAll;
  FrameEquipments.ReceivingAll;
  FrameOXROPR.ReceivingAll;
  //FrameWinterPrices.FillingTree;
  FrameSSR.ReceivingAll;

  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;

  FormMain.CreateButtonOpenWindow(CaptionButtonReferenceData, HintButtonReferenceData,
    FormMain.ShowReferenceData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(CaptionButtonReferenceData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.FormDestroy(Sender: TObject);
begin
  FormReferenceData := nil;

  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButtonReferenceData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.HideAllFrames;
begin
  FrameRates.Visible := False;
  FramePriceMaterials.Visible := False;
  FramePriceMechanizms.Visible := False;
  FrameEquipments.Visible := False;
  FrameOXROPR.Visible := False;
  FrameWinterPrices.Visible := False;
  FrameSSR.Visible := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.SpeedButtonRatesClick(Sender: TObject);
begin
  HideAllFrames;

  with FrameRates do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.SpeedButtonMaterialsClick(Sender: TObject);
begin
  HideAllFrames;

  with FramePriceMaterials do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.SpeedButtonMechanizmsClick(Sender: TObject);
begin
  HideAllFrames;

  with FramePriceMechanizms do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.SpeedButtonEquipmentsClick(Sender: TObject);
begin
  HideAllFrames;

  with FrameEquipments do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.SpeedButtonOXROPRClick(Sender: TObject);
begin
  HideAllFrames;

  with FrameOXROPR do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.SpeedButtonWinterPricesClick(Sender: TObject);
begin
  HideAllFrames;

  with FrameWinterPrices do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.SpeedButtonSSRClick(Sender: TObject);
begin
  HideAllFrames;

  with FrameSSR do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

function TFormReferenceData.GetLeftIndentForFormSborniks(): Integer;
begin
  Result := FrameRates.VST.Width + FrameRates.SplitterLeft.Width;
end;

// ---------------------------------------------------------------------------------------------------------------------

function TFormReferenceData.GetTopIndentForFormSborniks(): Integer;
begin
  Result := PanelReferenceData.Height + FrameRates.PanelSearchNormative.Height +
    FrameRates.PanelHeaderCollection.Height;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
