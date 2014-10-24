unit AdditionData;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ExtCtrls, Buttons, StdCtrls, SysUtils, fFrameRates,
  Main, Waiting, fFramePriceMaterials, fFramePriceMechanizms, fFrameEquipments, CalculationEstimate;

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
    procedure FormPaint(Sender: TObject);

    procedure HideAllFrames;

    procedure SpeedButtonRatesClick(Sender: TObject);
    procedure SpeedButtonMaterialClick(Sender: TObject);
    procedure SpeedButtonMechanizmClick(Sender: TObject);
    procedure SpeedButtonEquipmentClick(Sender: TObject);

  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  public
    FrameRates: TFrameRates;
    FramePriceMaterial: TFramePriceMaterial;
    FramePriceMechanizm: TFramePriceMechanizm;
    FrameEquipment: TFrameEquipment;
  end;

  // Класс потока
  TThreadQuery = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  FormAdditionData: TFormAdditionData;

implementation

{$R *.dfm}
{ R
  var

  FramePriceMaterial: TFramePriceMaterial;
  FramePriceMechanizm: TFramePriceMechanizm;
  FrameEquipment: TFrameEquipment;
}

// Процедура выполнения потока
procedure TThreadQuery.Execute;
begin
  FormWaiting.Show;
  // R FormAdditionData*
  FormAdditionData.FrameRates.ReceivingAll;
  FormAdditionData.FramePriceMaterial.ReceivingAll;
  FormAdditionData.FramePriceMechanizm.ReceivingAll;
  FormAdditionData.FrameEquipment.ReceivingAll;

  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;
end;

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
var
  Thread: TThreadQuery;
begin
  // Открываем окно ожидания
  FormWaiting.Show;
  Application.ProcessMessages;
  // R inherited Create(AOwner);
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

  FrameRates := TFrameRates.Create(FormAdditionData, vDataBase, True);
  FramePriceMaterial := TFramePriceMaterial.Create(FormAdditionData, vDataBase, True, True, False);
  FramePriceMechanizm := TFramePriceMechanizm.Create(FormAdditionData, vDataBase, True, True);
  FrameEquipment := TFrameEquipment.Create(FormAdditionData, vDataBase, True);

  FrameRates.ReceivingAll;
  Application.ProcessMessages;
  // FramePriceMaterial.ReceivingAll;  //Опитимизировать загрузку
  // Application.ProcessMessages;
  FramePriceMechanizm.ReceivingAll;
  Application.ProcessMessages;
  FrameEquipment.ReceivingAll;
  Application.ProcessMessages;

  FormMain.PanelCover.Visible := False;

  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(CaptionButtonAdditionData, HintButtonAdditionData,
    FormMain.ShowAdditionData);
  // Закрываем окно ожидания
  FormWaiting.Close;
  Application.ProcessMessages;
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

  FrameRates.Destroy;
  FramePriceMaterial.Destroy;
  FramePriceMechanizm.Destroy;
  FrameEquipment.Destroy;

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

procedure TFormAdditionData.FormPaint(Sender: TObject);
begin
  with FramePriceMaterial do
    if Parent = nil then
    begin
      Parent := FormAdditionData;
      Align := alClient;
      Visible := False;
    end;

  with FramePriceMechanizm do
    if Parent = nil then
    begin
      Parent := FormAdditionData;
      Align := alClient;
      Visible := False;
    end;

  with FrameEquipment do
    if Parent = nil then
    begin
      Parent := FormAdditionData;
      Align := alClient;
      Visible := False;
    end;

  with FrameRates do
    if Parent = nil then
    begin
      Parent := FormAdditionData;
      Align := alClient;
      Visible := True;

      SetFocus;
      VST.SetFocus;
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormAdditionData.HideAllFrames;
begin
  FrameRates.Visible := False;
  FramePriceMaterial.Visible := False;
  FramePriceMechanizm.Visible := False;
  FrameEquipment.Visible := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormAdditionData.SpeedButtonRatesClick(Sender: TObject);
begin
  HideAllFrames;
  FrameRates.Visible := True;
  FrameRates.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormAdditionData.SpeedButtonMaterialClick(Sender: TObject);
begin
  HideAllFrames;
  FramePriceMaterial.ReceivingAll;
  FramePriceMaterial.Visible := True;
  FramePriceMaterial.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormAdditionData.SpeedButtonMechanizmClick(Sender: TObject);
begin
  HideAllFrames;
  FramePriceMechanizm.Visible := True;
  FramePriceMechanizm.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormAdditionData.SpeedButtonEquipmentClick(Sender: TObject);
begin
  HideAllFrames;
  FrameEquipment.Visible := True;
  FrameEquipment.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
