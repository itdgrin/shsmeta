unit hwid_impl;

interface
uses Windows, SysUtils, System.AnsiStrings, winioctl;

const
  IDENTIFY_BUFFER_SIZE = 512;

  DFP_GET_VERSION = $00074080;
  DFP_SEND_DRIVE_COMMAND = $0007c084;
  DFP_RECEIVE_DRIVE_DATA = $0007c088;

  FILE_DEVICE_SCSI = $0000001b;
  IOCTL_SCSI_MINIPORT_IDENTIFY = ((FILE_DEVICE_SCSI shl 16) + $0501);
  IOCTL_SCSI_MINIPORT = $0004D008;  //  see NTDDSCSI.H for definition

//  Valid values for the bCommandReg member of IDEREGS.
const
  IDE_ATAPI_IDENTIFY = $A1;  //  Returns ID sector for ATAPI.
  IDE_ATA_IDENTIFY = $EC;  //  Returns ID sector for ATA.

//  Max number of drives assuming primary/secondary, master/slave topology
const MAX_IDE_DRIVES = 16;

type
//record for storing results (instead of printing on console)
  tresults_dv = record
    DriveModelNumber: AnsiString;
    DriveSerialNumber: AnsiString;
  end;

  tresults_array_dv = array of tresults_dv;

  type
{$Align 1}  //#pragma pack(1) //  Required to ensure correct PhysicalDrive IOCTL structure setup
  GETVERSIONINPARAMS = record
    bVersion: Byte;               // Binary driver version.
    bRevision: Byte;              // Binary driver revision.
    bReserved: Byte;              // Not used.
    bIDEDeviceMap: Byte;          // Bit map of IDE devices.
    fCapabilities: Cardinal;          // Bit mask of driver capabilities.
    dwReserved: array [0..3] of Cardinal;          // For future use.
  end;
{$Align On} //default value
  PGETVERSIONINPARAMS = ^GETVERSIONINPARAMS;
  LPGETVERSIONINPARAMS = ^GETVERSIONINPARAMS;

//  GETVERSIONOUTPARAMS contains the data returned from the
//  Get Driver Version function.
  GETVERSIONOUTPARAMS = record
   bVersion: Byte;// Binary driver version.
   bRevision: Byte;// Binary driver revision.
   bReserved: Byte;// Not used.
   bIDEDeviceMap: Byte;// Bit map of IDE devices.
   fCapabilities: Longword;// Bit mask of driver capabilities.
   dwReserved: array [0..3] of Longword;// For future use.
  end;
  PGETVERSIONOUTPARAMS = ^GETVERSIONOUTPARAMS;
  LPGETVERSIONOUTPARAMS = ^GETVERSIONOUTPARAMS;

type
   //  IDE registers
  IDEREGS = record
   bFeaturesReg: Byte;// Used for specifying SMART "commands".
   bSectorCountReg: Byte;// IDE sector count register
   bSectorNumberReg: Byte;// IDE sector number register
   bCylLowReg: Byte;// IDE low order cylinder value
   bCylHighReg: Byte;// IDE high order cylinder value
   bDriveHeadReg: Byte;// IDE drive/head register
   bCommandReg: Byte;// Actual IDE command.
   bReserved: Byte;// reserved for future use.  Must be zero.
  end;
  PIDEREGS = ^IDEREGS;
  LPIDEREGS = ^IDEREGS;


//  SENDCMDINPARAMS contains the input parameters for the
//  Send Command to Drive function.
{$ALIGN 1}
  SENDCMDINPARAMS = record
   cBufferSize: Longword;//  Buffer size in bytes
   irDriveRegs: IDEREGS;   //  Structure with drive register values.
   bDriveNumber: Byte;//  Physical drive number to send
                            //  command to (0,1,2,3).
   bReserved: array[0..2] of Byte;//  Reserved for future expansion.
   dwReserved: array [0..3] of Longword;//  For future use.
   bBuffer: array [0..0] of Byte;//  Input buffer.     //!TODO: this is array of single element
  end;
{$ALIGN on}
  PSENDCMDINPARAMS = ^SENDCMDINPARAMS;
  LPSENDCMDINPARAMS = ^SENDCMDINPARAMS;

{$ALIGN 1}
type
   // Status returned from driver
  DRIVERSTATUS = record
   bDriverError: Byte;//  Error code from driver, or 0 if no error.
   bIDEStatus: Byte;//  Contents of IDE Error register.
                        //  Only valid when bDriverError is SMART_IDE_ERROR.
   bReserved: array [0..1] of Byte;//  Reserved for future expansion.
   dwReserved: array [0..1] of Longword;//  Reserved for future expansion.
  end;
{$ALIGN on}
  PDRIVERSTATUS = ^DRIVERSTATUS;
  LPDRIVERSTATUS = ^DRIVERSTATUS;

   // Structure returned by PhysicalDrive IOCTL for several commands
{$ALIGN 1}
  SENDCMDOUTPARAMS = record
   cBufferSize: Longword;//  Size of bBuffer in bytes
   DriverStatus: DRIVERSTATUS;//  Driver status structure.
   bBuffer: array [0..0] of Byte;//  Buffer of arbitrary length in which to store the data read from the                                                       // drive.
  end;
{$ALIGN on}
  PSENDCMDOUTPARAMS = ^SENDCMDOUTPARAMS;
  LPSENDCMDOUTPARAMS = ^SENDCMDOUTPARAMS;

// The following struct defines the interesting part of the IDENTIFY
// buffer:
{$ALIGN 1}
  IDSECTOR = record
   wGenConfig: Word;
   wNumCyls: Word;
   wReserved: Word;
   wNumHeads: Word;
   wBytesPerTrack: Word;
   wBytesPerSector: Word;
   wSectorsPerTrack: Word;
   wVendorUnique: array [0..3-1] of Word;
   sSerialNumber: array [0..20-1] of AnsiChar;
   wBufferType: Word;
   wBufferSize: Word;
   wECCSize: Word;
   sFirmwareRev: array [0..8-1] of AnsiChar;
   sModelNumber: array [0..40-1] of AnsiChar;
   wMoreVendorUnique: Word;
   wDoubleWordIO: Word;
   wCapabilities: Word;
   wReserved1: Word;
   wPIOTiming: Word;
   wDMATiming: Word;
   wBS: Word;
   wNumCurrentCyls: Word;
   wNumCurrentHeads: Word;
   wNumCurrentSectorsPerTrack: Word;
   ulCurrentSectorCapacity: Cardinal;
   wMultSectorStuff: Word;
   ulTotalAddressableSectors: Cardinal;
   wSingleWordDMA: Word;
   wMultiWordDMA: Word;
   bReserved: array [0..128-1] of Byte;
  end;
{$ALIGN on}
  PIDSECTOR = ^IDSECTOR;

  SRB_IO_CONTROL = record
   HeaderLength: Cardinal;
   Signature: array [0..8-1] of Byte;
   Timeout: Cardinal;
   ControlCode: Cardinal;
   ReturnCode: Cardinal;
   Length: Cardinal;
  end;
  PSRB_IO_CONTROL = ^SRB_IO_CONTROL;

type tdiskdata_dv = array [0..256-1] of DWORD;

///begin dv auxilary declarations
type
  tarray_of_words256_dv = array [0..256-1] of WORD;
  parray_of_words256_dv = ^tarray_of_words256_dv;
///end dv auxilary declarations
//
// IDENTIFY data (from ATAPI driver source)
//
{$ALIGN 1}//pragma pack(1)
type IDENTIFY_DATA = record
    GeneralConfiguration: Word;             // 00 00
    NumberOfCylinders: Word;                // 02  1
    Reserved1: Word;                        // 04  2
    NumberOfHeads: Word;                    // 06  3
    UnformattedBytesPerTrack: Word;         // 08  4
    UnformattedBytesPerSector: Word;        // 0A  5
    SectorsPerTrack: Word;                  // 0C  6
    VendorUnique1: array [0..3-1] of Word;                 // 0E  7-9
    SerialNumber: array [0..10-1] of Word;                 // 14  10-19
    BufferType: Word;                       // 28  20
    BufferSectorSize: Word;                 // 2A  21
    NumberOfEccBytes: Word;                 // 2C  22
    FirmwareRevision: array [0..4-1] of  Word;              // 2E  23-26
    ModelNumber: array [0..20-1] of  Word;                  // 36  27-46
    MaximumBlockTransfer: Byte;             // 5E  47
    VendorUnique2: Byte;                    // 5F
    DoubleWordIo: Word;                     // 60  48
    Capabilities: Word;                     // 62  49
    Reserved2: Word;                        // 64  50
    VendorUnique3: Byte;                    // 66  51
    PioCycleTimingMode: Byte;               // 67
    VendorUnique4: Byte;                    // 68  52
    DmaCycleTimingMode: Byte;               // 69

// Delhpi has no bit fields. Fortunately, we don't need this
// record memebers in our application. So, we can simplify declaration of the record.

//    USHORT TranslationFieldsValid:1;        // 6A  53
//    USHORT Reserved3:15;
    TranslationFieldsValid: Word;         // 6A  53 //Reserved3 is in the last 15 bits.

    NumberOfCurrentCylinders: Word;         // 6C  54
    NumberOfCurrentHeads: Word;             // 6E  55
    CurrentSectorsPerTrack: Word;           // 70  56
    CurrentSectorCapacity: Cardinal;            // 72  57-58
    CurrentMultiSectorSetting: Word;        //     59
    UserAddressableSectors: Cardinal;           //     60-61

//USHORT SingleWordDMASupport : 8;        //     62
//USHORT SingleWordDMAActive : 8;
//USHORT MultiWordDMASupport : 8;         //     63
//USHORT MultiWordDMAActive : 8;
//USHORT AdvancedPIOModes : 8;            //     64
//USHORT Reserved4 : 8;
    SingleWordDMASupport: Word;        //     62 //SingleWordDMAActive is in the second byte
    MultiWordDMASupport: Word;         //     63 //MultiWordDMAActive is in the second byte
    AdvancedPIOModes: Word;            //     64 //Reserved4 is in the second byte

    MinimumMWXferCycleTime: Word;           //     65
    RecommendedMWXferCycleTime: Word;       //     66
    MinimumPIOCycleTime: Word;              //     67
    MinimumPIOCycleTimeIORDY: Word;         //     68
    Reserved5: array [0..2-1] of  Word;                     //     69-70
    ReleaseTimeOverlapped: Word;            //     71
    ReleaseTimeServiceCommand: Word;        //     72
    MajorRevision: Word;                    //     73
    MinorRevision: Word;                    //     74
    Reserved6: array [0..50-1] of  Word;                    //     75-126
    SpecialFunctionsEnabled: Word;          //     127
    Reserved7: array [0..128-1] of  Word;                   //     128-255
end;
PIDENTIFY_DATA = ^IDENTIFY_DATA;

{$ALIGN on}//#pragma pack()
//  Required to ensure correct PhysicalDrive IOCTL structure setup
{$ALIGN 4}
type
  {$Z4} //size of each enumeration type should be equal 4
  STORAGE_QUERY_TYPE = (
      PropertyStandardQuery = 0,          // Retrieves the descriptor
      PropertyExistsQuery,                // Used to test whether the descriptor is supported
      PropertyMaskQuery,                  // Used to retrieve a mask of writeable fields in the descriptor
      PropertyQueryMaxDefined     // use to validate the value
  );
  {$Z1}

  //
  // define some initial property id's
  //
  {$Z4} //size of each enumeration type should be equal 4
  STORAGE_PROPERTY_ID = (StorageDeviceProperty = 0, StorageAdapterProperty);
  {$Z1}
  //
  // Query structure - additional parameters for specific queries can follow
  // the header
  //
type
	STORAGE_PROPERTY_QUERY = record
    //
    // ID of the property being retrieved
    //
    PropertyId: STORAGE_PROPERTY_ID;
    //
    // Flags indicating the type of query being performed
    //
    QueryType: STORAGE_QUERY_TYPE;
    //
    // Space for additional parameters if necessary
    //
    AdditionalParameters: array [0..1-1] of UCHAR;
  end;

{$ALIGN on}
  PSTORAGE_PROPERTY_QUERY = ^STORAGE_PROPERTY_QUERY;

{$ALIGN 4}
type
  STORAGE_DEVICE_DESCRIPTOR = record
    // Sizeof(STORAGE_DEVICE_DESCRIPTOR)
    Version: Cardinal;
    // Total size of the descriptor, including the space for additional
    // data and id strings
    Size: Cardinal;
    // The SCSI-2 device type
    DeviceType: Byte;
    // The SCSI-2 device type modifier (if any) - this may be zero
    DeviceTypeModifier: Byte;
    // Flag indicating whether the device's media (if any) is removable.  This
    // field should be ignored for media-less devices
    RemovableMedia: Byte;
    // Flag indicating whether the device can support mulitple outstanding
    // commands.  The actual synchronization in this case is the responsibility
    // of the port driver.
    CommandQueueing: Byte;
    // Byte offset to the zero-terminated ascii string containing the device's
    // vendor id string.  For devices with no such ID this will be zero
    VendorIdOffset: Cardinal;
    // Byte offset to the zero-terminated ascii string containing the device's
    // product id string.  For devices with no such ID this will be zero
    ProductIdOffset: Cardinal;
    // Byte offset to the zero-terminated ascii string containing the device's
    // product revision string.  For devices with no such string this will be
    // zero
    ProductRevisionOffset: Cardinal;
    // Byte offset to the zero-terminated ascii string containing the device's
    // serial number.  For devices with no serial number this will be zero
    SerialNumberOffset: Cardinal;
    // Contains the bus type (as defined above) of the device.  It should be
    // used to interpret the raw device properties at the end of this structure
    // (if any)
    BusType: STORAGE_BUS_TYPE;
    // The number of bytes of bus-specific data which have been appended to
    // this descriptor
    RawPropertiesLength: Cardinal;
    // Place holder for the first byte of the bus specific property data
    RawDeviceProperties: array [0..1-1] of Byte;
  end;
  PSTORAGE_DEVICE_DESCRIPTOR = ^STORAGE_DEVICE_DESCRIPTOR;
{$ALIGN on}

type
  DISK_GEOMETRY_EX = record
    Geometry: DISK_GEOMETRY;
    DiskSize: Int64; //LARGE_INTEGER
    Data: array [0..1-1] of Byte;
  end;
  PDISK_GEOMETRY_EX = ^DISK_GEOMETRY_EX;

const SENDIDLENGTH = sizeof(SENDCMDOUTPARAMS) + IDENTIFY_BUFFER_SIZE;

var
  SMART_GET_VERSION: Integer;
  SMART_RCV_DRIVE_DATA: Integer;
  IOCTL_STORAGE_QUERY_PROPERTY: Integer; //initialization in initialize-section

function ConvertToString(diskdata: tdiskdata_dv; firstIndex: Integer;
	lastIndex: Integer; buf: PAnsiChar): PAnsiChar;
function PrintIdeInfo(drive: Integer; diskdata: tdiskdata_dv): tresults_dv;
function flipAndCodeBytes(str: PAnsiChar; pos: Integer;
  flip: Integer; buf: PAnsiChar): AnsiString;

function GetHardDriveComputerID(var Dest: tresults_array_dv): Boolean; inline;

function ReadIdeDriveAsScsiDriveInNT(var Dest: tresults_array_dv): Boolean; inline;
function ReadPhysicalDriveInNTWithZeroRights(var Dest: tresults_array_dv): Boolean; inline;
function ReadPhysicalDriveInNTUsingSmart(var Dest: tresults_array_dv): Boolean; inline;

implementation

function ReadPhysicalDriveInNTUsingSmart (var Dest: tresults_array_dv): Boolean;
var
  drive: Integer;
  hPhysicalDriveIOCTL: THandle;
  driveName: array [0..256-1] of char;

  GetVersionParams: GETVERSIONINPARAMS;
  cbBytesReturned: Cardinal;

  CommandSize: ULONG;
  Command: PSENDCMDINPARAMS;

  BytesReturned: Cardinal;

  diskdata: tdiskdata_dv;
  ijk: Integer;
  pIdSector: PWord;

  count_drives_dv: Integer;
const
  ID_CMD = $EC; // Returns ID sector for ATA

begin
  SetLength(Dest, MAX_IDE_DRIVES - 1);
  count_drives_dv := 0;
  for drive := 0 to MAX_IDE_DRIVES-1 do
  begin
    StrCopy(driveName, PChar(Format('\\.\PhysicalDrive%d', [drive])));
    //  Windows NT, Windows 2000, Windows Server 2003, Vista
    hPhysicalDriveIOCTL :=
      CreateFile(driveName, GENERIC_READ or GENERIC_WRITE,
       FILE_SHARE_DELETE or FILE_SHARE_READ or FILE_SHARE_WRITE,
       nil, OPEN_EXISTING, 0, 0);

    if not (hPhysicalDriveIOCTL = INVALID_HANDLE_VALUE) then
    begin
      try
        cbBytesReturned := 0;
        // Get the version, etc of PhysicalDrive IOCTL
        FillChar(GetVersionParams, sizeof(GetVersionParams), 0);

        if DeviceIoControl(hPhysicalDriveIOCTL, SMART_GET_VERSION, nil, 0,
            @GetVersionParams, sizeof (GETVERSIONINPARAMS),
            cbBytesReturned, nil) then
        begin
          CommandSize := sizeof(SENDCMDINPARAMS) + IDENTIFY_BUFFER_SIZE;
          GetMem(PSENDCMDINPARAMS(Command), CommandSize);
          try
            // Returns ID sector for ATA
            Command^.irDriveRegs.bCommandReg := ID_CMD;
            BytesReturned := 0;
            if DeviceIoControl(hPhysicalDriveIOCTL, SMART_RCV_DRIVE_DATA,
              Command, sizeof(SENDCMDINPARAMS),
              Command, CommandSize, BytesReturned, nil) then
            begin
              pIdSector := PWord(PIDENTIFY_DATA(@PSENDCMDOUTPARAMS(Command)^.bBuffer[0])); //!TOCHECK

              for ijk := 0 to 256-1 do
              begin
                diskdata[ijk] := parray_of_words256_dv(pIdSector)[ijk];
              end;

              Dest[count_drives_dv] := PrintIdeInfo(drive, diskdata);
              inc(count_drives_dv);
            end;
          finally
            FreeMem(Command, CommandSize);
          end;
       end
    finally
      CloseHandle(hPhysicalDriveIOCTL); //dv: fix 20120115:
    end;
   end
  end;

  SetLength(Dest, count_drives_dv);
  Result := count_drives_dv > 0;
end;

function flipAndCodeBytes(str: PAnsiChar; pos: Integer; flip: Integer;
  buf: PAnsiChar): AnsiString;
var i, j, k: Integer;
    p: Integer;
    c: AnsiChar;
    t: AnsiChar;
begin
   j := 0;
   k := 0;

   buf [0] := #$00;
   if (pos <= 0) then
   begin
      Result := buf;
      exit;
   end;

   if (j = 0) then
   begin
      p := 0;
      // First try to gather all characters representing hex digits only.
      j := 1;
      k := 0;
      buf[k] := #$00;
      i := pos;
      while (j <> 0) and (str[i] <> #$00) do
      begin
        c := ansichar(tolower(ord(str[i])));

    	  if (isspaceB(ord(c))) then c := #$00;

    	  inc(p);
    	  buf[k] :=  AnsiChar(Chr(Ord(buf[k]) shl 4));

        if ((c >= '0') and (c <= '9')) then
          buf[k] := AnsiChar(Chr(Ord(buf[k]) or Byte(Ord(c) - Ord('0'))))
        else
        if ((c >= 'a') and (c <= 'f')) then
          buf[k] := AnsiChar(Chr(Ord(buf[k]) or Byte(Ord(c) - Ord('a') + 10)))
        else
        begin
          j := 0;
          break;
        end;

	      if (p = 2) then
        begin
    	    if ((buf[k] <> #$00) and (not isprintB(ord(buf[k])))) then
          begin
    	       j := 0;
	           break;
    	    end;
	        inc(k);
  	      p := 0;
	        buf[k] := #$00;
  	    end;
        inc(i);
      end;
   end;

   if (j = 0) then
   begin
      // There are non-digit characters, gather them as is.
      j := 1;
      k := 0;
      i := pos;
      while ( (j <> 0) and (str[i] <> #$00) ) do
      begin
        c := str[i];
	      if ( not isprintB(ord(c))) then
        begin
	        j := 0;
	        break;
	      end;
	      buf[(k)] := c;
        inc(k);
        inc(i);
      end;
   end;

   if (j = 0) then
   begin
      // The characters are not there or are not printable.
      k := 0;
   end;

   buf[k] := #$00;

   if (flip <> 0) then
   begin
      // Flip adjacent characters
      j := 0;
      while (j < k) do
      begin
        t := buf[j];
	      buf[j] := buf[j + 1];
	      buf[j + 1] := t;
        j := j + 2;
      end
   end;

   // Trim any beginning and end space
   i := -1;
   j := -1;
   k := 0;
   while (buf[k] <> #$00) do
   begin
      if (not isspaceB(ord(buf[k]))) then
      begin
        if (i < 0) then i := k;
	      j := k;
      end;
      inc(k);
   end;

   if ((i >= 0) and (j >= 0)) then
   begin
      k := i;
      while (( k <= j) and (buf[k] <> #$00)) do
      begin
         buf[k - i] := buf[k];
         inc(k);
      end;
      buf[k - i] := #$00;
   end;

   Result := buf;
end;

function ReadPhysicalDriveInNTWithZeroRights(var Dest: tresults_array_dv): Boolean;
var
  drive: Integer;
  hPhysicalDriveIOCTL: THandle;
  driveName: array [0..256-1] of Char;

	query: STORAGE_PROPERTY_QUERY;
  cbBytesReturned: Cardinal;
  buffer: array [0..10000-1] of AnsiChar;
  serialNumber: array [0..10000-1] of AnsiChar;
	modelNumber: array [0..10000-1] of AnsiChar;

  descrip: PSTORAGE_DEVICE_DESCRIPTOR;
  count_drives_dv: Integer;
begin
   SetLength(Dest, MAX_IDE_DRIVES-1);
   count_drives_dv := 0;
  for drive := 0 to MAX_IDE_DRIVES-1 do
  begin
    StrCopy(driveName, PChar(Format('\\.\PhysicalDrive%d', [drive])));
    //  Windows NT, Windows 2000, Windows XP - admin rights not required
    hPhysicalDriveIOCTL :=
      CreateFile(driveName, 0, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
        OPEN_EXISTING, 0, 0);
    if not(hPhysicalDriveIOCTL = INVALID_HANDLE_VALUE) then
    begin
		  //-STORAGE_PROPERTY_QUERY query;
      cbBytesReturned := 0;

      FillChar(query, sizeof(query), 0);
      query.PropertyId := StorageDeviceProperty;
		  query.QueryType := PropertyStandardQuery;

      FillChar(buffer, sizeof(buffer), 0);
      FillChar(modelNumber, sizeof(modelNumber), 0);
      FillChar(serialNumber, sizeof(serialNumber), 0);

      if DeviceIoControl(hPhysicalDriveIOCTL, IOCTL_STORAGE_QUERY_PROPERTY,
        @query, sizeof(query),
				@buffer, sizeof(buffer), cbBytesReturned, nil) then
      begin
			  descrip := PSTORAGE_DEVICE_DESCRIPTOR(@buffer);

        flipAndCodeBytes(buffer, descrip^.ProductIdOffset, 0, modelNumber);
        flipAndCodeBytes(buffer, descrip^.SerialNumberOffset, 1, serialNumber);

        //  serial number must be alphanumeric
        //  (but there can be leading spaces on IBM drives)
				if ((isalnumB(ord(serialNumber[0])) or isalnumB(ord(serialNumber[19])))) then
        begin
          Dest[count_drives_dv].DriveModelNumber := Trim(modelNumber);
          Dest[count_drives_dv].DriveSerialNumber := Trim(serialNumber);
          inc(count_drives_dv);
			  end;
      end;
      CloseHandle(hPhysicalDriveIOCTL);
    end;
  end;

  SetLength(Dest, count_drives_dv);
  Result := count_drives_dv > 0;
end;

function ReadIdeDriveAsScsiDriveInNT(var Dest: tresults_array_dv): Boolean;
var
  controller: Integer;
  hScsiDriveIOCTL: THandle;
  driveName: array [0..256-1] of char;

  drive: Integer;

  buffer: array [0..sizeof (SRB_IO_CONTROL) + SENDIDLENGTH - 1] of AnsiChar;
  p: PSRB_IO_CONTROL;
  pin: PSENDCMDINPARAMS;
  dummy: DWORD;

  pOut: PSENDCMDOUTPARAMS;
  pId: PIDSECTOR;
  diskdata: tdiskdata_dv;
  ijk: Integer;
  pIdSectorPtr: PWord;

  count_drives_dv: Integer;
begin
  SetLength(Dest, 16-1);
  count_drives_dv := 0;
  for controller := 0 to 16-1 do
  begin
    StrCopy(driveName, PChar(Format('\\.\Scsi%d:', [controller])));
    // Windows NT, Windows 2000, any rights should do
    hScsiDriveIOCTL :=
      CreateFile(driveName, GENERIC_READ or GENERIC_WRITE,
        FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);

    if (hScsiDriveIOCTL <> INVALID_HANDLE_VALUE) then
    begin
      for drive := 0 to 2-1 do
      begin
        p := PSRB_IO_CONTROL(@buffer);
        pin := PSENDCMDINPARAMS(buffer + sizeof (SRB_IO_CONTROL));

        FillChar(buffer, sizeof(buffer), 0);
        p^.HeaderLength := sizeof (SRB_IO_CONTROL);
        p^.Timeout := 10000;
        p^.Length := SENDIDLENGTH;
        p^.ControlCode := IOCTL_SCSI_MINIPORT_IDENTIFY;
        Move(AnsiString('SCSIDISK'), p^.Signature, 8);

        pin^.irDriveRegs.bCommandReg := IDE_ATA_IDENTIFY;
        pin^.bDriveNumber := drive;

        if DeviceIoControl(hScsiDriveIOCTL, IOCTL_SCSI_MINIPORT,
              @buffer, sizeof(SRB_IO_CONTROL) + sizeof(SENDCMDINPARAMS) - 1,
              @buffer, sizeof(SRB_IO_CONTROL) + SENDIDLENGTH, dummy, nil) then
        begin
           pOut := PSENDCMDOUTPARAMS(buffer + sizeof (SRB_IO_CONTROL)); //!TOCHECK
           pId := PIDSECTOR(@pOut^.bBuffer[0]);
           if (pId^.sModelNumber[0] <> #$00 ) then
           begin
              pIdSectorPtr := PWord(pId);

              for ijk := 0 to 256-1 do
              begin
                 diskdata[ijk] := parray_of_words256_dv(pIdSectorPtr)[ijk];
              end;

              Dest[count_drives_dv] := PrintIdeInfo(controller * 2 + drive, diskdata);
              inc(count_drives_dv);
           end;
        end;
      end;
      CloseHandle(hScsiDriveIOCTL);
    end;
  end;

  SetLength(Dest, count_drives_dv);
  Result := count_drives_dv > 0;
end;

function PrintIdeInfo(drive: Integer; diskdata: tdiskdata_dv): tresults_dv;
var
   serialNumber: array [0..1024-1] of AnsiChar;
   modelNumber: array [0..1024-1] of AnsiChar;
begin
   FillChar(serialNumber, SizeOf(serialNumber), 0);
   FillChar(modelNumber, SizeOf(modelNumber), 0);
   //  copy the hard drive serial number to the buffer
   ConvertToString(diskdata, 10, 19, @serialNumber);
   ConvertToString(diskdata, 27, 46, @modelNumber);

   Result.DriveModelNumber :=  Trim(modelNumber);
   Result.DriveSerialNumber := Trim(serialNumber);
end;

function ConvertToString(diskdata: tdiskdata_dv; firstIndex: Integer;
		       lastIndex: Integer; buf: PAnsiChar): PAnsiChar;
var index: Integer;
    position: Integer;
begin
   position := 0;
   //  each integer has two characters stored in it backwards
   for index := firstIndex to lastIndex do
   begin
      //  get high byte for 1st character
      buf[position] := AnsiChar(Chr(diskdata[index] div 256));
      inc(position);

      //  get low byte for 2nd character
      buf[position] := AnsiChar(Chr(diskdata[index] mod 256));
      inc(position);
   end;
   //  end the string
   buf[position] := #$00;
   //  cut off the trailing blanks
   index := position - 1;
   while (index >0) do
   begin
      if not isspaceB(ord(buf[index])) then
        break;
      buf[index] := #$00;
      dec(index);
   end;
   Result := buf;
end;

function getHardDriveComputerID(var Dest: tresults_array_dv): Boolean;
begin
  Result := ReadPhysicalDriveInNTWithZeroRights(Dest);
  if not Result then
    Result := ReadPhysicalDriveInNTUsingSmart(Dest);
  if not Result then
    Result := ReadIdeDriveAsScsiDriveInNT(Dest);
end;

initialization
  SMART_GET_VERSION := CTL_CODE(IOCTL_DISK_BASE, $0020, METHOD_BUFFERED, FILE_READ_ACCESS);
  SMART_RCV_DRIVE_DATA := CTL_CODE(IOCTL_DISK_BASE, $0022, METHOD_BUFFERED, FILE_READ_ACCESS or FILE_WRITE_ACCESS);

  IOCTL_STORAGE_QUERY_PROPERTY := CTL_CODE(IOCTL_STORAGE_BASE, $0500, METHOD_BUFFERED, FILE_ANY_ACCESS);
end.
