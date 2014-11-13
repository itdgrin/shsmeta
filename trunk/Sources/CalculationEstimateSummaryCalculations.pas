unit CalculationEstimateSummaryCalculations;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids;

type
  TfrCalculationEstimateSummaryCalculations = class(TFrame)
    dbgrdButtonSummaryCalculation: TDBGrid;
  private
    { Private declarations }
  public
    function LoadData(const Args: Variant): Boolean;
  end;

implementation

{$R *.dfm}
{ TfrCalculationEstimateSummaryCalculations }

function TfrCalculationEstimateSummaryCalculations.LoadData(const Args: Variant): Boolean;
begin
  Result := True;
  try

  except
    Result := False;
  end;
end;

end.
