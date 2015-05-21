unit CalcResource;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Menus, Vcl.Samples.Spin, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.Mask, JvDBGridFooter,
  JvComponentBase, JvFormPlacement;

type
  TfCalcResource = class(TForm)
    pnlTop: TPanel;
    lbl1: TLabel;
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
    grMaterial: TJvDBGrid;
    pnlMatBott: TPanel;
    grMaterialBott: TJvDBGrid;
    dbmmoNAME: TDBMemo;
    spl1: TSplitter;
    spl2: TSplitter;
    qrMaterialData: TFDQuery;
    dsMaterialData: TDataSource;
    pnlMechClient: TPanel;
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
    grDev: TJvDBGrid;
    pnl5: TPanel;
    spl6: TSplitter;
    grDevBott: TJvDBGrid;
    dbmmoNAME2: TDBMemo;
    qrDevices: TFDQuery;
    dsDevices: TDataSource;
    pnl6: TPanel;
    pnl7: TPanel;
    grRates: TJvDBGrid;
    qrRates: TFDQuery;
    dsRates: TDataSource;
    lbl5: TLabel;
    lbl7: TLabel;
    dbedt2: TDBEdit;
    JvDBGridFooter1: TJvDBGridFooter;
    JvDBGridFooter2: TJvDBGridFooter;
    JvDBGridFooter3: TJvDBGridFooter;
    JvDBGridFooter4: TJvDBGridFooter;
    cbb4: TComboBox;
    chkEdit: TCheckBox;
    edtEstimateName: TEdit;
    FormStorage: TJvFormStorage;
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
    procedure qrMaterialDataAfterOpen(DataSet: TDataSet);
    procedure JvDBGridFooter1Calculate(Sender: TJvDBGridFooter; const FieldName: string;
      var CalcValue: Variant);
    procedure qrMaterialDataAfterScroll(DataSet: TDataSet);
    procedure qrMechDataAfterScroll(DataSet: TDataSet);
    procedure qrDevicesAfterScroll(DataSet: TDataSet);
    procedure qrRatesAfterScroll(DataSet: TDataSet);
    procedure chkEditClick(Sender: TObject);
    procedure qrMaterialDataBeforeOpen(DataSet: TDataSet);
  private
    Footer: Variant;
    IDEstimate: Integer;
    procedure CalcFooter;
  public
  end;

var
  fCalcResource: TfCalcResource;

procedure ShowCalcResource(const ID_ESTIMATE: Variant);

implementation

{$R *.dfm}

uses Main, Tools;

procedure ShowCalcResource(const ID_ESTIMATE: Variant);
begin
  if VarIsNull(ID_ESTIMATE) then
    Exit;
  if (not Assigned(fCalcResource)) then
    fCalcResource := TfCalcResource.Create(nil);
  fCalcResource.IDEstimate := ID_ESTIMATE;
  fCalcResource.edtEstimateName.Text :=
    FastSelectSQLOne('SELECT CONCAT(SM_NUMBER, " ",  NAME) FROM smetasourcedata WHERE SM_ID=:SM_ID',
    VarArrayOf([ID_ESTIMATE]));
  fCalcResource.pgc1.ActivePageIndex := 0;
  fCalcResource.Show;
end;

procedure TfCalcResource.CalcFooter;
begin
  // � ����������� �� �������
  case pgc1.ActivePageIndex of
    // ������ ���������
    0:
      ;
    // ������ ����������
    1:
      begin
        Footer := CalcFooterSumm(qrMaterialData);
      end;
    // ������ ����������
    2:
      begin
        Footer := CalcFooterSumm(qrMechData);
      end;
    // ������ ������������
    3:
      begin
        Footer := CalcFooterSumm(qrDevices);
      end;
    // ������ �\�
    4:
      begin
        Footer := CalcFooterSumm(qrRates);
      end;
  end;
end;

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

procedure TfCalcResource.chkEditClick(Sender: TObject);
begin
  grMaterial.ReadOnly := not chkEdit.Checked;
  grMech.ReadOnly := not chkEdit.Checked;
  grDev.ReadOnly := not chkEdit.Checked;
  grRates.ReadOnly := not chkEdit.Checked;
end;

procedure TfCalcResource.edtMechCodeFilterChange(Sender: TObject);
begin
  qrMechData.Filtered := False;
  qrMechData.Filter := 'Upper(CODE) LIKE ''%' + AnsiUpperCase(edtMechCodeFilter.Text) +
    '%'' AND Upper(NAME) LIKE ''%' + AnsiUpperCase(edtMechNameFilter.Text) + '%''';
  // + ' AND NDS=' + IntToStr(cbbMechNDS.ItemIndex); //��������, �������� ������� � ���
  qrMechData.Filtered := True;
  CalcFooter;
end;

procedure TfCalcResource.edtMatCodeFilterChange(Sender: TObject);
begin
  qrMaterialData.Filtered := False;
  qrMaterialData.Filter := 'Upper(CODE) LIKE ''%' + AnsiUpperCase(edtMatCodeFilter.Text) +
    '%'' AND Upper(NAME) LIKE ''%' + AnsiUpperCase(edtMatNameFilter.Text) + '%''';
  // + ' AND NDS=' + IntToStr(cbbMatNDS.ItemIndex); //��������, �������� ������� � ���
  qrMaterialData.Filtered := True;
  CalcFooter;
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
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  LoadDBGridSettings(grMaterial);
  LoadDBGridSettings(grMaterialBott);
  LoadDBGridSettings(grMech);
  LoadDBGridSettings(grMechBott);
  LoadDBGridSettings(grDev);
  LoadDBGridSettings(grDevBott);
  LoadDBGridSettings(grRates);
end;

procedure TfCalcResource.FormDestroy(Sender: TObject);
begin
  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(Caption);
  fCalcResource := nil;
end;

procedure TfCalcResource.JvDBGridFooter1Calculate(Sender: TJvDBGridFooter; const FieldName: string;
  var CalcValue: Variant);
begin
  if not CheckQrActiveEmpty(Sender.DataSource.DataSet) then
    Exit;

  CalcValue := Footer[Sender.DataSource.DataSet.FieldByName(FieldName).Index];
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

procedure TfCalcResource.qrDevicesAfterScroll(DataSet: TDataSet);
begin
  cbb2.ItemIndex := DataSet.FieldByName('MONTH').AsInteger - 1;
  se2.Value := DataSet.FieldByName('YEAR').AsInteger;
end;

procedure TfCalcResource.qrMaterialDataAfterOpen(DataSet: TDataSet);
begin
  CalcFooter;
end;

procedure TfCalcResource.qrMaterialDataAfterScroll(DataSet: TDataSet);
begin
  //cbbFromMonth.ItemIndex := DataSet.FieldByName('MONTH').AsInteger - 1;
  //seFromYear.Value := DataSet.FieldByName('YEAR').AsInteger;
end;

procedure TfCalcResource.qrMaterialDataBeforeOpen(DataSet: TDataSet);
begin
  (DataSet as TFDQuery).ParamByName('SM_ID').AsInteger := IDEstimate;
end;

procedure TfCalcResource.qrMechDataAfterScroll(DataSet: TDataSet);
begin
  cbb1.ItemIndex := DataSet.FieldByName('MONTH').AsInteger - 1;
  se1.Value := DataSet.FieldByName('YEAR').AsInteger;
end;

procedure TfCalcResource.qrRatesAfterScroll(DataSet: TDataSet);
begin
  cbb4.ItemIndex := DataSet.FieldByName('MONTH').AsInteger - 1;
  // := DataSet.FieldByName('YEAR').AsInteger;
end;

end.
