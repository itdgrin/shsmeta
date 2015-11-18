{
**************************************************
* A binary compatible RC6 implementation          *
* written by Dave Barton (davebarton@bigfoot.com) *
***************************************************
* 128bit block encryption                         *
* Variable size key - up to 2048bit               *
***************************************************
}
unit RC6;

interface
uses
  Sysutils, System.Classes;

const
  NUMROUNDS = 20; { number of rounds must be between 16-24 }
type
  {$IFDEF VER120}
    dword= longword;
  {$ELSE}
    dword= longint;
  {$ENDIF}

  TRC6Data= record
    InitBlock: array[0..15] of byte;    { initial IV }
    LastBlock: array[0..15] of byte;    { current IV }
    KeyD: array[0..((NUMROUNDS*2)+3)] of DWord;
  end;

  TRC6Encryptor = class(TObject)
  private
    FData: TRC6Data;
    FKey: array of byte;
  public
    constructor Create(AKey: array of byte);
    destructor Destroy; override;
    procedure StreamEncrypt(AStreamIn, AStreamOut: TMemoryStream);
    procedure StreamDecrypt(AStreamIn, AStreamOut: TMemoryStream);

    function StrEncrypt(const AStr: string): string;
    function StrDecrypt(const AStr: string): string;
  end;

  function LRot16(X: word; c: integer): word; assembler;
  function RRot16(X: word; c: integer): word; assembler;
  function LRot32(X: dword; c: integer): dword; assembler;
  function RRot32(X: dword; c: integer): dword; assembler;
  procedure XorBlock(I1, I2, O1: PByteArray; Len: integer);
  procedure IncBlock(P: PByteArray; Len: integer);

  function RC6SelfTest: boolean;
    { performs a self test on this implementation }
  procedure RC6Init(var Data: TRC6Data; Key: pointer; Len: integer; IV: pointer);
    { initializes the TRC6Data structure with the key information and IV if applicable }
  procedure RC6Burn(var Data: TRC6Data);
    { erases all information about the key }

  procedure RC6EncryptECB(var Data: TRC6Data; InData, OutData: pointer);
    { encrypts the data in a 128bit block using the ECB mode }
  procedure RC6EncryptCBC(var Data: TRC6Data; InData, OutData: pointer);
    { encrypts the data in a 128bit block using the CBC chaining mode }
  procedure RC6EncryptOFB(var Data: TRC6Data; InData, OutData: pointer);
    { encrypts the data in a 128bit block using the OFB chaining mode }
  procedure RC6EncryptCFB(var Data: TRC6Data; InData, OutData: pointer; Len: integer);
    { encrypts Len bytes of data using the CFB chaining mode }
  procedure RC6EncryptOFBC(var Data: TRC6Data; InData, OutData: pointer; Len: integer);
    { encrypts Len bytes of data using the OFB counter chaining mode }

  procedure RC6DecryptECB(var Data: TRC6Data; InData, OutData: pointer);
    { decrypts the data in a 128bit block using the ECB mode }
  procedure RC6DecryptCBC(var Data: TRC6Data; InData, OutData: pointer);
    { decrypts the data in a 128bit block using the CBC chaining mode }
  procedure RC6DecryptOFB(var Data: TRC6Data; InData, OutData: pointer);
    { decrypts the data in a 128bit block using the OFB chaining mode }
  procedure RC6DecryptCFB(var Data: TRC6Data; InData, OutData: pointer; Len: integer);
    { decrypts Len bytes of data using the CFB chaining mode }
  procedure RC6DecryptOFBC(var Data: TRC6Data; InData, OutData: pointer; Len: integer);
    { decrypts Len bytes of data using the OFB counter chaining mode }

  procedure RC6Reset(var Data: TRC6Data);
    { resets the chaining mode information }

{******************************************************************************}
implementation

const
  sBox: array[0..51] of DWord= (
    $B7E15163,$5618CB1C,$F45044D5,$9287BE8E,$30BF3847,$CEF6B200,
    $6D2E2BB9,$0B65A572,$A99D1F2B,$47D498E4,$E60C129D,$84438C56,
    $227B060F,$C0B27FC8,$5EE9F981,$FD21733A,$9B58ECF3,$399066AC,
    $D7C7E065,$75FF5A1E,$1436D3D7,$B26E4D90,$50A5C749,$EEDD4102,
    $8D14BABB,$2B4C3474,$C983AE2D,$67BB27E6,$05F2A19F,$A42A1B58,
    $42619511,$E0990ECA,$7ED08883,$1D08023C,$BB3F7BF5,$5976F5AE,
    $F7AE6F67,$95E5E920,$341D62D9,$D254DC92,$708C564B,$0EC3D004,
    $ACFB49BD,$4B32C376,$E96A3D2F,$87A1B6E8,$25D930A1,$C410AA5A,
    $62482413,$007F9DCC,$9EB71785,$3CEE913E);

function LRot16(X: word; c: integer): word; assembler;
asm
  mov ecx,&c
  mov ax,&X
  rol ax,cl
  mov &Result,ax
end;

function RRot16(X: word; c: integer): word; assembler;
asm
  mov ecx,&c
  mov ax,&X
  ror ax,cl
  mov &Result,ax
end;

function LRot32(X: dword; c: integer): dword; assembler;
asm
  mov ecx,&c
  mov eax,&X
  rol eax,cl
  mov &Result,eax
end;

function RRot32(X: dword; c: integer): dword; assembler;
asm
  mov ecx,&c
  mov eax,&X
  ror eax,cl
  mov &Result,eax
end;

procedure XorBlock(I1, I2, O1: PByteArray; Len: integer);
var
  i: integer;
begin
  for i:= 0 to Len-1 do
    O1[i]:= I1[i] xor I2[i];
end;

procedure IncBlock(P: PByteArray; Len: integer);
begin
  Inc(P[Len-1]);
  if (P[Len-1]= 0) and (Len> 1) then
    IncBlock(P,Len-1);
end;

function RC6SelfTest;
const
  Key: array[0..15] of byte=
    ($01,$23,$45,$67,$89,$ab,$cd,$ef,$01,$12,$23,$34,$45,$56,$67,$78);
  InBlock: array[0..15] of byte=
    ($02,$13,$24,$35,$46,$57,$68,$79,$8a,$9b,$ac,$bd,$ce,$df,$e0,$f1);
  OutBlock: array[0..15] of byte=
    ($52,$4e,$19,$2f,$47,$15,$c6,$23,$1f,$51,$f6,$36,$7e,$a4,$3f,$18);
var
  Block: array[0..15] of byte;
  Data: TRC6Data;
begin
  RC6Init(Data,@Key,Sizeof(Key),nil);
  RC6EncryptECB(Data,@InBlock,@Block);
  Result:= CompareMem(@Block,@OutBlock,Sizeof(Block)) or not (NUMROUNDS=20);
  RC6DecryptECB(Data,@Block,@Block);
  Result:= Result and CompareMem(@Block,@InBlock,Sizeof(Block));
  RC6Burn(Data);
end;

procedure RC6Init;
var
  xKeyD: array[0..63] of DWord;
  i, j, k, xKeyLen: integer;
  A, B: DWord;
begin
  if (Len<= 0) or (Len> 256) then
    raise Exception.Create('RC6: Key length must be between 1 and 256 bytes');
  with Data do
  begin
    if IV= nil then
    begin
      FillChar(InitBlock,16,0);
      FillChar(LastBlock,16,0);
    end
    else
    begin
      Move(IV^,InitBlock,16);
      Move(IV^,LastBlock,16);
    end;
    FillChar(xKeyD,Sizeof(xKeyD),0);
    Move(Key^,xKeyD,Len);
    xKeyLen:= Len div 4;
    if (Len mod 4)<> 0 then
      Inc(xKeyLen);
    Move(sBox,KeyD,((NUMROUNDS*2)+4)*4);
    i:= 0; j:= 0;
    A:= 0; B:= 0;
    if xKeyLen> ((NUMROUNDS*2)+4) then
      k:= xKeyLen*3
    else
      k:= ((NUMROUNDS*2)+4)*3;
    for k:= 1 to k do
    begin
      A:= LRot32(KeyD[i]+A+B,3);
      KeyD[i]:= A;
      B:= LRot32(xKeyD[j]+A+B,A+B);
      xKeyD[j]:= B;
      i:= (i+1) mod ((NUMROUNDS*2)+4);
      j:= (j+1) mod xKeyLen;
    end;
    FillChar(xKeyD,Sizeof(xKeyD),0);
  end;
end;

procedure RC6Burn;
begin
  FillChar(Data,Sizeof(Data),0);
end;

procedure RC6EncryptECB;
var
  A, B, C, D, t, u: DWord;
  i: integer;
begin
  Move(InData^,A,4);
  Move(pointer(integer(InData)+4)^,B,4);
  Move(pointer(integer(InData)+8)^,C,4);
  Move(pointer(integer(InData)+12)^,D,4);
  B:= B + Data.KeyD[0];
  D:= D + Data.KeyD[1];
  for i:= 1 to NUMROUNDS do
  begin
    t:= Lrot32(B * (2*B + 1),5);
    u:= Lrot32(D * (2*D + 1),5);
    A:= Lrot32(A xor t,u) + Data.KeyD[2*i];
    C:= Lrot32(C xor u,t) + Data.KeyD[2*i+1];
    t:= A; A:= B; B:= C; C:= D; D:= t;
  end;
  A:= A + Data.KeyD[(2*NUMROUNDS)+2];
  C:= C + Data.KeyD[(2*NUMROUNDS)+3];
  Move(A,OutData^,4);
  Move(B,pointer(integer(OutData)+4)^,4);
  Move(C,pointer(integer(OutData)+8)^,4);
  Move(D,pointer(integer(OutData)+12)^,4);
end;

procedure RC6DecryptECB;
var
  A, B, C, D, t, u: DWord;
  i: integer;
begin
  Move(InData^,A,4);
  Move(pointer(integer(InData)+4)^,B,4);
  Move(pointer(integer(InData)+8)^,C,4);
  Move(pointer(integer(InData)+12)^,D,4);
  C:= C - Data.KeyD[(2*NUMROUNDS)+3];
  A:= A - Data.KeyD[(2*NUMROUNDS)+2];
  for i:= NUMROUNDS downto 1 do
  begin
    t:= A; A:= D; D:= C; C:= B; B:= t;
    u:= Lrot32(D * (2*D + 1),5);
    t:= Lrot32(B * (2*B + 1),5);
    C:= Rrot32(C - Data.KeyD[2*i+1],t) xor u;
    A:= Rrot32(A - Data.KeyD[2*i],u) xor t;
  end;
  D:= D - Data.KeyD[1];
  B:= B - Data.KeyD[0];
  Move(A,OutData^,4);
  Move(B,pointer(integer(OutData)+4)^,4);
  Move(C,pointer(integer(OutData)+8)^,4);
  Move(D,pointer(integer(OutData)+12)^,4);
end;

procedure RC6EncryptCBC;
begin
  XorBlock(InData,@Data.LastBlock,OutData,16);
  RC6EncryptECB(Data,OutData,OutData);
  Move(OutData^,Data.LastBlock,16);
end;

procedure RC6DecryptCBC;
var
  TempBlock: array[0..15] of byte;
begin
  Move(InData^,TempBlock,16);
  RC6DecryptECB(Data,InData,OutData);
  XorBlock(OutData,@Data.LastBlock,OutData,16);
  Move(TempBlock,Data.LastBlock,16);
end;

procedure RC6EncryptCFB;
var
  i: integer;
  TempBlock: array[0..15] of byte;
begin
  for i:= 0 to Len-1 do
  begin
    RC6EncryptECB(Data,@Data.LastBlock,@TempBlock);
    PByteArray(OutData)[i]:= PByteArray(InData)[i] xor TempBlock[0];
    Move(Data.LastBlock[1],Data.LastBlock[0],15);
    Data.LastBlock[15]:= PByteArray(OutData)[i];
  end;
end;

procedure RC6DecryptCFB;
var
  i: integer;
  TempBlock: array[0..15] of byte;
  b: byte;
begin
  for i:= 0 to Len-1 do
  begin
    b:= PByteArray(InData)[i];
    RC6EncryptECB(Data,@Data.LastBlock,@TempBlock);
    PByteArray(OutData)[i]:= PByteArray(InData)[i] xor TempBlock[0];
    Move(Data.LastBlock[1],Data.LastBlock[0],15);
    Data.LastBlock[15]:= b;
  end;
end;

procedure RC6EncryptOFB;
begin
  RC6EncryptECB(Data,@Data.LastBlock,@Data.LastBlock);
  XorBlock(@Data.LastBlock,InData,OutData,16);
end;

procedure RC6DecryptOFB;
begin
  RC6EncryptECB(Data,@Data.LastBlock,@Data.LastBlock);
  XorBlock(@Data.LastBlock,InData,OutData,16);
end;

procedure RC6EncryptOFBC;
var
  i: integer;
  TempBlock: array[0..15] of byte;
begin
  for i:= 0 to Len-1 do
  begin
    RC6EncryptECB(Data,@Data.LastBlock,@TempBlock);
    PByteArray(OutData)[i]:= PByteArray(InData)[i] xor TempBlock[0];
    IncBlock(@Data.LastBlock,16);
  end;
end;

procedure RC6DecryptOFBC;
var
  i: integer;
  TempBlock: array[0..15] of byte;
begin
  for i:= 0 to Len-1 do
  begin
    RC6EncryptECB(Data,@Data.LastBlock,@TempBlock);
    PByteArray(OutData)[i]:= PByteArray(InData)[i] xor TempBlock[0];
    IncBlock(@Data.LastBlock,16);
  end;
end;

procedure RC6Reset;
begin
  Move(Data.InitBlock,Data.LastBlock,16);
end;

{ TRC6Encryptor }

constructor TRC6Encryptor.Create(AKey: array of byte);
begin
  inherited Create;
  SetLength(FKey, Length(AKey));
  Move(AKey[0], FKey[0], Length(AKey));
  RC6Init(FData,@FKey,Sizeof(FKey),nil);
end;

destructor TRC6Encryptor.Destroy;
begin
  RC6Burn(FData);
  inherited;
end;

procedure TRC6Encryptor.StreamDecrypt(AStreamIn, AStreamOut: TMemoryStream);
var Block: array[0..15] of byte;
    i, j,
    AddCount: Integer;
begin
  AStreamOut.SetSize(AStreamIn.Size);
  AStreamIn.Position :=0;
  AStreamOut.Position :=0;
  AddCount := 0;
  for i := 0 to AStreamIn.Size div 16 - 1 do
  begin
    AStreamIn.Read(Block, Sizeof(Block));
    RC6DecryptECB(FData,@Block,@Block);
    if i = (AStreamIn.Size div 16 - 1) then
      for j := High(Block) downto Low(Block) do
      begin
        if (Block[j] = 0) then
          continue;
        if (Block[j] = 1) then
          AddCount := High(Block) - j + 1;
        Break;
      end;
    AStreamOut.Write(Block, Sizeof(Block));
  end;
  if AddCount > 0 then
    AStreamOut.SetSize(AStreamOut.Size - AddCount);
end;

procedure TRC6Encryptor.StreamEncrypt(AStreamIn, AStreamOut: TMemoryStream);
var Block: array[0..15] of byte;
    InSize, OutSize: Int64;
    i: Integer;
begin
  InSize := AStreamIn.Size;
  OutSize := AStreamIn.Size + 1;
  if OutSize mod 16 > 0 then
    OutSize := OutSize + 16 - (OutSize mod 16);
  AStreamIn.SetSize(OutSize);
  AStreamOut.SetSize(OutSize);

  AStreamIn.Seek(-16, soFromEnd);
  AStreamIn.Read(Block, Sizeof(Block));
  Block[InSize mod 16] := 1;
  for i := (InSize mod 16) + 1 to High(Block) do
    Block[i] := 0;
  AStreamIn.Seek(-16, soFromEnd);
  AStreamIn.Write(Block, Sizeof(Block));

  AStreamIn.Position := 0;
  AStreamOut.Position := 0;
  for i := 0 to OutSize div 16 - 1 do
  begin
    AStreamIn.Read(Block, Sizeof(Block));
    RC6EncryptECB(FData,@Block,@Block);
    AStreamOut.Write(Block, Sizeof(Block));
  end;
  AStreamIn.SetSize(InSize);
end;

function TRC6Encryptor.StrEncrypt(const AStr: string): string;
var TmpArray: array of byte;
    TmpCount: Integer;
    I: Integer;
begin
  TmpCount := SizeOf(Char) * Length(AStr);
  if TmpCount mod 16 > 0 then
    TmpCount := TmpCount + 16 - (TmpCount mod 16);
  SetLength(TmpArray, TmpCount);
  Move(PChar(AStr)[0], TmpArray[0], SizeOf(Char) * Length(AStr));
  for I := 0 to TmpCount div 16 - 1 do
    RC6EncryptECB(FData, @TmpArray[16 * I], @TmpArray[16 * I]);
  SetLength(Result, TmpCount div SizeOf(Char));
  Move(TmpArray[0], PChar(Result)[0], TmpCount);
end;

function TRC6Encryptor.StrDecrypt(const AStr: string): string;
var TmpArray: array of byte;
    TmpCount: Integer;
    I: Integer;
begin
  TmpCount := SizeOf(Char) * Length(AStr);
  SetLength(TmpArray, TmpCount + 1);
  Move(PChar(AStr)[0], TmpArray[0], TmpCount);
  TmpArray[High(TmpArray)] := 0;
  for I := 0 to TmpCount div 16 - 1 do
    RC6DecryptECB(FData, @TmpArray[16 * I], @TmpArray[16 * I]);
  Result := String(PChar(TmpArray));
end;

end.
