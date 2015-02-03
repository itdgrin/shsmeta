unit OwnData;

interface

uses
  Windows, Messages, Classes, Controls, Forms, Buttons, ExtCtrls, fFrameRates,
  fFramePriceMaterials, fFramePriceMechanizms, fFrameEquipments, fFrameSmeta;

type
  TFormOwnData = class(TForm)

    PanelOwnData: TPanel;

    SpeedButtonMaterials: TSpeedButton;
    SpeedButtonMechanisms: TSpeedButton;
    SpeedButtonEquipments: TSpeedButton;
    SpeedButtonRates: TSpeedButton;

    constructor Create(AOwner: TComponent; const vDataBase: Char; const vPriceColumn: Boolean); reintroduce;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure HideAllFrames;

    procedure SpeedButtonClick(Sender: TObject);

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
  FrameRates.Parent := Self;
  FrameRates.Align := alClient;
  FrameRates.Visible := False;
  SpeedButtonRates.Tag := Integer(FrameRates);

  FramePriceMaterials := TFramePriceMaterial.Create(Self, vDataBase, vPriceColumn, False, False);
  FramePriceMaterials.Parent := Self;
  FramePriceMaterials.Align := alClient;
  FramePriceMaterials.Visible := False;
  SpeedButtonMaterials.Tag := Integer(FramePriceMaterials);

  FramePriceMechanisms := TFramePriceMechanizm.Create(Self, vDataBase, vPriceColumn, False);
  FramePriceMechanisms.Parent := Self;
  FramePriceMechanisms.Align := alClient;
  FramePriceMechanisms.Visible := False;
  SpeedButtonMechanisms.Tag := Integer(FramePriceMechanisms);

  FrameEquipments := TFrameEquipment.Create(Self, vDataBase, False);
  FrameEquipments.Parent := Self;
  FrameEquipments.Align := alClient;
  FrameEquipments.Visible := False;
  SpeedButtonEquipments.Tag := Integer(FrameEquipments);

  SpeedButtonClick(SpeedButtonRates);
  FrameRates.Visible := True;
  FormMain.PanelCover.Visible := False;

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

procedure TFormOwnData.HideAllFrames;
begin
  FrameRates.Visible := False;
  FramePriceMaterials.Visible := False;
  FramePriceMechanisms.Visible := False;
  FrameEquipments.Visible := False;
end;

procedure TFormOwnData.SpeedButtonClick(Sender: TObject);
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

end.
