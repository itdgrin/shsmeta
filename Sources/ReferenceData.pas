unit ReferenceData;

interface

uses
  Windows, Messages, Classes, Controls, Forms, Buttons, ExtCtrls, Vcl.Dialogs,
  fFrameRates, fFramePriceMaterials, fFramePriceMechanizms, fFrameEquipments,
  fFrameOXROPR, fFrameWinterPrice, fFrameSSR, fFrameSmeta;

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

    constructor Create(AOwner: TComponent; const vDataBase: Char; const vPriceColumn: Boolean); reintroduce;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure HideAllFrames;

    procedure SpeedButtonClick(Sender: TObject);

    function GetLeftIndentForFormSborniks(): Integer;
    function GetTopIndentForFormSborniks(): Integer;
  private
    const CaptionButton = 'Справочные данные';
    const HintButton = 'Окно справочных данных';
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
  FrameRates.Visible := False;
  SpeedButtonRates.Tag := Integer(FrameRates);

  FramePriceMaterials := TFramePriceMaterial.Create(Self, vDataBase, vPriceColumn, False, False);
  FramePriceMaterials.Parent := Self;
  FramePriceMaterials.Align := alClient;
  FramePriceMaterials.Visible := False;
  SpeedButtonMaterials.Tag := Integer(FramePriceMaterials);

  FramePriceMechanizms := TFramePriceMechanizm.Create(Self, vDataBase, vPriceColumn, False);
  FramePriceMechanizms.Parent := Self;
  FramePriceMechanizms.Align := alClient;
  FramePriceMechanizms.Visible := False;
  SpeedButtonMechanizms.Tag := Integer(FramePriceMechanizms);

  FrameEquipments := TFrameEquipment.Create(Self, vDataBase, False);
  FrameEquipments.Parent := Self;
  FrameEquipments.Align := alClient;
  FrameEquipments.Visible := False;
  SpeedButtonEquipments.Tag := Integer(FrameEquipments);

  FrameOXROPR := TFrameOXROPR.Create(Self);
  FrameOXROPR.Parent := Self;
  FrameOXROPR.Align := alClient;
  FrameOXROPR.Visible := False;
  SpeedButtonOXROPR.Tag := Integer(FrameOXROPR);

  FrameWinterPrices := TFrameWinterPrice.Create(Self);
  FrameWinterPrices.Parent := Self;
  FrameWinterPrices.Align := alClient;
  FrameWinterPrices.Visible := False;
  SpeedButtonWinterPrices.Tag := Integer(FrameWinterPrices);

  FrameSSR := TFrameSSR.Create(Self);
  FrameSSR.Parent := Self;
  FrameSSR.Align := alClient;
  FrameSSR.Visible := False;
  SpeedButtonSSR.Tag := Integer(FrameSSR);

  SpeedButtonClick(SpeedButtonRates);
  FrameRates.Visible := true;

  FormMain.PanelCover.Visible := False;

  FormMain.CreateButtonOpenWindow(CaptionButton, HintButton, Self, 1);
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
  FormMain.SelectButtonActiveWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReferenceData.FormDestroy(Sender: TObject);
begin
  FormReferenceData := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButton);
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

procedure TFormReferenceData.SpeedButtonClick(Sender: TObject);
begin
  HideAllFrames;

  if not Assigned(TSmetaFrame((Sender as TComponent).Tag)) then exit;

  with TSmetaFrame((Sender as TComponent).Tag) do
  begin
    if not Loaded then
    begin
      FormWaiting.Show;
      Application.ProcessMessages;
      try
        ReceivingAll;
      finally
        FormWaiting.Close;
      end;
    end;

    if (Self as TControl).Visible then
    begin
      Visible := True;
      SetFocus;
    end;
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
