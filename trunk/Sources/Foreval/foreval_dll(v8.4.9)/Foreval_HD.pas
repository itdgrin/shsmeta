unit Foreval_HD;

{******************************************************************************}
{                                                                              }
{                     SOREL   (C)CopyRight 1999-2003. Russia, S.-Petersburg.   }
{                                                                              }
{ Foreval - компилятор строковых алгебраических  выражений  с расширенными     }
{ возможностями.                                                               }
{ Модуль содержит синтаксический анализатор и оптимизатор выражений.           }
{ Компилировать только начиная с версии DELPHI 4.0 (содержит динамич. массивы) }
{                               -Foreval-                                      }
{                          ver. 8.4.9                                          }
{******************************************************************************}


{.$DEFINE TEXTOUT}

interface

uses

  SysUtils,Math,Windows;

  const _PI: extended = 3.141592653589793238462643;
  const NumberFact = 1754;

  const
   E_ZeroDivide = 20;
   E_InvalidOp = 21;
   E_OverFlow = 22;
   E_UnderFlow = 23;
   E_IntOverFlow = 24;
   E_AccessViolation = 25;
   E_OutOfMemory  = 26;
   E_StackOverFlow = 27;
   E_ERROR_AT_ADDITION_FUNCTION = 28;
   E_NONEXISTENT_FUNCTION = 29;
   E_UNKNOWN_SYMBOL  = 1;
   E_MISSING_BRACKET_LEFT = 2;
   E_MISSING_BRACKET_RIGHT  = 3;
   E_MISSING_OPERATION = 4;
   E_INCOINCIDENCE_NUMBER_ARGUMENTS = 5;
   E_MISSING_EXPRESSION  = 6;
   E_UNKNOWN_FUNCTION = 7;

  const _Single = 1;
  const _Double = 2;
  const _Extended = 3;
  const _Integer = 4;
  const _Differ =  5;
  const _None = 0;

  const  _ADD:  Integer = 2;
  const  _MUL:  Integer = -2;
  const  _DIV:  Integer = -1;
  const  _SUB:  Integer = 1;
  const  _SUBR: Integer = 3; //устанавливается TreeOptimizator -ом
  const  _DIVR: Integer = -3;//устанавливается TreeOptimizator -ом
  const  _NOP:  Integer = 0;

  const  _FAVB: Integer = 1;
  const  _AIFB: Integer = 2;
  const  _AAF:  Integer = 3;
  const  _MAF:  Integer = 4;
  const  _IAVB: Integer = 5;
  const  _AAI:  Integer = 6;
  const  _AFI:  Integer = 7;



  const  _FPU:  Integer = 1;
  const  _MEM:  Integer = 2;

  const  _Disable: Integer = 0;
  const  _Enable:  Integer = 1;
  const  _Auto:    Integer = 2;

  const  C_Compile: Integer = 1;
  const  C_EmlXchBranch: Integer = 2;  //TreeOptimizator
  const  C_EmlDinamicLoad: Integer = 3;

type
TAddress = Cardinal;
type TFloatType = extended;
type TIntegType = Integer;
type PFloatType = TAddress;//Pointer;

type
TAmvab  = record
            A: TFloatType;
            B: TFloatType;
           nf: Cardinal;
          end;

type
PAmvab  = record
            A: TFloatType;
            B: TFloatType;
           PF: PFloatType;
          end;

type TDAmvab = array of TAmvab;
type PDAmvab = array of PAmvab;


type
   PFuncData = ^TFuncData;
   TFuncData = record
                FData: Extended;
                //IData: TIntegType;
                Next:  PFuncData;
               end;




type TMass2 =  record
              FM: array of TFloatType;
              IM: array of TFloatType;
              FC: TFloatType;
               end;
type
TArray4 = array [1..4] of byte;
type TCode = array of byte;    //=DWORD для выравнивания на 32
type TArrayF = array of TFloatType;
type PArrayF = ^TArrayF;
type TAddFunc = function(N: Integer; SF: TArrayF): TFloatType;


type PIntegType = TAddress;//Pointer;

type TArrayI = array of Integer;

type TPrt =    record
                WCS: Integer; //ранг  сохранения (какая часть команды сохраняется)
                RCS: Integer; //приоритет чтения (какая часть команды замещается)
                NC: Integer;  //число сохраняемых частей за раз
               end;

type TWCS =    record
                WCS: Integer;  //ранг  сохранения (какая часть команды сохраняется)
                MWCS: Integer; //номер массива в CopyStack (соответствующего WCS)
               end;            //где сохраняется эта часть комманды

type TAWCS = array of TWCS; //если команда сохраняет одновременно несколько частей

type TArray2I = array of array of  TPrt;



type

 TFunc = record
               S: TIntegType;              //Stack
               N: TIntegType;              //Node
               I: TIntegType;              //Inv; 1:'-';-1:'/'; 2:'+'; -2:'*'; 0: NOP;
             Neg: TIntegType;
               NL: Cardinal;      //порядковый номер комманды на уровне
               NM: Cardinal;      //номер; Interp[NM] - узел (Tree^.Pr) для эл-ов уровня
               CODE: TIntegType;    //номер комманды в FuncList
            ExtArg: Integer;   //=_Double,_Extended,_Integer,_Single,_None - если команда является аргументом внешней ф-ии соотв. типа (либо нет - _None) исп-ся при компиляции
            SExtArg: Integer; //смещение адреса аргумента добавл. ф-ии (только для ф-ий через память, для остальных = 0!!!)
              SGN: TArrayI;   //SGN[i] = _MUL,_ADD,_SUB,_DIV (i=0,..N); - действия над  коммандами вытекающего уровня
            RData: TArrayI;   //RData[i] = _FPU,_MEM; (i=0..N); - где хранятся рез-ты комманд вытекающего уровня
            SNExtArg: TArrayI;//смещения адресов аргументов ф-ии (если добавл. ф-ия через память) 
             SData: Integer;   //=_FPU,_MEM; где сохраняется рез-т текущего узла
               PkAdr: Cardinal;
               PkShift: Cardinal;
               PkRType: Cardinal;
               ErS:  String;
             XCHA: Integer;   //обмен аргументов для 2-арг. ком.(FType = 4) уст-ся в TreeOptimizator(если есть обмен) исп-ся компилятором
               AI: TIntegType;             //inf  for Func
               BI: TIntegType;             //inf  for Ipwr
               CI: TIntegType;             //TIntegType const.; inf for type ARGI
               DI: TIntegType;             //inf for Type of ARGF
               EI: TIntegType;             //manage for function
               FI: TIntegType;             //manage, only for FPwr

               F1:  TFloatType;            //help var. for func. opt.
               F2:  TFloatType;

               V1: TFloatType;           //help var. for float var. opt.
               V2: TFloatType;          //в командах типа ax+b используются:
                      //a - V1(VI1), b - V2(VI2)
                         //в ост. случ. const. - V12, VI6, V6;

               V3: TFloatType;          //коэфф. второй перем.
               V4: TFloatType;         //коэфф. второй перем.

               VI1:   TIntegType;         //help var. for int. var. opt.
               VI2:   TIntegType;
               VI3:   TIntegType;   //коэфф. второй перем.
               VI4:   TIntegType;   //коэфф. второй перем.


               FV1:  PFloatType;   //указатели на переменные
               FV2: PFloatType;     //исп-ся для указания на вторую fl. перем.


               IV1:   PIntegType;
               IV2:   PIntegType; //исп-ся для указания на вторую int. перем.

               AWCS: TAWCS;
               RCS: Integer;
               MRCS: Integer; {номер массива в CopyStack для чтения замещаемой части}
                              {если сразу несколько частей, то -  номер первой}

                PM:  array of PFloatType;
                PN:  array of TFloatType;
                PI:  array of PIntegType;
                PC:  array of TIntegType;
               AFB:  PDAmvab;

                end;


type
TArrayOfTFunc = array of TFunc;

type
TFunction = record
                   Code:  TCode;
                   Data:  PFuncData;
                   Stack: TArrayF;
                   CpSt:  TArrayF;
                   //Fact:  TArrayF;
                   ICode: TAddress;
                   //BCode: TAddress;
                  end;

type PFunction = ^TFunction;

type TNStack = record
                S: TIntegType; //текущий номер стека
                N: TIntegType; //число вытекающих узлов
              end;


type
PNode = ^TNode;
TNode = record
        Code:  Integer;
        SGN: TArrayI;
        RData: TArrayI;
        SNExtArg: TArrayI;
        PkAdr: Cardinal;
        PkShift: Cardinal;
        PkRType: Cardinal;
        Expression: String;
        NL: Cardinal;
        NM: Cardinal;
        SData: Integer;
        ExtArg: Integer;
        SExtArg: Integer;
        Stack: TNStack;
        SDeep: Integer;
        Neg: Integer;   //1-neg
        XCHA: Integer;
        I: Integer;   //1:'-';-1:'/'; 2:'+'; -2:'*'; 0: NOP;
        Ch: PNode;
        Nb: PNode;
        Pr: PNode;
        AI: TIntegType;
        BI: TIntegType;
        CI: TIntegType;
        DI: TIntegType;
        EI: TIntegType;
        FI: TIntegType;
        FV1: TIntegType;    //номер fl. переменной для создания ссылки на неё
        FV2:TIntegType;    //номер fl. второй переменной для создания ссылки на неё
        IV1: TIntegType;    //номер int. переменной для создания ссылки на неё
        IV2:TIntegType;    //номер int. второй переменной для создания ссылки на неё
        F1:  TFloatType;
        F2:  TFloatType;

        V1: TFloatType;
        V2: TFloatType;
        V3: TFloatType;
        V4: TFloatType;
        VI1: TIntegType;
        VI2: TIntegType;
        VI3: TIntegType;
        VI4:  TIntegType;
        AFB: TDAmvab;
        PN:  TMass2;         //коэфф-ты для аргументов-функций: ARGF
        PN1: TMass2;         //коэфф-ты для аргументов-функций: ARGI
       end;

type
TDataNode = record
              Code: Integer;
              N: TIntegType;
              Expression: String;
              SGN: TArrayI;
              SNExtArg: TArrayI;
              SS: Integer;      //смещение стека: исп-ся в добавл. ф-ях
              ExtArg: Integer;
              XCHA: Integer;
              Neg: Integer;   //1-neg;
              AI: TIntegType;
              BI: TIntegType;
              CI: TIntegType;
              DI: TIntegType;
              EI: TIntegType;
              FI: TIntegType;
              FV1: TIntegType;
              FV2: TIntegType;
              IV1: TIntegType;
              IV2:TIntegType;
              F1:  TFloatType;
              F2:  TFloatType;
              V1: TFloatType;
              V2: TFloatType;
              V3: TFloatType;
              V4: TFloatType;
              VI1: TIntegType;
              VI2: TIntegType;
              VI3: TIntegType;
              VI4: TIntegType;
              PN:  TMass2;
              PN1: TMass2;
              AFB: TDAmvab;
            end;

type
TLevel = record
          Expression: String;
          NL: Cardinal;
          I: Integer;   //1:'-';-1:'/'; 2:'+'; -2:'*';
          ExtArg: Integer;
          SExtArg: Integer;
          PkAdr: Cardinal;
          PkShift: Cardinal;
          PkRType: Cardinal;
         end;


type PLevel = array of TLevel;



type
TArrayS = array of String;


type
TAdditionalFunc = record
                   Name: String;
                   Arg:  Integer;  //число аргументов
                  addr:  Pointer;  //адрес
                 FType:  Integer;
               SaveReg:  Integer;
                   inl:  Integer;
               Id_Func:  Integer;  //идентефикатор
                  CLST:  Integer;  //очистка стека
                 Arrow:  Integer;  //направление передачи аргументов
                Set_ID:  Integer;  //разрешение использования идентефикатора
                   NST:  Integer;  //в случае если добавл. ф-ия остаётся в стеке,
                                   // то NST=глубине стека ф-ии, иначе NST = -1.
               ArgType:  Integer;  //_Integer,_Double,_Extended,_Differ
           ArgTypeList:  TArrayI;  //если ArgType = _Differ, то в ArgTypeList -
                                   //список типов переменных
               inlCode:  TCode;
                  end;



type
TFuncList =     record
                 Name: TArrayS;
                 Addr: Pointer;
                 inl: Integer;  //0,1 - ф-ия вызывается по адресу(Addr), либо вставляется
                                //непосредственно в код (inline)
                 inlCode: TCode;//содержит код ф-ии в случае inl=1
                 NST: Integer;  //глубина стека
                                //в случае если добавл. ф-ия остаётся в стеке,
                                // то NST=глубине стека ф-ии, иначе NST = -1.
                 Id_Func:  Integer; //только для внешних ф-ий (вызов всегда через ESP)
                 Set_Id:  Integer; //1 - использовать Id_Func; 0 - нет
                 Arg: Integer;    //число аргументов (-1 для Infinite)
                 ARROW: Integer; //направление передачи параметров : 0 - прямое(LR); 1 - обратное(RL);
                 CLST: Integer;  //кто очищает стек : 0 - вызываемая; 1 - вызывающая;
                 ArgType:  Integer;  //тип аргумента (если все одинаковые)
                 ArgTypeList:  TArrayI; //типы аргументов (если - разные)
                 SaveReg: Integer; //принудительное сохранение регистров (PUSH/POP),
                                   //используемых функцией (EAX,...)  ,бит = 1,0 (сохр./нет)
                                   //биты: 1 - EAX; 2 - EBX; 3 - ECX; 4 - EDX; 5 - ESP; 6 - EBP; 7 - ESI; 8 - EDI;
                                   //остальные биты зарезервированы

                 FType: Integer; //< 0 - добавляемые ф-ии
                end;             // = 0 - внутренние комманды(AAF,MAF,ADD,MUL,LDSC,...)
                                 // = 1 - внутренние и добавляемые ф-ии типа func(n)
                                 // = 2 - внутренние и добавляемые ф-ии типа func(x)
                                 // = 3 - внутренние и добавляемые ф-ии типа func(x,n)
                                 // = 4 - внутренние и добавляемые ф-ии типа func(x1,x2)


type
TArrayFuncList = array of TFuncList;


type
TParamList = record
               Name: String;
               Value: TFloatType;
             end;



type
TVariable = record
              Name: String;
              Addr: TAddress;
             VType: Integer; //_Double, _Extended, _Integer;
            end;

type
TVarList = array of TVariable;




type
TString1 = String[1];

type
TFin = record
        F: Integer;
        I: Integer;
       end;

type
TAttrib = record
           Adr:   Cardinal; //адрес сохраняемого результата (непосредственный - Address)
                            //либо косвенный (в регистрах)
                            //Adr = Address,EAX(1),EBX(2),ECX(3),EDX(4),ESP(5);
           RType: Cardinal; //тип сохраняемого результата
                            //RType = _Double,_Integer,_Extended,_Single
           Shift: Cardinal; //смещение в косвенной адресации ([EAX+shift],...)                 
          end;

type
TArrayPkg = array of TAttrib;
type
PArrayPkg = ^TArrayPkg;

type TExternalException = procedure; //внешний обработчик исключений


type
ESyntaxError = class(Exception);

type
EInternalError = class(Exception);



type

  TForevalH = class



  private



    Interp: TArrayOfTFunc;
    CurrentExpression: String;      //текущее выражение
    LFunc    : TIntegType;          //длина скомпилированного выражения
    StackSize: TIntegType;          //размер стека
    ParamList: array  of TParamList;                     //список параметров(имена,значения)
    VarList: TVarList;
    ArgM : array of String;              //список аргументов в случае > 2 арг.(отсчёт с '1')
    Func: TFunction;                     //исполняемый код скомпилированного выражения
    Tree: PNode;                                //дерево разбора выражения
    FuncList: TArrayFuncList;
    F_Optimization: Boolean; //вкл. выкл. полную оптимизацию, включая операции
    F_SyntaxExtension:       Boolean; //вкл./выкл.: имена ф-ий > 1; '{' ; '['; '!'; '^'; .
    BeginTree: PNode;                 //указатель начала дерева (не обязательно)
    F_VarShift:              Boolean;  //распознавание var&param в верхнем/нижнем/обоих регистрах.
    F_FuncShift:             Boolean;
    DMI: array of Integer;   //используется в PostCodeOptimization;
    LSRes: TIntegType;
    F_PostCodeOptimizator:   Boolean;
    F_StackDeep:             Integer;
    F_SyntaxErrorString: String;   //строка ошибки
    F_SaveInStack: Boolean;
    F_ErrorCode: Integer;
    F_ShowException: Boolean;      //вкл./выкл. показ исключений
    F_ExternalException: Boolean;  //вкл./выкл. внешнего обработчика исключений
    F_CalcConstant: Boolean;
    F_LevelReplace: Cardinal;
    F_ErNum: Integer;  //номер Interp в случае ошибки в CalcConst;
    F_Arrow: Integer;
    F_CLST:  Integer;
    F_Set_Id: Integer;
    F_TreeOptimization: Integer;
    F_DinamicLoadOptimization: Integer;
    F_ParamType, F_DataType: Integer; //компиляция параметров и стека на типы(_Double/_Extended)
    F_OverFlowFunc: Boolean;  //=True если в выражении присутствует добавляемая ф-ия с .NST=-1(т.е. неизвестна глубина стека)
    F_CloseArg: Boolean;
    F_PackageCompile: Boolean;
    F_XchTableTrig: Boolean;
    XchTable: TArray2I;
    XchCode:  TArrayI;
    PkgData:  TArrayPkg;
    F_IdL: Integer;
    F_Attrib: TAttrib;
    Db_XchBrSDeep: Integer;     //глубина стека до выполнения TreeOpimization (если: _Enable,_Auto)
    Db_XchBrNXch: Integer;      //число перестановок в TreeOpimization
    Db_DinLoadSDeep: Integer;   //глубина стека до выполнения DinamicLoad  (если: _Enable,_Auto)
    Db_DinLoadNMem: Integer;    //число выталкиваний в DinamicLoad
    Db_DinLoadOverFlow: Boolean;//True, если глубину стека в DinamicLoad невозможно сделать меньше заданной
    Db_CmplMaxStack: Integer;   //глубина стека при компилировании
    Db_CmplOverFlow: Boolean;   //если при компиляции в режиме F_SaveStack = True возникает переполнение, то: True, иначе: False
    Db_CopyStackXch: Integer;   //число замен в CopyStack
    Db_CalcConst: Integer;      //число вычисленных констант в CalcConst
    Db_MaxReplaceLevel: Integer;//макс. уровень замены в CopyStack



    procedure FindExternalBracket(S: String; var SS: String; var Neg: Integer);
    procedure FindMainOperation(S:String; var MOP: Integer);
    procedure StringAnalizator(S:String; var N: TIntegType; var COP: Integer; var HS:PLevel; var{Neg: Boolean} Neg: Integer);
    procedure WriteCode;
    procedure WriteLevelParam(H: PNode; HS: PLevel; N: Cardinal);
    function  PointToDec(S: String):String;
    procedure CreateFuncList;
    procedure CreateInitData;
    procedure CreateFactMass;
    procedure FindVar(S1: String; ND: TDataNode; var ni: TIntegType; var FIN:TFin; var {Neg: Boolean} Neg: Integer);
    procedure SyntaxAnalizator(S:String; var ND: TDataNode; var LV:PLevel;  var EOFN: Boolean);
    procedure NumberAnalizator(LV: PLevel; ND: TDataNode; var LV1: PLevel; var ND1: TDataNode; var EOFN: Boolean);
    procedure OperationalAnalizator(LV:PLevel; ND: TDataNode; var LV1:PLevel; var ND1: TDataNode; var EOFN: Boolean);
    procedure AddOptimizator(LV:PLevel; ND: TDataNode; var LV1:PLevel; var ND1: TDataNode; var EOFN: Boolean);
    procedure MulOptimizator(LV:PLevel; ND: TDataNode; C: TFloatType; Neg: Integer; var LV1:PLevel; var ND1: TDataNode; var EOFN: Boolean);
    procedure FunctionalAnalizator(nf: TIntegType; A: TFloatType; B: TFloatType; Arg1: String; Arg2: String; var ND: TDataNode; var LV: PLevel; var EOFN: Boolean);
    procedure SubstParam(S1: String; var S2: String; var C: TFloatType; var SB: TIntegType);
    procedure PredSyntax(S: String; var ND: TDataNode; var LV: PLevel; var BH: Boolean; var EOFN: Boolean);
    procedure MulOptH(LV: PLevel; var LV1: PLevel; var C: TFloatType; var{Neg: Boolean;} Neg: Integer; var BH: Boolean);
    procedure WriteNodeParam(ND: TDataNode);
    procedure FindAV(S: String; ND: TDataNode; var A: TFloatType; var FIN: TFin; var ni: TIntegType);
    procedure FindAMVAB(S: String; var ni: TIntegType; var FIN: TFin; var PN: TMass2);
    procedure InitNode(var ND: TDataNode);
    procedure FindMV(S: String; var PN: TMass2; var ni: TIntegType);
    procedure FindMAF(S: String; var PN: TMass2; var B: TFloatType; var BH: Boolean);
    procedure FindAMVAB_FI(S: String; var A: TFloatType; var B: TFloatType; var nf: TIntegType; var ni: TIntegType; var BH: Boolean);
    procedure WriteDataCode;
    procedure FindAFB(S: String; var A: TFloatType; var B: TFloatType; var BH: Boolean);
    procedure FindArgType(S: String; var nt: TIntegType; var A: TFloatType; var B: TFloatType; var nf: TIntegType; var ni: TIntegType; var PN: TMass2);
    procedure WriteArgData(nt: TIntegType; A: TFloatType; B: TFloatType; ni: TIntegType; nf: TIntegType; PN: TMass2; var ND: TDataNode);
    procedure FindFuncArgData(S: String; var ND: TDataNode; var nt: TIntegType{; var BH: Boolean});
    procedure FindFunction(S: String; var A: TFloatType; var B: TFloatType; var Arg1: String; var Arg2: String; var nf: TIntegType; var BH: Boolean);
    procedure FindFuncSymb(S1: String; var S2: String);
    procedure FindFactSymb(S1: String; var S2: String);
    procedure FindPowerSymb(S1: String; var S2: String);
    procedure ReplaceAbsBr(S: String; var S1: String);
    procedure ReplaceTruncBr(S: String; var S1: String);
    procedure XchangeAddingBracket(S: String; var S1: String);
    procedure PrevTreat(S: String; var S1: String);
    procedure SetAdditionalParameter(S: String; V: TFloatType);
    procedure FreeTree;
    procedure FreeFunction;
    function  GetParameter2(S: String): TFloatType;
    procedure SetParameter(Number: TIntegType; V: TFloatType);
    function  GetParameter1(Number: TIntegType): TFloatType;
    procedure Linker(S:String);
    procedure SetStackSize;
    procedure CodeGeneration;
    procedure FindSA(S: String; var LV: PLevel; var A: TFloatType; var N: TIntegType; var BH: Boolean);
    procedure FindFIAV(S1: String; var ni: TIntegType; var FIN: TFin; var A,B: TFloatType; var PN: TMass2);
    procedure FindManyArg(S: String; nf: Integer);
    procedure ExtFunc(nf: TIntegType;  ND: TDataNode; var LV: PLevel; var ND1: TDataNode; var EOFN: Boolean);
    procedure FuncFType1(nf: TIntegType; Arg1: String; var LV: PLevel; var ND: TDataNode; var EOFN: Boolean);
    procedure FuncFType2(nf: TIntegType; Arg1: String; var LV: PLevel; var ND: TDataNode; var EOFN: Boolean);
    procedure FuncFType3(nf: TIntegType; Arg1,Arg2: String; var LV: PLevel; var ND: TDataNode; var EOFN: Boolean);
    procedure FuncFType4(nf: TIntegType; Arg1,Arg2: String; var LV: PLevel; var ND: TDataNode; var EOFN: Boolean);
    function  CmpAAF(NS,NF: Integer): Boolean;
    function  CmpMAF(NS,NF: Integer): Boolean;
    function  CmpFAVB(NS,NF: Integer): Boolean;
    function  CmpIAVB(NS,NF: Integer): Boolean;
    function  CmpAIFB(NS,NF: Integer): Boolean;
    function  CmpAAI(NS,NF: Integer): Boolean;
    function  CmpFAVB1(NS,NF: Integer): Boolean;
    function  CmpFunc1(NS,NF: Integer): Boolean;
    function  CmpFunc2(NS,NF: Integer): Boolean;
    function  CmpFunc3(NS,NF: Integer): Boolean;
    function  CmpFunc4(NS,NF: Integer): Boolean;


    procedure FindConstItem(LM: PLevel; {Neg: Boolean;}Neg: Integer; T: Integer;  var LM1: PLevel; var A,B: TFloatType; var BH: Boolean);
    procedure PostCodeOptimization;
    procedure CalcConstExpr(S: String; var A: TFloatType; var BH: Boolean);
    procedure CalcConstExpr_MUL(LVA: PLevel; var A: TFloatType; var BH: Boolean);
    procedure SubstParamC(S1: String; var S2: String; var C: TFloatType; var SB: TIntegType);
    procedure CalcConstFunc;
    function  GetNumberXchTable(Code: Integer): Integer;
    function  GetPriorityXch(Code1,Code2: Integer): TPrt;
    function  Calc: TFloatType;
    //procedure AddNameFunction(FName,NName: String);
    procedure AddNameFunction(Code: Integer; Name: String);
    procedure ClearNameFunction(Code: Integer);
    procedure DeleteFunction(Code: Integer);
    procedure SetCorrectIPWR(CI: Integer);
    procedure SetNodeDeep;
    procedure TreeOptimizator;
    procedure BranchOptimizator;
    function  CheckXchBranch(Lv: PNode): Boolean;
    procedure XchBranch(Pr: PNode);
    procedure RestoreStack;
    procedure InitConstDb;
    function  EnableDL(I: Integer): Boolean;
    function  IsSameFunctions(NF,NS: Integer): Boolean;
    procedure ReplaceOperations;
    procedure InsertCopyStack(NF,NS,N: Integer);
    procedure FreeInterp;
    procedure FreeFuncData(FuncData: PFuncData);
    procedure SetNL;
    procedure SetLoadSource;
    procedure SetNM;
    procedure SetLoadMem(I: Integer);
    procedure DinamicLoadOptimizator;
    procedure SetDIVR;
    procedure PackageAnalizator(LV: PLevel; ND: TDataNode; var LV1: PLevel; var ND1: TDataNode; var BH,EOFN: Boolean);
    procedure PkSyntax(S:String; var ND: TDataNode; var LV:PLevel;  var EOFN: Boolean);
    procedure SetExchTableTrig(k: Integer);

   




  protected
   ExtException: {Pointer}TExternalException;  //внешний обработчик исключений
   procedure  CalcException;  virtual;



  public

   constructor Create;
   destructor  Destroy;    overload;

    procedure SetF(C,Code,Value: Integer);
    function GetF(C,Code: Integer): Integer;



   procedure SetExtExpression(S: String;  Atr: TAttrib; var E_Func: TFunction);
   procedure SetNewVar(Name: String; Addr: Cardinal; VType: Integer);
   procedure FreeExtFunc(E_Func: TFunction);
   procedure AddNewFunction(Func: TAdditionalFunc; var ID: Cardinal);
   procedure SetStackDeep(S: Integer);
   procedure SetLevelReplace(L: Integer);

   procedure ClearVar;
   procedure ClearParam;
   procedure FreeVar;
   procedure FreeParam;
   procedure FreeAddFunction;
   function  GetReg(R: Integer): Integer;       //использование регистра [R] в скомпилированной ф-ии
   procedure SetReg(Reg: Integer; SC: Integer); //принудительное сохранение регистра [R] в скомпилированной ф-ии
   procedure SetPkgData(PD: TArrayPkg);


   property  Parameter[Name: string]: TFloatType read GetParameter2 write SetAdditionalParameter;
   property  CalcConstant: Boolean read F_CalcConstant write F_CalcConstant default True;
   property  CorrectIPWR: Integer write SetCorrectIPWR;
   property  AddNewFuncName[Code: Integer]: String write AddNameFunction;
   property  ClearNameFunc: Integer write ClearNameFunction;
   property  DeleteFunc: Integer write DeleteFunction;
   property  SyntaxExtension: Boolean read F_SyntaxExtension write F_SyntaxExtension default True;
   property  VarShift: Boolean read F_VarShift write F_VarShift default False;
   property  FuncShift: Boolean read F_FuncShift write F_FuncShift default False;
   property  ShowException: Boolean read F_ShowException write F_ShowException default True;
   property  ErrorCode: TIntegType read  F_ErrorCode write F_ErrorCode default 0;
   property  SyntaxErrorString: String read F_SyntaxErrorString write F_SyntaxErrorString;
   property  ExternalException: Boolean read F_ExternalException write F_ExternalException default False;
   property  ParamType: Integer read F_ParamType write F_ParamType default _Double;
   property  DataType: Integer read F_DataType  write F_DataType default _Double;
   property  TreeOptimization: Integer read F_TreeOptimization write F_TreeOptimization default 2;
   property  DinamicLoadOptimization: Integer read F_DinamicLoadOptimization write F_DinamicLoadOptimization default 2;
   property  SaveInStack: Boolean read F_SaveInStack write F_SaveInStack default True;
   property  GlobalOptimization: Boolean read F_Optimization write F_Optimization default True;
   property  UseReg[R: Integer]: Integer read GetReg;
   property  CloseArg: Boolean read F_CloseArg write F_CloseArg default False;
   property  PackageCompile: Boolean read F_PackageCompile write F_PackageCompile default False;
   property  SpecTrigOptim: Integer write SetExchTableTrig;

   property  XchBrSDeep:      Integer read Db_XchBrSDeep;
   property  XchBrNXch:       Integer read Db_XchBrNXch;
   property  DinLoadSDeep:    Integer read Db_DinLoadSDeep;
   property  DinLoadNMem:     Integer read Db_DinLoadNMem;
   property  DinLoadOverFlow: Boolean read Db_DinLoadOverFlow;
   property  CmplMaxStack:    Integer read Db_CmplMaxStack;
   property  CmplOverFlow:    Boolean read Db_CmplOverFlow;
   property  CopyStackXch:    Integer read Db_CopyStackXch;
   property  CalcConst:       Integer read Db_CalcConst;
   property  MaxReplaceLevel: Integer read Db_MaxReplaceLevel;





  published



  end;



var
  ak,bk: array[1..7] of TFloatType;
  C_2dqrPi: extended;
  Factorial: TArrayF;          //массив факториалов



  ForevalH: TForevalH;



implementation
uses
{$IFDEF TEXTOUT}
TestG8,
{$ENDIF}
Compilator, CommandC;
var
Cmpl: TCompiler;





procedure TForevalH.SetStackSize;
label endp;
begin
if F_ErrorCode <> 0 then goto endp;
Tree:=BeginTree;   //не обязательно, т.к. чтение дерева - циклически

while Tree^.Ch <> nil do
begin
Tree:=Tree^.Ch;
end;
StackSize:=Tree^.Stack.S;

while Tree^.Pr <> nil do
begin
 while Tree^.Nb <> nil  do
 begin
 Tree:=Tree^.Nb;
  while Tree^.Ch <> nil do
  begin
  Tree:=Tree^.Ch;
  end;
if Tree^.Stack.S > StackSize then StackSize:=Tree^.Stack.S;
 end;
 Tree:=Tree^.Pr;
if Tree^.Stack.S > StackSize then StackSize:=Tree^.Stack.S;
end;

SetLength(Func.Stack,StackSize+1);
endp:
end;



procedure TForevalH.Linker(S: String);
label endp;
var
HS: PLevel;
ND: TDataNode;
H,H1: PNode;
EOFN: Boolean;
i: Cardinal;
begin
if F_ErrorCode <> 0 then goto endp;
New(Tree);
Tree^.Ch:=nil;
Tree^.Nb:=nil;
Tree^.Pr:=nil;
BeginTree:=Tree;
//вершина дерева:
Tree^.Expression:=Copy(S,1,Length(S));
Tree^.Stack.S:=1;
Tree^.I:=0;
//Tree^.NL:=0;
EOFN:=True;
if F_PackageCompile then PkSyntax(Copy(Tree^.Expression,1,Length(Tree^.Expression)),ND,HS,EOFN)
else
SyntaxAnalizator(Copy(Tree^.Expression,1,Length(Tree^.Expression)),ND,HS,EOFN);
//спуск:
//COP<>NOP:
while EOFN <> True do
begin
if F_ErrorCode <> 0 then goto endp;

New(H);
Tree^.Ch:=H;
inc(F_IdL);  //для отладки
WriteNodeParam(ND);
WriteLevelParam(H,HS,0);


H^.Stack.S:=Tree^.Stack.S;
H^.Pr:=Tree;
H1:=H;
H^.Ch:=nil;
H^.Nb:=nil;

for i:=1 to High(HS) do
begin
 New(H);
 H^.Ch:=nil;
 H^.Nb:=nil;
 WriteLevelParam(H,HS,i);
 H^.Stack.S:=H1^.Stack.S+1;
 H1.Nb:=H;
 H^.Pr:=Tree;
 //HS:=HS^.Next;
 H1:=H;
end;
Tree:=H^.Pr^.Ch;
HS:=nil; //??? (освобождение массива уровня)
SyntaxAnalizator(Copy(Tree^.Expression,1,Length(Tree^.Expression)),ND,HS,EOFN);
end;
//EOFN=True: последняя команда узла (нижний левый)
WriteNodeParam(ND);

//подъём:
while Tree^.Pr <> nil do
begin
 while Tree^.Nb <> nil  do
 begin
 Tree:=Tree^.Nb;
 SyntaxAnalizator(Copy(Tree^.Expression,1,Length(Tree^.Expression)),ND,HS,EOFN);
//COP<>NOP:
while EOFN<>True do
 begin
 if F_ErrorCode <> 0 then goto endp;

 New(H);
 Tree^.Ch:=H;
 inc(F_IdL);  //для отладки
 WriteNodeParam(ND);
 WriteLevelParam(H,HS,0);

 H^.Stack.S:=Tree^.Stack.S;
 H^.Pr:=Tree;
 H1:=H;
 H^.Ch:=nil;
 H^.Nb:=nil;
 for i:=1 to High(HS) do
 begin
  New(H);
  H^.Ch:=nil;
  H^.Nb:=nil;
  WriteLevelParam(H,HS,i);

  H^.Stack.S:=H1^.Stack.S+1;
  H1.Nb:=H;
  H^.Pr:=Tree;
  H1:=H;
 end;
 Tree:=H^.Pr^.Ch;
 HS:=nil; //??? (освобождение массива уровня)
 SyntaxAnalizator(Copy(Tree^.Expression,1,Length(Tree^.Expression)),ND,HS,EOFN);
 end;
//EOFN=True:последняя команда узла
WriteNodeParam(ND);
end;
Tree:=Tree^.Pr;
end;

Tree:=BeginTree;

endp:
end;



procedure TForevalH.FreeFunction;
var
i: Integer;
begin
Func.Code:=nil;
Func.Stack:=nil;
Func.CpSt:=nil;
FreeFuncData(Func.Data);
end;



procedure TForevalH.WriteNodeParam(ND: TDataNode);
begin
Tree^.Stack.N:=ND.N;
Tree^.Neg:=ND.Neg;
Tree^.XCHA:=ND.XCHA;
Tree^.AI:=ND.AI;
Tree^.BI:=ND.BI;
Tree^.CI:=ND.CI;
Tree^.DI:=ND.DI;
Tree^.EI:=ND.EI;
Tree^.FI:=ND.FI;
Tree^.FV1:=ND.FV1;
Tree^.FV2:=ND.FV2;
Tree^.IV1:=ND.IV1;
Tree^.IV2:=ND.IV2;
Tree^.F1:=ND.F1;
Tree^.F2:=ND.F2;


Tree^.V1:=ND.V1;
Tree^.V2:=ND.V2;
Tree^.V3:=ND.V3;
Tree^.V4:=ND.V4;
Tree^.V4:=ND.V4;
Tree^.VI1:=ND.VI1;
Tree^.VI2:=ND.VI2;
Tree^.VI3:=ND.VI3;
Tree^.VI4:=ND.VI4;


Tree^.SGN:=ND.SGN;
Tree^.SNExtArg:=ND.SNExtArg;
Tree^.PN:=ND.PN;
Tree^.PN1:=ND.PN1;
Tree^.Code:=ND.Code;
Tree^.AFB:=ND.AFB;
end;



procedure TForevalH.WriteLevelParam(H: PNode; HS: PLevel; N: Cardinal);
begin
H^.Expression:=Copy(HS[N].Expression,1,Length(HS[N].Expression));
H^.I:=HS[N].I;
H^.ExtArg:=HS[N].ExtArg;
H^.SExtArg:=HS[N].SExtArg;
H^.PkAdr:=HS[N].PkAdr;
H^.PkShift:=HS[N].PkShift;
H^.PkRType:=HS[N].PkRType;
end;


procedure TForevalH.FindExternalBracket(S: String; var SS: String; {var Neg: Boolean} var Neg: Integer);
label
2,3,endp;
var
b,i,z,a:TIntegType;
begin
SS:=Copy(S,1,Length(S)); z:=1;
2:
b:=0; a:=1;

if SS = '' then
begin
goto endp;
end;


if SS[1] = '-' then a:=2;
if  SS[a] = '(' then
begin
 b:=-1;
 for i:=a+1 to Length(SS)-1 do
 begin
  if SS[i] = '(' then b:=b-1;
  if SS[i] = ')' then b:=b+1;
  if b = 0 then goto 3
 end;


if SS[Length(SS)] = ')' then
begin
if a = 2 then
begin
Delete(SS,1,1);
z:=z*(-1);
end;
Delete(SS,1,1);
Delete(SS,Length(SS),1);
goto 2;
end;
end;
3:
if z = -1 then  Neg:=1
else  Neg:=0;


endp:
end;



procedure TForevalH.FindMainOperation(S:String; var MOP: Integer);
label endp;
var
Pl,Ml: Boolean;
i,b: TIntegType;
E: Exception;
begin
if S = '' then
begin
F_ErrorCode:=E_MISSING_EXPRESSION;
raise ESyntaxError.Create('');
goto endp;
end;

MOP:=_NOP;
b:=0; Pl:=False; Ml:=False;

if S[1] = '(' then b:=-1;

if (S[Length(S)] = '*') or (S[Length(S)] = '/') or (S[Length(S)] = '+') or (S[Length(S)] = '-')
then
begin
F_ErrorCode:=E_MISSING_EXPRESSION;
F_SyntaxErrorString:=Copy(S,1,Length(S));
raise ESyntaxError.Create('');
goto endp;
end;
for i:=2 to Length(S) do
begin
 if S[i] = '(' then b:=b-1;
 if S[i] = ')' then b:=b+1;
 if (b = 0) and ((S[i] = '+') or (S[i] = '-')) then Pl:= True;
 if (b = 0) and ((S[i] = '*') or (S[i] = '/')) then Ml:= True;
end;
if Ml = True then MOP:=_MUL;
if Pl = True then MOP:=_ADD;


endp:
end;


procedure TForevalH.StringAnalizator(S:String; var N: TIntegType; var COP: Integer; var HS:PLevel; var{Neg: Boolean} Neg: Integer);
label endp;
var
SS,SMOP,SMOP1: String;
BH,IH,IH1: PLevel;
i,p,b: TIntegType;
Neg1,MOP,MOP1: Integer;
E: Exception;
begin
if F_ErrorCode <> 0 then goto endp;

FindExternalBracket(Copy(S,1,Length(S)),SS,Neg1);
if SS = '' then
begin F_ErrorCode:=E_MISSING_EXPRESSION;
raise ESyntaxError.Create('');
goto endp;
end;
FindMainOperation(SS,MOP);
if MOP = _ADD then begin MOP1:=_SUB; SMOP:='+'; end
else
if MOP = _MUL then begin MOP1:=_DIV; SMOP:='*'; end;
Neg:=Neg1;
N:=0;

if MOP <> _NOP then
 begin
 p:=1; b:=0;   BH:=IH; IH1:=IH;

 if MOP = _ADD then begin MOP1:=_SUB; SMOP1:='-'; end
 else
 if MOP = _MUL then begin MOP1:=_DIV; SMOP1:='/'; end;

 if SS[1] = '(' then b:=-1;
 for i:=2 to Length(SS)do
  begin
   if SS[i] = '(' then b:=b-1;
   if SS[i] = ')' then b:=b+1;
   if (b =0) and ((SS[i] = SMOP) or (SS[i] = SMOP1)) then
    begin

      if Copy(SS,p,i-p) = '' then
      begin
       F_ErrorCode:=E_MISSING_EXPRESSION;
       raise ESyntaxError.Create('');
       goto endp;
      end;

     N:=N+1;
     SetLength(HS,N);
     HS[N-1].Expression:=Copy(SS,p,i-p);
     HS[N-1].I:=_NOP;
     HS[N-1].ExtArg:=_None;
     if (N-1) > 0 then
     begin
      if SS[p-1] = '-' then  HS[N-1].I:=_SUB   else
      if SS[p-1] = '/' then  HS[N-1].I:=_DIV   else
      if SS[p-1] = '*' then  HS[N-1].I:=_MUL   else
      if SS[p-1] = '+' then  HS[N-1].I:=_ADD;
     end;
     p:=i+1;
    end;
  end;

 N:=N+1;
 SetLength(HS,N);
 HS[N-1].Expression:=Copy(SS,p,Length(SS)-p+1);
 HS[N-1].I:=_NOP;

 if SS[p-1] = '-' then  HS[N-1].I:=_SUB   else
 if SS[p-1] = '/' then  HS[N-1].I:=_DIV   else
 if SS[p-1] = '*' then  HS[N-1].I:=_MUL   else
 if SS[p-1] = '+' then  HS[N-1].I:=_ADD;
 end
else
begin   {только число - конец узла}
 N:=1;
 SetLength(HS,N);
 HS[0].Expression:=Copy(SS,1,Length(SS));
 HS[0].ExtArg:=_None;
end;

COP:=MOP;

endp:
end;




procedure TForevalH.NumberAnalizator(LV: PLevel; ND: TDataNode; var LV1: PLevel; var ND1: TDataNode; var EOFN: Boolean);
label 1,endp;
var
S2: String;
ni,SB: TIntegType;
//Neg: Boolean;
Neg: Integer;
C: TFloatType;
FIN: TFin;
E: Exception;
BH: Boolean;
begin
PackageAnalizator(LV,ND,LV1,ND1,BH,EOFN);
if BH then goto endp;

EOFN:=False;  Neg:=0;
FindVar(LV[0].Expression,ND,ni,FIN,Neg);
if ni <> 0 then
 begin
  if (ni = 1) or (ni = 20) then
  ND.Code:=C_LDSF
  else
  if ni = -1 then
  ND.Code:=C_LDSI;
  ND.FV1:=FIN.F;
  ND.IV1:=FIN.I;
  ND.Neg:=Neg;
  EOFN:=True;
  goto 1;
 end;

SubstParam(LV[0].Expression,S2,C,SB);
if SB = 1 then
begin
ND.V2:=C;
ND.Code:=C_LDSC;  EOFN:=True;
goto 1;
end;

F_ErrorCode:=E_UNKNOWN_SYMBOL;
F_SyntaxErrorString:=Copy(LV[0].Expression,1,Length(LV[0].Expression));
raise ESyntaxError.Create('');

ND.Code:=C_LDSC; EOFN:=True;

1:
ND1:=ND; LV1:=LV;
endp:
end;


procedure TForevalH.PackageAnalizator(LV: PLevel; ND: TDataNode; var LV1: PLevel; var ND1: TDataNode; var BH,EOFN: Boolean);
begin
 EOFN:=False;
 if Copy(LV[0].Expression,1,9) = '@@PACKAGE' then
 begin
  ND1:=ND;
  LV1:=LV;
  ND1.Code:=C_PACKAGE;
  ND1.N:=1;
  Delete(LV1[0].Expression,1,9);
  BH:=True;
 end
 else
 BH:=False;
end;


procedure TForevalH.SetNewVar(Name: String; Addr: Cardinal; VType: Integer);
label endp;
var
i: TIntegType;
Name2,Name1: String;
E: Exception;
begin
try

for i:=0 to High(VarList) do
begin
Name1:=VarList[i].Name;
if  Name = Name1 then
 begin
  //F_ErrorCode:={переменная уже существует}
  goto endp;
 end;

end;

if (VType <> _Double) and  (VType <> _Extended)
   and (VType <> _Integer) and (VType <> _Single)
then
begin
 //F_ErrorCode:={неверный тип переменной}
 goto endp;
end;

SetLength(VarList,Length(VarList)+1);
VarList[High(VarList)].Name:=Copy(Name,1,Length(Name));
VarList[High(VarList)].Addr:=Addr;
VarList[High(VarList)].VType:=VType;


endp:
except
 on E: EOutOfMemory     do F_ErrorCode:=E_OutOfMemory;
end;
if F_ErrorCode <> 0 then raise EInternalError.Create('');

end;





procedure TForevalH.FuncFType2(nf: TIntegType; Arg1: String; var LV: PLevel; var ND: TDataNode; var EOFN: Boolean);
label 1,endp;
var
nt,nt1,nt2,nf1,nif: Integer;
S1,S2,Sa: String;
B1: Boolean;
a,b: TFloatType;
ND1,ND2: TDataNode;
begin
if  F_ErrorCode <> 0 then goto endp;
EOFN:=False;    InitNode(ND);
Sa:=Copy(Arg1,1,Length(Arg1));



SetLength(LV,1); LV[0].I:=_NOP; LV[0].ExtArg:=_None;
if F_Optimization = False then goto 1;
//поиск типа аргумента и сохр. данных, если найден:
FindFuncArgData(Sa,ND,nt);
if (nt <> 0) and (nt < 5) then
begin
if nt = _FAVB then ND.EI:=2
else
if nt = _AAF then ND.EI:=3
else
if nt = _MAF then ND.EI:=4
else
if nt = _AIFB then ND.EI:=5;


 EOFN:=True;
end
else
begin
 //func(Stack):
1: 
 LV[0].Expression:=Copy(Sa,1,Length(Sa));
 ND.EI:=1;  ND.N:=1;
 EOFN:=False;
end;

ND.Code:=nf;
endp:
end;



procedure TForevalH.FuncFType1(nf: TIntegType; Arg1: String; var LV: PLevel; var ND: TDataNode; var EOFN: Boolean);
label 1,endp;
var
nt,nt1,nt2,nf1,nif: Integer;
S1,S2,Sa: String;
B1: Boolean;
a,b: TFloatType;
ND1,ND2: TDataNode;
begin
if  F_ErrorCode <> 0 then goto endp;
EOFN:=False;    InitNode(ND);
Sa:=Copy(Arg1,1,Length(Arg1));



SetLength(LV,1); LV[0].I:=_NOP; LV[0].ExtArg:=_None;
if F_Optimization = False then goto 1;
//поиск типа аргумента и сохр. данных, если найден:
FindFuncArgData(Sa,ND,nt);
if nt = _IAVB then begin ND.EI:=2; EOFN:=True; end
else
if nt = _AAI then begin ND.EI:=3; EOFN:=True; end
else
if (nt = _FAVB) and (ND.V1 = 0) and (Trunc(ND.V2) = ND.V2) then
begin
ND.EI:=2; ND.VI1:=0; ND.VI2:=Trunc(ND.V2); ND.IV1:=1; EOFN:=True;
end
else
//[Stack]
begin
1:
 LV[0].Expression:=Copy(Sa,1,Length(Sa));
 ND.EI:=1;  ND.N:=1;
 EOFN:=False;
end;

ND.Code:=nf;
endp:
end;






procedure TForevalH.FuncFType4(nf: TIntegType; Arg1: String; Arg2: String; var LV: PLevel; var ND: TDataNode; var EOFN: Boolean);
label 1,endp;
var
S1,S2: String;
LVH: PLevel;
nif: Integer;
nt1,nt2: TIntegType;
ND2,ND1: TDataNode;
B: Integer;
begin
if  F_ErrorCode <> 0 then goto endp;

{EI:
1:  S1,S2
2:  FAVB,S2
3:  AAF,S2
4:  MAF,S2
5:  S1,FAVB
6:  FAVB,FAVB
7:  AAF,FAVB
8:  MAF,FAVB
9:  S1,AAF
10:  FAVB,AAF
11: S1,MAF
12: FAVB,MAF
}
nt1:=0; nt2:=0;
S1:=Copy(Arg1,1,Length(Arg1));  S2:=Copy(Arg2,1,Length(Arg2));
SetLength(LV,1); LV[0].I:=_NOP;
InitNode(ND1); InitNode(ND2);
if F_Optimization = False then goto 1;
FindFuncArgData(S1,ND1,nt1); FindFuncArgData(S2,ND2,nt2);



//^AF+B
if nt2 = _FAVB then
 begin
  ND1.V3:=ND2.V1; ND1.V4:=ND2.V2; ND1.FV2:=ND2.FV1;
  if nt1 = _FAVB then begin ND1.EI:=6; EOFN:=True;  end
  else
  if nt1 = _AAF then begin ND1.EI:=7; EOFN:=True; end
  else
  if nt1 = _MAF then begin ND1.EI:=8; EOFN:=True; end
  else
  begin
   ND1.EI:=5; EOFN:=False;
   ND1.N:=1;
   LV[0].Expression:=Copy(S1,1,Length(S1));
  end
 end
else

//^ARGF ;только AF+B, Stack
if (nt2 = _AAF) or (nt2 = _MAF) then
begin
 ND1.PN:=ND2.PN;  ND1.DI:=ND2.DI;
 if nt1 = _FAVB then
  begin
   ND1.V3:=ND1.V1; ND1.V4:=ND1.V2; ND1.FV2:=ND1.FV1; ND1.V1:=0; ND1.FV1:=0;
   if nt2 = _AAF then begin ND1.V2:= 0;  ND1.EI:=10; end
   else
   if nt2 = _MAF then begin ND1.V2:=ND2.V2;   ND1.EI:=12;  end;
   EOFN:=True;
  end
 else
  begin
   EOFN:=False;
   ND1.N:=1;
   if nt2 = _MAF then begin ND1.V2:=ND2.V2; ND1.EI:=11; end
   else
   if nt2 = _AAF then  ND1.EI:=9;
   LV[0].Expression:=Copy(S1,1,Length(S1));
  end
end
else
//^Stack
 begin
  if nt1 = _FAVB then
  begin
   ND1.EI:=2; EOFN:=False;
   ND1.N:=1;
   LV[0].Expression:=Copy(S2,1,Length(S2));
  end
  else
  if nt1 = _AAF  then
  begin
   ND1.EI:=3; EOFN:=False;
   ND1.N:=1;
   LV[0].Expression:=Copy(S2,1,Length(S2));
  end
  else
  if  nt1 = _MAF then
  begin
   ND1.EI:=4; EOFN:=False;
   ND1.N:=1;
   LV[0].Expression:=Copy(S2,1,Length(S2));
  end
  else
  begin
1:
   ND1.EI:=1; EOFN:=False; ND1.N:=2;
   SetLength(LV,2);
   LV[1].Expression:=Copy(S1,1,Length(S1));
   LV[0].Expression:=Copy(S2,1,Length(S2));
  end
end;

ND:=ND1;
ND.Code:=nf;


if nf = C_POWER then
begin
 if (nt2 = _FAVB) and (ND2.V1 = 0) and  (ND2.V2 = 2) then
 begin
  ND.Code:=C_SQR;
  ND.EI:=ND.EI-4; //вместо FuncFTYpe2(0,S1,LV,ND,EOFN);
 end
 else
 if (nt2 = _FAVB) and (ND2.V1 = 0) and  (ND2.V2 = -2) then
 begin
  ND.Code:=C_SQRN;
  ND.EI:=ND.EI-4; //вместо FuncFTYpe2(0,S1,LV,ND,EOFN);
 end
 else
 if (nt2 = _FAVB) and (ND2.V1 = 0) and  (ND2.V2 = 0.5) then
 begin
  ND.Code:=C_SQRT;
  ND.EI:=ND.EI-4; //вместо FuncFType2(0,S1,LV,ND,EOFN);
 end
 else
 if (nt2 = _FAVB) and (ND2.V1 = 0) and  (ND2.V2 = -1) then
 begin
  ND.Code:=C_FPWRDVR;
  ND.EI:=ND.EI-4; //вместо FuncFType2(0,S1,LV,ND,EOFN);
 end
 else
 if ((nt2 = _IAVB) or (nt2 = _AAI)) or ((nt2 = _FAVB) and (ND2.V1 = 0) and (Trunc(ND2.V2) = ND2.V2)) then
 begin
  nf:=C_IPWR;
  FuncFType3(nf,S1,S2,LV,ND,EOFN);
 end
 else
 begin
  ND.Code:=C_FPWR;
 end;

end
else
if nf = C_ROOT then
begin
 if ((nt2 = _IAVB) or (nt2 = _AAI)) or ((nt2 = _FAVB) and (ND2.V1 = 0) and (Trunc(ND2.V2) = ND2.V2)) then
 begin
  nf:=C_IROOT;
  FuncFType3(nf,S1,S2,LV,ND,EOFN);
 end
 else
 begin
  ND.Code:=C_FROOT;
 end;
end;


endp:
end;




procedure TForevalH.SubstParam(S1: String; var S2: String; var C: TFloatType; var SB: TIntegType);
label endp;
var
N,i: TIntegType;
S1h,S3: String;
E: Exception;
begin
if F_ErrorCode <> 0 then goto endp;
C:=0;
if S1 = '' then
begin
F_ErrorCode:=E_MISSING_EXPRESSION;
raise ESyntaxError.Create('');
goto endp;
end;

N:=1; S1h:=Copy(S1,1,Length(S1));  SB:=0;

if S1h[1] = '-' then
begin
N:=-1;
Delete(S1h,1,1);
end;


for i:=1 to High(ParamList) do
begin
 S3:=ParamList[i].Name;
 if F_VarShift = False then
 begin
  S3:=LowerCase(S3);
  S1h:=LowerCase(S1h);
 end;
 if S1h = S3 then
 begin
 C:=N*ParamList[i].Value;
 S2:=FloatToStr(N*ParamList[i].Value);
 SB:=1;
 goto endp;
 end;

end;

try
C:=N*StrToFloat(PointToDec(S1h));
S2:=FloatToStr(C);
SB:=1;
except
SB:=0;
end;


S2:=S1;

endp:
end;




procedure TForevalH.SubstParamC(S1: String; var S2: String; var C: TFloatType; var SB: TIntegType);
label endp;
var
N,i: TIntegType;
S1h,S3: String;
BH: Boolean;
E: Exception;
begin
C:=0;
if F_ErrorCode <> 0 then goto endp;

if S1 = '' then
begin
F_ErrorCode:=E_MISSING_EXPRESSION;
raise ESyntaxError.Create('');
goto endp;
end;

N:=1; S1h:=Copy(S1,1,Length(S1));  SB:=0;

if S1h[1] = '-' then
begin
N:=-1;
Delete(S1h,1,1);
end;



for i:=1 to High(ParamList) do
begin
 S3:=ParamList[i].Name;
 if F_VarShift = False then
 begin
  S3:=LowerCase(S3);
  S1h:=LowerCase(S1h);
 end;
 if S1h = S3 then
 begin
 C:=N*ParamList[i].Value;
 S2:=FloatToStr(N*ParamList[i].Value);
 SB:=1;
 goto endp;
 end;

end;

try
C:=N*StrToFloat(PointToDec(S1h));
SB:=1;
except
SB:=0;
end;

if SB = 0 then
 begin
  CalcConstExpr(S1{S1h},C,BH);
  if BH = True then
  begin
   SB:=1; S2:=FloatToStr(C); goto endp;
  end
  else SB:=0;
 end;

S2:=S1;

endp:
end;




procedure TForevalH.SetParameter(Number: TIntegType; V: TFloatType);
begin
ParamList[Number].Value:=V;
end;


function TForevalH.GetParameter1(Number: TIntegType): TFloatType;
begin
GetParameter1:=ParamList[Number].Value;
end;


function TForevalH.GetParameter2(S: String): TFloatType;
label endp;
var
i: Integer;
S1: String;
begin


for i:=1 to High(ParamList) do
begin
 S1:=ParamList[i].Name;
 if F_VarShift = False then
 begin
  S1:=LowerCase(S1);
  S:=LowerCase(S);
 end;

 if S1 = S then
 begin
 GetParameter2:=ParamList[i].Value; goto endp;
 end;
end;

endp:
end;


procedure TForevalH.SetAdditionalParameter(S: String; V: TFloatType);
label endp;
var
i: Integer;
S1,S2: String;
E: Exception;
begin
try

for i:=1 to High(ParamList) do
begin
S1:=ParamList[i].Name;
if S1 = S then
 begin
 ParamList[i].Value:=V; goto endp;
 end;
end;

//добавление в список нового параметра:
SetLength(ParamList,Length(ParamList)+1);
ParamList[High(ParamList)].Name:=Copy(S,1,Length(S));
ParamList[High(ParamList)].Value:=V;

endp:
except
 on E: EOutOfMemory     do F_ErrorCode:=E_OutOfMemory;
end;
if F_ErrorCode <> 0 then EInternalError.Create('');
end;



procedure TForevalH.FuncFType3(nf: TIntegType; Arg1: String; Arg2: String; var LV: PLevel; var ND: TDataNode; var EOFN: Boolean);
label 1,endp;
var
S1,S2: String;
LVH: PLevel;
nif,N: Integer;
nt1,nt2: TIntegType;
ND2,ND1: TDataNode;
B: Integer;
begin
if  F_ErrorCode <> 0 then goto endp;
{EI:
1:  S1,IAVB
2:  FAVB,IAVB
3:  AAF,IAVB
4:  MAF,IAVB
5:  S1,AAI
6:  FAVB,AAI
7: AAF,AAI
8: MAF,AAI
9: S1,[S2]
10: FAVB,[S2]
11: AAF,[S2]
12: MAF,[S2]
}
nt1:=0; nt2:=0;
S1:=Copy(Arg1,1,Length(Arg1));  S2:=Copy(Arg2,1,Length(Arg2));
SetLength(LV,1); LV[0].I:=_NOP;
InitNode(ND1); InitNode(ND2);
if F_Optimization = False then goto 1;
FindFuncArgData(S1,ND1,nt1); FindFuncArgData(S2,ND2,nt2);


//^Const
if (nt2 = _FAVB) and (ND2.V2 = Trunc(ND2.V2)) and (ND2.V1 = 0) then
 begin
  ND1.VI1:=0; ND1.VI2:=Trunc(ND2.V2); ND1.IV1:=1;
  if nt1 = _FAVB then begin ND1.EI:=2; EOFN:=True;  end
  else
  if nt1 = _AAF then begin ND1.EI:=3; EOFN:=True; end
  else
  if nt1 = _MAF then begin ND1.EI:=4; EOFN:=True; end
  else
  begin
   ND1.EI:=1; EOFN:=False;
   ND1.N:=1;
   LV[0].Expression:=Copy(S1,1,Length(S1));
  end
 end
else
//^(an+b)
if nt2 = _IAVB then
 begin
  ND1.VI1:=ND2.VI1; ND1.VI2:=ND2.VI2; ND1.IV1:=ND2.IV1;
  if nt1 = _FAVB then begin ND1.EI:=2; EOFN:=True;  end
  else
  if nt1 = _AAF  then begin ND1.EI:=3; EOFN:=True; end
  else
  if nt1 = _MAF  then begin ND1.EI:=4; EOFN:=True; end
  else
  begin
   ND1.EI:=1; EOFN:=False;
   ND1.N:=1;
   LV[0].Expression:=Copy(S1,1,Length(S1));
  end
 end
else
//^ARGI
if nt2 = _AAI then
 begin
  ND1.PN1:=ND2.PN1;  ND1.CI:=ND2.CI;
  if nt1 = _FAVB then begin ND1.EI:=6; EOFN:=True;  end
  else
  if nt1 = _AAF then begin ND1.EI:=7; EOFN:=True; end
  else
  if nt1 = _MAF then begin ND1.EI:=8; EOFN:=True; end
  else
  begin
   ND1.EI:=5; EOFN:=False;
   ND1.N:=1;
   LV[0].Expression:=Copy(S1,1,Length(S1));
  end
 end
else
//^Stack
 begin
  if nt1 = _FAVB then
  begin
   ND1.EI:=10; EOFN:=False;
   ND1.N:=1;
   LV[0].Expression:=Copy(S2,1,Length(S2));
  end
  else
  if nt1 = _AAF then
  begin
   ND1.EI:=11; EOFN:=False;
   ND1.N:=1;
   LV[0].Expression:=Copy(S2,1,Length(S2));
  end
  else
  if nt1 = _MAF then
  begin
   ND1.EI:=12; EOFN:=False;
   ND1.N:=1;
   LV[0].Expression:=Copy(S2,1,Length(S2));
  end
  else
  begin
1:  
   ND1.EI:=9; EOFN:=False; ND1.N:=2;
   SetLength(LV,2);
   LV[0].Expression:=Copy(S1,1,Length(S1));
   LV[1].Expression:=Copy(S2,1,Length(S2));
  end
end;

ND:=ND1;
ND.Code:=nf;






if nf = C_IPWR then
begin
 //IPWR3-IPWR16; IPWR3N-IPWR16N   {ND.EI = 1,2,3,4}
 if (nt2 = _FAVB) and  (ND2.V1 = 0) and   (ND2.V2 = Trunc(ND2.V2)) and
    (abs(ND2.V2) >= 3) and (abs(ND2.V2) <= 16) then
 begin
  //EI - совпадает
  N:=abs(Trunc(ND2.V2))-3;
  if ND2.V2 > 0 then ND.Code:=C_IPWR3+N else ND.Code:=C_IPWR3N+N;
 end
 else
 //(-1)^IAVB,AAI
 if ((ND.EI = 2)  or (ND.EI = 6)) and  (ND.V1 = 0) and (ND.V2 = -1) then
 begin
  if ND.EI = 6 then ND.EI:=3;
  ND.Code:=C_IPWRSGN;
  //ND.COP:='IPWRSGN';
 end
 else
 //2^IAVB,AAI
 if ((ND.EI = 2)  or (ND.EI = 6)) and  (ND.V1 = 0) and (ND.V2 = 2) then
 begin
  if ND.EI = 6 then ND.EI:=3;
  ND.Code:=C_I2PWR;
  //ND.COP:='I2PWR';
 end;
end;


endp:
end;






procedure TForevalH.FunctionalAnalizator(nf: TIntegType; A: TFloatType; B: TFloatType; Arg1: String; Arg2: String; var ND: TDataNode; var LV: PLevel; var EOFN: Boolean);
label 1,2,3,endp;
var
ND1: TDataNode;
LV1: PLevel;
EOFN1,BH: Boolean;
begin
if F_ErrorCode <> 0 then goto endp;
EOFN:=False; InitNode(ND);

case  FuncList[nf].FType of
1:    FuncFType1(nf,Arg1,LV,ND,EOFN);
2:    FuncFType2(nf,Arg1,LV,ND,EOFN);
3:    FuncFType3(nf,Arg1,Arg2,LV,ND,EOFN);
4:    FuncFType4(nf,Arg1,Arg2,LV,ND,EOFN);
else
//добавляемые функции:
if FuncList[nf].FType < 0 then
begin
 ExtFunc(nf,ND,LV,ND,EOFN);
end;
end;



if  (A <> 1) or (B <> 0) then
 begin
  ND.F1:=A;
  ND.F2:=B;
  ND.AI:=1;
 end
else
begin
 ND.F1:=1;
 ND.F2:=0;
 ND.AI:=0;
end;


endp:
end;







procedure TForevalH.AddOptimizator(LV:PLevel; ND: TDataNode; var LV1:PLevel; var ND1: TDataNode; var EOFN: Boolean);
label endp;
var
LH,LH1: PLevel;
h,SB,ni,i,nf,vf,st,cf:TIntegType;
z,CA,A,cx,js,C1,nv:TFloatType;
S2: String;
CH: TMass2;
CV: TMass2;
FIN: TFin;
begin
//ADD = AS(Si) + ARGF(ADD)   ;AS-add/sub


if F_ErrorCode <> 0 then goto endp;
SetLength(LV1,0);
st:=0;  //число  стеков
cf:=0;  //флаг присутствия конст.
vf:=0;  //флаг переменных
nv:=0;  //число переменных
h:=0;   //help var
//если в выражении только AMVAB: cx*nf+CA
cx:=0;
nf:=0;


SetLength(CV.FM,Length(VarList)); SetLength(CH.FM,Length(VarList));

for i:=0 to High(VarList) do
begin
CH.FM[i]:=0;
CV.FM[i]:=0;
end;

InitNode(ND1);
CA:=0;


//просмотр списка:
for i:=0 to High(LV) do
begin
 FindAV(LV[i].Expression,ND1,A,FIN,ni);

 //var
 if ni = 1  then
 begin
  if LV[i].I = _SUB then A:=-A;
  CV.FM[FIN.F]:=CV.FM[FIN.F]+A;
  CH.FM[FIN.F]:=1;
  vf:=1;
 end
 else
 //const
 if ni = 20 then
 begin
  if LV[i].I = _SUB then CA:=CA-A else CA:=CA+A;
  nf:=1;
 end
 else
 //Stack
 begin
   if h = 0 then SetLength(LV1,1) else SetLength(LV1,Length(LV1)+1);
   LV1[High(LV1)].Expression:=Copy(LV[i].Expression,1,Length(LV[i].Expression));
   LV1[High(LV1)].I:=LV[i].I;
   h:=1; inc(st);
 end;
end;



//обработка:
if vf <> 0 then
for i:=0 to High(VarList) do
begin
nv:=nv+CH.FM[i];
//только в случае AMVAB:
if CH.FM[i] = 1 then begin nf:=i; cx:=CV.FM[i]; end;
end;


if (st = 0) and (vf = 0)  then
begin
 ND1.V2:=CA;
 ND1.Code:=C_LDSC;
end
else
begin
 if (st = 0) and (nv = 1) then
 begin
  if (CA = 0) and (cx = 1) then
  begin
   ND1.Code:=C_LDSF;
   ND1.FV1:=nf;
  end
  else
  begin
   ND1.Code:=C_FAVB;
   ND1.FV1:=nf;
   ND1.V1:=cx;
   ND1.V2:=CA;
  end;
 end
 else
 if (st <> 0) then
 begin
  ND1.Code:=C_ADD;
  if nv <= 1 then
  begin
   ND1.F2:=CA;
   ND1.F1:=cx;
   ND1.FV1:=nf;
  end
  else
  begin
   ND1.DI:=_AAF;
   ND1.PN:=CV;
   ND1.PN.FC:=CA;
  end
 end;
end;


if st = 0 then EOFN:=True else EOFN:=False;


endp:
end;


procedure TForevalH.FindVar(S1: String; ND: TDataNode; var ni: TIntegType; var FIN:TFin; var {Neg: Boolean} Neg: Integer);
label endp;
var
i: TIntegType;
S2,S3: String;                                //ni = 1 - fl. перем.
begin                                        //ni = -1 - int. перем.
if F_ErrorCode <> 0 then goto endp;  //ni = 0 - перем. не найдена
                                             //FIN.F - номер fl. перем.
S2:=Copy(S1,1,length(S1));                   //FIN.I - номер int. перем.
Neg:=0;
ni:=0; FIN.F:=0; FIN.I:=0;

if S2[1] = '-' then
begin
 Neg:=1;
 Delete(S2,1,1);
end;


for i:=0 to High(VarList) do
begin
S3:=VarList[i].Name;
if F_VarShift = False then
begin
S3:=LowerCase(S3);
S2:=LowerCase(S2);
end;

 if S2 = S3 then
  begin

   if VarList[i].VType = _Integer then
   begin
    ni:=-1;
    FIN.I:=i;
   end
   else
   begin
    ni:=1;
    FIN.F:=i;
   end;

   if (Neg = 1) and  (ND.Neg = 1) then Neg:= 0
   else
   if (Neg = 1) and  (ND.Neg = 0) then Neg:= 1
   else
   if (Neg = 0) and  (ND.Neg = 1) then Neg:= 1
   else
   if (Neg = 0) and  (ND.Neg = 0) then Neg:= 0;
   goto endp;
  end;
end;

//только для ф-ий:
if S2 = '@@func' then
  begin
   ni:=1;
   FIN.F:=0;
   if (Neg = 1) and  (ND.Neg = 1) then Neg:= 0
   else
   if (Neg = 1) and  (ND.Neg = 0) then Neg:= 1
   else
   if (Neg = 0) and  (ND.Neg = 1) then Neg:= 1
   else
   if (Neg = 0) and  (ND.Neg = 0) then Neg:= 0;
   ni:=1;
   goto endp;
  end;

endp:
end;



procedure TForevalH.MulOptH(LV: PLevel; var LV1: PLevel; var C: TFloatType; var Neg: Integer; var BH: Boolean);
var
h, N, SB: TIntegType;
S1: String;
Neg1,COP: Integer;
C1: TFloatType;
i: Cardinal;
begin
C:=0;  h:=0;   Neg:=0;
SetLength(LV1,1); LV[0].I:=_NOP;


for i:=0 to High(LV) do
 begin

 SubstParam(LV[i].Expression,LV[i].Expression,C1{?},SB);
  try
   if LV[i].I = _SUB then N:=-1
   else N:=1;
   C:=C+N*StrToFloat(PointToDec(LV[i].Expression));
  except
   LV1[0].Expression:=Copy(LV[i].Expression,1,Length(LV[i].Expression));
   LV1[0].I:=LV[i].I;
   Neg1:=LV[i].I;
   h:=h+1;
  end;
end;

if h = 1 then
begin
S1:=Copy(LV1[0].Expression,1,Length(LV1[0].Expression));
SetLength(LV1,1); LV1[0].I:=_NOP;
StringAnalizator(S1,N,COP,LV1,Neg);

if ((Neg1 = 1) and (Neg = 0)) or ((Neg1 = 0) and (Neg = 1)) then Neg:=1
else Neg:=0;
if COP = _MUL then BH:=True
else BH:=False;
end
else BH:=False;

end;






procedure TForevalH.MulOptimizator(LV:PLevel; ND: TDataNode;  C: TFloatType; Neg: Integer; var LV1:PLevel; var ND1: TDataNode; var EOFN: Boolean);
label 2,3,4,endp,endp1;
var
PN,PN1: TMass2;
AFB: TDAmvab;
df,ds,ms,mf,mm,dd,h,daf: Integer;
CM,V1,V2,V3,V4,A,B: TFloatType;
nf1,nf2,i,nt,nf,ni,di: Integer;
SD: String;
nds,nx,nxb: Integer;
LV2: PLevel;
begin

//MUL = F1*M(Ai*Xi+Bi)*MD(Si)/ARGF+F2; M - умножения; D - деления;

if F_ErrorCode <> 0 then goto endp1;
SetLength(LV1,0);
ds:=0;  //число деления на стек
df:=0;  //флаг деления на FAVB
ms:=0;  //число умножения на стек
dd:=0;  //флаг деления
mm:=0;  //флаг умножения
mf:=0;  //число переменных умножения (AMVAB)
daf:=0; //флаг ARGF в знаменателе
di:=0;  //_AAF,_MAF
CM:=1;  //const умножения
V1:=0; V2:=0; nf2:=0;//(V1*nf1+V2) - AMVAB(df)
h:=0; nx:=0; nxb:=0;  //help var


SetLength(PN.FM,Length(VarList)); //переменные умножения
for i:=0 to High(PN.FM) do
begin
 PN.FM[i]:=0;
end;
PN.FC:=1;


ND.Neg:=0;    {'-' учитывается в общей проц.}
InitNode(ND1);

if Neg = 1 then CM:=-1;




//просмотр списка:
for i:=0 to High(LV) do
begin

 FindArgType(LV[i].Expression,nt,A,B,nf,ni,PN1{?});
 //const
 if (nt = 1) and  (A = 0) then
 begin
  if LV[i].I = _DIV then CM:=CM/B else CM:=CM*B;
 end
 else
 //AMVAB (mf)
 if (nt = 1) and {(B = 0) and} ((LV[i].I = _MUL) or (LV[i].I = _NOP)) then
 begin
  SetLength(AFB,Length(AFB)+1);
  AFB[High(AFB)].nf:=nf;
  AFB[High(AFB)].A:=A;
  AFB[High(AFB)].B:=B;

  if (B = 0) and (A = -1) then
  begin
   CM:=-CM;
   AFB[High(AFB)].A:=-AFB[High(AFB)].A;  //минус в общий множитель CM
  end;

  inc(mf);
  mm:=1;
  if (nx = 0) and (B = 0) then nx:=mf;
  if (nxb = 0) and (B <> 0) then nxb:=mf;
 end
 else
 {}
 //FAVB (df)
 if (nt = 1) and  (daf = 0) and (df = 0) and (LV[i].I = _DIV) then
 begin
  nf1:=nf; V1:=A; V2:=B;
  df:=1;
  dd:=1;
  SD:=LV[i].Expression+'*';
 end
 else
 //ARGF(+) (daf)
 if (nt = 3) and (daf = 0) and  (df = 0) and (LV[i].I = _DIV) then
 begin
  PN:=PN1;
  daf:=1;
  dd:=1;
  di:=_AAF;
  SD:=LV[i].Expression+'*';
 end
 else
 //ARGF(*) (daf)
 if (nt = 4) and (daf = 0) and  (df = 0) and (LV[i].I = _DIV) then
 begin
  PN:=PN1;
  daf:=1;
  df:=1;
  dd:=1;
  di:=_MAF;
  V3:=A; V4:=B;
  SD:=LV[i].Expression+'*';
 end
 else
 {}
 //Stack
 begin
  if h = 0 then SetLength(LV1,1) else SetLength(LV1,Length(LV1)+1);
  h:=1;
  if LV[i].I = _DIV then inc(ds) else inc(ms);
  LV1[High(LV1)].Expression:=Copy(LV[i].Expression,1,Length(LV[i].Expression));
  LV1[High(LV1)].I:=LV[i].I;
 end;
end;


//изменение порядка AFB: (напр: x*(x+1)->(x+1)*x)
if Length(AFB) <> 0 then
begin
 if (nx = 1) and (nxb <> 0) then
 begin
  nf:=AFB[nx-1].nf;
  A:=AFB[nx-1].A;
  B:=AFB[nx-1].B;
  AFB[nx-1].nf:=AFB[nxb-1].nf;
  AFB[nx-1].A:=AFB[nxb-1].A;
  AFB[nx-1].B:=AFB[nxb-1].B;
  AFB[nxb-1].nf:=nf;
  AFB[nxb-1].A:=A;
  AFB[nxb-1].B:=B;
 end;
end;


//обработка:
if (ds = 0) and (ms = 0) and (daf = 0) and (df = 0) and (mf = 0) then
begin
 ND1.V2:=CM+C;
 ND1.Code:=C_LDSC;
end
else
begin
 if (daf = 0) and (df = 1) then
 begin
  SetLength(PN.FM,Length(VarList));
  for i:=0 to High(PN.FM) do
  begin
   PN.FM[i]:=0;
  end;
  PN.FM[nf1]:=V1;
  PN.FC:=V2;
  di:=_AAF;
 end;
 if (daf = 1) or (df = 1) then
 begin
  ND1.PN:=PN;
  ND1.V1:=V3;
  ND1.V2:=V4;
 end;

 ND1.DI:=di;
 ND1.AFB:=AFB;
 ND1.F2:=C;
 ND1.F1:=CM;
 ND1.Code:=C_MUL;
end;

if (ds+ms) = 0 then EOFN:=True else EOFN:=False;



//добавление в MUL (убрать из AddEndCommand -> FLD1; FDIVRP):
//преобразование комбинаций типа (оставлять в выражении только одно деление и помещать его
//в конец выражения):
//MUL/S1*S2/S3*S4... -> MUL*S1*S2/(S1*S3)
//MUL/S1/S2/S3... -> MUL/(S1*S2*S3) и т.д.


if (ds >= 2) or ((ds+ms >= 2) and (LV1[0].I = _DIV)) or ((ds >= 1) and ((daf =1) or (df = 1))) then
begin
 if (daf = 0) and (df = 0) then SD:='';
 for i:=0 to High(LV1) do
 begin
  if LV1[i].I = _DIV then SD:=SD+LV1[i].Expression+'*'
  else
  begin
   SetLength(LV2,Length(LV2)+1);
   LV2[High(LV2)].Expression:=Copy(LV1[i].Expression,1,Length(LV1[i].Expression));
   LV2[High(LV2)].I:=LV1[i].I;
  end;
 end;

 SetLength(SD,Length(SD)-1);
 SetLength(LV1,Length(LV2)+1);
 for i:=0 to High(LV1)-1 do
 begin
  LV1[i].I:=LV2[i].I;
  LV1[i].Expression:=Copy(LV2[i].Expression,1,Length(LV2[i].Expression));
 end;

 LV1[High(LV1)].I:=_DIV;
 LV1[High(LV1)].Expression:=Copy(SD,1,Length(SD));

 if (df = 1) or (daf = 1) then  ND1.DI:=0;
end;


endp1:
end;





procedure TForevalH.OperationalAnalizator(LV:PLevel; ND: TDataNode; var LV1:PLevel; var ND1: TDataNode; var EOFN: Boolean);
var
C: TFloatType;
BH{,Neg,Neg1}: Boolean;
Neg,Neg1: Integer;
LH,LH1: PLevel;
i: Integer;
begin
LV1:=LV;
ND1:=ND; Neg1:=ND.Neg;

if F_Optimization = True then
begin
//оптимизатор включён:
 if ND.Code = _ADD then
 begin
  MulOptH(LV,LV1,C,Neg,BH);
  if BH = True then
  begin
   if  Neg1 = 1 then C:=-C;

   if (Neg1 = 1) and (Neg = 1) then Neg:=0
   else
   if (Neg1 = 1) and (Neg = 0) then Neg:=1
   else
   if (Neg1 = 0) and (Neg = 1) then Neg:=1
   else
   if (Neg1 = 0) and (Neg = 0) then Neg:=0;

   MulOptimizator(LV1, ND, C, Neg, LV1, ND1, EOFN);


   ND1.Neg:=0;  // минус перед общим выражением учитывается в коэффицентах


  end
  else
  begin
   if BH = False then
   begin
    AddOptimizator(LV, ND, LV1, ND1, EOFN);
    ND1.Neg:=Neg1;
   end
  end
 end
 else
 begin
 //'*'
 MulOptimizator(LV, ND, 0, Neg1, LV1, ND1, EOFN);
 if Neg1 = 1 then ND1.F2:=-ND1.F2;

 ND1.Neg:=0;        // минус перед общим выражением учитывается в коэффицентах

 end;
end
else
//оптимизатор выключен:
begin
 if  ND.Code = _ADD  then ND1.Code:=C_ADD
 else
 if  ND.Code = _MUL  then ND1.Code:=C_MUL;
end;


//для всех комманд:
SetLength(ND1.SGN,Length(LV1));
for i:=0 to High(LV1) do
begin
 ND1.SGN[i]:=LV1[i].I;
 //SGN отличается от .I в [0]:
 if (i = 0) and (LV1[i].I = _NOP) then
 begin
  if ND1.Code  = C_MUL then ND1.SGN[0]:=_MUL
  else
  if ND1.Code = C_ADD then ND1.SGN[0]:=_ADD;
 end;
end;
ND1.N:=Length(LV1);


end;



procedure TForevalH.FindSA(S: String; var LV: PLevel; var A: TFloatType; var N: TIntegType; var BH: Boolean);
label 1;
var
LH,LV1,BL,BL1: PLevel;
CN1,CN2,h,SB,ni,i,ds,COP: Integer;
Neg1,Neg2,Neg: Integer;
C1: TFloatType;
ND: TDataNode;
FIN: TFin;
PN: TMass2;
begin
A:=1;  SetLength(LV,1); LV[0].I:=_NOP;
h:=0;    CN1:=1; CN2:=1;  BH:=False;  BL:=LV; ds:=0;
Neg2:=0;
StringAnalizator(S,N{?},COP,LV1,Neg1);
if COP = _ADD then begin BH:=False; goto 1; end;


if  Neg1 = 1 then CN1:=-1;



 for i:=0 to High(LV1) do
 begin

 SubstParam(LV1[i].Expression,LV1[i].Expression,C1{?},SB);
 if SB = 1 then
  begin
   if  LV1[i].I = _DIV then C1:=1/C1;
   A:=A*C1;
  end
  else
  begin
   FindAMVAB(LV1[i].Expression,ni,FIN{?},PN{?});
   if ni = 1 then begin BH:=False; goto 1; end;
   if h = 0 then
    begin
     if LV1[i].Expression[1] = '-' then
     begin
     CN2:=-1; Delete(LV1[i].Expression,1,1);
     end;
     LV[0].Expression:=Copy(LV1[i].Expression,1,Length(LV1[i].Expression));
     LV[0].I:=LV1[i].I;
     if LV[0].I = _DIV then inc(ds);
    end
    else
    begin
    SetLength(LV,Length(LV)+1);
     LV[High(LV)].Expression:=Copy(LV1[i].Expression,1,Length(LV1[i].Expression));
     LV[High(LV)].I:=LV1[i].I;
     if  LV[High(LV)].I = _DIV then inc(ds);
    end;
   h:=h+1;                                  //2*sin(x)*cos(x)*tan(x)
  end;
 end;


 begin
  LV:=BL;
  N:=h;
  A:=CN1*CN2*A;
 end;



BH:=True;

1:
end;






procedure TForevalH.FindAV(S: String; ND :TDataNode; var A: TFloatType; var FIN: TFin; var ni: TIntegType);
label endp;
var
LV: PLevel;
FIN1:TFIN;
//LVA: PLevel;
{Neg,Neg1,Neg2,}BH: Boolean;
Neg,Neg1,Neg2,COP: Integer;
S1,S2: String;                                       //ni = 0 - нет
N,SB,nv,ni1,NZ: TIntegType;                          //ni = -1 - int. FIN.I
ND1: TDataNode;                                      //ni = 1 - fl.   FIN.F
C1,C,M: TFloatType;                                  //ni = 20 - const;
i: Integer;
begin
ni:=0; nv:=0;  NZ:=1;
StringAnalizator(S,N,COP,LV,Neg);
if  Neg = 1 then NZ:=-1;
ND1.Neg:=0;


if COP = _MUL then
begin

 M:=1;  C:=0; A:=0;

 for i:=0 to High(LV) do
 begin
  SubstParam(LV[i].Expression,S1{?},C,SB);
  if SB = 1 then
  begin
   if  LV[i].I = _DIV then M:=M/C else M:=M*C;
  end
  else
  begin
   FindVar(LV[i].Expression,ND1,ni1,FIN1,Neg2);
   if (ni1 <> 0) and (nv = 0) and ((LV[i].I = _MUL) or (LV[i].I = _NOP)) then
   begin
    inc(nv);
    Neg1:=Neg2; FIN:=FIN1;  ni:=ni1;
    if Neg2 = 1 then NZ:=-NZ;
   end
   else
   begin
    ni:=0;
    goto endp;
   end;
  end;
 end;

end
else
if COP = _NOP then      //const,var
begin
 CalcConstExpr(LV[0].Expression,M,BH);
 if BH = True then  ni:=20
 else
 begin
  FindVar(LV[0].Expression,ND1,ni,FIN,Neg2);
  if ni <> 0 then
  begin
   if {Neg2 = True}Neg2 = 1 then NZ:=-NZ; nv:=1; M:=1;
  end
  else
  begin
   ni:=0;
   goto endp;
  end;
 end;
end
else
begin
 ni:=0;
 goto endp;
end;

if nv = 0 then ni:=20;
A:=NZ*M;


if ND.Neg = 1 then A:=-A;

endp:
end;



procedure TForevalH.FindMV(S: String; var PN: TMass2; var ni: TIntegType);
label 1,endp;
var
S2: String;
N,i,SB,r,SF,SI: TIntegType;
Neg,Neg1,Neg3,COP: Integer;        //ni:
BH: Boolean;                       //A*x*y*...*w*n*k*...j     23
LV: PLevel;                        //A*n*k*...*j              22
ND: TDataNode;                     //A*x*y*...*w              21
A,A1,C1: TFloatType;               //A - PN[Last]
FIN: TFin;
begin

ND.Neg:=0;
BH:=True; SF:=0; SI:=0;  A:=1;
Neg1:=0;  Neg3:=0; Neg:=0;
r:=0;

for i:=0 to High(VarList) do
begin
 PN.FM[i]:=0;
end;


for i:=0 to High(VarList) do
begin
 PN.IM[i]:=0;
end;

StringAnalizator(S,N,COP,LV,Neg);

if COP = _MUL then
begin

 for i:=0 to High(LV) do
 begin
  if LV[i].I = _DIV then goto 1;
  FindVar(LV[i].Expression,ND{?},ni,FIN,Neg1);
  if ni = 0 then
  begin
1:
   try
    SubstParam(LV[i].Expression,S2,C1{?},SB);
    A1:=StrToFloat(PointToDec(S2));
    if LV[i].I = _DIV  then A1:=1/A1;
    A:=A*A1;
   except
    BH:=False;
   end;

  end
  else
  if ni = 1 then
  begin
   PN.FM[FIN.F]:=PN.FM[FIN.F]+1;
   if Neg1 = 1 then Neg3:=1;
   inc(r);
  end
  else
  if ni = -1 then
  begin
   PN.IM[FIN.I]:=PN.IM[FIN.I]+1;
   if Neg1 = 1 then Neg3:=1;
   inc(r);
  end;
   if BH = False then begin ni:=0; goto endp; end;

 end;
end
else BH:=False;

if (BH = False) or (r = 1) then begin ni:=0; goto endp; end;

 for i:=0 to High(VarList) do
  begin
   if PN.FM[i] = 1 then inc(SF);
   if PN.FM[i] > 1 then  begin BH:=False; ni:=0; goto endp; end;
  end;

 for i:=0 to High(VarList) do
  begin
   if PN.IM[i] = 1 then inc(SI);
   if PN.IM[i] > 1 then  begin BH:=False; ni:=0; goto endp; end;
  end;

 ni:=0;


 if (SF > 0) and (SI > 0) then  ni:=23
 else
 if (SF = 0) and (SI > 0) then  ni:=22
 else
 if (SF > 0) and (SI = 0) then  ni:=21
 else ni:=20;


  if ((Neg = 1) and (Neg3 = 0)) or ((Neg = 0) and (Neg3 = 1))
 then A:=-A;

 PN.FC:=A;

if BH = False then ni:=0;
if r = 1 then ni:=0;


endp:
end;



procedure TForevalH.FindMAF(S: String; var PN: TMass2; var B: TFloatType; var BH: Boolean);
var
LV: PLevel;
S2: String;               //A*x*...*w+B;
N,SB,ni: TIntegType;
//Neg: Boolean;
Neg,COP: Integer;
C1: TFloatType;
begin
BH:=True;

StringAnalizator(S,N,COP,LV,Neg);
if (COP = _ADD) and (N = 2) then
begin

try
 SubstParam(LV[0].Expression,S2,C1{?},SB{?});
 B:=StrToFloat(PointToDec(S2));
 FindMV(LV[1].Expression,PN,ni);
 if ni = 21 then
  begin
   if LV[1].I = _SUB then PN.FC:=-PN.FC;
  end
 else BH:=False;
except
 try
  SubstParam(LV[1].Expression,S2,C1{?},SB{?});
  B:=StrToFloat(PointToDec(S2));
  FindMV(LV[0].Expression,PN,ni);
  if ni = 21 then
   begin
    if LV[1].I = _SUB then B:=-B;
   end
  else BH:=False;
 except
  BH:=False;
 end;
end;
end
else
 if COP = _MUL then
 begin
  FindMV(S,PN,ni);
  if ni = 21 then B:=0
  else BH:=False;
  Neg:=0;  //минус учитывается в FindMV
 end
else
BH:=False;

if BH <> False then
 begin
  if {Neg = True}Neg = 1 then
    begin
     PN.FC:=-PN.FC;
     B:=-B;
    end;
 end;


end;



procedure TForevalH.FindAMVAB_FI(S: String; var A: TFloatType; var B: TFloatType; var nf: TIntegType; var ni: TIntegType; var BH: Boolean);
label endp;
var
LV: PLevel;
PN: TMass2;
S2: String;                         //A*i*f+B;
N,SB,vf,vi,i,COP: Integer;          //i - IntegVar; nf - номер
//Neg: Boolean;                     //f - FloatVar; ni - номер
Neg: Integer;
C1: TFloatType;
begin
BH:=True; vf:=0; vi:=0;
SetLength(PN.FM,Length(VarList)); SetLength(PN.IM,Length(VarList));

for i:=0 to High(VarList) do
begin
 PN.FM[i]:=0;
 PN.IM[i]:=0;
end;



StringAnalizator(S,N,COP,LV,Neg);
if (COP = _ADD) and (N = 2) then
begin

try
 SubstParam(LV[0].Expression,S2,C1{?},SB{?});
 B:=StrToFloat(PointToDec(S2));
 FindMV(LV[1].Expression,PN,ni);
 if ni = 23 then
  begin
   if LV[1].I = 1 then PN.FC:=-PN.FC;
  end
 else BH:=False;
except
 try
  SubstParam(LV[1].Expression,S2,C1{?},SB{?});
  B:=StrToFloat(PointToDec(S2));
  FindMV(LV[0].Expression,PN,ni);
  if ni = 23 then
   begin
    if LV[1].I = 1 then B:=-B;
   end
  else BH:=False;
 except
  BH:=False;
 end;
end;
end
else
 if COP = _MUL then
 begin
  FindMV(S,PN,ni);
  if ni = 23 then B:=0
  else BH:=False;
  Neg:=0;  //минус учитывается в FindMV
 end
else
BH:=False;

A:=PN.FC;

for i:=0 to High(VarList) do
begin
 if PN.FM[i] = 1 then begin inc(vf); nf:=i; end;
 if vf > 1 then begin BH:=False; goto endp; end;
end;

for i:=0 to High(VarList) do
begin
 if PN.IM[i] = 1 then begin inc(vi); ni:=i; end;
 if vi > 1 then begin BH:=False; goto endp; end;
end;


if BH <> False then
 begin
  if Neg = 1 then
    begin
     A:=-A;
     B:=-B;
    end;
 end;

endp:
end;



procedure TForevalH.FindAMVAB(S: String; var ni: TIntegType; var FIN: TFin; var PN: TMass2);
label endp;
var                           //ni = 20, - const; - PN.FC
LV: PLevel;                   //ni = 21, - a1*x1+a2*x2+...an*xn+b;   b - PN.FC
ND: TDataNode;                //ni = 22, - a1*i1+a2*i2+...+an*in+b;  b - PN.FC  (ai,b - целые)
i,SF,SI,nv,N,COP: Integer;    //ni = 23, - a1*x1+...+an*in+b;        b - PN.FC (не исп-ся)
A: TFloatType;                //остальные значения ni:
                              //a*var+b, ni = 0,1,-1: a - PN.FM/IM[FIN.F/FIN.I]; b - PN.FC
//Neg: Boolean;               // все коэфф. переменных в PN в соотв. номерах
PH: TMass2;
Neg: Integer;

begin
if F_ErrorCode <> 0 then goto endp;

SF:=0; SI:=0;  ND.Neg:=0;
PN.FC:=0;
SetLength(PN.FM,Length(VarList)); SetLength(PN.IM,Length(VarList));
SetLength(PH.FM,Length(VarList)); SetLength(PH.IM,Length(VarList));

for i:=0 to High(VarList) do
begin
PN.FM[i]:=0;
PH.FM[i]:=0;
end;

for i:=0 to High(VarList) do
begin
PN.IM[i]:=0;
PH.IM[i]:=0;
end;

StringAnalizator(copy(S,1,Length(S)),N{?},COP,LV,Neg);
if COP = _ADD then
begin
for i:=0 to High(LV) do
 begin
  ND.Neg:=LV[i].I;
  FindAV(LV[i].Expression,ND{?},A,FIN,ni);
  if ni = 1 then
  begin
   PN.FM[FIN.F]:=PN.FM[FIN.F]+A;
   PH.FM[FIN.F]:=1;
  end
  else
  if ni = -1 then
  begin
   PN.IM[FIN.I]:=PN.IM[FIN.I]+A;
   PH.IM[FIN.I]:=1;
  end
  else
  if ni = 20 then
   PN.FC:=PN.FC+A
  else
  begin
   ni:=0; goto endp;
  end;
 end;

if Neg = 1 then
begin
 for i:=0 to High(VarList) do
 begin
 PN.FM[i]:=-PN.FM[i];
 end;

 for i:=0 to High(VarList) do
 begin
 PN.IM[i]:=-PN.IM[i];
 end;

 PN.FC:=-PN.FC;
end;

end
else
begin
FindAV(Copy(S,1,Length(S)),ND{?},A,FIN,ni);
if ni = 1   then PN.FM[FIN.F]:=A else
if ni = -1  then PN.IM[FIN.I]:=A else
if ni = 20  then PN.FC:=A;
goto endp;
end;



for i:=0 to High(VarList) do
begin
if PH.FM[i] <> 0 then begin inc(SF); nv:=i; FIN.F:=i; end;
end;

for i:=0 to High(VarList) do
begin
if PH.IM[i] <> 0 then begin inc(SI); nv:=i; FIN.I:=i; end;
end;

ni:=0;

if (SF >= 1) and (SI >= 1) then ni:=23
else
if (SF = 1) and (SI = 0)  then  ni:=1
else
if (SF = 0) and (SI = 1)  then ni:=-1
else
if (SF > 1) and (SI = 0)  then ni:=21
else
if (SF = 0) and (SI > 1)  then ni:=22
else
if (SF = 0) and (SI = 0)  then ni:=20;


endp:
end;







procedure TForevalH.FindArgType(S: String; var nt: TIntegType; var A: TFloatType; var B: TFloatType; var nf: TIntegType; var ni: TIntegType; var PN: TMass2);
label 1;
var                             //nt:
S1,S2: String;                  //0: type is absent
IB: Boolean;                    //1: a*f+b, const.          i - IntegVar
i,SB: TIntegType;               //2: a*i*f+b                f - FloatVar
{Neg,}BH: Boolean;              //3: a1*x+a2*y+...+a12      (AAF)
C: TFloatType;                  //4: a*x*y*...*w+b          (MAF)
ND: TDataNode;                  //5: a*i+b     ;a,b - Integ.
FIN: TFin;
Neg: Integer;
begin                           //6: a1*n+a2*k+...+a5*j+a6  (all const. - Integ)
nt:=0;   {ND.Neg:=False;}       //7: a1*n+a2*k+...+a5*j+a6  (any const. - Float)
S1:=Copy(S,1,Length(S));
S2:=Copy(S,1,Length(S));
nf:=0; ni:=0;
ND.Neg:=0;

//const:
FindExternalBracket(S1,S2,Neg);
SubstParamC(S2,S2,C,SB);
if SB = 1 then
begin
 nt:=1; //в случае const. - a*x+b; (a = 0)
 A:=0;
 B:=C;
 ni:=0;
 nf:=1; //в случае const. ссылка на X;
 if Neg = 1 then B:=-B;
 goto 1;
end;


FindFIAV(S1,ni,FIN,A,B,PN);
//a*x+b:
if ni = 1 then
begin
 nf:=FIN.F;
 nt:=1;
 goto 1;
end
else
//a*n+b:
if (ni = -1) then
begin
 if A = 0 then       //если const. - то ссылка на a*x+b
  begin
   nt:=1; A:=0; nf:=1;  goto 1;
  end;
 ni:=FIN.I;
 if (Trunc(A) = A) and (Trunc(B) = B)  then
 begin
  nt:=5;
 end
 else
 begin
  nt:=7;
  for i:=0 to High(VarList) do
  begin
   PN.IM[i]:=0;
  end;
  PN.FC:=B;
  PN.IM[ni]:=A;
 end;

 goto 1;
end
else
//a1*x+a2*y+...+a12:
if ni = 21 then
begin
 nt:=3;
 goto 1;
end
else
//a1*n+a2*k+...+a5*j+a6:
if ni = 22 then
begin
 IB:=True;
 for i:=0 to High(VarList) do
 begin
  if Trunc(PN.IM[i]) <> PN.IM[i] then IB:=False;
 end;
 if Trunc(PN.FC) <> PN.FC then IB:=False;

 if IB = True then nt:=6
 else nt:=7;

 goto 1;
end;



//a*x*y*...*w+b:
FindMAF(S1,PN,B,BH);
if BH = True then
begin
 nt:=4;
 goto 1;
end;



//a*x*n+b:
FindAMVAB_FI(S1,A,B,nf,ni,BH);
if BH = True then
begin
 nt:=2;
 goto 1;
end;

1:
end;



procedure TForevalH.FindFIAV(S1: String; var ni: TIntegType; var FIN: TFin; var A,B: TFloatType; var PN: TMass2);
label endp;
begin
if F_ErrorCode <> 0 then goto endp;
A:=0; B:=0;
FindAMVAB(S1,ni,FIN,PN);

if ni = 1 then
begin
 a:=PN.FM[FIN.F];
 b:=PN.FC;
end
else
if ni = -1 then
begin
 a:=PN.IM[FIN.I];
 b:=PN.FC;
end;

endp:
end;


procedure TForevalH.WriteArgData(nt: TIntegType; A: TFloatType; B: TFloatType; ni: TIntegType; nf: TIntegType; PN: TMass2; var ND: TDataNode);
begin
InitNode(ND);
if (nt <> 0) then
begin
if nt = _FAVB then
begin
ND.V1:=A; ND.V2:=B;  ND.FV1:=nf;
end
else
if nt = _AIFB then
begin
ND.V1:=A; ND.V2:=B;  ND.FV1:=nf; ND.IV1:=ni;
end
else
if nt = _AAF then
begin
ND.PN:=PN; ND.DI:=_AAF;
end
else
if nt = _MAF then
begin
ND.DI:=_MAF; ND.V2:=B;  ND.PN:=PN;
end
else
if nt = _IAVB then
begin
ND.VI1:=Trunc(A); ND.VI2:=Trunc(B); ND.IV1:=ni;
end
else
if nt = _AAI then
begin
ND.PN1:=PN; ND.CI:=_AAI;
end
else
if nt = _AFI then
begin
ND.PN:=PN; ND.DI:=_AFI;
end;
end;
end;





procedure TForevalH.FindFuncArgData(S: String;  var ND: TDataNode; var nt: TIntegType);
var
ni,nf: TIntegType;
A,B: TFloatType;
PN: TMass2;
begin
FindArgType(S,nt,A,B,nf,ni,PN);
if (nt <> 0)  then
begin
WriteArgData(nt,A,B,ni,nf,PN,ND);
end;
end;




procedure TForevalH.FindAFB(S: String; var A: TFloatType; var B: TFloatType; var BH: Boolean);
label 1;
var
N,SB,ni,nv,COP: Integer;
{Neg: Boolean;}                  //a*x+b; используется только для функций
Neg: Integer;
S1: String;
LV: PLevel;
ND: TDataNode;
FIN: TFin;
PN: TMass2;
A1: TFloatType;
i: Cardinal;
begin
A:=0; B:=0; BH:=False; nv:=0;   Neg:=0;
ni:=0;   ND.Neg:=0;
StringAnalizator(S,N{?},COP,LV,Neg);
if COP = _ADD then
begin

 for i:=0 to High(LV) do
 begin
  ND.Neg:=LV[i].I;
  FindAV(LV[i].Expression,ND{?},A1,FIN,ni);

  if (ni = 1) and (nv = 0) and (FIN.F = 0) then
  begin
   nv:=1;  A:=A1;
  end
  else
  if ni = 20 then
  B:=B+A1
  else
  begin
   BH:=False; goto 1;
  end;

 end;

  if Neg = 1 then
  begin
   A:=-A; B:=-B;
  end;

  if nv = 0 then BH:=False else BH:=True;
  goto 1;

end
else
//COP = _MUL,_NOP
begin
 FindAV(S,ND{?},A1,FIN,ni);
 if (ni = 1) and (FIN.F = 0) and (A1 <> 0) then
 begin
  B:=0; A:=A1; BH:=True;
 end
 else
 BH:=False;
end;


1:
end;





procedure TForevalH.CalcConstExpr_MUL(LVA: PLevel;  var A: TFloatType; var BH: Boolean);
label endp;
var
COP,S1: String;
N,SB,i: Integer;
Neg: Boolean;
LV: PLevel;
LVA1: PLevel;
C,S,M: TFloatType;
begin
M:=1; BH:=True; C:=0; A:=0;

 for i:=0 to High(LVA) do
 begin
  SubstParam(LVA[i].Expression,S1{?},C,SB);
  if SB = 1 then
  begin
   if {LVA[i].Inv = True}LVA[i].I = _DIV then M:=M/C else M:=M*C;
   BH:=True;
  end
  else
  begin
   BH:=False;
   goto endp;
  end;
 end;


A:=M;

endp:
end;



procedure TForevalH.CalcConstExpr(S: String; var A: TFloatType; var BH: Boolean);
label endp;
var
S1,S2: String;
N,SB,i: Integer;
Neg,Neg1,COP: Integer;
LV,LV1: PLevel;
C: TFloatType;
begin

S2:=Copy(S,1,Length(S));
StringAnalizator(S2,N,COP,LV,Neg);
A:=0;  C:=0;
if COP = _MUL then
begin
 CalcConstExpr_MUL(LV,C,BH);
 if BH = True then begin A:=C; goto endp; end else begin BH:=False; goto endp; end;
end
else
if COP = _ADD then
begin

 for i:=0 to High(LV) do
 begin
   StringAnalizator(LV[i].Expression,N,COP,LV1,Neg1);

   if COP = _NOP then
   begin
    SubstParam(LV[i].Expression,S1{?},C,SB);
    if SB = 1 then
    begin
     if LV[i].I = 1 then C:=-C;
    end
    else
    begin
     BH:=False; goto endp;
    end;
   end
   else
   if COP = _MUL then
   begin
    CalcConstExpr_MUL(LV1,C,BH);
    if BH = False then  goto endp;
    if  LV[i].I = _SUB then C:=-C;
   end
   else
   begin BH:=False; goto endp; end;

   if Neg1 = 1 then C:=-C;
   A:=A+C;
 end; //end for
BH:=True;
end
else
if COP = _NOP then
begin
 SubstParam(S,S1{?},C,SB);
  if SB = 1 then
  begin
   if {Neg = True}Neg = 1 then C:=-C;
   A:=C;
   BH:= True;
   goto endp;
  end;
 BH:=False; goto endp;
end;




endp:
if Neg = 1 then A:=-A;
end;






procedure TForevalH.FindConstItem(LM: PLevel; {Neg: Boolean;}Neg: Integer;  T: Integer; var LM1: PLevel; var A,B: TFloatType; var BH: Boolean);
label 1,endp;
var
i,N,N1,N2,SB,Inv,Ng,h: Integer;
S,S1: String;
LM2: PLevel;
//Neg1: Boolean;                        //* = '*','/'
LV1: PLevel;                            //A*S1*..*Sn+B
C: TFloatType;                          //A,B - совокупность const.
Neg1,COP: Integer;
begin
SetLength(LM1,1);
if T = 1 then
begin
 LM2:=LM; A:=1;
 if LM[1].Expression[1] = '-' then begin A:=-1; Delete(LM[1].Expression,1,1);  end;
 goto 1;
end;

B:=0; h:=0; BH:=False;
for i:=1 to  High(LM) do
begin
 SubstParam(LM[i].Expression,S1{},C,SB);
 if SB = 1 then
 begin
  if LM[i].I = _SUB then C:=-C;
  B:=B+C;
 end
 else
 begin
  h:=h+1;
  S:=LM[i].Expression;
  if LM[i].I = _SUB then N:=-1 else N:=1;
 end;
end;


if h = 1 then
begin
 StringAnalizator(S,N2{?},COP,LV1,Neg1);
 if COP = _MUL then
 begin
  if Neg1 = 1 then N1:=-N1 else N1:=1;
  A:=N*N1;
1:
  for i:=1 to High(LM2) do
  begin
   if LM2[i].I = _DIV then Inv:=1 else Inv:=0;
   SubstParam(LM2[i].Expression,S1,C,SB);
   if SB = 1 then
   begin
    if Inv = 1 then C:=1/C;
    A:=A*C;
   end
   else
   begin
    SetLength(LM1,Length(LM1)+1);
    LM1[High(LM1)].Expression:=Copy(LM2[i].Expression,1,Length(LM2[i].Expression));
    LM1[High(LM1)].I:=LM2[i].I;
   end;
  end;
  BH:=True;
  if Neg = 1 then begin A:=-A; B:=-B;  end;
 end
 else
 BH:=False;
end
else
BH:=False;

endp:
end;





procedure TForevalH.FindFactSymb(S1: String; var S2: String);
label 1,2,endp;
var
Sa: String;
pb,bb,b,i,pb1: TIntegType;
begin
Sa:=Copy(S1,1,Length(S1));        //замена функции fact в виде A!,(A)! на fact(A)

2:
b:=0; pb:=0;
for i:=1 to Length(Sa) do
begin
 if Sa[i] = ')' then b:=b-1;
 if Sa[i] = '(' then b:=b+1;
 if (Sa[i] = '!') and (b = 0) then pb:=i;
end;

if pb = 0 then goto endp;

bb:=0;  pb1:=0;  i:=pb-1;
while  i > 0 do
begin
 if Sa[i] = ')' then bb:=bb-1;
 if Sa[i] = '(' then bb:=bb+1;
 if ((Sa[i] = '*') or (Sa[i] = '/') or (Sa[i] = '+') or
 (Sa[i] = '-') or (Sa[i] = '^'))  and (bb = 0) then
  begin pb1:=i+1; goto 1; end;
  i:=i-1;
end;
1: if   pb1 = 0 then begin pb1:=1; S1:=Copy(Sa,1,pb-1); end
   else
    S1:=Copy(Sa,pb1,pb-pb1);

if (S1[1] = '(') and (S1[Length(S1)] = ')') then  begin Delete(S1,1,1); Delete(S1,Length(S1),1); end;
Delete(Sa,pb1,pb-pb1+1);
Insert('fact'+'('+S1+')',Sa,pb1);
goto 2;

endp:
S2:=Copy(Sa,1,Length(Sa));
end;



procedure TForevalH.FindPowerSymb(S1: String; var S2: String);
label 1,2,3,endp;
var
Sa: String;
pb,bb,i,pb1,pb2: TIntegType;
E: Exception;
begin                         //замена выражения вида A^B,(A)^(B) выражением power(A,B)
Sa:=Copy(S1,1,Length(S1));

3:
pb:=0; bb:=0;
for i:=1 to Length(Sa) do
begin
 if Sa[i] = ')' then bb:=bb-1;
 if Sa[i] = '(' then bb:=bb+1;
 if (Sa[i] = '^') and (bb = 0) then pb:=i;
end;

if pb = 0 then goto endp;

bb:=0;  pb1:=0;  i:=pb-1;
while  i > 0 do
 begin
 if Sa[i] = ')' then bb:=bb-1;
 if Sa[i] = '(' then bb:=bb+1;
 if ((Sa[i] = '*') or (Sa[i] = '/') or (Sa[i] = '+') or
    (Sa[i] = '-') or (Sa[i] = '^') )  and (bb = 0) then
    begin pb1:=i+1; goto 1; end;
     i:=i-1;
 end;

1: if   pb1 = 0 then begin pb1:=1; S1:=Copy(Sa,1,pb-1); end
   else
    S1:=Copy(Sa,pb1,pb-pb1);


bb:=0; i:=pb+1; pb2:=0;
while i <= Length(Sa)  do
 begin
 if Sa[i] = ')' then bb:=bb-1;
 if Sa[i] = '(' then bb:=bb+1;
 if ((Sa[i] = '*') or (Sa[i] = '/') or (Sa[i] = '+') or
    (Sa[i] = '-') or (Sa[i] = '^')) and (i <> pb+1) and (bb = 0) then
    begin pb2:=i-1; goto 2; end;
 if (Sa[i] = '|') and (bb = 0) and (i <> pb+1) then begin pb2:=i; goto 2; end;
 i:=i+1;
 end;
 if pb2 = 0 then pb2:=Length(Sa);
2:
 S2:=Copy(Sa,pb+1,pb2-pb);
 if (S1 = '') or (S2 = '') then        //отсутствует аргумент
 begin
 F_ErrorCode:=E_INCOINCIDENCE_NUMBER_ARGUMENTS;
 F_SyntaxErrorString:=Copy(Sa,1,Length(Sa));
 raise ESyntaxError.Create('');
 goto endp;
 end;
 if (S1[1] = '(') and (S1[Length(S1)] = ')') then  begin Delete(S1,1,1); Delete(S1,Length(S1),1); end;
 if (S2[1] = '(') and (S2[Length(S2)] = ')') then  begin Delete(S2,1,1); Delete(S2,Length(S2),1); end;
 Delete(Sa,pb1,pb2-pb1+1);
 Insert('power('+S1+','+S2+')',Sa,pb1);
 goto 3;


endp:
S2:=Copy(Sa,1,Length(Sa));
end;






procedure TForevalH.FindFuncSymb(S1: String; var S2: String);
begin                  //порядок не менять
FindFactSymb(S1,S1);
FindPowerSymb(S1,S2);
end;




procedure   TForevalH.ReplaceAbsBr(S: String; var S1: String);
label 1,endp;

             function GetTypeAbsBr(p: Integer; S: String): Integer;
             begin
              if p = 1 then GetTypeAbsBr:=1
              else
              if p = Length(S) then GetTypeAbsBr:=2
              else
              if (S[p-1] = '+') or (S[p-1] = '-') or (S[p-1] = '*') or
                 (S[p-1] = '/') or (S[p-1] = '^') or (S[p-1] = '(') or
                 (S[p-1] = '[') or (S[p-1] = '{') or (S[p-1] = ',')
                 then GetTypeAbsBr:=1
              else
               GetTypeAbsBr:=2;
             end;


var
 i,L,p,t: Integer;
begin
L:=Length(S); p:=1;
//||x-1|+|x+1||-|x-|x+|x-1|-|x+1||+y|
while p < L do
begin
  for i:=p to L do
  begin
   if S[i] = '|' then
   begin
     p:=i; goto 1;
   end;
  end;
  goto endp;
1:
  t:=GetTypeAbsBr(p,S);
  if t = 1 then
  begin
   Delete(S,p,1); Insert('abs(',S,p); p:=p+3
  end
  else
  if t = 2 then
  begin
    Delete(S,p,1); Insert(')',S,p);
  end;

  L:=Length(S);
end;

endp:
S1:=Copy(S,1,Length(S));
end;




procedure   TForevalH.ReplaceTruncBr(S: String; var S1: String);
label 1,endp;
var
 i,L,p,t: Integer;
begin
L:=Length(S); p:=1;
//[[x-1]+[x+1]]-[x-[x+[x-1]-[x+1]]+y]
while p < L do
begin
  for i:=p to L do
  begin
   if S[i] = '[' then
   begin
     p:=i; t:=1; goto 1;
   end
   else
   if S[i] = ']' then
   begin
     p:=i; t:=2; goto 1;
   end;
  end;
  goto endp;
1:

  if t = 1 then
  begin
   Delete(S,p,1); Insert('trunc(',S,p); p:=p+5
  end
  else
  if t = 2 then
  begin
    Delete(S,p,1); Insert(')',S,p);
  end;

  L:=Length(S);
end;

endp:
S1:=Copy(S,1,Length(S));
end;


procedure TForevalH.FindFunction(S: String; var A: TFloatType; var B: TFloatType; var Arg1: String; var Arg2: String; var nf: TIntegType; var BH: Boolean);
label 1,2,3,4,endp;
var
i,k,l,bb,pf,pr,b1,b2,FType,INF,nif: Integer;
S1,Sa,Sf,Sf1,Sfn: String;
//Neg: Boolean;
Neg: Integer;
E: Exception;
begin
A:=0; B:=0;
if F_ErrorCode <> 0 then goto endp;
BH:=False;            //поиск A*func(Arg1{,Arg2})+B, nf-номер ф-ии, (nf=0: BH=False)

FindExternalBracket(S,S,Neg);
if F_SyntaxExtension = True then begin FindFuncSymb(S,Sa); S1:=Copy(Sa,1,Length(Sa)); end
else S1:=Copy(S,1,Length(S));

//поск функции:
nf:=0; bb:=0;  pf:=0; b1:=0;
for i:=1 to Length(S1) do
begin
 if S1[i] = '(' then begin b1:=i; goto 1; end;
end;
if b1 = 0 then goto endp;

1:
b2:=0; bb:=-1;
for i:=b1+1 to Length(S1) do
begin
 if S1[i] = '(' then bb:=bb-1;
 if S1[i] = ')' then bb:=bb+1;
 if (S1[i] = ')') and (bb = 0) then begin b2:=i; goto 2; end;
end;
2:
i:=b1-1;  pf:=1;
while i <> 0 do
begin
 if (S1[i] = '*') or (S1[i] = '+') or (S1[i] = '/') or (S1[i] = '-') or (S1[i] = '^')
   then begin pf:=i+1; goto 3; end;
 i:=i-1;
end;
3:
nf:=0;
Sf:=Copy(S1,pf,b1-pf);
Sa:=Copy(S1,b1+1,b2-b1-1);
if Sf = '' then goto endp;

if F_FuncShift = False then Sf1:=LowerCase(Sf) else Sf1:=Sf;

if F_SyntaxExtension = True then
begin
for k:=1 to Length(FuncList)-1 do
 begin
  for l:=1 to Length(FuncList[k].Name)-1 do
   begin
    Sfn:=FuncList[k].Name[l];
    if F_FuncShift = False then
    begin
     Sfn:=LowerCase(Sfn);
    end;
    if Sf1 = Sfn then  begin nf:=k;  goto 4; end;
   end;
 end
end
else
for k:=1 to Length({External}FuncList)-1 do
 begin
  for l:=1 to 1 do
   begin
    Sfn:={External}FuncList[k].Name[l];
    if F_FuncShift = False then
    begin
     Sfn:=LowerCase(Sfn);
    end;
    if Sf1 = Sfn then  begin nf:=k;  goto 4; end;
   end;
 end;

F_ErrorCode:=E_UNKNOWN_FUNCTION; //UknownFunction
F_SyntaxErrorString:=Copy(Sf,1,Length(Sf));
raise ESyntaxError.Create('');
goto endp;

4:
 if nf <> 0 then
 begin
  FType:=FuncList[nf].FType;
  if FType = 0 then begin BH:=False; goto endp; end; //введено специально для @@PACKAGE
  //определение FType через FindInternalNum только для добавляемых ф-ий !!!
  if  {ExternalFuncList[nf].FType < 0} FType < 0 then
  begin
   //ф-ии с  переменным числом аргументов:
   if (FType <= -11) and (FType >= -14) then INF:=1 else INF:=0;
  end;

  Delete(S1,pf,b2-pf+1);
  Insert('@@func',S1,pf);

  FindAFB(S1,A,B,BH);          //BH = True если найдено выражение a*func+b

  if BH = True then
  begin                //без аргументов:                  //с переменным числом аргументов:
    if  (Sa = '') and ({External}FuncList[nf].arg <> 0) and (INF = 0)
    then
    begin
     F_ErrorCode:=E_INCOINCIDENCE_NUMBER_ARGUMENTS;
     F_SyntaxErrorString:=Copy(S,1,Length(S));
     raise ESyntaxError.Create('');
     goto endp;
    end;


    FindManyArg(Sa,nf);
    if INF = 1 then
    begin
     FuncList[nf].arg:=High(ArgM);
    end;

    if FuncList[nf].arg <> High(ArgM) then
    begin
     F_ErrorCode:=E_INCOINCIDENCE_NUMBER_ARGUMENTS;
     F_SyntaxErrorString:=Copy(S,1,Length(S));
     raise ESyntaxError.Create('');
     goto 4;
    end;
    if FuncList[nf].arg = 2 then
    begin
     Arg1:=Copy(ArgM[1],1,Length(ArgM[1]));
     Arg2:=Copy(ArgM[2],1,Length(ArgM[2]));
    end
    else
    if FuncList[nf].arg = 1 then
    begin
     Arg1:=Copy(ArgM[1],1,Length(ArgM[1]));
    end;


   if Neg = 1 then
   begin
    A:=-A; B:=-B;
   end
  end
  else
  nf:=0;
 end;



endp:
end;




procedure TForevalH.FindManyArg(S: String; nf: Integer);
label endp;
var
i,N,bb,nif,FType,INF: Integer;
PP: TArrayI;
E: Exception;
begin

bb:=0;
N:=1; SetLength(PP,N+1); PP[1]:=0;
FType:=FuncList[nf].FType;
if  FType < 0 then
begin
 //ф-ии с  переменным числом аргументов:
 if (FType <= -11) and (FType >= -14) then INF:=1 else INF:=0;
end;

//функция без аргументов:
if (S = '') and  (({External}FuncList[nf].arg = 0) or (INF = 1))  then
begin
SetLength(ArgM,1);
goto endp;
end;

for i:=1 to Length(S) do
begin
 if S[i] = '(' then bb:=bb-1;
 if (bb = 0) and (S[i] = ',') then begin inc(N); SetLength(PP,N+1); PP[N]:=i; end;
 if S[i] = ')' then bb:=bb+1;
end;

inc(N);  SetLength(PP,N+1); PP[N]:=Length(S)+1;

SetLength(ArgM,N);

for i:=1 to N-1 do
begin
ArgM[i]:=Copy(S,PP[i]+1,PP[i+1]-PP[i]-1);
if (ArgM[i] = '')  then
begin
F_ErrorCode:=E_INCOINCIDENCE_NUMBER_ARGUMENTS;
F_SyntaxErrorString:=Copy(S,1,Length(S));
raise ESyntaxError.Create('');
goto endp;
end;
end;

endp:
end;



procedure TForevalH.ExtFunc(nf: TIntegType; ND: TDataNode; var LV: PLevel; var ND1: TDataNode; var EOFN: Boolean);
label 1;
var
LH,BL: PLevel;
i,nif,S: Integer;
begin
ND1:=ND;
EOFN:=False;


SetLength(LV,1); LV[0].I:=_NOP; LV[0].ExtArg:=_None;
//для функций без аргументов:
if FuncList[nf].arg = 0 then
begin
ND1.N:=0;
EOFN:=True;
goto 1;
end;

LV[0].Expression:=Copy(ArgM[1],1,Length(ArgM[1]));
for i:= 2 to High(ArgM) do
begin
SetLength(LV,Length(LV)+1);
LV[i-1].Expression:=Copy(ArgM[i],1,Length(ArgM[i]));
LV[i-1].I:=_NOP;
end;

ND1.N:=High(ArgM);


1:
ND1.Code:=nf;
for i:=0 to High(LV) do
begin
 if (FuncList[nf].FType < 0) then
 begin
  if FuncList[nf].ArgType = _Differ then
     LV[i].ExtArg:=FuncList[nf].ArgTypeList[i]
  else
     LV[i].ExtArg:=FuncList[nf].ArgType;
 end
end;


//Для добавл. ф-ий через память:
//Вычисление смещений адресов аргументов для их последовательного расположения в памяти.
//Т.к. размерность ячеек стека = 10(Extended) не зависимо от размерности аргументов, то
//для последовательного расположения аргументов в памяти (вплотную, друг за другом!!!) в
//случаях размерностей аргументов меньших Extended: Single,Double,Integer нужно вычислять
//смещения от начальных адресов аргументов (ячеек стека)
//в этом случае аргументы располагаются в памяти:
//@1 = @1; @2 = @1+S1; @3 = @1+S1+S2; @4 = @1+S1+S2+S3;...;
//@1 - адрес первого аргумента; Si - размеры соотв.(i-ых) аргументов в байтах;
//иначе (без смещения): @1 = @1; @2 = @1+10; @3 = @2+10; ...; 10 - размер ячейки стека.
//(для остальных ф-ий смещения адресов аргументов = 0!!!)


LV[0].SExtArg:=0;  S:=0;
if F_CloseArg then
begin
 case FuncList[nf].FType of
      -3,  -4, -5, -6, -7, -11, -12, -13, -14:
  begin
    SetLength(ND1.SNExtArg,Length(LV));
    ND1.SNExtArg[0]:=0;
  end;
 end;
end;


for i:=1 to High(LV) do
begin
 LV[i].SExtArg:=0;

 if F_CloseArg then
 begin
  case FuncList[nf].FType of
        -3 , -4 , -5 , -6 , -7 , -11 , -12 , -13 , -14:
   begin
    case LV[i-1].ExtArg of
      _Integer:  S:=S+4;
      _Single:   S:=S+4;
      _Double:   S:=S+8;
     _Extended: S:=S+10;
    end;

   LV[i].SExtArg:=i*10-S; //10 - размерность ячейки стека (extended)
   ND1.SNExtArg[i]:=LV[i].SExtArg;
   end;
  end;
 end;

end;


if FuncList[nf].NST = -1 then F_OverFlowFunc:=True;

end;




procedure TForevalH.XchangeAddingBracket(S: String; var S1: String);
var
i: TIntegType;
begin
S1:=Copy(S,1,Length(S));
for i:=1 to Length(S1) do
 begin
  if   (S1[i] = '{') then
   begin Delete(S1,i,1); Insert('(',S1,i); end;
  if   (S1[i] = '}') then
   begin Delete(S1,i,1); Insert(')',S1,i); end;
 end;
end;


procedure TForevalH.PrevTreat(S: String; var S1: String);
label endp;
var
b1,b2,i: TIntegType;
E: Exception;
begin
if S = '' then S:='0';
if F_SyntaxExtension = True then
begin
 XchangeAddingBracket(S,S);
 ReplaceAbsBr(S,S);
 ReplaceTruncBr(S,S);
end;


F_ErrorCode:=0;
b1:=0; b2:=0;
for i:=1 to Length(S)-1 do
begin
if (S[i] = ')') and ((S[i+1] <> '*') and  (S[i+1] <> '+') and
   (S[i+1] <> '-') and (S[i+1] <> '/') and (S[i+1] <> '^') and
   (S[i+1] <> '!') and (S[i+1] <> ')') and (S[i+1] <> ',') and (S[i+1] <> '&')) then
begin
 F_ErrorCode:=E_MISSING_OPERATION;      //отсутствует операция
 F_SyntaxErrorString:=Copy(S,1,Length(S));
 raise ESyntaxError.Create('');
 goto endp;
end;

if ((S[i] = '*') and ((S[i+1] = '*') or  (S[i+1] = '+') or
   (S[i+1] = '-') or (S[i+1] = '/') or (S[i+1] = '^') or
   (S[i+1] = '!'))) or
   ((S[i] = '/') and ((S[i+1] = '*') or  (S[i+1] = '+') or
   (S[i+1] = '-') or (S[i+1] = '/') or (S[i+1] = '^') or
   (S[i+1] = '!'))) or
   ((S[i] = '-') and ((S[i+1] = '*') or  (S[i+1] = '+') or
   (S[i+1] = '-') or (S[i+1] = '/') or (S[i+1] = '^') or
   (S[i+1] = '!'))) or
   ((S[i] = '+') and ((S[i+1] = '*') or  (S[i+1] = '+') or
   (S[i+1] = '-') or (S[i+1] = '/') or (S[i+1] = '^') or
   (S[i+1] = '!'))) or
   ((S[i] = '^') and ((S[i+1] = '*') or  (S[i+1] = '+') or
   (S[i+1] = '-') or (S[i+1] = '/') or (S[i+1] = '^') or
   (S[i+1] = '!'))) {or
   ((S[i] = '!') and ((S[i+1] = '*') or  (S[i+1] = '+') or
   (S[i+1] = '-') or (S[i+1] = '/') or (S[i+1] = '^') or
   (S[i+1] = '!')))}
   then
begin
 F_ErrorCode:=E_MISSING_EXPRESSION;      //отсутствует выражение
 F_SyntaxErrorString:=Copy(S,1,Length(S));
 raise ESyntaxError.Create('');
 goto endp;
end;

if S[i] = '(' then inc(b1);
if S[i] = ')' then inc(b2);
end;

if S[Length(S)] = ')' then inc(b2);
if (b2-b1) > 0 then
begin
F_ErrorCode:=E_MISSING_BRACKET_LEFT;
F_SyntaxErrorString:=Copy(S,1,Length(S));
raise ESyntaxError.Create('');
end
else
if (b1-b2) > 0 then
begin
F_ErrorCode:=E_MISSING_BRACKET_RIGHT;
F_SyntaxErrorString:=Copy(S,1,Length(S));
raise ESyntaxError.Create('');
end;

S1:=Copy(S,1,Length(S));
endp:
end;




procedure TForevalH.PredSyntax(S: String; var ND: TDataNode; var LV: PLevel; var BH: Boolean; var EOFN: Boolean);
label endp;
var
Sh,Arg1,Arg2: String;
a,b: TFloatType;
ni,nt,nf: TIntegType;
PN: TMass2;
begin
//BH = True - выражение распознано
if F_ErrorCode <> 0 then goto endp;
EOFN:=False;  BH:=False;
InitNode(ND);



Sh:=Copy(S,1,Length(S));
FindArgType(Sh,nt,A,B,nf,ni,PN);
if (nt <> 0) then
begin
EOFN:=True;  BH:=True;
WriteArgData(nt,A,B,ni,nf,PN,ND);
if nt = _FAVB then
begin
if ND.V1 = 0 then
begin
 ND.Code:=C_LDSC;
end
else
if (abs(ND.V1) = 1) and (ND.V2 = 0) then
 begin
  ND.Code:=C_LDSF;
  if ND.V1 = -1 then ND.Neg:=1;
 end
else
begin
 ND.Code:=C_FAVB;
end
end
else
if nt = _AIFB then
begin
ND.Code:=C_AIFB;
end
else
if nt = _AAF then
begin
ND.Code:=C_AAF;
end
else
if nt = _MAF then
begin
ND.Code:=C_MAF;
end
else
if nt = _IAVB then
begin
if (abs(ND.VI1) = 1) and (ND.VI2 = 0) then
 begin
  ND.Code:=C_LDSI;
  if ND.VI1 = -1 then ND.Neg:=1;
 end
else
begin
ND.Code:=C_IAVB;
end
end
else
if nt = _AAI then
begin
ND.Code:=C_AAI;
end
else
if nt = _AFI then
begin
ND.Code:=C_AFI;
end;


goto endp;
end;




//a*func+b:
//if (F_FunctionalOptimizator = True) and (F_PowerOptimizator = True) then
begin
FindFunction(Sh,A,B,Arg1,Arg2,nf,BH);
if BH = True then
begin
 FunctionalAnalizator(nf,A,B,Arg1,Arg2,ND,LV,EOFN);
 goto endp;
end;
end;




endp:
end;




procedure TForevalH.SyntaxAnalizator(S:String; var ND: TDataNode; var LV:PLevel;  var EOFN: Boolean);
label endp;
var
Arg1,Arg2: String;
nf,COP: Integer;
BH: Boolean;
a,b: TFloatType;
begin
if F_ErrorCode <> 0 then goto endp;

EOFN:=False;   BH:=False; InitNode(ND);

if F_Optimization = True then
PredSyntax(Copy(S,1,Length(S)), ND, LV, BH, EOFN);


if  BH = False then
begin
StringAnalizator(Copy(S,1,Length(S)), ND.N, COP, LV, ND.Neg);
ND.Code:=COP;
 If ND.Code = _NOP then
 begin
   FindFunction(S,A,B,Arg1,Arg2,nf,BH);
   if BH = True then   FunctionalAnalizator(nf,A,B,Arg1,Arg2,ND,LV,EOFN)
   else
   begin
    NumberAnalizator(LV,ND, LV, ND,EOFN); //package&переменные&числа
   end;
 end
 else
 begin
  OperationalAnalizator(LV,ND,LV,ND,EOFN); //оптимизатор сложения и умножения
 end;
end;

endp:
end;




procedure TForevalH.PkSyntax(S:String; var ND: TDataNode; var LV:PLevel;  var EOFN: Boolean);
label endp;
var
i,k,HL: Integer;
begin
if F_ErrorCode <> 0 then goto endp;
EOFN:=False;
InitNode(ND);

k:=1;
for i:=1 to Length(S) do
begin
 if S[i] = '&' then
 begin
   SetLength(LV,Length(LV)+1);
   HL:=High(LV);
   LV[HL].Expression:=Copy(S,k,i-k);
   Insert('@@PACKAGE(',LV[HL].Expression,1);
   Insert(')',LV[HL].Expression,Length(LV[HL].Expression)+1);
   LV[HL].PkAdr:=PkgData[HL].Adr;
   LV[HL].PkShift:=PkgData[HL].Shift;
   LV[HL].PkRType:=PkgData[HL].RType;
   LV[HL].I:=_NOP;
   k:=i+1;
 end;
end;
 SetLength(LV,Length(LV)+1);
 HL:=High(LV);
 LV[HL].Expression:=Copy(S,k,Length(S));
 Insert('@@PACKAGE(',LV[HL].Expression,1);
 Insert(')',LV[HL].Expression,Length(LV[HL].Expression)+1);
 LV[HL].PkAdr:=PkgData[HL].Adr;
 LV[HL].PkShift:=PkgData[HL].Shift;
 LV[HL].PkRType:=PkgData[HL].RType;
 LV[HL].I:=_NOP;



ND.N:=Length(LV);
ND.Code:=C_NOP;
F_PackageCompile:=False;

endp:
end;



procedure TForevalH.CodeGeneration;
label endp;
var
E: Exception;
begin
if F_ErrorCode <> 0 then goto endp;

LFunc:=1;
SetLength(Interp,LFunc);
Tree:=BeginTree; //не обязательно, т.к. чтение дерева - циклически

while Tree^.Ch <> nil do
begin
Tree:=Tree^.Ch;
end;
//COP=NOP:
WriteCode;

while Tree^.Pr <> nil do
begin
 while Tree^.Nb <> nil  do
 begin
 Tree:=Tree^.Nb;
  while Tree^.Ch <> nil do
  begin
  Tree:=Tree^.Ch;
  end;
//COP=NOP:
WriteCode;
end;

//COP<>NOP:
Tree:=Tree^.Pr;
WriteCode;
end;
//1-ый элемент в WriteCode выпадает

endp:

if (F_ErrorCode <> 0) then ESyntaxError.Create('');
if (F_ErrorCode <> 0) then  EInternalError.Create('');

end;




function TForevalH.Calc: TFloatType; assembler;
asm
 call [eax+Func.ICode];
end;


procedure TForevalH.WriteCode;
label endp;
var
i: TIntegType;
S: String;
begin
SetLength(Interp,LFunc+1);
WriteDataCode;


{---------}
//out:
{$IFDEF TEXTOUT}
if TestG8.Form1.CB_Cod.Checked = True then
 begin
  //S:=String(StrUpper(PChar(Tree^.COP))){+' , '+Tree^.Expression};

  for i:=1 to High(FuncList) do
  begin
   if Tree^.Code = i then S:=FuncList[i].Name[1];
  end;
  if (S[1] = '@') and (S[2] = '@') then Delete(S,1,2);


  if Tree^.SData = _MEM then S:=S+'SM';
  if (Length(Tree^.RData) > 0) and (Tree^.RData[0] = _MEM) then S:=S+'RM';
  TestG8.Form1.M2.Lines[LFunc-1]:=String(StrUpper(PChar(S)));
  //TestG8.Form1.M2.Lines[LFunc-1]:=String(StrUpper(PChar(Tree^.COP)))+' , '+Tree^.Expression;(*+'  '+IntToStr({Tree^.SDeep}{Tree^.Stack.S})*);
 {if (Tree^.COP <> 'MUL') and (Tree^.COP <> 'ADD') then
 TestG8.Form1.M2.Lines[LFunc-1]:=String(StrUpper(PChar(Tree^.Expression)))
 else
 TestG8.Form1.M2.Lines[LFunc-1]:=String(StrUpper(PChar(Tree^.COP)));}
 end;
{$ENDIF}
{---------}

//Interp[LFunc].CS:=0;
inc(LFunc);

end;



procedure TForevalH.WriteDataCode;
var
fa,i,L,j: TIntegType;
S: String;
begin


Interp[LFunc].ErS:=Copy(Tree^.Expression,1,Length(Tree^.Expression));
for i:=0 to High(VarList) do
begin
 if Tree^.FV1 = i then Interp[LFunc].FV1:=VarList[i].Addr;
 if Tree^.FV2 = i then Interp[LFunc].FV2:=VarList[i].Addr;
 if Tree^.IV1 = i then Interp[LFunc].IV1:=VarList[i].Addr;
 if Tree^.IV2 = i then Interp[LFunc].IV2:=VarList[i].Addr;
end;




Interp[LFunc].S:=Tree^.Stack.S;
Interp[LFunc].N:=Tree^.Stack.N;
Interp[LFunc].RCS:=0;
Interp[LFunc].Code:=Tree^.Code;

Interp[LFunc].ExtArg:=Tree^.ExtArg;
Interp[LFunc].SExtArg:=Tree^.SExtArg;
Interp[LFunc].PkAdr:=Tree^.PkAdr;
Interp[LFunc].PkShift:=Tree^.PkShift;
Interp[LFunc].PkRType:=Tree^.PkRType;

SetLength(Interp[LFunc].AWCS,0);
SetLength(Interp[LFunc].AFB,0);
SetLength(Interp[LFunc].PN,0);
SetLength(Interp[LFunc].PM,0);
SetLength(Interp[LFunc].PI,0);
SetLength(Interp[LFunc].PC,0);
SetLength(Interp[LFunc].RData,0);


SetLength(Interp[LFunc].SGN,Length(Tree^.SGN));
for i:=0 to High(Tree^.SGN) do
begin
 Interp[LFunc].SGN[i]:=Tree^.SGN[i];
end;

if Length(Tree^.RData) <> 0 then SetLength(Interp[LFunc].RData,Length(Tree^.RData));
for i:=0 to High(Tree^.RData) do
begin
 Interp[LFunc].RData[i]:=Tree^.RData[i];
end;

if Length(Tree^.SNExtArg) <> 0 then SetLength(Interp[LFunc].SNExtArg,Length(Tree^.SNExtArg));
for i:=0 to High(Tree^.SNExtArg) do
begin
 Interp[LFunc].SNExtArg[i]:=Tree^.SNExtArg[i];
end;


Interp[LFunc].EI:=Tree^.EI;
Interp[LFunc].DI:=Tree^.DI;
Interp[LFunc].AI:=Tree^.AI;
Interp[LFunc].BI:=Tree^.BI;
Interp[LFunc].CI:=Tree^.CI;
Interp[LFunc].FI:=Tree^.FI;

Interp[LFunc].F1:=Tree^.F1;
Interp[LFunc].F2:=Tree^.F2;


Interp[LFunc].V1:=Tree^.V1;
Interp[LFunc].V2:=Tree^.V2;

Interp[LFunc].V3:=Tree^.V3;
Interp[LFunc].V4:=Tree^.V4;

Interp[LFunc].VI1:=Tree^.VI1;
Interp[LFunc].VI2:=Tree^.VI2;
Interp[LFunc].VI4:=Tree^.VI3;
Interp[LFunc].VI4:=Tree^.VI4;



Interp[LFunc].I:=0;

//преобразование AAF :
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
   SetLength(Interp[LFunc].PM,fa+1);   SetLength(Interp[LFunc].PN,fa+2);
   j:=0;
   for i:=0 to High(VarList) do
    begin
     if Tree^.PN.FM[i] <> 0 then
      begin
       inc(j);
       Interp[LFunc].PM[j]:=VarList[i].Addr;
       Interp[LFunc].PN[j]:=Tree^.PN.FM[i];
      end;
    end;
   Interp[LFunc].PN[j+1]:=Tree^.PN.FC;

  end;

end;



//преобразование MAF :
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
  Interp[LFunc].V1:=Tree^.PN.FC;
  begin
   SetLength(Interp[LFunc].PM,fa+1);
   j:=0;
   for i:=0 to High(VarList) do
    begin
     if Tree^.PN.FM[i] <> 0 then
      begin
       inc(j); Interp[LFunc].PM[j]:=VarList[i].Addr;
      end;
    end;
  end;
end;

//AAF и MAF одновременно быть не могут


//преобразование AAI:
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
   SetLength(Interp[LFunc].PI,fa+1);   SetLength(Interp[LFunc].PC,fa+2);
   j:=0;
   for i:=0 to High(VarList) do
    begin
     if Tree^.PN1.IM[i] <> 0 then
      begin
       inc(j); Interp[LFunc].PI[j]:=VarList[i].Addr;
       Interp[LFunc].PC[j]:=Trunc(Tree^.PN1.IM[i]);
      end;
    end;
   Interp[LFunc].PC[j+1]:=Trunc(Tree^.PN1.FC);
  end;

end;


//преобразование AFI: (как аргумент не используется-только отдельной коммандой)
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

SetLength(Interp[LFunc].PI,fa+1);
SetLength(Interp[LFunc].PN,fa+2);
j:=0;
 for i:=0 to High(VarList) do
 begin
  if Tree^.PN.IM[i] <> 0 then
  begin
   inc(j); Interp[LFunc].PI[j]:=VarList[i].Addr;
   Interp[LFunc].PN[j]:=Tree^.PN.IM[i];
  end;
 end;
Interp[LFunc].PN[j+1]:=Tree^.PN.FC;


end;


//аргумент комманды MUL:
if Length(Tree^.AFB) > 0 then
begin
 SetLength(Interp[LFunc].AFB,Length(Tree^.AFB));
 for i:=0 to  High(Tree^.AFB) do
 begin
  Interp[LFunc].AFB[i].PF:=VarList[Tree^.AFB[i].nf].Addr;
  Interp[LFunc].AFB[i].A:=Tree^.AFB[i].A;
  Interp[LFunc].AFB[i].B:=Tree^.AFB[i].B;
 end;
end;




S:=Interp[LFunc].ErS;

Interp[LFunc].Neg:=Tree^.Neg;
Interp[LFunc].I:=Tree^.I;
Interp[LFunc].NL:=Tree^.NL;
Interp[LFunc].XCHA:=Tree^.XCHA;
Interp[LFunc].SData:=Tree^.SData;
Interp[LFunc].NM:=Tree^.NM;
Interp[LFunc].Code:=Tree^.Code;




end;





procedure TForevalH.SetNL;
label endp;
var
N: Integer;
HTree: PNode;
S: String;
begin
//инициализирует поле NL: порядковый номер  на уровне;


if F_ErrorCode <> 0 then goto endp;

Tree:=BeginTree; //не обязательно, т.к. чтение дерева - циклически


while Tree^.Ch <> nil do
begin
Tree:=Tree^.Ch;
end;
//COP=NOP:

while Tree^.Pr <> nil do
begin
 while Tree^.Nb <> nil  do
 begin
 Tree:=Tree^.Nb;
  while Tree^.Ch <> nil do
  begin
  Tree:=Tree^.Ch;
  end;
 //COP=NOP:
 inc(N);
end;

//COP<>NOP:
 S:=Tree^.Expression;
 Tree:=Tree^.Pr;
 N:=1;
 HTree:=Tree^.Ch;
 HTree^.NL:=N;
 HTree:=HTree^.Nb;
 while HTree <> nil do
 begin
  inc(N);
  HTree^.NL:=N;
  HTree:=HTree^.Nb;
 end;

end;

//в вершине '0' !!!
Tree^.NL:=0;
endp:
end;



procedure TForevalH.SetNM;
label endp;
var
N: Integer;
HTree: PNode;
S: String;
begin
//инициализирует поле NM: номер массива главного узла, т.е.: Interp[Interp[i].NM]  -
//главный узел, где i - комманды уровня (исп-ся только в MUL,ADD)


if F_ErrorCode <> 0 then goto endp;

//new(Interp[0]);
Tree:=BeginTree; //не обязательно, т.к. чтение дерева - циклически


while Tree^.Ch <> nil do
begin
Tree:=Tree^.Ch;
end;
//COP=NOP:
N:=1;

while Tree^.Pr <> nil do
begin
 while Tree^.Nb <> nil  do
 begin
 Tree:=Tree^.Nb;
  while Tree^.Ch <> nil do
  begin
  Tree:=Tree^.Ch;
  end;
 //COP=NOP:
 inc(N);
end;

//COP<>NOP:
 S:=Tree^.Expression;
 Tree:=Tree^.Pr;
 inc(N);
 HTree:=Tree^.Ch;
 HTree^.NM:=N;
 HTree:=HTree^.Nb;
 while HTree <> nil do
 begin
  HTree^.NM:=N;
  HTree:=HTree^.Nb;
 end;

end;
Tree^.NM:=0;

endp:
end;





//начальное заполнение: SData,RData[i] = _FPU
procedure TForevalH.SetLoadSource;
label endp;
var
i,LS: Integer;
HTree: PNode;
S: String;
begin
//инициализирует поля: SData,RData = _FPU и XCHA=0
LS:=_FPU;
if F_ErrorCode <> 0 then goto endp;

//new(Interp[0]);
Tree:=BeginTree; //не обязательно, т.к. чтение дерева - циклически

while Tree^.Ch <> nil do
begin
Tree:=Tree^.Ch;
end;
//COP=NOP:
Tree^.SData:=LS; Tree^.RData:=nil;
Tree^.XCHA:=0;

while Tree^.Pr <> nil do
begin
 while Tree^.Nb <> nil  do
 begin
 Tree:=Tree^.Nb;
  while Tree^.Ch <> nil do
  begin
  Tree:=Tree^.Ch;
  end;
 //COP=NOP:
 Tree^.SData:=LS; Tree^.RData:=nil;
 Tree^.XCHA:=0;
end;

//COP<>NOP:
 Tree:=Tree^.Pr;
 Tree^.SData:=LS;
 SetLength(Tree^.RData,Tree^.Stack.N);
 for i:=0 to High(Tree^.RData) do
 begin
  Tree^.RData[i]:=LS;
 end;


 Tree^.XCHA:=0;
 S:=Tree^.Expression;

end;


Tree^.SData:=_FPU;
Tree^.XCHA:=0;

//отладка:
{Tree^.RData[0]:=_MEM;  Tree^.RData[1]:=_FPU; Tree^.RData[2]:=_FPU; Tree^.RData[3]:=_MEM;
HTree:=Tree^.Ch;
HTree^.SData:=_MEM;
HTree^.Nb^.SData:=_FPU;
HTree^.Nb^.Nb^.SData:=_FPU;
HTree^.Nb^.Nb^.Nb^.SData:=_MEM;
}
endp:
end;



procedure TForevalH.SetNodeDeep;
label endp;
var
NS,SD: Integer;
S: String;
Interp0: TArrayOfTFunc;
begin
if F_ErrorCode <> 0 then goto endp;
Tree:=BeginTree; //не обязательно, т.к. чтение дерева - циклически
SetLength(Interp0,1);
Cmpl.E_Init(Interp0,{InternalFuncList,ExternalFuncList,}FuncList,VarList,F_StackDeep,F_ParamType,F_DataType,C_EmlXchBranch);


while Tree^.Ch <> nil do
begin
Tree:=Tree^.Ch;
end;
Tree^.SDeep:=0+Cmpl.E_GetFuncLoad(Tree);

while Tree^.Pr <> nil do
begin
 while Tree^.Nb <> nil  do
 begin
 Tree:=Tree^.Nb;
  while Tree^.Ch <> nil do
  begin
  Tree:=Tree^.Ch;
  end;
  Tree^.SDeep:=0+Cmpl.E_GetFuncLoad(Tree);
 end;

 SD:=Tree^.Pr^.Ch^.SDeep; NS:=Tree^.Pr^.Ch^.Stack.S;
 Tree:=Tree^.Pr^.Ch;
 while Tree^.Nb <> nil do
 begin
  Tree:=Tree^.Nb;
  if (Tree^.SDeep+Tree^.Stack.S) > (SD+NS) then
  begin
   SD:=Tree^.SDeep;
   NS:=Tree^.Stack.S;
  end;
 end;

 Tree:=Tree^.Pr;
 Tree^.SDeep:=NS-Tree^.Stack.S+SD+Cmpl.E_GetFuncLoad(Tree);
end;

Db_XchBrSDeep:=Cmpl.GetMaxStack;
endp:
end;




procedure TForevalH.TreeOptimizator;
begin
SetNodeDeep;

{$IFDEF TEXTOUT}
  TestG8.Form1.LXBSD.Caption:=IntToStr(Cmpl.GetMaxStack);
{$ENDIF}

if (F_TreeOptimization = _Enable) or
   ((F_TreeOptimization = _Auto) and (Cmpl.GetMaxStack > F_StackDeep))
then
 begin
  BranchOptimizator;
  RestoreStack;

 {$IFDEF TEXTOUT}
   TestG8.Form1.LXBNX.Caption:=IntToStr(Db_XchBrNXch);
 {$ENDIF}
 end;

end;





procedure TForevalH.BranchOptimizator;
label 1,2,3,endp;
var
S: String;
CNI: Integer;
begin
CNI:=0;
if F_ErrorCode <> 0 then goto endp;

Tree:=BeginTree; //не обязательно, т.к. чтение дерева - циклически

1:
while Tree.Ch <> nil do
begin
 Tree:=Tree^.Ch;
end;


2:
if Tree^.Nb = nil then goto 3
else
begin
 Tree:=Tree^.Nb;
 goto 1;
end;

3:
if Tree^.Pr = nil then  goto endp
else
begin
 //для добавл. ф-ий с FType < 0 аргументы не переставлять
 if   FuncList[Tree^.Pr^.Code].FType >= 0 then
 begin
  if CheckXchBranch(Tree^.Pr^.Ch) then
  begin
  S:=Tree^.Pr^.Expression;
  XchBranch(Tree^.Pr);
  inc(Db_XchBrNXch);
  end;
 end;
 Tree:=Tree^.Pr;
 goto 2;
end;


endp:
end;



function TForevalH.CheckXchBranch(Lv: PNode): Boolean;
label endp;
var
SD: Integer;
begin
CheckXchBranch:=False;
SD:=LV^.SDeep;
LV:=LV^.Nb;
while Lv <> nil do
begin
 if Lv^.SDeep > SD then
 begin
  CheckXchBranch:=True;
  goto endp;
 end;
 Lv:=Lv^.Nb;
end;

endp:
end;




procedure TForevalH.XchBranch(Pr: PNode);
type
Tmax = record
        N: Integer;
     Tree: PNode;
       end;
var
Mx: array of TMax;
Tr,Ch: PNode;
N,M,i,j,Max,NMax,nif,SS,St: Integer;
S,S1,S2,S3: String;
begin
Ch:=Pr^.Ch;
N:=0;
while Ch <> nil do
begin
inc(N);
Ch:=Ch^.Nb;
end;
SetLength(MX,N);

//создание массива узлов:
Ch:=Pr^.Ch;
M:=0;
while Ch <> nil do
begin
MX[M].Tree:=Ch;
MX[M].N:=M;
inc(M);
Ch:=Ch^.Nb;
end;

Ch:=Pr^.Ch;

//расстановка узлов по убыванию SDeep:
for i:=0 to N-1 do
begin
 Max:=MX[i].Tree^.SDeep; NMax:=i;
 for j:=i+1 to N-1 do
 begin
  if MX[j].Tree^.SDeep > Max then
  begin
   NMax:=j; Max:=MX[j].Tree^.SDeep;
  end;
 end;

 //обмен узлов:
 if NMax <> i then
 begin
  Tr:=MX[i].Tree;
  MX[i].Tree:=MX[NMax].Tree;
  MX[NMax].Tree:=Tr;

  M:=MX[i].N;
  MX[i].N:=MX[NMax].N;
  MX[NMax].N:=M;
 end;
end;

//восстановление ссылок после замены:
MX[N-1].Tree^.Nb:=nil; MX[N-1].Tree^.Pr:=Pr; Pr^.Ch:=MX[0].Tree;
for i:=0 to N-2 do
begin
  MX[i].Tree^.Nb:=MX[i+1].Tree;
end;

//f1(1)+f2(2)+f3(3)+f4(4)+f5(5)
//x-t/y+t/(x+t)
//((2*x-1)/(3*x-4))/(8/x-9/(2*x*y-1)+1)
{S:=MX[0].Tree^.Expression;
S1:=MX[1].Tree^.Expression;
S2:=MX[2].Tree^.Expression;
S3:=MX[3].Tree^.Expression;}
{$IFDEF TEXTOUT}
 //TestG8.Form1.M3.Lines[0]:=S;
 //TestG8.Form1.M4.Lines[0]:=S1;
{$ENDIF}

if Pr^.Code = C_ADD then
begin
 for i:=0 to N-1 do
 begin
  if (i = 0) and (MX[i].N <> 0) then
  begin
   if MX[i].Tree^.I = _ADD then MX[i].Tree^.I:=_NOP;
   if MX[i].Tree^.I = _SUB then
   begin
    MX[i].Tree^.I:=_NOP;
    if MX[i].Tree^.Neg = 1 then MX[i].Tree^.Neg:=0
    else
    MX[i].Tree^.Neg:=1;
   end;
  end;

  if (i > 0) and (MX[i].Tree^.I = _NOP)  then MX[i].Tree^.I:=_ADD;

  if (i > 0) and (MX[i].N = 0) and (MX[i].Tree^.Neg = 1) then
  begin
   MX[i].Tree^.Neg:=0;
   MX[i].Tree^.I:=_SUB;
  end;

   //ADD-S1+S2; ADD+S1-S2;
   if (i = 0) and (MX[i].Tree^.I = _NOP) then  Pr^.SGN[i]:=_ADD
   else
   if (i > 0) then Pr^.SGN[i]:=MX[i].Tree^.I;

   MX[i].Tree^.NL:=i+1;

 end;
end
else
if Pr^.Code = C_MUL then
begin

 for i:=0 to N-1 do
 begin
  if (i = 0) and (MX[i].N > 0) then
  begin
   if MX[i].Tree^.I = _MUL then MX[i].Tree^.I:=_NOP;
  end;

  if (i > 0) and (MX[i].Tree^.I = _NOP)  then MX[i].Tree^.I:=_MUL;

  if (i > 0)  or  ((i = 0) and (MX[i].Tree^.I <> _NOP)) then
   Pr^.SGN[i]:=MX[i].Tree^.I;

  MX[i].Tree^.NL:=i+1;
 end;

//обработка ситуации (в MUL): если в результате перестановки аргументов первой операцией
//на уровне  становится '/', то отсутствует её делитель =>
//следующей операции на уровне  присваивается: .I:=DIVR (становится её  делителем)
//(в SGN изменения не вносятся!!!)

 if (MX[0].Tree^.I = _DIV) and (MX[0].N > 0) then
 begin
  MX[0].Tree^.I:=_NOP;
  MX[1].Tree^.I:=_DIVR;
 end;

end
else
if FuncList[Pr^.Code].FType = 4 then
begin
 Pr^.XCHA:=1;
end
else
begin
  if FuncList[Pr^.Code].NST = -1 then F_OverFlowFunc:=True;
end;


end;






procedure TForevalH.RestoreStack;
label endp;
var
S: Integer;
begin
if F_ErrorCode <> 0 then goto endp;
Tree:=BeginTree;   //не обязательно, т.к. чтение дерева - циклически

S:=1;
while Tree^.Ch <> nil do
begin
Tree:=Tree^.Ch;
Tree^.Stack.S:=S;
end;


while Tree^.Pr <> nil do
begin
 while Tree^.Nb <> nil  do
 begin
 S:=Tree^.Stack.S;
 Tree:=Tree^.Nb;
 Tree^.Stack.S:=S+1;
 inc(S);
  while Tree^.Ch <> nil do
  begin
  Tree:=Tree^.Ch;
  Tree^.Stack.S:=S;
  end;
 end;
 Tree:=Tree^.Pr;
end;


endp:
end;



procedure TForevalH.DinamicLoadOptimizator;
label 1,beginp,endp;
var
i,Pn,PML,ML,CNT,k,t2: Integer;
S,S1: String;
begin

if  F_DinamicLoadOptimization = _Enable then goto beginp;
if  F_DinamicLoadOptimization = _Auto then
begin
 Cmpl.E_Init(Interp,FuncList,VarList,F_StackDeep,F_ParamType,F_DataType,C_EmlDinamicLoad);
 Db_DinLoadSDeep:=Cmpl.E_GetMaxStackEx;
 if Db_DinLoadSDeep > F_StackDeep then goto beginp else goto endp;
end;


beginp:
CNT:=0;
if F_ErrorCode <> 0 then goto endp;
PML:=0; PN:=0;
1:
SetDIVR;
Cmpl.E_Init(Interp,FuncList,VarList,F_StackDeep,F_ParamType,F_DataType,C_EmlDinamicLoad);

for i:=1 to LFunc-1 do
begin
  {$IFDEF TEXTOUT}
   //TestG8.Form1.M3.Lines[i-1]:=IntToStr(Interp[i].Code);
  {$ENDIF}
  S:=Interp[i].ErS;
  S1:=Interp[i-1].ErS;
  ML:=Cmpl.E_GetMaxLoadDL(I);

  {если переполнение стека в рез-те выталкивания предыдущей комманды (I-1) не устранено, то
   продолжить выталкивание предыдущих комманд (I-2,...1) по одной до тех пор, пока есть
   переполнение в данной комманде (I)}
  if {(ML = PML)}(ML > F_StackDeep) and (PN = I) then
  begin
   for k:=I-2 downto 1 do
   begin
     if Interp[k].SData = _FPU then
     begin
      if EnableDL(k) then
      begin
       SetLoadMem(k);
       {$IFDEF TEXTOUT}
        //TestG8.Form1.M1.Lines[CNT]:=Interp[k].Ers;
        //inc(CNT);
       {$ENDIF}
       goto 1;
      end;

     end;
   end;
    Db_DinLoadOverFlow:=True;
    //защита от зацикливания (возникает, если невозможно сделать загрузку стека < F_StackDeep:
   goto endp;
  end;

  {если произошло переполнение стека в текущем узле, то рез-т передыдущей (I-1) комманды
  выталкивается в память: (т.о. уменьшается на 1 загрузка стека)}
  if ML > F_StackDeep then
  begin
   if I = 1 then
   begin
    Db_DinLoadOverFlow:=True;
    //защита от зацикливания:
    goto endp;
   end;
   if {Interp[I-1].Code <> 305}EnableDL(I-1) then
   begin
    SetLoadMem(I-1);
    PML:=ML;
    PN:=I;
    {$IFDEF TEXTOUT}
     //TestG8.Form1.M1.Lines[CNT]:=Interp[i-1].Ers;
     //inc(CNT);
    {$ENDIF}
    goto 1;
   end;
  end;

end;

//((2*x-1)/(3*x-4))/(8/x-9/(2*x*y-1)+1)
endp:
{$IFDEF TEXTOUT}
  TestG8.Form1.LDLSD.Caption:=IntToStr(Db_DinLoadSDeep);
  if Db_DinLoadOverFlow  then
   TestG8.Form1.LDLNM.Caption:='OutOfStack'
  else
   TestG8.Form1.LDLNM.Caption:=IntToStr(Db_DinLoadNMem);
{$ENDIF}
//sinh(x)^cosh(y)
//test:
//m_eax5(f1(1),f2(2),f3(3),f4(4),f5(5))
{Interp[2].SData:=_MEM;
Interp[4].SData:=_MEM;
Interp[6].SData:=_MEM;
Interp[8].SData:=_MEM;
Interp[10].SData:=_MEM;
Interp[11].RData[0]:=_MEM;
Interp[11].RData[1]:=_MEM;
Interp[11].RData[2]:=_MEM;
Interp[11].RData[3]:=_MEM;
Interp[11].RData[4]:=_MEM;}
end;


function TForevalH.EnableDL(I: Integer): Boolean;
var
ifn: Integer;
begin
//False - если аргументы выталкивать для данного узла нельзя
//COP = NOP
//для добавляемых ф-ий через FPU
if {Internal}FuncList[Interp[Interp[I].NM].Code].FType = -8 then EnableDL:=False
else
if Interp[I].Code = C_NOP then  EnableDL:=False
else
EnableDL:=True;
end;



procedure TForevalH.SetDIVR;
label 1;
var
NL: TArrayI;
l,i,j,k: Integer;
begin
//обработка ситуации (в MUL): если в результате выталкивания аргументов первой операцией
//на уровне (c SData = _FPU) становится '/', то отсутствует её делитель =>
//следующей операции на уровне (с SData = _FPU) присваивается: .I:=DIVR
//(становится её  делителем), если такой нет, то деления выполняется в MUL
//(это возможно только в том случае, если в TreeOptimizator поменялись местами '*' и '/'
//т.к. '/'(если есть) всегда идёт последней операцией на уровне)
//(в SGN изменения не вносятся!!!)

 for i:=1 to LFunc-1 do
 begin
  if Interp[i].Code = C_MUL then
  begin

   if Interp[i].N > 1 then
   begin

    SetLength(NL,Interp[i].N); l:=0;
    for j:=1 to i do
    begin
     if Interp[j].NM = i then
     begin
      NL[l]:=j; inc(l);
     end;
    end;

    //Lengh(SGN) = Length(RData) = Length(NL)
    for k:=0 to High(Interp[i].SGN) do
    begin
     //поиск первого элемента уровня с SData = _FPU
     if Interp[i].RData[k] = _FPU then
     begin
      //если первая операция уровня (с SData  =_FPU) = '/', то следующая за ней
      //операция (с SData = _FPU) должна быть её делителем (.I = _DIVR)
      //если такой нет, то деление выполняется в главном узле уровня (MUL)
      //в SGN изменения не вносятся !!!
      if Interp[i].SGN[k] = _DIV then
      begin
       //поиск первого эл-та уровня с SData =_FPU после '/' для присвоения ему .I = _DIVR
       for l:=k+1 to High(Interp[i].SGN) do
       begin
        if Interp[i].RData[l] = _FPU then
        begin
         Interp[NL[l]].I:=_DIVR;
         goto 1;
        end;
       end;

      end
      else
      //если '/' не первая операция уровня с  SData = _FPU, то её делитель уже загружен
      //(предыдущая операция с SData = _FPU)
      goto 1;

     end
    end;

   end;

  end;

 1:
 end;

end;




procedure TForevalH.SetLoadMem(I: Integer);
var
NL,NM: Integer;
S,S1: String;
begin
 Interp[I].SData:=_MEM;
 NM:=Interp[I].NM;
 NL:=Interp[I].NL;
 Interp[NM].RData[NL-1]:=_MEM;

 S:=Interp[i].ErS;
 S1:=Interp[NM].ErS;
 inc(Db_DinLoadNMem);

 {$IFDEF TEXTOUT}
if TestG8.Form1.CB_Cod.Checked = True then
 begin
  S:=Copy(TestG8.Form1.M2.Lines[I-1],1,Length(TestG8.Form1.M2.Lines[I-1]));
  S1:=Copy(TestG8.Form1.M2.Lines[NM-1],1,Length(TestG8.Form1.M2.Lines[NM-1]));
  S:=S+'  WM';
  S1:=S1+'  RM';
  TestG8.Form1.M2.Lines[I-1]:=String(StrUpper(PChar(S)));
  TestG8.Form1.M2.Lines[NM-1]:=String(StrUpper(PChar(S1)));
 end;
{$ENDIF}
end;





procedure TForevalH.CalcConstFunc;
label 1,endp;
var
X,X1,X2,F: TFloatType;
i,il,N,k: Integer;
Addr: Pointer;
FuncCode: array of byte;
begin
if F_ErrorCode <> 0 then goto endp;

 for i:=1 to LFunc-1 do
 begin
  if FuncList[Interp[i].Code].FType <= 0 then goto 1;
  F_ErNum:=i;
  il:=0;

  //вычисление аргументов ф-ий соотв. типов:
  if FuncList[Interp[i].Code].FType = 2 then
  begin
   if Interp[i].EI = 2 then
     if Interp[i].V1 = 0 then
     begin
      X:=Interp[i].V2; il:=1;
     end
  end
  else
  if FuncList[Interp[i].Code].FType = 4 then
  begin
   if Interp[i].EI = 6 then
     if (Interp[i].V1 = 0) and  (Interp[i].V3 = 0) then
     begin
      X1:=Interp[i].V2;
      X2:=Interp[i].V4;
      il:=1;
     end
  end
  else
  if FuncList[Interp[i].Code].FType = 1 then
  begin
   if Interp[i].EI = 2 then
     if (Interp[i].VI1 = 0)  then
     begin
      N:=Interp[i].VI2;
      il:=1;
     end
  end
  else
  if FuncList[Interp[i].Code].FType = 3 then
  begin
   if Interp[i].EI = 2 then
     if (Interp[i].V1 = 0) and (Interp[i].VI1 = 0)  then
     begin
      X:=Interp[i].V2;
      N:=Interp[i].VI2;
      il:=1;
     end
  end;



  //вычисление ф-ий:
  if il = 1 then
  begin
   if FuncList[Interp[i].Code].Addr <> nil then
   begin
    Addr:=FuncList[Interp[i].Code].Addr;
   end
   else
   if FuncList[Interp[i].Code].inl = 1 then
   begin
     SetLength(FuncCode,Length(FuncList[Interp[i].Code].inlCode)+1);
     for k:=0 to High(FuncList[Interp[i].Code].inlCode) do
     begin
      FuncCode[k]:=FuncList[Interp[i].Code].inlCode[k];
     end;
     FuncCode[High(FuncCode)]:=$C3; //RET
     Addr:=@FuncCode[0];
   end;

   if FuncList[Interp[i].Code].FType = 2 then
   begin
     asm
       fld  X
       pushad
       call Addr
       popad
       fstp F
     end
    end
    else
    if FuncList[Interp[i].Code].FType = 4 then
    begin
     asm
       fld  X2
       fld  X1
       pushad
       call Addr
       popad
       fstp F
     end
    end
    else
    if FuncList[Interp[i].Code].FType = 1 then
    begin
     asm
       mov  eax,N
       pushad
       call Addr
       popad
       fstp F
     end
    end
    else
    if FuncList[Interp[i].Code].FType = 3 then
    begin
     asm
       fld  X
       mov  eax,N
       pushad
       call Addr
       popad
       fstp F
     end
   end;


   {if  (Interp[i].CODE >= C_IPWR3) and (Interp[i].CODE <= C_IPWR16) then
    if  Interp[i].BI = 1 then X:=1/X;}


    //замещение ф-ии -> LDSC:
    if Interp[i].AI = 1 then F:=Interp[i].F1*F+Interp[i].F2;
    Interp[i].V2:=F;
    Interp[i].CODE:=C_LDSC;
    FuncList[Interp[i].Code].FType:=0;

    inc(Db_CalcConst);



   {----------------------}
    //out:
   {$IFDEF TEXTOUT}
    if (TestG8.Form1.CB_Cod.Checked = True) then
    TestG8.Form1.M2.Lines[i-1]:='LDSC';
    {$ENDIF}
   {----------------------}



  end;



 1:
 end;

FuncCode:=nil; 
endp:
end;


procedure TForevalH.PostCodeOptimization;
var
i,j,FType,CODE,t1: Integer;
BH: Boolean;
begin
LSRes:=-1;
//порядок важен !!!
if F_CalcConstant then CalcConstFunc;
ReplaceOperations;
SetLength(Func.CpSt,LSRes+1);
{$IFDEF TEXTOUT}
   TestG8.Form1.LCC.Caption:=IntToStr(Db_CalcConst);
   TestG8.Form1.LRF.Caption:=IntToStr(Db_CopyStackXch);
{$ENDIF}

end;



procedure TForevalH.ReplaceOperations;
label 0,1,2,endp;
var
FType1,FType2,Code1,Code2,N1,N2,i,j,k,l,RL,RLB,t1,c1,c2,n,P: Integer;
begin
RL:=F_LevelReplace;

0:
if RL = 0 then goto endp;
//цикл по главной комманде:
for i:=RL to LFunc-1-RL do
begin
 //i-главная команда
 FType1:=FuncList[Interp[i].Code].FType;
 Code1:=Interp[i].CODE;
 //только для одноарг. комманд:
 if Interp[i].N > 1 then goto 1;
 //первая команда:
 N1:=Interp[i-RL+1].N;
 if N1 <> 0 then goto 1;

 if Interp[i].RCS = 1 then goto 1;   //если полностью замещена

 //только для этих комманд (FType >= 1)
 if (FType1 <= 0)  then goto 1;



 //цикл по замещаемой комманде:
 for j:=i+RL to LFunc-1 do
 begin
  Code2:=Interp[j].Code;
  FType2:=FuncList[Interp[j].Code].FType;
  if Interp[j].RCS = 1 then goto 2;   //если полностью замещена
  N2:=Interp[j-RL+1].N;
  if N2 <> 0 then goto 2;
  if Interp[j].N > 1 then goto 2;
  if (FType2 <= 0)  then goto 2;

  if IsSameFunctions(i,j) = False then goto 2;


  c1:=i; c2:=j;
  //сравнение аргументов:
  P:=GetPriorityXch(Code1,Code2).RCS;
  if ((P <> 0) and (Interp[j].RCS = 0)) or
     ((P <> 0) and (Interp[j].RCS <> 0) and (P < Interp[j].RCS))
  then
  begin
   //для однократной:
   if RL = 1  then
   begin
    InsertCopyStack(i,j,1);
    t1:=1;
    goto 2;
   end
   else
   //для вложенных комманд:
   for n:=1 to RL-1 do
   begin
    dec(c1); dec(c2);
    if Interp[c2].Code <> Interp[c1].Code then goto 2;
    if Interp[c1].F1 <> Interp[c2].F1 then goto 2;
    if Interp[c1].F2 <> Interp[c2].F2 then goto 2;
    if Interp[c1].N > 1 then goto 1;
    if Interp[c2].N > 1 then goto 2;
    if FuncList[Interp[c1].Code].FType <= 0 then goto 1;
    if FuncList[Interp[c2].Code].FType <= 0 then goto 2;
    if Interp[c1].RCS = 1 then goto 1;
    if Interp[c2].RCS = 1 then goto 2;



    if (Interp[c1].N = 0) and (n < RL-1)  then goto 2;
    if (Interp[c2].N = 0) and (n < RL-1)  then goto 2;
    //несовпадение стека для первой:
    if Interp[c1].S <> Interp[i].S then goto 1;
    //несовпадение стека для второй:
    if Interp[c2].S <> Interp[j].S then goto 2;


    if IsSameFunctions(c1,c2) = False then goto 2;
   end;
      {$IFDEF TEXTOUT}
      if (TestG8.Form1.CB_Cod.Checked = True)  then
      begin
       for k:=j downto j-RL+1 do
       begin
        TestG8.Form1.M2.Lines[k-1]:='NOP';
       end;
      end;
    {$ENDIF}


  InsertCopyStack(i,j,RL);
  end;

 2:
 end;

1:
end;
dec(RL);
goto 0;


endp:
end;









function TForevalH.CmpFunc2(NS,NF: Integer): Boolean;
begin
if Interp[NS].EI = 1 then CmpFunc2:=True
else
if Interp[NS].EI = 2 then CmpFunc2:=CmpFAVB(NS,NF)
else
if Interp[NS].EI = 3 then CmpFunc2:=CmpAAF(NS,NF)
else
if Interp[NS].EI = 4 then CmpFunc2:=CmpMAF(NS,NF)
else
if Interp[NS].EI = 5 then CmpFunc2:=CmpAIFB(NS,NF);
end;


function TForevalH.CmpFunc4(NS,NF: Integer): Boolean;
var
BH1,BH2: Boolean;
begin
if Interp[NS].EI = 1 then CmpFunc4:=False
else
if Interp[NS].EI = 2 then CmpFunc4:=CmpFAVB(NS,NF)
else
if Interp[NS].EI = 3 then CmpFunc4:=CmpAAF(NS,NF)
else
if Interp[NS].EI = 4 then CmpFunc4:=CmpMAF(NS,NF)
else
if Interp[NS].EI = 5 then CmpFunc4:=CmpFAVB(NS,NF)
else
if Interp[NS].EI = 6 then
 begin
  BH1:=CmpFAVB(NS,NF);  BH2:=CmpFAVB1(NS,NF);
  if (BH1 = True) and (BH2 = True) then CmpFunc4:=True
  else CmpFunc4:=False;
 end
else
if Interp[NS].EI = 7 then
 begin
  BH1:=CmpAAF(NS,NF);  BH2:=CmpFAVB1(NS,NF);
  if (BH1 = True) and (BH2 = True) then CmpFunc4:=True
  else CmpFunc4:=False;
 end
else
if Interp[NS].EI = 8 then
 begin
  BH1:=CmpMAF(NS,NF);  BH2:=CmpFAVB1(NS,NF);
  if (BH1 = True) and (BH2 = True) then CmpFunc4:=True
  else CmpFunc4:=False;
 end
else
if Interp[NS].EI = 9 then CmpFunc4:=CmpAAF(NS,NF)
else
if Interp[NS].EI = 10 then
 begin
  BH1:=CmpFAVB1(NS,NF);  BH2:=CmpAAF(NS,NF);
  if (BH1 = True) and (BH2 = True) then CmpFunc4:=True
  else CmpFunc4:=False;
 end
else
if Interp[NS].EI = 11 then CmpFunc4:=CmpMAF(NS,NF)
else
if Interp[NS].EI = 12 then
 begin
  BH1:=CmpFAVB1(NS,NF);  BH2:=CmpMAF(NS,NF);
  if (BH1 = True) and (BH2 = True) then CmpFunc4:=True
  else CmpFunc4:=False;
 end;

end;




function TForevalH.CmpFunc3(NS,NF: Integer): Boolean;
var
BH1,BH2: Boolean;
begin

if Interp[NS].EI = 1 then CmpFunc3:=CmpIAVB(NS,NF)
else
if Interp[NS].EI = 2 then
 begin
  BH1:=CmpFAVB(NS,NF);  BH2:=CmpIAVB(NS,NF);
  if (BH1 = True) and (BH2 = True) then CmpFunc3:=True
  else CmpFunc3:=False;
 end
else
if Interp[NS].EI = 3 then
 begin
  BH1:=CmpAAF(NS,NF);  BH2:=CmpIAVB(NS,NF);
  if (BH1 = True) and (BH2 = True) then CmpFunc3:=True
  else CmpFunc3:=False;
 end
else
if Interp[NS].EI = 4 then
 begin
  BH1:=CmpMAF(NS,NF);  BH2:=CmpIAVB(NS,NF);
  if (BH1 = True) and (BH2 = True) then CmpFunc3:=True
  else CmpFunc3:=False;
 end
else
if Interp[NS].EI = 5 then CmpFunc3:=CmpAAI(NS,NF)
else
if Interp[NS].EI = 6 then
 begin
  BH1:=CmpFAVB(NS,NF);  BH2:=CmpAAI(NS,NF);
  if (BH1 = True) and (BH2 = True) then CmpFunc3:=True
  else CmpFunc3:=False;
 end
else
if Interp[NS].EI = 7 then
 begin
  BH1:=CmpAAF(NS,NF);  BH2:=CmpAAI(NS,NF);
  if (BH1 = True) and (BH2 = True) then CmpFunc3:=True
  else CmpFunc3:=False;
 end
else
if Interp[NS].EI = 8 then
 begin
  BH1:=CmpMAF(NS,NF);  BH2:=CmpAAI(NS,NF);
  if (BH1 = True) and (BH2 = True) then CmpFunc3:=True
  else CmpFunc3:=False;
 end
else
if Interp[NS].EI = 9 then CmpFunc3:=False
else
if Interp[NS].EI = 10 then CmpFunc3:=CmpFAVB(NS,NF)
else
if Interp[NS].EI = 11 then CmpFunc3:=CmpAAF(NS,NF)
else
if Interp[NS].EI = 12 then CmpFunc3:=CmpMAF(NS,NF);
end;




function TForevalH.CmpFunc1(NS,NF: Integer): Boolean;
begin
if Interp[NS].EI = 1 then CmpFunc1:=True
else
if Interp[NS].EI = 2 then CmpFunc1:=CmpIAVB(NS,NF)
else
if Interp[NS].EI = 3 then CmpFunc1:=CmpAAI(NS,NF)
end;


function  TForevalH.CmpFAVB(NS,NF: Integer): Boolean;
begin
CmpFAVB:=False;
 if (Interp[NS].V1 = Interp[NF].V1) and  (Interp[NS].V2 = Interp[NF].V2) and
    (Interp[NS].FV1 = Interp[NF].FV1)
   then  CmpFAVB:=True;
end;


function  TForevalH.CmpFAVB1(NS,NF: Integer): Boolean;
begin
CmpFAVB1:=False;
 if (Interp[NS].FV2 = Interp[NF].FV2) and
    (Interp[NS].V3 = Interp[NF].V3)   and
    (Interp[NS].V4 = Interp[NF].V4)
    then  CmpFAVB1:=True;
end;


function  TForevalH.CmpIAVB(NS,NF: Integer): Boolean;
begin
CmpIAVB:=False;
 if (Interp[NS].IV1 = Interp[NF].IV1) and
    (Interp[NS].VI1 = Interp[NF].VI1) and
    (Interp[NS].VI2 = Interp[NF].VI2)
    then CmpIAVB:=TRue;
end;


function  TForevalH.CmpAIFB(NS,NF: Integer): Boolean;
begin
CmpAIFB:=False;
 if (Interp[NS].V1 = Interp[NF].V1) and  (Interp[NS].V2 = Interp[NF].V2) and
    (Interp[NS].FV1 = Interp[NF].FV1) and (Interp[NS].IV1 = Interp[NF].IV1)
   then  CmpAIFB:=True;
end;


function TForevalH.CmpAAF(NS,NF: Integer): Boolean;
label endp;
var
i,L: Integer;
begin
CmpAAF:=False;


if Interp[NS].DI = Interp[NF].DI  then
begin
 if Interp[NS].DI = _AAF  then
 begin
  if (Length(Interp[NS].PM) =  Length(Interp[NF].PM)) and
     (Length(Interp[NS].PN) =  Length(Interp[NF].PN)) then
  begin
   L:=High(Interp[NS].PM);
   for i:=1 to L do
   begin
    if Interp[NS].PM[i] <> Interp[NF].PM[i] then goto endp;
    if Interp[NS].PN[i] <> Interp[NF].PN[i] then goto endp;
   end;

   if Interp[NS].PN[L+1] <> Interp[NF].PN[L+1] then goto endp;
   CmpAAF:=True;
  end;
 end;
end;

endp:
end;



function TForevalH.CmpMAF(NS,NF: Integer): Boolean;
label endp;
var
i,L: Integer;
begin
CmpMAF:=False;


if Interp[NS].DI = Interp[NF].DI  then
begin
 if Interp[NS].DI = _MAF  then
 begin
  if Length(Interp[NS].PM) =  Length(Interp[NF].PM) then
  begin
   L:=High(Interp[NS].PM);
   for i:=1 to L do
   begin
    if Interp[NS].PM[i] <> Interp[NF].PM[i] then goto endp;
   end;

   if Interp[NS].V1 <> Interp[NF].V1 then goto endp;
   if Interp[NS].V2 <> Interp[NF].V2 then goto endp;

   CmpMAF:=True;
  end;
 end;
end;


endp:
end;




function TForevalH.CmpAAI(NS,NF: Integer): Boolean;
label endp;
var
i,L: Integer;
begin
CmpAAI:=False;


if Interp[NS].CI = Interp[NF].CI  then
begin
 if Interp[NS].CI = _AAI  then
 begin
   if (Length(Interp[NS].PI) =  Length(Interp[NF].PI)) and
      (Length(Interp[NS].PC) =  Length(Interp[NF].PC)) then
   begin
    L:=High(Interp[NS].PI);
    for i:=1 to L do
    begin
     if Interp[NS].PI[i] <> Interp[NF].PI[i] then goto endp;
     if Interp[NS].PC[i] <> Interp[NF].PC[i] then goto endp;
    end;

    if Interp[NS].PC[L+1] <> Interp[NF].PC[L+1] then goto endp;
    CmpAAI:=True;
   end;
 end;
end;


endp:
end;






procedure TForevalH.InsertCopyStack(NF,NS,N: Integer);
label 1;
var
i,s: Integer;
Pt: TPrt;
L: Integer;
begin
//NF -> NS
Pt:= GetPriorityXch(Interp[NF].Code,Interp[NS].Code);


L:=Length(Interp[NF].AWCS);
if L = 0 then
begin
 LSRes:=LSRes+Pt.NC;
 SetLength(Interp[NF].AWCS,1);
 Interp[NF].AWCS[0].WCS:=Pt.WCS;
 Interp[NF].AWCS[0].MWCS:=LSRes;
 Interp[NS].MRCS:=LSRes;
 Interp[NS].RCS:=Pt.RCS;
end
else
begin
 for i:=0 to L do
 begin
  if Interp[NF].AWCS[i].WCS = Pt.WCS then
  begin
   Interp[NS].MRCS:=Interp[NF].AWCS[i].MWCS;
   Interp[NS].RCS:=Pt.RCS;
   goto 1;
  end;
 end;

 LSRes:=LSRes+Pt.NC;
 SetLength(Interp[NF].AWCS,L+1);
 Interp[NF].AWCS[L].WCS:=Pt.WCS;
 Interp[NF].AWCS[L].MWCS:=LSRes;
 Interp[NS].MRCS:=LSRes;
 Interp[NS].RCS:=Pt.RCS;
end;



1:
for i:=NS-N+1 to NS-1 do
begin
  Interp[i].N:=0;
  Interp[i].F1:=1;
  Interp[i].F2:=0;
  Interp[i].code:=C_NOP;
  FuncList[Interp[i].Code].FType:=0;
end;

inc(Db_CopyStackXch);
if N > Db_MaxReplaceLevel then Db_MaxReplaceLevel:=N;
end;










function TForevalH.IsSameFunctions(NF,NS: Integer): Boolean;
label endp;
var
EI1,EI2,I1,I2,AI1,AI2,FI1,FI2,N1,N2,FType: Integer;
A,B: TFloatType;
BH: Boolean;
i,CODE,N,P,FType1,FType2: Integer;
F1,F2: TFloatType;
begin
IsSameFunctions:=False;

EI1:=Interp[NF].EI;
N1:=Interp[NF].N;
FType1:=FuncList[Interp[NF].Code].FType;
FType2:=FuncList[Interp[NS].Code].FType;
EI2:=Interp[NS].EI;
N2:=Interp[NS].N;
if (N1 <> N2)  or  (EI1 <> EI2) or (FType1 <> FType2) then goto endp;


if (FType1 = 2)   then
begin
 IsSameFunctions:=CmpFunc2(NS,NF);
end
else
if (FType1 = 4)   then
begin
 IsSameFunctions:=CmpFunc4(NS,NF);
end
else
if (FType1 = 3)   then
begin
 IsSameFunctions:=CmpFunc3(NS,NF);
 if (Interp[NF].Code >= C_IPWR3) and (Interp[NF].Code <= C_IPWR16) then
  if Interp[NF].BI <> Interp[NS].BI then IsSameFunctions:=False;
end
else
if (FType1 = 1)   then
begin
 IsSameFunctions:=CmpFunc1(NS,NF);
end;

endp:
end;






function  TForevalH.GetNumberXchTable(Code: Integer): Integer;
label endp;
var
i: Integer;
begin

 for i:=0 to High(XchCode) do
 begin
  if XchCode[i] = Code then
  begin
   GetNumberXchTable:=i; goto endp;
  end
 end;

GetNumberXchTable:=-1;
endp:
end;


function  TForevalH.GetPriorityXch(Code1,Code2: Integer): TPrt;
var
N1,N2: Integer;
begin
GetPriorityXch:=XchTable[Code1,Code2];
end;





procedure TForevalH.CreateFuncList;
begin
CommandC.CreateFuncList(FuncList);
end;




procedure TForevalH.AddNameFunction(Code: Integer; Name: String);
begin
if (Code >= 0) and (Code <= High(FuncList)) then
begin
 SetLength(FuncList[Code].Name,Length(FuncList[Code].Name)+1);
 FuncList[Code].Name[High(FuncList[Code].Name)]:=Copy(Name,1,Length(Name));
end; 
end;


procedure TForevalH.ClearNameFunction(Code: Integer);
begin
if (Code >= 0) and (Code <= High(FuncList)) then
 FuncList[Code].Name:=nil;
end;


procedure TForevalH.DeleteFunction(Code: Integer);
var
i: Integer;
begin
 if (Code >= 0) and (Code <= High(FuncList)) then
 begin
  FuncList[Code].FType:=0;
  for i:=1 to High(FuncList[Code].Name) do
  begin
    FuncList[Code].Name[i]:='@@'+FuncList[Code].Name[i];
  end;
 end
 else
 begin
  F_ErrorCode:=E_NONEXISTENT_FUNCTION;
  F_SyntaxErrorString:=IntToStr(Code);
  CalcException;
 end;
end;


procedure TForevalH.InitNode(var ND: TDataNode);
var
i: Integer;
begin
SetLength(ND.PN.FM,Length(VarList));   SetLength(ND.PN1.FM,Length(VarList));
SetLength(ND.PN.IM,Length(VarList));   SetLength(ND.PN1.IM,Length(VarList));

for i:=0 to High(VarList) do
begin
ND.PN.FM[i]:=0;
ND.PN1.FM[i]:=0;
ND.PN.IM[i]:=0;
ND.PN1.IM[i]:=0;
end;
ND.PN.FC:=0;
ND.PN1.FC:=0;

ND.N:=0;
ND.AI:=0;
ND.BI:=0;
ND.CI:=0;
ND.DI:=0;
ND.EI:=0;
ND.FI:=0;
ND.V1:=0;
ND.V2:=0;
ND.V3:=0;
ND.V4:=0;
{ND.V13:=0;
ND.V14:=0;}
ND.VI1:=0;
ND.VI2:=0;
ND.VI3:=0;
ND.VI4:=0;
ND.F1:=0;
ND.F2:=0;


ND.FV1:=0;
ND.IV1:=0;
ND.FV2:=0;
ND.IV2:=0;
ND.ExtArg:=_None;
ND.Neg:=0;
ND.XCHA:=0;
ND.SS:=0;
ND.Code:=0;
end;



procedure TForevalH.CreateFactMass;
var
i,j: TIntegType;
S: TFloatType;
begin                   //создание массива факториалов


SetLength(Factorial,NumberFact+1);

S:=1;
for j:=1 to NumberFact do
begin
 S:=S*j;
 Factorial[j]:=S;
end;
 Factorial[0]:=1;
end;




function TForevalH.PointToDec(S: String):String;
label
1;
var
i:TIntegType;
SS: String;
begin
SS:=Copy(S,1,Length(S));
for i:=1 to Length(S) do
 begin
  if SS[i] = '.' then
  begin
   Delete(SS,i,1);
   Insert(',',SS,i);
   goto 1;
 end
end;

1:
PointToDec:=Copy(SS,1,Length(SS));
end;



procedure TForevalH.InitConstDb;
begin
 Db_XchBrSDeep:=0;
 Db_XchBrNXch:=0;
 Db_DinLoadSDeep:=0;
 Db_DinLoadNMem:=0;
 Db_DinLoadOverFlow:=False;
 Db_CmplMaxStack:=0;
 Db_CmplOverFlow:=False;
 Db_CopyStackXch:=0;
 Db_CalcConst:=0;
 Db_MaxReplaceLevel:=0;
end;


procedure TForevalH.CreateInitData;
begin                             //порядок не менять


new(Func.Data);
SetLength(Func.Stack,2); //т.к. отсчёт с 1
CreateFactMass;
CreateFuncList;


SetLength(ParamList,1);
F_SaveInStack:=True;
F_StackDeep:=8;
Cmpl:=TCompiler.Create(FuncList);
SetCorrectIPWR(0);
SetReg(1,0);SetReg(2,0); SetReg(3,0); SetReg(4,0);
SetReg(5,0); SetReg(6,0); SetReg(7,0); SetReg(8,0);
F_ErrorCode:=0;
LFunc:=0;
F_Optimization:=True;
F_DinamicLoadOptimization:=_Auto;
F_PostCodeOptimizator:=True;
F_SyntaxExtension:=True;
F_ShowException:=False;
F_ExternalException:=False;
F_VarShift:=False;
F_FuncShift:=False;
F_TreeOptimization:=_Auto;
F_CalcConstant:=True;
F_LevelReplace:=3;
F_CloseArg:=False;
F_PackageCompile:=False;
F_ParamType:=_Double;
F_DataType:=_Double;
C_2dqrPi:=2/sqrt(_Pi);
CreateExchTable(FuncList,XchTable);
F_XchTableTrig:=True;
SetExchTableTrig(1);
ExtException:=nil;
end;


procedure TForevalH.SetExchTableTrig(k: Integer);
begin

if k = 1 then F_XchTableTrig:= True else  F_XchTableTrig:= False;

 //enable
if F_XchTableTrig = True then
 begin
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
end
else
//disable
if F_XchTableTrig = False then
begin
   //arcsin->arccos
 XchTable[C_ARCSIN,C_ARCCOS].RCS:=0;   XchTable[C_ARCSIN,C_ARCCOS].WCS:=0;   XchTable[C_ARCSIN,C_ARCCOS].NC:=0;
 //arccos->arcsin
 XchTable[C_ARCCOS,C_ARCSIN].RCS:=0;   XchTable[C_ARCCOS,C_ARCSIN].WCS:=0;   XchTable[C_ARCCOS,C_ARCSIN].NC:=0;


 //arctg->arcctg
 XchTable[C_ARCTAN,C_ARCCOTAN].RCS:=0;   XchTable[C_ARCTAN,C_ARCCOTAN].WCS:=0;   XchTable[C_ARCTAN,C_ARCCOTAN].NC:=0;
 //arcctg->arctg
 XchTable[C_ARCCOTAN,C_ARCTAN].RCS:=0;   XchTable[C_ARCCOTAN,C_ARCTAN].WCS:=0;   XchTable[C_ARCCOTAN,C_ARCTAN].NC:=0;

//tg->ctg
 XchTable[C_TAN,C_COTAN].RCS:=0;   XchTable[C_TAN,C_COTAN].WCS:=0;   XchTable[C_TAN,C_COTAN].NC:=0;
 //ctg->tg
 XchTable[C_COTAN,C_TAN].RCS:=0;   XchTable[C_COTAN,C_TAN].WCS:=0;   XchTable[C_COTAN,C_TAN].NC:=0;

 //sin->cos  (через fsincos)
 XchTable[C_SIN,C_COS].RCS:=0;  XchTable[C_SIN,C_COS].WCS:=0;  XchTable[C_SIN,C_COS].NC:=0;
 //cos->sin (через fsincos)
 XchTable[C_COS,C_SIN].RCS:=0;  XchTable[C_COS,C_SIN].WCS:=0;  XchTable[C_COS,C_SIN].NC:=0;
end;

end;





procedure TForevalH.SetStackDeep(S: Integer);
begin
F_StackDeep:=S;
if F_StackDeep > 8 then F_StackDeep:=8
else
if F_StackDeep < 0 then F_StackDeep:=0;
end;



procedure TForevalH.SetCorrectIPWR(CI: Integer);  //1-correct; 0-not;
begin
 if CI = 1 then
 begin
  FuncList[C_IPWR].Addr:=@R_IPWR_Correct;
  FuncList[C_FPWR].Addr:=@R_FPWR_Correct;
 end
 else
 if CI = 0 then
 begin
  FuncList[C_IPWR].Addr:=@R_IPWR;
  FuncList[C_FPWR].Addr:=@R_FPWR;
 end;
end;

procedure TForevalH.SetLevelReplace(L: Integer);
begin
F_LevelReplace:=L;
end;


procedure TForevalH.SetReg(Reg: Integer; SC: Integer);
begin
Cmpl.SetRegA(Reg,SC);
end;


function  TForevalH.GetReg(R: Integer): Integer;
begin
  GetReg:=Cmpl.GetReg(R);
end;


procedure TForevalH.SetPkgData(PD: TArrayPkg);
begin
 //SetLength(PkgData,Length(PD^));
 PkgData:=PD;
end;



procedure TForevalH.SetExtExpression(S: String;  Atr: TAttrib; var E_Func: TFunction);
label endp;
var
//I_PointToData: PStack;
I_Func: TFunction;
I_LFunc: TIntegType;
E: Exception;
NAdr: Cardinal;
LS: Integer;
begin
InitConstDb;
F_Attrib:= Atr;
try
Func:=E_Func;
Func.Data:=nil;
F_OverFlowFunc:=False;
F_ErNum:=0;
F_ErrorCode:=0;
F_ErrorCode:=0;
F_SyntaxErrorString:='';
CurrentExpression:=Copy(S,1,Length(S));
PrevTreat(S,S);
Linker(S);
SetNL;
SetLoadSource;
if (F_TreeOptimization <> _Disable) and (F_OverFlowFunc = False) and (F_Optimization = True)
   then TreeOptimizator;
SetNM; //после TreeOptimizator !!!, т.к. узлы меняются местами
//(TreeOptimizator при эмуляции не использует это поле (.NM))
CodeGeneration;
if (F_PostCodeOptimizator = True) and (F_Optimization = True) then PostCodeOptimization;
if (F_DinamicLoadOptimization <> _Disable) and (F_OverFlowFunc = False) and (F_Optimization = True)
   then  DinamicLoadOptimizator;

SetStackSize;
Cmpl.Init(FuncList,VarList,F_StackDeep,F_ParamType,F_DataType,F_SaveInStack,F_CloseArg,F_Attrib);
Cmpl.Compile(@Func,Interp,NAdr);
Func.ICode:=TAddress(@Func.Code[NAdr]);

Db_CmplMaxStack:=Cmpl.GetMaxStack;
Db_CmplOverFlow:=Cmpl.OverFlow;

{$IFDEF TEXTOUT}
  if Db_CmplOverFlow  then
   TestG8.Form1.LCSD.Caption:='OutOfStack'
  else
   TestG8.Form1.LCSD.Caption:=IntToStr(Db_CmplMaxStack);

   TestG8.Form1.LMRL.Caption:=IntToStr(Db_MaxReplaceLevel);
{$ENDIF}

except
 on E: ESyntaxError     do ;
 on E: EZeroDivide      do F_ErrorCode:=E_ZeroDivide;
 on E: EInvalidOp       do F_ErrorCode:=E_InvalidOp;
 on E: EOverFlow        do F_ErrorCode:=E_OverFlow;
 on E: EUnderFlow       do F_ErrorCode:=E_UnderFlow;
 on E: EIntOverFlow     do F_ErrorCode:=E_IntOverFlow;
 on E: EAccessViolation do F_ErrorCode:=E_AccessViolation;
 on E: EOutOfMemory     do F_ErrorCode:=E_OutOfMemory;
 on E: EStackOverFlow   do F_ErrorCode:=E_StackOverFlow;
end;

if (F_ErrorCode = E_ZeroDivide) and (F_ErNum > 0) then F_SyntaxErrorString:=Copy(Interp[F_ErNum].ErS,1,Length(Interp[F_ErNum].ErS))
else
if (F_ErrorCode = E_InvalidOp) and (F_ErNum > 0) then F_SyntaxErrorString:=Copy(Interp[F_ErNum].ErS,1,Length(Interp[F_ErNum].ErS))
else
if F_ErrorCode = E_ZeroDivide then F_SyntaxErrorString:=Copy(Tree^.Expression,1,Length(Tree.Expression));

FreeInterp;
FreeTree;
E_Func:=Func;
if (F_ErrorCode <> 0 )  then
begin
 FreeExtFunc(E_Func);
 E_Func.ICode:=0;
 CalcException;
end;


end;



procedure TForevalH.FreeInterp;
var
i: Integer;
begin
for i:=1 to Length(Interp)-1 do
begin
Interp[i].PN:=nil;
Interp[i].PM:=nil;
Interp[i].PI:=nil;
Interp[i].PC:=nil;
Interp[i].SGN:=nil;
Interp[i].AFB:=nil;
Interp[i].RData:=nil;
Interp[i].SNExtArg:=nil;
end;
Interp:=nil;
end;






procedure TForevalH.FreeExtFunc(E_Func: TFunction);
var
i: TIntegType;
begin

FreeFuncData(E_Func.Data);
E_Func.Code:=nil;
E_Func.Stack:=nil;
E_Func.CpSt:=nil;
end;




procedure TForevalH.FreeFuncData(FuncData: PFuncData);
var
FD1,FD2: PFuncData;
begin

FD1:=FuncData;
while FD1 <> nil do
begin
 FD2:=FD1^.Next;
 dispose(FD1);
 FD1:=FD2;
end;

end;







procedure TForevalH.AddNewFunction(Func: TAdditionalFunc; var ID: Cardinal);
var
i,HF: Integer;
begin
//Для функций с переменным числом аргументов:
//if (Func.FType >= 11) and (Func.FType <= 14) then Func.Arg:=-1;


SetLength(FuncList,Length(FuncList)+1);
HF:=High(FuncList);
SetLength(FuncList[HF].Name,2);
FuncList[HF].Addr:=Func.addr;
FuncList[HF].inl:=Func.inl;
FuncList[HF].Arg:=Func.Arg;
FuncList[HF].FType:=Func.FType;
FuncList[HF].ArgType:=Func.ArgType;
FuncList[HF].Arrow:=Func.Arrow;
FuncList[HF].CLST:=Func.CLST;
FuncList[HF].Set_Id:=Func.Set_Id;
FuncList[HF].Id_Func:=Func.Id_Func;
FuncList[HF].ArgType:=Func.ArgType;
FuncList[HF].NST:=Func.NST;
FuncList[HF].SaveReg:=Func.SaveReg;
FuncList[HF].Name[1]:=Copy(Func.Name,1,Length(Func.Name));
if Func.ArgType = _Differ then
begin
 SetLength(FuncList[HF].ArgTypeList,Length(Func.ArgTypeList));
 for i:=0 to High(Func.ArgTypeList) do
 FuncList[HF].ArgTypeList[i]:=Func.ArgTypeList[i];
end;
Func.ArgTypeList:=nil;
if Func.inl = 1 then
begin
 SetLength(FuncList[HF].inlCode,Length(Func.inlCode));
 for i:=0 to High(Func.inlCode) do
 FuncList[HF].inlCode[i]:=Func.inlCode[i];
end;

//LX:=Length(XchTable);
SetLength(XchTable,HF+1,HF+1);

for i:=1 to HF do
begin
  XchTable[HF,i].RCS:=0;
  XchTable[HF,i].WCS:=0;
  XchTable[HF,i].NC:=0;

  XchTable[i,HF].RCS:=0;
  XchTable[i,HF].WCS:=0;
  XchTable[i,HF].NC:=0;
end;
if Func.FType <= 0 then i:=0
else i:=1;
XchTable[HF,HF].RCS:=i;
XchTable[HF,HF].WCS:=i;
XchTable[HF,HF].NC:=i;

ID:=HF;
Func.inlCode:=nil;
end;



procedure TForevalH.FreeAddFunction;
begin
 SetLength(FuncList,LFuncList);
 SetLength(XchTable,LFuncList+1,LFuncList+1);
end;


procedure TForevalH.FreeVar;
begin
 VarList:=nil;
end;


procedure TForevalH.FreeParam;
begin
 ParamList:=nil;
end;




procedure TForevalH.ClearVar;
var
i: TIntegType;
Pm: Pointer;
begin


for i:=0 to High(VarList) do
begin
 Pm:=Pointer(VarList[i].Addr);
 if VarList[i].VType = _Integer then Integer(Pm^):=0
 else
 if VarList[i].VType = _Double then Double(Pm^):=0
 else
 if VarList[i].VType = _Extended then Extended(Pm^):=0
 else
 if VarList[i].VType = _Single then Single(Pm^):=0;
end;

end;


procedure TForevalH.ClearParam;
var
i: TIntegType;
begin
for i:=1 to High(ParamList) do
begin
ParamList[i].Value:=0;
end;
end;

constructor TForevalH.Create;
begin
CreateInitData;
end;


destructor TForevalH.Destroy;
begin
VarList:=nil;
FuncList:=nil;
Factorial:=nil;
inherited Destroy;
end;



procedure TForevalH.FreeTree;
label endp;
var
H: PNode;
S,S1: String;
begin
if F_ErrorCode <> 0 then goto endp;
Tree:=BeginTree;

while Tree^.Ch <> nil do
begin
Tree:=Tree^.Ch;
end;
//COP=NOP

while Tree^.Pr <> nil do
begin
 while Tree^.Nb <> nil  do
 begin
  H:=Tree; Tree:=Tree^.Nb;  H^.Nb:=nil;
  H^.SGN:=nil;    H^.PN.FM:=nil;
  H^.PN1.FM:=nil; H^.PN.IM:=nil;
  H^.PN1.IM:=nil; H^.AFB:=nil;
  H^.RData:=nil;  H^.SNExtArg:=nil;
  dispose(H);

  while Tree^.Ch <> nil do
  begin
  Tree:=Tree^.Ch;
  end;
 //COP=NOP
 end;

//COP<>NOP
H:=Tree; Tree:=Tree^.Pr; H^.Pr:=nil;
H^.SGN:=nil;    H^.PN.FM:=nil;
H^.PN1.FM:=nil; H^.PN.IM:=nil;
H^.PN1.IM:=nil; H^.AFB:=nil;
H^.RData:=nil;  H^.SNExtArg:=nil;
//S:=H^.Expression;
//S1:=H^.COP;
dispose(H);
end;
dispose(Tree);
endp:
end;




procedure TForevalH.CalcException;
label endp;
var
S: String;
T: Integer;
begin
if F_ShowException then
begin
 if F_ErrorCode <> 0 then
 begin
 case F_ErrorCode of
  E_AccessViolation:                    S:='ACCESS VIOLATION';
  E_OutOfMemory:                        S:='OUT OF MEMORY';
  E_StackOverFlow:                      S:='STACK OVERFLOW';
  E_IntOverFlow:                        S:='INTEGER OVERFLOW';
  E_UnderFlow:                          S:='UNDERFLOW';
  E_OverFlow:                           S:='OVERFLOW';
  E_InvalidOp:                          S:='INVALID OPERATION';
  E_ZeroDivide:                         S:='DIVIDE ON ZERO';
  E_UNKNOWN_SYMBOL :                    S:='UNKNOWN SYMBOL';
  E_MISSING_BRACKET_LEFT :              S:='MISSING "(" BRACKET';
  E_MISSING_BRACKET_RIGHT :             S:='MISSING ")" BRACKET';
  E_MISSING_OPERATION :                 S:='MISSING OPERATION';
  E_INCOINCIDENCE_NUMBER_ARGUMENTS :    S:='INCOINCIDENCE NUMBER OF ARGUMENTS';
  E_MISSING_EXPRESSION :                S:='MISSING EXPRESSION';
  E_UNKNOWN_FUNCTION :                  S:='UNKNOWN FUNCTION';
  E_ERROR_AT_ADDITION_FUNCTION:         S:='ERROR AT ADDITION FUNCTION';
  E_NONEXISTENT_FUNCTION:               S:='NONEXISTENT FUNCTION';
 end;
  MessageBox(0,PChar(S+#13+#10+'"'+F_SyntaxErrorString+'"'),PChar('Foreval error'),MB_ICONERROR);
 end;
end;



if Assigned(ExtException) then ExtException;
endp:
end;



function TForevalH.GetF(C,Code: Integer): Integer;
label endp;
begin
if (Code >= 0) and (Code <= High(FuncList)) then
begin
  F_ErrorCode:=E_NONEXISTENT_FUNCTION;
  F_SyntaxErrorString:=IntToStr(Code);
  CalcException;
goto endp;
end;
//адрес:
  if C = 2 then
  begin
   //не содержит RET
   if  (FuncList[Code].Addr <> nil) and (FuncList[Code].inl = 1)
       then GetF:=Cardinal(@FuncList[Code].inlCode[0])
   else
   //последняя команда - RET
   if  (FuncList[Code].Addr <> nil) and (FuncList[Code].inl = 0)
       then GetF:=Cardinal(@FuncList[Code].Addr)
  end
  else
//inl:
  if C = 3 then  GetF:=FuncList[Code].inl
  else
//NST:
  if C = 5 then  GetF:=FuncList[Code].NST
  else
//id_FUNC:
  if C = 6 then  GetF:=FuncList[Code].id_Func
  else
//Set_ID:
  if C = 7 then  GetF:=FuncList[Code].Set_ID
  else
//Arg:
  if C = 8 then  GetF:=FuncList[Code].Arg
  else
//ARROW:
  if C = 9 then  GetF:=FuncList[Code].ARROW
  else
//CLST:
  if C = 10 then  GetF:=FuncList[Code].CLST
  else
//ArgType:
  if C = 11 then  GetF:=FuncList[Code].ArgType
  else
//SaveReg:
  if C = 13 then  GetF:=FuncList[Code].SaveReg
  else
//FType:
  if C = 14 then  GetF:=FuncList[Code].FType
  else  GetF:=0;

endp:
end;




procedure TForevalH.SetF(C,Code,Value: Integer);
label endp;
var
PIC: ^TCode;
PII: ^TArrayI;
begin
if (Code >= 0) and (Code <= High(FuncList)) then
begin
  F_ErrorCode:=E_NONEXISTENT_FUNCTION;
  F_SyntaxErrorString:=IntToStr(Code);
  CalcException;
goto endp;
end;
//адрес:
  if C = 2 then
  begin
   if Value = 0 then FuncList[Code].Addr:=nil
   else
   FuncList[Code].Addr:=Pointer(Value);
   end
  else
//inl:
  if C = 3 then  FuncList[Code].inl:=Value
  else
//inlCode
  if C = 4 then
  begin
   PIC:=Pointer(Value);
   FuncList[Code].inlCode:=PIC^;
  end
  else
//NST:
  if C = 5 then  FuncList[Code].NST:=Value
  else
//id_FUNC:
  if C = 6 then  FuncList[Code].id_Func:=Value
  else
//Set_ID:
  if C = 7 then  FuncList[Code].Set_ID:=Value
  else
//Arg:
  if C = 8 then  FuncList[Code].Arg:=Value
  else
//ARROW:
  if C = 9 then  FuncList[Code].ARROW:=Value
  else
//CLST:
  if C = 10 then  FuncList[Code].CLST:=Value
  else
//ArgType:
  if C = 11 then  FuncList[Code].ArgType:=Value
  else
//ArgTypeList
  if C = 12 then
  begin
   PII:=Pointer(Value);
   FuncList[Code].ArgTypeList:=PII^;
  end
else
//SaveReg:
  if C = 13 then  FuncList[Code].SaveReg:=Value
  else
//FType:
  if C = 14 then  FuncList[Code].FType:=Value;

endp:
end;


end.
