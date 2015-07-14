unit TreeEstimate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, JvExComCtrls, JvDBTreeView,
  JvComponentBase, JvFormPlacement;

type
  TfTreeEstimate = class(TForm)
    qrTreeEstimates: TFDQuery;
    dsTreeEstimates: TDataSource;
    tvEstimates: TJvDBTreeView;
    FormStorage: TJvFormStorage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure tvEstimatesClick(Sender: TObject);
    procedure tvEstimatesDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fTreeEstimate: TfTreeEstimate;

implementation

uses Main, CalculationEstimate, DataModule;

{$R *.dfm}

procedure TfTreeEstimate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfTreeEstimate.FormDestroy(Sender: TObject);
begin
  fTreeEstimate := nil;
end;

procedure TfTreeEstimate.tvEstimatesClick(Sender: TObject);
begin
  if Assigned(FormCalculationEstimate) then
    FormCalculationEstimate.qrRatesEx.Locate('SM_ID', qrTreeEstimates.FieldByName('SM_ID').AsInteger, []);
end;

procedure TfTreeEstimate.tvEstimatesDblClick(Sender: TObject);
begin
  FormCalculationEstimate.EditNameEstimate.Text := qrTreeEstimates.FieldByName('NAME').AsString;
  FormCalculationEstimate.IdEstimate := qrTreeEstimates.FieldByName('SM_ID').AsInteger;
  // —оздание временных таблиц
  FormCalculationEstimate.CreateTempTables;
  // «аполнен€ временных таблиц, заполнение формы
  FormCalculationEstimate.OpenAllData;
  FormCalculationEstimate.frSummaryCalculations.LoadData
    (VarArrayOf([FormCalculationEstimate.IdEstimate, FormCalculationEstimate.IdAct]));
  // Close;
end;

end.
