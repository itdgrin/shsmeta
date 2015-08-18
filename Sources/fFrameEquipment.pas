unit fFrameEquipment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fFrameSpr, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, JvExControls, JvAnimatedImage, JvGIFCtrl,
  Vcl.Buttons, GlobsAndConst;

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
      const vAllowAddition: Boolean); reintroduce;
  end;

implementation

{$R *.dfm}

uses CalculationEstimate, SprController;

constructor TSprEquipment.Create(AOwner: TComponent;
      const vAllowAddition: Boolean);
begin
  FAllowAddition := vAllowAddition;
  FNoEdCol := True;
  inherited Create(AOwner, False, Date);
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
