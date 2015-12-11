unit CalculationEstimateSummaryCalculations;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Tools, Vcl.Menus, JvDBGrid, JvExDBGrids, JvComponentBase, JvFormPlacement, System.UITypes, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.Buttons, System.DateUtils, Vcl.Samples.Spin;

type
  TfrCalculationEstimateSummaryCalculations = class(TFrame)
    grSummaryCalculation: TJvDBGrid;
    qrData: TFDQuery;
    dsData: TDataSource;
    pm: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    FormStorage: TJvFormStorage;
    UpdateSQL: TFDUpdateSQL;
    mN3: TMenuItem;
    mN4: TMenuItem;
    mN5: TMenuItem;
    mN6: TMenuItem;
    mN7: TMenuItem;
    pnlIndex: TPanel;
    dbchkFL_APPLY_INDEX: TDBCheckBox;
    dblkcbbindex_type_id: TDBLookupComboBox;
    lbl1: TLabel;
    dblkcbbindex_type_date_id: TDBLookupComboBox;
    lbl2: TLabel;
    dbedtindex_type_id: TDBEdit;
    pnl2: TPanel;
    img1: TImage;
    qrIndexType: TFDQuery;
    dsIndexType: TDataSource;
    qrIndexTypeDate: TFDQuery;
    dsIndexTypeDate: TDataSource;
    qrObject: TFDQuery;
    dsObject: TDataSource;
    btnSaveIndex: TBitBtn;
    btnCancelIndex: TBitBtn;
    grp1: TGroupBox;
    cbbMonthBeginStroj: TComboBox;
    seYearBeginStroj: TSpinEdit;
    grp2: TGroupBox;
    seYearEndStroj: TSpinEdit;
    cbbMonthEndStroj: TComboBox;
    grp3: TGroupBox;
    cbbMonthSmeta: TComboBox;
    seYearSmeta: TSpinEdit;
    procedure grSummaryCalculationDblClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure grSummaryCalculationCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
    procedure grSummaryCalculationDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure qrDataAfterPost(DataSet: TDataSet);
    procedure mN3Click(Sender: TObject);
    procedure qrDataAfterCancel(DataSet: TDataSet);
    procedure mN4Click(Sender: TObject);
    procedure pmPopup(Sender: TObject);
    procedure mN5Click(Sender: TObject);
    procedure mN6Click(Sender: TObject);
    procedure mN7Click(Sender: TObject);
    procedure img1Click(Sender: TObject);
    procedure dbchkFL_APPLY_INDEXClick(Sender: TObject);
    procedure btnCancelIndexClick(Sender: TObject);
    procedure btnSaveIndexClick(Sender: TObject);
    procedure qrObjectBeforeEdit(DataSet: TDataSet);
    procedure dblkcbbindex_type_idClick(Sender: TObject);
    procedure qrObjectAfterOpen(DataSet: TDataSet);
  private
    SM_ID: Integer;
    SkipReload: Boolean;
    function CanEditField(Field: TField): Boolean;
  public
    function LoadData(const Args: Variant): Boolean;
  end;

implementation

{$R *.dfm}

uses BasicData, CardObject, Main, CalculationEstimate, TravelList;

procedure TfrCalculationEstimateSummaryCalculations.btnCancelIndexClick(Sender: TObject);
begin
  qrObject.Cancel;
end;

procedure TfrCalculationEstimateSummaryCalculations.btnSaveIndexClick(Sender: TObject);
begin
  qrObject.Post;
end;

function TfrCalculationEstimateSummaryCalculations.CanEditField(Field: TField): Boolean;
begin
  Result := False;

  if not CheckQrActiveEmpty(qrData) or (qrData.FieldByName('sm_type').AsInteger <> 3) or
    (FormCalculationEstimate.PanelCalculationYesNo.Tag = 0) or (Field = grSummaryCalculation.Columns[0].Field)
    or (Field = grSummaryCalculation.Columns[1].Field) or (Field = grSummaryCalculation.Columns[2].Field) or
    (Field = grSummaryCalculation.Columns[3].Field) or (Field = grSummaryCalculation.Columns[40].Field) then
    Exit;

  Result := True;
end;

procedure TfrCalculationEstimateSummaryCalculations.dbchkFL_APPLY_INDEXClick(Sender: TObject);
begin
  dblkcbbindex_type_id.Enabled := dbchkFL_APPLY_INDEX.Checked;
  dblkcbbindex_type_date_id.Enabled := dbchkFL_APPLY_INDEX.Checked;
  dbedtindex_type_id.Enabled := dbchkFL_APPLY_INDEX.Checked;
end;

procedure TfrCalculationEstimateSummaryCalculations.dblkcbbindex_type_idClick(Sender: TObject);
var
  index: Double;
  i, k, fromMonth, fromYear, toMonth, toYear, endStroj: Integer;
begin
  // Процедура расчета индекса
  if SkipReload then
    Exit;

  index := 1;
  k := 1;

  fromMonth := cbbMonthSmeta.ItemIndex + 1;
  fromYear := seYearSmeta.Value;
  toMonth := cbbMonthBeginStroj.ItemIndex + 1;
  toYear := seYearBeginStroj.Value;
  //endStroj := toMonth + toYear * 12 + qrObject.FieldByName('SROK_STROJ').AsInteger;
  endStroj := cbbMonthEndStroj.ItemIndex + seYearEndStroj.Value * 12 + 2;

  if qrObject.FieldByName('index_type_id').AsInteger = 2 then
    k := 100;

  try
    case qrObject.FieldByName('index_type_date_id').Value of
      // На дату составления сметы
      1:
        begin
          qrObject.FieldByName('index_value').Value := index;
        end;
      // На дату начала строительства
      2:
        begin
          // Цикл от даты составления сметы до начала строительства
          for i := fromMonth + fromYear * 12 to toMonth + toYear * 12 - 1 do
          begin
            index := index * GetUniDictParamValue(qrIndexType.FieldByName('unidictparam_code').AsString,
              fromMonth, fromYear) / k;
            if fromMonth = 12 then
            begin
              fromMonth := 1;
              fromYear := fromYear + 1;
            end
            else
              fromMonth := fromMonth + 1;
          end;
        end;
      // На дату окончания строительства
      3:
        begin
          // Цикл от даты составления сметы до окончания строительства
          for i := fromMonth + fromYear * 12 to endStroj - 1 do
          begin
            index := index * GetUniDictParamValue(qrIndexType.FieldByName('unidictparam_code').AsString,
              fromMonth, fromYear) / k;
            if fromMonth = 12 then
            begin
              fromMonth := 1;
              fromYear := fromYear + 1;
            end
            else
              fromMonth := fromMonth + 1;
          end;
        end;
    end;
    qrObject.Edit;
    qrObject.FieldByName('index_value').Value :=
      FastSelectSQLOne('SELECT ROUND(:x, round_INDEX) FROM round_setup LIMIT 1', VarArrayOf([index]));
  except
    qrObject.FieldByName('index_value').Value := 1;
  end;
end;

procedure TfrCalculationEstimateSummaryCalculations.grSummaryCalculationCanEditCell(Grid: TJvDBGrid;
  Field: TField; var AllowEdit: Boolean);
begin
  AllowEdit := CanEditField(Field);
end;

procedure TfrCalculationEstimateSummaryCalculations.grSummaryCalculationDblClick(Sender: TObject);
var
  Key: Variant;
begin
  Key := qrData.FieldByName('id_estimate').Value;
  FormBasicData.ShowForm(qrData.FieldByName('OBJ_ID').AsInteger, qrData.FieldByName('id_estimate').AsInteger);
  LoadData(VarArrayOf([SM_ID, qrData.FieldByName('OBJ_ID').AsInteger]));
  qrData.Locate('id_estimate', Key, []);
end;

procedure TfrCalculationEstimateSummaryCalculations.grSummaryCalculationDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with grSummaryCalculation.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    if not CanEditField(Column.Field) then
      Brush.Color := $00E1DFE0;

    if qrData.FieldByName('sm_type').AsInteger = 1 then
      Brush.Color := clSilver;

    if qrData.FieldByName('sm_type').AsInteger = 2 then
    begin
      Font.Style := Font.Style + [fsbold];
      Brush.Color := clSilver;
    end;

    // Строка в фокусе
    if (Assigned(TMyDBGrid((Sender AS TJvDBGrid)).DataLink) and
      ((Sender AS TJvDBGrid).Row = TMyDBGrid((Sender AS TJvDBGrid)).DataLink.ActiveRecord + 1)) then
    begin
      Brush.Color := PS.BackgroundSelectRow;
      Font.Color := PS.FontSelectRow;
    end;
    // Ячейка в фокусе
    if (gdSelected in State) then
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
      Font.Style := Font.Style + [fsbold];
    end;

    if (not Column.ReadOnly) and (qrData.FieldByName(Column.FieldName).Value <>
      qrData.FieldByName(Column.FieldName + 'F').Value) then
      Font.Color := clRed;
  end;
  grSummaryCalculation.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrCalculationEstimateSummaryCalculations.img1Click(Sender: TObject);
begin
  pnlIndex.Visible := not pnlIndex.Visible;
end;

function TfrCalculationEstimateSummaryCalculations.LoadData(const Args: Variant): Boolean;
begin
  Result := True;
  try
    SkipReload := True;
    grp1.Enabled := PS.AllowObjectDatesChange;
    grp2.Enabled := PS.AllowObjectDatesChange;
    grp3.Enabled := PS.AllowObjectDatesChange;
    qrData.Active := False;
    qrData.ParamByName('SM_ID').Value := Args[0];
    qrData.Active := True;
    SM_ID := Args[0];
    qrIndexType.Active := False;
    qrIndexType.Active := True;
    qrIndexTypeDate.Active := False;
    qrIndexTypeDate.Active := True;
    qrObject.Active := False;
    qrObject.ParamByName('OBJ_ID').Value := Args[1];
    qrObject.Active := True;
    SkipReload := False;
  except
    Result := False;
  end;
end;

procedure TfrCalculationEstimateSummaryCalculations.mN3Click(Sender: TObject);
begin
  grSummaryCalculation.Options := grSummaryCalculation.Options + [dgEditing];
  qrData.Edit;
end;

procedure TfrCalculationEstimateSummaryCalculations.mN4Click(Sender: TObject);
begin
  if CanEditField(grSummaryCalculation.SelectedField) then
  begin
    qrData.Edit;
    qrData.FieldByName(grSummaryCalculation.SelectedField.FieldName).Value := Null;
    qrData.Post;
  end;
end;

procedure TfrCalculationEstimateSummaryCalculations.mN5Click(Sender: TObject);
var
  i: Integer;
begin
  if Application.MessageBox('Вы действительно хотите сбросить все значения строки на стандартные?',
    'Сводный расчет', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    qrData.Edit;
    for i := 4 to grSummaryCalculation.Columns.Count - 1 do
      if grSummaryCalculation.Columns[i].Field <> nil then
        qrData.FieldByName(grSummaryCalculation.Columns[i].Field.FieldName).Value := Null;
    qrData.Post;
  end;
end;

procedure TfrCalculationEstimateSummaryCalculations.mN6Click(Sender: TObject);
var
  Key: Variant;
  i: Integer;
  SQL, sep: string;
begin
  if Application.MessageBox('Вы действительно хотите сбросить все значения на стандартные?', 'Сводный расчет',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    qrData.DisableControls;
    try
      Key := qrData.Fields[0].Value;
      qrData.First;
      while not qrData.Eof do
      begin
        if qrData.FieldByName('sm_type').AsInteger = 3 then
        begin
          SQL := '';
          sep := ',';
          for i := 4 to grSummaryCalculation.Columns.Count - 1 do
          begin
            if i = (grSummaryCalculation.Columns.Count - 1) then
              sep := '';
            if grSummaryCalculation.Columns[i].Field <> nil then
              SQL := SQL + grSummaryCalculation.Columns[i].Field.FieldName + 'F=NULL' + sep + ''#13;
          end;
          FastExecSQL('UPDATE summary_calculation SET'#13 + SQL + 'WHERE SM_ID=:0',
            VarArrayOf([qrData.FieldByName('id_estimate').Value]));
        end;
        qrData.Next;
      end;
    finally
      qrData.Locate(qrData.Fields[0].FieldName, Key, []);
      CloseOpen(qrData);
      qrData.EnableControls;
    end;
  end;
end;

procedure TfrCalculationEstimateSummaryCalculations.mN7Click(Sender: TObject);
begin
  if (not Assigned(fTravelList)) then
    fTravelList := TfTravelList.Create(Self);
  fTravelList.Show;
end;

procedure TfrCalculationEstimateSummaryCalculations.N5Click(Sender: TObject);
var fCardObject: TfCardObject;
begin
  fCardObject := TfCardObject.Create(Self);
  try
    fCardObject.IdObject := qrObject.FieldByName('OBJ_ID').Value;
    fCardObject.ShowModal;
  finally
    FreeAndNil(fCardObject);
  end;
end;

procedure TfrCalculationEstimateSummaryCalculations.pmPopup(Sender: TObject);
begin
  mN3.Visible := FormCalculationEstimate.PanelCalculationYesNo.Tag = 1;
  mN4.Visible := CanEditField(grSummaryCalculation.SelectedField);
  mN5.Visible := FormCalculationEstimate.PanelCalculationYesNo.Tag = 1;
  mN6.Visible := FormCalculationEstimate.PanelCalculationYesNo.Tag = 1;
end;

procedure TfrCalculationEstimateSummaryCalculations.qrDataAfterCancel(DataSet: TDataSet);
begin
  grSummaryCalculation.Options := grSummaryCalculation.Options - [dgEditing];
end;

procedure TfrCalculationEstimateSummaryCalculations.qrDataAfterPost(DataSet: TDataSet);
begin
  CloseOpen(qrData);
  grSummaryCalculation.Options := grSummaryCalculation.Options - [dgEditing];
end;

procedure TfrCalculationEstimateSummaryCalculations.qrObjectAfterOpen(DataSet: TDataSet);
var
  endDate: TDate;
begin
  btnSaveIndex.Visible := False;
  btnCancelIndex.Visible := False;

  dbchkFL_APPLY_INDEXClick(nil);
  endDate := IncMonth(qrObject.FieldByName('BEG_STROJ2').AsDateTime, qrObject.FieldByName('SROK_STROJ')
    .AsInteger - 1);
  cbbMonthSmeta.ItemIndex := MonthOf(qrObject.FieldByName('BEG_STROJ').AsDateTime) - 1;
  seYearSmeta.Value := YearOf(qrObject.FieldByName('BEG_STROJ').AsDateTime);
  cbbMonthBeginStroj.ItemIndex := MonthOf(qrObject.FieldByName('BEG_STROJ2').AsDateTime) - 1;
  seYearBeginStroj.Value := YearOf(qrObject.FieldByName('BEG_STROJ2').AsDateTime);
  cbbMonthEndStroj.ItemIndex := MonthOf(endDate) - 1;
  seYearEndStroj.Value := YearOf(endDate);

  CloseOpen(qrData);
end;

procedure TfrCalculationEstimateSummaryCalculations.qrObjectBeforeEdit(DataSet: TDataSet);
begin
  btnSaveIndex.Visible := True;
  btnCancelIndex.Visible := True;
end;

end.
