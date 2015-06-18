unit CalculationEstimateSummaryCalculations;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Tools, Vcl.Menus, JvDBGrid, JvExDBGrids, JvComponentBase, JvFormPlacement;

type
  TfrCalculationEstimateSummaryCalculations = class(TFrame)
    dbgrdSummaryCalculation: TJvDBGrid;
    qrData: TFDQuery;
    dsData: TDataSource;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    FormStorage: TJvFormStorage;
    procedure dbgrdSummaryCalculationDblClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private
    SM_ID: Integer;
  public
    function LoadData(const Args: Variant): Boolean;
  end;

implementation

{$R *.dfm}

uses BasicData, CardObject, Main;

procedure TfrCalculationEstimateSummaryCalculations.dbgrdSummaryCalculationDblClick(Sender: TObject);
var
  Key: Variant;
begin
  Key := qrData.FieldByName('SM_ID').Value;
  FormBasicData.ShowForm(qrData.FieldByName('OBJ_ID').AsInteger, qrData.FieldByName('SM_ID').AsInteger);
  LoadData(SM_ID);
  qrData.Locate('SM_ID', Key, []);
end;

procedure TfrCalculationEstimateSummaryCalculations.FrameResize(Sender: TObject);
begin
  // FixDBGridColumnsWidth(dbgrdSummaryCalculation);
end;

function TfrCalculationEstimateSummaryCalculations.LoadData(const Args: Variant): Boolean;
begin
  Result := True;
  try
    LoadDBGridSettings(dbgrdSummaryCalculation);
    qrData.Active := False;
    qrData.ParamByName('SM_ID').Value := Args;
    qrData.Active := True;
    SM_ID := Args;
  except
    Result := False;
  end;
end;

procedure TfrCalculationEstimateSummaryCalculations.N5Click(Sender: TObject);
begin
  FormCardObject.ShowModal;
end;

end.
