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
    ShowWindow(FormPricesReferenceData.Handle, SW_HIDE); // �������� ������ �������� �����
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

  FormMain.PanelCover.Visible := True; // ���������� ������ �� ������� �����

  // ----------------------------------------

  // ��������� �������� � ��������� �����

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
  // ���� ������ ������� Ctrl � �������� �����, �� ������ �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButtonPricesReferenceData);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPricesReferenceData.FormDestroy(Sender: TObject);
begin
  FormPricesReferenceData := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
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
