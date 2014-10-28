unit Materials;

interface

uses
  Windows, Messages, Classes, Controls, Forms, ExtCtrls, fFramePriceMaterials;

type
  TFormMaterials = class(TForm)

    constructor Create(AOwner: TComponent; const vDataBase: Char;
      const vPriceColumn, vAllowAddition, vAllowReplacement: Boolean); overload;

    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

  private
    AllowReplacement: Boolean; // ���������/��������� �������� ��������� ��������� �� ������

    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  public
    FramePriceMaterials: TFramePriceMaterial;

  end;

var
  FormMaterials: TFormMaterials;

implementation

uses Main, Waiting, CalculationEstimate;

{$R *.dfm}

procedure TFormMaterials.WMSysCommand(var Msg: TMessage);
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
    inherited;
    ShowWindow(Self.Handle, SW_HIDE); // �������� ������ �������� �����
  end
  else
    inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFormMaterials.Create(AOwner: TComponent; const vDataBase: Char;
  const vPriceColumn, vAllowAddition, vAllowReplacement: Boolean);
begin
  inherited Create(AOwner);

  // ----------------------------------------

  FormMain.PanelCover.Visible := True; // ���������� ������ �� ������� �����

  // ----------------------------------------

  // ��������� �������� � ��������� �����

  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10; // (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := 10; // GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNameReplacementMaterials;

  // ----------------------------------------

  AllowReplacement := vAllowReplacement;

  FramePriceMaterials := TFramePriceMaterial.Create(Self, vDataBase, vPriceColumn, vAllowAddition, vAllowReplacement);
  FramePriceMaterials.Parent := Self;
  FramePriceMaterials.Align := alClient;
  FramePriceMaterials.Visible := true;

  FormWaiting.Show;
  Application.ProcessMessages;

  FramePriceMaterials.ReceivingAll;

  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;
  // ----------------------------------------

  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(CaptionButtonReplacementMaterials, HintButtonReplacementMaterials,
    FormMain.ShowMaterials);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormMaterials.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButtonReplacementMaterials);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormMaterials.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  if AllowReplacement then
  begin
    FormMain.PanelCover.Visible := True;
    FormCalculationEstimate.WindowState := wsMaximized;
    FormMain.PanelCover.Visible := False;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormMaterials.FormDestroy(Sender: TObject);
begin
  FormMaterials := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButtonReplacementMaterials);
end;

end.
