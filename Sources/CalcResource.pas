unit CalcResource;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Menus, Vcl.Samples.Spin, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.Mask, JvDBGridFooter,
  JvComponentBase, JvFormPlacement, System.UITypes;

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
    qrEstimate: TFDQuery;
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
    procedure mDeteteClick(Sender: TObject);
    procedure mRestoreClick(Sender: TObject);
    procedure grMaterialDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
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

uses Main, Tools, ReplacementMatAndMech, CalculationEstimate;

procedure ShowCalcResource(const ID_ESTIMATE: Variant);
begin
  if VarIsNull(ID_ESTIMATE) then
    Exit;
  if (not Assigned(fCalcResource)) then
    fCalcResource := TfCalcResource.Create(nil);
  fCalcResource.IDEstimate := ID_ESTIMATE;
  fCalcResource.qrEstimate.ParamByName('SM_ID').Value := ID_ESTIMATE;
  fCalcResource.qrEstimate.Active := True;
  fCalcResource.cbbFromMonth.ItemIndex := fCalcResource.qrEstimate.FieldByName('MONTH').AsInteger - 1;
  fCalcResource.edtEstimateName.Text := fCalcResource.qrEstimate.FieldByName('NAME').AsString;
  fCalcResource.seFromYear.Value := fCalcResource.qrEstimate.FieldByName('YEAR').AsInteger;
  fCalcResource.cbbNDS.ItemIndex := fCalcResource.qrEstimate.FieldByName('NDS').AsInteger;
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
    (Field = grMaterial.Columns[7].Field) or (Field = grMaterial.Columns[10].Field) or
    (Field = grMaterial.Columns[11].Field) or (Field = grMaterial.Columns[12].Field) or
    (Field = grMaterial.Columns[13].Field) then
  begin
    Result := True;
    Exit;
  end;
end;

procedure TfCalcResource.chkEditClick(Sender: TObject);
begin
  {
    cbbNDS.Enabled := chkEdit.Checked;
    seFromYear.Enabled := chkEdit.Checked;
    seFromYear.ReadOnly := not chkEdit.Checked;
    cbbFromMonth.Enabled := chkEdit.Checked;
  }
  if not chkEdit.Checked then
    Caption := 'Расчет стоимости ресурсов [редактирование запрещено]'
  else
    Caption := 'Расчет стоимости ресурсов [редактирование разрешено]';
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

procedure TfCalcResource.grMaterialDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  if qrMaterialData.FieldByName('DELETED').AsInteger = 1 then
    grMaterial.Canvas.Font.Style := grMaterial.Canvas.Font.Style + [fsStrikeOut];
  grMaterial.Canvas.FillRect(Rect);
  grMaterial.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Column.Field.AsString);
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

procedure TfCalcResource.mDeteteClick(Sender: TObject);
begin
  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1:
      begin
        if not(qrMaterialData.State in [dsEdit]) then
          qrMaterialData.Edit;
        qrMaterialData.FieldByName('DELETED').Value := 1;
      end;
    // Расчет механизмов
    2:
      begin
        if not(qrMechData.State in [dsEdit]) then
          qrMechData.Edit;
        qrMechData.FieldByName('DELETED').Value := 1;
      end;
    // Расчет оборудования
    3:
      begin
        if not(qrDevices.State in [dsEdit]) then
          qrDevices.Edit;
        qrDevices.FieldByName('DELETED').Value := 1;
      end;

    // Расчет з\п
    4:
      begin
        if not(qrRates.State in [dsEdit]) then
          qrRates.Edit;
        qrRates.FieldByName('DELETED').Value := 1;
      end;
  end;
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

procedure TfCalcResource.mRestoreClick(Sender: TObject);
begin
  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1:
      begin
        if not(qrMaterialData.State in [dsEdit]) then
          qrMaterialData.Edit;
        qrMaterialData.FieldByName('DELETED').Value := 0;
      end;
    // Расчет механизмов
    2:
      begin
        if not(qrMechData.State in [dsEdit]) then
          qrMechData.Edit;
        qrMechData.FieldByName('DELETED').Value := 0;
      end;
    // Расчет оборудования
    3:
      begin
        if not(qrDevices.State in [dsEdit]) then
          qrDevices.Edit;
        qrDevices.FieldByName('DELETED').Value := 0;
      end;

    // Расчет з\п
    4:
      begin
        if not(qrRates.State in [dsEdit]) then
          qrRates.Edit;
        qrRates.FieldByName('DELETED').Value := 0;
      end;
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
        CloseOpen(qrMaterialData);
        CloseOpen(qrMaterialDetail);
      end;
    // Расчет механизмов
    2:
      begin
        CloseOpen(qrMechData);
      end;
    // Расчет оборудования
    3:
      begin
        CloseOpen(qrDevices);
      end;
    // Расчет з\п
    4:
      begin
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
  if CheckQrActiveEmpty(DataSet) then
    CalcFooter;
end;

procedure TfCalcResource.qrMaterialDataBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('SM_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('SM_ID').AsInteger := IDEstimate;
  if (DataSet as TFDQuery).FindParam('NDS') <> nil then
    (DataSet as TFDQuery).ParamByName('NDS').AsInteger := cbbNDS.ItemIndex;
  if (DataSet as TFDQuery).FindParam('SHOW_DELETED') <> nil then
    (DataSet as TFDQuery).ParamByName('SHOW_DELETED').Value := mShowDeleted.Checked;
end;

procedure TfCalcResource.qrMaterialDataBeforePost(DataSet: TDataSet);
var
  priceQ: string;
begin
  if Application.MessageBox('Сохранить изменения?', 'Смета', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES
  then
  begin
    with qrMaterialData do
    begin
      FastExecSQL('UPDATE materialcard_temp SET'#13 + 'TRANSP_PROC_PODR=:1, TRANSP_PROC_ZAC=:2,'#13 +
        'MAT_PROC_PODR=:3, MAT_PROC_ZAC=:4, DELETED=:5,'#13 + 'PROC_TRANSP=:7'#13 +
        'WHERE PROC_TRANSP=:9 AND DELETED=:10'#13 + 'AND MAT_PROC_ZAC=:11 AND MAT_PROC_PODR=:12'#13 +
        'AND TRANSP_PROC_ZAC=:13 AND TRANSP_PROC_PODR=:14'#13 +
        'AND IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS))=:15 AND MAT_ID=:16',
        VarArrayOf([FieldByName('TRANSP_PROC_PODR').Value, FieldByName('TRANSP_PROC_ZAC').Value,
        FieldByName('MAT_PROC_PODR').Value, FieldByName('MAT_PROC_ZAC').Value, FieldByName('DELETED').Value,
        FieldByName('PROC_TRANSP').Value, FieldByName('PROC_TRANSP').OldValue,
        FieldByName('DELETED').OldValue, FieldByName('MAT_PROC_ZAC').OldValue,
        FieldByName('MAT_PROC_PODR').OldValue, FieldByName('TRANSP_PROC_ZAC').OldValue,
        FieldByName('TRANSP_PROC_PODR').OldValue, cbbNDS.ItemIndex, FieldByName('COAST').OldValue,
        FieldByName('ID').Value]));

      // Цена
      case cbbNDS.ItemIndex of
        // Если в режиме без НДС
        0:
          priceQ := 'FCOAST_NO_NDS=:1, FCOAST_NDS=FCOAST_NO_NDS+(FCOAST_NO_NDS*NDS/100),'#13;
        // С НДС
        1:
          priceQ := 'FCOAST_NDS=:1, FCOAST_NO_NDS=FCOAST_NDS-(FCOAST_NDS/(100+NDS)*NDS),'#13;
      end;
      if FieldByName('COAST').Value <> FieldByName('COAST').OldValue then
        FastExecSQL('UPDATE materialcard_temp SET'#13 + priceQ + 'WHERE PROC_TRANSP=:4 AND DELETED=:5'#13 +
          'AND MAT_PROC_ZAC=:6 AND MAT_PROC_PODR=:7'#13 + 'AND TRANSP_PROC_ZAC=:8 AND TRANSP_PROC_PODR=:9'#13
          + 'AND IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS))=:10 AND MAT_ID=:11',
          VarArrayOf([FieldByName('COAST').Value, FieldByName('PROC_TRANSP').Value,
          FieldByName('DELETED').Value, FieldByName('MAT_PROC_ZAC').Value, FieldByName('MAT_PROC_PODR').Value,
          FieldByName('TRANSP_PROC_ZAC').Value, FieldByName('TRANSP_PROC_PODR').Value, cbbNDS.ItemIndex,
          FieldByName('COAST').OldValue, FieldByName('ID').Value]));

      // Стоимость транспорта
      if FieldByName('TRANSP').Value <> FieldByName('TRANSP').OldValue then
        FastExecSQL('UPDATE materialcard_temp SET FTRANSP_NO_NDS = :1, FTRANSP_NDS = :2'#13 +
          'WHERE PROC_TRANSP=:4 AND DELETED=:5'#13 + 'AND MAT_PROC_ZAC=:6 AND MAT_PROC_PODR=:7'#13 +
          'AND TRANSP_PROC_ZAC=:8 AND TRANSP_PROC_PODR=:9'#13 +
          'AND IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS))=:10 AND MAT_ID=:11',
          VarArrayOf([FieldByName('TRANSP').Value, FieldByName('TRANSP').Value,
          FieldByName('PROC_TRANSP').Value, FieldByName('DELETED').Value, FieldByName('MAT_PROC_ZAC').Value,
          FieldByName('MAT_PROC_PODR').Value, FieldByName('TRANSP_PROC_ZAC').Value,
          FieldByName('TRANSP_PROC_PODR').Value, cbbNDS.ItemIndex, FieldByName('COAST').Value,
          FieldByName('ID').Value]));
    end;
    // Вызываем переасчет всей сметы
    FormCalculationEstimate.RecalcEstimate;
    CloseOpen(qrMaterialData);
  end
  else
  begin
    qrMaterialData.Cancel;
    Abort;
  end;
end;

end.
