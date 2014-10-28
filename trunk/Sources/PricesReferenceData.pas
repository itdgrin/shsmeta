unit PricesReferenceData;

interface

uses
  Windows, Messages, Classes, Controls, Forms, Buttons, ExtCtrls,
  fFramePriceMaterials, fFramePriceMechanizms, fFramePriceTransportations,
  fFramePriceDumps;

type
  TFormPricesReferenceData = class(TForm)

    PanelPrices: TPanel;

    SpeedButtonTariffs: TSpeedButton;
    SpeedButtonPriceMaterials: TSpeedButton;
    SpeedButtonPriceMechanizms: TSpeedButton;
    SpeedButtonPriceTransportation: TSpeedButton;
    SpeedButtonPriceDumps: TSpeedButton;
    SpeedButtonIndex: TSpeedButton;

    constructor Create(AOwner: TComponent; const vDataBase: Char; const vPriceColumn: Boolean);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure HideAllFrames;

    procedure SpeedButtonMaterialsClick(Sender: TObject);
    procedure SpeedButtonMechanizmsClick(Sender: TObject);
    procedure SpeedButtonPriceTransportationClick(Sender: TObject);
    procedure SpeedButtonPriceDumpsClick(Sender: TObject);

  protected
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  private
    FramePriceMaterials: TFramePriceMaterial;
    FramePriceMechanizms: TFramePriceMechanizm;
    FramePriceTransportations: TFramePriceTransportations;
    FramePriceDumps: TFramePriceDumps;

  end;

var
  FormPricesReferenceData: TFormPricesReferenceData;

implementation

uses Main, Waiting;

{$R *.dfm}

procedure TFormPricesReferenceData.WMSysCommand(var Msg: TMessage);
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
    ShowWindow(FormPricesReferenceData.Handle, SW_HIDE); // Скрываем панель свёрнутой формы
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFormPricesReferenceData.Create(AOwner: TComponent; const vDataBase: Char;
  const vPriceColumn: Boolean);
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
  Caption := FormNamePricesReferenceData;

  // ----------------------------------------

  FramePriceMaterials := TFramePriceMaterial.Create(Self, vDataBase, vPriceColumn, False, False);
  FramePriceMaterials.Parent := Self;
  FramePriceMaterials.align := alClient;
  FramePriceMaterials.Visible := True;

  FramePriceMechanizms := TFramePriceMechanizm.Create(Self, vDataBase, vPriceColumn, False);
  FramePriceMechanizms.Parent := Self;
  FramePriceMechanizms.align := alClient;
  FramePriceMechanizms.Visible := False;

  FramePriceTransportations := TFramePriceTransportations.Create(Self);
  FramePriceTransportations.Parent := Self;
  FramePriceTransportations.align := alClient;
  FramePriceTransportations.Visible := False;

  FramePriceDumps := TFramePriceDumps.Create(Self);
  FramePriceDumps.Parent := Self;
  FramePriceDumps.align := alClient;
  FramePriceDumps.Visible := False;

  FormWaiting.Show;
  Application.ProcessMessages;

  FramePriceMaterials.ReceivingAll;
  FramePriceMechanizms.ReceivingAll;
  FramePriceTransportations.ReceivingAll;
  FramePriceDumps.ReceivingAll;

  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;

  // ----------------------------------------

  FormMain.CreateButtonOpenWindow(CaptionButtonPricesReferenceData, HintButtonPricesReferenceData,
    FormMain.ShowPricesReferenceData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesReferenceData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesReferenceData.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(CaptionButtonPricesReferenceData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesReferenceData.FormDestroy(Sender: TObject);
begin
  FormPricesReferenceData := nil;

  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButtonPricesReferenceData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesReferenceData.HideAllFrames;
begin
  FramePriceMaterials.Visible := False;
  FramePriceMechanizms.Visible := False;
  FramePriceTransportations.Visible := False;
  FramePriceDumps.Visible := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesReferenceData.SpeedButtonMaterialsClick(Sender: TObject);
begin
  HideAllFrames;

  with FramePriceMaterials do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesReferenceData.SpeedButtonMechanizmsClick(Sender: TObject);
begin
  HideAllFrames;

  with FramePriceMechanizms do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesReferenceData.SpeedButtonPriceTransportationClick(Sender: TObject);
begin
  HideAllFrames;

  with FramePriceTransportations do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesReferenceData.SpeedButtonPriceDumpsClick(Sender: TObject);
begin
  HideAllFrames;

  with FramePriceDumps do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
