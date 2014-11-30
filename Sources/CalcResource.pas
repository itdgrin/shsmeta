unit CalcResource;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Menus, Vcl.Samples.Spin, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Tools;

type
  TfCalcResource = class(TForm)
    pnlTop: TPanel;
    lbl1: TLabel;
    dblkcbbNAME: TDBLookupComboBox;
    dsObject: TDataSource;
    qrObject: TFDQuery;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    ts3: TTabSheet;
    ts4: TTabSheet;
    ts5: TTabSheet;
    lbl2: TLabel;
    lbl5: TLabel;
    pnlMatTop: TPanel;
    lbl6: TLabel;
    cbbFromMonth: TComboBox;
    seFromYear: TSpinEdit;
    chk1: TCheckBox;
    edtMatCodeFilter: TEdit;
    edtMatNameFilter: TEdit;
    pmMat: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    cbbMatNDS: TComboBox;
    pnlMatClient: TPanel;
    pnlMatFooter: TPanel;
    grMaterial: TJvDBGrid;
    pnlMatBott: TPanel;
    grMaterialBott: TJvDBGrid;
    dbmmoNAME: TDBMemo;
    spl1: TSplitter;
    spl2: TSplitter;
    qrMaterialData: TFDQuery;
    dsMaterialData: TDataSource;
    pnlMechClient: TPanel;
    pnl2: TPanel;
    grMech: TJvDBGrid;
    pnlMechBott: TPanel;
    spl3: TSplitter;
    grMechBott: TJvDBGrid;
    dbmmoNAME1: TDBMemo;
    spl4: TSplitter;
    pnlMechTop: TPanel;
    lbl3: TLabel;
    cbb1: TComboBox;
    se1: TSpinEdit;
    chk2: TCheckBox;
    edtMechCodeFilter: TEdit;
    edtMechNameFilter: TEdit;
    cbbMechNDS: TComboBox;
    pmMech: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    qrMechData: TFDQuery;
    dsMechData: TDataSource;
    spl5: TSplitter;
    pnl1: TPanel;
    lbl4: TLabel;
    cbb2: TComboBox;
    se2: TSpinEdit;
    chk3: TCheckBox;
    edt1: TEdit;
    edt2: TEdit;
    cbb3: TComboBox;
    pnl3: TPanel;
    pnl4: TPanel;
    JvDBGrid1: TJvDBGrid;
    pnl5: TPanel;
    spl6: TSplitter;
    JvDBGrid2: TJvDBGrid;
    dbmmoNAME2: TDBMemo;
    pmDevice: TPopupMenu;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    qrDevices: TFDQuery;
    dsDevices: TDataSource;
    qrMaterialDataID_ESTIMATE: TLongWordField;
    qrMaterialDataID_TYPE_DATA: TLongWordField;
    qrMaterialDataID_TABLES: TLongWordField;
    qrMaterialDataOBJ_ID: TLongWordField;
    qrMaterialDataCODE: TStringField;
    qrMaterialDataNAME: TStringField;
    qrMaterialDataUNIT: TStringField;
    qrMaterialDataCNT: TFMTBCDField;
    qrMaterialDataDOC_DATE: TDateField;
    qrMaterialDataDOC_NUM: TStringField;
    qrMaterialDataPROC_TRANSP: TFloatField;
    qrMaterialDataCOAST: TLargeintField;
    qrMaterialDataPRICE: TLargeintField;
    qrMaterialDataTRANSP: TLargeintField;
    qrMaterialDataCOAST_NDS: TLargeintField;
    qrMaterialDataCOAST_NO_NDS: TLargeintField;
    qrMaterialDataPRICE_NDS: TLargeintField;
    qrMaterialDataPRICE_NO_NDS: TLargeintField;
    qrMaterialDataTRANSP_NDS: TLargeintField;
    qrMaterialDataTRANSP_NO_NDS: TLargeintField;
    qrMechDataID_ESTIMATE: TLongWordField;
    qrMechDataID_TYPE_DATA: TLongWordField;
    qrMechDataID_TABLES: TLongWordField;
    qrMechDataOBJ_ID: TLongWordField;
    qrMechDataCODE: TStringField;
    qrMechDataNAME: TStringField;
    qrMechDataUNIT: TStringField;
    qrMechDataCNT: TFMTBCDField;
    qrMechDataDOC_DATE: TDateField;
    qrMechDataDOC_NUM: TStringField;
    qrMechDataCOAST: TLargeintField;
    qrMechDataPRICE: TLargeintField;
    qrMechDataCOAST_NDS: TLargeintField;
    qrMechDataCOAST_NO_NDS: TLargeintField;
    qrMechDataPRICE_NDS: TLargeintField;
    qrMechDataPRICE_NO_NDS: TLargeintField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure pgc1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtMatCodeFilterChange(Sender: TObject);
    procedure edtMatCodeFilterClick(Sender: TObject);
    procedure cbbMatNDSChange(Sender: TObject);
    procedure edtMechCodeFilterChange(Sender: TObject);
    procedure cbbMechNDSChange(Sender: TObject);
  private
  public
    procedure LocateObject(Object_ID: Integer);
  end;

var
  fCalcResource: TfCalcResource;

implementation

{$R *.dfm}

uses Main;

procedure TfCalcResource.cbbMatNDSChange(Sender: TObject);
begin
  qrMaterialData.ParamByName('NDS').AsInteger := cbbMatNDS.ItemIndex;
  CloseOpen(qrMaterialData);
end;

procedure TfCalcResource.cbbMechNDSChange(Sender: TObject);
begin
  qrMechData.ParamByName('NDS').AsInteger := cbbMechNDS.ItemIndex;
  CloseOpen(qrMechData);
end;

procedure TfCalcResource.edtMechCodeFilterChange(Sender: TObject);
begin
  qrMechData.Filtered := False;
  qrMechData.Filter := 'Upper(CODE) LIKE ''%' + AnsiUpperCase(edtMechCodeFilter.Text) +
    '%'' AND Upper(NAME) LIKE ''%' + AnsiUpperCase(edtMechNameFilter.Text) + '%''';
  // + ' AND NDS=' + IntToStr(cbbMechNDS.ItemIndex); //возможно, неверное решение с НДС
  qrMechData.Filtered := True;
end;

procedure TfCalcResource.edtMatCodeFilterChange(Sender: TObject);
begin
  qrMaterialData.Filtered := False;
  qrMaterialData.Filter := 'Upper(CODE) LIKE ''%' + AnsiUpperCase(edtMatCodeFilter.Text) +
    '%'' AND Upper(NAME) LIKE ''%' + AnsiUpperCase(edtMatNameFilter.Text) + '%''';
  // + ' AND NDS=' + IntToStr(cbbMatNDS.ItemIndex); //возможно, неверное решение с НДС
  qrMaterialData.Filtered := True;
end;

procedure TfCalcResource.edtMatCodeFilterClick(Sender: TObject);
begin
  (Sender as TEdit).SelectAll;
end;

procedure TfCalcResource.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfCalcResource.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCalcResource.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(Caption, Caption, FormMain.N2Click);
  CloseOpen(qrObject);
  LoadDBGridSettings(grMaterial);
  LoadDBGridSettings(grMaterialBott);
  LoadDBGridSettings(grMech);
  LoadDBGridSettings(grMechBott);
  LoadDBGridSettings(JvDBGrid1);
  LoadDBGridSettings(JvDBGrid2);
  // LoadDBGridsSettings(fCalcResource);
end;

procedure TfCalcResource.FormDestroy(Sender: TObject);
begin
  fCalcResource := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

procedure TfCalcResource.LocateObject(Object_ID: Integer);
begin
  dblkcbbNAME.KeyValue := Object_ID;
  pgc1.ActivePageIndex := 0;
end;

procedure TfCalcResource.pgc1Change(Sender: TObject);
begin
  case pgc1.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1:
      CloseOpen(qrMaterialData);
    // Расчет механизмов
    2:
      CloseOpen(qrMechData);
    // Расчет оборудования
    3:
      CloseOpen(qrDevices);
    // Расчет з\п
    4:
      ;
  end;
end;

end.
