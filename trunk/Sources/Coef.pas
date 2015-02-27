unit Coef;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons;

type
  TfCoefficients = class(TForm)
    qrCoef: TFDQuery;
    dsCoef: TDataSource;
    grCoef: TJvDBGrid;
    pnl1: TPanel;
    btnClose: TButton;
    dbnvgr1: TDBNavigator;
    btnAdd: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCoefficients: TfCoefficients;

implementation

{$R *.dfm}

uses Main, Tools, CalculationEstimate;

procedure TfCoefficients.btnAddClick(Sender: TObject);
begin
  if FormCalculationEstimate.GetCountCoef = 5 then
  begin
    MessageBox(0, PChar('Уже добавлено 5 наборов коэффициентов!' + sLineBreak + sLineBreak +
      'Добавление больше 5 наборов невозможно.'), 'Смета', MB_ICONINFORMATION + MB_OK + mb_TaskModal);
    Close;
  end
  else
    FormCalculationEstimate.AddCoefToRate(qrCoef.FieldByName('coef_id').AsInteger);
end;

procedure TfCoefficients.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfCoefficients.FormCreate(Sender: TObject);
begin
  CloseOpen(qrCoef);
  LoadDBGridSettings(grCoef);
end;

procedure TfCoefficients.FormShow(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;
end;

end.
