unit SectionEstimateList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  JvComponentBase, JvFormPlacement, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, System.UITypes;

type
  TfSectionEstimateList = class(TForm)
    qrMain: TFDQuery;
    dsMain: TDataSource;
    FormStorage: TJvFormStorage;
    grMain: TJvDBGrid;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grMainTitleBtnClick(Sender: TObject; ACol: Integer; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSectionEstimateList: TfSectionEstimateList;

implementation

{$R *.dfm}

uses Main, Tools, DataModule;

procedure TfSectionEstimateList.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfSectionEstimateList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfSectionEstimateList.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(Caption, Caption, Self, 1);
  LoadDBGridSettings(grMain);
  CloseOpen(qrMain);
end;

procedure TfSectionEstimateList.FormDestroy(Sender: TObject);
begin
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
  fSectionEstimateList := nil;
end;

procedure TfSectionEstimateList.grMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  with (Sender AS TJvDBGrid).Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    if (gdSelected in State) then // Ячейка в фокусе
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
      Font.Style := Font.Style + [fsBold];
    end;
  end;

  (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfSectionEstimateList.grMainTitleBtnClick(Sender: TObject; ACol: Integer; Field: TField);
var
  s: string;
begin
  if not CheckQrActiveEmpty(qrMain) then
    Exit;
  s := '';
  if grMain.SortMarker = smDown then
    s := ' DESC';
  qrMain.SQL[qrMain.SQL.Count - 1] := 'ORDER BY ' + grMain.SortedField + s;
  CloseOpen(qrMain);
end;

end.
