unit Compilator;

{******************************************************************************}
{                                                                              }
{                      SOREL (C)CopyRight 1999-2003. Russia, S.-Petersburg.    }
{                                                                              }
{         Компилятор и эмулятор  сгенерированного выражения (из Foreval_HD)    }
{                             ver 3.4.23                                       }
{                                                                              }
{******************************************************************************}


{.$DEFINE TEXTOUT}
//для добавляемых ф-ий (передача адреса начала аргументов):
//FType =
//       -3 - EAX             начальный адрес
//       -4 - EBX             начальный адрес
//       -5 - ECX             начальный адрес
//       -6 - EDX             начальный адрес
//       -7 - ESP             начальный адрес
//       -8 - FPU             значения
//       -10 - Stack (CPU)    значения
//       -11 - Infinite       адрес списка - EAX; длина - EBX
//       -12 - Infinite       адрес списка - EBX; длина - ECX
//       -13 - Infinite       адрес списка - ECX; длина - EDX
//       -14 - Infinite       Stack (CPU);  адрес, длина; (Addr,Length: Cardinal)



interface

uses
{Math, }SysUtils, Foreval_HD, {Command,} CommandC
{$IFDEF TEXTOUT}
,TestG8
{$ENDIF}
;

const
C05: double = 0.5;
C1: double = 1;

E_CPId2: extended = 1.57079632679489662;{_Pi/2;}

D_CPId2: double = 1.57079632679489662;{_Pi/2;}


const SizeE = 10;

const _Single = 1;
const _Double = 2;
const _Extended = 3;
const _Integer = 4;
const _Differ =  5;
const _None = 0;
const _Float = 6;
const _Load = 7;
const _AddSub = 8;
const _MulDiv = 9;




type
  TCompiler = class

 private
  E_Overflow: Boolean;
  Db_OverFlow: Boolean;
  F_SaveStack: Boolean;
  F_EnableCheckStack: Boolean;
  F_Attrib: TAttrib;
  N_Stack: Integer;     //текущая глубина стека (после вычисления текущей ф-ии)
  N1_Stack: Integer;    //глубина стека перед вычислением текущей ф-ии
  StackSize: Integer;   //максимально разрешённая глубина стека (<= 8)
  _MaxStack: Integer;   //максимально достигнутая глубина стека во всём выражении
   F_CorrectIPWR: Integer;
  F_ParamType, F_DataType: Integer; //компиляция параметров и стека на типы(_Double/_Extended/_Single)
  SMAX: Integer;        //максимально достигнутая глубина стека в текущей ф-ии
  F_CloseArg: Boolean;
  Func: TFunction;
  Interp: TArrayOfTFunc;
  Factorial: TArrayF;
  FuncData,BFuncData: PFuncData;

  FuncList: TArrayFuncList;
  VarList: TVarList;
  LFunc: Integer;
  F_Mode: Integer;   //режим работы модуля
  REG:  array [1..8] of Integer;
  REGA: array [1..8] of Integer;
  ICOMP: TCode;   //TBCode;
  AL_ICOMP: TCode;
  CNI: Cardinal; //текущий номер компилируемой команды 


  //procedure IntToHex(N: TAddress; var AH: TArray4);
  procedure AddAddress(Adr: TAddress);
  procedure AddInteger(Int: Integer);
  procedure AddCommand(I: Integer);
  procedure AddEndCommand(I: Integer);
  procedure AddByte(B: Byte);
  procedure AddWord(B1: Byte; B2: Byte);

  procedure AddCom(B1: Byte);                           overload;
  procedure AddCom(B1,B2: Byte);                        overload;
  procedure AddCom(B1,B2,B3: Byte);                     overload;
  procedure AddCom(B1: Byte; Adr: TAddress);            overload;
  procedure AddCom(B1,B2: Byte; Adr: TAddress);         overload;
  procedure AddCom(B1,B2,B3: Byte; Adr: TAddress);      overload;
  procedure AddCom(B1,B2,B3: Byte; N: Integer);         overload;
  procedure AddCom(B1: Byte; N: Integer);               overload;
  procedure AddCom(B1,B2: Byte; N: Integer);            overload;

  procedure FLD(N: TAddress; VType: Integer);     overload;
  procedure FSTPM(N: TAddress; VType: Integer);
  procedure FAVB(I: Integer);
  procedure FAVBM(I,k: Integer);
  procedure FAVBM1(I: Integer);
  function  FAVB1(I: Integer): Boolean;
  procedure FAVBF(I: Integer);
  procedure FAVBF1(I: Integer);
  procedure ASB(I: Integer);
  procedure FMUL(X: TFloatType; N: TAddress; VType: Integer); overload;
  procedure FADD(X: TfloatType; N: TAddress; VType: Integer); overload;
  procedure FADD(N: TAddress; VType: Integer); overload;
  procedure FMUL(N: TAddress; VType: Integer); overload;
  procedure FADD; overload;
  procedure FADD2;
  procedure FSUB;     overload;
  procedure FSUBRP;
  procedure FSUBP;
  procedure FSUBR(N: TAddress; VType: Integer);
  procedure FSUB(N: TAddress; VType: Integer); overload;
  procedure FMULP1; overload;
  procedure MAF(I: Integer);
  procedure AAF(I:Integer);
  procedure AAI(I: Integer);
  procedure AAI1(I: Integer);
  procedure AFI(I: Integer);
  procedure FIDIV(N: TAddress);
  procedure FDIVR1;
  procedure FDIVP;   overload;
  procedure FDIVRP;  overload;
  procedure FDIV(N:TAddress; VType: Integer);  overload;
  procedure FDIVR(N:TAddress; VType: Integer); overload;
  procedure FILD(N: TAddress);
  procedure FIMUL(N: TAddress);
  procedure FIADD(N: TAddress);
  procedure IAVB(I: Integer);
  procedure IAVBF(I: Integer);
  procedure IAVBF1(I: Integer);
  procedure AIFB(I: Integer);
  procedure AIFB1(I: Integer);
  procedure MOVB(N: TAddress);
  procedure MOVAM(N: TAddress);
  procedure MOVMA(N: TAddress);
  procedure MOVAX(N: TAddress);
  procedure MOVCM(N: TAddress);
  procedure MOVCA;
  procedure MOVAB;
  procedure MOVBA;
  procedure MOVD1(N: TAddress);
  procedure MOVMB(N: TAddress);
  procedure SUBAB;
  procedure SUBA(N: TAddress);
  procedure FSTPESP(VType: Integer);                overload;
  procedure FSTPESP(VType: Integer; N: Integer);    overload;
  procedure NEGA;
  procedure NEGB;
  procedure IMULA(X: Integer; N: TAddress);
  procedure IMULB(X: Integer;N: TAddress);
  procedure IMULBA_B(B: Byte);
  procedure IMULDA_B(B: Byte);
  procedure IMULBA;
  procedure IMULBB;
  procedure IMULAA;
  procedure IMULAB;
  procedure LEA_CC8A;
  procedure LEA_CD8A;
  procedure LEA_AC2A;
  procedure ADDA(X: Integer; N: TAddress);  overload;
  procedure ADDA(N: TAddress);    overload;
  procedure ADDCB;
  procedure ADDCD;
  procedure ADDAB;
  procedure ADDESP(N: Integer);
  procedure SUBESP(N: Integer);
  procedure PUSHAX;
  procedure PUSHA;
  procedure PUSHB;
  procedure PUSHC;
  procedure PUSHD;
  procedure PUSHESP;
  procedure POPESP;
  procedure PUSHEBP;
  procedure POPEBP;
  procedure PUSHESI;
  procedure POPESI;
  procedure PUSHEDI;
  procedure POPEDI;
  procedure PUSHM(N: Integer);
  procedure PUSHF(N: TAddress);
  procedure POPA;
  procedure POPB;
  procedure POPC;
  procedure POPD;
  procedure CALLA;
  procedure CALLB;
  procedure CALLC;
  procedure CALLD;
  procedure MOVB1(N: TAddress);
  procedure MOVA1(N: TAddress);
  procedure MOVC1(N: TAddress);
  procedure SUBA_B(B: Byte);
  procedure FCHS;
  procedure EndFuncCom(I: Integer);
  procedure InsertFunc1(I: Integer);
  procedure InsertFunc2(I: Integer);
  procedure InsertFunc3(I: Integer);
  procedure InsertFunc4(I: Integer);
  procedure FPWR; overload;
  procedure FXCH1;

  procedure FLDLN2;
  procedure FLDLG2;
  procedure FYL2X;
  procedure FLDCW(N: TAddress);
  procedure FISTP(N: TAddress);
  //procedure FSTP(VType: Integer; Adr: TAddress);
  procedure FSTPA(VType: Integer; Shift: Cardinal);
  procedure FSTPB(VType: Integer; Shift: Cardinal);
  procedure FSTPC(VType: Integer; Shift: Cardinal);
  procedure FSTPD(VType: Integer; Shift: Cardinal);
  procedure FSINCOS;
  procedure SQR;
  procedure IPWR3;
  procedure IPWR4;
  procedure IPWR5;
  procedure IPWR6;
  procedure IPWR7;
  procedure IPWR8;
  procedure IPWR9;
  procedure IPWR10;
  procedure IPWR11;
  procedure IPWR12;
  procedure IPWR13;
  procedure IPWR14;
  procedure IPWR15;
  procedure IPWR16;
  procedure IPWR_B;
  procedure FMUL0;


  procedure FSCALE;
  procedure FSIN;
  procedure FCOS;
  procedure FPTAN;
  procedure FPATAN;
  procedure FLD1;
  procedure FLD0;
  procedure FSTP0;
  procedure FSTP1;
  procedure FLDA_E;
  procedure FTAN;
  procedure FATAN;
  procedure SINH;
  procedure COTAN;
  procedure ARCSIN;
  procedure ARCCOS;
  procedure ARCCOTAN;
  procedure EXP;
  procedure LN;
  procedure LOG10;
  procedure LOG2;
  procedure COSH;
  procedure TANH;
  procedure COTANH;
  procedure ARCSINH;
  procedure ARCCOSH;
  procedure ARCTANH;
  procedure ARCCOTANH;
  procedure SIN;
  procedure COS;
  procedure FABS;
  procedure ADD(I: Integer);
  procedure MUL(I: Integer);
  procedure MUL_AFB(I,OP: Integer);
  procedure MUL_AAF(I: Integer);
  procedure MUL_MAF(I: Integer);

  procedure FUNC1(I: Integer);
  procedure FUNC2(I: Integer);
  procedure FUNC3(I: Integer);
  procedure FUNC4(I: Integer);
  procedure FSTM(N: TAddress; VType: Integer);
  //procedure CopyStack(I: Integer);
  procedure FAB12(I: Integer);
  procedure FSQRT;



  procedure FACTSTACK;
  procedure FRNDINT;
  procedure FTRUNC; overload;
  procedure TRUNCM(N: TAddress);
  procedure LOGN;              overload;
  procedure ALS;
  procedure SetReg(R: Integer);
  procedure RET;
  procedure SaveReg;
  procedure SaveRes(Adr,RType,Shift: Cardinal);
  procedure SaveFuncReg(I: Integer);
  function  SizeArg(VType: Integer): Integer;
  procedure AddFuncMEM(I: Integer);
  procedure AddFuncCPU(I: Integer);
  procedure AddFuncFPU(I: Integer);
  procedure AddFuncINF(I: Integer);
  procedure PKGCMPL(I: Integer);
  procedure MOVREGESP(R: Integer; Sh: Byte);
  procedure POPREG(reg: Cardinal);
  procedure PUSHREG(reg: Cardinal);



  procedure CheckStack(N: Integer);
  function  WriteData(Data: TFloatType; DataType: Integer; ComType: Integer): TAddress;
  procedure FreeData;
  function  IsLevelLoad(I: Integer): Boolean;
  function  IsLevelLoadA(I: Integer): Integer;

  procedure POPFPU;
  procedure PUSHFPU;



  procedure E_TreeToInterp(Tree: PNode);
  procedure E_SetNode(Tree: PNode);
  procedure E_SetNodeDL(I: Integer);






 public
  constructor Create(FL: TArrayFuncList);
  procedure Compile(PFunc: PFunction; EInterp: TArrayOfTFunc;  var NAdr: Cardinal);
   procedure SetRegA(R: Integer; SC: Integer);
  function  GetReg(R: Integer): Integer;
  function  GetVarType(Addr: TAddress): Integer;
  procedure Init(FL: TArrayFuncList; VList: TVarList; S,Param,Data: Integer; SaveStack,CloseArg: Boolean; Atr: TAttrib);
  procedure E_Init( EInterp: TArrayOfTFunc; FL: TArrayFuncList; VList: TVarList; S,Param,Data,Mode: Integer);
  function  E_GetMaxLoadDL(I: Integer): Integer;
  function  E_GetFuncLoad(Tree: PNode): Integer;
  function  E_GetMaxStackEx: Integer;
  property  GetMaxStack: Integer read _MaxStack default 0;
  property  OverFlow: Boolean read Db_OverFlow default False;





end;


implementation
const
FCW1: Word = $1f32;
FCW2: Word = $1332;
var
MEM,MEM1: Integer; //используется в компиляторе как промежуточная ячейка
DMEM,DMEM1,DMEM2,DMEM3,DMEM4,DMEM5,DMEM6,DMEM7,DMEM8,DMEM9: double;
EMEM,EMEM1,EMEM2,EMEM3,EMEM4,EMEM5,EMEM6,EMEM7,EMEM8,EMEM9: extended;
SFPU: array [1..8] of Extended;


constructor TCompiler.Create(FL: TArrayFuncList);
begin
 FuncList:=FL;
 inherited Create;
end;




procedure TCompiler.Init(FL: TArrayFuncList;  VList: TVarList; S,Param,Data: Integer; SaveStack,CloseArg: Boolean; Atr: TAttrib);
begin
FuncList:=FL;
VarList:=VList;
StackSize:=S;
F_Attrib:=Atr;
F_SaveStack:=SaveStack;
F_ParamType:=Param;
F_DataType:=Data;
F_Mode:=C_Compile;
F_CloseArg:=CloseArg;
F_EnableCheckStack:=True;
end;


procedure TCompiler.E_Init(EInterp: TArrayOfTFunc; FL: TArrayFuncList; VList: TVarList; S,Param,Data,Mode: Integer);
begin
N_Stack:=0;
SMAX:=0;
Interp:=EInterp;
FuncList:=FL;
VarList:=VList;
StackSize:=S;
F_ParamType:=Param;
F_DataType:=Data;
N_Stack:=0;
E_Overflow:=False;
F_SaveStack:=True;
_MaxStack:=0;
F_Mode:=Mode;
F_EnableCheckStack:=True;
end;





procedure TCompiler.E_SetNode(Tree: PNode);
label 1,2;
var
i,j,k,N: Integer;
AH,AB: TArray4;
R: TFloatType;
P: Pointer;
X: TFloatType;
Sh,S: String;
Cm,alg: Cardinal;
Bt1: Byte;
AdrS,AdrD,AdrH,TAdr: Cardinal;
begin

CNI:=0;
E_TreeToInterp(Tree);

SMAX:=N_Stack;
N1_Stack:=N_Stack;
AddCommand(0);
AddEndCommand(0);

end;




procedure TCompiler.E_SetNodeDL(I: Integer);
label 1,2;
var
j,k,N: Integer;
AH,AB: TArray4;
R: TFloatType;
P: Pointer;
X: TFloatType;
Sh,S: String;
Cm,alg: Cardinal;
Bt1: Byte;
AdrS,AdrD,AdrH,TAdr: Cardinal;
begin

CNI:=I;

SMAX:=N_Stack;
N1_Stack:=N_Stack;
AddCommand(I);
AddEndCommand(I);
end;



procedure TCompiler.E_TreeToInterp(Tree: PNode);
label endp;
var
fa,i,L,j: TIntegType;
S: String;
begin

Interp[0].ErS:=Copy(Tree^.Expression,1,Length(Tree^.Expression));
for i:=0 to High(VarList) do
begin
 if Tree^.FV1 = i then Interp[0].FV1:=VarList[i].Addr;
 if Tree^.FV2 = i then Interp[0].FV2:=VarList[i].Addr;
 if Tree^.IV1 = i then Interp[0].IV1:=VarList[i].Addr;
 if Tree^.IV2 = i then Interp[0].IV2:=VarList[i].Addr;
end;


Interp[0].S:=Tree^.Stack.S;
Interp[0].N:=Tree^.Stack.N;
Interp[0].RCS:=0;
Interp[0].ExtArg:=Tree^.ExtArg;
Interp[0].SExtArg:=Tree^.SExtArg;
Interp[0].PkAdr:=Tree^.PkAdr;
Interp[0].PkShift:=Tree^.PkShift;
Interp[0].PkRType:=Tree^.PkRType;
SetLength(Interp[0].AWCS,0);
SetLength(Interp[0].AFB,0);
SetLength(Interp[0].PN,0);
SetLength(Interp[0].PM,0);
SetLength(Interp[0].PI,0);
SetLength(Interp[0].PC,0);
SetLength(Interp[0].RData,0);



SetLength(Interp[0].SGN,Length(Tree^.SGN));
for i:=0 to High(Tree^.SGN) do
begin
 Interp[0].SGN[i]:=Tree^.SGN[i];
end;

Interp[0].EI:=Tree^.EI;
Interp[0].DI:=Tree^.DI;
Interp[0].AI:=Tree^.AI;
Interp[0].BI:=Tree^.BI;
Interp[0].CI:=Tree^.CI;
Interp[0].FI:=Tree^.FI;

Interp[0].F1:=Tree^.F1;
Interp[0].F2:=Tree^.F2;



Interp[0].V1:=Tree^.V1;
Interp[0].V2:=Tree^.V2;

Interp[0].V3:=Tree^.V3;
Interp[0].V4:=Tree^.V4;


Interp[0].VI1:=Tree^.VI1;
Interp[0].VI2:=Tree^.VI2;
Interp[0].VI3:=Tree^.VI3;
Interp[0].VI4:=Tree^.VI4;



Interp[0].I:=0;

//AAF:
if Tree^.DI = _AAF then
begin
fa:=0;
for i:=0 to High(VarList) do
begin

if Tree^.PN.FM[i] <> 0 then
begin
inc(fa);
end;
end;
  begin
   SetLength(Interp[0].PM,fa+1);   SetLength(Interp[0].PN,fa+2);
   j:=0;
   for i:=0 to High(VarList) do
    begin
     if Tree^.PN.FM[i] <> 0 then
      begin
       inc(j);
       Interp[0].PM[j]:=VarList[i].Addr;
       Interp[0].PN[j]:=Tree^.PN.FM[i];
      end;
    end;
   Interp[0].PN[j+1]:=Tree^.PN.FC;

   //Interp[0].AM:=1;
  end;

end;




//MAF:
if Tree^.DI = _MAF then
begin
fa:=0;
for i:=0 to High(VarList) do
begin
if Tree^.PN.FM[i] <> 0 then
begin
inc(fa);
end;
end;
  Interp[0].V1:=Tree^.PN.FC;
  begin
   SetLength(Interp[0].PM,fa+1);
   j:=0;
   for i:=0 to High(VarList) do
    begin
     if Tree^.PN.FM[i] <> 0 then
      begin
       inc(j); Interp[0].PM[j]:=VarList[i].Addr;
      end;
    end;
  end;
end;




if Tree^.CI = _AAI then
begin
fa:=0;
for i:=0 to High(VarList) do
begin
if Tree^.PN1.IM[i] <> 0 then
begin
inc(fa);
end;
end;
  begin
   SetLength(Interp[0].PI,fa+1);   SetLength(Interp[0].PC,fa+2);
   j:=0;
   for i:=0 to High(VarList) do
    begin
     if Tree^.PN1.IM[i] <> 0 then
      begin
       inc(j); Interp[0].PI[j]:=VarList[i].Addr;
       Interp[0].PC[j]:=Trunc(Tree^.PN1.IM[i]);
      end;
    end;
   Interp[0].PC[j+1]:=Trunc(Tree^.PN1.FC);
  end;

end;



if Tree^.DI = _AFI then
begin

fa:=0;
for i:=0 to High(VarList) do
begin
if Tree^.PN.IM[i] <> 0 then
begin
inc(fa);
end;
end;

SetLength(Interp[0].PI,fa+1);
SetLength(Interp[0].PN,fa+2);
j:=0;
 for i:=0 to High(VarList) do
 begin
  if Tree^.PN.IM[i] <> 0 then
  begin
   inc(j); Interp[0].PI[j]:=VarList[i].Addr;
   Interp[0].PN[j]:=Tree^.PN.IM[i];
  end;
 end;
Interp[0].PN[j+1]:=Tree^.PN.FC;


end;

if Length(Tree^.AFB) > 0 then
begin
 SetLength(Interp[0].AFB,Length(Tree^.AFB));
 for i:=0 to  High(Tree^.AFB) do
 begin
  Interp[0].AFB[i].PF:=VarList[Tree^.AFB[i].nf].Addr;
  Interp[0].AFB[i].A:=Tree^.AFB[i].A;
  Interp[0].AFB[i].B:=Tree^.AFB[i].B;
 end;
end;


if Length(Tree^.RData) <> 0 then SetLength(Interp[0].RData,Length(Tree^.RData));
for i:=0 to High(Tree^.RData) do
begin
 Interp[0].RData[i]:=Tree^.RData[i];
end;

if Length(Tree^.SNExtArg) <> 0 then SetLength(Interp[0].SNExtArg,Length(Tree^.SNExtArg));
for i:=0 to High(Tree^.SNExtArg) do
begin
 Interp[0].SNExtArg[i]:=Tree^.SNExtArg[i];
end;

Interp[0].SData:=Tree^.SData;
Interp[0].Neg:=Tree^.Neg;
Interp[0].I:=Tree^.I;
Interp[0].NL:=Tree^.NL;
Interp[0].XCHA:=Tree^.XCHA;
Interp[0].NM:=Tree^.NM;
Interp[0].Code:=Tree^.Code;


endp:
end;



function TCompiler.E_GetMaxLoadDL(I: Integer): Integer;
begin
 E_SetNodeDL(I);
 E_GetMaxLoadDL:=SMAX;
end;



function TCompiler.E_GetFuncLoad(Tree: PNode): Integer;
begin
 E_SetNode(Tree);
 E_GetFuncLoad:=SMAX-N1_Stack;
end;



function TCompiler.E_GetMaxStackEx: Integer;
var
i: Integer;
begin
 for i:=1 to High(Interp) do
 begin
  E_SetNodeDL(i);
 end;
 E_GetMaxStackEx:=_MaxStack;
end;




function  TCompiler.GetVarType(Addr: TAddress): Integer;
label endp;
var
 i: Integer;
begin
 for i:=0 to High(VarList) do
 begin
   if  Addr = VarList[i].Addr then
   begin
    GetVarType:=VarList[i].VType;
    goto endp;
   end;
 end;

endp:
end;



{
procedure TCompiler.IntToHex(N: TAddress; var AH: TArray4);
var
i,K,N1,j: Integer;
A8: array [1..8] of Integer;
begin
N1:=N;  j:=1;
for i:=7 downto 1 do
begin
 K:=Trunc(N1/IntPower(2,i*4));
 A8[j]:=(K);
 N1:=N1-Trunc(IntPower(2,i*4))*K;
 inc(j);
end;
A8[j]:=N1;


//в обратном порядке:
j:=1;
for i:=4 downto 1 do
begin
 AH[i]:=A8[j]*16+A8[j+1];
 j:=j+2;
end;
end;
}






function  TCompiler.WriteData(Data: TFloatType;  DataType,ComType: Integer): TAddress;
var
FD1: PFuncData;
BH: Boolean;
Pm: Pointer;
ConstType: Integer;
begin


if F_Mode = C_Compile then
begin

 BH:=False;
 if ComType = _LOAD then
  begin
   BH:=True;
   if DataType = _Integer then ConstType:=_Integer
   else
   ConstType:=F_ParamType;
  end
 else
 begin
  if ComType = _ADDSUB then
  begin
   if Data <> 0 then BH:=True;
  end
  else
  if ComType = _MULDIV then
  begin
   if (Data <> 1) and (Data <> -1) then BH:=True;
  end;

  if BH then
  begin
   if DataType = _Integer then ConstType:=_Integer
   else
   ConstType:=F_ParamType;
  end;
 end;





 if BH = True then
 begin
  new(FD1); FD1^.Next:=nil;
  FuncData^.Next:=FD1;
  FuncData:=FD1;
  Pm:=Pointer(@FD1^.FData);


  case  ConstType of
  _Integer:   Integer(Pm^):=Trunc(Data);
  _Single:    Single(Pm^):=Data;
  _Double:    Double(Pm^):=Data;
  _Extended:  Extended(Pm^):=Data;
  end;

  WriteData:=TAddress(Pm);

 end
 else
 WriteData:=TAddress(nil);

end
else
WriteData:=TAddress(nil);
end;



procedure TCompiler.FreeData;
var
FD1,FD2: PFuncData;
begin

FD1:=BFuncData;
while FD1 <> nil do
begin
 FD2:=FD1^.Next;
 dispose(FD1);
 FD1:=FD2;
end;

end;



procedure TCompiler.Compile(PFunc: PFunction; EInterp: TArrayOfTFunc;  var NAdr: Cardinal);
label 1,2;
var
i,j,k,N,t1: Integer;
AH,AB: TArray4;
R: TFloatType;
P: Pointer;
X: TFloatType;
Sh,S: String;
Cm,alg: Cardinal;
Bt1: Byte;
AdrS,AdrD,AdrH,TAdr: Cardinal;
begin
//{$IFDEF TEXTOUT}
_MaxStack:=0;
//{$ENDIF}
//каждый раз инициализация т.к. предыдущее выражение может сбросить F_SaveStack:
//if StackSize = 0 then F_SaveStack:=False else F_SaveStack:=True;


N_Stack:=0;
CNI:=0;
E_Overflow:=False;
Db_OverFlow:=False;
F_EnableCheckStack:=True;

 Func:=PFunc^;
 Interp:=EInterp;
 LFunc:=Length(Interp);

1:
new(FuncData); FuncData^.Next:=nil; BFuncData:=FuncData;
SetLength(ICOMP,0);
REG[1]:=0;
REG[2]:=0;
REG[3]:=0;
REG[4]:=0;
REG[5]:=0;
REG[6]:=0;
REG[7]:=0;
REG[8]:=0;


for i:=1 to LFunc-1 do
begin
//NOP не выполняется
 if Interp[i].Code <> C_NOP then
 begin
 {$IFDEF TEXTOUT}
   //SMAX:=N_Stack;
   S:=Interp[i].ErS;
   //if Length(Interp[i].RData) > 0 then t1:=Interp[i].RData[0];
 {$ENDIF}
  CNI:=i;
  AddCommand(i);
  AddEndCommand(i);

 end;
end;


SaveReg;
SaveRes(F_Attrib.Adr,F_Attrib.RType,F_Attrib.Shift);
RET;


if  (F_SaveStack = True) and (E_OverFlow = True) then
begin
  N_Stack:=0;
  _MaxStack:=0;
  E_OverFlow:=False;
  F_SaveStack:=False;
  FreeData;
  Db_OverFlow:=True;
  goto 1;
end;

{$IFDEF TEXTOUT}
  TestG8.Form1.STL.Caption:=IntToStr(N_Stack);
{$ENDIF}


//выравнивание кода на alg:
alg:=16;
SetLength(Func.Code,0);
SetLength(PFunc^.Code,Length(ICOMP)+alg+1);
for i:=0 to alg+1  do
begin
 if Cardinal(@PFunc^.Code[i]) mod alg = 0 then
 begin
  NAdr:=i;
  goto 2;
 end;
end;
2:
for i:=0 to High(ICOMP) do begin
 PFunc^.Code[i+NAdr]:=ICOMP[i];
end;
PFunc^.Data:=BFuncData;
ICOMP:=nil;

end;


procedure TCompiler.CheckStack(N: Integer);
begin
if F_EnableCheckStack then
N_Stack:=N_Stack+N;

if N_Stack > StackSize then
begin
E_OverFlow:=True;
end;

//{$IFDEF TEXTOUT}
if N_Stack > _MaxStack
  then _MaxStack:=N_Stack;
if N_Stack > SMAX then SMAX:=N_Stack;
//{$ENDIF}
end;


procedure TCompiler.SetReg(R: Integer);
begin
//1 - EAX; 2 - EBX; 3 - ECX; 4 - EDX;
REG[R]:=1;
end;


procedure TCompiler.SetRegA(R: Integer; SC: Integer);
begin //для установки из-вне принудительного сохранения регистров
//1 - EAX; 2 - EBX; 3 - ECX; 4 - EDX; 5 - ESP; 6 - EBP; 7 - ESI; 8 - EDI;
REGA[R]:=SC;
end;

function  TCompiler.GetReg(R: Integer): Integer;
begin
 if (REG[R] = 1) or (REGA[R] = 1) then GetReg:=1 else GetReg:=0;
end;

procedure TCompiler.SaveFuncReg(I: Integer);
var
N,k,E: Integer;
begin
  N:=FuncList[Interp[I].Code].SaveReg;
  for k:=0 to 7 do
  begin
    E:=0;
    asm
     push eax
     push ebx

     mov  eax,N
     mov  ebx,k
     bt   eax,ebx
     jnc  @@1
     mov  E,1
     @@1:
     pop  ebx
     pop  eax
    end;

    if E = 1 then SetReg(k+1);
  end;
end;



procedure TCompiler.SaveReg;
var
PP: array [0..7] of byte;
i,L,j,k: integer;
begin
L:=-1;

for i:=1 to 8 do
begin
 PP[i-1]:=0;
if (REG[i] <> 0) or (REGA[i] <> 0) then
 begin
 inc(L); PP[L]:=i;
 end;
end;

if L > -1 then
begin
 j:=High(ICOMP);
 SetLength(ICOMP,Length(ICOMP)+2*(L+1));

 for i:=j downto 0 do
 begin
 ICOMP[i+(L+1)]:=ICOMP[i];
 end;

 for i:=0 to (L{+1}) do
 begin
  if PP[i] = 1 then ICOMP[i]:=$50 else
  if PP[i] = 2 then ICOMP[i]:=$53 else
  if PP[i] = 3 then ICOMP[i]:=$51 else
  if PP[i] = 4 then ICOMP[i]:=$52 else
  if PP[i] = 5 then ICOMP[i]:=$54 else
  if PP[i] = 6 then ICOMP[i]:=$55 else
  if PP[i] = 7 then ICOMP[i]:=$56 else
  if PP[i] = 8 then ICOMP[i]:=$57;
 end;

 k:=0;
 for i:=(L{+1}) downto 0 do
 begin
  if PP[i] = 1 then
   begin ICOMP[j+(L+1)+k+1]:=$58; inc(k); end else
  if PP[i] = 2 then
   begin ICOMP[j+(L+1)+k+1]:=$5B; inc(k); end else
  if PP[i] = 3 then
   begin ICOMP[j+(L+1)+k+1]:=$59; inc(k); end else
  if PP[i] = 4 then
   begin ICOMP[j+(L+1)+k+1]:=$5A; inc(k); end else
  if PP[i] = 5 then
   begin ICOMP[j+(L+1)+k+1]:=$5C; inc(k); end else
  if PP[i] = 6 then
   begin ICOMP[j+(L+1)+k+1]:=$5D; inc(k); end else
  if PP[i] = 7 then
   begin ICOMP[j+(L+1)+k+1]:=$5E; inc(k); end else
  if PP[i] = 8 then
   begin ICOMP[j+(L+1)+k+1]:=$5F; inc(k); end;


 end;

end;

//RET;
end;



procedure TCompiler.SaveRes(Adr,RType,Shift: Cardinal);
var
PP: array [0..7] of byte;
i,L,j,k: integer;
begin
if (Adr <> 0) and (RType <> 0) then
begin
 case Adr of
 1:   FSTPA(RType,Shift);
 2:   FSTPB(RType,Shift);
 3:   FSTPC(RType,Shift);
 4:   FSTPD(RType,Shift);
 5:   FSTPESP(RType,Shift)   //non-doc
 else
      FSTPM(Adr,RType);
end;
end;

//RET;

end;



function TCompiler.IsLevelLoad(I: Integer): Boolean;
label endp;
var
NM,NL,k: Integer;
begin
if F_Mode = C_EmlXchBranch then
begin
 if Interp[I].NL = 1 then IsLevelLoad:=False
 else
 IsLevelLoad:=True;
end
else
begin
 NM:=Interp[I].NM;
 NL:=Interp[I].NL;

 for k:=0 to NL-2 do
 begin
  if Interp[NM].RData[k] = _FPU then
  begin
   IsLevelLoad:=True; goto endp;
  end;
 end;

 IsLevelLoad:=False;
end;
endp:
end;



function TCompiler.IsLevelLoadA(I: Integer): Integer;
var
n,k,l: Integer;
begin
n:=-1;
l:=0;
 for k:=0 to High(Interp[I].RData) do
 begin
  if Interp[I].RData[k] = _FPU then
  begin
   inc(l);
   n:=k;
  end;
 end;

 if n = -1 then IsLevelLoadA:=0
 else
 begin
  k:=Interp[i].SGN[n];
  if (l = 1) and (k = _DIV) then IsLevelLoadA:=_DIV
  else
  IsLevelLoadA:=_MUL;
  //если l > 0, то деление уже выполнено
 end;
end;

function TCompiler.SizeArg(VType: Integer): Integer;
begin
  case VType of
    _Single:     SizeArg:=4;
    _Integer:    SizeArg:=4;
    _Double:     SizeArg:=8;
    _Extended:   SizeArg:=12;
  end;
end;

procedure TCompiler.AddCommand(I: Integer);
var
N,k,j,NS,OVF: Integer;
begin

//запись в стек только для:
//(1) несовместимых (по стеку) комманд
//(2) многоаргументных комманд
//для добавляемых ф-ий запись не выполняется


{if Interp[I].Code = C_CopyStack then
begin
CopyStack(I);
end
else }
if Interp[I].Code = C_NOP then
begin
EndFuncCom(I);
end
else
if Interp[I].Code = C_PACKAGE then
begin
 PKGCMPL(I);
end
else
if Interp[I].Code = C_LDSC then
begin
 FLD(WriteData(Interp[i].V2,_Float,_Load),F_ParamType);
end
else
if Interp[i].Code = C_LDSF then
begin
 FLD(TAddress(Interp[i].FV1),GetVarType(Interp[i].FV1));
end
else
if Interp[i].Code = C_LDSI then
begin
 FILD(TAddress(Interp[i].IV1));
end
else
if Interp[i].Code = C_FAVB then
begin
 FAVB(I);
end
else
if Interp[i].Code = C_IAVB then
begin
 IAVB(I);
end
else
if Interp[i].Code = C_AIFB then
begin
 AIFB(I);
end
else
if Interp[i].Code = C_MUL then
begin
 MUL(I);
end
else
if Interp[i].Code = C_AAI then
begin
 AAI(I);
end
else
if Interp[i].Code = C_AFI then
begin
 AFI(I);
end
else
if Interp[i].Code = C_MAF then
begin
 MAF(I);
end
else
if Interp[i].Code = C_AAF then
begin
 AAF(I);
end
else
if Interp[i].Code = C_ADD  then
begin
  ADD(I);
end
else
if FuncList[Interp[i].Code].FType = 1 then
begin
 FUNC1(I);
end
else
if FuncList[Interp[i].Code].FType = 2 then
begin
 FUNC2(I);
end
else
if FuncList[Interp[i].Code].FType = 3 then
begin
 FUNC3(I);
end
else
if FuncList[Interp[i].Code].FType = 4 then
begin
 FUNC4(I);
end
else
//EXTERNAL FUNCTION
if {Interp[i].Code > LInternalFuncList}FuncList[Interp[i].Code].FType < 0 then
begin
{if E_OverFlow = True then OVF:=1 else OVF:=0; //исползуется в (FType = -5, NST <> -1)
//добавляемые ф-ии только в режиме F_SaveStack = False: (за исключением FType = -5,NST <> -1)
E_OverFlow:=True;
}
//передача адреса параметров через память (EAX,EBX,ECX,EDX,ESP):
if (FuncList[Interp[i].Code].FType <= -3) and   (FuncList[Interp[i].Code].FType >= -7) then
begin
 AddFuncMEM(I);
end
else
//передача параметров через Stack (FPU):
if (FuncList[Interp[i].Code].FType = -8) then
begin
 AddFuncFPU(I);
end
else
//передача  параметров через Stack (CPU):
if -FuncList[Interp[i].Code].FType = 10 then
begin
 AddFuncCPU(I);
end
else
//функции с переменным числом аргументов:
if (FuncList[Interp[i].Code].FType <= -11) and   (FuncList[Interp[i].Code].FType >= -14) then
begin
 AddFuncINF(I);
end
else
begin
 //ERROR
 //Wrong type additional function
end;

end;


end;



procedure TCompiler.AddFuncMEM(I: Integer);
var
k,T,N,S,IdS: Integer;
begin
IdS:=0;
 if FuncList[Interp[i].Code].Arg  > 0 then
 begin
  if FuncList[Interp[i].Code].FType = -3 then
  MOVA1(TAddress(@Func.Stack[Interp[i].S]))
  else
  if FuncList[Interp[i].Code].FType = -4 then
  MOVB1(TAddress(@Func.Stack[Interp[i].S]))
  else
  if FuncList[Interp[i].Code].FType = -5 then
  MOVC1(TAddress(@Func.Stack[Interp[i].S]))
  else
  if FuncList[Interp[i].Code].FType = -6 then
  MOVD1(TAddress(@Func.Stack[Interp[i].S]))
  else
  if (FuncList[Interp[i].Code].FType = -7) and (FuncList[Interp[i].Code].Set_Id = 1) then
  begin
    if FuncList[Interp[i].Code].Arrow = 1 then
    begin
      PUSHM(TAddress(@Func.Stack[Interp[i].S]));
      PUSHM(FuncList[Interp[i].Code].Id_Func);
    end
    else
    if FuncList[Interp[i].Code].Arrow = 0 then
    begin
      PUSHM(FuncList[Interp[i].Code].Id_Func);
      PUSHM(TAddress(@Func.Stack[Interp[i].S]));
    end;
    IdS:=1;
  end
  else
  if (FuncList[Interp[i].Code].FType = -7) then
  PUSHM(TAddress(@Func.Stack[Interp[i].S]));

  if (FuncList[Interp[i].Code].FType = -3) then
  MOVB1(TAddress(FuncList[Interp[i].Code].Addr))
  else
  MOVA1(TAddress(FuncList[Interp[i].Code].Addr))
 end;

 //выгрузка аргументов из стека (если есть: _FPU)
 if F_SaveStack = True then
 begin
  //т.к. в FPU-стеке запись наоборот:
  for k:=FuncList[Interp[i].Code].Arg downto 1 do
  begin
   if Interp[I].RData[k-1] = _FPU then
   begin

    if FuncList[Interp[I].Code].ArgType = _Differ then
        T:=FuncList[Interp[I].Code].ArgTypeList[k-1]
    else
        T:=FuncList[Interp[I].Code].ArgType;

    if (F_Mode = C_Compile) and (F_CloseArg = True) then  S:=Interp[I].SNExtArg[k-1]
    else S:=0;

    FSTPM(TAddress(@Func.Stack[Interp[I].S+k-1])-S,T);
   end;
  end;
 end;


 if (FuncList[Interp[i].Code].Set_Id = 1) and (IdS = 0) then
 begin
  PUSHM(FuncList[Interp[i].Code].Id_Func);
 end;

 if (FuncList[Interp[i].Code].FType = -3) then CALLB else CALLA;


 if FuncList[Interp[i].Code].Set_Id = 1 then N:=4 else N:=0;
 if FuncList[Interp[i].Code].FType = -7  then N:=N+4;
 if FuncList[Interp[i].Code].CLST = 1 then ADDESP(N);

 FAB12(I);

 if (FuncList[Interp[i].Code].NST <> -1)  and (F_SaveStack = True) then
 begin
  CheckStack(FuncList[Interp[i].Code].NST);
  CheckStack(-(FuncList[Interp[i].Code].NST-1));
 end
 else
 E_OverFlow:=True;

end;




procedure TCompiler.AddFuncCPU(I: Integer);
var
k,SS,T,N,XCH,NS,VType,DS,Sz,F1,M1,Reg: Integer;

        procedure PUSHARG(VType,S: Integer);
        begin
           if (VType = _Integer) or (VType = _Single) then
            PUSHF(TAddress(@Func.Stack[Interp[i].S+S]))
           else
           if VType = _Double then
           begin
            PUSHF(TAddress(@Func.Stack[Interp[i].S+S])+4);
            PUSHF(TAddress(@Func.Stack[Interp[i].S+S]));
           end
           else
           if VType = _Extended then
           begin
            PUSHF(TAddress(@Func.Stack[Interp[i].S+S])+8);
            PUSHF(TAddress(@Func.Stack[Interp[i].S+S])+4);
            PUSHF(TAddress(@Func.Stack[Interp[i].S+S]));
           end;
        end;




  procedure ArgInMEM_FPU(I,DS,Reg: Integer);
    var
      k,VType1,VType2,cn,SS,Sz,N,PS,f,ID: Integer;
    begin
      //Reg=_MEM - F_SaveStack=False

      PS:=0;

      if (FuncList[Interp[i].Code].ARROW = 1)  and
         (FuncList[Interp[i].Code].Set_Id = 1) then
      begin
         DS:=DS-4;
      end
      else
      if (FuncList[Interp[i].Code].ARROW = 0)  then
      begin
       DS:=0;
       if (FuncList[Interp[i].Code].Set_Id = 1) then
        PUSHM(FuncList[Interp[i].Code].Id_Func);
      end;


         N:=FuncList[Interp[i].Code].Arg-1;


         //передача всех FPU-арг.:
       for k:=N downto 0 do
       begin
          if FuncList[Interp[i].Code].ArgType = _Differ then
             VType:=FuncList[Interp[i].Code].ArgTypeList[k] else
             VType:=FuncList[Interp[i].Code].ArgType;

          Sz:=SizeArg(VType);

          if  (Interp[I].RData[k] = _FPU) and (Reg <> _MEM) then
          begin
            if FuncList[Interp[i].Code].ARROW = 1 then
            begin
             FSTPESP(VType,-DS);
             DS:=DS-Sz;
            end
            else
            if FuncList[Interp[i].Code].ARROW = 0 then
            begin
             DS:=DS+Sz;
             FSTPESP(VType,-DS);
            end
          end
          else
          //if  Interp[I].RData[k] = _MEM then
          begin
             if FuncList[Interp[i].Code].ARROW = 1 then
                DS:=DS-SizeArg(VType)
             else
             if FuncList[Interp[i].Code].ARROW = 0 then
                DS:=DS+SizeArg(VType);
          end;
       end;


         for k:= 0 to N do
         begin
           if FuncList[Interp[i].Code].ARROW = 1 then cn:=k
           else
           if FuncList[Interp[i].Code].ARROW = 0 then cn:=N-k;

           if FuncList[Interp[i].Code].ArgType = _Differ then
              VType:=FuncList[Interp[i].Code].ArgTypeList[cn] else
              VType:=FuncList[Interp[i].Code].ArgType;


           if  (Interp[I].RData[cn] = _FPU) and (Reg <> _MEM) then
           begin
             PS:=PS+SizeArg(VType);
           end
           else
           //if  Interp[I].RData[cn] = _MEM then
           begin
             SUBESP(PS);
             PUSHARG(VType,cn);
             PS:=0;
           end;

         end;


      if (FuncList[Interp[i].Code].Set_Id = 1) then
      begin
        SUBESP(PS);
        if (FuncList[Interp[i].Code].ARROW = 1) then
         PUSHM(FuncList[Interp[i].Code].Id_Func);
      end
      else
      if (FuncList[Interp[i].Code].Set_Id = 0) then
         SUBESP(PS);

    end;


begin
//Id_Func - после переменных: func(x1,...,xn,Id_Func);
NS:=0;
DS:=0;
//DS - определение глубины стека для передаваемых аргументов:
if FuncList[Interp[i].Code].ArgType = _Differ then
begin
 for k:=0 to  High(Interp[I].RData) do
 begin
   VType:=FuncList[Interp[i].Code].ArgTypeList[k];
     case VType of
     _Single:     DS:=DS+4;
     _Integer:    DS:=DS+4;
     _Double:     DS:=DS+8;
     _Extended:   DS:=DS+12;  //12 - т.к. PUSH EAX вместо PUSH AX (12 вместо 10) - так компилирует DELPHI
     end;
 end
end
else
begin
 VType:=FuncList[Interp[i].Code].ArgType;
 case VType of
  _Single:     Sz:=4;
  _Integer:    Sz:=4;
  _Double:     Sz:=8;
  _Extended:   Sz:=12;
 end;
 DS:=FuncList[Interp[i].Code].Arg*Sz;
end;

if FuncList[Interp[i].Code].Set_Id = 1 then DS:=DS+4;


//Reg=1(все аргументы в FPU) ,Reg=2(все аргументы в MEM), Reg=3(FPU&MEM)
M1:=0;F1:=0;
for k:=0 to  High(Interp[I].RData) do
begin
 if Interp[I].RData[k] = _MEM then M1:=1
 else
 if  Interp[I].RData[k] = _FPU then F1:=1
end;

if (F1 = 1) and (M1 = 0) then Reg:=1
else
if (F1 = 0) and (M1 = 1) then Reg:=2
else Reg:=3;

if (F_SaveStack = False) or (FuncList[Interp[i].Code].NST = -1) then Reg:=2;


ArgInMEM_FPU(I,DS,Reg);



 MOVA1(TAddress(FuncList[Interp[i].Code].Addr));
 CALLA;

 if FuncList[Interp[i].Code].CLST = 1 then
 begin
  ADDESP(DS);
 end;

 FAB12(I);
 if (FuncList[Interp[i].Code].NST <> -1)  and (F_SaveStack = True) then
 begin
  CheckStack(FuncList[Interp[i].Code].NST);
  CheckStack(-(FuncList[Interp[i].Code].NST-1));
 end
 else
 E_OverFlow:=True;


end;




procedure TCompiler.AddFuncFPU(I: Integer);
var
N,k: Integer;
begin

if (FuncList[Interp[i].Code].NST = -1) or (F_SaveStack = False) then
begin
    for k:= 0 to FuncList[Interp[i].Code].Arg-1 do
    begin
      if FuncList[Interp[i].Code].ArgType = _Differ then
       FLD(TAddress(@Func.Stack[Interp[i].S+k]),FuncList[Interp[i].Code].ArgTypeList[k])
      else
       FLD(TAddress(@Func.Stack[Interp[i].S+k]),FuncList[Interp[i].Code].ArgType);
    end; 
end;
//частичное выталкивание аргументов из памяти в DL не производится

 if FuncList[Interp[i].Code].Set_Id = 1 then
 begin
  PUSHM(FuncList[Interp[i].Code].Id_Func);
 end;

 MOVA1(TAddress(FuncList[Interp[i].Code].Addr));
 CALLA;

 if FuncList[Interp[i].Code].Set_Id = 1 then N:=4 else N:=0;
 if FuncList[Interp[i].Code].CLST = 1 then ADDESP(N);

 FAB12(I);


 if (FuncList[Interp[i].Code].NST <> -1)  and (F_SaveStack = True) then
 begin
  CheckStack(FuncList[Interp[i].Code].NST);
  CheckStack(-(FuncList[Interp[i].Code].NST+FuncList[Interp[i].Code].Arg-1));
 end
 else
 E_OverFlow:=True;


end;





procedure TCompiler.AddFuncINF(I: Integer);
var
CT,k,T,N,DS: Integer;
S: Cardinal;
begin
//выгрузка аргументов из стека (если есть: _FPU)
 if F_SaveStack = True then
 begin
  //т.к. в FPU-стеке запись наоборот:
  for k:=FuncList[Interp[i].Code].Arg downto 1 do
  begin
   if Interp[I].RData[k-1] = _FPU then
   begin

    if (F_Mode = C_Compile) and (F_CloseArg = True) then  S:=Interp[I].SNExtArg[k-1]
    else S:=0;

    T:=FuncList[Interp[I].Code].ArgType;
    FSTPM(TAddress(@Func.Stack[Interp[I].S+k-1])-S,T);

   end;
  end;
 end;


DS:=0;
//Infinite EAX,EBX
if -FuncList[Interp[i].Code].FType = 11 then
begin
 MOVA1(TAddress(@Func.Stack[Interp[i].S]));
 MOVB1(Interp[i].N);
 MOVC1(TAddress(FuncList[Interp[i].Code].Addr));
 CT:=1;
end
else
//Infinite EBX,ECX
if -FuncList[Interp[i].Code].FType = 12 then
begin
 MOVB1(TAddress(@Func.Stack[Interp[i].S]));
 MOVC1(Interp[i].N);
 MOVA1(TAddress(FuncList[Interp[i].Code].Addr));
 CT:=0;
end
else
//Infinite ECX,EDX
if -FuncList[Interp[i].Code].FType = 13 then
begin
 MOVC1(TAddress(@Func.Stack[Interp[i].S]));
 MOVD1(Interp[i].N);
 MOVA1(TAddress(FuncList[Interp[i].Code].Addr));
 CT:=0;
end
else
//Infinite Stack (Adr,Length,[ID])
if -FuncList[Interp[i].Code].FType = 14 then
begin

 if  FuncList[Interp[i].Code].ARROW = 0  then
 begin
  if FuncList[Interp[i].Code].Set_Id = 1 then
  begin
   PUSHM(FuncList[Interp[i].Code].Id_Func);
  end;
  PUSHM(Interp[i].N);
  PUSHM(TAddress(@Func.Stack[Interp[i].S]));
 end
 else
 if  FuncList[Interp[i].Code].ARROW = 1  then
 begin
  PUSHM(TAddress(@Func.Stack[Interp[i].S]));
  PUSHM(Interp[i].N);
  if FuncList[Interp[i].Code].Set_Id = 1 then
  begin
   PUSHM(FuncList[Interp[i].Code].Id_Func);
  end;
 end;

 MOVA1(TAddress(FuncList[Interp[i].Code].Addr));
 DS:=8;
 CT:=0;
end;



//реинициализация: arg=-1(INFINITE), т.к. при разборе ф-ии arg=текущему числу перем. в ф-ии
//ExternalFuncList[Interp[i].FI].arg:=-1;

if (FuncList[Interp[i].Code].Set_Id = 1) and (DS = 0) then
   PUSHM(FuncList[Interp[i].Code].Id_Func);

if CT = 1 then CALLC else CALLA;

if FuncList[Interp[i].Code].Set_Id = 1 then DS:=DS+4;

if FuncList[Interp[i].Code].CLST = 1 then ADDESP(DS);


FAB12(I);
if (FuncList[Interp[i].Code].NST <> -1)  and (F_SaveStack = True) then
begin
 CheckStack(FuncList[Interp[i].Code].NST);
 CheckStack(-(FuncList[Interp[i].Code].NST-1));
end
else
E_OverFlow:=True;

end;



procedure TCompiler.POPFPU;
var
i,adr: Cardinal;
begin
adr:=Cardinal(@SFPU[1]);
 for i:=0 to N_Stack do
 begin
  FSTPM(adr+i*10,F_DataType);
 end;
end;


procedure TCompiler.PUSHFPU;
var
i,adr: Cardinal;
begin
adr:=Cardinal(@SFPU[1]);
 for i:=0 to N_Stack do
 begin
  FLD(adr+i*10,F_DataType);
 end;
end;



procedure TCompiler.AddByte(B: Byte);
var
j: Integer;
begin
if F_Mode = C_Compile then
begin
 j:=High(ICOMP)+1;
 SetLength(ICOMP,Length(ICOMP)+1);
 ICOMP[j]:=B;
end;
end;



procedure TCompiler.AddWord(B1: Byte; B2: Byte);
var
j: Integer;
begin
if F_Mode = C_Compile then
begin
 j:=High(ICOMP)+1;
 SetLength(ICOMP,Length(ICOMP)+2);
 ICOMP[j]:=B1; ICOMP[j+1]:=B2;
end;
end;



procedure TCompiler.AddCom(B1: Byte);
begin
if F_Mode = C_Compile then
begin
 SetLength(ICOMP,Length(ICOMP)+1);
 ICOMP[High(ICOMP)]:=B1;
end;
end;

procedure TCompiler.AddCom(B1,B2: Byte);
begin
if F_Mode = C_Compile then
begin
 SetLength(ICOMP,Length(ICOMP)+2);
 ICOMP[High(ICOMP)-1]:=B1; ICOMP[High(ICOMP)]:=B2;
end;
end;

procedure TCompiler.AddCom(B1,B2,B3: Byte);
begin
if F_Mode = C_Compile then
begin
 SetLength(ICOMP,Length(ICOMP)+3);
 ICOMP[High(ICOMP)-2]:=B1; ICOMP[High(ICOMP)-1]:=B2; ICOMP[High(ICOMP)]:=B3;
end;
end;

procedure TCompiler.AddCom(B1: Byte; Adr: TAddress);
var
P: ^Cardinal;
begin
if F_Mode = C_Compile then
begin
 SetLength(ICOMP,Length(ICOMP)+5);
 ICOMP[High(ICOMP)-4]:=B1;
 P:=@ICOMP[High(ICOMP)-3];
 P^:=Adr;
end;
end;


procedure TCompiler.AddCom(B1,B2: Byte; Adr: TAddress);
var
P: ^Cardinal;
begin
if F_Mode = C_Compile then
begin
 SetLength(ICOMP,Length(ICOMP)+6);
 ICOMP[High(ICOMP)-5]:=B1; ICOMP[High(ICOMP)-4]:=B2;
 P:=@ICOMP[High(ICOMP)-3];
 P^:=Adr;
end;
end;

procedure TCompiler.AddCom(B1,B2,B3: Byte; Adr: TAddress);
var
P: ^Cardinal;
begin
if F_Mode = C_Compile then
begin
 SetLength(ICOMP,Length(ICOMP)+7);
 ICOMP[High(ICOMP)-6]:=B1; ICOMP[High(ICOMP)-5]:=B2; ICOMP[High(ICOMP)-4]:=B3;
 P:=@ICOMP[High(ICOMP)-3];
 P^:=Adr;
end;
end;


procedure TCompiler.AddCom(B1,B2,B3: Byte; N: Integer);
var
P: ^Integer;
begin
if F_Mode = C_Compile then
begin
 SetLength(ICOMP,Length(ICOMP)+7);
 ICOMP[High(ICOMP)-6]:=B1; ICOMP[High(ICOMP)-5]:=B2; ICOMP[High(ICOMP)-4]:=B3;
 P:=@ICOMP[High(ICOMP)-3];
 P^:=N;
end;
end;


procedure TCompiler.AddCom(B1: Byte; N: Integer);
var
P: ^Integer;
begin
if F_Mode = C_Compile then
begin
 SetLength(ICOMP,Length(ICOMP)+5);
 ICOMP[High(ICOMP)-4]:=B1;
 P:=@ICOMP[High(ICOMP)-3];
 P^:=N;
end;
end;


procedure TCompiler.AddCom(B1,B2: Byte; N: Integer);
var
P: ^Integer;
begin
if F_Mode = C_Compile then
begin
 SetLength(ICOMP,Length(ICOMP)+6);
 ICOMP[High(ICOMP)-5]:=B1; ICOMP[High(ICOMP)-4]:=B2;
 P:=@ICOMP[High(ICOMP)-3];
 P^:=N;
end;
end;


procedure TCompiler.FLD(N: TAddress; VType: Integer);
begin
case VType of
_Single:    AddCom($D9,$05,N);
_Double:    AddCom($DD,$05,N);
_Extended:  AddCom($DB,$2D,N);
_Integer:   AddCom($DB,$05,N);
end;
CheckStack(1);
end;


procedure TCompiler.FSTPM(N: TAddress; VType: Integer);
begin

case VType of
_Single:   AddCom($D9,$1D,N);
_Extended: AddCom($DB,$3D,N);
_Double:   AddCom($DD,$1D,N);
_Integer:  AddCom($DB,$1D,N);
end;

CheckStack(-1);
end;


procedure TCompiler.AddEndCommand(I: Integer);
var
N,J,S,SS: Integer;
begin

 if F_SaveStack = False then
 begin
  if Interp[i].Neg = 1  then FCHS;

  //выталкивание только если следующая комманда:
  //(1) несовместима (по стеку)
  //(2) многоаргументная
  //(3) добавляемая ф-ия типов: Func[I]^.FType < 0
  //выталкивание не производится:
  //для последней ф-ии (Func[LFunc-1])
  //для комманды NOP

  if  (I < LFunc-1)   then
  begin
   if ((Interp[I+1].S <> Interp[i].S) or (Interp[I+1].N > 1) or
      (FuncList[Interp[I+1].Code].FType < 0 )) and
      (Interp[i].Code <> C_NOP) then
   begin
    N:=TAddress(@Func.Stack[Interp[i].S]);
    //для обычных комманд:
    if Interp[I].ExtArg = _None  then
       FSTPM(N,F_DataType)
    else
    //добавляемые ф-ии:
    begin
      S:=Interp[I].S;
      N:=Cardinal(@Func.Stack[S])-Interp[i].SExtArg;
      FSTPM(N,Interp[i].ExtArg);
    end;
   end
  end
 end

 else

 if F_SaveStack = True then
 begin
  if Interp[I].SData = _FPU then
  begin
   if {Interp[i].NL > 1} IsLevelLoad(I)  then
   begin
    if (Interp[i].I = _SUB) and (Interp[i].Neg = 0)  then FSUB
    else
    if (Interp[i].I = _SUB) and (Interp[i].Neg = 1)  then FADD
    else
    if (Interp[i].I = _NOP) and (Interp[i].Neg = 1)   then FCHS
    else
    if Interp[i].I = _ADD  then FADD
    else
    begin
     if Interp[i].Neg = 1   then FCHS;

     if Interp[i].I = _MUL then FMULP1
     else
     if Interp[i].I = _DIV then FDIVP
     else
     if Interp[i].I = _DIVR then FDIVRP;
    end;
   end
   else
   //загрузка первой комманды на уровень
   begin
    if (Interp[i].I = _SUB)  and (Interp[i].Neg = 0)  then FCHS
    else
    if (Interp[i].I <> _SUB) and (Interp[i].Neg = 1)  then FCHS;
  end;
  end
  //SData = _MEM
  else
  if Interp[I].SData = _MEM then
  begin
    if Interp[I].Neg = 1   then FCHS;
    N:=TAddress(@Func.Stack[Interp[I].S]);
    //для обычных комманд:
    if Interp[I].ExtArg = _None  then
    FSTPM(N,F_DataType)
    else
    //для аргументов добавляемых ф-ий:
    begin
     S:=Interp[I].S;
     N:=Cardinal(@Func.Stack[S])-Interp[i].SExtArg;
     FSTPM(N,Interp[i].ExtArg);
    end;
  end;
 end;


end;



procedure TCompiler.AddAddress(Adr: TAddress);
var
AB: TArray4;
j: Integer;
P: ^Cardinal;
begin
if F_Mode = C_Compile then
begin
 j:=High(ICOMP)+1;
 SetLength(ICOMP,Length(ICOMP)+4);
 P:=@ICOMP[j];
 P^:=Adr;
end;
end;




procedure TCompiler.AddInteger(Int: Integer);
var
AB: TArray4;
j: Integer;
P: ^Integer;//Pointer;
begin
if F_Mode = C_Compile then
begin
 j:=High(ICOMP)+1;
 SetLength(ICOMP,Length(ICOMP)+4);
 P:=@ICOMP[j];
 P^:=Int;
end;
end;



procedure TCompiler.FAVB(I: Integer);
begin
if Interp[i].V1 <> 0 then
begin
 FLD(TAddress(Interp[i].FV1),GetVarType(Interp[i].FV1));
 if  (Interp[i].V1 <> 1) and (Interp[i].V1 <> -1) then
 FMUL(Interp[i].V1,WriteData(Interp[i].V1,_Float,_MulDiv),F_ParamType);
 if Interp[i].V2 <> 0 then
 begin
  if Interp[i].V1 = -1 then
  FSUBR(WriteData(Interp[i].V2,_Float,_AddSub),F_ParamType)
  else
  FADD(Interp[i].V2,WriteData(Interp[i].V2,_Float,_AddSub),F_ParamType);
 end
 else
 if (Interp[i].V1 = -1) then FCHS;
end
else
FLD(WriteData(Interp[i].V2,_Float,_Load),F_ParamType);
end;



procedure TCompiler.FAVBM(I,k: Integer);
//используется в MUL
begin
FLD(TAddress(Interp[i].AFB[k].PF),GetVarType(Interp[i].AFB[k].PF));

if Interp[i].AFB[k].A = -1 then
   FSUBR(WriteData(Interp[i].AFB[k].B,_Float,_AddSub),F_ParamType)
else
  begin
    FMUL(Interp[i].AFB[k].A,WriteData(Interp[i].AFB[k].A,_Float,_MulDiv),F_ParamType);
    FADD(Interp[i].AFB[k].B,WriteData(Interp[i].AFB[k].B,_Float,_AddSub),F_ParamType);
  end;
end;




procedure TCompiler.FAVBM1(I: Integer);
//используется в MUL
begin
FLD(TAddress(Interp[i].PM[1]),GetVarType(Interp[i].PM[1]));

if Interp[i].PN[1] = -1 then
begin
   if Interp[i].PN[2] = 0 then FCHS
   else
   FSUBR(WriteData(Interp[i].PN[2],_Float,_AddSub),F_ParamType);
end
else
  begin
    FMUL(Interp[i].PN[1],WriteData(Interp[i].PN[1],_Float,_MulDiv),F_ParamType);
    FADD(Interp[i].PN[2],WriteData(Interp[i].PN[2],_Float,_AddSub),F_ParamType);
  end;
end;


function TCompiler.FAVB1(I: Integer): Boolean;
begin
FAVB1:=False;
if Interp[i].F1 <> 0 then
begin
 if Interp[i].F1 = 1 then
 begin
  FADD(TAddress(Interp[i].FV1),GetVarType(Interp[i].FV1));
  FADD(Interp[i].F2,WriteData(Interp[i].F2,_Float,_AddSub),F_ParamType);
 end
 else
 if  Interp[i].F1 = -1 then
 begin
  FSUB(TAddress(Interp[i].FV1),GetVarType(Interp[i].FV1));
  FADD(Interp[i].F2,WriteData(Interp[i].F2,_Float,_AddSub),F_ParamType);
 end
 else
 begin
  FLD(TAddress(Interp[i].FV1),GetVarType(Interp[i].FV1));
   FMUL(Interp[i].F1,WriteData(Interp[i].F1,_Float,_MulDiv),F_ParamType);
  FADD(Interp[i].F2,WriteData(Interp[i].F2,_Float,_AddSub),F_ParamType);
  FADD;
 end;

FAVB1:=True;
end
else
if Interp[i].F2 <> 0 then
begin
FADD(WriteData(Interp[i].F2,_Float,_AddSub),F_ParamType);
FAVB1:=True;
end;
end;



procedure TCompiler.FCHS;
begin
AddWord($D9,$E0);
end;







procedure TCompiler.FAVBF(I: Integer);
begin
FAVB(I);
end;



procedure TCompiler.FAVBF1(I: Integer);
begin
if Interp[i].V3 <> 0 then
begin
 FLD(TAddress(Interp[i].FV2),GetVarType(Interp[i].FV2));
 if  (Interp[i].V3 <> 1) and (Interp[i].V3 <> -1) then
 FMUL(Interp[i].V3,WriteData(Interp[i].V3,_Float,_MulDiv),F_ParamType);
 if Interp[i].V4 <> 0 then
 begin
  if Interp[i].V3 = -1 then
  FSUBR(WriteData(Interp[i].V4,_Float,_AddSub),F_ParamType)
  else
  FADD(Interp[i].V4,WriteData(Interp[i].V4,_Float,_AddSub),F_ParamType);
 end
 else
 if (Interp[i].V3 = -1) then FCHS;
end
else
FLD(WriteData(Interp[i].V4,_Float,_Load),F_ParamType);
end;





procedure TCompiler.FAB12(I: Integer);
begin
FMUL(Interp[i].F1,WriteData(Interp[i].F1,_Float,_MulDiv),F_ParamType);
FADD(Interp[i].F2,WriteData(Interp[i].F2,_Float,_AddSub),F_ParamType);
end;




procedure TCompiler.ASB(I: Integer);
begin
if Interp[i].F1 = -1 then AddWord($D9,$E0) else
if Interp[i].F1 <> 1 then
begin
 FADD(Interp[i].F1,WriteData(Interp[i].F1,_Float,_AddSub),F_ParamType);
end;

FADD(Interp[i].F2,WriteData(Interp[i].F2,_Float,_AddSub),F_ParamType);
end;




procedure TCompiler.FMUL(X: TFloatType; N: TAddress; VType: Integer);
begin
if X = -1 then FCHS else
if (X <> 1) and (X <> 0) then
begin
 FMUL(N,VType);
end;
end;


procedure TCompiler.FADD(X: TFloatType; N: TAddress; VType: Integer);
begin
if X <> 0 then
begin
 FADD(N,VType);
end;
end;


procedure TCompiler.FADD;
begin
 AddCom($DE,$C1);
 CheckStack(-1);
end;


procedure TCompiler.FADD2;
begin
 AddCom($D8,$C2);
end;


procedure TCompiler.FSUB;
begin
 AddCom($DE,$E9);
 CheckStack(-1);
end;


procedure TCompiler.FSUB(N: TAddress; VType: Integer);
begin
 if VType = _Extended then
 begin
  FLD(N,_Extended);
  FSUBP;
 end
 else
 if VType = _Double then
 begin
  AddCom($DC,$25,N);
 end
 else
 if VType = _Single then
 begin
   AddCom($D8,$25,N);
 end;
end;






procedure TCompiler.FSUBRP;
begin
 AddWord($DE,$E1);
 CheckStack(-1);
end;


procedure TCompiler.FSUBP;
begin
 AddWord($DE,$E9);
 CheckStack(-1);
end;


procedure TCompiler.FSUBR(N: TAddress; VType: Integer);
begin
 if VType = _Extended then
 begin
  FLD(N,VType);
  FSUBRP;
 end
 else
 if VType = _Double then
 begin
  AddCom($DC,$2D,N);
 end
 else
 if VType = _Single then
 begin
   AddCom($D8,$2D,N);
 end;
end;



procedure TCompiler.FMULP1;
begin
 AddWord($DE,$C9);
 CheckStack(-1);
end;

procedure TCompiler.FDIVP;
begin
 AddCom($DE,$F9);
 CheckStack(-1);
end;

procedure TCompiler.FDIVRP;
begin
 AddCom($DE,$F1);
 CheckStack(-1);
end;


procedure TCompiler.FDIVR1;
begin
 AddCom($DC,$3D);
 AddAddress(TAddress(@C1));
end;


procedure TCompiler.FDIV(N: TAddress; VType: Integer);
begin
 if VType = _Extended then
 begin
  FLD(N,_Extended);
  FDIVP;
 end
 else
 if VType = _Double  then
 begin
  AddCom($DC,$35,N);
 end
 else
 if VType = _Single then
 begin
   AddCom($D8,$35,N);
 end;
end;

procedure TCompiler.FDIVR(N: TAddress; VType: Integer);
begin
 if VType = _Extended then
 begin
 FLD(N,_Extended);
 FDIVRP;
 end
 else
 if VType = _Double then
 begin
 AddCom($DC,$3D,N);
 end
 else
 if VType = _Single then
 begin
   AddCom($D8,$3D,N);
 end;
end;



procedure TCompiler.FMUL(N: TAddress; VType: Integer);
begin
 if VType = _Extended then
 begin
  FLD(N,_Extended);
  FMULP1;
 end
 else
 if VType = _Double then
 begin
  AddCom($DC,$0D,N);
 end
 else
 if VType = _Single then
 begin
  AddCom($D8,$0D,N);
 end;
end;




procedure TCompiler.FADD(N: TAddress; VType: Integer);
begin
 if VType = _Extended then
 begin
  FLD(N,_Extended);
  FADD;
 end
 else
 if VType = _Double then
 begin
  AddCom($DC,$05,N);
 end
 else
 if VType = _Single then
 begin
   AddCom($D8,$05,N);
 end;
end;




procedure TCompiler.FMUL0;
begin
 AddWord($D8,$C8);
end;





procedure TCompiler.MAF(I: Integer);
var
k: Integer;
begin
FLD(TAddress(Interp[i].PM[1]),GetVarType(Interp[i].PM[1]));
for k:=2 to High(Interp[i].PM) do
begin
 FMUL(TAddress(Interp[i].PM[k]),GetVarType(Interp[i].PM[k]));
end;

FMUL(Interp[i].V1,WriteData(Interp[i].V1,_Float,_MulDiv),F_ParamType);
FADD(Interp[i].V2,WriteData(Interp[i].V2,_Float,_AddSub),F_ParamType);
end;



procedure TCompiler.AAF(I: Integer);
var
k,H: Integer;
begin


FLD(TAddress(Interp[i].PM[1]),GetVarType(Interp[i].PM[1]));
H:=High(Interp[i].PN);


if Interp[i].PN[H] <> 0 then
begin
 if Interp[i].PN[1] = -1 then
 FSUBR(WriteData(Interp[i].PN[H],_Float,_AddSub),F_ParamType)
 else
 begin
  FMUL(Interp[i].PN[1],WriteData(Interp[i].PN[1],_Float,_MulDiv),F_ParamType);
  FADD(Interp[i].PN[H],WriteData(Interp[i].PN[H],_Float,_AddSub),F_ParamType);
 end;
end
else
begin
 if Interp[i].PN[1] = -1 then FCHS else
 if Interp[i].PN[1] <> 1 then
  FMUL(Interp[i].PN[1],WriteData(Interp[i].PN[1],_Float,_MulDiv),F_ParamType);
end;


for k:=2 to High(Interp[i].PM) do
begin
 if Interp[i].PN[k] = -1 then
  FSUB(TAddress(Interp[i].PM[k]),GetVarType(Interp[i].PM[k]))
 else
 if Interp[i].PN[k] = 1  then
  FADD(TAddress(Interp[i].PM[k]),GetVarType(Interp[i].PM[k]))
 else
 begin
  FLD(TAddress(Interp[i].PM[k]),GetVarType(Interp[i].PM[k]));
  FMUL(Interp[i].PN[k],WriteData(Interp[i].PN[k],_Float,_MulDiv),F_ParamType);
  FADD;
 end;
end;


end;




procedure TCompiler.ADD(I: Integer);
var
k,j,LL,s: Integer;
BF: Boolean;
begin

  if F_SaveStack = False then
  begin

   //комманда с одним стеком - в ST(0), остальные загружаются:
   j:=Interp[i].S;
   if Interp[i].N > 1 then
   begin
    FLD(TAddress(@Func.Stack[j]),F_DataType);
   end;

   if  Interp[i].SGN[0] = _SUB   then FCHS;

   j:=1;
   for k:=Interp[i].S+1 to Interp[i].S+Interp[i].N-1 do
   begin
    if  Interp[i].SGN[j] = _ADD then FADD(TAddress(@Func.Stack[k]),F_DataType)
    else
    if  Interp[i].SGN[j] = _SUB then FSUB(TAddress(@Func.Stack[k]),F_DataType);
    inc(j);
   end;

  end
  else
  //выполнение операций с аргументами, находящимися в памяти (SData = _MEM):
  if F_SaveStack = True then
  begin
   LL:=0; S:=Interp[I].S;
   for j:=0 to High(Interp[I].RData) do
   begin
    if Interp[I].RData[j] = _FPU then LL:=1;
   end;

   for j:=0 to High(Interp[I].RData) do
   begin
    if Interp[I].RData[j] = _MEM then
    begin

     if LL = 1  then
     begin
      if (Interp[i].SGN[j] = _SUB)   then FSUB(TAddress(@Func.Stack[S]),F_DataType)
      else
      if (Interp[i].SGN[j] = _ADD)   then FADD(TAddress(@Func.Stack[S]),F_DataType);
     end
     else
     if LL = 0 then
     begin
      if (Interp[i].SGN[j] = _SUB)   then
      begin
       FLD(TAddress(@Func.Stack[S]),F_DataType);
       FCHS;
      end
      else
      if (Interp[i].SGN[j] = _ADD)   then FLD(TAddress(@Func.Stack[S]),F_DataType);
      LL:=1;
     end;
    end;
    inc(S);
   end;
  end;



//общее для F_SaveStack = True/False:
  if {Interp[i].AM = 0}Interp[i].DI = 0 then FAVB1(I)
  else
  if {Interp[i].AM = 1}Interp[i].DI = _AAF then
  begin
   AAF(I);
   FADD;
  end;


end;



procedure TCompiler.MUL(I: Integer);
var
k,j,l,f,f1,s,h,n,op,FD: Integer;
S1: String;
begin
S1:=Interp[i].ErS;
//f=1    - в стеке (FP) уже есть число
//f=0    -   стек (FP) пуст
//OP     - операция со стеком (последним эл-ом уровня, находящимся в FPU)
//f1=1   -  загружена  F1

f1:=0;

if F_SaveStack = True then
begin
 Op:=IsLevelLoadA(I);
 if Op <> 0 then f:=1 else f:=0;
end
else
//F_SaveStack=False:
begin
//последний эл-т уровня не выталкивается
 N:=Interp[i].N;
 if N = 0 then
 begin
  f:=0;
  OP:=0;
 end
 else
 if N = 1 then
 begin
  f:=1;
  OP:=Interp[I].SGN[0];
 end
 else
 if N > 1 then
 begin
  FLD(TAddress(@Func.Stack[Interp[I].S]),F_DataType);
  f:=1;
  OP:=Interp[I].SGN[0];
 end
 else
 begin
  f:=0;
  OP:=0;
 end;
end;


//общее для F_SaveStack = True/False:
//(a1*x1+b1)*...*(ak*xk+bk):
 if Length(Interp[i].AFB) > 0 then
 begin
  MUL_AFB(I,OP);
  OP:=0; f:=1;
 end;

//MUL/ARGF:  (ARGF = a1*x1+...+an*xn+b)(AAF)
 if {Interp[i].AM = 1}Interp[i].DI = _AAF then
 begin
  //т.е. если стек пуст, то принудительная загрузка F1:
  if (OP = 0) and (f = 0) then
  begin
    FLD(WriteData(Interp[i].F1,_Float,_Load),F_ParamType);
    f1:=1;
  end;
  MUL_AAF(I);
  OP:=0; f:=1;
 end
 else
//MUL/ARGF:  (ARGF = (a*x1*...*xn+b)(MAF)
 if {Interp[i].AM = 2}Interp[i].DI = _MAF then
 begin
  //т.е. если стек пуст, то принудительная загрузка F1:
  if (OP = 0) and (f = 0) then
  begin
    FLD(WriteData(Interp[i].F1,_Float,_Load),F_ParamType);
    f1:=1;
  end;
  MUL_MAF(I);
  OP:=0; f:=1;
 end;




if F_SaveStack = True then
begin
//возможны только 3 случая:
//(1)f=0; (2)f=1&OP=0; (3)f=1&OP<>0;
   S:=Interp[I].S;
           
   for j:=0 to High(Interp[I].RData) do
   begin
    if Interp[I].RData[j] = _MEM then
    begin
     if F = 1  then
     begin
      if OP <> 0 then
      begin
       if OP = _DIV then  FDIVR(TAddress(@Func.Stack[S]),F_DataType)
       else
       if (OP = _MUL) and (Interp[I].SGN[j] = _DIV) then  FDIV(TAddress(@Func.Stack[S]),F_DataType)
       else
       FMUL(TAddress(@Func.Stack[S]),F_DataType);
       OP:=0;
      end
      else
      if (Interp[i].SGN[j] = _MUL) then FMUL(TAddress(@Func.Stack[S]),F_DataType)
      else
      if (Interp[i].SGN[j] = _DIV)   then FDIV(TAddress(@Func.Stack[S]),F_DataType);
     end
     else
     if F = 0 then
     begin
      if (Interp[i].SGN[j] = _DIV)   then
      begin
       FLD(TAddress(@Func.Stack[S]),F_DataType);
       OP:=_DIV;
      end
      else
      if (Interp[i].SGN[j] = _MUL)   then FLD(TAddress(@Func.Stack[S]),F_DataType);
      F:=1;
     end;
    end;
    inc(S);
   end;

 end
 else
 //F_SaveStack = False:
 begin

    if N > 1 then
    begin
      S:=Interp[I].S+1;
      for k:=1 to N-1 do
      begin
       if OP = _DIV then
       begin
        FDIVR(TAddress(@Func.Stack[S]),F_DataType);
        OP:=0;
       end
       else
       if  Interp[i].SGN[k] = _MUL then  FMUL(TAddress(@Func.Stack[S]),F_DataType)
       else
       if  Interp[i].SGN[k] = _DIV then  FDIV(TAddress(@Func.Stack[S]),F_DataType);
       inc(S);
      end;
      OP:=0;
    end;

 end;



//для случая Const/S:
if OP = _DIV then FDIVR(WriteData(Interp[i].F1,_Float,_Load{искл.}),F_ParamType)
else
if F1 = 0 then FMUL(Interp[i].F1,WriteData(Interp[i].F1,_Float,_MulDiv),F_ParamType);

FADD(Interp[i].F2,WriteData(Interp[i].F2,_Float,_AddSub),F_ParamType);
end;




procedure TCompiler.MUL_AFB(I,OP: Integer);
var
f,k: Integer;
begin
//(a1*x1+b1)*...*(ak*xk+bk):
if OP <> 0 then f:=1 else f:=0;

      for k:=0 to High(Interp[i].AFB) do
      begin
        //A*X:
        if Interp[i].AFB[k].B = 0 then
        begin
          //стек пуст:
          if f = 0 then
          begin
           FLD(TAddress(Interp[i].AFB[k].PF),GetVarType(Interp[i].AFB[k].PF));
           FMUL(Interp[i].AFB[k].A,WriteData(Interp[i].AFB[k].A,_Float,_MulDiv),F_ParamType);
          end
          else
          //в стеке число (f = 1):
          begin
           if OP = _MUL then
            FMUL(TAddress(Interp[i].AFB[k].PF),GetVarType(Interp[i].AFB[k].PF))
           else
           if OP = _DIV then
            FDIVR(TAddress(Interp[i].AFB[k].PF),GetVarType(Interp[i].AFB[k].PF))
           else
            FMUL(TAddress(Interp[i].AFB[k].PF),GetVarType(Interp[i].AFB[k].PF));
           OP:=0;
          end;
          FMUL(Interp[i].AFB[k].A,WriteData(Interp[i].AFB[k].A,_Float,_MulDiv),F_ParamType);
          f:=1;
        end
        //A*X+B:
        else
        begin
         FAVBM(I,k);
         if OP = _MUL then FMULP1
         else
         if OP = _DIV then FDIVRP;
         OP:=0;
         if k > 0 then FMULP1;
         f:=1;
        end;
      end;

end;



procedure TCompiler.MUL_AAF(I: Integer);
begin
//при вызове в стеке уже есть число
      {(a*x+b),(x+b),x:}
      if  Length(Interp[i].PM) = 2 then
      begin
       {/x}
       if (Interp[i].PN[1] = 1) and  (Interp[i].PN[2] = 0) then
       begin
        FDIV(TAddress(Interp[i].PM[1]),GetVarType(Interp[i].PM[1]));
       end
       else
       {/(x+b),/(a*x+b)}
       begin
        FAVBM1(I);
        FDIVP;
       end;
      end
      else
      begin
       AAF(I);
       FDIVP;
      end;
end;




procedure TCompiler.MUL_MAF(I: Integer);
begin
//при вызове в стеке уже есть число
 MAF(I);
 FDIVP;
end;




procedure TCompiler.FILD(N: TAddress);
begin
AddWord($DB,$05);
AddAddress(N);
CheckStack(1);
end;

procedure TCompiler.FIMUL(N: TAddress);
begin
AddWord($DA,$0D);
AddAddress(N);
end;

procedure TCompiler.FIADD(N: TAddress);
begin
AddWord($DA,$05);
AddAddress(N);
end;



procedure TCompiler.IAVB(I: Integer);
begin
MOVMA(TAddress(Interp[i].IV1));
IMULA(Interp[i].VI1,WriteData(Interp[i].VI1,_Integer,_MulDiv));
ADDA(Interp[i].VI2,WriteData(Interp[i].VI2,_Integer,_AddSub));
MOVAM(TAddress(@MEM));
FILD(TAddress(@MEM));
end;


procedure TCompiler.IAVBF(I: Integer);
begin
if Interp[i].VI1 <> 0 then
begin
MOVMA(TAddress(Interp[i].IV1));
IMULA(Interp[i].VI1,WriteData(Interp[i].VI1,_Integer,_MulDiv));
ADDA(Interp[i].VI2,WriteData(Interp[i].VI2,_Integer,_AddSub))
end
else
MOVMA(WriteData(Interp[i].VI2,_Integer,_Load));
end;



procedure TCompiler.IAVBF1(I: Integer);
begin
if Interp[i].VI3 <> 0 then
begin
MOVMA(TAddress(Interp[i].IV2));
IMULA(Interp[i].VI3,WriteData(Interp[i].VI3,_Integer,_MulDiv));
ADDA(Interp[i].VI4,WriteData(Interp[i].VI4,_Integer,_AddSub))
end
else
MOVMA(WriteData(Interp[i].VI4,_Integer,_Load));
end;


procedure TCompiler.AIFB(I: Integer);
begin
FILD(TAddress(Interp[i].IV1));
FMUL(TAddress(Interp[i].FV1),GetVarType(Interp[i].FV1));

if Interp[i].V1 = -1 then AddWord($D9,$E0) else
if Interp[i].V1 <> 1 then
begin
 FMUL(Interp[i].V1,WriteData(Interp[i].V1,_Float,_MulDiv),F_ParamType);
end;

FADD(Interp[i].V2,WriteData(Interp[i].V2,_Float,_AddSub),F_ParamType);
end;




procedure TCompiler.AIFB1(I: Integer);
begin
FLD(TAddress(Interp[i].FV1),GetVarType(Interp[i].FV1));
FIMUL(TAddress(Interp[i].IV2));

if Interp[i].V1 = -1 then AddWord($D9,$E0) else
if Interp[i].V1 <> 1 then
begin
 FMUL(Interp[i].V1,WriteData(Interp[i].V1,_Float,_MulDiv),F_ParamType);
end;

FADD(Interp[i].V2,WriteData(Interp[i].V2,_Float,_AddSub),F_ParamType);
end;



procedure TCompiler.AAI(I: Integer);
var
k: Integer;
begin

MOVMA(TAddress(Interp[i].PI[1]));
IMULA(Interp[i].PC[1],WriteData(Interp[i].PC[1],_Integer,_MulDiv));
for k:=2 to High(Interp[i].PI) do
begin
 if Interp[i].PC[k] = 1 then
 ADDA(TAddress(Interp[i].PI[k]))
 else
 if Interp[i].PC[k] = -1 then
 SUBA(TAddress(Interp[i].PI[k]))
 else
 begin
 MOVB(TAddress(Interp[i].PI[k]));
 IMULB(Interp[i].PC[k],WriteData(Interp[i].PC[k],_Integer,_MulDiv));
 ADDAB;
 end;
end;

ADDA(Interp[i].PC[High(Interp[i].PC)],WriteData(Interp[i].PC[High(Interp[i].PC)],_Integer,_AddSub));
MOVAM(TAddress(@MEM));
FILD(TAddress(@MEM));

end;



procedure TCompiler.AAI1(I: Integer);
var
k: Integer;
begin


MOVMA(TAddress(Interp[i].PI[1]));
IMULA(Interp[i].PC[1],WriteData(Interp[i].PC[1],_Integer,_MulDiv));
for k:=2 to High(Interp[i].PI) do
begin
 if Interp[i].PC[k] = 1 then
 ADDA(TAddress(Interp[i].PI[k]))
 else
 if Interp[i].PC[k] = -1 then
 SUBA(TAddress(Interp[i].PI[k]))
 else
 begin
 MOVB(TAddress(Interp[i].PI[k]));
 IMULB(Interp[i].PC[k],WriteData(Interp[i].PC[k],_Integer,_MulDiv));
 ADDAB;
 end;
end;
ADDA(Interp[i].PC[High(Interp[i].PC)],WriteData(Interp[i].PC[High(Interp[i].PC)],_Integer,_AddSub));
end;





procedure TCompiler.AFI(I: Integer);
var
k: Integer;
begin
FILD(TAddress(Interp[i].PI[1]));
FMUL(Interp[i].PN[1],WriteData(Interp[i].PN[1],_Float,_MulDiv),F_ParamType);
for k:=2 to High(Interp[i].PI) do
begin
 FILD(TAddress(Interp[i].PI[k]));
 FMUL(Interp[i].PN[k],WriteData(Interp[i].PN[k],_Float,_MulDiv),F_ParamType);
 FADD;
end;

FADD(Interp[i].PN[High(Interp[i].PN)],WriteData(Interp[i].PN[High(Interp[i].PN)],_Float,_AddSub),F_ParamType);
end;


procedure TCompiler.PKGCMPL(I: Integer);
var
R,N,K,m: Integer;
begin
 //если регистр с адресом возврата (reg) используется при вычислении
 //(т.е. push reg в начале выражения), то коммандой mov reg,[esp+S] это значение
 //восстанавливается; S - 'глубина залегания' этого регистра в стеке
 //Определение S:
 case Interp[I].PkAdr of
    1,2,3,4:
    begin
     R:=Interp[I].PkAdr;
     N:=0; K:=0;
     if (REG[R] = 1) or (REGA[R] = 1) then
     begin

      for m:=1 to 8 do
      begin
       if (REG[m] = 1) or (REGA[m] = 1) then
       begin
        inc(N);
        if R = m then K:=N;
       end;
      end;

      MOVREGESP(R,(N-K)*4);
     end;
    end;
 end;

SaveRes(Interp[I].PkAdr,Interp[I].PkRType,Interp[I].PkShift); 
end;



procedure TCompiler.MOVREGESP(R: Integer; Sh: Byte);
begin  //mov reg,[esp+Sh]
   case R of
   1:  begin AddCom($8B,$44,$24); AddByte(Sh); end;
   2:  begin AddCom($8B,$5C,$24); AddByte(Sh); end;
   3:  begin AddCom($8B,$4C,$24); AddByte(Sh); end;
   4:  begin AddCom($8B,$54,$24); AddByte(Sh); end;
   end;
end;



procedure TCompiler.POPREG(reg: Cardinal);
begin
  case reg of
   1:  POPA;
   2:  POPB;
   3:  POPC;
   4:  POPD;
  end;
end;


procedure TCompiler.PUSHREG(reg: Cardinal);
begin
  case reg of
   1:  PUSHA;
   2:  PUSHB;
   3:  PUSHC;
   4:  PUSHD;
  end;
end;

procedure TCompiler.MOVB(N: TAddress);
begin
AddWord($8B,$1D);
AddAddress(N);
SetReg(2);
end;


procedure TCompiler.MOVA1(N: TAddress);
begin
//N - число
AddByte($B8);
AddAddress(N);
SetReg(1);
end;



procedure TCompiler.MOVB1(N: TAddress);
begin
AddByte($BB);
AddAddress(N);
SetReg(2);
end;


procedure TCompiler.MOVC1(N: TAddress);
begin
AddByte($B9);
AddAddress(N);
SetReg(3);
end;


procedure TCompiler.MOVD1(N: TAddress);
begin
AddByte($BA);
AddAddress(N);
SetReg(4);
end;


procedure TCompiler.MOVCA;
begin
AddWord($89,$C1);
SetReg(1);
SetReg(3);
end;


procedure TCompiler.MOVAB;
begin
//EAX -> EBX
AddWord($89,$C3);
SetReg(1);
SetReg(2);
end;


procedure TCompiler.MOVBA;
begin
//EBX -> EAX
AddWord($89,$D8);
SetReg(1);
SetReg(2);
end;


procedure TCompiler.NEGA;
begin
AddWord($F7,$D8);
end;


procedure TCompiler.NEGB;
begin
AddWord($F7,$DB);
end;


procedure TCompiler.SUBA(N: TAddress);
begin
AddWord($2B,$05);
AddAddress(N);
SetReg(1);
end;

procedure TCompiler.SUBAB;
begin
//EAX = EAX - EBX
AddWord($29,$D8);
SetReg(1);
SetReg(2);
end;



procedure TCompiler.SUBA_B(B: Byte);
begin
//EAX = EAX - B
AddWord($83,$E8);
AddByte(B);
SetReg(1);
end;



procedure TCompiler.FSTPESP(VType: Integer);
begin
 case VType of
  _Single:   AddCom($D9,$1C,$24);
  _Integer:  AddCom($DB,$1C,$24);  //fistp
  _Double:   AddCom($DD,$1C,$24);
  _Extended: AddCom($DB,$3C,$24);
 end;
 CheckStack(-1);
end;


procedure TCompiler.FSTPESP(VType: Integer; N: Integer);
begin
if N = 0 then FSTPESP(VType)
else
begin
 case VType of
  _Single:   AddCom($D9,$9C,$24,N);
  _Integer:  AddCom($DB,$9C,$24,N);  //fistp
  _Double:   AddCom($DD,$9C,$24,N);
  _Extended: AddCom($DB,$BC,$24,N);
 end;
 CheckStack(-1);
end;
end;


procedure TCompiler.MOVAM(N: TAddress);
begin
//EAX->MEM
AddWord($89,$05);
AddAddress(N);
SetReg(1);
end;


procedure TCompiler.MOVMA(N: TAddress);
begin
//MEM->EAX
AddWord($8B,$05);
AddAddress(N);
SetReg(1);
end;


procedure TCompiler.MOVAX(N: TAddress);
begin
//word ptr [N] -> AX
AddByte($66);  AddByte($8B); AddByte($05);
AddAddress(N);
SetReg(1);
end;



procedure TCompiler.MOVMB(N: TAddress);
begin
//MEM->EBX
AddWord($8B,$1D);
AddAddress(N);
SetReg(2);
end;


procedure TCompiler.MOVCM(N: TAddress);
begin
AddWord($8B,$0D);
AddAddress(N);
SetReg(3);
end;


procedure TCompiler.IMULA(X: Integer; N: TAddress);
begin
if X = -1 then NEGA
else
if X <> 1 then
begin
AddWord($F7,$2D);
AddAddress(N);
SetReg(1);
end;
end;


procedure TCompiler.IMULBA;
begin
AddByte($0F); AddByte($AF); AddByte($D8);
SetReg(1);
SetReg(2);
end;


procedure TCompiler.IMULBB;
begin
AddByte($0F); AddByte($AF); AddByte($DB);
SetReg(1);
SetReg(2);
end;


procedure TCompiler.IMULAA;
begin
AddByte($0F); AddByte($AF); AddByte($C0);
SetReg(1);
end;


procedure TCompiler.IMULAB;
begin
AddByte($0F); AddByte($AF); AddByte($C3);
SetReg(1);
SetReg(2);
end;



procedure TCompiler.IMULB(X: Integer; N: TAddress);
begin
if X = -1 then NEGB
else
if X <> 1 then
begin
AddByte($0F); AddByte($AF); AddByte($1D);
AddAddress(N);
SetReg(2);
end;
end;


procedure TCompiler.IMULBA_B(B: Byte);
begin
//EAX*B -> EBX
AddWord($6B,$D8);
AddByte(B); //B - байт
SetReg(1);
SetReg(2);
end;


procedure TCompiler.IMULDA_B(B: Byte);
begin
//EAX*B -> EDX
AddWord($6B,$D0);
AddByte(B); //B - байт
SetReg(1);
SetReg(4);
end;


procedure TCompiler.ADDA(X: Integer; N: TAddress);
begin
if X <> 0 then
begin
AddWord($03,$05);
AddAddress(N);
SetReg(1);
end;
end;


procedure TCompiler.ADDA(N: TAddress);
begin
AddWord($03,$05);
AddAddress(N);
SetReg(1);
end;


procedure TCompiler.ADDAB;
begin
AddWord($01,$D8);
SetReg(1);
SetReg(2);
end;


procedure TCompiler.ADDCB;
begin
AddWord($01,$D9);
SetReg(2);
SetReg(3);
end;


procedure TCompiler.ADDCD;
begin
AddWord($01,$D1);
SetReg(3);
SetReg(4);
end;


procedure TCompiler.ADDESP(N: Integer);
begin
if N <> 0 then
AddCom($81,$C4,N);
end;

procedure TCompiler.SUBESP(N: Integer);
begin
if N <> 0 then
AddCom($81,$EC,N);
end;

procedure TCompiler.PUSHAX;
begin
//PUSH AX
AddWord($66,$50);
end;


procedure TCompiler.PUSHA;
begin
AddByte($50);
end;

procedure TCompiler.PUSHB;
begin
AddByte($53);
end;


procedure TCompiler.PUSHC;
begin
AddByte($51);
end;

procedure TCompiler.POPA;
begin
AddByte($58);
end;

procedure TCompiler.POPB;
begin
AddByte($5B);
end;


procedure TCompiler.POPC;
begin
AddByte($59);
end;


procedure TCompiler.CALLA;
begin
AddWord($FF,$D0);
SetReg(1);
end;


procedure TCompiler.CALLB;
begin
AddWord($FF,$D3);
SetReg(2);
end;


procedure TCompiler.CALLC;
begin
AddWord($FF,$D1);
SetReg(3);
end;

procedure TCompiler.CALLD;
begin
AddWord($FF,$D2);
SetReg(4);
end;


procedure TCompiler.FLDCW(N: TAddress);
begin
AddWord($D9,$2D);
AddAddress(N);
end;


procedure TCompiler.FISTP(N: TAddress);
begin
AddWord($DB,$1D);
AddAddress(N);
CheckStack(-1);
end;



procedure TCompiler.FSTPA(VType: Integer; Shift: Cardinal);
begin
if Shift = 0 then
begin
 case VType of
  _Single:   AddCom($D9,$18);
  _Integer:  AddCom($DB,$18);  //fistp
  _Double:   AddCom($DD,$18);
  _Extended: AddCom($DB,$38);
 end;
end
else
begin
  case VType of
  _Single:   AddCom($D9,$98,Shift);
  _Integer:  AddCom($DB,$98,Shift);  //fistp
  _Double:   AddCom($DD,$98,Shift);
  _Extended: AddCom($DB,$B8,Shift);
 end;
end;
CheckStack(-1);
end;

procedure TCompiler.FSTPB(VType: Integer; Shift: Cardinal);
begin
if Shift = 0 then
begin
 case VType of
  _Integer:  AddCom($DB,$1B);  //fistp
  _Double:   AddCom($DD,$1B);
  _Single:   AddCom($D9,$1B);
  _Extended: AddCom($DB,$3B);
 end;
end
else
begin
  case VType of
  _Integer:  AddCom($DB,$9B,Shift);  //fistp
  _Double:   AddCom($DD,$9B,Shift);
  _Single:   AddCom($D9,$9B,Shift);
  _Extended: AddCom($DB,$BB,Shift);
 end;
end;
CheckStack(-1);
end;



procedure TCompiler.FSTPC(VType: Integer; Shift: Cardinal);
begin
if Shift = 0 then
begin
 case VType of
  _Integer:  AddCom($DB,$19);  //fistp
  _Double:   AddCom($DD,$19);
  _Single:   AddCom($D9,$19);
  _Extended: AddCom($DB,$39);
 end;
end
else
begin
  case VType of
  _Integer:  AddCom($DB,$99,Shift);  //fistp
  _Double:   AddCom($DD,$99,Shift);
  _Single:   AddCom($D9,$99,Shift);
  _Extended: AddCom($DB,$B9,Shift);
 end;
end;
CheckStack(-1);
end;


procedure TCompiler.FSTPD(VType: Integer; Shift: Cardinal);
begin
if Shift = 0 then
begin
 case VType of
  _Integer:  AddCom($DB,$1A);  //fistp
  _Double:   AddCom($DD,$1A);
  _Single:   AddCom($D9,$1A);
  _Extended: AddCom($DB,$3A);
 end;
end
else
begin
  case VType of
  _Integer:  AddCom($DB,$9A,Shift);  //fistp
  _Double:   AddCom($DD,$9A,Shift);
  _Single:   AddCom($D9,$9A,Shift);
  _Extended: AddCom($DB,$BA,Shift);
 end;
end;

CheckStack(-1);
end;


procedure TCompiler.FXCH1;
begin
AddWord($D9,$C9);
end;



procedure TCompiler.FLDLN2;
begin
AddWord($D9,$ED);
CheckStack(1);
end;


procedure TCompiler.FYL2X;
begin
AddWord($D9,$F1);
CheckStack(-1);
end;


procedure TCompiler.FLDLG2;
begin
AddWord($D9,$EC);
CheckStack(1);
end;


procedure TCompiler.FSINCOS;
begin
AddWord($D9,$FB);
CheckStack(1);
end;



procedure TCompiler.EndFuncCom(I: Integer);
var
N,L: Cardinal;
begin
//только полное сохранение (частичное - в соответствующих ф-ях)
L:=Length(Interp[i].AWCS);

if (L = 1)  {and  (Interp[i].Code <> 510)}  then
begin
 if (Interp[i].AWCS[0].WCS = 1) then
 begin
  N:=TAddress(@Func.CpSt[Interp[i].AWCS[0].MWCS]);
  FSTM(N,F_DataType);
 end;
end;

if Interp[i].AI = 1 then
begin
FAB12(I);
end;
end;




procedure TCompiler.FUNC3(I: Integer);
begin

if Interp[i].RCS = 0 then
begin


if (F_SaveStack = True) and (Interp[i].N > 0) then
begin
 if (Interp[i].N = 1) and (Interp[i].RData[0] = _MEM) then
    FLD(TAddress(@Func.Stack[Interp[i].S]),F_DataType)
 else
 if (Interp[i].N = 2) and (Interp[i].RData[0] = _MEM) and (Interp[i].RData[1] = _MEM) then
 begin
    FLD(TAddress(@Func.Stack[Interp[i].S]),F_DataType);
    FLD(TAddress(@Func.Stack[Interp[i].S+1]),F_DataType)
 end
 else
 if (Interp[i].N = 2) and (Interp[i].RData[0] = _MEM) and (Interp[i].RData[1] = _FPU) then
 begin
    FLD(TAddress(@Func.Stack[Interp[i].S]),F_DataType);
    FXCH1;
 end
 else
 if (Interp[i].N = 2) and (Interp[i].RData[0] = _FPU) and (Interp[i].RData[1] = _MEM) then
 begin
    FLD(TAddress(@Func.Stack[Interp[i].S+1]),F_DataType)
 end
end
 else
if  (F_SaveStack = False) and (Interp[i].N = 2) then
begin
   FLD(TAddress(@Func.Stack[Interp[i].S]),F_DataType);
   FLD(TAddress(@Func.Stack[Interp[i].S+1]),F_DataType)
end;

if Interp[i].XCHA = 1 then FXCH1;


//Arg1->ST(0); Arg2->EAX
if Interp[i].EI = 1 then
begin
IAVBF(I);
end
else
if Interp[i].EI = 2 then
begin
IAVBF(I);
FAVBF(I);
end
else
if Interp[i].EI = 3 then
begin
IAVBF(I);
AAF(I);
end
else
if Interp[i].EI = 4 then
begin
IAVBF(I);
MAF(I);
end
else
if Interp[i].EI = 5 then
begin
AAI1(I);
end
else
if Interp[i].EI = 6 then
begin
FAVBF(I);
AAI1(I);
end
else
if Interp[i].EI = 7 then
begin
AAI1(I);
AAF(I);
end
else
if Interp[i].EI = 8 then
begin
MAF(I);
AAI1(I);
end
else
if Interp[i].EI = 9 then
begin
TRUNCM(TAddress(@MEM));
MOVMA(TAddress(@MEM));
end
else
if Interp[i].EI = 10 then
begin
TRUNCM(TAddress(@MEM));
MOVMA(TAddress(@MEM));
FAVBF(I);
end
else
if Interp[i].EI = 11 then
begin
TRUNCM(TAddress(@MEM));
MOVMA(TAddress(@MEM));
AAF(I);
end
else
if Interp[i].EI = 12 then
begin
TRUNCM(TAddress(@MEM));
MOVMA(TAddress(@MEM));
MAF(I);
end;

end;




InsertFunc3(I);
EndFuncCom(I);
end;




procedure TCompiler.InsertFunc3(I: Integer);
var
S: String;
                procedure AddFunc(I,C: Integer);
                label endp;
                var
                 k: Integer;
                  begin
                  //Если адрес ф-ии = 0 и inl = 1, то ф-ия вставляется непосредственно в код,
                  //если соотв. адрес <> 0, то ф-ия вызывается: mov eax,Addr; call EAX
                  //Это возможно только если ф-ия вычисляется целиком (С=1)
                  //(введено специально для добавляемых ф-ий с FType=3)
                  //Также (в этом случае) возможно переопределение внутренних ф-ий путём
                  //установки нового адреса в FuncList[C_FUNC].Addr=NewFuncAddr при этом
                  //надо (если нужно) изменить глубину стека  FuncList[C_FUNC].NST=NewFuncNST
                   if C = 1 then
                   begin
                     if FuncList[Interp[I].Code].inl = 1 then
                     begin
                      for k:=0 to High(FuncList[Interp[I].Code].inlCode) do
                      begin
                       AddByte(FuncList[Interp[I].Code].inlCode[k]);
                      end;
                     end
                     else
                     if FuncList[Interp[I].Code].Addr <> nil then
                     begin
                      MOVB1(TAddress(FuncList[Interp[I].Code].Addr));
                      CALLB;
                     end;

                     SaveFuncReg(I);
                     
                     goto endp;
                   end;

                   //выполняется только для C=0:
                   {case  Interp[I].Code of
                    C_IPWR:           IPWR;
                    C_IROOT:          IROOT;
                   end; }

                  endp:
                  end;

begin



//только полное замещение (частичное - в соответствующих ф-ях)
if Interp[i].RCS = 1 then
begin
 FLD(TAddress(@Func.CpSt[Interp[i].MRCS]),F_DataType);
 {$IFDEF TEXTOUT}
  {if (TestG8.Form1.CB_Cod.Checked = True)  then
  TestG8.Form1.M2.Lines[I-1]:='COPYSTACK';}
 {$ENDIF}
end
else
begin
 //нет чтения и  нет сохранения или нет сохранения по частям (только целиком):
 //(введено специально для добавляемых ф-ий FType = 3)
 if (Interp[i].RCS = 0) and
   ((Length(Interp[i].AWCS) = 0) or ((Length(Interp[i].AWCS) = 1) and (Interp[i].AWCS[0].WCS = 1))) then
 begin
 //глубина стека определяется по NST
  CheckStack(FuncList[Interp[i].Code].NST);
  CheckStack(-FuncList[Interp[i].Code].NST);
  F_EnableCheckStack:=False;
  AddFunc(I,1);
  F_EnableCheckStack:=True;
 end
 else
 //если есть чтение или сохранение по частям:
 //(для ф-ий с FType = 3 таких нет (зарезервировано для будущих))
 begin
  AddFunc(I,0);
 end;


end;



end;



procedure TCompiler.IPWR_B;
begin
MOVB1(TAddress(@R_IPWR));
CALLB;
SetReg(1);
SetReg(3);
SetReg(4);
end;




procedure TCompiler.FUNC4(I: Integer);
var
S: String;
begin

if Interp[i].RCS = 0 then
begin

if (F_SaveStack = True) and (Interp[i].N > 0) then
begin
 if (Interp[i].N = 1) and (Interp[i].RData[0] = _MEM) then
    FLD(TAddress(@Func.Stack[Interp[i].S]),F_DataType)
 else
 if (Interp[i].N = 2) and (Interp[i].RData[0] = _MEM) and (Interp[i].RData[1] = _MEM) then
 begin
    FLD(TAddress(@Func.Stack[Interp[i].S]),F_DataType);
    FLD(TAddress(@Func.Stack[Interp[i].S+1]),F_DataType)
 end
 else
 if (Interp[i].N = 2) and (Interp[i].RData[0] = _MEM) and (Interp[i].RData[1] = _FPU) then
 begin
    FLD(TAddress(@Func.Stack[Interp[i].S]),F_DataType);
    FXCH1;
 end
 else
 if (Interp[i].N = 2) and (Interp[i].RData[0] = _FPU) and (Interp[i].RData[1] = _MEM) then
 begin
    FLD(TAddress(@Func.Stack[Interp[i].S+1]),F_DataType)
 end
end
 else
if  (F_SaveStack = False) and (Interp[i].N = 2) then
begin
   FLD(TAddress(@Func.Stack[Interp[i].S]),F_DataType);
   FLD(TAddress(@Func.Stack[Interp[i].S+1]),F_DataType)
end;

if Interp[i].XCHA = 1 then FXCH1;

//Arg1->ST(0); Arg2->ST(1)
 if Interp[i].EI = 1 then
 begin
  {}
 end
 else
 if Interp[i].EI = 2 then
 begin
  FAVBF(I);
 end
 else
 if Interp[i].EI = 3  then
 begin
  AAF(I);
 end
 else
 if Interp[i].EI = 4 then
 begin
  MAF(I);
 end
 else
 if Interp[i].EI = 5 then
 begin
  FAVBF1(I);
  FXCH1;
 end
 else
 if Interp[i].EI = 6  then
 begin
  FAVBF1(I);
  FAVBF(I);
 end
 else
 if Interp[i].EI = 7  then
 begin
  FAVBF1(I);
  AAF(I);
 end
 else
 if Interp[i].EI = 8  then
 begin
  FAVBF1(I);
  MAF(I);
 end
 else
 if Interp[i].EI = 10 then
 begin
  AAF(I);
  FAVBF1(I);
 end
 else
 if Interp[i].EI = 12 then
 begin
  MAF(I);
  FAVBF1(I);
 end
 else
 if Interp[i].EI = 9 then
 begin
  AAF(I);
  FXCH1;
 end
 else
 if Interp[i].EI = 11 then
 begin
  MAF(I);
  FXCH1;
 end;
end;

InsertFunc4(I);
EndFuncCom(I);
end;





procedure TCompiler.InsertFunc4(I: Integer);
var
S: String;
                procedure AddFunc(I,C: Integer);
                label endp;
                var
                 k: Integer;
                  begin
                  //Если адрес ф-ии = 0 и inl = 1, то ф-ия вставляется непосредственно в код,
                  //если соотв. адрес <> 0, то ф-ия вызывается: mov eax,Addr; call EAX
                  //Это возможно только если ф-ия вычисляется целиком (С=1)
                  //(введено специально для добавляемых ф-ий с FType=4)
                  //Также (в этом случае) возможно переопределение внутренних ф-ий путём
                  //установки нового адреса в FuncList[C_FUNC].Addr=NewFuncAddr при этом
                  //надо (если нужно) изменить глубину стека  FuncList[C_FUNC].NST=NewFuncNST
                   if C = 1 then
                   begin
                     if FuncList[Interp[I].Code].inl = 1 then
                     begin
                      for k:=0 to High(FuncList[Interp[I].Code].inlCode) do
                      begin
                       AddByte(FuncList[Interp[I].Code].inlCode[k]);
                      end
                     end
                     else
                     if FuncList[Interp[I].Code].Addr <> nil then
                     begin
                      MOVA1(TAddress(FuncList[Interp[I].Code].Addr));
                      CALLA;
                     end;

                     SaveFuncReg(I);

                     goto endp;
                   end;

                   //выполняется только для C=0:
                   {case  Interp[I].Code of
                    C_FPWR:           FPWR;
                    C_FROOT:          FROOT;
                   end;}

                  endp:
                  end;

begin



//только полное замещение (частичное - в соответствующих ф-ях)
if Interp[i].RCS = 1 then
begin
 FLD(TAddress(@Func.CpSt[Interp[i].MRCS]),F_DataType);
 {$IFDEF TEXTOUT}
  {if (TestG8.Form1.CB_Cod.Checked = True)  then
  TestG8.Form1.M2.Lines[I-1]:='COPYSTACK';}
 {$ENDIF}
end
else
begin
 //нет чтения и  нет сохранения или нет сохранения по частям (только целиком):
 //(введено специально для добавляемых ф-ий FType = 4)
 if (Interp[i].RCS = 0) and
   ((Length(Interp[i].AWCS) = 0) or ((Length(Interp[i].AWCS) = 1) and (Interp[i].AWCS[0].WCS = 1))) then
 begin
 //глубина стека определяется по NST
  CheckStack(FuncList[Interp[i].Code].NST);
  CheckStack(-FuncList[Interp[i].Code].NST-1); //т.к. два аргумента
  F_EnableCheckStack:=False;
  AddFunc(I,1);
  F_EnableCheckStack:=True;
 end
 else
 //если есть чтение или сохранение по частям:
 //(для ф-ий с FType = 4 таких нет (зарезервировано для будущих))
 begin
  AddFunc(I,0);
 end;


end;



end;






procedure TCompiler.SQR;
begin
FMUL0;
end;



procedure TCompiler.IPWR3;
begin
FLD0;
FMUL0;
FMULP1;
end;



procedure TCompiler.IPWR4;
begin
FMUL0;
FMUL0;
end;



procedure TCompiler.IPWR5;
begin
FLD0;
FMUL0;
FMUL0;
FMULP1;
end;



procedure TCompiler.IPWR6;
begin
FMUL0;
FLD0;
FMUL0;
FMULP1;
end;




procedure TCompiler.IPWR7;
begin
FLD0;
FMUL0;
FLD0;
FMUL0;
FMULP1;
FMULP1;
end;



procedure TCompiler.IPWR8;
begin
FMUL0;
FMUL0;
FMUL0;
end;



procedure TCompiler.IPWR9;
begin
FLD0;
FMUL0;
FMUL0;
FMUL0;
FMULP1;
end;






procedure TCompiler.IPWR10;
begin
FMUL0;
FLD0;
FMUL0;
FMUL0;
FMULP1;
end;




procedure TCompiler.IPWR11;
begin
FLD0;
FMUL0;
FLD0;
FMUL0;
FMUL0;
FMULP1;
FMULP1;
end;




procedure TCompiler.IPWR12;
begin
FMUL0;
FMUL0;
FLD0;
FMUL0;
FMULP1;
end;




procedure TCompiler.IPWR13;
begin
FLD0;
FMUL0;
FMUL0;
FLD0;
FMUL0;
FMULP1;
FMULP1;
end;




procedure TCompiler.IPWR14;
begin
FMUL0;
FLD0;
FMUL0;
FLD0;
FMUL0;
FMULP1;
FMULP1;
end;






procedure TCompiler.IPWR15;
begin
FLD0;
FLD0;
FMUL0;
FLD0;
FMUL0;
FMULP1;
FMULP1;
FMUL0;
FMULP1;
end;





procedure TCompiler.IPWR16;
begin
FMUL0;
FMUL0;
FMUL0;
FMUL0;
end;






procedure TCompiler.FSIN;
begin
 AddWord($D9,$FE);
end;


procedure TCompiler.FSTM(N: TAddress; VType: Integer);
begin
 if VType = _Extended then
 begin
  FLD0;
  FSTPM(N,_Extended)
 end
 else
 if VType = _Double then
 begin
  AddCom($DD,$15,N);
 end
 else
 if VType = _Single then
 begin
   AddCom($D9,$15,N);
 end;
end;


procedure TCompiler.FSQRT;
begin
AddWord($D9,$FA);
end;



procedure TCompiler.FPWR;
begin
if F_CorrectIPWR = 0 then
//возникает странная ошибка: результат "прыгает", например: sin((3*x+4)^(2*y-1)) [x=2,y=5]
//для этого добавляются wait в IPWR
MOVA1(TAddress(@R_FPWR))
else
MOVA1(TAddress(@R_FPWR_Correct));

CALLA;
CheckStack(1);
CheckStack(-2);
end;



procedure TCompiler.LOGN;
begin
MOVA1(TAddress(@R_LOGN));
CALLA;
CheckStack(1);
CheckStack(-2);
SetReg(1);
end;







procedure TCompiler.InsertFunc2(I: Integer);
var
S: String;
                procedure AddFunc(I,C: Integer);
                label endp;
                var
                 k: Integer;
                  begin
                  //Если адрес ф-ии = 0 и inl = 1, то ф-ия вставляется непосредственно в код,
                  //если соотв. адрес <> 0, то ф-ия вызывается: mov eax,Addr; call EAX
                  //Это возможно только если ф-ия вычисляется целиком (С=1)
                  //(введено специально для добавляемых ф-ий с FType=2)
                  //Также (в этом случае) возможно переопределение внутренних ф-ий путём
                  //установки нового адреса в FuncList[C_FUNC].Addr=NewFuncAddr при этом
                  //надо (если нужно) изменить глубину стека  FuncList[C_FUNC].NST=NewFuncNST
                   if C = 1 then
                   begin
                     if FuncList[Interp[I].Code].inl = 1 then
                     begin
                      for k:=0 to High(FuncList[Interp[I].Code].inlCode) do
                      begin
                       AddByte(FuncList[Interp[I].Code].inlCode[k]);
                      end;
                     end
                     else
                     if FuncList[Interp[I].Code].Addr <> nil then
                     begin
                      MOVA1(TAddress(FuncList[Interp[I].Code].Addr));
                      CALLA;
                     end;

                     SaveFuncReg(I);
                     goto endp;
                   end;

                   //выполняется только для C=0:
                   case  Interp[I].Code of
                    C_SIN:             SIN;
                    C_COS:             COS;
                    C_TAN:             FTAN;
                    C_SQR:             SQR;
                    C_SINH:            SINH;
                    C_SQRT:            FSQRT;
                    C_ARCTAN:          FATAN;
                    C_ARCSIN:          ARCSIN;
                    C_ARCCOS:          ARCCOS;
                    C_COTAN:           COTAN;
                    C_ARCCOTAN:        ARCCOTAN;
                    C_EXP:             EXP;
                    C_LN:              LN;
                    C_LOG10:           LOG10;
                    C_LOG2:            LOG2;
                    C_COSH:            COSH;
                    C_TANH:            TANH;
                    C_COTANH:          COTANH;
                    C_ARCSINH:         ARCSINH;
                    C_ARCCOSH:         ARCCOSH;
                    C_ARCTANH:         ARCTANH;
                    C_ARCCOTANH:       ARCCOTANH;
                    C_ABS:             FABS;
                    C_TRUNC:           FTRUNC;
                    C_IPWR3:           IPWR3;
                    C_IPWR4:           IPWR4;
                    C_IPWR5:           IPWR5;
                    C_IPWR6:           IPWR6;
                    C_IPWR7:           IPWR7;
                    C_IPWR8:           IPWR8;
                    C_IPWR9:           IPWR9;
                    C_IPWR10:          IPWR10;
                    C_IPWR11:          IPWR11;
                    C_IPWR12:          IPWR12;
                    C_IPWR13:          IPWR13;
                    C_IPWR14:          IPWR14;
                    C_IPWR15:          IPWR15;
                    C_IPWR16:          IPWR16;
                   end;

                  endp:
                  end;

begin



//только полное замещение (частичное - в соответствующих ф-ях)
if Interp[i].RCS = 1 then
begin
 //FLD(TAddress(@Func.CpSt[Interp[i].MRCS]));
 FLD(TAddress(@Func.CpSt[Interp[i].MRCS]),F_DataType);
 {$IFDEF TEXTOUT}
  {if (TestG8.Form1.CB_Cod.Checked = True)  then
  TestG8.Form1.M2.Lines[I-1]:='COPYSTACK';}
 {$ENDIF}
end
else
begin
 //нет чтения и  нет сохранения или нет сохранения по частям (только целиком):
 //(введено специально для добавляемых ф-ий с FType=2)
 if (Interp[i].RCS = 0) and
   ((Length(Interp[i].AWCS) = 0) or ((Length(Interp[i].AWCS) = 1) and (Interp[i].AWCS[0].WCS = 1))) then
 begin
 //глубина стека определяется по NST
  CheckStack(FuncList[Interp[i].Code].NST);
  CheckStack(-FuncList[Interp[i].Code].NST);
  F_EnableCheckStack:=False;
  AddFunc(I,1);
  F_EnableCheckStack:=True;
 end
 else
 //если есть чтение или сохранение по частям:
 begin
  AddFunc(I,0);
 end;


end;



end;







procedure TCompiler.FUNC2(I: Integer);
var
S: String;
begin
if Interp[i].RCS  = 0 then
begin
 if Interp[i].EI = 2 then FAVBF(I)
 else
 if Interp[i].EI = 3 then AAF(I)
 else
 if Interp[i].EI = 4 then MAF(I)
 else
 if Interp[i].EI = 5 then AIFB(I)
 else
 if (Interp[i].EI = 1) and (F_SaveStack = True) and (Interp[i].RData[0] = _MEM) then
 {Stack}
 begin
   FLD(TAddress(@Func.Stack[Interp[i].S]),F_DataType);
 end;
end;

InsertFunc2(I);
EndFuncCom(I);
end;


procedure TCompiler.FCOS;
begin
 AddCom($D9,$FF);
end;

procedure TCompiler.FPTAN;
begin
 AddCom($D9,$F2);
 CheckStack(1);
end;

procedure TCompiler.FPATAN;
begin
 AddCom($D9,$F3);
end;


procedure TCompiler.FSCALE;
begin
 AddCom($D9,$FD);
 CheckStack(-1);
end;

procedure TCompiler.FLD1;
begin
 AddWord($D9,$E8);
 CheckStack(1);
end;

procedure TCompiler.FLD0;
begin
 AddWord($D9,$C0);
 CheckStack(1);
end;

procedure TCompiler.FSTP0;
begin
 AddWord($DD,$D8);
 CheckStack(-1);
end;

procedure TCompiler.FSTP1;
begin
 AddWord($DD,$D9);
 CheckStack(-1);
end;

procedure TCompiler.FTAN;
begin
 FPTAN;
 FSTP0;
end;

procedure TCompiler.FATAN;
begin
 FLD1;
 FPATAN;
 CheckStack(-1);
end;


procedure TCompiler.SINH;
label endp;
var
L,N: Cardinal;
N1,N2,N3,P: Integer;
begin


P:=Interp[CNI].RCS;  //приоритет чтения (1-sh;2-exp,1/exp;3-exp)
L:=Length(Interp[CNI].AWCS);
N1:=-1; N2:=-1; N3:=-1; //ранги сохранения (номера массива с соотв. рангами) (1-sh;2-exp,1/exp;3-exp)
if L = 1 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0
 else
 if Interp[CNI].AWCS[0].WCS = 3 then N3:=0
end
else
if L = 2 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0
 else
 if Interp[CNI].AWCS[0].WCS = 3 then N3:=0;
 if Interp[CNI].AWCS[1].WCS = 1 then N1:=1
 else
 if Interp[CNI].AWCS[1].WCS = 2 then N2:=1
 else
 if Interp[CNI].AWCS[1].WCS = 3 then N3:=1
end
else
if L = 3 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0
 else
 if Interp[CNI].AWCS[0].WCS = 3 then N3:=0;
 if Interp[CNI].AWCS[1].WCS = 1 then N1:=1
 else
 if Interp[CNI].AWCS[1].WCS = 2 then N2:=1
 else
 if Interp[CNI].AWCS[1].WCS = 3 then N3:=1;
 if Interp[CNI].AWCS[2].WCS = 1 then N1:=1
 else
 if Interp[CNI].AWCS[2].WCS = 2 then N2:=1
 else
 if Interp[CNI].AWCS[2].WCS = 3 then N3:=1;

end;


//если одновременно и чтение и сохранение по частям:
if P > 1 then
begin

 //exp->
 if P = 3 then
 begin
  //FLD(TAddress(@Func.CpSt[Interp[CNI].MRCS]));
  FLD(TAddress(@Func.CpSt[Interp[CNI].MRCS]),F_DataType);

  //->exp
  if N2 <> -1 then
  begin
   N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS-1]);
   FSTM(N,F_DataType);
  end;

  {1/EXP:}
  FLD0;
  FDIVR1;

  //1/exp:
  if N2 <> -1 then
  begin
   N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS]);
   FSTM(N,F_DataType);
  end;

  //sinh:
  FSUB;
  FMUL(TAddress(@C05),_Double);

  if (L > 1) and (N1 <> -1) then //сохранение для случая L=1 в EndFuncCom
  begin
   N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N1].MWCS-1]);
   FSTM(N,F_DataType);
  end
 end
 else
 if P = 2 then
 begin
   //EXP
   FLD(TAddress(@Func.CpSt[Interp[CNI].MRCS-1]),F_DataType);
   //EXP-1/EXP
   FSUB(TAddress(@Func.CpSt[Interp[CNI].MRCS]),F_DataType);
   FMUL(TAddress(@C05),_Double);
  {если сохранение есть, то должно быть только: (L = 1;N1 <> -1) - сохраняется в EndFuncCom)}
 end;

 {$IFDEF TEXTOUT}
   {if (TestG8.Form1.CB_Cod.Checked = True)  then
   TestG8.Form1.M2.Lines[CNI-1]:='COPYSTACK'; }
 {$ENDIF}

 goto endp;
end;






//если нет сохранения или нет сохранения по частям (только целиком):
if (L = 0) or ((L = 1) and (Interp[CNI].AWCS[0].WCS = 1)) then
begin
 MOVA1(TAddress(@R_SINH));
 CALLA;
 CheckStack(2);
 CheckStack(-2);
 goto endp;
end;



//если нет чтения и есть сохранение по частям:
if (P = 0) and (L >= 1) then
begin
 {EXP:}
 EXP;


 //->exp:
 if N3 <> -1 then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N3].MWCS]);
  FSTM(N,F_DataType);
 end;

  //->exp
 if N2 <> -1 then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS-1]);
  FSTM(N,F_DataType);
 end;

 {1/EXP:}
 FLD0;
 FDIVR1;


 //1/exp:
 if N2 <> -1 then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS]);
  FSTM(N,F_DataType);
 end;

 //sinh:
 FSUB;
 FMUL(TAddress(@C05),_Double);

 if (L > 1) and (N1 <> -1) then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N1].MWCS]);
  FSTM(N,F_DataType);
 end;

end;


endp:
end;



procedure TCompiler.COTAN;
label endp;
var
L,N: Cardinal;
N1,N2,P: Integer;
begin


P:=Interp[CNI].RCS; //приоритет чтения (1-cotan,tan)
L:=Length(Interp[CNI].AWCS);
//ранги сохранения (номера массива с соотв. рангами) (N1-cotan,N2-tan)
N1:=-1; N2:=-1;
if L = 1 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0;
end
else
if L = 2 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0;
 if Interp[CNI].AWCS[1].WCS = 1 then N1:=1
 else
 if Interp[CNI].AWCS[1].WCS = 2 then N2:=1;
end;

//если одновременно и чтение и сохранение по частям:
if P <> 0 then
begin

 //tan->
 if P = 2 then
 begin
  FLD1;
  FDIV(TAddress(@Func.CpSt[Interp[CNI].MRCS]),F_DataType);
 end;

 {$IFDEF TEXTOUT}
   {if (TestG8.Form1.CB_Cod.Checked = True)  then
   TestG8.Form1.M2.Lines[CNI-1]:='COPYSTACK'; }
 {$ENDIF}

 goto endp;
end;


//если нет сохранения или нет сохранения по частям (только целиком):
if (L = 0) or ((L = 1) and (Interp[CNI].AWCS[0].WCS = 1)) then
begin
 FPTAN;
 FDIVRP;
 goto endp;
end;




//если нет чтения и есть сохранение по частям:
if (P = 0) and (L >= 1) then
begin
 FPTAN;
 FXCH1;

 //->tan:
 if N2 <> -1 then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS]);
  FSTM(N,F_DataType);
 end;

 FXCH1;
 FDIVRP;

 if (L > 1) and (N1 <> -1) then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N1].MWCS]);
  FSTM(N,F_DataType);
 end;

end;

endp:
end;




procedure TCompiler.ARCSIN;
label endp;
var
L,N: Cardinal;
N1,P: Integer;
begin


P:=Interp[CNI].RCS; //приоритет чтения (1-asin,2-acos)
L:=Length(Interp[CNI].AWCS);
N1:=-1;   //ранги сохранения (номера массива с соотв. рангами) (N1-asin)

//если одновременно и чтение и сохранение по частям:
if P <> 0 then
begin

 //acos->
 if P = 2 then
 begin
  if (F_DataType = _Double) or (F_DataType = _Single) then
  FLD(TAddress(@D_CPid2),_Double)
  else
  FLD(TAddress(@E_CPid2),_Extended);
  
  FSUB(TAddress(@Func.CpSt[Interp[CNI].MRCS]),F_DataType);
 end;

 {$IFDEF TEXTOUT}
   {if (TestG8.Form1.CB_Cod.Checked = True)  then
   TestG8.Form1.M2.Lines[CNI-1]:='COPYSTACK';}
 {$ENDIF}

 goto endp;
end;


//если нет сохранения или нет сохранения по частям (только целиком):
if P = 0 then
begin
 MOVA1(TAddress(@R_ARCSIN));
 CALLA;
 CheckStack(1);
 CheckStack(-1);
 goto endp;
end;

endp:
end;




procedure TCompiler.ARCCOS;
label endp;
var
L,N: Cardinal;
N1,P: Integer;
begin


P:=Interp[CNI].RCS; //приоритет чтения (1-acos,2-asin)
L:=Length(Interp[CNI].AWCS);

//если одновременно и чтение и сохранение по частям:
if P <> 0 then
begin

 //asin->
 if P = 2 then
 begin
  if (F_DataType = _Double) or (F_DataType = _Single) then
  FLD(TAddress(@D_CPid2),_Double)
  else
  FLD(TAddress(@E_CPid2),_Extended);

  FSUB(TAddress(@Func.CpSt[Interp[CNI].MRCS]),F_DataType);
 end;

 {$IFDEF TEXTOUT}
 {if (TestG8.Form1.CB_Cod.Checked = True)  then
 TestG8.Form1.M2.Lines[CNI-1]:='COPYSTACK'; }
 {$ENDIF}

 goto endp;
end;






//если нет сохранения или нет сохранения по частям (только целиком):
if P = 0 then
begin
 MOVA1(TAddress(@R_ARCCOS));
 CALLA;
 CheckStack(1);
 CheckStack(-1);
 goto endp;
end;


endp:
end;




procedure TCompiler.ARCCOTAN;
label endp;
var
L,N: Cardinal;
N1,N2,P: Integer;
begin


P:=Interp[CNI].RCS; //приоритет чтения (1-acotan,atan)
L:=Length(Interp[CNI].AWCS);
//ранги сохранения (номера массива с соотв. рангами) (N1-acotan,N2-atan)
N1:=-1; N2:=-1;
if L = 1 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0;
end
else
if L = 2 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0;
 if Interp[CNI].AWCS[1].WCS = 1 then N1:=1
 else
 if Interp[CNI].AWCS[1].WCS = 2 then N2:=1;
end;

//если одновременно и чтение и сохранение по частям:
if P <> 0 then
begin

 //->atan
 if P = 2 then
 begin
  if (F_DataType = _Double) or (F_DataType = _Single) then
  FLD(TAddress(@D_CPid2),_Double)
  else
  FLD(TAddress(@E_CPid2),_Extended);
  
  FSUB(TAddress(@Func.CpSt[Interp[CNI].MRCS]),F_DataType);
 end;

 {$IFDEF TEXTOUT}
 {if (TestG8.Form1.CB_Cod.Checked = True)  then
 TestG8.Form1.M2.Lines[CNI-1]:='COPYSTACK';}
 {$ENDIF}

 goto endp;
end;


//если нет сохранения или нет сохранения по частям (только целиком):
if (L = 0) or ((L = 1) and (Interp[CNI].AWCS[0].WCS = 1)) then
begin
 FLD1;
 FPATAN;
 if (F_DataType = _Double) or (F_DataType = _Single) then
 FSUBR(TAddress(@D_CPid2),_Double)
 else
 FSUBR(TAddress(@E_CPid2),_Extended);
 goto endp;
end;






//если нет чтения и есть сохранение по частям:
if (P = 0) and (L >= 1) then
begin
 FLD1;
 FPATAN;

 //->atan:
 if N2 <> -1 then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS]);
  FSTM(N,F_DataType);
 end;

 if (F_DataType = _Double) or (F_DataType = _Single) then
 FSUBR(TAddress(@D_CPid2),_Double)
 else
 FSUBR(TAddress(@E_CPid2),_Extended);

 if (L > 1) and (N1 <> -1) then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N1].MWCS]);
  FSTM(N,F_DataType);
 end;

end;



endp:
end;




procedure TCompiler.SIN;
label endp;
var
L,N: Cardinal;
N1,N2,P: Integer;
begin


P:=Interp[CNI].RCS;
L:=Length(Interp[CNI].AWCS);
//ранги сохранения (номера массива с соотв. рангами) (N1-sin,N2-cos)
N1:=-1; N2:=-1;
if L = 1 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0;
end
else
if L = 2 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0;

 if Interp[CNI].AWCS[1].WCS = 1 then N1:=1
 else
 if Interp[CNI].AWCS[1].WCS = 2 then N2:=1;
end;



//если нет сохранения или нет сохранения по частям (только целиком):
if (L = 0) or ((L = 1) and (Interp[CNI].AWCS[0].WCS = 1)) then
begin
 FSIN;
 goto endp;
end;



//если нет чтения и есть сохранение по частям:
//sin->cos или sin->sin,cos
if (P = 0) and (((L = 1) and (Interp[CNI].AWCS[0].WCS = 2)) or (L = 2)) then
begin
 FSINCOS;


 //->cos:
 if N2 <> -1 then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS]);
  FSTPM(N,F_DataType);
 end;


 //->sin
 if {(L > 1) and} (N1 <> -1) then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N1].MWCS]);
  FSTM(N,F_DataType);
 end;

end;



endp:
end;






procedure TCompiler.COS;
label endp;
var
L,N: Cardinal;
N1,N2,P: Integer;
begin


P:=Interp[CNI].RCS;
L:=Length(Interp[CNI].AWCS);
//ранги сохранения (номера массива с соотв. рангами) (N1-sin,N2-cos)
N1:=-1; N2:=-1;
if L = 1 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0;
end
else
if L = 2 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0;

 if Interp[CNI].AWCS[1].WCS = 1 then N1:=1
 else
 if Interp[CNI].AWCS[1].WCS = 2 then N2:=1;
end;



//если нет сохранения или нет сохранения по частям (только целиком):
if (L = 0) or ((L = 1) and (Interp[CNI].AWCS[0].WCS = 1)) then
begin
 FCOS;
 goto endp;
end;



//если нет чтения и есть сохранение по частям:
//cos->sin или cos->cos,sin
if (P = 0) and (((L = 1) and (Interp[CNI].AWCS[0].WCS = 2)) or (L = 2)) then
begin
 FSINCOS;
 FXCH1;


 //->sin:
 if N2 <> -1 then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS]);
  FSTPM(N,F_DataType);
 end;


 //->cos
 if {(L > 1) and} (N1 <> -1) then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N1].MWCS]);
  FSTM(N,F_DataType);
 end;

end;



endp:
end;



procedure TCompiler.EXP;
begin
 MOVA1(TAddress(@R_EXP));
 CALLA;
 CheckStack(2);
 CheckStack(-2);
end;




procedure TCompiler.LN;
begin
 FLDLN2;
 FXCH1;
 FYL2X;
end;


procedure TCompiler.LOG10;
begin
 FLDLG2;
 FXCH1;
 FYL2X;
end;


procedure TCompiler.LOG2;
begin
 FLD1;
 FXCH1;
 FYL2X;
end;




procedure TCompiler.COSH;
label endp;
var
L,N: Cardinal;
N1,N2,N3,P: Integer;
begin


P:=Interp[CNI].RCS;
L:=Length(Interp[CNI].AWCS);
N1:=-1; N2:=-1; N3:=-1;
if L = 1 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0
 else
 if Interp[CNI].AWCS[0].WCS = 3 then N3:=0
end
else
if L = 2 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0
 else
 if Interp[CNI].AWCS[0].WCS = 3 then N3:=0;
 if Interp[CNI].AWCS[1].WCS = 1 then N1:=1
 else
 if Interp[CNI].AWCS[1].WCS = 2 then N2:=1
 else
 if Interp[CNI].AWCS[1].WCS = 3 then N3:=1
end
else
if L = 3 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0
 else
 if Interp[CNI].AWCS[0].WCS = 3 then N3:=0;
 if Interp[CNI].AWCS[1].WCS = 1 then N1:=1
 else
 if Interp[CNI].AWCS[1].WCS = 2 then N2:=1
 else
 if Interp[CNI].AWCS[1].WCS = 3 then N3:=1;
 if Interp[CNI].AWCS[2].WCS = 1 then N1:=1
 else
 if Interp[CNI].AWCS[2].WCS = 2 then N2:=1
 else
 if Interp[CNI].AWCS[2].WCS = 3 then N3:=1;

end;


//если одновременно и чтение и сохранение по частям:
if P > 1 then
begin

 //exp->
 if P = 3 then
 begin
  //FLD(TAddress(@Func.CpSt[Interp[CNI].MRCS]));
  FLD(TAddress(@Func.CpSt[Interp[CNI].MRCS]),F_DataType);

  //->exp
  if N2 <> -1 then
  begin
   N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS-1]);
   FSTM(N,F_DataType);
  end;

  {1/EXP:}
  FLD0;
  FDIVR1;
  {FLD1;
  FDIVRP; }

  //1/exp:
  if N2 <> -1 then
  begin
   N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS]);
   FSTM(N,F_DataType);
  end;

  //cosh:
  FADD;
  FMUL(TAddress(@C05),_Double);

  if (L > 1) and (N1 <> -1) then //сохранение для случая L=1 в EndFuncCom
  begin
   N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N1].MWCS]);
   FSTM(N,F_DataType);
  end
 end
 else
 if P = 2 then
 begin
   //EXP
   //FLD(TAddress(@Func.CpSt[Interp[CNI].MRCS-1]));
   FLD(TAddress(@Func.CpSt[Interp[CNI].MRCS-1]),F_DataType);
   
   //EXP+1/EXP
   FADD(TAddress(@Func.CpSt[Interp[CNI].MRCS]),F_DataType);
   FMUL(TAddress(@C05),_Double);
  {если сохранение есть, то должно быть только: (L = 1;N1 <> -1) - сохраняется в EndFuncCom)}
 end;

 {$IFDEF TEXTOUT}
 {if (TestG8.Form1.CB_Cod.Checked = True)  then
 TestG8.Form1.M2.Lines[CNI-1]:='COPYSTACK'; }
 {$ENDIF}

 goto endp;
end;






//если нет сохранения или нет сохранения по частям (только целиком):
if (L = 0) or ((L = 1) and (Interp[CNI].AWCS[0].WCS = 1)) then
begin
 MOVA1(TAddress(@R_COSH));
 CALLA;
 CheckStack(2);
 CheckStack(-2);
 goto endp;
end;



//если нет чтения и есть сохранение по частям:
if (P = 0) and (L >= 1) then
begin
 {EXP:}
 EXP;

 //->exp:
 if N3 <> -1 then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N3].MWCS]);
  FSTM(N,F_DataType);
 end;

  //->exp
 if N2 <> -1 then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS-1]);
  FSTM(N,F_DataType);
 end;

 {1/EXP:}
 FLD0;
 FDIVR1;


 //1/exp:
 if N2 <> -1 then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS]);
  FSTM(N,F_DataType);
 end;

 //cosh:
 FADD;
 FMUL(TAddress(@C05),_Double);

 if (L > 1) and (N1 <> -1) then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N1].MWCS]);
  FSTM(N,F_DataType);
 end;

end;


endp:
end;





procedure TCompiler.TANH;
label endp;
var
L,N: Cardinal;
N1,N2,P: Integer;
begin


P:=Interp[CNI].RCS; //приоритет чтения (1-th,2-cth,3-exp)
L:=Length(Interp[CNI].AWCS);
N1:=-1; N2:=-1;  //ранги сохранения (номера массива с соотв. рангами) (N1-th;N2-exp)
if L = 1 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0;
end
else
if L = 2 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0;
 if Interp[CNI].AWCS[1].WCS = 1 then N1:=1
 else
 if Interp[CNI].AWCS[1].WCS = 2 then N2:=1;
end;

//если одновременно и чтение и сохранение по частям:
if P > 1 then
begin

 //exp->
 if P = 3 then
 begin
  FLD(TAddress(@Func.CpSt[Interp[CNI].MRCS]),F_DataType);

  {(EXP^2-1)/(EXP^2+1):}
  FMUL0;
  FLD0;
  FLD1;
  FSUBP;
  FLD1;
  FADD2;
  FDIVP;
  FSTP1;

  //если есть сохранение, то только целиком (th) в EndFuncCom

 end
 else
 if P = 2 then
 begin
   //cth->
   FLD(TAddress(@Func.CpSt[Interp[CNI].MRCS]),F_DataType);
   FDIVR1;
 end;

 {$IFDEF TEXTOUT}
 {if (TestG8.Form1.CB_Cod.Checked = True)  then
 TestG8.Form1.M2.Lines[CNI-1]:='COPYSTACK'; }
 {$ENDIF}

 goto endp;
end;






//если нет сохранения или нет сохранения по частям (только целиком):
if (L = 0) or ((L = 1) and (Interp[CNI].AWCS[0].WCS = 1)) then
begin
 MOVA1(TAddress(@R_TANH));
 CALLA;
 CheckStack(2);
 CheckStack(-2);
 goto endp;
end;



//если нет чтения и есть сохранение по частям:
if (P = 0) and (L >= 1) then
begin
 {EXP:}
 EXP;

 //->exp:
 if N2 <> -1 then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS]);
  FSTM(N,F_DataType);
 end;

 {(EXP^2-1)/(EXP^2+1):}
  FMUL0;
  FLD0;
  FLD1;
  FSUBP;
  FLD1;
  FADD2;
  FDIVP;
  FSTP1;


 if (L > 1) and (N1 <> -1) then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N1].MWCS]);
  FSTM(N,F_DataType);
 end;

end;


endp:
end;



procedure TCompiler.COTANH;
label endp;
var
L,N: Cardinal;
N1,N2,P: Integer;
begin


P:=Interp[CNI].RCS; //приоритет чтения (1-th,2-cth,3-exp)
L:=Length(Interp[CNI].AWCS);
N1:=-1; N2:=-1;  //ранги сохранения (номера массива с соотв. рангами) (N1-th;N2-exp)
if L = 1 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0;
end
else
if L = 2 then
begin
 if Interp[CNI].AWCS[0].WCS = 1 then N1:=0
 else
 if Interp[CNI].AWCS[0].WCS = 2 then N2:=0;
 if Interp[CNI].AWCS[1].WCS = 1 then N1:=1
 else
 if Interp[CNI].AWCS[1].WCS = 2 then N2:=1;
end;

//если одновременно и чтение и сохранение по частям:
if P > 1 then
begin

 //exp->
 if P = 3 then
 begin
  FLD(TAddress(@Func.CpSt[Interp[CNI].MRCS]),F_DataType);

  {(EXP^2-1)/(EXP^2+1):}
  FMUL0;
  FLD0;
  FLD1;
  FSUBP;
  FLD1;
  FADD2;
  FDIVRP;
  FSTP1;

  //если есть сохранение, то только целиком (th) в EndFuncCom

 end
 else
 if P = 2 then
 begin
   //cth->
   FLD(TAddress(@Func.CpSt[Interp[CNI].MRCS]),F_DataType);
   FDIVR1;

 end;

 {$IFDEF TEXTOUT}
 {if (TestG8.Form1.CB_Cod.Checked = True)  then
 TestG8.Form1.M2.Lines[CNI-1]:='COPYSTACK'; }
 {$ENDIF}

 goto endp;
end;






//если нет сохранения или нет сохранения по частям (только целиком):
if (L = 0) or ((L = 1) and (Interp[CNI].AWCS[0].WCS = 1)) then
begin
 MOVA1(TAddress(@R_COTANH));
 CALLA;
 CheckStack(2);
 CheckStack(-2);
 goto endp;
end;



//если нет чтения и есть сохранение по частям:
if (P = 0) and (L >= 1) then
begin
 {EXP:}
 EXP;

 //->exp:
 if N2 <> -1 then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N2].MWCS]);
  FSTM(N,F_DataType);
 end;

 {(EXP^2-1)/(EXP^2+1):}
  FMUL0;
  FLD0;
  FLD1;
  FSUBP;
  FLD1;
  FADD2;
  FDIVRP;
  FSTP1;



 if (L > 1) and (N1 <> -1) then
 begin
  N:=TAddress(@Func.CpSt[Interp[CNI].AWCS[N1].MWCS]);
  FSTM(N,F_DataType);
 end;

end;


endp:
end;


procedure TCompiler.ARCSINH;
begin
 MOVA1(TAddress(@R_ARCSINH));
 CALLA;
 CheckStack(1);
 CheckStack(-1);
end;



procedure TCompiler.ARCCOSH;
begin
 MOVA1(TAddress(@R_ARCCOSH));
 CALLA;
 CheckStack(2);
 CheckStack(-2);
end;


procedure TCompiler.ARCTANH;
begin
 MOVA1(TAddress(@R_ARCTANH));
 CALLA;
 CheckStack(2);
 CheckStack(-2);
end;



procedure TCompiler.ARCCOTANH;
begin
 MOVA1(TAddress(@R_ARCCOTANH));
 CALLA;
 CheckStack(2);
 CheckStack(-2);
end;


procedure TCompiler.FABS;
begin
AddWord($D9,$E1);
end;



procedure  TCompiler.FRNDINT;
begin
AddWord($D9,$FC);
end;



procedure TCompiler.TRUNCM(N: TAddress);
begin
FLDCW(TAddress(@FCW1));
FISTP(N);
FLDCW(TAddress(@FCW2));
end;



procedure TCompiler.FTRUNC;
begin
FLDCW(TAddress(@FCW1));
FRNDINT;
FLDCW(TAddress(@FCW2));
end;


procedure TCompiler.LEA_CC8A;
begin
//LEA ECX, ECX+8*EAX
 AddByte($8D);
 AddByte($0C);
 AddByte($C1);
end;

procedure TCompiler.LEA_AC2A;
begin
//LEA EAX, ECX+2*EAX
 AddByte($8D);
 AddByte($04);
 AddByte($41);
end;


procedure TCompiler.LEA_CD8A;
begin
//LEA ECX, EDX+8*EAX
 AddByte($8D);
 AddByte($0C);
 AddByte($C2);
end;

procedure  TCompiler.FLDA_E;
begin
//fld tbyte ptr [EAX]
AddWord($DB,$28);
CheckStack(1);
end;



procedure TCompiler.FACTSTACK;
begin
FLDCW(TAddress(@FCW1));
FISTP(TAddress(@MEM));
FLDCW(TAddress(@FCW2));
MOVMA(TAddress(@MEM));
end;




procedure TCompiler.FUNC1(I: Integer);
var
S: String;
begin
if Interp[i].RCS  = 0 then
begin
 if (Interp[i].EI = 1) and (F_SaveStack = True) and (Interp[i].RData[0] = _MEM) then
 {Stack}
 begin
   FLD(TAddress(@Func.Stack[Interp[i].S]),F_DataType);
 end;

 if Interp[i].EI = 1 then
 begin
  TRUNCM(TAddress(@MEM));
  MOVMA(TAddress(@MEM));
 end
 else
 if Interp[i].EI = 2 then IAVBF(I)
 else
 if Interp[i].EI = 3 then AAI1(I)
end;

InsertFunc1(I);
EndFuncCom(I);
end;






procedure TCompiler.InsertFunc1(I: Integer);
var
S: String;
                procedure AddFunc(I,C: Integer);
                label endp;
                var
                 k: Integer;
                  begin
                  //Если адрес ф-ии = 0 и inl = 1, то ф-ия вставляется непосредственно в код,
                  //если соотв. адрес <> 0, то ф-ия вызывается: mov eax,Addr; call EAX
                  //Это возможно только если ф-ия вычисляется целиком (С=1)
                  //(введено специально для добавляемых ф-ий с FType=1)
                  //Также (в этом случае) возможно переопределение внутренних ф-ий путём
                  //установки нового адреса в FuncList[C_FUNC].Addr=NewFuncAddr при этом
                  //надо (если нужно) изменить глубину стека  FuncList[C_FUNC].NST=NewFuncNST
                   if C = 1 then
                   begin
                     if FuncList[Interp[I].Code].inl = 1 then
                     begin
                      for k:=0 to High(FuncList[Interp[I].Code].inlCode) do
                      begin
                       AddByte(FuncList[Interp[I].Code].inlCode[k]);
                      end;
                     end
                     else
                     if FuncList[Interp[I].Code].Addr <> nil then
                     begin
                      MOVB1(TAddress(FuncList[Interp[I].Code].Addr));
                      CALLB;
                     end;

                     SaveFuncReg(I);

                     goto endp;
                   end;

                   //выполняется только для C=0:
                   {case  Interp[I].Code of
                    C_FACT:             FACT;
                    C_I2PWR:            I2PWR;
                    C_IPWRSGN:          IPWRSGN;
                   end;}

                  endp:
                  end;

begin



//только полное замещение (частичное - в соответствующих ф-ях)
if Interp[i].RCS = 1 then
begin
 FLD(TAddress(@Func.CpSt[Interp[i].MRCS]),F_DataType);
 {$IFDEF TEXTOUT}
 {if (TestG8.Form1.CB_Cod.Checked = True)  then
 TestG8.Form1.M2.Lines[I-1]:='COPYSTACK';  }
 {$ENDIF}
end
else
begin
 //нет чтения и  нет сохранения или нет сохранения по частям (только целиком):
 //(введено специально для добавляемых ф-ий с FType=1)
 if (Interp[i].RCS = 0) and
   ((Length(Interp[i].AWCS) = 0) or ((Length(Interp[i].AWCS) = 1) and (Interp[i].AWCS[0].WCS = 1))) then
 begin
 //глубина стека определяется по NST
  CheckStack(FuncList[Interp[i].Code].NST);
  CheckStack(-FuncList[Interp[i].Code].NST+1);//т.к. аргумент передаётся через EAX,
  F_EnableCheckStack:=False;                  //а возвращается через ST(0)
  AddFunc(I,1);
  F_EnableCheckStack:=True;
 end
 else
 //если есть чтение или сохранение по частям:
 //(для ф-ий с FType = 1 таких нет (зарезервировано для будущих))
 begin
  AddFunc(I,0);
 end;


end;
end;



procedure TCompiler.FIDIV(N: TAddress);
begin
AddWord($DA,$35);
AddAddress(N);
end;




procedure TCompiler.ALS;
begin
//EAX -> ST(0)
MOVAM(TAddress(@MEM));
FILD(TAddress(@MEM));
end;



procedure TCompiler.PUSHM(N: Integer);
begin
//непосредственная загрузка стека
AddCom($68,N);
end;


procedure TCompiler.PUSHF(N: TAddress);
begin
//загрузка стека по адресу: dword ptr [N]
AddWord($FF,$35);
AddAddress(N);
end;




procedure TCompiler.PUSHD;
begin
AddByte($52);
end;

procedure TCompiler.PUSHESP;
begin
AddByte($54);
end;


procedure TCompiler.POPESP;
begin
AddByte($5C);
end;

procedure TCompiler.PUSHEBP;
begin
AddByte($55);
end;


procedure TCompiler.POPEBP;
begin
AddByte($5D);
end;


procedure TCompiler.PUSHESI;
begin
AddByte($56);
end;


procedure TCompiler.POPESI;
begin
AddByte($5E);
end;

procedure TCompiler.PUSHEDI;
begin
AddByte($57);
end;


procedure TCompiler.POPEDI;
begin
AddByte($5F);
end;

procedure TCompiler.POPD;
begin
AddByte($5A);
end;


procedure TCompiler.RET;
begin
AddByte($C3);
end;



end.
