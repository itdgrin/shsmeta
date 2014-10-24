unit PricesOwnData;

interface

uses
  Windows, Messages, Classes, Controls, Forms, Buttons, ExtCtrls;

type
  TFormPricesOwnData = class(TForm)

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
    procedure FormPaint(Sender: TObject);

    procedure HideAllFrames;

    procedure SpeedButtonMaterialsClick(Sender: TObject);
    procedure SpeedButtonMechanizmsClick(Sender: TObject);
    procedure SpeedButtonPriceTransportationClick(Sender: TObject);
    procedure SpeedButtonPriceDumpsClick(Sender: TObject);

  protected
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  end;

  // ����� ������
  TThreadQuery = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  FormPricesOwnData: TFormPricesOwnData;

implementation

uses Main, Waiting, fFramePriceMaterials, fFramePriceMechanizms, fFramePriceTransportations, fFramePriceDumps;

{$R *.dfm}

var
  FramePriceMaterials: TFramePriceMaterial;
  FramePriceMechanizms: TFramePriceMechanizm;
  FramePriceTransportations: TFramePriceTransportations;
  FramePriceDumps: TFramePriceDumps;

  // ---------------------------------------------------------------------------------------------------------------------

  // ��������� ���������� ������
procedure TThreadQuery.Execute;
begin
  FormWaiting.Show;

  FramePriceMaterials.ReceivingAll;
  FramePriceMechanizms.ReceivingAll;
  FramePriceTransportations.ReceivingAll;
  FramePriceDumps.ReceivingAll;

  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesOwnData.WMSysCommand(var Msg: TMessage);
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
    ShowWindow(FormPricesOwnData.Handle, SW_HIDE); // �������� ������ �������� �����
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFormPricesOwnData.Create(AOwner: TComponent; const vDataBase: Char; const vPriceColumn: Boolean);
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
  Caption := FormNamePricesOwnData;

  // ----------------------------------------

  FramePriceMaterials := TFramePriceMaterial.Create(Self, vDataBase, vPriceColumn, False, False);
  FramePriceMechanizms := TFramePriceMechanizm.Create(Self, vDataBase, vPriceColumn, False);
  FramePriceTransportations := TFramePriceTransportations.Create(FormPricesOwnData);
  FramePriceDumps := TFramePriceDumps.Create(FormPricesOwnData);

  Thread := TThreadQuery.Create(False); // C����� ��������� ������
  Thread.Priority := tpHighest;
  Thread.Resume;

  // ----------------------------------------

  FormMain.CreateButtonOpenWindow(CaptionButtonPricesOwnData, HintButtonPricesOwnData,
    FormMain.ShowPricesOwnData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesOwnData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  FramePriceMaterials.Destroy;
  FramePriceMechanizms.Destroy;
  FramePriceTransportations.Destroy;
  FramePriceDumps.Destroy;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesOwnData.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������ �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButtonPricesOwnData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesOwnData.FormDestroy(Sender: TObject);
begin
  FormPricesOwnData := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButtonPricesOwnData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesOwnData.FormPaint(Sender: TObject);
begin
  with FramePriceMaterials do
    if Parent = nil then
    begin
      Parent := FormPricesOwnData;
      align := alClient;
      Visible := True;
    end;

  with FramePriceMechanizms do
    if Parent = nil then
    begin
      Parent := FormPricesOwnData;
      align := alClient;
      Visible := False;
    end;

  with FramePriceTransportations do
    if Parent = nil then
    begin
      Parent := FormPricesOwnData;
      align := alClient;
      Visible := False;
    end;

  with FramePriceDumps do
    if Parent = nil then
    begin
      Parent := FormPricesOwnData;
      align := alClient;
      Visible := False;
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesOwnData.HideAllFrames;
begin
  FramePriceMaterials.Visible := False;
  FramePriceMechanizms.Visible := False;
  FramePriceTransportations.Visible := False;
  FramePriceDumps.Visible := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesOwnData.SpeedButtonMaterialsClick(Sender: TObject);
begin
  HideAllFrames;

  with FramePriceMaterials do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesOwnData.SpeedButtonMechanizmsClick(Sender: TObject);
begin
  HideAllFrames;

  with FramePriceMechanizms do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesOwnData.SpeedButtonPriceTransportationClick(Sender: TObject);
begin
  HideAllFrames;

  with FramePriceTransportations do
  begin
    Visible := True;
    SetFocus;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesOwnData.SpeedButtonPriceDumpsClick(Sender: TObject);
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
