unit Transportation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Grids, ExtCtrls, DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFormTransportation = class(TForm)
    Panel1: TPanel;
    EditJustificationNumber: TEdit;
    LabelJustification: TLabel;
    EditJustification: TEdit;
    Bevel1: TBevel;
    ButtonCancel: TButton;
    Panel2: TPanel;
    LabelDistance: TLabel;
    EditDistance: TEdit;
    PanelBottom: TPanel;
    qrTemp: TFDQuery;
    Label7: TLabel;
    Label9: TLabel;
    edtPriceNoNDS: TEdit;
    Label8: TLabel;
    edtPriceNDS: TEdit;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    cmbUnit: TComboBox;
    Label1: TLabel;
    edtCount: TEdit;
    LabelMass: TLabel;
    edtYDW: TEdit;
    Label2: TLabel;
    cmbClass: TComboBox;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    edtCoastNoNDS: TEdit;
    edtCoastNDS: TEdit;
    Label10: TLabel;
    edtNDS: TEdit;
    Bevel2: TBevel;
    ButtonAdd: TButton;

    procedure FormShow(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure cmbUnitChange(Sender: TObject);
    procedure CalculationTransp;
    procedure GetCoast;
    procedure edtCountChange(Sender: TObject);
    procedure edtNDSChange(Sender: TObject);
    procedure edtCoastNDSChange(Sender: TObject);
    procedure edtCoastNoNDSChange(Sender: TObject);
    procedure EditDistanceChange(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);

  private
    EstMonth, EstYear : integer;
    ChangeCoast: boolean;
    JustNumber: string;
    TranspCount, CCount, Ydw: extended;
    CoastNoNds, CoastNds, Nds: integer;
    Distance: Integer;
    Loading: boolean;
    procedure GetEstimateInfo(aIdEstimate: integer);
    procedure LoadTranspInfo(aIdTransp: integer);
  public
    IdEstimate: Integer; //ID сметы в которой транспорт
    IdTransp: Integer; // ID транспорта в смете
    TranspType: Integer;
    InsMode: boolean; //признак вставкисвалки
    IsSaved: boolean;
  end;

const
  CaptionForm = 'Перевозка грузов';

//Вызов окна транспорта. InsMode - признак вставкисвалки  в смету
function GetTranspForm(IdEstimate, IdTransp, TranspType: Integer;
  InsMode: boolean): boolean;

implementation

uses Main, CalculationEstimate, DataModule;

{$R *.dfm}

function GetTranspForm(IdEstimate, IdTransp, TranspType: Integer;
  InsMode: boolean): boolean;
var FormTransp: TFormTransportation;
begin
  Result := false;
  FormTransp := TFormTransportation.Create(nil);
  try
    FormTransp.IdEstimate := IdEstimate;
    FormTransp.IdTransp := IdTransp;
    FormTransp.InsMode := InsMode;
    FormTransp.TranspType := TranspType;
    FormTransp.IsSaved := false;
    FormTransp.ShowModal;
    Result := FormTransp.IsSaved;
  finally
    FormTransp.Free;
  end;
end;

procedure TFormTransportation.CalculationTransp;
begin
    if trim(edtCount.Text) = '' then CCount := 0
  else
  begin
    if edtCount.Text[length(edtCount.Text)] = '.' then
    begin
      CCount := StrToFloat(copy(edtCount.Text,1,length(edtCount.Text) - 1));
    end
    else CCount := StrToFloat(edtCount.Text);
  end;

  if trim(edtYDW.Text) = '' then Ydw := 0
  else
  begin
    if edtYDW.Text[length(edtYDW.Text)] = '.' then
    begin
      Ydw := StrToFloat(copy(edtYDW.Text,1,length(edtYDW.Text) - 1));
    end
    else Ydw := StrToFloat(edtYDW.Text);
  end;

  if trim(EditDistance.Text) = '' then Distance := 0
  else Distance := StrToInt(EditDistance.Text);

  if trim(edtCoastNoNDS.Text) = '' then CoastNoNds := 0
  else CoastNoNds := StrToInt(edtCoastNoNDS.Text);

  if trim(edtCoastNDS.Text) = '' then CoastNds := 0
  else CoastNds := StrToInt(edtCoastNDS.Text);

  if trim(edtNDS.Text) = '' then Nds := 0
  else Nds := StrToInt(edtNDS.Text);

  if 0 = cmbUnit.ItemIndex then
    TranspCount := CCount
  else
    TranspCount := (CCount * Ydw) / 1000;

  edtPriceNoNDS.Text := IntToStr(Round(TranspCount * CoastNoNds));
  edtPriceNDS.Text := IntToStr(Round(TranspCount * CoastNds));
end;

procedure TFormTransportation.ButtonAddClick(Sender: TObject);
begin
  if InsMode then
  begin
    qrTemp.Active := False;
    qrTemp.SQL.Text := 'Insert into transpcard_temp (TRANSP_TYPE,TRANSP_CODE_JUST,' +
      'TRANSP_JUST,TRANSP_COUNT,TRANSP_DIST,TRANSP_SUM_NDS,TRANSP_SUM_NO_NDS,' +
      'COAST_NO_NDS,COAST_NDS,CARG_CLASS,CARG_UNIT,CARG_TYPE,CARG_COUNT,CARG_YDW,' +
      'NDS,PRICE_NDS,PRICE_NO_NDS) values (' +
      ':TRANSP_TYPE,:TRANSP_CODE_JUST,' +
      ':TRANSP_JUST,:TRANSP_COUNT,:TRANSP_DIST,:TRANSP_SUM_NDS,:TRANSP_SUM_NO_NDS,' +
      ':COAST_NO_NDS,:COAST_NDS,:CARG_CLASS,:CARG_UNIT,:CARG_TYPE,:CARG_COUNT,:CARG_YDW,' +
      ':NDS,:PRICE_NDS,:PRICE_NO_NDS)';
    qrTemp.ParamByName('TRANSP_TYPE').Value := TranspType;
    qrTemp.ParamByName('TRANSP_CODE_JUST').Value := EditJustificationNumber.Text;
    qrTemp.ParamByName('TRANSP_JUST').Value := EditJustification.Text;
    qrTemp.ParamByName('TRANSP_COUNT').Value := TranspCount;
    qrTemp.ParamByName('TRANSP_DIST').Value := Distance;
    qrTemp.ParamByName('TRANSP_SUM_NDS').Value := StrToInt64(edtPriceNDS.Text);;
    qrTemp.ParamByName('TRANSP_SUM_NO_NDS').Value := StrToInt64(edtPriceNoNDS.Text);
    qrTemp.ParamByName('COAST_NO_NDS').Value := CoastNoNds;
    qrTemp.ParamByName('COAST_NDS').Value := CoastNds;
    qrTemp.ParamByName('CARG_CLASS').Value := cmbClass.ItemIndex;
    qrTemp.ParamByName('CARG_UNIT').Value := cmbUnit.Text;
    qrTemp.ParamByName('CARG_TYPE').Value := cmbUnit.ItemIndex;
    qrTemp.ParamByName('CARG_COUNT').Value := CCount;
    qrTemp.ParamByName('CARG_YDW').Value := Ydw;
    qrTemp.ParamByName('NDS').Value := Nds;
    qrTemp.ParamByName('PRICE_NDS').Value := StrToInt64(edtPriceNDS.Text);
    qrTemp.ParamByName('PRICE_NO_NDS').Value := StrToInt64(edtPriceNoNDS.Text);

    qrTemp.ExecSQL;

    qrTemp.SQL.Text := 'INSERT INTO data_estimate_temp ' +
      '(id_estimate, id_type_data, id_tables) VALUE ' +
      '(' + IntToStr(IdEstimate) + ', ' + IntToStr(TranspType) +
      ', (SELECT max(id) FROM transpcard_temp));';

    qrTemp.ExecSQL;
  end
  else
  begin
    qrTemp.Active := False;
    qrTemp.SQL.Text := 'Update transpcard_temp set TRANSP_TYPE=:TRANSP_TYPE,' +
      'TRANSP_CODE_JUST=:TRANSP_CODE_JUST,TRANSP_JUST=:TRANSP_JUST,' +
      'TRANSP_COUNT=:TRANSP_COUNT,TRANSP_DIST=:TRANSP_DIST,' +
      'TRANSP_SUM_NDS=:TRANSP_SUM_NDS,TRANSP_SUM_NO_NDS=:TRANSP_SUM_NO_NDS,' +
      'COAST_NO_NDS=:COAST_NO_NDS,COAST_NDS=:COAST_NDS,CARG_CLASS=:CARG_CLASS,' +
      'CARG_UNIT=:CARG_UNIT,CARG_TYPE=:CARG_TYPE,CARG_COUNT=:CARG_COUNT,' +
      'CARG_YDW=:CARG_YDW,NDS=:NDS,PRICE_NDS=:PRICE_NDS,' +
      'PRICE_NO_NDS=:PRICE_NO_NDS where ID = :ID';
    qrTemp.ParamByName('TRANSP_TYPE').Value := TranspType;
    qrTemp.ParamByName('TRANSP_CODE_JUST').Value := EditJustificationNumber.Text;
    qrTemp.ParamByName('TRANSP_JUST').Value := EditJustification.Text;
    qrTemp.ParamByName('TRANSP_COUNT').Value := TranspCount;
    qrTemp.ParamByName('TRANSP_DIST').Value := Distance;
    qrTemp.ParamByName('TRANSP_SUM_NDS').Value := StrToInt64(edtPriceNDS.Text);;
    qrTemp.ParamByName('TRANSP_SUM_NO_NDS').Value := StrToInt64(edtPriceNoNDS.Text);
    qrTemp.ParamByName('COAST_NO_NDS').Value := CoastNoNds;
    qrTemp.ParamByName('COAST_NDS').Value := CoastNds;
    qrTemp.ParamByName('CARG_CLASS').Value := cmbClass.ItemIndex;
    qrTemp.ParamByName('CARG_UNIT').Value := cmbUnit.Text;
    qrTemp.ParamByName('CARG_TYPE').Value := cmbUnit.ItemIndex;
    qrTemp.ParamByName('CARG_COUNT').Value := CCount;
    qrTemp.ParamByName('CARG_YDW').Value := Ydw;
    qrTemp.ParamByName('NDS').Value := Nds;
    qrTemp.ParamByName('PRICE_NDS').Value := StrToInt64(edtPriceNDS.Text);
    qrTemp.ParamByName('PRICE_NO_NDS').Value := StrToInt64(edtPriceNoNDS.Text);
    qrTemp.ParamByName('ID').Value := IdTransp;

    qrTemp.ExecSQL;
  end;
  IsSaved := true;
  ButtonCancelClick(Sender);
end;

procedure TFormTransportation.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormTransportation.cmbUnitChange(Sender: TObject);
begin
  if Loading then exit;

  edtYDW.Enabled := 0 <> cmbUnit.ItemIndex;
  CalculationTransp;
end;

//Подгружает необходимую информацию из сметы
procedure TFormTransportation.GetEstimateInfo(aIdEstimate: integer);
begin
  try
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

procedure TFormTransportation.EditDistanceChange(Sender: TObject);
begin
  if Loading then exit;

  if (EditDistance.Text <> '') and (StrToInt(EditDistance.Text) > 0) then
    EditJustificationNumber.Text := JustNumber + '-' +
      EditDistance.Text
  else EditJustificationNumber.Text := EditDistance.Text;

  GetCoast;
  CalculationTransp;
end;

procedure TFormTransportation.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9','.', #8]) then // Не цифра и не BackSpace
    Key := #0;

  if Key = '.' then
  begin
    if pos('.',(Sender as TEdit).Text) > 0 then Key := #0;
    if (Sender as TEdit).Text = '' then Key := #0;
  end;
end;


procedure TFormTransportation.edtCoastNDSChange(Sender: TObject);
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
      CalculationTransp;
    finally
      ChangeCoast := false;
    end;
  end;
end;

procedure TFormTransportation.edtCoastNoNDSChange(Sender: TObject);
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
      CalculationTransp;
    finally
      ChangeCoast := false;
    end;
  end;
end;

procedure TFormTransportation.edtCountChange(Sender: TObject);
begin
  if Loading then exit;
  CalculationTransp;
end;

procedure TFormTransportation.edtNDSChange(Sender: TObject);
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
      CalculationTransp;
    finally
      ChangeCoast := false;
    end;
  end;
end;

procedure TFormTransportation.FormShow(Sender: TObject);
begin
  Loading := false;
  GetEstimateInfo(IdEstimate);

  if InsMode then
  begin
    case TranspType of
      6:
        begin
          EditJustificationNumber.Text := 'C310';
          EditJustification.Text := 'Перевозка грузов автомобилями – самосвалами C310';
        end;
      7:
        begin
          EditJustificationNumber.Text := 'C310';
          EditJustification.Text := 'Перевозка мусора автомобилями – самосвалами C310';
        end;
      8:
        begin
          EditJustificationNumber.Text := 'C311';
          EditJustification.Text := 'Перевозка грузов автомобилями – самосвалами C311';
        end;
      9:
        begin
          EditJustificationNumber.Text := 'C311';
          EditJustification.Text := 'Перевозка мусора автомобилями - самосвалами C311';
        end;
      else raise Exception.Create('Неизвестный тип транспорта (' +
        IntToStr(TranspType) + ')');
    end;

    edtYDW.Enabled := 0 <> cmbUnit.ItemIndex;
    edtCount.Text := '0';
    edtYDW.Text := '0';

    if TranspType in [7,9] then cmbClass.Enabled := False;
    CalculationTransp;
  end
  else
  begin
    LoadTranspInfo(IdTransp);
    ButtonAdd.Caption := 'Сохранить';
  end;

  if TranspType in [6,7] then JustNumber := 'C310';
  if TranspType in [8,9] then JustNumber := 'C311';

  EditDistance.SetFocus;
end;

procedure TFormTransportation.LoadTranspInfo(aIdTransp: integer);
var i : integer;
begin
  Loading := true;
  try
      qrTemp.Active := False;
      qrTemp.SQL.Text := 'SELECT * FROM transpcard_temp WHERE (ID = ' +
        IntToStr(aIdTransp) + ');';
      qrTemp.Active := True;

      EditJustificationNumber.Text := qrTemp.FieldByName('TRANSP_CODE_JUST').AsString;
      EditJustification.Text := qrTemp.FieldByName('TRANSP_JUST').AsString;
      EditDistance.Text := qrTemp.FieldByName('TRANSP_DIST').AsString;
      cmbClass.ItemIndex := qrTemp.FieldByName('CARG_CLASS').AsInteger;
      cmbUnit.ItemIndex := qrTemp.FieldByName('CARG_TYPE').AsInteger;
      edtCount.Text := qrTemp.FieldByName('CARG_COUNT').AsString;
      edtYDW.Text := qrTemp.FieldByName('CARG_YDW').AsString;
      edtCoastNDS.Text := qrTemp.FieldByName('COAST_NDS').AsString;
      edtCoastNoNDS.Text := qrTemp.FieldByName('COAST_NO_NDS').AsString;
      edtNDS.Text := qrTemp.FieldByName('NDS').AsString;
      edtPriceNoNDS.Text := qrTemp.FieldByName('TRANSP_SUM_NO_NDS').AsString;
      edtPriceNDS.Text := qrTemp.FieldByName('TRANSP_SUM_NDS').AsString;

      TranspType := qrTemp.FieldByName('TRANSP_TYPE').AsInteger;
      TranspCount := qrTemp.FieldByName('TRANSP_COUNT').AsFloat;
      CoastNoNds := qrTemp.FieldByName('COAST_NO_NDS').AsInteger;
      CoastNds := qrTemp.FieldByName('COAST_NDS').AsInteger;
      Nds := qrTemp.FieldByName('NDS').AsInteger;
      CCount := qrTemp.FieldByName('CARG_COUNT').AsFloat;
      Ydw := qrTemp.FieldByName('CARG_YDW').AsFloat;

      qrTemp.Active := False;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении данных по свалке ошибка:' +
      sLineBreak + sLineBreak + E.Message), CaptionForm,
      MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
  Loading := false;
end;

procedure TFormTransportation.GetCoast;
var
  i: Integer;
  More: Integer;
  TabName, DistanceText, LikeText: string;
begin
  More := 0;
  Distance := 0;
  LikeText := '';
  CoastNoNDS := 0;
  CoastNDS := 0;
  NDS := 20;

  case TranspType of
    6,7: TabName := 'transfercargo';
    8,9: TabName := 'transfercargoboard';
  end;

  if EditDistance.Text <> '' then
  begin
    Distance := StrToInt(EditDistance.Text);
    DistanceText := EditDistance.Text;

    if TranspType in [6,7] then
    begin
      if Distance > 50 then
      begin
        More := Distance - 50;
        DistanceText := '50';
        LikeText := '50 км';
      end;
    end;

    if TranspType in [8,9] then
    begin
      if Distance > 100 then
      begin
        if (Distance mod 5) = 0 then
          DistanceText := IntToStr(Distance - 4) + '-' + IntToStr(Distance)
        else
          DistanceText := IntToStr(Distance - (Distance mod 5) + 1) + '-' +
            IntToStr(Distance + (5 - (Distance mod 5)));
        if Distance > 200 then
        begin
          More := Distance - 200;
          DistanceText := '196-200';
          LikeText := '200 км';
        end;
      end;
    end;
  end;

  try
    with qrTemp do
    begin
      Active := False;
      SQL.Text := 'SELECT * FROM ' + TabName + ' WHERE monat = ' + IntToStr(EstMonth) +
        ' and year = ' + IntToStr(EstYear) + ' and distance = :dist;';
      ParamByName('dist').Value := DistanceText;
      Active := True;

      if not IsEmpty then
      begin
        CoastNoNDS := FieldByName('class' +
          IntToStr(cmbClass.ItemIndex + 1) + '_1').AsInteger;
        CoastNDS := FieldByName('class' +
          IntToStr(cmbClass.ItemIndex + 1) + '_2').AsInteger;
      end;

      Active := False;

      if (More > 0) and (CoastNoNDS > 0) then
      begin
        SQL.Text := 'SELECT * FROM ' + TabName + ' WHERE monat = ' + IntToStr(EstMonth) +
          ' and year = ' + IntToStr(EstYear) + ' and distance LIKE "%' + LikeText + '%";';
        Active := True;

        if not IsEmpty then
        begin
          CoastNoNDS := FieldByName('class' + IntToStr(cmbClass.ItemIndex + 1) +
            '_1').AsInteger * More + CoastNoNDS;
          CoastNDS := FieldByName('class' + IntToStr(cmbClass.ItemIndex + 1) +
            '_2').AsInteger * More + CoastNDS;
        end;
        Active := False;
      end;
    end;
  except
    on E: Exception do
    begin
      qrTemp.Active := False;

      MessageBox(0, PChar('При получении цен по грузоперевозкам возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
  end;
  ChangeCoast := true;
  edtCoastNoNDS.Text := IntToStr(CoastNoNDS);
  edtCoastNDS.Text := IntToStr(CoastNDS);
  edtNDS.Text := IntToStr(NDS);
  ChangeCoast := false;
end;

end.

