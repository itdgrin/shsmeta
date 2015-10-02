unit fFrameEquipment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fFrameSpr, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, JvExControls, JvAnimatedImage, JvGIFCtrl,
  Vcl.Buttons, GlobsAndConst, Vcl.Menus;

type
  TSprEquipment = class(TSprFrame)
    procedure ListSprDblClick(Sender: TObject);
  private
    { Private declarations }
    FAllowAddition: Boolean;
  protected
     function GetSprType: Integer; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      const vAllowAddition: Boolean; ABaseType: Byte = 0); reintroduce;
  end;

implementation

{$R *.dfm}

uses CalculationEstimate, SprController;

constructor TSprEquipment.Create(AOwner: TComponent;
      const vAllowAddition: Boolean; ABaseType: Byte);
var y, m: Integer;
begin
  FAllowAddition := vAllowAddition;
  //FNoEdCol := True;
  y := G_CURYEAR;
  m := G_CURMONTH;
  inherited Create(AOwner, False, Date, ABaseType);

  G_CURYEAR := y;
  G_CURMONTH := m;
end;

function TSprEquipment.GetSprType: Integer;
begin
  Result := CDevIndex;
end;

procedure TSprEquipment.ListSprDblClick(Sender: TObject);
begin
  inherited;
  if FAllowAddition and (ListSpr.ItemIndex > -1) then
    FormCalculationEstimate.AddDevice(
      TSprRecord(ListSpr.Items[ListSpr.ItemIndex].Data^).ID);
end;

end.
