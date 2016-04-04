unit CalculationEstimate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, ToolWin,
  ExtCtrls, StdCtrls, Grids, DBGrids, Buttons, DB, Menus, ShellAPI, DateUtils, IniFiles, ImgList, Clipbrd,
  Math, pngimage, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBCtrls, CalculationEstimateSummaryCalculations,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, System.UITypes, System.Types, EditExpression, GlobsAndConst,
  FireDAC.UI.Intf, JvExComCtrls, JvDBTreeView, Generics.Collections, Tools, Generics.Defaults,
  fFrameCalculator, Data.FmtBcd, dmReportU, JvComponentBase, JvFormPlacement,
  SprController,
  fEstRowFinder;

type
  TAutoRepRec = record
    ID: Integer;
    DataType: Integer;
    Code: string;
    Name: string;
    MID: Integer;
    RTID: Integer;
  end;

  TAutoRepArray = array of TAutoRepRec;

  TSplitter = class(ExtCtrls.TSplitter)
  public
    procedure Paint(); override;
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
  TFormCalculationEstimate = class(TSmForm)

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
    PanelSSR: TPanel;
    PanelData: TPanel;
    lblSourceData: TLabel;
    lblDescr: TLabel;
    EditVAT: TEdit;
    EditMonth: TEdit;
    edtDescr: TEdit;
    pnlCalculationYesNo: TPanel;
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
    PopupMenuCoefSeparator1: TMenuItem;
    PopupMenuCoefCopy: TMenuItem;
    edtWinterPrice: TEdit;
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
    PanelClientRightTables: TPanel;
    ImageSplitterRight1: TImage;
    ImageSplitterRight2: TImage;
    SplitterRight1: TSplitter;
    SplitterRight2: TSplitter;
    ImageNoData: TImage;
    LabelNoData1: TLabel;
    LabelNoData2: TLabel;
    PMAddAdditionTransportationС310: TMenuItem;
    PMAddAdditionTransportationС311: TMenuItem;
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
    PMAddAdditionTransportationС310Cargo: TMenuItem;
    PMAddAdditionTransportationС310Trash: TMenuItem;
    PMAddAdditionTransportationС311Cargo: TMenuItem;
    PMAddAdditionTransportationС311Trash: TMenuItem;
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
    qrMechanizmCOAST_NO_NDS: TFMTBCDField;
    qrMechanizmCOAST_NDS: TFMTBCDField;
    qrMechanizmZP_MACH_NO_NDS: TFMTBCDField;
    qrMechanizmZP_MACH_NDS: TFMTBCDField;
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
    qrMaterialCOAST_NO_NDS: TFMTBCDField;
    qrMaterialCOAST_NDS: TFMTBCDField;
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
    pnlSummaryCalculations: TPanel;
    frSummaryCalculations: TfrCalculationEstimateSummaryCalculations;
    qrMaterialID: TIntegerField;
    qrDumpID: TIntegerField;
    qrTranspID: TIntegerField;
    qrDevicesID: TIntegerField;
    qrDumpDUMP_ID: TIntegerField;
    btnMaterials: TSpeedButton;
    btnMechanisms: TSpeedButton;
    btnEquipments: TSpeedButton;
    btnDescription: TSpeedButton;
    btnResMat: TSpeedButton;
    btnResMech: TSpeedButton;
    btnResDev: TSpeedButton;
    btnResZP: TSpeedButton;
    btnContractPrice: TSpeedButton;
    PMTransPerc: TMenuItem;
    PMTrPerc1: TMenuItem;
    PMTrPerc2: TMenuItem;
    PMTrPerc3: TMenuItem;
    PMTrPerc4: TMenuItem;
    PMTrPerc5: TMenuItem;
    PMTrPerc0: TMenuItem;
    btnCalcFact: TBitBtn;
    lblForeman: TLabel;
    lblForemanFIO: TLabel;
    qrRatesExCONS_REPLASED: TIntegerField;
    qrMaterialKOEFMR: TFloatField;
    PMInsertRow: TMenuItem;
    lbl1: TLabel;
    lblZone: TLabel;
    lblTypeWork: TLabel;
    lblWinterPrice: TLabel;
    pmLblObj: TPopupMenu;
    mN14: TMenuItem;
    mN15: TMenuItem;
    PMSetTransPerc1: TMenuItem;
    PMSetTransPerc2: TMenuItem;
    PMSetTransPerc3: TMenuItem;
    PMSetTransPerc4: TMenuItem;
    edtTypeWork: TEdit;
    edtZone: TEdit;
    qrRatesExCOEF_ORDERS: TIntegerField;
    qrMaterialFTRANSCOUNT: TFMTBCDField;
    PMUseTransPerc: TMenuItem;
    PMUseTransForThisCount: TMenuItem;
    mCopyToOwnBase: TMenuItem;
    qrRatesExNOM_ROW_MANUAL: TIntegerField;
    PMNumRow: TMenuItem;
    PMRenumCurSmet: TMenuItem;
    PMRenumFromCurRowToSM: TMenuItem;
    PMRenumAllList: TMenuItem;
    btnKC6J: TSpeedButton;
    PMRenumSelected: TMenuItem;
    PMRenumPTM: TMenuItem;
    qrMaterialBASE: TByteField;
    qrMechanizmBASE: TByteField;
    qrDevicesBASE: TByteField;
    PMMatManPrice: TMenuItem;
    PMMechManPrice: TMenuItem;
    PMDevManPrice: TMenuItem;
    FormStorage: TJvFormStorage;
    pmAddTransp: TPopupMenu;
    pmAddTranspCargo: TMenuItem;
    pmAddTranspTrash: TMenuItem;
    btnWinterPriceSelect: TBitBtn;
    dbmmoRight: TDBMemo;
    SplitterRightMemo: TSplitter;
    qrRatesExRecalc: TFDQuery;
    pmMarkRow: TMenuItem;
    qrRatesExMarkRow: TShortintField;
    PMMatSprCard: TMenuItem;
    qrMaterialMAT_TYPE: TIntegerField;
    PMMechSprCard: TMenuItem;
    PMDevSprCard: TMenuItem;
    pnlActSourceData: TPanel;
    lbl2: TLabel;
    edtActDate: TEdit;
    btnRS: TSpeedButton;
    qrDevicesFTRANSP_NDS: TFMTBCDField;
    qrDevicesFTRANSP_NO_NDS: TFMTBCDField;
    PMMatNormPrice: TMenuItem;
    PMMechNormPrice: TMenuItem;
    qrMaterialVFCOAST_NO_NDS: TFMTBCDField;
    qrMaterialVFCOAST_NDS: TFMTBCDField;
    qrMaterialVFPRICE_NO_NDS: TFMTBCDField;
    qrMaterialVFPRICE_NDS: TFMTBCDField;
    qrMaterialVFTRANSP_NO_NDS: TFMTBCDField;
    qrMaterialVFTRANSP_NDS: TFMTBCDField;
    qrMaterialVFTRANSCOUNT: TFMTBCDField;
    qrMaterialPROC_TRANSP: TFMTBCDField;
    qrMechanizmVFCOAST_NO_NDS: TFMTBCDField;
    qrMechanizmVFCOAST_NDS: TFMTBCDField;
    qrMechanizmVFPRICE_NO_NDS: TFMTBCDField;
    qrMechanizmVFPRICE_NDS: TFMTBCDField;
    qrMechanizmVFZP_MACH_NO_NDS: TFMTBCDField;
    qrMechanizmVFZP_MACH_NDS: TFMTBCDField;
    qrMechanizmVFZPPRICE_NO_NDS: TFMTBCDField;
    qrMechanizmVFZPPRICE_NDS: TFMTBCDField;
    qrDevicesVFCOAST_NO_NDS: TFMTBCDField;
    qrDevicesVFCOAST_NDS: TFMTBCDField;
    qrDevicesVFPRICE_NO_NDS: TFMTBCDField;
    qrDevicesVFPRICE_NDS: TFMTBCDField;
    qrDevicesVFTRANSP_NO_NDS: TFMTBCDField;
    qrDevicesVFTRANSP_NDS: TFMTBCDField;
    pmFindRowInEstim: TMenuItem;
    N15: TMenuItem;
    pmCopyFromSM: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

    procedure SpeedButtonLocalEstimateClick(Sender: TObject);
    procedure SpeedButtonSummaryCalculationClick(Sender: TObject);
    procedure SpeedButtonSSRClick(Sender: TObject);
    procedure pnlCalculationYesNoClick(Sender: TObject);
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

    // Пунткты выпадающего меню в нижней таблице
    procedure PopupMenuCoefAddSetClick(Sender: TObject);
    procedure PopupMenuCoefDeleteSetClick(Sender: TObject);

    // Верхние правые кнопки
    procedure btnDescriptionClick(Sender: TObject);
    procedure btnMaterialsClick(Sender: TObject);
    procedure btnMechanismsClick(Sender: TObject);

    // Заполнаяет таблицы справа исходя из выбранной строки в таблице расценок
    procedure GridRatesRowSellect;
    // Открытие нужных датасетов для выбранной строки в таблице расценок
    procedure GridRatesRowLoad;
    // Открытие датасетов для таблиц справа
    procedure FillingTableMaterials(const vIdCardRate, vIdMat: Integer);
    procedure FillingTableMechanizm(const vIdCardRate, vIdMech: Integer);
    procedure FillingTableDevises(const vIdDev: Integer);
    procedure FillingTableDump(const vIdDump: Integer);
    procedure FillingTableTransp(const vIdTransp: Integer);
    procedure FillingTableStartup(const vStType: Integer);
    procedure FillingTableDescription(const vIdNormativ: Integer);

    // Средний разряд рабочих-строителей
    function GetRankBuilders(const vIdNormativ: string): Double;

    // Разраты труда рабочих-строителей
    function GetWorkCostBuilders(const vIdNormativ: string): Double;

    // Затраты труда машинистов
    function GetWorkCostMachinists(const vIdNormativ: string): Double;

    // Расчёт ЗП (заработной платы)
    function CalculationSalary(const vIdNormativ: string): TTwoValues; // +++

    procedure EstimateBasicDataClick(Sender: TObject);
    procedure LabelObjectClick(Sender: TObject);
    procedure LabelEstimateClick(Sender: TObject);
    procedure lblSourceDataClick(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure PanelTopMenuResize(Sender: TObject);
    procedure SettingVisibleRightTables;
    procedure PanelClientRightTablesResize(Sender: TObject);
    procedure btnEquipmentsClick(Sender: TObject);
    procedure SpeedButtonModeTablesClick(Sender: TObject);
    procedure GetMonthYearCalculationEstimate;
    procedure GetSourceData;

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

    procedure OutputDataToTable(ANewRow: Boolean = False); // Заполнение таблицы расценок

    procedure AddRate(const ARateId: Integer);
    procedure AddMaterial(AMatId, AManPriceID: Integer; APriceDate: TDateTime; ASprRecord: TSprRecord);
    procedure AddMechanizm(AMechId, AManPriceID: Integer; APriceDate: TDateTime; ASprRecord: TSprRecord);
    procedure AddDevice(AEquipId, AManPriceID: Integer; APriceDate: TDateTime; ASprRecord: TSprRecord);

    procedure PMMechFromRatesClick(Sender: TObject);
    procedure dbgrdRates12DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure qrRatesExAfterScroll(DataSet: TDataSet);
    procedure qrRatesExCOUNTChange(Sender: TField);
    procedure dbgrdDescription1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure qrMechanizmBeforeInsert(DataSet: TDataSet);
    procedure qrMechanizmAfterScroll(DataSet: TDataSet);
    procedure qrMechanizmCalcFields(DataSet: TDataSet);
    procedure dbgrdMechanizmDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure qrMechanizmBeforeScroll(DataSet: TDataSet);
    procedure MechRowChange(Sender: TField);
    procedure MatRowChange(Sender: TField);
    procedure pmMechanizmsPopup(Sender: TObject);
    procedure qrMaterialBeforeScroll(DataSet: TDataSet);
    procedure qrMaterialAfterScroll(DataSet: TDataSet);
    procedure dbgrdMaterialDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure PMMatMechEditClick(Sender: TObject);
    procedure dbgrdDevicesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure qrDevicesBeforeScroll(DataSet: TDataSet);
    procedure PMDevEditClick(Sender: TObject);
    procedure DevRowChange(Sender: TField);
    procedure FormResize(Sender: TObject);
    procedure PMAddDumpClick(Sender: TObject);
    procedure btnDumpClick(Sender: TObject);
    procedure PMDumpEditClick(Sender: TObject);
    procedure PMAddTranspClick(Sender: TObject);
    procedure btnTranspClick(Sender: TObject);
    procedure btnStartupClick(Sender: TObject);
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
    procedure dbgrdEnter(Sender: TObject);
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
    procedure qrRatesExCalcFields(DataSet: TDataSet);
    procedure qrRatesExAfterOpen(DataSet: TDataSet);
    procedure PMAddRateOldClick(Sender: TObject);
    procedure PMRateRefClick(Sender: TObject);
    procedure PMCalcMatClick(Sender: TObject);
    procedure PMCalcMechClick(Sender: TObject);
    procedure PMCalcDeviceClick(Sender: TObject);
    procedure pmDevicesPopup(Sender: TObject);
    procedure PMMechAutoRepClick(Sender: TObject);
    procedure btnResMatClick(Sender: TObject);
    procedure PMTrPerc0Click(Sender: TObject);
    procedure PMTransPercClick(Sender: TObject);
    procedure btnCalcFactClick(Sender: TObject);
    procedure lblForemanClick(Sender: TObject);
    procedure PMInsertRowClick(Sender: TObject);
    procedure PopupMenuCoefOrdersClick(Sender: TObject);
    procedure qrRatesExBeforeScroll(DataSet: TDataSet);
    procedure PMSetTransPercClick(Sender: TObject);
    procedure grRatesExExit(Sender: TObject);
    procedure qrCalculationsAfterOpen(DataSet: TDataSet);
    procedure dbgrdCalculationsResize(Sender: TObject);
    procedure dbmmoCAPTIONExit(Sender: TObject);
    procedure grRatesExCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
    procedure dbgrdMaterialCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
    procedure dbgrdMechanizmCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
    procedure mN14Click(Sender: TObject);
    procedure PMUseTransPercClick(Sender: TObject);
    procedure PMUseTransForThisCountClick(Sender: TObject);
    procedure mCopyToOwnBaseClick(Sender: TObject);
    procedure qrRatesExNOM_ROW_MANUALChange(Sender: TField);
    procedure PMRenumCurSmetClick(Sender: TObject);
    procedure PMNumRowClick(Sender: TObject);
    procedure btnKC6JClick(Sender: TObject);
    procedure PMRenumSelectedClick(Sender: TObject);
    procedure PMRenumPTMClick(Sender: TObject);
    procedure PMMatManPriceClick(Sender: TObject);
    procedure grRatesExSelectColumns(Grid: TJvDBGrid; var DefaultDialog: Boolean);
    procedure btnContractPriceClick(Sender: TObject);
    procedure dbgrdCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
    procedure dbmmoEnter(Sender: TObject);
    procedure pmPopup(Sender: TObject);
    procedure pmMarkRowClick(Sender: TObject);
    procedure qrRatesExMarkRowChange(Sender: TField);
    procedure PMMatSprCardClick(Sender: TObject);
    procedure PanelDataResize(Sender: TObject);
    procedure dsTypeDataDataChange(Sender: TObject; Field: TField);
    procedure btnRSClick(Sender: TObject);
    procedure PMMatNormPriceClick(Sender: TObject);
    procedure grRatesExEnter(Sender: TObject);
    procedure pmFindRowInEstimClick(Sender: TObject);
    procedure pmCopyFromSMClick(Sender: TObject);
  private const
    CaptionButton: array [1 .. 3] of string = ('Расчёт сметы', 'Расчёт акта', 'Расчёт акта на доп. работы');
    HintButton: array [1 .. 3] of string = ('Окно расчёта сметы', 'Окно расчёта акта',
      'Окно расчёта акта на доп. работы');
  private
    FMesCaption: string; // Заголовок для сообщений окна
    flLoaded: Boolean;

    ActReadOnly: Boolean;
    RowCoefDefault: Boolean;

    FIdObject: Integer;
    FIdEstimate: Integer;

    NDSEstimate: Boolean; // Расчет  с НДС или без

    FMonthEstimate: Integer;
    FYearEstimate: Integer;
    FRegion: Integer;

    FNewRowIterator, FNewNomManual: Integer;

    VisibleRightTables: String; // Настройка отобаржения нужной таблицы справа

    WCWinterPrice: Integer;
    WCSalaryWinterPrice: Integer;

    CountFromRate: Double;

    // Флаги пересчета по правым таблицам, исключает зацикливание в обработчиках ОnChange;
    FReCalcMech, FReCalcMat, FReCalcDev: Boolean;
    // Айдишника для посветки жирным связей между заменяющим и замененным
    // ID замененного материала который надо подсветить
    FIdReplasedMat: Integer;
    // ID заменяющего материала который надо подсветить
    FIdReplasingMat: Integer;
    // ID замененного механизма который надо подсветить
    FIdReplasedMech: Integer;
    // ID заменяющего механизма который надо подсветить
    FIdReplasingMech: Integer;

    IsUnAcc: Boolean;

    // Последняя таблица в которой был фокус, используется для отрисовки
    FLastEntegGrd: TJvDBGrid;
    // Флаги необходимости предлагать автоматически добавить пуск и регулировку
    FAutoAddE18, FAutoAddE20: Boolean;
    // Фрейм для расчета фактической цены, отображается как всплывающая панелька
    FCalculator: TCalculator;
    // Массив для автозамены (вписок позицый по которым будет выполняться автозамена)
    FAutoRepArray: TAutoRepArray;

    // Кастуный скролл в левом гриде
    FOldGridProc: TWndMethod;
    FTranspDistance: Integer;

    TYPE_ACT: Integer; // Тип акта

    FReplaceRowID: Integer; // ID строки сметы, которая будет заменяться

    //Флаги что таблицы находся в режиме расширенного редактирования;
    FMatInEditMode,
    FMechInEditMode,
    FDevInEditMode: Boolean;

    //Форма поиска строки в смете;
    FRowFinder: TFormEstRowFinder;

    procedure GridProc(var Message: TMessage);

    // пересчитывает все относящееся к строке в таблице расценок
    procedure ReCalcRowRates;

    // Обновляет кол-во у заменяющих материалов в расценке
    procedure GridRatesUpdateCount;

    // Изменяет внешний вид таблиц в зависимости от НДС
    procedure ChangeGrigNDSStyle(aNDS: Boolean);

    // проверка что материал неучтеный в таблице материалов
    function CheckMatUnAccountingMatirials: Boolean;

    procedure ReCalcRowMat(ACType: byte); // Пересчет одного материала
    function CheckMatReadOnly: Boolean; // Проверят можно ли редактировать данную строку
    procedure SetMatReadOnly(AValue: Boolean); // Устанавливает режим редактирования
    procedure SetMatEditMode; // включение режима расширенного редактирования материалов
    procedure SetMatNoEditMode; // отключение режима расширенного редактирования механизмов

    procedure ReCalcRowMech(ACType: byte); // Пересчет одного механизма
    function CheckMechReadOnly: Boolean; // Проверят можно ли редактировать данную строку
    procedure SetMechReadOnly(AValue: Boolean); // Устанавливает режим редактирования
    procedure SetMechEditMode; // включение режима расширенного редактирования механизма
    procedure SetMechNoEditMode; // отключение режима расширенного редактирования механизма

    procedure ReCalcRowDev; // Пересчет одного оборудование
    procedure SetDevEditMode; // включение режима расширенного редактирования оборудования
    procedure SetDevNoEditMode; // отключение режима расширенного редактирования оборудования
    procedure SetNoEditMode;

    // Проверяет есть ли пуск и регулировка в текущей смете
    function CheckE1820(AType: Integer): Boolean;
    // Проверяет, что курсор стоит на смете (ПТМ)
    function CheckCursorInRate: Boolean;

    // Набор процедур для управление автозаменой
    procedure ClearAutoRep; // Очищает массив автозамены
    procedure CheckNeedAutoRep(AID, AType, AMId, ARTId: Integer; ACode, AName: string);
    // Проверяет необходимость в замене
    procedure ShowAutoRep; // Показывает диалог замены для всех из массива

    procedure DeleteRowFromSmeta();
    procedure SaveData; // Процедура сохранения сметы/акта

    function GetSMSubType(ASM_ID: Integer): Integer;
    procedure CloseOtherTabs;
    function GetEditable: Boolean;

    function SprManualData(ASprType: Integer; const ANewCode: string; var ANewID: Integer): Boolean;
    procedure ReplaceSmRow(ASmRowId: Integer; var AIterator, AManualNom: Integer);

    procedure FillingWinterPrice(const vNumber: string);
    procedure FillingOHROPR(const vNumber: string);
    function GetOHROPRId(const ANumRate: string): Integer;

    //Позицианирует основное окно и окно справочника
    procedure PozWindow(AForm: TForm);
    //Копирование строк из другой сметы
    procedure CopyRowsToSM(ASmClipData: TSmClipData);
  protected
    procedure SetFormStyle; override;
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
  public

    Act: Boolean;

    ConfirmCloseForm: Boolean;
    flChangeEstimate: Boolean; // Не даем закрыться окну при переключении между сметами.
    property IdObject: Integer read FIdObject write FIdObject;
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
    procedure FillObjectInfo;
    procedure ShowNeedSaveDialog;
    function getTYPE_ACT: Integer;
    procedure LoadMain(const SM_ID: Integer);
    constructor Create(const SM_ID: Integer); reintroduce;
    // Свойство возможности редактировать смету
    property Editable: Boolean read GetEditable;
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
  AdditionData, CardMaterial,
  KC6, CardAct, Coef, WinterPrice,
  ReplacementMatAndMech, CardEstimate, KC6Journal,
  TreeEstimate, ImportExportModule, CalcResource, CalcResourceFact, ForemanList,
  TranspPersSelect, CardObject, CopyToOwnDialog, SelectDialog,
  ManualPriceSelect, uSelectColumn, ContractPrice,
  ManualSprItem, SmReportData,
  fReportSSR,
  fCopyEstimRow;

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

procedure TFormCalculationEstimate.SetNoEditMode;
begin
  SetMatNoEditMode;
  SetMechNoEditMode;
  SetDevNoEditMode;
end;

function TFormCalculationEstimate.GetEditable: Boolean;
var
  res: Variant;
begin
  Result := True;
  if not Act then
  begin
    res := FastSelectSQLOne('SELECT FL_CONTRACT_PRICE_DONE FROM objcards WHERE OBJ_ID=:0',
      VarArrayOf([IdObject]));
    if not VarIsNull(res) then
      Result := res = 0;
  end;
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
  // SC_MAXIMIZE - Разворачивание формы во весь экран
  // SC_RESTORE - Сворачивание формы в окно
  // SC_MINIMIZE - Сворачивание формы в маленькую панель

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
    // Скрываем панель свёрнутой формы
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

procedure TFormCalculationEstimate.GridProc(var Message: TMessage);
begin
  // Для более красивого скролла в мультиселекте
  case Message.Msg of
    WM_MOUSEWHEEL:
      with TWMMouseWheel(Message) do
      begin
        grRatesEx.DataSource.DataSet.DisableControls;
        try
          if grRatesEx.DataSource.DataSet.Active then
            grRatesEx.DataSource.DataSet.MoveBy(-WheelDelta div 120);
          with grRatesEx.SelectedRows do
          begin
            if Count < 2 then
            begin
              Clear;
              CurrentRowSelected := True;
            end;
          end;
          Message.Result := 0;
          Exit;
        finally
          grRatesEx.DataSource.DataSet.EnableControls;
        end;
      end;
  end;
  FOldGridProc(Message);
end;

procedure TFormCalculationEstimate.SetFormStyle;
var
  TitleRowH: Integer;
begin
  inherited;
  TitleRowH := Trunc(dbgrdMaterial.RowsHeight * 1.85);
  case dbgrdMaterial.Font.Size of
    8, 10, 12, 14:
      ;
  else
    Exit;
  end;

  dbgrdMaterial.AutoSizeRows := False;
  dbgrdMechanizm.AutoSizeRows := False;
  dbgrdDevices.AutoSizeRows := False;
  dbgrdDump.AutoSizeRows := False;
  dbgrdTransp.AutoSizeRows := False;

  dbgrdMaterial.TitleRowHeight := TitleRowH;
  dbgrdMechanizm.TitleRowHeight := TitleRowH;
  dbgrdDevices.TitleRowHeight := TitleRowH;
  dbgrdDump.TitleRowHeight := TitleRowH;
  dbgrdTransp.TitleRowHeight := TitleRowH;
end;

procedure TFormCalculationEstimate.FormCreate(Sender: TObject);
begin
  inherited;

  FOldGridProc := grRatesEx.WindowProc;
  grRatesEx.WindowProc := GridProc;

  FormMain.mCalcResources.Visible := True;
  FormMain.PanelCover.Visible := True; // Показываем панель на главной форме

  // Настройка размеров и положения формы
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10;
  Left := 10;

  WindowState := wsMaximized;
  if not Act then
  begin
    Caption := CaptionButton[1] + ' - Разрешено редактирование документа';
    FMesCaption := CaptionButton[1];
    btnContractPrice.Visible := True;
    btnContractPrice.Caption := 'Контрактная цена';
  end
  else
  begin
    Caption := CaptionButton[2 + TYPE_ACT] + ' - Разрешено редактирование документа';
    FMesCaption := CaptionButton[2 + TYPE_ACT];
    SpeedButtonSSR.Visible := False;
    btnContractPrice.Caption := 'Расчет';
  end;

  lblForeman.Visible := Act;
  lblForemanFIO.Visible := Act;
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

  // ЗАГРУЖАЕМ ИЗОБРАЖЕНИЯ ДЛЯ СПЛИТТЕРОВ

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
  dbmmoRight.Constraints.MinHeight := 45;

  if PS.UseBoldFontForName then
  begin
    dbmmoCAPTION.Font.Style := dbmmoCAPTION.Font.Style + [fsBold];
    dbmmoRight.Font.Style := dbmmoRight.Font.Style + [fsBold];
  end;

  ConfirmCloseForm := True;

  RowCoefDefault := True;
  // Высота панели с нижней таблицей
  PanelTableBottom.Height := 110 + PanelBottom.Height;

  // По умолчанию будет предлагать добавить пуск и регулировку
  FAutoAddE18 := True;
  FAutoAddE20 := True;

  FCalculator := TCalculator.Create(Self);
  FCalculator.Parent := TWinControl(Self);
  FCalculator.Visible := False;

  FRowFinder := TFormEstRowFinder.Create(Self);
  FRowFinder.Act := Act;

  if not Act then
    FormMain.CreateButtonOpenWindow(CaptionButton[1], HintButton[1], Self, 1)
  else
    FormMain.CreateButtonOpenWindow(CaptionButton[2 + TYPE_ACT], HintButton[2 + TYPE_ACT], Self, 1);

  flLoaded := True;
end;

procedure TFormCalculationEstimate.FormShow(Sender: TObject);
begin
  SettingVisibleRightTables;

  grRatesEx.SetFocus;

  FormMain.TimerCover.Enabled := True;
  // Запускаем таймер который скроет панель после отображения формы
end;

procedure TFormCalculationEstimate.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  if not Act then
    FormMain.SelectButtonActiveWindow(CaptionButton[1])
  else
    FormMain.SelectButtonActiveWindow(CaptionButton[2 + TYPE_ACT]);
end;

procedure TFormCalculationEstimate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if flChangeEstimate then
    Exit;
  Action := caFree;
  FormMain.mCalcResources.Visible := False;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  if not Act then
    FormMain.DeleteButtonCloseWindow(CaptionButton[1])
  else
    FormMain.DeleteButtonCloseWindow(CaptionButton[2 + TYPE_ACT]);
  if (not Assigned(fObjectsAndEstimates)) then
    fObjectsAndEstimates := TfObjectsAndEstimates.Create(FormMain);
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
          // Если пытамся ввести формулу в таблицу слева
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
  // FixDBGridColumnsWidth(dbgrdCalculations);
end;

procedure TFormCalculationEstimate.SpeedButtonLocalEstimateClick(Sender: TObject);
begin
  // Временный костыль
  CloseOtherTabs;

  if SpeedButtonLocalEstimate.Tag = 0 then
  begin
    SpeedButtonLocalEstimate.Down := True;

    SpeedButtonLocalEstimate.Tag := 1;
    SpeedButtonSummaryCalculation.Tag := 0;
    SpeedButtonSSR.Tag := 0;

    // Настройка видимости панелей
    PanelLocalEstimate.Visible := True;
    pnlSummaryCalculations.Visible := False;
    PanelSSR.Visible := False;

    // Делаем кнопки верхнего правого меню активными
    BottomTopMenuEnabled(True);

    pnlCalculationYesNo.Enabled := True;

    if pnlCalculationYesNo.Tag = 1 then
      pnlCalculationYesNo.Color := clLime
    else
      pnlCalculationYesNo.Color := clRed;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonSummaryCalculationClick(Sender: TObject);
begin
  // Временный костыль
  CloseOtherTabs;

  if SpeedButtonSummaryCalculation.Tag = 0 then
  begin
    SpeedButtonSummaryCalculation.Down := True;

    SpeedButtonLocalEstimate.Tag := 0;
    SpeedButtonSummaryCalculation.Tag := 1;
    SpeedButtonSSR.Tag := 0;

    // Настройка видимости панелей
    PanelLocalEstimate.Visible := False;
    pnlSummaryCalculations.Visible := True;
    PanelSSR.Visible := False;

    // Инициализация заполнения фрейма данными
    frSummaryCalculations.LoadData(VarArrayOf([IdEstimate, IdObject]));

    // Делаем кнопки верхнего правого меню неактивными
    BottomTopMenuEnabled(False);

    pnlCalculationYesNo.Enabled := True;

    if pnlCalculationYesNo.Tag = 1 then
      pnlCalculationYesNo.Color := clLime
    else
      pnlCalculationYesNo.Color := clRed;
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
var ReportSSR: TFormReportSSR;
begin
  ShowNeedSaveDialog;
  ReportSSR := TFormReportSSR.Create(Self, IdObject);
  try
    ReportSSR.ShowModal;
  finally
    FreeAndNil(ReportSSR);
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

procedure TFormCalculationEstimate.btnContractPriceClick(Sender: TObject);
begin
  if Assigned(fContractPrice) then
    Exit;

  CloseOtherTabs;
  if (not Assigned(fContractPrice)) then
    fContractPrice := TfContractPrice.Create(FormCalculationEstimate, VarArrayOf([IdObject, IdEstimate]));

  if fContractPrice.flError then
  begin
    FreeAndNil(fContractPrice);
    Abort;
  end;

  fContractPrice.Parent := FormCalculationEstimate;
  fContractPrice.Align := alClient;
  fContractPrice.BorderStyle := bsNone;
  fContractPrice.Show;
end;

procedure TFormCalculationEstimate.btnResMatClick(Sender: TObject);
begin
  // CloseOtherTabs;
  if Assigned(fContractPrice) then
  begin
    fContractPrice.Close;
    FreeAndNil(fContractPrice);
  end;
  if (Sender as TSpeedButton).Tag = 77 then
    ShellExecute(Handle, nil, 'report.exe', PChar('K' + INTTOSTR(FormCalculationEstimate.IdEstimate)),
      PChar(GetCurrentDir + '\reports\'), SW_maximIZE)
  else
    ShowCalcResource(FormCalculationEstimate.IdEstimate, (Sender as TSpeedButton).Tag,
      FormCalculationEstimate);
end;

procedure TFormCalculationEstimate.btnRSClick(Sender: TObject);
{ var
  doc: OleVariant;
  fileName: string; }
begin
  ShowNeedSaveDialog;
  CloseOtherTabs;
  ShowCalcResource(IdEstimate, 0, Self);
  {
    fileName := ExtractFilePath(Application.ExeName) + C_REPORTDIR + 'ШАБЛОН ПОЛНЫЙ.xls';
    doc := dmSmReport.loadDocument(fileName);
    dmSmReport.qrSR.Active := False;
    dmSmReport.qrSR.ParamByName('SM_ID').Value := IdEstimate;
    dmSmReport.qrSR.Active := True;
    dmSmReport.loadParams(dmSmReport.qrSR, doc, 5);
    dmSmReport.showDocument(doc);
  }
  {
    ShellExecute(Handle, nil, 'rs.exe', PChar(INTTOSTR(FormCalculationEstimate.IdEstimate)),
    PChar(GetCurrentDir + '\reports\'), SW_maximIZE);
  }
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

procedure TFormCalculationEstimate.btnKC6JClick(Sender: TObject);
begin
  CloseOtherTabs;

  if Act then
  // для акта
  begin
    if MessageBox(0, PChar('Произвести выборку данных из сметы?'), 'Расчёт сметы',
      MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrYes then
      fKC6.MyShow(IdObject);
  end
  // Для сметы
  else
  begin
    ShowNeedSaveDialog;
    FormWaiting.Show;
    Application.ProcessMessages;
    if (not Assigned(fKC6Journal)) then
      fKC6Journal := TfKC6Journal.Create(FormCalculationEstimate, VarArrayOf([IdObject, IdEstimate]));

    // Встраиваем форму
    fKC6Journal.Parent := FormCalculationEstimate;
    fKC6Journal.Align := alClient;
    fKC6Journal.BorderStyle := bsNone;

    fKC6Journal.Show;
    FormWaiting.Close;
  end;
end;

procedure TFormCalculationEstimate.RecalcEstimate;
// Процедура перерасчета сметы
var
  Key: Variant;
  e: TDataSetNotifyEvent;
  AutoCommitValue: Boolean;
begin
  // Перерасчет для сметы
  if not Act then
  begin
    AutoCommitValue := DM.Read.Options.AutoCommit;
    DM.Read.Options.AutoCommit := False;
    try
      DM.Read.StartTransaction;
      qrTemp.Active := False;
      qrTemp.SQL.Text := 'SELECT SM_ID FROM smetasourcedata WHERE OBJ_ID=:OBJ_ID AND SM_TYPE=2 AND ACT=:ACT';
      qrTemp.ParamByName('OBJ_ID').Value := IdObject;
      if Act then
        qrTemp.ParamByName('ACT').Value := 1
      else
        qrTemp.ParamByName('ACT').Value := 0;
      qrTemp.Active := True;
      qrTemp.First;
      try
        while not qrTemp.Eof do
        begin
          qrRatesExRecalc.Active := False;
          qrRatesExRecalc.ParamByName('EAID').Value := qrTemp.FieldByName('SM_ID').Value;
          if Act then
            qrRatesExRecalc.ParamByName('vIsACT').Value := 1
          else
            qrRatesExRecalc.ParamByName('vIsACT').Value := 0;
          qrRatesExRecalc.Active := True;
          qrRatesExRecalc.First;
          while not qrRatesExRecalc.Eof do
          begin
            if qrRatesExRecalc.FieldByName('ID_TYPE_DATA').Value > 0 then
            begin
              FastExecSQL('CALL CalcRowInRateTab(:ID, :TYPE, 1);',
                VarArrayOf([qrRatesExRecalc.FieldByName('ID_TABLES').Value,
                qrRatesExRecalc.FieldByName('ID_TYPE_DATA').Value]));
              FastExecSQL('CALL CalcCalculation(:SM_ID, :ID_TYPE_DATA, :ID_TABLES, 0)',
                VarArrayOf([qrRatesExRecalc.FieldByName('SM_ID').Value,
                qrRatesExRecalc.FieldByName('ID_TYPE_DATA').Value,
                qrRatesExRecalc.FieldByName('ID_TABLES').Value]));
            end;
            qrRatesExRecalc.Next;
          end;
          qrTemp.Next;
        end;
        qrTemp.Active := False;
        DM.Read.Commit;
      except
        DM.Read.Rollback;
        raise;
      end;
    finally
      DM.Read.Options.AutoCommit := AutoCommitValue;
      CloseOpen(qrCalculations);
    end;
  end
  else
  // Для акта пока работает старый перерасчет
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
            FastExecSQL('CALL CalcCalculation(:SM_ID, :ID_TYPE_DATA, :ID_TABLES, 0)',
              VarArrayOf([qrRatesExSM_ID.Value, qrRatesExID_TYPE_DATA.Value, qrRatesExID_TABLES.Value]));
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
      grRatesEx.SelectedRows.Clear;
      CloseOpen(qrCalculations);
    end;
  end;
end;

procedure TFormCalculationEstimate.btn1Click(Sender: TObject);
begin
  if not Editable then
    Exit;

  if Application.MessageBox('Произвести перерасчет?', 'Перерасчет', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST)
    <> IDYES then
    Exit;
  case Application.MessageBox('Произвести перерасчет\замену данных?'#13 +
    '(будут восстановлены справочные цены)', 'Перерасчет', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) of
    IDYES:
      FastExecSQL('CALL UpdateSmetaCosts(:IDESTIMATE);', VarArrayOf([IdEstimate]));
  end;
  RecalcEstimate;

  if pnlSummaryCalculations.Visible then
    frSummaryCalculations.LoadData(VarArrayOf([IdEstimate, IdObject]));

  if Assigned(fContractPrice) then
    fContractPrice.mRecalcAllClick(nil);
end;

procedure TFormCalculationEstimate.btnCalcFactClick(Sender: TObject);
begin
  ShowCalcResourceFact(FormCalculationEstimate.IdEstimate);
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
      Hint := 'Режим показа таблиц: материалы, механизмы, оборудования';
      DM.ImageListModeTables.GetBitmap(1, SpeedButtonModeTables.Glyph);
      s := '1110000';
    end
    else
    begin
      Tag := 0;
      Hint := 'Режим одной таблицы';
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
var
  newWith: Integer;
begin
  newWith := ((Sender as TPanel).Width - dblkcbbOXROPR.Left - lblWinterPrice.Width - 24) div 2;
  dblkcbbOXROPR.Width := newWith;

  // EditWinterPrice.Left := lblWinterPrice.Left + lblWinterPrice.Width + 6;
  edtWinterPrice.Width := newWith;
  btnWinterPriceSelect.Left := edtWinterPrice.Left + edtWinterPrice.Width -
    4 { - btnWinterPriceSelect.Width };
end;

procedure TFormCalculationEstimate.pnlCalculationYesNoClick(Sender: TObject);
begin
  with pnlCalculationYesNo do
    if Tag = 1 then
    begin
      Tag := 0;
      Color := clRed;
      Caption := 'Расчёты запрещены';
      if not Act then
        FormCalculationEstimate.Caption := CaptionButton[1] + ' - Запрещено редактирование документа'
      else
        FormCalculationEstimate.Caption := CaptionButton[2 + TYPE_ACT] +
          ' - Запрещено редактирование документа'
    end
    else
    begin
      Tag := 1;
      Color := clLime;
      Caption := 'Расчёты разрешены';
      if not Act then
        FormCalculationEstimate.Caption := CaptionButton[1] + ' - Разрешено редактирование документа'
      else
        FormCalculationEstimate.Caption := CaptionButton[2 + TYPE_ACT] +
          ' - Разрешено редактирование документа';
    end;
  frSummaryCalculations.grSummaryCalculation.Repaint;
  if Assigned(fCalcResource) then
    fCalcResource.pnlCalculationYesNoClick(nil);
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

procedure TFormCalculationEstimate.PanelDataResize(Sender: TObject);
begin
  edtDescr.Width := pnlCalculationYesNo.Left - edtDescr.Left - 6;
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
  i, btnCount: Integer;
begin
  if not flLoaded then
    Exit;

  // btn3.Visible := not Act;
  // btn3.Visible := not Act;
  btnCalcFact.Visible := Act;
  // btnCalcFact.Visible := Act;

  btnCount := 0;

  for i := 0 to PanelTopMenu.ControlCount - 1 do
  begin
    if (PanelTopMenu.Controls[i] is TSpeedButton) and (PanelTopMenu.Controls[i] as TSpeedButton).Visible then
      Inc(btnCount);
    if (PanelTopMenu.Controls[i] is TButton) and (PanelTopMenu.Controls[i] as TButton).Visible then
      Inc(btnCount);
    if (PanelTopMenu.Controls[i] is TBitBtn) and (PanelTopMenu.Controls[i] as TBitBtn).Visible then
      Inc(btnCount);
  end;

  WidthButton := ((Sender as TPanel).ClientWidth - btnCount - 5) div btnCount;

  for i := 0 to PanelTopMenu.ControlCount - 1 do
  begin
    if (PanelTopMenu.Controls[i] is TSpeedButton) and (PanelTopMenu.Controls[i] as TSpeedButton).Visible then
      (PanelTopMenu.Controls[i] as TSpeedButton).Width := WidthButton;
    if (PanelTopMenu.Controls[i] is TButton) and (PanelTopMenu.Controls[i] as TButton).Visible then
      (PanelTopMenu.Controls[i] as TButton).Width := WidthButton;
    if (PanelTopMenu.Controls[i] is TBitBtn) and (PanelTopMenu.Controls[i] as TBitBtn).Visible then
      (PanelTopMenu.Controls[i] as TBitBtn).Width := WidthButton;
  end;
  {
    if Act then
    WidthButton := ((Sender as TPanel).ClientWidth - btnKC6.Left - btnKC6.Width - 7) div 5
    else
    WidthButton := ((Sender as TPanel).ClientWidth - btnKC6.Left - btnKC6.Width - 7) div 7;
    // btnKC6.Width := WidthButton;
    btnResMat.Width := WidthButton;
    btnResMech.Width := WidthButton;
    btnResDev.Width := WidthButton;
    btnResZP.Width := WidthButton;
    btnResCalc.Width := WidthButton;
    SpeedButtonSSR.Width := WidthButton;
    btn3.Width := WidthButton;
    btnCalcFact.Width := WidthButton;
  }

  btnResMat.Caption := StringReplace(btnResMat.Caption, ' ', ''#13, [rfReplaceAll]);
  btnResMech.Caption := StringReplace(btnResMech.Caption, ' ', ''#13, [rfReplaceAll]);
  btnResDev.Caption := StringReplace(btnResDev.Caption, ' ', ''#13, [rfReplaceAll]);
  btnContractPrice.Caption := StringReplace(btnContractPrice.Caption, ' ', ''#13, [rfReplaceAll]);

  dbmmoRight.Height := dbmmoCAPTION.Height;
end;

// Делаем кнопки правой панели верхнего меню неактивными
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

// Перерисовка изображений для сплиттеров
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
  // flLoaded := True;
end;

procedure TFormCalculationEstimate.Button3Click(Sender: TObject);
begin
  FormSummaryCalculationSettings.ShowModal;
end;

procedure TFormCalculationEstimate.PopupMenuTableLeftTechnicalPartClick(Sender: TObject);
var
  NumberNormativ, NameFile: String;
  FirstChar: Char;
  Path: String;
begin
  NumberNormativ := qrRatesExOBJ_CODE.AsString;

  // В условии - русские символы, в переменной NumberNormativ - английские
  if (NumberNormativ > 'Е121-1-1') and (NumberNormativ < 'Е121-137-1') then
    NumberNormativ := 'E121_p1'
  else if (NumberNormativ > 'Е121-141-1') and (NumberNormativ < 'Е121-222-2') then
    NumberNormativ := 'E121_p2'
  else if (NumberNormativ > 'Е121-241-1') and (NumberNormativ < 'Е121-439-8') then
    NumberNormativ := 'E121_p3'
  else if (NumberNormativ > 'Е121-451-1') and (NumberNormativ < 'Е121-639-1') then
    NumberNormativ := 'E121_p4'
  else if (NumberNormativ > 'Е29-6-1') and (NumberNormativ < 'Е29-92-12') then
    NumberNormativ := 'E29_p1'
  else if (NumberNormativ > 'Е29-93-1') and (NumberNormativ < { 'Е29-277-1' } 'Е29-277-2') then
    NumberNormativ := 'E29_p2'
  else if (NumberNormativ > 'Е35-9-1') and (NumberNormativ < 'Е35-233-2') then
    NumberNormativ := 'E35_p1'
  else if (NumberNormativ > 'Е35-234-1') and (NumberNormativ < 'Е35-465-1') then
    NumberNormativ := 'E35_p2'
  else if (NumberNormativ > 'Ц12-1-1') and (NumberNormativ < 'Ц12-331-3') then
    NumberNormativ := 'C12_p1'
  else if (NumberNormativ > 'Ц12-362-1') and (NumberNormativ < 'Ц12-1314-10') then
    NumberNormativ := 'C12_p2'
  else if (NumberNormativ > 'Ц13-1-1') and (NumberNormativ < 'Ц13-230-7') then
    NumberNormativ := 'C13_p1'
  else if (NumberNormativ > 'Ц13-250-1') and (NumberNormativ < 'Ц13-383-3') then
    NumberNormativ := 'C13_p2'
  else if (NumberNormativ > 'Ц8-1-1') and (NumberNormativ < 'Ц8-477-1') then
    NumberNormativ := 'C8_p1'
  else if (NumberNormativ > 'Ц8-481-1') and (NumberNormativ < 'Ц8-914-3') then
    NumberNormativ := 'C8_p2'
  else
  begin
    FirstChar := NumberNormativ[1];

    Delete(NumberNormativ, 1, 1);

    // В условии - русские символы, в переменной NumberNormativ - английские
    if FirstChar = 'Е' then
      NumberNormativ := 'E' + NumberNormativ
    else if FirstChar = 'С' then
      NumberNormativ := 'C' + NumberNormativ
    else if FirstChar = '0' then
      NumberNormativ := '0' + NumberNormativ;

    // Удаляем символы начиная с первого символа '-' и до конца строки
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
    MessageBox(0, PChar('Вы пытаетесь открыть файл:' + sLineBreak + sLineBreak + Path + sLineBreak +
      sLineBreak + 'которого не существует!'), PChar(FMesCaption), MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;

  ShellExecute(FormCalculationEstimate.Handle, nil, PChar(Path), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TFormCalculationEstimate.qrCalculationsAfterOpen(DataSet: TDataSet);
begin
  if qrCalculations.RecordCount > dbgrdCalculations.VisibleRowCount then
    dbgrdCalculations.ScrollBars := ssVertical
  else
    dbgrdCalculations.ScrollBars := ssNone;
end;

procedure TFormCalculationEstimate.qrDevicesBeforeScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not FReCalcDev then
  begin
    // закрытие открытой на редактирование строки
    SetDevNoEditMode;
  end;
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
    // Пересчет по строке оборудования
    try
      // Индивидуальное поведение для конкретных полей
      if (Sender.FieldName = 'PROC_PODR') or
         (Sender.FieldName = 'PROC_ZAC') or
         (Sender.FieldName = 'TRANSP_PROC_PODR') or
         (Sender.FieldName = 'TRANSP_PROC_ZAC') then
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
        qrDevicesVFCOAST_NO_NDS.Value := NDSToNoNDS1(qrDevicesVFCOAST_NDS.Value, qrDevicesNDS.Value);
        qrDevicesVFTRANSP_NO_NDS.Value := NDSToNoNDS1(qrDevicesVFTRANSP_NDS.Value, qrDevicesNDS.Value);
      end
      else
      begin
        qrDevicesFCOAST_NDS.Value := NoNDSToNDS1(qrDevicesFCOAST_NO_NDS.Value, qrDevicesNDS.Value);
        qrDevicesDEVICE_TRANSP_NDS.Value := NoNDSToNDS1(qrDevicesDEVICE_TRANSP_NO_NDS.Value,
          qrDevicesNDS.Value);
        qrDevicesVFCOAST_NDS.Value := NoNDSToNDS1(qrDevicesVFCOAST_NO_NDS.Value, qrDevicesNDS.Value);
        qrDevicesVFTRANSP_NDS.Value := NoNDSToNDS1(qrDevicesVFTRANSP_NO_NDS.Value, qrDevicesNDS.Value);
      end;
      // После изменения ячейки строка фиксируется
      qrDevices.Post;

      // Пересчет по строке оборуд
      ReCalcRowDev;
    finally
      FReCalcDev := False;
    end;
  end;
end;

procedure TFormCalculationEstimate.dsTypeDataDataChange(Sender: TObject; Field: TField);
begin

end;

// Проверят можно ли редактировать данную строку
function TFormCalculationEstimate.CheckMechReadOnly: Boolean;
begin
  Result := False;
  // Вынесеный механизм в расценке или замененные механизмы
  if ((qrMechanizmFROM_RATE.AsInteger = 1) and (qrRatesExID_TYPE_DATA.AsInteger = 1)) or
    (qrMechanizmREPLACED.AsInteger = 1) or (qrMechanizmTITLE.AsInteger > 0) or
    not(qrMechanizmID.AsInteger > 0) or (qrMechanizm.Eof) then
    Result := True;
end;

// Проверяет выполнялась ли ранее в смета замена по такому коду, если да то нуждается в автозамене
procedure TFormCalculationEstimate.CheckNeedAutoRep(AID, AType, AMId, ARTId: Integer; ACode, AName: string);
var
  j: Integer;
begin
  if ((AType = 2) and not PMMatAutoRep.Checked) or ((AType = 3) and not PMMechAutoRep.Checked) then
    Exit;

  qrTemp1.Active := False;
  case byte(PS.FindAutoRepInAllRate) of
    0:
      begin
        case AType of
          2:
            qrTemp1.SQL.Text := 'SELECT mt.id FROM materialcard_temp mt, card_rate_temp cr ' +
              ' where (mt.DATA_ROW_ID = cr.DATA_ROW_ID) and (mt.REPLACED = 1) and ' + '(mt.MAT_ID = ' +
              INTTOSTR(AMId) + ') and ' + '(cr.RATE_ID = ' + INTTOSTR(ARTId) + ')';
          3:
            qrTemp1.SQL.Text := 'SELECT mh.id FROM mechanizmcard_temp mh, card_rate_temp cr ' +
              ' where (mh.DATA_ROW_ID = cr.DATA_ROW_ID) and (mh.REPLACED = 1) and ' + '(mh.MECH_ID = ' +
              INTTOSTR(AMId) + ') and ' + '(cr.RATE_ID = ' + INTTOSTR(ARTId) + ')';
        else
          Exit;
        end;
      end;
    1:
      begin
        case AType of
          2:
            qrTemp1.SQL.Text := 'SELECT id FROM materialcard_temp where ' + '(REPLACED = 1) and (MAT_ID = ' +
              INTTOSTR(AMId) + ')';
          3:
            qrTemp1.SQL.Text := 'SELECT id FROM mechanizmcard_temp where ' + '(REPLACED = 1) and (MECH_ID = '
              + INTTOSTR(AMId) + ')';
        else
          Exit;
        end;
      end;
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
    FAutoRepArray[j].Name := AName;
    FAutoRepArray[j].MID := AMId;
    if not PS.FindAutoRepInAllRate then
      FAutoRepArray[j].RTID := ARTId
    else
      FAutoRepArray[j].RTID := 0;
  end;
  qrTemp1.Active := False;
end;

procedure TFormCalculationEstimate.ClearAutoRep;
begin
  SetLength(FAutoRepArray, 0);
end;

procedure TFormCalculationEstimate.CloseOtherTabs;
begin
  // Временный костыль
  if (Assigned(fCalcResource)) then
  begin
    fCalcResource.Close;
    FreeAndNil(fCalcResource);
  end;
  if (Assigned(fKC6Journal)) then
  begin
    fKC6Journal.Close;
    FreeAndNil(fKC6Journal);
  end;
  if (Assigned(fContractPrice)) then
  begin
    fContractPrice.Close;
    FreeAndNil(fContractPrice);
  end;
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
          case MessageBox(0, PChar('Хотите произвести замену материала ''' + FAutoRepArray[i].Code + ' ' +
            FAutoRepArray[i].Name + '''?' + sLineBreak +
            'Замены данного материала ранее уже производились в смете.'), 'Автозамена',
            MB_ICONQUESTION + MB_OKCANCEL + mb_TaskModal) of
            mrOk:
              begin
                frmReplace := TfrmReplacement.Create(IdEstimate, FAutoRepArray[i].RTID, FAutoRepArray[i].ID,
                  0, 2, False, True);
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
          case MessageBox(0, PChar('Хотите произвести замену механизма ''' + FAutoRepArray[i].Code + ' ' +
            FAutoRepArray[i].Name + '''?' + sLineBreak +
            'Замены данного механизма ранее уже производились в смете.'), 'Автозамена',
            MB_ICONQUESTION + MB_OKCANCEL + mb_TaskModal) of
            mrOk:
              begin
                frmReplace := TfrmReplacement.Create(IdEstimate, FAutoRepArray[i].RTID, FAutoRepArray[i].ID,
                  0, 3, False, True);
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

procedure TFormCalculationEstimate.SetMechReadOnly(AValue: Boolean); // Устанавливает режим редактирования
begin
  dbgrdMechanizm.ReadOnly := AValue;
end;

// Проверят можно ли редактировать данную строку
function TFormCalculationEstimate.CheckMatReadOnly: Boolean;
begin
  Result := False;
  // Вынесенные из расценки // или замененный
  if ((qrMaterialFROM_RATE.AsInteger = 1) and (qrRatesExID_TYPE_DATA.AsInteger = 1)) or
    (qrMaterialREPLACED.AsInteger = 1) or (qrMaterialDELETED.AsInteger = 1) or (qrMaterialTITLE.AsInteger > 0)
    or not(qrMaterialID.AsInteger > 0) or (qrMaterial.Eof) then
    Result := True;
end;

// Устанавливает режим редактирования
procedure TFormCalculationEstimate.SetMatReadOnly(AValue: Boolean);
begin
  dbgrdMaterial.ReadOnly := AValue;
end;

// включение режима расширенного редактирования оборудования
procedure TFormCalculationEstimate.SetDevEditMode;
var I: Integer;
begin
  for i := 0 to dbgrdDevices.Columns.Count - 1 do
    if (dbgrdDevices.Columns[i].FieldName.ToUpper = 'DEVICE_NAME') or
      (dbgrdDevices.Columns[i].FieldName.ToUpper = 'NDS') then
      dbgrdDevices.Columns[i].ReadOnly := False;

  dbmmoRight.Color := $00AFFEFC;
  dbmmoRight.ReadOnly := False;

  FDevInEditMode := True;
end;

procedure TFormCalculationEstimate.SetDevNoEditMode;
var
  i: Integer;
begin
  if FDevInEditMode then
  begin
    for i := 0 to dbgrdDevices.Columns.Count - 1 do
      if (dbgrdDevices.Columns[i].FieldName.ToUpper = 'DEVICE_NAME') or
        (dbgrdDevices.Columns[i].FieldName.ToUpper = 'NDS') then
        dbgrdDevices.Columns[i].ReadOnly := True;

    dbmmoRight.Color := clWindow;
    dbmmoRight.ReadOnly := True;

    FDevInEditMode := False;
  end;
end;

// включение режима расширенного редактирования материалов
procedure TFormCalculationEstimate.SetMatEditMode;
var
  i: Integer;
begin
  if CheckMatReadOnly then
    Exit;

  for i := 0 to dbgrdMaterial.Columns.Count - 1 do
    if (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'MAT_NAME') or
      (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'MAT_NORMA') or
      (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'MAT_COUNT') or
      (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'FCOAST_NDS') or
      (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'FCOAST_NO_NDS') or
      (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'FTRANSP_NDS') or
      (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'FTRANSP_NO_NDS') or
      (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'PROC_TRANSP') or
      (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'NDS') then
      dbgrdMaterial.Columns[i].ReadOnly := False;

  dbmmoRight.Color := $00AFFEFC;
  dbmmoRight.ReadOnly := False;

  FMatInEditMode := True;
end;

// отключение режима расширенного редактирования материалов
procedure TFormCalculationEstimate.SetMatNoEditMode;
var
  i: Integer;
begin
  if FMatInEditMode then
  begin
    for i := 0 to dbgrdMaterial.Columns.Count - 1 do
      if (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'MAT_NAME') or
        (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'MAT_NORMA') or
        (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'MAT_COUNT') or
        (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'FCOAST_NDS') or
        (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'FCOAST_NO_NDS') or
        (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'FTRANSP_NDS') or
        (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'FTRANSP_NO_NDS') or
        (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'PROC_TRANSP') or
        (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'NDS') then
        dbgrdMaterial.Columns[i].ReadOnly := True;

    dbmmoRight.Color := clWindow;
    dbmmoRight.ReadOnly := True;

    FMatInEditMode := False;
  end;
end;

procedure TFormCalculationEstimate.qrMaterialAfterScroll(DataSet: TDataSet);
var
  flag: Boolean;
begin
  // На всякий случай, что-бы избежать глюков
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

    // Для красоты отрисовки
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
    // Предыдущее рекно используется для определния направления движения по таблице
    dbgrdMaterial.Tag := qrMaterial.RecNo;
    // закрытие открытой на редактирование строки
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
    Sender.Value := 0;
    Exit;
  end;

  if not FReCalcMat then
  begin
    FReCalcMat := True;
    // Пересчет по строке материала
    try
      CField := Sender.FieldName;
      CValue := Sender.Value;
      CType := 0;

      if (CField = 'MAT_COUNT') then
        CType := 1;

      if (CField = 'MAT_NAME') then
      begin
        qrTemp.SQL.Text := 'UPDATE materialcard_temp set ' +
          'MAT_NAME=:MAT_NAME WHERE ID=:ID;';
        qrTemp.ParamByName('ID').Value := qrMaterialID.AsInteger;
        qrTemp.ParamByName('MAT_NAME').Value := CValue;
        qrTemp.ExecSQL;
        Exit;
      end;

      // Индивидуальное поведение для конкретных полей
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

      if (Sender.FieldName = 'FTRANSP_NDS') or
         (Sender.FieldName = 'FTRANSP_NO_NDS') then
        qrMaterialFTRANSCOUNT.Value := qrMaterialMAT_COUNT.Value;

      if (Sender.FieldName = 'VFTRANSP_NDS') or
         (Sender.FieldName = 'VFTRANSP_NO_NDS') then
        qrMaterialVFTRANSCOUNT.Value := qrMaterialMAT_COUNT.Value;

      // пересчитывается всегда, что-бы не писать кучу условий когда это актуально
      if NDSEstimate then
      begin
        qrMaterialFCOAST_NO_NDS.Value := NDSToNoNDS1(qrMaterialFCOAST_NDS.Value, qrMaterialNDS.Value);
        qrMaterialFTRANSP_NO_NDS.Value := NDSToNoNDS1(qrMaterialFTRANSP_NDS.Value, qrMaterialNDS.Value);
        qrMaterialVFCOAST_NO_NDS.Value := NDSToNoNDS1(qrMaterialVFCOAST_NDS.Value, qrMaterialNDS.Value);
        qrMaterialVFTRANSP_NO_NDS.Value := NDSToNoNDS1(qrMaterialVFTRANSP_NDS.Value, qrMaterialNDS.Value);
      end
      else
      begin
        qrMaterialFCOAST_NDS.Value := NoNDSToNDS1(qrMaterialFCOAST_NO_NDS.Value, qrMaterialNDS.Value);
        qrMaterialFTRANSP_NDS.Value := NoNDSToNDS1(qrMaterialFTRANSP_NO_NDS.Value, qrMaterialNDS.Value);
        qrMaterialVFCOAST_NDS.Value := NoNDSToNDS1(qrMaterialVFCOAST_NO_NDS.Value, qrMaterialNDS.Value);
        qrMaterialVFTRANSP_NDS.Value := NoNDSToNDS1(qrMaterialVFTRANSP_NO_NDS.Value, qrMaterialNDS.Value);
      end;

      // После изменения ячейки фиксируется
      qrMaterial.Post;

      // Обновление в базе (так как датасет не связан с базой напрямую)
      with qrTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('UPDATE materialcard_temp SET FCOAST_NO_NDS = :FCOAST_NO_NDS, ' +
          'FCOAST_NDS = :FCOAST_NDS, FTRANSP_NO_NDS = :FTRANSP_NO_NDS, ' +
          'FTRANSP_NDS = :FTRANSP_NDS, VFCOAST_NO_NDS = :VFCOAST_NO_NDS, ' +
          'VFCOAST_NDS = :VFCOAST_NDS, VFTRANSP_NO_NDS = :VFTRANSP_NO_NDS, ' +
          'VFTRANSP_NDS = :VFTRANSP_NDS, MAT_PROC_ZAC = :MAT_PROC_ZAC, ' +
          'MAT_PROC_PODR = :MAT_PROC_PODR, TRANSP_PROC_ZAC = :TRANSP_PROC_ZAC, ' +
          'TRANSP_PROC_PODR = :TRANSP_PROC_PODR, FTRANSCOUNT = :FTRANSCOUNT, ' +
          'VFTRANSCOUNT = :VFTRANSCOUNT, ' + CField + ' = :AA' + CField +
          ' WHERE id = :id;');
        ParamByName('FCOAST_NO_NDS').Value := qrMaterialFCOAST_NO_NDS.AsVariant;
        ParamByName('FCOAST_NDS').Value := qrMaterialFCOAST_NDS.AsVariant;
        ParamByName('FTRANSP_NO_NDS').Value := qrMaterialFTRANSP_NO_NDS.AsVariant;
        ParamByName('FTRANSP_NDS').Value := qrMaterialFTRANSP_NDS.AsVariant;
        ParamByName('VFCOAST_NO_NDS').Value := qrMaterialVFCOAST_NO_NDS.AsVariant;
        ParamByName('VFCOAST_NDS').Value := qrMaterialVFCOAST_NDS.AsVariant;
        ParamByName('VFTRANSP_NO_NDS').Value := qrMaterialVFTRANSP_NO_NDS.AsVariant;
        ParamByName('VFTRANSP_NDS').Value := qrMaterialVFTRANSP_NDS.AsVariant;
        ParamByName('MAT_PROC_ZAC').Value := qrMaterialMAT_PROC_ZAC.Value;
        ParamByName('MAT_PROC_PODR').Value := qrMaterialMAT_PROC_PODR.Value;
        ParamByName('TRANSP_PROC_ZAC').Value := qrMaterialTRANSP_PROC_ZAC.Value;
        ParamByName('TRANSP_PROC_PODR').Value := qrMaterialTRANSP_PROC_PODR.Value;
        ParamByName('FTRANSCOUNT').Value := qrMaterialFTRANSCOUNT.AsVariant;
        ParamByName('VFTRANSCOUNT').Value := qrMaterialVFTRANSCOUNT.AsVariant;
        ParamByName('AA' + CField).Value := CValue;
        ParamByName('id').Value := qrMaterialID.Value;
        ExecSQL;
      end;

      // Пересчет по строке материала
      ReCalcRowMat(CType);
    finally
      FReCalcMat := False;
    end;
  end;
end;

procedure TFormCalculationEstimate.mBaseDataClick(Sender: TObject);
begin
  fBasicData.ShowForm(IdObject, qrRatesExSM_ID.AsInteger);
  GetSourceData;
  GridRatesRowSellect;
  CloseOpen(qrRatesEx);
  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.mCopyToOwnBaseClick(Sender: TObject);
var
  newID, newID1, res, tID: Variant;
  AutoCommitValue, flOk: Boolean;
  OBJ_NAME: string;
  TmpRec: TSprRecord;
  MatId, MatType: Integer;
begin
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  try
    DM.Read.StartTransaction;
    try
      case qrRatesExID_TYPE_DATA.Value of
        // Копирование расценки в собственную бд
        1:
        begin
          OBJ_NAME := qrRatesExOBJ_CODE.AsString;
          // Проверяем на наличие такой же записи
         //Закомментированно так как алгоритм не учитывает внушние ключи normativg
          flOk := False;
          while not flOk do
          begin
            tID := Null;
            tID := FastSelectSQLOne
              ('SELECT NORMATIV_ID FROM normativg WHERE NORM_BASE=1 and NORM_NUM=:0 LIMIT 1',
              VarArrayOf([OBJ_NAME]));
            if not VarIsNull(tID) then
            begin
              res := ShowCopyToOwnDialog(OBJ_NAME);

              if VarIsNull(res) then
                Exit;
              if res = 1 then
              begin
                FastExecSQL('DELETE FROM normativg WHERE NORMATIV_ID = :1', VarArrayOf([tID]));
                flOk := True;
              end;
            end
            else
              flOk := True;
          end;

          tID := FastSelectSQLOne('SELECT RATE_ID FROM card_rate_temp WHERE ID=:0',
            VarArrayOf([qrRatesExID_TABLES.Value]));
          // Копируем расценку
          newID := GetNewID(C_MANID_NORM);
          FastExecSQL
            ('INSERT INTO normativg(NORMATIV_ID,SORT_NUM, NORM_NUM, NORM_CAPTION, ' +
              'UNIT_ID, NORM_ACTIVE,normativ_directory_id, NORM_BASE, NORM_TYPE, ' +
              'work_id, ZNORMATIVS_ID,date_beginer)'#13
            + '(SELECT :4, null,:2,:3,UNIT_ID,1,normativ_directory_id,1,NORM_TYPE,' +
              'work_id,ZNORMATIVS_ID, :0 FROM normativg WHERE NORMATIV_ID = :1);',
            VarArrayOf([newID, OBJ_NAME, qrRatesExOBJ_NAME.Value, Now, tID]));

          // Копируем материалы
          newID1 := GetNewID(C_MANID_NORM_MAT);
          DM.qrDifferent.Active := False;
          DM.qrDifferent.SQL.Text :=
            'SELECT MAT_ID, MAT_NORMA FROM materialcard_temp WHERE ID_CARD_RATE=' +
            qrRatesExID_TABLES.AsString;
          DM.qrDifferent.Active := true;
          while not DM.qrDifferent.Eof do
          begin
            FastExecSQL('INSERT INTO materialnorm (ID, NORMATIV_ID, MATERIAL_ID, ' +
              'NORM_RAS, BASE) VALUES (:0,:1,:2,:3,1)',
              VarArrayOf([newID1, newID, DM.qrDifferent.Fields[0].Value,
              DM.qrDifferent.Fields[1].Value]));
            Inc(newID1);
            DM.qrDifferent.Next;
          end;
          DM.qrDifferent.Active := False;

          // Копируем механизмы
          newID1 := GetNewID(C_MANID_NORM_MECH);
          DM.qrDifferent.Active := False;
          DM.qrDifferent.SQL.Text :=
            'SELECT MECH_ID, MECH_NORMA FROM mechanizmcard_temp WHERE ID_CARD_RATE=' +
            qrRatesExID_TABLES.AsString;
          DM.qrDifferent.Active := true;
          while not DM.qrDifferent.Eof do
          begin
            FastExecSQL('INSERT INTO mechanizmnorm (ID, NORMATIV_ID, MECHANIZM_ID, ' +
              'NORM_RAS, BASE) VALUES (:0,:1,:2,:3,1)',
              VarArrayOf([newID1, newID, DM.qrDifferent.Fields[0].Value,
              DM.qrDifferent.Fields[1].Value]));
            Inc(newID1);
            DM.qrDifferent.Next;
          end;
          DM.qrDifferent.Active := False;

          // Копируем затраты труда
          newID1 := GetNewID(C_MANID_NORM_WORK);
          DM.qrDifferent.Active := False;
          DM.qrDifferent.SQL.Text :=
            'SELECT WORK_ID, NORMA FROM normativwork WHERE NORMATIV_ID=' +
            VarToStr(tID);
          DM.qrDifferent.Active := true;
          while not DM.qrDifferent.Eof do
          begin
            FastExecSQL('INSERT INTO normativwork (ID, NORMATIV_ID, WORK_ID, NORMA, BASE) ' +
              'VALUES (:0,:1,:2,:3,1)',
              VarArrayOf([newID1, newID, DM.qrDifferent.Fields[0].Value,
              DM.qrDifferent.Fields[1].Value]));
            Inc(newID1);
            DM.qrDifferent.Next;
          end;
          DM.qrDifferent.Active := False;
        end;
        // Материал
        2:
        begin
          MatId := -1;
          MatType := -1;
          DM.qrDifferent.SQL.Text :=
            'SELECT MAT_ID, MAT_TYPE FROM materialcard_temp WHERE ID=:ID';
          DM.qrDifferent.ParamByName('ID').Value := qrRatesExID_TABLES.Value;
          DM.qrDifferent.Active := True;
          try
            if not DM.qrDifferent.IsEmpty then
            begin
              MatId := DM.qrDifferent.Fields[0].AsInteger;
              MatType := DM.qrDifferent.Fields[1].AsInteger;
            end
            else
              raise Exception.Create('Материал не найден.');

            if not(MatType in [1,2]) then
              raise Exception.Create('Недопустимый тип материала.');
          finally
            DM.qrDifferent.Active := False;
          end;
          OBJ_NAME := Trim(qrRatesExOBJ_CODE.AsString);

          // Проверяем на наличие такой же записи
          flOk := False;
          while not flOk do
          begin
            tID := Null;
            tID := FastSelectSQLOne('SELECT MATERIAL_ID FROM MATERIAL WHERE BASE=1 and Trim(MAT_CODE)=Trim(:0) LIMIT 1',
              VarArrayOf([OBJ_NAME]));
            if not VarIsNull(tID) then
            begin
              res := ShowCopyToOwnDialog(OBJ_NAME);

              if VarIsNull(res) then
                Exit;
              if res = 1 then
              begin
                FastExecSQL('DELETE FROM MATERIAL WHERE MATERIAL_ID = :1', VarArrayOf([tID]));
                DelSprItem(tID, MatType - 1);
                flOk := True;
              end;
            end
            else
              flOk := True;
          end;

          // Копируем
          newID := GetNewID(C_MANID_MAT);
          FastExecSQL
            ('INSERT INTO MATERIAL (MATERIAL_ID, MAT_CODE, MAT_NAME, MAT_TYPE, ' +
              'UNIT_ID, BASE) (SELECT :3, :0, :1, MAT_TYPE, UNIT_ID, 1 ' +
              'FROM MATERIAL WHERE MATERIAL_ID=:2)',
            VarArrayOf([newID, OBJ_NAME, qrRatesExOBJ_NAME.AsString, MatId]));

          TmpRec.ID := newID;
          TmpRec.Code := OBJ_NAME;
          TmpRec.Name := qrRatesExOBJ_NAME.AsString;
          TmpRec.Unt := Trim(qrRatesExOBJ_UNIT.AsString);
          TmpRec.Manual := True;
          //MatType - 1 = CMatIndex, CJBIIndex
          SprControl.AddItem(MatType - 1, TmpRec);
        end;
        // Механизм
        3:
        begin
          // Проверяем на наличие такой же записи
          flOk := False;
          OBJ_NAME := qrRatesExOBJ_CODE.AsString;
          while not flOk do
          begin
            tID := Null;
            tID := FastSelectSQLOne
              ('SELECT MECHANIZM_ID FROM MECHANIZM WHERE BASE=1 and Trim(MECH_CODE)=Trim(:0) LIMIT 1',
              VarArrayOf([OBJ_NAME]));
            if not VarIsNull(tID) then
            begin
              res := ShowCopyToOwnDialog(OBJ_NAME);

              if VarIsNull(res) then
                Exit;
              if res = 1 then
              begin
                FastExecSQL('DELETE FROM MECHANIZM WHERE MECHANIZM_ID = :1', VarArrayOf([tID]));
                DelSprItem(tID, CMechIndex);
                flOk := True;
              end;
            end
            else
              flOk := True;
          end;

          tID := FastSelectSQLOne('SELECT MECH_ID FROM mechanizmcard_temp WHERE ID=:0',
            VarArrayOf([qrRatesExID_TABLES.Value]));
          // Копируем
          newID := GetNewID(C_MANID_MECH);
          FastExecSQL
            ('INSERT INTO MECHANIZM(MECHANIZM_ID, MECH_CODE, MECH_NAME, UNIT_ID, ' +
            'DESCRIPTION, MECH_PH, TYPE_MEH_SMEN_HOUR, BASE) (SELECT :3, :0, :1, ' +
            'UNIT_ID, DESCRIPTION, MECH_PH, TYPE_MEH_SMEN_HOUR, 1 ' +
            'FROM MECHANIZM WHERE MECHANIZM_ID=:2)',
            VarArrayOf([newID, OBJ_NAME, qrRatesExOBJ_NAME.Value, tID]));
          TmpRec.ID := newID;
          TmpRec.Code := OBJ_NAME;
          TmpRec.Name := qrRatesExOBJ_NAME.AsString;
          TmpRec.Unt := Trim(qrRatesExOBJ_UNIT.AsString);
          TmpRec.Manual := True;
          SprControl.AddItem(CMechIndex, TmpRec);
        end;
        // Оборудование
        4:
        begin
          // Проверяем на наличие такой же записи
          flOk := False;
          OBJ_NAME := qrRatesExOBJ_CODE.AsString;
          while not flOk do
          begin
            tID := Null;
            tID := FastSelectSQLOne
              ('SELECT DEVICE_ID FROM devices WHERE BASE=1 and Trim(DEVICE_CODE1)=Trim(:0) LIMIT 1',
              VarArrayOf([OBJ_NAME]));
            if not VarIsNull(tID) then
            begin
              res := ShowCopyToOwnDialog(OBJ_NAME);

              if VarIsNull(res) then
                Exit;
              if res = 1 then
              begin
                FastExecSQL('DELETE FROM devices WHERE DEVICE_ID = :1', VarArrayOf([tID]));
                DelSprItem(tID, CDevIndex);
                flOk := True;
              end;
            end
            else
              flOk := True;
          end;

          tID := FastSelectSQLOne('SELECT DEVICE_ID FROM devicescard_temp WHERE ID=:0',
            VarArrayOf([qrRatesExID_TABLES.Value]));
          // Копируем
          newID := GetNewID(C_MANID_DEV);
          FastExecSQL
            ('INSERT INTO devices (DEVICE_ID, DEVICE_CODE1, DEVICE_CODE2, NAME, ' +
            'UNIT, BASE) (SELECT :3, :0, '''', :1, ' +
            'UNIT, 1 FROM devices WHERE DEVICE_ID=:2)',
            VarArrayOf([newID, OBJ_NAME, qrRatesExOBJ_NAME.Value, tID]));
          TmpRec.ID := newID;
          TmpRec.Code := OBJ_NAME;
          TmpRec.Name := qrRatesExOBJ_NAME.AsString;
          TmpRec.Unt := Trim(qrRatesExOBJ_UNIT.AsString);
          TmpRec.Manual := True;
          SprControl.AddItem(CDevIndex, TmpRec);
        end
        else raise Exception.Create('Операция не поддерживает данный тип данных.');
      end;
      DM.Read.Commit;
      Application.MessageBox('Запись успешно скопирована!', 'Справочник',
        MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    except
      on e: Exception do
      begin
        DM.Read.Rollback;
        Application.MessageBox(PChar('Ошибка копирования записи!' + sLineBreak +
          e.ClassName + ': ' + e.Message), 'Справочник',
          MB_OK + MB_ICONSTOP + MB_TOPMOST);
      end;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
  end;
end;

procedure TFormCalculationEstimate.mDelEstimateClick(Sender: TObject);
var
  NumberEstimate, TextWarning: String;
begin
  NumberEstimate := qrRatesExOBJ_CODE.AsString;

  case qrRatesExID_TYPE_DATA.AsInteger of
    - 1:
      TextWarning := 'Вы пытаетесь удалить ЛОКАЛЬНУЮ смету с номером: ' + NumberEstimate + sLineBreak +
        'Вместе с ней будут удалены все разделы ПТМ которые с ней связаны!' + sLineBreak + sLineBreak +
        'Подтверждаете удаление?';
    -2:
      TextWarning := 'Вы пытаетесь удалить ОБЪЕКТНУЮ смету с номером: ' + NumberEstimate + sLineBreak +
        'Вместе с ней будут удалены все локальные и разделы ПТМ которые с ней связаны!' + sLineBreak +
        sLineBreak + 'Подтверждаете удаление?';
    -3:
      TextWarning := 'Вы действительно хотите удалить раздел ПТМ с номером: ' + NumberEstimate;
  else
    Exit;
  end;

  if MessageBox(0, PChar(TextWarning), PChar(FMesCaption), MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo
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
      MessageBox(0, PChar('При удалении сметы возникла ошибка:' + sLineBreak + e.Message), PChar(FMesCaption),
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

    // Для красоты отрисовки
    if (FIdReplasedMech > 0) or (FIdReplasingMech > 0) or flag then
      dbgrdMechanizm.Repaint;
  end;
end;

procedure TFormCalculationEstimate.qrMechanizmBeforeInsert(DataSet: TDataSet);
begin
  Abort; // Запрет добавления новой строки в правых таблицах
end;

procedure TFormCalculationEstimate.qrMechanizmBeforeScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not FReCalcMech then
  begin
    // Предыдущее рекно используется для определния направления движения по таблице
    dbgrdMechanizm.Tag := qrMechanizm.RecNo;

    // закрытие открытой на редактирование строки
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

// Исключает ввод null в числовые поля таблицы сметы
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
    // Пересчет по строке механизма
    try
      CField := Sender.FieldName;
      CValue := Sender.Value;
      CType := 0;

      if (CField = 'MECH_NAME') then
      begin
        qrTemp.SQL.Text := 'UPDATE mechanizmcard_temp set ' + 'MECH_NAME=:MECH_NAME WHERE ID=:ID;';
        qrTemp.ParamByName('ID').Value := qrMechanizmID.Value;
        qrTemp.ParamByName('MECH_NAME').Value := CValue;
        qrTemp.ExecSQL;
        Exit;
      end;

      if (Sender.FieldName = 'MECH_COUNT') then
        CType := 1;

      // Индивидуальное поведение для конкретных полей
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

      // пересчитывается всегда, что-бы не писать кучу условий когда это актуально
      if NDSEstimate then
      begin
        qrMechanizmFCOAST_NO_NDS.Value := NDSToNoNDS1(qrMechanizmFCOAST_NDS.Value, qrMechanizmNDS.Value);
        qrMechanizmFZP_MACH_NO_NDS.Value := NDSToNoNDS1(qrMechanizmFZP_MACH_NDS.Value, qrMechanizmNDS.Value);
        qrMechanizmVFCOAST_NO_NDS.Value := NDSToNoNDS1(qrMechanizmVFCOAST_NDS.Value, qrMechanizmNDS.Value);
        qrMechanizmVFZP_MACH_NO_NDS.Value := NDSToNoNDS1(qrMechanizmVFZP_MACH_NDS.Value, qrMechanizmNDS.Value);
      end
      else
      begin
        qrMechanizmFCOAST_NDS.Value := NoNDSToNDS1(qrMechanizmFCOAST_NO_NDS.Value, qrMechanizmNDS.Value);
        qrMechanizmFZP_MACH_NDS.Value := NoNDSToNDS1(qrMechanizmFZP_MACH_NO_NDS.Value, qrMechanizmNDS.Value);
        qrMechanizmVFCOAST_NDS.Value := NoNDSToNDS1(qrMechanizmVFCOAST_NO_NDS.Value, qrMechanizmNDS.Value);
        qrMechanizmVFZP_MACH_NDS.Value := NoNDSToNDS1(qrMechanizmVFZP_MACH_NO_NDS.Value, qrMechanizmNDS.Value);
      end;

      // После изменения ячейки строка фиксируется
      qrMechanizm.Post;

      // Обновление в базе (так как датасет не связан с базой напрямую)
      qrTemp.Active := False;
      qrTemp.SQL.Clear;
      qrTemp.SQL.Add('UPDATE mechanizmcard_temp SET FCOAST_NO_NDS = :FCOAST_NO_NDS, ' +
        'FCOAST_NDS = :FCOAST_NDS, FZP_MACH_NO_NDS = :FZP_MACH_NO_NDS, ' +
        'FZP_MACH_NDS = :FZP_MACH_NDS, VFCOAST_NO_NDS = :VFCOAST_NO_NDS, ' +
        'VFCOAST_NDS = :VFCOAST_NDS, VFZP_MACH_NO_NDS = :VFZP_MACH_NO_NDS, ' +
        'VFZP_MACH_NDS = :VFZP_MACH_NDS, PROC_ZAC = :PROC_ZAC, ' +
        'PROC_PODR = :PROC_PODR, ' + CField +
        ' = :AA' + CField + ' WHERE id = :id;');
      qrTemp.ParamByName('FCOAST_NO_NDS').Value := qrMechanizmFCOAST_NO_NDS.AsVariant;
      qrTemp.ParamByName('FCOAST_NDS').Value := qrMechanizmFCOAST_NDS.AsVariant;
      qrTemp.ParamByName('FZP_MACH_NO_NDS').Value := qrMechanizmFZP_MACH_NO_NDS.AsVariant;
      qrTemp.ParamByName('FZP_MACH_NDS').Value := qrMechanizmFZP_MACH_NDS.AsVariant;
      qrTemp.ParamByName('VFCOAST_NO_NDS').Value := qrMechanizmVFCOAST_NO_NDS.AsVariant;
      qrTemp.ParamByName('VFCOAST_NDS').Value := qrMechanizmVFCOAST_NDS.AsVariant;
      qrTemp.ParamByName('VFZP_MACH_NO_NDS').Value := qrMechanizmVFZP_MACH_NO_NDS.AsVariant;
      qrTemp.ParamByName('VFZP_MACH_NDS').Value := qrMechanizmVFZP_MACH_NDS.AsVariant;
      qrTemp.ParamByName('PROC_ZAC').Value := qrMechanizmPROC_ZAC.Value;
      qrTemp.ParamByName('PROC_PODR').Value := qrMechanizmPROC_PODR.Value;
      qrTemp.ParamByName('AA' + CField).Value := CValue;
      qrTemp.ParamByName('id').Value := qrMechanizmID.Value;
      qrTemp.ExecSQL;

      // Пересчет по строке механизма
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
  with fCardEstimate do
  begin
    EditingRecord(True);
    fCardEstimate.ShowForm(IdObject, qrRatesExSM_ID.AsInteger, mainType);
    CloseOpen(qrRatesEx);
  end;
end;

procedure TFormCalculationEstimate.mN14Click(Sender: TObject);
var
  fCardObject: TfCardObject;
begin
  fCardObject := TfCardObject.Create(Self);
  try
    fCardObject.IdObject := IdObject;
    fCardObject.ShowModal;
  finally
    FreeAndNil(fCardObject);
  end;
end;

procedure TFormCalculationEstimate.mAddLocalClick(Sender: TObject);
begin
  fCardEstimate.EditingRecord(False);
  fCardEstimate.ShowForm(IdObject, IdEstimate, 1);
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
  fCardEstimate.EditingRecord(False);
  case SM_TYPE of
    1:
      fCardEstimate.ShowForm(IdObject, qrRatesExSM_ID.AsInteger, 3);
    3:
      fCardEstimate.ShowForm(IdObject, PARENT_ID, 3);
  end;
  CloseOpen(qrRatesEx);
end;

// Пересчитывает данные по строке в таблице механизмов
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
    qrMechanizmMECH_NORMA.Value := qrTemp.FieldByName('MECH_NORMA').AsBCD;
    qrMechanizmMECH_COUNT.Value := qrTemp.FieldByName('MECH_COUNT').AsBCD;
    qrMechanizmFPRICE_NO_NDS.Value := qrTemp.FieldByName('FPRICE_NO_NDS').AsBCD;
    qrMechanizmFPRICE_NDS.Value := qrTemp.FieldByName('FPRICE_NDS').AsBCD;
    qrMechanizmFZPPRICE_NO_NDS.Value := qrTemp.FieldByName('FZPPRICE_NO_NDS').AsBCD;
    qrMechanizmFZPPRICE_NDS.Value := qrTemp.FieldByName('FZPPRICE_NDS').AsBCD;
    qrMechanizmVFPRICE_NO_NDS.Value := qrTemp.FieldByName('VFPRICE_NO_NDS').AsBCD;
    qrMechanizmVFPRICE_NDS.Value := qrTemp.FieldByName('VFPRICE_NDS').AsBCD;
    qrMechanizmVFZPPRICE_NO_NDS.Value := qrTemp.FieldByName('VFZPPRICE_NO_NDS').AsBCD;
    qrMechanizmVFZPPRICE_NDS.Value := qrTemp.FieldByName('VFZPPRICE_NDS').AsBCD;
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
        qrRatesExOBJ_COUNT.Value := qrMechanizmMECH_COUNT.AsExtended;
        qrRatesEx.Post;
      finally
        qrRatesExOBJ_COUNT.OnChange := ev;
      end;
    end;
  end;
  qrTemp.Active := False;
  CloseOpen(qrCalculations);
end;

// Пересчет одного материала
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
    qrMaterialFPRICE_NO_NDS.Value := qrTemp.FieldByName('FPRICE_NO_NDS').AsBCD;
    qrMaterialFPRICE_NDS.Value := qrTemp.FieldByName('FPRICE_NDS').AsBCD;
    qrMaterialFTRANSP_NO_NDS.Value := qrTemp.FieldByName('FTRANSP_NO_NDS').AsBCD;
    qrMaterialFTRANSP_NDS.Value := qrTemp.FieldByName('FTRANSP_NDS').AsBCD;
    qrMaterialVFPRICE_NO_NDS.Value := qrTemp.FieldByName('VFPRICE_NO_NDS').AsBCD;
    qrMaterialVFPRICE_NDS.Value := qrTemp.FieldByName('VFPRICE_NDS').AsBCD;
    qrMaterialVFTRANSP_NO_NDS.Value := qrTemp.FieldByName('VFTRANSP_NO_NDS').AsBCD;
    qrMaterialVFTRANSP_NDS.Value := qrTemp.FieldByName('VFTRANSP_NDS').AsBCD;
    qrMaterial.Post;
    if (qrRatesExID_TYPE_DATA.Value = 2) and
       (qrRatesExID_TABLES.Value = qrMaterialID.Value) then
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

  CloseOpen(qrCalculations);
end;

// Пересчет одного оборудование
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
    qrDevicesVFPRICE_NO_NDS.Value := qrTemp.FieldByName('VFPRICE_NO_NDS').AsBCD;
    qrDevicesVFPRICE_NDS.Value := qrTemp.FieldByName('VFPRICE_NDS').AsBCD;
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

// проверка что материал неучтеный в таблице материалов
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
  // Устанавливаем №пп
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
    // grRatesEx.SelectedRows.Clear;
  end;
end;

procedure TFormCalculationEstimate.qrRatesExAfterScroll(DataSet: TDataSet);
begin
  qrCalculationsAfterOpen(qrCalculations);
  // Гасит итератор, все добавляется в конец сметы(отличается от 0 только в режиме вставке строки)
  FNewRowIterator := 0;
  // Гасит собственный номер
  FNewNomManual := 0;
  tmRate.Enabled := False;
  tmRate.Enabled := True;

  // для поля ввода ставит курсор на пользовательский номер
  // if qrRatesExID_TYPE_DATA.Value = -4 then
  // grRatesEx.Col := 2;
end;

procedure TFormCalculationEstimate.qrRatesExBeforeScroll(DataSet: TDataSet);
var
  ev: TDataSetNotifyEvent;
begin
  if (qrRatesExID_TYPE_DATA.Value = -5) then
  begin
    ev := qrRatesEx.BeforeScroll;
    try
      qrRatesEx.BeforeScroll := nil;
      qrRatesEx.Delete;
      grRatesEx.SelectedRows.Clear;
      Abort;
    finally
      qrRatesEx.BeforeScroll := ev;
    end;
  end;

  if (qrRatesExID_TYPE_DATA.Value = -4) and ((qrRatesExNOM_ROW_MANUAL.AsVariant <> Null) or
    (qrRatesExOBJ_CODE.AsVariant <> Null)) then
  begin
    qrRatesEx.Edit;
    qrRatesExNOM_ROW_MANUAL.AsVariant := Null;
    qrRatesEx.Edit;
    qrRatesExOBJ_CODE.AsVariant := Null;
    qrRatesEx.Post;
  end;
end;

procedure TFormCalculationEstimate.qrRatesExCalcFields(DataSet: TDataSet);
// Функция считает сколько добавленных материалов/механизмов в расценке
  function GetAddedCount(const ID_CARD_RATE: Integer): Integer;
  begin
    Result := 0;
    DM.qrDifferent.SQL.Text :=
      'SELECT ADDED FROM materialcard_temp WHERE ID_CARD_RATE=:ID_CARD_RATE AND ADDED=1 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('ADDED').AsInteger;
    // Если уже что то нашли, то можно дальше не производить лишних действий
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
    // Если уже что то нашли, то можно дальше не производить лишних действий
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

function TFormCalculationEstimate.GetSMSubType(ASM_ID: Integer): Integer;
begin
  Result := 0; // Условный тип сметы в который можно добавлять все
  qrTemp.Active := False;
  qrTemp.SQL.Clear;
  qrTemp.SQL.Text := 'Select SM_SUBTYPE from smetasourcedata where SM_ID = ' +
    '(Select PARENT_ID from smetasourcedata where SM_ID = :SM_ID)';
  qrTemp.ParamByName('SM_ID').Value := qrRatesExSM_ID.Value;
  qrTemp.Active := True;
  try
    if not qrTemp.Eof then
      Result := qrTemp.Fields[0].AsInteger;
  finally
    qrTemp.Active := False;
  end;
  if ((Result = 1) and (PS.AddRateType1ToLocal)) or ((Result = 2) and (PS.AddRateType0ToPNR)) then
    Result := 0;
end;

procedure TFormCalculationEstimate.qrRatesExCODEChange(Sender: TField);
var
  NewCode: string;
  newID: Integer;
  Point: TPoint;
  MatType: Integer;
  MatStr: string;
  MesRes: Integer;
  TmpSprRec: TSprRecord;
begin
  try
    if qrRatesExID_TYPE_DATA.Value > 0 then
      FReplaceRowID := qrRatesExDATA_ESTIMATE_OR_ACT_ID.Value;

    NewCode := Trim(AnsiUpperCase(qrRatesExOBJ_CODE.AsString));

    if Length(NewCode) = 0 then
      Exit;

    grRatesEx.EditorMode := False;
    newID := 0;

    // Замена литинских на кирилические
    if (NewCode[1] = 'Е') or
       (NewCode[1] = 'E') or
       (NewCode[1] = 'У') or
       (NewCode[1] = 'T') or
       (NewCode[1] = 'Ц') or
       (NewCode[1] = 'W') or
       (NewCode[1] = '0') then // E кирилическая и латинская
    begin
      if (NewCode[1] = 'E') or (NewCode[1] = 'T') or (NewCode[1] = 'У') then
        NewCode[1] := 'Е'; // E кирилическая
      if NewCode[1] = 'W' then
        NewCode[1] := 'Ц';

      case GetSMSubType(qrRatesExSM_ID.Value) of
        1:
          if NewCode[1] = '0' then
          begin
            MessageBox(0, 'Ввод пусконаладки не допустим!', PChar(FMesCaption),
              MB_ICONINFORMATION + MB_OK + mb_TaskModal);
            qrRatesExOBJ_CODE.AsString := '';
            Exit;
          end;
        2:
          if NewCode[1] <> '0' then
          begin
            MessageBox(0, 'Ввод расценки не допустим!', PChar(FMesCaption),
              MB_ICONINFORMATION + MB_OK + mb_TaskModal);
            qrRatesExOBJ_CODE.AsString := '';
            Exit;
          end;
      end;

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
          newID := qrTemp.Fields[0].AsInteger;
      end;
      qrTemp.Active := False;
      if newID = 0 then
      begin
        if NewCode[1] = '0' then
          MesRes := MessageBox(0, 'Пусконаладка с указанным кодом не найдена!' + sLineBreak +
            'Открыть справочник?', PChar(FMesCaption), MB_ICONINFORMATION + MB_OKCANCEL + mb_TaskModal)
        else
          MesRes := MessageBox(0, 'Расценка с указанным кодом не найдена!' + sLineBreak +
            'Открыть справочник?', PChar(FMesCaption), MB_ICONINFORMATION + MB_OKCANCEL + mb_TaskModal);

        if MesRes = mrOk then
          PMAddRatMatMechEquipOwnClick(nil);

        Exit;
      end;

      AddRate(newID);
      Exit;
    end;

    // перевозка грузов и мусора
    if (Length(NewCode) >= 4) and ((NewCode[1] = 'С') or (NewCode[1] = 'C')) and
      ((Copy(NewCode, 2, 3) = '310') or (Copy(NewCode, 2, 3) = '311')) then
    begin
      if (Copy(NewCode, 2, 3) = '310') then
      begin
        pmAddTranspCargo.Tag := 6;
        pmAddTranspTrash.Tag := 7;
      end
      else
      begin
        pmAddTranspCargo.Tag := 8;
        pmAddTranspTrash.Tag := 9;
      end;
      qrRatesExOBJ_CODE.AsString := '';
      grRatesEx.EditorMode := True;

      FTranspDistance := StrToIntDef(Copy(NewCode, 6, 255), 0);

      Point.X := grRatesEx.CellRect(grRatesEx.Col, grRatesEx.Row).Left;
      Point.Y := grRatesEx.CellRect(grRatesEx.Col, grRatesEx.Row).Bottom + 1;
      pmAddTransp.Popup(grRatesEx.ClientToScreen(Point).X, grRatesEx.ClientToScreen(Point).Y);
      Exit;
    end;

    // перевозка грузов и мусора
    if (Length(NewCode) >= 2) and (Copy(NewCode, 1, 2) = 'БС') then
    begin
      qrRatesExOBJ_CODE.AsString := '';
      grRatesEx.EditorMode := True;
      PMAddDumpClick(nil);
      Exit;
    end;

    if (NewCode[1] = 'С') or (NewCode[1] = 'C') or // C кирилическая и латинская
      ((Length(NewCode) > 1) and (NewCode[1] = '5') and CharInSet(NewCode[2], ['7', '8'])) then
    begin
      if NewCode[1] = 'C' then
        NewCode[1] := 'С';

      if (NewCode[1] = 'С') then
      begin
        MatType := CMatIndex;
        MatStr := 'Материал'
      end
      else
      begin
        MatType := CJBIIndex;
        MatStr := 'ЖБИ';
      end;

      qrTemp.Active := False;
      qrTemp.SQL.Clear;
      qrTemp.SQL.Add('SELECT MATERIAL_ID FROM material WHERE MAT_CODE = :CODE;');
      qrTemp.ParamByName('CODE').Value := NewCode;
      qrTemp.Active := True;
      if not qrTemp.IsEmpty then
        newID := qrTemp.Fields[0].AsInteger;
      qrTemp.Active := False;
      if newID = 0 then
      begin
        if MessageBox(0, PChar(MatStr + ' с указанным кодом не найден! ' + sLineBreak + 'Добавить новый ' +
          MatStr.ToLower + ' в справочник?'), PChar(FMesCaption), MB_ICONINFORMATION + MB_OKCANCEL +
          mb_TaskModal) = mrOk then
          SprManualData(MatType, NewCode, newID);
        if newID = 0 then
          Exit;
      end;

      AddMaterial(newID, 0, 0, TmpSprRec);
      Exit;
    end;

    if (NewCode[1] = 'М') or (NewCode[1] = 'M') or (NewCode[1] = 'V') then // M кирилическая и латинская
    begin
      if (NewCode[1] = 'M') or (NewCode[1] = 'V') then
        NewCode[1] := 'М';
      qrTemp.Active := False;
      qrTemp.SQL.Clear;
      qrTemp.SQL.Add('SELECT MECHANIZM_ID FROM mechanizm WHERE MECH_CODE = :CODE;');
      qrTemp.ParamByName('CODE').Value := NewCode;
      qrTemp.Active := True;
      if not qrTemp.IsEmpty then
        newID := qrTemp.Fields[0].AsInteger;
      qrTemp.Active := False;
      if newID = 0 then
      begin
        if MessageBox(0, PChar('Механизм с указанным кодом не найден! ' + sLineBreak +
          'Добавить новый механизм в справочник?'), PChar(FMesCaption), MB_ICONINFORMATION + MB_OKCANCEL +
          mb_TaskModal) = mrOk then
          SprManualData(CMechIndex, NewCode, newID);
        if newID = 0 then
          Exit;
      end;

      AddMechanizm(newID, 0, 0, TmpSprRec);
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
        newID := qrTemp.Fields[0].AsInteger;
      qrTemp.Active := False;
      if newID = 0 then
      begin
        if MessageBox(0, PChar('Оборудование с указанным кодом не найдено!' + sLineBreak +
          'Добавить новое оборудование в справочник?'), PChar(FMesCaption), MB_ICONINFORMATION + MB_OKCANCEL +
          mb_TaskModal) = mrOk then
          SprManualData(CDevIndex, NewCode, newID);

        if newID = 0 then
          Exit;
      end;
      AddDevice(newID, 0, 0, TmpSprRec);
      Exit;
    end;

    MessageBox(0, 'По указанному коду ничего не найдено!', PChar(FMesCaption),
      MB_ICONINFORMATION + MB_OK + mb_TaskModal);
  finally
    if (qrRatesExID_TYPE_DATA.Value > 0) and (qrRatesEx.State in [dsEdit]) then
      qrRatesEx.Cancel;
  end;
end;

procedure TFormCalculationEstimate.qrRatesExCOUNTChange(Sender: TField);
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    Exit;
  end;

  case qrRatesExID_TYPE_DATA.AsInteger of
    1:
      qrTemp.SQL.Text := 'UPDATE card_rate_temp set rate_count=:RC WHERE ID=:ID;';
    2:
      qrTemp.SQL.Text := 'UPDATE materialcard_temp set mat_count=:RC WHERE ID=:ID;';
    3:
      qrTemp.SQL.Text := 'UPDATE mechanizmcard_temp set MECH_COUNT=:RC WHERE ID=:ID;';
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
      ShowMessage('Запрос обновления не реализован!');
      Exit;
    end;
  end;
  if not(qrRatesExID_TYPE_DATA.AsInteger in [10, 11]) then
    qrTemp.ParamByName('ID').Value := qrRatesExID_TABLES.AsInteger;
  qrTemp.ParamByName('RC').Value := Sender.Value;
  qrTemp.ExecSQL;
  // Пересчитывает все величины по данной строке
  ReCalcRowRates;
  if PS.AutoScrollToNextRow then
  begin
    qrRatesEx.DisableControls;
    try
      // Переходим на следующую строку после ввода кол-ва
      qrRatesEx.Next;
      // ...в колонку ввода кода расценки
      grRatesEx.Col := 3;
    finally
      grRatesEx.SelectedRows.Clear;
      qrRatesEx.EnableControls;
    end;
  end;
end;

procedure TFormCalculationEstimate.qrRatesExMarkRowChange(Sender: TField);
begin
  FastExecSQL('UPDATE data_row_temp set MarkRow=:MarkRow WHERE ID=:ID;',
    VarArrayOf([Sender.Value, qrRatesExDATA_ESTIMATE_OR_ACT_ID.AsInteger]));
end;

procedure TFormCalculationEstimate.qrRatesExNOM_ROW_MANUALChange(Sender: TField);
var
  AutoCommitValue: Boolean;
  ev: TDataSetNotifyEvent;
  Col: Integer;
begin
  qrRatesEx.Post;

  if qrRatesExID_TYPE_DATA.Value > 0 then
  begin
    qrRatesEx.DisableControls;
    Col := grRatesEx.Col;
    ev := qrRatesEx.AfterScroll;
    AutoCommitValue := DM.Read.Options.AutoCommit;
    try
      DM.Read.Options.AutoCommit := False;
      qrRatesEx.AfterScroll := nil;

      DM.Read.StartTransaction;
      try
        qrTemp.SQL.Text := 'UPDATE data_row_temp set NOM_ROW_MANUAL=:VAL WHERE ID=:ID;';
        qrTemp.ParamByName('ID').Value := qrRatesExDATA_ESTIMATE_OR_ACT_ID.AsInteger;
        qrTemp.ParamByName('VAL').Value := Sender.Value;
        qrTemp.ExecSQL;

        qrTemp.SQL.Text := 'CALL UpdateNomManual(:SM_ID, 0, 0);';
        qrTemp.ParamByName('SM_ID').Value := qrRatesExSM_ID.Value;
        qrTemp.ExecSQL;

        OutputDataToTable(False);

        DM.Read.Commit;
      except
        DM.Read.Rollback;
        raise;
      end;
    finally
      DM.Read.Options.AutoCommit := AutoCommitValue;
      qrRatesEx.AfterScroll := ev;
      grRatesEx.Col := Col;
      qrRatesEx.EnableControls;
    end;
  end
  else
    // будет использовано в Add процедурах
    // позволяет ввести номер до добавления строки
    if (qrRatesExID_TYPE_DATA.Value = -4) or (qrRatesExID_TYPE_DATA.Value = -5) then
      FNewNomManual := Sender.AsInteger;

  if grRatesEx.Col = 2 then
    grRatesEx.Col := 3;
end;

procedure TFormCalculationEstimate.qrRatesWORK_IDChange(Sender: TField);
begin
  FastExecSQL('UPDATE card_rate_temp SET WORK_ID = :p1 WHERE ID = :p2',
    VarArrayOf([qrRatesExWORK_ID.Value, qrRatesExID_TABLES.Value]));
  CloseOpen(qrCalculations);
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

// пересчитывает все относящееся к строке в таблице расценок
procedure TFormCalculationEstimate.ReCalcRowRates;
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'CALL CalcRowInRateTab(:ID, :TYPE, :CalcMode);';
  qrTemp.ParamByName('ID').Value := qrRatesExID_TABLES.Value;
  qrTemp.ParamByName('TYPE').Value := qrRatesExID_TYPE_DATA.Value;
  qrTemp.ParamByName('CalcMode').Value := G_CALCMODE;
  qrTemp.ExecSQL;

  // Для расценок обновляется кол-во у заменяющих материалов
  GridRatesUpdateCount;

  GridRatesRowLoad;

  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.GridRatesUpdateCount;
var
  TempBookmark: TBookMark;
  NewCount: Currency;
  RateID: Integer;
  ev: TDataSetNotifyEvent;
  ev2: TFieldNotifyEvent;

begin
  if qrRatesExID_TYPE_DATA.AsInteger = 1 then
  begin
    TempBookmark := qrRatesEx.GetBookmark;
    RateID := qrRatesExID_TABLES.Value;

    qrRatesEx.DisableControls;
    ev := qrRatesEx.AfterScroll;
    ev2 := qrRatesExOBJ_COUNT.OnChange;
    try
      qrRatesEx.AfterScroll := nil;
      qrRatesExOBJ_COUNT.OnChange := nil;

      if not qrRatesEx.Eof then
        qrRatesEx.Next;

      qrTemp.Active := False;

      while not qrRatesEx.Eof do
      begin
        if RateID = qrRatesExID_RATE.Value then
        begin
          if (qrRatesExID_TYPE_DATA.Value = 2) and (qrRatesExID_REPLACED.Value > 0) and
            (qrRatesExCONS_REPLASED.Value = 0) then
          begin
            NewCount := 0;
            qrTemp.SQL.Text := 'Select MAT_COUNT FROM materialcard_temp WHERE ID = ' +
              INTTOSTR(qrRatesExID_TABLES.AsInteger);
            qrTemp.Active := True;
            if not qrTemp.Eof then
              NewCount := qrTemp.Fields[0].Value;
            qrTemp.Active := False;

            qrRatesEx.Edit;
            qrRatesExOBJ_COUNT.Value := NewCount;
            qrRatesEx.Post;
          end;
        end
        else
          Break; // так как датасет отсортирован
        qrRatesEx.Next;
      end;
      qrRatesEx.GotoBookmark(TempBookmark);
      qrRatesEx.FreeBookmark(TempBookmark);
    finally
      qrRatesExOBJ_COUNT.OnChange := ev2;
      qrRatesEx.AfterScroll := ev;
      qrRatesEx.EnableControls;
    end;
  end;
end;

procedure TFormCalculationEstimate.grRatesExCanEditCell(Grid: TJvDBGrid; Field: TField;
  var AllowEdit: Boolean);
begin
  AllowEdit := Editable;
  if ((Field = qrRatesExOBJ_CODE) and (qrRatesExID_TYPE_DATA.Value <> -4) and
    (qrRatesExID_TYPE_DATA.Value <> -5) and (qrRatesExID_TYPE_DATA.Value < 0)) or
    ((Field = qrRatesExNOM_ROW_MANUAL) and ((qrRatesExID_TYPE_DATA.Value = -1) or
    (qrRatesExID_TYPE_DATA.Value = -2) or (qrRatesExID_TYPE_DATA.Value = -3))) or (Grid.Col = 1) then
    AllowEdit := False;
end;

procedure TFormCalculationEstimate.grRatesExEnter(Sender: TObject);
begin
  SetNoEditMode;
  dbgrdEnter(Sender);
end;

procedure TFormCalculationEstimate.grRatesExExit(Sender: TObject);
begin
  (Sender as TJvDBGrid).DataSource.DataSet.CheckBrowseMode;
end;

procedure TFormCalculationEstimate.grRatesExSelectColumns(Grid: TJvDBGrid; var DefaultDialog: Boolean);
var
  R, WorkArea: TRect;
  Frm: TfSelectColumn;
  Pt: TPoint;
  CheckColumns: TCheckColumnArray;
  i: Integer;
begin
  if grRatesEx.Columns.Count >= 5 then
  begin
    SetLength(CheckColumns, 5);

    for i := Low(CheckColumns) to High(CheckColumns) do
    begin
      CheckColumns[i].Key := Grid.Columns[i].Visible;
      CheckColumns[i].Value := Grid.Columns[i].Title.Caption;
    end;

    R := Grid.CellRect(0, 0);
    Frm := TfSelectColumn.Create(Application);
    try
      if not IsRectEmpty(R) then
      begin
        Pt := Grid.ClientToScreen(Point(R.Left, R.Bottom + 1));
        WorkArea := Screen.MonitorFromWindow(Handle).WorkareaRect;
        if Pt.X + Frm.Width > WorkArea.Right then
          Pt.X := WorkArea.Right - Frm.Width;
        if Pt.Y + Frm.Height > WorkArea.Bottom then
          Pt.Y := WorkArea.Bottom - Frm.Height;
        Frm.SetBounds(Pt.X, Pt.Y, Frm.Width, Frm.Height);
      end;
      Frm.Columns := CheckColumns;
      if Frm.ShowModal = mrOk then
      begin
        for i := Low(CheckColumns) to High(CheckColumns) do
          Grid.Columns[i].Visible := CheckColumns[i].Key;
      end;
    finally
      DefaultDialog := Frm.DefaultDialog;
      FreeAndNil(Frm);
    end;
    Grid.Invalidate;
  end;
end;

procedure TFormCalculationEstimate.ReplacementClick(Sender: TObject);
var
  frmReplace: TfrmReplacement;
begin
  case TMenuItem(Sender).Tag of
    0:
      frmReplace := TfrmReplacement.Create(IdEstimate, 0, qrMaterialID.AsInteger, 0, 2, False, False);
    1:
      frmReplace := TfrmReplacement.Create(IdEstimate, 0, qrMechanizmID.AsInteger, 0, 3, False, False);
    2:
      frmReplace := TfrmReplacement.Create(IdEstimate, 0, qrDevicesID.AsInteger, 0, 4, False, False);
  else
    Exit;
  end;

  if Assigned(frmReplace) then
    try
      if Height > 700 then
        frmReplace.Height := 700
      else
        frmReplace.Height := Height;

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
var
  res: Variant;
begin
  if (not Assigned(fWinterPrice)) then
    fWinterPrice := TfWinterPrice.Create(Self);
  fWinterPrice.FormKind := kdSelect;
  fWinterPrice.LicateID := qrRatesExZNORMATIVS_ID.Value;
  res := FastSelectSQLOne('SELECT ZNORMATIVS_ONDATE_ID FROM card_rate_temp WHERE ID=:ID',
    VarArrayOf([qrRatesExID_TABLES.AsInteger]));
  if VarIsNull(res) then
    res := 0;
  fWinterPrice.Licate_ONDATE_ID := res;

  if (fWinterPrice.ShowModal = mrOk) and (fWinterPrice.OutValue <> 0) then
  begin
    FastExecSQL
      ('UPDATE card_rate_temp SET ZNORMATIVS_ID=:ZNORMATIVS_ID, ZNORMATIVS_ONDATE_ID=:ZNORMATIVS_ONDATE_ID WHERE ID=:ID',
      VarArrayOf([fWinterPrice.OutValue, fWinterPrice.ZNORMATIVS_ONDATE_ID, qrRatesExID_TABLES.AsInteger]));
    qrRatesExZNORMATIVS_ID.Value := fWinterPrice.OutValue;
    FillingWinterPrice('');
    CloseOpen(qrCalculations);
  end;
end;

procedure TFormCalculationEstimate.nWinterPriseSetDefaultClick(Sender: TObject);
begin
  if Application.MessageBox('Вы действительно хотите заменить коэф. зимнего удорожания в выбранной расценке?',
    'Application.Title', MB_OKCANCEL + MB_ICONQUESTION + MB_TOPMOST) = IDOK then
  begin
    FastExecSQL('UPDATE card_rate_temp SET ZNORMATIVS_ID=NULL WHERE ID=:ID',
      VarArrayOf([qrRatesExID_TABLES.AsInteger]));
    qrRatesExZNORMATIVS_ID.Value := 0;
    edtWinterPrice.Text := '';
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
  if (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'FCOAST_NDS') then
    FCalculator.ShowCalculator(dbgrdMaterial, qrMaterialFCOAST_NDS.Value,
      qrMaterialMAT_COUNT.Value,
      qrMaterialFPRICE_NDS.Value,
      qrMaterialNDS.Value, 'FCOAST_NDS');

  if (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'VFCOAST_NDS') then
    FCalculator.ShowCalculator(dbgrdMaterial, qrMaterialVFCOAST_NDS.Value,
      qrMaterialMAT_COUNT.Value,
      qrMaterialVFPRICE_NDS.Value,
      qrMaterialNDS.Value, 'VFCOAST_NDS');
end;

procedure TFormCalculationEstimate.PMCalcMechClick(Sender: TObject);
begin
  if (dbgrdMechanizm.Columns[dbgrdMechanizm.Col - 1].FieldName = 'FCOAST_NDS') then
    FCalculator.ShowCalculator(dbgrdMechanizm, qrMechanizmFCOAST_NDS.Value,
      qrMechanizmMECH_COUNT.Value,
      qrMechanizmFPRICE_NDS.Value,
      qrMechanizmNDS.Value, 'FCOAST_NDS');

  if (dbgrdMechanizm.Columns[dbgrdMechanizm.Col - 1].FieldName = 'VFCOAST_NDS') then
    FCalculator.ShowCalculator(dbgrdMechanizm, qrMechanizmVFCOAST_NDS.Value,
      qrMechanizmMECH_COUNT.Value,
      qrMechanizmVFPRICE_NDS.Value,
      qrMechanizmNDS.Value, 'VFCOAST_NDS');
end;

procedure TFormCalculationEstimate.PMCopyClick(Sender: TObject);
var
  DataObj: TSmClipData;
  TempBookmark: TBookMark;
  i, j: Integer;
begin
  if grRatesEx.EditorMode then
  begin
    grRatesEx.InplaceEditor.CopyToClipboard;
    Exit;
  end;

  if Act then
    Exit;

  if grRatesEx.SelectedRows.Count = 0 then
    grRatesEx.SelectedRows.CurrentRowSelected := True;

  DataObj := TSmClipData.Create;
  grRatesEx.DataSource.DataSet.DisableControls;
  TempBookmark := grRatesEx.DataSource.DataSet.GetBookmark;
  try
    with grRatesEx.SelectedRows do
      if Count <> 0 then
      begin
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
              DataObj.SmClipArray[j].RateType := 0;
              if DataObj.SmClipArray[j].DataType = 1 then
              begin
                qrTemp.Active := False;
                qrTemp.SQL.Text := 'Select NORM_TYPE from card_rate_temp ' + 'where ID = ' +
                  DataObj.SmClipArray[j].DataID.ToString;
                qrTemp.Active := True;
                try
                  if not qrTemp.Eof then
                    DataObj.SmClipArray[j].RateType := qrTemp.Fields[0].AsInteger;
                finally
                  qrTemp.Active := False;
                end;
              end;

            end;
          end;
        end;
        DataObj.CopyToClipboard;
      end;
  finally
    grRatesEx.DataSource.DataSet.GotoBookmark(TempBookmark);
    grRatesEx.DataSource.DataSet.FreeBookmark(TempBookmark);
    grRatesEx.DataSource.DataSet.EnableControls;
    DataObj.Free;
  end;
end;

procedure TFormCalculationEstimate.pmCopyFromSMClick(Sender: TObject);
begin
  if (Assigned(FormCopyEstimRow)) then
  begin
    FormCopyEstimRow.Show;
    Exit;
  end;

  DM.FDGUIxWaitCursor1.ScreenCursor := gcrHourGlass;
  try
    SendMessage(Application.MainForm.ClientHandle, WM_SETREDRAW, 0, 0);
    FormCopyEstimRow := TFormCopyEstimRow.Create(Self);
    FormCopyEstimRow.OnCopyRowsToSM := CopyRowsToSM;
    FormCopyEstimRow.WindowState := wsNormal;

    PozWindow(FormCopyEstimRow);
  finally
    SendMessage(Application.MainForm.ClientHandle, WM_SETREDRAW, 1, 0);
    RedrawWindow(Application.MainForm.ClientHandle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN or
      RDW_NOINTERNALPAINT);
    DM.FDGUIxWaitCursor1.ScreenCursor := gcrDefault;
  end;
end;

procedure TFormCalculationEstimate.CopyRowsToSM(ASmClipData: TSmClipData);
var TmpIterator: Integer;
begin
  if not((qrRatesExID_TYPE_DATA.AsInteger > 0) or
         (qrRatesExID_TYPE_DATA.AsInteger = -5) or
         (qrRatesExID_TYPE_DATA.AsInteger = -4) or
         (qrRatesExID_TYPE_DATA.AsInteger = -3)) then
  begin
    raise Exception.Create('Вставка не может быть выполненена в текущаю строку.');
  end;

  TmpIterator := qrRatesExITERATOR.Value;
  if FNewRowIterator > 0 then
    TmpIterator := FNewRowIterator;

  if PasteSmetaRow(ASmClipData.SmClipArray, qrRatesExSM_ID.Value, TmpIterator,
    GetSMSubType(qrRatesExSM_ID.Value)) then
    OutputDataToTable(True);
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

  frmReplace := TfrmReplacement.Create(IdEstimate, IdRate, 0, 0, TMenuItem(Sender).Tag, True, False);

  try
    if (frmReplace.ShowModal = mrYes) then
      OutputDataToTable;
  finally
    FreeAndNil(frmReplace);
  end;
end;

procedure TFormCalculationEstimate.PMMatDeleteClick(Sender: TObject);
begin
  if MessageBox(0, PChar('Вы действительно хотите удалить ' + qrMaterialMAT_CODE.AsString + '?'),
    PChar(FMesCaption), MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
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

    // Вызываем расчет

  except
    on e: Exception do
      MessageBox(0, PChar('При удалении материала возникла ошибка:' + sLineBreak + sLineBreak + e.Message),
        PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  OutputDataToTable;
end;

procedure TFormCalculationEstimate.PMMatManPriceClick(Sender: TObject);
var
  fmPrice: TfmManPriceSelect;
  TmpDataType, TmpSprID: Integer;
  TmpCode, TmpUnit, TmpName: string;
begin
  TmpDataType := (Sender as TComponent).Tag;
  case TmpDataType of
    2:
      begin
        TmpSprID := qrMaterialMAT_ID.Value;
        TmpCode := qrMaterialMAT_CODE.AsString;
        TmpUnit := qrMaterialMAT_UNIT.AsString;
        TmpName := qrMaterialMAT_NAME.AsString;
      end;
    3:
      begin
        TmpSprID := qrMechanizmMECH_ID.Value;
        TmpCode := qrMechanizmMECH_CODE.AsString;
        TmpUnit := qrMechanizmMECH_UNIT.AsString;
        TmpName := qrMechanizmMECH_NAME.AsString;
      end;
    4:
      begin
        TmpSprID := qrDevicesDEVICE_ID.Value;
        TmpCode := qrDevicesDEVICE_CODE.AsString;
        TmpUnit := qrDevicesDEVICE_UNIT.AsString;
        TmpName := qrDevicesDEVICE_NAME.AsString;
      end;
  else
    raise Exception.Create('Неизвестный тип данных.');
  end;

  fmPrice := TfmManPriceSelect.Create(Self, TmpSprID, TmpDataType, TmpCode, TmpUnit, TmpName);
  try
    if fmPrice.ShowModal = mrOk then
    begin
      case TmpDataType of
        2:
          begin
            qrMaterial.Edit;
            if NDSEstimate then
              qrMaterialFCOAST_NDS.Value := fmPrice.CoastNDS
            else
              qrMaterialFCOAST_NO_NDS.Value := fmPrice.CoastNoNDS;
          end;
        3:
          begin
            qrMechanizm.Edit;
            if NDSEstimate then
              qrMechanizmFCOAST_NDS.Value := fmPrice.CoastNDS
            else
              qrMechanizmFCOAST_NO_NDS.Value := fmPrice.CoastNoNDS;
          end;
        4:
          begin
            qrDevices.Edit;
            if NDSEstimate then
              qrDevicesFCOAST_NDS.Value := fmPrice.CoastNDS
            else
              qrDevicesFCOAST_NO_NDS.Value := fmPrice.CoastNoNDS;
          end;
      end;
    end;
  finally
    FreeAndNil(fmPrice);
  end;
end;

procedure TFormCalculationEstimate.PMMatMechEditClick(Sender: TObject);
begin
  if TMenuItem(Sender).Tag = 1 then
    SetMechEditMode
  else
    SetMatEditMode;
end;

procedure TFormCalculationEstimate.PMMatNormPriceClick(Sender: TObject);
begin
  if (Sender as TMenuItem).Tag = 1 then
  begin
    qrMaterial.Edit;
    if NDSEstimate then
      qrMaterialFCOAST_NDS.Value := qrMaterialCOAST_NDS.Value
    else
      qrMaterialFCOAST_NO_NDS.Value := qrMaterialCOAST_NO_NDS.Value;
  end;

  if (Sender as TMenuItem).Tag = 2 then
  begin
    qrMechanizm.Edit;
    if NDSEstimate then
    begin
      qrMechanizmFZP_MACH_NDS.Value := qrMechanizmZP_MACH_NDS.Value;
      qrMechanizm.Edit;
      qrMechanizmFCOAST_NDS.Value := qrMechanizmCOAST_NDS.Value;
    end
    else
    begin
      qrMechanizmFZP_MACH_NO_NDS.Value := qrMechanizmZP_MACH_NO_NDS.Value;
      qrMechanizm.Edit;
      qrMechanizmFCOAST_NO_NDS.Value := qrMechanizmCOAST_NO_NDS.Value;
    end;
  end;
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
      MessageBox(0, PChar('При восстановлении материала возникла ошибка:' + sLineBreak + sLineBreak +
        e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.PMMatSprCardClick(Sender: TObject);
var
  SprType: Integer;
  TmpID: Integer;
begin
  case (Sender as TComponent).Tag of
    2:
      begin
        TmpID := qrMaterialMAT_ID.AsInteger;
        SprType := CMatIndex;
        if qrMaterialMAT_TYPE.AsInteger = 2 then
          SprType := CJBIIndex;
      end;
    3:
      begin
        TmpID := qrMechanizmMECH_ID.AsInteger;
        SprType := CMechIndex;
      end;
    4:
      begin
        TmpID := qrDevicesDEVICE_ID.AsInteger;
        SprType := CDevIndex;
      end
  else
    raise Exception.Create('Неизвестный тип данных.');
  end;

  SprManualData(SprType, '', TmpID);
end;

procedure TFormCalculationEstimate.PMMatFromRatesClick(Sender: TObject);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL FromRareMaterial(:id_estimate, :id_mat, 0, :CalcMode);');
      ParamByName('id_estimate').Value := qrRatesExSM_ID.AsInteger;
      ParamByName('id_mat').Value := qrMaterialID.AsInteger;
      ParamByName('CalcMode').Value := G_CALCMODE;
      ExecSQL;
    end;

    OutputDataToTable;
  except
    on e: Exception do
      MessageBox(0, PChar('При вынесении материала из расценки возникла ошибка:' + sLineBreak + sLineBreak +
        e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// Открытие строчки механизмов на редактирование
procedure TFormCalculationEstimate.PMMechAutoRepClick(Sender: TObject);
begin
  (Sender as TMenuItem).Checked := not(Sender as TMenuItem).Checked;
end;

procedure TFormCalculationEstimate.PMMechDeleteClick(Sender: TObject);
begin
  if MessageBox(0, PChar('Вы действительно хотите удалить ' + qrMechanizmMECH_CODE.AsString + '?'),
    PChar(FMesCaption), MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
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
      MessageBox(0, PChar('При удалении механизма возникла ошибка:' + sLineBreak + sLineBreak + e.Message),
        PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  OutputDataToTable;
end;

// включение режима расширенного редактирования механизма
procedure TFormCalculationEstimate.SetMechEditMode;
var
  i: Integer;
begin
  if CheckMechReadOnly then
    Exit;

  for i := 0 to dbgrdMechanizm.Columns.Count - 1 do
    if (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'MECH_NAME') or
      (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'MECH_NORMA') or
      (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'MECH_COUNT') or
      (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'FCOAST_NDS') or
      (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'FCOAST_NO_NDS') or
      (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'FZP_MACH_NDS') or
      (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'FZP_MACH_NO_NDS') or
      (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'NORMATIV') or
      (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'NDS') then
      dbgrdMechanizm.Columns[i].ReadOnly := False;

  dbmmoRight.Color := $00AFFEFC;
  dbmmoRight.ReadOnly := False;

  FMechInEditMode := True;
end;

// отключение режима расширенного редактирования механизма
procedure TFormCalculationEstimate.SetMechNoEditMode;
var
  i: Integer;
begin
  if FMechInEditMode then
  begin
    for i := 0 to dbgrdMechanizm.Columns.Count - 1 do
      if (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'MECH_NAME') or
        (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'MECH_NORMA') or
        (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'MECH_COUNT') or
        (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'FCOAST_NDS') or
        (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'FCOAST_NO_NDS') or
        (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'FZP_MACH_NDS') or
        (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'FZP_MACH_NO_NDS') or
        (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'NORMATIV') or
        (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'NDS') then
        dbgrdMechanizm.Columns[i].ReadOnly := True;

    dbmmoRight.Color := clWindow;
    dbmmoRight.ReadOnly := True;

    FMechInEditMode := False;
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
      MessageBox(0, PChar('При вынесении механизма из расценки возникла ошибка:' + sLineBreak + sLineBreak +
        e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
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
      MessageBox(0, PChar('При восстановлении механизма возникла ошибка:' + sLineBreak + sLineBreak +
        e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.PMNumRowClick(Sender: TObject);
var
  TmpSmType: Integer;
begin
  TmpSmType := 0;
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'SELECT SM_TYPE FROM smetasourcedata ' + 'WHERE (SM_ID = ' + FIdEstimate.ToString + ')';
  qrTemp.Active := True;
  if not qrTemp.Eof then
  begin
    TmpSmType := qrTemp.Fields[0].AsInteger;
  end;
  qrTemp.Active := False;

  PMRenumSelected.Enabled := grRatesEx.SelectedRows.Count > 1;
  PMRenumPTM.Enabled := (TmpSmType = 3);
  PMRenumCurSmet.Enabled := TmpSmType in [1, 2];
  PMRenumFromCurRowToSM.Enabled := PMRenumCurSmet.Enabled and (qrRatesExID_TYPE_DATA.Value > 0) and
    (qrRatesExNOM_ROW_MANUAL.Value > 0);
  PMRenumAllList.Enabled := TmpSmType = 2;
end;

procedure TFormCalculationEstimate.PMPasteClick(Sender: TObject);
var
  DataObj: TSmClipData;
  TmpIterator: Integer;
begin
  if grRatesEx.EditorMode then
  begin
    grRatesEx.InplaceEditor.PasteFromClipboard;
    Exit;
  end;

  if not((qrRatesExID_TYPE_DATA.AsInteger > 0) or
         (qrRatesExID_TYPE_DATA.AsInteger = -5) or
         (qrRatesExID_TYPE_DATA.AsInteger = -4) or
         (qrRatesExID_TYPE_DATA.AsInteger = -3)) then
    raise Exception.Create('Вставка не может быть выполненена в текущаю строку.');

  DataObj := TSmClipData.Create;
  try
    if ClipBoard.HasFormat(G_SMETADATA) then
    begin
      DataObj.GetFromClipBoard;
      TmpIterator := qrRatesExITERATOR.Value;
      if FNewRowIterator > 0 then
        TmpIterator := FNewRowIterator;

      if PasteSmetaRow(DataObj.SmClipArray, qrRatesExSM_ID.Value, TmpIterator,
        GetSMSubType(qrRatesExSM_ID.Value)) then
        OutputDataToTable(True);
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

procedure TFormCalculationEstimate.PMRenumCurSmetClick(Sender: TObject);
var
  ev: TDataSetNotifyEvent;
  ev2: TFieldNotifyEvent;
  TempBookmark: TBookMark;
  NumRow: Integer;
  LocalSmIdList, SmIdList: TList<Integer>;
  AutoCommitValue: Boolean;
  i: Integer;
begin
  LocalSmIdList := TList<Integer>.Create;
  SmIdList := TList<Integer>.Create;
  try
    if (Sender as TComponent).Tag in [1, 2] then
    begin
      qrTemp.Active := False;
      qrTemp.SQL.Text := 'SELECT SM_ID, SM_TYPE, PARENT_ID ' + 'FROM smetasourcedata WHERE (SM_ID = ' +
        qrRatesExSM_ID.Value.ToString + ')';
      qrTemp.Active := True;
      if not qrTemp.Eof then
      begin
        if qrTemp.Fields[1].AsInteger = 1 then
          LocalSmIdList.Add(qrTemp.Fields[0].AsInteger)
        else
          LocalSmIdList.Add(qrTemp.Fields[2].AsInteger);
      end;
      qrTemp.Active := False;
    end;

    if (Sender as TComponent).Tag = 3 then
    begin
      qrTemp.Active := False;
      qrTemp.SQL.Text := 'SELECT SM_ID FROM smetasourcedata WHERE ' + '(PARENT_ID = ' + FIdEstimate.ToString +
        ') and (SM_TYPE = 1) and (DELETED = 0)';
      qrTemp.Active := True;
      while not qrTemp.Eof do
      begin
        LocalSmIdList.Add(qrTemp.Fields[0].AsInteger);
        qrTemp.Next;
      end;
      qrTemp.Active := False;
    end;

    if (LocalSmIdList.Count > 1) and ((Sender as TComponent).Tag <> 3) then
      Exit;

    TempBookmark := qrRatesEx.GetBookmark;
    qrRatesEx.DisableControls;
    ev := qrRatesEx.AfterScroll;
    ev2 := qrRatesExNOM_ROW_MANUAL.OnChange;
    AutoCommitValue := DM.Read.Options.AutoCommit;
    try
      DM.Read.Options.AutoCommit := False;
      qrRatesEx.AfterScroll := nil;
      qrRatesExNOM_ROW_MANUAL.OnChange := nil;

      for i := 0 to LocalSmIdList.Count - 1 do
      begin
        SmIdList.Clear;
        qrTemp.SQL.Text := 'SELECT SM_ID, SM_TYPE, PARENT_ID ' + 'FROM smetasourcedata WHERE (PARENT_ID = ' +
          LocalSmIdList[i].ToString + ') and (DELETED = 0)';
        qrTemp.Active := True;
        while not qrTemp.Eof do
        begin
          SmIdList.Add(qrTemp.Fields[0].AsInteger);
          qrTemp.Next;
        end;
        qrTemp.Active := False;

        NumRow := 0;
        if (Sender as TComponent).Tag in [1, 3] then
          qrRatesEx.First;

        if (Sender as TComponent).Tag = 2 then
        begin
          NumRow := qrRatesExNOM_ROW_MANUAL.Value;
          if not qrRatesEx.Eof then
            qrRatesEx.Next;
        end;

        DM.Read.StartTransaction;
        try
          while not qrRatesEx.Eof do
          begin
            if (SmIdList.IndexOf(qrRatesExSM_ID.Value) > -1) and (qrRatesExID_TYPE_DATA.Value > 0) then
            begin
              Inc(NumRow);
              qrRatesEx.Edit;
              qrRatesExNOM_ROW_MANUAL.Value := NumRow;
              qrRatesEx.Post;
              qrTemp.SQL.Text := 'UPDATE data_row_temp set NOM_ROW_MANUAL=:VAL WHERE ID=:ID;';
              qrTemp.ParamByName('ID').Value := qrRatesExDATA_ESTIMATE_OR_ACT_ID.AsInteger;
              qrTemp.ParamByName('VAL').Value := NumRow;
              qrTemp.ExecSQL;
            end;
            qrRatesEx.Next;
          end;
          DM.Read.Commit;
        except
          DM.Read.Rollback;
          raise;
        end;
      end;
    finally
      DM.Read.Options.AutoCommit := AutoCommitValue;

      qrRatesEx.GotoBookmark(TempBookmark);
      qrRatesEx.FreeBookmark(TempBookmark);

      qrRatesEx.AfterScroll := ev;
      qrRatesExNOM_ROW_MANUAL.OnChange := ev2;
      qrRatesEx.EnableControls;
    end;
  finally
    FreeAndNil(LocalSmIdList);
    FreeAndNil(SmIdList);
  end;
end;

procedure TFormCalculationEstimate.PMRenumPTMClick(Sender: TObject);
var
  ev: TDataSetNotifyEvent;
  ev2: TFieldNotifyEvent;
  TempBookmark: TBookMark;
  NumRow: Integer;
  AutoCommitValue: Boolean;
begin
  TempBookmark := qrRatesEx.GetBookmark;
  ev := qrRatesEx.AfterScroll;
  ev2 := qrRatesExNOM_ROW_MANUAL.OnChange;
  AutoCommitValue := DM.Read.Options.AutoCommit;
  try
    qrRatesEx.DisableControls;

    DM.Read.Options.AutoCommit := False;
    qrRatesEx.AfterScroll := nil;
    qrRatesExNOM_ROW_MANUAL.OnChange := nil;

    DM.Read.StartTransaction;
    try
      qrTemp.Active := False;
      qrTemp.SQL.Text := 'Select GetLastNomManual(:SM_ID, 0)';
      qrTemp.ParamByName('SM_ID').Value := FIdEstimate;
      qrTemp.Active := True;
      try
        NumRow := 0;
        if not qrTemp.Eof then
          NumRow := qrTemp.Fields[0].AsInteger;
      finally
        qrTemp.Active := False;
      end;

      qrRatesEx.First;
      while not qrRatesEx.Eof do
      begin
        if (qrRatesExSM_ID.Value = FIdEstimate) and (qrRatesExID_TYPE_DATA.Value > 0) then
        begin
          Inc(NumRow);
          qrRatesEx.Edit;
          qrRatesExNOM_ROW_MANUAL.Value := NumRow;
          qrRatesEx.Post;
          qrTemp.SQL.Text := 'UPDATE data_row_temp set NOM_ROW_MANUAL=:VAL WHERE ID=:ID;';
          qrTemp.ParamByName('ID').Value := qrRatesExDATA_ESTIMATE_OR_ACT_ID.AsInteger;
          qrTemp.ParamByName('VAL').Value := NumRow;
          qrTemp.ExecSQL;
        end;
        qrRatesEx.Next;
      end;
      DM.Read.Commit;
    except
      DM.Read.Rollback;
      raise;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;

    qrRatesEx.GotoBookmark(TempBookmark);
    qrRatesEx.FreeBookmark(TempBookmark);

    qrRatesEx.AfterScroll := ev;
    qrRatesExNOM_ROW_MANUAL.OnChange := ev2;
    qrRatesEx.EnableControls;
  end;
end;

procedure TFormCalculationEstimate.PMRenumSelectedClick(Sender: TObject);
var
  TempBookmark: TBookMark;
  X: Integer;
  AutoCommitValue: Boolean;
  ev: TDataSetNotifyEvent;
  ev2: TFieldNotifyEvent;
  NumRow: Integer;
  flag: Boolean;
begin
  TempBookmark := qrRatesEx.GetBookmark;
  qrRatesEx.DisableControls;
  ev := qrRatesEx.AfterScroll;
  ev2 := qrRatesExNOM_ROW_MANUAL.OnChange;
  AutoCommitValue := DM.Read.Options.AutoCommit;
  try
    DM.Read.Options.AutoCommit := False;
    qrRatesEx.AfterScroll := nil;
    qrRatesExNOM_ROW_MANUAL.OnChange := nil;

    if grRatesEx.SelectedRows.Count = 0 then
      grRatesEx.SelectedRows.CurrentRowSelected := True;

    NumRow := 0;
    flag := False;
    DM.Read.StartTransaction;
    try
      for X := 0 to grRatesEx.SelectedRows.Count - 1 do
      begin
        grRatesEx.DataSource.DataSet.Bookmark := grRatesEx.SelectedRows.Items[X];
        if qrRatesExID_TYPE_DATA.Value < 1 then
          Continue;

        if not flag and (qrRatesExNOM_ROW_MANUAL.Value > 0) then
        begin
          NumRow := qrRatesExNOM_ROW_MANUAL.Value;
          flag := True;
          Continue;
        end;

        Inc(NumRow);
        qrRatesEx.Edit;
        qrRatesExNOM_ROW_MANUAL.Value := NumRow;
        qrRatesEx.Post;
        qrTemp.SQL.Text := 'UPDATE data_row_temp set NOM_ROW_MANUAL=:VAL WHERE ID=:ID;';
        qrTemp.ParamByName('ID').Value := qrRatesExDATA_ESTIMATE_OR_ACT_ID.AsInteger;
        qrTemp.ParamByName('VAL').Value := NumRow;
        qrTemp.ExecSQL;

      end;
      DM.Read.Commit;
    except
      DM.Read.Rollback;
      raise;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;

    qrRatesEx.GotoBookmark(TempBookmark);
    qrRatesEx.FreeBookmark(TempBookmark);

    qrRatesEx.AfterScroll := ev;
    qrRatesExNOM_ROW_MANUAL.OnChange := ev2;
    qrRatesEx.EnableControls;
  end;
end;

// Групповое изменение процента транспорта для материалов сметы
procedure TFormCalculationEstimate.PMSetTransPercClick(Sender: TObject);
var
  fTrPersSelect: TfTrPersSelect;
  TransPr: Double;
  MatCode: string;
  UpdateStr: string;
  EstimStr: string;
  SelType: byte;
  WhereStr: string;
  TempBookmark: TBookMark;
  X: Integer;
begin
  SelType := 0;
  if (Sender as TComponent).Tag in [1, 2, 3] then
  begin
    fTrPersSelect := TfTrPersSelect.Create(nil);
    try
      if fTrPersSelect.ShowModal = mrOk then
      begin
        SelType := fTrPersSelect.SelectType;
        TransPr := fTrPersSelect.TranspPers;
        MatCode := fTrPersSelect.MatCode;
      end
      else
        Exit;
    finally
      FreeAndNil(fTrPersSelect);
    end;
  end;

  grRatesEx.DataSource.DataSet.DisableControls;
  TempBookmark := grRatesEx.DataSource.DataSet.GetBookmark;
  try
    if grRatesEx.SelectedRows.Count = 0 then
      grRatesEx.SelectedRows.CurrentRowSelected := True;

    for X := 0 to grRatesEx.SelectedRows.Count - 1 do
    begin // (1-локальная, 2-объектная, 3-ПТМ)
      if grRatesEx.SelectedRows.IndexOf(grRatesEx.SelectedRows.Items[X]) > -1 then
      begin
        grRatesEx.DataSource.DataSet.Bookmark := grRatesEx.SelectedRows.Items[X];
        if (qrRatesExID_TYPE_DATA.Value in [1, 2]) or (qrRatesExID_TYPE_DATA.Value = -1) or
          (qrRatesExID_TYPE_DATA.Value = -2) or (qrRatesExID_TYPE_DATA.Value = -3) then
        begin
          case qrRatesExID_TYPE_DATA.Value of
            1:
              begin
                WhereStr := '(ID_CARD_RATE = ' + qrRatesExID_TABLES.Value.ToString + ')';
                EstimStr := qrRatesExSM_ID.Value.ToString;
              end;
            2:
              begin
                WhereStr := '(ID = ' + qrRatesExID_TABLES.Value.ToString + ')';
                EstimStr := qrRatesExSM_ID.Value.ToString;
              end;
            -1, -2, -3:
              begin
                EstimStr := 'SELECT SM_ID FROM smetasourcedata WHERE ' + '((PARENT_ID = ' +
                  qrRatesExSM_ID.Value.ToString + ') OR ' + '(SM_ID = ' + qrRatesExSM_ID.Value.ToString +
                  ') OR ' + '(PARENT_ID IN (SELECT SM_ID FROM smetasourcedata WHERE ' + 'PARENT_ID = ' +
                  qrRatesExSM_ID.Value.ToString + '))) AND ' + '(DELETED = 0)';
                WhereStr := '((ID in (select ID_TABLES from data_row_temp where ' +
                  '(ID_TYPE_DATA = 2) and (SM_ID in (' + EstimStr + ')))) or ' +
                  '(ID_CARD_RATE in (select ID_TABLES from data_row where ' +
                  '(ID_TYPE_DATA = 1) and (SM_ID in (' + EstimStr + ')))))';
                EstimStr := qrRatesExSM_ID.Value.ToString;
              end;
          end;

          if (Sender as TComponent).Tag in [1, 2, 3] then
          begin
            case SelType of
              1:
                UpdateStr := 'PROC_TRANSP = GetTranspPers(' + EstimStr + ', ''' + MatCode + ''', 0)';
              2:
                UpdateStr := 'PROC_TRANSP = ' + TransPr.ToString;
            end;
            if (Sender as TComponent).Tag = 1 then
              WhereStr := WhereStr + ' and (MAT_CODE like ''С103%'')';
            if (Sender as TComponent).Tag = 2 then
              WhereStr := WhereStr + ' and ((MAT_CODE like ''С530%'') or ' +
                '(MAT_CODE like ''С533%'') or (MAT_CODE like ''С534%''))';
          end
          else
            UpdateStr := 'PROC_TRANSP = GetTranspPers(' + EstimStr + ', MAT_CODE, ID_CARD_RATE)';

          qrTemp.Active := False;
          qrTemp.SQL.Text := 'update materialcard_temp set ' + UpdateStr + ' where ' + WhereStr;
          qrTemp.ExecSQL;
        end;
      end;
    end;
  finally
    grRatesEx.DataSource.DataSet.GotoBookmark(TempBookmark);
    grRatesEx.DataSource.DataSet.FreeBookmark(TempBookmark);
    grRatesEx.DataSource.DataSet.EnableControls;

    RecalcEstimate;
  end;
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
  DialogResult := MessageBox(0, PChar('Текущий ССР будет удален. Продолжить?'), 'Смета',
    MB_ICONINFORMATION + MB_YESNO + mb_TaskModal);

  if DialogResult = mrYes then
    MessageBox(0, PChar('Новый ССР'), 'Смета', MB_ICONINFORMATION + MB_OK + mb_TaskModal)
  else
    FormCalculationEstimate.Close;
end;

procedure TFormCalculationEstimate.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  DialogResult: Integer;
  docType: String;
  Tmp: Integer;
begin
  DialogResult := mrNone;

  if not Act then
    docType := CaptionButton[1]
  else
    docType := CaptionButton[2 + TYPE_ACT];

  Tmp := MB_YESNOCANCEL;
  if G_STARTAPP then
    Tmp := MB_YESNO;

  if (not ActReadOnly) and (pnlCalculationYesNo.Tag = 1) and ConfirmCloseForm then
    DialogResult := MessageBox(0, PChar('Сохранить изменения текущего документа - [' + docType + ']?'),
      'Смета', MB_ICONINFORMATION + Tmp + mb_TaskModal);

  if DialogResult = mrCancel then
  begin
    ConfirmCloseForm := True;
    CanClose := False;
    Abort;
    Exit;
  end;

  if DialogResult = mrYes then
    SaveData;

  CanClose := True;
end;

procedure TFormCalculationEstimate.GridRatesRowLoad;
begin
  case qrRatesExID_TYPE_DATA.AsInteger of
    1: // РАСЦЕНКА
      begin
        // Заполнение таблиц справа
        FillingTableMaterials(qrRatesExID_TABLES.AsInteger, 0);
        FillingTableMechanizm(qrRatesExID_TABLES.AsInteger, 0);
        FillingTableDescription(qrRatesExID_TABLES.AsInteger);
      end;
    2: // МАТЕРИАЛ
      begin
        FillingTableMaterials(0, qrRatesExID_TABLES.AsInteger);
      end;
    3: // МЕХАНИЗМ
      begin
        // Заполнение таблицы механизмов
        FillingTableMechanizm(0, qrRatesExID_TABLES.AsInteger);
      end;
    4: // Оборудование
      begin
        // Заполнение таблицы Оборудования
        FillingTableDevises(qrRatesExID_TABLES.AsInteger);
      end;
    5: // Свалки
      begin
        // Заполнение таблицы свалок
        FillingTableDump(qrRatesExID_TABLES.AsInteger);
      end;
    6, 7, 8, 9: // транспорт
      begin
        FillingTableTransp(qrRatesExID_TABLES.AsInteger);
      end;
    10, 11: // Пуск и регулировка
      begin
        FillingTableStartup(qrRatesExID_TYPE_DATA.AsInteger);
      end;
  end;
end;

procedure TFormCalculationEstimate.GridRatesRowSellect;
var
  CalcPrice: string[2];
begin
  // Средний разряд рабочих-строителей
  EditCategory.Text := '';
  edtWinterPrice.Text := '';

  PopupMenuCoefAddSet.Enabled := True;
  PopupMenuCoefDeleteSet.Enabled := True;

  CalcPrice := '00';

  // Загрузка необходимых данных по строке в таблице расценок
  GridRatesRowLoad;
  // РАЗВЁРТЫВАНИЕ ВЫБРАННОЙ РАСЦЕНКИ В ТАБЛИЦАХ СПРАВА
  // BtnChange := False;
  // Гасит все правые кнопки
  BottomTopMenuEnabled(False);
  case qrRatesExID_TYPE_DATA.AsInteger of
    1: // РАСЦЕНКА
      begin
        // настройка кнопочек свержу справа, для расценок всегда выбирается "материалы"
        btnMaterials.Enabled := True;
        btnMechanisms.Enabled := True;
        btnDescription.Enabled := True;

        if btnMaterials.Down or
           btnEquipments.Down or
           btnDump.Down or
           btnTransp.Down or
           btnStartup.Down then
        begin
          btnMaterials.Down := True;
          btnMaterialsClick(btnMaterials);
        end;

        if btnMechanisms.Down then
          btnMechanismsClick(btnMechanisms);

        if btnDescription.Down then
          btnDescriptionClick(btnDescription);

        // Средний разряд рабочих-строителей

        EditCategory.Text :=
          MyFloatToStr
          (GetRankBuilders(VarToStr(FastSelectSQLOne('SELECT RATE_ID FROM card_rate_temp WHERE ID=:1',
          VarArrayOf([qrRatesExID_TABLES.AsInteger])))));

        // Запоняем строку зимнего удорожания
        FillingWinterPrice(qrRatesExOBJ_CODE.AsString);
        FillingOHROPR(qrRatesExOBJ_CODE.AsString);
        CalcPrice := '11';
      end;
    2: // МАТЕРИАЛ
      begin
        btnMaterials.Enabled := True;
        btnMaterials.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // Нажимаем на кнопку материалов, для отображения таблицы материалов
        btnMaterialsClick(btnMaterials);

        CalcPrice := '10';
      end;
    3: // МЕХАНИЗМ
      begin
        btnMechanisms.Enabled := True;
        btnMechanisms.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // Нажимаем на кнопку механизмов, для отображения таблицы механизмов
        btnMechanismsClick(btnMechanisms);

        CalcPrice := '01';
      end;
    4: // ОБОРУДОВАНИЕ
      begin
        btnEquipments.Enabled := True;
        // BtnChange := True;
        btnEquipments.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // Нажимаем на кнопку оборудования, для отображения таблицы оборудования
        btnEquipmentsClick(btnEquipments);
      end;
    5: // Свалки
      begin
        btnDump.Enabled := True;
        // BtnChange := True;
        btnDump.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // Нажимаем на кнопку свалок, для отображения таблицы свалок
        btnDumpClick(btnDump);
      end;
    6, 7, 8, 9: // Транспорт
      begin
        btnTransp.Enabled := True;
        // BtnChange := True;
        btnTransp.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        btnTranspClick(btnTransp);
      end;
    10, 11: // Пуск и регулировка
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
    'SELECT COUNT(*) AS CNT FROM calculation_coef_temp where SM_ID=:id_estimate and id_owner=:id_owner and id_type_data=:id_type_data';
  qrTemp.ParamByName('id_estimate').Value := qrRatesExSM_ID.AsInteger;
  qrTemp.ParamByName('id_owner').Value := qrRatesExID_TABLES.AsInteger;
  qrTemp.ParamByName('id_type_data').Value := qrRatesExID_TYPE_DATA.AsInteger;
  qrTemp.Active := True;
  Result := qrTemp.FieldByName('CNT').AsInteger;
  qrTemp.Active := False;
end;

procedure TFormCalculationEstimate.SaveData;
var
  AutoCommitValue: Boolean;
begin
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  try
    if Act and ActReadOnly then
      Exit;
    try
      DM.Read.StartTransaction;
      // Для акта
      if Act then
        FastExecSQL('CALL SaveAllDataEstimate(:id_estimate);', VarArrayOf([IdEstimate]))
      else
      // Для сметы
      begin
        qrTemp.Active := False;
        qrTemp.SQL.Text :=
          'SELECT SM_ID FROM smetasourcedata WHERE OBJ_ID=:OBJ_ID AND SM_TYPE=2 AND ACT=:ACT';
        qrTemp.ParamByName('OBJ_ID').Value := IdObject;
        if Act then
          qrTemp.ParamByName('ACT').Value := 1
        else
          qrTemp.ParamByName('ACT').Value := 0;
        qrTemp.Active := True;
        qrTemp.First;
        while not qrTemp.Eof do
        begin
          FastExecSQL('CALL SaveAllDataEstimate(:id_estimate);',
            VarArrayOf([qrTemp.FieldByName('SM_ID').Value]));
          qrTemp.Next;
        end;
        qrTemp.Active := False;
      end;
      DM.Read.Commit;
    except
      on e: Exception do
      begin
        DM.Read.Rollback;
        qrTemp.SQL.Text := 'SELECT @ErrorCode AS ECode';
        qrTemp.Active := True;
        MessageBox(0, PChar('При сохранении данных сметы возникла ошибка:' + sLineBreak + sLineBreak +
          e.Message + sLineBreak + qrTemp.FieldByName('ECode').AsString), PChar(FMesCaption),
          MB_ICONERROR + MB_OK + mb_TaskModal);
        Abort;
      end;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
  end;
end;

procedure TFormCalculationEstimate.SetActReadOnly(const Value: Boolean);
begin
  ActReadOnly := Value;
end;

procedure TFormCalculationEstimate.PMTransPercClick(Sender: TObject);
var
  TmpCode: string;
begin
  PMTrPerc1.Enabled := True;
  PMTrPerc2.Enabled := True;
  PMTrPerc3.Enabled := True;
  PMTrPerc4.Enabled := True;
  PMTrPerc5.Enabled := True;

  TmpCode := qrMaterialMAT_CODE.AsString; // Для улучшения читаемости
  if Pos('С103', TmpCode) > 0 then
  begin
    PMTrPerc2.Enabled := False;
    PMTrPerc4.Enabled := False;
    PMTrPerc5.Enabled := False;
  end;

  if (Pos('С530', TmpCode) > 0) or (Pos('С533', TmpCode) > 0) or (Pos('С544', TmpCode) > 0) then
  begin
    PMTrPerc2.Enabled := False;
    PMTrPerc4.Enabled := False;
  end;
end;

procedure TFormCalculationEstimate.PMTrPerc0Click(Sender: TObject);
var
  TrPr: Variant;
  TmpCode: string;
begin
  if (not qrMaterial.Active) or (qrMaterialMAT_CODE.AsString = '') then
    Exit;

  case (Sender as TComponent).Tag of
    0:
      TmpCode := qrMaterialMAT_CODE.AsString;
    // Просто константы, что-бы получиль нужное значение из GetTranspPers
    // GetTranspPers выдаст значение в учетом региона и даты сметы
    1:
      TmpCode := 'С101-0000';
    2:
      TmpCode := 'С201-0000';
    3:
      TmpCode := 'С300-0000';
    4:
      TmpCode := 'С501-0000';
    5:
      TmpCode := 'С000-0000';
  end;

  TrPr := FastSelectSQLOne('SELECT GetTranspPers(:IdEstimate, :MatCode, :RateID);',
    VarArrayOf([qrRatesExSM_ID.AsInteger, TmpCode, qrMaterialID_CARD_RATE.AsInteger]));
  if VarIsNull(TrPr) then
    TrPr := 0;

  qrMaterial.Edit;
  qrMaterial.FieldByName('PROC_TRANSP').Value := TrPr;
end;

procedure TFormCalculationEstimate.PMUseTransForThisCountClick(Sender: TObject);
begin
  if (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'FTRANSP_NO_NDS') or
     (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'FTRANSP_NDS') then
  begin
    qrMaterial.Edit;
    qrMaterialFTRANSCOUNT.Value := qrMaterialMAT_COUNT.Value;
  end;

  if (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'VFTRANSP_NO_NDS') or
     (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'VFTRANSP_NDS') then
  begin
    qrMaterial.Edit;
    qrMaterialVFTRANSCOUNT.Value := qrMaterialMAT_COUNT.Value;
  end;
end;

procedure TFormCalculationEstimate.PMUseTransPercClick(Sender: TObject);
begin
  qrMaterial.Edit;
  if (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'FTRANSP_NO_NDS') or
     (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'FTRANSP_NDS') then
  begin
    qrMaterial.Edit;
    qrMaterialFTRANSCOUNT.Value := 0;
  end;

  if (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'VFTRANSP_NO_NDS') or
     (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'VFTRANSP_NDS') then
  begin
    qrMaterial.Edit;
    qrMaterialVFTRANSCOUNT.Value := 0;
  end;
end;

procedure TFormCalculationEstimate.pmPopup(Sender: TObject);
begin
  if not Editable then
    Abort;
end;

procedure TFormCalculationEstimate.PopupMenuCoefAddSetClick(Sender: TObject);
begin
  if fCoefficients.ShowModal = mrOk then
  begin
    { if FormCalculationEstimate.GetCountCoef = 5 then
      begin
      MessageBox(0, PChar('Уже добавлено 5 наборов коэффициентов!' + sLineBreak + sLineBreak +
      'Добавление больше 5 наборов невозможно.'), 'Смета', MB_ICONINFORMATION + MB_OK + mb_TaskModal);
      end
      else }
    begin
      AddCoefToRate(fCoefficients.qrCoef.FieldByName('coef_id').AsInteger);
      RecalcEstimate;
    end;
  end;
end;

procedure TFormCalculationEstimate.PopupMenuCoefDeleteSetClick(Sender: TObject);
begin
  if MessageBox(0, PChar('Вы действительно хотите удалить ' + sLineBreak + 'выделенный набор коэффициентов?'),
    'Смета', MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) <> mrYes then
    Exit;

  qrTemp.SQL.Text := 'Delete from calculation_coef_temp where calculation_coef_id=:id';
  qrTemp.ParamByName('id').Value := qrCalculations.FieldByName('id').AsInteger;
  qrTemp.ExecSQL;

  RecalcEstimate;
end;

procedure TFormCalculationEstimate.PopupMenuCoefOrdersClick(Sender: TObject);
begin
  if PopupMenuCoefOrders.Checked then
  begin
    FastExecSQL('UPDATE card_rate_temp SET COEF_ORDERS=0 WHERE ID=:0',
      VarArrayOf([qrRatesExID_TABLES.Value]));
    PopupMenuCoefOrders.Checked := False;
  end
  else
  begin
    FastExecSQL('UPDATE card_rate_temp SET COEF_ORDERS=1 WHERE ID=:0',
      VarArrayOf([qrRatesExID_TABLES.Value]));
    PopupMenuCoefOrders.Checked := True;
  end;
  FastExecSQL('CALL CalcRowInRateTab(:ID, :TYPE, 1);',
    VarArrayOf([qrRatesExID_TABLES.Value, qrRatesExID_TYPE_DATA.Value]));
  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.pmCoefPopup(Sender: TObject);
begin
  if not Editable then
    Abort;

  PopupMenuCoefDeleteSet.Enabled := (qrCalculations.FieldByName('ID').AsInteger > 0);
  PopupMenuCoefOrders.Visible := (qrRatesExID_TYPE_DATA.Value = 1) and (qrRatesExCOEF_ORDERS.Value = 1);
  PopupMenuCoefOrders.Checked := FastSelectSQLOne('SELECT COEF_ORDERS FROM card_rate_temp WHERE ID=:0',
    VarArrayOf([qrRatesExID_TABLES.Value])) = 1;

end;

// вид всплывающего меню материалов
procedure TFormCalculationEstimate.pmMaterialsPopup(Sender: TObject);
begin
  if not Editable then
    Abort;

  PMMatEdit.Enabled := (not CheckMatReadOnly);

  PMTransPerc.Enabled := (not CheckMatReadOnly);
  PMTransPerc.Visible := (dbgrdMaterial.Col > 0) and
    (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'PROC_TRANSP');

  PMUseTransPerc.Visible := (dbgrdMaterial.Col > 0) and
    ((dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'FTRANSP_NO_NDS') or
     (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'FTRANSP_NDS') or
     (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'VFTRANSP_NO_NDS') or
     (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'VFTRANSP_NDS'));
  PMUseTransForThisCount.Visible := PMUseTransPerc.Visible;

  if (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'FTRANSP_NO_NDS') or
     (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'FTRANSP_NDS') then
  begin
    PMUseTransPerc.Enabled :=
      (not CheckMatReadOnly) and (qrMaterialFTRANSCOUNT.Value > 0);

    PMUseTransForThisCount.Enabled := PMUseTransPerc.Enabled and
      (qrMaterialFTRANSCOUNT.Value <> qrMaterialMAT_COUNT.Value);
  end;

  if (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'VFTRANSP_NO_NDS') or
     (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'VFTRANSP_NDS') then
  begin
    PMUseTransPerc.Enabled :=
      (not CheckMatReadOnly) and (qrMaterialVFTRANSCOUNT.Value > 0);

    PMUseTransForThisCount.Enabled := PMUseTransPerc.Enabled and
      (qrMaterialVFTRANSCOUNT.Value <> qrMaterialMAT_COUNT.Value);
  end;

  PMMatFromRates.Enabled := (not CheckMatReadOnly) and (qrMaterialCONSIDERED.AsInteger = 1) and
    (qrRatesExID_TYPE_DATA.AsInteger = 1);

  PMMatReplace.Enabled := ((not CheckMatReadOnly) or (qrMaterialREPLACED.AsInteger = 1));

  PMMatAddToRate.Enabled := (qrRatesExID_TYPE_DATA.AsInteger = 1);

  PMMatDelete.Enabled := (not CheckMatReadOnly) and
  // Заменяющий
    (((qrMaterialID_REPLACED.AsInteger > 0) and (qrMaterialFROM_RATE.AsInteger = 0)) or
    // Добавленный
    ((qrMaterialADDED.AsInteger > 0) and (qrMaterialFROM_RATE.AsInteger = 0)) or
    // Вынесеный
    ((qrMaterialFROM_RATE.AsInteger = 1) and (qrRatesExID_TYPE_DATA.AsInteger = 2)) or
    // Учтеный
    ((qrMaterialID_CARD_RATE.AsInteger > 0) and (qrMaterialCONSIDERED.AsInteger = 1) and
    (qrMaterialID_REPLACED.AsInteger = 0) and (qrMaterialFROM_RATE.AsInteger = 0) and
    (qrMaterialREPLACED.AsInteger = 0) and (qrMaterialADDED.AsInteger = 0) and
    (qrMaterialDELETED.AsInteger = 0)));

  PMMatRestore.Enabled := qrMaterialDELETED.AsInteger = 1;

  PMCalcMat.Visible := NDSEstimate;
  PMCalcMat.Enabled :=
    (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'FCOAST_NDS')
    or
    (dbgrdMaterial.Columns[dbgrdMaterial.Col - 1].FieldName = 'VFCOAST_NDS');

  PMMatManPrice.Visible := (qrMaterialBASE.Value > 0);
  PMMatManPrice.Enabled := not CheckMatReadOnly;

  PMMatNormPrice.Visible := (qrMaterialBASE.Value = 0);
  PMMatNormPrice.Enabled := not CheckMatReadOnly;

  PMMatSprCard.Visible := (qrMaterialBASE.Value > 0);
  PMMatSprCard.Enabled := not CheckMatReadOnly;
end;

// Настройка вида всплывающего меню таблицы механизмов
procedure TFormCalculationEstimate.pmMechanizmsPopup(Sender: TObject);
begin
  if not Editable then
    Abort;

  PMMechEdit.Enabled := (not CheckMechReadOnly);

  PMMechFromRates.Enabled := (not CheckMechReadOnly) and (qrRatesExID_TYPE_DATA.AsInteger = 1);

  PMMechReplace.Enabled := (not CheckMechReadOnly) or (qrMechanizmREPLACED.AsInteger = 1);

  // Доступен только с расценке
  PMMechAddToRate.Enabled := (qrRatesExID_TYPE_DATA.AsInteger = 1);

  PMMechDelete.Enabled := (not CheckMechReadOnly) and
  // Заменяющий
    (((qrMechanizmID_REPLACED.AsInteger > 0) and (qrMechanizmFROM_RATE.AsInteger = 0)) or
    // Добавленный
    ((qrMechanizmADDED.AsInteger > 0) and (qrMechanizmFROM_RATE.AsInteger = 0)) or
    // Вынесенный
    ((qrMechanizmFROM_RATE.AsInteger = 1) and (qrRatesExID_TYPE_DATA.AsInteger = 3)) or
    // Учтеный
    ((qrMechanizmID_CARD_RATE.AsInteger > 0) and (qrMechanizmID_REPLACED.AsInteger = 0) and
    (qrMechanizmFROM_RATE.AsInteger = 0) and (qrMechanizmREPLACED.AsInteger = 0) and
    (qrMechanizmADDED.AsInteger = 0) and (qrMechanizmDELETED.AsInteger = 0)));

  PMMechRestore.Enabled := qrMechanizmDELETED.AsInteger = 1;

  PMCalcMech.Visible := NDSEstimate;
  PMCalcMech.Enabled :=
    (dbgrdMechanizm.Columns[dbgrdMechanizm.Col - 1].FieldName = 'FCOAST_NDS') or
    (dbgrdMechanizm.Columns[dbgrdMechanizm.Col - 1].FieldName = 'VFCOAST_NDS');

  PMMechManPrice.Visible := (qrMechanizmBASE.Value > 0);
  PMMechManPrice.Enabled := not CheckMechReadOnly;

  PMMechNormPrice.Visible := (qrMechanizmBASE.Value = 0);
  PMMechNormPrice.Enabled := not CheckMechReadOnly;

  PMMechSprCard.Visible := (qrMechanizmBASE.Value > 0);
  PMMechSprCard.Enabled := not CheckMechReadOnly;
end;

function TFormCalculationEstimate.CheckCursorInRate: Boolean;
begin
  Result := (qrRatesExID_TYPE_DATA.AsInteger > 0) or // Что-то врутри смети
    (qrRatesExID_TYPE_DATA.AsInteger = -3) or (qrRatesExID_TYPE_DATA.AsInteger = -4) or
    (qrRatesExID_TYPE_DATA.AsInteger = -5);
  // или шапка жешки или строка ввода
end;

procedure TFormCalculationEstimate.ReplaceSmRow(ASmRowId: Integer; var AIterator, AManualNom: Integer);
var
  TempBookmark: TBookMark;
  ev: TDataSetNotifyEvent;
  ev2: TFieldNotifyEvent;
begin
  if ASmRowId = 0 then
    Exit;

  TempBookmark := qrRatesEx.GetBookmark;
  qrRatesEx.DisableControls;
  ev := qrRatesEx.AfterScroll;
  ev2 := qrRatesExNOM_ROW_MANUAL.OnChange;
  try
    qrRatesEx.AfterScroll := nil;
    qrRatesExNOM_ROW_MANUAL.OnChange := nil;

    qrRatesEx.First;
    while not qrRatesEx.Eof do
    begin
      if (qrRatesExDATA_ESTIMATE_OR_ACT_ID.Value = ASmRowId) then
      begin
        AIterator := qrRatesExITERATOR.Value;
        AManualNom := qrRatesExNOM_ROW_MANUAL.Value;
        DeleteRowFromSmeta();
        Exit;
      end;
      qrRatesEx.Next;
    end;
  finally
    qrRatesEx.GotoBookmark(TempBookmark);
    qrRatesEx.FreeBookmark(TempBookmark);

    qrRatesEx.AfterScroll := ev;
    qrRatesExNOM_ROW_MANUAL.OnChange := ev2;
    qrRatesEx.EnableControls;
  end;
end;

// Добавление расценки в смету
procedure TFormCalculationEstimate.AddRate(const ARateId: Integer);
var
  vMaxIdRate, DataRowID: Integer;
  MaxMId: Integer;
  NewRateCode: string;
  vNormRas: Double;
  Month1, Year1: Integer;
  PriceVAT, PriceNoVAT: string;
  Pt: Real;
  AutoCommitValue: Boolean;
  Work_ID: Integer;
begin
  if not CheckCursorInRate then
    Exit;

  AutoCommitValue := DM.Connect.Transaction.Options.AutoCommit;
  DM.Connect.Transaction.Options.AutoCommit := False;
  DM.Connect.Transaction.StartTransaction;
  try
    try
      ReplaceSmRow(FReplaceRowID, FNewRowIterator, FNewNomManual);

      // Добавляем найденную расценку во временную таблицу card_rate_temp
      try
        with qrTemp do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('CALL AddRate(:id_estimate, :id_rate, :cnt, :iterator, :nommanual);');
          ParamByName('id_estimate').Value := qrRatesExSM_ID.AsInteger;
          ParamByName('id_rate').Value := ARateId;
          ParamByName('cnt').Value := 0;
          ParamByName('iterator').Value := FNewRowIterator;
          ParamByName('nommanual').Value := FNewNomManual;
          Active := True;
          vMaxIdRate := FieldByName('id').AsInteger;
          NewRateCode := FieldByName('RATE_CODE').AsString;
          DataRowID := FieldByName('DATA_ROW_ID').AsInteger;
          Work_ID := FieldByName('WORK_ID').AsInteger;
          Active := False;
        end;
      except
        on e: Exception do
        begin
          MessageBox(0, 'При добавлении расценки во временную таблицу возникла ошибка.', PChar(FMesCaption),
            MB_ICONERROR + MB_OK + mb_TaskModal);
          raise;
        end;
      end;

      if Work_ID = 0 then
      begin
        Work_ID := GetOHROPRId(NewRateCode);
        qrTemp.SQL.Text := 'Update card_rate_temp set WORK_ID = :WORK_ID where ID = :ID';
        qrTemp.ParamByName('WORK_ID').Value := Work_ID;
        qrTemp.ParamByName('ID').Value := vMaxIdRate;
        qrTemp.ExecSQL;
      end;

      ClearAutoRep;

      qrTemp.SQL.Clear;
      qrTemp.SQL.Add('SELECT year,monat,DATE_BEG FROM stavka WHERE stavka_id = ' +
        '(SELECT stavka_id FROM smetasourcedata WHERE sm_id = ' + INTTOSTR(qrRatesExSM_ID.AsInteger) + ')');
      qrTemp.Active := True;
      Month1 := qrTemp.FieldByName('monat').AsInteger;
      Year1 := qrTemp.FieldByName('year').AsInteger;
      qrTemp.Active := False;

      // Заносим во временную таблицу materialcard_temp материалы находящиеся в расценке
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
            ' as "PriceNoVAT", TMat.BASE as "BASE", TMat.MAT_TYPE as "MAT_TYPE" ' +
            'FROM materialnorm as TMatNorm ' +
            'JOIN material as TMat ON TMat.material_id = TMatNorm.material_id ' +
            'LEFT JOIN units ON TMat.unit_id = units.unit_id ' + 'LEFT JOIN materialcoastg as TMatCoast ON ' +
            '(TMatCoast.material_id = TMatNorm.material_id) and ' + '(monat = ' + INTTOSTR(Month1) + ') and '
            + '(year = ' + INTTOSTR(Year1) + ') ' + 'WHERE (TMatNorm.normativ_id = ' + INTTOSTR(ARateId) +
            ') order by "MatCode", "MatName"';
          Active := True;

          Filtered := False;
          Filter := 'MatCode LIKE ''С%''';
          Filtered := True;

          First;

          while not Eof do
          begin
            // Получение процента транспорта для материала
            qrTemp1.Active := False;
            qrTemp1.SQL.Clear;
            qrTemp1.SQL.Add('SELECT GetTranspPers(:IdEstimate, :MatCode, :RateID);');
            qrTemp1.ParamByName('IdEstimate').Value := qrRatesExSM_ID.AsInteger;
            qrTemp1.ParamByName('MatCode').Value := FieldByName('MatCode').AsString;
            qrTemp1.ParamByName('RateID').Value := vMaxIdRate;
            qrTemp1.Active := True;
            Pt := 0;
            if not qrTemp1.Eof then
              Pt := qrTemp1.Fields[0].AsFloat;
            qrTemp1.Active := False;

            qrTemp1.SQL.Text := 'SELECT GetNewID(:IDType)';
            qrTemp1.ParamByName('IDType').Value := C_ID_SMMAT;
            qrTemp1.Active := True;
            MaxMId := 0;
            if not qrTemp1.Eof then
              MaxMId := qrTemp1.Fields[0].AsInteger;
            qrTemp1.Active := False;

            qrTemp1.SQL.Text := 'Insert into materialcard_temp (SM_ID, DATA_ROW_ID, ' +
              'ID, ID_CARD_RATE, MAT_ID, MAT_CODE, MAT_NAME, MAT_NORMA, MAT_UNIT, ' +
              'COAST_NO_NDS, COAST_NDS, FCOAST_NO_NDS, FCOAST_NDS, ' +
              'PROC_TRANSP, BASE, MAT_TYPE) values ' +
              '(:SM_ID, :DATA_ROW_ID, :ID, :ID_CARD_RATE, :MAT_ID, :MAT_CODE, ' +
              ':MAT_NAME, :MAT_NORMA, :MAT_UNIT, :COAST_NO_NDS, :COAST_NDS, ' +
              ':COAST_NO_NDS, :COAST_NDS, :PROC_TRANSP, :BASE, :MAT_TYPE)';
            qrTemp1.ParamByName('SM_ID').Value := qrRatesExSM_ID.AsInteger;
            qrTemp1.ParamByName('DATA_ROW_ID').Value := DataRowID;
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
            qrTemp1.ParamByName('PROC_TRANSP').AsFloat := Pt;
            qrTemp1.ParamByName('BASE').Value := FieldByName('BASE').Value;
            qrTemp1.ParamByName('MAT_TYPE').Value := FieldByName('MAT_TYPE').Value;
            qrTemp1.ExecSQL;

            CheckNeedAutoRep(MaxMId, 2, FieldByName('MatId').AsInteger, ARateId,
              FieldByName('MatCode').AsString, FieldByName('MatName').AsString);

            Next;
          end;

          Filtered := False;
          Filter := 'MatCode LIKE ''П%''';
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
              qrTemp1.SQL.Text := 'Insert into materialcard_temp ' + '(SM_ID, DATA_ROW_ID, ID, ID_CARD_RATE, '
                + 'CONSIDERED, MAT_ID, MAT_CODE, MAT_NAME, MAT_NORMA, MAT_UNIT, ' +
                'COAST_NO_NDS, COAST_NDS, FCOAST_NO_NDS, FCOAST_NDS, ' +
                'PROC_TRANSP, BASE, MAT_TYPE) values ' +
                '(:SM_ID, :DATA_ROW_ID, :ID, :ID_CARD_RATE, :CONSIDERED, :MAT_ID, ' +
                ':MAT_CODE, :MAT_NAME, :MAT_NORMA, :MAT_UNIT, :COAST_NO_NDS, ' +
                ':COAST_NDS, :COAST_NO_NDS, :COAST_NDS, :PROC_TRANSP, :BASE, :MAT_TYPE)';
              qrTemp1.ParamByName('SM_ID').Value := qrRatesExSM_ID.AsInteger;
              qrTemp1.ParamByName('DATA_ROW_ID').Value := DataRowID;
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
              qrTemp1.ParamByName('BASE').Value := FieldByName('BASE').Value;
              qrTemp1.ParamByName('MAT_TYPE').Value := FieldByName('MAT_TYPE').Value;
              qrTemp1.ExecSQL;

              CheckNeedAutoRep(MaxMId, 2, FieldByName('MatId').AsInteger, ARateId,
                FieldByName('MatCode').AsString, FieldByName('MatName').AsString);
            end;
            Next;
          end;

          Filtered := False;
          Filter := '';

          Active := False;
        end;
      except
        on e: Exception do
        begin
          MessageBox(0, 'При занесении материалов во временную таблицу возникла ошибка.', PChar(FMesCaption),
            MB_ICONERROR + MB_OK + mb_TaskModal);
          raise;
        end;
      end;

      // Заносим во временную таблицу mechanizmcard_temp механизмы находящиеся в расценке
      try
        with qrTemp do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT mech.mechanizm_id as "MechId", mech.mech_code as "MechCode", ' +
            'mechnorm.norm_ras as "MechNorm", units.unit_name as "Unit", ' +
            'mech.mech_name as "MechName", mechcoast.coast1 as "CoastVAT", ' +
            'mechcoast.coast2 as "CoastNoVAT", mechcoast.zp1 as "SalaryVAT", ' +
            'mechcoast.zp2 as "SalaryNoVAT", IFNULL(mech.MECH_PH, 0) as "MECH_PH", ' + 'mech.BASE as "BASE" '
            + 'FROM mechanizmnorm as mechnorm ' +
            'JOIN mechanizm as mech ON mechnorm.mechanizm_id = mech.mechanizm_id ' +
            'JOIN units ON mech.unit_id = units.unit_id ' + 'LEFT JOIN mechanizmcoastg as MechCoast ON ' +
            '(MechCoast.mechanizm_id = mechnorm.mechanizm_id) and ' + '(monat = ' + INTTOSTR(Month1) +
            ') and ' + '(year = ' + INTTOSTR(Year1) + ') ' + 'WHERE (mechnorm.normativ_id = ' +
            INTTOSTR(ARateId) + ') order by "MechCode", "MechName"');

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
              qrTemp1.SQL.Text := 'Insert into mechanizmcard_temp (SM_ID, DATA_ROW_ID, ' +
                'ID, ID_CARD_RATE, MECH_ID, MECH_CODE, MECH_NAME, MECH_NORMA, ' +
                'MECH_UNIT, COAST_NO_NDS, COAST_NDS, ZP_MACH_NO_NDS, ZP_MACH_NDS, ' +
                'FCOAST_NO_NDS, FCOAST_NDS, FZP_MACH_NO_NDS, FZP_MACH_NDS, ' +
                'NORMATIV, BASE) values (:SM_ID, :DATA_ROW_ID, :ID, :ID_CARD_RATE, ' +
                ':MECH_ID, :MECH_CODE, :MECH_NAME, :MECH_NORMA, :MECH_UNIT, :COAST_NO_NDS, ' +
                ':COAST_NDS, :ZP_MACH_NO_NDS, :ZP_MACH_NDS, :COAST_NO_NDS, ' +
                ':COAST_NDS, :ZP_MACH_NO_NDS, :ZP_MACH_NDS, :NORMATIV, :BASE)';
              qrTemp1.ParamByName('SM_ID').Value := qrRatesExSM_ID.AsInteger;
              qrTemp1.ParamByName('DATA_ROW_ID').Value := DataRowID;
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
              qrTemp1.ParamByName('BASE').Value := FieldByName('BASE').Value;
              qrTemp1.ExecSQL;

              CheckNeedAutoRep(MaxMId, 3, FieldByName('MechId').AsInteger, ARateId,
                FieldByName('MechCode').AsString, FieldByName('MechName').AsString);
            end;
            Next;
          end;
          Active := False;
        end;
      except
        on e: Exception do
        begin
          MessageBox(0, 'При занесении механизмов во временную таблицу возникла ошибка.', PChar(FMesCaption),
            MB_ICONERROR + MB_OK + mb_TaskModal);
          raise;
        end;
      end;
      DM.Connect.Transaction.Commit;
    except
      DM.Connect.Transaction.Rollback;
      raise;
    end;
  finally
    DM.Connect.Transaction.Options.AutoCommit := AutoCommitValue;
  end;

  // автоматическая вставка пуска и регулировки, отключена по просьбе заказчика
  { if ((Pos('е18', AnsiLowerCase(NewRateCode)) > 0) and (not CheckE1820(10)) and FAutoAddE18) or
    ((Pos('е20', AnsiLowerCase(NewRateCode)) > 0) and (not CheckE1820(11)) and FAutoAddE20) then
    begin
    if (Pos('е18', AnsiLowerCase(NewRateCode)) > 0) then
    case MessageBox(0, PChar('Дабавить пуск и регулировку отопления по Е18 в смету?'), PChar(FMesCaption),
    MB_ICONQUESTION + MB_OKCANCEL + mb_TaskModal) of
    mrOk:
    PMAddAdditionHeatingE18Click(PMAddAdditionHeatingE18);
    mrCancel:
    begin
    FAutoAddE18 := False;
    OutputDataToTable(True);
    end;
    end;

    if (Pos('е20', AnsiLowerCase(NewRateCode)) > 0) then
    case MessageBox(0, PChar('Дабавить пуск и регулировку отопления по Е20 в смету?'), PChar(FMesCaption),
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
    else }
  OutputDataToTable(True);
  // Проверка нескольких настроек ОХРиОПР и ПП
  // ТОДО

  (Self as TForm).Invalidate;

  // Выполнение автозамены по добавленной расценке
  ShowAutoRep;
end;

procedure TFormCalculationEstimate.PMAddTranspClick(Sender: TObject);
begin
  if not CheckCursorInRate then
    Exit;

  if FReplaceRowID > 0 then
  begin
    FNewRowIterator := qrRatesExITERATOR.Value;
    FNewNomManual := qrRatesExNOM_ROW_MANUAL.Value;
  end;

  if GetTranspForm(qrRatesExSM_ID.AsInteger, -1, (Sender as TMenuItem).Tag, FNewRowIterator, FNewNomManual,
    FTranspDistance, True) then
  begin
    ReplaceSmRow(FReplaceRowID, FNewRowIterator, FNewNomManual);
    OutputDataToTable(True);
  end;
end;

// в целом процедура работает неверно так как может быть открыто несколько смет
function TFormCalculationEstimate.CheckE1820(AType: Integer): Boolean;
var
  RecNo, SmID: Integer;
  ev1, ev2: TDataSetNotifyEvent;
begin
  RecNo := qrRatesEx.RecNo;
  SmID := qrRatesExSM_ID.AsInteger;
  Result := False;
  qrRatesEx.DisableControls;
  ev1 := qrRatesEx.BeforeScroll;
  ev2 := qrRatesEx.AfterScroll;
  try
    qrRatesEx.BeforeScroll := nil;
    qrRatesEx.AfterScroll := nil;
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
    qrRatesEx.BeforeScroll := ev1;
    qrRatesEx.AfterScroll := ev2;
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
  qrTemp.SQL.Text := 'INSERT INTO data_row_temp ' +
    '(ID, SM_ID, id_type_data, NUM_ROW, NOM_ROW_MANUAL, E1820_COUNT) VALUE ' +
    '(GetNewID(:IDType), :SM_ID, :SType, :NUM_ROW, :NOM_ROW_MANUAL, :E1820_COUNT);';
  qrTemp.ParamByName('IDType').Value := C_ID_DATA;
  qrTemp.ParamByName('SM_ID').Value := qrRatesExSM_ID.AsInteger;
  qrTemp.ParamByName('SType').Value := (Sender as TComponent).Tag;
  qrTemp.ParamByName('NUM_ROW').Value := Iterator;
  qrTemp.ParamByName('NOM_ROW_MANUAL').Value := FNewNomManual;
  qrTemp.ParamByName('E1820_COUNT').Value := 1;
  qrTemp.ExecSQL;

  qrTemp.SQL.Text := 'CALL UpdateNomManual(:IdEstimate, 0, 0);';
  qrTemp.ParamByName('IdEstimate').Value := qrRatesExSM_ID.AsInteger;
  qrTemp.ExecSQL;

  OutputDataToTable(True);
end;

procedure TFormCalculationEstimate.PMAddDumpClick(Sender: TObject);
begin
  if FReplaceRowID > 0 then
  begin
    FNewRowIterator := qrRatesExITERATOR.Value;
    FNewNomManual := qrRatesExNOM_ROW_MANUAL.Value;
  end;

  if GetDumpForm(qrRatesExSM_ID.AsInteger, -1, FNewRowIterator, FNewNomManual, True) then
  begin
    ReplaceSmRow(FReplaceRowID, FNewRowIterator, FNewNomManual);
    OutputDataToTable(True);
  end;
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

procedure TFormCalculationEstimate.DeleteRowFromSmeta();
begin
  case qrRatesExID_TYPE_DATA.AsInteger of
    1: // Расценка
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
          MessageBox(0, PChar('При удалении расценки возникла ошибка:' + sLineBreak + sLineBreak + e.Message),
            PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
      end;
    2: // Материал
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
          MessageBox(0, PChar('При удалении материала возникла ошибка:' + sLineBreak + sLineBreak +
            e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
      end;
    3: // Механизм
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
          MessageBox(0, PChar('При удалении механизма возникла ошибка:' + sLineBreak + sLineBreak +
            e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
      end;
    4: // Оборудование
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
          MessageBox(0, PChar('При удалении оборудования возникла ошибка:' + sLineBreak + sLineBreak +
            e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
      end;
    5: // Свалка
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
          MessageBox(0, PChar('При удалении свалки возникла ошибка:' + sLineBreak + sLineBreak + e.Message),
            PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
      end;
    6, 7, 8, 9: // Транспорт
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
          MessageBox(0, PChar('При удалении транспорта возникла ошибка:' + sLineBreak + sLineBreak +
            e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
      end;
    10, 11: // Пуск и регулировка
      try
        with qrTemp do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('DELETE FROM data_row_temp WHERE (ID = ' +
            INTTOSTR(qrRatesExDATA_ESTIMATE_OR_ACT_ID.AsInteger) + ');');
          ExecSQL;

          SQL.Clear;
          SQL.Add('CALL `UpdateNomManual`(:SM_ID, :NomManual, 1);');
          ParamByName('SM_ID').Value := qrRatesExSM_ID.Value;
          ParamByName('NomManual').Value := qrRatesExNOM_ROW_MANUAL.Value;
          ExecSQL;
        end;
      except
        on e: Exception do
          MessageBox(0, PChar('При удалении пусконаладки возникла ошибка:' + sLineBreak + sLineBreak +
            e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
      end;
  end;
end;

// Удаление чего-либо из сметы
procedure TFormCalculationEstimate.PMDeleteClick(Sender: TObject);
var
  TempBookmark: TBookMark;
  X: Integer;
begin
  if grRatesEx.SelectedRows.Count > 1 then
  begin
    if MessageBox(0, PChar('Вы действительно хотите удалить выбранные записи(' +
      INTTOSTR(grRatesEx.SelectedRows.Count) + ')?'), PChar(FMesCaption), MB_ICONINFORMATION + MB_YESNO +
      mb_TaskModal) = mrNo then
      Exit;

    grRatesEx.DataSource.DataSet.DisableControls;
    TempBookmark := grRatesEx.DataSource.DataSet.GetBookmark;
    for X := 0 to grRatesEx.SelectedRows.Count - 1 do
    begin
      if grRatesEx.SelectedRows.IndexOf(grRatesEx.SelectedRows.Items[X]) > -1 then
      begin
        grRatesEx.DataSource.DataSet.Bookmark := grRatesEx.SelectedRows.Items[X];
        DeleteRowFromSmeta();
      end;
    end;

    grRatesEx.DataSource.DataSet.GotoBookmark(TempBookmark);
    grRatesEx.DataSource.DataSet.FreeBookmark(TempBookmark);
    grRatesEx.DataSource.DataSet.EnableControls;
  end
  else
  begin
    if MessageBox(0, PChar('Вы действительно хотите удалить ' + qrRatesExOBJ_CODE.AsString + '?'),
      PChar(FMesCaption), MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
      Exit;
    DeleteRowFromSmeta();
  end;

  if not qrRatesEx.Bof then
    qrRatesEx.Prior;
  OutputDataToTable;
end;

procedure TFormCalculationEstimate.PMDevEditClick(Sender: TObject);
begin
  SetDevEditMode;
end;

procedure TFormCalculationEstimate.pmDevicesPopup(Sender: TObject);
begin
  if not Editable then
    Abort;

  PMCalcDevice.Visible := NDSEstimate;
  PMCalcDevice.Enabled := (dbgrdDevices.Columns[dbgrdDevices.Col - 1].FieldName = 'FCOAST_NDS');

  PMDevManPrice.Visible := (qrDevicesBASE.Value > 0);
  PMDevSprCard.Visible := (qrDevicesBASE.Value > 0);
end;

// Общий пункт для свалок и транспорта
procedure TFormCalculationEstimate.PMDumpEditClick(Sender: TObject);
begin
  if qrRatesExID_TYPE_DATA.AsInteger = 5 then
    if GetDumpForm(qrRatesExSM_ID.AsInteger, qrDumpID.AsInteger, FNewRowIterator, FNewNomManual, False) then
      OutputDataToTable;

  if qrRatesExID_TYPE_DATA.AsInteger in [6, 7, 8, 9] then
    if GetTranspForm(qrRatesExSM_ID.AsInteger, qrTranspID.AsInteger, qrRatesExID_TYPE_DATA.AsInteger,
      FNewRowIterator, FNewNomManual, FTranspDistance, False) then
      OutputDataToTable;
end;

procedure TFormCalculationEstimate.PMEditClick(Sender: TObject);
begin
  // Редактируются только свалки и транспорт
  if qrRatesExID_TYPE_DATA.AsInteger in [5, 6, 7, 8, 9] then
    PMDumpEditClick(nil);
end;

procedure TFormCalculationEstimate.pmFindRowInEstimClick(Sender: TObject);
var TempBookmark: TBookMark;
begin
  FRowFinder.EstimateID := FIdEstimate;
  if FRowFinder.ShowModal = mrOk then
  begin
    qrRatesEx.DisableControls;
    try
      TempBookmark := grRatesEx.DataSource.DataSet.GetBookmark;
      qrRatesEx.First;
      while not qrRatesEx.Eof do
      begin
        if (qrRatesExDATA_ESTIMATE_OR_ACT_ID.Value = FRowFinder.DataID) then
        begin
          if FRowFinder.CurType = 2 then
            btnMaterials.Down := True;
          if FRowFinder.CurType = 3 then
            btnMechanisms.Down := True;
          Exit;
        end;
        qrRatesEx.Next;
      end;
      qrRatesEx.GotoBookmark(TempBookmark);
    finally
      if qrRatesEx.BookmarkValid(TempBookmark) then
        qrRatesEx.FreeBookmark(TempBookmark);
      qrRatesEx.EnableControls;
    end;
  end;
end;

procedure TFormCalculationEstimate.PMInsertRowClick(Sender: TObject);
var
  SM_ID, TmpIterator: Integer;
begin
  while (qrRatesExID_RATE.Value > 0) and not qrRatesEx.Eof do
    qrRatesEx.Next;
  SM_ID := qrRatesExSM_ID.Value;
  TmpIterator := qrRatesExITERATOR.Value;
  qrRatesEx.Insert;
  qrRatesExSM_ID.Value := SM_ID;
  qrRatesExID_TYPE_DATA.Value := -5;
  qrRatesEx.Post;
  grRatesEx.SelectedRows.Clear;
  FNewRowIterator := TmpIterator;
end;

procedure TFormCalculationEstimate.pmMarkRowClick(Sender: TObject);
begin
  if qrRatesExMarkRow.Value = 0 then
    qrRatesExMarkRow.Value := 1
  else
    qrRatesExMarkRow.Value := 0;

  pmMarkRow.Checked := qrRatesExMarkRow.Value > 0;
  grRatesEx.Repaint;
end;

procedure TFormCalculationEstimate.pmTableLeftPopup(Sender: TObject);
var
  mainType: Integer;
  Edt: Boolean;
  i: Integer;
begin
  // Вынесено сюда так как mousedown работает глючно
  if (grRatesEx.SelectedRows.Count > 0) and not(grRatesEx.SelectedRows.CurrentRowSelected) then
    grRatesEx.SelectedRows.Clear;

  Edt := Editable;
  if (Sender is TPopupMenu) then
    for i := 0 to (Sender as TPopupMenu).Items.Count - 1 do
      (Sender as TPopupMenu).Items[i].Enabled := Edt;

  PMCopy.Enabled := (qrRatesExID_TYPE_DATA.AsInteger > 0);
  PMPaste.Enabled := ((qrRatesExID_TYPE_DATA.AsInteger > 0) or (qrRatesExID_TYPE_DATA.AsInteger = -5) or
    (qrRatesExID_TYPE_DATA.AsInteger = -4) or (qrRatesExID_TYPE_DATA.AsInteger = -3)) and
    ClipBoard.HasFormat(G_SMETADATA) and Edt;

  // Финт для преодаления глюка работы с горячими клавишами
  PMCopy.Enabled := PMCopy.Enabled or grRatesEx.EditorMode;
  PMPaste.Enabled := PMPaste.Enabled or grRatesEx.EditorMode;

  // Нельзя удалить неучтенный материал из таблицы расценок
  PMDelete.Visible := (qrRatesExID_TYPE_DATA.AsInteger > 0);
  PMAdd.Visible := CheckCursorInRate and not(Act and (TYPE_ACT = 0));
  PMInsertRow.Visible := (qrRatesExID_TYPE_DATA.AsInteger > 0) AND not(Act and (TYPE_ACT = 0));
  PMEdit.Visible := (qrRatesExID_TYPE_DATA.AsInteger in [5, 6, 7, 8, 9]) and CheckCursorInRate;
  PMCopy.Visible := not Act;
  pmCopyFromSM.Visible := not Act;
  PMPaste.Visible := not Act;
  mCopyToOwnBase.Visible := qrRatesExID_TYPE_DATA.Value in [1, 2, 3, 4];

  if Act then
    pmFindRowInEstim.Caption := 'Искать в акте'
  else
    pmFindRowInEstim.Caption := 'Искать в смете';

  pmMarkRow.Visible := qrRatesExID_TYPE_DATA.AsInteger > 0;
  pmMarkRow.Checked := qrRatesExMarkRow.Value > 0;

  // Разрешаем добавлять разделы ПТМ только когда курсор установлен на локальной смете
  // или открыта изначально локальная
  qrTemp.SQL.Text := 'SELECT SM_TYPE FROM smetasourcedata WHERE SM_ID=:ID';
  qrTemp.ParamByName('ID').AsInteger := IdEstimate;
  qrTemp.Active := True;
  mainType := qrTemp.FieldByName('SM_TYPE').AsInteger;
  qrTemp.Active := False;
  mAddPTM.Visible := (mainType <> 3) and not(Act and (TYPE_ACT = 0));
  mAddLocal.Visible := (mainType = 2) and not(Act and (TYPE_ACT = 0));
  mDelEstimate.Visible := (qrRatesExID_TYPE_DATA.AsInteger < 0) and (qrRatesExID_TYPE_DATA.AsInteger <> -4)
    and (qrRatesExID_TYPE_DATA.AsInteger <> -5);
  mEditEstimate.Visible := (qrRatesExID_TYPE_DATA.AsInteger < 0) and (qrRatesExID_TYPE_DATA.AsInteger <> -4)
    and (qrRatesExID_TYPE_DATA.AsInteger <> -5);
  mBaseData.Visible := (qrRatesExID_TYPE_DATA.AsInteger < 0) and (qrRatesExID_TYPE_DATA.AsInteger <> -4) and
    (qrRatesExID_TYPE_DATA.AsInteger <> -5);
  mBaseData.Caption := 'Исходные данные - ' + qrRatesExOBJ_CODE.AsString;
  // Просто удачное место, что-бы погасить растояние перевозки заданное при ручном вводе
  FTranspDistance := 0;
  // Гасит замену строки если решили воспользоваться справочниками
  FReplaceRowID := 0;
end;

procedure TFormCalculationEstimate.EstimateBasicDataClick(Sender: TObject);
begin
  fBasicData.ShowModal;
end;

procedure TFormCalculationEstimate.LabelObjectClick(Sender: TObject);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(fObjectsAndEstimates)) then
    fObjectsAndEstimates := TfObjectsAndEstimates.Create(Self);

  fObjectsAndEstimates.Show;

  // Закрываем форму ожидания
  FormWaiting.Close;
end;

procedure TFormCalculationEstimate.lblForemanClick(Sender: TObject);
begin
  if (not Assigned(fForemanList)) then
    fForemanList := TfForemanList.Create(FormMain);
  fForemanList.FormKind := kdSelect;
  if (fForemanList.ShowModal = mrOk) and (fForemanList.OutValue <> 0) then
  begin
    FastExecSQL('UPDATE smetasourcedata SET foreman_id=:0 WHERE SM_ID=:1',
      VarArrayOf([fForemanList.OutValue, IdEstimate]));
    lblForemanFIO.Caption :=
      VarToStr(FastSelectSQLOne
      ('SELECT CONCAT(IFNULL(foreman_first_name, ""), " ", IFNULL(foreman_name, ""), " ", IFNULL(foreman_second_name, "")) FROM foreman WHERE foreman_id=:0',
      VarArrayOf([fForemanList.OutValue])));
  end;
end;

procedure TFormCalculationEstimate.LabelEstimateClick(Sender: TObject);
begin
  // Показываем панельку с деревом смет
  if not Assigned(fTreeEstimate) then
    fTreeEstimate := TfTreeEstimate.Create(Self);
  fTreeEstimate.qrTreeEstimates.ParamByName('obj_id').Value := IdObject;
  CloseOpen(fTreeEstimate.qrTreeEstimates);
  fTreeEstimate.tvEstimates.FullExpand;
  if Assigned(fContractPrice) then
    fTreeEstimate.qrTreeEstimates.Locate('SM_ID', fContractPrice.qrMain.FieldByName('SM_ID').Value, [])
  else
    fTreeEstimate.qrTreeEstimates.Locate('SM_ID', qrRatesExSM_ID.Value, []);
  fTreeEstimate.Show;
end;

procedure TFormCalculationEstimate.lblSourceDataClick(Sender: TObject);
begin
  fBasicData.ShowForm(IdObject, IdEstimate);
  GetSourceData;
  GridRatesRowSellect;
  CloseOpen(qrRatesEx);
  CloseOpen(qrCalculations);
end;

// Открытие датасета таблицы материалов
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
  // Открытие датасета для заполнения таблицы материалов
  qrMaterial.Active := False;
  // Заполняет materials_temp
  qrMaterial.SQL.Text := 'call GetMaterials(' + INTTOSTR(fType) + ',' + INTTOSTR(fID) + ',' +
    INTTOSTR(G_SHOWMODE) + ')';
  qrMaterial.ExecSQL;

  qrMaterial.Active := False;
  // Открывает materials_temp
  qrMaterial.SQL.Text :=
    'SELECT * FROM materials_temp ORDER BY SRTYPE, TITLE DESC, MAT_CODE, MAT_NAME';
  qrMaterial.Active := True;
  i := 0;
  // Нумерация строк, внутри подгрупп
  while not qrMaterial.Eof do
  begin
    if (qrMaterialTITLE.AsInteger > 0) then
    begin
      i := 0;
      qrMaterial.Next;
    end;
    Inc(i);
    qrMaterial.Edit;
    qrMaterialNUM.AsInteger := i;
    qrMaterial.Post;

    qrMaterial.Next;
  end;
  qrMaterialNUM.ReadOnly := True;

  for i := 0 to dbgrdMaterial.Columns.Count - 1 do
    if (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'MAT_NORMA') or
      (dbgrdMaterial.Columns[i].FieldName.ToUpper = 'KOEFMR') then
      dbgrdMaterial.Columns[i].Visible := (qrRatesExID_TYPE_DATA.Value = 1) or
        ((qrRatesExID_TYPE_DATA.Value = 2) and (qrRatesExID_REPLACED.Value > 0) and
        (qrRatesExCONS_REPLASED.Value = 0));

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
    LikeText := 'Е18'
  else
    LikeText := 'Е20';
  qrStartup.Active := False;
  qrStartup.SQL.Text := 'select RATE_CODE, RATE_CAPTION, RATE_COUNT, RATE_UNIT ' +
    'from data_row_temp as dm LEFT JOIN card_rate_temp as cr ' +
    'ON (dm.ID_TYPE_DATA = 1) AND (cr.ID = dm.ID_TABLES) ' + 'WHERE (cr.RATE_CODE LIKE "%' + LikeText +
    '%") and (dm.SM_ID = ' + INTTOSTR(qrRatesExSM_ID.AsInteger) + ')';
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
  // Открытие датасета для заполнения таблицы материалов
  qrMechanizm.Active := False;
  // Заполняет Mechanizms_temp
  qrMechanizm.SQL.Text := 'call GetMechanizms(' + INTTOSTR(fType) + ',' + INTTOSTR(fID) + ',' +
    INTTOSTR(G_SHOWMODE) + ')';
  qrMechanizm.ExecSQL;

  qrMechanizm.Active := False;
  // Открывает Mechanizms_temp
  qrMechanizm.SQL.Text :=
    'SELECT * FROM mechanizms_temp ORDER BY SRTYPE, TITLE DESC, MECH_CODE, MECH_NAME';
  qrMechanizm.Active := True;
  i := 0;
  // Нумерация строк, внутри подгрупп
  while not qrMechanizm.Eof do
  begin
    if (qrMechanizmTITLE.AsInteger > 0) then
    begin
      i := 0;
      qrMechanizm.Next;
    end;
    Inc(i);
    qrMechanizm.Edit;
    qrMechanizmNUM.AsInteger := i;
    qrMechanizm.Post;

    qrMechanizm.Next;
  end;
  qrMechanizmNUM.ReadOnly := True;

  for i := 0 to dbgrdMechanizm.Columns.Count - 1 do
    if (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'MECH_NORMA') or
      (dbgrdMechanizm.Columns[i].FieldName.ToUpper = 'KOEF') then
      dbgrdMechanizm.Columns[i].Visible := (qrRatesExID_TYPE_DATA.AsInteger = 1);

  qrMechanizm.First;
  if (qrMechanizmTITLE.AsInteger > 0) then
    qrMechanizm.Next;

  FReCalcMech := False;
  qrMechanizm.EnableControls;
  qrMechanizmAfterScroll(qrMechanizm);
end;

function TFormCalculationEstimate.GetOHROPRId(const ANumRate: string): Integer;
var
  mes: string;
  COL1NAME, COL2NAME: string;
  MAIS: Integer;
begin
  Result := 1;
  try
    COL1NAME := FastSelectSQLOne('SELECT objstroj.COL1NAME FROM objstroj, objcards WHERE ' +
      'objcards.OBJ_ID=:0 and objcards.STROJ_ID=objstroj.STROJ_ID', VarArrayOf([IdObject]));
    COL2NAME := FastSelectSQLOne('SELECT objstroj.COL2NAME FROM objstroj, objcards ' +
      'WHERE objcards.OBJ_ID=:0 and objcards.STROJ_ID=objstroj.STROJ_ID', VarArrayOf([IdObject]));
    MAIS := FastSelectSQLOne('SELECT IFNULL(smetasourcedata.`MAIS_ID`, objcards.`MAIS_ID`) FROM ' +
      'smetasourcedata, objcards WHERE sm_id = :0 AND objcards.`obj_id` = ' + 'smetasourcedata.`OBJ_ID`',
      VarArrayOf([qrRatesExSM_ID.Value]));
    qrTemp.Active := False;
    qrTemp.SQL.Text := 'SELECT DISTINCT objworks.work_id as work_id, work_name as NAME,'#13 +
      'CONCAT(objdetailex.' + COL1NAME + ', "% / ", objdetailex.' + COL2NAME + ', "%") AS VALUE,'#13 +
      'CONCAT(s, " - ", po) AS DESCRIPTION'#13 +
      'FROM onormativs, objworks, objdetailex WHERE objdetailex.NUMBER=objworks.work_id ' +
      'AND objdetailex.MAIS_ID=:MAIS AND objworks.WORK_ID=onormativs.WORK_ID AND ' +
      'FN_NUM_TO_INT(:ncode)>=FN_NUM_TO_INT(s) and FN_NUM_TO_INT(:ncode)<=FN_NUM_TO_INT(po)';
    qrTemp.ParamByName('ncode').AsString := ANumRate;
    qrTemp.ParamByName('MAIS').AsInteger := MAIS;
    qrTemp.Active := True;
    qrTemp.First;
    if not qrTemp.Eof then
    begin
      if qrTemp.RecordCount = 1 then
      begin
        Result := qrTemp.FieldByName('work_id').Value;
      end
      else
      // Если нашлось более одной записи, показываем диалог
      begin
        mes := 'Расценка "' + qrRatesExOBJ_CODE.AsString +
          '" относится к нескольким настройкам ОХРиОПР и ПП. Укажите необходимый тип.';
        Application.MessageBox(PWideChar(mes), 'Расчет', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
        if ShowSelectDialog('Выбор типа ОХРиОПР и ПП', qrTemp) then
        begin
          Result := qrTemp.FieldByName('work_id').Value;
        end;
      end;
    end
    else
    begin
      Result := FastSelectSQLOne('SELECT def_work_id FROM round_setup LIMIT 1', VarArrayOf([]));
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('При получении значений ОХРиОПР:' + sLineBreak + sLineBreak + e.Message),
        PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.FillingOHROPR(const vNumber: string);
// Находим охр и опр по настройке
var
  TmpID: Integer;
begin
  if qrRatesExWORK_ID.AsInteger = 0 then
  begin
    TmpID := GetOHROPRId(vNumber);
    if TmpID > 0 then
      qrRatesExWORK_ID.AsInteger := TmpID;
  end;

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
  // Средний разряд рабочих-строителей
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
      MessageBox(0, PChar('При получении значения "Средний разряд" возникла ошибка:' + sLineBreak + sLineBreak
        + e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetWorkCostBuilders(const vIdNormativ: string): Double;
begin
  Result := 0;
  // Разраты труда рабочих-строителей
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
      MessageBox(0, PChar('При получении значения "ЗТ строителей" возникла ошибка:' + sLineBreak + sLineBreak
        + e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetWorkCostMachinists(const vIdNormativ: string): Double;
begin
  Result := 0;
  // Затраты труда машинистов
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
      MessageBox(0, PChar('При получении значения "ЗТ машинистов" возникла ошибка:' + sLineBreak + sLineBreak
        + e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
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
    // Количество из ЛЕВОЙ таблицы
    Count := CountFromRate; // MyStrToFloat(Cells[2, Row]);

    TZ := GetWorkCostBuilders(vIdNormativ) * Count;
    // Затраты труда рабочий * количество
    TZ1 := GetWorkCostBuilders(vIdNormativ); // Затраты труда рабочий * 1

    EditCategory.Text := MyFloatToStr(GetRankBuilders(vIdNormativ));

    // Получаем межразрядный коэффициент
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

      // Получаем регион (1-город, 2-село, 3-минск)
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
    // !!!!!!!!!! УМНОЖИТЬ НА КОЭФФИЦИЕНТ ГОСУДАРСТВА !!!!!!!!!!
    TZ1 := TZ1 * MRCoef * RateWorker;
    // !!!!!!!!!! УМНОЖИТЬ НА КОЭФФИЦИЕНТ ГОСУДАРСТВА !!!!!!!!!!

    // -----------------------------------------

    TW.ForOne := RoundTo(TZ1, PS.RoundTo * -1);
    TW.ForCount := RoundTo(TZ, PS.RoundTo * -1);

    Result := TW;
  except
    on e: Exception do
      MessageBox(0, PChar('Ошибка при вычислении «' + '», в таблице вычислений:' + sLineBreak + sLineBreak +
        e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.SettingVisibleRightTables;
begin
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

  dbmmoRight.DataSource := nil;
  dbmmoRight.DataField := '';
  dbmmoRight.ReadOnly := True;
  dbmmoRight.Color := clWindow;

  SetNoEditMode;

  if VisibleRightTables = '1000000' then
  begin
    dbgrdMaterial.Align := alClient;
    dbgrdMaterial.Visible := True;
    dbmmoRight.DataSource := dsMaterial;
    dbmmoRight.DataField := 'MAT_NAME';
  end
  else if VisibleRightTables = '0100000' then
  begin
    dbgrdMechanizm.Align := alClient;
    dbgrdMechanizm.Visible := True;
    dbmmoRight.DataSource := dsMechanizm;
    dbmmoRight.DataField := 'MECH_NAME';
  end
  else if VisibleRightTables = '0010000' then
  begin
    dbgrdDevices.Align := alClient;
    dbgrdDevices.Visible := True;
    dbmmoRight.DataSource := dsDevices;
    dbmmoRight.DataField := 'DEVICE_NAME';
  end
  else if VisibleRightTables = '0001000' then
  begin
    dbgrdDescription.Align := alClient;
    dbgrdDescription.Visible := True;
    dbgrdDescription.Columns[0].Width := dbgrdDescription.Width - 50;
    dbmmoRight.DataSource := dsDescription;
    dbmmoRight.DataField := qrDescription.Fields[0].FieldName;
  end
  else if VisibleRightTables = '0000100' then
  begin
    dbgrdDump.Align := alClient;
    dbgrdDump.Visible := True;
    dbmmoRight.DataSource := dsDump;
    dbmmoRight.DataField := 'DUMP_NAME';
  end
  else if VisibleRightTables = '0000010' then
  begin
    dbgrdTransp.Align := alClient;
    dbgrdTransp.Visible := True;
    dbmmoRight.DataSource := dsTransp;
    dbmmoRight.DataField := 'TRANSP_JUST';
  end
  else if VisibleRightTables = '0000001' then
  begin
    dbgrdStartup.Align := alClient;
    dbgrdStartup.Visible := True;
    dbmmoRight.DataSource := dsStartup;
    dbmmoRight.DataField := 'RATE_CAPTION';
  end
  else if VisibleRightTables = '1110000' then // Не используется!!!
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
        SQL.Add('select year(s.`DATE`) as YEAR, MONTH(s.`DATE`) AS MONTH FROM smetasourcedata s WHERE s.SM_ID='
          + INTTOSTR(IdEstimate) + ';');
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
      MessageBox(0, PChar('При запросе месяца и года из таблицы СТАВКА возникла ошибка:' + sLineBreak +
        e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
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
        EditMonth.Text := FormatDateTime('mmmm yyyy года.',
          StrToDate('01.' + qrTemp.FieldByName('monat').AsString + '.' + qrTemp.FieldByName('year')
          .AsString));

        if FieldByName('nds').Value then
        begin
          EditVAT.Text := 'c НДС';
          NDSEstimate := True;
        end
        else
        begin
          EditVAT.Text := 'без НДС';
          NDSEstimate := False;
        end;
      end;
      Active := False;
    end;
    // Исходя от того, используется НДС или нет настраивает внешний вид таблиц справа
    ChangeGrigNDSStyle(NDSEstimate);

  except
    on e: Exception do
      MessageBox(0, PChar('При получении исходных данных возникла ошибка:' + sLineBreak + sLineBreak +
        e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.getTYPE_ACT: Integer;
begin
  Result := TYPE_ACT;
end;

procedure TFormCalculationEstimate.ChangeGrigNDSStyle(aNDS: Boolean);
var
  i: Integer;
begin
  with dbgrdMaterial do
  begin
    // в зависимости от ндс скрывает одни и показывает другие калонки
    for i := 0 to Columns.Count - 1 do
    begin
      if (Columns[i].FieldName.ToUpper = 'NDS') or
         (Columns[i].FieldName.ToUpper = 'FCOAST_NDS') or
         (Columns[i].FieldName.ToUpper = 'FPRICE_NDS') or
         (Columns[i].FieldName.ToUpper = 'FTRANSP_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFCOAST_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFPRICE_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFTRANSP_NDS') then
        Columns[i].Visible := aNDS;

      if (Columns[i].FieldName.ToUpper = 'FCOAST_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'FPRICE_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'FTRANSP_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFCOAST_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFPRICE_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFTRANSP_NO_NDS') then
        Columns[i].Visible := not aNDS;
    end;
  end;

  with dbgrdMechanizm do
  begin
    for i := 0 to Columns.Count - 1 do
    begin
      if (Columns[i].FieldName.ToUpper = 'MECH_UNIT') then
        Columns[i].Visible := False;

      if (Columns[i].FieldName.ToUpper = 'NDS') or
         (Columns[i].FieldName.ToUpper = 'FCOAST_NDS') or
         (Columns[i].FieldName.ToUpper = 'FPRICE_NDS') or
         (Columns[i].FieldName.ToUpper = 'FZP_MACH_NDS') or
         (Columns[i].FieldName.ToUpper = 'FZPPRICE_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFCOAST_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFPRICE_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFZP_MACH_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFZPPRICE_NDS') then
        Columns[i].Visible := aNDS;

      if (Columns[i].FieldName.ToUpper = 'FCOAST_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'FPRICE_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'FZP_MACH_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'FZPPRICE_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFCOAST_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFPRICE_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFZP_MACH_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFZPPRICE_NO_NDS') then
        Columns[i].Visible := not aNDS;
    end;
  end;

  with dbgrdDevices do
  begin
    for i := 0 to Columns.Count - 1 do
    begin
      if (Columns[i].FieldName.ToUpper = 'DEVICE_UNIT') then
        Columns[i].Visible := False;

      if (Columns[i].FieldName.ToUpper = 'FCOAST_NDS') or
         (Columns[i].FieldName.ToUpper = 'DEVICE_TRANSP_NDS') or
         (Columns[i].FieldName.ToUpper = 'FPRICE_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFCOAST_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFTRANSP_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFPRICE_NDS') or
         (Columns[i].FieldName.ToUpper = 'NDS') then
        Columns[i].Visible := aNDS;

      if (Columns[i].FieldName.ToUpper = 'FCOAST_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'DEVICE_TRANSP_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'FPRICE_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFCOAST_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFTRANSP_NO_NDS') or
         (Columns[i].FieldName.ToUpper = 'VFPRICE_NO_NDS') then
        Columns[i].Visible := not aNDS;
    end;
  end;

  with dbgrdDump do
  begin
    // в зависимости от ндс скрывает одни и показывает другие калонки
    Columns[6].Visible := aNDS; // цена факт
    Columns[8].Visible := aNDS; // стоим факт

    Columns[7].Visible := not aNDS;
    Columns[9].Visible := not aNDS;
  end;

  with dbgrdTransp do
  begin
    // в зависимости от ндс скрывает одни и показывает другие калонки
    Columns[7].Visible := aNDS; // цена факт
    Columns[11].Visible := aNDS; // стоим факт

    Columns[8].Visible := not aNDS;
    Columns[12].Visible := not aNDS;
  end;
end;

procedure TFormCalculationEstimate.FillingWinterPrice(const vNumber: string);
var
  mes: string;
begin
  // ФТ-7 if qrRatesExAPPLY_WINTERPRISE_FLAG.AsInteger = 1 then
  try
    if qrRatesExZNORMATIVS_ID.AsInteger <> 0 then
    begin
      qrTemp.Active := False;
      qrTemp.SQL.Text := 'SELECT CONCAT(IFNULL(num, ""), " ", name) as "Name" ' +
        'FROM znormativs WHERE znormativs.ZNORMATIVS_ID=:ZNORMATIVS_ID LIMIT 1;';
      qrTemp.ParamByName('ZNORMATIVS_ID').AsInteger := qrRatesExZNORMATIVS_ID.AsInteger;
      qrTemp.Active := True;
      if VarIsNull(qrTemp.FieldByName('Name').Value) then
        edtWinterPrice.Text := 'не найден'
      else
        edtWinterPrice.Text := qrTemp.FieldByName('Name').AsString;
    end
    else
    begin
      qrTemp.Active := False;
      qrTemp.SQL.Text := 'SELECT znormativs.ZNORMATIVS_ID, num as "Number", name as "Name",'#13 +
        'CONCAT(s, " - ", po) AS DESCRIPTION,'#13 +
        'CONCAT(coef, "% / ", coef_zp, "%") AS VALUE, coef as "Coef", coef_zp as "CoefZP", FN_NUM_TO_INT(s) as "From", FN_NUM_TO_INT(po) as "On" '
        + 'FROM znormativs, znormativs_detail, znormativs_value ' +
        'WHERE znormativs.ZNORMATIVS_ID=znormativs_detail.ZNORMATIVS_ID  ' +
        'AND znormativs.ZNORMATIVS_ID = znormativs_value.ZNORMATIVS_ID ' + 'AND znormativs.DEL_FLAG = 0 ' +
        'AND znormativs_value.ZNORMATIVS_ONDATE_ID = (' + '  SELECT znormativs_ondate.ID' +
        '    FROM znormativs_ondate' +
        '    WHERE `znormativs_ondate`.`onDate` <= (SELECT CONVERT(CONCAT(stavka.YEAR,"-",stavka.MONAT,"-01"), DATE) FROM stavka WHERE stavka.STAVKA_ID = (SELECT STAVKA_ID FROM smetasourcedata WHERE SM_ID='
        + qrRatesExSM_ID.AsString + '))' +
        '    AND `znormativs_ondate`.`DEL_FLAG` = 0 ORDER BY `znormativs_ondate`.`onDate` DESC LIMIT 1) AND FN_NUM_TO_INT("'
        + vNumber + '")<=FN_NUM_TO_INT(po) AND FN_NUM_TO_INT("' + vNumber +
        '")>=FN_NUM_TO_INT(s) AND REPLACE(SUBSTRING(s FROM 1 FOR 1), "E", "Е")=REPLACE(SUBSTRING("' + vNumber
        + '" FROM 1 FOR 1), "E", "Е")' + ';';
      qrTemp.Active := True;
      qrTemp.First;
      if not qrTemp.Eof then
      begin
        if qrTemp.RecordCount = 1 then
        begin
          edtWinterPrice.Text := qrTemp.FieldByName('Number').AsString + ' ' +
            qrTemp.FieldByName('Name').AsString;
          FastExecSQL('UPDATE card_rate_temp SET ZNORMATIVS_ID=:0 WHERE ID=:1',
            VarArrayOf([qrTemp.FieldByName('ZNORMATIVS_ID').Value, qrRatesExID_TABLES.Value]));
          qrRatesExZNORMATIVS_ID.AsInteger := qrTemp.FieldByName('ZNORMATIVS_ID').AsInteger;
        end
        else
        // Если нашлось более одной записи, показываем диалог
        begin
          mes := 'Расценка "' + qrRatesExOBJ_CODE.AsString +
            '" относится к нескольким настройкам зимнего удорожания. Укажите необходимый вид.';
          Application.MessageBox(PWideChar(mes), 'Расчет', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
          if ShowSelectDialog('Выбор зимнего удорожания', qrTemp) then
          begin
            edtWinterPrice.Text := qrTemp.FieldByName('Number').AsString + ' ' +
              qrTemp.FieldByName('Name').AsString;
            FastExecSQL('UPDATE card_rate_temp SET ZNORMATIVS_ID=:0 WHERE ID=:1',
              VarArrayOf([qrTemp.FieldByName('ZNORMATIVS_ID').Value, qrRatesExID_TABLES.Value]));
            qrRatesExZNORMATIVS_ID.AsInteger := qrTemp.FieldByName('ZNORMATIVS_ID').AsInteger;
            CloseOpen(qrCalculations);
          end;
        end;
      end;
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('При получении значений зимнего удорожания возникла ошибка:' + sLineBreak +
        sLineBreak + e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
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

  if (Assigned(fKC6) and fKC6.Showing and fKC6.chkCopyTreeEstimates.Visible and
    (not fKC6.chkCopyTreeEstimates.Checked)) then
    fKC6.Button1.Enabled := (qrRatesExID_TYPE_DATA.Value = -3) or (qrRatesExID_TYPE_DATA.Value = -4);

  Panel1.Visible := (qrRatesExID_TYPE_DATA.Value = 1);

  if Assigned(fTreeEstimate) then
    fTreeEstimate.qrTreeEstimates.Locate('SM_ID', qrRatesExSM_ID.Value, []);
  // Блокирует лишние действия, если в цикле выполняется работа с qrRates

  // Вне зависимости от режима, все зависящие от qrRates
  // при смене строки закрываются, что-бы исключить случайный пересчет оставщегося
  // открытым датасета по данным другой расценки
  qrMaterial.Active := False;
  qrMechanizm.Active := False;
  qrDevices.Active := False;
  qrDump.Active := False;
  qrTransp.Active := False;
  qrStartup.Active := False;
  qrDescription.Active := False;
  ImageNoData.PopupMenu := nil;

  // На всякий случай, что-бы избежать глюков
  if not qrRatesEx.Active then
    Exit;

  // Скрываем колонки зименого удорожания если не нужны
  dbgrdCalculations.Columns[13].Visible := qrRatesExAPPLY_WINTERPRISE_FLAG.AsInteger = 1;
  dbgrdCalculations.Columns[14].Visible := qrRatesExAPPLY_WINTERPRISE_FLAG.AsInteger = 1;
  edtWinterPrice.Visible := qrRatesExAPPLY_WINTERPRISE_FLAG.AsInteger = 1;
  lblWinterPrice.Visible := qrRatesExAPPLY_WINTERPRISE_FLAG.AsInteger = 1;
  btnWinterPriceSelect.Visible := qrRatesExAPPLY_WINTERPRISE_FLAG.AsInteger = 1;
  dbgrdCalculations.Columns[13].Width := 64;
  dbgrdCalculations.Columns[14].Width := 64;
  FixDBGridColumnsWidth(dbgrdCalculations);

  LabelCategory.Visible := qrRatesExID_TYPE_DATA.AsInteger = 1;
  EditCategory.Visible := qrRatesExID_TYPE_DATA.AsInteger = 1;
  edtRateActive.Visible := qrRatesExID_TYPE_DATA.AsInteger = 1;
  edtRateActiveDate.Visible := qrRatesExID_TYPE_DATA.AsInteger = 1;
  // Если расценка
  if qrRatesExID_TYPE_DATA.AsInteger = 1 then
  begin
    // получаем статус расценки
    if FastSelectSQLOne('SELECT NORM_ACTIVE FROM normativg, card_rate_temp ' +
      'WHERE card_rate_temp.ID=:0 and card_rate_temp.RATE_ID=normativg.NORMATIV_ID',
      VarArrayOf([qrRatesExID_TABLES.Value])) = 1 then
    begin
      edtRateActive.Text := 'Действующая';
      edtRateActive.Color := $0080FF80;
      res := FastSelectSQLOne('SELECT date_beginer FROM normativg, card_rate_temp ' +
        'WHERE card_rate_temp.ID=:0 and card_rate_temp.RATE_ID=normativg.NORMATIV_ID',
        VarArrayOf([qrRatesExID_TABLES.Value]));
      if VarIsNull(res) then
        edtRateActiveDate.Text := 'дата не указана'
      else
        edtRateActiveDate.Text := DateToStr(res);
    end
    else
    begin
      edtRateActive.Text := 'Недействующая';
      edtRateActive.Color := clRed;
      res := FastSelectSQLOne('SELECT date_end FROM normativg, card_rate_temp ' +
        'WHERE card_rate_temp.ID=:0 and card_rate_temp.RATE_ID=normativg.NORMATIV_ID',
        VarArrayOf([qrRatesExID_TABLES.Value]));
      if VarIsNull(res) then
        edtRateActiveDate.Text := 'не указана'
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

  // Код можно редактировать везде кроме шапок смет
  qrRatesExOBJ_CODE.ReadOnly := not((qrRatesExID_TYPE_DATA.AsInteger = -4) or
    (qrRatesExID_TYPE_DATA.AsInteger = -5) or (qrRatesExID_TYPE_DATA.AsInteger > 0));

  // Для строк шапок и строк вставки
  if qrRatesExID_TYPE_DATA.AsInteger < 0 then
  begin
    qrRatesExOBJ_COUNT.ReadOnly := True;
    BottomTopMenuEnabled(False);
    TestOnNoDataNew(qrMaterial);
    Exit;
  end;

  // Можно редактировать кол-во для любой строки
  qrRatesExOBJ_COUNT.ReadOnly := False;

  // заполняет таблицы справа
  GridRatesRowSellect;
end;

// Проверка, что таблица является пустой(если пустая показывается картинка нет данных)
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

constructor TFormCalculationEstimate.Create(const SM_ID: Integer);
begin
  inherited Create(Application);
  LoadMain(SM_ID);
end;

procedure TFormCalculationEstimate.LoadMain(const SM_ID: Integer);
begin
  // Процедура открытия сметы / акта, загрузки всех параметров
  // TODO
  Act := FastSelectSQLOne('SELECT ACT FROM smetasourcedata WHERE SM_ID=:0', VarArrayOf([SM_ID])) = 1;
  TYPE_ACT := FastSelectSQLOne('SELECT IFNULL(TYPE_ACT, 0) FROM smetasourcedata WHERE SM_ID=:0',
    VarArrayOf([SM_ID]));
  IdObject := FastSelectSQLOne('SELECT OBJ_ID FROM smetasourcedata WHERE SM_ID=:0', VarArrayOf([SM_ID]));
  IdEstimate := SM_ID;
  pnlActSourceData.Visible := Act;
  if Act then
  begin
    edtActDate.Text := FormatDateTime('mmmm yyyy',
      FastSelectSQLOne('SELECT DATE FROM smetasourcedata WHERE SM_ID=:0', VarArrayOf([SM_ID])));
  end;
end;

procedure TFormCalculationEstimate.CreateTempTables;
begin
  try
    FastExecSQL('CALL CreateTempTables(1);', VarArrayOf([]));
  except
    on e: Exception do
      MessageBox(0, PChar('При создании временных таблиц возникла ошибка:' + sLineBreak + sLineBreak +
        e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.OpenAllData;
begin
  GetMonthYearCalculationEstimate;
  GetSourceData; // Выводим информациию об исходных данных сметы
  try
    if Act then
    begin
      try
        FastExecSQL('CALL OpenAllDataEstimate(:IdEstimate);', VarArrayOf([IdEstimate]));
      except
        ShowMessage(FastSelectSQLOne('SELECT @sql as QR;', VarArrayOf([])));
      end;
    end
    // Если открываем смету, то открываем весь объект
    else
    begin
      qrTemp.Active := False;
      qrTemp.SQL.Text := 'SELECT SM_ID FROM smetasourcedata WHERE OBJ_ID=:OBJ_ID AND SM_TYPE=2 AND ACT=:ACT';
      qrTemp.ParamByName('OBJ_ID').Value := IdObject;
      if Act then
        qrTemp.ParamByName('ACT').Value := 1
      else
        qrTemp.ParamByName('ACT').Value := 0;
      qrTemp.Active := True;
      qrTemp.First;
      while not qrTemp.Eof do
      begin
        try
          FastExecSQL('CALL OpenAllDataEstimate(:IdEstimate);',
            VarArrayOf([qrTemp.FieldByName('SM_ID').Value]));
        except
          ShowMessage(FastSelectSQLOne('SELECT @sql as QR;', VarArrayOf([])));
        end;
        qrTemp.Next;
      end;
      qrTemp.Active := False;
    end;
  except
    on e: Exception do
      MessageBox(0, PChar('При открытии данных возникла ошибка:' + sLineBreak + sLineBreak + e.Message),
        PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // Заполнение таблицы расценок
  OutputDataToTable;

  FillObjectInfo;

  if not qrOXROPR.Active then
    qrOXROPR.Active := True;
  if not qrTypeData.Active then
    qrTypeData.Active := True;
end;

procedure TFormCalculationEstimate.FillObjectInfo;
begin
  edtZone.Text := FastSelectSQLOne
    ('SELECT `objregion`.`REGION` FROM `objregion`, `objcards`, `objstroj` WHERE `objcards`.`OBJ_ID`=:0 and `objcards`.`STROJ_ID`=`objstroj`.`STROJ_ID` AND  `objstroj`.`OBJ_REGION`=`objregion`.`OBJ_REGION_ID`',
    VarArrayOf([IdObject]));
  edtZone.Width := GetTextWidth(edtZone.Text, edtZone.Handle) + 4;
  edtTypeWork.Text := FastSelectSQLOne
    ('SELECT `objstroj`.`NAME` FROM `objcards`, `objstroj` WHERE `objcards`.`OBJ_ID`=:0 and `objcards`.`STROJ_ID`=`objstroj`.`STROJ_ID`',
    VarArrayOf([IdObject]));
  edtTypeWork.Width := GetTextWidth(edtTypeWork.Text, edtTypeWork.Handle) + 4;
end;

// Заполнение таблицы расценок
procedure TFormCalculationEstimate.OutputDataToTable(ANewRow: Boolean = False);
var
  TmpSmID, RecNo: Integer;
  SortIDArray: TArray<string>;
  i: Integer;
begin
  // Новая процедура вывода левой части
  qrRatesEx.ParamByName('EAID').Value := IdEstimate;
  if Act then
    qrRatesEx.ParamByName('vIsACT').Value := 1
  else
    qrRatesEx.ParamByName('vIsACT').Value := 0;

  qrRatesEx.DisableControls;

  if qrRatesExID_TYPE_DATA.Value = -5 then
    qrRatesExID_TYPE_DATA.Value := -4;

  try
    if (ANewRow) then
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
        Inc(i);
        SetLength(SortIDArray, i);
        SortIDArray[i - 1] := strngfldRatesExSORT_ID.AsString;
        qrRatesEx.Next;
      until not((not qrRatesEx.Eof) and (TmpSmID = qrRatesExSM_ID.Value));
      TArray.Sort<string>(SortIDArray, TComparer<string>.Default);
      qrRatesEx.RecNo := RecNo;
    end;

    CloseOpen(qrRatesEx, False);

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

    grRatesEx.Col := 4;
  finally
    qrRatesEx.EnableControls;
    grRatesEx.SelectedRows.Clear;
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
begin
  if (Assigned(FormAdditionData)) then
  begin
    FormAdditionData.Show;
    Exit;
  end;
  DM.FDGUIxWaitCursor1.ScreenCursor := gcrHourGlass;
  try
    SendMessage(Application.MainForm.ClientHandle, WM_SETREDRAW, 0, 0);
    FormAdditionData := TFormAdditionData.Create(Self, vDataBase, GetSMSubType(qrRatesExSM_ID.Value));
    FormAdditionData.WindowState := wsNormal;

    FormAdditionData.FramePriceMaterial.OnSelect := AddMaterial;
    FormAdditionData.FramePriceMechanizm.OnSelect := AddMechanizm;
    FormAdditionData.FrameEquipment.OnSelect := AddDevice;

    PozWindow(FormAdditionData);
  finally
    SendMessage(Application.MainForm.ClientHandle, WM_SETREDRAW, 1, 0);
    RedrawWindow(Application.MainForm.ClientHandle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN or
      RDW_NOINTERNALPAINT);
    DM.FDGUIxWaitCursor1.ScreenCursor := gcrDefault;
  end;
end;

procedure TFormCalculationEstimate.PozWindow(AForm: TForm);
var FormLeft, BorderLeft: Integer;
begin
  // Сворачиваем окно
  WindowState := wsNormal;
  // Ставим форму в левый верхний угол
  Left := 0;
  Top := 0;

  // Устанавливаем размеры формы
  Width := FormMain.ClientWidth - 5;
  Height := FormMain.ClientHeight - (5 + 27); // + 27 - нижняя панель с кнопками

  // Делим левую и правую таблицы в соотношении 1 к 3
  PanelClientLeft.Width := FormMain.Width div 3;

  with AForm do
  begin
    // Расстояние сверху до формы с данными (внутри формы FormCalculationEstimate)
    // FormTop := PanelLocalEstimate.Top + PanelTopClient.Height;
    // Расстояние сверху до начала координат формы FormCalculationEstimate (внутри формы FormMain)
    // BorderTop := FormCalculationEstimate.Top;
    Top := FormCalculationEstimate.Top;
    // Расстояние слева до формы с данными (внутри формы FormCalculationEstimate)
    FormLeft := SplitterCenter.Left + SplitterCenter.Width;
    // Расстояние слева до начала координат формы FormCalculationEstimate (внутри формы FormMain)
    BorderLeft := FormCalculationEstimate.Left +
      (FormCalculationEstimate.Width - FormCalculationEstimate.ClientWidth) div 2;
    // Left := BorderLeft + FormLeft;
    Width := FormCalculationEstimate.ClientWidth - FormLeft +
      (FormCalculationEstimate.Width - FormCalculationEstimate.ClientWidth) div 2;
    // Шапка + высота клиентской область формы
    Height := GetSystemMetrics(SM_CYCAPTION) + FormCalculationEstimate.ClientHeight;
    // Отнимаем высоту нижней панели с кнопками
    Height := Height - 27;
    Left := BorderLeft + FormLeft;
  end;
end;

procedure TFormCalculationEstimate.ShowNeedSaveDialog;
begin
  if PS.ShowNeedSaveDialog then
  begin
    case Application.MessageBox
      ('Для корректного отображения результатов расчета необходимо сохранить текущий документ. Сохранить изменения?',
      'Расчет', MB_YESNOCANCEL + MB_ICONQUESTION + MB_TOPMOST) of
      IDCANCEL:
        Abort;
      IDYES:
        SaveData;
    end;
  end
  else
    SaveData;
end;

procedure TFormCalculationEstimate.AddCoefToRate(coef_id: Integer);
// Добавление коэфф. к строчке
var
  X: Word;
  TempBookmark: TBookMark;
begin
  grRatesEx.DataSource.DataSet.DisableControls;
  if grRatesEx.SelectedRows.Count = 0 then
    grRatesEx.SelectedRows.CurrentRowSelected := True;
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
            'INSERT INTO calculation_coef_temp(calculation_coef_id,SM_ID,id_type_data,id_owner,id_coef,COEF_NAME,OSN_ZP,EKSP_MACH,MAT_RES,WORK_PERS,WORK_MACH,OXROPR,PLANPRIB,ZP_MASH)'#13
            + 'SELECT GetNewID(:IDType), :SM_ID, :id_type_data, :id_owner, coef_id,COEF_NAME,OSN_ZP,EKSP_MACH,MAT_RES,WORK_PERS,WORK_MACH,OXROPR,PLANPRIB,ZP_MASH'#13
            + 'FROM coef WHERE coef.coef_id=:coef_id';
          qrTemp.ParamByName('IDType').Value := C_ID_SMCOEF;
          qrTemp.ParamByName('SM_ID').AsInteger := qrRatesExSM_ID.Value;
          qrTemp.ParamByName('id_owner').AsInteger := qrRatesExID_TABLES.AsInteger;
          qrTemp.ParamByName('id_type_data').AsInteger := qrRatesExID_TYPE_DATA.AsInteger;
          qrTemp.ParamByName('coef_id').AsInteger := coef_id;
          qrTemp.ExecSQL;

          if qrRatesExID_TYPE_DATA.Value < 0 then
          begin
            // Добавление во все содерожимое сметы, кроме пусконаладки
            FastExecSQL('INSERT INTO `calculation_coef_temp`(`calculation_coef_id`, ' +
              '`SM_ID`, `id_type_data`, `id_owner`,'#13 +
              ' `id_coef`, `COEF_NAME`, `OSN_ZP`, `EKSP_MACH`, `MAT_RES`, `WORK_PERS`,'#13 +
              '  `WORK_MACH`, `OXROPR`, `PLANPRIB`, `ZP_MASH`)'#13 +
              '(SELECT GetNewID(:IDType),data_row_temp.SM_ID,data_row_temp.ID_TYPE_DATA,data_row_temp.ID_TABLES,'#13
              + 'coef_id,COEF_NAME,OSN_ZP,EKSP_MACH,MAT_RES,WORK_PERS,WORK_MACH,OXROPR,PLANPRIB,coef.ZP_MASH'#13
              + 'FROM data_row_temp, coef WHERE ((data_row_temp.SM_ID=:id_estimate) OR (data_row_temp.SM_ID IN (SELECT SM_ID FROM smetasourcedata WHERE PARENT_ID=:id_estimate))) AND data_row_temp.ID_TYPE_DATA<10 AND coef.coef_id=:coef_id)',
              VarArrayOf([C_ID_SMCOEF, qrRatesExSM_ID.Value, coef_id]));
          end;
          {
            if qrRatesExID_TYPE_DATA.Value > 0 then
            begin
            FastExecSQL('CALL CalcRowInRateTab(:ID, :TYPE, 1);',
            VarArrayOf([qrRatesExID_TABLES.Value, qrRatesExID_TYPE_DATA.Value]));
            FastExecSQL('CALL CalcCalculation(:SM_ID, :ID_TYPE_DATA, :ID_TABLES, 0, :ID_ACT)',
            VarArrayOf([qrRatesExSM_ID.Value, qrRatesExID_TYPE_DATA.Value, qrRatesExID_TABLES.Value,
            qrRatesExID_ACT.Value]));
            GridRatesUpdateCount;
            end;
          }
        end;
      end;
    end;
  grRatesEx.DataSource.DataSet.GotoBookmark(TempBookmark);
  grRatesEx.DataSource.DataSet.FreeBookmark(TempBookmark);
  grRatesEx.DataSource.DataSet.EnableControls;
  grRatesEx.SetFocus;
  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.AddDevice(AEquipId, AManPriceID: Integer; APriceDate: TDateTime;
  ASprRecord: TSprRecord);
// Добавление оборудования к смете
begin
  try
    if not CheckCursorInRate then
      Exit;

    ReplaceSmRow(FReplaceRowID, FNewRowIterator, FNewNomManual);

    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddDevice(:IdEstimate, :IdDev, 0, :Iterator, :NomManual, :ManPriceID);');
      ParamByName('IdEstimate').Value := qrRatesExSM_ID.AsInteger;
      ParamByName('IdDev').Value := AEquipId;
      ParamByName('Iterator').Value := FNewRowIterator;
      ParamByName('NomManual').Value := FNewNomManual;
      ParamByName('ManPriceID').Value := AManPriceID;
      ExecSQL;
    end;

    OutputDataToTable(True);
  except
    on e: Exception do
      MessageBox(0, PChar('При добавлении оборудования возникла ошибка:' + sLineBreak + sLineBreak +
        e.Message), PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// Добавление материала к смете
procedure TFormCalculationEstimate.AddMaterial(AMatId, AManPriceID: Integer; APriceDate: TDateTime;
  ASprRecord: TSprRecord);
begin
  try
    if not CheckCursorInRate then
      Exit;

    ReplaceSmRow(FReplaceRowID, FNewRowIterator, FNewNomManual);

    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddMaterial(:IdEstimate, :IdMat, 0, :Iterator, ' +
        ':NomManual, :CALCMODE, :ManPriceID);');
      ParamByName('IdEstimate').Value := qrRatesExSM_ID.AsInteger;
      ParamByName('IdMat').Value := AMatId;
      ParamByName('Iterator').Value := FNewRowIterator;
      ParamByName('NomManual').Value := FNewNomManual;
      ParamByName('CALCMODE').Value := G_CALCMODE;
      ParamByName('ManPriceID').Value := AManPriceID;
      ExecSQL;
    end;

    OutputDataToTable(True);
  except
    on e: Exception do
      MessageBox(0, PChar('При добавлении материала возникла ошибка:' + sLineBreak + sLineBreak + e.Message),
        PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// Добавление механизма к смете
procedure TFormCalculationEstimate.AddMechanizm(AMechId, AManPriceID: Integer; APriceDate: TDateTime;
  ASprRecord: TSprRecord);
begin
  try
    if not CheckCursorInRate then
      Exit;

    ReplaceSmRow(FReplaceRowID, FNewRowIterator, FNewNomManual);

    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddMechanizm(:IdEstimate, :IdMech, 0, :Iterator, ' +
        ':NomManual, :CALCMODE, :ManPriceID);');
      ParamByName('IdEstimate').Value := qrRatesExSM_ID.AsInteger;
      ParamByName('IdMech').Value := AMechId;
      ParamByName('Iterator').Value := FNewRowIterator;
      ParamByName('NomManual').Value := FNewNomManual;
      ParamByName('CALCMODE').Value := G_CALCMODE;
      ParamByName('ManPriceID').Value := AManPriceID;
      ExecSQL;
    end;

    OutputDataToTable(True);
  except
    on e: Exception do
      MessageBox(0, PChar('При добавлении механизма возникла ошибка:' + sLineBreak + sLineBreak + e.Message),
        PChar(FMesCaption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.dbgrdCalculationsResize(Sender: TObject);
begin
  if qrCalculations.RecordCount > dbgrdCalculations.VisibleRowCount then
    dbgrdCalculations.ScrollBars := ssVertical
  else
    dbgrdCalculations.ScrollBars := ssNone;
end;

procedure TFormCalculationEstimate.dbgrdDescription1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with dbgrdDescription.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;
    if gdFocused in State then // Ячейка в фокусе
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    if Assigned(TMyDBGrid(dbgrdDescription).DataLink) and
      (dbgrdDescription.Row = TMyDBGrid(dbgrdDescription).DataLink.ActiveRecord + 1) and
      (dbgrdDescription = FLastEntegGrd) then
    begin
      Font.Style := Font.Style + [fsBold];
    end;

    FillRect(Rect);
    TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Column.Field.AsString);
  end;
end;

procedure TFormCalculationEstimate.dbgrdCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
begin
  AllowEdit := Editable;
end;

procedure TFormCalculationEstimate.dbgrdDevicesDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if ((Sender as TJvDBGrid).MaxColumnWidth > 0) and
     (Column.Width >= (Sender as TJvDBGrid).MaxColumnWidth) then
    Column.Width := (Sender as TJvDBGrid).MaxColumnWidth - 1;

  with (Sender as TJvDBGrid).Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    // Подсветка поля код (для красоты)
    if Column.Index = 1 then
      Brush.Color := $00F0F0FF;

    // Подсветка полей стоимости
    if (Column.FieldName.ToUpper = 'PRICE_NDS') or
       (Column.FieldName.ToUpper = 'PRICE_NO_NDS') or
       (Column.FieldName.ToUpper = 'FPRICE_NDS') or
       (Column.FieldName.ToUpper = 'FPRICE_NO_NDS') or
       (Column.FieldName.ToUpper = 'VFPRICE_NDS') or
       (Column.FieldName.ToUpper = 'VFPRICE_NO_NDS') then
        Brush.Color := $00FBFEBC;

    if Assigned(TMyDBGrid(Sender).DataLink) and
      ((Sender as TJvDBGrid).Row = TMyDBGrid(Sender).DataLink.ActiveRecord + 1) and
      (TJvDBGrid(Sender) = FLastEntegGrd) then
    begin
      Font.Style := Font.Style + [fsBold];
      // Все поля открытые для редактирования подсвечиваются желтеньким
      if not Column.ReadOnly then
        Brush.Color := $00AFFEFC
    end;

    if (gdFocused in State) or // Ячейка в фокусе
       (FCalculator.Visible and (gdSelected in State)) // Или на неё открыли калькулятор
    then
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    (Sender as TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
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

procedure TFormCalculationEstimate.dbgrdMaterialCanEditCell(Grid: TJvDBGrid; Field: TField;
  var AllowEdit: Boolean);
begin
  AllowEdit := Editable;
  if not AllowEdit then
    Exit;

  // Перечень полей которые можно редактировать всегда
  if (Field.FieldName.ToUpper = 'VFCOAST_NO_NDS') or
     (Field.FieldName.ToUpper = 'VFCOAST_NDS') or
     (Field.FieldName.ToUpper = 'VFTRANSP_NO_NDS') or
     (Field.FieldName.ToUpper = 'VFTRANSP_NDS') or
     (Field.FieldName.ToUpper = 'MAT_PROC_PODR') or
     (Field.FieldName.ToUpper = 'MAT_PROC_ZAC') or
     (Field.FieldName.ToUpper = 'TRANSP_PROC_PODR') or
     (Field.FieldName.ToUpper = 'TRANSP_PROC_ZAC') then
    Exit;

  AllowEdit := FMatInEditMode;
end;

procedure TFormCalculationEstimate.dbgrdMaterialDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Str: string;
begin
  // Преодоление глюка
  if ((Sender as TJvDBGrid).MaxColumnWidth > 0) and (Column.Width >= (Sender as TJvDBGrid).MaxColumnWidth)
  then
    Column.Width := (Sender as TJvDBGrid).MaxColumnWidth - 1;

  // Порядок строчек очень важен для данной процедуры
  with dbgrdMaterial.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    // Подсветка поля код (для красоты)
    if Column.Index = 1 then
      Brush.Color := $00F0F0FF;

    // Подсветка полей стоимости
    if (Column.FieldName.ToUpper = 'FPRICE_NDS') or
       (Column.FieldName.ToUpper = 'FPRICE_NO_NDS') or
       (Column.FieldName.ToUpper = 'VFPRICE_NDS') or
       (Column.FieldName.ToUpper = 'VFPRICE_NO_NDS') then
      Brush.Color := $00FBFEBC;

    // Подсветка красным пустых значений  норма, цена и %трансп
    if ((Column.FieldName.ToUpper = 'MAT_NORMA') or
        (Column.FieldName.ToUpper = 'FCOAST_NDS') or
        (Column.FieldName.ToUpper = 'FCOAST_NO_NDS') or
        (Column.FieldName.ToUpper = 'PROC_TRANSP')) and
       (Column.Field.Value = 0) then
      Brush.Color := $008080FF;

    if Assigned(TMyDBGrid(dbgrdMaterial).DataLink) and
      (dbgrdMaterial.Row = TMyDBGrid(dbgrdMaterial).DataLink.ActiveRecord + 1) and
      (dbgrdMaterial = FLastEntegGrd) then
    begin
      Font.Style := Font.Style + [fsBold];
      // Все поля открытые для редактирования подсвечиваются желтеньким
      if not Column.ReadOnly then
        Brush.Color := $00AFFEFC;
    end;

    // Подсветка зеленым фактических транспортных расходов в режиме ручного ввода
    if (Column.FieldName.ToUpper = 'FTRANSP_NDS') or
       (Column.FieldName.ToUpper = 'FTRANSP_NO_NDS') then
    begin
      if qrMaterialFTRANSCOUNT.Value > 0 then
      begin
        Brush.Color := $0080FF80;
        // Подсветка красным если значение вводилось для другого колва
        if qrMaterialFTRANSCOUNT.Value <> qrMaterialMAT_COUNT.Value then
          Brush.Color := $008080FF;
      end;
    end;

    if (Column.FieldName.ToUpper = 'VFTRANSP_NDS') or
       (Column.FieldName.ToUpper = 'VFTRANSP_NO_NDS') then
    begin
      if qrMaterialVFTRANSCOUNT.Value > 0 then
      begin
        Brush.Color := $0080FF80;
        // Подсветка красным если значение вводилось для другого колва
        if qrMaterialVFTRANSCOUNT.Value <> qrMaterialMAT_COUNT.Value then
          Brush.Color := $008080FF;
      end;
    end;

    // Зачеркиваем вынесеные из расцеки материалы
    if (qrMaterialFROM_RATE.Value = 1) and
       (qrRatesExID_TYPE_DATA.Value = 1) then
    begin
      Font.Style := Font.Style + [fsStrikeOut];
      Brush.Color := $00DDDDDD;
    end;

    // подсвечиваем замененный материал
    if (qrMaterialREPLACED.Value = 1) then
    begin
      Brush.Color := $00DDDDDD;
    end;

    // подсвечиваем удаленный материал
    if (qrMaterialDELETED.Value = 1) then
    begin
      Font.Style := Font.Style + [fsStrikeOut];
      Brush.Color := $008080FF;
    end;

    // Подсветка замененного материяла (подсветка П-шки)
    if (FIdReplasedMat > 0) and
       (qrMaterialID.Value = FIdReplasedMat) and
       (dbgrdMaterial = FLastEntegGrd) then
      Font.Style := Font.Style + [fsBold];

    // Подсветка замененяющего материала
    if (FIdReplasingMat > 0) and
       (FIdReplasingMat = qrMaterialID_REPLACED.Value) and
       (dbgrdMaterial = FLastEntegGrd) then
      Font.Style := Font.Style + [fsBold];

    Str := '';
    // Подсветка синим подшапок таблицы
    if qrMaterialTITLE.AsInteger > 0 then
    begin
      Brush.Color := clNavy;
      Font.Color := clWhite;
      Font.Style := Font.Style + [fsBold];
      if Column.Index = 1 then
        if Assigned(Column.Field) then
          Str := Column.Field.DisplayText;
    end
    else
    begin
      if Assigned(Column.Field) then
        Str := Column.Field.DisplayText;
    end;

    // Не отображает кол-во и суммы для замененных или вынесеных
    if ((qrMaterialFROM_RATE.Value = 1) and (qrRatesExID_TYPE_DATA.Value = 1)) or
       (qrMaterialREPLACED.Value = 1) or
       (qrMaterialDELETED.Value = 1) then
    begin
      if (Column.FieldName.ToUpper = 'MAT_COUNT') or
         (Column.FieldName.ToUpper = 'FPRICE_NDS') or
         (Column.FieldName.ToUpper = 'FPRICE_NO_NDS') or
         (Column.FieldName.ToUpper = 'FTRANSP_NDS') or
         (Column.FieldName.ToUpper = 'FTRANSP_NO_NDS') or
         (Column.FieldName.ToUpper = 'VFPRICE_NDS') or
         (Column.FieldName.ToUpper = 'VFPRICE_NO_NDS') or
         (Column.FieldName.ToUpper = 'VFTRANSP_NDS') or
         (Column.FieldName.ToUpper = 'VFTRANSP_NO_NDS') then
        Str := '';
    end;

    if (gdFocused in State) or // Ячейка в фокусе
      (FCalculator.Visible and (gdSelected in State)) // Или на неё открыли калькулятор
    then
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    // Подсветкаа добавленного материала
    if qrMaterialADDED.Value = 1 then
      Font.Color := clBlue;

    if qrMaterialID_REPLACED.Value > 0 then
      Font.Style := Font.Style + [fsItalic];

    FillRect(Rect);
    if Column.Alignment = taRightJustify then
      TextRect(Rect, Rect.Right - 2 - TextWidth(Str), Rect.Top + 2, Str)
    else
      TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Str);
  end;
end;

procedure TFormCalculationEstimate.dbgrdMaterialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // 45 - Insert
  // Исловие аналогично условаю в PopupMenuMaterialsPopup
  if (Key = 45) and ((not CheckMatReadOnly) and (qrMaterialTITLE.AsInteger = 0)) then
    SetMatEditMode;
end;

procedure TFormCalculationEstimate.dbgrdMechanizmCanEditCell(Grid: TJvDBGrid; Field: TField;
  var AllowEdit: Boolean);
begin
  AllowEdit := Editable;
  if not AllowEdit then
    Exit;

  if (Field.FieldName.ToUpper = 'VFCOAST_NO_NDS') or
     (Field.FieldName.ToUpper = 'VFCOAST_NDS') or
     (Field.FieldName.ToUpper = 'VFZP_MACH_NO_NDS') or
     (Field.FieldName.ToUpper = 'VFZP_MACH_NDS') or
     (Field.FieldName.ToUpper = 'PROC_PODR') or
     (Field.FieldName.ToUpper = 'PROC_ZAC') then
    Exit;

  AllowEdit := FMechInEditMode;
end;

procedure TFormCalculationEstimate.dbgrdMechanizmDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Str: string;
begin
  if ((Sender as TJvDBGrid).MaxColumnWidth > 0) and (Column.Width >= (Sender as TJvDBGrid).MaxColumnWidth)
  then
    Column.Width := (Sender as TJvDBGrid).MaxColumnWidth - 1;

  with dbgrdMechanizm.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    // Подсветка поля код (для красоты)
    if Column.Index = 1 then
      Brush.Color := $00F0F0FF;

    if (Column.FieldName.ToUpper = 'FPRICE_NDS') or
       (Column.FieldName.ToUpper = 'FPRICE_NO_NDS') or
       (Column.FieldName.ToUpper = 'FZPPRICE_NDS') or
       (Column.FieldName.ToUpper = 'FZPPRICE_NO_NDS') or
       (Column.FieldName.ToUpper = 'VFPRICE_NDS') or
       (Column.FieldName.ToUpper = 'VFPRICE_NO_NDS') or
       (Column.FieldName.ToUpper = 'VFZPPRICE_NDS') or
       (Column.FieldName.ToUpper = 'VFZPPRICE_NO_NDS') then
      Brush.Color := $00FBFEBC;

    // Подсветка красным пустых значений
    if ((Column.FieldName.ToUpper = 'MECH_NORMA') or
        (Column.FieldName.ToUpper = 'FCOAST_NDS') or
        (Column.FieldName.ToUpper = 'FCOAST_NO_NDS')) and
       (Column.Field.Value = 0) then
      Brush.Color := $008080FF;

    if Assigned(TMyDBGrid(dbgrdMechanizm).DataLink) and
      (dbgrdMechanizm.Row = TMyDBGrid(dbgrdMechanizm).DataLink.ActiveRecord + 1) and
      (dbgrdMechanizm = FLastEntegGrd) then
    begin
      Font.Style := Font.Style + [fsBold];
      // Все поля открытые для редактирования подсвечиваются желтеньким
      if not Column.ReadOnly then
        Brush.Color := $00AFFEFC
    end;

    // Зачеркиваем вынесеные из расцеки механизмы
    if (qrMechanizmFROM_RATE.Value = 1) and (qrRatesExID_TYPE_DATA.Value = 1) then
    begin
      Font.Style := Font.Style + [fsStrikeOut];
      Brush.Color := $00DDDDDD
    end;

    // подсвечиваем замененный механизм
    if (qrMechanizmREPLACED.Value = 1) then
    begin
      Brush.Color := $00DDDDDD;
    end;

    // подсвечиваем удаленный механизм
    if (qrMechanizmDELETED.Value = 1) then
    begin
      Font.Style := Font.Style + [fsStrikeOut];
      Brush.Color := $008080FF;
    end;

    // Подсветка замененного механизма
    if (FIdReplasedMech > 0) and
       (qrMechanizmID.Value = FIdReplasedMech) and
       (dbgrdMechanizm = FLastEntegGrd)
    then
      Font.Style := Font.Style + [fsBold];

    // Подсветка замененяющего механизма
    if (FIdReplasingMech > 0) and
       (FIdReplasingMech = qrMechanizmID_REPLACED.Value) and
       (dbgrdMechanizm = FLastEntegGrd) then
      Font.Style := Font.Style + [fsBold];

    Str := '';
    // Подсветка синим подшапок таблицы
    if qrMechanizmTITLE.Value > 0 then
    begin
      Brush.Color := clNavy;
      Font.Color := clWhite;
      Font.Style := Font.Style + [fsBold];
      if Column.Index = 1 then
        if Assigned(Column.Field) then
          Str := Column.Field.DisplayText;
    end
    else
    begin
      if Assigned(Column.Field) then
        Str := Column.Field.DisplayText;
    end;

    if ((qrMechanizmFROM_RATE.Value = 1) and (qrRatesExID_TYPE_DATA.Value = 1)) or
       (qrMechanizmREPLACED.Value = 1) or
       (qrMechanizmDELETED.Value = 1) then
    begin
      if (Column.FieldName.ToUpper = 'MECH_COUNT') or
         (Column.FieldName.ToUpper = 'FPRICE_NDS') or
         (Column.FieldName.ToUpper = 'FPRICE_NO_NDS') or
         (Column.FieldName.ToUpper = 'FZPPRICE_NDS') or
         (Column.FieldName.ToUpper = 'FZPPRICE_NO_NDS') or
         (Column.FieldName.ToUpper = 'VFPRICE_NDS') or
         (Column.FieldName.ToUpper = 'VFPRICE_NO_NDS') or
         (Column.FieldName.ToUpper = 'VFZPPRICE_NDS') or
         (Column.FieldName.ToUpper = 'VFZPPRICE_NO_NDS') or
         (Column.FieldName.ToUpper = 'TERYDOZATR') then
        Str := '';
    end;

    if (gdFocused in State) or // Ячейка в фокусе
      (FCalculator.Visible and (gdSelected in State)) // Или на неё открыли калькулятор
    then
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    // Подсветкаа добавленного материала
    if qrMechanizmADDED.Value = 1 then
      Font.Color := clBlue;

    if qrMechanizmID_REPLACED.Value > 0 then
      Font.Style := Font.Style + [fsItalic];

    FillRect(Rect);
    if Column.Alignment = taRightJustify then
      TextRect(Rect, Rect.Right - 2 - TextWidth(Str), Rect.Top + 2, Str)
    else
      TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Str);
  end;
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
      Font.Style := Font.Style + [fsBold];
      Brush.Color := clSilver;
    end;
    if (qrRatesExID_TYPE_DATA.AsInteger = -4) or (qrRatesExID_TYPE_DATA.AsInteger = -5) then
    begin
      Font.Color := PS.FontRows;
      Brush.Color := clInactiveBorder;
    end;

    // Подсветка нумерации строк как фиксированной облости
    if Column.Index = 0 then
      Brush.Color := grRatesEx.FixedColor;

    // Подсвечиваем расценку с добавленными материалами/механизмами
    if qrRatesExADDED_COUNT.Value > 0 then
      Font.Color := clBlue;
    // Подсветка отрицательного кол-ва
    if qrRatesExOBJ_COUNT.Value < 0 then
      Font.Color := clRed;
    // Подсветка отмеченных строк
    if qrRatesExMarkRow.Value > 0 then
      Font.Color := clPurple;
    // Подсветка выделения
    if (grRatesEx.SelectedRows.CurrentRowSelected) and (grRatesEx.SelectedRows.Count > 1) then
      Font.Color := $008080FF;

    if Assigned(TMyDBGrid(grRatesEx).DataLink) and
      (grRatesEx.Row = TMyDBGrid(grRatesEx).DataLink.ActiveRecord + 1)
    // and (grRatesEx = LastEntegGrd) // Подсвечивается жирным только если есть фокус
    then
    begin
      Font.Style := Font.Style + [fsBold];
    end;

    if gdFocused in State then // Ячейка в фокусе
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    // Подсветка вынесенного за расценку материала и заменяющего материала
    // Вынесение за расценку имеет приоритет над заменой
    if btnMaterials.Down and qrMaterial.Active and (dbgrdMaterial = FLastEntegGrd) then
    begin
      if (qrRatesExID_TABLES.AsInteger = qrMaterialID.AsInteger) and (qrRatesExID_TYPE_DATA.AsInteger = 2) and
        ((grRatesEx.Row <> TMyDBGrid(grRatesEx).DataLink.ActiveRecord + 1)) then
        Font.Style := Font.Style + [fsBold];
    end;

    // Подсветка заменяющего для пэшки
    if btnMaterials.Down and qrMaterial.Active and (dbgrdMaterial = FLastEntegGrd) then
    begin
      if (qrRatesExID_REPLACED.AsInteger = qrMaterialID.AsInteger) and (qrRatesExID_TYPE_DATA.AsInteger = 2)
        and (qrMaterialCONSIDERED.AsInteger = 0) and
        ((grRatesEx.Row <> TMyDBGrid(grRatesEx).DataLink.ActiveRecord + 1)) then
        Font.Style := Font.Style + [fsBold];
    end;

    // Подсветка вынесенного за расценку механизма
    if btnMechanisms.Down and qrMechanizm.Active and (dbgrdMechanizm = FLastEntegGrd) then
    begin
      if (qrRatesExID_TABLES.AsInteger = qrMechanizmID.AsInteger) and (qrRatesExID_TYPE_DATA.AsInteger = 3)
        and (grRatesEx.Row <> TMyDBGrid(grRatesEx).DataLink.ActiveRecord + 1) then
        Font.Style := Font.Style + [fsBold];
    end;

    if qrRatesExREPLACED_COUNT.Value > 0 then
      Font.Style := Font.Style + [fsItalic];

    (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFormCalculationEstimate.dbgrdEnter(Sender: TObject);
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
  // Запрет инсерта
  if Key = 45 then
    Key := 0;

  grRatesEx.ReadOnly := pnlCalculationYesNo.Tag = 0;
end;

procedure TFormCalculationEstimate.dbmmoEnter(Sender: TObject);
begin
  (Sender as TDBMemo).ReadOnly := not Editable;
end;

procedure TFormCalculationEstimate.dbmmoCAPTIONExit(Sender: TObject);
begin
  if (qrRatesEx.State in [dsEdit, dsInsert]) and
    (qrRatesEx.FieldByName('OBJ_NAME').Value <> qrRatesEx.FieldByName('OBJ_NAME').OldValue) then
  begin
    if PS.AutosaveRateDescr or (Application.MessageBox('Сохранить описание записи?', 'Смета',
      MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES) then
    begin
      FastExecSQL('UPDATE data_row_temp SET OBJ_NAME=:0 WHERE ID=:1',
        VarArrayOf([dbmmoCAPTION.Text, qrRatesExDATA_ESTIMATE_OR_ACT_ID.Value]));
    end
    else
      qrRatesEx.Cancel;
    qrRatesEx.CheckBrowseMode;
  end;
end;

function TFormCalculationEstimate.SprManualData(ASprType: Integer; const ANewCode: string;
  var ANewID: Integer): Boolean;
var
  SprCard: TManSprCardForm;
begin
  Result := False;
  SprCard := TManSprCardForm.Create(Self, ANewID, ASprType, ANewCode);
  try
    if SprCard.ShowModal = mrOk then
    begin
      ANewID := SprCard.SprID;
      Result := True;
    end;
  finally
    FreeAndNil(SprCard);
  end;
end;

end.
