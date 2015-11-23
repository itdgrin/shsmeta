unit SerialKeyModule;

interface
uses Winapi.Windows, System.SysUtils;

function GerLocalKey(const ADrive: string): TBytes;

implementation

const
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


//Получает номер физического диска по букве логического
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

//Не обрабатывает никаких исключений
function GetHDDSerialByNum(ANum: DWord; var ASerial, ARevision, AModel: string): DWord;
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
            ASerial := TEncoding.Default.GetString(TBytes(tmp)).Trim;

            SetLength(tmp, 8);
            Move(scop.bBuffer[47], tmp[1], 8);
            ARevision := TEncoding.Default.GetString(TBytes(tmp)).Trim;

            SetLength(tmp, 40);
            Move(scop.bBuffer[55], tmp[1], 40);
            AModel := TEncoding.Default.GetString(TBytes(tmp)).Trim;
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

function GerLocalKey(const ADrive: string): TBytes;
const LKeyLen = 64;
var Num: DWord;
    Serial,
    Revision,
    Model,
    TmpStr: string;
    I, TmpLen: Integer;
begin
  SetLength(Result, LKeyLen);
  Num := GetHDDNumberByLetter(ADrive);
  if GetHDDSerialByNum(Num, Serial, Revision, Model) = 0 then
    TmpStr := Serial + Revision + Model
  else
    TmpStr := IntToStr(GetDiskSerialNum(ADrive));

  TmpLen := Length(TmpStr) * SizeOf(Char);
  if TmpLen > LKeyLen then
    Move(TmpStr[1], Result[0], LKeyLen)
  else
  begin
    for I := 0 to LKeyLen div TmpLen - 1 do
      Move(TmpStr[1], Result[I * TmpLen], TmpLen);
    Move(TmpStr[1], Result[(LKeyLen div TmpLen) * TmpLen],
      LKeyLen - (LKeyLen div TmpLen) * TmpLen);
  end;
end;

end.
