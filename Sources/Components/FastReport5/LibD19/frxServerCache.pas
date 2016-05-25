
{******************************************}
{                                          }
{             FastReport v5.0              }
{            Server cahce module           }
{                                          }
{         Copyright (c) 1998-2014          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxServerCache;

{$I frx.inc}

interface

uses Windows, Classes, SysUtils, frxUtils, frxServerUtils, frxNetUtils,
     frxVariables, frxClass, frxServerLog, SyncObjs;

type
  TfrxServerCacheItem = class(TCollectionItem)
  private
    FReportName: String;
    FVariables: TfrxVariables;
    FFileName: String;
    FExpTime: TDateTime;
    FSessionId: String;
    FStream: TStream;
    FInternalId: String;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property ReportName: String read FReportName write FReportName;
    property Variables: TfrxVariables read FVariables write FVariables;
    property FileName: String read FFileName write FFileName;
    property ExpTime: TDateTime read FExpTime write FExpTime;
    property SessionId: String read FSessionId write FSessionId;
    property Stream: TStream read FStream write FStream;
    property InternalId: String read FInternalId write FInternalId;
  end;

  TfrxServerCacheSpool = class(TCollection)
  private
    function GetItems(Index: Integer): TfrxServerCacheItem;
    function EqualVariables(const Var1: TfrxVariables; const Var2: TfrxVariables): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[Index: Integer]: TfrxServerCacheItem read GetItems;
    procedure Clear;
  published
    function Add: TfrxServerCacheItem;
    function Insert(Index: Integer): TfrxServerCacheItem;
    function IndexOf(const ReportName: String; const Variables: TfrxVariables; const SessionId: String): Integer;
  end;

  TfrxServerCache = class (TThread)
  private
    FCachePath: String;
    FActive: Boolean;
    FLatency: Integer;
    FHeap: TfrxServerCacheSpool;
    FMemoryCache: Boolean;
    FThreadActive: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure CleanUpFiles;
    procedure RemoveExpired;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    function GetCachedStream(const Report: TfrxReport; const ReportName: String; const Variables: TfrxVariables; const Id: String): Boolean;
    function GetCachedReportById(const Report: TfrxReport; const Id: String): Boolean;
    procedure Open;
    procedure Close;
    procedure Clear;
    procedure AddReport(const Report: TfrxReport;
      const ReportName: String; const Variables: TfrxVariables; const Id: String; const InternalId: String);

    property Active: Boolean read FActive write SetActive;
    property CachePath: String read FCachePath write FCachePath;
    property DefaultLatency: Integer read FLatency write FLatency;
    property Heap: TfrxServerCacheSpool read FHeap;
    property MemoryCache: Boolean read FMemoryCache write FMemoryCache;
  end;

const
  CACHE_PREFIX = '$fr';

var
  CacheCS1: TCriticalSection;
  ReportCache: TfrxServerCache;

implementation

uses frxFileUtils, frxServerConfig, frxServerReportsList;

{ TfrxServerCacheSpool }

function TfrxServerCacheSpool.Add: TfrxServerCacheItem;
begin
  Result := TfrxServerCacheItem.Create(Self);
end;

procedure TfrxServerCacheSpool.Clear;
var
  i: Integer;
begin
  CacheCS1.Enter;
  try
  for i := 0 to Count - 1 do
    if Assigned(Items[i].Stream) then
    begin
        Items[i].Stream.Free;
        Items[i].Stream := nil;
    end;
  finally
    CacheCS1.Leave;
  end;
  inherited Clear;
end;

constructor TfrxServerCacheSpool.Create;
begin
  inherited Create(TfrxServerCacheItem);
end;

destructor TfrxServerCacheSpool.Destroy;
begin
  inherited;
end;

function TfrxServerCacheSpool.EqualVariables(const Var1,
  Var2: TfrxVariables): Boolean;
var
  i, j, k: Integer;
begin
  Result := False;
  if Assigned(Var1) and Assigned(Var2) then
  begin
    j := Var1.Count;
    if j = Var2.Count then
    begin
      Result := True;
      for i := 0 to j - 1 do
      begin
        k := Var2.IndexOf(Var1.Items[i].Name);
        if (k = -1) or (Var2.Items[k].Value <> Var1.Items[i].Value) then
        begin
          Result := False;
          Break;
        end;
      end;
    end;
  end
  else if Var1 = Var2 then
    Result := True;
end;

function TfrxServerCacheSpool.GetItems(Index: Integer): TfrxServerCacheItem;
begin
  Result := TfrxServerCacheItem(inherited Items[Index]);
end;

function TfrxServerCacheSpool.IndexOf(const ReportName: String;
  const Variables: TfrxVariables; const SessionId: String): Integer;
var
  i: Integer;
  s: String;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    s := Items[i].SessionId;
    if ((AnsiCompareText(ReportName, Items[i].ReportName) = 0) and
       EqualVariables(Items[i].Variables, Variables)) and (s = '') or
       ((AnsiCompareText(SessionId, s) = 0) and (s <> '')) then
    begin
      Result := i;
      break;
    end;
  end;
end;

function TfrxServerCacheSpool.Insert(Index: Integer): TfrxServerCacheItem;
begin
  Result := TfrxServerCacheItem(inherited Insert(Index));
end;

{ TfrxServerCacheItem }

constructor TfrxServerCacheItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FStream := nil;
end;

destructor TfrxServerCacheItem.Destroy;
begin
  CacheCS1.Enter;
  try
    if Assigned(FStream) then
      FStream.Free;
    if Assigned(FVariables) then
      FVariables.Free;
  finally
    CacheCS1.Leave;
  end;
  inherited;
end;

{ TfrxServerCache }

procedure TfrxServerCache.AddReport(const Report: TfrxReport;
  const ReportName: String; const Variables: TfrxVariables; const Id: String; const InternalId: String);
var
  Item: TfrxServerCacheItem;
  Lat: TDateTime;
begin
  if Active then
  begin
    CacheCS1.Enter;
    try
      Lat := ReportsList.GetCacheLatency(ReportName) / 86400;
      if Lat > 0 then
      begin
        Item := FHeap.Add;
        Item.ReportName := ReportName;
        Item.InternalId := InternalId;
        if Assigned(Variables) then
        begin
          Item.Variables := TfrxVariables.Create;
          Item.Variables.Assign(Variables);
        end;
        Item.ExpTime := Now + Lat;
        if Id <> '' then
          Item.ExpTime := Item.ExpTime * 20;
        if FMemoryCache then
        begin
          Item.Stream := TMemoryStream.Create;
          try
            Report.PreviewPages.SaveToStream(Item.Stream);
            Item.Stream.Position := 0;
          except
            Item.Stream.Free;
            FMemoryCache := False;
          end;
        end;
        if not FMemoryCache then
        begin
          Item.FileName := GetUniqueFileName(FCachePath, CACHE_PREFIX);
          try
            Report.PreviewPages.SaveToFile(Item.FileName);
          except
            Active := False;
          end;
        end;
        Item.SessionId := Id;
      end;
    finally
      CacheCS1.Leave;
    end;
  end;
end;

procedure TfrxServerCache.CleanUpFiles;
var
  SRec: TSearchRec;
  i: Integer;
begin
 if DirectoryExists(FCachePath) then
 begin
   i := FindFirst(FCachePath + CACHE_PREFIX + '*.*', 0, SRec);
   try
     while i = 0 do
     begin
       try
         DeleteFile(FCachePath + SRec.Name);
       except
       end;
       i := FindNext(SRec);
     end;
   finally
     FindClose(SRec);
   end;
 end;
end;

procedure TfrxServerCache.Clear;
begin
  FHeap.Clear;
  CleanUpFiles;
end;

procedure TfrxServerCache.Close;
begin
  if FActive then
  begin
    Suspend;
    Clear;
    FActive := False;
  end;
end;

constructor TfrxServerCache.Create;
begin
  inherited Create(True);
  FMemoryCache := ServerConfig.GetValue('server.cache.target') = 'memory';
  FCachePath := frxGetAbsPathDir(ServerConfig.GetValue('server.cache.path'), ServerConfig.ConfigFolder);
  FActive := ServerConfig.GetValue('server.cache.active') = 'yes';
  FLatency := StrToInt(ServerConfig.GetValue('server.cache.defaultlatency'));
  FHeap := TfrxServerCacheSpool.Create;
  CleanUpFiles;
  Resume;
end;

destructor TfrxServerCache.Destroy;
begin
  Clear;
  Terminate;
  PMessages;
  while FThreadActive do
    Sleep(10);
  FHeap.Free;
  inherited;
end;

procedure TfrxServerCache.Execute;
var
  i: Integer;
begin
  FThreadActive := True;
  while not Terminated do
  begin
    RemoveExpired;
    i := 0;
    while (not Terminated) and (i < 100) do
    begin
      Sleep(100);
      Inc(i);
      PMessages;
    end;
  end;
  FThreadActive := False;
end;

function TfrxServerCache.GetCachedStream(const Report: TfrxReport;
  const ReportName: String; const Variables: TfrxVariables; const Id: String): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Active then
  begin
    CacheCS1.Enter;
    try
      i := FHeap.IndexOf(ReportName, Variables, Id);
      if i <> -1 then
      begin
        try
          if Assigned(FHeap.Items[i].Stream) then
          begin
            FHeap.Items[i].Stream.Position := 0;
            Report.PreviewPages.LoadFromStream(FHeap.Items[i].Stream);
            Result := True;
          end
          else if FileExists(FHeap.Items[i].FileName) then
          begin
            Report.PreviewPages.LoadFromFile(FHeap.Items[i].FileName);
            Result := True;
          end;
        except
          on e: Exception do
          begin
            LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + Id + #9'cache read error: ' + FHeap.Items[i].FileName + ' ' + Report.Errors.Text + e.Message);
            LogWriter.ErrorReached;
            Result := False;
          end;
        end;
      end
    finally
      CacheCS1.Leave;
    end;
  end;
  if Result then
    LogWriter.StatAddCacheHit;
end;

procedure TfrxServerCache.Open;
begin
  if not FActive then
  begin
    Resume;
    FActive := True;
  end;
end;

procedure TfrxServerCache.RemoveExpired;
var
  i: Integer;
begin
  i := 0;
  CacheCS1.Enter;
  try
    while i < FHeap.Count do
    begin
      if FHeap.Items[i].ExpTime <= Now then
      begin
        if Assigned(FHeap.Items[i].Stream) then
        begin
          FHeap.Items[i].Stream.Free;
          FHeap.Items[i].Stream := nil;
        end;
        if FileExists(FHeap.Items[i].FileName) then
          DeleteFile(FHeap.Items[i].FileName);
        FHeap.Items[i].Free; // Delete(i);
      end else Inc(i);
    end;
  finally
    CacheCS1.Leave;
  end;
end;

procedure TfrxServerCache.SetActive(const Value: Boolean);
begin
  if Value <> FActive then
    if Value then Open
    else Close;
end;

function TfrxServerCache.GetCachedReportById(const Report: TfrxReport;
  const Id: String): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Active then
  begin
    CacheCS1.Enter;
    try
      for i := 0 to FHeap.Count - 1 do
      begin
        if FHeap.Items[i].InternalId = Id then
        begin
          try
            if Assigned(FHeap.Items[i].Stream) then
            begin
              FHeap.Items[i].Stream.Position := 0;
              Report.PreviewPages.LoadFromStream(FHeap.Items[i].Stream);
              Result := True;
            end
            else if FileExists(FHeap.Items[i].FileName) then
            begin
              Report.PreviewPages.LoadFromFile(FHeap.Items[i].FileName);
              Result := True;
            end;
          except
            on e: Exception do
            begin
              LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + Id + #9'cache read error: ' + FHeap.Items[i].FileName + ' ' + Report.Errors.Text + e.Message);
              LogWriter.ErrorReached;
              Result := False;
            end;
          end;
          Result := True;
          break;
        end;

      end;
    finally
      CacheCS1.Leave;
    end;
  end;
  if Result then
    LogWriter.StatAddCacheHit;
end;

initialization
  CacheCS1 := TCriticalSection.Create;

finalization
  CacheCS1.Free;

end.
