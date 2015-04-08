unit OXROPRSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, Vcl.ExtCtrls;

type
  TfOXROPRSetup = class(TForm)
    grONormaivs: TJvDBGrid;
    qrONormativs: TFDQuery;
    dsONormativs: TDataSource;
    qrWorkList: TFDQuery;
    dsWorkList: TDataSource;
    pnl1: TPanel;
    dbnvgr1: TDBNavigator;
    qrONormativsID: TFDAutoIncField;
    qrONormativsINTERVAL_ID: TLongWordField;
    strngfldONormativsS: TStringField;
    strngfldONormativsPO: TStringField;
    qrONormativsDATE_BEG: TDateField;
    qrONormativsDATE_END: TDateField;
    qrONormativsWORK_ID: TWordField;
    strngfldONormativsWorkLooK: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fOXROPRSetup: TfOXROPRSetup;

implementation

uses Tools;

{$R *.dfm}

procedure TfOXROPRSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfOXROPRSetup.FormCreate(Sender: TObject);
begin
  LoadDBGridSettings(grONormaivs);
  CloseOpen(qrWorkList);
  CloseOpen(qrONormativs);
end;

procedure TfOXROPRSetup.FormDestroy(Sender: TObject);
begin
  fOXROPRSetup := nil;
end;

end.
