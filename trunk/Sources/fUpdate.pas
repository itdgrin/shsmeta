unit fUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  System.IOUtils, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, UpdateModule, Vcl.ComCtrls, IdAntiFreezeBase, Vcl.IdAntiFreeze,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, ZipForge,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Comp.Script, FireDAC.UI.Intf, FireDAC.Stan.Async,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.SysUtils,
  IniFiles, IdMessage, IdSSLOpenSSL, IdMessageClient, IdSMTPBase, IdSMTP,
  IdAttachmentFile, IdExplicitTLSClientServerBase, Tools;

type
  TUpdateForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Image1: TImage;
    btnUpdate: TButton;
    btnCancel: TButton;
    btnOk: TButton;
    Panel4: TPanel;
    Label2: TLabel;
    Panel3: TPanel;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    HTTP: TIdHTTP;
    IdAntiFreeze1: TIdAntiFreeze;
    ZipForge: TZipForge;
    SQLScript: TFDScript;
    qrTemp: TFDQuery;
    btnIterrupt: TButton;
    procedure btnUpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure SQLScriptError(ASender: TObject; const AInitiator: IFDStanObject;
      var AException: Exception);
    procedure SQLScriptBeforeExecute(Sender: TObject);
    procedure SQLScriptAfterExecute(Sender: TObject);
    procedure SQLScriptProgress(Sender: TObject);
    procedure btnIterruptClick(Sender: TObject);
  private
    FCurVersion: TVersion; //������� ������ ����������
    FSR: TServiceResponse;
    SqlErrorList: TStringList;

    FClientName: string; // ��� ������
    FSendReport: boolean; // ������������� ���������� ����� �� ������� ����������

    FStopUpdateProc,
    FErrorUpdateProc: Boolean;

    FLogFile: TLogFile;

    procedure ShowUpdateStatys;
    procedure StartUpdate;
    procedure LoadAndSetUpdate(AUpdate: TNewVersion; AType: byte);
    function ExecSqlScript(ADirName: string; AUpdate: TNewVersion; AType: byte): Boolean;
    procedure SendErrorReport;
    function UpdateApp(const AUpdatePath: string): Boolean;
    procedure ShowStatys(const AStatysStr: string; AType: byte = 0);
    procedure SetButtonStyle(AStyle: Integer);
    function CheckUpdateProc: Boolean;
    { Private declarations }
  public
    //������������� ������ �� �� �������� ������� ���
    procedure SetVersion(const AVersion: TVersion;
      const AServiceResponse: TServiceResponse);
    { Public declarations }
  end;

var
  //���������� ���������� �������������� ���������� ����������
  //���� ������������� ��������� Updater �� ���������� ���������
  StartUpdater: Boolean = False;
  //���� � ����� � ������������ ����������
  UpdatePath,
  NewAppVersion: string;

implementation
uses DataModule;

{$R *.dfm}

procedure TUpdateForm.SendErrorReport;
var i : integer;
    Msg : TIdMessage;
    SMTP : TIdSMTP;
    SSLIOHandler : TIdSSLIOHandlerSocketOpenSSL;
begin
  Msg := TIdMessage.Create;
  SMTP := TIdSMTP.Create;
  SSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
  try
    try
      if FClientName = '' then
        raise Exception.Create('����� �� ���������. �� ������� ��� �������.');

      SSLIOHandler.SSLOptions.Method := sslvSSLv3;
      SMTP.IOHandler := SSLIOHandler;
      SMTP.HeloName := 'Smeta';

      SMTP.Host := 'smtp.gmail.com';
      SMTP.Port := 465;

      SMTP.AuthType := satDefault;
      SMTP.Username := 'smetareport';
      SMTP.Password := 'smeta1234';

      SMTP.UseTLS := utUseImplicitTLS;

      SMTP.Connect;

      Msg.From.Address := 'smetareport@gmail.com';
      Msg.From.Name := FClientName;
      Msg.Recipients.EMailAddresses := SupportMail;
      Msg.Subject := '����� �� ������� ����������';
      for i := 0 to SqlErrorList.Count - 1 do
        Msg.Body.Add(SqlErrorList[i] + '<br>');

     //��� ��������
      Msg.IsEncoded:=false;
      Msg.ContentType := 'text/html; charset=UTF-8;';

      SMTP.Send(Msg);
      SMTP.Disconnect;
    except
      on e : Exception do
        ShowStatys(e.Message);
    end;
  finally
    Msg.Free;
    SMTP.Free;
    SSLIOHandler.Free;
  end;
end;

procedure TUpdateForm.ShowStatys(const AStatysStr: string; AType: byte = 0);
begin
  if AType = 0 then
    Memo1.Lines.Add(AStatysStr)
  else
    if Memo1.Lines.Count > 0 then
      Memo1.Lines[Memo1.Lines.Count - 1] := AStatysStr;
end;

procedure TUpdateForm.LoadAndSetUpdate(AUpdate: TNewVersion; AType: byte);
var LoadPath, UpdName: string;
    MStream: TMemoryStream;
begin
  LoadPath := ExtractFilePath(Application.ExeName) + 'Updates\';
  UpdName := copy(AUpdate.Url, 1, Pos('?',AUpdate.Url) - 1);
  UpdName := StringReplace(UpdName, '/','\', [rfReplaceAll]);
  UpdName := ExtractFileName(UpdName);

  Case AType of
  0:LoadPath := LoadPath + 'cat' + IntToStr(AUpdate.Version) + '\';
  1:LoadPath := LoadPath + 'user' + IntToStr(AUpdate.Version) + '\';
  2:LoadPath := LoadPath + 'app' + IntToStr(AUpdate.Version) + '\';
  End;
  ForceDirectories(LoadPath);

  ShowStatys('���������� ' + IntToStr(AUpdate.Version) + ': ' + AUpdate.Comment);

  MStream := TMemoryStream.Create;
  try
    try
      HTTP.HandleRedirects := true;
      HTTP.Request.UserAgent:='Mozilla/5.0 (Windows NT 6.1) '+
        'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36';
      HTTP.Request.Accept:='text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
      HTTP.Request.AcceptLanguage:='ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4,ar;q=0.2';
      HTTP.Request.AcceptCharSet:='windows-1251,utf-8;q=0.7,*;q=0.7';

      ShowStatys('��������...');
      HTTP.Get(UpdateServ + AUpdate.Url, MStream);
      MStream.SaveToFile(LoadPath + UpdName);
      ShowStatys('��������� �������', 1);

      if CheckUpdateProc then
        Exit;

      ShowStatys('����������...');
      ZipForge.BaseDir := LoadPath;
      ZipForge.Options.OverwriteMode := omAlways;
      ZipForge.FileName := LoadPath + UpdName;
      ZipForge.OpenArchive;
      ZipForge.ExtractFiles('*.*');
      ZipForge.CloseArchive;

      DeleteFile(LoadPath + UpdName);
      ShowStatys('����������� �������', 1);

      if CheckUpdateProc then
        Exit;

      if AType in [0,1] then
      begin
        ShowStatys('���������...');

        if not ExecSqlScript(LoadPath, AUpdate, AType) then
          raise Exception.Create('�� ������� ��������� ������!');

        ShowStatys('����������� �������', 1);
      end
      else
      begin
       StartUpdater := UpdateApp(LoadPath);
       NewAppVersion := IntToStr(AUpdate.Version);
      end;
    except
      on e: Exception do
      begin
        FLogFile.Add(e.ClassName + ': ' + e.Message,
          'Update Form (Type=' + IntToStr(Atype) +
          '; Vers=' + IntToStr(AUpdate.Version) + ')');
        FErrorUpdateProc := True;
        ShowStatys(e.Message);

        SqlErrorList.Insert(0, e.Message);
        //���� ���������� ���� ������������ ����� �� �������
        if FSendReport then
        begin
          ShowStatys('�������� ������ �� ������� � ������������');
          case AType of
          0: SqlErrorList.Insert(0, '���������� ������������ �' +
            IntToStr(AUpdate.Version));
          1: SqlErrorList.Insert(0, '���������� ���������������� ������ �' +
              IntToStr(AUpdate.Version));
          2: SqlErrorList.Insert(0, '���������� ���������� �' +
              IntToStr(AUpdate.Version));
          end;

          SendErrorReport;
        end;

        ShowStatys('');
        ShowStatys('���������� ����������� �������!');
      end;
    end;
  finally
    MStream.Free;
    //����� ���������� ���������� ����� � SQL ��������� ��������
    if (AType in [0,1]) or
      ((AType = 2) and not StartUpdater) then
      KillDir(LoadPath);
  end;
end;

function TUpdateForm.UpdateApp(const AUpdatePath: string): Boolean;
begin
  UpdatePath := AUpdatePath;
  if TFile.Exists(UpdatePath + UpdaterName) then
  begin
    TFile.Copy(UpdatePath + UpdaterName,
      ExtractFilePath(Application.ExeName) + UpdaterName, True);
    TFile.Delete(UpdatePath + UpdaterName);
  end;
  Result := not TDirectory.IsEmpty(AUpdatePath);
end;

function TUpdateForm.ExecSqlScript(ADirName: string;
  AUpdate: TNewVersion; AType: byte): Boolean;
var TmpSR: TSearchRec;
    found,
    ScriptCount,
    ScriptNo: integer;
    ScriptResult: boolean;
    VersTabName: string;
begin
  ScriptCount := 0;
  ScriptNo := 0;
  Result := True;

  if AType = 0 then
    VersTabName := 'versionref'
  else
    VersTabName := 'versionuser';

  //��������� ����� ���-�� �������� � �����
  found := FindFirst(ADirName + '*.sql', faAnyFile, TmpSR);
  try
    while (found = 0) do
    begin
      inc(ScriptCount);
      found := FindNext(TmpSR);
    end;
  finally
    FindClose(TmpSR);
  end;

  if (ScriptCount > 0) then
  begin
    found := FindFirst(ADirName + '*.sql', faAnyFile, TmpSR);
    try
      while (found = 0) do
      begin
        inc(ScriptNo);

        //�������� ����������� ��� ������ ����� ���� ���������� �������� ���������
        //��������
        ScriptResult := False;
        qrTemp.SQL.Text := 'Select SCRIPTNAME from ' + VersTabName +
          ' where (VERSION = ' + IntToStr(AUpdate.Version) +
          ') and (SCRIPTNAME = ''' + TmpSR.name +
          ''') and (EXECRESULT = 1)';
        qrTemp.Active := True;
        if not qrTemp.Eof then
          ScriptResult := True;
        qrTemp.Active := False;

        //���� ��� ������ ��� ���������� �� �� ����� ��������
        if ScriptResult then
        begin
          found := FindNext(TmpSR);
          Continue;
        end;

        SqlScript.SQLScriptFileName := ADirName + TmpSR.name;
        SqlScript.ExecuteFile(SqlScript.SQLScriptFileName);
        ScriptResult := (SqlScript.TotalErrors = 0) and (SqlErrorList.Count = 0);

        qrTemp.SQL.Text := 'INSERT INTO ' + VersTabName +
          ' (VERSION,SCRIPTNAME,EXECTIME,EXECRESULT,ERRORCOUNT,ERRORTEXT,COMMENT,' +
          'SCRIPTCOUNT,SCRIPTNO) VALUES (:VERSION,:SCRIPTNAME,:EXECTIME,:EXECRESULT,' +
          ':ERRORCOUNT,:ERRORTEXT,:COMMENT,:SCRIPTCOUNT,:SCRIPTNO)';
        qrTemp.ParamByName('VERSION').Value := AUpdate.Version;
        qrTemp.ParamByName('SCRIPTNAME').Value := TmpSR.name;
        qrTemp.ParamByName('EXECTIME').Value := Now;
        qrTemp.ParamByName('EXECRESULT').Value := byte(ScriptResult);
        qrTemp.ParamByName('ERRORCOUNT').Value := SqlErrorList.Count;
        qrTemp.ParamByName('ERRORTEXT').Value := copy(SqlErrorList.Text, 1, 250);
        qrTemp.ParamByName('COMMENT').Value := AUpdate.Comment;
        qrTemp.ParamByName('SCRIPTCOUNT').Value := ScriptCount;
        qrTemp.ParamByName('SCRIPTNO').Value := ScriptNo;
        qrTemp.ExecSQL;

        //���� ���������� ������� ������ � ��������, �� ���������� �����������
        if not ScriptResult then
        begin
          Result := False;
          Exit;
        end;

        found := FindNext(TmpSR);
      end;
    finally
      FindClose(TmpSR);
    end;
  end
  else
  begin
    //���� ���������� �� �������� �������� ��� ������������ ��� ����������
    ScriptResult := True;
    qrTemp.SQL.Text := 'INSERT INTO ' + VersTabName +
      ' (VERSION,SCRIPTNAME,EXECTIME,EXECRESULT,ERRORCOUNT,ERRORTEXT,COMMENT,' +
      'SCRIPTCOUNT,SCRIPTNO) VALUES (:VERSION,:SCRIPTNAME,:EXECTIME,:EXECRESULT,' +
      ':ERRORCOUNT,:ERRORTEXT,:COMMENT,:SCRIPTCOUNT,:SCRIPTNO)';
    qrTemp.ParamByName('VERSION').Value := AUpdate.Version;
    qrTemp.ParamByName('SCRIPTNAME').Value := '';
    qrTemp.ParamByName('EXECTIME').Value := Now;
    qrTemp.ParamByName('EXECRESULT').Value := byte(ScriptResult);
    qrTemp.ParamByName('ERRORCOUNT').Value := SqlErrorList.Count;
    qrTemp.ParamByName('ERRORTEXT').Value := copy(SqlErrorList.Text, 1, 250);
    qrTemp.ParamByName('COMMENT').Value := AUpdate.Comment;
    qrTemp.ParamByName('SCRIPTCOUNT').Value := ScriptCount;
    qrTemp.ParamByName('SCRIPTNO').Value := ScriptNo;
    qrTemp.ExecSQL;
  end;
end;

function TUpdateForm.CheckUpdateProc: Boolean;
begin
   Application.ProcessMessages;
   Result := FStopUpdateProc or FErrorUpdateProc;
end;

procedure TUpdateForm.StartUpdate;
var i: integer;
begin
  StartUpdater := False;
  UpdatePath := '';
  FStopUpdateProc := False;
  FErrorUpdateProc := False;
  NewAppVersion := IntToStr(FCurVersion.App);

  //����� ������� ���������� ����� ��������� ���������
  KillDir(ExtractFilePath(Application.ExeName) + 'Updates');
  ForceDirectories(ExtractFilePath(Application.ExeName) + 'Updates');
  Memo1.Lines.Clear;
  ShowStatys('������ �������� ����������:');
  SqlErrorList.Clear;
  SqlScript.Tag := integer(SqlErrorList);

  if FSR.CatalogCount > 0 then
  begin
    ShowStatys('');
    ShowStatys('***���������� ������������***');

    for i := 0 to FSR.CatalogCount - 1 do
    begin
      if CheckUpdateProc then
        Break;
      LoadAndSetUpdate(FSR.CatalogList[i], 0);
    end;
    if CheckUpdateProc then
    begin
      if FStopUpdateProc then
      begin
        ShowStatys('');
        ShowStatys('���������� ��������!');
      end;
      Exit;
    end;

    ShowStatys('***����������� ���������***');
  end;

  if FSR.UserCount > 0 then
  begin
    ShowStatys('');
    ShowStatys('***���������� ���������������� ������***');

    for i := 0 to FSR.UserCount - 1 do
    begin
      if CheckUpdateProc then
        Break;
      LoadAndSetUpdate(FSR.UserList[i], 1);
    end;

    if CheckUpdateProc then
    begin
      if FStopUpdateProc then
      begin
        ShowStatys('');
        ShowStatys('���������� ��������!');
      end;
      Exit;
    end;

    ShowStatys('***���������������� ������� ���������***');
  end;

  if FSR.AppCount > 0 then
  begin
    ShowStatys('');
    ShowStatys('***���������� ���������***');

    for i := 0 to FSR.AppCount - 1 do
    begin
      if CheckUpdateProc then
        Break;
      LoadAndSetUpdate(FSR.AppList[i], 2);
    end;

    if CheckUpdateProc then
    begin
      if FStopUpdateProc then
      begin
        ShowStatys('');
        ShowStatys('���������� ��������!');
      end;
      Exit;
    end;

    if not StartUpdater then
      ShowStatys('***��������� ���������***');
  end;

  if StartUpdater then
  begin
    ShowStatys('');
    ShowStatys('��� ���������� ���������� ����� ���������� ���������!');
  end;

  ShowStatys('');
  ShowStatys('���������� ������ �������!');
end;

procedure TUpdateForm.SetVersion(const AVersion: TVersion;
  const AServiceResponse: TServiceResponse);
begin
  FSR.Assign(AServiceResponse);
  FCurVersion.Assign(AVersion);
end;

//����������� �� ����� ���������� ������� ���������� ��������� � SqlErrorList
procedure TUpdateForm.SQLScriptAfterExecute(Sender: TObject);
begin
  ProgressBar1.Visible := False;
end;

procedure TUpdateForm.SQLScriptBeforeExecute(Sender: TObject);
begin
  ProgressBar1.Style := pbstMarquee;
  ProgressBar1.Visible := True;
end;

procedure TUpdateForm.SQLScriptError(ASender: TObject;
  const AInitiator: IFDStanObject; var AException: Exception);
begin
  if SQLScript.Tag > 0 then
  begin
    TStringList(SQLScript.Tag).Add(
      ExtractFileName(SQLScript.SQLScriptFileName) + ': ' + AException.Message);
    Abort;
  end;
end;

procedure TUpdateForm.SQLScriptProgress(Sender: TObject);
begin
  Application.ProcessMessages;
end;

procedure TUpdateForm.SetButtonStyle(AStyle: Integer);
begin
  btnUpdate.Width := 100;
  btnCancel.Width := 75;
  btnOk.Width := 75;
  btnIterrupt.Width := 100;
  //��� ������ ��������
  case AStyle of
    1:  //���������� ����
    begin
      btnUpdate.Visible := True;
      btnCancel.Visible := True;
      btnOk.Visible := False;
      btnIterrupt.Visible := False;
      btnCancel.Left := Panel1.Width - btnCancel.Width - 8;
      btnUpdate.Left := btnCancel.Left - btnUpdate.Width - 8;
    end;
    2:  //���������� ����������
    begin
      btnUpdate.Visible := False;
      btnCancel.Visible := False;
      btnOk.Visible := False;
      btnIterrupt.Visible := True;
      btnIterrupt.Left := Panel1.Width - btnIterrupt.Width - 8;
    end;
    else //���������� ���
    begin
      btnUpdate.Visible := False;
      btnCancel.Visible := False;
      btnOk.Visible := True;
      btnIterrupt.Visible := False;
      btnOk.Left := Panel1.Width - btnOk.Width - 8;
    end;
  end;
end;

//������������� ������� ��� ���� ����������
procedure TUpdateForm.ShowUpdateStatys;
begin
  //������� ������
  label2.Caption := '������� ������ ���������: ' + IntToStr(FCurVersion.App);
  label3.Caption := '������������: ' + IntToStr(FCurVersion.Catalog);
  label4.Caption := '���������������� ������: ' + IntToStr(FCurVersion.User);

  //��� ������ ��������
  SetButtonStyle(FSR.UpdeteStatys);

  memo1.Lines.Clear;
  //��������� � ����
  case FSR.UpdeteStatys of
    1:  //���������� ����
    begin
      ShowStatys('�������� ����� ���������� �� �������:');

      if FCurVersion.App < FSR.AppVersion then
        ShowStatys('����� ��������� :' + IntToStr(FSR.AppVersion));

      if FCurVersion.Catalog < FSR.CatalogVersion then
        ShowStatys('����� ������������ :' +
          IntToStr(FSR.CatalogVersion));

      if FCurVersion.User < FSR.UserVersion then
        ShowStatys('����� ���������������� ������ :' +
          IntToStr(FSR.UserVersion));
    end;
    else //���������� ���
    begin
      ShowStatys('�� ������� ����� ���������� ���.');
    end;
  end;
end;

procedure TUpdateForm.btnIterruptClick(Sender: TObject);
begin
  FStopUpdateProc := True;
end;

procedure TUpdateForm.btnOkClick(Sender: TObject);
begin
  close;
end;

procedure TUpdateForm.btnUpdateClick(Sender: TObject);
begin
  SetButtonStyle(2);
  Application.ProcessMessages;
  StartUpdate;
  SetButtonStyle(0);
end;

procedure TUpdateForm.FormCreate(Sender: TObject);
begin
  FCurVersion.Clear;
  FSR := TServiceResponse.Create;
  SqlErrorList := TStringList.Create;

  FLogFile := TLogFile.Create;
  FLogFile.Active := true;
  FLogFile.FileDir := ExtractFileDir(ExtractFilePath(Application.ExeName) + LogFileName);
  FLogFile.FileName := ExtractFileName(LogFileName);
end;

procedure TUpdateForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FSR);
  FreeAndNil(SqlErrorList);
  FreeAndNil(FLogFile);
end;

procedure TUpdateForm.FormShow(Sender: TObject);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    FClientName := ini.ReadString('system', 'clientname', '');
    FSendReport := ini.ReadBool('system', 'sendreport', False);
  finally
    FreeAndNil(ini);
  end;
 ShowUpdateStatys;
end;

procedure TUpdateForm.HTTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  if AWorkMode = wmRead then
    ProgressBar1.Position := AWorkCount div 100;

end;

procedure TUpdateForm.HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  if AWorkMode = wmRead then
  begin
    ProgressBar1.Style := pbstNormal;
    ProgressBar1.Visible := True;
    ProgressBar1.Position := 0;
    ProgressBar1.Max := AWorkCountMax div 100;
  end;
end;

procedure TUpdateForm.HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  ProgressBar1.Visible := False;
  ProgressBar1.Position := 0;
end;

end.
