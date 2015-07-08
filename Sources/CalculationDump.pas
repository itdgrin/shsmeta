unit CalculationDump;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Grids, ExtCtrls, DB,
  DBCtrls, Math, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.FmtBcd;

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

    DumpCount, MCount, Ydw,
    CoastNoNds, CoastNds: TBcd;
    Nds: Integer;
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

uses Main, DataModule, CalculationEstimate, Tools, GlobsAndConst;

{$R *.dfm}

function GetDumpForm(IdEstimate, IdDump: Integer; InsMode: boolean): boolean;
var FormDump: TFormCalculationDump;
begin
  //Result := false;
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

      DumpCount := qrTemp.FieldByName('DUMP_COUNT').AsBCD;
      CoastNoNds := qrTemp.FieldByName('COAST_NO_NDS').AsBCD;
      CoastNds := qrTemp.FieldByName('COAST_NDS').AsBCD;
      Nds := qrTemp.FieldByName('NDS').AsInteger;
      MCount := qrTemp.FieldByName('WORK_COUNT').AsBCD;
      Ydw := qrTemp.FieldByName('WORK_YDW').AsBCD;

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
var Iterator: Integer;
    NewId: Integer;
begin
  if InsMode then
  begin
    qrTemp.Active := False;
    qrTemp.SQL.Text := 'SELECT GetNewID(:IDType)';
    qrTemp.ParamByName('IDType').Value := C_ID_SMDUM;
    qrTemp.Active := True;
    NewId := 0;
    if not qrTemp.Eof then
      NewId := qrTemp.Fields[0].AsInteger;
    qrTemp.Active := False;

    if NewId = 0 then
      raise Exception.Create('Не удалось получить новый ID.');

    qrTemp.SQL.Text := 'Insert into dumpcard_temp (ID, DUMP_ID, DUMP_NAME, ' +
      'DUMP_CODE_JUST, DUMP_JUST, DUMP_UNIT, ' +
      'DUMP_COUNT,DUMP_TYPE,DUMP_SUM_NDS,DUMP_SUM_NO_NDS,COAST_NO_NDS,COAST_NDS,' +
      'WORK_UNIT,WORK_TYPE,WORK_COUNT,WORK_YDW,NDS,PRICE_NDS,PRICE_NO_NDS) values (' +
      ':ID, :DUMP_ID,:DUMP_NAME,:DUMP_CODE_JUST,:DUMP_JUST,:DUMP_UNIT, ' +
      ':DUMP_COUNT,:DUMP_TYPE,:DUMP_SUM_NDS,:DUMP_SUM_NO_NDS,:COAST_NO_NDS,:COAST_NDS,' +
      ':WORK_UNIT,:WORK_TYPE,:WORK_COUNT,:WORK_YDW,:NDS,:PRICE_NDS,:PRICE_NO_NDS)';
    qrTemp.ParamByName('ID').Value := NewId;
    qrTemp.ParamByName('DUMP_ID').Value := DBLookupComboBoxND.KeyValue;
    qrTemp.ParamByName('DUMP_NAME').Value := DBLookupComboBoxND.Text;
    qrTemp.ParamByName('DUMP_CODE_JUST').Value := EditJustificationNumber.Text;
    qrTemp.ParamByName('DUMP_JUST').Value := EditJustification.Text;
    qrTemp.ParamByName('DUMP_UNIT').Value := edtDumpUnit.Text;
    qrTemp.ParamByName('DUMP_COUNT').Value := BcdToDouble(DumpCount);
    qrTemp.ParamByName('DUMP_TYPE').Value := Unit_Type;
    qrTemp.ParamByName('DUMP_SUM_NDS').Value := StrToCurr(edtPriceNDS.Text);;
    qrTemp.ParamByName('DUMP_SUM_NO_NDS').Value := StrToCurr(edtPriceNoNDS.Text);
    qrTemp.ParamByName('COAST_NO_NDS').Value := BCDToCurrency(CoastNoNds);
    qrTemp.ParamByName('COAST_NDS').Value := BCDToCurrency(CoastNds);
    qrTemp.ParamByName('WORK_UNIT').Value := cmbUnit.Text;
    qrTemp.ParamByName('WORK_TYPE').Value := cmbUnit.ItemIndex;
    qrTemp.ParamByName('WORK_COUNT').Value := BCDToDouble(MCount);
    qrTemp.ParamByName('WORK_YDW').Value := BCDToDouble(Ydw);
    qrTemp.ParamByName('NDS').Value := Nds;
    qrTemp.ParamByName('PRICE_NDS').Value := StrToCurr(edtPriceNDS.Text);
    qrTemp.ParamByName('PRICE_NO_NDS').Value := StrToCurr(edtPriceNoNDS.Text);

    qrTemp.ExecSQL;

    Iterator := UpdateIterator(IdEstimate, 0, 0);
    qrTemp.SQL.Text := 'INSERT INTO data_estimate_temp ' +
      '(ID, id_estimate, id_type_data, id_tables, NUM_ROW) VALUE ' +
      '(GetNewID(:IDType), :id_estimate, :id_type_data, :id_tables, :NUM_ROW)';
    qrTemp.ParamByName('IDType').Value := C_ID_DATA;
    qrTemp.ParamByName('id_estimate').Value := IdEstimate;
    qrTemp.ParamByName('id_type_data').Value := 5;
    qrTemp.ParamByName('id_tables').Value := NewId;
    qrTemp.ParamByName('NUM_ROW').Value := Iterator;

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
    qrTemp.ParamByName('DUMP_COUNT').Value := BcdToDouble(DumpCount);
    qrTemp.ParamByName('DUMP_TYPE').Value := Unit_Type;
    qrTemp.ParamByName('DUMP_SUM_NDS').Value := StrToCurr(edtPriceNDS.Text);;
    qrTemp.ParamByName('DUMP_SUM_NO_NDS').Value := StrToCurr(edtPriceNoNDS.Text);
    qrTemp.ParamByName('COAST_NO_NDS').Value := BCDToCurrency(CoastNoNds);
    qrTemp.ParamByName('COAST_NDS').Value := BCDToCurrency(CoastNds);
    qrTemp.ParamByName('WORK_UNIT').Value := cmbUnit.Text;
    qrTemp.ParamByName('WORK_TYPE').Value := cmbUnit.ItemIndex;
    qrTemp.ParamByName('WORK_COUNT').Value := BcdToDouble(MCount);
    qrTemp.ParamByName('WORK_YDW').Value := BcdToDouble(Ydw);
    qrTemp.ParamByName('NDS').Value := Nds;
    qrTemp.ParamByName('PRICE_NDS').Value := StrToFloat(edtPriceNDS.Text);
    qrTemp.ParamByName('PRICE_NO_NDS').Value := StrToFloat(edtPriceNoNDS.Text);
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

    edtCoastNoNDS.Text := FloatToStr(qrTemp.FieldByName('coast1').AsFloat);
    edtCoastNDS.Text := FloatToStr(qrTemp.FieldByName('coast2').AsFloat);
    edtNDS.Text := '20';
  except
    on E: Exception do
      MessageBox(0, PChar('При получении цен по свалке возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  CalculationCost;
end;

procedure TFormCalculationDump.edtCoastNDSChange(Sender: TObject);
var i: TBcd;
    nds: Integer;
begin
  if Loading then
    exit;
  if not ChangeCoast then
  begin
    ChangeCoast := true;
    try
      if not TryStrToBcd(edtCoastNDS.Text, i) then
        i := 0;

      nds := StrToIntDef(edtNDS.Text, 0);

      edtCoastNoNDS.Text := BcdToStr(NDSToNoNDS1(i, nds));
      CalculationCost;
    finally
      ChangeCoast := false;
    end;
  end;
end;

procedure TFormCalculationDump.edtCoastNoNDSChange(Sender: TObject);
var i: TBcd;
    nds: Integer;
begin
  if Loading then
    exit;
  if not ChangeCoast then
  begin
    ChangeCoast := true;
    try
      if not TryStrToBcd(edtCoastNoNDS.Text, i) then
        i := 0;

      nds := StrToIntDef(edtNDS.Text, 0);

      edtCoastNDS.Text := BcdToStr(NDSToNoNDS1(i, nds));
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
var i: Integer;
    cost: TBcd;
begin
  if Loading then exit;
  if not ChangeCoast then
  begin
    ChangeCoast := true;
    try
      i := StrToIntDef(edtNDS.Text, 0);

      if not TryStrToBcd(edtCoastNoNDS.Text, cost) then
        cost := 0;

      edtCoastNDS.Text := BcdToStr(NDSToNoNDS1(cost, i));
      CalculationCost;
    finally
      ChangeCoast := false;
    end;
  end;
end;


procedure TFormCalculationDump.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0' .. '9','.', #8]) then // Не цифра и не BackSpace
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
      if not TryStrToBcd(copy(edtCount.Text,1,length(edtCount.Text) - 1), MCount) then
        MCount := 0;
    end
    else
      if not TryStrToBcd(edtCount.Text, MCount) then
        MCount := 0;
  end;

  if trim(edtYDW.Text) = '' then ydw := 0
  else
  begin
    if edtYDW.Text[length(edtYDW.Text)] = '.' then
    begin
      if not TryStrToBcd(copy(edtYDW.Text,1,length(edtYDW.Text) - 1), Ydw) then
        Ydw := 0;
    end
    else
      if not TryStrToBcd(edtYDW.Text, Ydw) then
        Ydw := 0;
  end;

  if not TryStrToBcd(edtCoastNoNDS.Text, CoastNoNds)  then
    CoastNoNds := 0;

  if not TryStrToBcd(edtCoastNDS.Text, CoastNds) then
    CoastNds := 0;

  Nds := StrToIntDef(edtNDS.Text, 0);

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

  edtPriceNoNDS.Text := CurrToStr(Round(BCDToCurrency(DumpCount * CoastNoNds)));
  edtPriceNDS.Text := CurrToStr(Round(BCDToCurrency(DumpCount * CoastNds)));
end;

procedure TFormCalculationDump.cmbUnitChange(Sender: TObject);
begin
  if Loading then exit;
  edtYDW.Enabled := Unit_Type <> cmbUnit.ItemIndex;
  CalculationCost;
end;

end.



