unit fFrameMechanizm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fFrameSpr, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, JvExControls, JvAnimatedImage, JvGIFCtrl,
  Vcl.Buttons, GlobsAndConst, Data.DB;

type
  TSprMechanizm = class(TSprFrame)
    procedure ListSprDblClick(Sender: TObject);
    procedure ListSprResize(Sender: TObject);
    procedure ListSprCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    FZpColIndex,
    FTrColIndex: Integer;
    { Private declarations }
  private
    { Private declarations }
    FAllowAddition: Boolean;
  protected
    function GetSprType: Integer; override;
    function CheckFindCode(AFindCode: string): string; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      const APriceColumn, vAllowAddition: Boolean;
      const AStarDate: TDateTime; ABaseType: Byte = 0); reintroduce;
  end;

implementation

{$R *.dfm}

uses CalculationEstimate, SprController;

constructor TSprMechanizm.Create(AOwner: TComponent;
      const APriceColumn, vAllowAddition: Boolean;
      const AStarDate: TDateTime; ABaseType: Byte);
var lc: TListColumn;
begin
  FAllowAddition := vAllowAddition;
 // FNoEdCol := False;
  inherited Create(AOwner, APriceColumn, AStarDate, ABaseType);
  if APriceColumn then
  begin
    lc := ListSpr.Columns.Add;
    lc.Caption := 'ЗП машиниста, руб';
    FZpColIndex := lc.Index;
  end;
  lc := ListSpr.Columns.Add;
  lc.Caption := 'Затр. труда, чел.ч.';
  FTrColIndex := lc.Index;
end;

function TSprMechanizm.CheckFindCode(AFindCode: string): string;
begin
  if AFindCode.Length > 0 then
  begin
    AFindCode := UpperCase(AFindCode);
    if (AFindCode[1] = 'M') or (AFindCode[1] = 'V') then // латинская
      AFindCode[1] := 'М';      //кирилица
  end;
  Result := AFindCode;
end;

function TSprMechanizm.GetSprType: Integer;
begin
  Result := CMechIndex;
end;

procedure TSprMechanizm.ListSprCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  inherited;
  if FPriceColumn then
  begin
    if TSprRecord(Item.Data^).ZpMach > 0 then
      Item.SubItems.Add(FloatToStr(TSprRecord(Item.Data^).ZpMach))
    else Item.SubItems.Add('');
  end;
  if TSprRecord(Item.Data^).TrZatr > 0 then
    Item.SubItems.Add(FloatToStr(TSprRecord(Item.Data^).TrZatr))
  else Item.SubItems.Add('');
end;

procedure TSprMechanizm.ListSprDblClick(Sender: TObject);
begin
  inherited;
  if FAllowAddition and (ListSpr.ItemIndex > -1) then
    FormCalculationEstimate.AddMechanizm(
      TSprRecord(ListSpr.Items[ListSpr.ItemIndex].Data^).ID);
end;

procedure TSprMechanizm.ListSprResize(Sender: TObject);
begin
  inherited;
  if FPriceColumn then
    ListSpr.Columns[FZpColIndex].Width := 120;
  ListSpr.Columns[FTrColIndex].Width := 120;
end;

end.
