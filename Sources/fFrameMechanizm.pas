unit fFrameMechanizm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fFrameSpr, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, JvExControls, JvAnimatedImage, JvGIFCtrl,
  Vcl.Buttons, GlobsAndConst;

type
  TSprMechanizm = class(TSprFrame)
    procedure ListSprDblClick(Sender: TObject);
  private
    { Private declarations }
  private
    { Private declarations }
    FAllowAddition: Boolean;
  protected
    function GetSprSQL: string; override;
    function CheckFindCode(AFindCode: string): string; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      const APriceColumn, vAllowAddition: Boolean;
      const AStarDate: TDateTime); reintroduce;
  end;

implementation

{$R *.dfm}

uses CalculationEstimate;

constructor TSprMechanizm.Create(AOwner: TComponent;
      const APriceColumn, vAllowAddition: Boolean;
      const AStarDate: TDateTime);
begin
  FAllowAddition := vAllowAddition;
  inherited Create(AOwner, APriceColumn, AStarDate);
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

function TSprMechanizm.GetSprSQL: string;
begin
  if FPriceColumn then
    Result := 'SELECT mechanizm.mechanizm_id as "Id", mech_code as "Code", ' +
          'cast(mech_name as char(1024)) as "Name", unit_name as "Unit", ' +
          'coast1 as "PriceVAT", coast2 as "PriceNotVAT" ' +
          'FROM mechanizm left join units on (mechanizm.unit_id = units.unit_id) ' +
          'left join mechanizmcoastg mc on ' +
          '(mechanizm.mechanizm_id = mc.mechanizm_id) and ' +
          '(year=' + IntToStr(edtYear.Value) + ') and (monat=' +
          IntToStr(cmbMonth.ItemIndex + 1) + ') ORDER BY mech_code;'
  else
    Result := 'SELECT mechanizm.mechanizm_id as "Id", mech_code as "Code", ' +
          'cast(mech_name as char(1024)) as "Name", unit_name as "Unit" ' +
          'FROM mechanizm left join units on mechanizm.unit_id = units.unit_id ' +
          'ORDER BY mech_code;';
end;

procedure TSprMechanizm.ListSprDblClick(Sender: TObject);
begin
  inherited;
  if FAllowAddition and (ListSpr.ItemIndex > -1) then
    FormCalculationEstimate.AddMechanizm(
      TSprRecord(ListSpr.Items[ListSpr.ItemIndex].Data^).ID);
end;

end.
