unit Lib;

{******************************************************************************}
{                                                                              }
{                      SOREL  (C)CopyRight 1999-2003. Russia.                  }
{                                                                              }
{                       Lib - интерфейс Foreval.dll                            }
{                           ver. 8.4.6 (R116)                                  }
{******************************************************************************}

{$DEFINE TEXTOUT}
interface
uses
Foreval_HD,CommandC,SysUtils;
const _Single = 1;
const _Double = 2;
//const _Extended = 3;
const _Integer = 4;
const _Differ =  5;

type  TCompFunc = record
                    Func: TFunction;
              XchBrSDeep: Integer;
               XchBrNXch: Integer;
            DinLoadSDeep: Integer;
             DinLoadNMem: Integer;
         DinLoadOverFlow: Integer;
               CmplSDeep: Integer;
            CmplOverFlow: Integer;
            CopyStackXch: Integer;
               CalcConst: Integer;
         MaxReplaceLevel: Integer;
                 end;


type
TAttribL = record
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
 C_SQR     =     14;
 C_SQRT =        15;
 C_LN =          16;
 C_EXP =         17;
 C_LOG2 =        18;
 C_LOG10 =       19;
 C_IPWR3 =       20;
 C_IPWR4 =       21;
 C_IPWR5 =       22;
 C_IPWR6 =       23;
 C_IPWR7 =       24;
 C_IPWR8 =       25;
 C_IPWR9 =       26;
 C_IPWR10 =      27;
 C_IPWR11 =      28;
 C_IPWR12 =      29;
 C_IPWR13 =      30;
 C_IPWR14 =      31;
 C_IPWR15 =      32;
 C_IPWR16 =      33;
 C_SIN =         34;
 C_COS =         35;
 C_TAN =         36;
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
 C_ABS =         50;
 C_TRUNC =       51;
 C_LOGN =        52;
 C_FPWR =        53;
 C_FACT =        54;
 C_IPWR =        55;
 C_IPWRSGN =     56;
 C_I2PWR =       57;
 C_POWER =       58;
 C_ROOT =        59;
 C_FROOT =       60;
 C_IROOT =       61;
 C_IPWR3N =      62;
 C_IPWR4N =      63;
 C_IPWR5N =      64;
 C_IPWR6N =      65;
 C_IPWR7N =      66;
 C_IPWR8N =      67;
 C_IPWR9N =      68;
 C_IPWR10N =     69;
 C_IPWR11N =     70;
 C_IPWR12N =     71;
 C_IPWR13N =     72;
 C_IPWR14N =     73;
 C_IPWR15N =     74;
 C_IPWR16N =     75;



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
PFloatType = Foreval_HD.PFloatType;   {?}
type
TFloatType = Foreval_HD.TFloatType;   {?}
type
PIntegType = Foreval_HD.PIntegType;   {?}
type
TArrayS = Foreval_HD.TArrayS;   {?}
type
TSetFunction = record
                Func: TFunction;
                Addr: TAddress;
               end;


type
TAddress = Foreval_HD.TAddress;


 type TForevalDll = class(TForevalH) end;



 procedure FreeCmplFuncList;
 procedure FreeFunction(Func: Cardinal);





 procedure  flSet(Mode,Value1,Value2: Integer);  stdcall;
 procedure  flCompile(Expr: {$IFDEF TEXTOUT}String{$ELSE}Pointer{$ENDIF}; Ptr: Pointer; var Addr: Pointer);         stdcall;
 procedure  flPerform(act,subj: Cardinal);                       stdcall;
 procedure  flSetFunction(Name: {$IFDEF TEXTOUT}String{$ELSE}Pointer{$ENDIF}; FAdr: Pointer; var ID: Cardinal);      stdcall;
 procedure  flAddNameFunction(Code: Cardinal; NName: {$IFDEF TEXTOUT}String{$ELSE}Pointer{$ENDIF});              stdcall;
 procedure  flGetErrorString(var S:{$IFDEF TEXTOUT}String{$ELSE}Pointer{$ENDIF});                     stdcall;
 procedure  flGetErrorCode(var ECode: Cardinal); stdcall;
 procedure  flSetVar(Name: {$IFDEF TEXTOUT}String{$ELSE}Pointer{$ENDIF};  ExAddr: Pointer; VType: Cardinal);      stdcall;
 procedure  flSetParam(Name: {$IFDEF TEXTOUT}String{$ELSE}Pointer{$ENDIF}; Ptr: Pointer; VType: Cardinal);             stdcall;
 procedure  flGet(What,Func: Cardinal; var Get: Cardinal);               stdcall;








var
 DF: array of TCompFunc;
 Foreval: TForevalDll;
 ExtLibException: TExternalException; //внешний обработчик исключений
 _STRINGTYPE: Integer;
 PkgData: TArrayPkg;
 PkgExpr: String;
 PkgLastAddr: Cardinal;
 F_PkgCmpl: Boolean;






implementation



function PtrToStr(P: Pointer): String;
var
S: String;
begin
 if _STRINGTYPE = fl_STRING then S:=String(P)
 else
 if  _STRINGTYPE = fl_PCHAR then S:=String(PChar(P))
 else
 if  _STRINGTYPE = fl_WIDE_STRING then S:=WideCharToString(P);

 PtrToStr:=Copy(S,1,Length(S));
end;


function StrToPtr(S: String): Pointer;
begin
 if _STRINGTYPE = fl_STRING then StrToPtr:=Pointer(S)
 else
 if _STRINGTYPE = fl_PCHAR  then StrToPtr:=PChar(S)
 else
 if _STRINGTYPE = fl_WIDE_STRING then begin StrToPtr:=PWideChar(WideString(S)); end;
end;


procedure DeleteSpace(S: String; var S1: String);
var i: Integer;
begin
i:=Length(S);

 while i >= 1 do
 begin
    if S[i] = ' ' then
   begin
    Delete(S,i,1);
   end;
  dec(i);
 end;

S1:=Copy(S,1,Length(S));
end;



procedure FreeCmplFuncList;
var
i: Integer;
begin
For i:=1 to Length(DF)-1 do
 begin
  if DF[i].Func.ICode <> 0 then
  Foreval.FreeExtFunc(DF[i].Func);
 end;
end;


procedure FreeFunction(Func: Cardinal);
label 1;
var
i: Integer;
begin
 //скомпилир. ф-и€
 For i:=0 to High(DF) do
 begin
  if Func = DF[i].Func.ICode then
  begin
   Foreval.FreeExtFunc(DF[i].Func);
   DF[i].Func.ICode:=0;
   goto 1;
  end;
 end;
 //внутренн€€ ф-и€
  Foreval.DeleteFunc:=Func;

1:
end;


procedure PackageCompile;
var
CFunc: TFunction;
Attr: TAttrib;
begin
 Attr.Adr:=0;
 Attr.RType:=0;
 Attr.Shift:=0;
 Delete(PkgExpr,Length(PkgExpr),1); //& - последний
 Foreval.PackageCompile:=True;     //сбрасываетс€ при разборе в SetExtExpression
 Foreval.SetPkgData(PkgData);
 Foreval.SetExtExpression(PkgExpr,Attr,CFunc);

 if CFunc.ICode <> 0 then
 begin
  SetLength(DF,Length(DF)+1);
  DF[High(DF)].Func:=CFunc;
  DF[High(DF)].XchBrSDeep:=Foreval.XchBrSDeep;
  DF[High(DF)].XchBrNXch:=Foreval.XchBrNXch;
  DF[High(DF)].DinLoadSDeep:=Foreval.DinLoadSDeep;
  DF[High(DF)].DinLoadNMem:=Foreval.DinLoadNMem;
  if Foreval.DinLoadOverFlow = True then DF[High(DF)].DinLoadOverFlow:=1
  else DF[High(DF)].DinLoadOverFlow:=0;
  DF[High(DF)].CmplSDeep:=Foreval.CmplMaxStack;
  if Foreval.CmplOverFlow = True then
  DF[High(DF)].CmplOverFlow:=1
  else DF[High(DF)].CmplOverFlow:=0;
  DF[High(DF)].CopyStackXch:=Foreval.CopyStackXch;
  DF[High(DF)].CalcConst:=Foreval.CalcConst;
  DF[High(DF)].MaxReplaceLevel:=Foreval.MaxReplaceLevel;
 end;

 PkgLastAddr:=CFunc.ICode;
 F_PkgCmpl:=False;
 PkgExpr:='';
 PkgData:=nil;
end;


procedure flSet(Mode,Value1,Value2: Integer);
begin
if mode = fl_ENABLE then
begin
  if value1 =  fl_SYNTAX_EXTENSION    then Foreval.SyntaxExtension:=True   else
  if value1 =  fl_EXTERNAL_EXCEPTION  then Foreval.ExternalException:=True else
  //if value1 =  fl_SHOW_EXCEPTION      then Foreval.ShowException:=True     else
  if value1 =  fl_VAR_NAME_SHIFT      then Foreval.VarShift:=True          else
  if value1 =  fl_FUNC_NAME_SHIFT     then Foreval.FuncShift:=True         else
  if value1 =  fl_CALC_CONST          then Foreval.CalcConstant:=True      else
  if value1 =  fl_SAVE_EAX            then Foreval.SetReg(1,1)             else
  if value1 =  fl_SAVE_EBX            then Foreval.SetReg(2,1)             else
  if value1 =  fl_SAVE_ECX            then Foreval.SetReg(3,1)             else
  if value1 =  fl_SAVE_EDX            then Foreval.SetReg(4,1)             else
  if value1 =  fl_SAVE_ESP            then Foreval.SetReg(5,1)             else
  if value1 =  fl_SAVE_EBP            then Foreval.SetReg(6,1)             else
  if value1 =  fl_SAVE_ESI            then Foreval.SetReg(7,1)             else
  if value1 =  fl_SAVE_EDI            then Foreval.SetReg(8,1)             else
  if value1 =  fl_CORRECT_POWER       then Foreval.CorrectIPWR:=1          else
  if value1 =  fl_DINAMIC_LOAD        then Foreval.DinamicLoadOptimization:=1 else
  if value1 =  fl_EXCHANGE_BRANCH     then Foreval.TreeOptimization:=1     else
  if value1 =  fl_GLOBAL_OPTIMIZATION then Foreval.GlobalOptimization:=True else
  if value1 =  fl_SET_ID              then Foreval.SetF(7,Value1,1)        else
  if value1 =  fl_CLST                then Foreval.SetF(10,Value1,1)       else
  if value1 =  fl_CLOSE_ARG           then Foreval.CloseArg:=True          else
  if value1 =  fl_PACKAGE_COMPILE     then F_PkgCmpl:=True                 else
  if value1 =  fl_TRIG_OPTIMIZATION   then Foreval.SpecTrigOptim:=1;

end
else
if mode = fl_DISABLE then
begin
  if value1 =  fl_SYNTAX_EXTENSION    then Foreval.SyntaxExtension:=False   else
  if value1 =  fl_EXTERNAL_EXCEPTION  then Foreval.ExternalException:=False else
  //if value1 =  fl_SHOW_EXCEPTION      then Foreval.ShowException:=False     else
  if value1 =  fl_VAR_NAME_SHIFT      then Foreval.VarShift:=False          else
  if value1 =  fl_FUNC_NAME_SHIFT     then Foreval.FuncShift:=False         else
  if value1 =  fl_CALC_CONST          then Foreval.CalcConstant:=False      else
  if value1 =  fl_SAVE_EAX            then Foreval.SetReg(1,0)              else
  if value1 =  fl_SAVE_EBX            then Foreval.SetReg(2,0)              else
  if value1 =  fl_SAVE_ECX            then Foreval.SetReg(3,0)              else
  if value1 =  fl_SAVE_EDX            then Foreval.SetReg(4,0)              else
  if value1 =  fl_SAVE_ESP            then Foreval.SetReg(5,0)             else
  if value1 =  fl_SAVE_EBP            then Foreval.SetReg(6,0)             else
  if value1 =  fl_SAVE_ESI            then Foreval.SetReg(7,0)             else
  if value1 =  fl_SAVE_EDI            then Foreval.SetReg(8,0)             else
  if value1 =  fl_CORRECT_POWER       then Foreval.CorrectIPWR:=0           else
  if value1 =  fl_DINAMIC_LOAD        then Foreval.DinamicLoadOptimization:=0 else
  if value1 =  fl_EXCHANGE_BRANCH     then Foreval.TreeOptimization:=0      else
  if value1 =  fl_GLOBAL_OPTIMIZATION then Foreval.GlobalOptimization:=False else
  if value1 =  fl_SET_ID              then Foreval.SetF(7,Value1,0)          else
  if value1 =  fl_CLST                then Foreval.SetF(10,Value1,0)         else
  if value1 =  fl_CLOSE_ARG           then Foreval.CloseArg:=False           else
  if value1 =  fl_PACKAGE_COMPILE     then PackageCompile                    else
  if value1 =  fl_TRIG_OPTIMIZATION   then Foreval.SpecTrigOptim:=0;

end
else
if mode = fl_STRING_TYPE then
begin
 case Value1 of
 fl_STRING:      _STRINGTYPE:=Value1;
 fl_PCHAR:       _STRINGTYPE:=Value1;
 fl_WIDE_STRING: _STRINGTYPE:=Value1;
 end;
end
else
if mode = fl_AUTO then
begin
  if value1 =  fl_DINAMIC_LOAD        then Foreval.DinamicLoadOptimization:=2 else
  if value1 =  fl_EXCHANGE_BRANCH     then Foreval.TreeOptimization:=2;
end
else
if  mode =  fl_REPLACE_FUNCTION     then Foreval.SetLevelReplace(value1)
else
if  mode =  fl_STACK_DEEP        then
begin
 if (value1 >= 1) and (value1 <= 8) then
 begin
  Foreval.SetStackDeep(value1);
  Foreval.SaveInStack:=True;
 end
 else
 if value1 = 0 then Foreval.SaveInStack:=False;
end
else
if  mode = fl_PARAM_TYPE then
    case value1 of
    fl_SINGLE:    Foreval.ParamType:=_SINGLE;
    fl_DOUBLE:    Foreval.ParamType:=_DOUBLE;
    fl_EXTENDED:  Foreval.ParamType:=_EXTENDED;
    end
else
if  mode = fl_DATA_TYPE then
    case value1 of
    fl_SINGLE:    Foreval.DataType:=_SINGLE;
    fl_DOUBLE:    Foreval.DataType:=_DOUBLE;
    fl_EXTENDED:  Foreval.DataType:=_EXTENDED;
    end
else
if mode = fl_EXTERNAL_EXCEPTION then Foreval.ExtException:=TExternalException(value1)
else
if mode = fl_ADDRESS then Foreval.SetF(2,Value1,Value2)
else
if mode = fl_INLINE then
begin
 if Value2 = 0 then
 begin
  Foreval.SetF(3,Value1,0);
 end
 else
 begin
  Foreval.SetF(3,Value1,1);
  Foreval.SetF(4,Value1,Value2);
 end
end
else
if mode = fl_FUNC_STACK_DEEP then
begin
 if Value2 = fl_UNKNOWN then Value2:=-1;
 Foreval.SetF(5,Value1,Value2);
end
else
if mode = fl_FUNC_ID         then Foreval.SetF(6,Value1,Value2)
else
if mode = fl_NUM_ARG         then Foreval.SetF(8,Value1,Value2)
else
if mode = fl_ARROW           then
begin
 if Value2 = fl_RIGHT then
  Foreval.SetF(9,Value1,0)
 else
 if Value2 = fl_BACK then
  Foreval.SetF(9,Value1,1);
end
else
if mode = fl_ARG_TYPE then
begin
 case Value2 of
  fl_SINGLE:   Foreval.SetF(11,Value1,_Single);
  fl_DOUBLE:   Foreval.SetF(11,Value1,_Double);
  fl_EXTENDED: Foreval.SetF(11,Value1,_Extended);
  fl_INTEGER:  Foreval.SetF(11,Value1,_Integer);
  fl_DIFFER:   Foreval.SetF(11,Value1,_Differ);
 end;
end
else
if mode = fl_ARG_TYPE_LIST then Foreval.SetF(12,Value1,Value2)
else
if mode = fl_SAVE_REG       then Foreval.SetF(13,Value1,Value2)
else
if mode = fl_CALL_TYPE then
begin
 case Value2 of
  fl_MEMORY_EAX:                      Foreval.SetF(14,Value1,-3);
  fl_MEMORY_EBX:                      Foreval.SetF(14,Value1,-4);
  fl_MEMORY_ECX:                      Foreval.SetF(14,Value1,-5);
  fl_MEMORY_EDX:                      Foreval.SetF(14,Value1,-6);
  fl_MEMORY_STACK_CPU:                Foreval.SetF(14,Value1,-7);
  fl_STACK_FPU:                       Foreval.SetF(14,Value1,-8);
  fl_STACK_CPU:                       Foreval.SetF(14,Value1,-10);
  fl_INFINITE_EABX:                   Foreval.SetF(14,Value1,-11);
  fl_INFINITE_EBCX:                   Foreval.SetF(14,Value1,-12);
  fl_INFINITE_ECDX:                   Foreval.SetF(14,Value1,-13);
  fl_INFINITE_STACK_CPU:              Foreval.SetF(14,Value1,-14);
  fl_KERNEL_I:                        Foreval.SetF(14,Value1,1);
  fl_KERNEL_F:                        Foreval.SetF(14,Value1,2);
  fl_KERNEL_FI:                       Foreval.SetF(14,Value1,3);
  fl_KERNEL_FF:                       Foreval.SetF(14,Value1,4);
 end;
end;
end;



procedure  flPerform(act,subj: Cardinal);
begin
  if act = fl_CLEAR then
  begin
   case subj of
    fl_PARAM_LIST: Foreval.ClearParam;
    fl_VAR_LIST:   Foreval.ClearVar;
   end
  end
  else
  if act = fl_FREE then
  begin
   case subj of
    fl_PARAM_LIST:     Foreval.FreeParam;
    fl_VAR_LIST:       Foreval.FreeVar;
    fl_ADD_FUNC_LIST:  Foreval.FreeAddFunction;
    fl_CMPL_FUNC_LIST: FreeCmplFuncList;
    else
    FreeFunction(subj);
   end;
  end
  else
  if act = fl_CLEAR_NAMES_FUNC then Foreval.ClearNameFunc:=subj;
end;


procedure flCompile(Expr: {$IFDEF TEXTOUT}String{$ELSE}Pointer{$ENDIF};  Ptr: Pointer; var Addr: Pointer);
var
CFunc: TFunction;
PAtr,HPAtr: ^TAttrib;
Atr: TAttrib;
Func: String;
begin
{$IFDEF TEXTOUT}
Func:=Expr;
{$ELSE}
Func:=PtrToStr(Expr);
{$ENDIF}
DeleteSpace(Func,Func);

new(PAtr);
 if Ptr = nil then
 begin
  PAtr^.Adr:=0;
  PAtr^.RType:=0;
  PAtr^.Shift:=0;
 end
 else
 begin
  HPAtr:=Ptr;
  case HPAtr^.Adr of
   fl_EAX:        PAtr^.Adr:=1;
   fl_EBX:        PAtr^.Adr:=2;
   fl_ECX:        PAtr^.Adr:=3;
   fl_EDX:        PAtr^.Adr:=4;
   fl_ESP:        PAtr^.Adr:=5;
  else
   PAtr^.Adr:=HPAtr.Adr;
  end;

  case HPAtr^.RType of
   fl_SINGLE:         PAtr^.RType:=_Single;
   fl_INTEGER:        PAtr^.RType:=_Integer;
   fl_DOUBLE:         PAtr^.RType:=_Double;
   fl_EXTENDED:       PAtr^.RType:=_Extended;
  end;

   PAtr^.Shift:=HPAtr^.Shift;
 end;

if F_PkgCmpl = True then
begin
  PkgExpr:=PkgExpr+Func+'&';
  SetLength(PkgData,Length(PkgData)+1);
  PkgData[High(PkgData)].Adr:=PAtr^.Adr;
  PkgData[High(PkgData)].RType:=PAtr^.RType;
  PkgData[High(PkgData)].Shift:=PAtr^.Shift;
end
else
begin
 Foreval.SetExtExpression(Func,PAtr^,CFunc);

 if CFunc.ICode <> 0 then
 begin
  SetLength(DF,Length(DF)+1);
  DF[High(DF)].Func:=CFunc;
  DF[High(DF)].XchBrSDeep:=Foreval.XchBrSDeep;
  DF[High(DF)].XchBrNXch:=Foreval.XchBrNXch;
  DF[High(DF)].DinLoadSDeep:=Foreval.DinLoadSDeep;
  DF[High(DF)].DinLoadNMem:=Foreval.DinLoadNMem;
  if Foreval.DinLoadOverFlow = True then DF[High(DF)].DinLoadOverFlow:=1
  else DF[High(DF)].DinLoadOverFlow:=0;
  DF[High(DF)].CmplSDeep:=Foreval.CmplMaxStack;
  if Foreval.CmplOverFlow = True then
  DF[High(DF)].CmplOverFlow:=1
  else DF[High(DF)].CmplOverFlow:=0;
  DF[High(DF)].CopyStackXch:=Foreval.CopyStackXch;
  DF[High(DF)].CalcConst:=Foreval.CalcConst;
  DF[High(DF)].MaxReplaceLevel:=Foreval.MaxReplaceLevel;
  Addr:=Pointer(CFunc.ICode);
 end;

end;

PAtr:=nil;
end;


procedure flGetErrorCode(var ECode: Cardinal);
begin
ECode:=0;
 case  Foreval.ErrorCode of
   E_ZeroDivide:                        ECode:=fl_ZERO_DIVIDE;
   E_InvalidOp:                         ECode:=fl_INVALID_OPERATION;
   E_OverFlow:                          ECode:=fl_OVERFLOW;
   E_UnderFlow:                         ECode:=fl_UNDERFLOW;
   E_IntOverFlow:                       ECode:=fl_INT_OVERFLOW;
   E_AccessViolation:                   ECode:=fl_ACCESS_VIOLATION;
   E_OutOfMemory:                       ECode:=fl_OUT_OF_MEMORY;
   E_StackOverFlow:                     ECode:=fl_STACK_OVERFLOW;
   E_UNKNOWN_SYMBOL:                    ECode:=fl_UNKNOWN_SYMBOL;
   E_MISSING_BRACKET_LEFT:              ECode:=fl_MISSING_LEFT_BRACKET;
   E_MISSING_BRACKET_RIGHT:             ECode:=fl_MISSING_RIGHT_BRACKET;
   E_INCOINCIDENCE_NUMBER_ARGUMENTS:    ECode:=fl_WRONG_NUMBER_ARGUMENTS;
   E_MISSING_OPERATION:                 ECode:=fl_MISSING_OPERATION;
   E_MISSING_EXPRESSION:                ECode:=fl_MISSING_EXPRESSION;
   E_UNKNOWN_FUNCTION:                  ECode:=fl_UNKNOWN_FUNCTION;
   E_ERROR_AT_ADDITION_FUNCTION:        ECode:=fl_ERROR_AT_ADDITION_FUNCTION;
   E_NONEXISTENT_FUNCTION:              ECode:=fl_NONEXISTENT_FUNCTION;
  end;
end;





procedure flSetVar(Name: {$IFDEF TEXTOUT}String{$ELSE}Pointer{$ENDIF};  ExAddr: Pointer; VType: Cardinal);
begin
case VType of
fl_SINGLE:   Foreval.SetNewVar({$IFDEF TEXTOUT}Name{$ELSE}PtrToStr(Name){$ENDIF},Cardinal(ExAddr),_SINGLE);
fl_INTEGER:  Foreval.SetNewVar({$IFDEF TEXTOUT}Name{$ELSE}PtrToStr(Name){$ENDIF},Cardinal(ExAddr),_INTEGER);
fl_DOUBLE:   Foreval.SetNewVar({$IFDEF TEXTOUT}Name{$ELSE}PtrToStr(Name){$ENDIF},Cardinal(ExAddr),_DOUBLE);
fl_EXTENDED: Foreval.SetNewVar({$IFDEF TEXTOUT}Name{$ELSE}PtrToStr(Name){$ENDIF},Cardinal(ExAddr),_EXTENDED);
end;

end;



procedure flSetParam(Name: {$IFDEF TEXTOUT}String{$ELSE}Pointer{$ENDIF}; Ptr: Pointer; VType: Cardinal);
var
T: Extended;
begin
T:=0;
case VType of
  fl_SINGLE:   T:=Single(Ptr^);
  fl_INTEGER:  T:=Integer(Ptr^);
  fl_DOUBLE:   T:=Double(Ptr^);
  fl_EXTENDED: T:=Extended(Ptr^);
end;
Foreval.Parameter[{$IFDEF TEXTOUT}Name{$ELSE}PtrToStr(Name){$ENDIF}]:=T;
end;






procedure flSetFunction(Name: {$IFDEF TEXTOUT}String{$ELSE}Pointer{$ENDIF}; FAdr: Pointer; var ID: Cardinal);
label endp;
var
Func: TAdditionalFunc;
FuncStruct: TAddFuncStruct;
i,ECode: Integer;
TypeL: TArrayI;
TypeC: TCode;
PF: ^TAddFuncStruct;
Arg1,Arg2: Cardinal;
begin
ECode:=0;
PF:=FAdr;
FuncStruct:=PF^;

try
Func.Name:=Copy({$IFDEF TEXTOUT}Name{$ELSE}PtrToStr(Name){$ENDIF},1,Length({$IFDEF TEXTOUT}Name{$ELSE}PtrToStr(Name){$ENDIF}));
Func.Arg:=FuncStruct.Arg;
Func.Id_Func:=FuncStruct.Id_Func;
Func.NST:=FuncStruct.DeepFPU;
Func.SaveReg:=FuncStruct.SaveReg;
Func.CLST:=0;
Func.Arrow:=0;
Func.Set_ID:=0;

if (FuncStruct.Addr = nil) and (FuncStruct.CodeInline <> nil) and (FuncStruct.SizeCode > 0) then
begin
 Func.addr:=nil;
 Func.inl:=1;
 SetLength(Func.inlCode,FuncStruct.SizeCode);
 TypeC:=TCode(FuncStruct.CodeInline);
 for i:=0 to FuncStruct.SizeCode-1 do
 begin
  Func.inlCode[i]:=TypeC[i];
 end;
end
else
if FuncStruct.Addr <> nil then
begin
 Func.addr:=FuncStruct.Addr;
 Func.inl:=0;
 Func.inlCode:=nil;
end;

if (Func.Addr = nil) and (Func.inl = 0) then  ECode:=E_ERROR_AT_ADDITION_FUNCTION;


if FuncStruct.DeepFPU = fl_UNKNOWN then Func.NST:=-1
else
if FuncStruct.DeepFPU > 8 then ECode:=E_ERROR_AT_ADDITION_FUNCTION;


if FuncStruct.ClearStack = fl_ENABLE then  Func.CLST:=1
 else
 if FuncStruct.ClearStack = fl_DISABLE then Func.CLST:=0
 else
 if (FuncStruct.CallType = fl_MEMORY_STACK_CPU) or (FuncStruct.CallType = fl_STACK_CPU) or
    (FuncStruct.CallType = fl_INFINITE_STACK_CPU)
    then ECode:=E_ERROR_AT_ADDITION_FUNCTION;



if FuncStruct.Arrow = fl_RIGHT then  Func.Arrow:=0
 else
 if FuncStruct.Arrow = fl_BACK then Func.Arrow:=1
 else
 if (FuncStruct.CallType = fl_STACK_CPU) and (FuncStruct.Arg > 1)
 then  ECode:=E_ERROR_AT_ADDITION_FUNCTION;



if  FuncStruct.Set_ID = fl_Enable then Func.Set_ID:=1
 else
 if  FuncStruct.Set_ID = fl_Disable then Func.Set_ID:=0
 else
 if ((FuncStruct.CallType <> fl_KERNEL_I) and (FuncStruct.CallType <> fl_KERNEL_F) and
    (FuncStruct.CallType <> fl_KERNEL_FI) and (FuncStruct.CallType <> fl_KERNEL_FF))
     then ECode:=E_ERROR_AT_ADDITION_FUNCTION;


if ((FuncStruct.CallType <> fl_KERNEL_I) and (FuncStruct.CallType <> fl_KERNEL_F) and
   (FuncStruct.CallType <> fl_KERNEL_FI) and (FuncStruct.CallType <> fl_KERNEL_FF)) then
begin
 case FuncStruct.ArgType of
  fl_SINGLE:   Func.ArgType:=_Single;
  fl_DOUBLE:   Func.ArgType:=_Double;
  fl_EXTENDED: Func.ArgType:=_Extended;
  fl_INTEGER:  Func.ArgType:=_Integer;
  //fl_DIFFER:   Func.ArgType:=_Differ;
 else
 if (FuncStruct.ArgType = fl_DIFFER) or (FuncStruct.ArgTypeList <> nil) then
    Func.ArgType:=_Differ
 else
  ECode:=E_ERROR_AT_ADDITION_FUNCTION;
 end;
 if Func.inl = 1 then  ECode:=E_ERROR_AT_ADDITION_FUNCTION;
end;


if (FuncStruct.ArgType = fl_DIFFER) or (FuncStruct.ArgTypeList <> nil) then
begin
 Func.ArgType:=_Differ;
 SetLength(Func.ArgTypeList,FuncStruct.Arg);
 TypeL:=TArrayI(FuncStruct.ArgTypeList);
 for i:=0 to FuncStruct.Arg-1 do
  case TypeL[i] of
   fl_INTEGER:   Func.ArgTypeList[i]:=_Integer;
   fl_DOUBLE:    Func.ArgTypeList[i]:=_Double;
   fl_EXTENDED:  Func.ArgTypeList[i]:=_Extended;
   fl_SINGLE:   Func.ArgTypeList[i]:=_Single;
  else
   ECode:=E_ERROR_AT_ADDITION_FUNCTION
  end;
end;


if ((FuncStruct.CallType = fl_INFINITE_EABX) or (FuncStruct.CallType = fl_INFINITE_EBCX) or
   (FuncStruct.CallType = fl_INFINITE_ECDX) or (FuncStruct.CallType = fl_INFINITE_STACK_CPU)) then
   begin
     case FuncStruct.ArgType of
       fl_SINGLE:  ;
       fl_DOUBLE:   ;
       fl_EXTENDED: ;
       fl_INTEGER:  ;
     else
     ECode:=E_ERROR_AT_ADDITION_FUNCTION;
     end;
   end;


if FuncStruct.CallType = fl_MEMORY_EAX               then Func.FType:=-3
else
if FuncStruct.CallType = fl_MEMORY_EBX               then Func.FType:=-4
else
if FuncStruct.CallType = fl_MEMORY_ECX               then Func.FType:=-5
else
if FuncStruct.CallType = fl_MEMORY_EDX               then Func.FType:=-6
else
if FuncStruct.CallType = fl_MEMORY_STACK_CPU         then Func.FType:=-7
else
if FuncStruct.CallType = fl_STACK_FPU                then Func.FType:=-8
else
if FuncStruct.CallType = fl_STACK_CPU                then Func.FType:=-10
else
if FuncStruct.CallType = fl_INFINITE_EABX            then Func.FType:=-11
else
if FuncStruct.CallType = fl_INFINITE_EBCX            then Func.FType:=-12
else
if FuncStruct.CallType = fl_INFINITE_ECDX            then Func.FType:=-13
else
if FuncStruct.CallType = fl_INFINITE_STACK_CPU       then Func.FType:=-14
else
if FuncStruct.CallType = fl_KERNEL_I                 then Func.FType:=1
else
if FuncStruct.CallType = fl_KERNEL_F                 then Func.FType:=2
else
if FuncStruct.CallType = fl_KERNEL_FI                then Func.FType:=3
else
if FuncStruct.CallType = fl_KERNEL_FF                then Func.FType:=4
else
ECode:=E_ERROR_AT_ADDITION_FUNCTION;

if ((FuncStruct.CallType = fl_KERNEL_I) or (FuncStruct.CallType = fl_KERNEL_F) or
   (FuncStruct.CallType = fl_KERNEL_FI) or (FuncStruct.CallType = fl_KERNEL_FF))  then
   begin
    if (FuncStruct.CallType = fl_KERNEL_I) or (FuncStruct.CallType = fl_KERNEL_F) then
     Func.Arg:=1
    else
    if (FuncStruct.CallType = fl_KERNEL_FI) or (FuncStruct.CallType = fl_KERNEL_FF) then
     Func.Arg:=2;
    if FuncStruct.DeepFPU = fl_UNKNOWN then ECode:=E_ERROR_AT_ADDITION_FUNCTION;
   end;





if (FuncStruct.CallType = fl_STACK_FPU)  and
   ((FuncStruct.Arg > 8) or (FuncStruct.Arg < 1))  then
   ECode:=E_ERROR_AT_ADDITION_FUNCTION;

except
on E:  EAccessViolation do ECode:=E_ERROR_AT_ADDITION_FUNCTION;
end;



if ECode <> 0 then
begin
 Foreval.ErrorCode:=E_ERROR_AT_ADDITION_FUNCTION;
 Foreval.SyntaxErrorString:={$IFDEF TEXTOUT}Name{$ELSE}PtrToStr(Name){$ENDIF};
 Foreval.CalcException;
end
else
Foreval.AddNewFunction(Func,ID);


endp:
end;




procedure flAddNameFunction(Code: Cardinal; NName: {$IFDEF TEXTOUT}String{$ELSE}Pointer{$ENDIF});
begin
{$IFDEF TEXTOUT}Foreval.AddNewFuncName[Code]:=NName{$ELSE}Foreval.AddNewFuncName[Code]:=PtrToStr(NName);{$ENDIF}
//Foreval.AddNewFuncName[Code]:=PtrToStr(NName);
end;



procedure flGetErrorString(var S: {$IFDEF TEXTOUT}String{$ELSE}Pointer{$ENDIF});
begin
 S:={$IFDEF TEXTOUT}Foreval.SyntaxErrorString{$ELSE}StrToPtr(Foreval.SyntaxErrorString){$ENDIF};
end;




procedure  flGet(What,Func: Cardinal; var Get: Cardinal);
label 1,endp;
var
i,C: Integer;
begin
//внутренние и добавл€емые ф-ии (Func)
if What = fl_ADDRESS then Get:=Foreval.GetF(2,Func)
else
if What = fl_INLINE then
begin
 if Foreval.GetF(3,Func) = 1 then Get:=fl_ENABLE
 else
 if Foreval.GetF(3,Func) = 0 then Get:=fl_DISABLE;
end
else
if What = fl_FUNC_STACK_DEEP then
begin
 if Foreval.GetF(5,Func) = -1 then Get:=fl_UNKNOWN
 else
 Get:=Foreval.GetF(5,Func);
end
else
if What = fl_FUNC_ID         then Get:=Foreval.GetF(6,Func)
else
if What = fl_SET_ID          then
begin
 if Foreval.GetF(7,Func) = 1 then Get:=fl_ENABLE
 else
 if Foreval.GetF(7,Func) = 0 then Get:=fl_DISABLE
end
else
if What = fl_NUM_ARG         then Get:=Foreval.GetF(8,Func)
else
if What = fl_ARROW           then
begin
 if Foreval.GetF(9,Func) = 0 then Get:=fl_RIGHT
 else
 if Foreval.GetF(9,Func) = 1 then Get:=fl_BACK;
end
else
if What = fl_CLST            then
begin
 if Foreval.GetF(10,Func) = 1 then Get:=fl_ENABLE
 else
 if Foreval.GetF(10,Func) = 0 then Get:=fl_DISABLE
end
else
if What = fl_ARG_TYPE          then
begin
 case Foreval.GetF(11,Func) of
  _SINGLE:   Get:=fl_SINGLE;
  _DOUBLE:   Get:=FL_DOUBLE;
  _EXTENDED: Get:=fl_EXTENDED;
  _INTEGER:  Get:=fl_INTEGER;
  _DIFFER:   Get:=fl_DIFFER;
 end;
end
else
if What = fl_SAVE_REG        then Get:=Foreval.GetF(13,Func)
else
if What = fl_CALL_TYPE       then
begin
  case Foreval.GetF(14,Func)  of
  -3:                                   Get:=fl_MEMORY_EAX;
  -4:                                   Get:=fl_MEMORY_EBX;
  -5:                                   Get:=fl_MEMORY_ECX;
  -6:                                   Get:=fl_MEMORY_EDX;
  -7:                                   Get:=fl_MEMORY_STACK_CPU;
  -8:                                   Get:=fl_STACK_FPU;
  -10:                                  Get:=fl_STACK_CPU;
  -11:                                  Get:=fl_INFINITE_EABX;
  -12:                                  Get:=fl_INFINITE_EBCX;
  -13:                                  Get:=fl_INFINITE_ECDX;
  -14:                                  Get:=fl_INFINITE_STACK_CPU;
  1:                                    Get:=fl_KERNEL_I;
  2:                                    Get:=fl_KERNEL_F;
  3:                                    Get:=fl_KERNEL_FI;
  4:                                    Get:=fl_KERNEL_FF;
 end;
end
else
//скомпилированные ф-ии (Func)
begin
 For i:=0 to High(DF) do
 begin
  if Func = DF[i].Func.ICode then
  begin
   C:=i;
   goto 1;
  end;
 end;

  Foreval.ErrorCode:=E_NONEXISTENT_FUNCTION;
  Foreval.SyntaxErrorString:=IntToStr(Func);
  Foreval.CalcException;
  goto endp;

1:
 case What of
  fl_EXCHANGE_BRANCH_STACK_DEEP:   Get:=DF[C].XchBrSDeep;
  fl_EXCHANGE_BRANCHE_NUM:         Get:=DF[C].XchBrNXch;
  fl_DINAMIC_LOAD_STACK_DEEP:      Get:=DF[C].DinLoadSDeep;
  fl_DINAMIC_LOAD_NUM:             Get:=DF[C].DinLoadNMem;
  fl_DINAMIC_LOAD_OVFL:            begin
                                    if DF[C].DinLoadOverFlow = 1 then Get:=fl_YES
                                    else
                                    if DF[C].DinLoadOverFlow = 0 then Get:=fl_NO;
                                   end;
  fl_COMPILE_STACK_DEEP:           Get:=DF[C].CmplSDeep;
  fl_COMPILE_OVFL:                 begin
                                    if DF[C].CmplOverFlow = 1 then Get:=fl_YES
                                    else
                                    if DF[C].CmplOverFlow = 0 then Get:=fl_NO;
                                   end;
  fl_REPLACE_FUNCTION_NUM:         Get:=DF[C].CopyStackXch;
  fl_MAX_REPLACE_LEVEL:            Get:=DF[C].MaxReplaceLevel;
  fl_CALC_CONST_NUM:               Get:=DF[C].CalcConst;
  fl_LENGTH_CODE:                  Get:=Cardinal(@DF[C].Func.Code[High(DF[C].Func.Code)])-DF[C].Func.ICode;
  fl_USE_EAX:                      if Foreval.UseReg[1] = 1 then Get:=fl_YES else Get:=fl_NO;
  fl_USE_EBX:                      if Foreval.UseReg[2] = 1 then Get:=fl_YES else Get:=fl_NO;
  fl_USE_ECX:                      if Foreval.UseReg[3] = 1 then Get:=fl_YES else Get:=fl_NO;
  fl_USE_EDX:                      if Foreval.UseReg[4] = 1 then Get:=fl_YES else Get:=fl_NO;
  fl_USE_ESP:                      if Foreval.UseReg[5] = 1 then Get:=fl_YES else Get:=fl_NO;
  fl_USE_EBP:                      if Foreval.UseReg[6] = 1 then Get:=fl_YES else Get:=fl_NO;
  fl_USE_ESI:                      if Foreval.UseReg[7] = 1 then Get:=fl_YES else Get:=fl_NO;
  fl_USE_EDI:                      if Foreval.UseReg[8] = 1 then Get:=fl_YES else Get:=fl_NO;
 end;
end;

if What = fl_VERSION        then
begin
 if What = fl_MAJOR          then Get:=800;
 if What = fl_MINOR          then Get:=40;
 if What = fl_RELEASE        then Get:=8;
end
else
if What = fl_ABOUT        then Get:=Cardinal(StrToPtr('SOREL CopyRight (C) 1999-2003 Foreval R845'))
else
if What = fl_AUTHOR       then Get:=Cardinal(StrToPtr('Russia S.-Petersburg -2003-'))
else
if What = fl_PACKAGE_COMPILE_LAST_ADDR then Get:=PkgLastAddr;

endp:
end;




initialization
begin
 Foreval:=TForevalDll.Create;
 SetLength(DF,1);
 _STRINGTYPE:=fl_STRING;
 //_STRINGTYPE:=fl_PChar;
 F_PkgCmpl:=False;
end;



finalization
begin


FreeCmplFuncList;
DF:=nil;

Foreval.Destroy;
end;


end.
