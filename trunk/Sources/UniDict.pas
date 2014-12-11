unit UniDict;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, Tools, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Samples.Spin, System.DateUtils,
  Vcl.Mask;

type
  TfUniDict = class(TForm)
    JvDBGrid1: TJvDBGrid;
    pnl1: TPanel;
    btn1: TBitBtn;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btn4: TBitBtn;
    btn5: TBitBtn;
    btn6: TBitBtn;
    qrUniDict: TFDQuery;
    dsUniDict: TDataSource;
    dbmmoparam_description: TDBMemo;
    se2: TSpinEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    dbedtcode: TDBEdit;
    lbl3: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure se2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fUniDict: TfUniDict;

implementation

{$R *.dfm}

uses Main;

procedure TfUniDict.btn6Click(Sender: TObject);
begin
  Close;
end;

procedure TfUniDict.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfUniDict.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfUniDict.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(Caption, Caption, FormMain.N8Click);
  LoadDBGridSettings(JvDBGrid1);
  se2.Value := YearOf(Now);
  se2Change(Sender);
end;

procedure TfUniDict.FormDestroy(Sender: TObject);
begin
  fUniDict := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

procedure TfUniDict.se2Change(Sender: TObject);
begin
  qrUniDict.ParamByName('year').AsInteger := se2.Value;
  CloseOpen(qrUniDict);
end;

end.
