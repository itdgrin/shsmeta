unit SerialKeyModule;

interface
uses Winapi.Windows, System.SysUtils, System.AnsiStrings, System.Classes, RC6;

const

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
  //��������� ��� �������� ������������ ����������
  TSerialKeyInfo = record
    UserName: string;
    UserKey: TBytes;
    DataBegin: TDateTime;
    DateEnd: TDateTime;
    SerialNumber: String;
  end;

  TSerialKeyData = TBytes;

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

//���������� ��������� ������ ��� �������� �� ������ ��� ��������� ���������� �����
procedure GetLocalData(const ADrive: string; var AData: TBytes);
procedure GetLocalDataFile(const ASerialKey: string; const AData: TBytes;
  AStream: TStream);
//��������� ���������� �����
procedure GetLocalKey(var AKey: TBytes);
//��������� ������ HDD �� ����� �����
function GetHDDNumberByLetter(const ADrive: string): DWord;
//��������� ��������� HDD !!! �� �������� ��� ���� ������
function GetHDDSerialByNum(ANum: DWord;
  var ASerial, ARevision, AModel: AnsiString): DWord;
procedure CorrectDevInfo(var _params: TSendCmdOutParams);
//�������� �������� ����������� �����
function GetDiskSerialNum(const ADrive: string): DWord;


implementation

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
function GetHDDNumberByLetter(const ADrive: string): DWord;
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
  Result := 1000;
  hDevice := CreateFile(PChar('\\.\' + ADrive),
    GENERIC_READ or GENERIC_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
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

function GetDiskSerialNum(const ADrive: string): DWord;
var
  sz,fs: DWord;
begin
 GetVolumeInformation(PChar(ADrive), nil, 0, @Result, sz, fs, nil, 0);
end;

procedure GetLocalData(const ADrive: string; var AData: TBytes);
const LKeyLen = 16;
var //Num: DWord;
    //Serial,
   // Revision,
   // Model,
    TmpBytes: TBytes;
    I, TmpLen: Integer;
begin
  SetLength(AData, LKeyLen);
  FillChar(AData[0], LKeyLen, 0);

  //Num := GetHDDNumberByLetter(ADrive);
  //if GetHDDSerialByNum(Num, Serial, Revision, Model) = 0 then
  // TmpStr := Serial + Revision + Model
  //else
  TmpBytes := TEncoding.Default.GetBytes(IntToStr(GetDiskSerialNum(ADrive)));

  TmpLen := Length(TmpBytes);
  if TmpLen >= LKeyLen then
    Move(TmpBytes[0], AData[0], LKeyLen)
  else
  begin
    for I := 0 to LKeyLen div TmpLen - 1 do
      Move(TmpBytes[0], AData[I * TmpLen], TmpLen);
    Move(TmpBytes[0], AData[(LKeyLen div TmpLen) * TmpLen],
      LKeyLen - (LKeyLen div TmpLen) * TmpLen);
  end;

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
      FKeyLen = 16;
var TmpBytes: TBytes;
    I, J: Integer;
    RC6Encryptor: TRC6Encryptor;
begin
  if Length(ASerialKey) <> FKeyLen then
    raise Exception.Create('Serial key is not correct.');

  SetLength(TmpBytes, FKeyLen + FLen);

  Randomize;
  for I := Low(TmpBytes) to High(TmpBytes) do
    TmpBytes[I] := Byte(Random(256));

  J := TmpBytes[0];
  if J = 0 then
    J := 1;
  if J + Length(AData) > FLen - 1 then
    J := FLen - Length(AData) - 1;

  Move(AData[0], TmpBytes[J], Length(AData));
  Move(TEncoding.ASCII.GetBytes(ASerialKey)[0], TmpBytes[FLen], FKeyLen);

  RC6Encryptor := TRC6Encryptor.Create(ConstKey);
  try
    TmpBytes := RC6Encryptor.BytesEncrypt(TmpBytes);
    TmpBytes := RC6Encryptor.BytesDecrypt(TmpBytes);
  finally
    FreeAndNil(RC6Encryptor);
  end;

  AStream.Write(TmpBytes, Length(TmpBytes));
end;

end.