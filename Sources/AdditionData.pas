unit AdditionData;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ExtCtrls, Buttons, StdCtrls,
  SysUtils, fFrameRates, Main, Waiting, fFramePriceMaterials,
  fFramePriceMechanizms, fFrameEquipments, CalculationEstimate, fFrameSmeta,
  fFrameMaterial;

type
  TFormAdditionData = class(TForm)

    PanelTopMenu: TPanel;

    SpeedButtonRates: TSpeedButton;
    SpeedButtonMaterial: TSpeedButton;
    SpeedButtonMechanizm: TSpeedButton;
    SpeedButtonEquipment: TSpeedButton;

    constructor Create(AOwner: TComponent; const vDataBase: Char); reintroduce;

    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

    procedure HideAllFrames;
    procedure SpeedButtonClick(Sender: TObject);
  private
    const CaptionButton = 'Добавление данных';
    const HintButton = 'Окно добавления данных';
  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
  public
    FrameRates: TFrameRates;
    FramePriceMaterial: TSprMaterial;
    FramePriceMechanizm: TFramePriceMechanizm;
    FrameEquipment: TFrameEquipment;
   // procedure AfterConstruction; override;
  end;

var
  FormAdditionData: TFormAdditionData;

implementation

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------
//procedure TFormAdditionData.AfterConstruction;
//begin
//  Exclude(FFormState, fsVisible);
//  inherited;
//end;

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
var TmpDate: TDateTime;
begin
  inherited Create(AOwner);

  // Настройка размеров и положения формы
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10; // (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := 10; // GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNameAdditionData;

  if Assigned(FormCalculationEstimate) then
    TmpDate := EncodeDate(FormCalculationEstimate.GetYear,
      FormCalculationEstimate.GetMonth, 1)
  else
    TmpDate := Date;

  // ----------------------------------------

  FrameRates := TFrameRates.Create(Self, vDataBase, True);
  FrameRates.Parent := Self;
  FrameRates.Align := alClient;
  FrameRates.Visible := False;
  SpeedButtonRates.Tag := Integer(FrameRates);

  FramePriceMaterial := TSprMaterial.Create(Self, True, False, TmpDate);
  FramePriceMaterial.Parent := Self;
  FramePriceMaterial.LoadSpr;
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

  //FormWaiting.Show;
  Application.ProcessMessages;
  try
    SpeedButtonClick(SpeedButtonRates);
  finally
 //   FormWaiting.Close;
  end;
  FrameRates.Visible := True;

//  FormMain.PanelCover.Visible := False;
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(CaptionButton, HintButton, Self);
end;

procedure TFormAdditionData.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(CaptionButton);
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
  FormMain.DeleteButtonCloseWindow(CaptionButton);
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
  if not Assigned(Pointer((Sender as TComponent).Tag)) then exit;

  if TObject((Sender as TComponent).Tag) is TSmetaFrame then
    with TSmetaFrame((Sender as TComponent).Tag) do
    begin
      if not Loaded then
      begin
      //  FormWaiting.Show;
      //  Application.ProcessMessages;
      //  try
          ReceivingAll;
      //  finally
      //    FormWaiting.Close;
      //  end;
      end;
    end;

  HideAllFrames;

  if (Self as TWinControl).Visible then
  begin
    TWinControl((Sender as TComponent).Tag).Visible := True;
    TWinControl((Sender as TComponent).Tag).SetFocus;
  end;

end;
// ---------------------------------------------------------------------------------------------------------------------

end.
