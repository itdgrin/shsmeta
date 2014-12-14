unit CalculationDump;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Grids, ExtCtrls, DB,
  DBCtrls, Math, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFormCalculationDump = class(TForm)
    Bevel1: TBevel;
    Panel1: TPanel;
    LabelJustification: TLabel;
    EditJustificationNumber: TEdit;
    EditJustification: TEdit;
    PanelMemo: TPanel;
    ButtonCancel: TButton;
    ButtonSave: TButton;
    Panel2: TPanel;
    LabelND: TLabel;
    DBLookupComboBoxND: TDBLookupComboBox;
    DataSourceND: TDataSource;
    Panel3: TPanel;
    ADOQueryND: TFDQuery;
    Memo: TMemo;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtDumpUnit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtCoastNDS: TEdit;
    edtCoastNoNDS: TEdit;
    Label5: TLabel;
    edtNDS: TEdit;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    cmbUnit: TComboBox;
    LabelMass: TLabel;
    edtYDW: TEdit;
    LabelCount: TLabel;
    edtCount: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtPriceNoNDS: TEdit;
    edtPriceNDS: TEdit;
    qrTemp: TFDQuery;

    procedure FormShow(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure CalculationCost;
    procedure FillingComboBox;
    procedure DBLookupComboBoxNDClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure edtCountChange(Sender: TObject);
    procedure edtYDWChange(Sender: TObject);
    procedure cmbUnitChange(Sender: TObject);
    procedure edtCoastNoNDSChange(Sender: TObject);
    procedure edtCoastNDSChange(Sender: TObject);
    procedure edtNDSChange(Sender: TObject);

  private
    Unit_Type: byte;
    EstMonth, EstYear, EstDumpId: integer;
    ChangeCoast: boolean;

    DumpCount, MCount, Ydw: extended;
    CoastNoNds, CoastNds, Nds: integer;
    Loading: boolean;  //Что-бы не срабатывали ченджи при заполнении формы

    procedure GetEstimateInfo(aIdEstimate: integer);
    procedure LoadDumpInfo(aIdDump: integer);
  public
    IdEstimate: Integer; //ID сметы в которой свалка
    IdDump: Integer; // ID свалки в смете
    InsMode: boolean; //признак вставкисвалки  в смету
    IsSaved: boolean;
  end;

const
  CaptionForm = 'Расчёт свалки';

//Вызов окна свалок. InsMode - признак вставкисвалки  в смету
function GetDumpForm(IdEstimate, IdDump: Integer; InsMode: boolean): boolean;

implementation

uses Main, DataModule, CalculationEstimate;

{$R *.dfm}

function GetDumpForm(IdEstimate, IdDump: Integer; InsMode: boolean): boolean;
var FormDump: TFormCalculationDump;
begin
  Result := false;
  FormDump := TFormCalculationDump.Create(nil);
  try
    FormDump.IdEstimate := IdEstimate;
    FormDump.IdDump := IdDump;
    FormDump.InsMode := InsMode;
    FormDump.IsSaved := false;
    FormDump.ShowModal;
    Result := FormDump.IsSaved;
  finally
    FormDump.Free;
  end;
end;

//Подгружает необходимую информацию из сметы
procedure TFormCalculationDump.GetEstimateInfo(aIdEstimate: integer);
begin
  try
    qrTemp.Active := False;
    qrTemp.SQL.Text := 'SELECT dump_id FROM smetasourcedata WHERE sm_id = ' +
      IntToStr(aIdEstimate) + ';';
    qrTemp.Active := True;
    EstDumpId := qrTemp.FieldByName('dump_id').AsInteger;
    qrTemp.Active := False;

    qrTemp.SQL.Text := 'SELECT monat as "Month", year as "Year" FROM stavka WHERE ' +
      'stavka_id = (SELECT stavka_id From smetasourcedata '
      + 'WHERE sm_id = ' + IntToStr(aIdEstimate) + ');';
    qrTemp.Active := True;
    EstMonth := qrTemp.FieldByName('Month').AsInteger;
    EstYear := qrTemp.FieldByName('Year').AsInteger;
    qrTemp.Active := False;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении данных по смете возникла ошибка:' +
        sLineBreak + sLineBreak + E.Message), CaptionForm,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationDump.LoadDumpInfo(aIdDump: integer);
begin
    Loading := True;
    try
      qrTemp.Active := False;
      qrTemp.SQL.Text := 'SELECT * FROM dumpcard_temp WHERE (ID = ' +
        IntToStr(aIdDump) + ');';
      qrTemp.Active := True;

      EditJustificationNumber.Text := qrTemp.FieldByName('DUMP_CODE_JUST').AsString;
      EditJustification.Text := qrTemp.FieldByName('DUMP_JUST').AsString;
      DBLookupComboBoxND.KeyValue := qrTemp.FieldByName('DUMP_ID').AsInteger;
      edtDumpUnit.Text := qrTemp.FieldByName('DUMP_UNIT').AsString;
      Unit_Type := qrTemp.FieldByName('DUMP_TYPE').AsInteger;
      edtCoastNDS.Text := qrTemp.FieldByName('COAST_NDS').AsString;
      edtCoastNoNDS.Text := qrTemp.FieldByName('COAST_NO_NDS').AsString;
      edtNDS.Text := qrTemp.FieldByName('NDS').AsString;
      cmbUnit.ItemIndex := qrTemp.FieldByName('WORK_TYPE').AsInteger;
      edtCount.Text := qrTemp.FieldByName('WORK_COUNT').AsString;
      edtYDW.Text := qrTemp.FieldByName('WORK_YDW').AsString;
      edtPriceNoNDS.Text := qrTemp.FieldByName('DUMP_SUM_NO_NDS').AsString;
      edtPriceNDS.Text := qrTemp.FieldByName('DUMP_SUM_NDS').AsString;

      DumpCount := qrTemp.FieldByName('DUMP_COUNT').AsFloat;
      CoastNoNds := qrTemp.FieldByName('COAST_NO_NDS').AsInteger;
      CoastNds := qrTemp.FieldByName('COAST_NDS').AsInteger;
      Nds := qrTemp.FieldByName('NDS').AsInteger;
      MCount := qrTemp.FieldByName('WORK_COUNT').AsFloat;
      Ydw := qrTemp.FieldByName('WORK_YDW').AsFloat;

      Memo.Text := EditJustification.Text + ' ' + DBLookupComboBoxND.Text + '.';
      qrTemp.Active := False;
    except
      on E: Exception do
        MessageBox(0, PChar('При получении данных по свалке ошибка:' +
        sLineBreak + sLineBreak + E.Message), CaptionForm,
        MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
    Loading := false;
end;

procedure TFormCalculationDump.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCalculationDump.ButtonSaveClick(Sender: TObject);
begin
  if InsMode then
  begin
    qrTemp.Active := False;
    qrTemp.SQL.Text := 'Insert into dumpcard_temp (DUMP_ID, DUMP_NAME,DUMP_CODE_JUST,' +
      'DUMP_JUST,DUMP_UNIT, ' +
      'DUMP_COUNT,DUMP_TYPE,DUMP_SUM_NDS,DUMP_SUM_NO_NDS,COAST_NO_NDS,COAST_NDS,' +
      'WORK_UNIT,WORK_TYPE,WORK_COUNT,WORK_YDW,NDS,PRICE_NDS,PRICE_NO_NDS) values (' +
      ':DUMP_ID,:DUMP_NAME,:DUMP_CODE_JUST,:DUMP_JUST,:DUMP_UNIT, ' +
      ':DUMP_COUNT,:DUMP_TYPE,:DUMP_SUM_NDS,:DUMP_SUM_NO_NDS,:COAST_NO_NDS,:COAST_NDS,' +
      ':WORK_UNIT,:WORK_TYPE,:WORK_COUNT,:WORK_YDW,:NDS,:PRICE_NDS,:PRICE_NO_NDS)';
    qrTemp.ParamByName('DUMP_ID').Value := DBLookupComboBoxND.KeyValue;
    qrTemp.ParamByName('DUMP_NAME').Value := DBLookupComboBoxND.Text;
    qrTemp.ParamByName('DUMP_CODE_JUST').Value := EditJustificationNumber.Text;
    qrTemp.ParamByName('DUMP_JUST').Value := EditJustification.Text;
    qrTemp.ParamByName('DUMP_UNIT').Value := edtDumpUnit.Text;
    qrTemp.ParamByName('DUMP_COUNT').Value := DumpCount;
    qrTemp.ParamByName('DUMP_TYPE').Value := Unit_Type;
    qrTemp.ParamByName('DUMP_SUM_NDS').Value := StrToInt64(edtPriceNDS.Text);;
    qrTemp.ParamByName('DUMP_SUM_NO_NDS').Value := StrToInt64(edtPriceNoNDS.Text);
    qrTemp.ParamByName('COAST_NO_NDS').Value := CoastNoNds;
    qrTemp.ParamByName('COAST_NDS').Value := CoastNds;
    qrTemp.ParamByName('WORK_UNIT').Value := cmbUnit.Text;
    qrTemp.ParamByName('WORK_TYPE').Value := cmbUnit.ItemIndex;
    qrTemp.ParamByName('WORK_COUNT').Value := MCount;
    qrTemp.ParamByName('WORK_YDW').Value := Ydw;
    qrTemp.ParamByName('NDS').Value := Nds;
    qrTemp.ParamByName('PRICE_NDS').Value := StrToInt64(edtPriceNDS.Text);
    qrTemp.ParamByName('PRICE_NO_NDS').Value := StrToInt64(edtPriceNoNDS.Text);

    qrTemp.ExecSQL;

    qrTemp.SQL.Text := 'INSERT INTO data_estimate_temp ' +
      '(id_estimate, id_type_data, id_tables) VALUE ' +
      '(' + IntToStr(IdEstimate) + ', 5, (SELECT max(id) FROM dumpcard_temp));';

    qrTemp.ExecSQL;
  end
  else
  begin
    qrTemp.Active := False;
    qrTemp.SQL.Text := 'Update dumpcard_temp set DUMP_ID = :DUMP_ID, DUMP_NAME = :DUMP_NAME, ' +
      'DUMP_CODE_JUST = :DUMP_CODE_JUST, DUMP_JUST = :DUMP_JUST, ' +
      'DUMP_UNIT = :DUMP_UNIT, DUMP_COUNT = :DUMP_COUNT, DUMP_TYPE = :DUMP_TYPE, ' +
      'DUMP_SUM_NDS = :DUMP_SUM_NDS, DUMP_SUM_NO_NDS = :DUMP_SUM_NO_NDS, ' +
      'COAST_NO_NDS = :COAST_NO_NDS, COAST_NDS = :COAST_NDS,' +
      'WORK_UNIT = :WORK_UNIT, WORK_TYPE = :WORK_TYPE, WORK_COUNT = :WORK_COUNT, ' +
      'WORK_YDW = :WORK_YDW, NDS = :NDS, PRICE_NDS = :PRICE_NDS, ' +
      'PRICE_NO_NDS = :PRICE_NO_NDS where ID = :ID';
    qrTemp.ParamByName('DUMP_ID').Value := DBLookupComboBoxND.KeyValue;
    qrTemp.ParamByName('DUMP_NAME').Value := DBLookupComboBoxND.Text;
    qrTemp.ParamByName('DUMP_CODE_JUST').Value := EditJustificationNumber.Text;
    qrTemp.ParamByName('DUMP_JUST').Value := EditJustification.Text;
    qrTemp.ParamByName('DUMP_UNIT').Value := edtDumpUnit.Text;
    qrTemp.ParamByName('DUMP_COUNT').Value := DumpCount;
    qrTemp.ParamByName('DUMP_TYPE').Value := Unit_Type;
    qrTemp.ParamByName('DUMP_SUM_NDS').Value := StrToInt64(edtPriceNDS.Text);;
    qrTemp.ParamByName('DUMP_SUM_NO_NDS').Value := StrToInt64(edtPriceNoNDS.Text);
    qrTemp.ParamByName('COAST_NO_NDS').Value := CoastNoNds;
    qrTemp.ParamByName('COAST_NDS').Value := CoastNds;
    qrTemp.ParamByName('WORK_UNIT').Value := cmbUnit.Text;
    qrTemp.ParamByName('WORK_TYPE').Value := cmbUnit.ItemIndex;
    qrTemp.ParamByName('WORK_COUNT').Value := MCount;
    qrTemp.ParamByName('WORK_YDW').Value := Ydw;
    qrTemp.ParamByName('NDS').Value := Nds;
    qrTemp.ParamByName('PRICE_NDS').Value := StrToInt64(edtPriceNDS.Text);
    qrTemp.ParamByName('PRICE_NO_NDS').Value := StrToInt64(edtPriceNoNDS.Text);
    qrTemp.ParamByName('ID').Value := IdDump;

    qrTemp.ExecSQL;
  end;
  IsSaved := true;
  ButtonCancelClick(Sender);
end;

procedure TFormCalculationDump.DBLookupComboBoxNDClick(Sender: TObject);
var vID: integer;
    te: TDateTime;
begin
  //Если выборается новая свалка текстовка обновляется
  EditJustificationNumber.Text := 'БС999-9901';
  EditJustification.Text := 'Плата за прием и захоронение отходов (строительного мусора).';

  Memo.Text := EditJustification.Text + ' ' + DBLookupComboBoxND.Text + '.';

  vID := (Sender as TDBLookupComboBox).KeyValue;

  try
    qrTemp.Active := False;
    qrTemp.SQL.Text := 'SELECT coast1, coast2 FROM ' +
      'dumpcoast WHERE ' +
      '(dump_id = :ID) and (DATE_BEG >= :date1) and (DATE_BEG <= :date2);';

    qrTemp.ParamByName('ID').Value := vID;
    te := EncodeDate(EstYear, EstMonth, 1);
    qrTemp.ParamByName('date1').Value := te;
    te := IncMonth(te) - 1;
    qrTemp.ParamByName('date2').Value := te;

    qrTemp.Active := True;
    edtDumpUnit.Text := ADOQueryND.FieldByName('unit_name').AsString;
    if ADOQueryND.FieldByName('unit_id').AsInteger = 24 then
      Unit_Type := 1 else Unit_Type := 0;

    edtYDW.Enabled := Unit_Type <> cmbUnit.ItemIndex;

    edtCoastNoNDS.Text := IntToStr(qrTemp.FieldByName('coast1').AsInteger);
    edtCoastNDS.Text := IntToStr(qrTemp.FieldByName('coast2').AsInteger);
    edtNDS.Text := '20';
  except
    on E: Exception do
      MessageBox(0, PChar('При получении цен по свалке возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  CalculationCost;
end;

procedure TFormCalculationDump.edtCoastNDSChange(Sender: TObject);
var i, nds: integer;
begin
  if Loading then exit;
  if not ChangeCoast then
  begin
    ChangeCoast := true;
    try
      if trim(edtCoastNDS.Text) = '' then i := 0
      else i := StrToInt(edtCoastNDS.Text);

      if trim(edtNDS.Text) = '' then nds := 0
      else nds := StrToInt(edtNDS.Text);

      edtCoastNoNDS.Text := IntToStr(NDSToNoNDS(i, nds));
      CalculationCost;
    finally
      ChangeCoast := false;
    end;
  end;
end;

procedure TFormCalculationDump.edtCoastNoNDSChange(Sender: TObject);
var i, nds: integer;
begin
  if Loading then exit;
  if not ChangeCoast then
  begin
    ChangeCoast := true;
    try
      if trim(edtCoastNoNDS.Text) = '' then i := 0
      else i := StrToInt(edtCoastNoNDS.Text);

      if trim(edtNDS.Text) = '' then nds := 0
      else nds := StrToInt(edtNDS.Text);

      edtCoastNDS.Text := IntToStr(NoNDSToNDS(i, nds));
      CalculationCost;
    finally
      ChangeCoast := false;
    end;
  end;
end;

procedure TFormCalculationDump.edtCountChange(Sender: TObject);
begin
  CalculationCost;
end;

procedure TFormCalculationDump.edtNDSChange(Sender: TObject);
var i, cost: integer;
begin
  if Loading then exit;
  if not ChangeCoast then
  begin
    ChangeCoast := true;
    try
      if trim(edtNDS.Text) = '' then i := 0
      else i := StrToInt(edtNDS.Text);

      if trim(edtCoastNoNDS.Text) = '' then cost := 0
      else cost := StrToInt(edtCoastNoNDS.Text);

      edtCoastNDS.Text := IntToStr(NoNDSToNDS(cost, i));
      CalculationCost;
    finally
      ChangeCoast := false;
    end;
  end;
end;


procedure TFormCalculationDump.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9','.', #8]) then // Не цифра и не BackSpace
    Key := #0;

  if Key = '.' then
  begin
    if pos('.',(Sender as TEdit).Text) > 0 then Key := #0;
    if (Sender as TEdit).Text = '' then Key := #0;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.edtYDWChange(Sender: TObject);
begin
  if Loading then exit;
  CalculationCost;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.FormShow(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  FillingComboBox;
  GetEstimateInfo(IdEstimate);

  //Если идет первичная вставка, то устанавливается свалка по умолчания
  if InsMode then
  begin
    DBLookupComboBoxND.KeyValue := EstDumpId;
    DBLookupComboBoxNDClick(DBLookupComboBoxND);
    DBLookupComboBoxND.SetFocus;
    cmbUnit.ItemIndex := Unit_Type;
    edtYDW.Enabled := Unit_Type <> cmbUnit.ItemIndex;
    edtCount.Text := '0';
    edtYDW.Text := '0';
  end
  else
  begin
    LoadDumpInfo(IdDump);
    ButtonSave.Caption := 'Сохранить';
  end;
end;

procedure TFormCalculationDump.FillingComboBox;
begin
  try
    with ADOQueryND do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT dump_id, dump_name, dump.UNIT_ID as UNIT_ID, ' +
        'units.UNIT_NAME as UNIT_NAME FROM dump, units where ' +
        'dump.UNIT_ID = units.UNIT_ID ORDER BY dump_name ASC;');
      Active := True;
    end;

    with DBLookupComboBoxND do
    begin
      ListSource := DataSourceND;
      ListField := 'dump_name';
      KeyField := 'dump_id';
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении списка свалок возникла ошибка:' + sLineBreak + E.Message), CaptionForm,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationDump.CalculationCost;
begin
  if trim(edtCount.Text) = '' then MCount := 0
  else
  begin
    if edtCount.Text[length(edtCount.Text)] = '.' then
    begin
      MCount := StrToFloat(copy(edtCount.Text,1,length(edtCount.Text) - 1));
    end
    else MCount := StrToFloat(edtCount.Text);
  end;

  if trim(edtYDW.Text) = '' then ydw := 0
  else
  begin
    if edtYDW.Text[length(edtYDW.Text)] = '.' then
    begin
      Ydw := StrToFloat(copy(edtYDW.Text,1,length(edtYDW.Text) - 1));
    end
    else Ydw := StrToFloat(edtYDW.Text);
  end;

  if trim(edtCoastNoNDS.Text) = '' then CoastNoNds := 0
  else CoastNoNds := StrToInt(edtCoastNoNDS.Text);

  if trim(edtCoastNDS.Text) = '' then CoastNds := 0
  else CoastNds := StrToInt(edtCoastNDS.Text);

  if trim(edtNDS.Text) = '' then Nds := 0
  else Nds := StrToInt(edtNDS.Text);

  if Unit_Type = cmbUnit.ItemIndex then
    DumpCount := MCount
  else
  begin
    if Unit_Type = 0 then
    begin
      DumpCount := (MCount * Ydw) / 1000;
    end;

    if Unit_Type = 1 then
    begin
      if Ydw <> 0 then
        DumpCount := (MCount * 1000) / Ydw
      else DumpCount := 0;
    end;
  end;

  edtPriceNoNDS.Text := IntToStr(Round(DumpCount * CoastNoNds));
  edtPriceNDS.Text := IntToStr(Round(DumpCount * CoastNds));
end;

procedure TFormCalculationDump.cmbUnitChange(Sender: TObject);
begin
  if Loading then exit;
  edtYDW.Enabled := Unit_Type <> cmbUnit.ItemIndex;
  CalculationCost;
end;

end.
