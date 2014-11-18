unit CalculationEstimateSummaryCalculations;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Tools;

type
  TfrCalculationEstimateSummaryCalculations = class(TFrame)
    dbgrdSummaryCalculation: TDBGrid;
    qrData: TFDQuery;
    dsData: TDataSource;
    procedure FrameResize(Sender: TObject);
  private
    OBJECT_ID: Integer;
  public
    function LoadData(const Args: Variant): Boolean;
  end;

implementation

{$R *.dfm}
{ TfrCalculationEstimateSummaryCalculations }

procedure TfrCalculationEstimateSummaryCalculations.FrameResize(Sender: TObject);
begin
  FixDBGridColumnsWidth(dbgrdSummaryCalculation);
end;

function TfrCalculationEstimateSummaryCalculations.LoadData(const Args: Variant): Boolean;
begin
  Result := True;
  try
    LoadDBGridSettings(dbgrdSummaryCalculation);
    qrData.Active := False;
    qrData.ParamByName('OBJ_ID').Value := Args;
    qrData.Active := True;
    OBJECT_ID := Args;
  except
    Result := False;
  end;
end;

end.
