unit ReplacementMatAndMech;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Clipbrd, JvExControls,
  JvAnimatedImage, JvGIFCtrl, FireDAC.Phys.MySQL;

const
  WM_ONACTIVATE = WM_USER + 2;

type
  TSprRecord = record
    ID: Integer;
    Code,
    Name,
    Unt: string;
    CoastNDS,
    CoactNoNDS: Extended;
  end;

  TSprArray = array of TSprRecord;

  TActiveEvent = procedure(ADataSet: TDataSet; AE: Exception) of object;

  TThreadQuery = class(TThread)
  private
    FHandle: HWND;
    FQrTemp: TFDQuery;
    FConnect: TFDConnection;
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create(const ASQLText: string; AHandle: HWND);
    destructor Destroy; override;
  end;

  TfrmReplacement = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    rgroupType: TRadioGroup;
    rgroupWhere: TRadioGroup;
    groupReplace: TGroupBox;
    Label2: TLabel;
    edtSourceCode: TEdit;
    Label3: TLabel;
    edtSourceName: TEdit;
    edtDestName: TEdit;
    Label6: TLabel;
    edtDestCode: TEdit;
    Label5: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    edtCoeff: TEdit;
    groupEntry: TGroupBox;
    groupCatalog: TGroupBox;
    Panel4: TPanel;
    btnReplace: TButton;
    btnCancel: TButton;
    dbgrdEntry: TJvDBGrid;
    qrRep: TFDQuery;
    qrEntry: TFDQuery;
    dsEntry: TDataSource;
    qrEntrySEL: TBooleanField;
    qrEntrySMID: TIntegerField;
    qrEntrySMNAME: TStringField;
    qrEntryRTID: TIntegerField;
    qrEntryRTCODE: TStringField;
    qrEntryMTID: TIntegerField;
    qrEntryMTCODE: TStringField;
    qrEntryMTCOUNT: TFloatField;
    qrEntryMTUNIT: TStringField;
    Panel5: TPanel;
    StatusBar1: TStatusBar;
    Panel3: TPanel;
    Label1: TLabel;
    edtFind: TEdit;
    btnFind: TButton;
    btnSelect: TButton;
    LoadAnimator: TJvGIFAnimator;
    Label8: TLabel;
    ListSpr: TListView;
    procedure btnCancelClick(Sender: TObject);
    procedure rgroupTypeClick(Sender: TObject);
    procedure edtDestCodeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCoeffKeyPress(Sender: TObject; var Key: Char);
    procedure edtCoeffExit(Sender: TObject);
    procedure rgroupWhereClick(Sender: TObject);
    procedure qrEntrySELChange(Sender: TField);
    procedure qrEntryBeforeInsert(DataSet: TDataSet);
  private
    FCurType,
    FCurWhere: Byte;
    FObjectID,
    FEstimateID,
    FRateID,
    FMatMechID: Integer;

    FMonth,
    FYear,
    FRegion: Word;
    FRegionName: string;

    FSprArray: TSprArray;

    FFlag: Boolean;

    procedure ChangeType(AType: byte);
    procedure LoadRepInfo;
    procedure LoadEntry(AWhere: integer);

    procedure OnActivate(var Mes: TMessage); message WM_ONACTIVATE;
    procedure FillSprList(AFindName, AFindCode: string);

    { Private declarations }
  public
    constructor Create(const AObjectID, AEstimateID, ARateID,
      AMatMechID: Integer; AType: Byte); reintroduce;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModule, GlobsAndConst;

procedure TfrmReplacement.OnActivate(var Mes: TMessage);
var ind: Integer;
    TmpDS: TDataSet;
begin
  Label8.Visible := False;
  LoadAnimator.Visible := False;
  LoadAnimator.Animate := False;

  if Assigned(Exception(Mes.LParam)) then
    raise Exception(Mes.LParam);

  ind := 0;
  SetLength(FSprArray, ind);

  if not Assigned(TDataSet(Mes.WParam)) then
  begin
    ListSpr.Visible := True;
    Exit;
  end;

  TmpDS := TDataSet(Mes.WParam);

  if TmpDS.Active then
  begin
    while not TmpDS.Eof do
    begin
      inc(ind);
      SetLength(FSprArray, ind);
      //не по именам для быстродействия
      //Id, Code, Name, Unit, PriceVAT, PriceNotVAT
      FSprArray[ind - 1].ID := TmpDS.Fields[0].AsInteger;
      FSprArray[ind - 1].Code := TmpDS.Fields[1].AsString;
      FSprArray[ind - 1].Name := TmpDS.Fields[2].AsString;
      FSprArray[ind - 1].Unt := TmpDS.Fields[3].AsString;
      if FFlag then
      begin
        FSprArray[ind - 1].CoastNDS := TmpDS.Fields[4].AsFloat;
        FSprArray[ind - 1].CoactNoNDS := TmpDS.Fields[5].AsFloat;
      end;
      TmpDS.Next;
    end;
  end;

  FillSprList(edtFind.Text, '');
end;

procedure TfrmReplacement.FillSprList(AFindName, AFindCode: string);
var i: Integer;
    Item: TListItem;
begin
 // ListSpr.Items.Count := Length(FSprArray);
  for i := Low(FSprArray) to High(FSprArray) do
  begin
    Item := ListSpr.Items.Add;
   // Item.Caption := FSprArray[i].Code;
   { Item.SubItems.Add(FSprArray[i].Name);
    Item.SubItems.Add(FSprArray[i].Unt);

    if FFlag then
    begin
      Item.SubItems.Add(FloatToStr(FSprArray[i].CoastNDS));
      Item.SubItems.Add(FloatToStr(FSprArray[i].CoactNoNDS));
    end; }
  end;

  ListSpr.Visible :=  True;
end;

constructor TfrmReplacement.Create(const AObjectID, AEstimateID, ARateID,
      AMatMechID: Integer; AType: Byte);
begin
  inherited Create(nil);

  //Просто левые числа, что-бы onClick отработал
  FCurType := 9;
  FCurWhere := 9;

  FMonth := 0;
  FYear := 0;
  FRegion := 0;

  FObjectID := AObjectID;
  FEstimateID := AEstimateID;
  FRateID := ARateID;
  FMatMechID := AMatMechID;

  qrRep.Active := False;
  qrRep.SQL.Text := 'SELECT ob.region_id, reg.region_name ' +
    'FROM objcards as ob, regions as reg ' +
    'WHERE (ob.region_id = reg.region_id) and ' +
    '(ob.obj_id = ' + IntToStr(FObjectID) + ');';
  qrRep.Active := True;
  if not qrRep.IsEmpty then
  begin
    FRegion := qrRep.Fields[0].AsInteger;
    FRegionName := qrRep.Fields[1].AsString;
  end;
  qrRep.Active := False;

  qrRep.SQL.Text := 'SELECT IFNULL(monat,0) as monat, IFNULL(year,0) as year ' +
    'FROM smetasourcedata ' +
    'LEFT JOIN stavka ON stavka.stavka_id = smetasourcedata.stavka_id ' +
    'WHERE sm_id = ' + IntToStr(FEstimateID) + ';';
  qrRep.Active := True;
  if not qrRep.IsEmpty then
  begin
    FMonth := qrRep.Fields[0].AsInteger;
    FYear := qrRep.Fields[1].AsInteger;
  end;
  qrRep.Active := False;

  if (AType > 0) then
    rgroupType.ItemIndex := 1
  else
    rgroupType.ItemIndex := 0;

  LoadRepInfo;
  rgroupWhere.ItemIndex := 0;
end;

procedure TfrmReplacement.edtCoeffExit(Sender: TObject);
var s: string;
begin
  s := edtCoeff.Text;
  if (Length(s) > 0) and (s[High(s)] = FormatSettings.DecimalSeparator) then
    SetLength(s, Length(s)-1);
  edtCoeff.Text := s;

  if edtCoeff.Text = '' then
    edtCoeff.Text := '1';
end;

procedure TfrmReplacement.edtCoeffKeyPress(Sender: TObject; var Key: Char);
var f: Extended;
    s: string;
begin
  if CharInSet(Key, [^C, ^X, ^Z]) then
    Exit;

  if (Key = ^V) then
  begin
    if TryStrToFloat(Clipboard.AsText, f) then
    begin
      s :=
        Copy(edtCoeff.Text, 1, edtCoeff.SelStart) +
        Clipboard.AsText +
        Copy(edtCoeff.Text,
          edtCoeff.SelStart + edtCoeff.SelLength + 1,
          Length(edtCoeff.Text) - edtCoeff.SelStart - edtCoeff.SelLength);
      if TryStrToFloat(s, f) then
        Exit;
    end;
  end;

  case Key of
    '0'..'9',#8: ;
    '.',',':
     begin
       Key := FormatSettings.DecimalSeparator;
       if (pos(FormatSettings.DecimalSeparator , edtCoeff.Text) <> 0) or
          (edtCoeff.Text = '') then
        Key:= #0;
     end;
     else Key:= #0;
  end;
end;

procedure TfrmReplacement.edtDestCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #3) or (Key = #$16) then //Копирование и  вставка
    Exit;

  if (FCurType = 0) then
  begin
    if (Key = 'C') or (Key = 'c') or (Key = 'с') then
      Key := 'С'; //Кирилица
    if not (CharInSet(Key, ['0'..'9', '-', #8]) or (Key = 'С')) then
      Key := #0;
  end;

  if (FCurType = 1) then
  begin
    if (Key = 'M') or (Key = 'm') or (Key = 'м') then
      Key := 'М'; //Кирилица
    if not (CharInSet(Key, ['0'..'9', #8]) or (Key = 'М')) then
      Key := #0;
  end;
end;

procedure TfrmReplacement.LoadRepInfo;
begin
  qrRep.Active := False;

  if FCurType = 0 then
    qrRep.SQL.Text :=
      'select MAT_CODE, MAT_NAME from materialcard_temp where ID = ' +
      IntToStr(FMatMechID)
  else
    qrRep.SQL.Text :=
      'Select MECH_CODE, MECH_NAME from mechanizmcard_temp where ID = ' +
      IntToStr(FMatMechID);

  qrRep.Active := True;
  if not qrRep.IsEmpty then
  begin
    edtSourceCode.Text := qrRep.Fields[0].AsString;
    edtSourceName.Text := qrRep.Fields[1].AsString;
  end;
  qrRep.Active := False;
end;

procedure TfrmReplacement.qrEntryBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TfrmReplacement.qrEntrySELChange(Sender: TField);
begin
  qrEntry.Post;
end;

procedure TfrmReplacement.LoadEntry(AWhere: integer);
begin
  qrEntry.DisableControls;
  try
    qrEntry.Active := False;
    case AWhere of
    0:
      if (FCurType = 0) then
        qrEntry.SQL.Text :=
          'SELECT TRUE as SEL, SM.SM_ID as SMID, ' +
          'CONCAT(SM.SM_NUMBER, " ",  SM.NAME) as SMNAME, ' +
          'RT.ID as RTID, RT.RATE_CODE as RTCODE, MT.ID as MTID, ' +
          'MT.MAT_CODE as MTCODE, MT.MAT_COUNT as MTCOUNT, ' +
          'MT.MAT_UNIT as MTUNIT ' +
          'FROM smetasourcedata as SM, data_estimate_temp as ES, ' +
          'card_rate_temp as RT, materialcard_temp as MT ' +
          'WHERE (SM.SM_ID = ' + IntToStr(FEstimateID) + ') AND ' +
          '(SM.SM_ID = ES.ID_ESTIMATE) AND (ES.ID_TYPE_DATA = 1) AND ' +
          '(ES.ID_TABLES = RT.ID) AND (RT.ID = MT.ID_CARD_RATE) AND ' +
          '(MT.MAT_CODE = ''' + edtSourceCode.Text + ''') AND ' +
          '(RT.ID = ' + IntToStr(FRateID) + ')'
      else
        qrEntry.SQL.Text :=
          'SELECT TRUE as SEL, SM.SM_ID as SMID, ' +
          'CONCAT(SM.SM_NUMBER, " ",  SM.NAME) as SMNAME, ' +
          'RT.ID as RTID, RT.RATE_CODE as RTCODE, MT.ID as MTID, ' +
          'MT.MECH_CODE as MTCODE, MT.MECH_COUNT as MTCOUNT, ' +
          'MT.MECH_UNIT as MTUNIT ' +
          'FROM smetasourcedata as SM, data_estimate_temp as ES, ' +
          'card_rate_temp as RT, mechanizmcard_temp as MT ' +
          'WHERE (SM.SM_ID = ' + IntToStr(FEstimateID) + ') AND ' +
          '(SM.SM_ID = ES.ID_ESTIMATE) AND (ES.ID_TYPE_DATA = 1) AND ' +
          '(ES.ID_TABLES = RT.ID) AND (RT.ID = MT.ID_CARD_RATE) AND ' +
          '(MT.MECH_CODE = ''' + edtSourceCode.Text + ''') AND ' +
          '(RT.ID = ' + IntToStr(FRateID) + ')';
    1:
      if (FCurType = 0) then
        qrEntry.SQL.Text :=
          'SELECT TRUE as SEL, SM.SM_ID as SMID, ' +
          'CONCAT(SM.SM_NUMBER, " ",  SM.NAME) as SMNAME, ' +
          'RT.ID as RTID, RT.RATE_CODE as RTCODE, MT.ID as MTID, ' +
          'MT.MAT_CODE as MTCODE, MT.MAT_COUNT as MTCOUNT, ' +
          'MT.MAT_UNIT as MTUNIT ' +
          'FROM smetasourcedata as SM, data_estimate_temp as ES, ' +
          'card_rate_temp as RT, materialcard_temp as MT ' +
          'WHERE (SM.SM_ID = ' + IntToStr(FEstimateID) + ') AND ' +
          '(SM.SM_ID = ES.ID_ESTIMATE) AND (ES.ID_TYPE_DATA = 1) AND ' +
          '(ES.ID_TABLES = RT.ID) AND (RT.ID = MT.ID_CARD_RATE) AND ' +
          '(MT.MAT_CODE = ''' + edtSourceCode.Text + ''') AND ' +
          '(SM.SM_ID = ' + IntToStr(FEstimateID) + ')'
      else
        qrEntry.SQL.Text :=
          'SELECT TRUE as SEL, SM.SM_ID as SMID, ' +
          'CONCAT(SM.SM_NUMBER, " ",  SM.NAME) as SMNAME, ' +
          'RT.ID as RTID, RT.RATE_CODE as RTCODE, MT.ID as MTID, ' +
          'MT.MECH_CODE as MTCODE, MT.MECH_COUNT as MTCOUNT, ' +
          'MT.MECH_UNIT as MTUNIT ' +
          'FROM smetasourcedata as SM, data_estimate_temp as ES, ' +
          'card_rate_temp as RT, mechanizmcard_temp as MT ' +
          'WHERE (SM.SM_ID = ' + IntToStr(FEstimateID) + ') AND ' +
          '(SM.SM_ID = ES.ID_ESTIMATE) AND (ES.ID_TYPE_DATA = 1) AND ' +
          '(ES.ID_TABLES = RT.ID) AND (RT.ID = MT.ID_CARD_RATE) AND ' +
          '(MT.MECH_CODE = ''' + edtSourceCode.Text + ''') AND ' +
          '(SM.SM_ID = ' + IntToStr(FEstimateID) + ')';
    2:
      if (FCurType = 0) then
        qrEntry.SQL.Text := 'SELECT TRUE as SEL, SM.SM_ID as SMID, ' +
          'CONCAT(SM.SM_NUMBER, " ",  SM.NAME) as SMNAME, ' +
          'RT.ID as RTID, RT.RATE_CODE as RTCODE, MT.ID as MTID, ' +
          'MT.MAT_CODE as MTCODE, MT.MAT_COUNT as MTCOUNT, ' +
          'MT.MAT_UNIT as MTUNIT ' +
          'FROM smetasourcedata as SM, data_estimate_temp as ES, ' +
          'card_rate_temp as RT, materialcard_temp as MT ' +
          'WHERE (SM.SM_ID = ' + IntToStr(FEstimateID) + ') AND ' +
          '(SM.SM_ID = ES.ID_ESTIMATE) AND (ES.ID_TYPE_DATA = 1) AND ' +
          '(ES.ID_TABLES = RT.ID) AND (RT.ID = MT.ID_CARD_RATE) AND ' +
          '(MT.MAT_CODE = ''' + edtSourceCode.Text + ''') AND ' +
          '(SM.OBJ_ID = ' + IntToStr(FObjectID) + ')'
      else
        qrEntry.SQL.Text := '';
    else
      Exit;
    end;
    qrEntry.Active := True;
  finally
    qrEntry.EnableControls;
  end;
end;

procedure TfrmReplacement.ChangeType(AType: byte);
var TmpStr: string;
begin
  case AType of
    //Материалы
    0:
    begin
      groupReplace.Caption := 'Материала:';
      dbgrdEntry.Columns[3].Title.Caption := 'Материал';

      if FFlag then
      begin
        groupCatalog.Caption := 'Справочник материалов за ' +
          AnsiLowerCase(arraymes[FMonth][1]) + ' ' + IntToStr(FYear) + 'г. ' +
          FRegionName + ':';
        TmpStr := 'SELECT material.material_id as "Id", mat_code as "Code", ' +
          'cast(mat_name as char(1024)) as "Name", unit_name as "Unit", ' +
          'coast' + IntToStr(FRegion) + '_1 as "PriceVAT", ' +
          'coast' + IntToStr(FRegion) + '_2 as "PriceNotVAT" ' +
          'FROM material, units, materialcoastg ' +
          'WHERE (material.unit_id = units.unit_id) ' +
          'and (material.material_id = materialcoastg.material_id) ' +
          'and (not mat_code like "П%") and (year=' + IntToStr(FYear) +
          ') and (monat=' + IntToStr(FMonth) +') ORDER BY mat_code;';
      end
      else
      begin
        groupCatalog.Caption := 'Справочник материалов:';
        TmpStr := 'SELECT material.material_id as "Id", mat_code as "Code", ' +
          'cast(mat_name as char(1024)) as "Name", unit_name as "Unit" ' +
          'FROM material, units ' +
          'WHERE (material.unit_id = units.unit_id) ' +
          'and (not mat_code like "П%") ORDER BY mat_code;';
      end;
    end;
    //Механизмы
    1:
    begin
      groupReplace.Caption := 'Механизма:';
      dbgrdEntry.Columns[3].Title.Caption := 'Механизм';

      if FFlag then
      begin
        groupCatalog.Caption := 'Справочник механизмов за ' +
          AnsiLowerCase(arraymes[FMonth][1]) + ' ' + IntToStr(FYear) + 'г.:';
        TmpStr := 'SELECT mechanizm.mechanizm_id as "Id", mech_code as "Code", ' +
          'cast(mech_name as char(1024)) as "Name", unit_name as "Unit", ' +
          'coast1 as "PriceVAT", coast2 as "PriceNotVAT" ' +
          'FROM mechanizm, units, mechanizmcoastg' +
          ' WHERE (mechanizm.unit_id = units.unit_id) and ' +
          '(mechanizm.mechanizm_id = mechanizmcoastg.mechanizm_id) and ' +
          '(year=' + IntToStr(FYear) + ') and (monat=' + IntToStr(FMonth) +
          ') ORDER BY mech_code;';
      end
      else
      begin
        groupCatalog.Caption := 'Справочник механизмов:';
        TmpStr := 'SELECT mechanizm.mechanizm_id as "Id", mech_code as "Code", ' +
          'cast(mech_name as char(1024)) as "Name", unit_name as "Unit" ' +
          'FROM mechanizm, units, mechanizmcoastg' +
          ' WHERE (mechanizm.unit_id = units.unit_id) ORDER BY mech_code;';
      end;
    end;
  end;

  Label8.Visible := True;
  LoadAnimator.Visible := True;
  LoadAnimator.Animate := True;
  ListSpr.Visible := False;
  ListSpr.Items.Clear;

  //Вызов нити выполняющей запрос на данные справлчника
  TThreadQuery.Create(TmpStr, Handle);

  edtSourceCode.Text := '';
  edtSourceName.Text := '';
  edtDestName.Text := '';
  edtDestCode.Text := '';
  edtCoeff.Text := '1';
end;

procedure TfrmReplacement.rgroupTypeClick(Sender: TObject);
begin
  if FCurType <> rgroupType.ItemIndex then
  begin
    FCurType := rgroupType.ItemIndex;
    //Флаг показывать цены или нет
    FFlag :=
      ((FCurType = 0) and (FMonth > 0) and (FYear > 0) and (FRegion > 0))
      or
      ((FCurType = 1) and (FMonth > 0) and (FYear > 0));
    ChangeType(FCurType);
  end;
end;

procedure TfrmReplacement.rgroupWhereClick(Sender: TObject);
begin
  if FCurWhere <> rgroupWhere.ItemIndex then
  begin
    FCurWhere := rgroupWhere.ItemIndex;
    LoadEntry(FCurWhere);
  end;
end;

procedure TfrmReplacement.btnCancelClick(Sender: TObject);
begin
  Close;
end;

{ TThreadQuery }

constructor TThreadQuery.Create(const ASQLText: String; AHandle: HWND);
begin
  inherited Create(true);
  FHandle := AHandle;

  FConnect := TFDConnection.Create(nil);
  FConnect.Params.Text := G_CONNECTSTR;
  FQrTemp := TFDQuery.Create(nil);
  FQrTemp.Connection := FConnect;
  FQrTemp.SQL.Text := ASQLText;

  FreeOnTerminate := True;
  Priority := tpLower;
  Resume;
end;

destructor TThreadQuery.Destroy;
begin
  FreeAndNil(FQrTemp);
  FreeAndNil(FConnect);
  inherited;
end;

procedure TThreadQuery.Execute;
begin
  inherited;
  try
    FQrTemp.Active := True;
    SendMessage(FHandle, WM_ONACTIVATE, WParam(FQrTemp), LParam(nil));
  except
    on e: exception do
      SendMessage(FHandle, WM_ONACTIVATE, WParam(nil), LParam(e));
  end;
end;

end.
