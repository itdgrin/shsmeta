unit AdditionData;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ExtCtrls, Buttons, StdCtrls,
  SysUtils, fFrameRates, Main, Waiting, fFramePriceMaterials,
  fFramePriceMechanizms, fFrameEquipments, CalculationEstimate, fFrameSmeta;

type
  TFormAdditionData = class(TForm)

    PanelTopMenu: TPanel;

    SpeedButtonRates: TSpeedButton;
    SpeedButtonMaterial: TSpeedButton;
    SpeedButtonMechanizm: TSpeedButton;
    SpeedButtonEquipment: TSpeedButton;

    constructor Create(AOwner: TComponent; const vDataBase: Char);

    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

    procedure HideAllFrames;
    procedure SpeedButtonClick(Sender: TObject);
  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
  public
    FrameRates: TFrameRates;
    FramePriceMaterial: TFramePriceMaterial;
    FramePriceMechanizm: TFramePriceMechanizm;
    FrameEquipment: TFrameEquipment;
  end;

var
  FormAdditionData: TFormAdditionData;

implementation

{$R *.dfm}

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormAdditionData.WMSysCommand(var Msg: TMessage);
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
    ShowWindow(FormAdditionData.Handle, SW_HIDE); // Скрываем панель свёрнутой формы
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFormAdditionData.Create(AOwner: TComponent; const vDataBase: Char);
begin

  inherited Create(AOwner);

  // ----------------------------------------

  FormMain.PanelCover.Visible := True;

  // Настройка размеров и положения формы
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10; // (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := 10; // GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNameAdditionData;

  // ----------------------------------------

  FrameRates := TFrameRates.Create(Self, vDataBase, True);
  FrameRates.Parent := Self;
  FrameRates.Align := alClient;
  FrameRates.Visible := False;
  SpeedButtonRates.Tag := Integer(FrameRates);

  FramePriceMaterial := TFramePriceMaterial.Create(Self, vDataBase, True, True, False);
  FramePriceMaterial.Parent := Self;
  FramePriceMaterial.Align := alClient;
  FramePriceMaterial.Visible := False;
  SpeedButtonMaterial.Tag := Integer(FramePriceMaterial);

  FramePriceMechanizm := TFramePriceMechanizm.Create(Self, vDataBase, True, True);
  FramePriceMechanizm.Parent := Self;
  FramePriceMechanizm.Align := alClient;
  FramePriceMechanizm.Visible := False;
  SpeedButtonMechanizm.Tag := Integer(FramePriceMechanizm);

  FrameEquipment := TFrameEquipment.Create(Self, vDataBase, True);
  FrameEquipment.Parent := Self;
  FrameEquipment.Align := alClient;
  FrameEquipment.Visible := False;
  SpeedButtonEquipment.Tag := Integer(FrameEquipment);

  FormWaiting.Show;
  Application.ProcessMessages;
  try
    SpeedButtonClick(SpeedButtonRates);
  finally
    FormWaiting.Close;
  end;
  FrameRates.Visible := true;

  FormMain.PanelCover.Visible := False;
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(CaptionButtonAdditionData, HintButtonAdditionData,
    FormMain.ShowAdditionData);
end;

procedure TFormAdditionData.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(CaptionButtonAdditionData);
end;

procedure TFormAdditionData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  FormMain.PanelCover.Visible := True;
  FormCalculationEstimate.WindowState := wsMaximized;
  FormMain.PanelCover.Visible := False;
end;

procedure TFormAdditionData.FormDestroy(Sender: TObject);
begin
  FormAdditionData := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButtonAdditionData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormAdditionData.HideAllFrames;
begin
  FrameRates.Visible := False;
  FramePriceMaterial.Visible := False;
  FramePriceMechanizm.Visible := False;
  FrameEquipment.Visible := False;
end;

procedure TFormAdditionData.SpeedButtonClick(Sender: TObject);
begin

  if not Assigned(TSmetaFrame((Sender as TComponent).Tag)) then exit;

  with TSmetaFrame((Sender as TComponent).Tag) do
  begin
    if not Loaded then
    begin
     // FormWaiting.Show;
     // Application.ProcessMessages;
     // try
        ReceivingAll;
     // finally
     //   FormWaiting.Close;
     // end;
    end;
    HideAllFrames;

    if (Self as TControl).Visible then
    begin
      Visible := True;
      SetFocus;
    end;
  end;
end;
// ---------------------------------------------------------------------------------------------------------------------

end.
