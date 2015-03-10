unit BasicData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, DB, DateUtils, DBCtrls, Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Samples.Spin, System.UITypes, Vcl.Mask;

type
  TFormBasicData = class(TForm)
    LabelPercentTransportEquipment: TLabel;
    LabelK31: TLabel;
    LabelK32: TLabel;
    LabelK33: TLabel;
    EditPercentTransportEquipment: TEdit;
    EditK41: TEdit;
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
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ComboBoxMonth: TComboBox;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    LabelK41: TLabel;
    Bevel5: TBevel;
    LabelDump: TLabel;
    dblkcbbDump: TDBLookupComboBox;
    DBLookupComboBoxRegionDump: TDBLookupComboBox;
    dsDump: TDataSource;
    pmTransport: TPopupMenu;
    PopupMenuPercentTransportCity: TMenuItem;
    PopupMenuPercentTransportVillage: TMenuItem;
    PopupMenuPercentTransportMinsk: TMenuItem;
    RadioGroupCoefOrders: TRadioGroup;
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

    procedure FormShow(Sender: TObject);

    procedure ShowForm(const vIdObject, vIdEstimate: Integer);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ComboBoxMonthORYearChange(Sender: TObject);
    procedure DBLookupComboBoxRegionDumpClick(Sender: TObject);
    procedure PopupMenuPercentTransportMinskClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbchkAPPLY_LOW_COEF_OHROPR_FLAGClick(Sender: TObject);
    procedure qrSmetaAfterOpen(DataSet: TDataSet);
    // ”станавливаем флаг состо€ни€ (примен€ть/ не примен€ть) коэффициента по приказам

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

uses Main, DataModule, CalculationEstimate, Tools;

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
    MessageDlg('ƒл€ выбраных значений мас€ца и года расценки отсутствуют!'#13 +
      '”кажите мес€ц и год расценок.', mtError, [mbOK], 0);
    CanClose := False;
    exit;
  end;
  CanClose := True;
end;

procedure TFormBasicData.FormCreate(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;
  CloseOpen(qrMAIS);
end;

procedure TFormBasicData.FormShow(Sender: TObject);
var
  IdStavka: String;
  vDate: TDate;
begin
  qrSmeta.ParamByName('IdEstimate').AsInteger := IdEstimate;
  CloseOpen(qrSmeta);
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
    SQL.Add('SELECT coef_tr_zatr, coef_tr_obor, k40, k41, k31, k32, k33, k34, nds, kzp, stavka_id, date, dump_id, coef_orders '
      + 'FROM smetasourcedata WHERE sm_id = :sm_id;');
    ParamByName('sm_id').Value := IdEstimate;
    Active := True;

    case FieldByName('coef_orders').AsInteger of
      - 1:
        RadioGroupCoefOrders.ItemIndex := 2;
      0:
        RadioGroupCoefOrders.ItemIndex := 1;
      1:
        RadioGroupCoefOrders.ItemIndex := 0;
    end;

    edtPercentTransport.Text := MyFloatToStr(FieldByName('coef_tr_zatr').AsFloat);
    EditPercentTransportEquipment.Text := MyFloatToStr(FieldByName('coef_tr_obor').AsFloat);
    edtK40.Text := MyFloatToStr(FieldByName('K40').AsFloat);
    EditK41.Text := MyFloatToStr(FieldByName('K41').AsFloat);
    EditK31.Text := MyFloatToStr(FieldByName('K31').AsFloat);
    EditK32.Text := MyFloatToStr(FieldByName('K32').AsFloat);
    EditK33.Text := MyFloatToStr(FieldByName('K33').AsFloat);
    EditK34.Text := MyFloatToStr(FieldByName('K34').AsFloat);
    edtKZP.Text := MyFloatToStr(FieldByName('kzp').AsFloat);

    ComboBoxVAT.ItemIndex := FieldByName('nds').AsVariant;

    IdStavka := FieldByName('stavka_id').AsVariant;
    IdDump := FieldByName('dump_id').AsVariant;

    vDate := Now;
    ComboBoxMonth.ItemIndex := MonthOf(vDate) - 1;
    edtYear.Value := YearOf(vDate);

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
        dbedtEditRateWorker.Text := FieldByName('stavka_m_rab').AsVariant;
      edtRateMachinist.Text := FieldByName('stavka_m_mach').AsVariant;
      edtYear.OnChange := ComboBoxMonthORYearChange;
      ComboBoxMonth.OnChange := ComboBoxMonthORYearChange;
    end;
    // ----------------------------------------

    Active := False;
    SQL.Clear;
    SQL.Add('SELECT objstroj.obj_region as "IdRegion", objregion.region as "NameRegion" ' +
      'FROM objcards, objstroj, objregion WHERE objcards.stroj_id = objstroj.stroj_id and ' +
      'objstroj.obj_region = objregion.obj_region_id and objcards.obj_id = :obj_id;');
    ParamByName('obj_id').Value := IdObject;
    Active := True;

    EditRegion.Tag := FieldByName('IdRegion').AsVariant;
    EditRegion.Text := FieldByName('NameRegion').AsVariant;

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

    // ≈сли в смете свалка не указана берЄм из объекта, если указан из сметы
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
      DBLookupComboBoxRegionDump.KeyValue := ADOQueryRegionDump.FieldByName('region_id').AsVariant;

    DBLookupComboBoxRegionDumpClick(DBLookupComboBoxRegionDump);
  end;
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

procedure TFormBasicData.qrSmetaAfterOpen(DataSet: TDataSet);
begin
  pnlLowCoef.Visible := dbchkAPPLY_LOW_COEF_OHROPR_FLAG.Checked;
  if pnlLowCoef.Visible then
    Height := 575
  else
    Height := 575 - pnlLowCoef.Height;
end;

procedure TFormBasicData.ButtonSaveClick(Sender: TObject);
var
  IdStavka: Integer;
begin
  try
    { if qrSmeta.State in [dsEdit, dsInsert] then
      qrSmeta.Post; }

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
      MessageDlg('ƒл€ выбраных значений мас€ца и года расценки отсутствуют!'#13 +
        '”кажите мес€ц и год расценок.', mtError, [mbOK], 0);
      exit;
    end;

    with qrTMP do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE smetasourcedata SET stavka_id = :stavka_id, coef_tr_zatr = :coef_tr_zatr, coef_orders=:coef_orders, '
        + 'coef_tr_obor=:coef_tr_obor, k40=:k40, k41=:k41, k31=:k31, k32=:k32, k33=:k33, k34=:k34, growth_index=:growth_index, '
        + 'K_LOW_OHROPR=:K_LOW_OHROPR, K_LOW_PLAN_PRIB=:K_LOW_PLAN_PRIB, APPLY_LOW_COEF_OHROPR_FLAG=:APPLY_LOW_COEF_OHROPR_FLAG, '
        + 'nds=:nds, dump_id=:dump_id, kzp=:kzp, STAVKA_RAB=:STAVKA_RAB, MAIS_ID=:MAIS_ID, K35=:K35 WHERE sm_id = :sm_id;');

      ParamByName('stavka_id').Value := IdStavka;
      ParamByName('coef_tr_zatr').Value := edtPercentTransport.Text;
      ParamByName('coef_tr_obor').Value := EditPercentTransportEquipment.Text;
      ParamByName('k40').Value := edtK40.Text;
      ParamByName('k41').Value := EditK41.Text;
      ParamByName('k31').Value := EditK31.Text;
      ParamByName('k32').Value := EditK32.Text;
      ParamByName('k33').Value := EditK33.Text;
      ParamByName('k34').Value := EditK34.Text;
      ParamByName('K35').Value := dbedtK35.Text;
      ParamByName('kzp').Value := edtKZP.Text;
      ParamByName('nds').Value := ComboBoxVAT.ItemIndex;
      ParamByName('dump_id').Value := dblkcbbDump.KeyValue;
      ParamByName('STAVKA_RAB').Value := qrSmeta.FieldByName('STAVKA_RAB').AsVariant;
      ParamByName('K_LOW_OHROPR').Value := qrSmeta.FieldByName('K_LOW_OHROPR').Value;
      ParamByName('K_LOW_PLAN_PRIB').Value := qrSmeta.FieldByName('K_LOW_PLAN_PRIB').Value;
      ParamByName('APPLY_LOW_COEF_OHROPR_FLAG').AsInteger := qrSmeta.FieldByName('APPLY_LOW_COEF_OHROPR_FLAG')
        .AsInteger;
      ParamByName('MAIS_ID').Value := dblkcbbMAIS.KeyValue;
      ParamByName('growth_index').Value := dbedtgrowth_index.Text;
      case RadioGroupCoefOrders.ItemIndex of
        0:
          ParamByName('coef_orders').Value := 1;
        1:
          ParamByName('coef_orders').Value := 0;
        2:
          ParamByName('coef_orders').Value := -1;
      end;
      ParamByName('sm_id').Value := IdEstimate;

      ExecSQL;
    end;
    Close;
  except
    on E: Exception do
      MessageBox(0, PChar('ѕри сохранении данных возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        '»сходные данные', MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormBasicData.ButtonCancelClick(Sender: TObject);
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
    qrTMP.Active := False;
    qrTMP.SQL.Text := 'SELECT stavka_id FROM stavka WHERE year = ' + IntToStr(edtYear.Value) + ' and monat = ' +
    IntToStr(ComboBoxMonth.ItemIndex + 1) + ';';
    qrTMP.Active := True;
    qrSmeta.Edit;
    qrSmeta.FieldByName('STAVKA_ID').Value := qrTMP.FieldByName('STAVKA_ID').Value;
    qrSmeta.Post;
  }
end;

procedure TFormBasicData.dbchkAPPLY_LOW_COEF_OHROPR_FLAGClick(Sender: TObject);
begin
  pnlLowCoef.Visible := dbchkAPPLY_LOW_COEF_OHROPR_FLAG.Checked;
  if pnlLowCoef.Visible then
    Height := 575
  else
    Height := 575 - pnlLowCoef.Height;
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
