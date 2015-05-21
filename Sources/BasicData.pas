unit BasicData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, DB, DateUtils, DBCtrls, Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Samples.Spin, System.UITypes, Vcl.Mask, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.DBCGrids;

type
  TFormBasicData = class(TForm)
    LabelPercentTransportEquipment: TLabel;
    LabelK31: TLabel;
    LabelK32: TLabel;
    LabelK33: TLabel;
    EditPercentTransportEquipment: TEdit;
    EditK31: TEdit;
    EditK32: TEdit;
    EditK33: TEdit;
    EditK34: TEdit;
    LabelEstimateForDate: TLabel;
    LabelRateWorker: TLabel;
    LabelRegion: TLabel;
    EditRegion: TEdit;
    LabelVAT: TLabel;
    ComboBoxVAT: TComboBox;
    Bevel1: TBevel;
    ComboBoxMonth: TComboBox;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    LabelDump: TLabel;
    dblkcbbDump: TDBLookupComboBox;
    DBLookupComboBoxRegionDump: TDBLookupComboBox;
    dsDump: TDataSource;
    pmTransport: TPopupMenu;
    PopupMenuPercentTransportCity: TMenuItem;
    PopupMenuPercentTransportVillage: TMenuItem;
    PopupMenuPercentTransportMinsk: TMenuItem;
    DataSourceRegionDump: TDataSource;
    qrDump: TFDQuery;
    ADOQueryRegionDump: TFDQuery;
    qrTMP: TFDQuery;
    lbl1: TLabel;
    edtKZP: TEdit;
    edtYear: TSpinEdit;
    pnl1: TPanel;
    lblRateMachinist: TLabel;
    edtRateMachinist: TEdit;
    edtPercentTransport: TEdit;
    lblPercentTransport: TLabel;
    lblK: TLabel;
    edtK40: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    qrMAIS: TFDQuery;
    dsMAIS: TDataSource;
    dblkcbbMAIS: TDBLookupComboBox;
    lbl5: TLabel;
    bvl1: TBevel;
    qrSmeta: TFDQuery;
    dsSmeta: TDataSource;
    lbl2: TLabel;
    dbedtgrowth_index: TDBEdit;
    dbedtK35: TDBEdit;
    dbedtEditRateWorker: TDBEdit;
    dbchkAPPLY_LOW_COEF_OHROPR_FLAG: TDBCheckBox;
    pnlLowCoef: TPanel;
    lbl6: TLabel;
    dbedtK_LOW_OHROPR: TDBEdit;
    lbl7: TLabel;
    dbedtK_LOW_PLAN_PRIB: TDBEdit;
    dbchkcoef_orders: TDBCheckBox;
    dbchkAPPLY_WINTERPRISE_FLAG: TDBCheckBox;
    dsCoef: TDataSource;
    qrCoef: TFDQuery;
    pmCoef: TPopupMenu;
    mN1: TMenuItem;
    mN2: TMenuItem;
    edtK: TEdit;
    lblK1: TLabel;
    dbrgrpCOEF_ORDERS: TDBRadioGroup;
    pnl2: TPanel;
    lbl8: TLabel;
    grCoef: TJvDBGrid;
    pnl3: TPanel;
    btnSave: TButton;
    btnCancel: TButton;

    procedure FormShow(Sender: TObject);

    procedure ShowForm(const vIdObject, vIdEstimate: Integer);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure ComboBoxMonthORYearChange(Sender: TObject);
    procedure DBLookupComboBoxRegionDumpClick(Sender: TObject);
    procedure PopupMenuPercentTransportMinskClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbchkAPPLY_LOW_COEF_OHROPR_FLAGClick(Sender: TObject);
    procedure qrSmetaAfterOpen(DataSet: TDataSet);
    procedure dbedtEditRateWorkerEnter(Sender: TObject);
    procedure qrCoefNewRecord(DataSet: TDataSet);
    procedure mN1Click(Sender: TObject);
    procedure mN2Click(Sender: TObject);
    procedure pmCoefPopup(Sender: TObject);
    procedure qrCoefBeforeOpen(DataSet: TDataSet);
    procedure dbchkcoef_ordersClick(Sender: TObject);
    // Устанавливаем флаг состояния (применять/ не применять) коэффициента по приказам

  private
    IdObject: Integer;
    IdEstimate: Integer;
    IdDump: Variant;

    PercentTransportCity: Double;
    PercentTransportVillage: Double;
    PercentTransportMinsk: Double;
  end;

var
  FormBasicData: TFormBasicData;

implementation

uses Main, DataModule, CalculationEstimate, Tools, Coef;

{$R *.dfm}

procedure TFormBasicData.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  IdStavka: Integer;
begin
  CanClose := False;
  IdStavka := -1;

  with qrTMP do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT stavka_id FROM smetasourcedata WHERE sm_id = :sm_id;');
    ParamByName('sm_id').Value := IdEstimate;
    Active := True;
    if not Eof then
      IdStavka := FieldByName('stavka_id').AsInteger;
    Active := False;
  end;

  if IdStavka <= 0 then
  begin
    MessageDlg('Для выбраных значений масяца и года расценки отсутствуют!'#13 +
      'Укажите месяц и год расценок.', mtError, [mbOK], 0);
    CanClose := False;
    exit;
  end;
  CanClose := True;
end;

procedure TFormBasicData.FormCreate(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;
  LoadDBGridSettings(grCoef);
end;

procedure TFormBasicData.FormShow(Sender: TObject);
var
  IdStavka: String;
  REGION_ID: Variant;
begin
  qrSmeta.Active := False;
  qrSmeta.ParamByName('IdEstimate').AsInteger := IdEstimate;
  qrSmeta.Active := True;
  CloseOpen(qrCoef);
  CloseOpen(qrMAIS);

  with qrTMP do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM objregion ORDER BY obj_region_id;');
    Active := True;

    First;
    PercentTransportCity := FieldByName('percent_transport').AsVariant;
    PopupMenuPercentTransportCity.Caption := FieldByName('region').AsVariant + ' - ' +
      MyFloatToStr(PercentTransportCity) + '%';

    Next;
    PercentTransportVillage := FieldByName('percent_transport').AsVariant;
    PopupMenuPercentTransportVillage.Caption := FieldByName('region').AsVariant + ' - ' +
      MyFloatToStr(PercentTransportVillage) + '%';

    Next;
    PercentTransportMinsk := FieldByName('percent_transport').AsVariant;
    PopupMenuPercentTransportMinsk.Caption := FieldByName('region').AsVariant + ' - ' +
      MyFloatToStr(PercentTransportMinsk) + '%';
  end;

  // ----------------------------------------

  with qrTMP do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT coef_tr_zatr, coef_tr_obor, k40, k41, k31, k32, k33, k34, IFNULL(nds, 0) AS NDS, kzp, stavka_id, date, dump_id, coef_orders '
      + 'FROM smetasourcedata WHERE sm_id = :sm_id;');
    ParamByName('sm_id').Value := IdEstimate;
    Active := True;

    edtPercentTransport.Text := MyFloatToStr(FieldByName('coef_tr_zatr').AsFloat);
    EditPercentTransportEquipment.Text := MyFloatToStr(FieldByName('coef_tr_obor').AsFloat);
    edtK40.Text := MyFloatToStr(FieldByName('K40').AsFloat);
    // EditK41.Text := MyFloatToStr(FieldByName('K41').AsFloat);
    EditK31.Text := MyFloatToStr(FieldByName('K31').AsFloat);
    EditK32.Text := MyFloatToStr(FieldByName('K32').AsFloat);
    EditK33.Text := MyFloatToStr(FieldByName('K33').AsFloat);
    EditK34.Text := MyFloatToStr(FieldByName('K34').AsFloat);
    edtKZP.Text := MyFloatToStr(FieldByName('kzp').AsFloat);

    ComboBoxVAT.ItemIndex := FieldByName('nds').AsVariant;

    IdStavka := FieldByName('stavka_id').AsVariant;
    IdDump := FieldByName('dump_id').AsVariant;

    { vDate := Now;
      ComboBoxMonth.ItemIndex := MonthOf(vDate) - 1;
      edtYear.Value := YearOf(vDate); }

    // ----------------------------------------

    Active := False;
    SQL.Clear;
    SQL.Add('SELECT monat, year, stavka_m_rab, stavka_m_mach FROM stavka WHERE stavka_id = :stavka_id;');
    ParamByName('stavka_id').Value := IdStavka;
    Active := True;

    if not Eof then
    begin
      edtYear.OnChange := nil;
      ComboBoxMonth.OnChange := nil;
      ComboBoxMonth.ItemIndex := FieldByName('monat').AsInteger - 1;
      edtYear.Value := FieldByName('year').AsInteger;
      if VarIsNull(qrSmeta.FieldByName('STAVKA_RAB').Value) then
        qrSmeta.FieldByName('STAVKA_RAB').Value := FieldByName('stavka_m_rab').AsVariant;
      edtRateMachinist.Text := FieldByName('stavka_m_mach').AsVariant;
      edtYear.OnChange := ComboBoxMonthORYearChange;
      ComboBoxMonth.OnChange := ComboBoxMonthORYearChange;
    end;
    // ----------------------------------------

    Active := False;
    SQL.Clear;
    SQL.Add('SELECT objcards.REGION_ID, objstroj.obj_region as "IdRegion", objregion.region as "NameRegion" '
      + 'FROM objcards, objstroj, objregion WHERE objcards.stroj_id = objstroj.stroj_id and ' +
      'objstroj.obj_region = objregion.obj_region_id and objcards.obj_id = :obj_id;');
    ParamByName('obj_id').Value := IdObject;
    Active := True;

    EditRegion.Tag := FieldByName('IdRegion').AsVariant;
    EditRegion.Text := FieldByName('NameRegion').AsVariant;
    REGION_ID := FieldByName('REGION_ID').Value;

    // ----------------------------------------

    with ADOQueryRegionDump, DBLookupComboBoxRegionDump do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT region_id, region_name FROM regions ORDER BY 2');
      Active := True;

      First;
      ListSource := DataSourceRegionDump;
      ListField := 'region_name';
      KeyField := 'region_id';
    end;

    // Если в смете свалка не указана берём из объекта, если указан из сметы
    if IdDump <> NULL then
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT region_id FROM dump WHERE dump_id = :dump_id;');
      ParamByName('dump_id').Value := IdDump;
      Active := True;

      DBLookupComboBoxRegionDump.KeyValue := FieldByName('region_id').AsVariant;
    end
    else
      DBLookupComboBoxRegionDump.KeyValue := REGION_ID;

    DBLookupComboBoxRegionDumpClick(DBLookupComboBoxRegionDump);
  end;
end;

procedure TFormBasicData.mN1Click(Sender: TObject);
begin
  qrCoef.CheckBrowseMode;
  qrCoef.Append;
end;

procedure TFormBasicData.mN2Click(Sender: TObject);
begin
  if Application.MessageBox('Удалить запись?', 'Вопрос', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    qrCoef.CheckBrowseMode;

    // Каскадное удаление наборав из связанных смет
    DM.qrDifferent.SQL.Text := 'DELETE FROM calculation_coef WHERE id_estimate IN '#13 +
      '(SELECT SM_ID FROM smetasourcedata WHERE (PARENT_ID=:ID_ESTIMATE)'#13 +
      ' OR (PARENT_ID IN (SELECT SM_ID FROM smetasourcedata WHERE PARENT_ID = :ID_ESTIMATE)))'#13 +
      ' AND id_type_data=:id_type_data AND id_owner=0 AND id_coef=:id_coef';

    DM.qrDifferent.ParamByName('id_estimate').Value := qrCoef.FieldByName('id_estimate').Value;
    DM.qrDifferent.ParamByName('id_type_data').Value := qrCoef.FieldByName('id_type_data').Value;
    DM.qrDifferent.ParamByName('id_coef').Value := qrCoef.FieldByName('id_coef').Value;
    DM.qrDifferent.ExecSQL;

    qrCoef.Delete;
  end;
end;

procedure TFormBasicData.pmCoefPopup(Sender: TObject);
begin
  mN2.Enabled := CheckQrActiveEmpty(qrCoef);
end;

procedure TFormBasicData.ShowForm(const vIdObject, vIdEstimate: Integer);
begin
  IdObject := vIdObject;
  IdEstimate := vIdEstimate;

  ShowModal;
end;

procedure TFormBasicData.PopupMenuPercentTransportMinskClick(Sender: TObject);
begin
  with edtPercentTransport do
    case (Sender as TMenuItem).Tag of
      1:
        Text := MyFloatToStr(PercentTransportCity);
      2:
        Text := MyFloatToStr(PercentTransportVillage);
      3:
        Text := MyFloatToStr(PercentTransportMinsk);
    end;
end;

procedure TFormBasicData.qrCoefBeforeOpen(DataSet: TDataSet);
begin
  qrCoef.SQL.Text := StringReplace(qrCoef.SQL.Text, '`calculation_coef_temp`', '`calculation_coef`',
    [rfReplaceAll, rfIgnoreCase]);
  if Assigned(FormCalculationEstimate) then
    qrCoef.SQL.Text := StringReplace(qrCoef.SQL.Text, '`calculation_coef`', '`calculation_coef_temp`',
      [rfReplaceAll, rfIgnoreCase]);
end;

procedure TFormBasicData.qrCoefNewRecord(DataSet: TDataSet);
begin
  // Показываем справочник наборов коэф.
  if fCoefficients.ShowModal = mrOk then
  begin
    qrCoef.FieldByName('id_estimate').Value := qrSmeta.FieldByName('SM_ID').Value;
    qrCoef.FieldByName('id_type_data').Value := qrSmeta.FieldByName('SM_TYPE').Value * -1;
    qrCoef.FieldByName('id_owner').Value := 0;
    qrCoef.FieldByName('id_coef').Value := fCoefficients.qrCoef.FieldByName('coef_id').Value;
    qrCoef.FieldByName('COEF_NAME').Value := fCoefficients.qrCoef.FieldByName('COEF_NAME').Value;
    qrCoef.FieldByName('OSN_ZP').Value := fCoefficients.qrCoef.FieldByName('OSN_ZP').Value;
    qrCoef.FieldByName('EKSP_MACH').Value := fCoefficients.qrCoef.FieldByName('EKSP_MACH').Value;
    qrCoef.FieldByName('MAT_RES').Value := fCoefficients.qrCoef.FieldByName('MAT_RES').Value;
    qrCoef.FieldByName('WORK_PERS').Value := fCoefficients.qrCoef.FieldByName('WORK_PERS').Value;
    qrCoef.FieldByName('WORK_MACH').Value := fCoefficients.qrCoef.FieldByName('WORK_MACH').Value;
    qrCoef.FieldByName('OXROPR').Value := fCoefficients.qrCoef.FieldByName('OXROPR').Value;
    qrCoef.FieldByName('PLANPRIB').Value := fCoefficients.qrCoef.FieldByName('PLANPRIB').Value;
    qrCoef.Post;
    // Каскадно добавляем выбранный кф. на все зависимые сметы
    DM.qrDifferent.SQL.Text := 'INSERT INTO `calculation_coef`(`id_estimate`, `id_type_data`, `id_owner`,'#13
      + ' `id_coef`, `COEF_NAME`, `OSN_ZP`, `EKSP_MACH`, `MAT_RES`, `WORK_PERS`,'#13 +
      '  `WORK_MACH`, `OXROPR`, `PLANPRIB`)'#13 + 'VALUE(:id_estimate,:id_type_data,:id_owner,'#13 +
      ':id_coef,:COEF_NAME,:OSN_ZP,:EKSP_MACH,:MAT_RES,:WORK_PERS,:WORK_MACH,:OXROPR,:PLANPRIB)';
    DM.qrDifferent.ParamByName('id_type_data').Value := qrSmeta.FieldByName('SM_TYPE').Value * -1;
    DM.qrDifferent.ParamByName('id_owner').Value := 0;
    DM.qrDifferent.ParamByName('id_coef').Value := fCoefficients.qrCoef.FieldByName('coef_id').Value;
    DM.qrDifferent.ParamByName('COEF_NAME').Value := fCoefficients.qrCoef.FieldByName('COEF_NAME').Value;
    DM.qrDifferent.ParamByName('OSN_ZP').Value := fCoefficients.qrCoef.FieldByName('OSN_ZP').Value;
    DM.qrDifferent.ParamByName('EKSP_MACH').Value := fCoefficients.qrCoef.FieldByName('EKSP_MACH').Value;
    DM.qrDifferent.ParamByName('MAT_RES').Value := fCoefficients.qrCoef.FieldByName('MAT_RES').Value;
    DM.qrDifferent.ParamByName('WORK_PERS').Value := fCoefficients.qrCoef.FieldByName('WORK_PERS').Value;
    DM.qrDifferent.ParamByName('WORK_MACH').Value := fCoefficients.qrCoef.FieldByName('WORK_MACH').Value;
    DM.qrDifferent.ParamByName('OXROPR').Value := fCoefficients.qrCoef.FieldByName('OXROPR').Value;
    DM.qrDifferent.ParamByName('PLANPRIB').Value := fCoefficients.qrCoef.FieldByName('PLANPRIB').Value;

    DM.qrDifferent1.Active := False;
    DM.qrDifferent1.SQL.Text := 'SELECT SM_ID FROM smetasourcedata WHERE (PARENT_ID=:ID_ESTIMATE)'#13 +
      ' OR (PARENT_ID IN (SELECT SM_ID FROM smetasourcedata WHERE PARENT_ID = :ID_ESTIMATE))';
    DM.qrDifferent1.ParamByName('ID_ESTIMATE').Value := qrSmeta.FieldByName('SM_ID').Value;
    DM.qrDifferent1.Active := True;
    DM.qrDifferent1.First;
    while not DM.qrDifferent1.Eof do
    begin
      DM.qrDifferent.ParamByName('id_estimate').Value := DM.qrDifferent1.FieldByName('SM_ID').Value;
      DM.qrDifferent.ExecSQL;
      DM.qrDifferent1.Next;
    end;
    DM.qrDifferent1.Active := False;
  end
  else
    qrCoef.Cancel;
end;

procedure TFormBasicData.qrSmetaAfterOpen(DataSet: TDataSet);
var
  pnlLowCoef_Visible, dbrgrpCOEF_ORDERS_Visible: Integer;
begin
  pnlLowCoef.Visible := dbchkAPPLY_LOW_COEF_OHROPR_FLAG.Checked;
  dbrgrpCOEF_ORDERS.Visible := dbchkAPPLY_WINTERPRISE_FLAG.Checked;

  if pnlLowCoef.Visible then
    pnlLowCoef_Visible := 0
  else
    pnlLowCoef_Visible := 1;

  if dbrgrpCOEF_ORDERS.Visible then
    dbrgrpCOEF_ORDERS_Visible := 0
  else
    dbrgrpCOEF_ORDERS_Visible := 1;

  Height := 670 - pnlLowCoef.Height * pnlLowCoef_Visible - dbrgrpCOEF_ORDERS.Height *
    dbrgrpCOEF_ORDERS_Visible;
end;

procedure TFormBasicData.btnSaveClick(Sender: TObject);
var
  IdStavka: Integer;
begin
  try
    { if qrSmeta.State in [dsEdit, dsInsert] then
      qrSmeta.Post; }
    if qrCoef.State in [dsEdit, dsInsert] then
      qrCoef.Post;

    IdStavka := -1;
    with qrTMP do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT stavka_id FROM stavka WHERE year = :year and monat = :monat;');
      ParamByName('year').Value := edtYear.Value;
      ParamByName('monat').Value := ComboBoxMonth.ItemIndex + 1;
      Active := True;
      if not Eof then
        IdStavka := FieldByName('stavka_id').AsInteger;
    end;

    if IdStavka <= 0 then
    begin
      MessageDlg('Для выбраных значений масяца и года расценки отсутствуют!'#13 +
        'Укажите месяц и год расценок.', mtError, [mbOK], 0);
      exit;
    end;

    with qrTMP do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE smetasourcedata SET stavka_id = :stavka_id, coef_tr_zatr = :coef_tr_zatr, coef_orders=:coef_orders, '
        + 'coef_tr_obor=:coef_tr_obor, k40=:k40, k41=:k41, k31=:k31, k32=:k32, k33=:k33, k34=:k34, growth_index=:growth_index, '
        + 'K_LOW_OHROPR=:K_LOW_OHROPR, K_LOW_PLAN_PRIB=:K_LOW_PLAN_PRIB, APPLY_LOW_COEF_OHROPR_FLAG=:APPLY_LOW_COEF_OHROPR_FLAG, '
        + 'nds=:nds, dump_id=:dump_id, kzp=:kzp, STAVKA_RAB=:STAVKA_RAB, MAIS_ID=:MAIS_ID, K35=:K35, APPLY_WINTERPRISE_FLAG=:APPLY_WINTERPRISE_FLAG, '
        + 'WINTERPRICE_TYPE=:WINTERPRICE_TYPE ' + 'WHERE sm_id = :sm_id;');

      ParamByName('stavka_id').Value := IdStavka;
      ParamByName('coef_tr_zatr').Value := edtPercentTransport.Text;
      ParamByName('coef_tr_obor').Value := EditPercentTransportEquipment.Text;
      ParamByName('k40').Value := edtK40.Text;
      // ParamByName('k41').Value := EditK41.Text;
      ParamByName('k31').Value := EditK31.Text;
      ParamByName('k32').Value := EditK32.Text;
      ParamByName('k33').Value := EditK33.Text;
      ParamByName('k34').Value := EditK34.Text;
      ParamByName('K35').Value := dbedtK35.Text;
      ParamByName('kzp').Value := edtKZP.Text;
      ParamByName('nds').Value := ComboBoxVAT.ItemIndex;
      ParamByName('dump_id').Value := dblkcbbDump.KeyValue;
      ParamByName('STAVKA_RAB').Value := qrSmeta.FieldByName('STAVKA_RAB').Value;
      ParamByName('K_LOW_OHROPR').Value := qrSmeta.FieldByName('K_LOW_OHROPR').Value;
      ParamByName('K_LOW_PLAN_PRIB').Value := qrSmeta.FieldByName('K_LOW_PLAN_PRIB').Value;
      ParamByName('APPLY_LOW_COEF_OHROPR_FLAG').AsInteger := qrSmeta.FieldByName('APPLY_LOW_COEF_OHROPR_FLAG')
        .AsInteger;
      ParamByName('APPLY_WINTERPRISE_FLAG').AsInteger := qrSmeta.FieldByName('APPLY_WINTERPRISE_FLAG')
        .AsInteger;
      ParamByName('MAIS_ID').Value := dblkcbbMAIS.KeyValue;
      ParamByName('growth_index').Value := dbedtgrowth_index.Text;
      ParamByName('coef_orders').Value := qrSmeta.FieldByName('coef_orders').AsInteger;
      ParamByName('WINTERPRICE_TYPE').Value := qrSmeta.FieldByName('WINTERPRICE_TYPE').AsInteger;
      ParamByName('sm_id').Value := IdEstimate;
      ExecSQL;
      // Обновляем все зависимые сметы до самого низкого уровня
      if Application.MessageBox('Обновить исходные данные всех зависмых смет?', 'Вопрос',
        MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
      begin
        SQL.Text := 'CALL `UPDATE_SMETASOURCEDATA_CHILD`(:sm_id);';
        ParamByName('sm_id').Value := IdEstimate;
        ExecSQL;
      end;
    end;
    Close;
  except
    on E: Exception do
      MessageBox(0, PChar('При сохранении данных возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        'Исходные данные', MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormBasicData.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormBasicData.ComboBoxMonthORYearChange(Sender: TObject);
var
  vYear, vMonth: String;
begin
  edtRateMachinist.Text := '';

  vMonth := IntToStr(ComboBoxMonth.ItemIndex + 1);
  vYear := IntToStr(edtYear.Value);

  with qrTMP do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT stavka_m_rab as "RateWorker", stavka_m_mach as "RateMachinist" FROM stavka WHERE year = '
      + vYear + ' and monat = ' + vMonth + ';');
    Active := True;
    if not Eof then
    begin
      qrSmeta.FieldByName('STAVKA_RAB').AsVariant := FieldByName('RateWorker').AsVariant;
      edtRateMachinist.Text := FieldByName('RateMachinist').AsVariant;
    end;
  end;
  {
  if Application.MessageBox('Произвести замену индекса роста цен из справочника?', 'Смета',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    qrSmeta.FieldByName('growth_index').Value := GetUniDictParamValue('GROWTH_INDEX',
      (ComboBoxMonth.ItemIndex + 1), edtYear.Value);
  end;
  }
end;

procedure TFormBasicData.dbchkAPPLY_LOW_COEF_OHROPR_FLAGClick(Sender: TObject);
var
  pnlLowCoef_Visible, dbrgrpCOEF_ORDERS_Visible: Integer;
begin
  pnlLowCoef.Visible := dbchkAPPLY_LOW_COEF_OHROPR_FLAG.Checked;
  dbrgrpCOEF_ORDERS.Visible := dbchkAPPLY_WINTERPRISE_FLAG.Checked;

  if pnlLowCoef.Visible then
    pnlLowCoef_Visible := 0
  else
    pnlLowCoef_Visible := 1;

  if dbrgrpCOEF_ORDERS.Visible then
    dbrgrpCOEF_ORDERS_Visible := 0
  else
    dbrgrpCOEF_ORDERS_Visible := 1;

  Height := 670 - pnlLowCoef.Height * pnlLowCoef_Visible - dbrgrpCOEF_ORDERS.Height *
    dbrgrpCOEF_ORDERS_Visible;
end;

procedure TFormBasicData.dbchkcoef_ordersClick(Sender: TObject);
begin
  if not CheckQrActiveEmpty(qrSmeta) then
    exit;
  if dbchkcoef_orders.Checked then
  begin
    edtKZP.Text := FloatToStr(GetUniDictParamValue('K_KORR_ZP', (ComboBoxMonth.ItemIndex + 1),
      edtYear.Value));
  end
  else
  begin
    edtKZP.Text := '1';
  end;
end;

procedure TFormBasicData.dbedtEditRateWorkerEnter(Sender: TObject);
begin
  qrSmeta.FieldByName('STAVKA_RAB').Value := dbedtEditRateWorker.Text;
end;

procedure TFormBasicData.DBLookupComboBoxRegionDumpClick(Sender: TObject);
begin
  with qrDump, dblkcbbDump do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT dump_id, dump_name FROM dump WHERE region_id = :region_id ORDER BY 2;');
    ParamByName('region_id').Value := DBLookupComboBoxRegionDump.KeyValue;
    Active := True;

    ListSource := dsDump;
    ListField := 'dump_name';
    KeyField := 'dump_id';

    if IdDump = NULL then
      KeyValue := FieldByName('dump_id').AsVariant
    else
      KeyValue := IdDump;
  end;
end;

end.
