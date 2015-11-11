{ *********************************************************************** }
{                                                                         }
{ Delphi Еncryption Library                                               }
{ Еncryption / Decryption stream - RC6                                    }
{                                                                         }
{ Copyright (c) 2004 by Matveev Igor Vladimirovich                        }
{ With offers and wishes write: teap_leap@mail.ru                         }
{                                                                         }
{ *********************************************************************** }

unit RC6;

interface

uses
  SysUtils, Classes;

const
  RC6Rounds    = 20;
  RC6KeyLength = 2 * (RC6Rounds + 2);

  RC6BlockSize = 16;
  RC6KeySize   = 16 * 4;

  RC6P32       = $b7e15163;
  RC6Q32       = $9e3779b9;
  RC6lgw       = 5;

type
  TRC6Block = array[1..4] of LongWord;

var
  RC6S      : array[0..RC6KeyLength - 1] of LongWord;
  RC6Key    : AnsiString;
  RC6KeyPtr : PAnsiChar;

////////////////////////////////////////////////////////////////////////////////
// Дополнительные функции

procedure RC6Initialize(AKey: AnsiString);      // Инициализация
procedure RC6CalculateSubKeys;                  // Подготовка подключей
function RC6EncipherBlock(var Block): Boolean;  // Шифрация блока (16 байт)
function RC6DecipherBlock(var Block): Boolean;  // Дешифрация блока

////////////////////////////////////////////////////////////////////////////////
// Главные функции

function RC6EncryptCopy(ADestStream, ASourseStream: TStream; ACount: Int64;
  AKey: AnsiString): Boolean;    // Зашифровать данные из одного потока в другой

function RC6DecryptCopy(ADestStream, ASourseStream: TStream; ACount: Int64;
  AKey: AnsiString): Boolean;    // Расшифровать данные из одного потока в другой

function RC6EncryptStream(ADataStream: TStream; ACount: Int64;
  AKey: AnsiString): Boolean;     // Зашифровать содержимое потока

function RC6DecryptStream(ADataStream: TStream; ACount: Int64;
  AKey: AnsiString): Boolean;     // Расшифровать содержимое потока

implementation

function ROL(a, s: LongWord): LongWord;
asm
  mov    ecx, s
  rol    eax, cl
end;

function ROR(a, s: LongWord): LongWord;
asm
  mov    ecx, s
  ror    eax, cl
end;

procedure RC6InvolveKey;
var
  TempKey: AnsiString;
  i, j: Integer;
  K1, K2: LongWord;
begin
  // Разворачивание ключа до длинны KeySize = 64
  TempKey := RC6Key;
  i := 1;
  while ((Length(TempKey) mod RC6KeySize) <> 0) do
  begin
    TempKey := TempKey + TempKey[i];
    Inc(i);
  end;

  i := 1;
  j := 0;
  while (i < Length(TempKey)) do
  begin
    Move((RC6KeyPtr + j)^, K1, 4);
    Move(TempKey[i], K2, 4);
    K1 := ROL(K1, K2) xor K2;
    Move(K1, (RC6KeyPtr + j)^, 4);
    j := (j + 4) mod RC6KeySize;
    Inc(i, 4);
  end;
end;

procedure RC6CalculateSubKeys;
var
  i, j, k : Integer;
  L: array[0..15] of LongWord;
  A, B: LongWord;
begin
  // Копирование ключа в L
  Move(RC6KeyPtr^, L, RC6KeySize);

  // Инициализация подключа S
  RC6S[0] := RC6P32;
  for i := 1 to RC6KeyLength - 1 do
    RC6S[i] := RC6S[i-1] + RC6Q32;

  // Смешивание S с ключом
  i := 0;
  j := 0;
  A := 0;
  B := 0;
  for k := 1 to 3 * RC6KeyLength do
  begin
    A := ROL((RC6S[i] + A + B), 3);
    RC6S[i] := A;
    B := ROL((L[j] + A + B), (A + B));
    L[j] := B;
    i := (i + 1) mod RC6KeyLength;
    j := (j + 1) mod 16;
  end;
end;

procedure RC6Initialize(AKey: AnsiString);
begin
  GetMem(RC6KeyPtr, RC6KeySize);
  FillChar(RC6KeyPtr^, RC6KeySize, #0);
  RC6Key := AKey;

  RC6InvolveKey;
end;

function RC6EncipherBlock(var Block): Boolean;
var
  RC6Block: TRC6Block absolute Block;
  i: Integer;
  t, u: LongWord;
  Temp: LongWord;
begin
  // Инициализация блока
  Inc(RC6Block[2], RC6S[0]);
  Inc(RC6Block[4], RC6S[1]);

  for i := 1 to RC6Rounds do
  begin
    t := ROL((RC6Block[2] * (2 * RC6Block[2] + 1)), RC6lgw);
    u := ROL((RC6Block[4] * (2 * RC6Block[4] + 1)), RC6lgw);
    RC6Block[1] := ROL((RC6Block[1] xor t), u) + RC6S[2 * i];
    RC6Block[3] := ROL((RC6Block[3] xor u), t) + RC6S[2 * i + 1];

    Temp := RC6Block[1];
    RC6Block[1] := RC6Block[2];
    RC6Block[2] := RC6Block[3];
    RC6Block[3] := RC6Block[4];
    RC6Block[4] := Temp;
  end;

  RC6Block[1] := RC6Block[1] + RC6S[2 * RC6Rounds + 2];
  RC6Block[3] := RC6Block[3] + RC6S[2 * RC6Rounds + 3];

  Result := TRUE;
end;

function RC6DecipherBlock(var Block): Boolean;
var
  RC6Block : TRC6Block absolute Block;
  i: Integer;
  t, u: LongWord;
  Temp: LongWord;
begin
  // Инициализация блока
  RC6Block[3] := RC6Block[3] - RC6S[2 * RC6Rounds + 3];
  RC6Block[1] := RC6Block[1] - RC6S[2 * RC6Rounds + 2];

  for i := RC6Rounds downto 1 do
  begin
    Temp := RC6Block[4];
    RC6Block[4] := RC6Block[3];
    RC6Block[3] := RC6Block[2];
    RC6Block[2] := RC6Block[1];
    RC6Block[1] := Temp;

    u := ROL((RC6Block[4] * (2*RC6Block[4] + 1)), RC6lgw);
    t := ROL((RC6Block[2] * (2*RC6Block[2] + 1)), RC6lgw);
    RC6Block[3] := ROR((RC6Block[3] - RC6S[2 * i + 1]), t) xor u;
    RC6Block[1] := ROR((RC6Block[1] - RC6S[2 * i]), u) xor t;
  end;

  Dec(RC6Block[4], RC6S[1]);
  Dec(RC6Block[2], RC6S[0]);

  Result := TRUE;
end;

////////////////////////////////////////////////////////////////////////////////
// Реализация главных функций

function RC6EncryptCopy(ADestStream, ASourseStream : TStream; ACount: Int64;
  AKey : AnsiString): Boolean;
var
  Buffer   : TRC6Block;
  PrCount  : Int64;
  AddCount : Byte;
begin
  Result := True;
  try
    if AKey = '' then
    begin
      ADestStream.CopyFrom(ASourseStream, ACount);
      Exit;
    end;
    RC6Initialize(AKey);
    RC6CalculateSubKeys;
    PrCount := 0;
    while ACount - PrCount >= RC6BlockSize do
    begin
      ASourseStream.Read(Buffer, RC6BlockSize);
      RC6EncipherBlock(Buffer);
      ADestStream.Write(Buffer, RC6BlockSize);
      Inc(PrCount, RC6BlockSize);
    end;

    AddCount := ACount - PrCount;
    if ACount - PrCount <> 0 then
    begin
      ASourseStream.Read(Buffer, AddCount);
      ADestStream.Write(Buffer, AddCount);
    end;
  except
    Result := False;
  end;
end;

function RC6DecryptCopy(ADestStream, ASourseStream: TStream; ACount: Int64;
  AKey: AnsiString): Boolean;
var
  Buffer: TRC6Block;
  PrCount: Int64;
  AddCount: Byte;
begin
  Result := True;
  try
    if AKey = '' then
    begin
      ADestStream.CopyFrom(ASourseStream, ACount);
      Exit;
    end;
    RC6Initialize(AKey);
    RC6CalculateSubKeys;
    PrCount := 0;
    while ACount - PrCount >= RC6BlockSize do
    begin
      ASourseStream.Read(Buffer, RC6BlockSize);
      RC6DecipherBlock(Buffer);
      ADestStream.Write(Buffer, RC6BlockSize);
      Inc(PrCount, RC6BlockSize);
    end;

    AddCount := ACount - PrCount;
    if ACount - PrCount <> 0 then
    begin
      ASourseStream.Read(Buffer, AddCount);
      ADestStream.Write(Buffer, AddCount);
    end;
  except
    Result := False;
  end;
end;

function RC6EncryptStream(ADataStream: TStream; ACount: Int64; AKey: AnsiString): Boolean;
var
  Buffer   : TRC6Block;
  PrCount  : Int64;
begin
  Result := True;
  try
    if AKey = '' then
    begin
      ADataStream.Seek(ACount, soFromCurrent);
      Exit;
    end;
    RC6Initialize(AKey);
    RC6CalculateSubKeys;
    PrCount := 0;
    while ACount - PrCount >= RC6BlockSize do
    begin
      ADataStream.Read(Buffer, RC6BlockSize);
      RC6EncipherBlock(Buffer);
      ADataStream.Seek(-RC6BlockSize, soFromCurrent);
      ADataStream.Write(Buffer, RC6BlockSize);
      Inc(PrCount, RC6BlockSize);
    end;
  except
    Result := False;
  end;
end;

function RC6DecryptStream(ADataStream: TStream; ACount: Int64; AKey: AnsiString): Boolean;
var
  Buffer: TRC6Block;
  PrCount: Int64;
begin
  Result := True;
  try
    if AKey = '' then
    begin
      ADataStream.Seek(ACount, soFromCurrent);
      Exit;
    end;
    RC6Initialize(AKey);
    RC6CalculateSubKeys;
    PrCount := 0;
    while ACount - PrCount >= RC6BlockSize do
    begin
      ADataStream.Read(Buffer, RC6BlockSize);
      RC6DecipherBlock(Buffer);
      ADataStream.Seek(-RC6BlockSize, soFromCurrent);
      ADataStream.Write(Buffer, RC6BlockSize);
      Inc(PrCount, RC6BlockSize);
    end;
  except
    Result := False;
  end;
end;

end.
