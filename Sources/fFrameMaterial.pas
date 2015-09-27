unit fFrameMaterial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fFrameSpr, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, JvExControls, JvAnimatedImage, JvGIFCtrl,
  Vcl.Buttons, Data.DB, GlobsAndConst;

type
  TSprMaterial = class(TSprFrame)
    lbRegion: TLabel;
    cmbRegion: TComboBox;
    rbMat: TRadioButton;
    rbJBI: TRadioButton;
    procedure ListSprDblClick(Sender: TObject);
    procedure rbMatClick(Sender: TObject);
  private
    { Private declarations }
    FAllowAddition: Boolean;
  protected
    function GetSprType: Integer; override;
    function GetRegion: Integer; override;
    procedure OnLoadStart; override;
    procedure OnLoadDone; override;
    function CheckFindCode(AFindCode: string): string; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      const APriceColumn, vAllowAddition: Boolean;
      const AStarDate: TDateTime;
      const ARegion: Integer;
      const AMat, AJBI: Boolean; ABaseType: Byte = 0); reintroduce;
  end;

implementation

{$R *.dfm}

uses CalculationEstimate, SprController;

constructor TSprMaterial.Create(AOwner: TComponent;
      const APriceColumn, vAllowAddition: Boolean;
      const AStarDate: TDateTime;
      const ARegion: Integer;
      const AMat, AJBI: Boolean; ABaseType: Byte);
begin
  FAllowAddition := vAllowAddition;
  inherited Create(AOwner, APriceColumn, AStarDate, ABaseType);

  if not APriceColumn then
  begin
    lbRegion.Visible := False;
    cmbRegion.Visible := False;
    rbMat.Left := PanelManual.Width + 8;
    rbJBI.Left := rbMat.Left;
  end;

  if (cmbRegion.Items.Count >= ARegion) and (ARegion > 0) then
    cmbRegion.ItemIndex := ARegion - 1;
  if AMat then
    rbMat.Checked := True
  else if AJBI then
    rbJBI.Checked := True;
end;

function TSprMaterial.GetRegion;
begin
  Result := cmbRegion.ItemIndex + 1;
end;

function TSprMaterial.GetSprType: Integer;
begin
  if rbMat.Checked then
    Result := CMatIndex
  else
    Result := CJBIIndex;
end;

function TSprMaterial.CheckFindCode(AFindCode: string): string;
begin
  if AFindCode.Length > 0 then
  begin
    AFindCode := UpperCase(AFindCode);
    if AFindCode[1] = 'C' then  //���������
      AFindCode[1] := '�';      //��������
  end;
  Result := AFindCode;
end;

procedure TSprMaterial.ListSprDblClick(Sender: TObject);
begin
  inherited;
  if FAllowAddition and (ListSpr.ItemIndex > -1) then
    FormCalculationEstimate.AddMaterial(
      TSprRecord(ListSpr.Items[ListSpr.ItemIndex].Data^).ID);
end;

procedure TSprMaterial.OnLoadStart;
begin
  inherited;
  cmbRegion.Enabled := False;
  rbMat.Enabled := False;
  rbJBI.Enabled := False;
end;

procedure TSprMaterial.rbMatClick(Sender: TObject);
begin
  inherited;
  btnShow.Enabled := True;
  ListSpr.Visible := False;
  btnShow.Click;
end;

procedure TSprMaterial.OnLoadDone;
begin
  inherited;
  if FPriceColumn then
    cmbRegion.Enabled := True;

  rbMat.Enabled := True;
  rbJBI.Enabled := True;
end;

end.
