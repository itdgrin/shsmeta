unit UpdateModule;

interface

uses
  System.Classes, System.SysUtils, DateUtils, Vcl.Forms, SyncObjs,
  Winapi.Windows, IdHTTP, XMLIntf, XMLDoc,  ActiveX, GlobsAndConst;

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
    Catalog: integer;
    User: integer;
    procedure Clear;
    procedure Assign(const AVersion: TVersion);
  end;

  TNewVersion = record
    Version: integer;
    Url: string;
    Comment: string;
  end;
  TNewVersionList = array of TNewVersion;

  TServiceResponse = class(TPersistent)
  private
    //0 - нет обновлений
    //1 - есть обновления
    FUpdeteStatys: byte;

    FAppCount,
    FCatalogCount,
    FUserCount: integer;

    FAppList,
    FCatalogList,
    FUserList: TNewVersionList;

    FUserRequest: boolean;

    function GetAppList(AIndex: Integer): TNewVersion;
    function GetCatalogList(AIndex: Integer): TNewVersion;
    function GetUserList(AIndex: Integer): TNewVersion;

    procedure SetAppList(AIndex: Integer; const AValue: TNewVersion);
    procedure SetCatalogList(AIndex: Integer; const AValue: TNewVersion);
    procedure SetUserList(AIndex: Integer; const AValue: TNewVersion);

    function GetAppVersion: integer;
    function GetCatalogVersion: integer;
    function GetUserVersion: integer;
  public
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create;
    destructor Destroy; override;

    property UserRequest: boolean read FUserRequest write FUserRequest;
    property UpdeteStatys: byte read FUpdeteStatys write FUpdeteStatys;

    property AppVersion: integer read GetAppVersion;
    property CatalogVersion: integer read GetCatalogVersion;
    property UserVersion: integer read GetUserVersion;

    property AppCount: integer read FAppCount;
    property CatalogCount: integer read FCatalogCount;
    property UserCount: integer read FUserCount;

    property AppList[Index: Integer]: TNewVersion read GetAppList write SetAppList;
    property CatalogList[Index: Integer]: TNewVersion read GetCatalogList write SetCatalogList;
    property UserList[Index: Integer]: TNewVersion read GetUserList write SetUserList;

    function AddApp(const ANewVersion: TNewVersion): integer;
    function AddCatalog(const ANewVersion: TNewVersion): integer;
    function AddUser(const ANewVersion: TNewVersion): integer;
  end;

  TUpdateThread = class(TThread)
  private
    FCurVersion : TVersion; //Текушая версия программы
    FCurVersionCS: TCriticalSection;

    FMainHandle: HWND;
    FLogFile: TLogFile;

    FUREvent, FTermEvent: TEvent;

    FResponse: TServiceResponse; //Ответ службы

    FUserBlok: boolean; //Блокировка пользователем (не надо меня беспокоить)
    FUserBlokCS: TCriticalSection;

    //Запрос версии инициирован пользователем
    FUserRequest: boolean;

    procedure GetVersion; //Отправляет запрос на получение версии на серверее
    procedure ParsXMLResult(const AStrimPage: TMemoryStream;
      var ASResponse: TServiceResponse);

    procedure GetLogName;
    { Private declarations }
  protected
    procedure Execute; override;
  public
    procedure UserRequest;
    procedure Terminate;
    constructor Create(AVersion: TVersion; AMainHandle: HWND); overload;
    destructor Destroy; override;
    procedure UserBlok;
    procedure SetCurVersion(AVersion: TVersion);
  end;

implementation

{ TVersion }
procedure TVersion.Clear;
begin
  App := 0;
  Catalog := 0;
  User := 0;
end;

procedure TVersion.Assign(const AVersion: TVersion);
begin
  App := AVersion.App;
  Catalog := AVersion.Catalog;
  User := AVersion.User;
end;

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
  //В принципе обращаться к Application в потоке некрасиво
  FLogFile.FileDir := ExtractFilePath(Application.ExeName) + C_LOGDIR;
  FLogFile.FileName := C_UPDATELOG;
end;

constructor TUpdateThread.Create(AVersion: TVersion;
  AMainHandle: HWND);
begin
  inherited Create(true);

  //Текущая версия приложения;
  FCurVersion := AVersion;
  FCurVersionCS := TCriticalSection.Create;

  FMainHandle := AMainHandle;

  FLogFile := TLogFile.Create;
  FLogFile.Active := true;

  FUREvent := TEvent.Create(nil, true, false, '');
  FTermEvent := TEvent.Create(nil, true, false, '');

  FResponse := TServiceResponse.Create;

  FUserBlok := False;
  FUserBlokCS := TCriticalSection.Create;

  Priority :=  tpLower;
  Resume;
end;

destructor TUpdateThread.Destroy;
begin
  FreeAndNil(FResponse);
  FreeAndNil(FCurVersionCS);
  FreeAndNil(FUserBlokCS);
  FreeAndNil(FUREvent);
  FreeAndNil(FTermEvent);
  FreeAndNil(FLogFile);
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

procedure TUpdateThread.SetCurVersion(AVersion: TVersion);
begin
  FCurVersionCS.Enter;
  try
    FCurVersion.App := AVersion.App;
    FCurVersion.Catalog := AVersion.Catalog;
    FCurVersion.User := AVersion.User;
  finally
    FCurVersionCS.Leave;
  end;
end;

procedure TUpdateThread.UserBlok;
begin
  FUserBlokCS.Enter;
  try
    FUserBlok := True;
  finally
    FUserBlokCS.Leave;
  end;
end;

procedure TUpdateThread.ParsXMLResult(const AStrimPage: TMemoryStream;
      var ASResponse: TServiceResponse);
var XML : IXMLDocument;
    TempNode, TempNode1, CatNode, UsNode, AppNode: IXMLNode;
    i: Integer;
    TempNV: TNewVersion;
    Resp: TServiceResponse;
begin
  XML := TXMLDocument.Create(nil);
  Resp := TServiceResponse.Create;
  try
    try
      XML.LoadFromStream(AStrimPage);

      TempNode := XML.ChildNodes.FindNode('updates');
      if TempNode = nil then
        raise Exception.Create('Не найдена нода <updates>');
      CatNode := TempNode.ChildNodes.FindNode('catalog_updates');
      if CatNode = nil then
        raise Exception.Create('Не найдена нода <catalog_updates>');
      UsNode := TempNode.ChildNodes.FindNode('user_updates');
      if UsNode = nil then
        raise Exception.Create('Не найдена нода <user_updates>');
      AppNode := TempNode.ChildNodes.FindNode('app_updates');
      if AppNode = nil then
        raise Exception.Create('Не найдена нода <app_updates>');

      TempNode := nil;
      TempNode := AppNode.ChildNodes.FindNode('available');
      if TempNode = nil then
        raise Exception.Create('Не найдена нода <app_updates><available>');
      if TempNode.Text = 'yes' then
      begin
        Resp.UpdeteStatys := 1;
        TempNV.Version := StrToInt(AppNode.ChildNodes.FindNode('version').Text);
        TempNV.Url := AppNode.ChildNodes.FindNode('url').Text;
        Resp.AddApp(TempNV);
        TempNode1 := nil;
      end;

      TempNode := nil;
      TempNode := CatNode.ChildNodes.FindNode('available');
      if TempNode = nil then
        raise Exception.Create('Не найдена нода <catalog_updates><available>');
      if TempNode.Text = 'yes' then
      begin
        Resp.UpdeteStatys := 1;
        for i := 0 to CatNode.ChildNodes.Count - 1 do
        begin
          if CatNode.ChildNodes[i].NodeName = 'update' then
          begin
            TempNode1 := CatNode.ChildNodes.Get(i);
            TempNV.Version := StrToInt(TempNode1.ChildNodes.FindNode('version').Text);
            TempNV.Url := TempNode1.ChildNodes.FindNode('url').Text;
            TempNV.Comment := TempNode1.ChildNodes.FindNode('comment').Text;
            Resp.AddCatalog(TempNV);
            TempNode1 := nil;
          end;
        end;
      end;

      TempNode := nil;
      TempNode := UsNode.ChildNodes.FindNode('available');
      if TempNode = nil then
        raise Exception.Create('Не найдена нода <user_updates><available>');
      if TempNode.Text = 'yes' then
      begin
        Resp.UpdeteStatys := 1;
        for i := 0 to UsNode.ChildNodes.Count - 1 do
        begin
          if UsNode.ChildNodes[i].NodeName = 'update' then
          begin
            TempNode1 := UsNode.ChildNodes.Get(i);
            TempNV.Version := StrToInt(TempNode1.ChildNodes.FindNode('version').Text);
            TempNV.Url := TempNode1.ChildNodes.FindNode('url').Text;
            TempNV.Comment := TempNode1.ChildNodes.FindNode('comment').Text;
            Resp.AddUser(TempNV);
            TempNode1 := nil;
          end;
        end;
      end;
      TempNode := nil;

     ASResponse.Assign(Resp);
    except
      on e: Exception do
      begin
        FLogFile.Add(e.ClassName + ': ' + e.Message, 'Update Thread (pars XML mode)');
      end;
    end;
  finally
    Resp.Free;
    XML := nil;
  end;
end;

procedure TUpdateThread.GetVersion;
var HTTP: TIdHTTP;
    StrimPage: TMemoryStream;
begin
  FResponse.Clear;

  FUserRequest := false;
  //Снимаем сигнальное состояние порверки по требованию если оно установлено
  if FUREvent.WaitFor(0) = wrSignaled then
  begin
    FUserBlok := False;
    FUREvent.ResetEvent;
    FUserRequest := true;
  end;

  //Если пользователь запретил, запроса не происходит
  if FUserBlok then exit;

  HTTP := TIdHTTP.Create(nil);
  StrimPage := TMemoryStream.Create;
  try
    try
      HTTP.HandleRedirects := true;
      HTTP.Request.UserAgent:='Mozilla/5.0 (Windows NT 6.1) '+
        'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36';
      HTTP.Request.Accept:='text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
      HTTP.Request.AcceptLanguage:='ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4,ar;q=0.2';
      HTTP.Request.AcceptCharSet:='windows-1251,utf-8;q=0.7,*;q=0.7';

      HTTP.Get(C_UPDATESERV + '/gen/get_xml.xml?' +
        'user_version=' + IntToStr(FCurVersion.User) + '&' +
        'app_version=' + IntToStr(FCurVersion.App) + '&' +
        'catalog_version=' + IntToStr(FCurVersion.Catalog), StrimPage);

      ParsXMLResult(StrimPage, FResponse);

    except
      on e: Exception do
      begin
        FLogFile.Add(e.ClassName + ': ' + e.Message, 'Update Thread (get version mode)');
      end;
    end;
  finally
    HTTP.Free;
    StrimPage.Free;
  end;

  FCurVersionCS.Enter;
  try
    FResponse.UserRequest := FUserRequest;
    //Если FUserRequest = True по сообщение будет отправлено в любом случае
    if (FCurVersion.App < FResponse.AppVersion) or
       (FCurVersion.Catalog < FResponse.CatalogVersion) or
       (FCurVersion.User < FResponse.UserVersion) or
       FUserRequest then
       SendMessage(FMainHandle, WM_SHOW_SPLASH, 0, LParam(FResponse));
  finally
    FCurVersionCS.Leave;
  end;
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
        WaitForMultipleObjectsEx(2, @Handles[0], false, C_GETVERSINTERVAL, False);
      end;
    finally
        CoUninitialize;
    end;
  except
    on e: Exception do
    begin
      FLogFile.Add(e.ClassName + ': ' + e.Message, 'Update Thread (execute mode)');
    end;
  end;
end;

{ TServiceResponse }
procedure TServiceResponse.Assign(Source: TPersistent);
var i : integer;
begin
  if Source is TServiceResponse then
  begin
    FUserRequest := (Source as TServiceResponse).FUserRequest;
    FUpdeteStatys := (Source as TServiceResponse).FUpdeteStatys;

    FAppCount := (Source as TServiceResponse).FAppCount;
    SetLength(FAppList, FAppCount);
    for i := 0 to FAppCount - 1 do
    begin
      FAppList[i].Version := (Source as TServiceResponse).FAppList[i].Version;
      FAppList[i].Url := (Source as TServiceResponse).FAppList[i].Url;
      FAppList[i].Comment := (Source as TServiceResponse).FAppList[i].Comment;
    end;

    FCatalogCount := (Source as TServiceResponse).FCatalogCount;
    SetLength(FCatalogList, FCatalogCount);
    for i := 0 to FCatalogCount - 1 do
    begin
      FCatalogList[i].Version := (Source as TServiceResponse).FCatalogList[i].Version;
      FCatalogList[i].Url := (Source as TServiceResponse).FCatalogList[i].Url;
      FCatalogList[i].Comment := (Source as TServiceResponse).FCatalogList[i].Comment;
    end;

    FUserCount := (Source as TServiceResponse).FUserCount;
    SetLength(FUserList, FUserCount);
    for i := 0 to FUserCount - 1 do
    begin
      FUserList[i].Version := (Source as TServiceResponse).FUserList[i].Version;
      FUserList[i].Url := (Source as TServiceResponse).FUserList[i].Url;
      FUserList[i].Comment := (Source as TServiceResponse).FUserList[i].Comment;
    end;
    Exit;
  end;

  inherited Assign(Source);
end;

procedure TServiceResponse.Clear;
begin
  FAppCount := 0;
  FCatalogCount := 0;
  FUserCount := 0;

  SetLength(FAppList, FAppCount);
  SetLength(FCatalogList, FCatalogCount);
  SetLength(FUserList, FUserCount);
end;

constructor TServiceResponse.Create;
begin
  inherited Create;
  Clear;
end;

destructor TServiceResponse.Destroy;
begin
  clear;
  inherited;
end;

function TServiceResponse.GetAppList(AIndex: Integer): TNewVersion;
begin
  if (AIndex < 0) or (AIndex >= FAppCount) then
    raise Exception.Create(format('List index out of bounds (%d)',[AIndex]));
  Result := FAppList[AIndex];
end;

function TServiceResponse.GetCatalogList(AIndex: Integer): TNewVersion;
begin
  if (AIndex < 0) or (AIndex >= FCatalogCount) then
    raise Exception.Create(format('List index out of bounds (%d)',[AIndex]));
  Result := FCatalogList[AIndex];
end;

function TServiceResponse.GetUserList(AIndex: Integer): TNewVersion;
begin
  if (AIndex < 0) or (AIndex >= FUserCount) then
    raise Exception.Create(format('List index out of bounds (%d)',[AIndex]));
  Result := FUserList[AIndex];
end;

function TServiceResponse.AddApp(const ANewVersion: TNewVersion): integer;
begin
  inc(FAppCount);
  SetLength(FAppList, FAppCount);
  Result := FAppCount - 1;
  FAppList[Result].Version := ANewVersion.Version;
  FAppList[Result].Url := ANewVersion.Url;
  FAppList[Result].Comment := ANewVersion.Comment;
end;

function TServiceResponse.AddCatalog(const ANewVersion: TNewVersion): integer;
begin
  inc(FCatalogCount);
  SetLength(FCatalogList, FCatalogCount);
  Result := FCatalogCount - 1;
  FCatalogList[Result].Version := ANewVersion.Version;
  FCatalogList[Result].Url := ANewVersion.Url;
  FCatalogList[Result].Comment := ANewVersion.Comment;
end;

function TServiceResponse.AddUser(const ANewVersion: TNewVersion): integer;
begin
  inc(FUserCount);
  SetLength(FUserList, FUserCount);
  Result := FUserCount - 1;
  FUserList[Result].Version := ANewVersion.Version;
  FUserList[Result].Url := ANewVersion.Url;
  FUserList[Result].Comment := ANewVersion.Comment;
end;

function TServiceResponse.GetAppVersion: integer;
var i: integer;
begin
  Result := 0;
  for i := 0 to FAppCount - 1 do
      if Result < FAppList[i].Version then
        Result := FAppList[i].Version;
end;

function TServiceResponse.GetCatalogVersion: integer;
var i: integer;
begin
  Result := 0;
  for i := 0 to FCatalogCount - 1 do
      if Result < FCatalogList[i].Version then
        Result := FCatalogList[i].Version;
end;

function TServiceResponse.GetUserVersion: integer;
var i: integer;
begin
  Result := 0;
  for i := 0 to FUserCount - 1 do
      if Result < FUserList[i].Version then
        Result := FUserList[i].Version;
end;

procedure TServiceResponse.SetAppList(AIndex: Integer; const AValue: TNewVersion);
begin
  if (AIndex < 0) or (AIndex >= FAppCount) then
    raise Exception.Create(format('List index out of bounds (%d)',[AIndex]));
  FAppList[AIndex].Version := AValue.Version;
  FAppList[AIndex].Url := AValue.Url;
end;

procedure TServiceResponse.SetCatalogList(AIndex: Integer; const AValue: TNewVersion);
begin
  if (AIndex < 0) or (AIndex >= FCatalogCount) then
    raise Exception.Create(format('List index out of bounds (%d)',[AIndex]));
  FCatalogList[AIndex].Version := AValue.Version;
  FCatalogList[AIndex].Url := AValue.Url;
end;

procedure TServiceResponse.SetUserList(AIndex: Integer; const AValue: TNewVersion);
begin
  if (AIndex < 0) or (AIndex >= FUserCount) then
    raise Exception.Create(format('List index out of bounds (%d)',[AIndex]));
  FUserList[AIndex].Version := AValue.Version;
  FUserList[AIndex].Url := AValue.Url;
end;

end.
