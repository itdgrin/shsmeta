unit TariffDict;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfTariffDict = class(TForm)
    pgc: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    pnlBott: TPanel;
    btnClose: TBitBtn;
    pnlLeft: TPanel;
    pnlClient: TPanel;
    spl1: TSplitter;
    JvDBGrid1: TJvDBGrid;
    JvDBGrid2: TJvDBGrid;
    pnlTop: TPanel;
    lbl1: TLabel;
    dbedtInDate: TDBEdit;
    lbl2: TLabel;
    dbedtSTAVKA_M_RAB: TDBEdit;
    qrCategory: TFDQuery;
    dsCategory: TDataSource;
    qrStavka: TFDQuery;
    dsStavka: TDataSource;
    qrStavkaSTAVKA_ID: TWordField;
    qrStavkaYEAR: TWordField;
    qrStavkaMONAT: TWordField;
    qrStavkaSTAVKA_RB_RAB: TIntegerField;
    qrStavkaSTAVKA_RB_MACH: TIntegerField;
    qrStavkaSTAVKA_M_RAB: TIntegerField;
    qrStavkaSTAVKA_M_MACH: TIntegerField;
    qrStavkaMONTH_YEAR: TDateField;
    pnl1: TPanel;
    pnl2: TPanel;
    JvDBGrid3: TJvDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure pgcChange(Sender: TObject);
    procedure qrStavkaAfterScroll(DataSet: TDataSet);
    procedure JvDBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fTariffDict: TfTariffDict;

implementation

{$R *.dfm}

uses Tools, Main;

procedure TfTariffDict.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfTariffDict.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfTariffDict.FormCreate(Sender: TObject);
begin
  LoadDBGridSettings(JvDBGrid1);
  LoadDBGridSettings(JvDBGrid2);
  pgc.ActivePageIndex := 0;
  pgcChange(Sender);
end;

procedure TfTariffDict.FormDestroy(Sender: TObject);
begin
  fTariffDict := nil;
end;

procedure TfTariffDict.JvDBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  (Sender AS TDBGrid).Canvas.Brush.Color := PS.BackgroundRows;
  (Sender AS TDBGrid).Canvas.Font.Color := PS.FontRows;
  if gdFocused in State then
  begin
    (Sender AS TDBGrid).Canvas.Brush.Color := PS.BackgroundSelectCell;
    (Sender AS TDBGrid).Canvas.Font.Color := PS.FontSelectCell;
  end;
  (Sender AS TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfTariffDict.pgcChange(Sender: TObject);
begin
  case pgc.ActivePageIndex of
    // Тарифы по зарплате
    0:
      begin
        CloseOpen(qrStavka);
        qrCategory.ParamByName('IN_STAVKA').AsFloat := qrStavkaSTAVKA_M_RAB.Value;
        qrCategory.ParamByName('IN_DATE').AsDate := qrStavkaMONTH_YEAR.Value;
        CloseOpen(qrCategory);
      end;
    // Статистические индексы
    1:
      begin

      end;
  end;
end;

procedure TfTariffDict.qrStavkaAfterScroll(DataSet: TDataSet);
begin
  qrCategory.ParamByName('IN_STAVKA').AsFloat := qrStavkaSTAVKA_M_RAB.Value;
  qrCategory.ParamByName('IN_DATE').AsDate := qrStavkaMONTH_YEAR.Value;
  CloseOpen(qrCategory);
end;

end.
