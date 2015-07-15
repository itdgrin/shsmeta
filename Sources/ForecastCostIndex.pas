unit ForecastCostIndex;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Samples.Spin,
  System.DateUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid;

type
  TfForecastCostIndex = class(TForm)
    pnlTop: TPanel;
    seYear: TSpinEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    dblkcbbDocument: TDBLookupComboBox;
    qrDocument: TFDQuery;
    dsDocument: TDataSource;
    qrMain: TFDQuery;
    dsMain: TDataSource;
    pnlMain: TPanel;
    grMain: TJvDBGrid;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure seYearChange(Sender: TObject);
    procedure qrMainBeforeOpen(DataSet: TDataSet);
    procedure qrMainAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fForecastCostIndex: TfForecastCostIndex;

implementation

uses DataModule, Main, Tools;

{$R *.dfm}

procedure TfForecastCostIndex.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfForecastCostIndex.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfForecastCostIndex.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(Caption, Caption, Self, 1);
  seYear.Value := YearOf(Now);
  LoadDBGridSettings(grMain);
  dblkcbbDocument.KeyValue := 0;
  CloseOpen(qrDocument);
end;

procedure TfForecastCostIndex.FormDestroy(Sender: TObject);
begin
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
  fForecastCostIndex := nil;
end;

procedure TfForecastCostIndex.qrMainAfterOpen(DataSet: TDataSet);
begin
  grMain.Visible := not qrMain.IsEmpty;
end;

procedure TfForecastCostIndex.qrMainBeforeOpen(DataSet: TDataSet);
begin
  qrMain.ParamByName('YEAR').Value := seYear.Value;
  qrMain.ParamByName('DOC').Value := dblkcbbDocument.KeyValue;
end;

procedure TfForecastCostIndex.seYearChange(Sender: TObject);
begin
  CloseOpen(qrMain);
end;

end.
