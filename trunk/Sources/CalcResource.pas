unit CalcResource;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Menus, Vcl.Samples.Spin, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Tools, Vcl.Mask;

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
    pnlMatTop: TPanel;
    lbl6: TLabel;
    cbbFromMonth: TComboBox;
    seFromYear: TSpinEdit;
    chk1: TCheckBox;
    edtMatCodeFilter: TEdit;
    edtMatNameFilter: TEdit;
    pm: TPopupMenu;
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
    qrDevices: TFDQuery;
    dsDevices: TDataSource;
    pnl6: TPanel;
    pnl7: TPanel;
    JvDBGrid3: TJvDBGrid;
    qrRates: TFDQuery;
    dsRates: TDataSource;
    lbl5: TLabel;
    lbl7: TLabel;
    dbedt1: TDBEdit;
    dbedt2: TDBEdit;
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
  // + ' AND NDS=' + IntToStr(cbbMechNDS.ItemIndex); //��������, �������� ������� � ���
  qrMechData.Filtered := True;
end;

procedure TfCalcResource.edtMatCodeFilterChange(Sender: TObject);
begin
  qrMaterialData.Filtered := False;
  qrMaterialData.Filter := 'Upper(CODE) LIKE ''%' + AnsiUpperCase(edtMatCodeFilter.Text) +
    '%'' AND Upper(NAME) LIKE ''%' + AnsiUpperCase(edtMatNameFilter.Text) + '%''';
  // + ' AND NDS=' + IntToStr(cbbMatNDS.ItemIndex); //��������, �������� ������� � ���
  qrMaterialData.Filtered := True;
end;

procedure TfCalcResource.edtMatCodeFilterClick(Sender: TObject);
begin
  (Sender as TEdit).SelectAll;
end;

procedure TfCalcResource.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;
  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfCalcResource.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCalcResource.FormCreate(Sender: TObject);
begin
  // ������ ������ �� ����� ���� (�� ������� ����� �����)
 // FormMain.CreateButtonOpenWindow(Caption, Caption, FormMain.N2Click);
 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
  // ������� ������ �� ����� ���� (�� ������� ����� �����)
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
    // ������ ���������
    0:
      ;
    // ������ ����������
    1:
      CloseOpen(qrMaterialData);
    // ������ ����������
    2:
      CloseOpen(qrMechData);
    // ������ ������������
    3:
      CloseOpen(qrDevices);
    // ������ �\�
    4:
      CloseOpen(qrRates);
  end;
end;

end.
