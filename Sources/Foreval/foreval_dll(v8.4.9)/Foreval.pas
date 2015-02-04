unit Foreval;

{******************************************************************************}
{                                                                              }
{               SOREL  (C)CopyRight 1999-2003. Russia                          }
{                                                                              }
{                          Foreval.dll interface unit.                         }
{                               ver. 8.4.7                                     }
{******************************************************************************}


{$DEFINE STRING}
interface


type
TExternalException = procedure ; stdcall;



const
MathDll = 'Foreval.dll';

type
TAddFuncStruct = record
                  addr:  Pointer;
                   Arg:  Cardinal;
              CallType:  Cardinal;
               ArgType:  Cardinal;
           ArgTypeList:  Pointer;
            ClearStack:  Cardinal;
                 Arrow:  Cardinal;
               DeepFPU:  Cardinal;
                Set_ID:  Cardinal;
               Id_Func:  Cardinal;
               SaveReg:  Cardinal;
            CodeInline:  Pointer;
              SizeCode:  Cardinal;
                  end;

type
TAttrib = record
           Adr:   Cardinal;
           RType: Cardinal;
          end;

//fl_SHOW_EXCEPTION       = 99;  //Non-doc. только в полной версии(Window,Dialogs)
const
fl_DISABLE              = 0;
fl_ENABLE               = 1;
fl_AUTO                 = 2;
fl_YES                  = 3;
fl_NO                   = 4;
fl_SYNTAX_EXTENSION     = 10;
fl_VAR_NAME_SHIFT       = 11;
fl_FUNC_NAME_SHIFT      = 12;
fl_CALC_CONST           = 13;
fl_EXTERNAL_EXCEPTION   = 14;
fl_REPLACE_FUNCTION     = 15;
fl_DINAMIC_LOAD         = 16;
fl_SAVE_EAX             = 17;
fl_SAVE_EBX             = 18;
fl_SAVE_ECX             = 19;
fl_SAVE_EDX             = 20;
fl_SAVE_ESP             = 21;
fl_SAVE_EBP             = 22;
fl_SAVE_ESI             = 23;
fl_SAVE_EDI             = 24;
fl_STACK_DEEP           = 25;
fl_SINGLE               = 26;
fl_INTEGER              = 27;
fl_DOUBLE               = 28;
fl_EXTENDED             = 29;
fl_DIFFER               = 30;
fl_DATA_TYPE            = 31;
fl_PARAM_TYPE           = 32;
fl_CORRECT_POWER        = 33;
fl_EXCHANGE_BRANCH      = 34;
fl_GLOBAL_OPTIMIZATION  = 35;
fl_SET_ID               = 36;
fl_CLST                 = 37;
fl_ADDRESS              = 38;
fl_INLINE               = 39;
fl_FUNC_STACK_DEEP      = 40;
fl_FUNC_ID              = 41;
fl_NUM_ARG              = 42;
fl_ARROW                = 43;
fl_ARG_TYPE             = 44;
fl_ARG_TYPE_LIST        = 45;
fl_SAVE_REG             = 46;
fl_CALL_TYPE            = 47;
fl_CLEAR                = 48;
fl_PARAM_LIST           = 49;
fl_VAR_LIST             = 50;
fl_FREE                 = 51;
fl_ADD_FUNC_LIST        = 54;
fl_CMPL_FUNC_LIST       = 55;
fl_CLEAR_NAMES_FUNC     = 56;
fl_EAX                  = 57;
fl_EBX                  = 58;
fl_ECX                  = 59;
fl_EDX                  = 60;
fl_ESP                  = 61;
fl_STRING_TYPE          = 62;
fl_STRING               = 63;
fl_PCHAR                = 64;
fl_WIDE_STRING          = 65;
fl_CLOSE_ARG            = 66;
fl_PACKAGE_COMPILE      = 67;
fl_TRIG_OPTIMIZATION    = 68;






{flAddNewFunction}
fl_MEMORY_EAX           = 100;
fl_MEMORY_EBX           = 101;
fl_MEMORY_ECX           = 102;
fl_MEMORY_EDX           = 103;
fl_MEMORY_STACK_CPU     = 104;
fl_KERNEL_I             = 105;
fl_KERNEL_F             = 106;
fl_KERNEL_FI            = 107;
fl_KERNEL_FF            = 108;
fl_STACK_FPU            = 109;
fl_STACK_CPU            = 110;
fl_INFINITE_EABX        = 111;
fl_INFINITE_EBCX        = 112;
fl_INFINITE_ECDX        = 113;
fl_INFINITE_STACK_CPU   = 114;
fl_RIGHT                = 115;
fl_BACK                 = 116;
fl_UNKNOWN              = 117;





{GetErrorCode}
fl_ACCESS_VIOLATION           = 200;
fl_OUT_OF_MEMORY              = 201;
fl_STACK_OVERFLOW             = 202;
fl_ZERO_DIVIDE                = 203;
fl_INVALID_OPERATION          = 204;
fl_OVERFLOW                   = 205;
fl_UNDERFLOW                  = 206;
fl_INT_OVERFLOW               = 207;
fl_UNKNOWN_SYMBOL             = 208;
fl_MISSING_LEFT_BRACKET       = 209;
fl_MISSING_RIGHT_BRACKET      = 210;
fl_MISSING_OPERATION          = 211;
fl_WRONG_NUMBER_ARGUMENTS     = 212;
fl_MISSING_EXPRESSION         = 213;
fl_UNKNOWN_FUNCTION           = 214;
fl_ERROR_AT_ADDITION_FUNCTION = 215;
fl_NONEXISTENT_FUNCTION       = 216;



{Get}
fl_VERSION                         = 301;
fl_MAJOR                           = 302;
fl_MINOR                           = 303;
fl_RELEASE                         = 304;
fl_ABOUT                           = 305;
fl_AUTHOR                          = 306;
fl_EXCHANGE_BRANCH_STACK_DEEP      = 316;
fl_EXCHANGE_BRANCHE_NUM            = 317;
fl_DINAMIC_LOAD_STACK_DEEP         = 318;
fl_DINAMIC_LOAD_NUM                = 319;
fl_DINAMIC_LOAD_OVFL               = 320;
fl_COMPILE_STACK_DEEP              = 321;
fl_COMPILE_OVFL                    = 322;
fl_REPLACE_FUNCTION_NUM            = 323;
fl_CALC_CONST_NUM                  = 324;
fl_USE_EAX                         = 325;
fl_USE_EBX                         = 326;
fl_USE_ECX                         = 327;
fl_USE_EDX                         = 328;
fl_USE_ESP                         = 329;
fl_USE_EBP                         = 330;
fl_USE_ESI                         = 331;
fl_USE_EDI                         = 332;
fl_MAX_REPLACE_LEVEL               = 333;
fl_LENGTH_CODE                     = 334;
fl_PACKAGE_COMPILE_LAST_ADDR       = 335;


{Internal Function}
 C_LN =          16;
 C_EXP =         17;
 C_LOG2 =        18;
 C_LOG10 =       19;
 C_COTAN =       37;
 C_ARCSIN =      38;
 C_ARCCOS =      39;
 C_ARCTAN =      40;
 C_ARCCOTAN =    41;
 C_SINH =        42;
 C_COSH =        43;
 C_TANH =        44;
 C_COTANH =      45;
 C_ARCSINH =     46;
 C_ARCCOSH =     47;
 C_ARCTANH =     48;
 C_ARCCOTANH =   49;
 C_LOGN =        52;
 C_FPWR =        53;
 C_FACT =        54;
 C_IPWR =        55;
 C_POWER =       58;
 C_ROOT =        59;
 C_FROOT =       60;
 C_IROOT =       61;



 //реальные шаблоны функций:
 {procedure  flSet(Mode,Value1,Value2: Cardinal); stdcall; external MathDll;
 procedure  flCompile(Func: Pointer; Ptr: Pointer; var Addr: Pointer);         stdcall;  external MathDll;
 procedure  flPerform(act,subj: Cardinal);                       stdcall;external MathDll;
 procedure  flSetFunction(Name: Pointer; FAdr: Pointer; var ID: Cardinal);      stdcall; external MathDll;
 procedure  flAddNameFunction(Code: Cardinal; NName: Pointer);              stdcall; external MathDll;
 procedure  flGetErrorString(var S: Pointer);                     stdcall;external MathDll;
 procedure  flGetErrorCode(var ECode: Cardinal); stdcall;    external MathDll;
 procedure  flSetVar(Name: PChar;  ExAddr: Pointer; VType: Cardinal);      stdcall; external MathDll;
 procedure  flSetParam(Name: Pointer; Ptr: Pointer; VType: Cardinal);             stdcall; external MathDll;
 procedure  flGet(What,Func: Cardinal; var Get: Cardinal);               stdcall; external MathDll;}


 {$IFDEF STRING}
 procedure  flSet(Mode,Value1,Value2: Cardinal); stdcall; external MathDll;
 procedure  flCompile(Func: String; Ptr: Pointer; var Addr: Pointer);         stdcall;  external MathDll;
 procedure  flPerform(act,subj: Cardinal);                       stdcall;external MathDll;
 procedure  flSetFunction(Name: String; FAdr: Pointer; var ID: Cardinal);      stdcall; external MathDll;
 procedure  flAddNameFunction(Code: Cardinal; NName: String);              stdcall; external MathDll;
 procedure  flGetErrorString(var S: String);                     stdcall;external MathDll;
 procedure  flGetErrorCode(var ECode: Cardinal); stdcall;    external MathDll;
 procedure  flSetVar(Name: String;  ExAddr: Pointer; VType: Cardinal);      stdcall; external MathDll;
 procedure  flSetParam(Name: String; Ptr: Pointer; VType: Cardinal);             stdcall; external MathDll;
 procedure  flGet(What,Func: Cardinal; var Get: Cardinal);               stdcall; external MathDll;
 {$ELSE}
 procedure  flSet(Mode,Value1,Value2: Cardinal); stdcall; external MathDll;
 procedure  flCompile(Func: PChar; Ptr: Pointer; var Addr: Pointer);         stdcall;  external MathDll;
 procedure  flPerform(act,subj: Cardinal);                       stdcall;external MathDll;
 procedure  flSetFunction(Name: PChar; FAdr: Pointer; var ID: Cardinal);      stdcall; external MathDll;
 procedure  flAddNameFunction(Code: Cardinal; NName: PChar);              stdcall; external MathDll;
 procedure  flGetErrorString(var S: PChar);                     stdcall;external MathDll;
 procedure  flGetErrorCode(var ECode: Cardinal); stdcall;    external MathDll;
 procedure  flSetVar(Name: PChar;  ExAddr: Pointer; VType: Cardinal);      stdcall; external MathDll;
 procedure  flSetParam(Name: PChar; Ptr: Pointer; VType: Cardinal);             stdcall; external MathDll;
 procedure  flGet(What,Func: Cardinal; var Get: Cardinal);               stdcall; external MathDll;
 {$ENDIF}




 //internal:
 function   CalcFunction(Func: Pointer): double;


implementation

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


  function CalcFunction(Func: Pointer): double;
  asm
   Call Func
  end;



end.






