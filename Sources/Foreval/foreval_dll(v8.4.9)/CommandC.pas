unit CommandC;

{******************************************************************************}
{                                                                              }
{  SOREL  (C)CopyRight 1999-2003. Russia, S.-Petersburg.                       }
{                                                                              }
{  оммандный модуль: содержит  исполн€емые функции,                            }
{ + инициализаци€ массива функций и таблицы замещений.                         }
{ »спользовать только на процессорах с автосинхронизацией (486DX и выше):      }
{ отсутствует FWAIT.                                                           }
{                             ver 3.4.18                                       }
{******************************************************************************}



interface
uses
Foreval_HD, MATH, SysUtils;



const
 C1: double = 1;
 C05: double = 0.5;
 C1dpi: extended = 0.3183098861838; {1/Pi;}
 C2dpi: extended = 0.6366197723676; {2/Pi;}
 C2: integer = 2;
 C025: double = 0.25;
 E_CPId2: extended = 1.57079632679489662;{Pi/2;}
 FCW1: Word = $1f32;    {Trunc}
 FCW2: Word = $1332;





//коды комманд должны начинатьс€ с 1 и последовательно возрастать (+1) !!!
//коды C_IPWR3-C_IPWR16;C_IPWR3N-C_IPWR16N должны идти последовательно(+1 на последующий)!!!
 C_LDSC      =   1;
 C_LDSF      =   2;
 C_LDSI      =   3;
 C_FAVB      =   4;
 C_IAVB      =   5;
 C_AIFB      =   6;
 C_AAI       =   7;
 C_AAF       =   8;
 C_AFI       =   9;
 C_MAF       =   10;
 C_MUL       =   11;
 C_ADD       =   12;
 C_NOP       =   13;
 C_PACKAGE =     14;
 C_SQR     =     15;
 C_SQRT =        16;
 C_LN =          17;
 C_EXP =         18;
 C_LOG2 =        19;
 C_LOG10 =       20;
 C_IPWR3 =       21;
 C_IPWR4 =       22;
 C_IPWR5 =       23;
 C_IPWR6 =       24;
 C_IPWR7 =       25;
 C_IPWR8 =       26;
 C_IPWR9 =       27;
 C_IPWR10 =      28;
 C_IPWR11 =      29;
 C_IPWR12 =      30;
 C_IPWR13 =      31;
 C_IPWR14 =      32;
 C_IPWR15 =      33;
 C_IPWR16 =      34;
 C_SIN =         35;
 C_COS =         36;
 C_TAN =         37;
 C_COTAN =       38;
 C_ARCSIN =      39;
 C_ARCCOS =      40;
 C_ARCTAN =      41;
 C_ARCCOTAN =    42;
 C_SINH =        43;
 C_COSH =        44;
 C_TANH =        45;
 C_COTANH =      46;
 C_ARCSINH =     47;
 C_ARCCOSH =     48;
 C_ARCTANH =     49;
 C_ARCCOTANH =   50;
 C_ABS =         51;
 C_TRUNC =       52;
 C_LOGN =        53;
 C_FPWR =        54;
 C_FACT =        55;
 C_IPWR =        56;
 C_IPWRSGN =     57;
 C_I2PWR =       58;
 C_POWER =       59;
 C_ROOT =        60;
 C_FROOT =       61;
 C_IROOT =       62;
 C_IPWR3N =      63;
 C_IPWR4N =      64;
 C_IPWR5N =      65;
 C_IPWR6N =      66;
 C_IPWR7N =      67;
 C_IPWR8N =      68;
 C_IPWR9N =      69;
 C_IPWR10N =     70;
 C_IPWR11N =     71;
 C_IPWR12N =     72;
 C_IPWR13N =     73;
 C_IPWR14N =     74;
 C_IPWR15N =     75;
 C_IPWR16N =     76;
 C_FPWRDVR =     77;
 C_SQRN =        78;




   LFuncList: Integer = 78;



 {const
 c05dln2,c1dln2,c05dln10,c1dln10: extended;
 const c2: single = 2;
 const c05: single = 0.5;
 const c1: single = 1;
 const c025: single = 0.25;
 const c3: single = 3;
 const c4: single = 4;
 const c6: single = 6;
 const cs2: single = -2;

 c05dln2:=0.5/ln(2);
 c05dln10:=0.5/ln(10);
 c1dln2:=1/ln(2);
 c1dln10:=1/ln(10);
 }




 //LInternalFuncList: Integer = 534; //внутренние функции;
                                   //12-18,20,21,23-25,29,32-110,301-305 - свободно

 //LExternalFuncList: Integer = 38;          //внешние ф-ии;(прописанные в €дре (поиск имЄн))



 
//procedure CreateInternalFuncList(var InternalFuncList: TArrayInternalFunc);
//procedure CreateExternalFuncList(var ExternalFuncList: TArrayExternalFunc);
procedure CreateExchTable(FuncList: TArrayFuncList; var XchTable: TArray2I);
procedure CreateFuncList(var FuncList: TArrayFuncList);
//procedure AddSpecialFunction;



procedure R_FPWR;
procedure R_FPWR_Correct;
procedure R_SINH;
procedure R_EXP;
procedure R_LogN;
procedure R_ARCSIN;
procedure R_ARCCOS;
procedure R_COSH;
procedure R_TANH;
procedure R_COTANH;
procedure R_ARCSINH;
procedure R_ARCCOSH;
procedure R_ARCTANH;
procedure R_ARCCOTANH;
procedure R_IPWR;
procedure R_IPWR_Correct;
procedure R_IPWRSGN;
procedure R_IROOT;
procedure R_FROOT;
procedure R_FACT;





implementation
var
MEM: Integer;






procedure AddCode(B1: Byte; FL: TArrayFuncList; Code: Integer); overload;
begin
SetLength(FL[Code].inlCode,Length(FL[Code].inlCode)+1);
FL[Code].inlCode[High(FL[Code].inlCode)]:=B1;
end;

procedure AddCode(B1,B2: Byte; FL: TArrayFuncList; Code: Integer); overload;
begin
SetLength(FL[Code].inlCode,Length(FL[Code].inlCode)+2);
FL[Code].inlCode[High(FL[Code].inlCode)-1]:=B1;
FL[Code].inlCode[High(FL[Code].inlCode)]:=B2;
end;


procedure AddCode(B1,B2,B3: Byte; FL: TArrayFuncList; Code: Integer);  overload;
begin
SetLength(FL[Code].inlCode,Length(FL[Code].inlCode)+3);
FL[Code].inlCode[High(FL[Code].inlCode)-2]:=B1;
FL[Code].inlCode[High(FL[Code].inlCode)-1]:=B2;
FL[Code].inlCode[High(FL[Code].inlCode)]:=B3;
end;

procedure AddCode(B1,B2: Byte; Adr: TAddress; FL: TArrayFuncList; Code: Integer); overload;
var
P: ^TAddress;
begin
SetLength(FL[Code].inlCode,Length(FL[Code].inlCode)+6);
FL[Code].inlCode[High(FL[Code].inlCode)-5]:=B1;
FL[Code].inlCode[High(FL[Code].inlCode)-4]:=B2;
P:=@FL[Code].inlCode[High(FL[Code].inlCode)-3];
P^:=Adr;
end;


procedure FSCALE(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D9,$FD,FL,Code);
end;


procedure FCHS(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D9,$E0,FL,Code);
end;


procedure FILD(Code: Integer; FL: TArrayFuncList; Adr: TAddress);
begin
AddCode($DB,$05,Adr,FL,Code);
end;


procedure FDIVR1(Code: Integer; FL: TArrayFuncList);
begin
AddCode($DC,$3D,TAddress(@C1),FL,Code);
end;


procedure FLDLN2(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D9,$ED,FL,Code);
end;

procedure FLDLG2(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D9,$EC,FL,Code);
end;

procedure FXCH1(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D9,$C9,FL,Code);
end;

procedure FYL2X(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D9,$F1,FL,Code);
end;


procedure FMUL0(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D8,$C8,FL,Code);
end;

procedure FLD0(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D9,$C0,FL,Code);
end;


procedure FMULP1(Code: Integer; FL: TArrayFuncList);
begin
AddCode($DE,$C9,FL,Code);
end;


procedure FABS(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D9,$E1,FL,Code);
end;

procedure FPTAN(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D9,$F2,FL,Code);
end;

procedure FPATAN(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D9,$F3,FL,Code);
end;

procedure FDIVRP(Code: Integer; FL: TArrayFuncList);
begin
AddCode($DE,$F1,FL,Code);
end;

procedure FLD1(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D9,$E8,FL,Code);
end;


procedure FRNDINT(Code: Integer; FL: TArrayFuncList);
begin
AddCode($D9,$FC,FL,Code);
end;

procedure FSTP0(Code: Integer; FL: TArrayFuncList);
begin
AddCode($DD,$D8,FL,Code);
end;

procedure FSUBRP(Code: Integer; FL: TArrayFuncList);
begin
AddCode($DE,$E1,FL,Code);
end;


procedure LEA_CC8A(Code: Integer; FL: TArrayFuncList);
begin
AddCode($8D,$0C,$C1,FL,Code);
end;


procedure LEA_AC2A(Code: Integer; FL: TArrayFuncList);
begin
AddCode($8D,$04,$41,FL,Code);
end;


procedure FLD(Code: Integer; FL: TArrayFuncList; Adr: TAddress);
begin
AddCode($DB,$2D,Adr,FL,Code);
end;


procedure FLDA_E(Code: Integer; FL: TArrayFuncList);
begin
AddCode($DB,$28,FL,Code);
end;



procedure FLDCW(Code: Integer; FL: TArrayFuncList; Adr: TAddress);
begin
AddCode($D9,$2D,Adr,FL,Code);
end;


procedure MOVNC(Code: Integer; FL: TArrayFuncList; Adr: TAddress);
var
P: ^Integer;
begin
SetLength(FL[Code].inlCode,Length(FL[Code].inlCode)+5);
FL[Code].inlCode[High(FL[Code].inlCode)-4]:=$B9;
P:=@FL[Code].inlCode[High(FL[Code].inlCode)-3];
P^:=Adr;
end;

procedure MOVAM(Code: Integer; FL: TArrayFuncList; Adr: TAddress);
begin
AddCode($89,$05,Adr,FL,Code);
end;

procedure _LN(FL: TArrayFuncList);
begin
FL[C_LN].Name[1]:='ln';
FL[C_LN].arg:=1;
FL[C_LN].FType:=2;
FL[C_LN].NST:=1;
FL[C_LN].inl:=1;
FLDLN2(C_LN,FL);
FXCH1(C_LN,FL);
FYL2X(C_LN,FL);
end;


procedure _LOG10(FL: TArrayFuncList);
begin
SetLength(FL[C_LOG10].Name,3);
FL[C_LOG10].Name[1]:='log10';
FL[C_LOG10].Name[2]:='lg';
FL[C_LOG10].arg:=1;
FL[C_LOG10].FType:=2;
FL[C_LOG10].NST:=1;
FL[C_LOG10].inl:=1;
FLDLG2(C_LOG10,FL);
FXCH1(C_LOG10,FL);
FYL2X(C_LOG10,FL);
end;


procedure _LOG2(FL: TArrayFuncList);
begin
SetLength(FL[C_LOG2].Name,3);
FL[C_LOG2].Name[1]:='log2';
FL[C_LOG2].Name[2]:='lg2';
FL[C_LOG2].arg:=1;
FL[C_LOG2].FType:=2;
FL[C_LOG2].NST:=1;
FL[C_LOG2].inl:=1;
FLD1(C_LOG2,FL);
FXCH1(C_LOG2,FL);
FYL2X(C_LOG2,FL);
end;


procedure _SIN(FL: TArrayFuncList);
begin
FL[C_SIN].Name[1]:='sin';
FL[C_SIN].arg:=1;
FL[C_SIN].FType:=2;
FL[C_SIN].NST:=0;
FL[C_SIN].inl:=1;
SetLength(FL[C_SIN].inlCode,2);
FL[C_SIN].inlCode[0]:=$D9;  FL[C_SIN].inlCode[1]:=$FE;
end;

procedure _COS(FL: TArrayFuncList);
begin
FL[C_COS].Name[1]:='cos';
FL[C_COS].arg:=1;
FL[C_COS].FType:=2;
FL[C_COS].NST:=0;
FL[C_COS].inl:=1;
SetLength(FL[C_COS].inlCode,2);
FL[C_COS].inlCode[0]:=$D9; FL[C_COS].inlCode[1]:=$FF;
end;

procedure _SQR(FL: TArrayFuncList);
begin
FL[C_SQR].Name[1]:='sqr';
FL[C_SQR].arg:=1;
FL[C_SQR].FType:=2;
FL[C_SQR].NST:=0;
FL[C_SQR].inl:=1;
FMUL0(C_SQR,FL);
end;

procedure _SQRN(FL: TArrayFuncList);
begin
FL[C_SQRN].Name[1]:='@@sqrn';
FL[C_SQRN].arg:=1;
FL[C_SQRN].FType:=2;
FL[C_SQRN].NST:=1;
FL[C_SQRN].inl:=1;
FMUL0(C_SQRN,FL);

FLD1(C_SQRN,FL);
FDIVRP(C_SQRN,FL);
end;

procedure _SQRT(FL: TArrayFuncList);
begin
FL[C_SQRT].Name[1]:='sqrt';
FL[C_SQRT].arg:=1;
FL[C_SQRT].FType:=2;
FL[C_SQRT].NST:=0;
FL[C_SQRT].inl:=1;
SetLength(FL[C_SQRT].inlCode,2);
FL[C_SQRT].inlCode[0]:=$D9;   FL[C_SQRT].inlCode[1]:=$FA;
end;



procedure _COTAN(FL: TArrayFuncList);
begin
SetLength(FL[C_COTAN].Name,3);
FL[C_COTAN].Name[1]:='cotan';
FL[C_COTAN].Name[2]:='ctg';
FL[C_COTAN].arg:=1;
FL[C_COTAN].FType:=2;
FL[C_COTAN].NST:=1;
FL[C_COTAN].inl:=1;
FPTAN(C_COTAN,FL);
FDIVRP(C_COTAN,FL);
end;


procedure _TAN(FL: TArrayFuncList);
begin
SetLength(FL[C_TAN].Name,3);
FL[C_TAN].Name[1]:='tan';
FL[C_TAN].Name[2]:='tg';
FL[C_TAN].arg:=1;
FL[C_TAN].FType:=2;
FL[C_TAN].NST:=1;
FL[C_TAN].inl:=1;
FPTAN(C_TAN,FL);
FSTP0(C_TAN,FL);
end;




procedure _ARCTAN(FL: TArrayFuncList);
begin
SetLength(FL[C_ARCTAN].Name,3);
FL[C_ARCTAN].Name[1]:='arctan';
FL[C_ARCTAN].Name[2]:='arctg';
FL[C_ARCTAN].arg:=1;
FL[C_ARCTAN].FType:=2;
FL[C_ARCTAN].NST:=1;
FL[C_ARCTAN].inl:=1;
FLD1(C_ARCTAN,FL);
FPATAN(C_ARCTAN,FL);
end;

procedure _ARCCOTAN(FL: TArrayFuncList);
begin
SetLength(FL[C_ARCCOTAN].Name,3);
FL[C_ARCCOTAN].Name[1]:='arccotan';
FL[C_ARCCOTAN].Name[2]:='arcctg';
FL[C_ARCCOTAN].arg:=1;
FL[C_ARCCOTAN].FType:=2;
FL[C_ARCCOTAN].NST:=1;
FL[C_ARCCOTAN].inl:=1;
FLD1(C_ARCCOTAN,FL);
FPATAN(C_ARCCOTAN,FL);
FLD(C_ARCCOTAN,FL,TAddress(@E_CPid2));
FSUBRP(C_ARCCOTAN,FL);
end;


procedure _ABS(FL: TArrayFuncList);
begin
FL[C_ABS].Name[1]:='abs';
FL[C_ABS].arg:=1;
FL[C_ABS].FType:=2;
FL[C_ABS].inl:=1;
FABS(C_ABS,FL);
end;


procedure _TRUNC(FL: TArrayFuncList);
begin
FL[C_TRUNC].Name[1]:='trunc';
FL[C_TRUNC].arg:=1;
FL[C_TRUNC].FType:=2;
FL[C_TRUNC].inl:=1;
FLDCW(C_TRUNC,FL,TAddress(@FCW1));
FRNDINT(C_TRUNC,FL);
FLDCW(C_TRUNC,FL,TAddress(@FCW2));
end;


procedure _FACT(FL: TArrayFuncList);
begin
FL[C_FACT].Name[1]:='fact';
FL[C_FACT].arg:=1;
FL[C_FACT].FType:=1;
FL[C_FACT].inl:=1;
FL[C_FACT].NST:=1;
FL[C_I2PWR].SaveReg:=5; //EAX+ECX
MOVNC(C_FACT,FL,TAddress(@Factorial[0]));
LEA_CC8A(C_FACT,FL);
LEA_AC2A(C_FACT,FL);
FLDA_E(C_FACT,FL);
end;


procedure _IPWRSGN(FL: TArrayFuncList);
begin
FL[C_IPWRSGN].Name[1]:='@@IPWRSGN';
FL[C_IPWRSGN].arg:=1;
FL[C_IPWRSGN].FType:=1;
FL[C_IPWRSGN].inl:=1;
FL[C_IPWRSGN].NST:=1;
FL[C_I2PWR].SaveReg:=1;

FLD1(C_IPWRSGN,FL);
//and eax,1
SetLength(FL[C_IPWRSGN].inlCode,Length(FL[C_IPWRSGN].inlCode)+3);
FL[C_IPWRSGN].inlCode[High(FL[C_IPWRSGN].inlCode)-2]:=$83;
FL[C_IPWRSGN].inlCode[High(FL[C_IPWRSGN].inlCode)-1]:=$E0;
FL[C_IPWRSGN].inlCode[High(FL[C_IPWRSGN].inlCode)]:=$01;
//jz +$2
SetLength(FL[C_IPWRSGN].inlCode,Length(FL[C_IPWRSGN].inlCode)+2);
FL[C_IPWRSGN].inlCode[High(FL[C_IPWRSGN].inlCode)-1]:=$74;
FL[C_IPWRSGN].inlCode[High(FL[C_IPWRSGN].inlCode)]:=$02;

FCHS(C_IPWRSGN,FL);
end;


procedure _FPWRDVR(FL: TArrayFuncList);
begin
FL[C_FPWRDVR].Name[1]:='@@FPWRDVR';
FL[C_FPWRDVR].arg:=1;
FL[C_FPWRDVR].FType:=2;
FL[C_FPWRDVR].NST:=1;
FL[C_FPWRDVR].inl:=1;

FLD1(C_FPWRDVR,FL);
FDIVRP(C_FPWRDVR,FL);
end;


procedure _I2PWR(FL: TArrayFuncList);
begin
FL[C_I2PWR].Name[1]:='@@I2PWR';
FL[C_I2PWR].arg:=1;
FL[C_I2PWR].FType:=1;
FL[C_I2PWR].inl:=1;
FL[C_I2PWR].NST:=2;
FL[C_I2PWR].SaveReg:=1;
MOVAM(C_I2PWR,FL,TAddress(@MEM));
FILD(C_I2PWR,FL,TAddress(@MEM));
FLD1(C_I2PWR,FL);
FSCALE(C_I2PWR,FL);
FXCH1(C_I2PWR,FL);
FSTP0(C_I2PWR,FL);
end;





procedure _IPWR3(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR3
else Code:=C_IPWR3N;

FL[Code].NST:=1;

FLD0(Code,FL);
FMUL0(Code,FL);
FMULP1(Code,FL);

if N = 1 then FDIVR1(Code,FL);
end;


procedure _IPWR4(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR4
else Code:=C_IPWR4N;

FL[Code].NST:=0;

FMUL0(Code,FL);
FMUL0(Code,FL);

if N = 1 then FDIVR1(Code,FL);
end;


procedure _IPWR5(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR5
else Code:=C_IPWR5N;

FL[Code].NST:=1;

FLD0(Code,FL);
FMUL0(Code,FL);
FMUL0(Code,FL);
FMULP1(Code,FL);

if N = 1 then FDIVR1(Code,FL);
end;


procedure _IPWR6(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR6
else Code:=C_IPWR6N;

FL[Code].NST:=1;

FMUL0(Code,FL);
FLD0(Code,FL);
FMUL0(Code,FL);
FMULP1(Code,FL);

if N = 1 then FDIVR1(Code,FL);
end;



procedure _IPWR7(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR7
else Code:=C_IPWR7N;

FL[Code].NST:=2;

FLD0(Code,FL);
FMUL0(Code,FL);
FLD0(Code,FL);
FMUL0(Code,FL);
FMULP1(Code,FL);
FMULP1(Code,FL);

if N = 1 then FDIVR1(Code,FL);
end;



procedure _IPWR8(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR8
else Code:=C_IPWR8N;

FL[Code].NST:=0;

FMUL0(Code,FL);
FMUL0(Code,FL);
FMUL0(Code,FL);

if N = 1 then FDIVR1(Code,FL);
end;



procedure _IPWR9(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR9
else Code:=C_IPWR9N;

FL[Code].NST:=1;

FLD0(Code,FL);
FMUL0(Code,FL);
FMUL0(Code,FL);
FMUL0(Code,FL);
FMULP1(Code,FL);

if N = 1 then FDIVR1(Code,FL);
end;



procedure _IPWR10(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR10
else Code:=C_IPWR10N;

FL[Code].NST:=1;

FMUL0(Code,FL);
FLD0(Code,FL);
FMUL0(Code,FL);
FMUL0(Code,FL);
FMULP1(Code,FL);

if N = 1 then FDIVR1(Code,FL);
end;



procedure _IPWR11(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR11
else Code:=C_IPWR11N;

FL[Code].NST:=2;

FLD0(Code,FL);
FMUL0(Code,FL);
FLD0(Code,FL);
FMUL0(Code,FL);
FMUL0(Code,FL);
FMULP1(Code,FL);
FMULP1(Code,FL);

if N = 1 then FDIVR1(Code,FL);
end;



procedure _IPWR12(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR12
else Code:=C_IPWR12N;

FL[Code].NST:=1;

FMUL0(Code,FL);
FMUL0(Code,FL);
FLD0(Code,FL);
FMUL0(Code,FL);
FMULP1(Code,FL);


if N = 1 then FDIVR1(Code,FL);
end;



procedure _IPWR13(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR13
else Code:=C_IPWR13N;

FL[Code].NST:=2;

FLD0(Code,FL);
FMUL0(Code,FL);
FMUL0(Code,FL);
FLD0(Code,FL);
FMUL0(Code,FL);
FMULP1(Code,FL);
FMULP1(Code,FL);

if N = 1 then FDIVR1(Code,FL);
end;



procedure _IPWR14(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR14
else Code:=C_IPWR14N;

FL[Code].NST:=2;

FMUL0(Code,FL);
FLD0(Code,FL);
FMUL0(Code,FL);
FLD0(Code,FL);
FMUL0(Code,FL);
FMULP1(Code,FL);
FMULP1(Code,FL);


if N = 1 then FDIVR1(Code,FL);
end;



procedure _IPWR15(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR15
else Code:=C_IPWR15N;

FL[Code].NST:=3;

FLD0(Code,FL);
FLD0(Code,FL);
FMUL0(Code,FL);
FLD0(Code,FL);
FMUL0(Code,FL);
FMULP1(Code,FL);
FMULP1(Code,FL);
FMUL0(Code,FL);
FMULP1(Code,FL);


if N = 1 then FDIVR1(Code,FL);
end;



procedure _IPWR16(FL: TArrayFuncList; N: Integer);
var
Code: Integer;
begin
if N = 0 then Code:=C_IPWR16
else Code:=C_IPWR16N;

FL[Code].NST:=0;


FMUL0(Code,FL);
FMUL0(Code,FL);
FMUL0(Code,FL);
FMUL0(Code,FL);


if N = 1 then FDIVR1(Code,FL);
end;



procedure _IPWRC(FL: TArrayFuncList);
var
Code,CodeN,i: Integer;
S: String;
begin
S:='@@IPWR'; Code:=C_IPWR3-1; CodeN:=C_IPWR3N-1;
for i:=3 to 16 do
begin
 Code:=Code+1;
 FL[Code].Name[1]:=S+IntToStr(i);
 FL[Code].arg:=1;
 FL[Code].FType:=2;
 FL[Code].inl:=1;
 CodeN:=CodeN+1;
 FL[CodeN].Name[1]:=S+IntToStr(i)+'N';
 FL[CodeN].arg:=1;
 FL[CodeN].FType:=2;
 FL[CodeN].inl:=1;
end;

_IPWR3(FL,0);  _IPWR3(FL,1);
_IPWR4(FL,0);  _IPWR4(FL,1);
_IPWR5(FL,0);  _IPWR5(FL,1);
_IPWR6(FL,0);  _IPWR6(FL,1);
_IPWR7(FL,0);  _IPWR7(FL,1);
_IPWR8(FL,0);  _IPWR8(FL,1);
_IPWR9(FL,0);  _IPWR9(FL,1);
_IPWR10(FL,0); _IPWR10(FL,1);
_IPWR11(FL,0); _IPWR11(FL,1);
_IPWR12(FL,0); _IPWR12(FL,1);
_IPWR13(FL,0); _IPWR13(FL,1);
_IPWR14(FL,0); _IPWR14(FL,1);
_IPWR15(FL,0); _IPWR15(FL,1);
_IPWR16(FL,0); _IPWR16(FL,1);
end;



procedure CreateFuncList(var FuncList: TArrayFuncList);
var
i: Integer;
begin
//список внутренних (исполн€емых) функций

SetLength(FuncList,LFuncList+1);
for i:=1 to  High(FuncList) do
begin
 FuncList[i].NST:=0;
 SetLength(FuncList[i].Name,2);
 FuncList[i].arg:=0;
 FuncList[i].Addr:=nil;
 FuncList[i].inl:=0;
 FuncList[i].inlCode:=nil;
 FuncList[i].SaveReg:=0;
end;

FuncList[C_LDSC].Name[1]:='@@LDSC';
FuncList[C_LDSC].FType:=0;

FuncList[C_LDSF].Name[1]:='@@LDSF';
FuncList[C_LDSF].FType:=0;

FuncList[C_LDSI].Name[1]:='@@LDSI';
FuncList[C_LDSI].FType:=0;

FuncList[C_FAVB].Name[1]:='@@FAVB';
FuncList[C_FAVB].FType:=0;

FuncList[C_IAVB].Name[1]:='@@IAVB';
FuncList[C_IAVB].FType:=0;

FuncList[C_AIFB].Name[1]:='@@AIFB';
FuncList[C_AIFB].FType:=0;

FuncList[C_AAI].Name[1]:='@@AAI';
FuncList[C_AAI].FType:=0;

FuncList[C_AAF].Name[1]:='@@AAF';
FuncList[C_AAF].FType:=0;

FuncList[C_AFI].Name[1]:='@@AFI';
FuncList[C_AFI].FType:=0;

FuncList[C_MAF].Name[1]:='@@MAF';
FuncList[C_MAF].FType:=0;

FuncList[C_MUL].Name[1]:='@@MUL';
FuncList[C_MUL].FType:=0;

FuncList[C_ADD].Name[1]:='@@ADD';
FuncList[C_ADD].FType:=0;

FuncList[C_NOP].Name[1]:='@@NOP';
FuncList[C_NOP].FType:=0;

FuncList[C_PACKAGE].Name[1]:='@@PACKAGE';
FuncList[C_PACKAGE].FType:=0;

_SIN(FuncList);
_COS(FuncList);
_LN(FuncList);
_SQR(FuncList);
_SQRT(FuncList);
_COTAN(FuncList);
_TAN(FuncList);
_ARCTAN(FuncList);
_ARCCOTAN(FuncList);
_LOG10(FuncList);
_LOG2(FuncList);
_ABS(FuncList);
_TRUNC(FuncList);
_FACT(FuncList);
_IPWRSGN(FuncList);
_FPWRDVR(FuncList);
_I2PWR(FuncList);
_IPWRC(FuncList);
_SQRN(FuncList);





FuncList[C_EXP].Name[1]:='exp';
FuncList[C_EXP].Addr:=@R_EXP;
FuncList[C_EXP].arg:=1;
FuncList[C_EXP].FType:=2;
FuncList[C_EXP].NST:=2;

FuncList[C_ARCSIN].Name[1]:='arcsin';
FuncList[C_ARCSIN].Addr:=@R_ARCSIN;
FuncList[C_ARCSIN].arg:=1;
FuncList[C_ARCSIN].FType:=2;
FuncList[C_ARCSIN].NST:=2;


FuncList[C_ARCCOS].Name[1]:='arccos';
FuncList[C_ARCCOS].Addr:=@R_ARCCOS;
FuncList[C_ARCCOS].arg:=1;
FuncList[C_ARCCOS].FType:=2;
FuncList[C_ARCCOS].NST:=2;


SetLength(FuncList[C_SINH].Name,3);
FuncList[C_SINH].Name[1]:='sinh';
FuncList[C_SINH].Name[2]:='sh';
FuncList[C_SINH].Addr:=@R_SINH;
FuncList[C_SINH].arg:=1;
FuncList[C_SINH].FType:=2;
FuncList[C_SINH].NST:=2;


SetLength(FuncList[C_COSH].Name,3);
FuncList[C_COSH].Name[1]:='cosh';
FuncList[C_COSH].Name[2]:='ch';
FuncList[C_COSH].Addr:=@R_COSH;
FuncList[C_COSH].arg:=1;
FuncList[C_COSH].FType:=2;
FuncList[C_COSH].NST:=2;


SetLength(FuncList[C_TANH].Name,3);
FuncList[C_TANH].Name[1]:='tanh';
FuncList[C_TANH].Name[2]:='th';
FuncList[C_TANH].Addr:=@R_TANH;
FuncList[C_TANH].arg:=1;
FuncList[C_TANH].FType:=2;
FuncList[C_TANH].NST:=2;


SetLength(FuncList[C_COTANH].Name,3);
FuncList[C_COTANH].Name[1]:='cotanh';
FuncList[C_COTANH].Name[2]:='cth';
FuncList[C_COTANH].Addr:=@R_COTANH;
FuncList[C_COTANH].arg:=1;
FuncList[C_COTANH].FType:=2;
FuncList[C_COTANH].NST:=2;


SetLength(FuncList[C_ARCSINH].Name,3);
FuncList[C_ARCSINH].Name[1]:='arcsinh';
FuncList[C_ARCSINH].Name[2]:='arsh';
FuncList[C_ARCSINH].Addr:=@R_ARCSINH;
FuncList[C_ARCSINH].arg:=1;
FuncList[C_ARCSINH].FType:=2;
FuncList[C_ARCSINH].NST:=2;


SetLength(FuncList[C_ARCCOSH].Name,3);
FuncList[C_ARCCOSH].Name[1]:='arccosh';
FuncList[C_ARCCOSH].Name[2]:='arch';
FuncList[C_ARCCOSH].Addr:=@R_ARCCOSH;
FuncList[C_ARCCOSH].arg:=1;
FuncList[C_ARCCOSH].FType:=2;
FuncList[C_ARCCOSH].NST:=2;

SetLength(FuncList[C_ARCTANH].Name,3);
FuncList[C_ARCTANH].Name[1]:='arctanh';
FuncList[C_ARCTANH].Name[2]:='arth';
FuncList[C_ARCTANH].Addr:=@R_ARCTANH;
FuncList[C_ARCTANH].arg:=1;
FuncList[C_ARCTANH].FType:=2;
FuncList[C_ARCTANH].NST:=2;


SetLength(FuncList[C_ARCCOTANH].Name,3);
FuncList[C_ARCCOTANH].Name[1]:='arccotanh';
FuncList[C_ARCCOTANH].Name[2]:='arcth';
FuncList[C_ARCCOTANH].Addr:=@R_ARCCOTANH;
FuncList[C_ARCCOTANH].arg:=1;
FuncList[C_ARCCOTANH].FType:=2;
FuncList[C_ARCCOTANH].NST:=2;



FuncList[C_POWER].Name[1]:='power';//при разборе переходит в FPWR,IPWR,IPWRC,IPWRSGN,I2PWR,sqrt,sqr
FuncList[C_POWER].arg:=2;
FuncList[C_POWER].FType:=4;


SetLength(FuncList[C_LOGN].Name,3);
FuncList[C_LOGN].Name[1]:='logn';
FuncList[C_LOGN].Name[2]:='log';
FuncList[C_LOGN].Addr:=@R_LOGN;
FuncList[C_LOGN].arg:=2;
FuncList[C_LOGN].FType:=4;
FuncList[C_LOGN].NST:=1;


FuncList[C_ROOT].Name[1]:='root';
FuncList[C_ROOT].arg:=2;
FuncList[C_ROOT].FType:=4;


FuncList[C_IROOT].Name[1]:='@@IROOT';
FuncList[C_IROOT].Addr:=@R_IROOT;
FuncList[C_IROOT].arg:=2;
FuncList[C_IROOT].FType:=3;
FuncList[C_IROOT].SaveReg:=3; //EAX+EBX
FuncList[C_IROOT].NST:=2;

FuncList[C_FROOT].Name[1]:='@@FROOT';
FuncList[C_FROOT].Addr:=@R_FROOT;
FuncList[C_FROOT].arg:=2;
FuncList[C_FROOT].FType:=4;
FuncList[C_FROOT].SaveReg:=3; //EAX
FuncList[C_FROOT].NST:=1;


FuncList[C_IPWR].Name[1]:='@@IPWR';
FuncList[C_IPWR].Addr:=@R_IPWR;
FuncList[C_IPWR].arg:=1;
FuncList[C_IPWR].FType:=3;
FuncList[C_IPWR].SaveReg:=13; //EAX+ECX+EDX
FuncList[C_IPWR].NST:=1;


FuncList[C_FPWR].Name[1]:='@@FPWR';
FuncList[C_FPWR].Addr:=@R_FPWR;
FuncList[C_FPWR].arg:=2;
FuncList[C_FPWR].FType:=4;
FuncList[C_FPWR].SaveReg:=13; //EAX+ECX+EDX
FuncList[C_FPWR].NST:=1;




end;



procedure CreateExchTable(FuncList: TArrayFuncList; var XchTable: TArray2I);
var
i,j,L: Integer;
begin
//XchTable:

{ Func1 -> Func2         }

{ ------> Func1 - главна€}
{ |                      }
{ |                      }
{ |                      }
{ |                      }
{ V Func2 - замен€ема€   }

{
ячейка таблицы:
|---------|     WCS - ранг  сохранени€ (кака€ часть команды (Func1) сохран€етс€)
| `  WCS  |     RCS - приоритет чтени€ (кака€ часть команды (Func2) замещаетс€)
|   `     |     NC  - число сохран€емых частей за раз
| RCS `   |
|-------- |


RCS:
0 - нет замены;
1 - полна€ замена;
далее приоритет падает с ростом RCS
}


//XchCode:
{XchCode[Number of Length of  XchTable] = Number Function in FuncList}




 L:=LFuncList+1;
 SetLength(XchTable,L,L);

 for i:=1 to L-1 do
 begin
  for j:=0 to L-1 do
  begin
   XchTable[i,j].RCS:=0;
   XchTable[i,j].WCS:=0;
   XchTable[i,j].NC:=0;
   if (i=j) and (FuncList[i].FType > 0) then
   begin
    XchTable[i,j].RCS:=1;
    XchTable[i,j].WCS:=1;
    XchTable[i,j].NC:=1;
   end;
  end;
 end;


 //////частична€ замена отключена из-за ошибки:  sh(x)/(-exp(x))+ch(x)/(-sh(x))

 //гиперб. ф-ии: S=exp;
 //дл€ sh,ch (соответственно):
 //(RCS: 1 - (sh,ch); 2 - (exp,1/exp); 3 - (exp))
 //(WCS: -//-)
 //дл€ th,cth (соответственно):
 //(RCS: 1 - (th,cth); 2 - (cth,th); 3 - (exp))
 //(WCS: 1 - (th,cth); 2 - (exp))
(*
 //sh->ch (S; 1/S)
 XchTable[C_SINH,C_COSH].RCS:=2;  XchTable[C_SINH,C_COSH].WCS:=2;  XchTable[C_SINH,C_COSH].NC:=2;
 //sh->th (S)
 XchTable[C_SINH,C_TANH].RCS:=3;  XchTable[C_SINH,C_TANH].WCS:=3;  XchTable[C_SINH,C_TANH].NC:=1;
 //sh->cth (S)
 XchTable[C_SINH,C_COTANH].RCS:=3;  XchTable[C_SINH,C_COTANH].WCS:=3;  XchTable[C_SINH,C_COTANH].NC:=1;
 //sh->exp (S)
 XchTable[C_SINH,C_EXP].RCS:=1;  XchTable[C_SINH,C_EXP].WCS:=3;  XchTable[C_SINH,C_EXP].NC:=1;
 //exp->sh (S)
 XchTable[C_EXP,C_SINH].RCS:=3;  XchTable[C_EXP,C_SINH].WCS:=1;  XchTable[C_EXP,C_SINH].NC:=1;
 //exp->ch (S)
 XchTable[C_EXP,C_COSH].RCS:=3;  XchTable[C_EXP,C_COSH].WCS:=1;  XchTable[C_EXP,C_COSH].NC:=1;
 //exp->th (S)
 XchTable[C_EXP,C_TANH].RCS:=3;  XchTable[C_EXP,C_TANH].WCS:=1;  XchTable[C_EXP,C_TANH].NC:=1;
 //exp->cth (S)
 XchTable[C_EXP,C_COTANH].RCS:=3;  XchTable[C_EXP,C_COTANH].WCS:=1;  XchTable[C_EXP,C_COTANH].NC:=1;
 //ch->sh (S; 1/S)
 XchTable[C_COSH,C_SINH].RCS:=2;  XchTable[C_COSH,C_SINH].WCS:=2;  XchTable[C_COSH,C_SINH].NC:=2;
 //ch->th (S)
 XchTable[C_COSH,C_TANH].RCS:=3;  XchTable[C_COSH,C_TANH].WCS:=3;  XchTable[C_COSH,C_TANH].NC:=1;
 //ch->cth (S)
 XchTable[C_COSH,C_COTANH].RCS:=3;  XchTable[C_COSH,C_COTANH].WCS:=3;  XchTable[C_COSH,C_COTANH].NC:=1;
 //ch->exp (S)
 XchTable[C_COSH,C_EXP].RCS:=1;  XchTable[C_COSH,C_EXP].WCS:=3;  XchTable[C_COSH,C_EXP].NC:=1;
 //th->ch (S)
 XchTable[C_TANH,C_COSH].RCS:=3;  XchTable[C_TANH,C_COSH].WCS:=2;  XchTable[C_TANH,C_COSH].NC:=1;
 //th->sh (S)
 XchTable[C_TANH,C_SINH].RCS:=3;  XchTable[C_TANH,C_SINH].WCS:=2;  XchTable[C_TANH,C_SINH].NC:=1;
 //th->cth (th)
 XchTable[C_TANH,C_COTANH].RCS:=2;  XchTable[C_TANH,C_COTANH].WCS:=1;  XchTable[C_TANH,C_COTANH].NC:=1;
 //th->exp (S)
 XchTable[C_TANH,C_EXP].RCS:=1;  XchTable[C_TANH,C_EXP].WCS:=2;  XchTable[C_TANH,C_EXP].NC:=1;
 //cth->ch (S)
 XchTable[C_COTANH,C_COSH].RCS:=3;  XchTable[C_COTANH,C_COSH].WCS:=2;  XchTable[C_COTANH,C_COSH].NC:=1;
 //cth->sh (S)
 XchTable[C_COTANH,C_SINH].RCS:=3;  XchTable[C_COTANH,C_SINH].WCS:=2;  XchTable[C_COTANH,C_SINH].NC:=1;
 //cth->th  (cth)
 XchTable[C_COTANH,C_TANH].RCS:=2;  XchTable[C_COTANH,C_TANH].WCS:=1;  XchTable[C_COTANH,C_TANH].NC:=1;
 //cth->exp (S)
 XchTable[C_COTANH,C_EXP].RCS:=1;  XchTable[C_COTANH,C_EXP].WCS:=2;  XchTable[C_COTANH,C_EXP].NC:=1;


 //arcsin->arccos
 XchTable[C_ARCSIN,C_ARCCOS].RCS:=2;   XchTable[C_ARCSIN,C_ARCCOS].WCS:=1;   XchTable[C_ARCSIN,C_ARCCOS].NC:=1;
 //arccos->arcsin
 XchTable[C_ARCCOS,C_ARCSIN].RCS:=2;   XchTable[C_ARCCOS,C_ARCSIN].WCS:=1;   XchTable[C_ARCCOS,C_ARCSIN].NC:=1;


 //arctg->arcctg
 XchTable[C_ARCTAN,C_ARCCOTAN].RCS:=2;   XchTable[C_ARCTAN,C_ARCCOTAN].WCS:=1;   XchTable[C_ARCTAN,C_ARCCOTAN].NC:=1;
 //arcctg->arctg
 XchTable[C_ARCCOTAN,C_ARCTAN].RCS:=1;   XchTable[C_ARCCOTAN,C_ARCTAN].WCS:=2;   XchTable[C_ARCCOTAN,C_ARCTAN].NC:=1;

//tg->ctg
 XchTable[C_TAN,C_COTAN].RCS:=2;   XchTable[C_TAN,C_COTAN].WCS:=1;   XchTable[C_TAN,C_COTAN].NC:=1;
 //ctg->tg
 XchTable[C_COTAN,C_TAN].RCS:=1;   XchTable[C_COTAN,C_TAN].WCS:=2;   XchTable[C_COTAN,C_TAN].NC:=1;

 //sin->cos  (через fsincos)
 XchTable[C_SIN,C_COS].RCS:=1;  XchTable[C_SIN,C_COS].WCS:=2;  XchTable[C_SIN,C_COS].NC:=1;
 //cos->sin (через fsincos)
 XchTable[C_COS,C_SIN].RCS:=1;  XchTable[C_COS,C_SIN].WCS:=2;  XchTable[C_COS,C_SIN].NC:=1;
 *)



end;






procedure R_FPWR;    assembler;
asm
//X^Y
//ST(0) <- X
//ST(1) <- Y


     FXCH
     FIST      MEM
     FICOM     MEM
     FNSTSW    AX
     SAHF;
     JZ        @@1
     JMP       @@2
@@1:

     FXCH
     FSTP     ST(1)
     MOV      EAX, MEM



     //PUSH     ECX
     //PUSH     EDX

     fld1
     fxch
     mov     ecx, eax
     cdq
     xor     eax, edx
     sub     eax, edx
     jnz     @@5
     fstp    ST(0)
     //POP     EDX
     //POP     ECX
     jmp     @@3
@@4: fmul    ST, ST
@@5: shr     eax,1
     jnc     @@4
     fmul    ST(1),ST
     jnz     @@4
     fstp    st
     cmp     ecx, 0

     //POP     EDX
     //POP     ECX
     jge     @@3
     fdivr   c1
     {fld1
     fdivrp}


     JMP     @@3

@@2:


     FXCH

     FLDZ            {.}
     FCOMP           {.}
     FSTSW   AX      {.}
     SAHF            {.}
     JZ     @@3      {.} //устран€ет ошибки типа 0^F; F - дробна€ степень

     FYL2X
     FLD     ST(0)
     FRNDINT
     FSUB    ST(1), ST
     FXCH    ST(1)
     F2XM1
     FLD1
     FADD
     FSCALE
     FSTP  ST(1)

@@3:

end;





procedure R_FPWR_Correct;    assembler;
asm
//X^Y
//ST(0) <- X
//ST(1) <- Y


     FXCH
     FIST      MEM
     FICOM     MEM
     FNSTSW    AX
     SAHF;
     JZ        @@1
     JMP       @@2
@@1:

     FXCH
     FSTP     ST(1)
     MOV      EAX, MEM
     //PUSH     ECX
     //PUSH     EDX
     fld1
     fxch
     mov     ecx, eax
     cdq
     xor     eax, edx
     sub     eax, edx
     jnz     @@5
     fstp    ST(0)
     //POP     EDX
     //POP     ECX
     jmp     @@3
@@4: fmul    ST, ST
@@5: shr     eax,1
     jnc     @@4
     fmul    ST(1),ST
     jnz     @@4
     fstp    st
     cmp     ecx, 0

     //POP     EDX
     //POP     ECX
     jge     @@6
     fdivr   c1
     {fld1
     fdivrp}
@@6:
     //возникает странна€ ошибка: результат "прыгает", например: sin((3*x+4)^(2*y-1)) [x=2,y=5]
     //дл€ этого добавл€ютс€ wait
     wait
     wait
     wait
     wait
     wait
     JMP     @@3

@@2:


     FXCH

     FLDZ            {.}
     FCOMP           {.}
     FSTSW   AX      {.}
     SAHF            {.}
     JZ     @@3      {.} //устран€ет ошибки типа 0^F; F - дробна€ степень

     FYL2X
     FLD     ST(0)
     FRNDINT
     FSUB    ST(1), ST
     FXCH    ST(1)
     F2XM1
     FLD1
     FADD
     FSCALE
     FSTP  ST(1)

@@3:

end;




procedure  R_IROOT; assembler;
//EAX - степень; ST(0) - основание;
asm
     //push    bx

     xor     bx,bx    //знак числа '+'
     mov     MEM,eax  //сохранение
     fldz
     fcomp
     fnstsw  ax
     sahf
     mov     eax,MEM //восстановление
     ja      @@1  // число < 0
     jb      @@2  // число > 0
                  // число = 0:
     fstp    ST(0)
     fldz
     jmp     @@5

@@1:
     bt      eax,0
     jc      @@3      //если степень нечЄтна€

     xor     eax,eax    //вызвать ошибку если степень чЄтна€
     div     eax
@@3:
     or      bx,1b     //знак '-'
     fabs
@@2:

     fld1
     fild    dword ptr [MEM]
     fdivp
     fxch
     FYL2X
     FLD     ST(0)
     FRNDINT
     FSUB    ST(1), ST
     FXCH    ST(1)
     F2XM1
     FLD1
     FADD
     FSCALE
     FSTP    ST(1)

     bt      bx,0
     jnc     @@5
     fchs

@@5:
     //pop     bx

end;



procedure  R_FROOT; assembler;
//ST(1) - степень; ST(0) - основание;
asm

     FXCH
     FIST      MEM
     FICOM     MEM
     FNSTSW    AX
     SAHF;
     JNZ        @@F   //не целое

     FXCH
     FSTP     ST(1)
     MOV      EAX, MEM
     CALL     R_IROOT


     {
     xor     bx,bx    //знак числа '+'
     mov     MEM,eax  //сохранение
     fldz
     fcomp
     fnstsw  ax
     sahf
     mov     eax,MEM //восстановление
     ja      @@1  // число < 0
     jb      @@2  // число > 0
                  // число = 0:
     fstp    ST(0)
     fldz
     jmp     @@END

@@1:
     bt      eax,0
     jc      @@3      //если степень нечЄтна€

     xor     eax,eax    //вызвать ошибку если степень чЄтна€
     div     eax
@@3:
     or      bx,1b     //знак '-'
     fabs
@@2:

     fld1
     fild    dword ptr [MEM]
     fdivp
     fxch
     FYL2X
     FLD     ST(0)
     FRNDINT
     FSUB    ST(1), ST
     FXCH    ST(1)
     F2XM1
     FLD1
     FADD
     FSCALE
     FSTP    ST(1)

     bt      bx,0
     jnc     @@END
     fchs

     }
     JMP      @@END



@@F:
     fld1
     fdivrp
     fxch
     FYL2X
     FLD     ST(0)
     FRNDINT
     FSUB    ST(1), ST
     FXCH    ST(1)
     F2XM1
     FLD1
     FADD
     FSCALE
     FSTP    ST(1)

@@END:
end;




procedure R_SINH; assembler;
asm
  FLDL2E
  FMUL
  FLD     ST(0)
  FRNDINT
  FSUB    ST(1), ST
  FXCH    ST(1)
  F2XM1
  FLD1
  FADD
  FSCALE
  FSTP    ST(1)

  FLD   ST(0)
  FLD1
  FDIVR
  FSUB
  FMUL   C05
end;


procedure R_EXP; assembler;
asm
        FLDL2E
        FMUL
        FLD     ST(0)
        FRNDINT
        FSUB    ST(1), ST
        FXCH    ST(1)
        F2XM1
        FLD1
        FADD
        FSCALE
        FSTP ST(1)
end;



procedure R_LogN; assembler;
//ST(0) <- Y
//ST(1) <- X
asm
        FXCH
        FLD1
        FXCH
        FYL2X
        FXCH
        FLD1
        FXCH
        FYL2X
        FDIV
end;





procedure R_ARCSIN; assembler;
asm
  FLD   ST
  FMUL  ST,ST
  FLD1
  FSUBR
  FSQRT
  FPATAN
end;



procedure R_ARCCOS; assembler;
asm      //arctan(sqrt(1-sqr(S))/S)
  FLD   ST
  FMUL  ST,ST
  FLD1
  FSUBR
  FSQRT
  FXCH
  FPATAN
end;



procedure R_COSH; assembler;
asm
  FLDL2E
  FMUL
  FLD     ST(0)
  FRNDINT
  FSUB    ST(1), ST
  FXCH    ST(1)
  F2XM1
  FLD1
  FADD
  FSCALE
  FSTP    ST(1)

  FLD     ST(0)
  FLD1
  FDIVR
  FADD
  FMUL  C05
end;



procedure R_TANH; assembler;
asm
  FIMUL   C2
  FLDL2E
  FMUL
  FLD     ST(0)
  FRNDINT
  FSUB    ST(1), ST
  FXCH    ST(1)
  F2XM1
  FLD1
  FADD
  FSCALE
  FSTP    ST(1)

  FLD     ST(0)
  FLD1
  FSUB
  FLD1
  FADD    ST,ST(2)
  FDIV
  FSTP    ST(1)
end;



procedure R_COTANH; assembler;
asm
  FIMUL   C2
  FLDL2E
  FMUL
  FLD     ST(0)
  FRNDINT
  FSUB    ST(1), ST
  FXCH    ST(1)
  F2XM1
  FLD1
  FADD
  FSCALE
  FSTP   ST(1)

  FLD     ST(0)
  FLD1
  FSUB
  FLD1
  FADD    ST,ST(2)
  FDIVR
  FSTP    ST(1)
end;



procedure R_ARCSINH; assembler;
asm
  FLD   ST
  FMUL  ST,ST
  FLD1
  FADD
  FSQRT
  FXCH
  FADD
  FLDLN2
  FXCH  ST(1)
  FYL2X
end;


procedure R_ARCCOSH; assembler;
asm
  FLD   ST
  FMUL  ST,ST
  FLD1
  FSUB
  FSQRT
  FXCH
  FADD
  FLDLN2
  FXCH  ST(1)
  FYL2X
end;



procedure R_ARCTANH; assembler;
asm     //ln((1+S)/(1-S))*0.5
  FLD  ST
  FLD1
  FADD
  FXCH
  FLD1
  FSUBR
  FDIV
  FLDLN2
  FXCH  ST(1)
  FYL2X
  FMUL  C05
end;




procedure R_ARCCOTANH; assembler;
asm     //ln((1+S)/(S-1))*0.5
  FLD  ST
  FLD1
  FADD
  FXCH
  FLD1
  FSUB
  FDIV
  FLDLN2
  FXCH  ST(1)
  FYL2X
  FMUL  C05
end;





procedure R_IPWR;assembler;
asm
        //PUSH     ECX
        //PUSH     EDX

        FLD1
        FXCH


        mov     ecx, eax
        cdq
        xor     eax, edx
        sub     eax, edx
        jnz     @@2
        fstp    ST(0)
        jmp     @@3
   @@1: fmul    ST, ST
   @@2: shr     eax,1
        jnc     @@1
        fmul    ST(1),ST
        jnz     @@1
        fstp    st
        cmp     ecx, 0
        jge     @@3
        fdivr   c1
        {fld1
        fdivrp}
        //возникает странна€ ошибка: результат "прыгает", например: sin((3*x+4)^(2*i-1)) [x=2,i=5]
        //дл€ этого добавл€ютс€ wait
   @@3:
         //POP     EDX
         //POP     ECX
        {wait
        wait
        wait
        wait
        wait}
end;



procedure R_IPWR_Correct;assembler;
asm
        //PUSH     EDX
        //PUSH     ECX
        FLD1
        FXCH


        mov     ecx, eax
        cdq
        xor     eax, edx
        sub     eax, edx
        jnz     @@2
        fstp    ST(0)
        jmp     @@3
   @@1: fmul    ST, ST
   @@2: shr     eax,1
        jnc     @@1
        fmul    ST(1),ST
        jnz     @@1
        fstp    st
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp
        //возникает странна€ ошибка: результат "прыгает", например: sin((3*x+4)^(2*i-1)) [x=2,i=5]
        //дл€ этого добавл€ютс€ wait
   @@3:
        //POP     EDX
        //POP     ECX

        wait
        wait
        wait
        wait
        wait
end;




procedure R_IPWRSGN; assembler;
asm
{    and  eax,$80000001
    jns  @1
    dec  eax
    or   eax,-$02
    inc  eax
@1: test eax,eax
    fld1
    jz  @2
    fchs
@2:}
       fld1
       and  eax,1
       jz   @end
       fchs 
@end:
end;


//используетс€ только в Lib (flGetAddress)
procedure R_FACT; assembler;
//N -> EAX
asm
 push  ecx
 mov   ecx, dword ptr [Factorial]
 lea   ecx, [ecx+eax*8]
 lea   eax, [ecx+eax*2]
 fld   tbyte ptr [eax]
 pop   ecx
end;

end.
