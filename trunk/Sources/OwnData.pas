unit OwnData;

interface

uses
  Windows, Messages, Classes, Controls, Forms, Buttons, ExtCtrls;

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
    procedure FormPaint(Sender: TObject);

    procedure HideAllFrames;

    procedure SpeedButtonRatesClick(Sender: TObject);
    procedure SpeedButtonMaterialsClick(Sender: TObject);
    procedure SpeedButtonMechanizmsClick(Sender: TObject);
    procedure SpeedButtonEquipmentsClick(Sender: TObject);

  protected
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  end;

  // ����� ������
  TThreadQuery = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  FormOwnData: TFormOwnData;

implementation

uses Main, Waiting, fFrameRates, fFramePriceMaterials, fFramePriceMechanizms, fFrameEquipments;

{$R *.dfm}

var
  FrameRates: TFrameRates;
  FramePriceMaterials: TFramePriceMaterial;
  FramePriceMechanisms: TFramePriceMechanizm;
  FrameEquipments: TFrameEquipment;

  // ---------------------------------------------------------------------------------------------------------------------

  // ��������� ���������� ������
procedure TThreadQuery.Execute;
begin
  FormWaiting.Show;

  FrameRates.ReceivingAll;
  FramePriceMaterials.ReceivingAll;
  FramePriceMechanisms.ReceivingAll;
  FrameEquipments.ReceivingAll;

  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.WMSysCommand(var Msg: TMessage);
begin
  // SC_MAXIMIZE - �������������� ����� �� ���� �����
  // SC_RESTORE - ������������ ����� � ����
  // SC_MINIMIZE - ������������ ����� � ��������� ������

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
    ShowWindow(FormOwnData.Handle, SW_HIDE); // �������� ������ �������� �����
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFormOwnData.Create(AOwner: TComponent; const vDataBase: Char; const vPriceColumn: Boolean);
var
  Thread: TThreadQuery;
begin
  inherited Create(AOwner);

  // ----------------------------------------

  FormMain.PanelCover.Visible := True; // ���������� ������ �� ������� �����

  // ----------------------------------------

  // ��������� �������� � ��������� �����

  ClientWidth := FormMain.ClientWidth;
  ClientHeight := FormMain.ClientHeight;
  Top := (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNameOwnData;

  // ----------------------------------------

  FrameRates := TFrameRates.Create(Self, vDataBase, False);
  FramePriceMaterials := TFramePriceMaterial.Create(Self, vDataBase, vPriceColumn, False, False);
  FramePriceMechanisms := TFramePriceMechanizm.Create(Self, vDataBase, vPriceColumn, False);
  FrameEquipments := TFrameEquipment.Create(FormOwnData, vDataBase, False);

  Thread := TThreadQuery.Create(False); // C����� ��������� ������
  Thread.Priority := tpHighest;
  Thread.Resume;

  // ----------------------------------------

  FormMain.CreateButtonOpenWindow(CaptionButtonOwnData, HintButtonOwnData, FormMain.ShowOwnData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  FrameRates.Destroy;
  FramePriceMaterials.Destroy;
  FramePriceMechanisms.Destroy;
  FrameEquipments.Destroy;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������ �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButtonOwnData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.FormDestroy(Sender: TObject);
begin
  FormOwnData := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButtonOwnData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormOwnData.FormPaint(Sender: TObject);
begin
  with FrameRates do
    if Parent = nil then
    begin
      Parent := FormOwnData;
      Align := alClient;
      Visible := True;
    end;

  with FramePriceMaterials do
    if Parent = nil then
    begin
      Parent := FormOwnData;
      Align := alClient;
      Visible := False;
    end;

  with FramePriceMechanisms do
    if Parent = nil then
    begin
      Parent := FormOwnData;
      Align := alClient;
      Visible := False;
    end;

  with FrameEquipments do
    if Parent = nil then
    begin
      Parent := FormOwnData;
      Align := alClient;
      Visible := False;
    end;
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
