unit CalcTravel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Tools, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfCalcTravel = class(TForm)
    lbl1: TLabel;
    dbedt2: TDBEdit;
    lbl3: TLabel;
    dbedtNAME: TDBEdit;
    lbl4: TLabel;
    btnExit: TBitBtn;
    btnSave: TBitBtn;
    JvDBGrid1: TJvDBGrid;
    dsqrCalcTravel: TDataSource;
    qrCalcTravel: TFDQuery;
    dblkcbbNAME: TDBLookupComboBox;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure qrCalcTravelAfterPost(DataSet: TDataSet);
    procedure JvDBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure dblkcbbNAMEClick(Sender: TObject);
  private
    { Private declarations }
  public
    ID_ACT: Integer;
    ID_TRAVEL: Integer;
  end;

var
  fCalcTravel: TfCalcTravel;

implementation

{$R *.dfm}

uses Main, TravelList;

procedure TfCalcTravel.btnExitClick(Sender: TObject);
begin
  fTravelList.qrTravel.Cancel;
  Close;
end;

procedure TfCalcTravel.btnSaveClick(Sender: TObject);
begin
  fTravelList.qrTravel.Post;
  Close;
end;

procedure TfCalcTravel.dblkcbbNAMEClick(Sender: TObject);
begin
  qrCalcTravel.ParamByName('ID_ACT').Value := dblkcbbNAME.KeyValue;
  CloseOpen(qrCalcTravel);
end;

procedure TfCalcTravel.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfCalcTravel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCalcTravel.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  //FormMain.CreateButtonOpenWindow(Caption, Caption, fTravelList.qrTravelNewRecord(fTravelList.qrTravel));
  LoadDBGridSettings(JvDBGrid1);
  CloseOpen(qrCalcTravel);
end;

procedure TfCalcTravel.FormDestroy(Sender: TObject);
begin
  fCalcTravel := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

procedure TfCalcTravel.JvDBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = VK_RETURN) and (qrCalcTravel.State = dsEdit) then
    qrCalcTravel.Post;
end;

procedure TfCalcTravel.qrCalcTravelAfterPost(DataSet: TDataSet);
begin
  if qrCalcTravel.FieldByName('NUMPP').AsString = '08' then
  begin
    qrCalcTravel.ParamByName('STOIM_KM').AsInteger := qrCalcTravel.FieldByName('CALC').AsInteger;
    CloseOpen(qrCalcTravel);
  end;
  if qrCalcTravel.FieldByName('NUMPP').AsString = '09' then
  begin
    qrCalcTravel.ParamByName('KM').AsInteger := qrCalcTravel.FieldByName('CALC').AsInteger;
    CloseOpen(qrCalcTravel);
  end;
end;

end.
