unit TariffDict;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Samples.Spin,
  System.DateUtils;

type
  TfTariffDict = class(TForm)
    pgc: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    pnlLeft: TPanel;
    pnlClient: TPanel;
    spl1: TSplitter;
    grCategory: TJvDBGrid;
    grStavka: TJvDBGrid;
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
    pnlTop1: TPanel;
    pnlClient1: TPanel;
    grIndexes: TJvDBGrid;
    qrIndexes: TFDQuery;
    lbl3: TLabel;
    seYear: TSpinEdit;
    cbbFromMonth: TComboBox;
    dsIndexes: TDataSource;
    qrStavkaMONTH_YEAR2: TDateField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pgcChange(Sender: TObject);
    procedure qrStavkaAfterScroll(DataSet: TDataSet);
    procedure grStavkaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure seYearChange(Sender: TObject);
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

procedure TfTariffDict.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfTariffDict.FormCreate(Sender: TObject);
begin
  LoadDBGridSettings(grCategory);
  LoadDBGridSettings(grStavka);
  LoadDBGridSettings(grIndexes);

  seYear.Value := YearOf(Now);
  cbbFromMonth.ItemIndex := MonthOf(Now) - 1;

  pgc.ActivePageIndex := 0;
  pgcChange(Sender);
end;

procedure TfTariffDict.FormDestroy(Sender: TObject);
begin
  fTariffDict := nil;
end;

procedure TfTariffDict.grStavkaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
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
    // ������ �� ��������
    0:
      begin
        CloseOpen(qrStavka);
        qrCategory.ParamByName('IN_STAVKA').AsFloat := qrStavkaSTAVKA_M_RAB.Value;
        qrCategory.ParamByName('IN_DATE').AsDate := qrStavkaMONTH_YEAR.Value;
        CloseOpen(qrCategory);
      end;
    // �������������� �������
    1:
      begin
        seYearChange(Sender);
      end;
  end;
end;

procedure TfTariffDict.qrStavkaAfterScroll(DataSet: TDataSet);
begin
  qrCategory.ParamByName('IN_STAVKA').AsFloat := qrStavkaSTAVKA_M_RAB.Value;
  qrCategory.ParamByName('IN_DATE').AsDate := qrStavkaMONTH_YEAR.Value;
  CloseOpen(qrCategory);
end;

procedure TfTariffDict.seYearChange(Sender: TObject);
begin
  qrIndexes.ParamByName('MONTH').AsInteger := cbbFromMonth.ItemIndex + 1;
  qrIndexes.ParamByName('YEAR').AsInteger := seYear.Value;
  CloseOpen(qrIndexes);
end;

end.
