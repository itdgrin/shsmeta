unit CalcResource;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Menus, Vcl.Samples.Spin, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.Mask, JvDBGridFooter,
  JvComponentBase, JvFormPlacement, System.UITypes, Vcl.Buttons;

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
    lbl7: TLabel;
    dbedt2: TDBEdit;
    JvDBGridFooter1: TJvDBGridFooter;
    JvDBGridFooter2: TJvDBGridFooter;
    JvDBGridFooter3: TJvDBGridFooter;
    JvDBGridFooter4: TJvDBGridFooter;
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
    qrMechDetail: TFDQuery;
    dsMechDetail: TDataSource;
    qrDevicesDetail: TFDQuery;
    dsDevicesDetail: TDataSource;
    dbmmoNAME3: TDBMemo;
    strngfldMaterialDataCODE: TStringField;
    strngfldMaterialDataNAME: TStringField;
    strngfldMaterialDataUNIT: TStringField;
    qrMaterialDataCNT: TFMTBCDField;
    qrMaterialDataDOC_DATE: TDateField;
    strngfldMaterialDataDOC_NUM: TStringField;
    qrMaterialDataPROC_TRANSP: TFMTBCDField;
    qrMaterialDataCOAST: TFMTBCDField;
    qrMaterialDataPRICE: TFMTBCDField;
    qrMaterialDataTRANSP: TFMTBCDField;
    qrMaterialDataDELETED: TByteField;
    qrMaterialDataMAT_PROC_ZAC: TWordField;
    qrMaterialDataMAT_PROC_PODR: TWordField;
    qrMaterialDataTRANSP_PROC_ZAC: TWordField;
    qrMaterialDataTRANSP_PROC_PODR: TWordField;
    qrMaterialDataMAT_ID: TLongWordField;
    strngfldMechDataCODE: TStringField;
    strngfldMechDataNAME: TStringField;
    strngfldMechDataUNIT: TStringField;
    qrMechDataCNT: TFMTBCDField;
    qrMechDataDOC_DATE: TDateField;
    strngfldMechDataDOC_NUM: TStringField;
    qrMechDataCOAST: TFMTBCDField;
    qrMechDataPRICE: TFMTBCDField;
    qrMechDataZP_1: TFMTBCDField;
    qrMechDataZP_2: TFMTBCDField;
    qrMechDataDELETED: TByteField;
    qrMechDataPROC_ZAC: TWordField;
    qrMechDataPROC_PODR: TWordField;
    qrMechDataMECH_ID: TLongWordField;
    strngfldDevicesCODE: TStringField;
    strngfldDevicesNAME: TStringField;
    strngfldDevicesUNIT: TStringField;
    qrDevicesCNT: TFMTBCDField;
    qrDevicesDOC_DATE: TDateField;
    strngfldDevicesDOC_NUM: TStringField;
    qrDevicesCOAST: TFMTBCDField;
    qrDevicesPRICE: TFMTBCDField;
    qrDevicesTRANSP: TFMTBCDField;
    qrDevicesPROC_ZAC: TWordField;
    qrDevicesPROC_PODR: TWordField;
    qrDevicesTRANSP_PROC_ZAC: TWordField;
    qrDevicesTRANSP_PROC_PODR: TWordField;
    qrDevicesDELETED: TLargeintField;
    qrDevicesDEVICE_ID: TLongWordField;
    qrMaterialDataFCOAST: TIntegerField;
    qrMaterialDataREPLACED: TIntegerField;
    qrMechDataREPLACED: TIntegerField;
    qrMaterialDataFREPLACED: TIntegerField;
    qrMechDataFREPLACED: TIntegerField;
    pnlCalculationYesNo: TPanel;
    btnShowDiff: TSpeedButton;
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
    procedure mDeteteClick(Sender: TObject);
    procedure mRestoreClick(Sender: TObject);
    procedure grMaterialDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure grMechDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure qrMechDataBeforePost(DataSet: TDataSet);
    procedure grMechTitleBtnClick(Sender: TObject; ACol: Integer; Field: TField);
    procedure qrDevicesBeforePost(DataSet: TDataSet);
    procedure grDevDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grRatesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure qrMaterialDataMAT_PROC_ZACChange(Sender: TField);
    procedure qrMaterialDataMAT_PROC_PODRChange(Sender: TField);
    procedure qrMaterialDataTRANSP_PROC_ZACChange(Sender: TField);
    procedure qrMaterialDataTRANSP_PROC_PODRChange(Sender: TField);
    procedure grMaterialBottDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure grMechBottDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure qrMechDataPROC_ZACChange(Sender: TField);
    procedure qrMechDataPROC_PODRChange(Sender: TField);
    procedure qrDevicesPROC_ZACChange(Sender: TField);
    procedure qrDevicesPROC_PODRChange(Sender: TField);
    procedure qrDevicesTRANSP_PROC_ZACChange(Sender: TField);
    procedure qrDevicesTRANSP_PROC_PODRChange(Sender: TField);
    procedure qrMaterialDetailBeforePost(DataSet: TDataSet);
    procedure qrMechDetailBeforePost(DataSet: TDataSet);
    procedure qrDevicesDetailBeforePost(DataSet: TDataSet);
    procedure pnlCalculationYesNoClick(Sender: TObject);
    procedure btnShowDiffClick(Sender: TObject);
  private
    Footer: Variant;
    IDEstimate: Integer;
    flLoaded: Boolean;
    procedure CalcFooter;
    function CanEditField(Field: TField): Boolean;
  public
  end;

var
  fCalcResource: TfCalcResource;

procedure ShowCalcResource(const ID_ESTIMATE: Variant; const APage: Integer = 0; AOwner: TWinControl = nil);

implementation

{$R *.dfm}

uses Main, Tools, ReplacementMatAndMech, CalculationEstimate, DataModule, GlobsAndConst;

procedure ShowCalcResource(const ID_ESTIMATE: Variant; const APage: Integer = 0; AOwner: TWinControl = nil);
var
  pageID: Integer;
begin
  if VarIsNull(ID_ESTIMATE) then
    Exit;
  if (not Assigned(fCalcResource)) then
    fCalcResource := TfCalcResource.Create(AOwner);
  fCalcResource.flLoaded := False;
  fCalcResource.IDEstimate := ID_ESTIMATE;
  fCalcResource.qrEstimate.ParamByName('SM_ID').Value := ID_ESTIMATE;
  fCalcResource.qrEstimate.Active := True;
  fCalcResource.cbbFromMonth.ItemIndex := fCalcResource.qrEstimate.FieldByName('MONTH').AsInteger - 1;
  fCalcResource.edtEstimateName.Text := fCalcResource.qrEstimate.FieldByName('NAME').AsString;
  fCalcResource.seFromYear.Value := fCalcResource.qrEstimate.FieldByName('YEAR').AsInteger;
  fCalcResource.cbbNDS.ItemIndex := fCalcResource.qrEstimate.FieldByName('NDS').AsInteger;

  if AOwner <> nil then
  begin
    fCalcResource.BorderStyle := bsNone;
    fCalcResource.Parent := AOwner;
    fCalcResource.Align := alClient;

  end;

  // Если вызвали с доп параметром (на что положить) , то скрываем все вкладки
  for pageID := 0 to fCalcResource.pgc.PageCount - 1 do
    fCalcResource.pgc.Pages[pageID].TabVisible := AOwner = nil;

  //fCalcResource.pnlTop.Visible := AOwner = nil;

  fCalcResource.pgc.ActivePageIndex := APage;

  fCalcResource.Show;
  fCalcResource.flLoaded := True;
  fCalcResource.pgcChange(nil);
end;

procedure TfCalcResource.btnShowDiffClick(Sender: TObject);
begin
  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1:
      begin

      end;
    // Расчет механизмов
    2:
      begin

      end;
    // Расчет оборудования
    3:
      begin

      end;
    // Расчет з\п
    4:
      begin

      end;
  end;
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

  if pnlCalculationYesNo.Tag = 0 then
    Exit;

  if (Field = grMaterial.Columns[4].Field) or (Field = grMaterial.Columns[6].Field) or
    (Field = grMaterial.Columns[7].Field) or (Field = grMaterial.Columns[10].Field) or
    (Field = grMaterial.Columns[11].Field) or (Field = grMaterial.Columns[12].Field) or
    (Field = grMaterial.Columns[13].Field) or (Field = grMech.Columns[4].Field) or
    (Field = grMech.Columns[6].Field) or (Field = grMech.Columns[8].Field) or
    (Field = grMech.Columns[9].Field) or (Field = grMaterialBott.Columns[4].Field) or
    (Field = grMaterialBott.Columns[5].Field) or (Field = grMaterialBott.Columns[6].Field) or
    (Field = grMaterialBott.Columns[7].Field) or (Field = grMaterialBott.Columns[8].Field) or
    (Field = grMaterialBott.Columns[9].Field) or (Field = grMaterialBott.Columns[10].Field) or
    (Field = grMechBott.Columns[4].Field) or (Field = grMechBott.Columns[5].Field) or
    (Field = grMechBott.Columns[6].Field) or (Field = grMechBott.Columns[7].Field) or
    (Field = grDev.Columns[4].Field) or (Field = grDev.Columns[6].Field) or (Field = grDev.Columns[7].Field)
    or (Field = grDev.Columns[8].Field) or (Field = grDev.Columns[9].Field) or
    (Field = grDev.Columns[10].Field) or (Field = grDev.Columns[11].Field) or
    (Field = grDev.Columns[12].Field) or (Field = grDev.Columns[13].Field) or
    (Field = grDevBott.Columns[4].Field) or (Field = grDevBott.Columns[5].Field) or
    (Field = grDevBott.Columns[6].Field) or (Field = grDevBott.Columns[7].Field) or
    (Field = grDevBott.Columns[8].Field) or (Field = grDevBott.Columns[9].Field) then
  begin
    Result := True;
    Exit;
  end;
end;

procedure TfCalcResource.edtMechCodeFilterChange(Sender: TObject);
begin
  qrMechData.Filtered := False;
  qrMechData.Filter := 'Upper(CODE) LIKE ''%' + AnsiUpperCase(edtMechCodeFilter.Text) +
    '%'' AND Upper(NAME) LIKE ''%' + AnsiUpperCase(edtMechNameFilter.Text) + '%''';
  // + ' AND NDS=' + IntToStr(cbbMechNDS.ItemIndex); //возможно, неверное решение с НДС
  qrMechData.Filtered := True;
  // CalcFooter;
end;

procedure TfCalcResource.edtMatCodeFilterChange(Sender: TObject);
begin
  qrMaterialData.Filtered := False;
  qrMaterialData.Filter := 'Upper(CODE) LIKE UPPER(''%' + edtMatCodeFilter.Text +
    '%'') AND Upper(NAME) LIKE UPPER(''%' + edtMatNameFilter.Text + '%'')';
  // + ' AND NDS=' + IntToStr(cbbMatNDS.ItemIndex); //возможно, неверное решение с НДС
  qrMaterialData.Filtered := True;
  // CalcFooter;
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
  FormMain.SelectButtonActiveWindow('Расчет стоимости ресурсов');
end;

procedure TfCalcResource.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCalcResource.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow('Расчет стоимости ресурсов', 'Расчет стоимости ресурсов', Self, 1);
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
  FormMain.DeleteButtonCloseWindow('Расчет стоимости ресурсов');
  fCalcResource := nil;
end;

procedure TfCalcResource.grDevDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  if qrDevices.FieldByName('DELETED').AsInteger = 1 then
    grDev.Canvas.Font.Style := grDev.Canvas.Font.Style + [fsStrikeOut];
  if CanEditField(Column.Field) then
    grDev.Canvas.Brush.Color := clMoneyGreen;
  grDev.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfCalcResource.grMaterialBottDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  if (qrMaterialDetail.FieldByName('FCOAST').AsInteger = 1) and (Column.FieldName = 'COAST') then
    grMaterialBott.Canvas.Font.Style := grMaterialBott.Canvas.Font.Style + [fsItalic];

  if qrMaterialDetail.FieldByName('DELETED').AsInteger = 1 then
    grMaterialBott.Canvas.Font.Style := grMaterialBott.Canvas.Font.Style + [fsStrikeOut];

  if qrMaterialDetail.FieldByName('REPLACED').AsInteger <> 0 then
  begin
    grMaterialBott.Canvas.Font.Style := grMaterial.Canvas.Font.Style + [fsStrikeOut] + [fsItalic];
    grMaterialBott.Canvas.Font.Color := clNavy;
  end;

  if qrMaterialDetail.FieldByName('ID_REPLACED').AsInteger <> 0 then
  begin
    grMaterialBott.Canvas.Font.Style := grMaterial.Canvas.Font.Style + [fsItalic];
    grMaterialBott.Canvas.Font.Color := clNavy;
  end;

  if CanEditField(Column.Field) then
    grMaterialBott.Canvas.Brush.Color := clMoneyGreen;

  grMaterialBott.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfCalcResource.grMaterialCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
begin
  AllowEdit := CanEditField(Field);
end;

procedure TfCalcResource.grMaterialDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  if (qrMaterialData.FieldByName('FCOAST').AsInteger = 1) and (Column.FieldName = 'COAST') then
    grMaterial.Canvas.Font.Style := grMaterial.Canvas.Font.Style + [fsItalic];

  if qrMaterialData.FieldByName('DELETED').AsInteger = 1 then
    grMaterial.Canvas.Font.Style := grMaterial.Canvas.Font.Style + [fsStrikeOut];

  if qrMaterialData.FieldByName('REPLACED').AsInteger <> 0 then
  begin
    grMaterial.Canvas.Font.Style := grMaterial.Canvas.Font.Style + [fsStrikeOut] + [fsItalic];
    grMaterial.Canvas.Font.Color := clNavy;
  end;

  if qrMaterialData.FieldByName('FREPLACED').AsInteger <> 0 then
  begin
    grMaterial.Canvas.Font.Style := grMaterial.Canvas.Font.Style + [fsItalic];
    grMaterial.Canvas.Font.Color := clNavy;
  end;

  if CanEditField(Column.Field) then
    grMaterial.Canvas.Brush.Color := clMoneyGreen;

  grMaterial.DefaultDrawColumnCell(Rect, DataCol, Column, State);
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

procedure TfCalcResource.grMechBottDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  if qrMechDetail.FieldByName('DELETED').AsInteger = 1 then
    grMechBott.Canvas.Font.Style := grMechBott.Canvas.Font.Style + [fsStrikeOut];

  if qrMechDetail.FieldByName('REPLACED').AsInteger <> 0 then
  begin
    grMechBott.Canvas.Font.Style := grMaterial.Canvas.Font.Style + [fsStrikeOut] + [fsItalic];
    grMechBott.Canvas.Font.Color := clNavy;
  end;

  if qrMechDetail.FieldByName('ID_REPLACED').AsInteger <> 0 then
  begin
    grMechBott.Canvas.Font.Style := grMaterial.Canvas.Font.Style + [fsItalic];
    grMechBott.Canvas.Font.Color := clNavy;
  end;

  if CanEditField(Column.Field) then
    grMechBott.Canvas.Brush.Color := clMoneyGreen;
  grMechBott.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfCalcResource.grMechDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  if qrMechData.FieldByName('DELETED').AsInteger = 1 then
    grMech.Canvas.Font.Style := grMech.Canvas.Font.Style + [fsStrikeOut];

  if qrMechData.FieldByName('REPLACED').AsInteger <> 0 then
  begin
    grMech.Canvas.Font.Style := grMaterial.Canvas.Font.Style + [fsStrikeOut] + [fsItalic];
    grMech.Canvas.Font.Color := clNavy;
  end;

  if qrMechData.FieldByName('FREPLACED').AsInteger <> 0 then
  begin
    grMech.Canvas.Font.Style := grMaterial.Canvas.Font.Style + [fsItalic];
    grMech.Canvas.Font.Color := clNavy;
  end;

  if CanEditField(Column.Field) then
    grMech.Canvas.Brush.Color := clMoneyGreen;
  grMech.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfCalcResource.grMechTitleBtnClick(Sender: TObject; ACol: Integer; Field: TField);
var
  s: string;
begin
  if not CheckQrActiveEmpty(qrMechData) then
    Exit;
  s := '';
  if grMech.SortMarker = smDown then
    s := ' DESC';
  qrMechData.SQL[qrMechData.SQL.Count - 1] := 'ORDER BY ' + grMech.SortedField + s;
  CloseOpen(qrMechData);
end;

procedure TfCalcResource.grRatesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  if qrRates.FieldByName('DELETED').AsInteger = 1 then
    grRates.Canvas.Font.Style := grRates.Canvas.Font.Style + [fsStrikeOut];
  grRates.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfCalcResource.JvDBGridFooter1Calculate(Sender: TJvDBGridFooter; const FieldName: string;
  var CalcValue: Variant);
begin
  try
    if not CheckQrActiveEmpty(Sender.DataSource.DataSet) then
      Exit;
  except

  end;

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
        // Если является заменяющим
        if (qrMaterialData.FieldByName('FREPLACED').AsInteger <> 0) and (not(qrMaterialData.State in [dsEdit]))
        then
        begin
          if MessageBox(0, PChar('Вы действительно хотите удалить ' + strngfldMaterialDataCODE.AsString +
            '?'), Pwidechar(Caption), MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) <> mrYes then
            Exit;
          DM.qrDifferent.SQL.Text := 'SELECT ID FROM materialcard_temp'#13 +
            'WHERE PROC_TRANSP=:PROC_TRANSP AND DELETED=:DELETED'#13 +
            'AND MAT_PROC_ZAC=:MAT_PROC_ZAC AND MAT_PROC_PODR=:MAT_PROC_PODR'#13 +
            'AND TRANSP_PROC_ZAC=:TRANSP_PROC_ZAC AND TRANSP_PROC_PODR=:TRANSP_PROC_PODR'#13 +
            'AND IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS))=:COAST AND MAT_ID=:MAT_ID';
          DM.qrDifferent.ParamByName('PROC_TRANSP').Value := qrMaterialData.FieldByName('PROC_TRANSP').Value;
          DM.qrDifferent.ParamByName('DELETED').Value := qrMaterialData.FieldByName('DELETED').Value;
          DM.qrDifferent.ParamByName('MAT_PROC_ZAC').Value :=
            qrMaterialData.FieldByName('MAT_PROC_ZAC').Value;
          DM.qrDifferent.ParamByName('MAT_PROC_PODR').Value :=
            qrMaterialData.FieldByName('MAT_PROC_PODR').Value;
          DM.qrDifferent.ParamByName('TRANSP_PROC_ZAC').Value :=
            qrMaterialData.FieldByName('TRANSP_PROC_ZAC').Value;
          DM.qrDifferent.ParamByName('TRANSP_PROC_PODR').Value :=
            qrMaterialData.FieldByName('TRANSP_PROC_PODR').Value;
          DM.qrDifferent.ParamByName('NDS').Value := cbbNDS.ItemIndex;
          DM.qrDifferent.ParamByName('COAST').Value := qrMaterialData.FieldByName('COAST').Value;
          DM.qrDifferent.ParamByName('MAT_ID').Value := qrMaterialData.FieldByName('MAT_ID').Value;
          DM.qrDifferent.Active := True;
          while not DM.qrDifferent.Eof do
          begin
            FastExecSQL('CALL DeleteMaterial(:id, :CalcMode);',
              VarArrayOf([DM.qrDifferent.FieldByName('ID').Value, G_CALCMODE]));
            DM.qrDifferent.Next;
          end;
          FormCalculationEstimate.RecalcEstimate;
          CloseOpen(qrMaterialData);
        end
        else
        begin
          if not(qrMaterialData.State in [dsEdit]) then
            qrMaterialData.Edit;
          qrMaterialData.FieldByName('DELETED').Value := 1;
        end;
      end;
    // Расчет механизмов
    2:
      begin
        // Если является заменяющим
        if (qrMechData.FieldByName('FREPLACED').AsInteger <> 0) and (not(qrMechData.State in [dsEdit])) then
        begin
          if MessageBox(0, PChar('Вы действительно хотите удалить ' + strngfldMechDataCODE.AsString + '?'),
            Pwidechar(Caption), MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) <> mrYes then
            Exit;
          DM.qrDifferent.SQL.Text := 'SELECT ID FROM mechanizmcard_temp'#13 +
            'WHERE DELETED=:DELETED AND PROC_ZAC=:PROC_ZAC AND PROC_PODR=:PROC_PODR'#13 +
            'AND IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS))=:COAST AND MECH_ID=:MECH_ID'#13
            + 'AND IF(:NDS=1, IF(FZP_MACH_NDS<>0, FZP_MACH_NDS, ZP_MACH_NDS), IF(FZP_MACH_NO_NDS<>0, FZP_MACH_NO_NDS, ZP_MACH_NO_NDS))=:ZP_1';
          DM.qrDifferent.ParamByName('DELETED').Value := qrMechData.FieldByName('DELETED').Value;
          DM.qrDifferent.ParamByName('PROC_ZAC').Value := qrMechData.FieldByName('PROC_ZAC').Value;
          DM.qrDifferent.ParamByName('PROC_PODR').Value := qrMechData.FieldByName('PROC_PODR').Value;
          DM.qrDifferent.ParamByName('NDS').Value := cbbNDS.ItemIndex;
          DM.qrDifferent.ParamByName('COAST').Value := qrMechData.FieldByName('COAST').Value;
          DM.qrDifferent.ParamByName('MECH_ID').Value := qrMechData.FieldByName('MECH_ID').Value;
          DM.qrDifferent.ParamByName('ZP_1').Value := qrMechData.FieldByName('ZP_1').Value;
          DM.qrDifferent.Active := True;
          while not DM.qrDifferent.Eof do
          begin
            FastExecSQL('CALL DeleteMechanism(:id, :CalcMode);',
              VarArrayOf([DM.qrDifferent.FieldByName('ID').Value, G_CALCMODE]));
            DM.qrDifferent.Next;
          end;
          FormCalculationEstimate.RecalcEstimate;
          CloseOpen(qrMechData);
        end
        else
        begin
          if not(qrMechData.State in [dsEdit]) then
            qrMechData.Edit;
          qrMechData.FieldByName('DELETED').Value := 1;
        end;
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
begin
  { grMaterial.Options := grMaterial.Options - [dgMultiSelect];
    grMaterialBott.Options := grMaterialBott.Options - [dgMultiSelect];
    grMech.Options := grMaterial.Options - [dgMultiSelect];
    grMechBott.Options := grMechBott.Options - [dgMultiSelect]; }
  case pgc.ActivePageIndex of
    1:
      frmReplace := TfrmReplacement.Create(0, IDEstimate, 0, 0, qrMaterialData.FieldByName('MAT_ID')
        .AsInteger, 2, False, False);
    2:
      frmReplace := TfrmReplacement.Create(0, IDEstimate, 0, 0, qrMechData.FieldByName('MECH_ID').AsInteger,
        3, False, False);
    3:
      frmReplace := TfrmReplacement.Create(0, IDEstimate, 0, 0, qrDevices.FieldByName('DEVICE_ID').AsInteger,
        4, False, False);
  end;
  if Assigned(frmReplace) then
    try
      if (frmReplace.ShowModal = mrYes) then
      begin
        // пересчет после замены
        FormCalculationEstimate.RecalcEstimate;
        pgcChange(nil);
      end;
    finally
      FreeAndNil(frmReplace);
    end;
  { grMaterial.Options := grMaterial.Options + [dgMultiSelect];
    grMaterialBott.Options := grMaterialBott.Options + [dgMultiSelect];
    grMech.Options := grMaterial.Options + [dgMultiSelect];
    grMechBott.Options := grMechBott.Options + [dgMultiSelect]; }
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

procedure TfCalcResource.N1Click(Sender: TObject);
begin
  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1:
      begin

      end;
    // Расчет механизмов
    2:
      begin

      end;
    // Расчет оборудования
    3:
      begin

      end;
    // Расчет з\п
    4:
      begin

      end;
  end;
end;

procedure TfCalcResource.N2Click(Sender: TObject);
begin
  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1:
      begin

      end;
    // Расчет механизмов
    2:
      begin

      end;
    // Расчет оборудования
    3:
      begin

      end;
    // Расчет з\п
    4:
      begin

      end;
  end;
end;

procedure TfCalcResource.pgcChange(Sender: TObject);
begin
  if not flLoaded then
    Exit;
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
        CloseOpen(qrMechDetail);
      end;
    // Расчет оборудования
    3:
      begin
        CloseOpen(qrDevices);
        CloseOpen(qrDevicesDetail);
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
        mReplace.Visible := True;
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

procedure TfCalcResource.pnlCalculationYesNoClick(Sender: TObject);
begin
  with pnlCalculationYesNo do
    if Tag = 1 then
    begin
      Tag := 0;
      Color := clRed;
      Caption := 'Расчёты запрещены';
      fCalcResource.Caption := 'Расчет стоимости ресурсов [редактирование запрещено]';
    end
    else
    begin
      Tag := 1;
      Color := clLime;
      Caption := 'Расчёты разрешены';
      fCalcResource.Caption := 'Расчет стоимости ресурсов [редактирование разрешено]';
    end;

  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1:
      begin
        grMaterial.Repaint;
        grMaterialBott.Repaint;
      end;
    // Расчет механизмов
    2:
      begin
        grMech.Repaint;
        grMechBott.Repaint;
      end;
    // Расчет оборудования
    3:
      begin
        grDev.Repaint;
        grDevBott.Repaint;
      end;
    // Расчет з\п
    4:
      begin
        grRates.Repaint;
      end;
  end;
end;

procedure TfCalcResource.qrDevicesBeforePost(DataSet: TDataSet);
var
  priceQ, priceQ1: string;
begin
  if (Application.MessageBox('Сохранить изменения?', 'Смета', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST)
    = IDYES) and (Application.MessageBox('Вы уверены, что хотите применить изменения?'#13 +
    '(будет произведена замена во всех зависимых величинах)', 'Смета',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES) then
  begin
    with qrDevices do
    begin
      // Цена
      case cbbNDS.ItemIndex of
        // Если в режиме без НДС
        0:
          begin
            priceQ := 'FCOAST_NO_NDS=:01, FCOAST_NDS=FCOAST_NO_NDS+(FCOAST_NO_NDS*NDS/100),'#13;
            priceQ1 :=
              'DEVICE_TRANSP_NO_NDS=:02, DEVICE_TRANSP_NDS=DEVICE_TRANSP_NO_NDS+(DEVICE_TRANSP_NO_NDS*NDS/100),'#13;
          end;
        // С НДС
        1:
          begin
            priceQ := 'FCOAST_NDS=:01, FCOAST_NO_NDS=FCOAST_NDS-(FCOAST_NDS/(100+NDS)*NDS),'#13;
            priceQ1 :=
              'DEVICE_TRANSP_NDS=:02, DEVICE_TRANSP_NO_NDS=DEVICE_TRANSP_NDS-(DEVICE_TRANSP_NDS/(100+NDS)*NDS),'#13;
          end;
      end;

      FastExecSQL('UPDATE devicescard_temp SET'#13 + priceQ1 + priceQ +
        'TRANSP_PROC_PODR=:1, TRANSP_PROC_ZAC=:2,'#13 + 'PROC_PODR=:3, PROC_ZAC=:4'#13 + 'WHERE '#13 +
        'PROC_ZAC=:11 AND PROC_PODR=:12'#13 + 'AND TRANSP_PROC_ZAC=:13 AND TRANSP_PROC_PODR=:14'#13 +
        'AND IF(:NDS=1, FCOAST_NDS, FCOAST_NO_NDS)=:15 AND DEVICE_ID=:16'#13 +
        'AND IF(:NDS1=1, DEVICE_TRANSP_NDS, DEVICE_TRANSP_NO_NDS)=:17',
        VarArrayOf([FieldByName('TRANSP').Value, FieldByName('COAST').Value,
        FieldByName('TRANSP_PROC_PODR').Value, FieldByName('TRANSP_PROC_ZAC').Value,
        FieldByName('PROC_PODR').Value, FieldByName('PROC_ZAC').Value, FieldByName('PROC_ZAC').OldValue,
        FieldByName('PROC_PODR').OldValue, FieldByName('TRANSP_PROC_ZAC').OldValue,
        FieldByName('TRANSP_PROC_PODR').OldValue, cbbNDS.ItemIndex, FieldByName('COAST').OldValue,
        FieldByName('DEVICE_ID').Value, cbbNDS.ItemIndex, FieldByName('TRANSP').OldValue]));
    end;
    // Вызываем переасчет всей сметы
    FormCalculationEstimate.RecalcEstimate;
    pgcChange(nil);
  end
  else
  begin
    qrDevices.Cancel;
    Abort;
  end;
end;

procedure TfCalcResource.qrDevicesDetailBeforePost(DataSet: TDataSet);
var
  priceQ, priceQ1: string;
begin
  if (Application.MessageBox('Сохранить изменения?', 'Смета', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES)
  then
  begin
    with qrDevicesDetail do
    begin
      // Цена
      case cbbNDS.ItemIndex of
        // Если в режиме без НДС
        0:
          begin
            priceQ := 'FCOAST_NO_NDS=:01, FCOAST_NDS=FCOAST_NO_NDS+(FCOAST_NO_NDS*NDS/100),'#13;
            priceQ1 :=
              'DEVICE_TRANSP_NO_NDS=:02, DEVICE_TRANSP_NDS=DEVICE_TRANSP_NO_NDS+(DEVICE_TRANSP_NO_NDS*NDS/100),'#13;
          end;
        // С НДС
        1:
          begin
            priceQ := 'FCOAST_NDS=:01, FCOAST_NO_NDS=FCOAST_NDS-(FCOAST_NDS/(100+NDS)*NDS),'#13;
            priceQ1 :=
              'DEVICE_TRANSP_NDS=:02, DEVICE_TRANSP_NO_NDS=DEVICE_TRANSP_NDS-(DEVICE_TRANSP_NDS/(100+NDS)*NDS),'#13;
          end;
      end;

      FastExecSQL('UPDATE devicescard_temp SET'#13 + priceQ1 + priceQ +
        'TRANSP_PROC_PODR=:1, TRANSP_PROC_ZAC=:2, PROC_PODR=:3, PROC_ZAC=:4 WHERE ID=:11',
        VarArrayOf([FieldByName('TRANSP').Value, FieldByName('COAST').Value,
        FieldByName('TRANSP_PROC_PODR').Value, FieldByName('TRANSP_PROC_ZAC').Value,
        FieldByName('PROC_PODR').Value, FieldByName('PROC_ZAC').Value, FieldByName('ID').Value]));
    end;
    // Вызываем переасчет всей сметы
    FormCalculationEstimate.RecalcEstimate;
    pgcChange(nil);
  end
  else
  begin
    qrDevicesDetail.Cancel;
    Abort;
  end;
end;

procedure TfCalcResource.qrDevicesPROC_PODRChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrDevicesPROC_ZAC.OnChange;
    qrDevicesPROC_ZAC.OnChange := nil;
    qrDevices.FieldByName('PROC_ZAC').Value := 100 - qrDevices.FieldByName('PROC_PODR').Value;
    qrDevicesPROC_ZAC.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResource.qrDevicesPROC_ZACChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrDevicesPROC_PODR.OnChange;
    qrDevicesPROC_PODR.OnChange := nil;
    qrDevices.FieldByName('PROC_PODR').Value := 100 - qrDevices.FieldByName('PROC_ZAC').Value;
    qrDevicesPROC_PODR.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResource.qrDevicesTRANSP_PROC_PODRChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrDevicesTRANSP_PROC_ZAC.OnChange;
    qrDevicesTRANSP_PROC_ZAC.OnChange := nil;
    qrDevices.FieldByName('TRANSP_PROC_ZAC').Value := 100 - qrDevices.FieldByName('TRANSP_PROC_PODR').Value;
    qrDevicesTRANSP_PROC_ZAC.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResource.qrDevicesTRANSP_PROC_ZACChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrDevicesTRANSP_PROC_PODR.OnChange;
    qrDevicesTRANSP_PROC_PODR.OnChange := nil;
    qrDevices.FieldByName('TRANSP_PROC_PODR').Value := 100 - qrDevices.FieldByName('TRANSP_PROC_ZAC').Value;
    qrDevicesTRANSP_PROC_PODR.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
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
  if (Application.MessageBox('Сохранить изменения?', 'Смета', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST)
    = IDYES) and (Application.MessageBox('Вы уверены, что хотите применить изменения?'#13 +
    '(будет произведена замена во всех зависимых величинах)', 'Смета',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES) then
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
        FieldByName('MAT_ID').Value]));

      // Цена
      case cbbNDS.ItemIndex of
        // Если в режиме без НДС
        0:
          priceQ := 'FCOAST_NO_NDS=:1, FCOAST_NDS=FCOAST_NO_NDS+(FCOAST_NO_NDS*NDS/100)'#13;
        // С НДС
        1:
          priceQ := 'FCOAST_NDS=:1, FCOAST_NO_NDS=FCOAST_NDS-(FCOAST_NDS/(100+NDS)*NDS)'#13;
      end;

      if FieldByName('COAST').Value <> FieldByName('COAST').OldValue then
        FastExecSQL('UPDATE materialcard_temp SET'#13 + priceQ + ' WHERE PROC_TRANSP=:4 AND DELETED=:5'#13 +
          'AND MAT_PROC_ZAC=:6 AND MAT_PROC_PODR=:7'#13 + 'AND TRANSP_PROC_ZAC=:8 AND TRANSP_PROC_PODR=:9'#13
          + 'AND IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS))=:10 AND MAT_ID=:11',
          VarArrayOf([FieldByName('COAST').Value, FieldByName('PROC_TRANSP').Value,
          FieldByName('DELETED').Value, FieldByName('MAT_PROC_ZAC').Value, FieldByName('MAT_PROC_PODR').Value,
          FieldByName('TRANSP_PROC_ZAC').Value, FieldByName('TRANSP_PROC_PODR').Value, cbbNDS.ItemIndex,
          FieldByName('COAST').OldValue, FieldByName('MAT_ID').Value]));

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
          FieldByName('MAT_ID').Value]));
    end;
    // Вызываем переасчет всей сметы
    FormCalculationEstimate.RecalcEstimate;
    pgcChange(nil);
  end
  else
  begin
    qrMaterialData.Cancel;
    Abort;
  end;
end;

procedure TfCalcResource.qrMaterialDataMAT_PROC_PODRChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrMaterialDataMAT_PROC_ZAC.OnChange;
    qrMaterialDataMAT_PROC_ZAC.OnChange := nil;
    qrMaterialData.FieldByName('MAT_PROC_ZAC').Value := 100 - qrMaterialData.FieldByName
      ('MAT_PROC_PODR').Value;
    qrMaterialDataMAT_PROC_ZAC.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResource.qrMaterialDataMAT_PROC_ZACChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrMaterialDataMAT_PROC_PODR.OnChange;
    qrMaterialDataMAT_PROC_PODR.OnChange := nil;
    qrMaterialData.FieldByName('MAT_PROC_PODR').Value :=
      100 - qrMaterialData.FieldByName('MAT_PROC_ZAC').Value;
    qrMaterialDataMAT_PROC_PODR.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResource.qrMaterialDataTRANSP_PROC_PODRChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrMaterialDataTRANSP_PROC_ZAC.OnChange;
    qrMaterialDataTRANSP_PROC_ZAC.OnChange := nil;
    qrMaterialData.FieldByName('TRANSP_PROC_ZAC').Value :=
      100 - qrMaterialData.FieldByName('TRANSP_PROC_PODR').Value;
    qrMaterialDataTRANSP_PROC_ZAC.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResource.qrMaterialDataTRANSP_PROC_ZACChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrMaterialDataTRANSP_PROC_PODR.OnChange;
    qrMaterialDataTRANSP_PROC_PODR.OnChange := nil;
    qrMaterialData.FieldByName('TRANSP_PROC_PODR').Value :=
      100 - qrMaterialData.FieldByName('TRANSP_PROC_ZAC').Value;
    qrMaterialDataTRANSP_PROC_PODR.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResource.qrMaterialDetailBeforePost(DataSet: TDataSet);
var
  priceQ: string;
begin
  if (Application.MessageBox('Сохранить изменения?', 'Смета', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES)
  then
  begin
    with qrMaterialDetail do
    begin
      FastExecSQL('UPDATE materialcard_temp SET TRANSP_PROC_PODR=:1, TRANSP_PROC_ZAC=:2,'#13 +
        'MAT_PROC_PODR=:3, MAT_PROC_ZAC=:4, DELETED=:5, PROC_TRANSP=:7 WHERE ID=:9',
        VarArrayOf([FieldByName('TRANSP_PROC_PODR').Value, FieldByName('TRANSP_PROC_ZAC').Value,
        FieldByName('MAT_PROC_PODR').Value, FieldByName('MAT_PROC_ZAC').Value, FieldByName('DELETED').Value,
        FieldByName('PROC_TRANSP').Value, FieldByName('ID').Value]));

      // Цена
      case cbbNDS.ItemIndex of
        // Если в режиме без НДС
        0:
          priceQ := 'FCOAST_NO_NDS=:1, FCOAST_NDS=FCOAST_NO_NDS+(FCOAST_NO_NDS*NDS/100)'#13;
        // С НДС
        1:
          priceQ := 'FCOAST_NDS=:1, FCOAST_NO_NDS=FCOAST_NDS-(FCOAST_NDS/(100+NDS)*NDS)'#13;
      end;

      if FieldByName('COAST').Value <> FieldByName('COAST').OldValue then
        FastExecSQL('UPDATE materialcard_temp SET'#13 + priceQ + ' WHERE ID=:4',
          VarArrayOf([FieldByName('COAST').Value, FieldByName('ID').Value]));

      // Стоимость транспорта
      if FieldByName('TRANSP').Value <> FieldByName('TRANSP').OldValue then
        FastExecSQL('UPDATE materialcard_temp SET FTRANSP_NO_NDS = :1, FTRANSP_NDS = :2 WHERE ID=:4',
          VarArrayOf([FieldByName('TRANSP').Value, FieldByName('TRANSP').Value, FieldByName('ID').Value]));
    end;
    // Вызываем переасчет всей сметы
    FormCalculationEstimate.RecalcEstimate;
    pgcChange(nil);
  end
  else
  begin
    qrMaterialDetail.Cancel;
    Abort;
  end;
end;

procedure TfCalcResource.qrMechDataBeforePost(DataSet: TDataSet);
var
  priceQ, priceQ1: string;
begin
  if (Application.MessageBox('Сохранить изменения?', 'Смета', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST)
    = IDYES) and (Application.MessageBox('Вы уверены, что хотите применить изменения?'#13 +
    '(будет произведена замена во всех зависимых величинах)', 'Смета',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES) then
  begin
    with qrMechData do
    begin
      FastExecSQL('UPDATE mechanizmcard_temp SET'#13 + 'PROC_PODR=:3, PROC_ZAC=:4, DELETED=:5'#13 +
        'WHERE DELETED=:10'#13 + 'AND PROC_ZAC=:11 AND PROC_PODR=:12'#13 +
        'AND IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS))=:15 AND MECH_ID=:16'#13
        + 'AND IF(:NDS1=1, IF(FZP_MACH_NDS<>0, FZP_MACH_NDS, ZP_MACH_NDS), IF(FZP_MACH_NO_NDS<>0, FZP_MACH_NO_NDS, ZP_MACH_NO_NDS))=:17',
        VarArrayOf([FieldByName('PROC_PODR').Value, FieldByName('PROC_ZAC').Value,
        FieldByName('DELETED').Value, FieldByName('DELETED').OldValue, FieldByName('PROC_ZAC').OldValue,
        FieldByName('PROC_PODR').OldValue, cbbNDS.ItemIndex, FieldByName('COAST').OldValue,
        FieldByName('MECH_ID').Value, cbbNDS.ItemIndex, FieldByName('ZP_1').OldValue]));

      // Цена
      case cbbNDS.ItemIndex of
        // Если в режиме без НДС
        0:
          begin
            priceQ := 'FCOAST_NO_NDS=:1, FCOAST_NDS=FCOAST_NO_NDS+(FCOAST_NO_NDS*NDS/100)'#13;
            priceQ1 := 'FZP_MACH_NO_NDS=:1, FZP_MACH_NDS=FZP_MACH_NO_NDS+(FZP_MACH_NO_NDS*NDS/100)'#13;
          end;
        // С НДС
        1:
          begin
            priceQ := 'FCOAST_NDS=:1, FCOAST_NO_NDS=FCOAST_NDS-(FCOAST_NDS/(100+NDS)*NDS)'#13;
            priceQ1 := 'FZP_MACH_NDS=:1, FZP_MACH_NO_NDS=FZP_MACH_NDS-(FZP_MACH_NDS/(100+NDS)*NDS)'#13;
          end;
      end;

      if FieldByName('COAST').Value <> FieldByName('COAST').OldValue then
        FastExecSQL('UPDATE mechanizmcard_temp SET'#13 + priceQ + ' WHERE DELETED=:5'#13 +
          'AND PROC_ZAC=:6 AND PROC_PODR=:7'#13 +
          'AND IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS))=:10 AND MECH_ID=:11'#13
          + 'AND IF(:NDS1=1, IF(FZP_MACH_NDS<>0, FZP_MACH_NDS, ZP_MACH_NDS), IF(FZP_MACH_NO_NDS<>0, FZP_MACH_NO_NDS, ZP_MACH_NO_NDS))=:12',
          VarArrayOf([FieldByName('COAST').Value, FieldByName('DELETED').Value, FieldByName('PROC_ZAC').Value,
          FieldByName('PROC_PODR').Value, cbbNDS.ItemIndex, FieldByName('COAST').OldValue,
          FieldByName('MECH_ID').Value, cbbNDS.ItemIndex, FieldByName('ZP_1').OldValue]));

      if FieldByName('ZP_1').Value <> FieldByName('ZP_1').OldValue then
        FastExecSQL('UPDATE mechanizmcard_temp SET'#13 + priceQ1 + ' WHERE DELETED=:5'#13 +
          'AND PROC_ZAC=:6 AND PROC_PODR=:7'#13 +
          'AND IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS))=:10 AND MECH_ID=:11'#13
          + 'AND IF(:NDS1=1, IF(FZP_MACH_NDS<>0, FZP_MACH_NDS, ZP_MACH_NDS), IF(FZP_MACH_NO_NDS<>0, FZP_MACH_NO_NDS, ZP_MACH_NO_NDS))=:12',
          VarArrayOf([FieldByName('ZP_1').Value, FieldByName('DELETED').Value, FieldByName('PROC_ZAC').Value,
          FieldByName('PROC_PODR').Value, cbbNDS.ItemIndex, FieldByName('COAST').Value,
          FieldByName('MECH_ID').Value, cbbNDS.ItemIndex, FieldByName('ZP_1').OldValue]));
    end;
    // Вызываем переасчет всей сметы
    FormCalculationEstimate.RecalcEstimate;
    pgcChange(nil);
  end
  else
  begin
    qrMechData.Cancel;
    Abort;
  end;
end;

procedure TfCalcResource.qrMechDataPROC_PODRChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrMechDataPROC_ZAC.OnChange;
    qrMechDataPROC_ZAC.OnChange := nil;
    qrMechData.FieldByName('PROC_ZAC').Value := 100 - qrMechData.FieldByName('PROC_PODR').Value;
    qrMechDataPROC_ZAC.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResource.qrMechDataPROC_ZACChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrMechDataPROC_PODR.OnChange;
    qrMechDataPROC_PODR.OnChange := nil;
    qrMechData.FieldByName('PROC_PODR').Value := 100 - qrMechData.FieldByName('PROC_ZAC').Value;
    qrMechDataPROC_PODR.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResource.qrMechDetailBeforePost(DataSet: TDataSet);
var
  priceQ, priceQ1: string;
begin
  if (Application.MessageBox('Сохранить изменения?', 'Смета', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES)
  then
  begin
    with qrMechDetail do
    begin
      FastExecSQL('UPDATE mechanizmcard_temp SET PROC_PODR=:3, PROC_ZAC=:4, DELETED=:5 WHERE ID=:10',
        VarArrayOf([FieldByName('PROC_PODR').Value, FieldByName('PROC_ZAC').Value,
        FieldByName('DELETED').Value, FieldByName('ID').Value]));

      // Цена
      case cbbNDS.ItemIndex of
        // Если в режиме без НДС
        0:
          begin
            priceQ := 'FCOAST_NO_NDS=:1, FCOAST_NDS=FCOAST_NO_NDS+(FCOAST_NO_NDS*NDS/100)'#13;
            priceQ1 := 'FZP_MACH_NO_NDS=:1, FZP_MACH_NDS=FZP_MACH_NO_NDS+(FZP_MACH_NO_NDS*NDS/100)'#13;
          end;
        // С НДС
        1:
          begin
            priceQ := 'FCOAST_NDS=:1, FCOAST_NO_NDS=FCOAST_NDS-(FCOAST_NDS/(100+NDS)*NDS)'#13;
            priceQ1 := 'FZP_MACH_NDS=:1, FZP_MACH_NO_NDS=FZP_MACH_NDS-(FZP_MACH_NDS/(100+NDS)*NDS)'#13;
          end;
      end;

      if FieldByName('COAST').Value <> FieldByName('COAST').OldValue then
        FastExecSQL('UPDATE mechanizmcard_temp SET'#13 + priceQ + ' WHERE ID=:5',
          VarArrayOf([FieldByName('COAST').Value, FieldByName('ID').Value]));

      if FieldByName('ZP_MASH').Value <> FieldByName('ZP_MASH').OldValue then
        FastExecSQL('UPDATE mechanizmcard_temp SET'#13 + priceQ1 + ' WHERE ID=:5',
          VarArrayOf([FieldByName('ZP_MASH').Value, FieldByName('ID').Value]));
    end;
    // Вызываем переасчет всей сметы
    FormCalculationEstimate.RecalcEstimate;
    pgcChange(nil);
  end
  else
  begin
    qrMechDetail.Cancel;
    Abort;
  end;
end;

end.
