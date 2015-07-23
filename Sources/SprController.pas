unit SprController;

interface
uses System.Classes,
     System.SysUtils,
     Winapi.Windows,
     System.SyncObjs,
     Data.DB,
     GlobsAndConst,
     Tools;

const
  CMatIndex = 0;
  CJBIIndex = 1;
  CMechIndex = 2;
  CDevIndex = 3;
  MaxSprIndex = 3;

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

  TSprPeriad = record
    Year,
    Month,
    Region: Integer;
  end;

  PSprRecord = ^TSprRecord;
  TSprArray = array of TSprRecord;

  //Класс использует потоки но не является потокобезопасным
  //Доступ к справочникам возможет только просле проверки флагов загрузки
  TSprControl = class(TObject)
  private
    FHandle: HWND;
    FAllSprList: array[0..MaxSprIndex] of TSprArray;
    FLoadSprFlags,
    FLoadPriceFlags: array[0..MaxSprIndex] of Boolean;
    FThQueryList: array[0..MaxSprIndex] of TThreadQuery;

    FYear,
    FMonth,
    FRegion: Integer;

    FNotifyCS: TCriticalSection;

    FSprNotifyList,
    FPriceNotifyList: array[0..MaxSprIndex] of array of HWND;

    procedure ThreadTerminate(Sender: TObject);
    procedure LoadSpr(ADataSet: TDataSet; AIndex: Integer);
    procedure LoadPrice(ADataSet: TDataSet; AIndex: Integer);
    procedure AddHeaderToException(AException: Exception; AIndex: Integer);

    function GetSprList(AIndex: Integer): TSprArray;
    function GetSprCount(AIndex: Integer): Integer;
    function GetSptLoad(AIndex: Integer): Boolean;
    function GetPriceLoad(AIndex: Integer): Boolean;
  public
    constructor Create(AHandle: HWND);
    destructor Destroy; override;

    procedure SetPriceNotify(AYear, AMonth, ARegion: Integer;
      ANotifyHandle: HWND; ANotifyIndex: Integer);

    procedure SetSprNotify(ANotifyHandle: HWND; ANotifyIndex: Integer);

    property Year: Integer read FYear;
    property Month: Integer read FMonth;
    property Region: Integer read FRegion;

    property SprList[AIndex: Integer]: TSprArray read GetSprList;
    property SprCount[AIndex: Integer]: Integer read GetSprCount;
    property SprLoaded[AIndex: Integer]: Boolean read GetSptLoad;
    property PriceLoaded[AIndex: Integer]: Boolean read GetPriceLoad;
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
    FNotifyCS := TCriticalSection.Create;

    for I := 0 to MaxSprIndex do
    begin
      SetLength(FAllSprList[I], 0);
      FLoadSprFlags[I] := False;
      FLoadPriceFlags[I] := False;
      SetLength(FSprNotifyList[I], 0);
      SetLength(FPriceNotifyList[I], 0);
      FThQueryList[I] := TThreadQuery.Create('', 0, True, I);
      FThQueryList[I].OnTerminate := ThreadTerminate;
      FThQueryList[I].OnActivate := LoadSpr;
      case I of
        CMatIndex: TmpStr :=
            'SELECT mt.material_id, mt.mat_code, mt.mat_name, ut.unit_name ' +
            'FROM material mt LEFT JOIN units ut ' +
            'ON (mt.unit_id = ut.unit_id) WHERE (mt.MAT_TYPE = 1) ' +
            'ORDER BY mt.mat_code;';
        CJBIIndex: TmpStr :=
            'SELECT mt.material_id, mt.mat_code, mt.mat_name, ut.unit_name ' +
            'FROM material mt LEFT JOIN units ut ' +
            'ON (mt.unit_id = ut.unit_id) WHERE (mt.MAT_TYPE = 2) ' +
            'ORDER BY mt.mat_code;';
        CMechIndex: TmpStr :=
            'SELECT mh.mechanizm_id, mh.mech_code, mh.mech_name, ut.unit_name, ' +
            'mh.MECH_PH ' +
            'FROM mechanizm mh LEFT JOIN units ut ' +
            'ON (mh.unit_id = ut.unit_id) ORDER BY mh.mech_code;';
        CDevIndex: TmpStr :=
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
  FreeAndNil(FNotifyCS);
  for I := 0 to MaxSprIndex do
  begin
    if Assigned(FThQueryList[I]) then
      FreeAndNil(FThQueryList[I]);
  end;
  inherited;
end;

function TSprControl.GetSprList(AIndex: Integer): TSprArray;
begin
  if (AIndex < 0) or (AIndex > MaxSprIndex) then
    raise Exception.Create('Неизвестный индекс справочника');

  Result := FAllSprList[AIndex];
end;

function TSprControl.GetSprCount(AIndex: Integer): Integer;
begin
  if (AIndex < 0) or (AIndex > MaxSprIndex) then
    raise Exception.Create('Неизвестный индекс справочника');

  Result := Length(FAllSprList[AIndex]);
end;

function TSprControl.GetSptLoad(AIndex: Integer): Boolean;
begin
  if (AIndex < 0) or (AIndex > MaxSprIndex) then
    raise Exception.Create('Неизвестный индекс справочника');

  Result := FLoadSprFlags[AIndex];
end;

function TSprControl.GetPriceLoad(AIndex: Integer): Boolean;
begin
  if (AIndex < 0) or (AIndex > MaxSprIndex) then
    raise Exception.Create('Неизвестный индекс справочника');

  Result := FLoadPriceFlags[AIndex];
end;

procedure TSprControl.AddHeaderToException(AException: Exception; AIndex: Integer);
var TmpStr: string;
begin
  case AIndex of
    CMatIndex: TmpStr := 'материалов ';
    CJBIIndex: TmpStr := 'ЖБИ ';
    CMechIndex: TmpStr := 'механизмов ';
    CDevIndex: TmpStr := 'оборудования ';
    else TmpStr := '';
  end;

  AException.Message := 'При загрузке справочника ' + TmpStr +
    'возникло исключение:' + sLineBreak + AException.Message;
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
var I,
    TmpCount,
    TmpInd: Integer;
begin
  if (AIndex < 0) or (AIndex > MaxSprIndex) then
    raise Exception.Create('Неизвестный индекс справочника');

  TmpCount := 0;
  TmpInd := 0;

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
    if AIndex = CMechIndex then
      FAllSprList[AIndex][TmpInd].TrZatr := ADataSet.Fields[4].AsExtended;

    Inc(TmpInd);
    ADataSet.Next;
  end;
  SetLength(FAllSprList[AIndex], TmpInd);

  FNotifyCS.Enter;
  try
    FLoadSprFlags[AIndex] := True;
    for I := Low(FSprNotifyList[AIndex]) to High(FSprNotifyList[AIndex]) do
      PostMessage(FSprNotifyList[AIndex][I], WM_SPRLOAD, WParam(AIndex), 0);
    SetLength(FSprNotifyList[AIndex], 0);
  finally
    FNotifyCS.Leave;
  end;
end;

procedure TSprControl.SetSprNotify(ANotifyHandle: HWND; ANotifyIndex: Integer);
var I: Integer;
begin
  if (ANotifyHandle > 0) and
     ((ANotifyIndex < 0) or
      (ANotifyIndex > MaxSprIndex)) then
    raise Exception.Create('Неизвестный индекс справочника');

  if (ANotifyHandle > 0) then
  begin
    FNotifyCS.Enter;
    try
      if FLoadSprFlags[ANotifyIndex] then
          PostMessage(ANotifyHandle, WM_SPRLOAD, WParam(ANotifyIndex), 0)
      else
      begin
        I := Length(FSprNotifyList[ANotifyIndex]);
        SetLength(FSprNotifyList[ANotifyIndex], I + 1);
        FSprNotifyList[ANotifyIndex][I] := ANotifyHandle;
      end;
    finally
      FNotifyCS.Leave;
    end;
  end;
end;

procedure TSprControl.SetPriceNotify(AYear, AMonth, ARegion: Integer;
  ANotifyHandle: HWND; ANotifyIndex: Integer);
var I, J: Integer;
    TmpStr: string;
begin
  if (AMonth < 0) or (AMonth > 12) or (AYear < 0) or
     (ARegion < 0) or (ARegion > 7) then
    raise Exception.Create('Неверные входные данные');

  if (ANotifyHandle > 0) and
     ((ANotifyIndex < 0) or
      (ANotifyIndex > MaxSprIndex) or
      (ANotifyIndex = CDevIndex)) then
    raise Exception.Create('Неизвестный индекс справочника');

  if AYear = 0 then
    AYear := FYear;
  if AMonth = 0 then
    AMonth := FMonth;
  if ARegion = 0 then
    ARegion := FRegion;

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
      CMatIndex: TmpStr :=
          'SELECT mt.material_id, mt.mat_code, mc.coast' + IntToStr(FRegion) + '_2, ' +
          'mc.coast' + IntToStr(FRegion) + '_1 ' +
          'FROM material mt LEFT JOIN materialcoastg mc ' +
          'ON (mt.material_id = mc.material_id) ' +
          'AND (mc.year = ' + IntToStr(FYear) + ') ' +
          'AND (mc.monat = ' + IntToStr(FMonth) + ') ' +
          'WHERE (mt.MAT_TYPE = 1) ORDER BY mt.mat_code;';
      CJBIIndex: TmpStr :=
          'SELECT mt.material_id, mt.mat_code, mc.coast' + IntToStr(FRegion) + '_2, ' +
          'mc.coast' + IntToStr(FRegion) + '_1 ' +
          'FROM material mt LEFT JOIN materialcoastg mc ' +
          'ON (mt.material_id = mc.material_id) ' +
          'AND (mc.year = ' + IntToStr(FYear) + ') ' +
          'AND (mc.monat = ' + IntToStr(FMonth) + ') ' +
          'WHERE (mt.MAT_TYPE = 2) ORDER BY mt.mat_code;';
      CMechIndex: TmpStr :=
          'SELECT mh.mechanizm_id, mh.mech_code, mc.coast1, mc.coast2, mc.ZP1 ' +
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

  if (ANotifyHandle > 0) then
  begin
    FNotifyCS.Enter;
    try
      if FLoadPriceFlags[ANotifyIndex] then
          PostMessage(ANotifyHandle, WM_PRICELOAD, WParam(ANotifyIndex), 0)
      else
      begin
        I := Length(FPriceNotifyList[ANotifyIndex]);
        SetLength(FPriceNotifyList[ANotifyIndex], I + 1);
        FPriceNotifyList[ANotifyIndex][I] := ANotifyHandle;
      end;
    finally
      FNotifyCS.Leave;
    end;
  end;
end;

procedure TSprControl.LoadPrice(ADataSet: TDataSet; AIndex: Integer);
var I, J: Integer;
    e: Exception;
    CompRes: Integer;
    SeveralCodes: Boolean;
begin
  if (AIndex < 0) or (AIndex > MaxSprIndex) then
    raise Exception.Create('Неизвестный индекс справочника');

  if not FLoadSprFlags[AIndex] then
  begin
    e := Exception.Create('Справочник не загружен');
    AddHeaderToException(e, AIndex);
    raise e;
  end;

  for I := Low(FAllSprList[AIndex]) to High(FAllSprList[AIndex]) do
  begin
    FAllSprList[AIndex][I].CoastNDS := 0;
    FAllSprList[AIndex][I].CoastNoNDS := 0;
    FAllSprList[AIndex][I].ZpMach := 0;
  end;

  I := 0;
  SeveralCodes := False; //Нужен для выявления блока из одинаковых кодов, если такое вообще возможно

  ADataSet.First;
  while not ADataSet.Eof do
  begin
    for J := I to High(FAllSprList[AIndex]) do
    begin
      CompRes := string.Compare(FAllSprList[AIndex][J].Code, ADataSet.Fields[1].AsString);

      if (FAllSprList[AIndex][J].ID = ADataSet.Fields[0].AsInteger) then
      begin
        FAllSprList[AIndex][J].CoastNDS := ADataSet.Fields[2].AsExtended;
        FAllSprList[AIndex][J].CoastNoNDS := ADataSet.Fields[3].AsExtended;
        if AIndex = CMechIndex then
          FAllSprList[AIndex][J].ZpMach := ADataSet.Fields[4].AsExtended;
        if not SeveralCodes then
          I := J + 1;
        Break;
      end;

      if (CompRes = 0) then
        SeveralCodes := True
      else if (CompRes < 0) then
        SeveralCodes := False
      else
        Break;
    end;
    ADataSet.Next;
  end;

  FNotifyCS.Enter;
  try
    FLoadPriceFlags[AIndex] := True;
    for I := Low(FPriceNotifyList[AIndex]) to High(FPriceNotifyList[AIndex]) do
      PostMessage(FPriceNotifyList[AIndex][I], WM_PRICELOAD, WParam(AIndex), 0);
    SetLength(FPriceNotifyList[AIndex], 0);
  finally
    FNotifyCS.Leave;
  end;
end;

end.
