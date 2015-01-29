unit UpdateModule;

interface

uses
  System.Classes, System.SysUtils, DateUtils, Vcl.Forms, SyncObjs,
  Winapi.Windows, Winapi.Messages, IdHTTP, XMLIntf, XMLDoc,  ActiveX;

const
  //Интервал времени через который происходит опрос сервака
  GetVersionInterval = 20000;

  WM_SHOW_SPLASH = WM_USER + 1;

type
  TLogFile = class(TObject)
  private
    { Private declarations }
    FFile: TextFile;
    FActive: boolean;
    FFileName: string;
    FFullName: string;
    FKeepOpened: boolean;
    FFileDir: string;

    procedure SetFileName(const Value: string);
    procedure SetKeepOpened(const Value: boolean);
    procedure SetFileDir(const Value: string);
    function GetLogFileName: String;
  protected
    { Protected declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure Add(AText: string; ATag: string = '');
    property Active: boolean read FActive write FActive;
    property FileName: string read FFileName write SetFileName;
    property KeepOpened: boolean read FKeepOpened write SetKeepOpened;
    property FileDir: string read FFileDir write SetFileDir;
  end;

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
    procedure Clear;
    constructor Create;
    destructor Destroy; override;

   { property UpdeteStatys: byte read fUpdeteStatys write fUpdeteStatys;
    property UpVersion: TVersion read fUpVersion write fUpVersion;
    property Count: integer read fCount write fCount;
    property NewVersions[Index: Integer]: TNewVersion read GetNewVersions write SetNewVersions;}
  end;

type
  TUpdateThread = class(TThread)
  private
    FCurVersion : TVersion; //Текушая версия программы
    FMainHandle: HWND;
    FLogFile: TLogFile;

    FUREvent, FTermEvent: TEvent;
    FVersionCS: TCriticalSection;
    FServiceResponse: TServiceResponse; //Ответ службы

    function GetServiceResponse: TServiceResponse;
    procedure GetVersion; //Отправляет запрос на получение версии на серверее
    procedure ParsXMLResult(const AStrimPage: TMemoryStream;
      var ASResponse: TServiceResponse);

    procedure GetLogName;
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

{ TLogFile }

function TLogFile.GetLogFileName: String;
begin
  Result:= FileDir + FileName;
end;

procedure TLogFile.Add(AText: string; ATag: string);
var
  fname, lMessage: string;
begin
  if not Active then exit;

  fname:= GetLogFileName;

  if not KeepOpened then
  begin
    AssignFile(FFile, fname);
    if FileExists(fname) then
      Append(FFile)
    else
      Rewrite(FFile);
  end
  else
    if fname <> FFullName then
    begin
      CloseFile(FFile);
      FFullName:= fname;
      AssignFile(FFile, fname);
      if FileExists(fname) then
        Append(FFile)
      else
        Rewrite(FFile);
    end;

  lMessage := '[' + DateToStr(Date);
  if ATag <> '' then lMessage:= lMessage + ' : '+ ATag;
  lMessage := lMessage + ']';
  lMessage:= lMessage + ' ' + AText;

  writeln(FFile, lMessage);

  if not KeepOpened then CloseFile(FFile);
end;

procedure TLogFile.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure TLogFile.SetKeepOpened(const Value: boolean);
begin
  FKeepOpened := Value;
end;

destructor TLogFile.Destroy;
begin
  if KeepOpened then CloseFile(FFile);
  inherited;
end;

procedure TLogFile.SetFileDir(const Value: string);
begin
  FFileDir:= Value;
  if FFileDir <> '' then
  begin
    ForceDirectories(FFileDir);
    FFileDir := IncludeTrailingPathDelimiter(FFileDir);
  end;
end;

{ UpdateThread }

procedure TUpdateThread.GetLogName;
begin
  FLogFile.FileDir := ExtractFilePath(Application.ExeName) + 'logs';
  FLogFile.FileName := 'update.log';
end;

constructor TUpdateThread.Create(AVersion: TVersion;
  AMainHandle: HWND);
begin
  inherited Create(true);

  //Текущая версия приложения;
  FCurVersion := AVersion;
  FMainHandle := AMainHandle;

  FLogFile := TLogFile.Create;
  FLogFile.Active := true;

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

procedure TUpdateThread.ParsXMLResult(const AStrimPage: TMemoryStream;
      var ASResponse: TServiceResponse);
var XML : IXMLDocument;
    CatNode, AppNode, UsNode : IXMLNode;

begin
  ASResponse.Clear;
  XML := TXMLDocument.Create(nil);
  try
    try
      //XML.LoadFromStream(AStrimPage);
      XML.LoadFromXML('d:\get_xml.xml');

    except
      on e: Exception do
      begin
        FLogFile.Add(e.ClassName + ': ' + e.Message, 'pars XML mode');
      end;
    end;
  finally
    XML := nil;
  end;
end;

procedure TUpdateThread.GetVersion;
var NewVersion : TVersion;
    HTTP: TIdHTTP;
    StrimPage: TMemoryStream;
    SResponse: TServiceResponse;
begin
  //Снимаем сигнальное состояние порверки по требованию если оно установлено
  if FUREvent.WaitFor(0) = wrSignaled then
    FUREvent.ResetEvent;

  HTTP := TIdHTTP.Create(nil);
  StrimPage := TMemoryStream.Create;
  SResponse := TServiceResponse.Create;
  try
    try
      HTTP.HandleRedirects := true;
      HTTP.Request.UserAgent:='Mozilla/5.0 (Windows NT 6.1) '+
        'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36';
      HTTP.Request.Accept:='text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
      HTTP.Request.AcceptLanguage:='ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4,ar;q=0.2';
      HTTP.Request.AcceptCharSet:='windows-1251,utf-8;q=0.7,*;q=0.7';

     { HTTP.Get('http://nocode.by:12115/gen/get_xml.xml?' +
        'user_version=' + IntToStr(FCurVersion.UserDB) + '&' +
        'app_version' + IntToStr(FCurVersion.App) + '&' +
        'catalog_version=' + IntToStr(FCurVersion.RefDB), StrimPage);}

      ParsXMLResult(StrimPage, SResponse);
    except
      on e: Exception do
      begin
        FLogFile.Add(e.ClassName + ': ' + e.Message, 'get version mode');
      end;
    end;
  finally
    SResponse.Free;
    HTTP.Free;
    StrimPage.Free;
  end;
end;

procedure TUpdateThread.ShowSplash;
begin
//  SendMessage(FMainHandle, WM_SHOW_SPLASH, 0, 0); //Будет ожидать действий пользователя
end;

procedure TUpdateThread.Execute;
var Handles: array [0..1] of THandle;
begin
  Synchronize(GetLogName);
  FLogFile.Active := true;
  try
    CoInitializeEx(nil, COINIT_APARTMENTTHREADED or COINIT_DISABLE_OLE1DDE);
    try
      Handles[0] := FUREvent.Handle;
      Handles[1] := FTermEvent.Handle;
      while not Terminated do
      begin
        GetVersion;
        WaitForMultipleObjectsEx(2, @Handles[0], false, GetVersionInterval, False);
      end;
    finally
        CoUninitialize;
    end;
  except
    on e: Exception do
    begin
      FLogFile.Add(e.ClassName + ': ' + e.Message, 'execute mode');
    end;
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

procedure TServiceResponse.Clear;
begin
 { fUpdeteStatys := 0;
  fUpVersion.RefDB := 0;
  fCount := 0;
  SetLength(fNewVersions, fCount); }
end;

constructor TServiceResponse.Create;
begin
  inherited Create;
  Clear;
end;

destructor TServiceResponse.Destroy;
begin
 { fCount := 0;
  SetLength(fNewVersions, fCount);      }
  inherited;
end;

{
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
