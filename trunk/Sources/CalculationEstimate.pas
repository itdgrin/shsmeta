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
  JvDBGrid, JvDBUltimGrid;

type
  TSplitter = class(ExtCtrls.TSplitter)
  private
    procedure Paint(); override;
  end;

  TMyDBGrid = class(TDBGrid)
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
    SpeedButtonDescription: TSpeedButton;
    SpeedButtonMaterials: TSpeedButton;
    SpeedButtonMechanisms: TSpeedButton;

    // ---------------------------

    PanelBottomButtons: TPanel;
    PanelButtonsLocalEstimate: TPanel;
    ButtonCopy: TButton;
    ButtonInsert: TButton;
    ButtonSelect: TButton;
    ButtonSelectRange: TButton;
    ButtonAdd: TButton;
    ButtonFind: TButton;
    ButtonDelete: TButton;
    PanelButtonsSSR: TPanel;
    ButtonSSRAdd: TButton;
    ButtonSSRDelete: TButton;
    ButtonSSRTax: TButton;
    ButtonSSRDetails: TButton;
    ButtonSSRUpload: TButton;
    ButtonSSRSave: TButton;
    PanelLocalEstimate: TPanel;
    ImageSplitterBottom: TImage;
    SplitterBottom: TSplitter;
    PanelClient: TPanel;
    ImageSplitterCenter: TImage;
    SplitterCenter: TSplitter;
    PanelTopClient: TPanel;
    Label2: TLabel;
    ComboBoxTypeData: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
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
    ComboBoxOXROPR: TComboBox;
    PanelSSR: TPanel;
    PanelSummaryCalculations: TPanel;
    PanelData: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    EditVAT: TEdit;
    EditMonth: TEdit;
    Edit4: TEdit;
    PanelCalculationYesNo: TPanel;
    PanelButtonsSummaryCalculations: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    PopupMenuButtonSummaryCalculation: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ButtonSRRNew: TButton;
    PopupMenuSSRButtonAdd: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    PopupMenuSSRButtonTax: TPopupMenu;
    N6: TMenuItem;
    N7: TMenuItem;
    ButtonTechnicalPart: TButton;
    PopupMenuTableLeft: TPopupMenu;
    PMAdd: TMenuItem;
    PMDelete: TMenuItem;
    PopupMenuTableLeftTechnicalPart: TMenuItem;
    N20: TMenuItem;
    ModeData: TMenuItem;
    Normal: TMenuItem;
    Extended: TMenuItem;
    N22: TMenuItem;
    PopupMenuMaterials: TPopupMenu;
    StringGridCalculations_del: TStringGrid;
    PopupMenuCoef: TPopupMenu;
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
    PopupMenuCoefSeparator2: TMenuItem;
    PopupMenuCoefSeparator1: TMenuItem;
    PopupMenuCoefCopy: TMenuItem;
    PopupMenuCoefColumns: TMenuItem;
    EditWinterPrice: TEdit;
    PopupMenuTableLeftTechnicalPart1: TMenuItem;
    PopupMenuTableLeftTechnicalPart2: TMenuItem;
    PopupMenuTableLeftTechnicalPart3: TMenuItem;
    PopupMenuTableLeftTechnicalPart4: TMenuItem;
    PopupMenuTableLeftTechnicalPart5: TMenuItem;
    PopupMenuTableLeftTechnicalPart6: TMenuItem;
    SpeedButtonEquipments: TSpeedButton;
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
    PMAddAdditionWinterPrice: TMenuItem;
    PopupMenuRatesAdd352: TMenuItem;
    PMMatFromRates: TMenuItem;
    PopupMenuMechanizms: TPopupMenu;
    PMMechFromRates: TMenuItem;
    PMMatReplace: TMenuItem;
    PMMatReplaceNumber: TMenuItem;
    PMMatReplaceTable: TMenuItem;
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
    PMReplace: TMenuItem;
    N9: TMenuItem;
    PMReplaceNumber: TMenuItem;
    PMReplaceTable: TMenuItem;
    PMMatReplaceTableRef: TMenuItem;
    PMMatReplaceTableOwn: TMenuItem;
    PMReplaceTableRef: TMenuItem;
    PMReplaceTableOwn: TMenuItem;
    PMReplaceNumberRef: TMenuItem;
    PMReplaceNumberOwn: TMenuItem;
    PMMatReplaceNumberRef: TMenuItem;
    PMMatReplaceNumberOwn: TMenuItem;
    PMMatEdit: TMenuItem;
    PMEdit: TMenuItem;
    PMCoefOrders: TMenuItem;
    PopupMenuCoefOrders: TMenuItem;
    EditCoefOrders: TEdit;
    LabelCategory: TLabel;
    EditCategory: TEdit;
    Button4: TButton;
    qrDescription: TFDQuery;
    qrTemp: TFDQuery;
    qrTemp1: TFDQuery;
    frSummaryCalculations: TfrCalculationEstimateSummaryCalculations;
    frSSR: TfrCalculationEstimateSSR;
    qrRates: TFDQuery;
    dsRates: TDataSource;
    dsDescription: TDataSource;
    qrRatesDID: TIntegerField;
    qrRatesRID: TIntegerField;
    qrRatesMID: TIntegerField;
    qrRatesMEID: TIntegerField;
    qrRatesIID: TIntegerField;
    qrRatesTYPE_DATA: TIntegerField;
    qrRatesIDID: TIntegerField;
    qrRatesCODE: TStringField;
    qrRatesCOUNT: TFloatField;
    qrRatesUNIT: TStringField;
    qrRatesCAPTION: TStringField;
    qrRatesCONSIDERED: TIntegerField;
    qrRatesREPLACED: TIntegerField;
    qrRatesID_CARD_RATE: TIntegerField;
    qrRatesID_REPLACED: TIntegerField;
    qrRatesFROM_RATE: TIntegerField;
    qrRatesSCROLL: TIntegerField;
    qrRatesNUM: TIntegerField;
    qrRatesRATEIDINRATE: TIntegerField;
    qrRatesCODEINRATE: TStringField;
    qrMechanizm: TFDQuery;
    dsMechanizm: TDataSource;
    qrDescriptionwork: TStringField;
    qrMechanizmID: TFDAutoIncField;
    qrMechanizmID_CARD_RATE: TIntegerField;
    qrMechanizmBD_ID: TIntegerField;
    qrMechanizmMECH_ID: TIntegerField;
    qrMechanizmMECH_CODE: TStringField;
    qrMechanizmMECH_NAME: TStringField;
    qrMechanizmMECH_NORMA: TFloatField;
    qrMechanizmMECH_COUNT: TFloatField;
    qrMechanizmMECH_UNIT: TStringField;
    qrMechanizmCOAST_NO_NDS: TIntegerField;
    qrMechanizmCOAST_NDS: TIntegerField;
    qrMechanizmZP_MACH_NO_NDS: TIntegerField;
    qrMechanizmZP_MACH_NDS: TIntegerField;
    qrMechanizmMECH_PRICE: TIntegerField;
    qrMechanizmMECH_ACTIVE: TShortintField;
    qrMechanizmDOC_DATE: TDateField;
    qrMechanizmDOC_NUM: TStringField;
    qrMechanizmFROM_RATE: TByteField;
    qrMechanizmFCOAST_NO_NDS: TIntegerField;
    qrMechanizmFCOAST_NDS: TIntegerField;
    HeaderControl1: THeaderControl;
    N8: TMenuItem;
    qrRatesCOUNTFORCALC: TFloatField;
    PMMechEdit: TMenuItem;
    qrMechanizmFZP_MACH_NO_NDS: TIntegerField;
    qrMechanizmFZP_MACH_NDS: TIntegerField;
    dbgrdMechanizm: TJvDBGrid;
    qrMechanizmNDS: TSmallintField;
    qrMechanizmPROC_PODR: TSmallintField;
    qrMechanizmPROC_ZAC: TSmallintField;
    qrMaterial: TFDQuery;
    dsMaterial: TDataSource;
    dbgrdMaterial: TJvDBGrid;
    qrMaterialID: TFDAutoIncField;
    qrMaterialBD_ID: TIntegerField;
    qrMaterialID_CARD_RATE: TIntegerField;
    qrMaterialID_REPLACED: TIntegerField;
    qrMaterialCONSIDERED: TByteField;
    qrMaterialREPLACED: TByteField;
    qrMaterialFROM_RATE: TByteField;
    qrMaterialMAT_ID: TIntegerField;
    qrMaterialMAT_CODE: TStringField;
    qrMaterialMAT_NAME: TStringField;
    qrMaterialMAT_NORMA: TFloatField;
    qrMaterialMAT_COUNT: TFloatField;
    qrMaterialMAT_UNIT: TStringField;
    qrMaterialCOAST_NO_NDS: TIntegerField;
    qrMaterialCOAST_NDS: TIntegerField;
    qrMaterialTRANSP_NO_NDS: TIntegerField;
    qrMaterialNDS: TIntegerField;
    qrMaterialFCOAST_NO_NDS: TIntegerField;
    qrMaterialFCOAST_NDS: TIntegerField;
    qrMaterialFTRANSP_NO_NDS: TIntegerField;
    qrMaterialFTRANSP_NDS: TIntegerField;
    qrMaterialMAT_ACTIVE: TByteField;
    qrMaterialSTATE_MATERIAL: TShortintField;
    qrMaterialSTATE_TRANSPORT: TByteField;
    qrMaterialDOC_DATE: TDateField;
    qrMaterialDOC_NUM: TStringField;
    qrMaterialMAT_PROC_ZA�: TIntegerField;
    qrMaterialMAT_PROC_PODR: TIntegerField;
    qrMaterialTRANSP_PROC_ZAC: TIntegerField;
    qrMaterialTRANSP_PROC_PODR: TIntegerField;
    qrMaterialNUM: TIntegerField;
    qrMaterialSCROLL: TIntegerField;
    qrMaterialTITLE: TIntegerField;
    qrMaterialPROC_TRANSP: TFloatField;
    N10: TMenuItem;
    qrRatesSTYPE: TIntegerField;
    qrMaterialMAT_KOEF: TFloatField;
    qrRatesDEID: TIntegerField;
    qrDevices: TFDQuery;
    dsDevices: TDataSource;
    qrDevicesID: TFDAutoIncField;
    qrDevicesBD_ID: TWordField;
    qrDevicesDEVICE_ID: TIntegerField;
    qrDevicesDEVICE_ACTIVE: TShortintField;
    qrDevicesDEVICE_CODE: TStringField;
    qrDevicesDEVICE_NAME: TStringField;
    qrDevicesDEVICE_COUNT: TFloatField;
    qrDevicesDEVICE_UNIT: TStringField;
    qrDevicesFCOAST_NO_NDS: TIntegerField;
    qrDevicesFCOAST_NDS: TIntegerField;
    qrDevicesNDS: TWordField;
    qrDevicesDOC_DATE: TDateField;
    qrDevicesDOC_NUM: TStringField;
    qrDevicesFACEMAN: TStringField;
    dbgrdDevices: TJvDBGrid;
    qrDevicesPROC_PODR: TWordField;
    qrDevicesPROC_ZAC: TWordField;
    PopupMenuDevices: TPopupMenu;
    PMDevEdit: TMenuItem;
    qrMechanizmNORMATIV: TFloatField;
    qrMechanizmNORM_TRYD: TFloatField;
    qrMechanizmTERYDOZATR: TFloatField;
    dbgrdCalculations: TDBGrid;
    qrCalculations: TFDQuery;
    dsCalculations: TDataSource;
    qrRatesESTIMATE_ID: TIntegerField;
    qrRatesOWNER_ID: TIntegerField;
    qrMaterialMAT_SUM_NO_NDS: TLargeintField;
    qrMaterialMAT_SUM_NDS: TLargeintField;
    qrMaterialMAT_TRANSP_NO_NDS: TLargeintField;
    qrMaterialMAT_TRANSP_NDS: TLargeintField;
    qrMaterialPRICE_NO_NDS: TLargeintField;
    qrMaterialPRICE_NDS: TLargeintField;
    qrMaterialFPRICE_NO_NDS: TLargeintField;
    qrMaterialFPRICE_NDS: TLargeintField;
    qrMaterialTRANSP_NDS: TIntegerField;
    qrMechanizmMECH_SUM_NO_NDS: TLargeintField;
    qrMechanizmMECH_SUM_NDS: TLargeintField;
    qrMechanizmMECH_ZPSUM_NO_NDS: TLargeintField;
    qrMechanizmMECH_ZPSUM_NDS: TLargeintField;
    qrMechanizmPRICE_NO_NDS: TLargeintField;
    qrMechanizmPRICE_NDS: TLargeintField;
    qrMechanizmZPPRICE_NO_NDS: TLargeintField;
    qrMechanizmZPPRICE_NDS: TLargeintField;
    qrMechanizmFPRICE_NO_NDS: TLargeintField;
    qrMechanizmFPRICE_NDS: TLargeintField;
    qrMechanizmFZPPRICE_NO_NDS: TLargeintField;
    qrMechanizmFZPPRICE_NDS: TLargeintField;
    qrMechanizmSCROLL: TIntegerField;
    qrMechanizmNUM: TIntegerField;
    qrDevicesDEVICE_SUM_NDS: TLargeintField;
    qrDevicesDEVICE_SUM_NO_NDS: TLargeintField;
    qrDevicesFPRICE_NDS: TLargeintField;
    qrDevicesFPRICE_NO_NDS: TLargeintField;
    qrDevicesSCROLL: TIntegerField;
    qrDevicesNUM: TIntegerField;
    qrDevicesDEVICE_TRANSP_NO_NDS: TLargeintField;
    qrDevicesDEVICE_TRANSP_NDS: TLargeintField;
    qrDevicesTRANSP_PROC_PODR: TWordField;
    qrDevicesTRANSP_PROC_ZAC: TWordField;
	qrRatesDUID: TIntegerField;	dbmmoCAPTION: TDBMemo;
    qrDump: TFDQuery;
    dsDump: TDataSource;
    SpeedButtonDump: TSpeedButton;
    dbgrdDump: TJvDBGrid;
    qrDumpID: TFDAutoIncField;
    qrDumpDUMP_NAME: TStringField;
    qrDumpDUMP_CODE_JUST: TStringField;
    qrDumpDUMP_JUST: TStringField;
    qrDumpDUMP_UNIT: TStringField;
    qrDumpDUMP_TYPE: TByteField;
    qrDumpDUMP_SUM_NDS: TLargeintField;
    qrDumpDUMP_SUM_NO_NDS: TLargeintField;
    qrDumpCOAST_NO_NDS: TLongWordField;
    qrDumpCOAST_NDS: TLongWordField;
    qrDumpWORK_UNIT: TStringField;
    qrDumpWORK_TYPE: TByteField;
    qrDumpNDS: TIntegerField;
    qrDumpPRICE_NDS: TLargeintField;
    qrDumpPRICE_NO_NDS: TLargeintField;
    qrDumpFCOAST_NDS: TLongWordField;
    qrDumpFCOAST_NO_NDS: TLongWordField;
    qrDumpFPRICE_NDS: TLargeintField;
    qrDumpFPRICE_NO_NDS: TLargeintField;
    qrDumpNUM: TIntegerField;
    PopupMenuDumpTransp: TPopupMenu;
    PMDumpEdit: TMenuItem;
    qrDumpDUMP_ID: TLongWordField;
    qrDumpDUMP_COUNT: TFloatField;
    qrDumpWORK_COUNT: TFloatField;
    qrDumpWORK_YDW: TFloatField;
    dbgrdDescription: TJvDBGrid;
    dbgrdRates: TJvDBGrid;
    qrRatesTRID: TIntegerField;
    SpeedButtonTransp: TSpeedButton;
    SpeedButtonStartup: TSpeedButton;
    qrTransp: TFDQuery;
    qrStartup: TFDQuery;
    dsTransp: TDataSource;
    dsStartup: TDataSource;
    dbgrdTransp: TJvDBGrid;
    qrTranspID: TFDAutoIncField;
    qrTranspTRANSP_TYPE: TByteField;
    qrTranspTRANSP_CODE_JUST: TStringField;
    qrTranspTRANSP_JUST: TStringField;
    qrTranspTRANSP_COUNT: TFloatField;
    qrTranspTRANSP_DIST: TFloatField;
    qrTranspTRANSP_SUM_NDS: TLargeintField;
    qrTranspTRANSP_SUM_NO_NDS: TLargeintField;
    qrTranspCOAST_NO_NDS: TLongWordField;
    qrTranspCOAST_NDS: TLongWordField;
    qrTranspCARG_CLASS: TByteField;
    qrTranspCARG_UNIT: TStringField;
    qrTranspCARG_TYPE: TByteField;
    qrTranspCARG_COUNT: TFloatField;
    qrTranspCARG_YDW: TFloatField;
    qrTranspNDS: TIntegerField;
    qrTranspPRICE_NDS: TLargeintField;
    qrTranspPRICE_NO_NDS: TLargeintField;
    qrTranspNUM: TIntegerField;
    qrStartupRATE_CODE: TStringField;
    qrStartupRATE_CAPTION: TStringField;
    qrStartupRATE_COUNT: TFloatField;
    qrStartupRATE_UNIT: TStringField;
    qrStartupNUM: TIntegerField;
    dbgrdStartup: TJvDBGrid;
    qrTranspCLASS: TStringField;
    qrTranspTRANSP_UNIT: TStringField;
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
    procedure PopupMenuCoefColumnsClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PopupMenuTableLeftTechnicalPartClick(Sender: TObject);

    // ������� ����������� ���� � ������ �������
    procedure PopupMenuCoefAddSetClick(Sender: TObject);
    procedure PopupMenuCoefDeleteSetClick(Sender: TObject);

    // ������� ������ ������
    procedure SpeedButtonDescriptionClick(Sender: TObject);
    procedure SpeedButtonMaterialsClick(Sender: TObject);
    procedure SpeedButtonMechanismsClick(Sender: TObject);

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

    procedure Calculation;

    procedure CalculationMaterial;

    procedure CalculationMechanizm;

    // ������� ������ �������-����������
    function GetRankBuilders(const vIdNormativ: string): Double;

    // ������� ����� �������-����������
    function GetWorkCostBuilders(const vIdNormativ: string): Double;

    // ������� ����� ����������
    function GetWorkCostMachinists(const vIdNormativ: string): Double;

    // ������ �� (���������� �����)
    function CalculationSalary(const vIdNormativ: string): TTwoValues;

    // ������ �� (������������ �������)
    procedure CalculationMR;

    // ������ % ����������
    procedure CalculationPercentTransport; // +++

    // ����� ������� �� ���������
    function GetNormMechanizm(const vIdNormativ, vIdMechanizm: string): Double;

    // ���� �� ���������
    function GetPriceMechanizm(const vIdNormativ, vIdMechanizm: string): Currency;

    // �������� ��������� (�� ���.)
    function GetSalaryMachinist(const vIdMechanizm: Integer): Currency;

    // ���� ������������� (������, ������) ���������
    function GetCoastMechanizm(const vIdMechanizm: Integer): Currency;

    // ������ ���� (������������ ����� � ����������)
    function CalculationEMiM(const vIdNormativ: string): TTwoValues;

    // ������ �� ��������� (�������� ���������)
    procedure CalculationSalaryMachinist; // +++

    // ���������
    procedure CalculationCost; // +++

    // ������ ��� � ���
    procedure CalculationOXROPR; // +++

    // ������ ���� �������
    procedure CalculationPlanProfit; // +++

    // ������ ��� � ���
    procedure CalculationCostOXROPR; // +++

    // ������ ������� ����������
    procedure CalculationWinterPrice; // +++

    // ������ �� � ������ ����������
    procedure CalculationSalaryWinterPrice; // +++

    // ������ ����
    procedure CalculationWork; // +++

    // ������ ���� ���.
    procedure CalculationWorkMachinist; // +++

    procedure EstimateBasicDataClick(Sender: TObject);
    procedure LabelObjectClick(Sender: TObject);
    procedure LabelEstimateClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure LabelMouseEnter(Sender: TObject);
    procedure LabelMouseLeave(Sender: TObject);
    procedure PanelObjectResize(Sender: TObject);
    procedure ComboBoxOXROPRChange(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure PanelTopMenuResize(Sender: TObject);
    procedure SettingVisibleRightTables;
    procedure PanelClientRightTablesResize(Sender: TObject);
    procedure SpeedButtonEquipmentsClick(Sender: TObject);
    procedure SpeedButtonModeTablesClick(Sender: TObject);
    procedure GetMonthYearCalculationEstimate;
    procedure FillingOXROPR;
    procedure GetSourceData;
    procedure SetIndexOXROPR(vNumber: string);
    procedure GetValuesOXROPR;
    procedure FillingWinterPrice(vNumber: string);

    procedure PMDeleteClick(Sender: TObject);
    procedure PanelNoDataResize(Sender: TObject);
    procedure TestOnNoData(SG: TStringGrid);
    procedure TestOnNoDataNew(ADataSet: TDataSet);
    procedure PMMatFromRatesClick(Sender: TObject);
    procedure CopyEstimate;
    procedure VisibleColumnsWinterPrice(Value: Boolean);
    procedure ReplacementNumber(Sender: TObject);
    procedure ReplacementMaterial(const vIdMat: Integer);

    procedure PMMatReplaceTableClick(Sender: TObject);
    procedure ShowFormAdditionData(const vDataBase: Char);
    procedure PMAddRatMatMechEquipRefClick(Sender: TObject);
    procedure PMAddRatMatMechEquipOwnClick(Sender: TObject);

    function GetPriceMaterial(): Variant;
    procedure PopupMenuMaterialsPopup(Sender: TObject);

    procedure PMCoefOrdersClick(Sender: TObject);
    procedure PopupMenuTableLeftPopup(Sender: TObject);
    // �������� ����������� �� �������� ���������
    procedure GetStateCoefOrdersInEstimate;
    procedure GetStateCoefOrdersInRate;
    // �������� ���� ��������� (��������� ��� �� ���������) ������������ �� ��������
    procedure PopupMenuCoefOrdersClick(Sender: TObject);
    procedure PopupMenuCoefPopup(Sender: TObject);
    procedure Button4Click(Sender: TObject);

    procedure OutputDataToTable(aRecNo: Integer); // ���������� ������� ��������

    procedure AddRate(const vRateId: Integer);
    procedure AddMaterial(const vMatId: Integer);
    procedure AddMechanizm(const vMechId: Integer);
    procedure AddDevice(const vEquipId: Integer);

    procedure PMMechFromRatesClick(Sender: TObject);
    procedure dbgrdRates12DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure qrRatesAfterScroll(DataSet: TDataSet);
    procedure qrRatesCOUNTChange(Sender: TField);
    procedure dbgrdDescription1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure qrDescriptionAfterScroll(DataSet: TDataSet);
    procedure qrMechanizmBeforeInsert(DataSet: TDataSet);
    procedure qrMechanizmAfterScroll(DataSet: TDataSet);
    procedure qrMechanizmCalcFields(DataSet: TDataSet);
    procedure qrRatesBeforeInsert(DataSet: TDataSet);
    procedure dbgrdMechanizmDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure PMMechEditClick(Sender: TObject);
    procedure qrMechanizmBeforeScroll(DataSet: TDataSet);
    procedure MechRowChange(Sender: TField);
    procedure MatRowChange(Sender: TField);
    procedure dbgrdMechanizmExit(Sender: TObject);
    procedure PopupMenuMechanizmsPopup(Sender: TObject);
    procedure qrRatesBeforePost(DataSet: TDataSet);
    procedure MemoRightExit(Sender: TObject);
    procedure MemoRightChange(Sender: TObject);
    procedure qrMaterialBeforeScroll(DataSet: TDataSet);
    procedure qrMaterialAfterScroll(DataSet: TDataSet);
    procedure dbgrdMaterialDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure PMMatEditClick(Sender: TObject);
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
    procedure SpeedButtonDumpClick(Sender: TObject);
    procedure qrDumpAfterScroll(DataSet: TDataSet);
    procedure PMDumpEditClick(Sender: TObject);
    procedure PMAddTranspClick(Sender: TObject);
    procedure SpeedButtonTranspClick(Sender: TObject);
    procedure SpeedButtonStartupClick(Sender: TObject);
    procedure qrTranspAfterScroll(DataSet: TDataSet);
    procedure qrStartupAfterScroll(DataSet: TDataSet);
    procedure qrTranspCalcFields(DataSet: TDataSet);
    procedure PMAddAdditionHeatingE18Click(Sender: TObject);
    procedure qrRatesCODEChange(Sender: TField);
    procedure PMEditClick(Sender: TObject);
  private
    ActReadOnly: Boolean;
    RowCoefDefault: Boolean;
    NameRowCoefDefault: String;

    IdObject: Integer;
    IdEstimate: Integer;
    NDSEstimate: Boolean; // ������  � ��� ��� ���

    MonthEstimate: Integer;
    YearEstimate: Integer;

    VisibleRightTables: String; // ��������� ����������� ������ ������� ������

    WCWinterPrice: Integer;
    WCSalaryWinterPrice: Integer;

    CountFromRate: Double;

    DataBase: Char;

    // ����� ��������� �� ������ ��������, ��������� ������������ � ������������ �nChange;
    ReCalcMech, ReCalcMat, ReCalcDev: Boolean;
    // ID ����������� ��������� ������� ���� ����������
    IdReplasedMat: Integer;
    // ID ����������� ��������� ������� ���� ����������
    IdReplasingMat: Integer;

    //������������ � �������� ������ ���������
    RepIdRate: integer;
    RepIdMat: integer;

    // ������������� ��� ����������� � ������ � ������� ��������
    procedure ReCalcRowRates;

    // �������� ������� ��� ������ � ����������� �� ���
    procedure ChangeGrigNDSStyle(aNDS: Boolean);
    // �������� ��� �������� ��������� � ������� ��������
    function CheckMatUnAccountingRates: Boolean;
    // ��������� ��� �������� ������ �������� (��������� ��� ����������)
    function CheckMatINRates: Boolean;

    // �������� ��� �������� ��������� � ������� ����������
    function CheckMatUnAccountingMatirials: Boolean;

    procedure ReCalcRowMat; // �������� ������ ���������
    function CheckMatReadOnly: Boolean; // �������� ����� �� ������������� ������ ������
    procedure SetMatReadOnly(AValue: Boolean); // ������������� ����� ��������������
    procedure SetMatEditMode; // ��������� ������ ������������ �������������� ����������
    procedure SetMatNoEditMode; // ���������� ������ ������������ �������������� ����������

    procedure ReCalcRowMech; // �������� ������ ���������
    function CheckMechReadOnly: Boolean; // �������� ����� �� ������������� ������ ������
    procedure SetMechReadOnly(AValue: Boolean); // ������������� ����� ��������������
    procedure SetMechEditMode; // ��������� ������ ������������ �������������� ���������
    procedure SetMechNoEditMode; // ���������� ������ ������������ �������������� ���������

    procedure ReCalcRowDev; // �������� ������ ������������
    procedure SetDevEditMode; // ��������� ������ ������������ �������������� ������������
    procedure SetDevNoEditMode; // ���������� ������ ������������ �������������� ������������
  public
    Act: Boolean;
    IdAct: Integer;
    // CountCoef : Integer;
    ConfirmCloseForm: Boolean;
    function GetCountCoef(): Integer;
    procedure AddCoefToRate(coef_id: Integer);
    procedure SetIdObject(const Value: Integer);
    procedure SetIdAct(const Value: Integer);
    procedure SetActReadOnly(const Value: Boolean);
    function GetIdObject: Integer;
    procedure SetIdEstimate(const Value: Integer);
    function GetIdEstimate: Integer;
    function GetMonth: Integer;
    function GetYear: Integer;
    procedure AddRowToTableRates(FieldRates: TFieldRates);
    procedure CreateTempTables;
    procedure OpenAllData;
    procedure Wheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
      var Handled: Boolean);

  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  const
    Indent = '     ';

  end;

var
  FormCalculationEstimate: TFormCalculationEstimate;
  TwoValues: TTwoValues;

  function NDSToNoNDS(aValue: Int64; aNDS: integer): int64;
  function NoNDSToNDS(aValue: Int64; aNDS: integer): int64;

implementation

uses Main, DataModule, Columns, SignatureSSR, Waiting,
  SummaryCalculationSettings, DataTransfer, Coefficients,
  BasicData, ObjectsAndEstimates, PercentClientContractor, Transportation,
  CalculationDump, SaveEstimate,
  ReplacementMaterial, Materials, AdditionData, CardMaterial, CardDataEstimate,
  ListCollections, CoefficientOrders, KC6,
  CardAct, Tools;

{$R *.dfm}

function NDSToNoNDS(aValue: Int64; aNDS: integer): int64;
begin
  Result := Round(aValue / (1.000000 + 0.010000 * aNDS));
end;

function NoNDSToNDS(aValue: Int64; aNDS: integer): int64;
begin
 Result := Round(aValue * (1.000000 + 0.010000 * aNDS));
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
  with TDBGrid(Sender) do
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
var
  i: Integer;
  Path: string;
  IFile: TIniFile;
begin
  FormMain.PanelCover.Visible := True; // ���������� ������ �� ������� �����

  // -----------------------------------------

  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10;
  // (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := 10; // GetSystemMetrics(SM_CXFRAME) * -1;

  WindowState := wsMaximized;
  Caption := FormNameCalculationEstimate;

  // -----------------------------------------

  IdObject := 0;
  IdEstimate := 0;
  Act := False;

  if VisibleRightTables <> '1000000' then
  begin
    VisibleRightTables := '1000000';
    SettingVisibleRightTables;
  end;

  VisibleRightTables := '';

  ShowHint := True;

  // -----------------------------------------

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
  PanelSummaryCalculations.Visible := False;
  PanelSSR.Visible := False;

  PanelLocalEstimate.Align := alClient;
  PanelSummaryCalculations.Align := alClient;
  PanelSSR.Align := alClient;

  // -----------------------------------------

  // ��������� ��������� ������ ������� � ��������

  PanelButtonsLocalEstimate.Align := alNone;
  PanelButtonsSummaryCalculations.Align := alNone;
  PanelButtonsSSR.Align := alNone;

  PanelButtonsLocalEstimate.Visible := True;
  PanelButtonsSummaryCalculations.Visible := False;
  PanelButtonsSSR.Visible := False;

  PanelButtonsLocalEstimate.Align := alClient;

  // -----------------------------------------

  PanelClientLeft.Width := 2 * ((FormMain.ClientWidth - 5) div 7);

  dbgrdCalculations.Constraints.MinHeight := 50;
  PanelClientLeft.Constraints.MinWidth := 30;
  dbmmoCAPTION.Constraints.MinHeight := 45;
  MemoRight.Constraints.MinHeight := 45;

  // -----------------------------------------

  FillingOXROPR;

  ConfirmCloseForm := True;

  RowCoefDefault := True;
  // ������ ������ � ������ ��������
  PanelTableBottom.Height := 110 + PanelBottom.Height;

  // ��������� ����� DBGrid �������
  LoadDBGridSettings(dbgrdRates);
  LoadDBGridSettings(dbgrdMaterial);
  LoadDBGridSettings(dbgrdMechanizm);
  LoadDBGridSettings(dbgrdDevices);
  LoadDBGridSettings(dbgrdDescription);
  LoadDBGridSettings(dbgrdDump);
  LoadDBGridSettings(dbgrdTransp);
  LoadDBGridSettings(dbgrdStartup);
  LoadDBGridSettings(dbgrdCalculations);

  // TCustomDbGridCracker(dbgrdRates).OnMouseWheel:=Wheel;
  if not Act then
  FormMain.CreateButtonOpenWindow('������ �����', '������ �����',
    FormMain.ShowCalculationEstimate);
end;

procedure TFormCalculationEstimate.FormShow(Sender: TObject);
begin
  SettingVisibleRightTables;

  dbgrdRates.SetFocus;

  FormMain.TimerCover.Enabled := True;
  // ��������� ������ ������� ������ ������ ����� ����������� �����
end;

procedure TFormCalculationEstimate.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButtonCalculationEstimate);
end;

procedure TFormCalculationEstimate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // ��������� �� ������ �� ������ CapsLock
  if (GetKeyState(VK_CAPITAL) and $01) <> 0 then
  begin
    keybd_event(VK_CAPITAL, 0, 0, 0);
    keybd_event(VK_CAPITAL, 0, KEYEVENTF_KEYUP, 0);
  end;
  Action := caFree;
end;

procedure TFormCalculationEstimate.FormDestroy(Sender: TObject);
begin
  FormCalculationEstimate := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButtonCalculationEstimate);
end;

procedure TFormCalculationEstimate.FormResize(Sender: TObject);
begin
  FixDBGridColumnsWidth(dbgrdCalculations);
end;

procedure TFormCalculationEstimate.SpeedButtonLocalEstimateClick(Sender: TObject);
begin
  if SpeedButtonLocalEstimate.Tag = 0 then
  begin
    SpeedButtonLocalEstimate.Down := True;

    SpeedButtonLocalEstimate.Tag := 1;
    SpeedButtonSummaryCalculation.Tag := 0;
    SpeedButtonSSR.Tag := 0;

    // ��������� ��������� �������
    PanelLocalEstimate.Visible := True;
    PanelSummaryCalculations.Visible := False;
    PanelSSR.Visible := False;

    // -----------------------------------------

    // ��������� ��������� ������ ������� � ��������

    PanelButtonsLocalEstimate.Align := alNone;
    PanelButtonsSummaryCalculations.Align := alNone;
    PanelButtonsSSR.Align := alNone;

    PanelButtonsLocalEstimate.Visible := True;
    PanelButtonsSummaryCalculations.Visible := False;
    PanelButtonsSSR.Visible := False;

    PanelButtonsLocalEstimate.Align := alClient;

    // -----------------------------------------

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
  if SpeedButtonSummaryCalculation.Tag = 0 then
  begin
    SpeedButtonSummaryCalculation.Down := True;

    SpeedButtonLocalEstimate.Tag := 0;
    SpeedButtonSummaryCalculation.Tag := 1;
    SpeedButtonSSR.Tag := 0;

    // ��������� ��������� �������
    PanelLocalEstimate.Visible := False;
    PanelSummaryCalculations.Visible := True;
    PanelSSR.Visible := False;

    // ������������� ���������� ������ �������
    frSummaryCalculations.LoadData(IdObject);

    // -----------------------------------------

    // ��������� ��������� ������ ������� � ��������

    PanelButtonsLocalEstimate.Align := alNone;
    PanelButtonsSummaryCalculations.Align := alNone;
    PanelButtonsSSR.Align := alNone;

    PanelButtonsLocalEstimate.Visible := False;
    PanelButtonsSummaryCalculations.Visible := True;
    PanelButtonsSSR.Visible := False;

    PanelButtonsSummaryCalculations.Align := alClient;

    // -----------------------------------------

    // ������ ������ �������� ������� ���� �����������
    BottomTopMenuEnabled(False);

    PanelCalculationYesNo.Enabled := True;

    if PanelCalculationYesNo.Tag = 1 then
      PanelCalculationYesNo.Color := clLime
    else
      PanelCalculationYesNo.Color := clRed;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonTranspClick(Sender: TObject);
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
  if SpeedButtonSSR.Tag = 0 then
  begin
    SpeedButtonSSR.Down := True;

    SpeedButtonLocalEstimate.Tag := 0;
    SpeedButtonSummaryCalculation.Tag := 0;
    SpeedButtonSSR.Tag := 1;

    // ��������� ��������� �������
    PanelLocalEstimate.Visible := False;
    PanelSummaryCalculations.Visible := False;
    PanelSSR.Visible := True;

    // -----------------------------------------

    // ��������� ��������� ������ ������� � ��������

    PanelButtonsLocalEstimate.Align := alNone;
    PanelButtonsSummaryCalculations.Align := alNone;
    PanelButtonsSSR.Align := alNone;

    PanelButtonsLocalEstimate.Visible := False;
    PanelButtonsSummaryCalculations.Visible := False;
    PanelButtonsSSR.Visible := True;

    // ������������� ���������� ������ �������
    frSSR.LoadData(IdObject);

    PanelButtonsSSR.Align := alClient;

    // -----------------------------------------

    // ������ ������ �������� ������� ���� �����������
    BottomTopMenuEnabled(False);

    PanelCalculationYesNo.Enabled := False;
    PanelCalculationYesNo.Color := clSilver;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonStartupClick(Sender: TObject);
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

procedure TFormCalculationEstimate.SpeedButtonMaterialsClick(Sender: TObject);
var
  s: string;
begin
  TestOnNoDataNew(qrMaterial);

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
      if (qrMaterial.FieldByName('TITLE').AsInteger > 0) then
        qrMaterial.Next;
    end;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonMechanismsClick(Sender: TObject);
var
  s: string;
begin
  TestOnNoDataNew(qrMechanizm);

  if SpeedButtonModeTables.Tag = 0 then
    s := '0100000'
  else
    s := '1110000';

  if s <> VisibleRightTables then
  begin
    VisibleRightTables := s;
    SettingVisibleRightTables;
    if CheckQrActiveEmpty(qrMechanizm) then
      qrMechanizm.First;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonEquipmentsClick(Sender: TObject);
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

procedure TFormCalculationEstimate.SpeedButtonDescriptionClick(Sender: TObject);
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

procedure TFormCalculationEstimate.SpeedButtonDumpClick(Sender: TObject);
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
      if SpeedButtonMechanisms.Down then
        s := '0100000';
      if SpeedButtonEquipments.Down then
        s := '0010000';
    end;
  end;
  if not SpeedButtonDescription.Down then
  begin
    VisibleRightTables := s;
    SettingVisibleRightTables;
  end;
end;

procedure TFormCalculationEstimate.Panel1Resize(Sender: TObject);
begin
  ComboBoxOXROPR.Width := (Sender as TPanel).Width div 2 - ComboBoxOXROPR.Left - 3;

  LabelWinterPrice.Left := ComboBoxOXROPR.Left + ComboBoxOXROPR.Width + 6;

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
    end
    else
    begin
      Tag := 1;
      Color := clLime;
      Caption := '������� ���������';
    end;
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

    // LabelNoData1.Left := (Width - LabelNoData1.Width) div 2;
    // LabelNoData1.Top := (Height - (LabelNoData1.Height * 2 + 6)) div 2;
  end;

  // LabelNoData2.Left := LabelNoData1.Left;
  // LabelNoData2.Top := LabelNoData1.Top + LabelNoData1.Height + 6;
end;

procedure TFormCalculationEstimate.PanelObjectResize(Sender: TObject);
begin
  EditNameObject.Width := LabelNumberContract.Left - EditNameObject.Left - 6;
  EditNameEstimate.Width := EditNameObject.Width;
end;

procedure TFormCalculationEstimate.PanelTopMenuResize(Sender: TObject);
var
  WidthButton: Integer;
  OffsetCenter: Integer;
begin
  BevelTopMenu.Left := (Sender as TPanel).Width div 2;

  OffsetCenter := 15; // �� ���������� ����� �� ������ � ����� ������

  // -----------------------------------------

  WidthButton := ((Sender as TPanel).Width div 2 - 18 - OffsetCenter) div 3;
  // 18 = 6 * 3 (����������: �� ������ ������, ����� 1 � 2, 2 � 3)

  SpeedButtonLocalEstimate.Left := 6;
  SpeedButtonLocalEstimate.Width := WidthButton;

  SpeedButtonSummaryCalculation.Left := SpeedButtonLocalEstimate.Left + SpeedButtonLocalEstimate.Width + 6;
  SpeedButtonSummaryCalculation.Width := WidthButton;

  SpeedButtonSSR.Left := SpeedButtonSummaryCalculation.Left + SpeedButtonSummaryCalculation.Width + 6;
  SpeedButtonSSR.Width := WidthButton;

  // -----------------------------------------

  WidthButton := 80;
  //((Sender as TPanel).Width div 2 - 30 - OffsetCenter - SpeedButtonModeTables.Width) div 4;
  // 24 = 6 * 5 (����������: ����� 4 � 5, 5 � 6, 6 � 7, 7 � 8, � �� ����� �����)

  SpeedButtonMaterials.Left := BevelTopMenu.Left + OffsetCenter;
  SpeedButtonMaterials.Width := WidthButton;

  SpeedButtonMechanisms.Left := SpeedButtonMaterials.Left + SpeedButtonMaterials.Width + 3;
  SpeedButtonMechanisms.Width := WidthButton;

  SpeedButtonEquipments.Left := SpeedButtonMechanisms.Left + SpeedButtonMaterials.Width + 3;
  SpeedButtonEquipments.Width := WidthButton;

  SpeedButtonDescription.Left := SpeedButtonEquipments.Left + SpeedButtonEquipments.Width + 3;
  SpeedButtonDescription.Width := WidthButton;

  SpeedButtonDump.Left := SpeedButtonDescription.Left + SpeedButtonDescription.Width + 3;
  SpeedButtonDump.Width := WidthButton;

  SpeedButtonTransp.Left := SpeedButtonDump.Left + SpeedButtonDump.Width + 3;
  SpeedButtonTransp.Width := WidthButton;

  SpeedButtonStartup.Left := SpeedButtonTransp.Left + SpeedButtonTransp.Width + 3;
  SpeedButtonStartup.Width := WidthButton;

  //�� ������������ ����
  SpeedButtonModeTables.Left := SpeedButtonStartup.Left + SpeedButtonStartup.Width + 3;

  MemoRight.Height := dbmmoCAPTION.Height;
end;

// ������ ������ ������ ������ �������� ���� �����������
procedure TFormCalculationEstimate.BottomTopMenuEnabled(const Value: Boolean);
begin
  SpeedButtonDescription.Enabled := Value;
  SpeedButtonMaterials.Enabled := Value;
  SpeedButtonMechanisms.Enabled := Value;
  SpeedButtonEquipments.Enabled := Value;
  SpeedButtonDump.Enabled := Value;
  SpeedButtonTransp.Enabled := Value;
  SpeedButtonStartup.Enabled := Value;
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

procedure TFormCalculationEstimate.Button4Click(Sender: TObject);
begin
  if MessageBox(0, PChar('���������� ������� ������ �� �����?'), '������ �����',
    MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrYes then
    FormKC6.MyShow(IdObject);
end;

procedure TFormCalculationEstimate.PopupMenuTableLeftTechnicalPartClick(Sender: TObject);
var
  NumberNormativ, NameFile: String;
  FirstChar: Char;
  Path: String;
begin
  NumberNormativ := qrRates.FieldByName('CODE').AsString;

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

  if SpeedButtonDescription.Down then
    MemoRight.Text := qrDescriptionwork.AsString;
end;

procedure TFormCalculationEstimate.qrDevicesAfterScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not ReCalcDev then
  begin
    if SpeedButtonEquipments.Down then
      MemoRight.Text := qrDevicesDEVICE_NAME.AsString;
  end;
end;

procedure TFormCalculationEstimate.qrDevicesBeforeScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not ReCalcDev then
  begin
    // �������� �������� �� �������������� ������
    SetDevNoEditMode;
  end;
end;

procedure TFormCalculationEstimate.qrDumpAfterScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if SpeedButtonDump.Down then
    MemoRight.Text := qrDumpDUMP_NAME.AsString;
end;

procedure TFormCalculationEstimate.DevRowChange(Sender: TField);
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    Exit;
  end;

  if not ReCalcDev then
  begin
    ReCalcDev := True;
    // �������� �� ������ ������������
    try
      // �������������� ��������� ��� ���������� �����
      if (Sender.FieldName = 'PROC_PODR') or
         (Sender.FieldName = 'PROC_ZAC') or
         (Sender.FieldName = 'TRANSP_PROC_PODR') or
         (Sender.FieldName = 'TRANSP_PROC_ZAC') then
      begin
        if Sender.AsInteger > 100 then
          Sender.AsInteger := 100;

        if Sender.AsInteger < 0 then
          Sender.AsInteger := 0;

        if (Sender.FieldName = 'PROC_PODR') then
          qrDevicesPROC_ZAC.AsInteger := 100 - qrDevicesPROC_PODR.AsInteger;

        if (Sender.FieldName = 'PROC_ZAC') then
          qrDevicesPROC_PODR.AsInteger := 100 - qrDevicesPROC_ZAC.AsInteger;

        if (Sender.FieldName = 'TRANSP_PROC_PODR') then
          qrDevicesTRANSP_PROC_ZAC.AsInteger := 100 - qrDevicesTRANSP_PROC_PODR.AsInteger;

        if (Sender.FieldName = 'TRANSP_PROC_ZAC') then
          qrDevicesTRANSP_PROC_PODR.AsInteger := 100 - qrDevicesTRANSP_PROC_ZAC.AsInteger;
      end;

      if NDSEstimate then
      begin
        qrDevicesFCOAST_NO_NDS.AsInteger :=
           NDSToNoNDS(qrDevicesFCOAST_NDS.AsInteger, qrDevicesNDS.AsInteger);
        qrDevicesDEVICE_TRANSP_NO_NDS.AsInteger :=
           NDSToNoNDS(qrDevicesDEVICE_TRANSP_NDS.AsInteger, qrDevicesNDS.AsInteger);
      end
      else
      begin
        qrDevicesFCOAST_NDS.AsInteger :=
          NoNDSToNDS(qrDevicesFCOAST_NO_NDS.AsInteger, qrDevicesNDS.AsInteger);
        qrDevicesDEVICE_TRANSP_NDS.AsLargeInt :=
          NoNDSToNDS(qrDevicesDEVICE_TRANSP_NO_NDS.AsLargeInt, qrDevicesNDS.AsInteger);
      end;
      // ����� ��������� ������ ������ �����������
      qrDevices.Post;

      // �������� �� ������ ������
      ReCalcRowDev;
    finally
      ReCalcDev := False;
    end;
  end;
end;

// �������� ����� �� ������������� ������ ������
function TFormCalculationEstimate.CheckMechReadOnly: Boolean;
begin
  Result := False;
  if (qrMechanizmFROM_RATE.AsInteger = 1) and not(qrRatesMEID.AsInteger > 0) then
    Result := True;
end;

procedure TFormCalculationEstimate.SetMechReadOnly(AValue: Boolean); // ������������� ����� ��������������
begin
  dbgrdMechanizm.ReadOnly := AValue;
end;

// �������� ����� �� ������������� ������ ������
function TFormCalculationEstimate.CheckMatReadOnly: Boolean;
begin
  Result := False;
  // ���������� �� ��������
  if ((qrMaterialFROM_RATE.AsInteger = 1) and not(qrRatesMID.AsInteger > 0)) or
  // ��������� ���������
    (CheckMatUnAccountingMatirials) then
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
  dbgrdMaterial.Columns[5].ReadOnly := False; // % ����������
  dbgrdMaterial.Columns[6].ReadOnly := False; // ��������
  dbgrdMaterial.Columns[7].ReadOnly := False; // ��������
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
    dbgrdMaterial.Columns[5].ReadOnly := True; // % ����������
    dbgrdMaterial.Columns[6].ReadOnly := True; // ��������
    dbgrdMaterial.Columns[7].ReadOnly := True; // ��������
    dbgrdMaterial.Columns[12].ReadOnly := True; // ���
    MemoRight.Color := clWindow;
    MemoRight.ReadOnly := True;
    MemoRight.Tag := 0;
    qrMaterial.Tag := 0;
  end;
end;

procedure TFormCalculationEstimate.qrMaterialAfterScroll(DataSet: TDataSet);
begin
  // �� ������ ������, ���-�� �������� ������
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not ReCalcMat then
  begin
    if qrMaterialTITLE.AsInteger > 0 then
    begin
      if dbgrdMaterial.Tag > qrMaterial.RecNo then
        qrMaterial.Prior
      else
        qrMaterial.Next;
    end;

    SetMatReadOnly(CheckMatReadOnly);
    dbgrdRates.Repaint;

    IdReplasedMat := qrMaterialID_REPLACED.AsInteger;
    IdReplasingMat := qrMaterialID.AsInteger;

    if SpeedButtonMaterials.Down then
      MemoRight.Text := qrMaterialMAT_NAME.AsString;
  end;
end;

procedure TFormCalculationEstimate.qrMaterialBeforeScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not ReCalcMat then
  begin
    // ���������� ����� ������������ ��� ���������� ����������� �������� �� �������
    dbgrdMaterial.Tag := qrMaterial.RecNo;

    // �������� �������� �� �������������� ������
    SetMatNoEditMode;
  end;
end;

procedure TFormCalculationEstimate.MatRowChange(Sender: TField);
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    Exit;
  end;

  if not ReCalcMat then
  begin
    ReCalcMat := True;
    // �������� �� ������ ���������
    try
      // �������������� ��������� ��� ���������� �����
      if (Sender.FieldName = 'MAT_PROC_PODR') or
        (Sender.FieldName = 'MAT_PROC_ZA�') or
        (Sender.FieldName = 'TRANSP_PROC_PODR') or
        (Sender.FieldName = 'TRANSP_PROC_ZAC') then
      begin
        if Sender.AsInteger > 100 then
          Sender.AsInteger := 100;

        if Sender.AsInteger < 0 then
          Sender.AsInteger := 0;

        if Sender.FieldName = 'MAT_PROC_PODR' then
          qrMaterialMAT_PROC_ZA�.AsInteger := 100 - qrMaterialMAT_PROC_PODR.AsInteger;
        if Sender.FieldName = 'MAT_PROC_PODR' then
          qrMaterialMAT_PROC_PODR.AsInteger := 100 - qrMaterialMAT_PROC_ZA�.AsInteger;
        if Sender.FieldName = 'TRANSP_PROC_PODR' then
          qrMaterialTRANSP_PROC_ZAC.AsInteger := 100 - qrMaterialTRANSP_PROC_PODR.AsInteger;
        if Sender.FieldName = 'TRANSP_PROC_ZAC' then
          qrMaterialTRANSP_PROC_PODR.AsInteger := 100 - qrMaterialTRANSP_PROC_ZAC.AsInteger;
      end;
      // ��������������� ������, ���-�� �� ������ ���� ������� ����� ��� ���������
      if NDSEstimate then
      begin
        qrMaterialCOAST_NO_NDS.AsLargeInt :=
          NDSToNoNDS(qrMaterialCOAST_NDS.AsLargeInt, qrMaterialNDS.AsInteger);
        qrMaterialFCOAST_NO_NDS.AsLargeInt :=
          NDSToNoNDS(qrMaterialFCOAST_NDS.AsLargeInt, qrMaterialNDS.AsInteger);
        qrMaterialFTRANSP_NO_NDS.AsLargeInt :=
          NDSToNoNDS(qrMaterialFTRANSP_NDS.AsLargeInt, qrMaterialNDS.AsInteger);
      end
      else
      begin
        qrMaterialCOAST_NDS.AsLargeInt :=
          NoNDSToNDS(qrMaterialCOAST_NO_NDS.AsLargeInt, qrMaterialNDS.AsInteger);
        qrMaterialFCOAST_NDS.AsLargeInt :=
          NoNDSToNDS(qrMaterialFCOAST_NO_NDS.AsLargeInt, qrMaterialNDS.AsInteger);
        qrMaterialFTRANSP_NDS.AsLargeInt :=
          NoNDSToNDS(qrMaterialFTRANSP_NO_NDS.AsLargeInt, qrMaterialNDS.AsInteger);
      end;
      // ����� ��������� ������ �����������
      qrMaterial.Post;

      //���������� � ���� (��� ��� ������� �� ������ � ����� ��������)
      with qrTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('UPDATE materialcard_temp SET COAST_NO_NDS = :COAST_NO_NDS, ' +
          'COAST_NDS = :COAST_NDS, FCOAST_NO_NDS = :FCOAST_NO_NDS, ' +
          'FCOAST_NDS = :FCOAST_NDS, FTRANSP_NO_NDS = :FTRANSP_NO_NDS, ' +
          'FTRANSP_NDS = :FTRANSP_NDS, MAT_PROC_ZA� = :MAT_PROC_ZA�, ' +
          'MAT_PROC_PODR = :MAT_PROC_PODR, TRANSP_PROC_ZAC = :TRANSP_PROC_ZAC, ' +
          'TRANSP_PROC_PODR = :TRANSP_PROC_PODR, ' +
          Sender.FieldName + ' = :AA' + Sender.FieldName + ' WHERE id = :id;');
        ParamByName('COAST_NO_NDS').Value := qrMaterialCOAST_NO_NDS.Value;
        ParamByName('COAST_NDS').Value := qrMaterialCOAST_NDS.Value;
        ParamByName('FCOAST_NO_NDS').Value := qrMaterialFCOAST_NO_NDS.Value;
        ParamByName('FCOAST_NDS').Value := qrMaterialFCOAST_NDS.Value;
        ParamByName('FTRANSP_NO_NDS').Value := qrMaterialFTRANSP_NO_NDS.Value;
        ParamByName('FTRANSP_NDS').Value := qrMaterialFTRANSP_NDS.Value;
        ParamByName('MAT_PROC_ZA�').Value := qrMaterialMAT_PROC_ZA�.Value;
        ParamByName('MAT_PROC_PODR').Value := qrMaterialMAT_PROC_PODR.Value;
        ParamByName('TRANSP_PROC_ZAC').Value := qrMaterialTRANSP_PROC_ZAC.Value;
        ParamByName('TRANSP_PROC_PODR').Value := qrMaterialTRANSP_PROC_PODR.Value;
        ParamByName('AA' + Sender.FieldName).Value := Sender.Value;
        ParamByName('id').Value := qrMaterialID.Value;
        ExecSQL;
      end;

      // �������� �� ������ ���������
      ReCalcRowMat;
    finally
      ReCalcMat := False;
    end;
  end;
end;

procedure TFormCalculationEstimate.qrMechanizmAfterScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not ReCalcMech then
  begin
    SetMechReadOnly(CheckMechReadOnly);
    dbgrdRates.Repaint;

    if SpeedButtonMechanisms.Down then
      MemoRight.Text := qrMechanizmMECH_NAME.AsString;
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

  if not ReCalcMech then
  begin
    // �������� �������� �� �������������� ������
    SetMechNoEditMode;
  end;
end;

procedure TFormCalculationEstimate.qrMechanizmCalcFields(DataSet: TDataSet);
var F : TField;
begin
  F := DataSet.FieldByName('NUM');
  if DataSet.Bof then F.AsInteger := 1 else F.AsInteger := DataSet.RecNo;
end;

// ��������� ���� null � �������� ���� ������� �����
procedure TFormCalculationEstimate.MechRowChange(Sender: TField);
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    Exit;
  end;

  if not ReCalcMech then
  begin
    ReCalcMech := True;
    // �������� �� ������ ���������
    try
      // �������������� ��������� ��� ���������� �����
      if (Sender.FieldName = 'PROC_PODR') or
         (Sender.FieldName = 'PROC_ZAC') then
      begin
        if Sender.AsInteger > 100 then Sender.AsInteger := 100;
        if Sender.AsInteger < 0 then Sender.AsInteger := 0;
        if (Sender.FieldName = 'PROC_PODR') then
          qrMechanizmPROC_ZAC.AsInteger := 100 - qrMechanizmPROC_PODR.AsInteger;
        if (Sender.FieldName = 'PROC_ZAC') then
          qrMechanizmPROC_PODR.AsInteger := 100 - qrMechanizmPROC_ZAC.AsInteger;
      end;

      // ��������������� ������, ���-�� �� ������ ���� ������� ����� ��� ���������
      if NDSEstimate then
      begin
        qrMechanizmCOAST_NO_NDS.AsLargeInt :=
          NDSToNoNDS(qrMechanizmCOAST_NDS.AsLargeInt, qrMechanizmNDS.AsInteger);
        qrMechanizmFCOAST_NO_NDS.AsLargeInt :=
          NDSToNoNDS(qrMechanizmFCOAST_NDS.AsLargeInt, qrMechanizmNDS.AsInteger);
        qrMechanizmZP_MACH_NO_NDS.AsLargeInt :=
          NDSToNoNDS(qrMechanizmZP_MACH_NDS.AsLargeInt, qrMechanizmNDS.AsInteger);
        qrMechanizmFZP_MACH_NO_NDS.AsLargeInt :=
          NDSToNoNDS(qrMechanizmFZP_MACH_NDS.AsLargeInt, qrMechanizmNDS.AsInteger);
      end
      else
      begin
        qrMechanizmCOAST_NDS.AsLargeInt :=
          NoNDSToNDS(qrMechanizmCOAST_NO_NDS.AsLargeInt, qrMechanizmNDS.AsInteger);
        qrMechanizmFCOAST_NDS.AsLargeInt :=
          NoNDSToNDS(qrMechanizmFCOAST_NO_NDS.AsLargeInt, qrMechanizmNDS.AsInteger);
        qrMechanizmZP_MACH_NDS.AsLargeInt :=
          NoNDSToNDS(qrMechanizmZP_MACH_NO_NDS.AsLargeInt, qrMechanizmNDS.AsInteger);
        qrMechanizmFZP_MACH_NDS.AsLargeInt :=
          NoNDSToNDS(qrMechanizmFZP_MACH_NO_NDS.AsLargeInt, qrMechanizmNDS.AsInteger);
      end;

      // ����� ��������� ������ ������ �����������
      qrMechanizm.Post;

      // �������� �� ������ ���������
      ReCalcRowMech;
    finally
      ReCalcMech := False;
    end;
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
          qrTemp.ParamByName('ID').AsInteger := qrMaterialID.AsInteger;
          qrTemp.ParamByName('MAT_NAME').AsString := MemoRight.Text;
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

// ������������� ������ �� ������ � ������� ����������
procedure TFormCalculationEstimate.ReCalcRowMech;
begin
  qrTemp.Active := false;
  qrTemp.SQL.Text := 'CALL CalcMech(:id, :getdata);';
  qrTemp.ParamByName('id').Value := qrMechanizmID.AsInteger;
  qrTemp.ParamByName('getdata').Value := 1;
  qrTemp.Active := true;
  if not qrTemp.IsEmpty then
  begin
    qrMechanizm.Edit;
    qrMechanizmMECH_COUNT.AsFloat := qrTemp.FieldByName('MECH_COUNT').AsFloat;
    qrMechanizmPRICE_NO_NDS.AsLargeInt := qrTemp.FieldByName('PRICE_NO_NDS').AsLargeInt;
    qrMechanizmPRICE_NDS.AsLargeInt := qrTemp.FieldByName('PRICE_NDS').AsLargeInt;
    qrMechanizmZPPRICE_NO_NDS.AsLargeInt := qrTemp.FieldByName('ZPPRICE_NO_NDS').AsLargeInt;
    qrMechanizmZPPRICE_NDS.AsLargeInt := qrTemp.FieldByName('ZPPRICE_NDS').AsLargeInt;
    qrMechanizmFPRICE_NO_NDS.AsLargeInt := qrTemp.FieldByName('FPRICE_NO_NDS').AsLargeInt;
    qrMechanizmFPRICE_NDS.AsLargeInt := qrTemp.FieldByName('FPRICE_NDS').AsLargeInt;
    qrMechanizmFZPPRICE_NO_NDS.AsLargeInt := qrTemp.FieldByName('FZPPRICE_NO_NDS').AsLargeInt;
    qrMechanizmFZPPRICE_NDS.AsLargeInt := qrTemp.FieldByName('FZPPRICE_NDS').AsLargeInt;
    qrMechanizmMECH_SUM_NO_NDS.AsLargeInt := qrTemp.FieldByName('MECH_SUM_NO_NDS').AsLargeInt;
    qrMechanizmMECH_SUM_NDS.AsLargeInt := qrTemp.FieldByName('MECH_SUM_NDS').AsLargeInt;
    qrMechanizmMECH_ZPSUM_NO_NDS.AsLargeInt := qrTemp.FieldByName('MECH_ZPSUM_NO_NDS').AsLargeInt;
    qrMechanizmMECH_ZPSUM_NDS.AsLargeInt := qrTemp.FieldByName('MECH_ZPSUM_NDS').AsLargeInt;
    qrMechanizmNORM_TRYD.AsFloat := qrTemp.FieldByName('NORM_TRYD').AsFloat;
    qrMechanizmTERYDOZATR.AsFloat := qrTemp.FieldByName('TERYDOZATR').AsFloat;
    qrMechanizm.Post;
  end;
  qrTemp.Active := false;
  CloseOpen(qrCalculations);
end;

// �������� ������ ���������
procedure TFormCalculationEstimate.ReCalcRowMat;
begin
  qrTemp.Active := false;
  qrTemp.SQL.Text := 'CALL CalcMat(:id, :getdata);';
  qrTemp.ParamByName('id').Value := qrMaterialID.AsInteger;
  qrTemp.ParamByName('getdata').Value := 1;
  qrTemp.Active := true;
  if not qrTemp.IsEmpty then
  begin
    qrMaterial.Edit;
    qrMaterialMAT_COUNT.AsFloat := qrTemp.FieldByName('MAT_COUNT').AsFloat;
    qrMaterialTRANSP_NO_NDS.AsInteger := qrTemp.FieldByName('TRANSP_NO_NDS').AsInteger;
    qrMaterialTRANSP_NDS.AsInteger := qrTemp.FieldByName('TRANSP_NDS').AsInteger;
    qrMaterialPRICE_NO_NDS.AsLargeInt := qrTemp.FieldByName('PRICE_NO_NDS').AsLargeInt;
    qrMaterialPRICE_NDS.AsLargeInt := qrTemp.FieldByName('PRICE_NDS').AsLargeInt;
    qrMaterialFPRICE_NO_NDS.AsLargeInt := qrTemp.FieldByName('FPRICE_NO_NDS').AsLargeInt;
    qrMaterialFPRICE_NDS.AsLargeInt := qrTemp.FieldByName('FPRICE_NDS').AsLargeInt;
    qrMaterialMAT_SUM_NO_NDS.AsLargeInt := qrTemp.FieldByName('MAT_SUM_NO_NDS').AsLargeInt;
    qrMaterialMAT_SUM_NDS.AsLargeInt := qrTemp.FieldByName('MAT_SUM_NDS').AsLargeInt;
    qrMaterialMAT_TRANSP_NO_NDS.AsLargeInt := qrTemp.FieldByName('MAT_TRANSP_NO_NDS').AsLargeInt;
    qrMaterialMAT_TRANSP_NDS.AsLargeInt := qrTemp.FieldByName('MAT_TRANSP_NDS').AsLargeInt;
    qrMaterial.Post;
  end;
  qrTemp.Active := false;
  CloseOpen(qrCalculations);
end;

// �������� ������ ������������
procedure TFormCalculationEstimate.ReCalcRowDev;
begin
  qrTemp.Active := false;
  qrTemp.SQL.Text := 'CALL CalcDevice(:id, :getdata);';
  qrTemp.ParamByName('id').Value := qrDevicesID.AsInteger;
  qrTemp.ParamByName('getdata').Value := 1;
  qrTemp.Active := true;
  if not qrTemp.IsEmpty then
  begin
    qrDevices.Edit;
    qrDevicesFPRICE_NO_NDS.AsLargeInt := qrTemp.FieldByName('FPRICE_NO_NDS').AsLargeInt;
    qrDevicesFPRICE_NDS.AsLargeInt := qrTemp.FieldByName('FPRICE_NDS').AsLargeInt;
    qrDevicesDEVICE_SUM_NO_NDS.AsLargeInt := qrTemp.FieldByName('DEVICE_SUM_NO_NDS').AsLargeInt;
    qrDevicesDEVICE_SUM_NDS.AsLargeInt := qrTemp.FieldByName('DEVICE_SUM_NDS').AsLargeInt;
    qrDevices.Post;
  end;
  qrTemp.Active := false;
  CloseOpen(qrCalculations);
end;

// �������� �� ��������� �������� ��� ����������
function TFormCalculationEstimate.CheckMatUnAccountingRates: Boolean;
begin
  Result := ((qrRatesMID.AsInteger > 0) and (qrRatesCONSIDERED.AsInteger = 0) and
    (qrRatesREPLACED.AsInteger = 0));
end;

function TFormCalculationEstimate.CheckMatINRates: Boolean;
begin
  Result := CheckMatUnAccountingRates or ((qrRatesMID.AsInteger > 0) and (qrRatesID_REPLACED.AsInteger > 0));
end;

// �������� ��� �������� ��������� � ������� ����������
function TFormCalculationEstimate.CheckMatUnAccountingMatirials: Boolean;
begin
  Result := qrMaterialCONSIDERED.AsInteger = 0;
end;

procedure TFormCalculationEstimate.qrRatesAfterScroll(DataSet: TDataSet);
begin
  // ��������� ������ ��������, ���� � ����� ����������� ������ � qrRates
  if qrRates.Tag <> 1 then
  begin
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

    // �� ������ ������, ���-�� �������� ������
    if not qrRates.Active then
      Exit;

    // � ������ ���������� ������ ������������� ���, � �� ����������
    qrRatesCOUNT.ReadOnly := DataSet.Eof;
    qrRatesCODE.ReadOnly := not DataSet.Eof;

    // ���� ��� ��������, ����� ��� ������, ������ ������ ��� ������
    if DataSet.Eof then
    begin
      BottomTopMenuEnabled(False);
      TestOnNoDataNew(qrMaterial);
      Exit;
    end;
    // ��������� ������������� ���-�� ��� ���������� � ���������� ����������
    qrRatesCOUNT.ReadOnly := CheckMatINRates;
    if qrRatesTYPE_DATA.AsInteger in [10,11] then
      qrRatesCOUNT.ReadOnly := true;

    // ��������� ������� ������
    GridRatesRowSellect;
  end;
end;

procedure TFormCalculationEstimate.qrRatesBeforeInsert(DataSet: TDataSet);
begin
  if not DataSet.Eof then
    Abort;
end;

procedure TFormCalculationEstimate.qrRatesBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert] then
  begin
    DataSet.Cancel;
    Abort;
  end;
end;

procedure TFormCalculationEstimate.qrRatesCODEChange(Sender: TField);
var NewCode: string;
    NewID: integer;
begin
  NewCode := AnsiUpperCase(qrRatesCODE.AsString);
  dbgrdRates.EditorMode := false;
  NewID := 0;

  //������ ��������� �� ������������
  if (NewCode[1] = '�') or (NewCode[1] = 'E') then //E ������������ � ���������
  begin
    if NewCode[1] = 'E' then NewCode[1] := '�';

    qrTemp.Active := False;
    qrTemp.SQL.Clear;
    qrTemp.SQL.Add('SELECT normativ_id FROM normativg WHERE norm_num = :norm_num;');
    qrTemp.ParamByName('norm_num').Value := NewCode;
    qrTemp.Active := True;
    if not qrTemp.IsEmpty then
      NewID := qrTemp.Fields[0].AsInteger;
    qrTemp.Active := False;
    if NewID = 0 then
    begin
      MessageBox(0, '�������� � ��������� ����� �� �������!', CaptionForm,
        MB_ICONINFORMATION + MB_YESNO + mb_TaskModal);
      exit;
    end;

    AddRate(NewID);
    dbgrdRates.EditorMode := true;
    exit;
  end;

  if (NewCode[1] = '�') or (NewCode[1] = 'C') then //C ������������ � ���������
  begin
    if NewCode[1] = 'C' then NewCode[1] := '�';

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
        MB_ICONINFORMATION + MB_YESNO + mb_TaskModal);
      exit;
    end;

    AddMaterial(NewID);
    dbgrdRates.EditorMode := true;
    exit;
  end;

  if (NewCode[1] = '�') or (NewCode[1] = 'M') then //M ������������ � ���������
  begin
    if NewCode[1] = 'M' then NewCode[1] := '�';

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
        MB_ICONINFORMATION + MB_YESNO + mb_TaskModal);
      exit;
    end;

    AddMechanizm(NewID);
    dbgrdRates.EditorMode := true;
    exit;
  end;

  if (NewCode[1] in ['0'..'9']) then
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
        MB_ICONINFORMATION + MB_YESNO + mb_TaskModal);
      exit;
    end;
    AddDevice(NewID);
    dbgrdRates.EditorMode := true;
    exit;
  end;

  MessageBox(0, '�� ���������� ���� ������ �� �������!', CaptionForm,
        MB_ICONINFORMATION + MB_YESNO + mb_TaskModal);
end;

procedure TFormCalculationEstimate.qrRatesCOUNTChange(Sender: TField);
var
  RCount: real;
  RecNo: Integer;
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    Exit;
  end;

  // ��������� ����� ��� �������
  RecNo := qrRates.RecNo;
  RCount := Sender.AsFloat;
  qrRatesCOUNTFORCALC.AsFloat := RCount;
  qrRates.Post;
  // ��� ������� ��������� COUNTFORCALC � � ���������� ��� ���������� ����������
  if qrRatesTYPE_DATA.AsInteger = 1 then
  begin
    qrRates.Tag := 1; // ��������� ����������� ������� ��������
    qrRates.DisableControls;
    try
      if not qrRates.Eof then
        qrRates.Next;
      while not qrRates.Eof do
      begin
        if CheckMatINRates then
        begin
          qrRates.Edit;
          qrRatesCOUNTFORCALC.AsFloat := RCount;
          qrRates.Post;
        end
        else
          Break; // ��� ��� ������� ������������
        qrRates.Next;
      end;
      qrRates.RecNo := RecNo;
    finally
      qrRates.Tag := 0;
      qrRates.EnableControls
    end;
  end;

  case qrRatesTYPE_DATA.AsInteger of
    1:
      begin
        qrTemp.SQL.Text := 'UPDATE card_rate_temp set rate_count=:RC WHERE ID=:ID;';
        qrTemp.ParamByName('ID').AsInteger := qrRatesRID.AsInteger;
        qrTemp.ParamByName('RC').AsFloat := Sender.Value;
        qrTemp.ExecSQL;
      end;
    2:
      begin
        qrTemp.SQL.Text := 'UPDATE materialcard_temp set mat_count=:RC WHERE ID=:ID;';
        qrTemp.ParamByName('ID').AsInteger := qrRatesMID.AsInteger;
        qrTemp.ParamByName('RC').AsFloat := Sender.Value;
        qrTemp.ExecSQL;
      end;
    3:
      begin
        qrTemp.SQL.Text := 'UPDATE mechanizmcard_temp set mech_count=:RC WHERE ID=:ID;';
        qrTemp.ParamByName('ID').AsInteger := qrRatesMEID.AsInteger;
        qrTemp.ParamByName('RC').AsFloat := Sender.Value;
        qrTemp.ExecSQL;
      end;
    4:
      begin
        qrTemp.SQL.Text := 'UPDATE devicescard_temp set device_count=:RC WHERE ID=:ID;';
        qrTemp.ParamByName('ID').AsInteger := qrRatesDEID.AsInteger;
        qrTemp.ParamByName('RC').AsFloat := Sender.Value;
        qrTemp.ExecSQL;
      end;
    5:
      begin
        qrTemp.SQL.Text := 'UPDATE dumpcard_temp set WORK_COUNT = :RC WHERE ID=:ID;';
        qrTemp.ParamByName('ID').AsInteger := qrRatesDUID.AsInteger;
        qrTemp.ParamByName('RC').AsFloat := Sender.Value;
        qrTemp.ExecSQL;
      end;
    6,7,8,9:
      begin
        qrTemp.SQL.Text := 'UPDATE transpcard_temp set CARG_COUNT = :RC WHERE ID=:ID;';
        qrTemp.ParamByName('ID').AsInteger := qrRatesTRID.AsInteger;
        qrTemp.ParamByName('RC').AsFloat := Sender.Value;
        qrTemp.ExecSQL;
      end
  else
    begin
      showmessage('������ ���������� �� ����������!');
    end;
  end;
  // ������������� ��� �������� �� ������ ������
  ReCalcRowRates;
end;

procedure TFormCalculationEstimate.qrStartupAfterScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if SpeedButtonStartup.Down then
    MemoRight.Text := qrStartupRATE_CAPTION.AsString;
end;

procedure TFormCalculationEstimate.qrTranspAfterScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if SpeedButtonTransp.Down then
    MemoRight.Text := qrTranspTRANSP_JUST.AsString;
end;

procedure TFormCalculationEstimate.qrTranspCalcFields(DataSet: TDataSet);
var F : TField;
begin
  F := DataSet.FieldByName('NUM');
  if DataSet.Bof then F.AsInteger := 1 else F.AsInteger := DataSet.RecNo;

  case qrTranspCARG_CLASS.AsInteger of
  0: qrTranspCLASS.AsString := 'I';
  1: qrTranspCLASS.AsString := 'II';
  2: qrTranspCLASS.AsString := 'III';
  3: qrTranspCLASS.AsString := 'IV';
  end;
end;

// ������������� ��� ����������� � ������ � ������� ��������
procedure TFormCalculationEstimate.ReCalcRowRates;
begin
  qrTemp.Active := false;
  qrTemp.SQL.Text := 'CALL CalcRowInRateTab(:ID, :TYPE);';
  qrTemp.ParamByName('ID').AsInteger := qrRatesIID.AsInteger;
  qrTemp.ParamByName('TYPE').AsInteger := qrRatesTYPE_DATA.AsInteger;
  qrTemp.ExecSQL;

  GridRatesRowLoad;

  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.N3Click(Sender: TObject);
begin
  FormSummaryCalculationSettings.ShowModal;
end;

procedure TFormCalculationEstimate.PMCoefOrdersClick(Sender: TObject);
begin
  // FormCoefficientOrders.ShowForm(IdEstimate, RateId, 0);
  GetStateCoefOrdersInRate;
end;

procedure TFormCalculationEstimate.PMMatReplaceTableClick(Sender: TObject);
begin
  {
    �������� (Sender as TMenuItem).Tag

    ������ �� �������:
    ��������� - 1, 2
    �������� 11, 22

    ���������� ������ - 1, 11
    ����������� ������ - 2, 22
  }

  case (Sender as TMenuItem).Tag of
    1, 11:
      DataBase := 'g';
    2, 12:
      DataBase := 's';
  end;

  RepIdRate := qrMaterialID_CARD_RATE.AsInteger;
  RepIdMat := qrMaterialID.AsInteger;

  if (Assigned(FormMaterials)) then
  begin
    FormMaterials.Show;
    Exit;
  end;

  FormMain.PanelCover.Visible := True;

  WindowState := wsNormal;
  Left := 0;
  Top := 0;
  Width := FormMain.ClientWidth - 4;
  Height := FormMain.ClientHeight - FormMain.PanelOpenWindows.Height - 4;

  // 4 - ��� �������������� ����� �� ���������, ���������� � MDIMain �����

  FormMaterials := TFormMaterials.Create(Self, DataBase, True, False, True);
  FormMaterials.WindowState := wsNormal;
  FormMaterials.Left := (FormMain.ClientWidth div 2) - 4;
  FormMaterials.Top := Top;
  FormMaterials.Width := FormMain.ClientWidth div 2;
  FormMaterials.Height := FormMain.ClientHeight - FormMain.PanelOpenWindows.Height -
    GetSystemMetrics(SM_CYBORDER) - PanelButtonsLocalEstimate.Height - 4;
end;

procedure TFormCalculationEstimate.ReplacementNumber(Sender: TObject);
var
  FormReplacementMaterial: TFormReplacementMaterial;
begin
  FormReplacementMaterial := TFormReplacementMaterial.Create(nil);
  try
    RepIdRate := qrMaterialID_CARD_RATE.AsInteger;
    RepIdMat := qrMaterialID.AsInteger;

    FormReplacementMaterial.SetDataBase('g');
    FormReplacementMaterial.ShowModal;
  finally
    FormReplacementMaterial.Free;
  end;
end;

procedure TFormCalculationEstimate.PMMatEditClick(Sender: TObject);
begin
  SetMatEditMode;
end;

procedure TFormCalculationEstimate.PMMatFromRatesClick(Sender: TObject);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE materialcard_temp SET from_rate = 1 WHERE id = :id;');
      ParamByName('id').Value := qrMaterialID.AsInteger;
      ExecSQL;
    end;

    OutputDataToTable(qrRates.RecNo);
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ��������� �� �������� �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// �������� ������� ���������� �� ��������������
procedure TFormCalculationEstimate.PMMechEditClick(Sender: TObject);
begin
  SetMechEditMode;
end;

// ��������� ������ ������������ �������������� ���������
procedure TFormCalculationEstimate.SetMechEditMode;
begin
  if CheckMechReadOnly then
    Exit;
  dbgrdMechanizm.Columns[2].ReadOnly := False; // �����
  dbgrdMechanizm.Columns[5].ReadOnly := False; // �� ���������
  dbgrdMechanizm.Columns[6].ReadOnly := False; // �� ���������
  dbgrdMechanizm.Columns[9].ReadOnly := False; // ��������
  dbgrdMechanizm.Columns[10].ReadOnly := False; // ��������
  dbgrdMechanizm.Columns[13].ReadOnly := False; // ���
  dbgrdMechanizm.Columns[22].ReadOnly := False; // ��������
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
    dbgrdMechanizm.Columns[5].ReadOnly := True; // �� ���������
    dbgrdMechanizm.Columns[6].ReadOnly := True; // �� ���������
    dbgrdMechanizm.Columns[9].ReadOnly := True; // ��������
    dbgrdMechanizm.Columns[10].ReadOnly := True; // ��������
    dbgrdMechanizm.Columns[13].ReadOnly := True; // ���
    dbgrdMechanizm.Columns[22].ReadOnly := True; // ��������
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
      SQL.Add('UPDATE mechanizmcard_temp SET from_rate = 1 WHERE id = :id;');
      ParamByName('id').Value := qrMechanizmID.Value;
      ExecSQL;
    end;

    OutputDataToTable(qrRates.RecNo);
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ��������� �� �������� �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.PopupMenuCoefColumnsClick(Sender: TObject);
begin
  FormColumns.SetNameTable('TableCalculations');
  FormColumns.ShowModal;
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
  PopupMenuSSRButtonAdd.Popup(P.X, P.Y);
end;

procedure TFormCalculationEstimate.ButtonSSRTaxClick(Sender: TObject);
var
  P: TPoint;
begin
  P := (Sender as TButton).ClientToScreen(Point(0, 0));
  PopupMenuSSRButtonTax.Popup(P.X, P.Y);
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

procedure TFormCalculationEstimate.CreateParams(var Params: TCreateParams);
begin
  inherited;
  {
    if SettingsFormSave = True then
    begin
    Params.Width := FS.Width;
    Params.Height := FS.Height;
    Params.X := FS.Left;
    Params.Y := FS.Top;
    end;
  }
end;

procedure TFormCalculationEstimate.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  DialogResult, i: Integer;
begin
  // ���� ��� ���������� � �������� ����, � ���� ���� ��������, ������ �� ������� ��� ���������
  // ���� ��� ����� �� ����� ������� ������, � ���������� ���� ConfirmCloseForm ����� ����������� � True
  if not ConfirmCloseForm then
    Exit;

  // ����, ��������������� � ��� ���������� ��� �� ���������� ��� ��������� �����
  ConfirmCloseForm := False;

  if (not ActReadOnly) then
    DialogResult := MessageBox(0, PChar('��������� ��������� ��������� ����� ��������� ����?'), '�����',
      MB_ICONINFORMATION + MB_YESNOCANCEL + mb_TaskModal);

  if DialogResult = mrCancel then
  begin
    ConfirmCloseForm := True;
    CanClose := False;
  end
  else if DialogResult = mrYes then
    if Act then
    begin
      if IdAct = 0 then
        FormCardAct.ShowModal
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
          on E: Exception do
            MessageBox(0, PChar('��� ���������� ������ ���� �������� ������:' + sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
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
        on E: Exception do
          MessageBox(0, PChar('��� ���������� ���� ������ ����� �������� ������:' + sLineBreak + sLineBreak +
            E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
      end;

  if (not Assigned(FormObjectsAndEstimates)) then
    FormObjectsAndEstimates := TFormObjectsAndEstimates.Create(FormMain);
end;

procedure TFormCalculationEstimate.GridRatesRowLoad;
begin
  case qrRatesTYPE_DATA.AsInteger of
    1: // ��������
      begin
        // ���������� ������ ������
        FillingTableMaterials(qrRatesRID.AsInteger, 0);
        FillingTableMechanizm(qrRatesRID.AsInteger, 0);
        FillingTableDescription(qrRatesIDID.AsInteger);
      end;
    2: // ��������
      begin
        // ���������� ���������� �������� � ��������
        if CheckMatINRates then
        begin
          FillingTableMaterials(qrRatesID_CARD_RATE.AsInteger, 0);
        end
        else
        begin // ��������� �������� � ����������
          FillingTableMaterials(0, qrRatesMID.AsInteger);
        end;
      end;
    3: // ��������
      begin
        // ���������� ������� ����������
        FillingTableMechanizm(0, qrRatesMEID.AsInteger);
      end;
    4: // ������������
      begin
        // ���������� ������� ������������
        FillingTableDevises(qrRatesDEID.AsInteger);
      end;
    5: // ������
      begin
        // ���������� ������� ������
        FillingTableDump(qrRatesDUID.AsInteger);
      end;
    6,7,8,9: // ���������
      begin
        FillingTableTransp(qrRatesTRID.AsInteger);
      end;
    10,11: // ���� � �����������
      begin
        FillingTableStartup(qrRatesTYPE_DATA.AsInteger);
      end;
  end;
end;

procedure TFormCalculationEstimate.GridRatesRowSellect;
var
  i: Integer;
  vIdNormativ: string;
  VAT, vClass, Distance, More, Mass, IdDump, Count: Integer;
  TwoValuesSalary, TwoValuesEMiM: TTwoValues;
  CalcPrice: string[2];
  BtnChange: Boolean; // ������� ��������� �������� ������
begin
  // ��������� ���� ������ � ���������� ������
  if qrRatesTYPE_DATA.AsInteger > 0 then
    ComboBoxTypeData.ItemIndex := qrRatesTYPE_DATA.AsInteger - 1
  else
    ComboBoxTypeData.ItemIndex := -1;

  // ������� ������ �������-����������
  EditCategory.Text := '';
  EditWinterPrice.Text := '';

  PopupMenuCoefAddSet.Enabled := True;
  PopupMenuCoefDeleteSet.Enabled := True;

  CalcPrice := '00';

  PMDelete.Enabled := True;
  PMReplace.Enabled := False;
  PMEdit.Enabled := False;

  // �������� ����������� ������ �� ������ � ������� ��������
  GridRatesRowLoad;
  // ���¨�������� ��������� �������� � �������� ������
  BtnChange := False;
  //����� ��� ������ ������
  BottomTopMenuEnabled(False);
  case qrRatesTYPE_DATA.AsInteger of
    1: // ��������
      begin
        // ��������� �������� ������ ������, ��� �������� ������ ���������� "���������"
        SpeedButtonMaterials.Enabled := True;
        SpeedButtonMechanisms.Enabled := True;
        SpeedButtonDescription.Enabled := True;

        if SpeedButtonMaterials.Down or SpeedButtonEquipments.Down or
          SpeedButtonDump.Down or SpeedButtonTransp.Down or
          SpeedButtonStartup.Down
        then
        begin
          SpeedButtonMaterials.Down := True;
          SpeedButtonMaterialsClick(SpeedButtonMaterials);
        end;

        if SpeedButtonMechanisms.Down then
          SpeedButtonMechanismsClick(SpeedButtonMechanisms);

        if SpeedButtonDescription.Down then
          SpeedButtonDescriptionClick(SpeedButtonDescription);

        // ������� ������ �������-����������
        EditCategory.Text :=
          MyFloatToStr(GetRankBuilders(IntToStr(qrRatesIDID.AsInteger)));

        // ������� ����� �������-����������
        //qrCalculations.ParamByName('trud_two').AsFloat :=
        //  GetWorkCostBuilders(IntToStr(qrRatesIDID.AsInteger));
        // R StringGridCalculations.Cells[11, CountCoef + 2] :=
        // R  MyFloatToStr(GetWorkCostBuilders(IntToStr(qrRatesIDID.AsInteger)));

        // ������� ����� ����������
        //qrCalculations.ParamByName('trud_mash_two').AsFloat :=
        //  GetWorkCostMachinists(IntToStr(qrRatesIDID.AsInteger));
        // R StringGridCalculations.Cells[12, CountCoef + 2] :=
        // R  MyFloatToStr(GetWorkCostMachinists(IntToStr(qrRatesIDID.AsInteger)));

        SetIndexOXROPR(qrRatesCODE.AsString);

        // �������� �������� ��� � ��� � ���� �������
        GetValuesOXROPR;

        // �������� ������ ������� ����������
        FillingWinterPrice(qrRatesCODEINRATE.AsString);

        Calculation;

        CalcPrice := '11';
      end;
    2: // ��������
      begin
        SpeedButtonMaterials.Enabled := True;
        SpeedButtonMaterials.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        if CheckMatUnAccountingRates then //���������� �������� � ��������
        begin
            PMReplace.Enabled := True;
            PMDelete.Enabled := False;
        end;

        // �������� �� ������ ����������, ��� ����������� ������� ����������
        SpeedButtonMaterialsClick(SpeedButtonMaterials);

        // ������� ������ �������-����������
        if CheckMatINRates then
          EditCategory.Text :=
            MyFloatToStr(GetRankBuilders(IntToStr(qrRatesRATEIDINRATE.AsInteger)));
        // ������� ����� �������-����������
        //qrCalculations.ParamByName('trud_two').AsFloat :=
        //  GetWorkCostBuilders(IntToStr(qrRatesRATEIDINRATE.AsInteger));
        // R StringGridCalculations.Cells[11, CountCoef + 2] :=
        // R   MyFloatToStr(GetWorkCostBuilders(IntToStr(qrRatesRATEIDINRATE.AsInteger)));

        EditCategory.Text := MyFloatToStr(GetWorkCostBuilders(IntToStr(qrRatesRATEIDINRATE.AsInteger)));

        SetIndexOXROPR(qrRatesCODE.AsString);

        // �������� �������� ��� � ��� � ���� �������
        GetValuesOXROPR;

        // �������� ������ ������� ����������
        if CheckMatINRates then
          FillingWinterPrice(qrRatesCODEINRATE.AsString);

        CalculationMaterial;

        CalcPrice := '10';
      end;
    3: // ��������
      begin
        SpeedButtonMechanisms.Enabled := True;
        SpeedButtonMechanisms.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // �������� �� ������ ����������, ��� ����������� ������� ����������
        SpeedButtonMechanismsClick(SpeedButtonMechanisms);

        // ������� ����� ����������
        //qrCalculations.ParamByName('trud_mash_two').AsFloat :=
         // GetWorkCostMachinists(IntToStr(qrRatesRATEIDINRATE.AsInteger));
        // R StringGridCalculations.Cells[12, CountCoef + 2] :=
        // R  MyFloatToStr(GetWorkCostMachinists(IntToStr(qrRatesRATEIDINRATE.AsInteger)));

        SetIndexOXROPR(qrRatesCODE.AsString);

        // �������� �������� ��� � ��� � ���� �������
        GetValuesOXROPR;

        // �������� ������ ������� ����������
        FillingWinterPrice(qrRatesCODEINRATE.AsString);

        // -------------------------------------

        CalculationMechanizm;

        CalcPrice := '01';
      end;
    4: // ������������
      begin
        SpeedButtonEquipments.Enabled := True;
        BtnChange := True;
        SpeedButtonEquipments.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // �������� �� ������ ������������, ��� ����������� ������� ������������
        SpeedButtonEquipmentsClick(SpeedButtonEquipments);
      end;
    5: // ������
      begin
        PMEdit.Enabled := True;
        SpeedButtonDump.Enabled := True;
        BtnChange := True;
        SpeedButtonDump.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // �������� �� ������ ������, ��� ����������� ������� ������
        SpeedButtonDumpClick(SpeedButtonDump);
      end;
    6,7,8,9: // ���������
      begin
        PMEdit.Enabled := True;
        SpeedButtonTransp.Enabled := True;
        BtnChange := True;
        SpeedButtonTransp.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        SpeedButtonTranspClick(SpeedButtonTransp);
      end;
    10,11: // ���� � �����������
      begin
        SpeedButtonStartup.Enabled := True;
        BtnChange := True;
        SpeedButtonStartup.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        SpeedButtonStartupClick(SpeedButtonStartup);
      end;
  end;
end;

function TFormCalculationEstimate.GetCountCoef(): Integer;
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'SELECT COUNT(*) AS CNT FROM calculation_coef_temp where id_estimate=:id_estimate and id_owner=:id_owner and id_type_data=:id_type_data';
  qrTemp.ParamByName('id_estimate').AsInteger := qrRatesESTIMATE_ID.AsInteger;
  qrTemp.ParamByName('id_owner').AsInteger := qrRatesOWNER_ID.AsInteger;
  qrTemp.ParamByName('id_type_data').AsInteger := qrRatesTYPE_DATA.AsInteger;
  qrTemp.Active := True;
  Result := qrTemp.FieldByName('CNT').AsInteger;
  qrTemp.Active := False;
end;

procedure TFormCalculationEstimate.SetIdObject(const Value: Integer);
begin
  IdObject := Value;
end;

function TFormCalculationEstimate.GetIdObject: Integer;
begin
  Result := IdObject;
end;

procedure TFormCalculationEstimate.SetActReadOnly(const Value: Boolean);
begin
  ActReadOnly := Value;
end;

procedure TFormCalculationEstimate.SetIdAct(const Value: Integer);
begin
  IdAct := Value;
end;

procedure TFormCalculationEstimate.SetIdEstimate(const Value: Integer);
begin
  IdEstimate := Value;
end;

function TFormCalculationEstimate.GetIdEstimate: Integer;
begin
  Result := IdEstimate;
end;

function TFormCalculationEstimate.GetMonth: Integer;
begin
  Result := MonthEstimate;
end;

function TFormCalculationEstimate.GetYear: Integer;
begin
  Result := YearEstimate;
end;

procedure TFormCalculationEstimate.PopupMenuCoefAddSetClick(Sender: TObject);
begin
  FormCoefficients.ShowModal;
end;

procedure TFormCalculationEstimate.PopupMenuCoefDeleteSetClick(Sender: TObject);
var
  ResultDialog: Integer;
  c, r: Integer;
begin
  if MessageBox(0, PChar('�� ������������� ������ ������� ' + sLineBreak + '���������� ����� �������������?'),
    '�����', MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) <> mrYes then
    Exit;

  qrTemp.SQL.Text := 'Delete from calculation_coef_temp where calculation_coef_id=:id';
  qrTemp.ParamByName('id').AsInteger := qrCalculations.FieldByName('id').AsInteger;
  qrTemp.ExecSQL;
  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.PopupMenuCoefOrdersClick(Sender: TObject);
begin
  // FormCoefficientOrders.ShowForm(IdEstimate, RateId, 0);
  GetStateCoefOrdersInRate;
end;

procedure TFormCalculationEstimate.PopupMenuCoefPopup(Sender: TObject);
begin
  GetStateCoefOrdersInEstimate;
end;

// ��� ������������ ���� ����������
procedure TFormCalculationEstimate.PopupMenuMaterialsPopup(Sender: TObject);
begin
  PMMatEdit.Enabled := (not CheckMatReadOnly) and (qrMaterialTITLE.AsInteger = 0);
  PMMatReplace.Enabled := CheckMatUnAccountingMatirials and (qrMaterialTITLE.AsInteger = 0);;
  PMMatFromRates.Enabled := (not CheckMatReadOnly) and (qrMaterialTITLE.AsInteger = 0);
end;

// ��������� ���� ������������ ���� ������� ����������
procedure TFormCalculationEstimate.PopupMenuMechanizmsPopup(Sender: TObject);
begin
  PMMechEdit.Enabled := not CheckMechReadOnly;
  PMMechFromRates.Enabled := (not CheckMechReadOnly) and (qrRatesMEID.AsInteger = 0);
end;

// ���������� �������� � �����
procedure TFormCalculationEstimate.AddRate(const vRateId: Integer);
var
  i: Integer;
  vMaxIdRate: Integer;
  vNormRas: Double;
  Month1, Year1: Integer;
  PriceVAT, PriceNoVAT: string;
  PercentTransport: Real;
  SQL1, SQL2: string;
begin

  // ��������� ��������� �������� �� ��������� ������� card_rate_temp
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddRate(:id_estimate, :id_rate, :cnt);');
      ParamByName('id_estimate').Value := IdEstimate;
      ParamByName('id_rate').Value := vRateId;
      ParamByName('cnt').AsFloat := 0;
      ExecSQL;
    end;

    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT max(id) as "MaxId" FROM card_rate_temp;');
      Active := True;
      vMaxIdRate := FieldByName('MaxId').AsInteger;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ���������� �������� �� ��������� ������� �������� ������:' + sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ������� �� ��������� ������� materialcard_temp ��������� ����������� � ��������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT year,monat FROM stavka WHERE stavka_id = ' +
        '(SELECT stavka_id FROM smetasourcedata WHERE sm_id = ' + IntToStr(IdEstimate) + ')');
      Active := True;
      if not Eof then
      begin
        Month1 := FieldByName('monat').AsInteger;
        Year1 := FieldByName('year').AsInteger;
      end;
      Active := False;

      SQL.Clear;
      SQL.Add('SELECT region_id FROM objcards WHERE obj_id = ' + IntToStr(IdObject));
      Active := True;
      if not Eof then
      begin
        PriceVAT := 'coast' + FieldByName('region_id').AsString + '_2';
        PriceNoVAT := 'coast' + FieldByName('region_id').AsString + '_1';
      end;
      Active := False;

      SQL.Clear;
      SQL.Add('SELECT coef_tr_zatr FROM smetasourcedata WHERE sm_id = ' + IntToStr(IdEstimate));
      Active := True;
      if not Eof then PercentTransport := Fields[0].AsFloat;
      Active := False;

      SQL.Clear;
      SQL.Text := 'SELECT DISTINCT TMat.material_id as "MatId", TMat.mat_code as "MatCode", ' +
        'TMatNorm.norm_ras as "MatNorm", units.unit_name as "MatUnit", ' +
        'TMat.unit_id as "UnitId", mat_name as "MatName", ' + PriceVAT + ' as "PriceVAT", ' +
        PriceNoVAT + ' as "PriceNoVAT" ' +
        'FROM materialnorm as TMatNorm ' +
        'JOIN material as TMat ON TMat.material_id = TMatNorm.material_id ' +
        'JOIN units ON TMat.unit_id = units.unit_id ' +
        'LEFT JOIN (select material_id, ' + PriceVAT + ', ' + PriceNoVAT +
        ' from materialcoastg where (monat = ' + IntToStr(Month1) +
        ') and (year = ' + IntToStr(Year1) + ')) as TMatCoast ' +
        'ON TMatCoast.material_id = TMatNorm.material_id ' +
        'WHERE (TMatNorm.normativ_id = ' + IntToStr(vRateId) + ') order by 1';
      Active := True;

      Filtered := False;
      Filter := 'MatCode LIKE ''�%''';
      Filtered := True;

      First;

      while not Eof do
      begin
        qrTemp1.Active := False;
        qrTemp1.SQL.Text := 'Insert into materialcard_temp (BD_ID, ID_CARD_RATE, MAT_ID, ' +
          'MAT_CODE, MAT_NAME, MAT_NORMA, MAT_UNIT, COAST_NO_NDS, COAST_NDS, ' +
          'PROC_TRANSP) values (:BD_ID, :ID_CARD_RATE, :MAT_ID, ' +
          ':MAT_CODE, :MAT_NAME, :MAT_NORMA, :MAT_UNIT, :COAST_NO_NDS, ' + ':COAST_NDS, :PROC_TRANSP)';
        qrTemp1.ParamByName('BD_ID').AsInteger := 1;
        qrTemp1.ParamByName('ID_CARD_RATE').AsInteger := vMaxIdRate;
        qrTemp1.ParamByName('MAT_ID').AsInteger := FieldByName('MatId').AsInteger;
        qrTemp1.ParamByName('MAT_CODE').AsString := FieldByName('MatCode').AsString;
        qrTemp1.ParamByName('MAT_NAME').AsString := FieldByName('MatName').AsString;
        vNormRas := MyStrToFloatDef(FieldByName('MatNorm').AsString, 0);
        qrTemp1.ParamByName('MAT_NORMA').AsFloat := vNormRas;
        qrTemp1.ParamByName('MAT_UNIT').AsString := FieldByName('MatUnit').AsString;
        qrTemp1.ParamByName('COAST_NO_NDS').AsInteger := FieldByName('PriceNoVAT').AsInteger;
        qrTemp1.ParamByName('COAST_NDS').AsInteger := FieldByName('PriceVAT').AsInteger;
        qrTemp1.ParamByName('PROC_TRANSP').AsFloat := PercentTransport;
        qrTemp1.ExecSQL;

        Next;
      end;

      Filtered := False;
      Filter := 'MatCode LIKE ''�%''';
      Filtered := True;

      First;

      while not Eof do
      begin
        qrTemp1.Active := False;
        qrTemp1.SQL.Text := 'Insert into materialcard_temp (BD_ID, ID_CARD_RATE, CONSIDERED, MAT_ID, ' +
          'MAT_CODE, MAT_NAME, MAT_NORMA, MAT_UNIT, COAST_NO_NDS, COAST_NDS, ' +
          'PROC_TRANSP) values (:BD_ID, :ID_CARD_RATE, :CONSIDERED, :MAT_ID, ' +
          ':MAT_CODE, :MAT_NAME, :MAT_NORMA, :MAT_UNIT, :COAST_NO_NDS, ' + ':COAST_NDS, :PROC_TRANSP)';
        qrTemp1.ParamByName('BD_ID').AsInteger := 1;
        qrTemp1.ParamByName('ID_CARD_RATE').AsInteger := vMaxIdRate;
        qrTemp1.ParamByName('CONSIDERED').AsInteger := 0;
        qrTemp1.ParamByName('MAT_ID').AsInteger := FieldByName('MatId').AsInteger;
        qrTemp1.ParamByName('MAT_CODE').AsString := FieldByName('MatCode').AsString;
        qrTemp1.ParamByName('MAT_NAME').AsString := FieldByName('MatName').AsString;
        vNormRas := MyStrToFloatDef(FieldByName('MatNorm').AsString, 0);
        qrTemp1.ParamByName('MAT_NORMA').AsFloat := vNormRas;
        qrTemp1.ParamByName('MAT_UNIT').AsString := FieldByName('MatUnit').AsString;
        qrTemp1.ParamByName('COAST_NO_NDS').AsInteger := FieldByName('PriceNoVAT').AsInteger;
        qrTemp1.ParamByName('COAST_NDS').AsInteger := FieldByName('PriceVAT').AsInteger;
        qrTemp1.ParamByName('PROC_TRANSP').AsFloat := PercentTransport;
        qrTemp1.ExecSQL;

        Next;
      end;

      Filtered := False;
      Filter := '';

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ���������� �� ��������� ������� �������� ������:' + sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ������� �� ��������� ������� mechanizmcard_temp ��������� ����������� � ��������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL GetMechanizmsFromRate(:IdObject, :IdEstimate, :IdRate);');

      ParamByName('IdObject').Value := IdObject;
      ParamByName('IdEstimate').Value := IdEstimate;
      ParamByName('IdRate').Value := vRateId;

      Active := True;
      First;

      while not Eof do
      begin
        qrTemp1.Active := False;
        qrTemp1.SQL.Text := 'Insert into mechanizmcard_temp (BD_ID, ID_CARD_RATE, ' +
          'MECH_ID, MECH_CODE, MECH_NAME, MECH_NORMA, MECH_UNIT, COAST_NO_NDS, ' +
          'COAST_NDS, ZP_MACH_NO_NDS, ZP_MACH_NDS) values (:BD_ID, :ID_CARD_RATE, ' +
          ':MECH_ID, :MECH_CODE, :MECH_NAME, :MECH_NORMA, :MECH_UNIT, :COAST_NO_NDS, ' +
          ':COAST_NDS, :ZP_MACH_NO_NDS, :ZP_MACH_NDS)';
        qrTemp1.ParamByName('BD_ID').AsInteger := 1;
        qrTemp1.ParamByName('ID_CARD_RATE').AsInteger := vMaxIdRate;
        qrTemp1.ParamByName('MECH_ID').AsInteger := FieldByName('MechId').AsInteger;
        qrTemp1.ParamByName('MECH_CODE').AsString := FieldByName('MechCode').AsString;
        qrTemp1.ParamByName('MECH_NAME').AsString := FieldByName('MechName').AsString;
        vNormRas := MyStrToFloatDef(FieldByName('MechNorm').AsString, 0);
        qrTemp1.ParamByName('MECH_NORMA').AsFloat := vNormRas;
        qrTemp1.ParamByName('MECH_UNIT').AsString := FieldByName('Unit').AsString;
        qrTemp1.ParamByName('COAST_NO_NDS').AsInteger := FieldByName('CoastNoVAT').AsInteger;
        qrTemp1.ParamByName('COAST_NDS').AsInteger := FieldByName('CoastVAT').AsInteger;
        qrTemp1.ParamByName('ZP_MACH_NO_NDS').AsInteger := FieldByName('SalaryNoVAT').AsInteger;
        qrTemp1.ParamByName('ZP_MACH_NDS').AsInteger := FieldByName('SalaryVAT').AsInteger;
        qrTemp1.ExecSQL;

        Next;
      end;

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ���������� �� ��������� ������� �������� ������:' + sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  OutputDataToTable(qrRates.RecordCount + 1);
end;

procedure TFormCalculationEstimate.PMAddTranspClick(
  Sender: TObject);
begin
  if GetTranspForm(IdEstimate, -1, (Sender as TMenuItem).Tag, true) then
  begin
    OutputDataToTable(qrRates.RecordCount + 1);
  end;
end;

procedure TFormCalculationEstimate.PMAddAdditionHeatingE18Click(
  Sender: TObject);
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'INSERT INTO data_estimate_temp ' +
    '(id_estimate, id_type_data) VALUE (:IdEstimate, :SType);';
  qrTemp.ParamByName('IdEstimate').AsInteger := IdEstimate;
  qrTemp.ParamByName('SType').AsInteger := (Sender as TComponent).Tag;
  qrTemp.ExecSQL;

  OutputDataToTable(qrRates.RecordCount + 1);
end;

procedure TFormCalculationEstimate.PMAddDumpClick(Sender: TObject);
begin
  if GetDumpForm(IdEstimate, -1, true) then
  begin
    OutputDataToTable(qrRates.RecordCount + 1);
  end;
end;

procedure TFormCalculationEstimate.PMAddRatMatMechEquipOwnClick(Sender: TObject);
begin
  ShowFormAdditionData('s');
end;

procedure TFormCalculationEstimate.PMAddRatMatMechEquipRefClick(Sender: TObject);
begin
  ShowFormAdditionData('g');
end;

// �������� ����-���� �� �����
procedure TFormCalculationEstimate.PMDeleteClick(Sender: TObject);
begin
  if MessageBox(0, PChar('�� ������������� ������ ������� ' + qrRates.FieldByName('CODE').AsString + '?'),
    CaptionForm, MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
    Exit;

  if Act then
  begin
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL DeleteDataFromAct(:IdTypeData, :Id);');
      ParamByName('IdTypeData').Value := qrRatesTYPE_DATA.AsInteger;
      ParamByName('Id').Value := qrRatesRID.AsInteger;
      ExecSQL;
    end;
  end
  else
    case qrRatesTYPE_DATA.AsInteger of
      1: // ��������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteRate(:id);');
            ParamByName('id').Value := qrRatesRID.AsInteger;
            ExecSQL;
          end;
        except
          on E: Exception do
            MessageBox(0, PChar('��� �������� �������� �������� ������:' + sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      2: // ��������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteMaterial(:id);');
            ParamByName('id').Value := qrRatesMID.AsInteger;
            ExecSQL;
          end;

        except
          on E: Exception do
            MessageBox(0, PChar('��� �������� ��������� �������� ������:' + sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      3: // ��������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteMechanism(:id);');
            ParamByName('id').Value := qrRatesMEID.AsInteger;
            ExecSQL;
          end;

        except
          on E: Exception do
            MessageBox(0, PChar('��� �������� ��������� �������� ������:' + sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      4: // ������������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteDevice(:id);');
            ParamByName('id').Value := qrRatesDEID.AsInteger;
            ExecSQL;
          end;

        except
          on E: Exception do
            MessageBox(0, PChar('��� �������� ������������ �������� ������:' + sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      5: // ������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteDump(:id);');
            ParamByName('id').Value := qrRatesDUID.AsInteger;
            ExecSQL;
          end;
        except
          on E: Exception do
            MessageBox(0, PChar('��� �������� ������ �������� ������:' + sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      6,7,8,9: // ���������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteTransp(:id);');
            ParamByName('id').Value := qrRatesTRID.AsInteger;
            ExecSQL;
          end;
        except
          on E: Exception do
            MessageBox(0, PChar('��� �������� ���������� �������� ������:' + sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      10,11: // ���� � �����������
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('DELETE FROM data_estimate_temp WHERE (id_type_data = ' +
              IntToStr(qrRatesTYPE_DATA.AsInteger) + ');');
            ExecSQL;
          end;
        except
          on E: Exception do
            MessageBox(0, PChar('��� �������� ���������� �������� ������:' + sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      end;
  OutputDataToTable(qrRates.RecNo);
end;

procedure TFormCalculationEstimate.PMDevEditClick(Sender: TObject);
begin
  SetDevEditMode;
end;

//����� ����� ��� ������ � ����������
procedure TFormCalculationEstimate.PMDumpEditClick(Sender: TObject);
begin
  if qrRatesTYPE_DATA.AsInteger = 5 then
    if GetDumpForm(IdEstimate, qrDumpID.AsInteger, false) then
     OutputDataToTable(qrRates.RecNo);

  if qrRatesTYPE_DATA.AsInteger in [6,7,8,9] then
    if GetTranspForm(IdEstimate, qrTranspID.AsInteger,
      qrRatesTYPE_DATA.AsInteger,false) then
     OutputDataToTable(qrRates.RecNo);
end;

procedure TFormCalculationEstimate.PMEditClick(Sender: TObject);
begin
  case qrRatesTYPE_DATA.AsInteger of
  5: PMDumpEditClick(nil);
  6,7,8,9: PMDumpEditClick(nil);
  end;
end;

procedure TFormCalculationEstimate.PopupMenuTableLeftPopup(Sender: TObject);
begin
  // ������ ������� ���������� �������� �� ������� ��������
  PMDelete.Enabled := not(CheckMatUnAccountingRates);
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
  // ��������� ����� ��������
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormObjectsAndEstimates)) then
    FormObjectsAndEstimates := TFormObjectsAndEstimates.Create(Self);

  FormObjectsAndEstimates.Show;

  // ��������� ����� ��������
  FormWaiting.Close;
end;

procedure TFormCalculationEstimate.Label1Click(Sender: TObject);
begin
  FormBasicData.ShowForm(IdObject, IdEstimate);
  GetSourceData;
  GetStateCoefOrdersInRate;
  GridRatesRowSellect;
end;

procedure TFormCalculationEstimate.LabelMouseEnter(Sender: TObject);
begin
  with (Sender as TLabel) do
  begin
    Cursor := crHandPoint;
    Font.Style := Font.Style + [fsUnderline];
  end;
end;

procedure TFormCalculationEstimate.LabelMouseLeave(Sender: TObject);
begin
  with (Sender as TLabel) do
  begin
    Cursor := crDefault;
    Font.Style := Font.Style - [fsUnderline];
  end;
end;

procedure TFormCalculationEstimate.ComboBoxOXROPRChange(Sender: TObject);
begin
  GetValuesOXROPR;
  // ������������� ��� ��������
  Calculation;
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
  ReCalcMat := True;
  qrMaterialNUM.ReadOnly := False;
  // �������� �������� ��� ���������� ������� ����������
  qrMaterial.Active := False;
  // ��������� materials_temp
  qrMaterial.SQL.Text := 'call GetMaterials(' + IntToStr(fType) + ',' + IntToStr(fID) + ')';
  qrMaterial.ExecSQL;

  qrMaterial.Active := False;
  // ��������� materials_temp
  qrMaterial.SQL.Text := 'SELECT * FROM materials_temp ORDER BY SRTYPE, TITLE DESC, ID';
  qrMaterial.Active := True;
  i := 0;
  // ��������� �����, ������ ��������
  while not qrMaterial.Eof do
  begin
    if (qrMaterial.FieldByName('TITLE').AsInteger > 0) then
    begin
      i := 0;
      qrMaterial.Next;
    end;
    inc(i);
    qrMaterial.Edit;
    qrMaterial.FieldByName('NUM').AsInteger := i;
    qrMaterial.Post;

    qrMaterial.Next;
  end;
  qrMaterialNUM.ReadOnly := True;
  ReCalcMat := False;

  if (qrRatesRID.AsInteger > 0) and (qrRatesFROM_RATE.AsInteger = 0) then
    dbgrdMaterial.Columns[2].Visible := True
  else
    dbgrdMaterial.Columns[2].Visible := False;

  qrMaterial.First;
  if (qrMaterial.FieldByName('TITLE').AsInteger > 0) then
    qrMaterial.Next;

  qrMaterial.EnableControls;
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
var LikeText: string;
begin
  if vStType = 10 then LikeText := '�18' else LikeText := '�20';
  qrStartup.Active := False;
  qrStartup.SQL.Text := 'select RATE_CODE, RATE_CAPTION, RATE_COUNT, RATE_UNIT ' +
    'from card_rate_temp WHERE RATE_CODE LIKE "%' + LikeText + '%"';
  qrStartup.Active := True;
end;

procedure TFormCalculationEstimate.FillingTableMechanizm(const vIdCardRate, vIdMech: Integer);
var
  i: Integer;
begin

  qrMechanizm.Active := False;
  if vIdMech > 0 then
  begin
    qrMechanizm.ParamByName('Type').AsInteger := 0;
    qrMechanizm.ParamByName('IDValue').AsInteger := vIdMech;
  end
  else
  begin
    qrMechanizm.ParamByName('Type').AsInteger := 1;
    qrMechanizm.ParamByName('IDValue').AsInteger := vIdCardRate;
  end;
  qrMechanizm.Active := True;

  if (qrRatesRID.AsInteger > 0) and (qrRatesFROM_RATE.AsInteger = 0) then
    dbgrdMechanizm.Columns[2].Visible := True
  else
    dbgrdMechanizm.Columns[2].Visible := False;
end;

procedure TFormCalculationEstimate.FillingTableDescription(const vIdNormativ: Integer);
var
  i: Integer;
begin
  with qrDescription do
  begin
    Active := False;
    ParamByName('IdNorm').AsInteger := vIdNormativ;
    Active := True;
  end;
end;

function TFormCalculationEstimate.GetRankBuilders(const vIdNormativ: string): Double;
begin
  // ������� ������ �������-����������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT norma FROM normativwork WHERE normativ_id = ' + vIdNormativ + ' and work_id = 1;');
      Active := True;

      if FieldByName('norma').Value <> Null then
        Result := FieldByName('norma').AsFloat
      else
        Result := 0;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� �������� "������� ������" �������� ������:' + sLineBreak + sLineBreak
        + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetWorkCostBuilders(const vIdNormativ: string): Double;
begin
  // ������� ����� �������-����������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT norma FROM normativwork WHERE normativ_id = ' + vIdNormativ + ' and work_id = 2;');
      Active := True;

      if FieldByName('norma').AsVariant <> Null then
        Result := FieldByName('norma').AsVariant
      else
        Result := 0;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� �������� "�� ����������" �������� ������:' + sLineBreak + sLineBreak
        + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetWorkCostMachinists(const vIdNormativ: string): Double;
begin
  // ������� ����� ����������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT norma FROM normativwork WHERE normativ_id = ' + vIdNormativ + ' and work_id = 3;');
      Active := True;

      if FieldByName('norma').AsVariant <> Null then
        Result := FieldByName('norma').AsVariant
      else
        Result := 0;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� �������� "�� ����������" �������� ������:' + sLineBreak + sLineBreak
        + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.Calculation;
begin
  { with ADOQueryMaterialCard do
    begin
    Filtered := False;
    Filter := 'id_replaced = 0 and mat_code LIKE ''�%''';
    Filtered := True;
    end;

    // -------------------------------------

    CalculationMR;
    CalculationPercentTransport;

    TwoValues := CalculationEMiM(IntToStr(RateId));

    // ��������� ������ � ������ ������� � ������� (����)
    with StringGridCalculations do
    begin
    Cells[3, CountCoef + 2] := MyCurrToStr(TwoValues.ForOne);
    Cells[3, CountCoef + 3] := MyCurrToStr(TwoValues.ForCount);
    end;

    CalculationSalaryMachinist;

    // -------------------------------------

    // ������������ �� (���������� �����)
    TwoValues := CalculationSalary(IntToStr(RateId));

    // ��������� ������ � ������ ������� � ������� (��)
    with StringGridCalculations do
    begin
    Cells[2, CountCoef + 2] := MyCurrToStr(TwoValues.ForOne);
    Cells[2, CountCoef + 3] := MyCurrToStr(TwoValues.ForCount);
    end;

    // ���������
    CalculationCost;

    CalculationOXROPR;

    CalculationPlanProfit;

    // ������������ ��� � ���
    CalculationCostOXROPR; // +++

    // ������������ ������ ����������
    CalculationWinterPrice;

    // ������������ �������� � ������ ����������
    CalculationSalaryWinterPrice;

    // ������������ ����
    CalculationWork;

    // ������������ ���� ���������
    CalculationWorkMachinist;

    // -------------------------------------

    with ADOQueryMaterialCard do
    begin
    Filtered := False;
    Filter := '';
    end; }
end;

procedure TFormCalculationEstimate.CalculationMaterial;
begin
  CalculationMR;

  CalculationPercentTransport;

  // ��������� ������ � ������ ������� � ������� (����)
  //qrCalculations.ParamByName('emim_one').AsFloat := 0;
  //qrCalculations.ParamByName('emim_two').AsFloat := 0;
  { R
    with StringGridCalculations do
    begin
    Cells[3, CountCoef + 2] := '0';
    Cells[3, CountCoef + 3] := '0';
    end;
  }

  // CalculationSalaryMachinist;
  // �� ���.
  //qrCalculations.ParamByName('zp_mash_one').AsFloat := 0;
  //qrCalculations.ParamByName('zp_mash_two').AsFloat := 0;
  { R
    with StringGridCalculations do
    begin
    Cells[4, CountCoef + 2] := '0';
    Cells[4, CountCoef + 3] := '0';
    end;
  }

  // ������������ �� (���������� �����)
  // TwoValues := CalculationSalary(IntToStr(RateId));

  // ��������� ������ � ������ ������� � ������� (��)
  //qrCalculations.ParamByName('zp_one').AsFloat := TwoValues.ForOne;
  //qrCalculations.ParamByName('zp_two').AsFloat := TwoValues.ForCount;
  { R
    with StringGridCalculations do
    begin
    Cells[2, CountCoef + 2] := MyCurrToStr(TwoValues.ForOne);
    Cells[2, CountCoef + 3] := MyCurrToStr(TwoValues.ForCount);
    end;
  }

  // ���������
  CalculationCost;

  CalculationOXROPR;

  CalculationPlanProfit;

  // ������������ ��� � ���
  CalculationCostOXROPR; // +++

  // ������������ ������ ����������
  CalculationWinterPrice;

  // ������������ �������� � ������ ����������
  CalculationSalaryWinterPrice;

  // ������������ ����
  CalculationWork;

  // ������������ ���� ���������
  // CalculationWorkMachinist;
end;

procedure TFormCalculationEstimate.CalculationMechanizm;
begin
  // CalculationMR;
  //qrCalculations.ParamByName('mr_one').AsFloat := 0;
  //qrCalculations.ParamByName('mr_two').AsFloat := 0;
  { R
    with StringGridCalculations do
    begin
    Cells[5, CountCoef + 2] := '0';
    Cells[5, CountCoef + 3] := '0';
    end;
  }

  // CalculationPercentTransport;
  //qrCalculations.ParamByName('transp_one').AsFloat := 0;
  //qrCalculations.ParamByName('transp_two').AsFloat := 0;
  { R
    with StringGridCalculations do
    begin
    Cells[6, CountCoef + 2] := '0';
    Cells[6, CountCoef + 3] := '0';
    end;
  }

  // TwoValues := CalculationEMiM(IntToStr(RateId));

  // ��������� ������ � ������ ������� � ������� (����)
  //qrCalculations.ParamByName('emim_one').AsFloat := TwoValues.ForOne;
  //qrCalculations.ParamByName('emim_two').AsFloat := TwoValues.ForCount;
  { R
    with StringGridCalculations do
    begin
    Cells[3, CountCoef + 2] := MyCurrToStr(TwoValues.ForOne);
    Cells[3, CountCoef + 3] := MyCurrToStr(TwoValues.ForCount);
    end;
  }

  CalculationSalaryMachinist;

  // -------------------------------------

  // ������������ �� (���������� �����)
  // TwoValues := CalculationSalary(IdNormativ);

  // ��������� ������ � ������ ������� � ������� (��)
  //qrCalculations.ParamByName('zp_one').AsFloat := 0;
  //qrCalculations.ParamByName('zp_two').AsFloat := 0;
  { R
    with StringGridCalculations do
    begin
    // Cells[2, CountCoef + 2] := MyCurrToStr(TwoValues.ForOne);
    // Cells[2, CountCoef + 3] := MyCurrToStr(TwoValues.ForCount);

    Cells[2, CountCoef + 2] := '0';
    Cells[2, CountCoef + 3] := '0';
    end;
  }

  // ���������
  CalculationCost;

  CalculationOXROPR;

  CalculationPlanProfit;

  // ������������ ��� � ���
  CalculationCostOXROPR; // +++

  // ������������ ������ ����������
  CalculationWinterPrice;

  // ������������ �������� � ������ ����������
  CalculationSalaryWinterPrice;

  // ������������ ����
  // CalculationWork;

  // ������������ ���� ���������
  CalculationWorkMachinist;
end;

function TFormCalculationEstimate.CalculationSalary(const vIdNormativ: string): TTwoValues;
var
  TZ, TZ1: Double;
  CountMaterial: Integer;
  Count: Double;
  i: Integer;
  MRCoef: Double;
  IdRegion: Integer;
  RateWorker: Double;
  TW: TTwoValues;
  StrQuery: string;
  key: Integer;
begin
  try
    // ���������� �� ����� �������
    Count := CountFromRate; // MyStrToFloat(Cells[2, Row]);

    TZ := GetWorkCostBuilders(vIdNormativ) * Count;
    // ������� ����� ������� * ����������
    TZ1 := GetWorkCostBuilders(vIdNormativ); // ������� ����� ������� * 1

    // ��������� �� ������� ������������� (��)
    {key := qrCalculations.RecNo;
    qrCalculations.DisableControls;
    try
      qrCalculations.First;
      for i := 1 to GetCountCoef + 1 do
      begin
        TZ := TZ * qrCalculations.FieldByName('ZP').AsFloat;
        TZ1 := TZ1 * qrCalculations.FieldByName('ZP').AsFloat;
        qrCalculations.Next;
      end;
    finally
      qrCalculations.RecNo := key;
      qrCalculations.EnableControls;
    end;   }

    // -----------------------------------------

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
        'WHERE objcards.stroj_id = objstroj.stroj_id and obj_id = ' + IntToStr(IdObject) + ';');
      Active := True;

      // �������� ������ (1-�����, 2-����, 3-�����)
      IdRegion := FieldByName('IdRegion').AsVariant;

      // -----------------------------------------

      Active := False;
      SQL.Clear;

      if IdRegion = 3 then
        StrQuery := 'SELECT stavka_m_rab as "RateWorker" FROM stavka WHERE monat = ' + IntToStr(MonthEstimate)
          + ' and year = ' + IntToStr(YearEstimate) + ';'
      else
        StrQuery := 'SELECT stavka_rb_rab as "RateWorker" FROM stavka WHERE monat = ' +
          IntToStr(MonthEstimate) + ' and year = ' + IntToStr(YearEstimate) + ';';

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
    on E: Exception do
      MessageBox(0, PChar('������ ��� ���������� �' + '�, � ������� ����������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.CalculationMR;
var
  MR, MR1: array of Double;
  CountMaterial: Integer;
  i, j, Nom: Integer;
  Count: Double;
  Res, Res1: Double;
  s: String;
begin
  { try
    if ADOQueryMaterialCard.RecordCount = 0 then
    begin
    StringGridCalculations.Cells[5, CountCoef + 2] := '0';
    StringGridCalculations.Cells[5, CountCoef + 3] := '0';
    Exit;
    end;

    // ���������� ��Ҩ���� ���������� � ��������
    CountMaterial := ADOQueryMaterialCard.RecordCount;

    // �������� ������
    SetLength(MR, CountMaterial);
    SetLength(MR1, CountMaterial);

    Res := 0;
    Res1 := 0;

    // ���������� �� ����� �������
    Count := CountFromRate; // MyStrToFloat(Cells[2, Row]);

    Nom := -1;

    // ����������� �� ������� ����������
    for i := 1 to CountMaterial + 1 do
    // + 1 ��� ��� ������ ������ ��� ������ � ������� ������ "�������"
    if StringGridMaterials.Cells[0, i] <> '' then
    begin
    Inc(Nom);

    with StringGridMaterials do
    begin
    s := Cells[2, i];
    MR[Nom] := Count * MyStrToFloat(s); // ���-�� * ����� �������
    MR1[Nom] := MyStrToFloat(s); // 1 * ����� �������
    end;

    // ��������� �� ������� ������������� (��)
    for j := 1 to CountCoef + 1 do
    with StringGridCalculations do
    begin
    MR[Nom] := MR[Nom] * MyStrToFloat(Cells[5, j]);
    MR1[Nom] := MR1[Nom] * MyStrToFloat(Cells[5, j]);
    end;

    // ��� ���������� �������� �� ���������� ����
    with StringGridMaterials do
    begin
    MR[Nom] := MR[Nom] * MyStrToFloatdef(Cells[7, i], 0);
    MR1[Nom] := MR1[Nom] * MyStrToFloatdef(Cells[7, i], 0);
    end;

    with StringGridMaterials do
    Cells[6, i] := MyFloatToStr(MyStrToFloat(Cells[5, i]) * MR[i] / 100)
    end;

    // -----------------------------------------

    if CountMaterial > 0 then
    begin
    Res := MR[0];
    Res1 := MR1[0];

    for i := 1 to CountMaterial - 1 do
    begin
    Res := Res + MR[i];
    Res1 := Res1 + MR1[i];
    end;
    end;

    // -----------------------------------------

    // ��������� ������ � ������ ������� � ������� (��)
    with StringGridCalculations do
    begin
    Cells[5, CountCoef + 3] := MyCurrToStr(RoundTo(Res, PS.RoundTo * -1));
    Cells[5, CountCoef + 2] := MyCurrToStr(RoundTo(Res1, PS.RoundTo * -1));
    end;
    except
    on E: Exception do
    MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[5,
    0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
    MB_ICONERROR + MB_OK + mb_TaskModal);
    end; }
end;

procedure TFormCalculationEstimate.CalculationPercentTransport;
var
  Percent: Double;
  Str: string;
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL GetPercentTransport(' + IntToStr(IdObject) + ');');
      Active := True;

      if RecordCount > 0 then
        Percent := FieldByName('PercentTransport').AsVariant
        // �������� % ������������ ������
      else
        Percent := 0;
    end;

    { R
      with StringGridCalculations do
      begin
      Cells[6, CountCoef + 2] :=
      MyFloatToStr(RoundTo(MyStrToFloatDef(Cells[5, CountCoef + 2], 0) * Percent / 100, PS.RoundTo * -1));
      Cells[6, CountCoef + 3] :=
      MyFloatToStr(RoundTo(MyStrToFloatDef(Cells[5, CountCoef + 3], 0) * Percent / 100, PS.RoundTo * -1));
      end;
    }   {
    qrCalculations.ParamByName('transp_one').AsFloat :=
      RoundTo(qrCalculations.ParamByName('mr_one').AsFloat * Percent / 100, PS.RoundTo * -1);
    qrCalculations.ParamByName('transp_two').AsFloat :=
      RoundTo(qrCalculations.ParamByName('mr_two').AsFloat * Percent / 100, PS.RoundTo * -1); }
  except
    on E: Exception do
      MessageBox(0, PChar('������ ��� ���������� �' + '�, � ������� ����������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetNormMechanizm(const vIdNormativ, vIdMechanizm: string): Double;
begin
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
      else
        Result := 0;

    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ����� ������� �� ��������� �������� ������:' + sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetPriceMechanizm(const vIdNormativ, vIdMechanizm: string): Currency;
begin
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
      else
        Result := 0;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ����� ������� �� ��������� �������� ������:' + sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.CalculationEMiM(const vIdNormativ: string): TTwoValues;
var
  IdMechanizm: array of Integer;
  EMiM, EMiM1: array of Double;
  CountMechanizm: Integer;
  i, j: Integer;
  Res, Res1, NormRas, Count, Coast: Double;
  TW: TTwoValues;
begin
  { try
    // �������� ��� Id ���������� � ��������
    try
    with qrTemp do
    begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT mechanizm_id FROM mechanizmnorm WHERE normativ_id = ' + vIdNormativ + ';');
    Active := True;

    CountMechanizm := RecordCount;
    SetLength(IdMechanizm, CountMechanizm);

    i := 0;
    First;

    while not Eof do
    begin
    IdMechanizm[i] := FieldByName('mechanizm_id').AsVariant;
    // ������� �� � ������
    Inc(i);
    Next;
    end;
    end;
    except
    on E: Exception do
    MessageBox(0, PChar('��� ��������� Id ���������� �������� ������:' + sLineBreak + sLineBreak +
    E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;

    // �������� ������
    SetLength(EMiM, CountMechanizm);
    SetLength(EMiM1, CountMechanizm);

    Res := 0;
    Res1 := 0;

    // ���������� �� ����� �������
    Count := CountFromRate; // MyStrToFloat(Cells[2, Row]);

    for i := 0 to CountMechanizm - 1 do
    begin
    NormRas := GetNormMechanizm(vIdNormativ, IntToStr(IdMechanizm[i]));

    EMiM[i] := Count * NormRas; // ���-�� * ����� �������
    EMiM1[i] := NormRas; // 1 * ����� �������

    // ��������� �� ������� ������������� (��)
    for j := 1 to CountCoef + 1 do
    with StringGridCalculations do
    begin
    EMiM[i] := EMiM[i] * MyStrToFloat(Cells[5, j]);
    EMiM1[i] := EMiM1[i] * MyStrToFloat(Cells[5, j]);
    end;

    with StringGridMechanizms do
    if Cells[8, i + 1] = '' then
    Coast := GetCoastMechanizm(IdMechanizm[i])
    else
    Coast := MyStrToFloat(Cells[8, i + 1]);

    // ��� ���������� �������� �� ���������� ����
    EMiM[i] := EMiM[i] * Coast;
    EMiM1[i] := EMiM1[i] * Coast;
    end;

    // -----------------------------------------

    if CountMechanizm > 1 then
    begin
    Res := EMiM[0];
    Res1 := EMiM1[0];

    for i := 1 to CountMechanizm - 1 do
    begin
    Res := Res + EMiM[i];
    Res1 := Res1 + EMiM1[i];
    end;
    end;

    // -----------------------------------------

    TW.ForOne := RoundTo(Res1, PS.RoundTo * -1);
    TW.ForCount := RoundTo(Res, PS.RoundTo * -1);

    Result := TW;
    except
    on E: Exception do
    MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[3,
    0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
    MB_ICONERROR + MB_OK + mb_TaskModal);
    end; }
end;

procedure TFormCalculationEstimate.CalculationSalaryMachinist;
var
  CountMechanizm: Integer;
  i, j: Integer;
  Count: Double;
  EMiM, EMiM1: array of Double;
  FirstSalary: Double;
  Res, Res1: Double;
  s: string;
begin
  { try
    // ���������� ���������� � ��������
    CountMechanizm := StringGridMechanizms.RowCount - 1;

    // �������� ������
    SetLength(EMiM, CountMechanizm);
    SetLength(EMiM1, CountMechanizm);

    // ���������� �� ����� �������
    Count := CountFromRate; // MyStrToFloat(Cells[2, Row]);

    Res := 0;
    Res1 := 0;

    for i := 0 to CountMechanizm - 1 do
    begin
    with StringGridMechanizms do
    begin
    s := Cells[2, i + 1];
    s[Pos('.', s)] := ',';

    EMiM[i] := Count * MyStrToFloat(s);
    EMiM1[i] := MyStrToFloat(s);
    end;

    // ��������� �� ������� ������������� (����)
    for j := 1 to CountCoef + 1 do
    with StringGridCalculations do
    begin
    EMiM[i] := EMiM[i] * MyStrToFloat(Cells[5, j]);
    EMiM1[i] := EMiM1[i] * MyStrToFloat(Cells[5, j]);
    end;

    with StringGridMechanizms do
    begin
    FirstSalary := GetSalaryMachinist(StrToInt(Cells[12, i + 1]));
    Res := Res + (FirstSalary * EMiM[i]);
    Res1 := Res1 + (FirstSalary * EMiM1[i]);

    with StringGridMechanizms do
    Cells[5, i + 1] := MyFloatToStr(FirstSalary * Count);
    end;
    end;

    // -----------------------------------------

    // ��������� ������ � ������ ������� � ������� (����)
    with StringGridCalculations do
    begin
    Cells[4, CountCoef + 3] := MyCurrToStr(RoundTo(Res, PS.RoundTo * -1));
    Cells[4, CountCoef + 2] := MyCurrToStr(RoundTo(Res1, PS.RoundTo * -1));
    end;
    except
    on E: Exception do
    MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[4,
    0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
    MB_ICONERROR + MB_OK + mb_TaskModal);
    end; }
end;

procedure TFormCalculationEstimate.CalculationCost;
begin
  { try
    with StringGridCalculations do
    begin
    Cells[7, CountCoef + 2] :=
    MyFloatToStr(RoundTo(MyStrToFloat(Cells[2, CountCoef + 2]) + MyStrToCurr(Cells[3, CountCoef + 2]) +
    MyStrToCurr(Cells[5, CountCoef + 2]) + MyStrToCurr(Cells[6, CountCoef + 2]), PS.RoundTo * -1));

    Cells[7, CountCoef + 3] :=
    MyFloatToStr(RoundTo(MyStrToFloat(Cells[2, CountCoef + 3]) + MyStrToCurr(Cells[3, CountCoef + 3]) +
    MyStrToCurr(Cells[5, CountCoef + 3]) + MyStrToCurr(Cells[6, CountCoef + 3]), PS.RoundTo * -1));
    end;
    except
    on E: Exception do
    MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[7,
    0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
    MB_ICONERROR + MB_OK + mb_TaskModal);
    end; }
end;

procedure TFormCalculationEstimate.CalculationOXROPR;
var
  OXROPR: Double;
begin
{
  try
    // ���� ����� % ������� ���������� ���� � �������, ����� �������
    // R if Cells[8, CountCoef + 2] <> '' then
    if qrCalculations.ParamByName('ohropr_one').Value <> Null then
    begin
      // R OXROPR := MyStrToCurr(Cells[2, CountCoef + 3]); // ��
      OXROPR := qrCalculations.ParamByName('count').AsInteger;
      // OXROPR := OXROPR + MyStrToCurr(Cells[4, CountCoef + 3]); // �� + �� ���.

      // (�� + �� ���.) * % � ���� �������
      // R OXROPR := OXROPR * MyStrToCurr(Cells[8, CountCoef + 2]) / 100;
      OXROPR := OXROPR * qrCalculations.ParamByName('ohropr_one').AsFloat / 100;

      // ��������� ������ � ������ ������� � ������� (��� � ���)
      // R Cells[8, CountCoef + 3] := MyFloatToStr(RoundTo(OXROPR, PS.RoundTo * -1));
      qrCalculations.ParamByName('ohropr_two').AsFloat := RoundTo(OXROPR, PS.RoundTo * -1);
    end
    else
    begin       }
      { R
        Cells[8, CountCoef + 2] := '���';
        Cells[8, CountCoef + 3] := '���';
      } {
      qrCalculations.ParamByName('ohropr_one').Value := Null;
      qrCalculations.ParamByName('ohropr_two').Value := Null;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('������ ��� ���������� ��������' + '�, � ������� ����������:' + sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
         }
end;

procedure TFormCalculationEstimate.CalculationPlanProfit;
var
  PlanProfit: Double;
begin
  { try
    with StringGridCalculations do
    // ���� % ����� ������� ���� � �������, ����� �������
    if Cells[9, CountCoef + 2] <> '' then
    begin
    PlanProfit := MyStrToCurr(Cells[2, CountCoef + 3]); // ��
    //     PlanProfit := PlanProfit + MyStrToCurr(Cells[4, CountCoef + 3]);
    // �� + �� ���.

    // (�� + �� ���.) * % � ���� �������
    PlanProfit := PlanProfit * MyStrToCurr(Cells[9, CountCoef + 2]) / 100;

    // ��������� ������ � ������ ������� � ������� (���� �������)
    Cells[9, CountCoef + 3] := MyFloatToStr(RoundTo(PlanProfit, PS.RoundTo * -1));
    end
    else
    begin
    Cells[9, CountCoef + 2] := '���';
    Cells[9, CountCoef + 3] := '���';
    end;
    except
    on E: Exception do
    MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[9,
    0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
    MB_ICONERROR + MB_OK + mb_TaskModal);
    end; }
end;

procedure TFormCalculationEstimate.CalculationCostOXROPR;
var
  OXROPR, PlanProfit: Currency;
  i: Integer;
  Str: string;
begin
  { try
    OXROPR := MyStrToCurr(StringGridCalculations.Cells[2, CountCoef + 3]); // ��
    OXROPR := OXROPR / MyStrToCurr(StringGridCalculations.Cells[8, CountCoef + 1]); // �� / �� �� ��������
    OXROPR := OXROPR + MyStrToCurr(StringGridCalculations.Cells[4, CountCoef + 3]);
    // (�� / �� �� ��������) + �� ���.

    PlanProfit := MyStrToCurr(StringGridCalculations.Cells[2, CountCoef + 2]);
    // ��
    PlanProfit := PlanProfit / MyStrToFloat(StringGridCalculations.Cells[8, CountCoef + 1]);
    // �� / �� �� ��������
    PlanProfit := PlanProfit + MyStrToFloat(StringGridCalculations.Cells[4, CountCoef + 2]);
    // (�� / �� �� ��������) + �� ���.

    // -----------------------------------------

    // ��������� �� ������� ������������� (��� � ���)
    try
    with StringGridCalculations do
    begin
    for i := 1 to CountCoef + 1 do
    begin
    OXROPR := OXROPR * MyStrToCurr(Cells[8, i]);
    PlanProfit := PlanProfit * MyStrToCurr(Cells[8, i]);
    end;

    Str := Cells[8, CountCoef + 2];
    if Str = '' then
    Str := '0';

    // ����� �� 100, ��� ��� �������� �� %
    OXROPR := OXROPR * MyStrToCurr(Str) / 100;
    PlanProfit := PlanProfit * MyStrToCurr(Str) / 100;
    end;
    except
    on E: Exception do
    MessageBox(0, PChar('��� ��������� ����� �� ������ ������� �������� ������:' + sLineBreak + sLineBreak
    + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;

    // -----------------------------------------

    // ��������� ������ � ������ ������� � ������� (��. � ��� � ���)
    with StringGridCalculations do
    begin
    Cells[10, CountCoef + 3] := MyCurrToStr(RoundTo(OXROPR, PS.RoundTo * -1));
    Cells[10, CountCoef + 2] := MyCurrToStr(RoundTo(PlanProfit, PS.RoundTo * -1));;
    end;
    except
    on E: Exception do
    MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[10,
    0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
    MB_ICONERROR + MB_OK + mb_TaskModal);
    end; }
end;

procedure TFormCalculationEstimate.CalculationWinterPrice;
var
  WinterPrice: Currency;
begin
  { try
    WinterPrice := MyStrToCurr(StringGridCalculations.Cells[2, CountCoef + 3]);
    // ��
    WinterPrice := WinterPrice + MyStrToCurr(StringGridCalculations.Cells[4, CountCoef + 3]); // �� + �� ���.

    // (�� + �� ���.) * ����� ������� ������� ����������
    WinterPrice := WinterPrice * MyStrToCurr(StringGridCalculations.Cells[13, CountCoef + 2]) / 100;

    // ��������� ������ � ������ ������� � ������� (���. ������.)
    with StringGridCalculations do
    Cells[13, CountCoef + 3] := MyCurrToStr(RoundTo(WinterPrice, PS.RoundTo * -1));
    except
    on E: Exception do
    MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[13,
    0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
    MB_ICONERROR + MB_OK + mb_TaskModal);
    end; }
end;

procedure TFormCalculationEstimate.CalculationSalaryWinterPrice;
var
  SalaryWinterPrice: Currency;
begin
  { try
    SalaryWinterPrice := MyStrToCurr(StringGridCalculations.Cells[2, CountCoef + 3]); // ��
    SalaryWinterPrice := SalaryWinterPrice + MyStrToCurr(StringGridCalculations.Cells[4, CountCoef + 3]);
    // �� + �� ���.

    // (�� + �� ���.) * ����� ������� ������� ����������
    SalaryWinterPrice := SalaryWinterPrice * MyStrToCurr(StringGridCalculations.Cells[14, CountCoef + 2]) / 100;

    // ��������� ������ � ������ ������� � ������� (�� � ���. ������.)
    with StringGridCalculations do
    Cells[14, CountCoef + 3] := MyCurrToStr(RoundTo(SalaryWinterPrice, PS.RoundTo * -1));
    except
    on E: Exception do
    MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[14,
    0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
    MB_ICONERROR + MB_OK + mb_TaskModal);
    end; }
end;

procedure TFormCalculationEstimate.CalculationWork;
var
  Work: Currency;
begin
  { try
    Work := MyStrToCurr(StringGridCalculations.Cells[11, CountCoef + 2]); // ����

    Work := Work * CountFromRate;
    // MyStrToCurr( StringGridRates.Cells[2, StringGridRates.Row] );
    // ���� * ���-��

    // ��������� ������ � ������ ������� � ������� (����)
    with StringGridCalculations do
    Cells[11, CountCoef + 3] := MyCurrToStr(RoundTo(Work, PS.RoundTo * -1));
    except
    on E: Exception do
    MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[11,
    0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
    MB_ICONERROR + MB_OK + mb_TaskModal);
    end; }
end;

procedure TFormCalculationEstimate.CalculationWorkMachinist;
var
  WorkMachinist: Currency;
begin
  { try
    WorkMachinist := MyStrToCurr(StringGridCalculations.Cells[12, CountCoef + 2]);
    // ����

    WorkMachinist := WorkMachinist * CountFromRate;
    // MyStrToCurr(StringGridRates.Cells[2, StringGridRates.Row]);
    // ���� * ���-��

    // ��������� ������ � ������ ������� � ������� (���� ���.)
    with StringGridCalculations do
    Cells[12, CountCoef + 3] := MyCurrToStr(RoundTo(WorkMachinist, PS.RoundTo * -1));
    except
    on E: Exception do
    MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[2,
    0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
    MB_ICONERROR + MB_OK + mb_TaskModal);
    end; }
end;

procedure TFormCalculationEstimate.SettingVisibleRightTables;
begin
  // ��������� ����� �������������� � ����, ���� �� �������
  // ������� � ���, ��� ���������� �� �������� ������ ��� ������� �� ���
  if not MemoRight.ReadOnly then
    MemoRightExit(MemoRight);

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
  else if VisibleRightTables = '1110000' then  //�� ������������!!!
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
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT monat as "Month", year as "Year" FROM stavka WHERE stavka_id = (SELECT stavka_id From smetasourcedata '
        + 'WHERE sm_id = ' + IntToStr(IdEstimate) + ');');
      Active := True;

      MonthEstimate := FieldByName('Month').AsVariant;
      YearEstimate := FieldByName('Year').AsVariant;
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� ������ � ���� �� ������� ������ �������� ������:' + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.FillingOXROPR;
var
  i: Integer;
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT work_id, work_name as "NameWork" FROM objworks ORDER BY work_id;');
      Active := True;

      First;
      i := 1;
      ComboBoxOXROPR.Items.Clear;

      while not Eof do
      begin
        ComboBoxOXROPR.Items.Add(IntToStr(i) + '. ' + FieldByName('NameWork').AsVariant);

        inc(i);
        Next;
      end;

      ComboBoxOXROPR.ItemIndex := 0;
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ���������� ����������� ������ "��� � ��� � ��. ����." �������� ������:' +
        sLineBreak + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.GetSourceData;
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT monat, year, nds FROM stavka, smetasourcedata ' +
        'WHERE stavka.stavka_id = smetasourcedata.stavka_id and sm_id = :sm_id;');
      qrTemp.ParamByName('sm_id').Value := IdEstimate;
      Active := True;

      EditMonth.Text := FormatDateTime('mmmm yyyy ����.',
        StrToDate('01.' + qrTemp.FieldByName('monat').AsString + '.' + qrTemp.FieldByName('year').AsString));

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
      Active := False;
    end;
    // ������ �� ����, ������������ ��� ��� ��� ����������� ������� ��� ������ ������
    ChangeGrigNDSStyle(NDSEstimate);

  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� �������� ������ �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.ChangeGrigNDSStyle(aNDS: Boolean);
begin
  with dbgrdMaterial do
  begin
    // � ����������� �� ��� �������� ���� � ���������� ������ �������
    Columns[6].Visible := aNDS; // ���� ����
    Columns[8].Visible := aNDS; // ������ ����
    Columns[10].Visible := aNDS; // ����� ����
    Columns[13].Visible := aNDS; // ���� ����
    Columns[15].Visible := aNDS; // ������ ����
    Columns[17].Visible := aNDS; // ����� ����

    Columns[7].Visible := not aNDS;
    Columns[9].Visible := not aNDS;
    Columns[11].Visible := not aNDS;
    Columns[14].Visible := not aNDS;
    Columns[16].Visible := not aNDS;
    Columns[18].Visible := not aNDS;
  end;

  with dbgrdMechanizm do
  begin
    // � ����������� �� ��� �������� ���� � ���������� ������ �������
    Columns[5].Visible := aNDS;
    Columns[7].Visible := aNDS;
    Columns[9].Visible := aNDS;
    Columns[11].Visible := aNDS;
    Columns[14].Visible := aNDS;
    Columns[16].Visible := aNDS;
    Columns[18].Visible := aNDS;
    Columns[20].Visible := aNDS;

    Columns[6].Visible := not aNDS;
    Columns[8].Visible := not aNDS;
    Columns[10].Visible := not aNDS;
    Columns[12].Visible := not aNDS;
    Columns[15].Visible := not aNDS;
    Columns[17].Visible := not aNDS;
    Columns[19].Visible := not aNDS;
    Columns[21].Visible := not aNDS;
  end;

  with dbgrdDevices do
  begin
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
    Columns[9].Visible := aNDS; // ����� ����

    Columns[8].Visible := not aNDS;
    Columns[10].Visible := not aNDS;
  end;
end;

procedure TFormCalculationEstimate.SetIndexOXROPR(vNumber: String);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT work_id as "IdWork", s as "From", po as "On" FROM onormativs;');
      Active := True;

      First;

      ComboBoxOXROPR.ItemIndex := 0;

      while not Eof do
      begin
        if (vNumber > FieldByName('From').AsVariant) and (vNumber < FieldByName('On').AsVariant) then
        begin
          ComboBoxOXROPR.ItemIndex := FieldByName('IdWork').AsVariant - 1;
          Break;
        end;

        Next;
      end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ���������� �������� � ���������� ������' + sLineBreak +
        '"��� � ��� � ��. ����." �������� ������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.GetValuesOXROPR;
begin
  with qrTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT p1 as "OXRandOPR", p2 as "PlannedProfit" FROM objdetail WHERE number = ' +
      IntToStr(ComboBoxOXROPR.ItemIndex + 1) +
      ' and stroj_id = (SELECT stroj_id FROM objcards WHERE obj_id = ' + IntToStr(IdObject) + ');');

    Active := True;

    if FieldByName('OXRandOPR').AsVariant <> Null then
      // R Cells[8, CountCoef + 2] := MyFloatToStr(FieldByName('OXRandOPR').AsVariant)
      //qrCalculations.ParamByName('ohropr_one').Value := FieldByName('OXRandOPR').AsVariant
    else
      // R Cells[8, CountCoef + 2] := '0';
      //qrCalculations.ParamByName('ohropr_one').AsFloat := 0;

    if FieldByName('PlannedProfit').AsVariant <> Null then
      // R Cells[9, CountCoef + 2] := MyFloatToStr(FieldByName('PlannedProfit').AsVariant)
      //qrCalculations.ParamByName('plan_prib_one').AsFloat := FieldByName('PlannedProfit').AsVariant
    else
      // R Cells[9, CountCoef + 2] := '0';
      //qrCalculations.ParamByName('plan_prib_one').AsFloat := 0;
  end;
end;

procedure TFormCalculationEstimate.FillingWinterPrice(vNumber: string);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT num as "Number", name as "Name", coef as "Coef", coef_zp as "CoefZP", s as "From", po as "On" '
        + 'FROM znormativs;');
      Active := True;

      First;
      { R
        StringGridCalculations.Cells[13, CountCoef + 2] := '0';
        StringGridCalculations.Cells[14, CountCoef + 2] := '0';
      }
      //qrCalculations.ParamByName('zim_udor_one').AsFloat := 0;
      //qrCalculations.ParamByName('zp_zim_udor_one').AsFloat := 0;

      while not Eof do
      begin
        if (vNumber > FieldByName('From').AsVariant) and (vNumber < FieldByName('On').AsVariant) then
        begin
          EditWinterPrice.Text := FieldByName('Number').AsVariant + ' ' + FieldByName('Name').AsVariant;
          { R
            StringGridCalculations.Cells[13, CountCoef + 2] := MyFloatToStr(FieldByName('Coef').AsVariant);
            StringGridCalculations.Cells[14, CountCoef + 2] := MyFloatToStr(FieldByName('CoefZP').AsVariant);
          }
          //qrCalculations.ParamByName('zim_udor_one').AsFloat := FieldByName('Coef').AsVariant;
          //qrCalculations.ParamByName('zp_zim_udor_one').AsFloat := FieldByName('CoefZP').AsVariant;
          Break;
        end;

        Next;
      end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� �������� ������� ���������� �������� ������:' + sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ����� ���� ��������, ���-�� ����� ������, ��� ������ � �������� 6��
procedure TFormCalculationEstimate.AddRowToTableRates(FieldRates: TFieldRates);
begin
  // �������� ������� � ��-6
  if Act and FormKC6.Showing then
    FormKC6.SelectDataEstimates(FieldRates.vTypeAddData, FieldRates.vId, FieldRates.vCount);
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

// ��������, ��� ������� �������� ������(���� ������ ������������ �������� ��� ������)
procedure TFormCalculationEstimate.TestOnNoData(SG: TStringGrid);
begin
  // if SG.Cells[0, 1] = '' then
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
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('Call GetSalaryMachinist(:IdObject, :IdMechanizm);');

      ParamByName('IdObject').Value := IdObject;
      ParamByName('IdMechanizm').Value := vIdMechanizm;

      Active := True;

      if FieldByName('Salary').AsVariant = Null then
        Result := 0
      else
        Result := FieldByName('Salary').AsVariant;

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� ��� ��������� �������� ������:' + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetCoastMechanizm(const vIdMechanizm: Integer): Currency;
begin
  // ���� ������������� (������, ������) ���������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('Call GetCoastMechanism(:IdObject, :IdMechanizm);');

      ParamByName('IdObject').Value := IdObject;
      ParamByName('IdMechanizm').Value := vIdMechanizm;

      Active := True;

      if FieldByName('Coast').AsVariant = Null then
        Result := 0
      else
        Result := FieldByName('Coast').AsVariant;

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� ����� ������ ��������� �������� ������:' + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.CreateTempTables;
var
  Str: string;
begin
  if Act then
    Str := 'CALL CreateTempTables(2);' // ������ ����
  else
    Str := 'CALL CreateTempTables(1);'; // ������ �����

  try
    with qrTemp do
    begin
      SQL.Clear;
      SQL.Add(Str);
      ExecSQL;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� �������� ��������� ������ �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.OpenAllData;
begin
  GetMonthYearCalculationEstimate;
  GetSourceData; // ������� ����������� �� �������� ������ �����
  GetStateCoefOrdersInRate;
  // �������� ��������� ������������ �� �������� (��������� / �� ���������)

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

      ExecSQL;
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� �������� ������ �������� ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ���������� ������� ��������
  OutputDataToTable(0);
end;

// ���������� ������� ��������
procedure TFormCalculationEstimate.OutputDataToTable(aRecNo: Integer);
var
  FieldRates: TFieldRates;
  i: Integer;
  Str: string;
  Count: integer;
begin
  if Act then
    Str := 'data_act_temp'
  else
    Str := 'data_estimate_temp';

  // �������� �������� ��� ���������� GridRates
  qrRates.Tag := 1; // ���-�� ��������� ������� �� ������ � ��������
  qrRates.Active := False;
  // ��������� rates_temp
  qrRates.SQL.Text := 'call GetRates(:pr1, :pr2, :fn)';
  qrRates.ParamByName('pr1').Value := Str;
  if Act then
  begin
    qrRates.ParamByName('pr2').Value := IdAct;
    qrRates.ParamByName('fn').Value := 'ID_ACT';
  end
  else
  begin
    qrRates.ParamByName('pr2').Value := IdEstimate;
    qrRates.ParamByName('fn').Value := 'ID_ESTIMATE';
  end;

  qrRates.ExecSQL;

  qrTemp.SQL.Text := 'CALL CalcCalculationAll;';
  qrTemp.ExecSQL;

  // ��������� rates_temp
  qrRates.SQL.Text := 'SELECT * FROM rates_temp ORDER BY DID, RID, STYPE, MID, MEID';
  qrRates.Active := True;
  i := 0;
  Count := 0;
  qrRates.DisableControls;
  //E18 � E20 - ����� ����������� � ����� ������ ���� ���
  PMAddAdditionHeatingE18.Enabled := True;
  PMAddAdditionHeatingE20.Enabled := True;
  try
    while not qrRates.Eof do
    begin
      inc(Count);
      if not CheckMatINRates then
        inc(i);

      if qrRatesTYPE_DATA.AsInteger = 10 then
        PMAddAdditionHeatingE18.Enabled := False;

      if qrRatesTYPE_DATA.AsInteger = 11 then
        PMAddAdditionHeatingE20.Enabled := False;

      qrRates.Edit;
      qrRatesNUM.AsInteger := i;
      qrRates.Post;

      qrRates.Next;
    end;
    //����� ���� Eof
    if Count > 0 then
    begin
      i := qrRates.RecNo;
      qrRates.Prior;
      if i <> qrRates.RecNo then
        qrRates.Next;
    end;

  finally
    qrRates.EnableControls;
  end;
  qrRates.Tag := 0;

  i := qrRates.RecNo;
  // ����������� ���� ���-�� ��������� �����
  if (Count >= aRecNo) and (aRecNo > 0) then
    qrRates.RecNo := aRecNo
  else
  begin
    if (aRecNo > 0) and (Count > 0) then
      qrRates.RecNo := Count
    else qrRates.First;
  end;

  //���� ��������� ������� �� ���������� ��������� ����� �������������
  if qrRates.RecNo = i then qrRatesAfterScroll(qrRates);

  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.CopyEstimate;
var
  sm_type, obj_id, name_estimate, date, sm_number, chapter, row_number, preparer, post_preparer, examiner,
    post_examiner, set_drawings, stavka_id, COEF_TR_ZATR, coef_tr_obor, k40, k41, k31, k32, k33, k34, NDS,
    dump_id: Variant;

  i, LastId: Integer;
  sIdEstimate, sNumberRow, sNumberNorm, sCountNorm, sUnitName, sDescription, sTypeData, sIdNorm,
    sDistanceCount, sClassMass: string;
begin
  { with FormSaveEstimate do
    begin
    iIdEstimate := IdEstimate;
    ShowModal;

    if bSaveEstimate then
    begin
    sm_number := '"' + EditNumberEstimate.Text + '"';
    name_estimate := '"' + EditNameEstimate.Text + '"';
    end
    else
    Exit;
    end;

    try
    with qrTemp do
    begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM smetasourcedata WHERE sm_id = ' + IntToStr(IdEstimate));
    Active := True;

    sm_type := '"' + IntToStr(FieldByName('sm_type').AsInteger) + '"';
    obj_id := '"' + IntToStr(FieldByName('obj_id').AsInteger) + '"';
    // name_estimate := '"����� ' + FieldByName('name').AsString + '"';
    date := '"' + DateToStr(FieldByName('date').AsDateTime) + '"';
    // sm_number := '"' + FieldByName('sm_number').AsString + '"';
    chapter := '"' + FieldByName('chapter').AsString + '"';
    row_number := '"' + IntToStr(FieldByName('row_number').AsInteger) + '"';
    preparer := '"' + FieldByName('preparer').AsString + '"';
    post_preparer := '"' + FieldByName('post_preparer').AsString + '"';
    examiner := '"' + FieldByName('examiner').AsString + '"';
    post_examiner := '"' + FieldByName('post_examiner').AsString + '"';
    set_drawings := '"' + FieldByName('set_drawings').AsString + '"';
    stavka_id := '"' + IntToStr(FieldByName('stavka_id').AsInteger) + '"';

    COEF_TR_ZATR := '"' + MyFloatToStr(FieldByName('coef_tr_zatr').AsFloat) + '"';
    coef_tr_obor := '"' + MyFloatToStr(FieldByName('coef_tr_obor').AsFloat) + '"';
    k40 := '"' + MyFloatToStr(FieldByName('k40').AsFloat) + '"';
    k41 := '"' + MyFloatToStr(FieldByName('k41').AsFloat) + '"';
    k31 := '"' + MyFloatToStr(FieldByName('k31').AsFloat) + '"';
    k32 := '"' + MyFloatToStr(FieldByName('k32').AsFloat) + '"';
    k33 := '"' + MyFloatToStr(FieldByName('k33').AsFloat) + '"';
    k34 := '"' + MyFloatToStr(FieldByName('k34').AsFloat) + '"';

    NDS := '"' + IntToStr(FieldByName('nds').AsInteger) + '"';
    dump_id := '"' + IntToStr(FieldByName('dump_id').AsInteger) + '"';

    // ----------------------------------------

    Active := False;
    SQL.Clear;
    SQL.Add('INSERT INTO smetasourcedata (sm_type, obj_id, name, date, sm_number, chapter, row_number, preparer, '
    + 'post_preparer, examiner, post_examiner, set_drawings, stavka_id, coef_tr_zatr, coef_tr_obor, k40, k41, k31, '
    + 'k32, k33, k34, nds, dump_id) Value(' + sm_type + ', ' + obj_id + ', ' + name_estimate + ', ' + date
    + ', ' + sm_number + ', ' + chapter + ', ' + row_number + ', ' + preparer + ', ' + post_preparer +
    ', ' + examiner + ', ' + post_examiner + ', ' + set_drawings + ', ' + stavka_id + ', ' + COEF_TR_ZATR
    + ', ' + coef_tr_obor + ', ' + k40 + ', ' + k41 + ', ' + k31 + ', ' + k32 + ', ' + k33 + ', ' + k34 +
    ', ' + NDS + ', ' + dump_id + ');');
    ExecSQL;

    // ----------------------------------------

    Active := False;
    SQL.Clear;
    SQL.Add('SELECT LAST_INSERT_ID() as "last_id";');
    // Id ��������� ������. ������ �������� ����������� � ��
    Active := True;

    sIdEstimate := FieldByName('last_id').AsVariant;
    end;
    except
    on E: Exception do
    begin
    MessageBox(0, PChar('��� ���������� ����� ����� �������� ������:' + sLineBreak + E.Message),
    CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
    end;

    try
    for i := 1 to StringGridRates.RowCount - 2 do
    begin
    with StringGridRates do
    begin
    sNumberRow := Cells[0, i];
    sNumberNorm := Cells[1, i];
    sCountNorm := Cells[2, i];

    if Pos(',', sCountNorm) > 0 then
    sCountNorm[Pos(',', sCountNorm)] := '.';

    if Cells[3, i] = '' then
    sUnitName := 'NULL'
    else
    sUnitName := '"' + Cells[3, i] + '"';

    if Cells[4, i] = '' then
    sDescription := 'NULL'
    else
    sDescription := '"' + Cells[4, i] + '"';

    sTypeData := Cells[5, i];

    if Cells[6, i] = '' then
    sIdNorm := 'NULL'
    else
    sIdNorm := '"' + Cells[6, i] + '"';

    if Cells[7, i] = '' then
    sDistanceCount := 'NULL'
    else
    sDistanceCount := '"' + Cells[7, i] + '"';

    if Cells[8, i] = '' then
    sClassMass := 'NULL'
    else
    sClassMass := '"' + Cells[8, i] + '"';
    end;

    with qrTemp do
    begin
    Active := False;
    SQL.Clear;
    SQL.Add('INSERT INTO rates (id_estimate, number_row, number_norm, count_norm, unit_name, description,'
    + ' type_data, id_norm, distance_count, class_mass) VALUE ("' + sIdEstimate + '", "' + sNumberRow +
    '", "' + sNumberNorm + '", "' + sCountNorm + '", ' + sUnitName + ', ' + sDescription + ', "' +
    sTypeData + '", ' + sIdNorm + ', ' + sDistanceCount + ', ' + sClassMass + ');');

    ExecSQL;
    end;
    end;
    except
    on E: Exception do
    MessageBox(0, PChar('��� ���������� �������� ����� ����� �������� ������:' + sLineBreak + sLineBreak +
    E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end; }
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

// ������ ����������� ��������� � �����
procedure TFormCalculationEstimate.ReplacementMaterial(const vIdMat: Integer);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL ReplacedMaterial(:IdEstimate, :IdCardRate, :IdReplaced, :IdMat);');
      ParamByName('IdEstimate').Value := IdEstimate;
      ParamByName('IdCardRate').Value := RepIdRate;
      ParamByName('IdReplaced').Value := RepIdMat;
      ParamByName('IdMat').Value := vIdMat;

      ExecSQL;
    end;

    OutputDataToTable(qrRates.RecNo);
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������ ���������� ��������� �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.ShowFormAdditionData(const vDataBase: Char);
var
  FormTop, FormLeft, BorderTop, BorderLeft: Integer;
begin
  if (Assigned(FormAdditionData)) then
  begin
    FormAdditionData.Show;
    Exit;
  end;

  FormMain.PanelCover.Visible := True;
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
  FormMain.PanelCover.Visible := False;
end;

function TFormCalculationEstimate.GetPriceMaterial(): Variant;
begin
  { with qrTemp do
    begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT state_nds FROM objcards WHERE obj_id = ' + IntToStr(IdObject) + ';');
    Active := True;

    case FieldByName('state_nds').AsVariant of
    0:
    Result := ADOQueryMaterialCard.FieldByName('coast_no_nds').AsVariant;
    1:
    Result := ADOQueryMaterialCard.FieldByName('coast_nds').AsVariant;
    end;
    end; }
end;

procedure TFormCalculationEstimate.GetStateCoefOrdersInEstimate;
begin
  // �������� ���� ��������� (��������� ��� �� ���������) ������������ �� ��������

  try
    PMCoefOrders.Enabled := False;
    PopupMenuCoefOrders.Enabled := False;

    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT coef_orders FROM smetasourcedata WHERE sm_id = :sm_id;');
      ParamByName('sm_id').Value := IdEstimate;
      Active := True;

      if FieldByName('coef_orders').AsInteger = -1 then
      begin
        PMCoefOrders.Enabled := True;
        PopupMenuCoefOrders.Enabled := True;
      end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ����� ���������� ������������ �� �������� ��� ����� �������� ������:'
        + sLineBreak + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  PopupMenuCoefDeleteSet.Enabled := (qrCalculations.FieldByName('ID').AsInteger > 0);
end;

procedure TFormCalculationEstimate.GetStateCoefOrdersInRate;
begin
  // �������� ���� ��������� ������������ �� �������� (��������� ��� �� ���������)

  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT coef_orders FROM smetasourcedata WHERE sm_id = :sm_id;');
      ParamByName('sm_id').Value := IdEstimate;
      Active := True;

      if FieldByName('coef_orders').AsInteger = 1 then
        EditCoefOrders.Color := $0080FF80
      else
        EditCoefOrders.Color := $008080FF;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ����� ���������� ������������ �� �������� �������� ������:' +
        sLineBreak + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.AddCoefToRate(coef_id: Integer);
// ���������� �����. � �������
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text :=
    'INSERT INTO calculation_coef_temp(id_estimate,id_type_data,id_owner,id_coef,COEF_NAME,COEF_VALUE,OSN_ZP,EKSP_MACH,MAT_RES,WORK_PERS,WORK_MACH)'#13
    + 'SELECT :id_estimate, :id_type_data, :id_owner, coef_id,COEF_NAME,COEF_VALUE,OSN_ZP,EKSP_MACH,MAT_RES,WORK_PERS,WORK_MACH'#13
    + 'FROM coef WHERE coef.coef_id=:coef_id';
  qrTemp.ParamByName('id_estimate').AsInteger := IdEstimate;
  qrTemp.ParamByName('id_owner').AsInteger := qrRates.FieldByName('owner_id').AsInteger;
  qrTemp.ParamByName('id_type_data').AsInteger := qrRatesTYPE_DATA.AsInteger;
  qrTemp.ParamByName('coef_id').AsInteger := coef_id;
  qrTemp.ExecSQL;
  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.AddDevice(const vEquipId: Integer);
// ���������� ������������ � �����
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddDevice(:IdEstimate, :IdDev);');
      ParamByName('IdEstimate').Value := IdEstimate;
      ParamByName('IdDev').Value := vEquipId;
      ExecSQL;
    end;

    OutputDataToTable(qrRates.RecordCount + 1);
  except
    on E: Exception do
      MessageBox(0, PChar('��� ���������� ������������ �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ���������� ��������� � �����
procedure TFormCalculationEstimate.AddMaterial(const vMatId: Integer);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddMaterial(:IdEstimate, :IdMat);');
      ParamByName('IdEstimate').Value := IdEstimate;
      ParamByName('IdMat').Value := vMatId;
      ExecSQL;
    end;

    OutputDataToTable(qrRates.RecordCount + 1);
  except
    on E: Exception do
      MessageBox(0, PChar('��� ���������� ��������� �������� ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ���������� ��������� � �����
procedure TFormCalculationEstimate.AddMechanizm(const vMechId: Integer);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddMechanizm(:IdEstimate, :IdMech, :Month, :Year);');
      ParamByName('IdEstimate').Value := IdEstimate;
      ParamByName('IdMech').Value := vMechId;
      ParamByName('Month').Value := MonthEstimate;
      ParamByName('Year').Value := YearEstimate;
      ExecSQL;
    end;

    OutputDataToTable(qrRates.RecordCount + 1);
  except
    on E: Exception do
      MessageBox(0, PChar('��� ���������� ��������� �������� ������:' + sLineBreak + sLineBreak + E.Message),
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

    if dbgrdDescription.Row = TMyDBGrid(dbgrdDescription).DataLink.ActiveRecord + 1 then
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
    if Column.Index in [9, 10] then
    begin
      Brush.Color := $00FBFEBC;
    end;

    if (Sender as TJvDBGrid).Row = TMyDBGrid(Sender).DataLink.ActiveRecord + 1 then
    begin
      Font.Style := Font.Style + [fsbold];
      // ��� ���� �������� ��� �������������� �������������� ����������
      if not Column.ReadOnly then
        Brush.Color := $00AFFEFC
    end;

    if gdFocused in State then // ������ � ������
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
    if Column.Index in [10, 11, 17, 18] then
    begin
      // �� ��������� ������� ������������ � ������� �������������� ���������
      // ������ �����
      if (Column.Index in [10, 11]) then
        if (qrMaterialFPRICE_NO_NDS.AsInteger > 0) then
          Brush.Color := $00DDDDDD
        else
          Brush.Color := $00FBFEBC;

      if (Column.Index in [17, 18]) then
        if (qrMaterialFPRICE_NO_NDS.AsInteger > 0) then
          Brush.Color := $00FBFEBC
        else
          Brush.Color := $00DDDDDD;
    end;

    // ��������� ������� ������ ��������
    if (Column.Index in [2, 5, 6, 7]) and (Column.Field.AsFloat = 0) then
    begin
      Brush.Color := $008080FF;
    end;

    if dbgrdMaterial.Row = TMyDBGrid(dbgrdMaterial).DataLink.ActiveRecord + 1 then
    begin
      Font.Style := Font.Style + [fsbold];
      // ��� ���� �������� ��� �������������� �������������� ����������
      if not Column.ReadOnly then
        Brush.Color := $00AFFEFC
    end;

    // ����������� ��������� �� ������� ���������
    if (qrMaterialFROM_RATE.AsInteger = 1) and not(qrRatesMID.AsInteger = qrMaterialID.AsInteger) then
    begin
      Font.Style := Font.Style + [fsStrikeOut];
      Brush.Color := $00DDDDDD
    end;

    // �������� ���������� �������� �� ������� ���������
    if (qrMaterialID_REPLACED.AsInteger > 0) and (qrMaterialFROM_RATE.AsInteger = 0) and
      (qrRatesMID.AsInteger = qrMaterialID.AsInteger) then
    begin
      Font.Style := Font.Style + [fsbold];
    end;

    // ��������� ����������� ��� ����������� ���������
    if (IdReplasedMat = qrMaterialID.AsInteger) or (IdReplasingMat = qrMaterialID_REPLACED.AsInteger) then
      Font.Style := Font.Style + [fsbold];

    // ������� �������� ��������� ��� ���������
    if CheckMatUnAccountingMatirials then
      Brush.Color := PS.BackgroundRows;

    // ��������� ����� �������� �������
    if qrMaterialTITLE.AsInteger > 0 then
    begin
      Brush.Color := clNavy;
      Font.Color := clWhite;
      Font.Style := Font.Style + [fsbold];
      if Column.Index = 1 then
        Str := Column.Field.AsString
      else
        Str := '';
    end
    else
      Str := Column.Field.AsString;

    if gdFocused in State then // ������ � ������
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

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

procedure TFormCalculationEstimate.dbgrdMechanizmDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with dbgrdMechanizm.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    // ��������� ���� ��� (��� �������)
    if Column.Index = 1 then
      Brush.Color := $00F0F0FF;

    // ��������� ����� ���������
    if Column.Index in [7, 8, 11, 12, 16, 17, 20, 21] then
    begin
      // �� ��������� ������� ������������ � ������� �������������� ���������
      // ������ �����
      if (Column.Index in [7, 8]) then
        if (qrMechanizmFPRICE_NO_NDS.AsInteger > 0) then
          Brush.Color := $00DDDDDD
        else
          Brush.Color := $00FBFEBC;

      if (Column.Index in [16, 17]) then
        if (qrMechanizmFPRICE_NO_NDS.AsInteger > 0) then
          Brush.Color := $00FBFEBC
        else
          Brush.Color := $00DDDDDD;

      if (Column.Index in [11, 12]) then
        if (qrMechanizmFZPPRICE_NO_NDS.AsInteger > 0) then
          Brush.Color := $00DDDDDD
        else
          Brush.Color := $00FBFEBC;

      if (Column.Index in [20, 21]) then
        if (qrMechanizmFZPPRICE_NO_NDS.AsInteger > 0) then
          Brush.Color := $00FBFEBC
        else
          Brush.Color := $00DDDDDD;
    end;

    // ��������� ������� ������ ��������
    if (Column.Index in [2, 5, 6]) and (Column.Field.AsFloat = 0) then
    begin
      Brush.Color := $008080FF;
    end;

    if dbgrdMechanizm.Row = TMyDBGrid(dbgrdMechanizm).DataLink.ActiveRecord + 1 then
    begin
      Font.Style := Font.Style + [fsbold];
      // ��� ���� �������� ��� �������������� �������������� ����������
      if not Column.ReadOnly then
        Brush.Color := $00AFFEFC
    end;

    // ����������� ��������� �� ������� ���������
    if (qrMechanizmFROM_RATE.AsInteger = 1) and not(qrRatesMEID.AsInteger > 0) then
    begin
      Font.Style := Font.Style + [fsStrikeOut];
      Brush.Color := $00DDDDDD
    end;

    if gdFocused in State then // ������ � ������
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

procedure TFormCalculationEstimate.dbgrdMechanizmExit(Sender: TObject);
begin
  if not Assigned(FormCalculationEstimate.ActiveControl) or
    (FormCalculationEstimate.ActiveControl.Name <> 'MemoRight') then
    SetMechNoEditMode;
end;

procedure TFormCalculationEstimate.dbgrdRates12DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  j: Integer;
  sdvig: string;
begin
  j := 2;
  with dbgrdRates.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;
    if gdFocused in State then // ������ � ������
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    if dbgrdRates.Row = TMyDBGrid(dbgrdRates).DataLink.ActiveRecord + 1 then
    begin
      Font.Style := Font.Style + [fsbold];
    end;

    // ��������� ����������� � ����������� ��������� �� �������� ���������
    // ��������� �� �������� ����� ��������� ��� �������
    if SpeedButtonMaterials.Down and qrMaterial.Active then
    begin
      if (qrRatesMID.AsInteger = qrMaterialID.AsInteger) and (qrRatesFROM_RATE.AsInteger = 1) then
        Font.Style := Font.Style + [fsbold];
    end;

    // ��������� ����������� �� �������� ���������
    if SpeedButtonMechanisms.Down and qrMechanizm.Active then
    begin
      if (qrRatesMEID.AsInteger = qrMechanizmID.AsInteger) and (qrRatesFROM_RATE.AsInteger = 1) then
        Font.Style := Font.Style + [fsbold];
    end;

    // ��������� ������ ��������� ���������� �������� � ���������� ��
    if CheckMatINRates then
    begin
      if CheckMatUnAccountingRates then Font.Color := clGray;
      if Column.Index = 1 then
        sdvig := Indent;
    end
    else
      sdvig := '';

    FillRect(Rect);

    TextOut(Rect.Left + j, Rect.Top + 2, sdvig + Column.Field.AsString);
  end;
end;

end.
