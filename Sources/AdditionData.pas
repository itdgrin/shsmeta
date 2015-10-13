unit AdditionData;

interface

uses
  Windows,
  Messages,
  Classes,
  Controls,
  Forms,
  ExtCtrls,
  Buttons,
  StdCtrls,
  SysUtils,
  fFrameRates,
  Main,
  Waiting,
  fFrameSmeta,
  fFrameMaterial,
  fFrameMechanizm,
  fFrameEquipment;

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
  private const
    CaptionButton = '���������� ������';

  const
    HintButton = '���� ���������� ������';
  private
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
  public
    FrameRates: TFrameRates;
    FramePriceMaterial: TSprMaterial;
    FramePriceMechanizm: TSprMechanizm;
    FrameEquipment: TSprEquipment;
  end;

var
  FormAdditionData: TFormAdditionData;

implementation

uses CalculationEstimate, fFrameSpr;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormAdditionData.WMSysCommand(var Msg: TMessage);
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
    ShowWindow(FormAdditionData.Handle, SW_HIDE); // �������� ������ �������� �����
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFormAdditionData.Create(AOwner: TComponent; const vDataBase: Char);
var
  TmpDate: TDateTime;
begin
  inherited Create(AOwner);

  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10; // (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := 10; // GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNameAdditionData;

  if Assigned(FormCalculationEstimate) then
    TmpDate := EncodeDate(FormCalculationEstimate.YearEstimate, FormCalculationEstimate.MonthEstimate, 1)
  else
    TmpDate := Date;

  // ----------------------------------------

  FrameRates := TFrameRates.Create(Self, vDataBase, True);
  FrameRates.Parent := Self;
  FrameRates.Align := alClient;
  FrameRates.Visible := False;
  SpeedButtonRates.Tag := Integer(FrameRates);

  FramePriceMaterial := TSprMaterial.Create(Self, True, True, TmpDate, FormCalculationEstimate.Region,
    True, False);
  FramePriceMaterial.Parent := Self;
  FramePriceMaterial.LoadSpr;
  FramePriceMaterial.Align := alClient;
  FramePriceMaterial.Visible := False;
  SpeedButtonMaterial.Tag := Integer(FramePriceMaterial);

  FramePriceMechanizm := TSprMechanizm.Create(Self, True, True, TmpDate);
  FramePriceMechanizm.Parent := Self;
  FramePriceMechanizm.LoadSpr;
  FramePriceMechanizm.Align := alClient;
  FramePriceMechanizm.Visible := False;
  SpeedButtonMechanizm.Tag := Integer(FramePriceMechanizm);

  FrameEquipment := TSprEquipment.Create(Self, True, True);
  FrameEquipment.Parent := Self;
  FrameEquipment.LoadSpr;
  FrameEquipment.Align := alClient;
  FrameEquipment.Visible := False;
  SpeedButtonEquipment.Tag := Integer(FrameEquipment);

  // FormWaiting.Show;
  Application.ProcessMessages;
  try
    SpeedButtonClick(SpeedButtonRates);
  finally
    // FormWaiting.Close;
  end;
  FrameRates.Visible := True;

  // FormMain.PanelCover.Visible := False;
  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(CaptionButton, HintButton, Self);
end;

procedure TFormAdditionData.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
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
  // ������� ������ �� ����� ���� (�� ������� ����� �����)
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
  HideAllFrames;

  if not Assigned(Pointer((Sender as TComponent).Tag)) then exit;

  if TObject((Sender as TComponent).Tag) is TSmetaFrame then
    with TSmetaFrame((Sender as TComponent).Tag) do
    begin
      if not Loaded then
      begin
        ReceivingAll;
      end
      else
        CheckCurPeriod;
    end;

  if TObject((Sender as TComponent).Tag) is TSprFrame then
    TSprFrame((Sender as TComponent).Tag).CheckCurPeriod;

  if (Self as TWinControl).Visible then
  begin
    TWinControl((Sender as TComponent).Tag).Visible := True;
    TWinControl((Sender as TComponent).Tag).SetFocus;
  end;

end;
// ---------------------------------------------------------------------------------------------------------------------

end.
