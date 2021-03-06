unit SerialKeyModule;

interface
uses
  Winapi.Windows,
  System.SysUtils,
  System.AnsiStrings,
  System.Classes,
  Dialogs,
  Forms,
  IdCoderMIME,
  IdGlobal,
  RC6,
  hwid_impl,
  winioctl;

const
  KeyLen = 16;
  ConstKey: array[0..15] of byte =
    ($42,$72,$65,$67,$6f,$72,$69,$6f,$56,$69,$63,$74,$6f,$72,$69,$61);

  SMART_GET_VERSION = $074080;
  SMART_SEND_DRIVE_COMMAND = $07C084;
  SMART_RCV_DRIVE_DATA = $07C088;

  // Values of ds_bDriverError
  DRVERR_NO_ERROR = 0;
  DRVERR_IDE_ERROR = 1;
  DRVERR_INVALID_FLAG = 2;
  DRVERR_INVALID_COMMAND = 3;
  DRVERR_INVALID_BUFFER = 4;
  DRVERR_INVALID_DRIVE = 5;
  DRVERR_INVALID_IOCTL = 6;
  DRVERR_ERROR_NO_MEM = 7;
  DRVERR_INVALID_REGISTER = 8;
  DRVERR_NOT_SUPPORTED = 9;
  DRVERR_NO_IDE_DEVICE = 10;

  // Values of ir_bCommandReg
  ATAPI_ID_CMD = $A1;
  ID_CMD = $EC;
  SMART_CMD = $B0;

type
  TSmAssigned = function (AValue: Pointer): Boolean;
  TCheckKey = function (ABeginDate, AEndDate: TDateTime): Boolean;

  //��������� ��� �������� ������������ ����������
  TSerialKeyInfo = record
    UserName: string;
    UserKey: TBytes;
    LocalID: Int64;
    DateBegin: TDateTime;
    DateEnd: TDateTime;
  end;
  PSerialKeyInfo = ^TSerialKeyInfo;

  TSerialKeyData = TBytes;
  PSerialKeyData = ^TSerialKeyData;

  TIdeRegs = packed record
    bFeaturesReg,
    bSectorCountReg,
    bSectorNumberReg,
    bCylLowReg,
    bCylHighReg,
    bDriveHeadReg,
    bCommandReg,
    bReserved: Byte;
  end;

  TDriverStatus = packed record
    bDriverError: Byte;
    bIDEError: Byte;
    bReserved: array[1..2] of Byte;
    dwReserved: array[1..2] of DWord;
  end;

  TSendCmdInParams = packed record
    dwBufferSize: DWORD;
    irDriveRegs: TIdeRegs;
    bDriveNumber: Byte;
    bReserved: array[1..3] of Byte;
    dwReserved: array[1..4] of DWord;
    bBuffer: Byte;
  end;

  TSendCmdOutParams = packed record
    dwBufferSize: DWORD;
    dsDriverStatus: TDriverStatus;
    bBuffer: array[1..512] of Byte;
  end;

  TGetVersionInParams = packed record
    bVersion,
    bRevision,
    bReserved,
    bIDEDeviceMap: Byte;
    dwCapabilities: DWord;
    dwReserved: array[1..4] of DWord;
  end;

//��������� ������ HDD �� ����� �����
function GetHDDNumberByLetter(ADrive: string): DWord; //inline;
//��������� ��������� HDD !!! �� �������� ��� ���� ������
function GetHDDSerialByNum(ANum: DWord;
  var ASerial, ARevision, AModel: AnsiString): DWord;
procedure CorrectDevInfo(var _params: TSendCmdOutParams);
//�������� �������� ����������� �����
function GetDiskSerialNum(ADrive: string): DWord;
//��������� ���������� �����
procedure GetLocalKey(var AKey: TBytes); //inline;
//���������� ��������� ������ ��� �������� �� ������ ��� ��������� ���������� �����
procedure GetLocalData(ADrive: string; var AData: TBytes); //inline;
//���������� ��������� ������ � ���� (�����)
procedure GetLocalDataFile(const ASerialKey: string; const AData: TBytes;
  AStream: TStream);
procedure GetLocalDataFromFile(var ASerialKey: string; var AData: TBytes;
  AStream: TStream);

//������� ����-����
procedure CreateKeyFile(const AFileName: string; const AKey: TBytes;
  const ASerialKeyInfo: TSerialKeyInfo; AKeyDll: TMemoryStream);
//��������� ������ �� ����-�����
procedure GetSerialKeyInfo(const AFileName: string; const AKey: TBytes;
  var ASerialKeyInfo: TSerialKeyInfo; AKeyDll: TMemoryStream); //inline;
//��������� ���������� ���������
function CheckLicenseFile(const AFileName: string; var ASI: TSerialKeyInfo;
  var ExceptFlag: Boolean): Boolean; //inline;
function CheckCurLicense: Boolean; //inline;
function LicenseAssigned(AValue: Pointer): Boolean; //inline;

implementation

uses uMemoryLoader, GlobsAndConst;

procedure CorrectDevInfo(var _params: TSendCmdOutParams);
  asm
  lea edi, _params.bBuffer

  add edi,14h
  mov ecx,0Ah

  @@SerNumLoop: mov ax,[edi]
  xchg al,ah
  stosw
  loop @@SerNumLoop

  add edi,6
  mov cl,18h

  @@ModelNumLoop: mov ax,[edi]
  xchg al,ah
  stosw
  loop @@ModelNumLoop
end;

//�������� ����� ����������� ����� �� ����� �����������
function GetHDDNumberByLetter(ADrive: string): DWord;
const
  IOCTL_STORAGE_GET_DEVICE_NUMBER = $2D1080;
var
  hDevice, BytesReturned: DWord;
  DeviceInfo: packed record
    DeviceType,
    DeviceNumber,
    PartitionNumber :DWord;
  end;
begin
  Result := 0;
  hDevice := CreateFile(PChar('\\.\' + ADrive),
    0, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  if (hDevice <> INVALID_HANDLE_VALUE) and
      DeviceIoControl(hDevice, IOCTL_STORAGE_GET_DEVICE_NUMBER,
        nil, 0, @DeviceInfo, SizeOf(DeviceInfo), BytesReturned, nil) then
  begin
    Result := DeviceInfo.DeviceNumber;
    CloseHandle(hDevice)
  end
end;

//�� ������������ ������� ����������
function GetHDDSerialByNum(ANum: DWord;
  var ASerial, ARevision, AModel: AnsiString): DWord;
var
  tmp: AnsiString;
  dev: THandle;
  scip: TSendCmdInParams;
  scop: TSendCmdOutParams;
  gvip: TGetVersionInParams;
  ret: DWORD;
begin
  Result := 1;
  dev := CreateFile(PChar('\\.\PhysicalDrive' + IntToStr(ANum)),
    GENERIC_READ or GENERIC_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  try
    if dev <> INVALID_HANDLE_VALUE then
    begin
      if DeviceIoControl(dev, SMART_GET_VERSION, nil, 0, @gvip, SizeOf(gvip),
        ret, nil) then
      begin
        scip.dwBufferSize := 512;
        scip.bDriveNumber := 0;
        scip.irDriveRegs.bSectorCountReg := 1;
        scip.irDriveRegs.bSectorNumberReg := 1;
        scip.irDriveRegs.bDriveHeadReg := $A0;
        scip.irDriveRegs.bCommandReg := ID_CMD;
        if DeviceIoControl(dev, SMART_RCV_DRIVE_DATA, @scip, SizeOf(scip),
          @scop, SizeOf(scop), ret, nil) then
        begin
          if scop.dsDriverStatus.bDriverError = DRVERR_NO_ERROR then
          begin
            CorrectDevInfo(scop);
            SetLength(tmp, 20);
            Move(scop.bBuffer[21], tmp[1], 20);
            ASerial := System.AnsiStrings.Trim(tmp);

            SetLength(tmp, 8);
            Move(scop.bBuffer[47], tmp[1], 8);
            ARevision := System.AnsiStrings.Trim(tmp);

            SetLength(tmp, 40);
            Move(scop.bBuffer[55], tmp[1], 40);
            AModel := System.AnsiStrings.Trim(tmp);
            Result := 0;
          end
          else
            Result := scop.dsDriverStatus.bDriverError;
        end
        else
          Result := GetLastError;
      end
      else
        Result := GetLastError;
    end;
  finally
    CloseHandle(dev);
  end;
end;

function GetDiskSerialNum(ADrive: string): DWord;
var
  sz,fs: DWord;
begin
 GetVolumeInformation(PChar(ADrive), nil, 0, @Result, sz, fs, nil, 0);
end;

procedure GetLocalData(ADrive: string; var AData: TBytes);
const LKeyLen = 16;
var Ind: Integer;
    I: Integer;
    Dest: tresults_array_dv;
begin
  SetLength(AData, LKeyLen);
  FillChar(AData[0], LKeyLen, 0);

  Ind := GetHDDNumberByLetter(ADrive);
  GetHardDriveComputerID(Dest);
  if Length(Dest) > Ind then
  begin
    for I := Low(AData) to High(AData) do
    begin
      if Length(Dest[Ind].DriveSerialNumber) >= I then
        AData[I] := Byte(Dest[Ind].DriveSerialNumber[I + 1]);
      if Length(Dest[Ind].DriveModelNumber) >= I then
        AData[I] := AData[I] xor Byte(Dest[Ind].DriveModelNumber[I + 1]);
    end;
  end;

  for I := Low(AData) to High(AData) do
    AData[I] := AData[I] xor ConstKey[I];

  for I := Low(AData) to High(AData) - 1 do
    AData[I + 1] := AData[I + 1] xor AData[I];
end;

procedure GetLocalKey(var AKey: TBytes);
var
  RC6Encryptor: TRC6Encryptor;
begin
  RC6Encryptor := TRC6Encryptor.Create(ConstKey);
  try
    AKey := RC6Encryptor.BytesEncrypt(AKey);
  finally
    FreeAndNil(RC6Encryptor);
  end;
end;

procedure GetLocalDataFile(const ASerialKey: string; const AData: TBytes;
  AStream: TStream);
const FLen = 256;
var TmpBytes: TBytes;
    I, J: Integer;
    RC6Encryptor: TRC6Encryptor;
    TmpStr: String;
begin
  if Length(ASerialKey) <> KeyLen then
    raise Exception.Create('Serial key is not correct.');

  SetLength(TmpBytes, KeyLen + FLen);

  Randomize;
  for I := Low(TmpBytes) to High(TmpBytes) do
    TmpBytes[I] := Byte(Random(256));

  J := TmpBytes[0];
  if J = 0 then
    J := 1;
  if J + KeyLen > FLen - 1 then
    J := FLen - KeyLen - 1;


  Move(AData[0], TmpBytes[J], KeyLen);
  Move(TEncoding.UTF8.GetBytes(ASerialKey)[0], TmpBytes[FLen], KeyLen);

  RC6Encryptor := TRC6Encryptor.Create(ConstKey);
  try
    TmpBytes := RC6Encryptor.BytesEncrypt(TmpBytes);
  finally
    FreeAndNil(RC6Encryptor);
  end;

  TmpStr := TIdEncoderMIME.EncodeBytes(TIdBytes(TmpBytes));

  AStream.Write(TmpBytes, Length(TmpBytes));
end;

procedure GetLocalDataFromFile(var ASerialKey: string; var AData: TBytes;
  AStream: TStream);
const FLen = 256;
var TmpBytes: TBytes;
    Tmp: TBytes;
    J: Integer;
    RC6Encryptor: TRC6Encryptor;
begin
  SetLength(TmpBytes, AStream.Size);
  AStream.Position := 0;
  AStream.Read(TmpBytes, AStream.Size);

  RC6Encryptor := TRC6Encryptor.Create(ConstKey);
  try
    TmpBytes := RC6Encryptor.BytesDecrypt(TmpBytes);
  finally
    FreeAndNil(RC6Encryptor);
  end;

  SetLength(Tmp, KeyLen);
  Move(TmpBytes[FLen], Tmp[0], KeyLen);
  ASerialKey := TEncoding.UTF8.GetString(Tmp);

  J := TmpBytes[0];
  if J = 0 then
    J := 1;
  if J + KeyLen > FLen - 1 then
    J := FLen - KeyLen - 1;

  SetLength(AData, KeyLen);
  Move(TmpBytes[J], AData[0], KeyLen);
end;


procedure CreateKeyFile(const AFileName: string; const AKey: TBytes;
  const ASerialKeyInfo: TSerialKeyInfo; AKeyDll: TMemoryStream);
var  RC6Encryptor: TRC6Encryptor;
     TmpStream1, TmpStream2: TMemoryStream;
     TmpBytes: TBytes;
     TmpStr: string;
begin
  TmpStream1 := TMemoryStream.Create;
  TmpStream2 := TMemoryStream.Create;
  RC6Encryptor := TRC6Encryptor.Create(AKey);
  try
    //��� ���������
    SetLength(TmpBytes, 256);
    TmpStr := Copy(ASerialKeyInfo.UserName, 1, 128);
    Move(TmpStr[1], TmpBytes[0], Length(TmpStr) * SizeOf(Char));
    TmpStream1.Write(TmpBytes, Length(TmpBytes));
    //UserKey � ������ ������ �� ������������, ������ ����� ������
    SetLength(TmpBytes, Length(ASerialKeyInfo.UserKey));
    Move(ASerialKeyInfo.UserKey[0], TmpBytes[0], Length(ASerialKeyInfo.UserKey));
    SetLength(TmpBytes, 16);
    TmpStream1.Write(TmpBytes, Length(TmpBytes));
    //������ �������� ��������
    TmpStream1.Write(ASerialKeyInfo.DateBegin, SizeOf(ASerialKeyInfo.DateBegin));
    TmpStream1.Write(ASerialKeyInfo.DateEnd, SizeOf(ASerialKeyInfo.DateEnd));
    //ID ������������, ��� �������
    TmpStream1.Write(ASerialKeyInfo.LocalID, SizeOf(ASerialKeyInfo.LocalID));
    //dll
    AKeyDll.Position := 0;
    TmpStream1.CopyFrom(AKeyDll, AKeyDll.Size);
    RC6Encryptor.StreamEncrypt(TmpStream1, TmpStream2, True);
    TmpStream2.SaveToFile(AFileName);
  finally
    FreeAndNil(RC6Encryptor);
    FreeAndNil(TmpStream1);
    FreeAndNil(TmpStream2);
  end;
end;

procedure GetSerialKeyInfo(const AFileName: string; const AKey: TBytes;
  var ASerialKeyInfo: TSerialKeyInfo; AKeyDll: TMemoryStream);
var  RC6Encryptor: TRC6Encryptor;
     TmpStream1, TmpStream2: TMemoryStream;
     TmpBytes: TBytes;
     TmpStr: string;
     Y, M, D: Word;
begin
  TmpStream1 := TMemoryStream.Create;
  TmpStream2 := TMemoryStream.Create;
  RC6Encryptor := TRC6Encryptor.Create(AKey);
  try
    TmpStream1.LoadFromFile(AFileName);
   // TmpStream1.SaveToFile(ExtractFileDir(Application.ExeName) + '\testFile1.dat');
    TmpStream1.Position := 0;
    RC6Encryptor.StreamDecrypt(TmpStream1, TmpStream2, True);
  //  TmpStream2.SaveToFile(ExtractFileDir(Application.ExeName) + '\testFile2.dat');
    TmpStream2.Position := 0;
    //��� ���������
    SetLength(TmpBytes, 256);
    TmpStream2.Read(TmpBytes, 256);

    //UserKey � ������ ������ �� ������������, ������ ����� ������
    //������ ���� ������������ ���  �������� ������ �����
    SetLength(ASerialKeyInfo.UserKey, 16);
    TmpStream2.Read(ASerialKeyInfo.UserKey, 16);

    if ASerialKeyInfo.UserKey[0] = 0 then
    begin
      ASerialKeyInfo.UserName := String(PChar(TmpBytes));
      //������ �������� ��������
      TmpStream2.Read(ASerialKeyInfo.DateBegin, SizeOf(ASerialKeyInfo.DateBegin));
      TmpStream2.Read(ASerialKeyInfo.DateEnd, SizeOf(ASerialKeyInfo.DateEnd));

      //������ ������, ����� �� ���� ������ �����, ������� �� ������ �����
      //ID ������������, ��� �������
      if TmpStream2.Size > 130336 then //��� ��������� ����������� �������� �����
        TmpStream2.Read(ASerialKeyInfo.LocalID, SizeOf(ASerialKeyInfo.LocalID));
    end;

    if ASerialKeyInfo.UserKey[0] = 1 then
    begin
      ASerialKeyInfo.UserName := UTF8ToString(Utf8String(PAnsiChar(TmpBytes)));
      ASerialKeyInfo.DateBegin := 0;
      ASerialKeyInfo.DateEnd := 0;
      ASerialKeyInfo.LocalID := 0;
      try
        SetLength(TmpStr, 8);
        SetLength(TmpBytes, 0);
        SetLength(TmpBytes, 9);
        TmpStream2.Read(TmpBytes, 8);
        TmpStr := UTF8ToString(Utf8String(PAnsiChar(TmpBytes)));
        D := StrToInt(Copy(TmpStr, 1, 2));
        M := StrToInt(Copy(TmpStr, 3, 2));
        Y := StrToInt(Copy(TmpStr, 5, 4));
        ASerialKeyInfo.DateBegin := EncodeDate(Y, M, D);
      except
      end;

      try
        SetLength(TmpStr, 8);
        SetLength(TmpBytes, 0);
        SetLength(TmpBytes, 9);
        TmpStream2.Read(TmpBytes, 8);
        TmpStr := UTF8ToString(Utf8String(PAnsiChar(TmpBytes)));
        D := StrToInt(Copy(TmpStr, 1, 2));
        M := StrToInt(Copy(TmpStr, 3, 2));
        Y := StrToInt(Copy(TmpStr, 5, 4));
        ASerialKeyInfo.DateEnd := EncodeDate(Y, M, D);
      except
      end;

      try
        SetLength(TmpStr, 8);
        SetLength(TmpBytes, 0);
        SetLength(TmpBytes, 9);
        TmpStream2.Read(TmpBytes, 8);
        TmpStr := UTF8ToString(Utf8String(PAnsiChar(TmpBytes)));
        ASerialKeyInfo.LocalID := StrToInt(TmpStr);
      except
      end;
    end;

    if Assigned(AKeyDll) then
      AKeyDll.CopyFrom(TmpStream2, TmpStream2.Size - TmpStream2.Position);
  finally
    FreeAndNil(RC6Encryptor);
    FreeAndNil(TmpStream1);
    FreeAndNil(TmpStream2);
  end;
end;

function CheckLicenseFile(const AFileName: string; var ASI: TSerialKeyInfo;
  var ExceptFlag: Boolean): Boolean;
var LocalKey: TBytes;
    KeyDll: TMemoryStream;
    CheckKey: TCheckKey;
    pDll : pointer;
begin
  ExceptFlag := False;
  Result := False;
  KeyDll := TMemoryStream.Create;
  try
    try
      GetLocalData(ExtractFileDrive(ParamStr(0)), LocalKey);
     // showmessage(TEncoding.Default.GetString(LocalKey));
      GetLocalKey(LocalKey);

      GetSerialKeyInfo(AFileName, LocalKey, ASI, KeyDll);

      pDll := MemoryLoadLibary(KeyDll.Memory);
      try
        if pDll = nil then
          Abort;

        @CheckKey := MemoryGetProcAddress(pDll, 'CheckKey');
        if @CheckKey = nil then
          Abort;

        Result := CheckKey(ASI.DateBegin, ASI.DateEnd);
      finally
        if pDll <> nil then
           MemoryFreeLibrary(pDll);
      end;
    except
      on e: exception do
      begin
        ExceptFlag := True;
      end;
    end;
  finally
    FreeAndNil(KeyDll);
  end;
end;

function CheckCurLicense: Boolean;
var SI: TSerialKeyInfo;
    ExceptFlag: Boolean;
begin
  Result := CheckLicenseFile(G_CURLISENSE, SI, ExceptFlag);
end;

function LicenseAssigned(AValue: Pointer): Boolean;
var LocalKey: TBytes;
    KeyDll: TMemoryStream;
    SmAssigned: TSmAssigned;
    SI: TSerialKeyInfo;
    pDll : pointer;
begin
  Result := False;
  KeyDll := TMemoryStream.Create;
  try
    try
      GetLocalData(ExtractFileDrive(ParamStr(0)), LocalKey);
      GetLocalKey(LocalKey);

      GetSerialKeyInfo(G_CURLISENSE, LocalKey, SI, KeyDll);

      pDll := MemoryLoadLibary(KeyDll.Memory);
      try
        if pDll = nil then
          Abort;

        @SmAssigned := MemoryGetProcAddress(pDll, 'SmAssigned');
        if (@SmAssigned = nil) then
          Abort;

        Result := SmAssigned(AValue);
      finally
        if pDll <> nil then
           MemoryFreeLibrary(pDll);
      end;
    except
      on e: exception do
        raise Exception.Create('����������� ����������� �������� (' + e.Message + ')');
    end;
  finally
    FreeAndNil(KeyDll);
  end;
end;

end.
