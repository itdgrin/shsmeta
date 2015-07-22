unit SprController;

interface
uses System.Classes,
     System.SysUtils,
     Winapi.Windows,
     System.SyncObjs,
     Data.DB,
     GlobsAndConst,
     Tools;

type
  TSprRecord = record
    ID: Integer;
    Code,
    Name,
    Unt: string;
    CoastNDS,
    CoastNoNDS,
    ZpMach,
    TrZatr: Extended;
  end;

  TSprArray = array of TSprRecord;

  TSprControl = class(TObject)
  private const
    MaxSprIndex = 3;
  private
    FHandle: HWND;
    //0 - материалы
    //1 - жби
    //2 - механизмы
    //3 - оборудование
    FAllSprList: array[0..MaxSprIndex] of TSprArray;
    FLoadSprFlags,
    FLoadPriceFlags: array[0..MaxSprIndex] of Boolean;
    FSprCSList: array[0..MaxSprIndex] of TCriticalSection;
    FThQueryList: array[0..MaxSprIndex] of TThreadQuery;

    FYear,
    FMonth,
    FRegion: Integer;

    procedure ThreadTerminate(Sender: TObject);
    procedure LoadSpr(ADataSet: TDataSet; AIndex: Integer);
    procedure LoadPrice(ADataSet: TDataSet; AIndex: Integer);
    procedure AddHeaderToException(AException: Exception; AIndex: Integer);

    function GetSprList(AIndex: Integer): TSprArray;
    function GetSprCount(AIndex: Integer): Integer;
    function GetSptLoad(AIndex: Integer): Boolean;
    function GetPriceLoad(AIndex: Integer): Boolean;
    function GetCS(AIndex: Integer): TCriticalSection;

  public
    constructor Create(AHandle: HWND);
    destructor Destroy; override;
    procedure SetPricePerion(AYear, AMonth, ARegion: Integer);

    property Year: Integer read FYear;
    property Month: Integer read FMonth;
    property Region: Integer read FRegion;

    property MatSpr: TSprArray Index 0 read GetSprList;
    property JBISpr: TSprArray Index 1 read GetSprList;
    property MechSpr: TSprArray Index 2 read GetSprList;
    property DevSpr: TSprArray Index 3 read GetSprList;

    property MatCount: Integer Index 0 read GetSprCount;
    property JBICount: Integer Index 1 read GetSprCount;
    property MechCount: Integer Index 2 read GetSprCount;
    property DevCount: Integer Index 3 read GetSprCount;

    property MatSprLoad: Boolean Index 0 read GetSptLoad;
    property JBISprLoad: Boolean Index 1 read GetSptLoad;
    property MechSprLoad: Boolean Index 2 read GetSptLoad;
    property DevSprLoad: Boolean Index 3 read GetSptLoad;

    property MatPriceLoad: Boolean Index 0 read GetPriceLoad;
    property JBIPriceLoad: Boolean Index 1 read GetPriceLoad;
    property MechPriceLoad: Boolean Index 2 read GetPriceLoad;
    property DevPriceLoad: Boolean Index 3 read GetPriceLoad;

    property MatSprCS: TCriticalSection Index 0 read GetCS;
    property JBISprCS: TCriticalSection Index 1 read GetCS;
    property MechSprCS: TCriticalSection Index 2 read GetCS;
    property DevSprCS: TCriticalSection Index 3 read GetCS;
  end;

var SprControl: TSprControl;

implementation

{ TSprControl }

constructor TSprControl.Create(AHandle: HWND);
var I: Integer;
    TmpStr: string;
begin
  inherited Create;
  try
    FHandle := AHandle;
    for I := 0 to MaxSprIndex do
    begin
      SetLength(FAllSprList[I], 0);
      FLoadSprFlags[I] := False;
      FLoadPriceFlags[I] := False;
      FSprCSList[I] := TCriticalSection.Create;
      FThQueryList[I] := TThreadQuery.Create('', 0, True, I);
      FThQueryList[I].OnTerminate := ThreadTerminate;
      FThQueryList[I].OnActivate := LoadSpr;
      case I of
        0: TmpStr :=
            'SELECT mt.material_id, mt.mat_code, mt.mat_name, ut.unit_name ' +
            'FROM material mt LEFT JOIN units ut ' +
            'ON (mt.unit_id = ut.unit_id) WHERE (mt.MAT_TYPE = 1) ' +
            'ORDER BY mt.mat_code;';
        1: TmpStr :=
            'SELECT mt.material_id, mt.mat_code, mt.mat_name, ut.unit_name ' +
            'FROM material mt LEFT JOIN units ut ' +
            'ON (mt.unit_id = ut.unit_id) WHERE (mt.MAT_TYPE = 2) ' +
            'ORDER BY mt.mat_code;';
        2: TmpStr :=
            'SELECT mh.mechanizm_id, mh.mech_code, mh.mech_name, ut.unit_name, ' +
            'mh.MECH_PH ' +
            'FROM mechanizm mh LEFT JOIN units ut ' +
            'ON (mh.unit_id = ut.unit_id) ORDER BY mh.mech_code;';
        3: TmpStr :=
            'SELECT dv.device_id, dv.device_code1, dv.name, ut.unit_name ' +
            'FROM devices dv LEFT JOIN units ut ' +
            'ON (dv.unit = ut.unit_id) ORDER BY dv.device_code1';
        else
          raise Exception.Create('Неизвестный индекс справочника');
      end;
      FThQueryList[I].SQLText := TmpStr;
      FThQueryList[I].Start;
    end;
  except
    Destroy;
    raise;
  end;
end;

destructor TSprControl.Destroy;
var I: Integer;
begin
  for I := 0 to MaxSprIndex do
  begin
    if Assigned(FSprCSList[I]) then
     FreeAndNil(FSprCSList[I]);
    if Assigned(FThQueryList[I]) then
      FreeAndNil(FThQueryList[I]);
  end;
  inherited;
end;

function TSprControl.GetSprList(AIndex: Integer): TSprArray;
begin
  if (AIndex < 0) and (AIndex > MaxSprIndex) then
    raise Exception.Create('Неизвестный индекс справочника');

  Result := FAllSprList[AIndex];
end;

function TSprControl.GetSprCount(AIndex: Integer): Integer;
begin
  if (AIndex < 0) and (AIndex > MaxSprIndex) then
    raise Exception.Create('Неизвестный индекс справочника');

  Result := Length(FAllSprList[AIndex]);
end;

function TSprControl.GetSptLoad(AIndex: Integer): Boolean;
begin
  if (AIndex < 0) and (AIndex > MaxSprIndex) then
    raise Exception.Create('Неизвестный индекс справочника');

  Result := FLoadSprFlags[AIndex];
end;

function TSprControl.GetPriceLoad(AIndex: Integer): Boolean;
begin
  if (AIndex < 0) and (AIndex > MaxSprIndex) then
    raise Exception.Create('Неизвестный индекс справочника');

  Result := FLoadPriceFlags[AIndex];
end;

function TSprControl.GetCS(AIndex: Integer): TCriticalSection;
begin
  if (AIndex < 0) and (AIndex > MaxSprIndex) then
    raise Exception.Create('Неизвестный индекс справочника');

  Result := FSprCSList[AIndex];
end;

procedure TSprControl.AddHeaderToException(AException: Exception; AIndex: Integer);
var TmpStr: string;
begin
  case AIndex of
    0: TmpStr := 'материалов ';
    1: TmpStr := 'ЖБИ ';
    2: TmpStr := 'механизмов ';
    3: TmpStr := 'оборудования ';
    else TmpStr := '';
  end;

  AException.Message := 'При загрузке справочника ' + TmpStr +
    'возникло исключение' + sLineBreak + AException.Message;
end;

procedure TSprControl.ThreadTerminate(Sender: TObject);
begin
  if (FHandle > 0) and
     (Sender is TThread) and
     Assigned(TThread(Sender).FatalException) then
  begin
    AddHeaderToException(Exception(TThread(Sender).FatalException),
      TThreadQuery(Sender).Tag);

    SendMessage(FHandle, WM_EXCEPTION,
      WParam(TThread(Sender).FatalException), 0);
  end;
end;

procedure TSprControl.LoadSpr(ADataSet: TDataSet; AIndex: Integer);
var TmpCount,
    TmpInd: Integer;
begin
  if (AIndex < 0) and (AIndex > MaxSprIndex) then
    raise Exception.Create('Неизвестный индекс справочника');

  TmpCount := 0;
  TmpInd := 0;

  FSprCSList[AIndex].Enter;
  try
    ADataSet.First;
    while not ADataSet.Eof do
    begin
      if TmpCount = TmpInd then
      begin
        TmpCount := TmpCount + 1000;
        SetLength(FAllSprList[AIndex], TmpCount);
      end;

      FAllSprList[AIndex][TmpInd].ID := ADataSet.Fields[0].AsInteger;
      FAllSprList[AIndex][TmpInd].Code := ADataSet.Fields[1].AsString;
      FAllSprList[AIndex][TmpInd].Name := ADataSet.Fields[2].AsString;
      FAllSprList[AIndex][TmpInd].Unt := ADataSet.Fields[3].AsString;
      if AIndex = 2 then
        FAllSprList[AIndex][TmpInd].TrZatr := ADataSet.Fields[4].AsExtended;

      Inc(TmpInd);
      ADataSet.Next;
    end;
    SetLength(FAllSprList[AIndex], TmpInd);
    FLoadSprFlags[AIndex] := True;
  finally
    FSprCSList[AIndex].Leave;
  end;
end;

procedure TSprControl.SetPricePerion(AYear, AMonth, ARegion: Integer);
var I, J: Integer;
    TmpStr: string;
begin
  if (AMonth < 1) or (AMonth > 12) or (AYear < 0) or
     (ARegion < 1) or (ARegion > 7) then
    raise Exception.Create('Неверные входные данные');

  J := -1;
  if (FRegion <> ARegion) then
    J := 1;
  if (FYear <> AYear) or (FMonth <> AMonth) then
    J := 2;

  FYear := AYear;
  FMonth := AMonth;
  FRegion := ARegion;

  //Для оборудования нет цен
  for I := 0 to J do
  begin
    FLoadPriceFlags[I] := False;
    FreeAndNil(FThQueryList[I]);
    FThQueryList[I] := TThreadQuery.Create('', 0, True, I);
    FThQueryList[I].OnTerminate := ThreadTerminate;
    FThQueryList[I].OnActivate := LoadPrice;
    case I of
      0: TmpStr :=
          'SELECT mt.mat_code, mc.coast' + IntToStr(FRegion) + '_2, ' +
          'mc.coast' + IntToStr(FRegion) + '_1 ' +
          'FROM material mt LEFT JOIN materialcoastg mc ' +
          'ON (mt.material_id = mc.material_id) ' +
          'AND (mc.year = ' + IntToStr(FYear) + ') ' +
          'AND (mc.monat = ' + IntToStr(FMonth) + ') ' +
          'WHERE (mt.MAT_TYPE = 1) ORDER BY mt.mat_code;';
      1: TmpStr :=
          'SELECT mt.mat_code, mc.coast' + IntToStr(FRegion) + '_2, ' +
          'mc.coast' + IntToStr(FRegion) + '_1 ' +
          'FROM material mt LEFT JOIN materialcoastg mc ' +
          'ON (mt.material_id = mc.material_id) ' +
          'AND (mc.year = ' + IntToStr(FYear) + ') ' +
          'AND (mc.monat = ' + IntToStr(FMonth) + ') ' +
          'WHERE (mt.MAT_TYPE = 1) ORDER BY mt.mat_code;';
      2: TmpStr :=
          'SELECT mh.mech_code, mc.coast1, mc.coast2, ZP1, mc.ZP1 ' +
          'FROM mechanizm mh LEFT JOIN mechanizmcoastg mc ' +
          'ON (mh.mechanizm_id = mc.mechanizm_id) ' +
          'AND (mc.year=' + IntToStr(FYear) + ') ' +
          'AND (mc.monat=' + IntToStr(FMonth) + ') ORDER BY mh.mech_code;';
      else
        raise Exception.Create('Неизвестный индекс справочника');
    end;
    FThQueryList[I].SQLText := TmpStr;
    FThQueryList[I].Start;
  end;
end;

procedure TSprControl.LoadPrice(ADataSet: TDataSet; AIndex: Integer);
begin

end;

end.
