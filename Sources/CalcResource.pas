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
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    pnlMatTop: TPanel;
    lbl6: TLabel;
    cbbFromMonth: TComboBox;
    seFromYear: TSpinEdit;
    chk1: TCheckBox;
    edt1: TEdit;
    edt2: TEdit;
    pmMat: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    cbb1: TComboBox;
    pnlMatClient: TPanel;
    pnlMatFooter: TPanel;
    grMaterial: TJvDBGrid;
    pnlMatBott: TPanel;
    grMaterialBott: TJvDBGrid;
    dbmmo1: TDBMemo;
    spl1: TSplitter;
    spl2: TSplitter;
    qrMaterialData: TFDQuery;
    dsMaterialData: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure pgc1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
  public
    procedure LocateObject(Object_ID: Integer);
  end;

var
  fCalcResource: TfCalcResource;

implementation

{$R *.dfm}

uses Main;

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
end;

procedure TfCalcResource.FormDestroy(Sender: TObject);
begin
  fCalcResource := nil;
end;

procedure TfCalcResource.FormResize(Sender: TObject);
begin
  FixDBGridColumnsWidth(grMaterial);
  FixDBGridColumnsWidth(grMaterialBott);
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
      ;
    // Расчет механизмов
    2:
      ;
    // Расчет оборудования
    3:
      ;
    // Расчет з\п
    4:
      ;
  end;
end;

end.
