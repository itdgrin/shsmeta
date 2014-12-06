unit BasicData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, DB,
  DateUtils, DBCtrls, Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormBasicData = class(TForm)
    LabelPercentTransportEquipment: TLabel;
    LabelK40: TLabel;
    LabelK31: TLabel;
    LabelK32: TLabel;
    LabelK33: TLabel;
    LabelK34: TLabel;
    EditPercentTransportEquipment: TEdit;
    EditK41: TEdit;
    EditK31: TEdit;
    EditK32: TEdit;
    EditK33: TEdit;
    EditK34: TEdit;
    LabelPercentTransport: TLabel;
    EditPercentTransport: TEdit;
    LabelEstimateForDate: TLabel;
    LabelRateWorker: TLabel;
    EditRateWorker: TEdit;
    LabelRateMachinist: TLabel;
    EditRateMachinist: TEdit;
    LabelRegion: TLabel;
    EditRegion: TEdit;
    LabelVAT: TLabel;
    ComboBoxVAT: TComboBox;
    Bevel1: TBevel;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ComboBoxMonth: TComboBox;
    ComboBoxYear: TComboBox;
    EditK40: TEdit;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    LabelK41: TLabel;
    Bevel5: TBevel;
    LabelDump: TLabel;
    DBLookupComboBoxDump: TDBLookupComboBox;
    DBLookupComboBoxRegionDump: TDBLookupComboBox;
    DataSourceDump: TDataSource;
    PopupMenuPercentTransport: TPopupMenu;
    PopupMenuPercentTransportCity: TMenuItem;
    PopupMenuPercentTransportVillage: TMenuItem;
    PopupMenuPercentTransportMinsk: TMenuItem;
    RadioGroupCoefOrders: TRadioGroup;
    DataSourceRegionDump: TDataSource;
    ADOQueryDump: TFDQuery;
    ADOQueryRegionDump: TFDQuery;
    ADOQueryTemp: TFDQuery;
    lbl1: TLabel;
    edtKZP: TEdit;

    procedure FormShow(Sender: TObject);

    procedure ShowForm(const vIdObject, vIdEstimate: Integer);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ComboBoxMonthORYearChange(Sender: TObject);
    procedure DBLookupComboBoxRegionDumpClick(Sender: TObject);
    procedure PopupMenuPercentTransportMinskClick(Sender: TObject);
    procedure GetValueCoefOrders;
    // Получаем флаг состояния (применять/ не применять) коэффициента по приказам
    procedure SetValueCoefOrders;
    procedure lbl1Click(Sender: TObject);
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

uses Main, DataModule, CalculationEstimate;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormBasicData.FormShow(Sender: TObject);
var
  IdStavka: String;
  vDate: TDate;
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  // ----------------------------------------

  with ADOQueryTemp do
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

  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT coef_tr_zatr, coef_tr_obor, k40, k41, k31, k32, k33, k34, nds, kzp, stavka_id, date, dump_id '
      + 'FROM smetasourcedata WHERE sm_id = :sm_id;');
    ParamByName('sm_id').Value := IdEstimate;
    Active := True;

    EditPercentTransport.Text := MyFloatToStr(FieldByName('coef_tr_zatr').AsFloat);
    EditPercentTransportEquipment.Text := MyFloatToStr(FieldByName('coef_tr_obor').AsFloat);
    EditK40.Text := MyFloatToStr(FieldByName('K40').AsFloat);
    EditK41.Text := MyFloatToStr(FieldByName('K41').AsFloat);
    EditK31.Text := MyFloatToStr(FieldByName('K31').AsFloat);
    EditK32.Text := MyFloatToStr(FieldByName('K32').AsFloat);
    EditK33.Text := MyFloatToStr(FieldByName('K33').AsFloat);
    EditK34.Text := MyFloatToStr(FieldByName('K34').AsFloat);
    edtKZP.Text := MyFloatToStr(FieldByName('kzp').AsFloat);

    ComboBoxVAT.ItemIndex := FieldByName('nds').AsVariant;

    IdStavka := FieldByName('stavka_id').AsVariant;
    vDate := FieldByName('date').AsDateTime;

    IdDump := FieldByName('dump_id').AsVariant;

    ComboBoxMonth.ItemIndex := MonthOf(vDate) - 1;

    // ----------------------------------------

    Active := False;
    SQL.Clear;
    SQL.Add('SELECT monat, year FROM stavka WHERE stavka_id = :stavka_id;');
    ParamByName('stavka_id').Value := IdStavka;
    Active := True;

    ComboBoxMonth.ItemIndex := FieldByName('monat').AsVariant - 1;
    ComboBoxYear.ItemIndex := 2012 - FieldByName('year').AsInteger;

    // ----------------------------------------

    Active := False;
    SQL.Clear;
    SQL.Add('SELECT stavka_m_rab, stavka_m_mach FROM stavka WHERE stavka_id = :stavka_id;');
    ParamByName('stavka_id').Value := IdStavka;
    Active := True;

    EditRateWorker.Text := FieldByName('stavka_m_rab').AsVariant;
    EditRateMachinist.Text := FieldByName('stavka_m_mach').AsVariant;

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
      DBLookupComboBoxRegionDump.KeyValue := ADOQueryRegionDump.FieldByName('region_id').AsVariant;

    DBLookupComboBoxRegionDumpClick(DBLookupComboBoxRegionDump);

    // ----------------------------------------

    GetValueCoefOrders; // Получаем значение коэффициента по приказам
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormBasicData.ShowForm(const vIdObject, vIdEstimate: Integer);
begin
  IdObject := vIdObject;
  IdEstimate := vIdEstimate;

  ShowModal;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormBasicData.PopupMenuPercentTransportMinskClick(Sender: TObject);
begin
  with EditPercentTransport do
    case (Sender as TMenuItem).Tag of
      1:
        Text := MyFloatToStr(PercentTransportCity);
      2:
        Text := MyFloatToStr(PercentTransportVillage);
      3:
        Text := MyFloatToStr(PercentTransportMinsk);
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormBasicData.ButtonSaveClick(Sender: TObject);
var
  IdStavka: Integer;
begin
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT stavka_id FROM stavka WHERE year = :year and monat = :monat;');
      ParamByName('year').Value := StrToInt(ComboBoxYear.Text);
      ParamByName('monat').Value := ComboBoxMonth.ItemIndex + 1;
      Active := True;
      IdStavka := FieldByName('stavka_id').AsInteger;
    end;

    // -----------------------------------------

    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE smetasourcedata SET stavka_id = :stavka_id, coef_tr_zatr = :coef_tr_zatr, ' +
        'coef_tr_obor = :coef_tr_obor, k40 = :k40, k41 = :k41, k31 = :k31, k32 = :k32, k33 = :k33, k34 = :k34, '
        + 'nds = :nds, dump_id = :dump_id, kzp = :kzp WHERE sm_id = :sm_id;');

      ParamByName('stavka_id').Value := IdStavka;
      ParamByName('coef_tr_zatr').Value := EditPercentTransport.Text;
      ParamByName('coef_tr_obor').Value := EditPercentTransportEquipment.Text;
      ParamByName('k40').Value := EditK40.Text;
      ParamByName('k41').Value := EditK41.Text;
      ParamByName('k31').Value := EditK31.Text;
      ParamByName('k32').Value := EditK32.Text;
      ParamByName('k33').Value := EditK33.Text;
      ParamByName('k34').Value := EditK34.Text;
      ParamByName('kzp').Value := edtKZP.Text;
      ParamByName('nds').Value := ComboBoxVAT.ItemIndex;
      ParamByName('dump_id').Value := DBLookupComboBoxDump.KeyValue;
      ParamByName('sm_id').Value := IdEstimate;

      ExecSQL;
    end;

    SetValueCoefOrders; // Примененять/не примененять коэффициент по приказам
  except
    on E: Exception do
      MessageBox(0, PChar('При сохранении данных возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        'Исходные данные', MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormBasicData.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormBasicData.ComboBoxMonthORYearChange(Sender: TObject);
var
  vYear, vMonth: String;
begin

  vMonth := IntToStr(ComboBoxMonth.ItemIndex + 1);
  vYear := ComboBoxYear.Text;

  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT stavka_m_rab as "RateWorker", stavka_m_mach as "RateMachinist" FROM stavka WHERE year = '
      + vYear + ' and monat = ' + vMonth + ';');
    Active := True;

    EditRateWorker.Text := FieldByName('RateWorker').AsVariant;
    EditRateMachinist.Text := FieldByName('RateMachinist').AsVariant;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormBasicData.DBLookupComboBoxRegionDumpClick(Sender: TObject);
begin
  with ADOQueryDump, DBLookupComboBoxDump do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT dump_id, dump_name FROM dump WHERE region_id = :region_id ORDER BY 2;');
    ParamByName('region_id').Value := DBLookupComboBoxRegionDump.KeyValue;
    Active := True;

    ListSource := DataSourceDump;
    ListField := 'dump_name';
    KeyField := 'dump_id';

    if IdDump = NULL then
      KeyValue := FieldByName('dump_id').AsVariant
    else
      KeyValue := IdDump;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormBasicData.GetValueCoefOrders;
var
  i: Integer;
begin
  // Получаем флаг состояния (применять/ не применять) коэффициента по приказам

  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT coef_orders FROM smetasourcedata WHERE sm_id = :sm_id;');
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
  end;
end;

procedure TFormBasicData.lbl1Click(Sender: TObject);
begin

end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormBasicData.SetValueCoefOrders;
var
  NameTable: string;
begin
  // Устанавливаем флаг состояния (применять/ не применять) коэффициента по приказам
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE smetasourcedata SET coef_orders = :coef_orders WHERE sm_id = :sm_id;');
      ParamByName('sm_id').Value := IdEstimate;

      case RadioGroupCoefOrders.ItemIndex of
        0:
          ParamByName('coef_orders').Value := 1;
        1:
          ParamByName('coef_orders').Value := 0;
        2:
          ParamByName('coef_orders').Value := -1;
      end;

      ExecSQL;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При записи флага состояния коэффициента по приказам возникла ошибка:' + sLineBreak
        + sLineBreak + E.Message), 'Исходные данные', MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
