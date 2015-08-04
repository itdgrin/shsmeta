unit CalcResourceFact;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Menus, Vcl.Samples.Spin, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.Mask, JvDBGridFooter,
  JvComponentBase, JvFormPlacement, System.UITypes, Vcl.Buttons;

type
  TfCalcResourceFact = class(TForm)
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
    qrMainData: TFDQuery;
    dsMainData: TDataSource;
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
    pnlRatesTop: TPanel;
    pnlRatesClient: TPanel;
    grRates: TJvDBGrid;
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
    qrMainDataCNT: TFMTBCDField;
    qrMainDataDOC_DATE: TDateField;
    strngfldMaterialDataDOC_NUM: TStringField;
    qrMainDataPROC_TRANSP: TFMTBCDField;
    qrMainDataCOAST: TFMTBCDField;
    qrMainDataPRICE: TFMTBCDField;
    qrMainDataTRANSP: TFMTBCDField;
    qrMainDataDELETED: TByteField;
    qrMainDataPROC_ZAC: TWordField;
    qrMainDataPROC_PODR: TWordField;
    qrMainDataTRANSP_PROC_ZAC: TWordField;
    qrMainDataTRANSP_PROC_PODR: TWordField;
    qrMainDataMAT_ID: TLongWordField;
    qrMainDataFCOAST: TIntegerField;
    qrMainDataREPLACED: TIntegerField;
    qrMainDataFREPLACED: TIntegerField;
    pnlCalculationYesNo: TPanel;
    btnShowDiff: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure pgcChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtMatCodeFilterChange(Sender: TObject);
    procedure edtMatCodeFilterClick(Sender: TObject);
    procedure qrMainDataAfterOpen(DataSet: TDataSet);
    procedure JvDBGridFooter1Calculate(Sender: TJvDBGridFooter; const FieldName: string;
      var CalcValue: Variant);
    procedure qrMainDataBeforeOpen(DataSet: TDataSet);
    procedure pmPopup(Sender: TObject);
    procedure grMaterialCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
    procedure grMaterialTitleBtnClick(Sender: TObject; ACol: Integer; Field: TField);
    procedure mDeteteClick(Sender: TObject);
    procedure mRestoreClick(Sender: TObject);
    procedure grMaterialDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure qrMainDataPROC_ZACChange(Sender: TField);
    procedure qrMainDataPROC_PODRChange(Sender: TField);
    procedure qrMainDataTRANSP_PROC_ZACChange(Sender: TField);
    procedure qrMainDataTRANSP_PROC_PODRChange(Sender: TField);
    procedure grMaterialBottDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure grMechBottDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
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
  fCalcResourceFact: TfCalcResourceFact;

procedure ShowCalcResourceFact(const ID_ESTIMATE: Variant; const APage: Integer = 0;
  AOwner: TWinControl = nil);

implementation

{$R *.dfm}

uses Main, Tools, ReplacementMatAndMech, CalculationEstimate, DataModule, GlobsAndConst;

procedure ShowCalcResourceFact(const ID_ESTIMATE: Variant; const APage: Integer = 0;
  AOwner: TWinControl = nil);
var
  pageID: Integer;
begin
  if VarIsNull(ID_ESTIMATE) then
    Exit;
  if (not Assigned(fCalcResourceFact)) then
    fCalcResourceFact := TfCalcResourceFact.Create(AOwner);
  fCalcResourceFact.flLoaded := False;
  fCalcResourceFact.IDEstimate := ID_ESTIMATE;
  fCalcResourceFact.qrEstimate.ParamByName('SM_ID').Value := ID_ESTIMATE;
  fCalcResourceFact.qrEstimate.Active := True;
  fCalcResourceFact.cbbFromMonth.ItemIndex := fCalcResourceFact.qrEstimate.FieldByName('MONTH').AsInteger - 1;
  fCalcResourceFact.edtEstimateName.Text := fCalcResourceFact.qrEstimate.FieldByName('NAME').AsString;
  fCalcResourceFact.seFromYear.Value := fCalcResourceFact.qrEstimate.FieldByName('YEAR').AsInteger;
  fCalcResourceFact.cbbNDS.ItemIndex := fCalcResourceFact.qrEstimate.FieldByName('NDS').AsInteger;

  if AOwner <> nil then
  begin
    fCalcResourceFact.BorderStyle := bsNone;
    fCalcResourceFact.Parent := AOwner;
    fCalcResourceFact.Align := alClient;
  end
  else
    // Создаём кнопку от этого окна (на главной форме внизу)
    FormMain.CreateButtonOpenWindow('Расчет стоимости фактических ресурсов',
      'Расчет стоимости фактических ресурсов', fCalcResourceFact, 1);

  // Если вызвали с доп параметром (на что положить) , то скрываем все вкладки
  for pageID := 0 to fCalcResourceFact.pgc.PageCount - 1 do
    fCalcResourceFact.pgc.Pages[pageID].TabVisible := AOwner = nil;

  // fCalcResource.pnlTop.Visible := AOwner = nil;

  fCalcResourceFact.pgc.ActivePageIndex := APage;

  fCalcResourceFact.Show;
  fCalcResourceFact.flLoaded := True;
  fCalcResourceFact.pgcChange(nil);
end;

procedure TfCalcResourceFact.btnShowDiffClick(Sender: TObject);
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
    // Расчет стоимости
    4:
      begin

      end;
  end;
end;

procedure TfCalcResourceFact.CalcFooter;
begin
  // В зависимости от вкладки
  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1:
      Footer := CalcFooterSumm(qrMainData);
    // Расчет механизмов
    2:
      Footer := CalcFooterSumm(qrMainData);
    // Расчет оборудования
    3:
      Footer := CalcFooterSumm(qrMainData);
    // Расчет з\п
    4:
      Footer := CalcFooterSumm(qrMainData);
  end;
end;

function TfCalcResourceFact.CanEditField(Field: TField): Boolean;
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

procedure TfCalcResourceFact.edtMatCodeFilterChange(Sender: TObject);
begin
  qrMainData.Filtered := False;
  qrMainData.Filter := 'Upper(CODE) LIKE UPPER(''%' + edtMatCodeFilter.Text +
    '%'') AND Upper(NAME) LIKE UPPER(''%' + edtMatNameFilter.Text + '%'')';
  // + ' AND NDS=' + IntToStr(cbbMatNDS.ItemIndex); //возможно, неверное решение с НДС
  qrMainData.Filtered := True;
  // CalcFooter;
end;

procedure TfCalcResourceFact.edtMatCodeFilterClick(Sender: TObject);
begin
  (Sender as TEdit).SelectAll;
end;

procedure TfCalcResourceFact.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow('Расчет стоимости ресурсов');
end;

procedure TfCalcResourceFact.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCalcResourceFact.FormCreate(Sender: TObject);
begin
  LoadDBGridSettings(grMaterial);
  LoadDBGridSettings(grMaterialBott);
  LoadDBGridSettings(grMech);
  LoadDBGridSettings(grMechBott);
  LoadDBGridSettings(grDev);
  LoadDBGridSettings(grDevBott);
  LoadDBGridSettings(grRates);
end;

procedure TfCalcResourceFact.FormDestroy(Sender: TObject);
begin
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow('Расчет стоимости ресурсов');
  fCalcResourceFact := nil;
end;

procedure TfCalcResourceFact.grMaterialBottDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TfCalcResourceFact.grMaterialCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
begin
  AllowEdit := CanEditField(Field);
end;

procedure TfCalcResourceFact.grMaterialDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  with (Sender AS TJvDBGrid).Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    if (gdSelected in State) then // Ячейка в фокусе
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
      Font.Style := Font.Style + [fsBold];
    end;
  end;
  { if (qrMaterialData.FieldByName('FCOAST').AsInteger = 1) and (Column.FieldName = 'COAST') then
    grMaterial.Canvas.Font.Style := grMaterial.Canvas.Font.Style + [fsItalic];
  }
  if qrMainData.FieldByName('DELETED').AsInteger = 1 then
    (Sender AS TJvDBGrid).Canvas.Font.Style := (Sender AS TJvDBGrid).Canvas.Font.Style + [fsStrikeOut];
  {
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
  }
  if CanEditField(Column.Field) then
    (Sender AS TJvDBGrid).Canvas.Brush.Color := clMoneyGreen;

  (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfCalcResourceFact.grMaterialTitleBtnClick(Sender: TObject; ACol: Integer; Field: TField);
var
  s: string;
begin
  if not CheckQrActiveEmpty(qrMainData) then
    Exit;
  s := '';
  if (Sender as TJvDBGrid).SortMarker = smDown then
    s := ' DESC';
  qrMainData.SQL[qrMainData.SQL.Count - 1] := 'ORDER BY ' + (Sender as TJvDBGrid).SortedField + s;
  CloseOpen(qrMainData);
end;

procedure TfCalcResourceFact.grMechBottDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
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

procedure TfCalcResourceFact.JvDBGridFooter1Calculate(Sender: TJvDBGridFooter; const FieldName: string;
  var CalcValue: Variant);
begin
  try
    if not CheckQrActiveEmpty(Sender.DataSource.DataSet) then
      Exit;
  except

  end;

  CalcValue := Footer[Sender.DataSource.DataSet.FieldByName(FieldName).Index];
end;

procedure TfCalcResourceFact.mDeteteClick(Sender: TObject);
begin
  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1, 2, 3, 4:
      begin
        if not(qrMainData.State in [dsEdit]) then
          qrMainData.Edit;
        qrMainData.FieldByName('DELETED').Value := 1;
      end;
  end;
end;

procedure TfCalcResourceFact.mRestoreClick(Sender: TObject);
begin
  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов
    1, 2, 3, 4:
      begin
        if not(qrMainData.State in [dsEdit]) then
          qrMainData.Edit;
        qrMainData.FieldByName('DELETED').Value := 0;
      end;
  end;
end;

procedure TfCalcResourceFact.N1Click(Sender: TObject);
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

procedure TfCalcResourceFact.N2Click(Sender: TObject);
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

procedure TfCalcResourceFact.pgcChange(Sender: TObject);
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
        CloseOpen(qrMainData);
        CloseOpen(qrMaterialDetail);
      end;
    // Расчет механизмов
    2:
      begin
        CloseOpen(qrMainData);
        CloseOpen(qrMechDetail);
      end;
    // Расчет оборудования
    3:
      begin
        CloseOpen(qrMainData);
        CloseOpen(qrDevicesDetail);
      end;
    // Расчет з\п
    4:
      begin
        CloseOpen(qrMainData);
      end;
  end;
end;

procedure TfCalcResourceFact.pmPopup(Sender: TObject);
begin
  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      ;
    // Расчет материалов ...
    1, 2, 3, 4:
      begin
        mDetete.Visible := qrMainData.FieldByName('DELETED').AsInteger = 0;
        mRestore.Visible := qrMainData.FieldByName('DELETED').AsInteger = 1;
      end;
  end;

end;

procedure TfCalcResourceFact.pnlCalculationYesNoClick(Sender: TObject);
begin
  with pnlCalculationYesNo do
    if Tag = 1 then
    begin
      Tag := 0;
      Color := clRed;
      Caption := 'Расчёты запрещены';
      fCalcResourceFact.Caption := 'Расчет стоимости ресурсов [редактирование запрещено]';
    end
    else
    begin
      Tag := 1;
      Color := clLime;
      Caption := 'Расчёты разрешены';
      fCalcResourceFact.Caption := 'Расчет стоимости ресурсов [редактирование разрешено]';
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

procedure TfCalcResourceFact.qrDevicesDetailBeforePost(DataSet: TDataSet);
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

procedure TfCalcResourceFact.qrMainDataAfterOpen(DataSet: TDataSet);
begin
  if CheckQrActiveEmpty(DataSet) then
    CalcFooter;
end;

procedure TfCalcResourceFact.qrMainDataBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('SM_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('SM_ID').AsInteger := IDEstimate;
  if (DataSet as TFDQuery).FindParam('NDS') <> nil then
    (DataSet as TFDQuery).ParamByName('NDS').AsInteger := cbbNDS.ItemIndex;
  if (DataSet as TFDQuery).FindParam('SHOW_DELETED') <> nil then
    (DataSet as TFDQuery).ParamByName('SHOW_DELETED').Value := mShowDeleted.Checked;

  case pgc.ActivePageIndex of
    // Расчет стоимости
    0:
      (DataSet as TFDQuery).ParamByName('TYPE_DATA').Value := 0;
    // Расчет материалов
    1:
      (DataSet as TFDQuery).ParamByName('TYPE_DATA').Value := 2;
    // Расчет механизмов
    2:
      (DataSet as TFDQuery).ParamByName('TYPE_DATA').Value := 3;
    // Расчет оборудования
    3:
      (DataSet as TFDQuery).ParamByName('TYPE_DATA').Value := 4;
    // Расчет з\п
    4:
      (DataSet as TFDQuery).ParamByName('TYPE_DATA').Value := 1;
end;

end;

procedure TfCalcResourceFact.qrMainDataPROC_PODRChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrMainDataPROC_ZAC.OnChange;
    qrMainDataPROC_ZAC.OnChange := nil;
    qrMainData.FieldByName('PROC_ZAC').Value := 100 - qrMainData.FieldByName('PROC_PODR').Value;
    qrMainDataPROC_ZAC.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResourceFact.qrMainDataPROC_ZACChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrMainDataPROC_PODR.OnChange;
    qrMainDataPROC_PODR.OnChange := nil;
    qrMainData.FieldByName('PROC_PODR').Value := 100 - qrMainData.FieldByName('PROC_ZAC').Value;
    qrMainDataPROC_PODR.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResourceFact.qrMainDataTRANSP_PROC_PODRChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrMainDataTRANSP_PROC_ZAC.OnChange;
    qrMainDataTRANSP_PROC_ZAC.OnChange := nil;
    qrMainData.FieldByName('TRANSP_PROC_ZAC').Value := 100 - qrMainData.FieldByName('TRANSP_PROC_PODR').Value;
    qrMainDataTRANSP_PROC_ZAC.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResourceFact.qrMainDataTRANSP_PROC_ZACChange(Sender: TField);
var
  e: TFieldNotifyEvent;
begin
  try
    e := qrMainDataTRANSP_PROC_PODR.OnChange;
    qrMainDataTRANSP_PROC_PODR.OnChange := nil;
    qrMainData.FieldByName('TRANSP_PROC_PODR').Value := 100 - qrMainData.FieldByName('TRANSP_PROC_ZAC').Value;
    qrMainDataTRANSP_PROC_PODR.OnChange := e;
  except
    Application.MessageBox('Установлено неверное значение!' + #13#10 +
      'Значение должно находиться в диаппазоне 0-100.', 'Смета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfCalcResourceFact.qrMaterialDetailBeforePost(DataSet: TDataSet);
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

procedure TfCalcResourceFact.qrMechDetailBeforePost(DataSet: TDataSet);
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
