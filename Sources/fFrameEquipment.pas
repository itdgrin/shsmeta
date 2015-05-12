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
    function GetSprSQL: string; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      const vAllowAddition: Boolean); reintroduce;
  end;

implementation

{$R *.dfm}

uses CalculationEstimate;

constructor TSprEquipment.Create(AOwner: TComponent;
      const vAllowAddition: Boolean);
begin
  FAllowAddition := vAllowAddition;
  inherited Create(AOwner, False, Date);
  PanelSettings.Visible := False;
end;

function TSprEquipment.GetSprSQL: string;
begin
  Result := 'SELECT device_id as "Id", device_code1 as "Code", ' +
    'name as "Name", units.unit_name as "Unit" FROM devices left join units ' +
    'on (devices.unit = units.unit_id) ORDER BY device_code1 ASC';
end;

procedure TSprEquipment.ListSprDblClick(Sender: TObject);
begin
  inherited;
  if FAllowAddition and (ListSpr.ItemIndex > -1) then
    FormCalculationEstimate.AddDevice(
      TSprRecord(ListSpr.Items[ListSpr.ItemIndex].Data^).ID);
end;

end.
