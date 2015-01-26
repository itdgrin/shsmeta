unit UpdateModule;

interface

uses
  System.Classes, System.SysUtils, DateUtils, Vcl.Dialogs, SyncObjs,
  Winapi.Windows, Winapi.Messages;

const
  //Интервал времени через который происходит опрос сервака
  GetVersionInterval = 20000;

  WM_SHOW_SPLASH = WM_USER + 1;

type
  TVersion = record
    App: integer;
    RefDB: integer;
    UserDB: integer;
  end;
  PVersion = ^TVersion;

 { TNewVersion = record
    DB: integer;
    DBPath: ShortString;
  end;
  TNewVersionList = array of TNewVersion;
  }

  TServiceResponse = class(TPersistent)
  private
    {fUpdeteStatys: byte;
    fUpVersion: TVersion;
    fCount: integer;
    fNewVersions: TNewVersionList;
    function GetNewVersions(AIndex: Integer): TNewVersion;
    procedure SetNewVersions(AIndex: Integer; ANewVersion: TNewVersion);
    procedure SortNewVersions;
    procedure Add(ANewVersion: TNewVersion);
    procedure Delete(AIndex: Integer); }
  public
    procedure Assign(Source: TPersistent); override;
    {procedure Clear;
    constructor Create;
    destructor Destroy; override;

    property UpdeteStatys: byte read fUpdeteStatys write fUpdeteStatys;
    property UpVersion: TVersion read fUpVersion write fUpVersion;
    property Count: integer read fCount write fCount;
    property NewVersions[Index: Integer]: TNewVersion read GetNewVersions write SetNewVersions;}
  end;

type
  TUpdateThread = class(TThread)
  private
    FCurVersion : TVersion; //Текушая версия программы
    FMainHandle: HWND;

    FUREvent, FTermEvent: TEvent;
    FVersionCS: TCriticalSection;
    FServiceResponse: TServiceResponse; //Ответ службы

    function GetServiceResponse: TServiceResponse;
    procedure GetVersion; //Отправляет запрос на получение версии на серверее
    //Показать всплывающее окно о наличии обновлений
    procedure ShowSplash;
    { Private declarations }
  protected
    procedure Execute; override;
  public
    property ServiceResponse: TServiceResponse read GetServiceResponse;
    procedure UserRequest;
    procedure Terminate;
    constructor Create(AVersion: TVersion; AMainHandle: HWND); overload;
    destructor Destroy; override;
  end;

implementation

{ UpdateThread }

constructor TUpdateThread.Create(AVersion: TVersion;
  AMainHandle: HWND);
begin
  inherited Create(true);

  FCurVersion := AVersion;
  FMainHandle := AMainHandle;

  FUREvent := TEvent.Create(nil, true, false, '');
  FTermEvent := TEvent.Create(nil, true, false, '');
  FVersionCS := TCriticalSection.Create;
  FServiceResponse := TServiceResponse.Create;

  Priority :=  tpLower;
  Resume;
end;

destructor TUpdateThread.Destroy;
begin
  FServiceResponse.Free;
  FVersionCS.Free;
  FUREvent.Free;
  FTermEvent.Free;
  inherited;
end;

procedure TUpdateThread.UserRequest;
begin
  FUREvent.SetEvent;
end;
procedure TUpdateThread.Terminate;
begin
  inherited Terminate;
  FTermEvent.SetEvent;
end;

function TUpdateThread.GetServiceResponse: TServiceResponse;
var r : TServiceResponse;
begin
  FVersionCS.Enter;
  try
    r := TServiceResponse.Create;
    r.Assign(FServiceResponse);
    Result := r;
  finally
    FVersionCS.Leave;
  end;
end;

procedure TUpdateThread.GetVersion;
var NewVersion : TVersion;
    Temp1: TVersion;
begin
 { FVersionCS.Enter;
  try
    FServiceResponse.Clear;

    FServiceResponse.fUpdeteStatys := 1;
    Temp1.RefDB := 3;
    FServiceResponse.fUpVersion := Temp1;
    Temp2.DB := 3;
    FServiceResponse.Add(Temp2);
    Temp2.DB := 1;
    FServiceResponse.Add(Temp2);
    Temp2.DB := 2;
    FServiceResponse.Add(Temp2);

    NewVersion := FServiceResponse.fUpVersion;
  finally
    FVersionCS.Leave;
  end;

  if (NewVersion.RefDB > FVersion.RefDB) or
      UserRequest
  then ShowSplash;

  LastGetVersion := Now;
  if UserRequest then UserRequest := false;    }
  FUREvent.ResetEvent;
end;

procedure TUpdateThread.ShowSplash;
begin
//  SendMessage(FMainHandle, WM_SHOW_SPLASH, 0, 0); //Будет ожидать действий пользователя
end;

procedure TUpdateThread.Execute;
var Handles: array [0..1] of THandle;
begin
  Handles[0] := FUREvent.Handle;
  Handles[1] := FTermEvent.Handle;
  while not Terminated do
  begin
    GetVersion;
    WaitForMultipleObjectsEx(2, @Handles[0], false, GetVersionInterval, False);
  end;
end;

{ TServiceResponse }
procedure TServiceResponse.Assign(Source: TPersistent);
var i : integer;
begin
  {if Source is TServiceResponse then
  begin
    fUpdeteStatys := (Source as TServiceResponse).fUpdeteStatys;
    fUpVersion := (Source as TServiceResponse).fUpVersion;
    fCount := (Source as TServiceResponse).fCount;
    SetLength(fNewVersions, fCount);
    for i := 0 to fCount - 1 do
      fNewVersions[i] := (Source as TServiceResponse).fNewVersions[i];
    Exit;
  end;               }

  inherited Assign(Source);
end;
{
procedure TServiceResponse.Clear;
begin
  fUpdeteStatys := 0;
  fUpVersion.RefDB := 0;
  fCount := 0;
  SetLength(fNewVersions, fCount);
end;

constructor TServiceResponse.Create;
begin
  inherited Create;
  Clear;
end;

destructor TServiceResponse.Destroy;
begin
  fCount := 0;
  SetLength(fNewVersions, fCount);
  inherited;
end;

procedure TServiceResponse.Delete(AIndex: Integer);
var i : integer;
begin
  if (AIndex < 0) or (AIndex >= fCount) then
    raise Exception.Create(format('List index out of bounds (%d)',[AIndex]));
  for i := AIndex + 1 to FCount - 1 do
    fNewVersions[i - 1] := fNewVersions[i];
  dec(fCount);
  SetLength(fNewVersions, fCount);
end;

function TServiceResponse.GetNewVersions(AIndex: Integer): TNewVersion;
begin
  if (AIndex < 0) or (AIndex >= fCount) then
    raise Exception.Create(format('List index out of bounds (%d)',[AIndex]));
  Result := fNewVersions[AIndex];
end;

procedure TServiceResponse.SetNewVersions(AIndex: Integer;
  ANewVersion: TNewVersion);
begin
  if (AIndex < 0) or (AIndex >= fCount) then
    raise Exception.Create(format('List index out of bounds (%d)',[AIndex]));
  fNewVersions[AIndex] := ANewVersion;
end;

procedure TServiceResponse.Add(ANewVersion: TNewVersion);
begin
  inc(fCount);
  SetLength(fNewVersions, fCount);
  fNewVersions[fCount - 1] := ANewVersion;
  SortNewVersions;
end;

//Работать будет если версии все валидные
procedure TServiceResponse.SortNewVersions;
var i, j: integer;
    Temp: TNewVersion;
begin
  for i := 0 to fCount - 2 do
    for j := i + 1 to fCount - 1 do
      if (fNewVersions[i].DB > fNewVersions[j].DB) then
      begin
        Temp := fNewVersions[i];
        fNewVersions[i] := fNewVersions[j];
        fNewVersions[j] := Temp;
      end;
end; }

end.
