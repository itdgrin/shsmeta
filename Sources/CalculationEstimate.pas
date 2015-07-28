unit CalculationEstimate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls,
  StdCtrls, Grids, DBGrids, Buttons, DB, Menus, ShellAPI, DateUtils,
  IniFiles, ImgList, Clipbrd, Math, pngimage, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls,
  CalculationEstimateSSR, CalculationEstimateSummaryCalculations, JvExDBGrids,
  JvDBGrid, JvDBUltimGrid, System.UITypes, System.Types, EditExpression,
  GlobsAndConst, FireDAC.UI.Intf, JvExComCtrls, JvDBTreeView,
  Generics.Collections,
  Generics.Defaults,
  fFrameCalculator,
  Data.FmtBcd;

type
  TAutoRepRec = record
    ID: Integer;
    DataType: Integer;
    Code: string;
  end;

  TAutoRepArray = array of TAutoRepRec;

  TSplitter = class(ExtCtrls.TSplitter)
  public
    procedure Paint(); override;
  end;

  TMyDBGrid = class(TJvDBGrid)
  public
    property DataLink;
  end;

  TTwoValues = record
    ForOne: Currency;
    ForCount: Currency;
  end;

  TCustomDBGridCracker = class(TCustomDBGrid);

  TFieldRates = record
    vRow: Variant;
    vNumber: Variant;
    vCount: Variant;
    vNameUnit: Variant;
    vDescription: Variant;
    vTypeAddData: Variant;
    vId: Variant;
  end;

type
  TFormCalculationEstimate = class(TForm)

    PanelTopMenu: TPanel;

    SpeedButtonLocalEstimate: TSpeedButton;
    SpeedButtonSummaryCalculation: TSpeedButton;
    SpeedButtonSSR: TSpeedButton;
    PanelLocalEstimate: TPanel;
    ImageSplitterBottom: TImage;
    SplitterBottom: TSplitter;
    PanelClient: TPanel;
    ImageSplitterCenter: TImage;
    SplitterCenter: TSplitter;
    PanelTopClient: TPanel;
    Label2: TLabel;
    edtRateActive: TEdit;
    edtRateActiveDate: TEdit;
    PanelClientLeft: TPanel;
    ImageSplitterLeft: TImage;
    SplitterLeft: TSplitter;
    PanelTableBottom: TPanel;
    PanelBottom: TPanel;
    Label10: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Panel1: TPanel;
    LabelOXROPR: TLabel;
    PanelSSR: TPanel;
    PanelData: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    EditVAT: TEdit;
    EditMonth: TEdit;
    Edit4: TEdit;
    PanelCalculationYesNo: TPanel;
    pmSummaryCalculation: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    pmSSRButtonAdd: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    pmSSRButtonTax: TPopupMenu;
    N6: TMenuItem;
    N7: TMenuItem;
    pmTableLeft: TPopupMenu;
    PMAdd: TMenuItem;
    PMDelete: TMenuItem;
    PopupMenuTableLeftTechnicalPart: TMenuItem;
    ModeData: TMenuItem;
    Normal: TMenuItem;
    Extended: TMenuItem;
    N22: TMenuItem;
    pmMaterials: TPopupMenu;
    pmCoef: TPopupMenu;
    PopupMenuCoefAddSet: TMenuItem;
    PopupMenuCoefDeleteSet: TMenuItem;
    PanelEstimate: TPanel;
    LabelEstimate: TLabel;
    EditNameEstimate: TEdit;
    PanelObject: TPanel;
    LabelObject: TLabel;
    LabelNumberContract: TLabel;
    LabelDateContract: TLabel;
    EditNameObject: TEdit;
    EditNumberContract: TEdit;
    EditDateContract: TEdit;
    BevelObject: TBevel;
    BevelEstimate: TBevel;
    LabelNameObject: TLabel;
    LabelNameEstimate: TLabel;
    LabelWinterPrice: TLabel;
    PopupMenuCoefSeparator1: TMenuItem;
    PopupMenuCoefCopy: TMenuItem;
    EditWinterPrice: TEdit;
    PopupMenuTableLeftTechnicalPart1: TMenuItem;
    PopupMenuTableLeftTechnicalPart2: TMenuItem;
    PopupMenuTableLeftTechnicalPart3: TMenuItem;
    PopupMenuTableLeftTechnicalPart4: TMenuItem;
    PopupMenuTableLeftTechnicalPart5: TMenuItem;
    PopupMenuTableLeftTechnicalPart6: TMenuItem;
    BevelTopMenu: TBevel;
    SpeedButtonModeTables: TSpeedButton;
    PanelNoData: TPanel;
    ShapeNoData: TShape;
    PanelClientRight: TPanel;
    ImageSplitterRightBottom: TImage;
    SplitterRightMemo: TSplitter;
    MemoRight: TMemo;
    PanelClientRightTables: TPanel;
    ImageSplitterRight1: TImage;
    ImageSplitterRight2: TImage;
    SplitterRight1: TSplitter;
    SplitterRight2: TSplitter;
    ImageNoData: TImage;
    LabelNoData1: TLabel;
    LabelNoData2: TLabel;
    PMAddAdditionTransportation�310: TMenuItem;
    PMAddAdditionTransportation�311: TMenuItem;
    PMAddDump: TMenuItem;
    PMAddAdditionHeatingE18: TMenuItem;
    PMAddAdditionHeatingE20: TMenuItem;
    PopupMenuRatesAdd352: TMenuItem;
    PMMatFromRates: TMenuItem;
    pmMechanizms: TPopupMenu;
    PMMechFromRates: TMenuItem;
    PMMatReplace: TMenuItem;
    PMAddAddition: TMenuItem;
    PMAddRatMatMechEquip: TMenuItem;
    PMAddRatMatMechEquipRef: TMenuItem;
    PMAddRatMatMechEquipOwn: TMenuItem;
    PMAddAdditionTransportation: TMenuItem;
    PMAddAdditionHeating: TMenuItem;
    PMAddAdditionTransportation�310Cargo: TMenuItem;
    PMAddAdditionTransportation�310Trash: TMenuItem;
    PMAddAdditionTransportation�311Cargo: TMenuItem;
    PMAddAdditionTransportation�311Trash: TMenuItem;
    N9: TMenuItem;
    PMMatEdit: TMenuItem;
    PMEdit: TMenuItem;
    PMCoefOrders: TMenuItem;
    PopupMenuCoefOrders: TMenuItem;
    LabelCategory: TLabel;
    EditCategory: TEdit;
    qrDescription: TFDQuery;
    qrTemp: TFDQuery;
    qrTemp1: TFDQuery;
    frSSR: TfrCalculationEstimateSSR;
    dsDescription: TDataSource;
    qrMechanizm: TFDQuery;
    dsMechanizm: TDataSource;
    qrDescriptionwork: TStringField;
    qrMechanizmID: TFDAutoIncField;
    qrMechanizmID_CARD_RATE: TIntegerField;
    qrMechanizmMECH_CODE: TStringField;
    qrMechanizmMECH_NAME: TStringField;
    qrMechanizmMECH_UNIT: TStringField;
    qrMechanizmFROM_RATE: TByteField;
    N8: TMenuItem;
    PMMechEdit: TMenuItem;
    dbgrdMechanizm: TJvDBGrid;
    qrMechanizmPROC_PODR: TSmallintField;
    qrMechanizmPROC_ZAC: TSmallintField;
    qrMaterial: TFDQuery;
    dsMaterial: TDataSource;
    dbgrdMaterial: TJvDBGrid;
    qrMaterialID_CARD_RATE: TIntegerField;
    qrMaterialID_REPLACED: TIntegerField;
    qrMaterialCONSIDERED: TByteField;
    qrMaterialREPLACED: TByteField;
    qrMaterialFROM_RATE: TByteField;
    qrMaterialMAT_ID: TIntegerField;
    qrMaterialMAT_CODE: TStringField;
    qrMaterialMAT_NAME: TStringField;
    qrMaterialMAT_UNIT: TStringField;
    qrMaterialSTATE_MATERIAL: TShortintField;
    qrMaterialSTATE_TRANSPORT: TByteField;
    qrMaterialMAT_PROC_ZAC: TIntegerField;
    qrMaterialMAT_PROC_PODR: TIntegerField;
    qrMaterialTRANSP_PROC_ZAC: TIntegerField;
    qrMaterialTRANSP_PROC_PODR: TIntegerField;
    qrMaterialNUM: TIntegerField;
    qrMaterialSCROLL: TIntegerField;
    qrMaterialTITLE: TIntegerField;
    N10: TMenuItem;
    qrDevices: TFDQuery;
    dsDevices: TDataSource;
    dbgrdDevices: TJvDBGrid;
    pmDevices: TPopupMenu;
    PMDevEdit: TMenuItem;
    dbgrdCalculations: TJvDBGrid;
    qrCalculations: TFDQuery;
    dsCalculations: TDataSource;
    qrMechanizmSCROLL: TIntegerField;
    qrMechanizmNUM: TIntegerField;
    dbmmoCAPTION: TDBMemo;
    qrDump: TFDQuery;
    dsDump: TDataSource;
    btnDump: TSpeedButton;
    dbgrdDump: TJvDBGrid;
    qrDumpDUMP_NAME: TStringField;
    qrDumpDUMP_CODE_JUST: TStringField;
    qrDumpDUMP_JUST: TStringField;
    qrDumpDUMP_UNIT: TStringField;
    qrDumpDUMP_TYPE: TByteField;
    qrDumpWORK_UNIT: TStringField;
    qrDumpWORK_TYPE: TByteField;
    qrDumpNUM: TIntegerField;
    pmDumpTransp: TPopupMenu;
    PMDumpEdit: TMenuItem;
    dbgrdDescription: TJvDBGrid;
    btnTransp: TSpeedButton;
    btnStartup: TSpeedButton;
    qrTransp: TFDQuery;
    qrStartup: TFDQuery;
    dsTransp: TDataSource;
    dsStartup: TDataSource;
    dbgrdTransp: TJvDBGrid;
    qrTranspTRANSP_TYPE: TByteField;
    qrTranspTRANSP_CODE_JUST: TStringField;
    qrTranspTRANSP_JUST: TStringField;
    qrTranspCARG_CLASS: TByteField;
    qrTranspCARG_UNIT: TStringField;
    qrTranspCARG_TYPE: TByteField;
    qrTranspNUM: TIntegerField;
    qrStartupRATE_CODE: TStringField;
    qrStartupRATE_CAPTION: TStringField;
    qrStartupRATE_UNIT: TStringField;
    qrStartupNUM: TIntegerField;
    dbgrdStartup: TJvDBGrid;
    qrTranspCLASS: TStringField;
    qrTranspTRANSP_UNIT: TStringField;
    tmRate: TTimer;
    qrMaterialCONS_REPLASED: TByteField;
    PMMatDelete: TMenuItem;
    qrOXROPR: TFDQuery;
    dblkcbbOXROPR: TDBLookupComboBox;
    dsOXROPR: TDataSource;
    btn1: TSpeedButton;

    pmWinterPrise: TPopupMenu;
    nSelectWinterPrise: TMenuItem;
    nWinterPriseSetDefault: TMenuItem;
    PMMechReplace: TMenuItem;
    PMMechDelete: TMenuItem;
    qrMechanizmID_REPLACED: TIntegerField;
    qrMechanizmREPLACED: TByteField;
    qrRatesEx: TFDQuery;
    dsRatesEx: TDataSource;
    grRatesEx: TJvDBGrid;
    qrMechanizmTITLE: TIntegerField;
    qrRatesExITERATOR: TIntegerField;
    qrRatesExOBJ_CODE: TStringField;
    qrRatesExOBJ_NAME: TStringField;
    qrRatesExOBJ_UNIT: TStringField;
    qrRatesExID_TYPE_DATA: TIntegerField;
    qrRatesExDATA_ESTIMATE_OR_ACT_ID: TIntegerField;
    qrRatesExID_TABLES: TIntegerField;
    qrRatesExSM_ID: TIntegerField;
    qrRatesExWORK_ID: TIntegerField;
    qrRatesExZNORMATIVS_ID: TIntegerField;
    qrRatesExAPPLY_WINTERPRISE_FLAG: TShortintField;
    dblkcbbID_TYPE_DATA: TDBLookupComboBox;
    qrTypeData: TFDQuery;
    dsTypeData: TDataSource;
    qrRatesExID_RATE: TIntegerField;
    strngfldRatesExSORT_ID: TStringField;
    PMMatAddToRate: TMenuItem;
    PMMechAddToRate: TMenuItem;
    qrMaterialADDED: TByteField;
    qrMechanizmADDED: TByteField;
    qrMaterialNDS: TIntegerField;
    qrMechanizmNDS: TIntegerField;
    mAddPTM: TMenuItem;
    mN11: TMenuItem;
    mDelEstimate: TMenuItem;
    mAddLocal: TMenuItem;
    mEditEstimate: TMenuItem;
    mBaseData: TMenuItem;
    qrMaterialDELETED: TByteField;
    qrMechanizmDELETED: TByteField;
    PMMatRestore: TMenuItem;
    PMMechRestore: TMenuItem;
    qrRatesExOBJ_COUNT: TFloatField;
    PMCopy: TMenuItem;
    PMPaste: TMenuItem;
    qrRatesExADDED_COUNT: TIntegerField;
    qrRatesExREPLACED_COUNT: TIntegerField;
    qrRatesExINCITERATOR: TIntegerField;
    qrRatesExNUM_ROW: TIntegerField;
    strngfldRatesExSORT_ID2: TStringField;
    pmAddRate: TPopupMenu;
    PMAddRateOld: TMenuItem;
    PMAddRateNew: TMenuItem;
    PMRateRef: TMenuItem;
    mN12: TMenuItem;
    PMCalcMat: TMenuItem;
    PMCalcMech: TMenuItem;
    PMCalcDevice: TMenuItem;
    N11: TMenuItem;
    PMDeviceReplace: TMenuItem;
    qrDevicesDEVICE_ID: TIntegerField;
    qrDevicesDEVICE_CODE: TStringField;
    qrDevicesDEVICE_NAME: TStringField;
    qrDevicesDEVICE_COUNT: TFMTBCDField;
    qrDevicesDEVICE_UNIT: TStringField;
    qrDevicesDEVICE_SUM_NDS: TFMTBCDField;
    qrDevicesDEVICE_SUM_NO_NDS: TFMTBCDField;
    qrDevicesDEVICE_TRANSP_NO_NDS: TFMTBCDField;
    qrDevicesDEVICE_TRANSP_NDS: TFMTBCDField;
    qrDevicesFCOAST_NO_NDS: TFMTBCDField;
    qrDevicesFCOAST_NDS: TFMTBCDField;
    qrDevicesNDS: TWordField;
    qrDevicesFPRICE_NDS: TFMTBCDField;
    qrDevicesFPRICE_NO_NDS: TFMTBCDField;
    qrDevicesPROC_PODR: TWordField;
    qrDevicesPROC_ZAC: TWordField;
    qrDevicesTRANSP_PROC_PODR: TWordField;
    qrDevicesTRANSP_PROC_ZAC: TWordField;
    qrDevicesSCROLL: TBCDField;
    qrDevicesNUM: TIntegerField;
    qrStartupRATE_COUNT: TFMTBCDField;
    qrTranspTRANSP_COUNT: TFMTBCDField;
    qrTranspTRANSP_DIST: TFMTBCDField;
    qrTranspTRANSP_SUM_NDS: TFMTBCDField;
    qrTranspTRANSP_SUM_NO_NDS: TFMTBCDField;
    qrTranspCOAST_NO_NDS: TFMTBCDField;
    qrTranspCOAST_NDS: TFMTBCDField;
    qrTranspCARG_COUNT: TFMTBCDField;
    qrTranspCARG_YDW: TFMTBCDField;
    qrTranspNDS: TIntegerField;
    qrTranspPRICE_NDS: TFMTBCDField;
    qrTranspPRICE_NO_NDS: TFMTBCDField;
    qrTranspKOEF: TFMTBCDField;
    qrDumpDUMP_COUNT: TFMTBCDField;
    qrDumpDUMP_SUM_NDS: TFMTBCDField;
    qrDumpDUMP_SUM_NO_NDS: TFMTBCDField;
    qrDumpCOAST_NO_NDS: TFMTBCDField;
    qrDumpCOAST_NDS: TFMTBCDField;
    qrDumpWORK_COUNT: TFMTBCDField;
    qrDumpWORK_YDW: TFMTBCDField;
    qrDumpNDS: TIntegerField;
    qrDumpPRICE_NDS: TFMTBCDField;
    qrDumpPRICE_NO_NDS: TFMTBCDField;
    qrDumpFCOAST_NDS: TFMTBCDField;
    qrDumpFCOAST_NO_NDS: TFMTBCDField;
    qrDumpFPRICE_NDS: TFMTBCDField;
    qrDumpFPRICE_NO_NDS: TFMTBCDField;
    qrMechanizmMECH_ID: TIntegerField;
    qrMechanizmMECH_NORMA: TFMTBCDField;
    qrMechanizmMECH_COUNT: TFMTBCDField;
    qrMechanizmMECH_SUM_NO_NDS: TFMTBCDField;
    qrMechanizmMECH_SUM_NDS: TFMTBCDField;
    qrMechanizmMECH_ZPSUM_NO_NDS: TFMTBCDField;
    qrMechanizmMECH_ZPSUM_NDS: TFMTBCDField;
    qrMechanizmCOAST_NO_NDS: TFMTBCDField;
    qrMechanizmCOAST_NDS: TFMTBCDField;
    qrMechanizmZP_MACH_NO_NDS: TFMTBCDField;
    qrMechanizmZP_MACH_NDS: TFMTBCDField;
    qrMechanizmPRICE_NO_NDS: TFMTBCDField;
    qrMechanizmPRICE_NDS: TFMTBCDField;
    qrMechanizmZPPRICE_NO_NDS: TFMTBCDField;
    qrMechanizmZPPRICE_NDS: TFMTBCDField;
    qrMechanizmFCOAST_NO_NDS: TFMTBCDField;
    qrMechanizmFCOAST_NDS: TFMTBCDField;
    qrMechanizmFZP_MACH_NO_NDS: TFMTBCDField;
    qrMechanizmFZP_MACH_NDS: TFMTBCDField;
    qrMechanizmFPRICE_NO_NDS: TFMTBCDField;
    qrMechanizmFPRICE_NDS: TFMTBCDField;
    qrMechanizmFZPPRICE_NO_NDS: TFMTBCDField;
    qrMechanizmFZPPRICE_NDS: TFMTBCDField;
    qrMechanizmNORMATIV: TFMTBCDField;
    qrMechanizmNORM_TRYD: TFMTBCDField;
    qrMechanizmTERYDOZATR: TFMTBCDField;
    qrMaterialMAT_NORMA: TFMTBCDField;
    qrMaterialMAT_COUNT: TFMTBCDField;
    qrMaterialMAT_SUM_NDS: TFMTBCDField;
    qrMaterialMAT_SUM_NO_NDS: TFMTBCDField;
    qrMaterialMAT_TRANSP_NO_NDS: TFMTBCDField;
    qrMaterialMAT_TRANSP_NDS: TFMTBCDField;
    qrMaterialCOAST_NO_NDS: TFMTBCDField;
    qrMaterialCOAST_NDS: TFMTBCDField;
    qrMaterialTRANSP_NO_NDS: TFMTBCDField;
    qrMaterialPROC_TRANSP: TFMTBCDField;
    qrMaterialTRANSP_NDS: TFMTBCDField;
    qrMaterialPRICE_NO_NDS: TFMTBCDField;
    qrMaterialPRICE_NDS: TFMTBCDField;
    qrMaterialFCOAST_NO_NDS: TFMTBCDField;
    qrMaterialFCOAST_NDS: TFMTBCDField;
    qrMaterialFTRANSP_NO_NDS: TFMTBCDField;
    qrMaterialFTRANSP_NDS: TFMTBCDField;
    qrMaterialFPRICE_NO_NDS: TFMTBCDField;
    qrMaterialFPRICE_NDS: TFMTBCDField;
    N12: TMenuItem;
    PMMatAutoRep: TMenuItem;
    N13: TMenuItem;
    PMMechAutoRep: TMenuItem;
    qrRatesExID_REPLACED: TIntegerField;
    qrMechanizmKOEF: TFloatField;
    qrMechanizmMECH_INPUTCOUNT: TFMTBCDField;
    pnlSummaryCalculations: TPanel;
    frSummaryCalculations: TfrCalculationEstimateSummaryCalculations;
    qrMaterialID: TIntegerField;
    qrDumpID: TIntegerField;
    qrTranspID: TIntegerField;
    qrDevicesID: TIntegerField;
    qrDumpDUMP_ID: TIntegerField;
    qrRatesExID_ACT: TIntegerField;
    btnMaterials: TSpeedButton;
    btnMechanisms: TSpeedButton;
    btnEquipments: TSpeedButton;
    btnDescription: TSpeedButton;
    btnKC6: TButton;
    btnResMat: TSpeedButton;
    btnResMech: TSpeedButton;
    btnResDev: TSpeedButton;
    btnResZP: TSpeedButton;
    btnResCalc: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

    procedure SpeedButtonLocalEstimateClick(Sender: TObject);
    procedure SpeedButtonSummaryCalculationClick(Sender: TObject);
    procedure SpeedButtonSSRClick(Sender: TObject);
    procedure PanelCalculationYesNoClick(Sender: TObject);
    procedure BottomTopMenuEnabled(const Value: Boolean);

    procedure RepaintImagesForSplitters();

    procedure ButtonSSRDetailsClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure ButtonSSRAddClick(Sender: TObject);
    procedure ButtonSSRTaxClick(Sender: TObject);
    procedure ButtonSRRNewClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PopupMenuTableLeftTechnicalPartClick(Sender: TObject);

    // ������� ����������� ���� � ������ �������
    procedure PopupMenuCoefAddSetClick(Sender: TObject);
    procedure PopupMenuCoefDeleteSetClick(Sender: TObject);

    // ������� ������ ������
    procedure btnDescriptionClick(Sender: TObject);
    procedure btnMaterialsClick(Sender: TObject);
    procedure btnMechanismsClick(Sender: TObject);

    // ���������� ������� ������ ������ �� ��������� ������ � ������� ��������
    procedure GridRatesRowSellect;
    // �������� ������ ��������� ��� ��������� ������ � ������� ��������
    procedure GridRatesRowLoad;
    // �������� ��������� ��� ������ ������
    procedure FillingTableMaterials(const vIdCardRate, vIdMat: Integer);
    procedure FillingTableMechanizm(const vIdCardRate, vIdMech: Integer);
    procedure FillingTableDevises(const vIdDev: Integer);
    procedure FillingTableDump(const vIdDump: Integer);
    procedure FillingTableTransp(const vIdTransp: Integer);
    procedure FillingTableStartup(const vStType: Integer);
    procedure FillingTableDescription(const vIdNormativ: Integer);

    // ������� ������ �������-����������
    function GetRankBuilders(const vIdNormativ: string): Double;

    // ������� ����� �������-����������
    function GetWorkCostBuilders(const vIdNormativ: string): Double;

    // ������� ����� ����������
    function GetWorkCostMachinists(const vIdNormativ: string): Double;

    // ������ �� (���������� �����)
    function CalculationSalary(const vIdNormativ: string): TTwoValues; // +++

    // ����� ������� �� ���������
    function GetNormMechanizm(const vIdNormativ, vIdMechanizm: string): Double;

    // ���� �� ���������
    function GetPriceMechanizm(const vIdNormativ, vIdMechanizm: string): Currency;

    // �������� ��������� (�� ���.)
    function GetSalaryMachinist(const vIdMechanizm: Integer): Currency;

    // ���� ������������� (������, ������) ���������
    function GetCoastMechanizm(const vIdMechanizm: Integer): Currency;

    procedure EstimateBasicDataClick(Sender: TObject);
    procedure LabelObjectClick(Sender: TObject);
    procedure LabelEstimateClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure PanelTopMenuResize(Sender: TObject);
    procedure SettingVisibleRightTables;
    procedure PanelClientRightTablesResize(Sender: TObject);
    procedure btnEquipmentsClick(Sender: TObject);
    procedure SpeedButtonModeTablesClick(Sender: TObject);
    procedure GetMonthYearCalculationEstimate;
    procedure GetSourceData;
    procedure FillingWinterPrice(vNumber: string);

    procedure PMDeleteClick(Sender: TObject);
    procedure PanelNoDataResize(Sender: TObject);
    procedure TestOnNoData(SG: TStringGrid);
    procedure TestOnNoDataNew(ADataSet: TDataSet);
    procedure PMMatFromRatesClick(Sender: TObject);
    procedure VisibleColumnsWinterPrice(Value: Boolean);
    procedure ShowFormAdditionData(const vDataBase: Char);
    procedure PMAddRatMatMechEquipRefClick(Sender: TObject);
    procedure PMAddRatMatMechEquipOwnClick(Sender: TObject);
    procedure pmMaterialsPopup(Sender: TObject);
    procedure pmTableLeftPopup(Sender: TObject);
    procedure pmCoefPopup(Sender: TObject);
    procedure btnKC6Click(Sender: TObject);

    procedure OutputDataToTable(ANewRow: Boolean = False); // ���������� ������� ��������

    procedure AddRate(const vRateId: Integer);
    procedure AddMaterial(const vMatId: Integer);
    procedure AddMechanizm(const vMechId: Integer);
    procedure AddDevice(const vEquipId: Integer);

    procedure PMMechFromRatesClick(Sender: TObject);
    procedure dbgrdRates12DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure qrRatesExAfterScroll(DataSet: TDataSet);
    procedure qrRatesExCOUNTChange(Sender: TField);
    procedure dbgrdDescription1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure qrDescriptionAfterScroll(DataSet: TDataSet);
    procedure qrMechanizmBeforeInsert(DataSet: TDataSet);
    procedure qrMechanizmAfterScroll(DataSet: TDataSet);
    procedure qrMechanizmCalcFields(DataSet: TDataSet);
    procedure dbgrdMechanizmDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure qrMechanizmBeforeScroll(DataSet: TDataSet);
    procedure MechRowChange(Sender: TField);
    procedure MatRowChange(Sender: TField);
    procedure dbgrdMechanizmExit(Sender: TObject);
    procedure pmMechanizmsPopup(Sender: TObject);
    procedure qrRatesExBeforePost(DataSet: TDataSet);
    procedure MemoRightExit(Sender: TObject);
    procedure MemoRightChange(Sender: TObject);
    procedure qrMaterialBeforeScroll(DataSet: TDataSet);
    procedure qrMaterialAfterScroll(DataSet: TDataSet);
    procedure dbgrdMaterialDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure PMMatMechEditClick(Sender: TObject);
    procedure dbgrdMaterialExit(Sender: TObject);
    procedure dbgrdDevicesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure qrDevicesBeforeScroll(DataSet: TDataSet);
    procedure qrDevicesAfterScroll(DataSet: TDataSet);
    procedure PMDevEditClick(Sender: TObject);
    procedure DevRowChange(Sender: TField);
    procedure dbgrdDevicesExit(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PMAddDumpClick(Sender: TObject);
    procedure btnDumpClick(Sender: TObject);
    procedure qrDumpAfterScroll(DataSet: TDataSet);
    procedure PMDumpEditClick(Sender: TObject);
    procedure PMAddTranspClick(Sender: TObject);
    procedure btnTranspClick(Sender: TObject);
    procedure btnStartupClick(Sender: TObject);
    procedure qrTranspAfterScroll(DataSet: TDataSet);
    procedure qrStartupAfterScroll(DataSet: TDataSet);
    procedure qrTranspCalcFields(DataSet: TDataSet);
    procedure PMAddAdditionHeatingE18Click(Sender: TObject);
    procedure qrRatesExCODEChange(Sender: TField);
    procedure PMEditClick(Sender: TObject);
    procedure tmRateTimer(Sender: TObject);
    procedure dbgrdRatesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrdMechanizmKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrdMaterialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrdDumpKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrdDevicesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrdRatesEnter(Sender: TObject);
    procedure PMMatDeleteClick(Sender: TObject);
    procedure qrRatesWORK_IDChange(Sender: TField);
    procedure btn1Click(Sender: TObject);
    procedure ReplacementClick(Sender: TObject);
    procedure nSelectWinterPriseClick(Sender: TObject);
    procedure nWinterPriseSetDefaultClick(Sender: TObject);
    procedure PMMechDeleteClick(Sender: TObject);
    procedure PMAddAdditionHeatingClick(Sender: TObject);
    procedure PMMatAddToRateClick(Sender: TObject);
    procedure mAddPTMClick(Sender: TObject);
    procedure mDelEstimateClick(Sender: TObject);
    procedure mAddLocalClick(Sender: TObject);
    procedure mEditEstimateClick(Sender: TObject);
    procedure mBaseDataClick(Sender: TObject);
    procedure PMMatRestoreClick(Sender: TObject);
    procedure PMMechRestoreClick(Sender: TObject);
    procedure PMCopyClick(Sender: TObject);
    procedure PMPasteClick(Sender: TObject);
    procedure LabelNameEstimateClick(Sender: TObject);
    procedure qrRatesExCalcFields(DataSet: TDataSet);
    procedure qrRatesExAfterOpen(DataSet: TDataSet);
    procedure qrRatesExNUM_ROWChange(Sender: TField);
    procedure PMAddRateOldClick(Sender: TObject);
    procedure PMRateRefClick(Sender: TObject);
    procedure PMCalcMatClick(Sender: TObject);
    procedure PMCalcMechClick(Sender: TObject);
    procedure PMCalcDeviceClick(Sender: TObject);
    procedure pmDevicesPopup(Sender: TObject);
    procedure PMMechAutoRepClick(Sender: TObject);
    procedure btnResMatClick(Sender: TObject);
  private const
    CaptionButton: array [1 .. 2] of string = ('������ �����', '������ ����');
    HintButton: array [1 .. 2] of string = ('���� ������� �����', '���� ������� ����');
  private
    Act: Boolean;
    ActReadOnly: Boolean;
    RowCoefDefault: Boolean;

    FIdObject: Integer;
    FIdAct: Integer;
    FIdEstimate: Integer;

    NDSEstimate: Boolean; // ������  � ��� ��� ���

    FMonthEstimate: Integer;
    FYearEstimate: Integer;
    FRegion: Integer;

    VisibleRightTables: String; // ��������� ����������� ������ ������� ������

    WCWinterPrice: Integer;
    WCSalaryWinterPrice: Integer;

    CountFromRate: Double;

    // ����� ��������� �� ������ ��������, ��������� ������������ � ������������ �nChange;
    FReCalcMech, FReCalcMat, FReCalcDev: Boolean;
    // ��������� ��� �������� ������ ������ ����� ���������� � ����������
    // ID ����������� ��������� ������� ���� ����������
    FIdReplasedMat: Integer;
    // ID ����������� ��������� ������� ���� ����������
    FIdReplasingMat: Integer;
    // ID ����������� ��������� ������� ���� ����������
    FIdReplasedMech: Integer;
    // ID ����������� ��������� ������� ���� ����������
    FIdReplasingMech: Integer;

    IsUnAcc: Boolean;

    // ��������� ������� � ������� ��� �����, ������������ ��� ���������
    FLastEntegGrd: TJvDBGrid;
    // ����� ������������� ���������� ������������� �������� ���� � �����������
    FAutoAddE18, FAutoAddE20: Boolean;
    // ����� ��� ������� ����������� ����, ������������ ��� ����������� ��������
    FCalculator: TCalculator;
    // ������ ��� ���������� (������ ������� �� ������� ����� ����������� ����������)
    FAutoRepArray: TAutoRepArray;
    // ������������� ��� ����������� � ������ � ������� ��������
    procedure ReCalcRowRates;

    // ��������� ���-�� � ���������� ���������� � ��������
    procedure GridRatesUpdateCount;
    // ��������� ���-�� �� ����� ������
    procedure UpdateMatCountInGridRate(AMId: Integer; AMCount: TBcd);

    // �������� ������� ��� ������ � ����������� �� ���
    procedure ChangeGrigNDSStyle(aNDS: Boolean);

    // ��������� ��� �������� ������ �������� (��������� ��� ����������)
    function CheckMatINRates: Boolean;

    // �������� ��� �������� ��������� � ������� ����������
    function CheckMatUnAccountingMatirials: Boolean;

    procedure ReCalcRowMat(ACType: byte); // �������� ������ ���������
    function CheckMatReadOnly: Boolean; // �������� ����� �� ������������� ������ ������
    procedure SetMatReadOnly(AValue: Boolean); // ������������� ����� ��������������
    procedure SetMatEditMode; // ��������� ������ ������������ �������������� ����������
    procedure SetMatNoEditMode; // ���������� ������ ������������ �������������� ����������

    procedure ReCalcRowMech(ACType: byte); // �������� ������ ���������
    function CheckMechReadOnly: Boolean; // �������� ����� �� ������������� ������ ������
    procedure SetMechReadOnly(AValue: Boolean); // ������������� ����� ��������������
    procedure SetMechEditMode; // ��������� ������ ������������ �������������� ���������
    procedure SetMechNoEditMode; // ���������� ������ ������������ �������������� ���������

    procedure ReCalcRowDev; // �������� ������ ������������
    procedure SetDevEditMode; // ��������� ������ ������������ �������������� ������������
    procedure SetDevNoEditMode; // ���������� ������ ������������ �������������� ������������
    // ��������� ���� �� ���� � ����������� � ������� �����
    function CheckE1820(AType: Integer): Boolean;
    // ���������, ��� ������ ����� �� ����� (���)
    function CheckCursorInRate: Boolean;

    // ����� �������� ��� ���������� �����������
    procedure ClearAutoRep; // ������� ������ ����������
    procedure CheckNeedAutoRep(AID, AType: Integer; ACode: string); // ��������� ������������� � ������
    procedure ShowAutoRep; // ���������� ������ ������ ��� ���� �� �������
  public
    ConfirmCloseForm: Boolean;

    property IdObject: Integer read FIdObject write FIdObject;
    property IdAct: Integer read FIdAct write FIdAct;
    property IdEstimate: Integer read FIdEstimate write FIdEstimate;
    property MonthEstimate: Integer read FMonthEstimate write FMonthEstimate;
    property YearEstimate: Integer read FYearEstimate write FYearEstimate;
    property Region: Integer read FRegion write FRegion;

    function GetCountCoef(): Integer;
    procedure AddCoefToRate(coef_id: Integer);

    procedure SetActReadOnly(const Value: Boolean);
    procedure CreateTempTables;
    procedure OpenAllData;
    procedure Wheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
      var Handled: Boolean);
    procedure RecalcEstimate;
    constructor Create(const isAct: Boolean); reintroduce;
  protected
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  const
    Indent = '     ';

  end;

var
  FormCalculationEstimate: TFormCalculationEstimate;
  TwoValues: TTwoValues;

function NDSToNoNDS(AValue, aNDS: Currency): Currency;
function NoNDSToNDS(AValue, aNDS: Currency): Currency;
function NDSToNoNDS1(AValue, aNDS: TBcd): TBcd;
function NoNDSToNDS1(AValue, aNDS: TBcd): TBcd;

implementation

uses Main, DataModule, SignatureSSR, Waiting,
  SummaryCalculationSettings, DataTransfer,
  BasicData, ObjectsAndEstimates, Transportation,
  CalculationDump, SaveEstimate,
  AdditionData, CardMaterial, CardDataEstimate,
  KC6, CardAct, Tools, Coef, WinterPrice,
  ReplacementMatAndMech, CardEstimate, KC6Journal,
  TreeEstimate, ImportExportModule, CalcResource;
{$R *.dfm}

function NDSToNoNDS(AValue, aNDS: Currency): Currency;
begin
  Result := Round(AValue / (1.000000 + 0.010000 * aNDS));
end;

function NoNDSToNDS(AValue, aNDS: Currency): Currency;
begin
  Result := Round(AValue * (1.000000 + 0.010000 * aNDS));
end;

function NDSToNoNDS1(AValue, aNDS: TBcd): TBcd;
begin
  Result := AValue / (1.000000 + 0.010000 * aNDS);
  Result := CurrencyToBcd(Round(BCDToCurrency(Result)));
end;

function NoNDSToNDS1(AValue, aNDS: TBcd): TBcd;
begin
  Result := AValue * (1.000000 + 0.010000 * aNDS);
  Result := CurrencyToBcd(Round(BCDToCurrency(Result)));
end;

{ TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
  FormCalculationEstimate.RepaintImagesForSplitters();
end;

procedure TFormCalculationEstimate.Wheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint; var Handled: Boolean);
begin
  with TJvDBGrid(Sender) do
  begin
    if Assigned(DataSource) then
      if Assigned(DataSource.DataSet) then
        if DataSource.DataSet.Active then
          DataSource.DataSet.MoveBy(-1 * Sign(WheelDelta));
  end;
  Handled := True;
end;

procedure TFormCalculationEstimate.WMSysCommand(var Msg: TMessage);
begin
  // SC_MAXIMIZE - �������������� ����� �� ���� �����
  // SC_RESTORE - ������������ ����� � ����
  // SC_MINIMIZE - ������������ ����� � ��������� ������

  if (Msg.WParam = SC_MAXIMIZE) or (Msg.WParam = SC_RESTORE) then
  begin
    FormMain.PanelCover.Visible := True;
    inherited;
    FormMain.PanelCover.Visible := False;
  end
  else if Msg.WParam = SC_MINIMIZE then
  begin
    FormMain.PanelCover.Visible := True;
    inherited;
    ShowWindow(FormCalculationEstimate.Handle, SW_HIDE);
    // �������� ������ �������� �����
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

procedure TFormCalculationEstimate.FormCreate(Sender: TObject);
begin
  FormMain.mCalcResources.Visible := True;
  FormMain.PanelCover.Visible := True; // ���������� ������ �� ������� �����

  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10;
  Left := 10;

  WindowState := wsMaximized;
  if not Act then
  begin
    Caption := CaptionButton[1] + ' - ��������� �������������� ���������';
  end
  else
  begin
    Caption := CaptionButton[2] + ' - ��������� �������������� ���������';
    SpeedButtonSSR.Visible := False;
    btnResCalc.Caption := '������';
  end;
  // -----------------------------------------

  IdObject := 0;
  IdEstimate := 0;

  if VisibleRightTables <> '1000000' then
  begin
    VisibleRightTables := '1000000';
    SettingVisibleRightTables;
  end;

  VisibleRightTables := '';

  ShowHint := True;

  // ��������� ����������� ��� ����������

  with DM.ImageListHorozontalDots do
  begin
    GetIcon(0, ImageSplitterBottom.Picture.Icon);
    GetIcon(0, ImageSplitterLeft.Picture.Icon);
    GetIcon(0, ImageSplitterRight1.Picture.Icon);
    GetIcon(0, ImageSplitterRight2.Picture.Icon);
    GetIcon(0, ImageSplitterRightBottom.Picture.Icon);
  end;

  with DM.ImageListVerticalDots do
  begin
    GetIcon(0, ImageSplitterCenter.Picture.Icon);
  end;

  with DM.ImageListModeTables do
  begin
    GetBitmap(0, SpeedButtonModeTables.Glyph);
  end;

  // -----------------------------------------

  PanelLocalEstimate.Visible := True;
  pnlSummaryCalculations.Visible := False;
  PanelSSR.Visible := False;

  PanelLocalEstimate.Align := alClient;
  pnlSummaryCalculations.Align := alClient;
  PanelSSR.Align := alClient;

  PanelClientLeft.Width := 2 * ((FormMain.ClientWidth - 5) div 7);

  dbgrdCalculations.Constraints.MinHeight := 50;
  PanelClientLeft.Constraints.MinWidth := 30;
  dbmmoCAPTION.Constraints.MinHeight := 45;
  MemoRight.Constraints.MinHeight := 45;

  ConfirmCloseForm := True;

  RowCoefDefault := True;
  // ������ ������ � ������ ��������
  PanelTableBottom.Height := 110 + PanelBottom.Height;

  // ��������� ����� DBGrid �������
  LoadDBGridSettings(dbgrdMaterial);
  LoadDBGridSettings(dbgrdMechanizm);
  LoadDBGridSettings(dbgrdDevices);
  LoadDBGridSettings(dbgrdDescription);
  LoadDBGridSettings(dbgrdDump);
  LoadDBGridSettings(dbgrdTransp);
  LoadDBGridSettings(dbgrdStartup);
  LoadDBGridSettings(dbgrdCalculations);
  LoadDBGridSettings(grRatesEx);

  // �� ��������� ����� ���������� �������� ���� � �����������
  FAutoAddE18 := True;
  FAutoAddE20 := True;

  FCalculator := TCalculator.Create(Self);
  FCalculator.Parent := TWinControl(Self);
  FCalculator.Visible := False;

  if not Act then
    FormMain.CreateButtonOpenWindow(CaptionButton[1], HintButton[1], Self, 1)
  else
    FormMain.CreateButtonOpenWindow(CaptionButton[2], HintButton[2], Self, 1)
end;

procedure TFormCalculationEstimate.FormShow(Sender: TObject);
begin
  SettingVisibleRightTables;

  grRatesEx.SetFocus;

  FormMain.TimerCover.Enabled := True;
  // ��������� ������ ������� ������ ������ ����� ����������� �����
end;

procedure TFormCalculationEstimate.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  if not Act then
    FormMain.SelectButtonActiveWindow(CaptionButton[1])
  else
    FormMain.SelectButtonActiveWindow(CaptionButton[2]);
end;

procedure TFormCalculationEstimate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FormMain.mCalcResources.Visible := False;
  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  if not Act then
    FormMain.DeleteButtonCloseWindow(CaptionButton[1])
  else
    FormMain.DeleteButtonCloseWindow(CaptionButton[2]);
  if (not Assigned(FormObjectsAndEstimates)) then
    FormObjectsAndEstimates := TFormObjectsAndEstimates.Create(FormMain);
end;

procedure TFormCalculationEstimate.FormDestroy(Sender: TObject);
begin
  FormCalculationEstimate := nil;
end;

procedure TFormCalculationEstimate.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  res: Variant;
begin
  if Shift = [] then
  begin
    case Key of
      vkEqual:
        begin
          // ���� ������� ������ ������� � ������� �����
          if CheckQrActiveEmpty(qrRatesEx) and (ActiveControl = grRatesEx) and
            (grRatesEx.SelectedField = qrRatesExOBJ_COUNT) then
          begin
            res := CalcExpression(qrRatesExOBJ_COUNT.AsString);
            if VarIsNull(res) then
              Exit;
            qrRatesEx.Edit;
            qrRatesExOBJ_COUNT.Value := res;
          end;
        end;
    end;
  end;
end;

procedure TFormCalculationEstimate.FormResize(Sender: TObject);
begin
  FixDBGridColumnsWidth(dbgrdCalculations);
end;

procedure TFormCalculationEstimate.SpeedButtonLocalEstimateClick(Sender: TObject);
begin
  // ��������� �������
  if (Assigned(fCalcResource)) then
    fCalcResource.Close;

  if SpeedButtonLocalEstimate.Tag = 0 then
  begin
    SpeedButtonLocalEstimate.Down := True;

    SpeedButtonLocalEstimate.Tag := 1;
    SpeedButtonSummaryCalculation.Tag := 0;
    SpeedButtonSSR.Tag := 0;

    // ��������� ��������� �������
    PanelLocalEstimate.Visible := True;
    pnlSummaryCalculations.Visible := False;
    PanelSSR.Visible := False;

    // ������ ������ �������� ������� ���� ���������
    BottomTopMenuEnabled(True);

    PanelCalculationYesNo.Enabled := True;

    if PanelCalculationYesNo.Tag = 1 then
      PanelCalculationYesNo.Color := clLime
    else
      PanelCalculationYesNo.Color := clRed;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonSummaryCalculationClick(Sender: TObject);
begin
  // ��������� �������
  if (Assigned(fCalcResource)) then
    fCalcResource.Close;

  if SpeedButtonSummaryCalculation.Tag = 0 then
  begin
    SpeedButtonSummaryCalculation.Down := True;

    SpeedButtonLocalEstimate.Tag := 0;
    SpeedButtonSummaryCalculation.Tag := 1;
    SpeedButtonSSR.Tag := 0;

    // ��������� ��������� �������
    PanelLocalEstimate.Visible := False;
    pnlSummaryCalculations.Visible := True;
    PanelSSR.Visible := False;

    // ������������� ���������� ������ �������
    frSummaryCalculations.LoadData(VarArrayOf([IdEstimate, IdAct]));

    // ������ ������ �������� ������� ���� �����������
    BottomTopMenuEnabled(False);

    PanelCalculationYesNo.Enabled := True;

    if PanelCalculationYesNo.Tag = 1 then
      PanelCalculationYesNo.Color := clLime
    else
      PanelCalculationYesNo.Color := clRed;
  end;
end;

procedure TFormCalculationEstimate.btnTranspClick(Sender: TObject);
begin
  TestOnNoDataNew(qrTransp);

  if VisibleRightTables <> '0000010' then
  begin
    VisibleRightTables := '0000010';
    SettingVisibleRightTables;
    if CheckQrActiveEmpty(qrTransp) then
      qrTransp.First;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonSSRClick(Sender: TObject);
begin

  ShellExecute(Handle, nil, 'report.exe', PChar('S' + INTTOSTR(FormCalculationEstimate.IdEstimate)),
    PChar('REPOTS\report\'), SW_maximIZE);
  Exit;

  if SpeedButtonSSR.Tag = 0 then
  begin
    SpeedButtonSSR.Down := True;

    SpeedButtonLocalEstimate.Tag := 0;
    SpeedButtonSummaryCalculation.Tag := 0;
    SpeedButtonSSR.Tag := 1;

    // ��������� ��������� �������
    PanelLocalEstimate.Visible := False;
    pnlSummaryCalculations.Visible := False;
    PanelSSR.Visible := True;

    // ������������� ���������� ������ �������
    frSSR.LoadData(IdObject);

    // ������ ������ �������� ������� ���� �����������
    BottomTopMenuEnabled(False);

    PanelCalculationYesNo.Enabled := False;
    PanelCalculationYesNo.Color := clSilver;
  end;
end;

procedure TFormCalculationEstimate.btnStartupClick(Sender: TObject);
begin
  TestOnNoDataNew(qrStartup);

  if VisibleRightTables <> '0000001' then
  begin
    VisibleRightTables := '0000001';
    SettingVisibleRightTables;
    if CheckQrActiveEmpty(qrStartup) then
      qrStartup.First;
  end;
end;

procedure TFormCalculationEstimate.btnMaterialsClick(Sender: TObject);
var
  s: string;
begin
  TestOnNoDataNew(qrMaterial);
  ImageNoData.PopupMenu := pmMaterials;

  if SpeedButtonModeTables.Tag = 0 then
    s := '1000000'
  else
    s := '1110000';

  if s <> VisibleRightTables then
  begin
    VisibleRightTables := s;
    SettingVisibleRightTables;
    if CheckQrActiveEmpty(qrMaterial) then
    begin
      qrMaterial.First;
      if (qrMaterialTITLE.AsInteger > 0) then
        qrMaterial.Next;
    end;
  end;
end;

procedure TFormCalculationEstimate.btnMechanismsClick(Sender: TObject);
var
  s: string;
begin
  TestOnNoDataNew(qrMechanizm);
  ImageNoData.PopupMenu := pmMechanizms;

  if SpeedButtonModeTables.Tag = 0 then
    s := '0100000'
  else
    s := '1110000';

  if s <> VisibleRightTables then
  begin
    VisibleRightTables := s;
    SettingVisibleRightTables;
    if CheckQrActiveEmpty(qrMechanizm) then
    begin
      qrMechanizm.First;
      if (qrMechanizmTITLE.AsInteger > 0) then
        qrMechanizm.Next;
    end;
  end;
end;

procedure TFormCalculationEstimate.btnResMatClick(Sender: TObject);
begin
  ShowCalcResource(FormCalculationEstimate.IdEstimate, (Sender as TSpeedButton).Tag, FormCalculationEstimate);
end;

procedure TFormCalculationEstimate.btnEquipmentsClick(Sender: TObject);
var
  s: string;
begin
  TestOnNoDataNew(qrDevices);

  if SpeedButtonModeTables.Tag = 0 then
    s := '0010000'
  else
    s := '1110000';

  if s <> VisibleRightTables then
  begin
    VisibleRightTables := s;
    SettingVisibleRightTables;
    if CheckQrActiveEmpty(qrDevices) then
      qrDevices.First;
  end;

end;

procedure TFormCalculationEstimate.RecalcEstimate;
// ��������� ����������� �����
var
  Key: Variant;
  e: TDataSetNotifyEvent;
  AutoCommitValue: Boolean;
begin
  qrRatesEx.DisableControls;
  e := qrRatesEx.AfterScroll;
  qrRatesEx.AfterScroll := nil;
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  try
    if CheckQrActiveEmpty(qrRatesEx) then
      Key := qrRatesEx.Fields[0].Value;
    qrRatesEx.First;
    DM.Read.StartTransaction;
    try
      while not qrRatesEx.Eof do
      begin
        if qrRatesExID_TYPE_DATA.Value > 0 then
        begin
          FastExecSQL('CALL CalcRowInRateTab(:ID, :TYPE, 1);',
            VarArrayOf([qrRatesExID_TABLES.Value, qrRatesExID_TYPE_DATA.Value]));
          FastExecSQL('CALL CalcCalculation(:SM_ID, :ID_TYPE_DATA, :ID_TABLES, 0, :ID_ACT)',
            VarArrayOf([qrRatesExSM_ID.Value, qrRatesExID_TYPE_DATA.Value, qrRatesExID_TABLES.Value,
            qrRatesExID_ACT.Value]));
        end;
        qrRatesEx.Next;
      end;

      if Key <> Null then
        qrRatesEx.Locate(qrRatesEx.Fields[0].FieldName, Key, []);

      DM.Read.Commit;
    except
      DM.Read.Rollback;
      raise;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;

    qrRatesEx.EnableControls;
    qrRatesEx.AfterScroll := e;
    CloseOpen(qrRatesEx);
    CloseOpen(qrCalculations);
  end;
end;

procedure TFormCalculationEstimate.btn1Click(Sender: TObject);
begin
  if Application.MessageBox('���������� ���������� �����?', '����������',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) <> IDYES then
    Exit;
  case Application.MessageBox('���������� ���������� ��� �� ���� �������� �����?', '����������',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) of
    IDYES:
      FastExecSQL('CALL UpdateSmetaCosts(:IDESTIMATE);', VarArrayOf([IdEstimate]));
  end;
  RecalcEstimate;
end;

procedure TFormCalculationEstimate.btnDescriptionClick(Sender: TObject);
begin
  TestOnNoDataNew(qrDescription);

  if VisibleRightTables <> '0001000' then
  begin
    VisibleRightTables := '0001000';
    SettingVisibleRightTables;
    if CheckQrActiveEmpty(qrDescription) then
      qrDescription.First;
  end;
end;

procedure TFormCalculationEstimate.btnDumpClick(Sender: TObject);
begin
  TestOnNoDataNew(qrDump);

  if VisibleRightTables <> '0000100' then
  begin
    VisibleRightTables := '0000100';
    SettingVisibleRightTables;
    if CheckQrActiveEmpty(qrDump) then
      qrDump.First;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonModeTablesClick(Sender: TObject);
var
  s: string;
begin
  with SpeedButtonModeTables do
  begin
    Glyph.Assign(nil);

    if Tag = 0 then
    begin
      Tag := 1;
      Hint := '����� ������ ������: ���������, ���������, ������������';
      DM.ImageListModeTables.GetBitmap(1, SpeedButtonModeTables.Glyph);
      s := '1110000';
    end
    else
    begin
      Tag := 0;
      Hint := '����� ����� �������';
      DM.ImageListModeTables.GetBitmap(0, SpeedButtonModeTables.Glyph);
      s := '1000000';
      if btnMechanisms.Down then
        s := '0100000';
      if btnEquipments.Down then
        s := '0010000';
    end;
  end;
  if not btnDescription.Down then
  begin
    VisibleRightTables := s;
    SettingVisibleRightTables;
  end;
end;

procedure TFormCalculationEstimate.Panel1Resize(Sender: TObject);
begin
  dblkcbbOXROPR.Width := (Sender as TPanel).Width div 2 - dblkcbbOXROPR.Left - 3;

  LabelWinterPrice.Left := dblkcbbOXROPR.Left + dblkcbbOXROPR.Width + 6;

  EditWinterPrice.Left := LabelWinterPrice.Left + LabelWinterPrice.Width + 6;
  EditWinterPrice.Width := (Sender as TPanel).Width - EditWinterPrice.Left - 6;
end;

procedure TFormCalculationEstimate.PanelCalculationYesNoClick(Sender: TObject);
begin
  with PanelCalculationYesNo do
    if Tag = 1 then
    begin
      Tag := 0;
      Color := clRed;
      Caption := '������� ���������';
      if not Act then
        FormCalculationEstimate.Caption := CaptionButton[1] + ' - ��������� �������������� ���������'
      else
        FormCalculationEstimate.Caption := CaptionButton[2] + ' - ��������� �������������� ���������'
    end
    else
    begin
      Tag := 1;
      Color := clLime;
      Caption := '������� ���������';
      if not Act then
        FormCalculationEstimate.Caption := CaptionButton[1] + ' - ��������� �������������� ���������'
      else
        FormCalculationEstimate.Caption := CaptionButton[2] + ' - ��������� �������������� ���������';
    end;
  frSummaryCalculations.grSummaryCalculation.Repaint;
end;

procedure TFormCalculationEstimate.PanelClientRightTablesResize(Sender: TObject);
var
  H: Integer;
begin
  if VisibleRightTables = '0001000' then
  begin
    dbgrdDescription.Columns[0].Width := dbgrdDescription.Width - 50;
  end
  else if VisibleRightTables = '1110000' then
  begin
    H := PanelClientRightTables.Height - SplitterRight1.Height - SplitterRight2.Height;

    dbgrdMaterial.Height := H div 3;
    dbgrdMechanizm.Height := dbgrdMaterial.Height;
    dbgrdDevices.Height := dbgrdMaterial.Height;
  end;
end;

procedure TFormCalculationEstimate.PanelNoDataResize(Sender: TObject);
begin
  if not(Sender as TPanel).Visible then
    Exit;

  with (Sender as TPanel) do
  begin
    ImageNoData.Left := (Width - ImageNoData.Width) div 2;
    ImageNoData.Top := (Height - ImageNoData.Height) div 2;
  end;
end;

procedure TFormCalculationEstimate.PanelTopMenuResize(Sender: TObject);

var
  WidthButton: Integer;
begin
  if Act then
    WidthButton := ((Sender as TPanel).ClientWidth - btnKC6.Left - 15) div 6
  else
    WidthButton := ((Sender as TPanel).ClientWidth - btnKC6.Left - 18) div 7;
  btnKC6.Width := WidthButton;
  btnResMat.Width := WidthButton;
  btnResMech.Width := WidthButton;
  btnResDev.Width := WidthButton;
  btnResZP.Width := WidthButton;
  btnResCalc.Width := WidthButton;
  SpeedButtonSSR.Width := WidthButton;

  MemoRight.Height := dbmmoCAPTION.Height;
end;

// ������ ������ ������ ������ �������� ���� �����������
procedure TFormCalculationEstimate.BottomTopMenuEnabled(const Value: Boolean);
begin
  btnDescription.Enabled := Value;
  btnMaterials.Enabled := Value;
  btnMechanisms.Enabled := Value;
  btnEquipments.Enabled := Value;
  btnDump.Enabled := Value;
  btnTransp.Enabled := Value;
  btnStartup.Enabled := Value;
end;

// ����������� ����������� ��� ����������
procedure TFormCalculationEstimate.RepaintImagesForSplitters();
begin
  ImageSplitterBottom.Top := SplitterBottom.Top;
  ImageSplitterBottom.Left := SplitterBottom.Left + (SplitterBottom.Width - ImageSplitterBottom.Width) div 2;

  ImageSplitterCenter.Left := SplitterCenter.Left;
  ImageSplitterCenter.Top := SplitterCenter.Top + (SplitterCenter.Height - ImageSplitterCenter.Height) div 2;

  ImageSplitterLeft.Top := SplitterLeft.Top;
  ImageSplitterLeft.Left := SplitterLeft.Left + (SplitterLeft.Width - ImageSplitterLeft.Width) div 2;

  ImageSplitterRight1.Top := SplitterRight1.Top;
  ImageSplitterRight1.Left := SplitterRight1.Left + (SplitterRight1.Width - ImageSplitterRight1.Width) div 2;

  ImageSplitterRight2.Top := SplitterRight2.Top;
  ImageSplitterRight2.Left := SplitterRight2.Left + (SplitterRight2.Width - ImageSplitterRight2.Width) div 2;

  ImageSplitterRightBottom.Top := SplitterRightMemo.Top;
  ImageSplitterRightBottom.Left := SplitterRightMemo.Left +
    (SplitterRightMemo.Width - ImageSplitterRightBottom.Width) div 2;
end;

procedure TFormCalculationEstimate.Button3Click(Sender: TObject);
begin
  FormSummaryCalculationSettings.ShowModal;
end;

procedure TFormCalculationEstimate.btnKC6Click(Sender: TObject);
begin
  if Act then
  // ��� ����
  begin
    if MessageBox(0, PChar('���������� ������� ������ �� �����?'), '������ �����',
      MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrYes then
      fKC6.MyShow(IdObject);
  end
  // ��� �����
  else
  begin
    if (not Assigned(fKC6Journal)) then
      fKC6Journal := TfKC6Journal.Create(Self);
    fKC6Journal.LocateObject(IdObject);
    fKC6Journal.LocateEstimate(IdEstimate);
    fKC6Journal.tvEstimates.SelectNode(IdEstimate).Expand(False);
    fKC6Journal.tvEstimatesClick(Self);
    fKC6Journal.Show;
  end;
end;

procedure TFormCalculationEstimate.PopupMenuTableLeftTechnicalPartClick(Sender: TObject);
var
  NumberNormativ, NameFile: String;
  FirstChar: Char;
  Path: String;
begin
  NumberNormativ := qrRatesExOBJ_CODE.AsString;

  // � ������� - ������� �������, � ���������� NumberNormativ - ����������
  if (NumberNormativ > '�121-1-1') and (NumberNormativ < '�121-137-1') then
    NumberNormativ := 'E121_p1'
  else if (NumberNormativ > '�121-141-1') and (NumberNormativ < '�121-222-2') then
    NumberNormativ := 'E121_p2'
  else if (NumberNormativ > '�121-241-1') and (NumberNormativ < '�121-439-8') then
    NumberNormativ := 'E121_p3'
  else if (NumberNormativ > '�121-451-1') and (NumberNormativ < '�121-639-1') then
    NumberNormativ := 'E121_p4'
  else if (NumberNormativ > '�29-6-1') and (NumberNormativ < '�29-92-12') then
    NumberNormativ := 'E29_p1'
  else if (NumberNormativ > '�29-93-1') and (NumberNormativ < '�29-277-1') then
    NumberNormativ := 'E29_p2'
  else if (NumberNormativ > '�35-9-1') and (NumberNormativ < '�35-233-2') then
    NumberNormativ := 'E35_p1'
  else if (NumberNormativ > '�35-234-1') and (NumberNormativ < '�35-465-1') then
    NumberNormativ := 'E35_p2'
  else if (NumberNormativ > '�12-1-1') and (NumberNormativ < '�12-331-3') then
    NumberNormativ := 'C12_p1'
  else if (NumberNormativ > '�12-362-1') and (NumberNormativ < '�12-1314-10') then
    NumberNormativ := 'C12_p2'
  else if (NumberNormativ > '�13-1-1') and (NumberNormativ < '�13-230-7') then
    NumberNormativ := 'C13_p1'
  else if (NumberNormativ > '�13-250-1') and (NumberNormativ < '�13-383-3') then
    NumberNormativ := 'C13_p2'
  else if (NumberNormativ > '�8-1-1') and (NumberNormativ < '�8-477-1') then
    NumberNormativ := 'C8_p1'
  else if (NumberNormativ > '�8-481-1') and (NumberNormativ < '�8-914-3') then
    NumberNormativ := 'C8_p2'
  else
  begin
    FirstChar := NumberNormativ[1];

    Delete(NumberNormativ, 1, 1);

    // � ������� - ������� �������, � ���������� NumberNormativ - ����������
    if FirstChar = '�' then
      NumberNormativ := 'E' + NumberNormativ
    else if FirstChar = '�' then
      NumberNormativ := 'C' + NumberNormativ;

    // ������� ������� ������� � ������� ������� '-' � �� ����� ������
    Delete(NumberNormativ, Pos('-', NumberNormativ), Length(NumberNormativ) - Pos('-', NumberNormativ) + 1);
  end;

  case (Sender as TMenuItem).Tag of
    1:
      NameFile := 'COD';
    2:
      NameFile := 'DATA';
    3:
      NameFile := 'PR';
    4:
      NameFile := 'TT';
    5:
      NameFile := 'TL';
    6:
      NameFile := 'PL';
  end;

  Path := ExtractFilePath(Application.ExeName) + 'Normative documents\' + NumberNormativ + '\' +
    NameFile + '.doc';

  if not FileExists(Path) then
  begin
    MessageBox(0, PChar('�� ��������� ������� ����:' + sLineBreak + sLineBreak + Path + sLineBreak +
      sLineBreak + '�������� �� ����������!'), CaptionForm, MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;

  ShellExecute(FormCalculationEstimate.Handle, nil, PChar(Path), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TFormCalculationEstimate.qrDescriptionAfterScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if btnDescription.Down then
    MemoRight.Text := qrDescriptionwork.AsString;
end;

procedure TFormCalculationEstimate.qrDevicesAfterScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not FReCalcDev then
  begin
    if btnEquipments.Down then
      MemoRight.Text := qrDevicesDEVICE_NAME.AsString;
  end;
end;

procedure TFormCalculationEstimate.qrDevicesBeforeScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not FReCalcDev then
  begin
    // �������� �������� �� �������������� ������
    SetDevNoEditMode;
  end;
end;

procedure TFormCalculationEstimate.qrDumpAfterScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if btnDump.Down then
    MemoRight.Text := qrDumpDUMP_NAME.AsString;
end;

procedure TFormCalculationEstimate.DevRowChange(Sender: TField);
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    Exit;
  end;

  if not FReCalcDev then
  begin
    FReCalcDev := True;
    // �������� �� ������ ������������
    try
      // �������������� ��������� ��� ���������� �����
      if (Sender.FieldName = 'PROC_PODR') or (Sender.FieldName = 'PROC_ZAC') or
        (Sender.FieldName = 'TRANSP_PROC_PODR') or (Sender.FieldName = 'TRANSP_PROC_ZAC') then
      begin
        if Sender.Value > 100 then
          Sender.Value := 100;

        if Sender.Value < 0 then
          Sender.Value := 0;

        if (Sender.FieldName = 'PROC_PODR') then
          qrDevicesPROC_ZAC.Value := 100 - qrDevicesPROC_PODR.Value;

        if (Sender.FieldName = 'PROC_ZAC') then
          qrDevicesPROC_PODR.Value := 100 - qrDevicesPROC_ZAC.Value;

        if (Sender.FieldName = 'TRANSP_PROC_PODR') then
          qrDevicesTRANSP_PROC_ZAC.Value := 100 - qrDevicesTRANSP_PROC_PODR.Value;

        if (Sender.FieldName = 'TRANSP_PROC_ZAC') then
          qrDevicesTRANSP_PROC_PODR.Value := 100 - qrDevicesTRANSP_PROC_ZAC.Value;
      end;

      if NDSEstimate then
      begin
        qrDevicesFCOAST_NO_NDS.Value := NDSToNoNDS1(qrDevicesFCOAST_NDS.Value, qrDevicesNDS.Value);
        qrDevicesDEVICE_TRANSP_NO_NDS.Value := NDSToNoNDS1(qrDevicesDEVICE_TRANSP_NDS.Value,
          qrDevicesNDS.Value);
      end
      else
      begin
        qrDevicesFCOAST_NDS.Value := NoNDSToNDS1(qrDevicesFCOAST_NO_NDS.Value, qrDevicesNDS.Value);
        qrDevicesDEVICE_TRANSP_NDS.Value := NoNDSToNDS1(qrDevicesDEVICE_TRANSP_NO_NDS.Value,
          qrDevicesNDS.Value);
      end;
      // ����� ��������� ������ ������ �����������
      qrDevices.Post;

      // �������� �� ������ ������
      ReCalcRowDev;
    finally
      FReCalcDev := False;
    end;
  end;
end;

// �������� ����� �� ������������� ������ ������
function TFormCalculationEstimate.CheckMechReadOnly: Boolean;
begin
  Result := False;
  // ��������� �������� � �������� ��� ���������� ���������
  if ((qrMechanizmFROM_RATE.AsInteger = 1) and ((qrRatesExID_TYPE_DATA.AsInteger = 1) or
    (qrRatesExID_RATE.AsInteger > 0))) or (qrMechanizmREPLACED.AsInteger = 1) or
    (qrMechanizmTITLE.AsInteger > 0) or (not(qrMechanizmID.AsInteger > 0)) or (qrMechanizm.Eof) then
    Result := True;
end;

// ��������� ����������� �� ����� � ����� ������ �� ������ ����, ���� �� �� ��������� � ����������
procedure TFormCalculationEstimate.CheckNeedAutoRep(AID, AType: Integer; ACode: string);
var
  j: Integer;
begin
  if ((AType = 2) and not PMMatAutoRep.Checked) or ((AType = 3) and not PMMechAutoRep.Checked) then
    Exit;

  qrTemp1.Active := False;
  case AType of
    2:
      qrTemp1.SQL.Text := 'SELECT id FROM materialcard_temp where ' + '(REPLACED = 1) and (MAT_CODE = ''' +
        ACode + ''')';
    3:
      qrTemp1.SQL.Text := 'SELECT id FROM mechanizmcard_temp where ' + '(REPLACED = 1) and (MECH_CODE = ''' +
        ACode + ''')';
  else
    Exit;
  end;
  qrTemp1.Active := True;
  if not qrTemp1.Eof then
  begin
    j := Length(FAutoRepArray);
    SetLength(FAutoRepArray, j + 1);
    FAutoRepArray[j].ID := AID;
    FAutoRepArray[j].DataType := AType;
    FAutoRepArray[j].Code := ACode;
  end;
  qrTemp1.Active := False;
end;

procedure TFormCalculationEstimate.ClearAutoRep;
begin
  SetLength(FAutoRepArray, 0);
end;

procedure TFormCalculationEstimate.ShowAutoRep;
var
  i: Integer;
  ReCalcFlag: Boolean;
  frmReplace: TfrmReplacement;
begin
  ReCalcFlag := False;
  for i := Low(FAutoRepArray) to High(FAutoRepArray) do
  begin
    case FAutoRepArray[i].DataType of
      2:
        begin
          case MessageBox(0, PChar('������ ���������� ������ ��������� ' + FAutoRepArray[i].Code + '?' +
            sLineBreak + '������ ������� ��������� ����� ��� ������������� � �����.'), '����������',
            MB_ICONQUESTION + MB_OKCANCEL + mb_TaskModal) of
            mrOk:
              begin
                frmReplace := TfrmReplacement.Create(IdObject, IdEstimate, 0, FAutoRepArray[i].ID, 0, 2,
                  False, True);
                try
                  if (frmReplace.ShowModal = mrYes) then
                  begin
                    ReCalcFlag := True;
                  end;
                finally
                  FreeAndNil(frmReplace);
                end;
              end;
            mrCancel:
              Continue;
          end;
        end;
      3:
        begin
          case MessageBox(0, PChar('������ ���������� ������ ��������� ' + FAutoRepArray[i].Code + '?' +
            sLineBreak + '������ ������� ��������� ����� ��� ������������� � �����.'), '����������',
            MB_ICONQUESTION + MB_OKCANCEL + mb_TaskModal) of
            mrOk:
              begin
                frmReplace := TfrmReplacement.Create(IdObject, IdEstimate, 0, FAutoRepArray[i].ID, 0, 3,
                  False, True);
                try
                  if (frmReplace.ShowModal = mrYes) then
                  begin
                    ReCalcFlag := True;
                  end;
                finally
                  FreeAndNil(frmReplace);
                end;
              end;
            mrCancel:
              Continue;
          end;
        end
    else
      Continue;
    end;
  end;

  if ReCalcFlag then
  begin
    RecalcEstimate;
    OutputDataToTable;
  end;
end;

procedure TFormCalculationEstimate.SetMechReadOnly(AValue: Boolean); // ������������� ����� ��������������
begin
  dbgrdMechanizm.ReadOnly := AValue;
end;

// �������� ����� �� ������������� ������ ������
function TFormCalculationEstimate.CheckMatReadOnly: Boolean;
begin
  Result := False;
  // ���������� �� �������� // ��� ����������
  if ((qrMaterialFROM_RATE.AsInteger = 1) and ((qrRatesExID_TYPE_DATA.AsInteger = 1) or
    (qrRatesExID_RATE.AsInteger > 0))) or (qrMaterialREPLACED.AsInteger = 1) or
    (qrMaterialDELETED.AsInteger = 1) or (qrMaterialTITLE.AsInteger > 0) or (not(qrMaterialID.AsInteger > 0))
    or (qrMaterial.Eof) then
    Result := True;
end;

// ������������� ����� ��������������
procedure TFormCalculationEstimate.SetMatReadOnly(AValue: Boolean);
begin
  dbgrdMaterial.ReadOnly := AValue;
end;

// ��������� ������ ������������ �������������� ������������
procedure TFormCalculationEstimate.SetDevEditMode;
begin
  dbgrdDevices.Columns[4].ReadOnly := False; // ���
  MemoRight.Color := $00AFFEFC;
  MemoRight.ReadOnly := False;
  MemoRight.Tag := 4; // Type_Data
  qrDevices.Tag := 1;
end;

procedure TFormCalculationEstimate.SetDevNoEditMode;
begin
  if qrDevices.Tag = 1 then
  begin
    dbgrdDevices.Columns[4].ReadOnly := True; // ���
    MemoRight.Color := clWindow;
    MemoRight.ReadOnly := True;
    MemoRight.Tag := 0;
    qrMaterial.Tag := 0;
  end;
end;

// ��������� ������ ������������ �������������� ����������
procedure TFormCalculationEstimate.SetMatEditMode;
begin
  if CheckMatReadOnly then
    Exit;
  dbgrdMaterial.Columns[2].ReadOnly := False; // �����
  dbgrdMaterial.Columns[4].ReadOnly := False; // ���-��
  dbgrdMaterial.Columns[5].ReadOnly := False; // ���� ���
  dbgrdMaterial.Columns[6].ReadOnly := False; // ���� ��� ���
  dbgrdMaterial.Columns[9].ReadOnly := False; // % ����������
  dbgrdMaterial.Columns[12].ReadOnly := False; // ���
  MemoRight.Color := $00AFFEFC;
  MemoRight.ReadOnly := False;
  MemoRight.Tag := 2; // Type_Data
  qrMaterial.Tag := 1;
end;

// ���������� ������ ������������ �������������� ����������
procedure TFormCalculationEstimate.SetMatNoEditMode;
begin
  if qrMaterial.Tag = 1 then
  begin
    dbgrdMaterial.Columns[2].ReadOnly := True; // �����
    dbgrdMaterial.Columns[4].ReadOnly := True; // ���-��
    dbgrdMaterial.Columns[5].ReadOnly := True; // ���� ���
    dbgrdMaterial.Columns[6].ReadOnly := True; // ���� ��� ���
    dbgrdMaterial.Columns[9].ReadOnly := True; // % ����������
    dbgrdMaterial.Columns[12].ReadOnly := True; // ���
    MemoRight.Color := clWindow;
    MemoRight.ReadOnly := True;
    MemoRight.Tag := 0;
    qrMaterial.Tag := 0;
  end;
end;

procedure TFormCalculationEstimate.qrMaterialAfterScroll(DataSet: TDataSet);
var
  flag: Boolean;
begin
  // �� ������ ������, ���-�� �������� ������
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not FReCalcMat then
  begin
    if qrMaterialTITLE.AsInteger > 0 then
    begin
      if dbgrdMaterial.Tag > qrMaterial.RecNo then
        qrMaterial.Prior
      else
        qrMaterial.Next;
    end;

    SetMatReadOnly(CheckMatReadOnly);
    grRatesEx.Repaint;

    flag := False;

    if ((qrMaterialID_REPLACED.Value = 0) and (FIdReplasedMat > 0)) or
      ((qrMaterialREPLACED.Value = 0) and (FIdReplasingMat > 0)) or
      (IsUnAcc and (not CheckMatUnAccountingMatirials)) then
      flag := True;

    FIdReplasedMat := qrMaterialID_REPLACED.Value;
    if qrMaterialREPLACED.Value > 0 then
      FIdReplasingMat := qrMaterialID.Value
    else
      FIdReplasingMat := 0;
    IsUnAcc := CheckMatUnAccountingMatirials;

    if btnMaterials.Down then
      MemoRight.Text := qrMaterialMAT_NAME.AsString;

    // ��� ������� ���������
    if CheckMatUnAccountingMatirials or (FIdReplasedMat > 0) or (FIdReplasingMat > 0) or flag then
      dbgrdMaterial.Repaint;
  end;
end;

procedure TFormCalculationEstimate.qrMaterialBeforeScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not FReCalcMat then
  begin
    // ���������� ����� ������������ ��� ���������� ����������� �������� �� �������
    dbgrdMaterial.Tag := qrMaterial.RecNo;

    // �������� �������� �� �������������� ������
    SetMatNoEditMode;
  end;
end;

procedure TFormCalculationEstimate.MatRowChange(Sender: TField);
var
  CField: string;
  CValue: Variant;
  CType: byte;
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    Exit;
  end;

  if not FReCalcMat then
  begin
    FReCalcMat := True;
    // �������� �� ������ ���������
    try
      CField := Sender.FieldName;
      CValue := Sender.Value;
      CType := 0;

      if (CField = 'MAT_COUNT') then
        CType := 1;

      // �������������� ��������� ��� ���������� �����
      if (Sender.FieldName = 'MAT_PROC_PODR') or (Sender.FieldName = 'MAT_PROC_ZAC') or
        (Sender.FieldName = 'TRANSP_PROC_PODR') or (Sender.FieldName = 'TRANSP_PROC_ZAC') then
      begin
        if Sender.Value > 100 then
          Sender.Value := 100;

        if Sender.Value < 0 then
          Sender.Value := 0;

        if Sender.FieldName = 'MAT_PROC_PODR' then
          qrMaterialMAT_PROC_ZAC.Value := 100 - qrMaterialMAT_PROC_PODR.Value;
        if Sender.FieldName = 'MAT_PROC_ZAC' then
          qrMaterialMAT_PROC_PODR.Value := 100 - qrMaterialMAT_PROC_ZAC.Value;
        if Sender.FieldName = 'TRANSP_PROC_PODR' then
          qrMaterialTRANSP_PROC_ZAC.Value := 100 - qrMaterialTRANSP_PROC_PODR.Value;
        if Sender.FieldName = 'TRANSP_PROC_ZAC' then
          qrMaterialTRANSP_PROC_PODR.Value := 100 - qrMaterialTRANSP_PROC_ZAC.Value;
      end;

      // �������������� ������ ����������� ������������ �������� ��� ��������� ����������� ����
      if (Sender.FieldName = 'FCOAST_NO_NDS') or (Sender.FieldName = 'FCOAST_NDS') then
      begin
        if NDSEstimate then
          qrMaterialFTRANSP_NDS.Value :=
            Round(BCDToCurrency((qrMaterialPROC_TRANSP.Value / 100) * qrMaterialMAT_COUNT.Value *
            qrMaterialFCOAST_NDS.Value))
        else
          qrMaterialFTRANSP_NO_NDS.Value :=
            Round(BCDToCurrency((qrMaterialPROC_TRANSP.Value / 100) * qrMaterialMAT_COUNT.Value *
            qrMaterialFCOAST_NO_NDS.Value));
      end;

      // ��������������� ������, ���-�� �� ������ ���� ������� ����� ��� ���������
      if NDSEstimate then
      begin
        qrMaterialCOAST_NO_NDS.Value := NDSToNoNDS1(qrMaterialCOAST_NDS.Value, qrMaterialNDS.Value);
        qrMaterialFCOAST_NO_NDS.Value := NDSToNoNDS1(qrMaterialFCOAST_NDS.Value, qrMaterialNDS.Value);
        qrMaterialFTRANSP_NO_NDS.Value := NDSToNoNDS1(qrMaterialFTRANSP_NDS.Value, qrMaterialNDS.Value);
      end
      else
      begin
        qrMaterialCOAST_NDS.Value := NoNDSToNDS1(qrMaterialCOAST_NO_NDS.Value, qrMaterialNDS.Value);
        qrMaterialFCOAST_NDS.Value := NoNDSToNDS1(qrMaterialFCOAST_NO_NDS.Value, qrMaterialNDS.Value);
        qrMaterialFTRANSP_NDS.Value := NoNDSToNDS1(qrMaterialFTRANSP_NO_NDS.Value, qrMaterialNDS.Value);
      end;
      // ����� ��������� ������ �����������
      qrMaterial.Post;

      // ���������� � ���� (��� ��� ������� �� ������ � ����� ��������)
      with qrTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('UPDATE materialcard_temp SET COAST_NO_NDS = :COAST_NO_NDS, ' +
          'COAST_NDS = :COAST_NDS, FCOAST_NO_NDS = :FCOAST_NO_NDS, ' +
          'FCOAST_NDS = :FCOAST_NDS, FTRANSP_NO_NDS = :FTRANSP_NO_NDS, ' +
          'FTRANSP_NDS = :FTRANSP_NDS, MAT_PROC_ZAC = :MAT_PROC_ZAC, ' +
          'MAT_PROC_PODR = :MAT_PROC_PODR, TRANSP_PROC_ZAC = :TRANSP_PROC_ZAC, ' +
          'TRANSP_PROC_PODR = :TRANSP_PROC_PODR, ' + CField + ' = :AA' + CField + ' WHERE id = :id;');
        ParamByName('COAST_NO_NDS').Value := qrMaterialCOAST_NO_NDS.AsVariant;
        ParamByName('COAST_NDS').Value := qrMaterialCOAST_NDS.AsVariant;
        ParamByName('FCOAST_NO_NDS').Value := qrMaterialFCOAST_NO_NDS.AsVariant;
        ParamByName('FCOAST_NDS').Value := qrMaterialFCOAST_NDS.AsVariant;
        ParamByName('FTRANSP_NO_NDS').Value := qrMaterialFTRANSP_NO_NDS.AsVariant;
        ParamByName('FTRANSP_NDS').Value := qrMaterialFTRANSP_NDS.AsVariant;
        ParamByName('MAT_PROC_ZAC').Value := qrMaterialMAT_PROC_ZAC.Value;
        ParamByName('MAT_PROC_PODR').Value := qrMaterialMAT_PROC_PODR.Value;
        ParamByName('TRANSP_PROC_ZAC').Value := qrMaterialTRANSP_PROC_ZAC.Value;
        ParamByName('TRANSP_PROC_PODR').Value := qrMaterialTRANSP_PROC_PODR.Value;
        ParamByName('AA' + CField).Value := CValue;
        ParamByName('id').Value := qrMaterialID.Value;
        ExecSQL;
      end;

      // �������� �� ������ ���������
      ReCalcRowMat(CType);
    finally
      FReCalcMat := False;
    end;
  end;
end;

procedure TFormCalculationEstimate.mBaseDataClick(Sender: TObject);
begin
  FormBasicData.ShowForm(IdObject, qrRatesExSM_ID.AsInteger);
  GetSourceData;
  GridRatesRowSellect;
  CloseOpen(qrRatesEx);
  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.mDelEstimateClick(Sender: TObject);
var
  NumberEstimate, TextWarning: String;
begin
  NumberEstimate := qrRatesExOBJ_CODE.AsString;

  case qrRatesExID_TYPE_DATA.AsInteger of
    - 1:
      TextWarning := '�� ��������� ������� ��������� ����� � �������: ' + NumberEstimate + sLineBreak +
        '������ � ��� ����� ������� ��� ������� ��� ������� � ��� �������!' + sLineBreak + sLineBreak +
        '������������� ��������?';
    -2:
      TextWarning := '�� ��������� ������� ��������� ����� � �������: ' + NumberEstimate + sLineBreak +
        '������ � ��� ����� ������� ��� ��������� � ������� ��� ������� � ��� �������!' + sLineBreak +
        sLineBreak + '������������� ��������?';
    -3:
      TextWarning := '�� ������������� ������ ������� ������ ��� � �������: ' + NumberEstimate;
  end;

  if MessageBox(0, PChar(TextWarning), PWideChar(Caption), MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo
  then
    Exit;

  try
    with qrTemp do
    begin
      SQL.Text := 'CALL DeleteEstimate(:IdEstimate);';
      ParamByName('IdEstimate').Value := qrRatesExSM_ID.AsInteger;
      ExecSQL;
      qrRatesEx.Prior;
      CloseOpen(qrRatesEx);
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� �������� ����� �������� ������:' + sLineBreak + e.message), PWideChar(Caption),
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.qrMechanizmAfterScroll(DataSet: TDataSet);
var
  flag: Boolean;
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not FReCalcMech then
  begin
    if qrMechanizmTITLE.AsInteger > 0 then
    begin
      if dbgrdMechanizm.Tag > qrMechanizm.RecNo then
        qrMechanizm.Prior
      else
        qrMechanizm.Next;
    end;

    SetMechReadOnly(CheckMechReadOnly);
    grRatesEx.Repaint;

    flag := False;

    if ((qrMechanizmID_REPLACED.Value = 0) and (FIdReplasedMech > 0)) or
      ((qrMechanizmREPLACED.Value = 0) and (FIdReplasingMech > 0)) then
      flag := True;

    FIdReplasedMech := qrMechanizmID_REPLACED.Value;
    if qrMechanizmREPLACED.Value > 0 then
      FIdReplasingMech := qrMechanizmID.Value
    else
      FIdReplasingMech := 0;

    if btnMechanisms.Down then
      MemoRight.Text := qrMechanizmMECH_NAME.AsString;

    // ��� ������� ���������
    if (FIdReplasedMech > 0) or (FIdReplasingMech > 0) or flag then
      dbgrdMechanizm.Repaint;
  end;
end;

procedure TFormCalculationEstimate.qrMechanizmBeforeInsert(DataSet: TDataSet);
begin
  Abort; // ������ ���������� ����� ������ � ������ ��������
end;

procedure TFormCalculationEstimate.qrMechanizmBeforeScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not FReCalcMech then
  begin
    // ���������� ����� ������������ ��� ���������� ����������� �������� �� �������
    dbgrdMechanizm.Tag := qrMechanizm.RecNo;

    // �������� �������� �� �������������� ������
    SetMechNoEditMode;
  end;
end;

procedure TFormCalculationEstimate.qrMechanizmCalcFields(DataSet: TDataSet);
var
  F: TField;
begin
  F := DataSet.FieldByName('NUM');
  if DataSet.Bof then
    F.AsInteger := 1
  else
    F.AsInteger := DataSet.RecNo;
end;

// ��������� ���� null � �������� ���� ������� �����
procedure TFormCalculationEstimate.MechRowChange(Sender: TField);
var
  CField: string;
  CValue: Variant;
  CType: byte;
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    Exit;
  end;

  if not FReCalcMech then
  begin
    FReCalcMech := True;
    // �������� �� ������ ���������
    try
      CField := Sender.FieldName;
      CValue := Sender.Value;
      CType := 0;

      if (Sender.FieldName = 'MECH_COUNT') then
        CType := 1;

      // �������������� ��������� ��� ���������� �����
      if (Sender.FieldName = 'PROC_PODR') or (Sender.FieldName = 'PROC_ZAC') then
      begin
        if Sender.Value > 100 then
          Sender.Value := 100;
        if Sender.Value < 0 then
          Sender.Value := 0;
        if (Sender.FieldName = 'PROC_PODR') then
          qrMechanizmPROC_ZAC.Value := 100 - qrMechanizmPROC_PODR.Value;
        if (Sender.FieldName = 'PROC_ZAC') then
          qrMechanizmPROC_PODR.Value := 100 - qrMechanizmPROC_ZAC.Value;
      end;

      // ��������������� ������, ���-�� �� ������ ���� ������� ����� ��� ���������
      if NDSEstimate then
      begin
        qrMechanizmCOAST_NO_NDS.Value := NDSToNoNDS1(qrMechanizmCOAST_NDS.Value, qrMechanizmNDS.Value);
        qrMechanizmFCOAST_NO_NDS.Value := NDSToNoNDS1(qrMechanizmFCOAST_NDS.Value, qrMechanizmNDS.Value);
        qrMechanizmZP_MACH_NO_NDS.Value := NDSToNoNDS1(qrMechanizmZP_MACH_NDS.Value, qrMechanizmNDS.Value);
        qrMechanizmFZP_MACH_NO_NDS.Value := NDSToNoNDS1(qrMechanizmFZP_MACH_NDS.Value, qrMechanizmNDS.Value);
      end
      else
      begin
        qrMechanizmCOAST_NDS.Value := NoNDSToNDS1(qrMechanizmCOAST_NO_NDS.Value, qrMechanizmNDS.Value);
        qrMechanizmFCOAST_NDS.Value := NoNDSToNDS1(qrMechanizmFCOAST_NO_NDS.Value, qrMechanizmNDS.Value);
        qrMechanizmZP_MACH_NDS.Value := NoNDSToNDS1(qrMechanizmZP_MACH_NO_NDS.Value, qrMechanizmNDS.Value);
        qrMechanizmFZP_MACH_NDS.Value := NoNDSToNDS1(qrMechanizmFZP_MACH_NO_NDS.Value, qrMechanizmNDS.Value);
      end;

      // ����� ��������� ������ ������ �����������
      qrMechanizm.Post;

      // ���������� � ���� (��� ��� ������� �� ������ � ����� ��������)
      with qrTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('UPDATE mechanizmcard_temp SET COAST_NO_NDS = :COAST_NO_NDS, ' +
          'COAST_NDS = :COAST_NDS, FCOAST_NO_NDS = :FCOAST_NO_NDS, ' +
          'FCOAST_NDS = :FCOAST_NDS, ZP_MACH_NO_NDS = :ZP_MACH_NO_NDS, ' +
          'ZP_MACH_NDS = :ZP_MACH_NDS, FZP_MACH_NO_NDS = :FZP_MACH_NO_NDS, ' +
          'FZP_MACH_NDS = :FZP_MACH_NDS, PROC_ZAC = :PROC_ZAC, ' + 'PROC_PODR = :PROC_PODR, ' + CField +
          ' = :AA' + CField + ' WHERE id = :id;');
        ParamByName('COAST_NO_NDS').Value := qrMechanizmCOAST_NO_NDS.AsVariant;
        ParamByName('COAST_NDS').Value := qrMechanizmCOAST_NDS.AsVariant;
        ParamByName('FCOAST_NO_NDS').Value := qrMechanizmFCOAST_NO_NDS.AsVariant;
        ParamByName('FCOAST_NDS').Value := qrMechanizmFCOAST_NDS.AsVariant;
        ParamByName('ZP_MACH_NO_NDS').Value := qrMechanizmZP_MACH_NO_NDS.AsVariant;
        ParamByName('ZP_MACH_NDS').Value := qrMechanizmZP_MACH_NDS.AsVariant;
        ParamByName('FZP_MACH_NO_NDS').Value := qrMechanizmFZP_MACH_NO_NDS.AsVariant;
        ParamByName('FZP_MACH_NDS').Value := qrMechanizmFZP_MACH_NDS.AsVariant;
        ParamByName('PROC_ZAC').Value := qrMechanizmPROC_ZAC.Value;
        ParamByName('PROC_PODR').Value := qrMechanizmPROC_PODR.Value;
        ParamByName('AA' + CField).Value := CValue;
        ParamByName('id').Value := qrMechanizmID.Value;
        ExecSQL;
      end;

      // �������� �� ������ ���������
      ReCalcRowMech(CType);
    finally
      FReCalcMech := False;
    end;
  end;
end;

procedure TFormCalculationEstimate.mEditEstimateClick(Sender: TObject);
var
  mainType: Integer;
begin
  qrTemp.SQL.Text := 'SELECT SM_TYPE FROM smetasourcedata WHERE SM_ID=:ID';
  qrTemp.ParamByName('ID').AsInteger := qrRatesExSM_ID.AsInteger;
  qrTemp.Active := True;
  mainType := qrTemp.FieldByName('SM_TYPE').AsInteger;
  qrTemp.Active := False;
  with FormCardEstimate do
  begin
    EditingRecord(True);
    FormCardEstimate.ShowForm(IdObject, qrRatesExSM_ID.AsInteger, mainType);
    CloseOpen(qrRatesEx);
  end;
end;

procedure TFormCalculationEstimate.MemoRightChange(Sender: TObject);
begin
  if not MemoRight.ReadOnly then
  begin
    // ����������� �������� ���������, ���������....
    // ������ ����� ������ sql
    case MemoRight.Tag of
      2:
        begin
          qrMaterial.Edit;
          qrMaterialMAT_NAME.AsString := MemoRight.Text;
          qrMaterial.Post;
          qrTemp.SQL.Text := 'UPDATE materialcard_temp set ' + 'MAT_NAME=:MAT_NAME WHERE ID=:ID;';
          qrTemp.ParamByName('ID').Value := qrMaterialID.AsInteger;
          qrTemp.ParamByName('MAT_NAME').Value := MemoRight.Text;
          qrTemp.ExecSQL;
        end;
      3:
        begin
          qrMechanizm.Edit;
          qrMechanizmMECH_NAME.AsString := MemoRight.Text;
          qrMechanizm.Post;
        end;
      4:
        begin
          qrDevices.Edit;
          qrDevicesDEVICE_NAME.AsString := MemoRight.Text;
          qrDevices.Post;
        end;
    end;
  end;
end;

procedure TFormCalculationEstimate.MemoRightExit(Sender: TObject);
begin
  case MemoRight.Tag of
    2:
      if not Assigned(FormCalculationEstimate.ActiveControl) or
        (FormCalculationEstimate.ActiveControl.Name <> 'dbgrdMaterial') then
        SetMatNoEditMode;
    3:
      if not Assigned(FormCalculationEstimate.ActiveControl) or
        (FormCalculationEstimate.ActiveControl.Name <> 'dbgrdMechanizm') then
        SetMechNoEditMode;
    4:
      if not Assigned(FormCalculationEstimate.ActiveControl) or
        (FormCalculationEstimate.ActiveControl.Name <> 'dbgrdDevices') then
        SetDevNoEditMode;
  end;
end;

procedure TFormCalculationEstimate.mAddLocalClick(Sender: TObject);
begin
  FormCardEstimate.EditingRecord(False);
  FormCardEstimate.ShowForm(IdObject, IdEstimate, 1);
  CloseOpen(qrRatesEx);
end;

procedure TFormCalculationEstimate.mAddPTMClick(Sender: TObject);
var
  SM_TYPE, PARENT_ID: Integer;
begin
  qrTemp.SQL.Text := 'SELECT SM_TYPE, PARENT_ID FROM smetasourcedata WHERE SM_ID=:ID';
  qrTemp.ParamByName('ID').AsInteger := qrRatesExSM_ID.AsInteger;
  qrTemp.Active := True;
  SM_TYPE := qrTemp.FieldByName('SM_TYPE').AsInteger;
  PARENT_ID := qrTemp.FieldByName('PARENT_ID').AsInteger;
  qrTemp.Active := False;
  FormCardEstimate.EditingRecord(False);
  case SM_TYPE of
    1:
      FormCardEstimate.ShowForm(IdObject, qrRatesExSM_ID.AsInteger, 3);
    3:
      FormCardEstimate.ShowForm(IdObject, PARENT_ID, 3);
  end;
  CloseOpen(qrRatesEx);
end;

// ������������� ������ �� ������ � ������� ����������
procedure TFormCalculationEstimate.ReCalcRowMech(ACType: byte);
var
  ev: TFieldNotifyEvent;
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'CALL CalcMech(:id, :getdata, :ctype, :CalcMode);';
  qrTemp.ParamByName('id').Value := qrMechanizmID.AsInteger;
  qrTemp.ParamByName('getdata').Value := 1;
  qrTemp.ParamByName('ctype').Value := ACType;
  qrTemp.ParamByName('CalcMode').Value := G_CALCMODE;
  qrTemp.Active := True;
  if not qrTemp.IsEmpty then
  begin
    qrMechanizm.Edit;
    qrMechanizmMECH_INPUTCOUNT.Value := qrTemp.FieldByName('MECH_INPUTCOUNT').AsBCD;
    qrMechanizmMECH_NORMA.Value := qrTemp.FieldByName('MECH_NORMA').AsBCD;
    qrMechanizmMECH_COUNT.Value := qrTemp.FieldByName('MECH_COUNT').AsBCD;
    qrMechanizmPRICE_NO_NDS.Value := qrTemp.FieldByName('PRICE_NO_NDS').AsBCD;
    qrMechanizmPRICE_NDS.Value := qrTemp.FieldByName('PRICE_NDS').AsBCD;
    qrMechanizmZPPRICE_NO_NDS.Value := qrTemp.FieldByName('ZPPRICE_NO_NDS').AsBCD;
    qrMechanizmZPPRICE_NDS.Value := qrTemp.FieldByName('ZPPRICE_NDS').AsBCD;
    qrMechanizmFPRICE_NO_NDS.Value := qrTemp.FieldByName('FPRICE_NO_NDS').AsBCD;
    qrMechanizmFPRICE_NDS.Value := qrTemp.FieldByName('FPRICE_NDS').AsBCD;
    qrMechanizmFZPPRICE_NO_NDS.Value := qrTemp.FieldByName('FZPPRICE_NO_NDS').AsBCD;
    qrMechanizmFZPPRICE_NDS.Value := qrTemp.FieldByName('FZPPRICE_NDS').AsBCD;
    qrMechanizmMECH_SUM_NO_NDS.Value := qrTemp.FieldByName('MECH_SUM_NO_NDS').AsBCD;
    qrMechanizmMECH_SUM_NDS.Value := qrTemp.FieldByName('MECH_SUM_NDS').AsBCD;
    qrMechanizmMECH_ZPSUM_NO_NDS.Value := qrTemp.FieldByName('MECH_ZPSUM_NO_NDS').AsBCD;
    qrMechanizmMECH_ZPSUM_NDS.Value := qrTemp.FieldByName('MECH_ZPSUM_NDS').AsBCD;
    qrMechanizmNORMATIV.Value := qrTemp.FieldByName('NORMATIV').AsBCD;
    qrMechanizmNORM_TRYD.Value := qrTemp.FieldByName('NORM_TRYD').AsBCD;
    qrMechanizmTERYDOZATR.Value := qrTemp.FieldByName('TERYDOZATR').AsBCD;
    qrMechanizm.Post;
    if (qrRatesExID_TYPE_DATA.Value = 3) and (qrRatesExID_TABLES.Value = qrMechanizmID.Value) then
    begin
      ev := qrRatesExOBJ_COUNT.OnChange;
      try
        qrRatesExOBJ_COUNT.OnChange := nil;
        qrRatesEx.Edit;
        qrRatesExOBJ_COUNT.Value := qrMechanizmMECH_INPUTCOUNT.AsExtended;
        qrRatesEx.Post;
      finally
        qrRatesExOBJ_COUNT.OnChange := ev;
      end;
    end;
  end;
  qrTemp.Active := False;
  CloseOpen(qrCalculations);
end;

// �������� ������ ���������
procedure TFormCalculationEstimate.ReCalcRowMat(ACType: byte);
var
  ev: TFieldNotifyEvent;
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'CALL CalcMat(:id, :getdata, :ctype, :CalcMode);';
  qrTemp.ParamByName('id').Value := qrMaterialID.AsInteger;
  qrTemp.ParamByName('getdata').Value := 1;
  qrTemp.ParamByName('ctype').Value := ACType;
  qrTemp.ParamByName('CalcMode').Value := G_CALCMODE;
  qrTemp.Active := True;
  if not qrTemp.IsEmpty then
  begin
    qrMaterial.Edit;
    qrMaterialMAT_NORMA.Value := qrTemp.FieldByName('MAT_NORMA').AsBCD;
    qrMaterialMAT_COUNT.Value := qrTemp.FieldByName('MAT_COUNT').AsBCD;
    qrMaterialTRANSP_NO_NDS.Value := qrTemp.FieldByName('TRANSP_NO_NDS').AsBCD;
    qrMaterialTRANSP_NDS.Value := qrTemp.FieldByName('TRANSP_NDS').AsBCD;
    qrMaterialPRICE_NO_NDS.Value := qrTemp.FieldByName('PRICE_NO_NDS').AsBCD;
    qrMaterialPRICE_NDS.Value := qrTemp.FieldByName('PRICE_NDS').AsBCD;
    qrMaterialFPRICE_NO_NDS.Value := qrTemp.FieldByName('FPRICE_NO_NDS').AsBCD;
    qrMaterialFPRICE_NDS.Value := qrTemp.FieldByName('FPRICE_NDS').AsBCD;
    qrMaterialMAT_SUM_NO_NDS.Value := qrTemp.FieldByName('MAT_SUM_NO_NDS').AsBCD;
    qrMaterialMAT_SUM_NDS.Value := qrTemp.FieldByName('MAT_SUM_NDS').AsBCD;
    qrMaterialMAT_TRANSP_NO_NDS.Value := qrTemp.FieldByName('MAT_TRANSP_NO_NDS').AsBCD;
    qrMaterialMAT_TRANSP_NDS.Value := qrTemp.FieldByName('MAT_TRANSP_NDS').AsBCD;
    qrMaterial.Post;
    if (qrRatesExID_TYPE_DATA.Value = 2) and (qrRatesExID_TABLES.Value = qrMaterialID.Value) then
    begin
      ev := qrRatesExOBJ_COUNT.OnChange;
      try
        qrRatesExOBJ_COUNT.OnChange := nil;
        qrRatesEx.Edit;
        qrRatesExOBJ_COUNT.Value := qrMaterialMAT_COUNT.AsExtended;
        qrRatesEx.Post;
      finally
        qrRatesExOBJ_COUNT.OnChange := ev;
      end;
    end;
  end;
  qrTemp.Active := False;

  if qrMaterialID_REPLACED.AsInteger > 0 then
    UpdateMatCountInGridRate(qrMaterialID.AsInteger, qrMaterialMAT_COUNT.Value);

  CloseOpen(qrCalculations);
end;

// �������� ������ ������������
procedure TFormCalculationEstimate.ReCalcRowDev;
var
  ev: TFieldNotifyEvent;
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'CALL CalcDevice(:id, :getdata);';
  qrTemp.ParamByName('id').Value := qrDevicesID.AsInteger;
  qrTemp.ParamByName('getdata').Value := 1;
  qrTemp.Active := True;
  if not qrTemp.IsEmpty then
  begin
    qrDevices.Edit;
    qrDevicesDEVICE_COUNT.Value := qrTemp.FieldByName('DEVICE_COUNT').AsBCD;
    qrDevicesFPRICE_NO_NDS.Value := qrTemp.FieldByName('FPRICE_NO_NDS').AsBCD;
    qrDevicesFPRICE_NDS.Value := qrTemp.FieldByName('FPRICE_NDS').AsBCD;
    qrDevicesDEVICE_SUM_NO_NDS.Value := qrTemp.FieldByName('DEVICE_SUM_NO_NDS').AsBCD;
    qrDevicesDEVICE_SUM_NDS.Value := qrTemp.FieldByName('DEVICE_SUM_NDS').AsBCD;
    qrDevices.Post;

    ev := qrRatesExOBJ_COUNT.OnChange;
    try
      qrRatesExOBJ_COUNT.OnChange := nil;
      qrRatesEx.Edit;
      qrRatesExOBJ_COUNT.Value := qrDevicesDEVICE_COUNT.AsExtended;
      qrRatesEx.Post;
    finally
      qrRatesExOBJ_COUNT.OnChange := ev;
    end;
  end;
  qrTemp.Active := False;
  CloseOpen(qrCalculations);
end;

function TFormCalculationEstimate.CheckMatINRates: Boolean;
begin
  Result := (qrRatesExID_RATE.AsInteger > 0) and (qrRatesExID_TYPE_DATA.AsInteger = 2);
end;

// �������� ��� �������� ��������� � ������� ����������
function TFormCalculationEstimate.CheckMatUnAccountingMatirials: Boolean;
begin
  Result := qrMaterialCONSIDERED.AsInteger = 0;
end;

procedure TFormCalculationEstimate.qrRatesExAfterOpen(DataSet: TDataSet);
var
  NumPP: Integer;
  Key: Variant;
begin
  if not CheckQrActiveEmpty(qrRatesEx) then
    Exit;
  Key := qrRatesEx.FieldByName('SORT_ID').Value;
  // ������������� ���
  qrRatesEx.DisableControls;
  qrRatesEx.AfterScroll := nil;
  qrRatesEx.OnCalcFields := nil;
  NumPP := 0;
  try
    qrRatesEx.First;
    while not qrRatesEx.Eof do
    begin
      NumPP := NumPP + qrRatesEx.FieldByName('INCITERATOR').AsInteger;
      qrRatesEx.Edit;
      if qrRatesEx.FieldByName('ID_TYPE_DATA').AsInteger < 0 then
        qrRatesEx.FieldByName('ITERATOR').Value := Null
      else
        qrRatesEx.FieldByName('ITERATOR').AsInteger := NumPP;
      qrRatesEx.Next;
    end;
  finally
    qrRatesEx.AfterScroll := qrRatesExAfterScroll;
    qrRatesEx.OnCalcFields := qrRatesExCalcFields;
    qrRatesEx.Locate('SORT_ID', Key, []);
    qrRatesEx.EnableControls;
    grRatesEx.SelectedRows.Clear;
  end;
end;

procedure TFormCalculationEstimate.qrRatesExAfterScroll(DataSet: TDataSet);
begin
  // ��� ���� ���-�� ����� �� ������� ��� ������� ��������� ������ ���������� � ���������
  if qrRatesEx.Tag <> 1 then
  begin
    tmRate.Enabled := False;
    tmRate.Enabled := True;
  end;
end;

procedure TFormCalculationEstimate.qrRatesExBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert] then
  begin
    DataSet.Cancel;
    Abort;
  end;
end;

procedure TFormCalculationEstimate.qrRatesExCalcFields(DataSet: TDataSet);
// ������� ������� ������� ����������� ����������/���������� � ��������
  function GetAddedCount(const ID_CARD_RATE: Integer): Integer;
  begin
    Result := 0;
    DM.qrDifferent.SQL.Text :=
      'SELECT ADDED FROM materialcard_temp WHERE ID_CARD_RATE=:ID_CARD_RATE AND ADDED=1 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('ADDED').AsInteger;
    // ���� ��� ��� �� �����, �� ����� ������ �� ����������� ������ ��������
    if Result > 0 then
      Exit;
    DM.qrDifferent.SQL.Text :=
      'SELECT ADDED FROM mechanizmcard_temp WHERE ID_CARD_RATE=:ID_CARD_RATE AND ADDED=1 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('ADDED').AsInteger;
    DM.qrDifferent.Active := False;
  end;
  function GetReplacedCount(const ID_CARD_RATE: Integer): Integer;
  begin
    Result := 0;
    DM.qrDifferent.SQL.Text :=
      'SELECT 1 AS R FROM materialcard_temp WHERE ID_CARD_RATE=:ID_CARD_RATE AND ID_REPLACED>0 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('R').AsInteger;
    // ���� ��� ��� �� �����, �� ����� ������ �� ����������� ������ ��������
    if Result > 0 then
      Exit;
    DM.qrDifferent.SQL.Text :=
      'SELECT 1 AS R FROM mechanizmcard_temp WHERE ID_CARD_RATE=:ID_CARD_RATE AND ID_REPLACED>0 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('R').AsInteger;
    DM.qrDifferent.Active := False;
  end;

begin
  if not CheckQrActiveEmpty(qrRatesEx) then
    Exit;

  if qrRatesExID_TYPE_DATA.Value = 1 then
    qrRatesExADDED_COUNT.Value := GetAddedCount(qrRatesExID_TABLES.Value);

  if qrRatesExID_TYPE_DATA.Value = 1 then
    qrRatesExREPLACED_COUNT.Value := GetReplacedCount(qrRatesExID_TABLES.Value);
end;

procedure TFormCalculationEstimate.qrRatesExCODEChange(Sender: TField);
var
  NewCode: string;
  NewID: Integer;
  Point: TPoint;
begin
  NewCode := AnsiUpperCase(qrRatesExOBJ_CODE.AsString);
  grRatesEx.EditorMode := False;

  if Length(NewCode) = 0 then
    Exit;

  NewID := 0;

  // ������ ��������� �� ������������
  if (NewCode[1] = '�') or (NewCode[1] = 'E') or (NewCode[1] = 'T') or (NewCode[1] = '�') or
    (NewCode[1] = 'W') or (NewCode[1] = '0') then // E ������������ � ���������
  begin
    if (NewCode[1] = 'E') or (NewCode[1] = 'T') then
      NewCode[1] := '�';
    if NewCode[1] = 'W' then
      NewCode[1] := '�';

    if NewCode[1] = 'W' then
      NewCode[1] := '�';
    qrTemp.Active := False;
    qrTemp.SQL.Clear;
    qrTemp.SQL.Add('SELECT normativ_id, norm_num FROM normativg WHERE ' +
      '(norm_num = :norm_num1) or (norm_num = :norm_num2) order by norm_num;');
    qrTemp.ParamByName('norm_num1').Value := NewCode;
    qrTemp.ParamByName('norm_num2').Value := NewCode + '*';
    qrTemp.Active := True;
    if not qrTemp.IsEmpty then
    begin
      if qrTemp.RecordCount > 1 then
      begin
        PMAddRateOld.Caption := qrTemp.Fields[1].AsString;
        PMAddRateOld.Tag := qrTemp.Fields[0].AsInteger;
        qrTemp.Next;
        PMAddRateNew.Caption := qrTemp.Fields[1].AsString;
        PMAddRateNew.Tag := qrTemp.Fields[0].AsInteger;
        qrTemp.Active := False;
        qrRatesExOBJ_CODE.AsString := '';

        Point.X := grRatesEx.CellRect(grRatesEx.Col, grRatesEx.Row).Left;
        Point.Y := grRatesEx.CellRect(grRatesEx.Col, grRatesEx.Row).Bottom + 1;
        pmAddRate.Popup(grRatesEx.ClientToScreen(Point).X, grRatesEx.ClientToScreen(Point).Y);

        Exit;
      end
      else
        NewID := qrTemp.Fields[0].AsInteger;
    end;
    qrTemp.Active := False;
    if NewID = 0 then
    begin
      MessageBox(0, '�������� � ��������� ����� �� �������!', CaptionForm,
        MB_ICONINFORMATION + MB_OK + mb_TaskModal);
      qrRatesExOBJ_CODE.AsString := '';
      Exit;
    end;

    AddRate(NewID);
    grRatesEx.EditorMode := True;
    Exit;
  end;

  if (NewCode[1] = '�') or (NewCode[1] = 'C') or // C ������������ � ���������
    ((Length(NewCode) > 1) and (NewCode[1] = '5') and CharInSet(NewCode[2], ['7', '8'])) then
  begin
    if NewCode[1] = 'C' then
      NewCode[1] := '�';

    qrTemp.Active := False;
    qrTemp.SQL.Clear;
    qrTemp.SQL.Add('SELECT MATERIAL_ID FROM material WHERE MAT_CODE = :CODE;');
    qrTemp.ParamByName('CODE').Value := NewCode;
    qrTemp.Active := True;
    if not qrTemp.IsEmpty then
      NewID := qrTemp.Fields[0].AsInteger;
    qrTemp.Active := False;
    if NewID = 0 then
    begin
      MessageBox(0, '�������� � ��������� ����� �� ������!', CaptionForm,
        MB_ICONINFORMATION + MB_OK + mb_TaskModal);
      qrRatesExOBJ_CODE.AsString := '';
      Exit;
    end;

    AddMaterial(NewID);
    grRatesEx.EditorMode := True;
    Exit;
  end;
  if (NewCode[1] = '�') or (NewCode[1] = 'M') or (NewCode[1] = 'V') then // M ������������ � ���������
  begin

    if (NewCode[1] = 'M') or (NewCode[1] = 'V') then
      NewCode[1] := '�';
    qrTemp.Active := False;
    qrTemp.SQL.Clear;
    qrTemp.SQL.Add('SELECT MECHANIZM_ID FROM mechanizm WHERE MECH_CODE = :CODE;');
    qrTemp.ParamByName('CODE').Value := NewCode;
    qrTemp.Active := True;
    if not qrTemp.IsEmpty then
      NewID := qrTemp.Fields[0].AsInteger;
    qrTemp.Active := False;
    if NewID = 0 then
    begin
      MessageBox(0, '�������� � ��������� ����� �� ������!', CaptionForm,
        MB_ICONINFORMATION + MB_OK + mb_TaskModal);
      qrRatesExOBJ_CODE.AsString := '';
      Exit;
    end;

    AddMechanizm(NewID);
    grRatesEx.EditorMode := True;
    Exit;
  end;

  if CharInSet(NewCode[1], ['1', '9']) then
  begin
    qrTemp.Active := False;
    qrTemp.SQL.Clear;
    qrTemp.SQL.Add('SELECT DEVICE_ID FROM devices WHERE DEVICE_CODE1 = :CODE;');
    qrTemp.ParamByName('CODE').Value := NewCode;
    qrTemp.Active := True;
    if not qrTemp.IsEmpty then
      NewID := qrTemp.Fields[0].AsInteger;
    qrTemp.Active := False;
    if NewID = 0 then
    begin
      MessageBox(0, '������������ � ��������� ����� �� ������!', CaptionForm,
        MB_ICONINFORMATION + MB_OK + mb_TaskModal);
      qrRatesExOBJ_CODE.AsString := '';
      Exit;
    end;
    AddDevice(NewID);
    grRatesEx.EditorMode := True;
    Exit;
  end;

  MessageBox(0, '�� ���������� ���� ������ �� �������!', CaptionForm,
    MB_ICONINFORMATION + MB_OK + mb_TaskModal);
  qrRatesExOBJ_CODE.AsString := '';
end;

procedure TFormCalculationEstimate.qrRatesExCOUNTChange(Sender: TField);
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    Exit;
  end;

  if qrRatesEx.Tag <> 1 then
  begin
    case qrRatesExID_TYPE_DATA.AsInteger of
      1:
        qrTemp.SQL.Text := 'UPDATE card_rate_temp set rate_count=:RC WHERE ID=:ID;';
      2:
        qrTemp.SQL.Text := 'UPDATE materialcard_temp set mat_count=:RC WHERE ID=:ID;';
      3:
        qrTemp.SQL.Text := 'UPDATE mechanizmcard_temp set MECH_INPUTCOUNT=:RC WHERE ID=:ID;';
      4:
        qrTemp.SQL.Text := 'UPDATE devicescard_temp set device_count=:RC WHERE ID=:ID;';
      5:
        qrTemp.SQL.Text := 'UPDATE dumpcard_temp set WORK_COUNT = :RC WHERE ID=:ID;';
      6, 7, 8, 9:
        qrTemp.SQL.Text := 'UPDATE transpcard_temp set CARG_COUNT = :RC WHERE ID=:ID;';
      10, 11:
        begin
          qrTemp.SQL.Text := 'UPDATE data_row_temp set E1820_COUNT = :RC WHERE ID=:ID;';
          qrTemp.ParamByName('ID').Value := qrRatesExDATA_ESTIMATE_OR_ACT_ID.AsInteger;
        end;
    else
      begin
        ShowMessage('������ ���������� �� ����������!');
        Exit;
      end;
    end;
    if not(qrRatesExID_TYPE_DATA.AsInteger in [10, 11]) then
      qrTemp.ParamByName('ID').Value := qrRatesExID_TABLES.AsInteger;
    qrTemp.ParamByName('RC').Value := Sender.Value;
    qrTemp.ExecSQL;
    // ������������� ��� �������� �� ������ ������
    ReCalcRowRates;
  end;
end;

procedure TFormCalculationEstimate.qrRatesExNUM_ROWChange(Sender: TField);
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    Exit;
  end;

  if qrRatesEx.Tag <> 1 then
  begin
    qrTemp.SQL.Text := 'UPDATE data_row_temp set NUM_ROW = :RC WHERE ID=:ID;';
    qrTemp.ParamByName('ID').Value := qrRatesExDATA_ESTIMATE_OR_ACT_ID.AsInteger;
    qrTemp.ParamByName('RC').Value := Sender.Value;
    qrTemp.ExecSQL;
    CloseOpen(qrRatesEx);
  end;
end;

procedure TFormCalculationEstimate.qrRatesWORK_IDChange(Sender: TField);
begin
  qrTemp.SQL.Text := 'UPDATE card_rate_temp SET WORK_ID = :p1 WHERE ID = :p2';
  qrTemp.ParamByName('p1').AsInteger := qrRatesExWORK_ID.Value;
  qrTemp.ParamByName('p2').AsInteger := qrRatesExID_TABLES.Value;
  qrTemp.ExecSQL;
  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.qrStartupAfterScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if btnStartup.Down then
    MemoRight.Text := qrStartupRATE_CAPTION.AsString;
end;

procedure TFormCalculationEstimate.qrTranspAfterScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if btnTransp.Down then
    MemoRight.Text := qrTranspTRANSP_JUST.AsString;
end;

procedure TFormCalculationEstimate.qrTranspCalcFields(DataSet: TDataSet);
var
  F: TField;
begin
  F := DataSet.FieldByName('NUM');
  if DataSet.Bof then
    F.AsInteger := 1
  else
    F.AsInteger := DataSet.RecNo;

  case qrTranspCARG_CLASS.AsInteger of
    0:
      qrTranspCLASS.AsString := 'I';
    1:
      qrTranspCLASS.AsString := 'II';
    2:
      qrTranspCLASS.AsString := 'III';
    3:
      qrTranspCLASS.AsString := 'IV';
  end;
end;

// ������������� ��� ����������� � ������ � ������� ��������
procedure TFormCalculationEstimate.ReCalcRowRates;
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'CALL CalcRowInRateTab(:ID, :TYPE, :CalcMode);';
  qrTemp.ParamByName('ID').Value := qrRatesExID_TABLES.Value;
  qrTemp.ParamByName('TYPE').Value := qrRatesExID_TYPE_DATA.Value;
  qrTemp.ParamByName('CalcMode').Value := G_CALCMODE;
  qrTemp.ExecSQL;

  // ��� �������� ����������� ���-�� � ���������� ����������
  if qrRatesExID_TYPE_DATA.AsInteger = 1 then
    GridRatesUpdateCount;

  GridRatesRowLoad;

  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.GridRatesUpdateCount;
var
  RecNo: Integer;
  NewCount: Currency;
begin
  RecNo := qrRatesEx.RecNo;
  // ��� ������� ��������� COUNTFORCALC � � ���������� ��� ���������� ����������
  if qrRatesExID_TYPE_DATA.AsInteger = 1 then
  begin
    qrRatesEx.Tag := 1; // ��������� ����������� ������� ��������
    qrRatesEx.DisableControls;
    try
      if not qrRatesEx.Eof then
        qrRatesEx.Next;

      qrTemp.Active := False;

      while not qrRatesEx.Eof do
      begin
        if CheckMatINRates then
        begin
          NewCount := 0;
          qrTemp.SQL.Text := 'Select MAT_COUNT FROM materialcard_temp ' + 'WHERE ID = ' +
            INTTOSTR(qrRatesExID_TABLES.AsInteger);
          qrTemp.Active := True;
          if not qrTemp.Eof then
            NewCount := qrTemp.Fields[0].Value;
          qrTemp.Active := False;

          qrRatesEx.Edit;
          qrRatesExOBJ_COUNT.Value := NewCount;
          qrRatesEx.Post;
        end
        else
          Break; // ��� ��� ������� ������������
        qrRatesEx.Next;
      end;
      qrRatesEx.RecNo := RecNo;
    finally
      qrRatesEx.Tag := 0;
      qrRatesEx.EnableControls
    end;
  end;
end;

procedure TFormCalculationEstimate.UpdateMatCountInGridRate(AMId: Integer; AMCount: TBcd);
var
  RecNo: Integer;
begin
  RecNo := qrRatesEx.RecNo;
  // ��� ������� ��������� COUNTFORCALC � � ���������� ��� ���������� ����������

  qrRatesEx.Tag := 1; // ��������� ����������� ������� ��������
  qrRatesEx.DisableControls;
  try
    qrRatesEx.First;

    while not qrRatesEx.Eof do
    begin
      if (qrRatesExID_TYPE_DATA.AsInteger = 2) and (qrRatesExID_TABLES.AsInteger = AMId) then
      begin
        qrRatesEx.Edit;
        qrRatesExOBJ_COUNT.Value := BcdToDouble(AMCount);
        qrRatesEx.Post;
        Break;
      end;

      qrRatesEx.Next;
    end;
    qrRatesEx.RecNo := RecNo;
  finally
    qrRatesEx.Tag := 0;
    qrRatesEx.EnableControls
  end;
end;

procedure TFormCalculationEstimate.ReplacementClick(Sender: TObject);
var
  frmReplace: TfrmReplacement;
begin
  case TMenuItem(Sender).Tag of
    0:
      frmReplace := TfrmReplacement.Create(IdObject, IdEstimate, 0, qrMaterialID.AsInteger, 0, 2,
        False, False);
    1:
      frmReplace := TfrmReplacement.Create(IdObject, IdEstimate, 0, qrMechanizmID.AsInteger, 0, 3,
        False, False);
    2:
      frmReplace := TfrmReplacement.Create(IdObject, IdEstimate, 0, qrDevicesID.AsInteger, 0, 4,
        False, False);
  else
    Exit;
  end;

  if Assigned(frmReplace) then
    try
      if (frmReplace.ShowModal = mrYes) then
      begin
        RecalcEstimate;
        OutputDataToTable;
      end;
    finally
      FreeAndNil(frmReplace);
    end;
end;

procedure TFormCalculationEstimate.nSelectWinterPriseClick(Sender: TObject);
begin
  if (not Assigned(fWinterPrice)) then
    fWinterPrice := TfWinterPrice.Create(Self);
  fWinterPrice.Kind := kdSelect;
  fWinterPrice.LicateID := qrRatesExZNORMATIVS_ID.Value;
  if (fWinterPrice.ShowModal = mrOk) and (fWinterPrice.OutValue <> 0) then
  begin
    FastExecSQL('UPDATE card_rate_temp SET ZNORMATIVS_ID=:ZNORMATIVS_ID WHERE ID=:ID',
      VarArrayOf([fWinterPrice.OutValue, qrRatesExID_TABLES.AsInteger]));
    qrRatesExZNORMATIVS_ID.Value := fWinterPrice.OutValue;
    FillingWinterPrice('');
    CloseOpen(qrCalculations);
  end;
end;

procedure TFormCalculationEstimate.nWinterPriseSetDefaultClick(Sender: TObject);
begin
  if Application.MessageBox('�� ������������� ������ �������� ����. ������� ���������� � ��������� ��������?',
    'Application.Title', MB_OKCANCEL + MB_ICONQUESTION + MB_TOPMOST) = IDOK then
  begin
    FastExecSQL('UPDATE card_rate_temp SET ZNORMATIVS_ID=NULL WHERE ID=:ID',
      VarArrayOf([qrRatesExID_TABLES.AsInteger]));
    qrRatesExZNORMATIVS_ID.Value := 0;
    EditWinterPrice.Text := '';
    FillingWinterPrice(qrRatesExOBJ_CODE.AsString);
    CloseOpen(qrCalculations);
  end;
end;

procedure TFormCalculationEstimate.N3Click(Sender: TObject);
begin
  FormSummaryCalculationSettings.ShowModal;
end;

procedure TFormCalculationEstimate.PMCalcDeviceClick(Sender: TObject);
begin
  FCalculator.ShowCalculator(dbgrdDevices, qrDevicesFCOAST_NDS.Value, qrDevicesDEVICE_COUNT.Value,
    qrDevicesFPRICE_NDS.Value, qrDevicesNDS.Value, 'FCOAST_NDS');
end;

procedure TFormCalculationEstimate.PMCalcMatClick(Sender: TObject);
begin
  FCalculator.ShowCalculator(dbgrdMaterial, qrMaterialFCOAST_NDS.Value, qrMaterialMAT_COUNT.Value,
    qrMaterialFPRICE_NDS.Value, qrMaterialNDS.Value, 'FCOAST_NDS');
end;

procedure TFormCalculationEstimate.PMCalcMechClick(Sender: TObject);
begin
  FCalculator.ShowCalculator(dbgrdMechanizm, qrMechanizmFCOAST_NDS.Value, qrMechanizmMECH_COUNT.Value,
    qrMechanizmFPRICE_NDS.Value, qrMechanizmNDS.Value, 'FCOAST_NDS');
end;

procedure TFormCalculationEstimate.PMCopyClick(Sender: TObject);
var
  DataObj: TSmClipData;
  TempBookmark: TBookMark;
  i, j: Integer;
begin
  if not(qrRatesExID_TYPE_DATA.Value > 0) or Act then
    Exit;

  if not grRatesEx.SelectedRows.CurrentRowSelected then
  begin
    grRatesEx.SelectedRows.Clear;
    grRatesEx.SelectedRows.CurrentRowSelected := True;
  end;

  DataObj := TSmClipData.Create;
  try
    grRatesEx.DataSource.DataSet.DisableControls;
    with grRatesEx.SelectedRows do
      if Count <> 0 then
      begin
        TempBookmark := grRatesEx.DataSource.DataSet.GetBookmark;
        for i := 0 to Count - 1 do
        begin
          if IndexOf(Items[i]) > -1 then
          begin
            grRatesEx.DataSource.DataSet.Bookmark := Items[i];

            if qrRatesExID_TYPE_DATA.Value > 0 then
            begin
              j := Length(DataObj.SmClipArray);
              SetLength(DataObj.SmClipArray, j + 1);

              DataObj.SmClipArray[j].ObjID := IdObject;
              DataObj.SmClipArray[j].SmID := qrRatesExSM_ID.Value;
              DataObj.SmClipArray[j].DataID := qrRatesExID_TABLES.Value;
              DataObj.SmClipArray[j].DataType := qrRatesExID_TYPE_DATA.Value;
            end;
          end;
        end;
        DataObj.CopyToClipBoard;
        grRatesEx.DataSource.DataSet.GotoBookmark(TempBookmark);
        grRatesEx.DataSource.DataSet.FreeBookmark(TempBookmark);
      end;
    grRatesEx.DataSource.DataSet.EnableControls;
  finally
    DataObj.Free;
  end;
end;

procedure TFormCalculationEstimate.PMMatAddToRateClick(Sender: TObject);
var
  frmReplace: TfrmReplacement;
  IdRate: Integer;
begin
  if qrRatesExID_TYPE_DATA.AsInteger = 1 then
    IdRate := qrRatesExID_TABLES.AsInteger
  else
    IdRate := qrRatesExSM_ID.AsInteger;

  frmReplace := TfrmReplacement.Create(IdObject, IdEstimate, IdRate, 0, 0, TMenuItem(Sender).Tag,
    True, False);

  try
    if (frmReplace.ShowModal = mrYes) then
      OutputDataToTable;
  finally
    FreeAndNil(frmReplace);
  end;
end;

procedure TFormCalculationEstimate.PMMatDeleteClick(Sender: TObject);
begin
  if MessageBox(0, PChar('�� ������������� ������ ������� ' + qrMaterialMAT_CODE.AsString + '?'), CaptionForm,
    MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
    Exit;

  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL DeleteMaterial(:id, :CalcMode);');
      ParamByName('id').Value := qrMaterialID.AsInteger;
      ParamByName('CalcMode').Value := G_CALCMODE;
      ExecSQL;
    end;

  except
    on e: Exception do
      MessageBox(0, PChar('��� �������� ��������� �������� ������:' + sLineBreak + sLineBreak + e.message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  OutputDataToTable;
end;

procedure TFormCalculationEstimate.PMMatMechEditClick(Sender: TObject);
begin
  if TMenuItem(Sender).Tag = 1 then
    SetMechEditMode
  else
    SetMatEditMode;
end;

procedure TFormCalculationEstimate.PMMatRestoreClick(Sender: TObject);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE materialcard_temp SET DELETED = 0 WHERE id = :vId');
      ParamByName('vId').Value := qrMaterialID.AsInteger;
      ExecSQL;
    end;

    OutputDataToTable;
  except
    on e: Exception do
      MessageBox(0, PChar('��� �������������� ��������� �������� ������:' + sLineBreak + sLineBreak +
        e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.PMMatFromRatesClick(Sender: TObject);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL FromRareMaterial(:id_estimate, :id_mat, 0);');
      ParamByName('id_estimate').Value := qrRatesExSM_ID.AsInteger;
      ParamByName('id_mat').Value := qrMaterialID.AsInteger;
      ExecSQL;
    end;

    OutputDataToTable;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ��������� ��������� �� �������� �������� ������:' + sLineBreak + sLineBreak +
        e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// �������� ������� ���������� �� ��������������
procedure TFormCalculationEstimate.PMMechAutoRepClick(Sender: TObject);
begin
  (Sender as TMenuItem).Checked := not(Sender as TMenuItem).Checked;
end;

procedure TFormCalculationEstimate.PMMechDeleteClick(Sender: TObject);
begin
  if MessageBox(0, PChar('�� ������������� ������ ������� ' + qrMechanizmMECH_CODE.AsString + '?'),
    CaptionForm, MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
    Exit;

  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL DeleteMechanism(:id, :CalcMode);');
      ParamByName('id').Value := qrMechanizmID.AsInteger;
      ParamByName('CalcMode').Value := G_CALCMODE;
      ExecSQL;
    end;

  except
    on e: Exception do
      MessageBox(0, PChar('��� �������� ��������� �������� ������:' + sLineBreak + sLineBreak + e.message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  OutputDataToTable;
end;

// ��������� ������ ������������ �������������� ���������
procedure TFormCalculationEstimate.SetMechEditMode;
begin
  if CheckMechReadOnly then
    Exit;
  dbgrdMechanizm.Columns[2].ReadOnly := False; // �����
  dbgrdMechanizm.Columns[5].ReadOnly := False; // ���-��
  dbgrdMechanizm.Columns[6].ReadOnly := False; // �� ���������
  dbgrdMechanizm.Columns[7].ReadOnly := False; // �� ���������
  dbgrdMechanizm.Columns[10].ReadOnly := False; // ��������
  dbgrdMechanizm.Columns[11].ReadOnly := False; // ��������
  dbgrdMechanizm.Columns[14].ReadOnly := False; // ���
  dbgrdMechanizm.Columns[23].ReadOnly := False; // ��������
  MemoRight.Color := $00AFFEFC;
  MemoRight.ReadOnly := False;
  MemoRight.Tag := 3;
  qrMechanizm.Tag := 1;
end;

// ���������� ������ ������������ �������������� ���������
procedure TFormCalculationEstimate.SetMechNoEditMode;
begin
  if qrMechanizm.Tag = 1 then
  begin
    dbgrdMechanizm.Columns[2].ReadOnly := True; // �����
    dbgrdMechanizm.Columns[5].ReadOnly := True; // ���-��
    dbgrdMechanizm.Columns[6].ReadOnly := True; // �� ���������
    dbgrdMechanizm.Columns[7].ReadOnly := True; // �� ���������
    dbgrdMechanizm.Columns[10].ReadOnly := True; // ��������
    dbgrdMechanizm.Columns[11].ReadOnly := True; // ��������
    dbgrdMechanizm.Columns[14].ReadOnly := True; // ���
    dbgrdMechanizm.Columns[23].ReadOnly := True; // ��������
    MemoRight.Color := clWindow;
    MemoRight.ReadOnly := True;
    MemoRight.Tag := 0;
    qrMechanizm.Tag := 0;
  end;
end;

procedure TFormCalculationEstimate.PMMechFromRatesClick(Sender: TObject);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL FromRareMechanism(:id_estimate, :id_mech, 0, :CalcMode);');
      ParamByName('id_estimate').Value := qrRatesExSM_ID.AsInteger;
      ParamByName('id_mech').Value := qrMechanizmID.Value;
      ParamByName('CalcMode').Value := G_CALCMODE;
      ExecSQL;
    end;

    OutputDataToTable;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ��������� ��������� �� �������� �������� ������:' + sLineBreak + sLineBreak +
        e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.PMMechRestoreClick(Sender: TObject);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE mechanizmcard_temp SET DELETED = 0 WHERE id = :vId');
      ParamByName('vId').Value := qrMechanizmID.Value;
      ExecSQL;
    end;

    OutputDataToTable;
  except
    on e: Exception do
      MessageBox(0, PChar('��� �������������� ��������� �������� ������:' + sLineBreak + sLineBreak +
        e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.PMPasteClick(Sender: TObject);
var
  DataObj: TSmClipData;
begin
  if not((qrRatesExID_TYPE_DATA.AsInteger > 0) or (qrRatesExID_TYPE_DATA.AsInteger = -4) or
    (qrRatesExID_TYPE_DATA.AsInteger = -3)) or Act then
    Exit;

  DataObj := TSmClipData.Create;
  try
    if ClipBoard.HasFormat(G_SMETADATA) then
    begin
      DataObj.GetFromClipBoard;
      if PasteSmetaRow(DataObj.SmClipArray, qrRatesExSM_ID.Value, qrRatesExNUM_ROW.Value) then
        OutputDataToTable;
    end;
  finally
    DataObj.Free;
  end;
end;

procedure TFormCalculationEstimate.PMRateRefClick(Sender: TObject);
begin
  PMAddRatMatMechEquipRefClick(nil);
  if Assigned(FormAdditionData) then
    FormAdditionData.FrameRates.EditRate.Text := StringReplace(PMAddRateOld.Caption, '&', '', [rfReplaceAll]);
end;

procedure TFormCalculationEstimate.ButtonSSRDetailsClick(Sender: TObject);
begin
  FormSignatureSSR.ShowModal;
end;

procedure TFormCalculationEstimate.ButtonSSRAddClick(Sender: TObject);
var
  P: TPoint;
begin
  P := (Sender as TButton).ClientToScreen(Point(0, 0));
  pmSSRButtonAdd.Popup(P.X, P.Y);
end;

procedure TFormCalculationEstimate.ButtonSSRTaxClick(Sender: TObject);
var
  P: TPoint;
begin
  P := (Sender as TButton).ClientToScreen(Point(0, 0));
  pmSSRButtonTax.Popup(P.X, P.Y);
end;

procedure TFormCalculationEstimate.ButtonSRRNewClick(Sender: TObject);
var
  DialogResult: Integer;
begin
  DialogResult := MessageBox(0, PChar('������� ��� ����� ������. ����������?'), '�����',
    MB_ICONINFORMATION + MB_YESNO + mb_TaskModal);

  if DialogResult = mrYes then
    MessageBox(0, PChar('����� ���'), '�����', MB_ICONINFORMATION + MB_OK + mb_TaskModal)
  else
    FormCalculationEstimate.Close;
end;

procedure TFormCalculationEstimate.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  DialogResult: Integer;
  FormCardAct: TfCardAct;
begin
  DialogResult := mrNone;

  if (not ActReadOnly) and (PanelCalculationYesNo.Tag = 1) and ConfirmCloseForm then
    DialogResult := MessageBox(0, PChar('��������� ��������� ��������� ����� ��������� ����?'), '�����',
      MB_ICONINFORMATION + MB_YESNOCANCEL + mb_TaskModal);

  if DialogResult = mrCancel then
  begin
    ConfirmCloseForm := True;
    CanClose := False;
    Exit;
  end;

  if DialogResult = mrYes then
    if Act then
    begin
      if IdAct = 0 then
      begin
        FormCardAct := TfCardAct.Create(Self);
        FormCardAct.Kind := kdInsert;
        FormCardAct.ShowModal;
      end
      else if not ActReadOnly then
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL SaveDataAct(:IdAct);');
            ParamByName('IdAct').Value := IdAct;
            ExecSQL;
          end;
        except
          on e: Exception do
          begin
            qrTemp.SQL.Text := 'SELECT @ErrorCode AS ECode';
            qrTemp.Active := True;
            MessageBox(0, PChar('��� ���������� ������ ���� �������� ������:' + sLineBreak + sLineBreak +
              e.message + sLineBreak + qrTemp.FieldByName('ECode').AsString), CaptionForm,
              MB_ICONERROR + MB_OK + mb_TaskModal);
          end;
        end;
    end
    else
      try
        with qrTemp do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('CALL SaveAllDataEstimate(:id_estimate);');
          ParamByName('id_estimate').Value := IdEstimate;
          ExecSQL;
        end;
      except
        on e: Exception do
        begin
          qrTemp.SQL.Text := 'SELECT @ErrorCode AS ECode';
          qrTemp.Active := True;
          MessageBox(0, PChar('��� ���������� ������ ����� �������� ������:' + sLineBreak + sLineBreak +
            e.message + sLineBreak + qrTemp.FieldByName('ECode').AsString), CaptionForm,
            MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      end;

  CanClose := True;
end;

procedure TFormCalculationEstimate.GridRatesRowLoad;
begin
  case qrRatesExID_TYPE_DATA.AsInteger of
    1: // ��������
      begin
        // ���������� ������ ������
        FillingTableMaterials(qrRatesExID_TABLES.AsInteger, 0);
        FillingTableMechanizm(qrRatesExID_TABLES.AsInteger, 0);
        FillingTableDescription(qrRatesExID_TABLES.AsInteger);
      end;
    2: // ��������
      begin
        // ���������� ���������� �������� � ��������
        if CheckMatINRates then
        begin
          FillingTableMaterials(qrRatesExID_RATE.AsInteger, 0);
        end
        else
        begin // ��������� �������� � ����������
          FillingTableMaterials(0, qrRatesExID_TABLES.AsInteger);
        end;
      end;
    3: // ��������
      begin
        // ���������� ������� ����������
        FillingTableMechanizm(0, qrRatesExID_TABLES.AsInteger);
      end;
    4: // ������������
      begin
        // ���������� ������� ������������
        FillingTableDevises(qrRatesExID_TABLES.AsInteger);
      end;
    5: // ������
      begin
        // ���������� ������� ������
        FillingTableDump(qrRatesExID_TABLES.AsInteger);
      end;
    6, 7, 8, 9: // ���������
      begin
        FillingTableTransp(qrRatesExID_TABLES.AsInteger);
      end;
    10, 11: // ���� � �����������
      begin
        FillingTableStartup(qrRatesExID_TYPE_DATA.AsInteger);
      end;
  end;
end;

procedure TFormCalculationEstimate.GridRatesRowSellect;
var
  CalcPrice: string[2];
begin
  // ������� ������ �������-����������
  EditCategory.Text := '';
  EditWinterPrice.Text := '';

  PopupMenuCoefAddSet.Enabled := True;
  PopupMenuCoefDeleteSet.Enabled := True;

  CalcPrice := '00';

  PMDelete.Enabled := True;
  PMEdit.Enabled := False;

  // �������� ����������� ������ �� ������ � ������� ��������
  GridRatesRowLoad;
  // ���¨�������� ��������� �������� � �������� ������
  // BtnChange := False;
  // ����� ��� ������ ������
  BottomTopMenuEnabled(False);
  case qrRatesExID_TYPE_DATA.AsInteger of
    1: // ��������
      begin
        // ��������� �������� ������ ������, ��� �������� ������ ���������� "���������"
        btnMaterials.Enabled := True;
        btnMechanisms.Enabled := True;
        btnDescription.Enabled := True;

        if btnMaterials.Down or btnEquipments.Down or btnDump.Down or btnTransp.Down or btnStartup.Down then
        begin
          btnMaterials.Down := True;
          btnMaterialsClick(btnMaterials);
        end;

        if btnMechanisms.Down then
          btnMechanismsClick(btnMechanisms);

        if btnDescription.Down then
          btnDescriptionClick(btnDescription);

        // ������� ������ �������-����������

        EditCategory.Text :=
          MyFloatToStr
          (GetRankBuilders(VarToStr(FastSelectSQLOne('SELECT RATE_ID FROM card_rate_temp WHERE ID=:1',
          VarArrayOf([qrRatesExID_TABLES.AsInteger])))));

        // �������� ������ ������� ����������
        FillingWinterPrice(qrRatesExOBJ_CODE.AsString);

        CalcPrice := '11';
      end;
    2: // ��������
      begin
        btnMaterials.Enabled := True;
        btnMaterials.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // �������� �� ������ ����������, ��� ����������� ������� ����������
        btnMaterialsClick(btnMaterials);

        CalcPrice := '10';
      end;
    3: // ��������
      begin
        btnMechanisms.Enabled := True;
        btnMechanisms.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // �������� �� ������ ����������, ��� ����������� ������� ����������
        btnMechanismsClick(btnMechanisms);

        CalcPrice := '01';
      end;
    4: // ������������
      begin
        btnEquipments.Enabled := True;
        // BtnChange := True;
        btnEquipments.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // �������� �� ������ ������������, ��� ����������� ������� ������������
        btnEquipmentsClick(btnEquipments);
      end;
    5: // ������
      begin
        PMEdit.Enabled := True;
        btnDump.Enabled := True;
        // BtnChange := True;
        btnDump.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // �������� �� ������ ������, ��� ����������� ������� ������
        btnDumpClick(btnDump);
      end;
    6, 7, 8, 9: // ���������
      begin
        PMEdit.Enabled := True;
        btnTransp.Enabled := True;
        // BtnChange := True;
        btnTransp.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        btnTranspClick(btnTransp);
      end;
    10, 11: // ���� � �����������
      begin
        btnStartup.Enabled := True;
        // BtnChange := True;
        btnStartup.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        btnStartupClick(btnStartup);
      end;
  end;
end;

function TFormCalculationEstimate.GetCountCoef(): Integer;
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text :=
    'SELECT COUNT(*) AS CNT FROM calculation_coef_temp where id_estimate=:id_estimate and id_owner=:id_owner and id_type_data=:id_type_data';
  qrTemp.ParamByName('id_estimate').Value := qrRatesExSM_ID.AsInteger;
  qrTemp.ParamByName('id_owner').Value := qrRatesExID_TABLES.AsInteger;
  qrTemp.ParamByName('id_type_data').Value := qrRatesExID_TYPE_DATA.AsInteger;
  qrTemp.Active := True;
  Result := qrTemp.FieldByName('CNT').AsInteger;
  qrTemp.Active := False;
end;

procedure TFormCalculationEstimate.SetActReadOnly(const Value: Boolean);
begin
  ActReadOnly := Value;
end;

procedure TFormCalculationEstimate.PopupMenuCoefAddSetClick(Sender: TObject);
begin
  if fCoefficients.ShowModal = mrOk then
  begin
    if FormCalculationEstimate.GetCountCoef = 5 then
    begin
      MessageBox(0, PChar('��� ��������� 5 ������� �������������!' + sLineBreak + sLineBreak +
        '���������� ������ 5 ������� ����������.'), '�����', MB_ICONINFORMATION + MB_OK + mb_TaskModal);
    end
    else
    begin
      AddCoefToRate(fCoefficients.qrCoef.FieldByName('coef_id').AsInteger);
      RecalcEstimate;
    end;
  end;
end;

procedure TFormCalculationEstimate.PopupMenuCoefDeleteSetClick(Sender: TObject);
begin
  if MessageBox(0, PChar('�� ������������� ������ ������� ' + sLineBreak + '���������� ����� �������������?'),
    '�����', MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) <> mrYes then
    Exit;

  qrTemp.SQL.Text := 'Delete from calculation_coef_temp where calculation_coef_id=:id';
  qrTemp.ParamByName('id').Value := qrCalculations.FieldByName('id').AsInteger;
  qrTemp.ExecSQL;

  RecalcEstimate;
end;

procedure TFormCalculationEstimate.pmCoefPopup(Sender: TObject);
begin
  PopupMenuCoefDeleteSet.Enabled := (qrCalculations.FieldByName('ID').AsInteger > 0);
end;

// ��� ������������ ���� ����������
procedure TFormCalculationEstimate.pmMaterialsPopup(Sender: TObject);
begin
  PMMatEdit.Enabled := (not CheckMatReadOnly);

  PMMatFromRates.Enabled := (not CheckMatReadOnly) and (qrMaterialCONSIDERED.AsInteger = 1) and
    ((qrRatesExID_RATE.AsInteger > 0) or (qrRatesExID_TYPE_DATA.AsInteger = 1));

  PMMatReplace.Enabled := ((not CheckMatReadOnly) or (qrMaterialREPLACED.AsInteger = 1));

  PMMatAddToRate.Enabled := (qrRatesExID_TYPE_DATA.AsInteger = 1) or (qrRatesExID_RATE.AsInteger > 0);

  PMMatDelete.Enabled := (not CheckMatReadOnly) and
  // ����������
    (((qrMaterialID_REPLACED.AsInteger > 0) and (qrMaterialFROM_RATE.AsInteger = 0)) or
    // �����������
    ((qrMaterialADDED.AsInteger > 0) and (qrMaterialFROM_RATE.AsInteger = 0)) or
    // ���������
    ((qrMaterialFROM_RATE.AsInteger = 1) and (qrRatesExID_TYPE_DATA.AsInteger = 2)) or
    // �������
    ((qrMaterialID_CARD_RATE.AsInteger > 0) and (qrMaterialCONSIDERED.AsInteger = 1) and
    (qrMaterialID_REPLACED.AsInteger = 0) and (qrMaterialFROM_RATE.AsInteger = 0) and
    (qrMaterialREPLACED.AsInteger = 0) and (qrMaterialADDED.AsInteger = 0) and
    (qrMaterialDELETED.AsInteger = 0)));

  PMMatRestore.Enabled := qrMaterialDELETED.AsInteger = 1;

  PMCalcMat.Visible := NDSEstimate;
  PMCalcMat.Enabled := (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'FCOAST_NDS');
  // or
  // (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'FTRANSP_NDS');
end;

// ��������� ���� ������������ ���� ������� ����������
procedure TFormCalculationEstimate.pmMechanizmsPopup(Sender: TObject);
begin
  PMMechEdit.Enabled := (not CheckMechReadOnly);

  PMMechFromRates.Enabled := (not CheckMechReadOnly) and
    ((qrRatesExID_RATE.AsInteger > 0) or (qrRatesExID_TYPE_DATA.AsInteger = 1));

  PMMechReplace.Enabled := (not CheckMechReadOnly) or (qrMechanizmREPLACED.AsInteger = 1);

  // �������� ������ � ��������
  PMMechAddToRate.Enabled := (qrRatesExID_TYPE_DATA.AsInteger = 1) or (qrRatesExID_RATE.AsInteger > 0);

  PMMechDelete.Enabled := (not CheckMechReadOnly) and
  // ����������
    (((qrMechanizmID_REPLACED.AsInteger > 0) and (qrMechanizmFROM_RATE.AsInteger = 0)) or
    // �����������
    ((qrMechanizmADDED.AsInteger > 0) and (qrMechanizmFROM_RATE.AsInteger = 0)) or
    // ����������
    ((qrMechanizmFROM_RATE.AsInteger = 1) and (qrRatesExID_TYPE_DATA.AsInteger = 3)) or
    // �������
    ((qrMechanizmID_CARD_RATE.AsInteger > 0) and (qrMechanizmID_REPLACED.AsInteger = 0) and
    (qrMechanizmFROM_RATE.AsInteger = 0) and (qrMechanizmREPLACED.AsInteger = 0) and
    (qrMechanizmADDED.AsInteger = 0) and (qrMechanizmDELETED.AsInteger = 0)));

  PMMechRestore.Enabled := qrMechanizmDELETED.AsInteger = 1;

  PMCalcMech.Visible := NDSEstimate;
  PMCalcMech.Enabled := (dbgrdMechanizm.Columns[dbgrdMechanizm.Col - 1].FieldName = 'FCOAST_NDS');
end;

function TFormCalculationEstimate.CheckCursorInRate: Boolean;
begin
  Result := (qrRatesExID_TYPE_DATA.AsInteger > 0) or // ���-�� ������ �����
    (qrRatesExID_TYPE_DATA.AsInteger = -3) or (qrRatesExID_TYPE_DATA.AsInteger = -4);
  // ��� ����� ����� ��� ������ �����
end;

// ���������� �������� � �����
procedure TFormCalculationEstimate.AddRate(const vRateId: Integer);
var
  vMaxIdRate: Integer;
  MaxMId: Integer;
  NewRateCode: string;
  vNormRas: Double;
  Month1, Year1: Integer;
  PriceVAT, PriceNoVAT: string;
  PT: Real;
begin
  if not CheckCursorInRate then
    Exit;

  // ��������� ��������� �������� �� ��������� ������� card_rate_temp
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddRate(:id_estimate, :id_rate, :cnt);');
      ParamByName('id_estimate').Value := qrRatesExSM_ID.AsInteger;
      ParamByName('id_rate').Value := vRateId;
      ParamByName('cnt').AsFloat := 0;
      Active := True;
      vMaxIdRate := FieldByName('id').AsInteger;
      NewRateCode := FieldByName('RATE_CODE').AsString;
      Active := False;
    end;
  except
    on e: Exception do
    begin
      MessageBox(0, PChar('��� ���������� �������� �� ��������� ������� �������� ������:' + sLineBreak +
        sLineBreak + e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
      Exit;
    end;
  end;

  // ���������� ����������
  ClearAutoRep;

  qrTemp.SQL.Clear;
  qrTemp.SQL.Add('SELECT year,monat,DATE_BEG FROM stavka WHERE stavka_id = ' +
    '(SELECT stavka_id FROM smetasourcedata WHERE sm_id = ' + INTTOSTR(qrRatesExSM_ID.AsInteger) + ')');
  qrTemp.Active := True;
  Month1 := qrTemp.FieldByName('monat').AsInteger;
  Year1 := qrTemp.FieldByName('year').AsInteger;
  qrTemp.Active := False;

  // ������� �� ��������� ������� materialcard_temp ��������� ����������� � ��������
  try
    with qrTemp do
    begin

      SQL.Clear;
      SQL.Add('SELECT region_id FROM objcards WHERE obj_id = ' + INTTOSTR(IdObject));
      Active := True;
      if not Eof then
      begin
        PriceVAT := 'coast' + FieldByName('region_id').AsString + '_2';
        PriceNoVAT := 'coast' + FieldByName('region_id').AsString + '_1';
      end;
      Active := False;

      SQL.Clear;
      SQL.Text := 'SELECT DISTINCT TMat.material_id as "MatId", TMat.mat_code as "MatCode", ' +
        'TMatNorm.norm_ras as "MatNorm", units.unit_name as "MatUnit", ' +
        'TMat.unit_id as "UnitId", mat_name as "MatName", ' + PriceVAT + ' as "PriceVAT", ' + PriceNoVAT +
        ' as "PriceNoVAT" ' + 'FROM materialnorm as TMatNorm ' +
        'JOIN material as TMat ON TMat.material_id = TMatNorm.material_id ' +
        'LEFT JOIN units ON TMat.unit_id = units.unit_id ' + 'LEFT JOIN materialcoastg as TMatCoast ON ' +
        '(TMatCoast.material_id = TMatNorm.material_id) and (monat = ' + INTTOSTR(Month1) + ') and (year = ' +
        INTTOSTR(Year1) + ') WHERE (TMatNorm.normativ_id = ' + INTTOSTR(vRateId) + ') order by 1';
      Active := True;

      Filtered := False;
      Filter := 'MatCode LIKE ''�%''';
      Filtered := True;

      First;

      while not Eof do
      begin
        // ��������� �������� ���������� ��� ���������
        qrTemp1.Active := False;
        qrTemp1.SQL.Clear;
        qrTemp1.SQL.Add('SELECT GetTranspPers(:IdEstimate, :MatCode);');
        qrTemp1.ParamByName('IdEstimate').Value := qrRatesExSM_ID.AsInteger;
        qrTemp1.ParamByName('MatCode').Value := FieldByName('MatCode').AsString;
        qrTemp1.Active := True;
        PT := 0;
        if not qrTemp1.Eof then
          PT := qrTemp1.Fields[0].AsFloat;
        qrTemp1.Active := False;

        qrTemp1.SQL.Text := 'SELECT GetNewID(:IDType)';
        qrTemp1.ParamByName('IDType').Value := C_ID_SMMAT;
        qrTemp1.Active := True;
        MaxMId := 0;
        if not qrTemp1.Eof then
          MaxMId := qrTemp1.Fields[0].AsInteger;
        qrTemp1.Active := False;

        if MaxMId > 0 then
        begin
          qrTemp1.SQL.Text := 'Insert into materialcard_temp (ID, ID_CARD_RATE, MAT_ID, ' +
            'MAT_CODE, MAT_NAME, MAT_NORMA, MAT_UNIT, COAST_NO_NDS, COAST_NDS, ' +
            'PROC_TRANSP) values (:ID, :ID_CARD_RATE, :MAT_ID, ' +
            ':MAT_CODE, :MAT_NAME, :MAT_NORMA, :MAT_UNIT, :COAST_NO_NDS, ' + ':COAST_NDS, :PROC_TRANSP)';
          qrTemp1.ParamByName('ID').Value := MaxMId;
          qrTemp1.ParamByName('ID_CARD_RATE').Value := vMaxIdRate;
          qrTemp1.ParamByName('MAT_ID').Value := FieldByName('MatId').AsInteger;
          qrTemp1.ParamByName('MAT_CODE').Value := FieldByName('MatCode').AsString;
          qrTemp1.ParamByName('MAT_NAME').Value := FieldByName('MatName').AsString;
          vNormRas := MyStrToFloatDef(FieldByName('MatNorm').AsString, 0);
          qrTemp1.ParamByName('MAT_NORMA').Value := vNormRas;
          qrTemp1.ParamByName('MAT_UNIT').Value := FieldByName('MatUnit').AsString;
          qrTemp1.ParamByName('COAST_NO_NDS').Value := FieldByName('PriceNoVAT').AsExtended;
          qrTemp1.ParamByName('COAST_NDS').Value := FieldByName('PriceVAT').AsExtended;
          qrTemp1.ParamByName('PROC_TRANSP').AsFloat := PT;
          qrTemp1.ExecSQL;

          CheckNeedAutoRep(MaxMId, 2, FieldByName('MatCode').AsString);
        end;

        Next;
      end;

      Filtered := False;
      Filter := 'MatCode LIKE ''�%''';
      Filtered := True;

      First;

      while not Eof do
      begin
        qrTemp1.SQL.Text := 'SELECT GetNewID(:IDType)';
        qrTemp1.ParamByName('IDType').Value := C_ID_SMMAT;
        qrTemp1.Active := True;
        MaxMId := 0;
        if not qrTemp1.Eof then
          MaxMId := qrTemp1.Fields[0].AsInteger;
        qrTemp1.Active := False;

        if MaxMId > 0 then
        begin
          qrTemp1.SQL.Text := 'Insert into materialcard_temp (ID, ID_CARD_RATE, CONSIDERED, MAT_ID, ' +
            'MAT_CODE, MAT_NAME, MAT_NORMA, MAT_UNIT, COAST_NO_NDS, COAST_NDS, ' +
            'PROC_TRANSP) values (:ID, :ID_CARD_RATE, :CONSIDERED, :MAT_ID, ' +
            ':MAT_CODE, :MAT_NAME, :MAT_NORMA, :MAT_UNIT, :COAST_NO_NDS, ' + ':COAST_NDS, :PROC_TRANSP)';
          qrTemp1.ParamByName('ID').Value := MaxMId;
          qrTemp1.ParamByName('ID_CARD_RATE').Value := vMaxIdRate;
          qrTemp1.ParamByName('CONSIDERED').Value := 0;
          qrTemp1.ParamByName('MAT_ID').Value := FieldByName('MatId').AsInteger;
          qrTemp1.ParamByName('MAT_CODE').Value := FieldByName('MatCode').AsString;
          qrTemp1.ParamByName('MAT_NAME').Value := FieldByName('MatName').AsString;
          vNormRas := MyStrToFloatDef(FieldByName('MatNorm').AsString, 0);
          qrTemp1.ParamByName('MAT_NORMA').Value := vNormRas;
          qrTemp1.ParamByName('MAT_UNIT').Value := FieldByName('MatUnit').AsString;
          qrTemp1.ParamByName('COAST_NO_NDS').Value := FieldByName('PriceNoVAT').AsExtended;
          qrTemp1.ParamByName('COAST_NDS').Value := FieldByName('PriceVAT').AsExtended;
          qrTemp1.ParamByName('PROC_TRANSP').Value := 0;
          qrTemp1.ExecSQL;

          if MaxMId > 0 then
            CheckNeedAutoRep(MaxMId, 2, FieldByName('MatCode').AsString);
        end;
        Next;
      end;

      Filtered := False;
      Filter := '';

      Active := False;
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ��������� ���������� �� ��������� ������� �������� ������:' + sLineBreak +
        sLineBreak + e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ������� �� ��������� ������� mechanizmcard_temp ��������� ����������� � ��������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT mech.mechanizm_id as "MechId", mech.mech_code as "MechCode", ' +
        'mechnorm.norm_ras as "MechNorm", units.unit_name as "Unit", ' +
        'mech.mech_name as "MechName", mechcoast.coast1 as "CoastVAT", ' +
        'mechcoast.coast2 as "CoastNoVAT", mechcoast.zp1 as "SalaryVAT", ' +
        'mechcoast.zp2 as "SalaryNoVAT", IFNULL(mech.MECH_PH, 0) as "MECH_PH" ' +
        'FROM mechanizmnorm as mechnorm ' +
        'JOIN mechanizm as mech ON mechnorm.mechanizm_id = mech.mechanizm_id ' +
        'JOIN units ON mech.unit_id = units.unit_id ' + 'LEFT JOIN mechanizmcoastg as MechCoast ON ' +
        '(MechCoast.mechanizm_id = mechnorm.mechanizm_id) and  ' + '(monat = ' + INTTOSTR(Month1) +
        ') and (year = ' + INTTOSTR(Year1) + ') WHERE (mechnorm.normativ_id = ' + INTTOSTR(vRateId) +
        ') order by 1');

      Active := True;
      First;

      while not Eof do
      begin
        qrTemp1.SQL.Text := 'SELECT GetNewID(:IDType)';
        qrTemp1.ParamByName('IDType').Value := C_ID_SMMEC;
        qrTemp1.Active := True;
        MaxMId := 0;
        if not qrTemp1.Eof then
          MaxMId := qrTemp1.Fields[0].AsInteger;
        qrTemp1.Active := False;

        if MaxMId > 0 then
        begin
          qrTemp1.SQL.Text := 'Insert into mechanizmcard_temp (ID, ID_CARD_RATE, ' +
            'MECH_ID, MECH_CODE, MECH_NAME, MECH_NORMA, MECH_UNIT, COAST_NO_NDS, ' +
            'COAST_NDS, ZP_MACH_NO_NDS, ZP_MACH_NDS, NORMATIV) values (:ID, :ID_CARD_RATE, ' +
            ':MECH_ID, :MECH_CODE, :MECH_NAME, :MECH_NORMA, :MECH_UNIT, :COAST_NO_NDS, ' +
            ':COAST_NDS, :ZP_MACH_NO_NDS, :ZP_MACH_NDS, :NORMATIV)';
          qrTemp1.ParamByName('ID').Value := MaxMId;
          qrTemp1.ParamByName('ID_CARD_RATE').Value := vMaxIdRate;
          qrTemp1.ParamByName('MECH_ID').Value := FieldByName('MechId').AsInteger;
          qrTemp1.ParamByName('MECH_CODE').Value := FieldByName('MechCode').AsString;
          qrTemp1.ParamByName('MECH_NAME').Value := FieldByName('MechName').AsString;
          vNormRas := MyStrToFloatDef(FieldByName('MechNorm').AsString, 0);
          qrTemp1.ParamByName('MECH_NORMA').Value := vNormRas;
          qrTemp1.ParamByName('MECH_UNIT').Value := FieldByName('Unit').AsString;
          qrTemp1.ParamByName('COAST_NO_NDS').Value := FieldByName('CoastNoVAT').AsExtended;
          qrTemp1.ParamByName('COAST_NDS').Value := FieldByName('CoastVAT').AsExtended;
          qrTemp1.ParamByName('ZP_MACH_NO_NDS').Value := FieldByName('SalaryNoVAT').AsExtended;
          qrTemp1.ParamByName('ZP_MACH_NDS').Value := FieldByName('SalaryVAT').AsExtended;
          qrTemp1.ParamByName('NORMATIV').Value := FieldByName('MECH_PH').AsExtended;
          qrTemp1.ExecSQL;

          if MaxMId > 0 then
            CheckNeedAutoRep(MaxMId, 3, FieldByName('MechCode').AsString);
        end;

        Next;
      end;

      Active := False;
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ��������� ���������� �� ��������� ������� �������� ������:' + sLineBreak +
        sLineBreak + e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  if ((Pos('�18', AnsiLowerCase(NewRateCode)) > 0) and (not CheckE1820(10)) and FAutoAddE18) or
    ((Pos('�20', AnsiLowerCase(NewRateCode)) > 0) and (not CheckE1820(11)) and FAutoAddE20) then
  begin
    if (Pos('�18', AnsiLowerCase(NewRateCode)) > 0) then
      case MessageBox(0, PChar('�������� ���� � ����������� ��������� �� �18 � �����?'), CaptionForm,
        MB_ICONQUESTION + MB_OKCANCEL + mb_TaskModal) of
        mrOk:
          PMAddAdditionHeatingE18Click(PMAddAdditionHeatingE18);
        mrCancel:
          begin
            FAutoAddE18 := False;
            OutputDataToTable(True);
          end;
      end;

    if (Pos('�20', AnsiLowerCase(NewRateCode)) > 0) then
      case MessageBox(0, PChar('�������� ���� � ����������� ��������� �� �20 � �����?'), CaptionForm,
        MB_ICONQUESTION + MB_OKCANCEL + mb_TaskModal) of
        mrOk:
          PMAddAdditionHeatingE18Click(PMAddAdditionHeatingE20);
        mrCancel:
          begin
            FAutoAddE18 := False;
            OutputDataToTable(True);
          end;
      end;
  end
  else
    OutputDataToTable(True);

  (Self as TForm).Invalidate;
  // ���������� ���������� �� ����������� ��������
  ShowAutoRep;
end;

procedure TFormCalculationEstimate.PMAddTranspClick(Sender: TObject);
begin
  if not CheckCursorInRate then
    Exit;

  if GetTranspForm(qrRatesExSM_ID.AsInteger, -1, (Sender as TMenuItem).Tag, True) then
    OutputDataToTable(True);
end;

// � ����� ��������� �������� ������� ��� ��� ����� ���� ������� ��������� ����
function TFormCalculationEstimate.CheckE1820(AType: Integer): Boolean;
var
  RecNo, SmID: Integer;
begin
  RecNo := qrRatesEx.RecNo;
  SmID := qrRatesExSM_ID.AsInteger;
  Result := False;
  qrRatesEx.DisableControls;
  try
    qrRatesEx.First;
    while (not qrRatesEx.Eof) do
    begin
      if (qrRatesExID_TYPE_DATA.AsInteger = AType) and (qrRatesExSM_ID.AsInteger = SmID) then
      begin
        Result := True;
        Break;
      end;
      qrRatesEx.Next;
    end;
    qrRatesEx.RecNo := RecNo;
  finally
    qrRatesEx.EnableControls;
  end;
end;

procedure TFormCalculationEstimate.PMAddAdditionHeatingClick(Sender: TObject);
begin
  PMAddAdditionHeatingE18.Enabled := not CheckE1820(PMAddAdditionHeatingE18.Tag);
  PMAddAdditionHeatingE20.Enabled := not CheckE1820(PMAddAdditionHeatingE20.Tag);
end;

procedure TFormCalculationEstimate.PMAddAdditionHeatingE18Click(Sender: TObject);
var
  Iterator: Integer;
begin
  if not CheckCursorInRate then
    Exit;

  if (Sender as TComponent).Tag = 10 then
    Iterator := C_ET18ITER
  else
    Iterator := C_ET20ITER;

  qrTemp.Active := False;
  qrTemp.SQL.Text := 'INSERT INTO data_row_temp ' + '(ID, id_estimate, id_type_data, NUM_ROW) VALUE ' +
    '(GetNewID(:IDType), :IdEstimate, :SType, :NUM_ROW);';
  qrTemp.ParamByName('IDType').Value := C_ID_DATA;
  qrTemp.ParamByName('IdEstimate').Value := qrRatesExSM_ID.AsInteger;
  qrTemp.ParamByName('SType').Value := (Sender as TComponent).Tag;
  qrTemp.ParamByName('NUM_ROW').Value := Iterator;
  qrTemp.ExecSQL;

  OutputDataToTable(True);
end;

procedure TFormCalculationEstimate.PMAddDumpClick(Sender: TObject);
begin
  if GetDumpForm(qrRatesExSM_ID.AsInteger, -1, True) then
    OutputDataToTable(True);
end;

procedure TFormCalculationEstimate.PMAddRateOldClick(Sender: TObject);
begin
  AddRate((Sender as TMenuItem).Tag);
end;

procedure TFormCalculationEstimate.PMAddRatMatMechEquipOwnClick(Sender: TObject);
begin
  ShowFormAdditionData('1');
end;

procedure TFormCalculationEstimate.PMAddRatMatMechEquipRefClick(Sender: TObject);
begin
  ShowFormAdditionData('0');
end;

// �������� ����-���� �� �����
procedure TFormCalculationEstimate.PMDeleteClick(Sender: TObject);
begin
  if MessageBox(0, PChar('�� ������������� ������ ������� ' + qrRatesExOBJ_CODE.AsString + '?'), CaptionForm,
    MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
    Exit;

  if Act then
  begin
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL DeleteDataFromAct(:IdTypeData, :Id);');
      ParamByName('IdTypeData').Value := qrRatesExID_TYPE_DATA.AsInteger;
      ParamByName('Id').Value := qrRatesExID_TABLES.AsInteger;
      ExecSQL;
    end;
  end
  else
    case qrRatesExID_TYPE_DATA.AsInteger of
      1: // ��������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteRate(:id);');
            ParamByName('id').Value := qrRatesExID_TABLES.AsInteger;
            ExecSQL;
          end;
        except
          on e: Exception do
            MessageBox(0, PChar('��� �������� �������� �������� ������:' + sLineBreak + sLineBreak +
              e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      2: // ��������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteMaterial(:id, :CalcMode);');
            ParamByName('id').Value := qrRatesExID_TABLES.AsInteger;
            ParamByName('CalcMode').Value := G_CALCMODE;
            ExecSQL;
          end;

        except
          on e: Exception do
            MessageBox(0, PChar('��� �������� ��������� �������� ������:' + sLineBreak + sLineBreak +
              e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      3: // ��������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteMechanism(:id, :CalcMode);');
            ParamByName('id').Value := qrRatesExID_TABLES.AsInteger;
            ParamByName('CalcMode').Value := G_CALCMODE;
            ExecSQL;
          end;

        except
          on e: Exception do
            MessageBox(0, PChar('��� �������� ��������� �������� ������:' + sLineBreak + sLineBreak +
              e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      4: // ������������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteDevice(:id);');
            ParamByName('id').Value := qrRatesExID_TABLES.AsInteger;
            ExecSQL;
          end;

        except
          on e: Exception do
            MessageBox(0, PChar('��� �������� ������������ �������� ������:' + sLineBreak + sLineBreak +
              e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      5: // ������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteDump(:id);');
            ParamByName('id').Value := qrRatesExID_TABLES.AsInteger;
            ExecSQL;
          end;
        except
          on e: Exception do
            MessageBox(0, PChar('��� �������� ������ �������� ������:' + sLineBreak + sLineBreak + e.message),
              CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      6, 7, 8, 9: // ���������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteTransp(:id);');
            ParamByName('id').Value := qrRatesExID_TABLES.AsInteger;
            ExecSQL;
          end;
        except
          on e: Exception do
            MessageBox(0, PChar('��� �������� ���������� �������� ������:' + sLineBreak + sLineBreak +
              e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      10, 11: // ���� � �����������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('DELETE FROM data_row_temp WHERE (ID = ' +
              INTTOSTR(qrRatesExDATA_ESTIMATE_OR_ACT_ID.AsInteger) + ');');
            ExecSQL;
          end;
        except
          on e: Exception do
            MessageBox(0, PChar('��� �������� ���������� �������� ������:' + sLineBreak + sLineBreak +
              e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
    end;
  qrRatesEx.Prior;
  OutputDataToTable;
end;

procedure TFormCalculationEstimate.PMDevEditClick(Sender: TObject);
begin
  SetDevEditMode;
end;

procedure TFormCalculationEstimate.pmDevicesPopup(Sender: TObject);
begin
  PMCalcDevice.Visible := NDSEstimate;
  PMCalcDevice.Enabled := (dbgrdDevices.Columns[dbgrdDevices.Col - 1].FieldName = 'FCOAST_NDS');
end;

// ����� ����� ��� ������ � ����������
procedure TFormCalculationEstimate.PMDumpEditClick(Sender: TObject);
begin
  if qrRatesExID_TYPE_DATA.AsInteger = 5 then
    if GetDumpForm(qrRatesExSM_ID.AsInteger, qrDumpID.AsInteger, False) then
      OutputDataToTable;

  if qrRatesExID_TYPE_DATA.AsInteger in [6, 7, 8, 9] then
    if GetTranspForm(qrRatesExSM_ID.AsInteger, qrTranspID.AsInteger, qrRatesExID_TYPE_DATA.AsInteger, False)
    then
      OutputDataToTable;
end;

procedure TFormCalculationEstimate.PMEditClick(Sender: TObject);
begin
  // ������������� ������ ������ � ���������
  if qrRatesExID_TYPE_DATA.AsInteger in [5, 6, 7, 8, 9] then
    PMDumpEditClick(nil);
end;

procedure TFormCalculationEstimate.pmTableLeftPopup(Sender: TObject);
var
  mainType: Integer;
begin
  // ������ ������� ���������� �������� �� ������� ��������
  PMDelete.Visible := (qrRatesExID_TYPE_DATA.AsInteger > 0);
  PMAdd.Visible := CheckCursorInRate;
  PMEdit.Visible := (qrRatesExID_TYPE_DATA.AsInteger in [5, 6, 7, 8, 9]) and CheckCursorInRate;
  PMCopy.Enabled := (qrRatesExID_TYPE_DATA.AsInteger > 0);
  PMPaste.Enabled := ((qrRatesExID_TYPE_DATA.AsInteger > 0) or (qrRatesExID_TYPE_DATA.AsInteger = -4) or
    (qrRatesExID_TYPE_DATA.AsInteger = -3)) and ClipBoard.HasFormat(G_SMETADATA);

  PMCopy.Visible := not Act;
  PMPaste.Visible := not Act;

  // ��������� ��������� ������� ��� ������ ����� ������ ���������� �� ��������� �����
  // ��� ������� ���������� ���������
  qrTemp.SQL.Text := 'SELECT SM_TYPE FROM smetasourcedata WHERE SM_ID=:ID';
  qrTemp.ParamByName('ID').AsInteger := IdEstimate;
  qrTemp.Active := True;
  mainType := qrTemp.FieldByName('SM_TYPE').AsInteger;
  qrTemp.Active := False;
  mAddPTM.Visible := (mainType <> 3) and not Act;
  mAddLocal.Visible := (mainType = 2) and not Act;
  mDelEstimate.Visible := (qrRatesExID_TYPE_DATA.AsInteger < 0) and (qrRatesExID_TYPE_DATA.AsInteger <> -4);
  mEditEstimate.Visible := (qrRatesExID_TYPE_DATA.AsInteger < 0) and (qrRatesExID_TYPE_DATA.AsInteger <> -4);
  mBaseData.Visible := (qrRatesExID_TYPE_DATA.AsInteger < 0) and (qrRatesExID_TYPE_DATA.AsInteger <> -4);
  mBaseData.Caption := '�������� ������ - ' + qrRatesExOBJ_CODE.AsString;
end;

procedure TFormCalculationEstimate.EstimateBasicDataClick(Sender: TObject);
begin
  FormBasicData.ShowModal;
end;

procedure TFormCalculationEstimate.LabelObjectClick(Sender: TObject);
begin
  // ��������� ����� ��������
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormObjectsAndEstimates)) then
    FormObjectsAndEstimates := TFormObjectsAndEstimates.Create(Self);

  FormObjectsAndEstimates.Show;

  // ��������� ����� ��������
  FormWaiting.Close;
end;

procedure TFormCalculationEstimate.LabelEstimateClick(Sender: TObject);
begin
  // ���������� �������� � ������� ����
  if not Assigned(fTreeEstimate) then
    fTreeEstimate := TfTreeEstimate.Create(Self);
  fTreeEstimate.qrTreeEstimates.ParamByName('obj_id').Value := IdObject;
  CloseOpen(fTreeEstimate.qrTreeEstimates);
  fTreeEstimate.tvEstimates.FullExpand;
  fTreeEstimate.qrTreeEstimates.Locate('SM_ID', qrRatesExSM_ID.Value, []);
  fTreeEstimate.Show;
end;

procedure TFormCalculationEstimate.Label1Click(Sender: TObject);
begin
  if Act then
    Exit;
  FormBasicData.ShowForm(IdObject, IdEstimate);
  GetSourceData;
  GridRatesRowSellect;
  CloseOpen(qrRatesEx);
  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.LabelNameEstimateClick(Sender: TObject);
begin

end;

// �������� �������� ������� ����������
procedure TFormCalculationEstimate.FillingTableMaterials(const vIdCardRate, vIdMat: Integer);
var
  fType, fID, i: Integer;
begin
  if vIdMat > 0 then
  begin
    fType := 0;
    fID := vIdMat;
  end
  else
  begin
    fType := 1;
    fID := vIdCardRate;
  end;

  qrMaterial.DisableControls;
  FReCalcMat := True;
  qrMaterialNUM.ReadOnly := False;
  // �������� �������� ��� ���������� ������� ����������
  qrMaterial.Active := False;
  // ��������� materials_temp
  qrMaterial.SQL.Text := 'call GetMaterials(' + INTTOSTR(fType) + ',' + INTTOSTR(fID) + ',' +
    INTTOSTR(G_SHOWMODE) + ')';
  qrMaterial.ExecSQL;

  qrMaterial.Active := False;
  // ��������� materials_temp
  qrMaterial.SQL.Text := 'SELECT * FROM materials_temp ORDER BY SRTYPE, TITLE DESC, ID';
  qrMaterial.Active := True;
  i := 0;
  // ��������� �����, ������ ��������
  while not qrMaterial.Eof do
  begin
    if (qrMaterialTITLE.AsInteger > 0) then
    begin
      i := 0;
      qrMaterial.Next;
    end;
    inc(i);
    qrMaterial.Edit;
    qrMaterialNUM.AsInteger := i;
    qrMaterial.Post;

    qrMaterial.Next;
  end;
  qrMaterialNUM.ReadOnly := True;

  if ((qrRatesExID_RATE.AsInteger > 0) or (qrRatesExID_TYPE_DATA.AsInteger = 1)) then
    dbgrdMaterial.Columns[2].Visible := True
  else
    dbgrdMaterial.Columns[2].Visible := False;

  qrMaterial.First;
  if (qrMaterialTITLE.AsInteger > 0) then
    qrMaterial.Next;

  FReCalcMat := False;
  qrMaterial.EnableControls;
  qrMaterialAfterScroll(qrMaterial);
end;

procedure TFormCalculationEstimate.FillingTableDevises(const vIdDev: Integer);
begin
  qrDevices.Active := False;
  qrDevices.ParamByName('IDValue').AsInteger := vIdDev;
  qrDevices.Active := True;
end;

procedure TFormCalculationEstimate.FillingTableDump(const vIdDump: Integer);
begin
  qrDump.Active := False;
  qrDump.ParamByName('IDValue').AsInteger := vIdDump;
  qrDump.Active := True;
end;

procedure TFormCalculationEstimate.FillingTableTransp(const vIdTransp: Integer);
begin
  qrTransp.Active := False;
  qrTransp.ParamByName('IDValue').AsInteger := vIdTransp;
  qrTransp.Active := True;
end;

// StType = 0 - E18, StType = 1 - E20
procedure TFormCalculationEstimate.FillingTableStartup(const vStType: Integer);
var
  LikeText: string;
begin
  if vStType = 10 then
    LikeText := '�18'
  else
    LikeText := '�20';
  qrStartup.Active := False;
  qrStartup.SQL.Text := 'select RATE_CODE, RATE_CAPTION, RATE_COUNT, RATE_UNIT ' +
    'from data_row_temp as dm LEFT JOIN card_rate_temp as cr ' +
    'ON (dm.ID_TYPE_DATA = 1) AND (cr.ID = dm.ID_TABLES) ' + 'WHERE (cr.RATE_CODE LIKE "%' + LikeText +
    '%") and (dm.ID_ESTIMATE = ' + INTTOSTR(qrRatesExSM_ID.AsInteger) + ') and ' + '(dm.ID_ACT is NULL)';
  qrStartup.Active := True;
end;

procedure TFormCalculationEstimate.FillingTableMechanizm(const vIdCardRate, vIdMech: Integer);
var
  fType, fID, i: Integer;
begin
  if vIdMech > 0 then
  begin
    fType := 0;
    fID := vIdMech;
  end
  else
  begin
    fType := 1;
    fID := vIdCardRate;
  end;

  qrMechanizm.DisableControls;
  FReCalcMech := True;
  qrMechanizmNUM.ReadOnly := False;
  // �������� �������� ��� ���������� ������� ����������
  qrMechanizm.Active := False;
  // ��������� Mechanizms_temp
  qrMechanizm.SQL.Text := 'call GetMechanizms(' + INTTOSTR(fType) + ',' + INTTOSTR(fID) + ',' +
    INTTOSTR(G_SHOWMODE) + ')';
  qrMechanizm.ExecSQL;

  qrMechanizm.Active := False;
  // ��������� Mechanizms_temp
  qrMechanizm.SQL.Text := 'SELECT * FROM mechanizms_temp ORDER BY SRTYPE, TITLE DESC, ID';
  qrMechanizm.Active := True;
  i := 0;
  // ��������� �����, ������ ��������
  while not qrMechanizm.Eof do
  begin
    if (qrMechanizmTITLE.AsInteger > 0) then
    begin
      i := 0;
      qrMechanizm.Next;
    end;
    inc(i);
    qrMechanizm.Edit;
    qrMechanizmNUM.AsInteger := i;
    qrMechanizm.Post;

    qrMechanizm.Next;
  end;
  qrMechanizmNUM.ReadOnly := True;

  if ((qrRatesExID_RATE.AsInteger > 0) or (qrRatesExID_TYPE_DATA.AsInteger = 1)) then
    dbgrdMechanizm.Columns[2].Visible := True
  else
    dbgrdMechanizm.Columns[2].Visible := False;

  qrMechanizm.First;
  if (qrMechanizmTITLE.AsInteger > 0) then
    qrMechanizm.Next;

  FReCalcMech := False;
  qrMechanizm.EnableControls;
  qrMechanizmAfterScroll(qrMechanizm);
end;

procedure TFormCalculationEstimate.FillingTableDescription(const vIdNormativ: Integer);
begin
  with qrDescription do
  begin
    Active := False;
    ParamByName('IdNorm').Value := FastSelectSQLOne('SELECT RATE_ID FROM card_rate_temp WHERE ID=:1',
      VarArrayOf([vIdNormativ]));
    Active := True;
  end;
end;

function TFormCalculationEstimate.GetRankBuilders(const vIdNormativ: string): Double;
begin
  Result := 0;
  // ������� ������ �������-����������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT norma FROM normativwork WHERE normativ_id = ' + vIdNormativ + ' and work_id = 1;');
      Active := True;

      if FieldByName('norma').Value <> Null then
        Result := FieldByName('norma').AsFloat;
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ��������� �������� "������� ������" �������� ������:' + sLineBreak + sLineBreak
        + e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetWorkCostBuilders(const vIdNormativ: string): Double;
begin
  Result := 0;
  // ������� ����� �������-����������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT norma FROM normativwork WHERE normativ_id = ' + vIdNormativ + ' and work_id = 2;');
      Active := True;

      if FieldByName('norma').AsVariant <> Null then
        Result := FieldByName('norma').AsVariant;
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ��������� �������� "�� ����������" �������� ������:' + sLineBreak + sLineBreak
        + e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetWorkCostMachinists(const vIdNormativ: string): Double;
begin
  Result := 0;
  // ������� ����� ����������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT norma FROM normativwork WHERE normativ_id = ' + vIdNormativ + ' and work_id = 3;');
      Active := True;

      if FieldByName('norma').AsVariant <> Null then
        Result := FieldByName('norma').AsVariant;
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ��������� �������� "�� ����������" �������� ������:' + sLineBreak + sLineBreak
        + e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.CalculationSalary(const vIdNormativ: string): TTwoValues;
var
  TZ, TZ1: Double;
  Count: Double;
  MRCoef: Double;
  IdRegion: Integer;
  RateWorker: Double;
  TW: TTwoValues;
  StrQuery: string;
begin
  try
    // ���������� �� ����� �������
    Count := CountFromRate; // MyStrToFloat(Cells[2, Row]);

    TZ := GetWorkCostBuilders(vIdNormativ) * Count;
    // ������� ����� ������� * ����������
    TZ1 := GetWorkCostBuilders(vIdNormativ); // ������� ����� ������� * 1

    EditCategory.Text := MyFloatToStr(GetRankBuilders(vIdNormativ));

    // �������� ������������ �����������
    if EditCategory.Text <> '0' then
      with qrTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT coef FROM category WHERE value = "' + EditCategory.Text + '";');
        Active := True;
        if RecordCount > 0 then
          MRCoef := FieldByName('coef').AsVariant
        else
          MRCoef := 0;
      end
    else
      MRCoef := 0;

    // -----------------------------------------

    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT objstroj.obj_region as "IdRegion" FROM objcards, objstroj ' +
        'WHERE objcards.stroj_id = objstroj.stroj_id and obj_id = ' + INTTOSTR(IdObject) + ';');
      Active := True;

      // �������� ������ (1-�����, 2-����, 3-�����)
      IdRegion := FieldByName('IdRegion').AsVariant;

      // -----------------------------------------

      Active := False;
      SQL.Clear;

      if IdRegion = 3 then
        StrQuery := 'SELECT stavka_m_rab as "RateWorker" FROM stavka WHERE monat = ' + INTTOSTR(MonthEstimate)
          + ' and year = ' + INTTOSTR(YearEstimate) + ';'
      else
        StrQuery := 'SELECT stavka_rb_rab as "RateWorker" FROM stavka WHERE monat = ' +
          INTTOSTR(MonthEstimate) + ' and year = ' + INTTOSTR(YearEstimate) + ';';

      SQL.Add(StrQuery);
      Active := True;

      RateWorker := FieldByName('RateWorker').AsFloat; // R .AsVariant
    end;

    // -----------------------------------------

    TZ := TZ * MRCoef * RateWorker;
    // !!!!!!!!!! �������� �� ����������� ����������� !!!!!!!!!!
    TZ1 := TZ1 * MRCoef * RateWorker;
    // !!!!!!!!!! �������� �� ����������� ����������� !!!!!!!!!!

    // -----------------------------------------

    TW.ForOne := RoundTo(TZ1, PS.RoundTo * -1);
    TW.ForCount := RoundTo(TZ, PS.RoundTo * -1);

    Result := TW;
  except
    on e: Exception do
      MessageBox(0, PChar('������ ��� ���������� �' + '�, � ������� ����������:' + sLineBreak + sLineBreak +
        e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetNormMechanizm(const vIdNormativ, vIdMechanizm: string): Double;
begin
  Result := 0;
  // ����� ������� �� ���������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT norm_ras FROM mechanizmnorm WHERE normativ_id = ' + vIdNormativ + ' and mechanizm_id = '
        + vIdMechanizm + ';');
      Active := True;

      if FieldByName('norm_ras').AsVariant <> Null then
        Result := MyStrToFloat(FieldByName('norm_ras').AsString)
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ��������� ����� ������� �� ��������� �������� ������:' + sLineBreak +
        sLineBreak + e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetPriceMechanizm(const vIdNormativ, vIdMechanizm: string): Currency;
begin
  Result := 0;
  // ���� �� ���������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT norm_ras FROM mechanizmnorm WHERE normativ_id = ' + vIdNormativ + ' and mechanizm_id = '
        + vIdMechanizm + ';');
      Active := True;

      if FieldByName('norm_ras').AsVariant <> Null then
        Result := MyStrToFloat(FieldByName('norm_ras').AsString)
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ��������� ����� ������� �� ��������� �������� ������:' + sLineBreak +
        sLineBreak + e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.SettingVisibleRightTables;
begin
  // ��������� ����� �������������� � ����, ���� �� �������
  // ������� � ���, ��� ���������� �� �������� ������ ��� ������� �� ���
  if not MemoRight.ReadOnly then
    MemoRightExit(MemoRight);

  if Assigned(FCalculator) then
    if FCalculator.Visible then
      FCalculator.OnExit(FCalculator);

  SplitterRight1.Align := alBottom;
  SplitterRight2.Align := alBottom;

  SplitterRight1.Visible := False;
  SplitterRight2.Visible := False;

  dbgrdMaterial.Visible := False;
  dbgrdDevices.Visible := False;
  dbgrdMechanizm.Visible := False;
  dbgrdDescription.Visible := False;
  dbgrdDump.Visible := False;
  dbgrdTransp.Visible := False;
  dbgrdStartup.Visible := False;

  dbgrdMaterial.Align := alNone;
  dbgrdDevices.Align := alNone;
  dbgrdDescription.Align := alNone;
  dbgrdMechanizm.Align := alNone;
  dbgrdDump.Align := alNone;
  dbgrdTransp.Align := alNone;
  dbgrdStartup.Align := alNone;

  ImageSplitterRight1.Visible := False;
  ImageSplitterRight2.Visible := False;

  if VisibleRightTables = '1000000' then
  begin
    dbgrdMaterial.Align := alClient;
    dbgrdMaterial.Visible := True;
  end
  else if VisibleRightTables = '0100000' then
  begin
    dbgrdMechanizm.Align := alClient;
    dbgrdMechanizm.Visible := True;
  end
  else if VisibleRightTables = '0010000' then
  begin
    dbgrdDevices.Align := alClient;
    dbgrdDevices.Visible := True;
  end
  else if VisibleRightTables = '0001000' then
  begin
    dbgrdDescription.Align := alClient;
    dbgrdDescription.Visible := True;
    dbgrdDescription.Columns[0].Width := dbgrdDescription.Width - 50;
  end
  else if VisibleRightTables = '0000100' then
  begin
    dbgrdDump.Align := alClient;
    dbgrdDump.Visible := True;
  end
  else if VisibleRightTables = '0000010' then
  begin
    dbgrdTransp.Align := alClient;
    dbgrdTransp.Visible := True;
  end
  else if VisibleRightTables = '0000001' then
  begin
    dbgrdStartup.Align := alClient;
    dbgrdStartup.Visible := True;
  end
  else if VisibleRightTables = '1110000' then // �� ������������!!!
  begin
    dbgrdMaterial.Align := alTop;
    SplitterRight1.Align := alTop;

    dbgrdDevices.Align := alBottom;
    SplitterRight2.Align := alTop;
    SplitterRight2.Align := alBottom;

    dbgrdMechanizm.Align := alClient;

    dbgrdMaterial.Visible := True;
    dbgrdMechanizm.Visible := True;
    dbgrdDevices.Visible := True;

    SplitterRight1.Visible := True;
    SplitterRight2.Visible := True;

    ImageSplitterRight1.Visible := True;
    ImageSplitterRight2.Visible := True;
  end;

  PanelClientRightTablesResize(PanelClientRightTables);
end;

procedure TFormCalculationEstimate.GetMonthYearCalculationEstimate;
begin
  try
    with qrTemp do
    begin
      if Act then
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('select year(ca.`DATE`) as YEAR, MONTH(ca.`DATE`) AS MONTH FROM `card_acts` ca WHERE ca.`ID`='
          + INTTOSTR(IdAct) + ';');
        Active := True;

        MonthEstimate := FieldByName('MONTH').AsInteger;
        YearEstimate := FieldByName('YEAR').AsInteger;
        Active := False;
      end
      else
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT IFNULL(monat, 0) as "Month", IFNULL(year, 0) as "Year" ' +
          'FROM stavka WHERE stavka_id = (SELECT stavka_id From smetasourcedata ' + 'WHERE sm_id = ' +
          INTTOSTR(IdEstimate) + ');');
        Active := True;

        MonthEstimate := FieldByName('Month').AsInteger;
        YearEstimate := FieldByName('Year').AsInteger;
        Active := False;
      end;

    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ������� ������ � ���� �� ������� ������ �������� ������:' + sLineBreak +
        e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.GetSourceData;
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT IFNULL(monat,0) as monat, IFNULL(year,0) as year, nds FROM smetasourcedata ' +
        'left outer join stavka on stavka.stavka_id = smetasourcedata.stavka_id WHERE sm_id = :sm_id;');
      qrTemp.ParamByName('sm_id').Value := IdEstimate;
      Active := True;

      if not Eof then
      begin
        EditMonth.Text := FormatDateTime('mmmm yyyy ����.',
          StrToDate('01.' + qrTemp.FieldByName('monat').AsString + '.' + qrTemp.FieldByName('year')
          .AsString));

        if FieldByName('nds').Value then
        begin
          EditVAT.Text := 'c ���';
          NDSEstimate := True;
        end
        else
        begin
          EditVAT.Text := '��� ���';
          NDSEstimate := False;
        end;
      end;
      Active := False;
    end;
    // ������ �� ����, ������������ ��� ��� ��� ����������� ������� ��� ������ ������
    ChangeGrigNDSStyle(NDSEstimate);

  except
    on e: Exception do
      MessageBox(0, PChar('��� ��������� �������� ������ �������� ������:' + sLineBreak + sLineBreak +
        e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.ChangeGrigNDSStyle(aNDS: Boolean);
begin
  with dbgrdMaterial do
  begin
    // � ����������� �� ��� �������� ���� � ���������� ������ �������
    Columns[5].Visible := aNDS; // ���� ����
    Columns[7].Visible := aNDS; // ����� ����
    Columns[10].Visible := aNDS; // ������ ����
    Columns[12].Visible := aNDS; // ���
    Columns[13].Visible := aNDS; // ���� ����
    Columns[15].Visible := aNDS; // ����� ����
    Columns[17].Visible := aNDS; // ������ ����

    Columns[6].Visible := not aNDS;
    Columns[8].Visible := not aNDS;
    Columns[11].Visible := not aNDS;
    Columns[14].Visible := not aNDS;
    Columns[16].Visible := not aNDS;
    Columns[18].Visible := not aNDS;
  end;

  with dbgrdMechanizm do
  begin
    // � ����������� �� ��� �������� ���� � ���������� ������ �������
    Columns[4].Visible := False;

    Columns[6].Visible := aNDS;
    Columns[8].Visible := aNDS;
    Columns[10].Visible := aNDS;
    Columns[12].Visible := aNDS;
    Columns[15].Visible := aNDS;
    Columns[17].Visible := aNDS;
    Columns[19].Visible := aNDS;
    Columns[21].Visible := aNDS;

    Columns[7].Visible := not aNDS;
    Columns[9].Visible := not aNDS;
    Columns[11].Visible := not aNDS;
    Columns[13].Visible := not aNDS;
    Columns[16].Visible := not aNDS;
    Columns[18].Visible := not aNDS;
    Columns[20].Visible := not aNDS;
    Columns[22].Visible := not aNDS;
  end;

  with dbgrdDevices do
  begin
    Columns[2].Visible := False;

    // � ����������� �� ��� �������� ���� � ���������� ������ �������
    Columns[5].Visible := aNDS; // ���� ����
    Columns[7].Visible := aNDS; // ������
    Columns[9].Visible := aNDS; // ����� ����

    Columns[6].Visible := not aNDS;
    Columns[8].Visible := not aNDS;
    Columns[10].Visible := not aNDS;
  end;

  with dbgrdDump do
  begin
    // � ����������� �� ��� �������� ���� � ���������� ������ �������
    Columns[6].Visible := aNDS; // ���� ����
    Columns[8].Visible := aNDS; // ����� ����

    Columns[7].Visible := not aNDS;
    Columns[9].Visible := not aNDS;
  end;

  with dbgrdTransp do
  begin
    // � ����������� �� ��� �������� ���� � ���������� ������ �������
    Columns[7].Visible := aNDS; // ���� ����
    Columns[11].Visible := aNDS; // ����� ����

    Columns[8].Visible := not aNDS;
    Columns[12].Visible := not aNDS;
  end;
end;

procedure TFormCalculationEstimate.FillingWinterPrice(vNumber: string);
begin
  try
    if qrRatesExZNORMATIVS_ID.AsInteger <> 0 then
      with qrTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT CONCAT(num, " ", name) as "Name" ' +
          'FROM znormativs WHERE znormativs.ZNORMATIVS_ID=:ZNORMATIVS_ID LIMIT 1;');
        ParamByName('ZNORMATIVS_ID').AsInteger := qrRatesExZNORMATIVS_ID.AsInteger;
        Active := True;
        if VarIsNull(FieldByName('Name').Value) then
          EditWinterPrice.Text := '�� ������'
        else
          EditWinterPrice.Text := FieldByName('Name').AsString;
      end
    else
      with qrTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT znormativs.ZNORMATIVS_ID, num as "Number", name as "Name", coef as "Coef", coef_zp as "CoefZP", FN_NUM_TO_INT(s) as "From", FN_NUM_TO_INT(po) as "On" '
          + 'FROM znormativs, znormativs_detail, znormativs_value ' +
          'WHERE znormativs.ZNORMATIVS_ID=znormativs_detail.ZNORMATIVS_ID  ' +
          'AND znormativs.ZNORMATIVS_ID = znormativs_value.ZNORMATIVS_ID ' + 'AND znormativs.DEL_FLAG = 0 ' +
          'AND znormativs_value.ZNORMATIVS_ONDATE_ID = (' + '  SELECT znormativs_ondate.ID' +
          '    FROM znormativs_ondate' +
          '    WHERE `znormativs_ondate`.`onDate` <= (SELECT CONVERT(CONCAT(stavka.YEAR,"-",stavka.MONAT,"-01"), DATE) FROM stavka WHERE stavka.STAVKA_ID = (SELECT STAVKA_ID FROM smetasourcedata WHERE SM_ID='
          + qrRatesExSM_ID.AsString + '))' +
          '    AND `znormativs_ondate`.`DEL_FLAG` = 0 ORDER BY `znormativs_ondate`.`onDate` DESC LIMIT 1) AND FN_NUM_TO_INT("'
          + vNumber + '")<=FN_NUM_TO_INT(po) AND FN_NUM_TO_INT("' + vNumber +
          '")>=FN_NUM_TO_INT(s) AND REPLACE(SUBSTRING(s FROM 1 FOR 1), "E", "�")=REPLACE(SUBSTRING("' +
          vNumber + '" FROM 1 FOR 1), "E", "�") LIMIT 1' + ';');
        Active := True;
        First;
        if not Eof then
        begin
          EditWinterPrice.Text := FieldByName('Number').AsVariant + ' ' + FieldByName('Name').AsVariant;
          qrRatesExZNORMATIVS_ID.AsInteger := FieldByName('ZNORMATIVS_ID').AsInteger;
        end;
      end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ��������� �������� ������� ���������� �������� ������:' + sLineBreak +
        sLineBreak + e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.TestOnNoDataNew(ADataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(ADataSet) then
  begin
    PanelClientRight.Visible := False;
    PanelNoData.Visible := True;
  end
  else
  begin
    PanelClientRight.Visible := True;
    PanelNoData.Visible := False;
  end;
end;

procedure TFormCalculationEstimate.tmRateTimer(Sender: TObject);
var
  res: Variant;
begin
  tmRate.Enabled := False;

  Panel1.Visible := (qrRatesExID_TYPE_DATA.Value = 1);

  if Assigned(fTreeEstimate) then
    fTreeEstimate.qrTreeEstimates.Locate('SM_ID', qrRatesExSM_ID.Value, []);
  // ��������� ������ ��������, ���� � ����� ����������� ������ � qrRates

  // ��� ����������� �� ������, ��� ��������� �� qrRates
  // ��� ����� ������ �����������, ���-�� ��������� ��������� �������� �����������
  // �������� �������� �� ������ ������ ��������
  qrMaterial.Active := False;
  qrMechanizm.Active := False;
  qrDevices.Active := False;
  qrDump.Active := False;
  qrTransp.Active := False;
  qrStartup.Active := False;
  qrDescription.Active := False;
  ImageNoData.PopupMenu := nil;

  // �� ������ ������, ���-�� �������� ������
  if not qrRatesEx.Active then
    Exit;

  // �������� ������� �������� ���������� ���� �� �����
  dbgrdCalculations.Columns[13].Visible := qrRatesExAPPLY_WINTERPRISE_FLAG.AsInteger = 1;
  dbgrdCalculations.Columns[14].Visible := qrRatesExAPPLY_WINTERPRISE_FLAG.AsInteger = 1;
  LabelWinterPrice.Visible := qrRatesExAPPLY_WINTERPRISE_FLAG.AsInteger = 1;
  EditWinterPrice.Visible := qrRatesExAPPLY_WINTERPRISE_FLAG.AsInteger = 1;
  dbgrdCalculations.Columns[13].Width := 64;
  dbgrdCalculations.Columns[14].Width := 64;
  FixDBGridColumnsWidth(dbgrdCalculations);

  LabelCategory.Visible := qrRatesExID_TYPE_DATA.AsInteger = 1;
  EditCategory.Visible := qrRatesExID_TYPE_DATA.AsInteger = 1;
  edtRateActive.Visible := qrRatesExID_TYPE_DATA.AsInteger = 1;
  edtRateActiveDate.Visible := qrRatesExID_TYPE_DATA.AsInteger = 1;
  // ���� ��������
  if qrRatesExID_TYPE_DATA.AsInteger = 1 then
  begin
    // �������� ������ ��������
    if FastSelectSQLOne('SELECT NORM_ACTIVE FROM normativg, card_rate_temp ' +
      'WHERE card_rate_temp.ID=:0 and card_rate_temp.RATE_ID=normativg.NORMATIV_ID',
      VarArrayOf([qrRatesExID_TABLES.Value])) = 1 then
    begin
      edtRateActive.Text := '�����������';
      edtRateActive.Color := $0080FF80;
      res := FastSelectSQLOne('SELECT date_beginer FROM normativg, card_rate_temp ' +
        'WHERE card_rate_temp.ID=:0 and card_rate_temp.RATE_ID=normativg.NORMATIV_ID',
        VarArrayOf([qrRatesExID_TABLES.Value]));
      if VarIsNull(res) then
        edtRateActiveDate.Text := '�� �������'
      else
        edtRateActiveDate.Text := DateToStr(res);
    end
    else
    begin
      edtRateActive.Text := '�������������';
      edtRateActive.Color := clRed;
      res := FastSelectSQLOne('SELECT date_end FROM normativg, card_rate_temp ' +
        'WHERE card_rate_temp.ID=:0 and card_rate_temp.RATE_ID=normativg.NORMATIV_ID',
        VarArrayOf([qrRatesExID_TABLES.Value]));
      if VarIsNull(res) then
        edtRateActiveDate.Text := '�� �������'
      else
        edtRateActiveDate.Text := DateToStr(res);
    end;
  end
  else
  begin
    edtRateActive.Text := '';
    edtRateActive.Color := $00E1DFE0;
    edtRateActiveDate.Text := '';
  end;

  if qrRatesExID_TYPE_DATA.AsInteger = -4 then
  begin
    // � ������ ���������� ������ ������������� ���, � �� ����������
    qrRatesExOBJ_CODE.ReadOnly := False;
  end;

  // ��� ����� ����� � ����� �������
  if qrRatesExID_TYPE_DATA.AsInteger < 0 then
  begin
    qrRatesExOBJ_COUNT.ReadOnly := True;
    BottomTopMenuEnabled(False);
    TestOnNoDataNew(qrMaterial);
    Exit;
  end;

  // ����� ������������� ���-�� ��� ����� ������
  qrRatesExOBJ_COUNT.ReadOnly := False;
  qrRatesExOBJ_CODE.ReadOnly := True;

  // ��������� ������� ������
  GridRatesRowSellect;
end;

// ��������, ��� ������� �������� ������(���� ������ ������������ �������� ��� ������)
procedure TFormCalculationEstimate.TestOnNoData(SG: TStringGrid);
begin
  if SG.RowCount = 1 then
  begin
    PanelClientRight.Visible := False;
    PanelNoData.Visible := True;
  end
  else
  begin
    PanelClientRight.Visible := True;
    PanelNoData.Visible := False;
  end;
end;

function TFormCalculationEstimate.GetSalaryMachinist(const vIdMechanizm: Integer): Currency;
begin
  Result := 0;
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('Call GetSalaryMachinist(:IdObject, :IdMechanizm);');

      ParamByName('IdObject').Value := IdObject;
      ParamByName('IdMechanizm').Value := vIdMechanizm;

      Active := True;

      if FieldByName('Salary').AsVariant <> Null then
        Result := FieldByName('Salary').AsVariant;

      Active := False;
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ������� ��� ��������� �������� ������:' + sLineBreak + e.message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetCoastMechanizm(const vIdMechanizm: Integer): Currency;
begin
  // ���� ������������� (������, ������) ���������
  Result := 0;
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('Call GetCoastMechanism(:IdObject, :IdMechanizm);');

      ParamByName('IdObject').Value := IdObject;
      ParamByName('IdMechanizm').Value := vIdMechanizm;

      Active := True;

      if FieldByName('Coast').AsVariant <> Null then
        Result := FieldByName('Coast').AsVariant;

      Active := False;
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� ������� ����� ������ ��������� �������� ������:' + sLineBreak + e.message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

constructor TFormCalculationEstimate.Create(const isAct: Boolean);
begin
  Act := isAct;
  inherited Create(Application);
end;

procedure TFormCalculationEstimate.CreateTempTables;
var
  Str: string;
begin
  Str := 'CALL CreateTempTables(1);'; // ������ �����

  try
    with qrTemp do
    begin
      SQL.Clear;
      SQL.Add(Str);
      ExecSQL;
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� �������� ��������� ������ �������� ������:' + sLineBreak + sLineBreak +
        e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.OpenAllData;
begin
  GetMonthYearCalculationEstimate;
  GetSourceData; // ������� ����������� �� �������� ������ �����
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;

      if Act then
      begin
        SQL.Add('CALL OpenAllDataAct(:IdAct);');
        ParamByName('IdAct').Value := IdAct;
      end
      else
      begin
        SQL.Add('CALL OpenAllDataEstimate(:IdEstimate);');
        ParamByName('IdEstimate').Value := IdEstimate;
      end;

      try
        ExecSQL;
      except
        qrTemp.SQL.Text := 'SELECT @sql as QR;';
        qrTemp.Active := True;
        ShowMessage(qrTemp.FieldByName('QR').AsString);
      end;
      Active := False;
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('��� �������� ������ �������� ������:' + sLineBreak + sLineBreak + e.message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ���������� ������� ��������
  OutputDataToTable;

  if not qrOXROPR.Active then
    qrOXROPR.Active := True;
  if not qrTypeData.Active then
    qrTypeData.Active := True;
end;

// ���������� ������� ��������
procedure TFormCalculationEstimate.OutputDataToTable(ANewRow: Boolean = False);
var
  TmpSmID, RecNo: Integer;
  SortIDArray: TArray<string>;
  i: Integer;
begin
  // ����� ��������� ������ ����� �����
  if Act then
  begin
    qrRatesEx.ParamByName('EAID').Value := IdAct;
    qrRatesEx.ParamByName('vIsACT').Value := 1;
  end
  else
  begin
    qrRatesEx.ParamByName('EAID').Value := IdEstimate;
    qrRatesEx.ParamByName('vIsACT').Value := 0;
  end;

  qrRatesEx.DisableControls;
  try
    if ANewRow then
    begin
      RecNo := qrRatesEx.RecNo;
      TmpSmID := qrRatesExSM_ID.Value;
      while ((not qrRatesEx.Bof) and (TmpSmID = qrRatesExSM_ID.Value)) do
        qrRatesEx.Prior;
      if (TmpSmID <> qrRatesExSM_ID.Value) then
        qrRatesEx.Next;

      i := 0;
      SetLength(SortIDArray, i);
      repeat
        inc(i);
        SetLength(SortIDArray, i);
        SortIDArray[i - 1] := strngfldRatesExSORT_ID.AsString;
        qrRatesEx.Next;
      until not((not qrRatesEx.Eof) and (TmpSmID = qrRatesExSM_ID.Value));
      TArray.Sort<string>(SortIDArray, TComparer<string>.Default);
      qrRatesEx.RecNo := RecNo;
    end;

    CloseOpen(qrRatesEx);

    if ANewRow then
    begin
      TmpSmID := qrRatesExSM_ID.Value;
      while ((not qrRatesEx.Bof) and (TmpSmID = qrRatesExSM_ID.Value)) do
        qrRatesEx.Prior;
      if (TmpSmID <> qrRatesExSM_ID.Value) then
        qrRatesEx.Next;

      while (not qrRatesEx.Eof) and (TmpSmID = qrRatesExSM_ID.Value) and
        TArray.BinarySearch<string>(SortIDArray, strngfldRatesExSORT_ID.AsString, i,
        TComparer<string>.Default) do
        qrRatesEx.Next;
    end;

    grRatesEx.Col := 3;
  finally
    qrRatesEx.EnableControls;
  end;
  // ----------------------------------
  if CheckQrActiveEmpty(qrRatesEx) { and (qrRatesExID_TYPE_DATA.Value > 0) } then
    CloseOpen(qrCalculations)
  else
    qrCalculations.Active := False;
end;

procedure TFormCalculationEstimate.VisibleColumnsWinterPrice(Value: Boolean);
begin
  if Value then
  begin
    dbgrdCalculations.Columns[13].Width := WCWinterPrice;
    dbgrdCalculations.Columns[14].Width := WCSalaryWinterPrice;
  end
  else
  begin
    if dbgrdCalculations.Columns[13].Width > -1 then
      WCWinterPrice := dbgrdCalculations.Columns[13].Width;

    if dbgrdCalculations.Columns[14].Width > -1 then
      WCSalaryWinterPrice := dbgrdCalculations.Columns[14].Width;

    dbgrdCalculations.Columns[13].Width := -1;
    dbgrdCalculations.Columns[14].Width := -1;
  end;
end;

procedure TFormCalculationEstimate.ShowFormAdditionData(const vDataBase: Char);
var
  { FormTop, } FormLeft, { BorderTop, } BorderLeft: Integer;
begin
  if (Assigned(FormAdditionData)) then
  begin
    FormAdditionData.Show;
    Exit;
  end;
  DM.FDGUIxWaitCursor1.ScreenCursor := gcrHourGlass;
  try
    SendMessage(Application.MainForm.ClientHandle, WM_SETREDRAW, 0, 0);
    FormAdditionData := TFormAdditionData.Create(FormMain, vDataBase);
    FormAdditionData.WindowState := wsNormal;

    // ����������� ����
    WindowState := wsNormal;
    // ������ ����� � ����� ������� ����
    Left := 0;
    Top := 0;

    // ������������� ������� �����
    Width := FormMain.ClientWidth - 5;
    Height := FormMain.ClientHeight - (5 + 27); // + 27 - ������ ������ � ��������

    // ����� ����� � ������ ������� � ����������� 1 � 3
    PanelClientLeft.Width := FormMain.Width div 3;

    with FormAdditionData do
    begin
      // ���������� ������ �� ����� � ������� (������ ����� FormCalculationEstimate)
      // FormTop := PanelLocalEstimate.Top + PanelTopClient.Height;
      // ���������� ������ �� ������ ��������� ����� FormCalculationEstimate (������ ����� FormMain)
      // BorderTop := FormCalculationEstimate.Top;
      Top := FormCalculationEstimate.Top;
      // ���������� ����� �� ����� � ������� (������ ����� FormCalculationEstimate)
      FormLeft := SplitterCenter.Left + SplitterCenter.Width;
      // ���������� ����� �� ������ ��������� ����� FormCalculationEstimate (������ ����� FormMain)
      BorderLeft := FormCalculationEstimate.Left +
        (FormCalculationEstimate.Width - FormCalculationEstimate.ClientWidth) div 2;
      // Left := BorderLeft + FormLeft;
      Width := FormCalculationEstimate.ClientWidth - FormLeft +
        (FormCalculationEstimate.Width - FormCalculationEstimate.ClientWidth) div 2;
      // ����� + ������ ���������� ������� �����
      Height := GetSystemMetrics(SM_CYCAPTION) + FormCalculationEstimate.ClientHeight;
      // �������� ������ ������ ������ � ��������
      Height := Height - 27;
      Left := BorderLeft + FormLeft;
    end;
  finally
    SendMessage(Application.MainForm.ClientHandle, WM_SETREDRAW, 1, 0);
    RedrawWindow(Application.MainForm.ClientHandle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN or
      RDW_NOINTERNALPAINT);
    DM.FDGUIxWaitCursor1.ScreenCursor := gcrDefault;
  end;

  Application.ProcessMessages;
end;

procedure TFormCalculationEstimate.AddCoefToRate(coef_id: Integer);
// ���������� �����. � �������
var
  X: Word;
  TempBookmark: TBookMark;
begin
  grRatesEx.DataSource.DataSet.DisableControls;
  with grRatesEx.SelectedRows do
    if Count <> 0 then
    begin
      TempBookmark := grRatesEx.DataSource.DataSet.GetBookmark;
      for X := 0 to Count - 1 do
      begin
        if IndexOf(Items[X]) > -1 then
        begin
          grRatesEx.DataSource.DataSet.Bookmark := Items[X];
          qrTemp.Active := False;
          qrTemp.SQL.Text :=
            'INSERT INTO calculation_coef_temp(calculation_coef_id, id_act, id_estimate,id_type_data,id_owner,id_coef,COEF_NAME,OSN_ZP,EKSP_MACH,MAT_RES,WORK_PERS,WORK_MACH,OXROPR,PLANPRIB)'#13
            + 'SELECT GetNewID(:IDType), :id_act, :id_estimate, :id_type_data, :id_owner, coef_id,COEF_NAME,OSN_ZP,EKSP_MACH,MAT_RES,WORK_PERS,WORK_MACH,OXROPR,PLANPRIB'#13
            + 'FROM coef WHERE coef.coef_id=:coef_id';
          qrTemp.ParamByName('IDType').Value := C_ID_SMCOEF;
          qrTemp.ParamByName('id_estimate').AsInteger := qrRatesExSM_ID.Value;
          qrTemp.ParamByName('id_owner').AsInteger := qrRatesExID_TABLES.AsInteger;
          qrTemp.ParamByName('id_type_data').AsInteger := qrRatesExID_TYPE_DATA.AsInteger;
          qrTemp.ParamByName('coef_id').AsInteger := coef_id;
          if Act then
            qrTemp.ParamByName('id_act').AsInteger := IdAct
          else
            qrTemp.ParamByName('id_act').Value := Null;
          qrTemp.ExecSQL;
        end;
      end;
    end;
  grRatesEx.DataSource.DataSet.GotoBookmark(TempBookmark);
  grRatesEx.DataSource.DataSet.FreeBookmark(TempBookmark);
  grRatesEx.DataSource.DataSet.EnableControls;
  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.AddDevice(const vEquipId: Integer);
// ���������� ������������ � �����
begin
  try
    if not CheckCursorInRate then
      Exit;

    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddDevice(:IdEstimate, :IdDev, 0, 0);');
      ParamByName('IdEstimate').Value := qrRatesExSM_ID.AsInteger;
      ParamByName('IdDev').Value := vEquipId;
      ExecSQL;
    end;

    OutputDataToTable(True);
  except
    on e: Exception do
      MessageBox(0, PChar('��� ���������� ������������ �������� ������:' + sLineBreak + sLineBreak +
        e.message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ���������� ��������� � �����
procedure TFormCalculationEstimate.AddMaterial(const vMatId: Integer);
begin
  try
    if not CheckCursorInRate then
      Exit;

    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddMaterial(:IdEstimate, :IdMat, 0, 0, :CALCMODE);');
      ParamByName('IdEstimate').Value := qrRatesExSM_ID.AsInteger;
      ParamByName('IdMat').Value := vMatId;
      ParamByName('CALCMODE').Value := G_CALCMODE;
      ExecSQL;
    end;

    OutputDataToTable(True);
  except
    on e: Exception do
      MessageBox(0, PChar('��� ���������� ��������� �������� ������:' + sLineBreak + sLineBreak + e.message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ���������� ��������� � �����
procedure TFormCalculationEstimate.AddMechanizm(const vMechId: Integer);
begin
  try
    if not CheckCursorInRate then
      Exit;

    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddMechanizm(:IdEstimate, :IdMech, 0, 0, :CALCMODE);');
      ParamByName('IdEstimate').Value := qrRatesExSM_ID.AsInteger;
      ParamByName('IdMech').Value := vMechId;
      ParamByName('CALCMODE').Value := G_CALCMODE;
      ExecSQL;
    end;

    OutputDataToTable(True);
  except
    on e: Exception do
      MessageBox(0, PChar('��� ���������� ��������� �������� ������:' + sLineBreak + sLineBreak + e.message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.dbgrdDescription1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with dbgrdDescription.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;
    if gdFocused in State then // ������ � ������
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    if Assigned(TMyDBGrid(dbgrdDescription).DataLink) and
      (dbgrdDescription.Row = TMyDBGrid(dbgrdDescription).DataLink.ActiveRecord + 1) and
      (dbgrdDescription = FLastEntegGrd) then
    begin
      Font.Style := Font.Style + [fsbold];
    end;

    FillRect(Rect);
    TextOut(Rect.Left + 2, Rect.Top + 2, Column.Field.AsString);
  end;
end;

procedure TFormCalculationEstimate.dbgrdDevicesDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with (Sender as TJvDBGrid).Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    // ��������� ���� ��� (��� �������)
    if Column.Index = 1 then
      Brush.Color := $00F0F0FF;

    // ��������� ����� ���������
    if (Sender as TJvDBGrid).Name = 'dbgrdTransp' then
    begin
      if Column.Index in [11, 12] then
        Brush.Color := $00FBFEBC;
    end
    else if Column.Index in [9, 10] then
      Brush.Color := $00FBFEBC;

    if Assigned(TMyDBGrid(Sender).DataLink) and
      ((Sender as TJvDBGrid).Row = TMyDBGrid(Sender).DataLink.ActiveRecord + 1) and
      (TJvDBGrid(Sender) = FLastEntegGrd) then
    begin
      Font.Style := Font.Style + [fsbold];
      // ��� ���� �������� ��� �������������� �������������� ����������
      if not Column.ReadOnly then
        Brush.Color := $00AFFEFC
    end;

    if (gdFocused in State) or // ������ � ������
      (FCalculator.Visible and (gdSelected in State)) // ��� �� �� ������� �����������
    then
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    FillRect(Rect);
    if Column.Alignment = taRightJustify then
      TextOut(Rect.Right - 2 - TextWidth(Column.Field.AsString), Rect.Top + 2, Column.Field.AsString)
    else
      TextOut(Rect.Left + 2, Rect.Top + 2, Column.Field.AsString);
  end;
end;

procedure TFormCalculationEstimate.dbgrdDevicesExit(Sender: TObject);
begin
  if not Assigned(FormCalculationEstimate.ActiveControl) or
    (FormCalculationEstimate.ActiveControl.Name <> 'MemoRight') then
    SetDevNoEditMode;
end;

procedure TFormCalculationEstimate.dbgrdDevicesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // 45 - Insert
  if (Key = 45) then
    PMDevEditClick(Sender);
end;

procedure TFormCalculationEstimate.dbgrdDumpKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 45) then
    PMDumpEditClick(Sender);
end;

procedure TFormCalculationEstimate.dbgrdMaterialDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Str: string;
begin
  // ������� ������� ����� ����� ��� ������ ���������
  with dbgrdMaterial.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    // ��������� ���� ��� (��� �������)
    if Column.Index = 1 then
      Brush.Color := $00F0F0FF;

    // ��������� ����� ���������
    if Column.Index in [7, 8, 15, 16] then
    begin
      // �� ��������� ������� ������������ � ������� �������������� ���������
      // ������ �����
      if (Column.Index in [7, 8]) then
        if (qrMaterialFPRICE_NO_NDS.Value > 0) then
          Brush.Color := $00DDDDDD
        else
          Brush.Color := $00FBFEBC;

      if (Column.Index in [15, 16]) then
        if (qrMaterialFPRICE_NO_NDS.Value > 0) then
          Brush.Color := $00FBFEBC
        else
          Brush.Color := $00DDDDDD;
    end;

    // ��������� ������� ������ ��������  �����, ���� � %������
    if (Column.Index in [2, 5, 6, 9]) and (Column.Field.Value = 0) then
    begin
      Brush.Color := $008080FF;
    end;

    if Assigned(TMyDBGrid(dbgrdMaterial).DataLink) and
      (dbgrdMaterial.Row = TMyDBGrid(dbgrdMaterial).DataLink.ActiveRecord + 1) and
      (dbgrdMaterial = FLastEntegGrd) then
    begin
      Font.Style := Font.Style + [fsbold];
      // ��� ���� �������� ��� �������������� �������������� ����������
      if not Column.ReadOnly then
        Brush.Color := $00AFFEFC;
    end;

    // ����������� ��������� �� ������� ���������
    if (qrMaterialFROM_RATE.Value = 1) and ((qrRatesExID_RATE.Value > 0) or (qrRatesExID_TYPE_DATA.Value = 1))
    then
    begin
      Font.Style := Font.Style + [fsStrikeOut];
      Brush.Color := $00DDDDDD;
    end;

    // ������������ ���������� ��������
    if (qrMaterialREPLACED.Value = 1) then
    begin
      Brush.Color := $00DDDDDD;
    end;

    // ������������ ��������� ��������
    if (qrMaterialDELETED.Value = 1) then
    begin
      Brush.Color := $008080FF;
    end;

    // ��������� ����������� ��������� (��������� �-���)
    if (FIdReplasedMat > 0) and (qrMaterialID.Value = FIdReplasedMat) and (dbgrdMaterial = FLastEntegGrd) then
      Font.Style := Font.Style + [fsbold];

    // ���������� ������� ��� ��������� ����������� ��������� � ������ �������,
    // ��� ��������� ��� � �����
    if (qrRatesExID_RATE.Value > 0) and (qrRatesExID_TYPE_DATA.Value = 2) and
      (qrRatesExID_TABLES.Value = qrMaterialID.Value) and (grRatesEx = FLastEntegGrd) then
      Font.Style := Font.Style + [fsbold];

    // ��������� ������������� ���������
    if (FIdReplasingMat > 0) and (FIdReplasingMat = qrMaterialID_REPLACED.Value) and
      (dbgrdMaterial = FLastEntegGrd) then
      Font.Style := Font.Style + [fsbold];

    Str := '';
    // ��������� ����� �������� �������
    if qrMaterialTITLE.AsInteger > 0 then
    begin
      Brush.Color := clNavy;
      Font.Color := clWhite;
      Font.Style := Font.Style + [fsbold];
      if Column.Index = 1 then
        if Assigned(Column.Field) then
          Str := Column.Field.AsString;
    end
    else
    begin
      if Assigned(Column.Field) then
        Str := Column.Field.AsString;
    end;

    // �� ���������� ���-�� � ����� ��� ���������� ��� ���������
    if ((qrMaterialFROM_RATE.Value = 1) and ((qrRatesExID_RATE.Value > 0) or (qrRatesExID_TYPE_DATA.Value = 1)
      )) or (qrMaterialREPLACED.Value = 1) or (qrMaterialDELETED.Value = 1) then
    begin
      if Column.Index in [4, 8, 9, 10, 11, 15, 16, 17, 18] then
        Str := '';
    end;

    if (gdFocused in State) or // ������ � ������
      (FCalculator.Visible and (gdSelected in State)) // ��� �� �� ������� �����������
    then
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    // ���������� ������������ ���������
    if qrMaterialADDED.Value = 1 then
      Font.Color := clBlue;

    if qrMaterialID_REPLACED.Value > 0 then
      Font.Style := Font.Style + [fsItalic];

    FillRect(Rect);
    if Column.Alignment = taRightJustify then
      TextOut(Rect.Right - 2 - TextWidth(Str), Rect.Top + 2, Str)
    else
      TextOut(Rect.Left + 2, Rect.Top + 2, Str);
  end;
end;

procedure TFormCalculationEstimate.dbgrdMaterialExit(Sender: TObject);
begin
  if not Assigned(FormCalculationEstimate.ActiveControl) or
    (FormCalculationEstimate.ActiveControl.Name <> 'MemoRight') then
    SetMatNoEditMode;
end;

procedure TFormCalculationEstimate.dbgrdMaterialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // 45 - Insert
  // ������� ���������� ������� � PopupMenuMaterialsPopup
  if (Key = 45) and ((not CheckMatReadOnly) and (qrMaterialTITLE.AsInteger = 0)) then
    SetMatEditMode;
end;

procedure TFormCalculationEstimate.dbgrdMechanizmDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Str: string;
begin
  with dbgrdMechanizm.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    // ��������� ���� ��� (��� �������)
    if Column.Index = 1 then
      Brush.Color := $00F0F0FF;

    // ��������� ����� ���������
    if Column.Index in [8, 9, 12, 13, 17, 18, 21, 22] then
    begin
      // �� ��������� ������� ������������ � ������� �������������� ���������
      // ������ �����
      if (Column.Index in [8, 9]) then
        if (qrMechanizmFPRICE_NO_NDS.Value > 0) then
          Brush.Color := $00DDDDDD
        else
          Brush.Color := $00FBFEBC;

      if (Column.Index in [17, 18]) then
        if (qrMechanizmFPRICE_NO_NDS.Value > 0) then
          Brush.Color := $00FBFEBC
        else
          Brush.Color := $00DDDDDD;

      if (Column.Index in [12, 13]) then
        if (qrMechanizmFZPPRICE_NO_NDS.Value > 0) then
          Brush.Color := $00DDDDDD
        else
          Brush.Color := $00FBFEBC;

      if (Column.Index in [21, 22]) then
        if (qrMechanizmFZPPRICE_NO_NDS.Value > 0) then
          Brush.Color := $00FBFEBC
        else
          Brush.Color := $00DDDDDD;
    end;

    // ��������� ������� ������ ��������
    if (Column.Index in [2, 6, 7]) and (Column.Field.Value = 0) then
    begin
      Brush.Color := $008080FF;
    end;

    if Assigned(TMyDBGrid(dbgrdMechanizm).DataLink) and
      (dbgrdMechanizm.Row = TMyDBGrid(dbgrdMechanizm).DataLink.ActiveRecord + 1) and
      (dbgrdMechanizm = FLastEntegGrd) then
    begin
      Font.Style := Font.Style + [fsbold];
      // ��� ���� �������� ��� �������������� �������������� ����������
      if not Column.ReadOnly then
        Brush.Color := $00AFFEFC
    end;

    // ����������� ��������� �� ������� ���������
    if (qrMechanizmFROM_RATE.Value = 1) and ((qrRatesExID_RATE.Value > 0) or (qrRatesExID_TYPE_DATA.Value = 1))
    then
    begin
      Font.Style := Font.Style + [fsStrikeOut];
      Brush.Color := $00DDDDDD
    end;

    // ������������ ���������� ��������
    if (qrMechanizmREPLACED.Value = 1) then
    begin
      Brush.Color := $00DDDDDD;
    end;

    // ������������ ��������� ��������
    if (qrMechanizmDELETED.Value = 1) then
    begin
      Brush.Color := $008080FF;
    end;

    // ��������� ����������� ���������
    if (FIdReplasedMech > 0) and (qrMechanizmID.Value = FIdReplasedMech) and (dbgrdMechanizm = FLastEntegGrd)
    then
      Font.Style := Font.Style + [fsbold];

    // ��������� ������������� ���������
    if (FIdReplasingMech > 0) and (FIdReplasingMech = qrMechanizmID_REPLACED.Value) and
      (dbgrdMechanizm = FLastEntegGrd) then
      Font.Style := Font.Style + [fsbold];

    Str := '';
    // ��������� ����� �������� �������
    if qrMechanizmTITLE.Value > 0 then
    begin
      Brush.Color := clNavy;
      Font.Color := clWhite;
      Font.Style := Font.Style + [fsbold];
      if Column.Index = 1 then
        if Assigned(Column.Field) then
          Str := Column.Field.AsString;
    end
    else
    begin
      if Assigned(Column.Field) then
        Str := Column.Field.AsString;
    end;

    if ((qrMechanizmFROM_RATE.Value = 1) and ((qrRatesExID_RATE.Value > 0) or
      (qrRatesExID_TYPE_DATA.Value = 1))) or (qrMechanizmREPLACED.Value = 1) or (qrMechanizmDELETED.Value = 1)
    then
    begin
      if Column.Index in [5, 8, 9, 12, 13, 17, 18, 21, 22, 25] then
        Str := '';
    end;

    if (gdFocused in State) or // ������ � ������
      (FCalculator.Visible and (gdSelected in State)) // ��� �� �� ������� �����������
    then
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    // ���������� ������������ ���������
    if qrMechanizmADDED.Value = 1 then
      Font.Color := clBlue;

    if qrMechanizmID_REPLACED.Value > 0 then
      Font.Style := Font.Style + [fsItalic];

    FillRect(Rect);
    if Column.Alignment = taRightJustify then
      TextOut(Rect.Right - 2 - TextWidth(Str), Rect.Top + 2, Str)
    else
      TextOut(Rect.Left + 2, Rect.Top + 2, Str);
  end;
end;

procedure TFormCalculationEstimate.dbgrdMechanizmExit(Sender: TObject);
begin
  if not Assigned(FormCalculationEstimate.ActiveControl) or
    (FormCalculationEstimate.ActiveControl.Name <> 'MemoRight') then
    SetMechNoEditMode;
end;

procedure TFormCalculationEstimate.dbgrdMechanizmKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // 45 - Insert
  if (Key = 45) and (not CheckMechReadOnly) then
    SetMechEditMode;
end;

procedure TFormCalculationEstimate.dbgrdRates12DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with grRatesEx.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    if qrRatesExID_TYPE_DATA.AsInteger = -3 then
      Brush.Color := clSilver;
    if qrRatesExID_TYPE_DATA.AsInteger = -1 then
    begin
      Font.Style := Font.Style + [fsbold];
      Brush.Color := clSilver;
    end;
    if qrRatesExID_TYPE_DATA.AsInteger = -4 then
    begin
      Font.Color := PS.FontRows;
      Brush.Color := clInactiveBorder;
    end;

    // ������������ �������� � ������������ �����������/�����������
    if qrRatesExADDED_COUNT.Value > 0 then
      Font.Color := clBlue;

    if (grRatesEx.SelectedRows.CurrentRowSelected) and (grRatesEx.SelectedRows.Count > 1) then
      Font.Color := clRed;

    if Assigned(TMyDBGrid(grRatesEx).DataLink) and
      (grRatesEx.Row = TMyDBGrid(grRatesEx).DataLink.ActiveRecord + 1)
    // and (grRatesEx = LastEntegGrd) // �������������� ������ ������ ���� ���� �����
    then
    begin
      Font.Style := Font.Style + [fsbold];
    end;

    if gdFocused in State then // ������ � ������
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    // ��������� ����������� �� �������� ��������� � ����������� ���������
    // ��������� �� �������� ����� ��������� ��� �������
    if btnMaterials.Down and qrMaterial.Active and (dbgrdMaterial = FLastEntegGrd) then
    begin
      if (qrRatesExID_TABLES.AsInteger = qrMaterialID.AsInteger) and (qrRatesExID_TYPE_DATA.AsInteger = 2) and
        ((grRatesEx.Row <> TMyDBGrid(grRatesEx).DataLink.ActiveRecord + 1) or (qrRatesExID_RATE.Value > 0))
      then
        Font.Style := Font.Style + [fsbold];
    end;

    // ��������� ����������� ��� �����
    if btnMaterials.Down and qrMaterial.Active and (dbgrdMaterial = FLastEntegGrd) then
    begin
      if (qrRatesExID_REPLACED.AsInteger = qrMaterialID.AsInteger) and (qrRatesExID_TYPE_DATA.AsInteger = 2)
        and (qrMaterialCONSIDERED.AsInteger = 0) and
        ((grRatesEx.Row <> TMyDBGrid(grRatesEx).DataLink.ActiveRecord + 1) or (qrRatesExID_RATE.Value > 0))
      then
        Font.Style := Font.Style + [fsbold];
    end;

    // ��������� ����������� �� �������� ���������
    if btnMechanisms.Down and qrMechanizm.Active and (dbgrdMechanizm = FLastEntegGrd) then
    begin
      if (qrRatesExID_TABLES.AsInteger = qrMechanizmID.AsInteger) and (qrRatesExID_TYPE_DATA.AsInteger = 3)
        and (grRatesEx.Row <> TMyDBGrid(grRatesEx).DataLink.ActiveRecord + 1) then
        Font.Style := Font.Style + [fsbold];
    end;

    if qrRatesExREPLACED_COUNT.Value > 0 then
      Font.Style := Font.Style + [fsItalic];

    (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFormCalculationEstimate.dbgrdRatesEnter(Sender: TObject);
begin
  FLastEntegGrd := TJvDBGrid(Sender);

  grRatesEx.Repaint;
  dbgrdMechanizm.Repaint;
  dbgrdMaterial.Repaint;
  dbgrdDevices.Repaint;
  dbgrdDump.Repaint;
  dbgrdTransp.Repaint;
  dbgrdStartup.Repaint;
  dbgrdDescription.Repaint;
end;

procedure TFormCalculationEstimate.dbgrdRatesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // ������ �������
  if Key = 45 then
    Key := 0;

  grRatesEx.ReadOnly := PanelCalculationYesNo.Tag = 0;
end;

end.
