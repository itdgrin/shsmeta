unit fLicense;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.IOUtils,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  JvExControls,
  JvLabel,
  JvExStdCtrls,
  JvHtControls,
  Vcl.Imaging.pngimage,
  System.Actions,
  Vcl.ActnList,
  System.Types,
  RC6,
  hwid_impl,
  winioctl,
  System.AnsiStrings;

type
  TLicenseForm = class(TForm)
    ButtonPanel: TPanel;
    MainPanel: TPanel;
    imgLicense: TImage;
    btnClose: TButton;
    lbTitle: TJvHTLabel;
    lbTitleState: TJvLabel;
    lbState: TLabel;
    Bevel1: TBevel;
    lbUserNameTitle: TJvLabel;
    lbActDateTitle: TJvLabel;
    lbEndDateTitle: TJvLabel;
    lbLicenFileTitle: TJvLabel;
    lbLicenFile: TJvLabel;
    lbEndDate: TJvLabel;
    lbActDate: TJvLabel;
    lbUserName: TJvLabel;
    Bevel2: TBevel;
    btnNewLicense: TButton;
    btnSaveDataFile: TButton;
    edtSerial1: TEdit;
    edtSerial2: TEdit;
    edtSerial3: TEdit;
    edtSerial4: TEdit;
    lbSerialTitle: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pmNewLicense: TPopupMenu;
    pmLoadKeyFromInet: TMenuItem;
    pmLoadKeyFromLocal: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    lbSelectLicense: TJvLabel;
    cbSelectLicense: TComboBox;
    btnDeleteLicense: TButton;
    ActionList: TActionList;
    actDelLicense: TAction;
    procedure btnNewLicenseDropDownClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtSerial1Change(Sender: TObject);
    procedure edtSerial1Enter(Sender: TObject);
    procedure edtSerial1Exit(Sender: TObject);
    procedure pmLoadKeyFromInetClick(Sender: TObject);
    procedure btnSaveDataFileClick(Sender: TObject);
    procedure pmLoadKeyFromLocalClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actDelLicenseUpdate(Sender: TObject);
    procedure actDelLicenseExecute(Sender: TObject);
    procedure cbSelectLicenseChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    FCurLicenseFile: string;
    FLicenseResult: Boolean;
    FLicenseList: TStringDynArray;

    function GetSerialNumber(var ASNumber: string): Boolean;
    procedure UpdateLicenseInfo;
    function GetCurLicenseFile: string;
    procedure SetCurLicenseFile(const ALicenseFile: string);
    procedure CheckCurLicense;
  public
    { Public declarations }
  end;

implementation
uses
 System.Win.Registry,
 SerialKeyModule,
 GlobsAndConst,
 uMemoryLoader;

{$R *.dfm}

procedure TLicenseForm.actDelLicenseExecute(Sender: TObject);
begin
  if TFile.Exists(FCurLicenseFile) then
  begin
    if Application.MessageBox('Удалить текущую лицезию?',
        PChar(Application.Title),
        MB_OKCANCEL + MB_ICONQUESTION + MB_TOPMOST) = mrCancel then
      Exit;

    TFile.Delete(FCurLicenseFile);
  end;
  UpdateLicenseInfo;
end;

procedure TLicenseForm.actDelLicenseUpdate(Sender: TObject);
begin
  actDelLicense.Enabled := FCurLicenseFile <> EmptyStr;
end;

procedure TLicenseForm.CheckCurLicense;
var SI: TSerialKeyInfo;
    ExceptFlag: Boolean;
begin
  FLicenseResult := CheckLicenseFile(FCurLicenseFile, SI, ExceptFlag);
  if not ExceptFlag then
  begin
    lbUserName.Caption := SI.UserName;
    lbActDate.Caption := DateToStr(SI.DateBegin);
    lbEndDate.Caption := DateToStr(SI.DateEnd);
  end
  else
  begin
    lbUserName.Caption := '---';
    lbActDate.Caption := '---';
    lbEndDate.Caption := '---';
    lbLicenFile.Caption := '---';
  end;

  if FCurLicenseFile <> '' then
    lbLicenFile.Caption := FCurLicenseFile;

  if FLicenseResult  then
  begin
    lbState.Caption := 'Есть действующия лицензия';
    lbState.Font.Color := clGreen;
  end
  else
  begin
    lbState.Caption := 'Отсутствует действующия лицензия';
    lbState.Font.Color := clRed;
  end;
end;

procedure TLicenseForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TLicenseForm.btnNewLicenseDropDownClick(Sender: TObject);
var Point: TPoint;
begin
  Point.X := btnNewLicense.Left;
  Point.Y := btnNewLicense.Top + btnNewLicense.Height;
  Point := MainPanel.ClientToScreen(Point);
  pmNewLicense.Popup(Point.X, Point.Y);
end;

function TLicenseForm.GetSerialNumber(var ASNumber: string): Boolean;
begin
  ASNumber :=
    edtSerial1.Text + edtSerial2.Text + edtSerial3.Text + edtSerial4.Text;
  if Length(ASNumber) <> 16 then
  begin
    ShowMessage('Введите правильный серийный номер.');
    edtSerial1.SetFocus;
    Result := False;
    Exit;
  end;
  Result := True;
end;

procedure TLicenseForm.pmLoadKeyFromInetClick(Sender: TObject);
var SNumber: string;
begin
  if not GetSerialNumber(SNumber) then
    Exit;

end;

function TLicenseForm.GetCurLicenseFile: string;
var Reg: TRegistry;
    CurKey: string;
begin
  Result := '';
  Reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    Reg.RootKey := C_REGROOT;
    CurKey := C_REGKEY + '\' + C_LICENSEKEY;

    if Reg.OpenKey(CurKey, True) then
    begin
      if Reg.ValueExists('CurLicense') then
        Result := Reg.ReadString('CurLicense');
    end
    else
      raise Exception.Create('Unable to create key!');

    Reg.CloseKey;
  finally
    Reg.CloseKey;
    FreeAndNil(Reg);
  end;
end;

procedure TLicenseForm.SetCurLicenseFile(const ALicenseFile: string);
var Reg: TRegistry;
    CurKey: string;
begin
  Reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    Reg.RootKey := C_REGROOT;
    CurKey := C_REGKEY + '\' + C_LICENSEKEY;

    if Reg.OpenKey(CurKey, True) then
      Reg.WriteString('CurLicense', ALicenseFile)
    else
      raise Exception.Create('Unable to create key!');

    Reg.CloseKey;
  finally
    Reg.CloseKey;
    FreeAndNil(Reg);
  end;
end;

procedure TLicenseForm.pmLoadKeyFromLocalClick(Sender: TObject);
var LicensePath,
    FileName: string;
    Ind: Integer;
    TmpName,
    TmpExt: string;
begin
  if OpenDialog.Execute(Self.Handle) then
  begin
    LicensePath := ExtractFilePath(Application.ExeName) + C_LICENSEDIR;
    FileName := ExtractFileName(OpenDialog.FileName);
    if TDirectory.Exists(LicensePath) then
      TDirectory.CreateDirectory(LicensePath);
    //Если файл с таким именем существует, изменяет имя при копировании
    if TFile.Exists(LicensePath + FileName) then
    begin
      Ind := 1;
      TmpName := ChangeFileExt(FileName, '');
      TmpExt := ExtractFileExt(FileName);
      while TFile.Exists(LicensePath + TmpName + Ind.ToString + TmpExt) do
        Inc(Ind);
      FileName := TmpName + Ind.ToString + TmpExt;
    end;

    TFile.Copy(OpenDialog.FileName, LicensePath + FileName);
    SetCurLicenseFile(LicensePath + FileName);
    UpdateLicenseInfo;
  end;
end;

procedure TLicenseForm.btnSaveDataFileClick(Sender: TObject);
var SNumber: string;
    FStream: TFileStream;
    LocalData: TBytes;
begin
  if not GetSerialNumber(SNumber) then
    Exit;

  if SaveDialog.Execute(Self.Handle) then
  begin
    SaveDialog.FileName := ChangeFileExt(SaveDialog.FileName, '.dat');
    FStream := TFileStream.Create(SaveDialog.FileName, fmCreate);
    try
      GetLocalData(ExtractFileDrive(Application.ExeName), LocalData);
      GetLocalDataFile(SNumber, LocalData, FStream);
    finally
      FreeAndNil(FStream);
    end;
  end;
end;

procedure TLicenseForm.cbSelectLicenseChange(Sender: TObject);
begin
  FCurLicenseFile := '';
  if cbSelectLicense.ItemIndex > -1 then
    FCurLicenseFile := FLicenseList[cbSelectLicense.ItemIndex];
  SetCurLicenseFile(FCurLicenseFile);
  UpdateLicenseInfo;
end;

procedure TLicenseForm.UpdateLicenseInfo;
var LicensePath: string;
    Flag: Integer;
    I: Integer;
begin
  LicensePath := ExtractFilePath(Application.ExeName) + C_LICENSEDIR;
  TDirectory.CreateDirectory(LicensePath);
  //Получение списка файлов лицензии
  FLicenseList :=
    TDirectory.GetFiles(LicensePath, '*.key', TSearchOption.soTopDirectoryOnly);
  //Получение текущей  лицензии
  FCurLicenseFile := GetCurLicenseFile;
  cbSelectLicense.Items.Clear;

  if Length(FLicenseList) = 0 then
  begin
    if FCurLicenseFile <> '' then
    begin
      FCurLicenseFile := '';
      SetCurLicenseFile(FCurLicenseFile);
    end;
  end
  else
  begin
    Flag := 0;
    for I := Low(FLicenseList) to High(FLicenseList) do
    begin
      cbSelectLicense.Items.Add(ExtractFileName(FLicenseList[I]));
      if FLicenseList[I].ToLower = FCurLicenseFile.ToLower then
        Flag := I;
    end;
    cbSelectLicense.ItemIndex := Flag;

    //Устанавливает текущей первую лицензиию, если текущая не найдена
    if FLicenseList[Flag].ToLower <> FCurLicenseFile.ToLower then
    begin
      FCurLicenseFile := FLicenseList[Flag];
      SetCurLicenseFile(FCurLicenseFile);
    end;
  end;

  CheckCurLicense;
end;

procedure TLicenseForm.edtSerial1Change(Sender: TObject);
begin
  if Length((Sender as TEdit).Text) >= 4 then
    SelectNext((Sender as TEdit), True, True);
end;

procedure TLicenseForm.edtSerial1Enter(Sender: TObject);
//var
//  Layout: array[0.. KL_NAMELENGTH] of char;
begin
// (Sender as TEdit).Tag := LoadKeyboardLayout(StrCopy(Layout,'00000409'),KLF_ACTIVATE);
end;

procedure TLicenseForm.edtSerial1Exit(Sender: TObject);
begin
//  UnloadKeyboardLayout((Sender as TEdit).Tag);
end;

procedure TLicenseForm.FormDestroy(Sender: TObject);
begin
  if G_CURLISENSE <> FCurLicenseFile then
    G_CURLISENSE := FCurLicenseFile;
end;

procedure TLicenseForm.FormShow(Sender: TObject);
begin
  UpdateLicenseInfo;
end;

end.
