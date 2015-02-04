unit TestG8;

                    (*программа, тестирующая Foreval.dll*)

{$DEFINE STRING}

interface

uses
  Windows,  SysUtils, Classes,  Dialogs, Math, Forms, Controls, StdCtrls,
  Foreval,     //при непосредственном подключении (без .dll) убрать Foreval добавить Lib !!!
  //Lib,
  ExtCtrls, ComCtrls ;

const E_CPId2: extended = 1.57079632679489662;{_Pi/2;}

const D_CPId2: double = 1.57079632679489662;{_Pi/2;}


type
TFloatType = double;
type
PExtended = ^Extended;
type
TIntegType = Integer;
type
TAddress = Cardinal;
type
PInteger = ^Integer;
type
PDouble = ^Double;
type
PSingle = ^Single;
type
TArrayS = array of String;


const _PI: extended = 3.141592653589793238462643;
const c2: single = 2;
const c05: single = 0.5;
const c1: single = 1;
const c025: single = 0.25;
const c3: single = 3;
const c4: single = 4;
const c6: single = 6;
const cs2: single = -2;

type
TCAttrib = record
           Adr:   Cardinal;
           RType: Cardinal;
           Shift: Cardinal;
          end;
type
TArrayPkg = array of TCAttrib;

type

  TForm1 = class(TForm)

   Button1: TButton;
    LFR: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    EF: TEdit;
    Label5: TLabel;
    IPF: TLabel;
    LCSD: TLabel;
    LDLSD: TLabel;
    LDLNM: TLabel;
    LXBSD: TLabel;
    LXBNX: TLabel;
    CTF: TLabel;
    LCT: TLabel;
    LP: TLabel;
    LCT1: TLabel;
    CB_OM: TCheckBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    CB_St: TCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    DinamicLoad: TRadioGroup;
    RBDL_Auto: TRadioButton;
    RBDL_Enable: TRadioButton;
    RBDL_Disable: TRadioButton;
    XchBranch: TGroupBox;
    RBXB_Auto: TRadioButton;
    RBXB_Enable: TRadioButton;
    RBXB_Disable: TRadioButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CB_CalcConst: TCheckBox;
    UDSD: TUpDown;
    UDRL: TUpDown;
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox3: TGroupBox;
    RB_PR_SNG: TRadioButton;
    RB_PR_DBL: TRadioButton;
    RB_PR_EXT: TRadioButton;
    GroupBox4: TGroupBox;
    RB_VR_SNG: TRadioButton;
    RB_VR_DBL: TRadioButton;
    RB_VR_EXT: TRadioButton;
    CB_Global: TCheckBox;
    LRF: TLabel;
    Label13: TLabel;
    LCC: TLabel;
    Label15: TLabel;
    LMRL: TLabel;
    Label12: TLabel;
    Label4: TLabel;
    STL: TLabel;
    ENC: TEdit;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    EX: TEdit;
    EY: TEdit;
    ET: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    EN: TEdit;
    EI: TEdit;
    EK: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    GroupBox5: TGroupBox;
    RB_SD: TRadioButton;
    RB_SE: TRadioButton;
    CB_Trig: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CB_StClick(Sender: TObject);
    procedure CB_TreeClick(Sender: TObject);
    procedure RBXB_AutoClick(Sender: TObject);
    procedure RBXB_EnableClick(Sender: TObject);
    procedure RBXB_DisableClick(Sender: TObject);
    procedure RBDL_AutoClick(Sender: TObject);
    procedure RBDL_EnableClick(Sender: TObject);
    procedure RBDL_DisableClick(Sender: TObject);
    procedure CB_CalcConstClick(Sender: TObject);
    procedure UDRLClick(Sender: TObject; Button: TUDBtnType);
    procedure UDSDClick(Sender: TObject; Button: TUDBtnType);
    //procedure RB_ST_DBLClick(Sender: TObject);
    //procedure RB_ST_EXTClick(Sender: TObject);
    procedure RB_PR_SNGClick(Sender: TObject);
    procedure RB_PR_DBLClick(Sender: TObject);
    procedure RB_PR_EXTClick(Sender: TObject);
    procedure RB_VR_SNGClick(Sender: TObject);
    procedure RB_VR_DBLClick(Sender: TObject);
    procedure RB_VR_EXTClick(Sender: TObject);
    procedure CB_GlobalClick(Sender: TObject);
    procedure EXChange(Sender: TObject);
    procedure EYChange(Sender: TObject);
    procedure ETChange(Sender: TObject);
    procedure ENChange(Sender: TObject);
    procedure EIChange(Sender: TObject);
    procedure EKChange(Sender: TObject);
    procedure RB_SDClick(Sender: TObject);
    procedure RB_SEClick(Sender: TObject);
    procedure CB_TrigClick(Sender: TObject);

   


  private



  protected



  public
   X,Y,Z,T,U,V,S,P,Q,R,W: Double;
   X1,Y1,Z1,T1,U1,V1,S1,P1,Q1,R1,W1: Extended;
   X0,Y0,Z0,T0,U0,V0,S0,P0,Q0,R0,W0: Single;
   i,j,k,l,m,n: Integer;
   a,b,c,d,e,f,g,h: Double;



   //function _FA3(x1,x2,x3: extended): TFloatType;

  published




  end;


{function K1(I: Integer): Double;
function F1(X: Double): Double; }

{function FA3: TFloatType;
function FA4: TFloatType;
function FR3: TFloatType;}
//function Func5(x1,x2,x3,x4,x5: TFloatType):TFloatType; register;

var
  ak,bk: array[1..7] of TFloatType;
  C_2dqrPi: extended;


  Form1: TForm1;
  //Foreval: TForevalH;
  XX: TFloatType;  //test
  //MEM1: TAddress;
  xs: single;








  function F1P(x: double): double; pascal;
  function F2P(x1,x2: double): double; pascal;
 

  function F1MP(adr: Cardinal): double; pascal;
  function F2MP(adr: Cardinal): double; pascal;
  function F3MP(adr: Cardinal): double; pascal;

  procedure F1MA(adr: Cardinal); pascal;
  procedure F2MA(adr: Cardinal); pascal;
  procedure F3MA(adr: Cardinal); pascal;









implementation
var
F_Error: Boolean;
MEM: Cardinal;
c05dln2,c1dln2,c05dln10,c1dln10: extended;
{$R *.DFM}



procedure FException; stdcall;
var
S,S1: String;
ECode: Cardinal;
PC: PChar;
begin
flGetErrorCode(ECode);
case ECode of
 fl_ZERO_DIVIDE:                  S:='DIVIDE ON ZERO';
 fl_INVALID_OPERATION:            S:='INVALID OPERATION';
 fl_OVERFLOW:                     S:='OVERFLOW';
 fl_UNDERFLOW:                    S:='UNDERFLOW';
 fl_INT_OVERFLOW:                 S:='INTEGER OVERFLOW';
 fl_ACCESS_VIOLATION:             S:='ACCESS VIOLATION';
 fl_OUT_OF_MEMORY:                S:='OUT OF MEMORY';
 fl_STACK_OVERFLOW:               S:='STACK OVERFLOW';
 fl_UNKNOWN_SYMBOL:               S:='UNKNOWN SYMBOL';
 fl_MISSING_LEFT_BRACKET:         S:='MISSING "(" BRACKET';
 fl_MISSING_RIGHT_BRACKET:        S:='MISSING ")" BRACKET';
 fl_WRONG_NUMBER_ARGUMENTS:       S:='INCOINCIDENCE NUMBER OF ARGUMENTS';
 fl_MISSING_OPERATION:            S:='MISSING OPERATION';
 fl_MISSING_EXPRESSION:           S:='MISSING EXPRESSION';
 fl_UNKNOWN_FUNCTION:             S:='UNKNOWN FUNCTION';
 fl_ERROR_AT_ADDITION_FUNCTION:   S:='ERROR AT ADDITION FUNCTION';
 fl_NONEXISTENT_FUNCTION:         S:='NONEXISTENT FUNCTION';
end;

  {$IFDEF STRING} flGetErrorString(S1);  {$ELSE} flGetErrorString(PC);   {$ENDIF}
  MessageBeep(MB_ICONHAND);
  {$IFDEF STRING} MessageDlg(S+#13#10+'"'+S1+'"',mtError,[mbOk],0); {$ELSE}  MessageDlg(S+#13#10+'"'+String(PC)+'"',mtError,[mbOk],0); {$ENDIF}


  Abort;

  if ECode <> 0 then F_Error:=True;
end;


function _FloatToStr(Value: Extended): string;
var
  Buffer: array[0..63] of Char;
begin
  SetString(Result, Buffer, FloatToText(Buffer, Value, fvExtended,
    ffGeneral, 20, 0));
end;

procedure InitFuncStruct(var Func: TAddFuncStruct);
begin
   Func.addr:=0;
   Func.Arg:=0;
   Func.CallType:=0;
   Func.ArgType:=0;
   Func.ArgTypeList:=0;
   Func.ClearStack:=fl_DISABLE;
   Func.Arrow:=fl_RIGHT;
   Func.DeepFPU:=fl_UNKNOWN;
   Func.Set_ID:=fl_DISABLE;
   Func.Id_Func:=0;
   Func.SaveReg:=0;
   Func.CodeInline:=0;
   Func.SizeCode:=0;
end;



procedure SIGN; assembler;
asm
     push    ax
     ftst
     fstp  st(0)
     fstsw   ax
     sahf
     jnz     @@nz
     fldz
     jmp     @@end
 @@nz:
     fld1
     jnb      @@end
     fchs
 @@end:
     pop     ax
end;


function  Avr: double;
var
 i: Integer;
 S: double;
 Adr,Len: Cardinal;
begin
 asm
  mov Adr,EAX
  mov Len,EBX
 end;

S:=0;
for i:=1 to Len do
begin
 S:=S+PDouble(Adr+10*(i-1))^; //10->8 в режиме fl_CLOSE_ARG
end;

Avr:=S/Len;
end;


procedure MAX; assembler;
//EBX <- Adr
//ECX <- Len
asm
     fld   qword ptr [ebx]
     sub   ecx,1
     jle   @@end
     add   ebx,10                 //10->8 в режиме fl_CLOSE_ARG
 @@cycl:
     fld   qword ptr [ebx]
     fcomp
     fstsw ax
     sahf
     jb    @@next                //jl   @@next: (MAX -> MIN)
     fstp  st(0)
     fld   qword ptr [ebx]
 @@next:
     add   ebx,10                //10->8 в режиме fl_CLOSE_ARG
     loop  @@cycl
 @@end:
end;



function FST(Adr,Len,Id: Cardinal):TFloatType;cdecl;
var
i: Integer;
S: TFloatType;
begin
{asm
 mov EAX, Adr
 mov EBX, Len
end;}

S:=0;
for i:=1 to Len do
begin
 //S:=S+PExtended(Adr+10*(i-1))^;
 //S:=S+PDouble(Adr+10*(i-1))^;
 S:=S+PInteger(Adr+10*(i-1))^;
end;
FST:=S+Id;
end;


function  INFA: double;
var
 i,Id: Integer;
 S: double;
 Adr,Len: Cardinal;
begin
 asm
  mov Adr,EAX
  mov Len,EBX

  push  dword ptr [ebp+8]
  pop   Id
 end;

S:=0;
for i:=1 to Len do
begin
 S:=S+PExtended(Adr+{10}8*(i-1))^;
end;

INFA:=S;
end;



function STID:TFloatType;
var
id: Integer;
S,x1,x2,x3: double;
begin
asm
    push   eax                      //чтобы не испортить EAX
    mov    eax,[ebp+8]
    mov    id,eax
    mov    eax,[ebp+12]          //+12(вместо 8) т.к. в вершине стека -ID
    fld    qword ptr [EAX]
    fstp   x1
    fld    qword ptr [EAX+10]
    fstp   x2
    fld    qword ptr [EAX+20]
    fstp   x3
    pop    eax
    {push   eax
    mov    eax,[ebp+8]
    mov    id,eax
    pop    eax}
    //без ID:
    {push   eax
    mov    eax,[ebp+8]
    fld    qword ptr [EAX]
    fstp   x1
    fld    qword ptr [EAX+10]
    fstp   x2
    fld    qword ptr [EAX+20]
    fstp   x3
    pop    eax}
end;

STID:=Id+x1+x2+x3;
end;


function FST1:TFloatType;
var
i: Integer;
S: TFloatType;
Adr,Len: Cardinal;
begin
asm
 mov Adr,EAX
 mov Len,EBX
end;

S:=0;
for i:=1 to Len do
begin
 S:=S+PExtended(Adr+10*(i-1))^;
end;
FST1:=S;
end;




function Func5(x1,x2,x3,x4,x5: TFloatType; Id: Cardinal):TFloatType; pascal;
begin
Func5:=Id;//x1-x2-x3+x4-x5;
end;



function Func2(x1,x2: double): extended; cdecl;
begin
 Func2:=x1+x2;
end;


function Func1(x: double): extended; register;
begin
 Func1:=x;
end;


function Func3(x1: integer; x2: double; x3: extended; Id: Integer): extended; cdecl;
begin
 Func3:=x1+x2+x3+Id;
end;



function F1P(x: Double): double; pascal;
begin
 F1P:=x*x;
end;


function F2P(x1,x2: Double): double; pascal;
begin
 F2P:=x1*x2*(x1+x2);
end;

function F2E(x1,x2: Extended): double; pascal;
begin
 F2E:=x1*x2*(x1+x2);
end;

function F2I(x1,x2: Integer): double; pascal;
begin
 F2I:=x1*x2*(x1+x2);
end;

function F5P(x1,x2,x3,x4,x5: double): double; pascal;
begin
 F5P:=1;
end;

function F3P(x1,x2,x3: double): double; pascal;
begin
 F3P:=x1+x2+x3;
end;


function F1MP(adr: Cardinal): double; pascal;
begin
 F1MP:=PDouble(adr)^*PDouble(adr)^;
end;



function F2MP(adr: Cardinal): double; pascal;
begin
 F2MP:=PDouble(adr)^*PDouble(adr+10)^*(PDouble(adr)^+PDouble(adr+10)^);
end;



function F3MP(adr: Cardinal): double; pascal;
begin
 F3MP:=PDouble(adr)^*PDouble(adr+10)^+PDouble(adr)^*PDouble(adr+20)^+PDouble(adr+10)^*PDouble(adr+20)^;
end;


procedure F1MA(adr: Cardinal); pascal;
asm
 fld  qword ptr [adr]
 fmul st,st
end;



procedure F2MA(adr: Cardinal); pascal;
asm
 fld  qword ptr [adr]
 fmul qword ptr [adr+10]
 fld qword ptr [adr]
 fadd qword ptr [adr]
 fmulp
end;



procedure F3MA(adr: Cardinal); pascal;
asm
 fld  qword ptr [adr]
 fmul qword ptr [adr+10]
 fld  qword ptr [adr]
 fmul qword ptr [adr+20]
 faddp
 fld  qword ptr [adr+10]
 fmul qword ptr [adr+20]
 faddp
end;


function FuncId(Id: Integer): extended; pascal;
begin
 FuncId:=Id;
end;

(*
function Func3:TFloatType;
var
R: TFloatType;
begin
//DOUBLE:
{ asm
  push  eax
  mov   eax, [ebp+8]
  fld   qword ptr [eax]
  fadd  qword ptr [eax+8]
  fadd  qword ptr [eax+16]
  pop   eax
  fstp  R
 end;
}
//EXTENDED:
asm
  push  eax
  mov   eax, [ebp+8]
  fld   tbyte ptr [eax]
  fld   tbyte ptr [eax+10]
  fld   tbyte ptr [eax+20]
  fadd
  fadd
  pop   eax
  fstp  R
 end;

Func3:=R;
end;
*)


function FA0: TFloatType;
var
x1,x2,x3,x4: TFloatType;
N: Integer;
begin
FA0:=1.5;
end;


function FS0: TFloatType;
var
x1,x2,x3,x4: TFloatType;
N: Integer;
begin
FS0:=1.5;
end;




function FA3ID: TFloatType;
var
x1,x2,x3,x4: TFloatType;
N,ID: Integer;
begin
//вызов через EAX
asm
 {push  ebx
 mov   ebx,[ebp+8]
 mov   ID,ebx
 pop   ebx }
 push  dword ptr [ebp+8]
 pop   Id
 FLD   qword ptr [EAX]
 FSTP  X1
 FLD   qword ptr [EAX+10]
 FSTP  X2
 FLD   qword ptr [EAX+20]
 FSTP  X3
end;

FA3ID:=ID+x1+x2+x3;

end;



function FA3: TFloatType;
var
x1,x2,x3: Double;
begin
asm
 FLD   qword ptr [EAX]
 FSTP  X1
 FLD   qword ptr [EAX+8]
 FSTP  X2
 FLD   qword ptr [EAX+16]
 FSTP  X3
end;

FA3:=x1+x2+x3;
end;


function MC4D: double;
var
x1: single;
x2: Extended;
x3: double;
x4: integer;
begin
asm
 FLD   dword ptr [ECX]
 FSTP  X1
 FLD   tbyte ptr [ECX+4]
 FSTP  X2
 FLD   qword ptr [ECX+14]
 FSTP  X3
 PUSH  EAX
 MOV   EAX,[ECX+22]
 MOV   X4,EAX
 POP   EAX
end;

MC4D:=x1+x2+x3+x4;
end;



function E3ID:TFloatType;
var
id: Integer;
x1,x2,x3: double;
begin
asm
    push   eax
    mov    eax,[ebp+8]
    mov    id,eax
    mov    eax,[ebp+12]          //+12(вместо 8) т.к. в вершине стека -ID
    fld    qword ptr [EAX]
    fstp   x1
    fld    qword ptr [EAX+10]
    fstp   x2
    fld    qword ptr [EAX+20]
    fstp   x3
    pop    eax
end;

E3ID:=x1+x2+x3+id;
end;





function FA5: extended;
var
x1,x2,x3,x4,x5: double;
N1,N2: Integer;
begin

//вызов через EAX
asm
 FLD   qword ptr [EAX]
 FSTP  X1
 FLD   qword ptr [EAX+10]
 FSTP  X2
 FLD   qword ptr [EAX+20]
 FSTP  X3
 FLD   qword ptr [EAX+30]
 FSTP  X4
 FLD   qword ptr [EAX+40]
 FSTP  X5
end;

FA5:=x1+x2+x3+x4+x5;
end;



function MA4: double;
var
x1,x2,x3,x4: integer;
N1,N2: Integer;
begin

//вызов через EAX
asm
 FILD  dword ptr [EAX]
 FISTP  X1
 FILD   dword ptr [EAX+4]
 FISTP  X2
 FILD   dword ptr [EAX+8]
 FISTP  X3
 FILD   dword ptr [EAX+12]
 FISTP  X4
end;
{asm
 FILD  dword ptr [EAX]
 FISTP  X1
 FILD   dword ptr [EAX+10]
 FISTP  X2
 FILD   dword ptr [EAX+20]
 FISTP  X3
 FILD   dword ptr [EAX+30]
 FISTP  X4
end;}

MA4:=x1+x2+x3+x4;
end;






function MS3: double;
var
x1,x2,x3: single;
N1,N2: Integer;
begin

//вызов через ESP
asm
 PUSH   EAX                      //чтобы не испортить EAX
 MOV    EAX,[EBP+8]
 FLD   dword ptr [EAX]
 FSTP  X1
 FLD   dword ptr [EAX+4]
 FSTP  X2
 FLD   dword ptr [EAX+8]
 FSTP  X3
 POP   EAX
end;

MS3:=x1+x2+x3;
end;


function MS4P(Adr: Cardinal): double; pascal;
begin
MS4P:=PSingle(Adr)^+PExtended(Adr+4)^+PDouble(Adr+14)^+PInteger(Adr+22)^;
end;



function FR3: double;
var
x1,x2,x3: Double;
begin

asm
 FSTP  X3
 FSTP  X2
 FSTP  X1
end;

FR3:=x1+x2+x3;
end;


function S4P(x1: Integer;x2: extended;x3: double; x4: single): double; pascal;
begin
 S4P:=x1+x2+x3+x4;
end;


function S4C(x1: Integer;x2: extended;x3: double; x4: single): double; cdecl;
begin
 S4C:=x1+x2+x3+x4;
end;

function S4S(x1: Integer;x2: extended;x3: double; x4: single): double; stdcall;
begin
 S4S:=x1+x2+x3+x4;
end;


function S3S(x1,x2,x3: double): double; stdcall;
begin
 S3S:=x1+x2+x3;
end;



function IAB:TFloatType;
var
i: Integer;
S: TFloatType;
Adr,Len: Cardinal;
begin
asm
 mov Adr,EAX
 mov Len,EBX
end;

S:=0;
for i:=1 to Len do
begin
 S:=S+PDouble(Adr+{10}8*(i-1))^;
end;
IAB:=S;
end;



function ISC(Adr,Len: Cardinal): double; cdecl;
var
i: Integer;
S: TFloatType;
begin
S:=0;
for i:=1 to Len do
begin
 S:=S+PDouble(Adr+10*(i-1))^;
end;
ISC:=S;
end;



function MA4ID: double;
var
x1,x2,x3,x4: double;
ID: Cardinal;
begin

//вызов через EAX
asm
 push  ebp
 push  dword ptr [ebp+8]
 pop   Id
 pop   ebp
 FLD   qword ptr [EAX]
 FSTP  X1
 FLD   qword ptr [EAX+8]
 FSTP  X2
 FLD   qword ptr [EAX+16]
 FSTP  X3
 FLD   qword ptr [EAX+24]
 FSTP  X4
end;

MA4ID:=x1+x2+x3+x4+ID;
end;




function MC3ID(ID: Cardinal): double; pascal;
var
x1,x2,x3: double;
begin

//вызов через ECX
asm
 FLD   qword ptr [ECX]
 FSTP  X1
 FLD   qword ptr [ECX+8]
 FSTP  X2
 FLD   qword ptr [ECX+16]
 FSTP  X3
end;

MC3ID:=x1+x2+x3+ID;
end;


function MS3ID:double;
var
id: Cardinal;
x1: extended;
x2: integer;
x3: double;
begin
asm
    push   eax
    mov    eax,[ebp+12]
    mov    id,eax
    mov    eax,[ebp+8]
    fld    tbyte ptr [EAX]
    fstp   x1
    fild   dword ptr [EAX+10]
    fistp  x2
    fld    qword ptr [EAX+14]
    fstp   x3
    pop    eax
end;

MS3ID:=Id+x1+x2+x3;
end;


function MS3CID(Adr,Id: Cardinal): Double;  cdecl;
var
x1,x2,x3: double;
begin
 x1:=PDouble(Adr)^;
 x2:=PDouble(Adr+8)^;
 x3:=PDouble(Adr+16)^;
 MS3CID:=x1+x2+x3+Id;
end;


function FR3ID: double;
var
x1,x2,x3: Double;
ID: Cardinal;
begin

asm
 push  dword ptr [ebp+8]
 pop   Id
 FSTP  X3
 FSTP  X2
 FSTP  X1
end;

FR3ID:=x1+x2+x3+ID;
end;

function S3PID(x1,x2,x3:double; ID: Cardinal): double; pascal;
begin
 S3PID:=x1+x2+x3+ID;
end;


function S3CID(x1,x2,x3:double; ID: Cardinal): double; cdecl;
begin
 S3CID:=x1+x2+x3+ID;
end;


function IABID:TFloatType;
var
i,ID: Integer;
S: TFloatType;
Adr,Len: Cardinal;
begin
asm
 push  dword ptr [ebp+8]
 pop   Id
 mov Adr,EAX
 mov Len,EBX
end;

S:=0;
for i:=1 to Len do
begin
 S:=S+PDouble(Adr+{10}8*(i-1))^;
end;
IABID:=S+ID;
end;



function ISCID(Adr,Len,ID: Cardinal): double; cdecl;
var
i: Integer;
S: TFloatType;
begin
S:=0;
for i:=1 to Len do
begin
 S:=S+PDouble(Adr+{10}8*(i-1))^;
end;
ISCID:=S+ID;
end;


function ISPID(Adr,Len,ID: Cardinal): double; pascal;
var
i: Integer;
S: TFloatType;
begin
S:=0;
for i:=1 to Len do
begin
 S:=S+PDouble(Adr+10*(i-1))^;
end;
ISPID:=S+ID;
end;




procedure KA; assembler;
asm
 fsubrp
end;

procedure FP; assembler;
asm
 fsubp
end;

procedure MA;
asm
 FLD     qword ptr [EAX]
 FSUB    qword ptr [EAX+8]
end;

function SP(x1,x2: double): double;  pascal;
begin
 SP:=x1-x2;
end;


function SC(x1,x2: double): double;  cdecl;
begin
 SC:=x1-x2;
end;

procedure FP3; assembler;
asm
 fsubp
 faddp
end;

procedure MA3;
asm
 FLD    qword ptr [EAX]
 FADD   qword ptr [EAX+8]
 FSUB   qword ptr [EAX+16]
end;

function SP3(x1,x2,x3: double): double;  pascal;
begin
 SP3:=x1+x2-x3;
end;


function SC3(x1,x2,x3: double): double;  cdecl;
begin
 SC3:=x1+x2-x3;
end;


function SS3(x1,x2,x3: double): double;  stdcall;
begin
 SS3:=x1+x2-x3;
end;


function SP2(x1,x2: double): double;  pascal;
begin
 SP2:=x1+x2;
end;



{function TForm1._FA3(x1,x2,x3: extended): TFloatType;
begin
_FA3:=sin(x1)*cos(x2)/(sin(x3)+cos(x3));
end;
}


function FAB: TFloatType;
var
x1,x2,x3,x4: TFloatType;
N: Integer;
begin

FAB:=1;
end;


function CalcFunc(Code: Cardinal): double;
asm
 call Code
 fstp @Result
end;







function M_EAX1: double;
var
x1,x2,x3,x4,x5: double;
begin

//вызов через EAX
asm
 FLD   qword ptr [EAX]
 FSTP  X1
 {FLD   qword ptr [EAX+10]
 FSTP  X2
 FLD   qword ptr [EAX+20]
 FSTP  X3
 FLD   qword ptr [EAX+30]
 FSTP  X4
 FLD   qword ptr [EAX+40]
 FSTP  X5}
end;

M_EAX1:=x1{+x2+x3+x4+x5};
end;


function M_EBX2ID: double;
var
x1,x2,x3,x4,x5: double;
ID: Integer;
begin

//вызов через EBX
asm
 push  dword ptr [ebp+8]
 pop   Id
 FLD   qword ptr [EBX]
 FSTP  X1
 FLD   qword ptr [EBX+10]
 FSTP  qword ptr X2
 {FLD   qword ptr [EAX+10]
 FSTP  X2
 FLD   qword ptr [EAX+20]
 FSTP  X3
 FLD   qword ptr [EAX+30]
 FSTP  X4
 FLD   qword ptr [EAX+40]
 FSTP  X5}
end;

M_EBX2ID:=x1+x2+ID{+x2+x3+x4+x5};
end;


function M_EAX5: double;
var
x1,x2,x3,x4,x5: double;
begin

//вызов через EAX
asm
 FLD   qword ptr [EAX]
 FSTP  X1
 FLD   qword ptr [EAX+10]
 FSTP  X2
 FLD   qword ptr [EAX+20]
 FSTP  X3
 FLD   qword ptr [EAX+30]
 FSTP  X4
 FLD   qword ptr [EAX+40]
 FSTP  X5
end;

M_EAX5:=x1+x2+x3+x4+x5;
end;



function M_EAX5D: double;
var
x1,x3: double;
x2,x5: integer;
x4: extended;
begin

//вызов через EAX
asm
 FLD   qword ptr [EAX]
 FSTP  X1
 FILD  dword ptr [EAX+10]
 FISTP X2
 FLD   qword ptr [EAX+20]
 FSTP  X3
 FLD   tbyte ptr [EAX+30]
 FSTP  X4
 FILD  dword ptr [EAX+40]
 FISTP X5
end;

M_EAX5D:=x1+x2+x3+x4+x5;
end;


function S3PD({x1,x2,x3: integer}x1: extended; x2: integer; x3: double ;Id: Integer): double; pascal;
begin
 S3PD:=x1+x2+x3+Id;
end;


function FC6({x1,x2,x3,x4,x5,x6: integer}x1: double; x2: extended; x3: integer; x4: double; x5: integer; x6: extended ;Id: Integer): double; cdecl;
begin
 FC6:=x1+x2+x3+x4+x5+x6+Id;
end;

function FP6({x1,x2,x3,x4,x5,x6: integer}x1: integer; x2: extended; x3: integer; x4: double; x5: double; x6: extended ;Id: Integer): double; pascal;
begin
 FP6:=x1+x2+x3+x4+x5+x6+Id;
end;






procedure TForm1.Button1Click(Sender: TObject);
label endp;
const fcw: word = $1f32;
//const fw2: word = $1332;
var
S1,S2: String;
i: TIntegType;
T_1,T_2,SB: TIntegType;
Result: Double;
//FuncTest: TExternalFunc;
x1,x2,x3,x4,x5,x6,x7,x8,x9,y1,y2,r1,r2,r3,r4,t1,z1: Double;
res:  double;
res1: extended;
a1,b1,NC: TIntegType;
//pv1,pv2,pv3: PFloatType;

FS,FS1,FS2,FS3: Pointer;

FuncTest: TAddFuncStruct;
Addr: TAddress;
//Code,Code1: Cardinal;
AE: array of extended;
ex1,ex2,ex3,ex4,ex5,ex6,ex7,ex8: Extended;
Atr: TCAttrib;
IC: array of byte;
Ptr,Pr: Pointer;
sn1: Single;
dn1: Double;
in1: Integer;
xn1: extended;
CError:Cardinal;
CP,Pk: Cardinal;
Code: Array of byte;
Pb: ^byte;
PC: PChar;
PS:PString;
PAS: PAnsiString;
PAC: PAnsiChar;
PWS: PWideString;
PWC: PWideChar;
Ans: AnsiString;
WS: WideString;
P: Pointer;
LV: TArrayS;
Pkg: TArrayPkg;
//FT: TFunction;
begin



LXBSD.Caption:='';
LXBNX.Caption:='';
LDLSD.Caption:='';
LDLNM.Caption:='';
LCSD.Caption:='';
LRF.Caption:='';
LCC.Caption:='';




//x1:=1; x2:=2; x3:=3; x4:=4; x5:=5; x6:=6; x7:=7;  x8:=8; x9:=intpower(2,60);
//ex1:=x1; ex2:=x2; ex3:=x3; ex4:=x4; ex5:=x5; ex6:=x6; ex7:=x7; ex8:=x8;


//x:=2;








//x:=2; y:=5; t:=1.77;
//a:=2;b:=2; c:=3; d:=4; e:=5.77;
//x1:=x; x2:=z; y1:=y; y2:=t;
//x1:=2; y1:=3; x2:=4; y2:=5;
//z1:=z; t1:=t;



//Res:=x*y-x*y*(x*y-x*y*(x*y-(x*y+(x*y-x*(x*y-x*y))*y)*y)*y);





 (*Atr.Adr:=0;
 Atr.RType:=0;
 Atr.Shift:=0;
 SetLength(Pkg,4);
 Pkg[0].Adr:=2;//Cardinal(@r1);
 Pkg[0].RType:=_Double;
 Pkg[0].Shift:=24;
 Pkg[1].Adr:=2;//Cardinal(@r2);
 Pkg[1].RType:=_Double;
 Pkg[1].Shift:=16;
 Pkg[2].Adr:=2;//Cardinal(@r3);
 Pkg[2].RType:=_Double;
 Pkg[2].Shift:=8;
 Pkg[3].Adr:=2;//Cardinal(@r4);
 Pkg[3].RType:=_Double;
 Pkg[3].Shift:=0;
 Foreval.SetPkgData(Pkg);
 Foreval.PackageCompile:=True;
 S1:='x^i&sin(x)&cos(x)&sin(x)*cos(x)';
 Foreval.SetExtExpression(S1,TAttrib(Atr),FT);
 P:=@r4;
 asm
  push ebx
  mov ebx,P
  call FT.ICode
  pop  ebx
 end;

 S1:=FloatToStr(r1)+' , '+FloatToStr(r2)+' , '+FloatToStr(r3)+' , '+FloatToStr(r4);
 EF.Text:=S1;
 *)

 F_Error:=False;
 S1:=EF.Text;


(* flSet(fl_ENABLE,fl_PACKAGE_COMPILE,0);
  Atr.Adr:=2;{Cardinal(@r1);} Atr.RType:=fl_Double; Atr.Shift:=24;
  flCompile('x^i',@Atr,P);
  Atr.Adr:=2;{Cardinal(@r2);} Atr.RType:=fl_Double; Atr.Shift:=16;
  flCompile('sin(x)',@Atr,P);
  Atr.Adr:=2;{Cardinal(@r3);} Atr.RType:=fl_Double; Atr.Shift:=8;
  flCompile('cos(x)',@Atr,P);
  Atr.Adr:=2;{Cardinal(@r4);} Atr.RType:=fl_Double; Atr.Shift:=0;
  flCompile('sin(x)*cos(x)',@Atr,P);
 flSet(fl_DISABLE,fl_PACKAGE_COMPILE,0);
 flGet(fl_PACKAGE_COMPILE_LAST_ADDR,0,CP);
 P:=@r4;
 asm
  push ebx
  mov ebx,P
  call CP
  pop  ebx
 end;
 S1:=FloatToStr(r1)+' , '+FloatToStr(r2)+' , '+FloatToStr(r3)+' , '+FloatToStr(r4);
 EF.Text:=S1;
 *)

  {Atr.RType:=fl_Double; Atr.Shift:=0;
  flSet(fl_ENABLE,fl_PACKAGE_COMPILE,0);
   Atr.Adr:=Cardinal(@r1); flCompile('t*sin(x)*cos(y)',@Atr,P);
   Atr.Adr:=Cardinal(@r2); flCompile('t*sin(x)*sin(y)',@Atr,P);
   Atr.Adr:=Cardinal(@r3); flCompile('t*cos(x)',@Atr,P);
 flSet(fl_DISABLE,fl_PACKAGE_COMPILE,0);
 flGet(fl_PACKAGE_COMPILE_LAST_ADDR,0,Pk);


 flCompile('t*sin(x)*cos(y)',0,FS1);
 flCompile('t*sin(x)*sin(y)',0,FS2);
 flCompile('t*cos(x)',0,FS3);
 }


  //Atr.Adr:=cardinal(@ex1); Atr.RType:=fl_EXTENDED;

 T_1:=GetTickCount;
  {$IFDEF STRING} flCompile(S1,@Atr,FS1);{$ELSE} flCompile(PChar(S1),@Atr,FS1); {$ENDIF}
 T_2:=GetTickCount;



 CTF.Caption:=IntToStr(T_2-T_1);
 if CB_OM.Checked then NC:=1 else NC:=StrToInt(ENC.Text);
 r:=1; //Pr:=@Res;

 flGetErrorCode(CError);
 if CError <> 0 then F_Error:=True;

 if  not F_Error then
 begin
 T_1:=GetTickCount;
 for i:=1 to NC do
 begin
 //Res:=CalcFunction(FS1);
 asm
  {call FS1
  fstp r1
  call FS2
  fstp r2
  call FS3
  fstp r3}
  //call Pk

   call FS1
   fstp Res
 end;


 //sin(cos(x))*cos(cos(x))
 //res:=(cos(1*sin(2*x+3*y+4)+5)+sin(2*x+3*y+4))*cos(1*sin(2*x+3*y+4)+5)*cos(2*x+3*y+4)+cos(1*sin(2*x+3*y+4)+5);
 //res:=sin(x)*cos(x)/(sin(x)+cos(x));
 //sin(x)^(-1)/cos(x)^(-2)/sin(x)^(-3)/sin(x)^(-1)/cos(x)/sin(x)/cos(x)^(-2)/sin(x)^(-3)
 //(-sin(x)^(-1))-cos(x)^(-2)/sin(x)^(-3)+sin(x)^(-1)-cos(x)-(-sin(x)-cos(x)^(-2))/sin(x)^(-3)
 //(-arcctg(x)^(-1))-arctg(x)^(-2)/arcctg(x)^(-3)+arcctg(x)^(-1)-arctg(x)-(-arcctg(x)-arctg(x)^(-2))/arcctg(x)^(-3)
 //(-arctg(x)^(-1))-arcctg(x)^(-2)/arctg(x)^(-3)+arctg(x)^(-1)-arcctg(x)-(-arctg(x)-arcctg(x)^(-2))/arctg(x)^(-3)
 //arctg(x)^(-1)/(-arcctg(x)^(-2))+arctg(x)^(-2)/arctg(x)^(-1)
  //res:=power(sin(x),(-1))/power(cos(x),(-2))/power(sin(x),(-3))/power(sin(x),(-1))/cos(x)/sin(x)/power(cos(x),(-2))/power(sin(x),(-3));
 //sin(x)^(-1)/cos(x)^(-2)/sin(x)^(-3)/sin(x)^(-1)/cos(x)/sin(x)/cos(x)^(-2)/sin(x)^(-3)
 //sh(x)^(-1)/(-exp(x)^(-2))+ch(x)^(-2)/(sh(x)^(-1))-exp(x)^(-1)/ch(x)^(-2)-sh(x)*ch(x)/exp(x)
 //sh(x)/(-exp(x))+ch(x)/(-sh(x))   !!!
 //sh(x)^(-1)/(-exp(x)^(-2))+ch(x)^(-2)/(-sh(x)^(-1))
 //sh(x)^(-1)/(-exp(x)^(-2))+ch(x)^(-2)/(sh(x)^(-1))-exp(x)^(-1)/ch(x)^(-2)
 //(cos(x)^(-1)+sin(x)^(-1))/(sin(x)^(-1)-cos(x)^(-1))
 //(cos(x)^(-2)+sin(x)^(-2))/(sin(x)^(-2)-cos(x)^(-2))
 //-cos(x)^(-1)-(-cos(x)^(-2))+sin(x)^(-1)*sin(x)^(-2)/(-cos(x)^(-2))*sin(x)^(-1)
   //(sin(x)^(-2)+cos(x)^(-2))/(sin(x)^(-1)+cos(x)^(-1))
   //(1/sin(x)^2+1/cos(x)^2)/(1/sin(x)+1/cos(x))
 //res:=(x*sin(2*t*x-1)-y*cos(2*t*x-1))/(x*sin(2*t*x-1)+y*cos(2*t*x-1));
 //ka(x*y-ka(x/y*2-3,t*x-ka(x,y)*ka(2*x*y*(2*x-3*y-4)+x,y))*x*(x*y-x/ka(x*ka(x*y-1,ka(x*y,x*(x*y+t/(x+1)-t)-x*y+2*t+1)+x*ka(x,y*(x*(x+t*y))))*x,x+1)),y)
 //ki(x*y-ki(x/y*2-3,t*x-ki(x,y)*ki(2*x*y*(2*x-3*y-4)+x,y))*x*(x*y-x/ki(x*ki(x*y-1,ki(x*y,x*(x*y+t/(x+1)-t)-x*y+2*t+1)+x*ki(x,y*(x*(x+t*y))))*x,x+1)),y)
 //fp(x*y-fp(x/y*2-3,t*x-fp(x,y)*fp(2*x*y*(2*x-3*y-4)+x,y))*x*(x*y-x/fp(x*fp(x*y-1,fp(x*y,x*(x*y+t/(x+1)-t)-x*y+2*t+1)+x*fp(x,y*(x*(x+t*y))))*x,x+1)),y)
 //ma(x*y-ma(x/y*2-3,t*x-ma(x,y)*ma(2*x*y*(2*x-3*y-4)+x,y))*x*(x*y-x/ma(x*ma(x*y-1,ma(x*y,x*(x*y+t/(x+1)-t)-x*y+2*t+1)+x*ma(x,y*(x*(x+t*y))))*x,x+1)),y)
 //Res:=sp(x*y-sp(x/y*2-3,t*x-sp(x,y)*sp(2*x*y*(2*x-3*y-4)+x,y))*x*(x*y-x/sp(x*sp(x*y-1,sp(x*y,x*(x*y+t/(x+1)-t)-x*y+2*t+1)+x*sp(x,y*(x*(x+t*y))))*x,x+1)),y)
 //Res:=sc(x*y-sc(x/y*2-3,t*x-sc(x,y)*sc(2*x*y*(2*x-3*y-4)+x,y))*x*(x*y-x/sc(x*sc(x*y-1,sc(x*y,x*(x*y+t/(x+1)-t)-x*y+2*t+1)+x*sc(x,y*(x*(x+t*y))))*x,x+1)),y)
 //Res:=fp3(x-y*fp3(x*y-t,x*fp3(x*y*t+y*2-1,fp3(x-y,x*fp3(2*x,-t,x*y*(x*y*t)*(x+y*t+1)),fp3(x*y*(x-t),x,fp3(x*y*t,-x,x*(x+y*t+t)*t)*fp3(x/fp3(x-y,-t,x),x,y*t*(x+y*t))-fp3(x,x+t,x*y*t+x*y+t*2-x))),x),y)*fp3(-t,y,x*y)*t,x,y)
 //Res:=ma3(x-y*ma3(x*y-t,x*ma3(x*y*t+y*2-1,ma3(x-y,x*ma3(2*x,-t,x*y*(x*y*t)*(x+y*t+1)),ma3(x*y*(x-t),x,ma3(x*y*t,-x,x*(x+y*t+t)*t)*ma3(x/ma3(x-y,-t,x),x,y*t*(x+y*t))-ma3(x,x+t,x*y*t+x*y+t*2-x))),x),y)*ma3(-t,y,x*y)*t,x,y)
 //Res:=sp3(x-y*sp3(x*y-t,x*sp3(x*y*t+y*2-1,sp3(x-y,x*sp3(2*x,-t,x*y*(x*y*t)*(x+y*t+1)),sp3(x*y*(x-t),x,sp3(x*y*t,-x,x*(x+y*t+t)*t)*sp3(x/sp3(x-y,-t,x),x,y*t*(x+y*t))-sp3(x,x+t,x*y*t+x*y+t*2-x))),x),y)*sp3(-t,y,x*y)*t,x,y)
 //Res:=sc3(x-y*sc3(x*y-t,x*sc3(x*y*t+y*2-1,sc3(x-y,x*sc3(2*x,-t,x*y*(x*y*t)*(x+y*t+1)),sc3(x*y*(x-t),x,sc3(x*y*t,-x,x*(x+y*t+t)*t)*sc3(x/sc3(x-y,-t,x),x,y*t*(x+y*t))-sc3(x,x+t,x*y*t+x*y+t*2-x))),x),y)*sc3(-t,y,x*y)*t,x,y)
 //Res:=f2p(x*f2p(-x-(y/f2p(1-x*f2p(x*y+1,y-x)-t,x-(-f2p(x*y,t/x)-t)+x)-y)*x/(2*x+1-(x+y*t)),x)/t,x)-f2p(x,y)/t
 //Res:=sc(x,y,t);
 //K1(2*n+3*k+4*l+5)+K1(2*n+3*k+4*l+5)
 //F1(2*x+3*y+4*t+5)+F1(2*x+3*y+4*t+5)
 //FI1(2*x+3*y+4*t+5,2*n+3*k+4*l+5)+FI1(2*x+3*y+4*t+5,2*n+3*k+4*l+5)
 //FF1(x*y+1,F1(x+2))+FF1(x*y+1,F1(x+2))

 //Res:=(x*(2*x+3)*(4*t+5)*y*t/(7*y+1)+8)*(7*x*y*(2*x+1)*(2*x*y*t-1)/(3*x-4*y+5*t-7)-9)/(4*x*y*(7*x+1)*(9*t+2)*(5*y-9)*(7/(2*x+3)-8/x-9/(2*x*y*t-1)+1))-((2*x+3)/x-t/(4*x+5)-(2*x*y-1)*(3*x-4*y+5*t-7)*x*y/(5*x-7*y+8)-9)*(5*x+1)*(7*y-9)*(7*t-1)/(x/y-t/x+1)
  //Res:= 1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9)
  //Res:=2/(-3*a-b-c/d-(-sin(a/b-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
  //Res:=2/(-a)/(-3*(-a)-b*(-b)/(-(-c))-c/d-(-1/(-sin(a/b-(-c-1)+1)-c)/d)+b*(-(-c)))-(-(-1-c)/d*2+3*a/(-b)/(-(-(-c)-2-d)-b)-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)-sin(-c-(-d-(1-b)-3-(-a*2))/a/(-b/(-a)-d)-1)
  //Res:=-(-x)-(-a/(-x-1-y)-c)*(-(-(-x-1)-b-y-1)/(-b)*c/(-y)-b)*(-(-sin(x)-1-x)-b*x/(-y)/(-b)-(-(1-cos(x)-x)-b)/sin(x)+(-(-a*x-b-y+1)-sin(y)/(-c-(-x)-1)*y)*b+(x-(-sin(x)-1-y)-t/(-c*x/(-b)-1)-1)-x-1)
  //Res:=x*(-(x*y+x))-2/(-3*a-b-c/d-(-sin(a/(-(x*y+x))-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
  //Res:=x*t-cosh(t)*(tanh(x*t-cosh(t)*(tanh(x*t-cosh(t)*(tanh(y*x-power(x,y)))))))
  //Res:=exp(exp(x*y-8)/2-1)/tanh(exp(x*y-8)/2-1)-exp(x*y-8)*tanh(x*y-8)*cosh(x*y-8)/sinh(exp(x*y-8)/2-1)
  //ошибка DELPHI:   !!!
    //Res:=x*y-x*y*(x*y-x*y*(x*y-(x*y+(x*y-x*(x*y-x*y))*y)*y)*y)

    //sin(x+1)^(-1)*(2*x*y*t+2)^(-1)+(2*cos(x+1)+1)^(-1)*(2*x*y*t+2)^(-1)-(2*cos(x+1)+1)^(-1)
    //|y-|x-1|+t-|3-t|-x|-|2*t+1|*|x-t*|y+2|-y|
    //(-1)^(2*k+1)*2^(k+1)*(2*i+1)!*k!/(y^(2*k+1)*i!)
    //
  //Res:=1/sin(x+1)*1/(2*x*y*t+2)+1/(2*cos(x+1)+1)*1/(2*x*y*t+2)-1/(2*cos(x+1)+1)
  //Res:=2/sp2(x-cos(y)*sin(-y*sp2(x*t,cos(y*sp2(2-x/t,t)/x*sp2(2-x,3*sin(x))/(2+x)))),y/sp2(x*cos(y),cos(y)*sp2(cos(y),sin(x))));
  //Res:=x*sp3(x*sp2(x,y),y,-sp2(sin(x),y)/(-x-t*sp3(sin(x),cos(x)*sin(y),t/sin(y)+cos(x))))
  //Res:=s3s(-sc3(x,-s3s(x,-sp2(x,y),-sc3(x,y,t)),-sp2(-x,y))/sp2(x,-y),t,y)*sc3(x,y,t);
  end;


 T_2:=GetTickCount;
 LFR.Caption:=_FloatToStr(Res);
 {S1:=FloatToStr(r1)+' , '+FloatToStr(r2)+' , '+FloatToStr(r3);
 EF.Text:=S1;}


 if not CB_OM.Checked then IPF.Caption:=IntToStr(Trunc(NC/(T_2-T_1)));


 end;
  flGet(fl_EXCHANGE_BRANCH_STACK_DEEP,Cardinal(FS1),CP);
  LXBSD.Caption:=IntToStr(CP);

  flGet(fl_EXCHANGE_BRANCHE_NUM,Cardinal(FS1),CP);
  LXBNX.Caption:=IntToStr(CP);

  flGet(fl_DINAMIC_LOAD_STACK_DEEP,Cardinal(FS1),CP);
  LDLSD.Caption:=IntToStr(CP);

  flGet(fl_DINAMIC_LOAD_OVFL,Cardinal(FS1),CP);
  if CP = fl_YES then  LDLNM.Caption:='OverFloow'
  else
  if CP = fl_NO then
  begin
   flGet(fl_DINAMIC_LOAD_NUM,Cardinal(FS1),CP);
   LDLNM.Caption:=IntToStr(CP);
  end;

  flGet(fl_COMPILE_OVFL,Cardinal(FS1),CP);
  if CP = fl_YES then  LCSD.Caption:='OverFloow'
  else
  if CP = fl_NO  then
  begin
   flGet(fl_COMPILE_STACK_DEEP,Cardinal(FS1),CP);
   LCSD.Caption:=IntToStr(CP);
  end;

  flGet(fl_REPLACE_FUNCTION_NUM,Cardinal(FS1),CP);
  LRF.Caption:=IntToStr(CP);

  flGet(fl_CALC_CONST_NUM,Cardinal(FS1),CP);
  LCC.Caption:=IntToStr(CP);

  flGet(fl_MAX_REPLACE_LEVEL,Cardinal(FS1),CP);
  LMRL.Caption:=IntToStr(CP);

  {flGet(fl_LENGTH_CODE,Cardinal(FS1),CP);
  SetLength(Code,CP);
  Pb:=FS1;
  for i:=0 to CP-1 do
  begin
   Code[i]:=Pb^; inc(Pb);
  end;

  Pr:=@Code[0];
   asm
    call Pr
    fstp Res
   end;

  LFR.Caption:=_FloatToStr(Res);
  }

  flPerform(fl_FREE,Cardinal(FS1){Pk});



endp:
end;


//2/(-3*x-y-t/x-(-sin(x/y-(-x-1)+1)-y)/t)-(-(-1-x)/y*2+3*x/y/t-cos(-(-x-y)/(-(-x+y*2)-x)-1)/(x+y*t/3)*x)
//2/(-x)/(-3*(-x)-y*(-y)/(-(-t))-t/x-(-1/(-sin(x/y-(-t-1)+1)-t)/x)+y*(-(-t)))-(-(-1-t)/x*2+3*x/(-y)/(-(-(-t)-2-x)-y)-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)-sin(-t-(-x-(1-y)-3-(-x*2))/x/(-y/(-x)-x)-1)
//-(-x)-(-x/(-x-1-y)-t)*(-(-(-x-1)-y-y-1)/(-y)*t/(-y)-y)*(-(-sin(x)-1-x)-y*x/(-y)/(-y)-(-(1-cos(x)-x)-y)/sin(x)+(-(-x*x-y-y+1)-sin(y)/(-t-(-x)-1)*y)*y+(x-(-sin(x)-1-y)-t/(-t*x/(-y)-1)-1)-x-1)
//x*(-(x*y+x))-2/(-3*x-y-t/x-(-sin(x/(-(x*y+x))-(-t-1)+1)-t)/x)-(-(-1-t)/x*2+3*x/y/t-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)
//7-x-(-(-x-1)+cos(x)-1-sin(x)-2*t-(-cos(y-(-(1-sin(t)-x)))))+2*y-t
//1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9) {!!! (8)}
//sin(a*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))  {!!!}
//sin(c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d)+c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d))
// 2*sin(4*x/t-(4*x-5)/(5*y+1)-x*5/cos(tan(2*t^(2*x/sin(4*x*y-5)+1)-3*x*y*t-t)^3)^5/(4*x*y*tan(2*x*y/(4*x-5*t+y-7/x)^7-(3*t+1)^sin(3*cos(sin(5*x/(4*t-1)-1)*tan(2/tan(4*x-t*cos(2*x+1)))*sin(5*x*y*t)*tan(3*(3*t-1)^3-2)+x*4+t-1)))))
//-(-x-y-sin(x)-7+8)-(-(-cos(x)/x-(-(-x+1))/sin(t)-5-x/tg(x)-(-1/x-4+1/t-sin(y))))

//2/sp2(x-cos(y)*sin(-y*sp2(x*t,cos(y*sp2(2-x/t,t)/x*sp2(2-x,3*sin(x))/(2+x)))),y/sp2(x*cos(y),cos(y)*sp2(cos(y),sin(x))))
//x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(2+t+1)-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1)))))
//x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(2+t+1)-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1))))))-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1)))))


//sin(x)-(-(sh(x)+cos(x)))
//x*y-x*y+(x*y-x*y+(x*y+(x*y+(x*y-x+(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y+(x*y+x+y+(x*y-x*y+(x*y-x*y+(x*y+(x*y+(x*y-x+(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y+(x*y+x+y)))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)
//x*y-x*y+(x*y-x*y+(x*y+(x*y+(x*y-x+(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y+(x*y+x+y+(x*y-x*y+(x*y-x*y+(x*y+(x*y+(x*y-x+(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y+(x*y+x+y+(x*y-x*y+(x*y-x*y+(x*y+(x*y+(x*y-x+(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y+(x*y+x+y+(x*y-x*y+(x*y-x*y+(x*y+(x*y+(x*y-x+(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y+(x*y+x+y)))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)

//2/(-3*a-b-c/d-(-sin(a/b-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//2/(-a)/(-3*(-a)-b*(-b)/(-(-c))-c/d-(-1/(-sin(a/b-(-c-1)+1)-c)/d)+b*(-(-c)))-(-(-1-c)/d*2+3*a/(-b)/(-(-(-c)-2-d)-b)-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)-sin(-c-(-d-(1-b)-3-(-a*2))/a/(-b/(-a)-d)-1)
//-(-x)-(-a/(-x-1-y)-c)*(-(-(-x-1)-b-y-1)/(-b)*c/(-y)-b)*(-(-sin(x)-1-x)-b*x/(-y)/(-b)-(-(1-cos(x)-x)-b)/sin(x)+(-(-a*x-b-y+1)-sin(y)/(-c-(-x)-1)*y)*b+(x-(-sin(x)-1-y)-t/(-c*x/(-b)-1)-1)-x-1)
//x*(-(x*y+x))-2/(-3*a-b-c/d-(-sin(a/(-(x*y+x))-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)

{_MEM!!!:}
//(((2*x*y*t-7)*x*y*t/(x-y*2-3/(x/(t-1)-7/(y+2))))/(x-1))
//(((2*x*y*t-7)/(x-y*2-3/(x/(t-1))))/(x-1))
//(2*x*y*t-7)*(x-y*2-3/(x*(t-1)))/(x-1)
//(2*x*y*t-7)*(x-y*2-3/(x*(t-1)))*(x-1)
//(x*y)*(x+y+3/(x*(t-1)))*(x-1)
//(x*y)*(x+y+3/(x*(t-1)))

//x/(2*x/y*t+1)*y*(t+1)*(2*x+2*y-t+3)-x*2-y*3+4*t/(x+1)-(5*x+1)*(2*y+1)*(7/y-8/x+1)+(2*x*y+1)*(3*y*t-5)*x*y*t*(2*y/(3*x+4*y+5*t-7)+(5*x-7*y-8*t+9)*(x+1)*(y-2)/(5*x-t+1))+(2*x+1)*(3*y+2)*(4*t-7)-((y+1)/(x-3)+y*x*t/(y-x*2+3)+(4*x*y*t+5)/(x+3))

//((x*y+y*t-x/t)/(2*x+(x*y-2/x)/(y*x+t*x)))*((2*x*y-x*t)/(t*x-y+t/x)-2*x*(3*t-x*t)/(2*x-3*y-4)*(x/(3*x-1)-(x*y+x)/(y*t+x)+5*(2*x*y*t-x*y)/(y*x+t*y)-(2*x+3*x*t)/(2*x*(y+1)*(3*y+2)/((x*y+t)/(x*y-t*x-y)-2*t/(2*x*y*t-1)+(4*x-1)*(5*y-t*x)/(x-2*y-1-(2*t*y-2*x)*(x+1)/(3-7*x-8*y*((4*x*y-t/y)/(2*t+1)-7*x-8/t+9*(2*x-1)*(3*x+4*y+5/t)/(2*x*y*t-7*x/t)*((x*y*t-x/y)/(x-y*2-3/((x*y-t*x)/((t-1)-x*t)-7/(y+2)+(x*y+t*y-y/t)/(2*x*y*t+1)-9))))))/(x*y+t*y)))))
//x*y*(x+y/t-t*y*x*(x+y-t)*x*t*(x+t)*(x+y)/(x+t-y)-t/(x+y)+t*(x+y)/x-(x-y)/t)*(x-t)*(x+y+t*x-y*t)/(t+y/x-t/y)-x*y*(x+t)*(x-y)*(t/(x-t+y)-x*(t+x)/(y-t+x))+(x+y+t+(x-t)*(x+y)-(x+y)/(x-t)-x*y/(t-x))
//x/(2*x*y*t+1)*y*(t+1)*(2*x+2*y-t+3)-x*2-y*3+4*t/(x+1)-(5*x+1)*(2*y+1)*(7/y-8/x+1)+(2*x*y+1)*(3*y*t-5)*x*y*t*(2*y/(3*x+4*y+5*t-7)+(5*x-7*y-8*t+9)*(x+1)*(y-2)/(5*x-t+1))+(2*x+1)*(3*y+2)*(4*t-7)-((y+1)/(x-3)+y*x*t/(y-x*2+3)+(4*x*y*t+5)/(x+3))
//!!!(XCH+DL):
//(x*(2*x+3)*(4*t+5)*y*t/(7*y+1)+8)*(7*x*y*(2*x+1)*(2*x*y*t-1)/(3*x-4*y+5*t-7)-9)/(4*x*y*(7*x+1)*(9*t+2)*(5*y-9)*(7/(2*x+3)-8/x-9/(2*x*y*t-1)+1))-((2*x+3)/x-t/(4*x+5)-(2*x*y-1)*(3*x-4*y+5*t-7)*x*y/(5*x-7*y+8)-9)*(5*x+1)*(7*y-9)*(7*t-1)/(x/y-t/x+1)
//((2*x*y*t-1)/(3*x-4*y+5*t-7)-9)/((7/(2*x+3)-8/x-9/(2*x*y*t-1)+1)) !!!XCH+DL
//((2*x-1)/(3*x-4))/(8/x-9/(2*x*y-1)+1) !!! XCH+DL
//x-(-(7-(-sin(x)-1)-8*y+y-cos(x)))
//7-x-(-(-x-1)+cos(x)-1-sin(x)-2*t-(-cos(y-(-(1-sin(t)-x)))))+2*y-t
//1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9) {!!! (8)}
//sin((a*x+b*y+c)-(a*x*y*t-d)+d*x-e)
//a*x*(b/(c*c-d)+e*x*(c*(d*x*((a*x+b)-(b*x-c))-x/((x/b-c)*c+(x/d+a)*x+c)+(a*x+b)-(b*x+c)+(c*x+d)*e*x)/(a*(b*(c*(d*(e*x-a)*(x+b)+(c*x-d)*x*a)+c*x+d)+e)/(x-d))*(x/c-d)*a*x))
//a*v1*(b/(c*c-d)+e*v1*(c*(d*v1*((a*v1+b)-(b*v1-c))-v1/((v1/b-c)*c+(v1/d+a)*v1+c)+(a*v1+b)-(b*v1+c)+(c*v1+d)*e*v1)/(a*(b*(c*(d*(e*v1-a)*(v1+b)+(c*v1-d)*v1*a)+c*v1+d)+e)/(v1-d))*(v1/c-d)*a*v1))
//sin(cos(tan(cos(sin(tan(x))))))
//a*x*sin(b*x+c)*cos(c*x+d)+x*c*(cos(c*sin(x*d+e)-c)*tan(c*x))
//(a*v1*v2*v3+v4+b)*(c*v1/(v1+v2-v3)-v4*v1*a+b)+(c*v1*(v2*(a*v3+b)-v3*(c*v4-d)/((a*v1-b*v2+c)*(v3/v4+v1/v2+c)+a*v1-b*v2-c*v3)+v1+v2-c*v3-d*v4*(a/v1+b/v2-c/v3-d/v4)))
//(a*x*y+t-b*x)*(c*(t/x+x/y*(c*x+y-t*(c+y*x*t/d+(y-x)/t)))-x/(x-b*t*y-d/(a*x*y*t-c)+a/x+b/y+c/t-e/(x*y*t))+b)
//(a*v1*v2+v3-b*v1)*(c*(v3/v1+v1/v2*(c*v1+v2-v3*(c+v3*v1*v2/d+(v2-v1)/v3)))-v1/(v1-b*v3*v2-d/(a*v1*v2*v3-c)+a/v1+b/v2+c/v3-e/(v1*v2*v3))+b)
//c*x*(x*c*(b*x*(a*x*(x*b+c)+d)+e)+d)*(c*x+d*x*(d+x+c*(b*x*(b*x+d)+e))+b)+(e*x+d+c*(b+e*x+a*(d+e*x+a*x*(c*x+d)*(b*x+e)*(a*x+c))*(c*x+d))*(c*x+b*x*(e*x+d)+b))
//c*x*(a*x*(b*x+c+d*x*(c*x+e))+(d*x+a)*c+c*x+e)*(a*x+b)*(c*x+d*(c*x+a)+d)*(a+c*x*(d*x+c+x+(c*x+e)*c+(e*x+d)*b)+c*x+d)+d*x+e*x*(a*x+c+x)+x+c*x*(a*x+b)*(c*x+d)*(d*x+e)+d*(c*x+(b*x+c)+(d*x+e)+a)+b
//c*t*(a*t*(b*t+c+d*t*(c*t+e))+(d*t+a)*c+c*t+e)*(a*t+b)*(c*t+d*(c*t+a)+d)*(a+c*t*(d*t+c+t+(c*t+e)*c+(e*t+d)*b)+c*t+d)+d*t+e*t*(a*t+c+t)+t+c*t*(a*t+b)*(c*t+d)*(d*t+e)+d*(c*t+(b*t+c)+(d*t+e)+a)+b
//c*y*(a*y*(b*y+c+d*y*(c*y+e))+(d*y+a)*c+c*y+e)*(a*y+b)*(c*y+d*(c*y+a)+d)*(a+c*y*(d*y+c+y+(c*y+e)*c+(e*y+d)*b)+c*y+d)+d*y+e*y*(a*y+c+y)+y+c*y*(a*y+b)*(c*y+d)*(d*y+e)+d*(c*y+(b*y+c)+(d*y+e)+a)+b
//c/x/(a/x/(x/b-c)-(x/d-a)-x/c-e)/(x/a-b)/(x/c-d)/(a-x/c/(x/d-c-x-(x/c-e)/c)-x/c-d)-x/d-e
//((c/x/(a/x/(x*b-c)-(x*d-a)-x*c-e)/(x*a-b)/(x*c-d)/(a-x*c/(x*d-c-x-(x*c-e)*c)-x*c-d)-x*d-e)/(c*x-d)-(x/(a*x-c)+(a*x-b)/x)/(c*x-d)+x/(c-x/(a*x+b)-(c*x-d)/x+(a*x-b)/(b*x-c)))*(a*x+b)/(c*x+d)+b*x*(c*x+d)/(a*x+d)-c*(c*x+d)*(b*x-a)/x+b
//c*x*(a*x*(b*x-c-d*x*(c*x-e))-(d*x-a)*c-c*x-e)*(a*x-b)*(c*x-d*(c*x-a)-d)*(a-c*x*(d*x-c-x-(c*x-e)*c-(e*x-d)*b)-c*x-d)-d*x-e*x*(a*x-c-x)-x-c*x*(a*x-b)*(c*x-d)*(d*x-e)-d*(c*x-(b*x-c)-(d*x-e)-a)-b
//(((2*x+3)*(3*y+4)+(3*x-5)/(4*y+6)+x*(4*y-5))*(3*x-4)+(2*x+3)*(((3*x-4)/(3*y+5)+5*x/(2*x-5)-7*y*(3*y+5)+7)/(3*x+4)-5/x-7/y))/(((3*x-4)*(4*y-5)*(5*y-7)*x-(3*x-8)*(2*y-9)/(3*x+4)+5/x-7)*(2*x-3)*(3*y+4)+x*(3*x-4)*(3*y+4)+5/x+7)+(3*x-5)*(5*y+6)/x+y*(3*x+5)/(5*x-6)+7
//(2*x*(2*t-1)/(3-x)-t-x/t/(7-y))*(3/x-t-3+(y*(x-1)-t*(5-x/t-7*(8*x-1)/(t*2/y+1))))-(2*x-x*y*t/(6*x-1)-t*(4-y)+2-5/x*(x-t*(3-x))*(x*y/(x+1)/(t-1)-2/y*(y-t))-x*y*t*(3/t+1)/(5*y/x-1))
//((x+sin(x)+3)*2*x+2*sin(x)+x+5)*2+sin(x)*x+2*sin(x)+5*sin(x)*sin(x)*x+5+x+2*(sin(x)*sin(x)*sin(x)+x*sin(x)+x+5)
//x*(2*x+3)*(3*y+4)*(4*x*y+5)+t*(2*t+3*y+4*x+5)*(2*x*y*t+3)+t*(2*x+3*y+4)*(5*x+6)-7*(5*x*y*t-8-7*x-8*y-9*t)*(2*x+3*t+4*y+5)
//power(a*power(b*power(c*x+d,2)+e,2)+b,2)         (a*(b*(c*x+d)^2+e)^2+b)^2
//sin(c*(a*x)^cos(-x^(sin(c^-6+x)*c+b)+d))   {при FOptim = False ощибка!!!}
//sin(c*power(a*x,cos(-power(x,(sin(power(c,-6)+x)*c+b))+d)))
//sin(c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))  {!!!}
//sin(c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d)+c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d))
//sin((x)^a+(x)^b)
//sin(b+b*x^7+x^6) {!!!}
//a*x^7+x^6
//sh(2*ch(2*x-1)-1)*exp(x)/ch(x)-sh(2*ch(2*x-1)-1)^2-sh(x)/exp(x)+ch(x)/exp(x)
//sin(a*(sin(a*(sin(a*(sin(a*(b*x+d)^b+c))^b+c))^b+c))^b+c)
//sin(a*sin(a*(sin(a*(sin(a*(x)^2+b)^2)^2+b)^2)^2+b)^2+b)^2 {!!!}
//sin(a*sin(x)^2+b) {!!!}
//sin(a*(sin(b*x+c)^2)^2+d) {!!!}
//sin(a*(sin(sin(a*(sin(b*x+c)^2)^2+d))^2)^2+d)
//power(sin(a*power(sin(a*(sin(a*(sin(a*(x)^2+b)^2)^2+b)^2)^2+b),2)+b),2)
//sin(a*(sin(a*(x)^2+b)^2)^2+b)^2 {!!! FC}
//(a*sin(a*(sin(b))^2+b)^2+b)^2 {!!!}
//(a*(sin(a*(sin(b))^2+b)^2)+b)^2
//(sin(a*(sin(b))^2+b)^2)^2   {!!!}
//sin(a*power(power(sin(a*x+b),2),2)+b) {!!!}
//2*x*(2*sin(3*x+4)*sin(4*x+5)+5)*sin(2*x+3)+6
//sin(sin(sin(sin(x)^2+sin(x)^2)^2+sin(sin(x)^2+sin(x)^2))+sin(sin(sin(x)^2+sin(x)^2)^2+sin(sin(x)^2+sin(x)^2)))^2
//power(sin(a*power(sin(a*power(power(sin(a*power(power(sin(a*x+b),2),2)+b),2),2)+b),2)+b),2)   {!!!}
//sin(cos(tan(x/2+3)^5)^5)^5 {FC!!!}
//56:
//sin(sin(sin(sin(a*x+b)^5+sin(c*x+d)^5)^5+sin(sin(d*x+e)^5+sin(c*x+b)^5))^5+sin(sin(sin(d*x+e)^5+sin(a*x+b)^5)^5+sin(sin(d*x+e)^5+sin(c*x+d)^5)))^5
//(a*sin(a*sin(a*sin(x)^2+b)^2+b)^2+b)^2 {!!!}
//63:
//sin(sin(a*sin(a*x+b)^2+b)+sin(a*sin(a*sin(a*x+b)^2+b*sin(c*x+d)^2)^3+b)^5)^2+sin(sin(a*sin(a*sin(b*x+c)^2+b)^2+d)^2+sin(a*sin(a*sin(b*x+c)^2+d)^2+b)^2+sin(a*sin(a*sin(b*x+c)^2+d)^2+b)^2)^3
//2*x*sin(3*x*tan(pi*x)+4*x*cos(pi*x)+5*x*cotan(pi*x)+6*x*sin(pi*x))+7*x*cos(8*x*tan(pi*x)+9*x*cos(pi*x)+10*x*cotan(pi*x)+11*x*sin(pi*x))+12*x*tan(13*x*tan(pi*x)+14*x*cos(pi*x)+15*x*cotan(pi*x)+16*x*sin(pi*x))+17*x*cotan(18*x*tan(pi*x)+19*x*cos(pi*x)+20*x*cotan(pi*x)+21*x*sin(pi*x))
//2*x*sin(3*x*tan(2*x)+4*x*cos(2*x)+5*x*cotan(2*x)+6*x*sin(2*x))+7*x*cos(8*x*tan(2*x)+9*x*cos(2*x)+10*x*cotan(2*x)+11*x*sin(2*x))+12*x*tan(13*x*tan(2*x)+14*x*cos(2*x)+15*x*cotan(2*x)+16*x*sin(2*x))+17*x*cotan(18*x*tan(2*x)+19*x*cos(2*x)+20*x*cotan(2*x)+21*x*sin(2*x))
//2*x*sin(2*x+3)*cos(2*x+3)+3*x*tan(2*x+3)*arctan(sin(2*x+3)*cos(2*x+3)*x*2)/sqrt(x+3*cos(2*x+3)+4*tan(2*x+3)+5*sin(2*x+3)+2)/sqrt(x+6*sqr(7*cos(2*x+3)+1)+3)/sqrt(x+9*sqr(8*sin(2*x+3)+2)+4)/sqrt(x+4*sqr(3*tan(2*x+3)+3)+5)
//3*(2*x*(2*sin(3*x+4)*sin(4*x+5)+5)*sin(2*x+3)+6)*sin(2*x*(2*sin(3*x+4)*sin(4*x+5)+5)*sin(2*x+3)+6)+3*(2*sin(2*x*(2*sin(3*x+4)*sin(4*x+5)+5)*sin(2*x+3)+6)+3)^2+4
//(a*x*t*sin(t/a+b)*(b*x+d)*cos(c*(a*x+b*y+c*t+d)^(c*x-b)-d)-tan(a*sin(a*x+b*y+c)^2-b*cos(a*x*y*t+b)^5+c)^3)/(a*x*y*(b*t-c)^(c*x-d)*(b*t+a)-b*x*sin(a*(b*x+c)^3-b)^4+d)+a*(b*x+c*y+d*t+c)*(a*x*y*t+b)*x*y*t-(b*x*y*t*(c*sin(b*x+c)+d)^3)/(((a*x+b)*(c*y-d)*(b*t+c)*x*y*t*b+c)*sin(a*cos(c*x+d)+b)^3)
//sin(sin(sin(sin(sin(sin(sin(sin(sin(sin(sin(x)))))))))))
//2*x*sin(2*y+3)*cos(2*t+3)+3*y*tan(2*z+3)*arctan(sin(2*x+3)*cos(2*y+3)*t*2)/sqrt(x+3*cos(2*y+3)+4*tan(2*t+3)+5*sin(2*z+3)+2)/sqrt(t+6*sqr(7*cos(2*y+3)+1)+3)/sqrt(x+9*sqr(8*sin(2*y+3)+2)+4)/sqrt(t+4*sqr(3*tan(2*z+3)+3)+5)
//(a*x*t*sin(t/a+b)*(b*x+d)*cos(c*(a*x+b*y+c*t+d)^(c*x-b)-d)-tan(a*sin(a*x+b*y+c)^2-b*cos(a*x*y*t+b)^5+c)^3)/(a*x*y*(b*t-c)^(c*x-d)*(b*t+a)-b*x*sin(a*(b*x+c)^3-b)^4+d)+a*(b*x+c*y+d*t+c)*(a*x*y*t+b)*x*y*t-(b*x*y*t*(c*sin(b*x+c)+d)^3)/(((a*x+b)*(c*y-d)*(b*t+c)*x*y*t*b+c)*sin(a*cos(c*x+d)+b)^3)
//(2*sin(3*x+4)*cos(x)+3*tan(x))*(3*sin(2*x+3)*tan(3*x+4)+4*sin(2*x+3)*cos(3*x+4)+5)+(2*sin(x)*cos(x)+3*tan(2*x+3)*cos(3*x+4)+4)*(3*cos(3*x+4)*tan(2*x+3)+4*sin(x)*ln(2*x+3)+4)+5
//(sin(x)*cos(x)+sin(x))*(cos(x)*sin(x)+cos(x))+(sin(x)*cos(x)+sin(x))*(cos(x)*sin(x)+cos(x))
//(((sin(x)*sin(x)+sin(x)*sin(x)+sin(x))*(sin(x)*sin(x)*sin(x)+sin(x)*sin(x)*sin(x))*(sin(x)*sin(x)*sin(x)+sin(x))+(sin(x)*sin(x)*sin(x)+sin(x)*sin(x)+sin(x))*(sin(x)*sin(x)+sin(x)*sin(x)+sin(x))+sin(x))*(sin(x)*sin(x)*sin(x)+sin(x))+sin(x))*(sin(x)*sin(x)+sin(x))*(sin(x)*sin(x)+sin(x)*sin(x))+(sin(x)*sin(x)+sin(x)*sin(x)+sin(x))*(sin(x)*sin(x)*sin(x)+sin(x)*sin(x)*sin(x))+sin(x)
//2*(2*x+3)*(3*y+4)*(4*x*y+5)+3*(2*t+3*y+4*x+5)*(2*x*y*t+3)+4*(2*x+3*y+4)*(5*x+6)+7
//5*(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)*(2*x+3*y+4*t+2*x*y*t*sin(2*x*y*t+3)+5)+2*x*y*t*sin(2*x+3*y+4*t+5)+7*((5*sin(2*x*y*t+5)*cos(2*x+3*y+5*t+7)*x*y*t+7)*(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)*(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)+(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)*(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)+(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)+5)+7
//2*(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)*(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)+sin(x)+5
//2*sin(a*(2*x*y*t+3)^(2*x+5)-7)+8 {!!!}EXTENDED/DOUBLE
//2*v1*v2*v3*v4*v5*v6*v7*v8*v9*v10*v11*v12+5
//2*v1-3*v2+4*v3-5*v4+6*v5-7.1*v6+7*v8-9.5*v9+v10-v11+v12-v7+15
//1-5*(-2*(-2*x+3)*sin(x))
//1-(-2*(-2*x+3)*sin(x)-1)
//(2*(x/2+3)/(y/3+4)-7)/(3*sin(x/2-3)/(sin(x/3+4)/2+3)+2)/(x/3+3)-2*(y/4-7)/sin(x/5+7)/(x/3+4)-2*sin(x/5+6)*sin(x/7+8)/(y/5+7)-(2*sin(2/x+3)*(2*x+3)/sin(x/4+5)-(5/x+7)*(2*sin(x/5+7)/(2*x+3)-5)/(x/5+7))
//(2*(x/2-3)/(5/x-7)-(x/5+7)*sin(x/3+4)/(x/5+7)-9)/sin(x/2-3) {!!!}
//(x/2-3)/(5/x-7)+(x/5+7)*2    {!!!}
//2*(sin(x)/(a*x+b)-(a*x-b)/sin(x))*(b-a*x)*sin(x)/(b-x*a)-7
//2*(2*x+3)*(3*y+4)*(4*x*y+5)+3*(2*t+3*y+4*x+5)*(2*x*y*t+3)+4*(2*x+3*y+4)*(5*x+6)+7
//1-((8-3*(2*x-3)/4*y/sin(x)-7)) {!!!}
//5/((2/x-3)/sin(5/y+3)-2*sin(7/sin(1/(2*x+3)+4)-3/(7-5/(2*x+3)*sin(3/x+5))-3))-3*sin(2*x+3)*(3*y+4)/sin(3/x-2)+4*(2*x+3)*(3*y+4)/(5*x+6)-6*sin(x)/(7*sin(3/x-2)*sin(3/(2*y-3)-4)/(2*x+3)-2*sin(2*x+3)*(3*y+4)/sin(1-5/(2*y+3)))*(2*sin(2/x-3)*(2/sin(2*x+3)-3*sin(2/x-3)/(2*x+3)+4*(3*y-2)/sin(2*y-3)/sin(sin(2*x+3)*sin(3*y+4)/(5*x-7)-7*sin(2/x-3)/(2*y+3)-5*sin(2*x-3)*(2*y-5)/sin(2/x-4))))
//sin(sin(x))*sin(x)+sin(x) {!!!} PCO
//sin(x)+sin(x)*sin(sin(x)) {!!!} PCO
//sin(x)+sin(x)*cos(sin(x)) {!!!} PCO + Operations
//sin(x)+sin(x)*sin(x)      {!!!} PCO
//2*((x+1)*3-4)/(3*x*y+4)+5 {!!!}
//sin(2*(3*x+4*t-5)^(2*i-3*j+4)+10)
//sin(2*(3*x+4*t-5)^(2*i-4)+10)
//sin((3*x+1)^i)
//sin(2*(3*x+4*y-10)^(2*i-1)-10)
//sin((3*x+4)^(2*i-1))
//sin(2*(3*x+4*y-10)^(2*i-3*j+4)-10)
//sin(2*(3*x+4*y-4*t+5*z-10)^(2*i-3*j+4*k+5*m-4)-10)
//2*(3*sin(4*(5*x+6*y-10)^(2*i+1)-11)-7)^9+12  !!!
//2*(3*sin(4*(5*x+6*y-10)^11-11)-7)+12         !!!
//2*(3*sin((5*x+6*y-10)^(2*i+1)-11))+12        !!!
//2*(3*(4*x+5*y-30)^(2*i+1)-10)^(3*j-5)-7
//2*x+3*y-4*z+5*t-v-u+s+2*p-q-3*r+5*w+2*x1+3*x2-x3-x4+2*x5-7*x6-x7+8*x8-x9-x10+2*v1-3*v2-4*v3+4*v4+1
//2*i-3*j+4*k+m-n-2*l+3*i1+i2-3*i3+4*i4-i5+i6-2*i7+i8-i9+7
//(2*x^i-5)^j
//(2*x^(i+3*j-12)-5)^(2*l+m)
//sin(2*x^(i+3*j-12)-5)^5
//sin(2*x^(i+3*j-12)-5)^(2*l+m)
//2*sin(4*x/t-(4*x-5)/(5*y+1)-x*5/cos(tan(2*t^(2*x/sin(4*x*y-5)+1)-3*x*y*t-t)^3)^5/(4*x*y*tan(2*x*y/(4*x-5*t+y-7/x)^7-(3*t+1)^sin(3*cos(sin(5*x/(4*t-1)-1)*tan(2/tan(4*x-t*cos(2*x+1)))*sin(5*x*y*t)*tan(3*(3*t-1)^3-2)+x*4+t-1)))))
//(-1)^(2*k+1)*sin(i*t)^(k-i+2)*i!*x^(k-1)/(k!*(2*(2*k+3*i-15)!+5)^(i-2))*2^(2*n*k*l-5)
//(2*sin(3*x+4)*cos(2*x*y*t-7)*x-x*y*t*2*cos(2*x+3)/sin((4*x+2)/(4*y+1)))*x/sin(x/y*2-3)-2*x/cos(x*sin(5*x+3)/cos(5*x-7)+8)+2*sin(2*x+3*y-4*t+5)*cos(3*x*y*t+7)/(2*x+3)
//sin(x)+1+cos(x*2+3)*sin(x)+x^2+2*t+7  {!!!} Polynom
//1+x^2+2*t   {!!!}
//x*t-cos(t)*(tan(x*t-cos(t)*(tan(x*t-cos(t)*(tan(y*x-t^y)))))) {!!!}
//x*t-cos(t)*(tan(x*t-cos(t)*(tan(x*t-cos(t)*(tan(y*x-t^(-1)))))))
//FA4(sin(x+FA4(FA4(1,2,3,sin(x)),x,y,t)),cos(x)+sin(x*y+x/t-sin(x-y)),FA4(x-y,t/x,t*x*sin(x)+cos(x),7-sin(x)),-FA4(-sin(x),-cos(x),-tan(x)-x,-t))
//FA4(sin(x)-cos(x)+x*y/t,sin(x/cos(x)-tan(x)),sin(x)^cos(x),y)
//FA3(sin(x)*cos(3*FA3(sin(x)/cos(x-t+2)-2*t,x/y,x*cos(x+sin(x)))/(x-1)+4),sin(x)-2*FA3(1-sin(x),x+cos(x)-sin(x)/(x+1),t)-3,x/(sin(x)-FA3(x,t^sin(x),sin(x)^cos(x))))
//FA3(-FR3(-sin(x),-cos(t*sin(x)),3),FA3(1,FA3(sin(x),cos(x)+sin(x)*x-t,t),4-2*FR3(sin(x),cos(x)+sin(x)*x-t,t)-x*FA3(sin(x),cos(x)+sin(x)*x-t,t)),FR3(cos(x)-FA3(sin(x),cos(x)+sin(x)*x-t,t),t,sin(x)+cos(x)/(x+1)))-2*sin(x)/FR3(x-t,x*sin(x),-3/t)-FA3(sin(x)*x+cos(x),x/sin(x)+t,3-x*t/(x+1))
//FR3(sin(x)-cos(x)+x*y/t,sin(x/cos(x)-tan(x)),sin(x)^cos(x))
//cos(x)-sin(2*cos(x)+3)+sin(cos(x))+sin(x)/(cos(x)-5*sin(2*cos(x)+3)-4*sin(cos(x)))-4*cos(5*sin(2*cos(x)+3)/(7*sin(cos(x))-1))
//2/sqrt(sin(x))-sin(x)/(sqrt(sin(x))-sqrt(1-sin(x)))-sin(x)/(sqrt(sin(x))+sqrt(1-sin(x)))
//2-sin(x)-(sqrt(1+sin(x))-sqrt(1-sin(x)))/(sqrt(1+sin(x))+sqrt(1-sin(x)))
//x*t-sin(x)^cos(x)*(tan(x*t-sin(x)^cos(x)*(tan(x*t-sin(x)^cos(x)))))
//x*t-exp(t)*(exp(x*t-exp(t)*(exp(x*t-exp(t)))))
//x*t-exp(t)*(exp(x*t-exp(t)*(exp(x*t-exp(t)*(exp(y*x-1))))))
//x*t-x^t*(x^(x*t-x^t*(x^(x*t-x^t*(x^t)))))
//x*t-x^(-1)*(x^(x*t-x^(-2)*(x^(x*t-x^(-3)*(x^(-4))))))
//x*t-x^7*((x*t-x^7*((x*t-x^7*(x^7))^7))^7)
//x*t-x^5*((x*t-x^5*((x*t-x^5*(x^5)+(x*(x^5))^5)^5)^5)^5)^5
//x*t-x^(-5)*((x*t-x^(-1)*((x*t-x^(-2)*(x^(-3))+(x*(x^(-4)))^(-2))^(-2))^(3))^(4))^(5)
//sin(sin(x))+sin(sin(sin(x)))+sin(sin(x))+sin(sin(sin(x)))
//sin(x)+sin(sin(x))+sin(sin(sin(x)))+sin(x)+sin(sin(x))+sin(sin(sin(x)))
//(sin(2*x+4)*3-5*cos(4*x-5)/tan(5*t-7)-x*4+y*5-7)/sin(x*5-11)+7*x*cos(8*t-9) !!!!!
//(sin(x)-cos(x)-x+y)   !!!
//(v1*v2*v3*v4*v5*v6*v7*v8*v9*v10*4*x*y*t+7)^2+(v1*v2*v3*v4*v5*v6*v7*v8*v9*v10*4*x*y+7)^2 !!!
//(v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+4+x+y+t+7)^2+(v1*v2*v3*v4*v5*v6*v7*v8*v9*v10*4*x*y+7)^2
//(v1*v2*v3*v4*v5*v6*v7*v8*v9*v1*4+7)^2+(v1*v2*v3*v4*v5*v6*v7*v8*v9*x*4+7)^2 !!!
//(v1+v2+v3+v4+v5+v6+v7+v8+v9+v1+4+7)^2+(v1+v2+v3+v4+v5+v6+v7+v8+v9+x+4+7)^2
//(x*x*y+7)^2  !!!
//(x*y)^2+(y*t*x)^ !!!
//-(-x-y-sin(x)-7+8)-(-(-cos(x)-(-(-x+1))-5-tg(x)-(x-4-sin(y)))) !!!
//sin(x)+sin(sin(sin(x)))+sin(sin(x))+sin(sin(sin(x)))+sin(sin(x))+sin(sin(sin(sin(x))))+sin(x)+sin(sin(sin(sin(x))))
//sin(sin(x))+sin(x)+sin(sin(x))-4*sin(sin(3*sin(x)))+sin(x)+2*sin(3*sin(x))+sin(sin(sin(x)))
//sin(sin(x))^cos(x)+sin(sin(x))^tan(x)    (!!!)
//-(-x-y-sin(x)-7+8)-(-(-cos(x)/x-(-(-x+1))/sin(t)-5-x/tg(x)-(-1/x-4+1/t-sin(y))))
//x*t-ch(t)*(th(x*t-ch(t)*(th(x*t-ch(t)*(th(y*x-t^y))))))
//sh(sin(x))+(sh(sin(x))+(sh(sin(x))+sin(x))) !!!(DL(2)+CopyStack(2))
//exp(sin(x))+(sh(sin(x))+(ch(sin(x))+sin(x))) !!! DL
//exp(sin(x))+sh(sin(x))    !!! DL
//(2*x-1)^(2*i-3)+(2*x-1)^(2*i-3)
//iroot(2*x-1,2*i-3)+iroot(2*x-1,2*i-3) !!! CS
//sin(x+5)^((sin(x)^cos(y))^(sin(x+1)^cos(y+1)))+sin(x+5)^((sin(x)^cos(y))^(sin(x+1)^cos(y+1)))
//p6(p6(1,2,3,4,5,6)+c6(1,2,3,4,5,6),2,p6(1,2,3,4,5,6)+c6(1,2,3,4,5,6),p6(1,2,3,4,5,6)+c6(1,2,p6(1,2,3,4,5,6)+c6(1,2,3,p6(1,2,3,4,5,6)+c6(1,2,p6(1,2,3,4,5,6)+c6(1,2,p6(1,2,3,4,5,6)+c6(1,2,3,4,5,6),4,5,6),4,5,6),5,6),4,p6(1,2,3,4,5,6)+c6(1,2,3,4,5,6),6),p6(1,2,3,4,5,6)+c6(1,2,p6(1,2,3,4,5,6)+c6(1,2,3,4,5,6),4,p6(1,2,3,4,5,6)+c6(1,2,3,4,5,6),6),p6(1,2,3,4,5,6)+c6(1,2,3,4,5,6))+c6(1,p6(1,2,3,p6(1,2,3,4,5,6)+c6(1,2,3,4,5,6),5,6)+c6(1,2,3,4,5,6),3,p6(1,2,3,4,5,6)+c6(1,2,3,4,5,6),5,p6(1,2,3,4,5,6)+c6(p6(1,2,3,4,5,6)+c6(1,2,3,4,5,6),2,3,4,5,6))
//f3p(x*y-t,f3p(x+y,y-t,y*f3p(x-y,y*t,t*y)),f3p(x*y,x-t,y+t)*x+f3p(x+y,x-f3p(x+y,y+t,t-x),t*y-x*f3p(t*x,x-y,t-x)))*f3p(x*y,t-y,y-t)*(f3p(f3p(x-y,t-y,y-x),y-x,y+f3p(x-y,y-t,x-t))+x*f3p(y*x,t*x,y*t)*(x+y)+t*(x+y*t))-f3p(y*f3p(y-t,y-x,t-y)+t,y+t*x,x-y)*(f3p(x-y,y-x,f3p(x*y,y-t,y-t))-y*f3p(f3p(x*x,y*x,t*x),f3p(t*y,x*y,t*x),f3p(x-t,y-x,x-y)))



procedure K1;
asm
 add  eax,eax
 mov  MEM,eax
 fild MEM
end;


procedure F1;
asm
 fld  ST(0)
 faddp
end;


procedure FI1;
asm
 mov  MEM,eax
 fild MEM
 faddp
end;


procedure FF1;
asm
 fsubp
end;



procedure TForm1.FormCreate(Sender: TObject);
var
Func: TAddFuncStruct;
ID: Cardinal;
Ptr: Pointer;
Code: array of byte;
TypeList: array of Integer;
S: String;
P: PChar;
begin
flSet(fl_ENABLE,fl_EXTERNAL_EXCEPTION,0);
flSet(fl_EXTERNAL_EXCEPTION,cardinal(@FException),0);
//flSet(fl_ENABLE,fl_CLOSE_ARG,0);
{$IFDEF STRING} flSet(fl_String_Type,fl_String,0);{$ELSE} flSet(fl_String_Type,fl_PChar,0); {$ENDIF}


c05dln2:=0.5/ln(2);
c05dln10:=0.5/ln(10);
c1dln2:=1/ln(2);
c1dln10:=1/ln(10);




Form1.X:=2;       Form1.x1:=2;      Form1.x0:=2;
Form1.Y:=5;       Form1.y1:=5;      Form1.y0:=5;
Form1.T:=1.77;    Form1.t1:=1.77;   Form1.t0:=1.77;
Form1.Z:=-5.1;    Form1.Z1:=-5.1;   Form1.Z0:=-5.1;
Form1.S:=-3.5;    Form1.S1:=-3.5;   Form1.S0:=-3.5;
Form1.P:=1.1;     Form1.P1:=1.1;    Form1.P0:=1.1;
Form1.Q:=2.2;     Form1.Q1:=2.2;    Form1.Q0:=2.2;
Form1.R:=15.3;    Form1.R1:=15.3;   Form1.R0:=15.3;
Form1.U:=0.5;     Form1.U1:=0.5;    Form1.U0:=0.5;
Form1.V:=-0.57;   Form1.V1:=-0.57;  Form1.V0:=-0.57;
Form1.W:=-3.3;    Form1.W1:=-3.3;   Form1.W0:=-3.3;


Form1.A:=2;
Form1.B:=2;
Form1.C:=3;
Form1.D:=4;
Form1.E:=5.77;
Form1.G:=0.5;
Form1.H:=-0.7;
Form1.N:=1;
Form1.M:=-3;
Form1.J:=3;
Form1.L:=4;
Form1.K:=2;
Form1.I:=5;

flSetParam('a',@Form1.A,fl_DOUBLE);
flSetParam('b',@Form1.B,fl_DOUBLE);
flSetParam('c',@Form1.C,fl_DOUBLE);
flSetParam('d',@Form1.D,fl_DOUBLE);
flSetParam('e',@Form1.E,fl_DOUBLE);
flSetParam('f',@Form1.F,fl_DOUBLE);
flSetParam('g',@Form1.G,fl_DOUBLE);
flSetParam('h',@Form1.H,fl_DOUBLE);

flSetVar('x',(@Form1.x),fl_Double);
flSetVar('y',(@Form1.y),fl_Double);
flSetVar('t',(@Form1.t),fl_Double);
flSetVar('z',(@Form1.z),fl_Double);
flSetVar('u',(@Form1.u),fl_Double);
flSetVar('v',(@Form1.v),fl_Double);
flSetVar('s',(@Form1.s),fl_Double);
flSetVar('p',(@Form1.p),fl_Double);
flSetVar('q',(@Form1.q),fl_Double);
flSetVar('r',(@Form1.r),fl_Double);
flSetVar('w',(@Form1.w),fl_Double);

flSetVar('x1',(@Form1.x1),fl_Extended);
flSetVar('y1',(@Form1.y1),fl_Extended);
flSetVar('t1',(@Form1.t1),fl_Extended);
flSetVar('z1',(@Form1.z1),fl_Extended);
flSetVar('u1',(@Form1.u1),fl_Extended);
flSetVar('v1',(@Form1.v1),fl_Extended);
flSetVar('s1',(@Form1.s1),fl_Extended);
flSetVar('p1',(@Form1.p1),fl_Extended);
flSetVar('q1',(@Form1.q1),fl_Extended);
flSetVar('r1',(@Form1.r1),fl_Extended);
flSetVar('w1',(@Form1.w1),fl_Extended);

flSetVar('x0',(@Form1.x0),fl_Single);
flSetVar('y0',(@Form1.y0),fl_Single);
flSetVar('t0',(@Form1.t0),fl_Single);
flSetVar('z0',(@Form1.z0),fl_Single);
flSetVar('u0',(@Form1.u0),fl_Single);
flSetVar('v0',(@Form1.v0),fl_Single);
flSetVar('s0',(@Form1.s0),fl_Single);
flSetVar('p0',(@Form1.p0),fl_Single);
flSetVar('q0',(@Form1.q0),fl_Single);
flSetVar('r0',(@Form1.r0),fl_Single);
flSetVar('w0',(@Form1.w0),fl_Single);



flSetVar('i',(@Form1.i),fl_Integer);
flSetVar('j',(@Form1.j),fl_Integer);
flSetVar('k',(@Form1.k),fl_Integer);
flSetVar('l',(@Form1.l),fl_Integer);
flSetVar('m',(@Form1.m),fl_Integer);
flSetVar('n',(@Form1.n),fl_Integer);



InitFuncStruct(Func);
Func.addr:=@K1;
Func.CallType:=fl_KERNEL_I;
Func.DeepFPU:=2;
flSetFunction('K1',@Func,ID);

InitFuncStruct(Func);
Func.addr:=@F1;
Func.CallType:=fl_KERNEL_F;
Func.DeepFPU:=2;
flSetFunction('F1',@Func,ID);

InitFuncStruct(Func);
Func.addr:=@FI1;
Func.CallType:=fl_KERNEL_FI;
Func.DeepFPU:=2;
flSetFunction('FI1',@Func,ID);

InitFuncStruct(Func);
Func.addr:=@FF1;
Func.CallType:=fl_KERNEL_FF;
Func.DeepFPU:=0;
flSetFunction('FF1',@Func,ID);


InitFuncStruct(Func);
SetLength(Code,2); Code[0]:=$DE; Code[1]:=$E9;
Func.SizeCode:=2;
Func.CodeInline:=@Code[0];
Func.CallType:=fl_KERNEL_FF;
Func.DeepFPU:=2;
flSetFunction('FF2',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@MA4;
Func.Arg:=4;
Func.ArgType:=fl_INTEGER;
Func.CallType:=fl_MEMORY_EAX;
Func.DeepFPU:=2;
flSetFunction('MA4',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@MC4D;
Func.Arg:=4;
//Func.ArgType:=fl_DIFFER;
SetLength(TypeList,4);
TypeList[0]:=fl_SINGLE;
TypeList[1]:=fl_EXTENDED;
TypeList[2]:=fl_DOUBLE;
TypeList[3]:=fl_INTEGER;
Func.ArgTypeList:=@TypeList[0];
Func.CallType:=fl_MEMORY_ECX;
Func.DeepFPU:=2;
flSetFunction('MC4D',@Func,ID);



InitFuncStruct(Func);
Func.addr:=@MS3;
Func.Arg:=3;
Func.ArgType:=fl_SINGLE;
Func.CallType:=fl_MEMORY_STACK_CPU;
Func.DeepFPU:=fl_UNKNOWN;
Func.ClearStack:=fl_ENABLE;
flSetFunction('MS3',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@MS4P;
Func.Arg:=4;
SetLength(TypeList,4);
TypeList[0]:=fl_SINGLE;
TypeList[1]:=fl_EXTENDED;
TypeList[2]:=fl_DOUBLE;
TypeList[3]:=fl_INTEGER;
Func.ArgTypeList:=@TypeList[0];
Func.CallType:=fl_MEMORY_STACK_CPU;
Func.DeepFPU:=2;
Func.ClearStack:=fl_DISABLE;
flSetFunction('MS4P',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@FR3;
Func.Arg:=3;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_STACK_FPU;
Func.DeepFPU:=2;
flSetFunction('FR3',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@S4P;
Func.Arg:=4;
SetLength(TypeList,4);
TypeList[0]:=fl_INTEGER;
TypeList[1]:=fl_EXTENDED;
TypeList[2]:=fl_DOUBLE;
TypeList[3]:=fl_SINGLE;
Func.ArgTypeList:=@TypeList[0];
Func.CallType:=fl_STACK_CPU;
Func.DeepFPU:=2;
Func.ClearStack:=fl_DISABLE;
Func.Arrow:=fl_BACK;
flSetFunction('S4P',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@S4C;
Func.Arg:=4;
SetLength(TypeList,4);
TypeList[0]:=fl_INTEGER;
TypeList[1]:=fl_EXTENDED;
TypeList[2]:=fl_DOUBLE;
TypeList[3]:=fl_SINGLE;
Func.ArgTypeList:=@TypeList[0];
Func.CallType:=fl_STACK_CPU;
Func.DeepFPU:=2;
Func.ClearStack:=fl_ENABLE;
Func.Arrow:=fl_RIGHT;
flSetFunction('S4C',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@S3S;
Func.Arg:=3;
SetLength(TypeList,4);
TypeList[0]:=fl_DOUBLE;
TypeList[1]:=fl_DOUBLE;
TypeList[2]:=fl_DOUBLE;
Func.ArgTypeList:=@TypeList[0];
Func.CallType:=fl_STACK_CPU;
Func.DeepFPU:=2;
Func.ClearStack:=fl_DISABLE;
Func.Arrow:=fl_RIGHT;
flSetFunction('S3S',@Func,ID);



InitFuncStruct(Func);
Func.addr:=@S4S;
Func.Arg:=4;
SetLength(TypeList,4);
TypeList[0]:=fl_INTEGER;
TypeList[1]:=fl_EXTENDED;
TypeList[2]:=fl_DOUBLE;
TypeList[3]:=fl_SINGLE;
Func.ArgTypeList:=@TypeList[0];
Func.CallType:=fl_STACK_CPU;
Func.DeepFPU:=2;
Func.ClearStack:=fl_DISABLE;
Func.Arrow:=fl_RIGHT;
flSetFunction('S4S',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@IAB;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_INFINITE_EABX;
Func.DeepFPU:=2;
flSetFunction('IAB',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@ISC;
Func.ArgType:=fl_DOUBLE;
Func.ClearStack:=fl_ENABLE;
Func.Arrow:=fl_RIGHT;
Func.CallType:=fl_INFINITE_STACK_CPU;
Func.DeepFPU:=2;
flSetFunction('ISC',@Func,ID);



//+ID


InitFuncStruct(Func);
Func.addr:=@MA4ID;
Func.Arg:=4;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_MEMORY_EAX;
Func.DeepFPU:=2;
Func.Set_ID:=fl_ENABLE;
Func.ClearStack:=fl_ENABLE;
Func.Id_Func:=1000;
flSetFunction('MA4ID',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@MC3ID;
Func.Arg:=3;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_MEMORY_ECX;
Func.Arrow:=fl_RIGHT;
Func.DeepFPU:=2;
Func.Set_ID:=fl_ENABLE;
Func.Id_Func:=1000;
flSetFunction('MC3ID',@Func,ID);



InitFuncStruct(Func);
Func.addr:=@MS3ID;
SetLength(TypeList,3);
TypeList[0]:=fl_EXTENDED;
TypeList[1]:=fl_INTEGER;
TypeList[2]:=fl_DOUBLE;
Func.ArgTypeList:=@TypeList[0];
Func.Arg:=3;
Func.CallType:=fl_MEMORY_STACK_CPU;
Func.DeepFPU:=2;
Func.Set_ID:=fl_ENABLE;
Func.ClearStack:=fl_ENABLE;
//Func.Arrow:=fl_BACK;
Func.Id_Func:=1000;
flSetFunction('MS3ID',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@MS3CID;
Func.ArgType:=fl_DOUBLE;
Func.Arg:=3;
Func.CallType:=fl_MEMORY_STACK_CPU;
Func.DeepFPU:=2;
Func.Set_ID:=fl_ENABLE;
Func.ClearStack:=fl_ENABLE;
Func.Arrow:=fl_RIGHT;
Func.Id_Func:=1000;
flSetFunction('MS3CID',@Func,ID);




InitFuncStruct(Func);
Func.addr:=@FR3ID;
Func.Arg:=3;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_STACK_FPU;
Func.Set_ID:=fl_ENABLE;
Func.ClearStack:=fl_ENABLE;
Func.Id_Func:=1000;
Func.DeepFPU:=2;
flSetFunction('FR3ID',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@S3PID;
Func.Arg:=3;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_STACK_CPU;
Func.DeepFPU:=2;
Func.ClearStack:=fl_DISABLE;
Func.Arrow:=fl_BACK;
Func.Set_ID:=fl_ENABLE;
Func.Id_Func:=1000;
flSetFunction('S3PID',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@S3CID;
Func.Arg:=3;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_STACK_CPU;
Func.DeepFPU:=2;
Func.ClearStack:=fl_ENABLE;
Func.Arrow:=fl_RIGHT;
Func.Set_ID:=fl_ENABLE;
Func.Id_Func:=1000;
flSetFunction('S3CID',@Func,ID);




InitFuncStruct(Func);
Func.addr:=@IABID;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_INFINITE_EABX;
Func.Set_ID:=fl_ENABLE;
Func.Id_Func:=1000;
Func.DeepFPU:=2;
Func.ClearStack:=fl_ENABLE;
flSetFunction('IABID',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@ISCID;
Func.ArgType:=fl_DOUBLE;
Func.ClearStack:=fl_ENABLE;
Func.Arrow:=fl_RIGHT;
Func.CallType:=fl_INFINITE_STACK_CPU;
Func.Set_ID:=fl_ENABLE;
Func.Id_Func:=1000;
Func.DeepFPU:=2;
flSetFunction('ISCID',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@ISPID;
Func.ArgType:=fl_DOUBLE;
Func.ClearStack:=fl_DISABLE;
Func.Arrow:=fl_BACK;
Func.CallType:=fl_INFINITE_STACK_CPU;
Func.Set_ID:=fl_ENABLE;
Func.Id_Func:=1000;
Func.DeepFPU:=2;
flSetFunction('ISPID',@Func,ID);


///////  test
InitFuncStruct(Func);
Func.addr:=@KA;
Func.CallType:=fl_KERNEL_FF;
Func.DeepFPU:=0;
flSetFunction('KA',@Func,ID);


InitFuncStruct(Func);
SetLength(Code,2);
Code[0]:=$DE; Code[1]:=$E1;
Func.SizeCode:=2;
Func.CodeInline:=@Code[0];
Func.CallType:=fl_KERNEL_FF;
Func.DeepFPU:=0;
flSetFunction('KI',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@FP;
Func.Arg:=2;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_STACK_FPU;
Func.DeepFPU:=0;
flSetFunction('FP',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@MA;
Func.Arg:=2;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_MEMORY_EAX;
Func.DeepFPU:=0;
flSetFunction('MA',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@SC;
Func.Arg:=2;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_STACK_CPU;
Func.DeepFPU:=0;
Func.ClearStack:=fl_ENABLE;
Func.Arrow:=fl_RIGHT;
flSetFunction('SC',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@SP;
Func.Arg:=2;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_STACK_CPU;
Func.DeepFPU:=0;
Func.ClearStack:=fl_DISABLE;
Func.Arrow:=fl_BACK;
flSetFunction('SP',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@FP3;
Func.Arg:=3;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_STACK_FPU;
Func.DeepFPU:=0;
flSetFunction('FP3',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@MA3;
Func.Arg:=3;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_MEMORY_EAX;
Func.DeepFPU:=0;
flSetFunction('MA3',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@SC3;
Func.Arg:=3;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_STACK_CPU;
Func.DeepFPU:=0;
Func.ClearStack:=fl_ENABLE;
Func.Arrow:=fl_RIGHT;
flSetFunction('SC3',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@SP3;
Func.Arg:=3;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_STACK_CPU;
Func.DeepFPU:=0;
Func.ClearStack:=fl_DISABLE;
Func.Arrow:=fl_BACK;
flSetFunction('SP3',@Func,ID);

InitFuncStruct(Func);
Func.addr:=@SP2;
Func.Arg:=2;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_STACK_CPU;
Func.DeepFPU:=0;
Func.ClearStack:=fl_DISABLE;
Func.Arrow:=fl_BACK;
flSetFunction('SP2',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@F2P;
Func.Arg:=2;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_STACK_CPU;
Func.DeepFPU:=0;
Func.ClearStack:=fl_DISABLE;
Func.Arrow:=fl_BACK;
flSetFunction('F2P',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@SIGN;
Func.CallType:=fl_KERNEL_F;
Func.DeepFPU:=0;
flSetFunction('sign',@Func,ID);

InitFuncStruct(Func);
Func.addr:=@Avr;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_INFINITE_EABX;
Func.DeepFPU:=1;
Func.ClearStack:=fl_ENABLE;
flSetFunction('avr',@Func,ID);


InitFuncStruct(Func);
Func.addr:=@Max;
Func.ArgType:=fl_DOUBLE;
Func.CallType:=fl_INFINITE_EBCX;
Func.DeepFPU:=2;
Func.ClearStack:=fl_ENABLE;
flSetFunction('max',@Func,ID);


end;









procedure TForm1.CB_StClick(Sender: TObject);
begin
if CB_St.Checked then flSet(fl_STACK_DEEP,8,0)
else
flSet(fl_STACK_DEEP,0,0);
end;

procedure TForm1.CB_TreeClick(Sender: TObject);
begin
{if CB_Tree.Checked then Foreval.TreeOptimization:=True
else
Foreval.TreeOptimization:=False; }
end;



procedure TForm1.CB_TrigClick(Sender: TObject);
begin
 if CB_Trig.Checked then flSet(fl_ENABLE,fl_TRIG_OPTIMIZATION,0)
 else  flSet(fl_DISABLE,fl_TRIG_OPTIMIZATION,0);

end;

procedure TForm1.RBXB_AutoClick(Sender: TObject);
begin
flSet(fl_AUTO,fl_EXCHANGE_BRANCH,0);
end;

procedure TForm1.RBXB_EnableClick(Sender: TObject);
begin
flSet(fl_ENABLE,fl_EXCHANGE_BRANCH,0);
end;

procedure TForm1.RBXB_DisableClick(Sender: TObject);
begin
flSet(fl_DISABLE,fl_EXCHANGE_BRANCH,0);
end;

procedure TForm1.RBDL_AutoClick(Sender: TObject);
begin
flSet(fl_AUTO,fl_DINAMIC_LOAD,0);
end;

procedure TForm1.RBDL_EnableClick(Sender: TObject);
begin
flSet(fl_ENABLE,fl_DINAMIC_LOAD,0);
end;

procedure TForm1.RBDL_DisableClick(Sender: TObject);
begin
flSet(fl_DISABLE,fl_DINAMIC_LOAD,0);;
end;

procedure TForm1.CB_CalcConstClick(Sender: TObject);
begin
if CB_CalcConst.Checked then flSet(fl_ENABLE,fl_CALC_CONST,0)
else
flSet(fl_DISABLE,fl_CALC_CONST,0);
end;



//Foreval.SetLevelReplace(StrToInt(E_CS.Text));
//Foreval.SetStackDeep(StrToInt(E_SDeep.Text));



procedure TForm1.UDRLClick(Sender: TObject; Button: TUDBtnType);
begin
flSet(fl_REPLACE_FUNCTION,UDRL.Position,0);
Panel1.Caption:=IntToStr(UDRL.Position);
end;

procedure TForm1.UDSDClick(Sender: TObject; Button: TUDBtnType);
begin
flSet(fl_STACK_DEEP,UDSD.Position,0);
Panel2.Caption:=IntToStr(UDSD.Position);
end;



procedure TForm1.RB_SDClick(Sender: TObject);
begin
 flSet(fl_DATA_TYPE,fl_DOUBLE,0);
end;

procedure TForm1.RB_SEClick(Sender: TObject);
begin
 flSet(fl_DATA_TYPE,fl_EXTENDED,0);
end;




procedure TForm1.RB_PR_SNGClick(Sender: TObject);
begin
 flSet(fl_PARAM_TYPE,fl_SINGLE,0);
end;

procedure TForm1.RB_PR_DBLClick(Sender: TObject);
begin
 flSet(fl_PARAM_TYPE,fl_DOUBLE,0);
end;

procedure TForm1.RB_PR_EXTClick(Sender: TObject);
begin
 flSet(fl_PARAM_TYPE,fl_EXTENDED,0);
end;

procedure TForm1.RB_VR_SNGClick(Sender: TObject);
begin
   flPerform(fl_FREE,fl_VAR_LIST);

flSetVar('x',(@Form1.x0),fl_Single);
flSetVar('y',(@Form1.y0),fl_Single);
flSetVar('t',(@Form1.t0),fl_Single);
flSetVar('z',(@Form1.z0),fl_Single);
flSetVar('u',(@Form1.u0),fl_Single);
flSetVar('v',(@Form1.v0),fl_Single);
flSetVar('s',(@Form1.s0),fl_Single);
flSetVar('p',(@Form1.p0),fl_Single);
flSetVar('q',(@Form1.q0),fl_Single);
flSetVar('r',(@Form1.r0),fl_Single);
flSetVar('w',(@Form1.w0),fl_Single);

flSetVar('i',(@Form1.i),fl_Integer);
flSetVar('j',(@Form1.j),fl_Integer);
flSetVar('k',(@Form1.k),fl_Integer);
flSetVar('l',(@Form1.l),fl_Integer);
flSetVar('m',(@Form1.m),fl_Integer);
flSetVar('n',(@Form1.n),fl_Integer);
end;

procedure TForm1.RB_VR_DBLClick(Sender: TObject);
begin
 flPerform(fl_FREE,fl_VAR_LIST);
 
flSetVar('x',(@Form1.x),fl_Double);
flSetVar('y',(@Form1.y),fl_Double);
flSetVar('t',(@Form1.t),fl_Double);
flSetVar('z',(@Form1.z),fl_Double);
flSetVar('u',(@Form1.u),fl_Double);
flSetVar('v',(@Form1.v),fl_Double);
flSetVar('s',(@Form1.s),fl_Double);
flSetVar('p',(@Form1.p),fl_Double);
flSetVar('q',(@Form1.q),fl_Double);
flSetVar('r',(@Form1.r),fl_Double);
flSetVar('w',(@Form1.w),fl_Double);

flSetVar('i',(@Form1.i),fl_Integer);
flSetVar('j',(@Form1.j),fl_Integer);
flSetVar('k',(@Form1.k),fl_Integer);
flSetVar('l',(@Form1.l),fl_Integer);
flSetVar('m',(@Form1.m),fl_Integer);
flSetVar('n',(@Form1.n),fl_Integer);
end;

procedure TForm1.RB_VR_EXTClick(Sender: TObject);
begin
flPerform(fl_FREE,fl_VAR_LIST);

flSetVar('x',(@Form1.x1),fl_Extended);
flSetVar('y',(@Form1.y1),fl_Extended);
flSetVar('t',(@Form1.t1),fl_Extended);
flSetVar('z',(@Form1.z1),fl_Extended);
flSetVar('u',(@Form1.u1),fl_Extended);
flSetVar('v',(@Form1.v1),fl_Extended);
flSetVar('s',(@Form1.s1),fl_Extended);
flSetVar('p',(@Form1.p1),fl_Extended);
flSetVar('q',(@Form1.q1),fl_Extended);
flSetVar('r',(@Form1.r1),fl_Extended);
flSetVar('w',(@Form1.w1),fl_Extended);

flSetVar('i',(@Form1.i),fl_Integer);
flSetVar('j',(@Form1.j),fl_Integer);
flSetVar('k',(@Form1.k),fl_Integer);
flSetVar('l',(@Form1.l),fl_Integer);
flSetVar('m',(@Form1.m),fl_Integer);
flSetVar('n',(@Form1.n),fl_Integer);
end;

procedure TForm1.CB_GlobalClick(Sender: TObject);
begin
 if CB_Global.Checked then flSet(fl_ENABLE,fl_GLOBAL_OPTIMIZATION,0)
 else  flSet(fl_DISABLE,fl_GLOBAL_OPTIMIZATION,0);

end;

procedure TForm1.EXChange(Sender: TObject);
var
 E: Extended;
begin
E:=StrToFloat(EX.Text);
 if RB_VR_SNG.Checked then Form1.X0:=E else
 if RB_VR_Dbl.Checked then Form1.X:=E else
  Form1.X1:=E;

  //STL.Caption:=FloatToStr(Form1.X);
end;


procedure TForm1.EYChange(Sender: TObject);
var
 E: Extended;
begin
E:=StrToFloat(EY.Text);
 if RB_VR_SNG.Checked then Form1.Y0:=E else
 if RB_VR_Dbl.Checked then Form1.Y:=E else
  Form1.Y1:=E;
end;

procedure TForm1.ETChange(Sender: TObject);
var
 E: Extended;
begin
E:=StrToFloat(ET.Text);
 if RB_VR_SNG.Checked then Form1.T0:=E else
 if RB_VR_Dbl.Checked then Form1.T:=E else
  Form1.T1:=E;
end;

procedure TForm1.ENChange(Sender: TObject);
begin
EN.Text:=IntToStr(Trunc(StrToFloat(EN.Text)));
Form1.N:=Trunc(StrToFloat(EN.Text));
end;

procedure TForm1.EIChange(Sender: TObject);
begin
EI.Text:=IntToStr(Trunc(StrToFloat(EI.Text)));
Form1.I:=Trunc(StrToFloat(EI.Text));
end;

procedure TForm1.EKChange(Sender: TObject);
begin
EK.Text:=IntToStr(Trunc(StrToFloat(EK.Text)));
Form1.K:=Trunc(StrToFloat(EK.Text));
end;



end.
