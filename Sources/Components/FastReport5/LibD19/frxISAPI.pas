
{******************************************}
{                                          }
{             FastReport v5.0              }
{             ISAPI extension              }
{         Copyright (c) 2006-2014          }
{         by Alexander Fediachov,          }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxISAPI;

interface

uses Windows, Isapi2, SysUtils, Classes,
  frxServer, frxDBSet, frxGZip, frxNetUtils,
  frxDCtrl, frxDMPExport, frxGradient, frxChBox, frxCross, frxRich,
  frxChart, frxBarcode, frxServerUtils, ActiveX, Registry, frxUtils,
{$IFDEF FR_SERVER}
  frxServerDB, 
{$ENDIF}
  frxServerConfig, frxFileUtils, frxServerStat, SyncObjs, ComObj;

function GetExtensionVersion(var Ver: THSE_VERSION_INFO): BOOL stdcall;
function HttpExtensionProc(var ECB: TEXTENSION_CONTROL_BLOCK): DWORD stdcall;
function TerminateExtension(dwFlags: DWORD): BOOL stdcall;

type
  TfrxISAPIThread = class(TThread)
  private
   FECB: PEXTENSION_CONTROL_BLOCK;
  protected
    procedure Execute; override;
  public
    constructor Create(AECB: PEXTENSION_CONTROL_BLOCK);
    property ECB: PEXTENSION_CONTROL_BLOCK read FECB;
  end;

var
  g_dwThreadCount: Integer = 0;
  ISAPIThread: TfrxISAPIThread;
  r: TRegistry;
  FServer: TfrxReportServer;
  ServerRoot: String;
  InstallPath: String;

{$IFDEF FR_DEBUG}
procedure OutMess(const s: String);
{$ENDIF}

implementation

{$IFDEF FR_DEBUG}
const
  LogFile = 'c:\fastreport.log';
procedure OutMess(const s: String);
var
  f:  TFileStream;
begin
  if FileExists(LogFile) then
    f := TFileStream.Create(LogFile, fmOpenWrite + fmShareDenyWrite)
  else
    f := TFileStream.Create(LogFile, fmCreate);
  f.Seek(0, soFromEnd);
  f.Write(s[1], Length(s));
  f.Write(#13#10, 2);
  f.Free;
end;
{$ENDIF}

function GetExtensionVersion(var Ver: THSE_VERSION_INFO): BOOL stdcall;
begin
  Integer(Result) := 1;
  Ver.dwExtensionVersion := MakeLong(HSE_VERSION_MINOR, HSE_VERSION_MAJOR);
  StrLCopy(Ver.lpszExtensionDesc, PChar('FastReport'), HSE_MAX_EXT_DLL_NAME_LEN);
end;

function HttpExtensionProc(var ECB: TEXTENSION_CONTROL_BLOCK): DWORD stdcall;
begin
  ISAPIThread := TfrxISAPIThread.Create(@ECB);
	InterlockedIncrement(g_dwThreadCount);
  Result := HSE_STATUS_PENDING;
end;

function TerminateExtension(dwFlags: DWORD): BOOL stdcall;
begin
  while (g_dwThreadCount > 0) do
    SleepEx(100, FALSE);
  SleepEx(1000, FALSE);
  Integer(Result) := 1;
end;

{ TfrxISAPIThread }

constructor TfrxISAPIThread.Create(AECB: PEXTENSION_CONTROL_BLOCK);
begin
  inherited Create(True);
  FECB := AECB;
  FreeOnTerminate := True;
  Resume;
end;

function GetFieldByName(ECB: TEXTENSION_CONTROL_BLOCK; const Name: string): string;
var
  Buffer: array[0..4095] of Char;
  Size: DWORD;
begin
  Size := SizeOf(Buffer);
  if ECB.GetServerVariable(ECB.ConnID, PChar(Name), @Buffer, Size) or
     ECB.GetServerVariable(ECB.ConnID, PChar('HTTP_' + Name), @Buffer, Size) then
  begin
    if Size > 0 then Dec(Size);
    SetString(Result, Buffer, Size);
  end else Result := '';
end;

procedure TfrxISAPIThread.Execute;
var
  FScriptName, ResultHeaders: string;
  Size: DWORD;
  Data: TfrxServerData;
  s, s1: String;
  i: Integer;
  Status: DWORD;

begin
  PMessages;
  CoInitializeEx(nil, COINIT_MULTITHREADED);
  try
    try
      Data := TfrxServerData.Create;
      try
        s := String(ECB.lpszQueryString);
        s1 := String(ECB.lpszPathInfo);
        if s1 = '' then
          s1 := '/'
        else if s1 = '/result' then
          s1 := s1 + '?';
        Data.Header :=  String(ECB.lpszMethod) + ' ' + s1 + s + ' HTTP/1.1' + #13#10;
        Data.Header := Data.Header + GetFieldByName(ECB^, 'ALL_RAW') + #13#10;
        PMessages;
        // working
        FServer.Get(Data);
        PMessages;
        Size := Data.Stream.Size;
        ResultHeaders := Data.RepHeader;
        i := Pos(#13#10, ResultHeaders);
        s := '';
        if i > 0 then
        begin
          s := Copy(ResultHeaders, 1, i - 1);
          Delete(ResultHeaders, 1, i + 1);
        end;
        FScriptName := GetFieldByName(ECB^, 'SCRIPT_NAME');
        ResultHeaders := StringReplace(ResultHeaders, 'Location: ', 'Location: ' + FScriptName, []);
        if Data.OutParams.Values['Location'] <> '' then
        begin
          s1 := FScriptName + Data.OutParams.Values['Location'];
          ECB.ServerSupportFunction(ECB.ConnID, HSE_REQ_SEND_URL_REDIRECT_RESP, PChar(s1), nil, nil);
        end else
        begin
          ECB.dwHttpStatusCode := Data.ErrorCode;
          ECB.ServerSupportFunction(ECB.ConnID, HSE_REQ_SEND_RESPONSE_HEADER, PChar(s), @Size, LPDWORD(ResultHeaders));
          PMessages;
          ECB.WriteClient(ECB.ConnID, Data.Stream.Memory, Size, 0);
        end;
        Status := HSE_STATUS_SUCCESS_AND_KEEP_CONN;
      finally
        Data.Free;
      end;
    except
      Status := HSE_STATUS_ERROR;
    end;
    PMessages;
    ECB.ServerSupportFunction(ECB.ConnID, HSE_REQ_DONE_WITH_SESSION, @Status, nil, nil);
  finally
    PMessages;
    CoUninitialize;
  end;
	InterlockedDecrement(g_dwThreadCount);
end;

initialization
  r := TRegistry.Create;
  try
    r.RootKey := HKEY_LOCAL_MACHINE;
    r.OpenKey('\SOFTWARE\Fast Reports\Server', false);
    InstallPath := r.ReadString('InstallPath') + '\';
    ServerRoot :=  InstallPath + 'bin\';
  finally
    r.Free;
  end;
  FServer := TfrxReportServer.CreateWithRoot(ServerRoot, False);
  FServer.Open;

finalization
  FServer.Free;

end.
