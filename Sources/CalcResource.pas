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
    pgc: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    ts3: TTabSheet;
    ts4: TTabSheet;
    ts5: TTabSheet;
    lbl2: TLabel;
    pnlMatTop: TPanel;
    edtMatCodeFilter: TEdit;
    edtMatNameFilter: TEdit;
    pm: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    mDetete: TMenuItem;
    N4: TMenuItem;
    mRestore: TMenuItem;
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
    edtMechCodeFilter: TEdit;
    edtMechNameFilter: TEdit;
    qrMechData: TFDQuery;
    dsMechData: TDataSource;
    spl5: TSplitter;
    pnlDevTop: TPanel;
    edt1: TEdit;
    edt2: TEdit;
    pnlDevClient: TPanel;
    grDev: TJvDBGrid;
    pnlDevBott: TPanel;
    spl6: TSplitter;
    grDevBott: TJvDBGrid;
    dbmmoNAME2: TDBMemo;
    qrDevices: TFDQuery;
    dsDevices: TDataSource;
    pnlRatesTop: TPanel;
    pnlRatesClient: TPanel;
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
    mShowDeleted: TMenuItem;
    mN7: TMenuItem;
    qrMaterialDetail: TFDQuery;
    dsMaterialDetail: TDataSource;
    mReplace: TMenuItem;
    lbl6: TLabel;
    cbbFromMonth: TComboBox;
    seFromYear: TSpinEdit;
    cbbNDS: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure pgcChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtMatCodeFilterChange(Sender: TObject);
    procedure edtMatCodeFilterClick(Sender: TObject);
    procedure edtMechCodeFilterChange(Sender: TObject);
    procedure qrMaterialDataAfterOpen(DataSet: TDataSet);
    procedure JvDBGridFooter1Calculate(Sender: TJvDBGridFooter; const FieldName: string;
      var CalcValue: Variant);
    procedure qrMaterialDataBeforeOpen(DataSet: TDataSet);
    procedure pmPopup(Sender: TObject);
    procedure mReplaceClick(Sender: TObject);
    procedure grMaterialCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
    procedure qrMaterialDataBeforePost(DataSet: TDataSet);
    procedure grMaterialTitleBtnClick(Sender: TObject; ACol: Integer; Field: TField);
    procedure chkEditClick(Sender: TObject);
  private
    Footer: Variant;
    IDEstimate: Integer;
    procedure CalcFooter;
    function CanEditField(Field: TField): Boolean;
  public
  end;

var
  fCalcResource: TfCalcResource;

procedure ShowCalcResource(const ID_ESTIMATE: Variant);

implementation

{$R *.dfm}

uses Main, Tools, ReplacementMatAndMech;

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
  fCalcResource.pgc.ActivePageIndex := 1;
  fCalcResource.Show;
end;

procedure TfCalcResource.CalcFooter;
begin
  // В зависимости от вкладки
  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1:
      Footer := CalcFooterSumm(qrMaterialData);
    // Расчет механизмов
    2:
      Footer := CalcFooterSumm(qrMechData);
    // Расчет оборудования
    3:
      Footer := CalcFooterSumm(qrDevices);
    // Расчет з\п
    4:
      Footer := CalcFooterSumm(qrRates);
  end;
end;

function TfCalcResource.CanEditField(Field: TField): Boolean;
begin
  Result := False;

  if not chkEdit.Checked then
    Exit;

  if (Field = grMaterial.Columns[4].Field) or (Field = grMaterial.Columns[6].Field) or
    (Field = grMaterial.Columns[10].Field) then
  begin
    Result := True;
    Exit;
  end;
end;

procedure TfCalcResource.chkEditClick(Sender: TObject);
begin
  cbbNDS.Enabled := chkEdit.Checked;
  seFromYear.Enabled := chkEdit.Checked;
  seFromYear.ReadOnly := not chkEdit.Checked;
  cbbFromMonth.Enabled := chkEdit.Checked;
end;

procedure TfCalcResource.edtMechCodeFilterChange(Sender: TObject);
begin
  qrMechData.Filtered := False;
  qrMechData.Filter := 'Upper(CODE) LIKE ''%' + AnsiUpperCase(edtMechCodeFilter.Text) +
    '%'' AND Upper(NAME) LIKE ''%' + AnsiUpperCase(edtMechNameFilter.Text) + '%''';
  // + ' AND NDS=' + IntToStr(cbbMechNDS.ItemIndex); //возможно, неверное решение с НДС
  qrMechData.Filtered := True;
  CalcFooter;
end;

procedure TfCalcResource.edtMatCodeFilterChange(Sender: TObject);
begin
  qrMaterialData.Filtered := False;
  qrMaterialData.Filter := 'Upper(CODE) LIKE ''%' + AnsiUpperCase(edtMatCodeFilter.Text) +
    '%'' AND Upper(NAME) LIKE ''%' + AnsiUpperCase(edtMatNameFilter.Text) + '%''';
  // + ' AND NDS=' + IntToStr(cbbMatNDS.ItemIndex); //возможно, неверное решение с НДС
  qrMaterialData.Filtered := True;
  CalcFooter;
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
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
  fCalcResource := nil;
end;

procedure TfCalcResource.grMaterialCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
begin
  AllowEdit := CanEditField(Field);
end;

procedure TfCalcResource.grMaterialTitleBtnClick(Sender: TObject; ACol: Integer; Field: TField);
var
  s: string;
begin
  if not CheckQrActiveEmpty(qrMaterialData) then
    Exit;
  s := '';
  if grMaterial.SortMarker = smDown then
    s := ' DESC';
  qrMaterialData.SQL[qrMaterialData.SQL.Count - 1] := 'ORDER BY ' + grMaterial.SortedField + s;
  CloseOpen(qrMaterialData);
end;

procedure TfCalcResource.JvDBGridFooter1Calculate(Sender: TJvDBGridFooter; const FieldName: string;
  var CalcValue: Variant);
begin
  if not CheckQrActiveEmpty(Sender.DataSource.DataSet) then
    Exit;

  CalcValue := Footer[Sender.DataSource.DataSet.FieldByName(FieldName).Index];
end;

procedure TfCalcResource.mReplaceClick(Sender: TObject);
var
  frmReplace: TfrmReplacement;
  i: Integer;
begin
  case pgc.ActivePageIndex of
    1:
      frmReplace := TfrmReplacement.Create(0, IDEstimate, 0, 0, qrMaterialData.FieldByName('CODE').AsString,
        0, False);
    2:
      frmReplace := TfrmReplacement.Create(0, IDEstimate, 0, 0, qrMechData.FieldByName('CODE').AsString,
        1, False);
  end;
  if Assigned(frmReplace) then
    try
      if (frmReplace.ShowModal = mrYes) then
      begin
        for i := 0 to frmReplace.Count - 1 do
          FastExecSQL('CALL CalcCalculation(:ESTIMATE_ID, 1, :OWNER_ID, 0);',
            VarArrayOf([frmReplace.EstIDs[i], frmReplace.RateIDs[i]]));

        case pgc.ActivePageIndex of
          1:
            CloseOpen(qrMaterialData);
          2:
            CloseOpen(qrMechData);
        end;
      end;
    finally
      FreeAndNil(frmReplace);
    end;
end;

procedure TfCalcResource.pgcChange(Sender: TObject);
begin
  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1:
      begin
        qrMaterialData.ParamByName('NDS').AsInteger := cbbNDS.ItemIndex;
        qrMaterialData.ParamByName('SHOW_DELETED').Value := mShowDeleted.Checked;
        qrMaterialDetail.ParamByName('SHOW_DELETED').Value := mShowDeleted.Checked;
        CloseOpen(qrMaterialData);
        CloseOpen(qrMaterialDetail);
      end;
    // Расчет механизмов
    2:
      begin
        qrMechData.ParamByName('NDS').AsInteger := cbbNDS.ItemIndex;
        qrMechData.ParamByName('SHOW_DELETED').Value := mShowDeleted.Checked;
        CloseOpen(qrMechData);
      end;
    // Расчет оборудования
    3:
      begin
        qrDevices.ParamByName('SHOW_DELETED').Value := mShowDeleted.Checked;
        CloseOpen(qrDevices);
      end;
    // Расчет з\п
    4:
      begin
        qrRates.ParamByName('SHOW_DELETED').Value := mShowDeleted.Checked;
        CloseOpen(qrRates);
      end;
  end;
end;

procedure TfCalcResource.pmPopup(Sender: TObject);
begin
  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1:
      begin
        mDetete.Visible := qrMaterialData.FieldByName('DELETED').AsInteger = 0;
        mRestore.Visible := qrMaterialData.FieldByName('DELETED').AsInteger = 1;
        mReplace.Visible := True;
      end;
    // Расчет механизмов
    2:
      begin
        mDetete.Visible := qrMechData.FieldByName('DELETED').AsInteger = 0;
        mRestore.Visible := qrMechData.FieldByName('DELETED').AsInteger = 1;
        mReplace.Visible := True;
      end;
    // Расчет оборудования
    3:
      begin
        mDetete.Visible := qrDevices.FieldByName('DELETED').AsInteger = 0;
        mRestore.Visible := qrDevices.FieldByName('DELETED').AsInteger = 1;
        mReplace.Visible := False;
      end;
    // Расчет з\п
    4:
      begin
        mDetete.Visible := qrRates.FieldByName('DELETED').AsInteger = 0;
        mRestore.Visible := qrRates.FieldByName('DELETED').AsInteger = 1;
        mReplace.Visible := False;
      end;
  end;

end;

procedure TfCalcResource.qrMaterialDataAfterOpen(DataSet: TDataSet);
begin
  CalcFooter;
end;

procedure TfCalcResource.qrMaterialDataBeforeOpen(DataSet: TDataSet);
begin
  (DataSet as TFDQuery).ParamByName('SM_ID').AsInteger := IDEstimate;
end;

procedure TfCalcResource.qrMaterialDataBeforePost(DataSet: TDataSet);
begin
  if Application.MessageBox('Произвести замену?', 'Смета', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES
  then
  begin
    FastExecSQL('UPDATE materialcard_temp SET FCOAST_NO_NDS = :0,'#13 +
      'FCOAST_NDS = (FCOAST_NO_NDS*NDS/100),'#13 + 'PROC_TRANSP = :1,'#13 +
      'FPRICE_NO_NDS=FCOAST_NO_NDS*MAT_COUNT,'#13 + 'FPRICE_NDS=FCOAST_NDS*MAT_COUNT'#13 +
      'WHERE MAT_CODE=:2', VarArrayOf([qrMaterialData.FieldByName('COAST').Value,
      qrMaterialData.FieldByName('PROC_TRANSP').Value, qrMaterialData.FieldByName('CODE').Value]));
    // CloseOpen(qrMaterialData);
  end
  else
  begin
    DataSet.Cancel;
    Abort;
  end;
end;

end.
