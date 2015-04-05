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
  JvDBGrid, JvDBUltimGrid, System.UITypes, System.Types, EditExpression;

type
  TSplitter = class(ExtCtrls.TSplitter)
  public
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
    btnDescription: TSpeedButton;
    btnMaterials: TSpeedButton;
    btnMechanisms: TSpeedButton;

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
    ModeData: TMenuItem;
    Normal: TMenuItem;
    Extended: TMenuItem;
    N22: TMenuItem;
    PopupMenuMaterials: TPopupMenu;
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
    btnEquipments: TSpeedButton;
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
    PMAddAdditionTransportationС310: TMenuItem;
    PMAddAdditionTransportationС311: TMenuItem;
    PMAddDump: TMenuItem;
    PMAddAdditionHeatingE18: TMenuItem;
    PMAddAdditionHeatingE20: TMenuItem;
    PopupMenuRatesAdd352: TMenuItem;
    PMMatFromRates: TMenuItem;
    PopupMenuMechanizms: TPopupMenu;
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
    EditCoefOrders: TEdit;
    LabelCategory: TLabel;
    EditCategory: TEdit;
    Button4: TButton;
    qrDescription: TFDQuery;
    qrTemp: TFDQuery;
    qrTemp1: TFDQuery;
    frSummaryCalculations: TfrCalculationEstimateSummaryCalculations;
    frSSR: TfrCalculationEstimateSSR;
    dsDescription: TDataSource;
    qrMechanizm: TFDQuery;
    dsMechanizm: TDataSource;
    qrDescriptionwork: TStringField;
    qrMechanizmID: TFDAutoIncField;
    qrMechanizmID_CARD_RATE: TIntegerField;
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
    qrMaterialMAT_PROC_ZAC: TIntegerField;
    qrMaterialMAT_PROC_PODR: TIntegerField;
    qrMaterialTRANSP_PROC_ZAC: TIntegerField;
    qrMaterialTRANSP_PROC_PODR: TIntegerField;
    qrMaterialNUM: TIntegerField;
    qrMaterialSCROLL: TIntegerField;
    qrMaterialTITLE: TIntegerField;
    qrMaterialPROC_TRANSP: TFloatField;
    N10: TMenuItem;
    qrMaterialMAT_KOEF: TFloatField;
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
    dbmmoCAPTION: TDBMemo;
    qrDump: TFDQuery;
    dsDump: TDataSource;
    btnDump: TSpeedButton;
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
    btnTransp: TSpeedButton;
    btnStartup: TSpeedButton;
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
    tmRate: TTimer;
    qrMaterialCONS_REPLASED: TByteField;
    PMMatDelete: TMenuItem;
    qrMaterialCOAST_NO_NDS: TFloatField;
    qrMaterialCOAST_NDS: TFloatField;
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
    qrTranspKOEF: TFloatField;
    qrRatesExINCITERATOR: TIntegerField;
    qrRatesExITERATOR: TIntegerField;
    qrRatesExOBJ_CODE: TStringField;
    qrRatesExOBJ_NAME: TStringField;
    qrRatesExOBJ_COUNT: TFloatField;
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
    qrRatesExSORT_ID: TVarBytesField;
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

    // Норма расхода по механизму
    function GetNormMechanizm(const vIdNormativ, vIdMechanizm: string): Double;

    // Цена по механизму
    function GetPriceMechanizm(const vIdNormativ, vIdMechanizm: string): Currency;

    // Зарплата машиниста (ЗП маш.)
    function GetSalaryMachinist(const vIdMechanizm: Integer): Currency;

    // Цена использования (аренды, работы) механизма
    function GetCoastMechanizm(const vIdMechanizm: Integer): Currency;

    procedure EstimateBasicDataClick(Sender: TObject);
    procedure LabelObjectClick(Sender: TObject);
    procedure LabelEstimateClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure LabelMouseEnter(Sender: TObject);
    procedure LabelMouseLeave(Sender: TObject);
    procedure PanelObjectResize(Sender: TObject);
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
    procedure PopupMenuMaterialsPopup(Sender: TObject);

    procedure PMCoefOrdersClick(Sender: TObject);
    procedure PopupMenuTableLeftPopup(Sender: TObject);
    // Удаление вынесенного из расценки материала
    procedure GetStateCoefOrdersInEstimate;
    procedure GetStateCoefOrdersInRate;
    // Получаем флаг состояния (применять или не применять) коэффициента по приказам
    procedure PopupMenuCoefOrdersClick(Sender: TObject);
    procedure PopupMenuCoefPopup(Sender: TObject);
    procedure Button4Click(Sender: TObject);

    procedure OutputDataToTable; // Заполнение таблицы расценок

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
    procedure PopupMenuMechanizmsPopup(Sender: TObject);
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
    procedure qrRatesExAfterPost(DataSet: TDataSet);
    procedure PMMatDeleteClick(Sender: TObject);
    procedure qrRatesWORK_IDChange(Sender: TField);
    procedure btn1Click(Sender: TObject);
    procedure ReplacementClick(Sender: TObject);
    procedure nSelectWinterPriseClick(Sender: TObject);
    procedure nWinterPriseSetDefaultClick(Sender: TObject);
    procedure PopupMenuRatesAdd352Click(Sender: TObject);
    procedure PMMechDeleteClick(Sender: TObject);
    procedure qrRatesExAfterOpen(DataSet: TDataSet);
  private const
    CaptionButton = 'Расчёт сметы';

  const
    HintButton = 'Окно расчёта сметы';
  private
    ActReadOnly: Boolean;
    RowCoefDefault: Boolean;

    IdObject: Integer;
    NDSEstimate: Boolean; // Расчет  с НДС или без

    MonthEstimate: Integer;
    YearEstimate: Integer;

    VisibleRightTables: String; // Настройка отобаржения нужной таблицы справа

    WCWinterPrice: Integer;
    WCSalaryWinterPrice: Integer;

    CountFromRate: Double;

    // Флаги пересчета по правым таблицам, исключает зацикливание в обработчиках ОnChange;
    ReCalcMech, ReCalcMat, ReCalcDev: Boolean;
    // ID замененного материала который надо подсветить
    IdReplasedMat: Integer;
    // ID заменяющего материала который надо подсветить
    IdReplasingMat: Integer;

    // ID замененного механизма который надо подсветить
    IdReplasedMech: Integer;
    // ID заменяющего механизма который надо подсветить
    IdReplasingMech: Integer;

    IsUnAcc: Boolean;

    // Последняя таблица в которой был фокус, используется для отрисовки
    LastEntegGrd: TJvDBGrid;

    IdAct: Integer;
    // ID отображаемой сметы
    IdEstimate: Integer;

    // пересчитывает все относящееся к строке в таблице расценок
    procedure ReCalcRowRates;

    // Обновляет кол-во у заменяющих материалов в расценке
    procedure GridRatesUpdateCount;
    // Обновляет кол-во по одной строке
    procedure UpdateMatCountInGridRate(AMId: Integer; AMCount: Real);

    // Изменяет внешний вид таблиц в зависимости от НДС
    procedure ChangeGrigNDSStyle(aNDS: Boolean);

    // проверяет что материал внутри расценки (неучтеный или заменяющий)
    function CheckMatINRates: Boolean;

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
  public
    Act: Boolean;

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

function NDSToNoNDS(AValue: Int64; aNDS: Integer): Int64;
function NoNDSToNDS(AValue: Int64; aNDS: Integer): Int64;

implementation

uses Main, DataModule, Columns, SignatureSSR, Waiting,
  SummaryCalculationSettings, DataTransfer,
  BasicData, ObjectsAndEstimates, PercentClientContractor, Transportation,
  CalculationDump, SaveEstimate,
  AdditionData, CardMaterial, CardDataEstimate,
  ListCollections, CoefficientOrders, KC6,
  CardAct, Tools, Coef, WinterPrice,
  ReplacementMatAndMech;

{$R *.dfm}

function NDSToNoNDS(AValue: Int64; aNDS: Integer): Int64;
begin
  Result := Round(AValue / (1.000000 + 0.010000 * aNDS));
end;

function NoNDSToNDS(AValue: Int64; aNDS: Integer): Int64;
begin
  Result := Round(AValue * (1.000000 + 0.010000 * aNDS));
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

procedure TFormCalculationEstimate.FormCreate(Sender: TObject);
begin
  FormMain.PanelCover.Visible := True; // Показываем панель на главной форме

  // Настройка размеров и положения формы
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10;
  Left := 10;

  WindowState := wsMaximized;
  Caption := CaptionButton + ' - Разрешено редактирование документа';
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
  PanelSummaryCalculations.Visible := False;
  PanelSSR.Visible := False;

  PanelLocalEstimate.Align := alClient;
  PanelSummaryCalculations.Align := alClient;
  PanelSSR.Align := alClient;

  // -----------------------------------------

  // НАСТРОЙКА ВИДИМОСТИ НИЖНИХ ПАНЕЛЕЙ С КНОПКАМИ

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

  ConfirmCloseForm := True;

  RowCoefDefault := True;
  // Высота панели с нижней таблицей
  PanelTableBottom.Height := 110 + PanelBottom.Height;

  // Установка стиля DBGrid таблицы
  LoadDBGridSettings(dbgrdMaterial);
  LoadDBGridSettings(dbgrdMechanizm);
  LoadDBGridSettings(dbgrdDevices);
  LoadDBGridSettings(dbgrdDescription);
  LoadDBGridSettings(dbgrdDump);
  LoadDBGridSettings(dbgrdTransp);
  LoadDBGridSettings(dbgrdStartup);
  LoadDBGridSettings(dbgrdCalculations);
  LoadDBGridSettings(grRatesEx);

  if not Act then
    FormMain.CreateButtonOpenWindow(CaptionButton, HintButton, Self, 1);
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
  FormMain.SelectButtonActiveWindow(CaptionButton);
end;

procedure TFormCalculationEstimate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  if (not Assigned(FormObjectsAndEstimates)) then
    FormObjectsAndEstimates := TFormObjectsAndEstimates.Create(FormMain);
end;

procedure TFormCalculationEstimate.FormDestroy(Sender: TObject);
begin
  FormCalculationEstimate := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButton);
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
            res := ShowEditExpression;
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
  if SpeedButtonLocalEstimate.Tag = 0 then
  begin
    SpeedButtonLocalEstimate.Down := True;

    SpeedButtonLocalEstimate.Tag := 1;
    SpeedButtonSummaryCalculation.Tag := 0;
    SpeedButtonSSR.Tag := 0;

    // Настройка видимости панелей
    PanelLocalEstimate.Visible := True;
    PanelSummaryCalculations.Visible := False;
    PanelSSR.Visible := False;

    // НАСТРОЙКА ВИДИМОСТИ НИЖНИХ ПАНЕЛЕЙ С КНОПКАМИ

    PanelButtonsLocalEstimate.Align := alNone;
    PanelButtonsSummaryCalculations.Align := alNone;
    PanelButtonsSSR.Align := alNone;

    PanelButtonsLocalEstimate.Visible := True;
    PanelButtonsSummaryCalculations.Visible := False;
    PanelButtonsSSR.Visible := False;

    PanelButtonsLocalEstimate.Align := alClient;

    // Делаем кнопки верхнего правого меню активными
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

    // Настройка видимости панелей
    PanelLocalEstimate.Visible := False;
    PanelSummaryCalculations.Visible := True;
    PanelSSR.Visible := False;

    // Инициализация заполнения фрейма данными
    frSummaryCalculations.LoadData(IdObject);

    // -----------------------------------------

    // НАСТРОЙКА ВИДИМОСТИ НИЖНИХ ПАНЕЛЕЙ С КНОПКАМИ

    PanelButtonsLocalEstimate.Align := alNone;
    PanelButtonsSummaryCalculations.Align := alNone;
    PanelButtonsSSR.Align := alNone;

    PanelButtonsLocalEstimate.Visible := False;
    PanelButtonsSummaryCalculations.Visible := True;
    PanelButtonsSSR.Visible := False;

    PanelButtonsSummaryCalculations.Align := alClient;

    // -----------------------------------------

    // Делаем кнопки верхнего правого меню неактивными
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
  if SpeedButtonSSR.Tag = 0 then
  begin
    SpeedButtonSSR.Down := True;

    SpeedButtonLocalEstimate.Tag := 0;
    SpeedButtonSummaryCalculation.Tag := 0;
    SpeedButtonSSR.Tag := 1;

    // Настройка видимости панелей
    PanelLocalEstimate.Visible := False;
    PanelSummaryCalculations.Visible := False;
    PanelSSR.Visible := True;

    // -----------------------------------------

    // НАСТРОЙКА ВИДИМОСТИ НИЖНИХ ПАНЕЛЕЙ С КНОПКАМИ

    PanelButtonsLocalEstimate.Align := alNone;
    PanelButtonsSummaryCalculations.Align := alNone;
    PanelButtonsSSR.Align := alNone;

    PanelButtonsLocalEstimate.Visible := False;
    PanelButtonsSummaryCalculations.Visible := False;
    PanelButtonsSSR.Visible := True;

    // Инициализация заполнения фрейма данными
    frSSR.LoadData(IdObject);

    PanelButtonsSSR.Align := alClient;

    // -----------------------------------------

    // Делаем кнопки верхнего правого меню неактивными
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

procedure TFormCalculationEstimate.btn1Click(Sender: TObject);
begin
  qrTemp.SQL.Text := 'CALL UpdateSmetaCosts(:IDESTIMATE);';
  qrTemp.ParamByName('IDESTIMATE').AsInteger := IdEstimate;
  qrTemp.ExecSQL;
  qrRatesExAfterScroll(qrRatesEx);
  CloseOpen(qrCalculations);
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
      Caption := 'Расчёты запрещены';
      FormCalculationEstimate.Caption := CaptionButton + ' - Запрещено редактирование документа';
    end
    else
    begin
      Tag := 1;
      Color := clLime;
      Caption := 'Расчёты разрешены';
      FormCalculationEstimate.Caption := CaptionButton + ' - Разрешено редактирование документа';
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

  OffsetCenter := 15; // От серединной линии до правых и левых кнопок

  // -----------------------------------------

  WidthButton := ((Sender as TPanel).Width div 2 - 18 - OffsetCenter) div 3;
  // 18 = 6 * 3 (расстояния: до первой кнопки, между 1 и 2, 2 и 3)

  SpeedButtonLocalEstimate.Left := 6;
  SpeedButtonLocalEstimate.Width := WidthButton;

  SpeedButtonSummaryCalculation.Left := SpeedButtonLocalEstimate.Left + SpeedButtonLocalEstimate.Width + 6;
  SpeedButtonSummaryCalculation.Width := WidthButton;

  SpeedButtonSSR.Left := SpeedButtonSummaryCalculation.Left + SpeedButtonSummaryCalculation.Width + 6;
  SpeedButtonSSR.Width := WidthButton;

  // -----------------------------------------

  WidthButton := 80;
  // ((Sender as TPanel).Width div 2 - 30 - OffsetCenter - SpeedButtonModeTables.Width) div 4;
  // 24 = 6 * 5 (расстояния: между 4 и 5, 5 и 6, 6 и 7, 7 и 8, и до конца формы)

  btnMaterials.Left := BevelTopMenu.Left + OffsetCenter;
  btnMaterials.Width := WidthButton;

  btnMechanisms.Left := btnMaterials.Left + btnMaterials.Width + 3;
  btnMechanisms.Width := WidthButton;

  btnEquipments.Left := btnMechanisms.Left + btnMaterials.Width + 3;
  btnEquipments.Width := WidthButton;

  btnDescription.Left := btnEquipments.Left + btnEquipments.Width + 3;
  btnDescription.Width := WidthButton;

  btnDump.Left := btnDescription.Left + btnDescription.Width + 3;
  btnDump.Width := WidthButton;

  btnTransp.Left := btnDump.Left + btnDump.Width + 3;
  btnTransp.Width := WidthButton;

  btnStartup.Left := btnTransp.Left + btnTransp.Width + 3;
  btnStartup.Width := WidthButton;

  // Не используется пока
  SpeedButtonModeTables.Left := btnStartup.Left + btnStartup.Width + 3;

  MemoRight.Height := dbmmoCAPTION.Height;
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
end;

procedure TFormCalculationEstimate.Button3Click(Sender: TObject);
begin
  FormSummaryCalculationSettings.ShowModal;
end;

procedure TFormCalculationEstimate.Button4Click(Sender: TObject);
begin
  if MessageBox(0, PChar('Произвести выборку данных из сметы?'), 'Расчёт сметы',
    MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrYes then
    FormKC6.MyShow(IdObject);
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
  else if (NumberNormativ > 'Е29-93-1') and (NumberNormativ < 'Е29-277-1') then
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
      NumberNormativ := 'C' + NumberNormativ;

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
      sLineBreak + 'которого не существует!'), CaptionForm, MB_ICONWARNING + MB_OK + mb_TaskModal);
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

  if not ReCalcDev then
  begin
    if btnEquipments.Down then
      MemoRight.Text := qrDevicesDEVICE_NAME.AsString;
  end;
end;

procedure TFormCalculationEstimate.qrDevicesBeforeScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not ReCalcDev then
  begin
    // закрытие открытой на редактирование строки
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

  if not ReCalcDev then
  begin
    ReCalcDev := True;
    // Пересчет по строке оборудования
    try
      // Индивидуальное поведение для конкретных полей
      if (Sender.FieldName = 'PROC_PODR') or (Sender.FieldName = 'PROC_ZAC') or
        (Sender.FieldName = 'TRANSP_PROC_PODR') or (Sender.FieldName = 'TRANSP_PROC_ZAC') then
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
        qrDevicesFCOAST_NO_NDS.AsInteger := NDSToNoNDS(qrDevicesFCOAST_NDS.AsInteger, qrDevicesNDS.AsInteger);
        qrDevicesDEVICE_TRANSP_NO_NDS.AsInteger := NDSToNoNDS(qrDevicesDEVICE_TRANSP_NDS.AsInteger,
          qrDevicesNDS.AsInteger);
      end
      else
      begin
        qrDevicesFCOAST_NDS.AsInteger := NoNDSToNDS(qrDevicesFCOAST_NO_NDS.AsInteger, qrDevicesNDS.AsInteger);
        qrDevicesDEVICE_TRANSP_NDS.AsLargeInt := NoNDSToNDS(qrDevicesDEVICE_TRANSP_NO_NDS.AsLargeInt,
          qrDevicesNDS.AsInteger);
      end;
      // После изменения ячейки строка фиксируется
      qrDevices.Post;

      // Пересчет по строке оборуд
      ReCalcRowDev;
    finally
      ReCalcDev := False;
    end;
  end;
end;

// Проверят можно ли редактировать данную строку
function TFormCalculationEstimate.CheckMechReadOnly: Boolean;
begin
  Result := False;
  //Вынесеный механизм в расценке или замененные механизмы
  if ((qrMechanizmFROM_RATE.AsInteger = 1) and not(qrRatesExID_TYPE_DATA.AsInteger = 1))
    or (qrMechanizmREPLACED.AsInteger = 1) or (qrMechanizmTITLE.AsInteger > 0) then
    Result := True;
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
  if ((qrMaterialFROM_RATE.AsInteger = 1) and not(qrRatesExID_TYPE_DATA.AsInteger = 1))
    or (qrMaterialREPLACED.AsInteger = 1) or (qrMaterialTITLE.AsInteger > 0) then
    Result := True;
end;

// Устанавливает режим редактирования
procedure TFormCalculationEstimate.SetMatReadOnly(AValue: Boolean);
begin
  dbgrdMaterial.ReadOnly := AValue;
end;

// включение режима расширенного редактирования оборудования
procedure TFormCalculationEstimate.SetDevEditMode;
begin
  dbgrdDevices.Columns[4].ReadOnly := False; // НДС
  MemoRight.Color := $00AFFEFC;
  MemoRight.ReadOnly := False;
  MemoRight.Tag := 4; // Type_Data
  qrDevices.Tag := 1;
end;

procedure TFormCalculationEstimate.SetDevNoEditMode;
begin
  if qrDevices.Tag = 1 then
  begin
    dbgrdDevices.Columns[4].ReadOnly := True; // НДС
    MemoRight.Color := clWindow;
    MemoRight.ReadOnly := True;
    MemoRight.Tag := 0;
    qrMaterial.Tag := 0;
  end;
end;

// включение режима расширенного редактирования материалов
procedure TFormCalculationEstimate.SetMatEditMode;
begin
  if CheckMatReadOnly then
    Exit;
  dbgrdMaterial.Columns[2].ReadOnly := False; // Норма
  dbgrdMaterial.Columns[4].ReadOnly := False; // Кол-во
  dbgrdMaterial.Columns[5].ReadOnly := False; // % транспорта
  dbgrdMaterial.Columns[6].ReadOnly := False; // Расценка
  dbgrdMaterial.Columns[7].ReadOnly := False; // Расценка
  dbgrdMaterial.Columns[12].ReadOnly := False; // НДС
  MemoRight.Color := $00AFFEFC;
  MemoRight.ReadOnly := False;
  MemoRight.Tag := 2; // Type_Data
  qrMaterial.Tag := 1;
end;

// отключение режима расширенного редактирования материалов
procedure TFormCalculationEstimate.SetMatNoEditMode;
begin
  if qrMaterial.Tag = 1 then
  begin
    dbgrdMaterial.Columns[2].ReadOnly := True; // Норма
    dbgrdMaterial.Columns[4].ReadOnly := True; // Кол-во
    dbgrdMaterial.Columns[5].ReadOnly := True; // % транспорта
    dbgrdMaterial.Columns[6].ReadOnly := True; // Расценка
    dbgrdMaterial.Columns[7].ReadOnly := True; // Расценка
    dbgrdMaterial.Columns[12].ReadOnly := True; // НДС
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
  // На всякий случай, что-бы избежать глюков
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
    grRatesEx.Repaint;

    flag := False;

    if ((qrMaterialID_REPLACED.AsInteger = 0) and (IdReplasedMat > 0)) or
      (IsUnAcc and (not CheckMatUnAccountingMatirials)) then
      flag := True;

    IdReplasedMat := qrMaterialID_REPLACED.AsInteger;
    IdReplasingMat := qrMaterialID.AsInteger;
    IsUnAcc := CheckMatUnAccountingMatirials;

    if btnMaterials.Down then
      MemoRight.Text := qrMaterialMAT_NAME.AsString;

    // Для красоты отрисовки
    if CheckMatUnAccountingMatirials or (IdReplasedMat > 0) or flag then
      dbgrdMaterial.Repaint;
  end;
end;

procedure TFormCalculationEstimate.qrMaterialBeforeScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not ReCalcMat then
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
    Sender.AsInteger := 0;
    Exit;
  end;

  if not ReCalcMat then
  begin
    ReCalcMat := True;
    // Пересчет по строке материала
    try
      CField := Sender.FieldName;
      CValue := Sender.Value;
      CType := 0;

      if (CField = 'MAT_COUNT') then
        CType := 1;

      // Индивидуальное поведение для конкретных полей
      if (Sender.FieldName = 'MAT_PROC_PODR') or (Sender.FieldName = 'MAT_PROC_ZAC') or
        (Sender.FieldName = 'TRANSP_PROC_PODR') or (Sender.FieldName = 'TRANSP_PROC_ZAC') then
      begin
        if Sender.AsInteger > 100 then
          Sender.AsInteger := 100;

        if Sender.AsInteger < 0 then
          Sender.AsInteger := 0;

        if Sender.FieldName = 'MAT_PROC_PODR' then
          qrMaterialMAT_PROC_ZAC.AsInteger := 100 - qrMaterialMAT_PROC_PODR.AsInteger;
        if Sender.FieldName = 'MAT_PROC_ZAC' then
          qrMaterialMAT_PROC_PODR.AsInteger := 100 - qrMaterialMAT_PROC_ZAC.AsInteger;
        if Sender.FieldName = 'TRANSP_PROC_PODR' then
          qrMaterialTRANSP_PROC_ZAC.AsInteger := 100 - qrMaterialTRANSP_PROC_PODR.AsInteger;
        if Sender.FieldName = 'TRANSP_PROC_ZAC' then
          qrMaterialTRANSP_PROC_PODR.AsInteger := 100 - qrMaterialTRANSP_PROC_ZAC.AsInteger;
      end;
      // пересчитывается всегда, что-бы не писать кучу условий когда это актуально
      if NDSEstimate then
      begin
        qrMaterialCOAST_NO_NDS.AsLargeInt := NDSToNoNDS(qrMaterialCOAST_NDS.AsLargeInt,
          qrMaterialNDS.AsInteger);
        qrMaterialFCOAST_NO_NDS.AsLargeInt := NDSToNoNDS(qrMaterialFCOAST_NDS.AsLargeInt,
          qrMaterialNDS.AsInteger);
        qrMaterialFTRANSP_NO_NDS.AsLargeInt := NDSToNoNDS(qrMaterialFTRANSP_NDS.AsLargeInt,
          qrMaterialNDS.AsInteger);
      end
      else
      begin
        qrMaterialCOAST_NDS.AsLargeInt := NoNDSToNDS(qrMaterialCOAST_NO_NDS.AsLargeInt,
          qrMaterialNDS.AsInteger);
        qrMaterialFCOAST_NDS.AsLargeInt := NoNDSToNDS(qrMaterialFCOAST_NO_NDS.AsLargeInt,
          qrMaterialNDS.AsInteger);
        qrMaterialFTRANSP_NDS.AsLargeInt := NoNDSToNDS(qrMaterialFTRANSP_NO_NDS.AsLargeInt,
          qrMaterialNDS.AsInteger);
      end;
      // После изменения ячейки фиксируется
      qrMaterial.Post;

      // Обновление в базе (так как датасет не связан с базой напрямую)
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
        ParamByName('COAST_NO_NDS').Value := qrMaterialCOAST_NO_NDS.Value;
        ParamByName('COAST_NDS').Value := qrMaterialCOAST_NDS.Value;
        ParamByName('FCOAST_NO_NDS').Value := qrMaterialFCOAST_NO_NDS.Value;
        ParamByName('FCOAST_NDS').Value := qrMaterialFCOAST_NDS.Value;
        ParamByName('FTRANSP_NO_NDS').Value := qrMaterialFTRANSP_NO_NDS.Value;
        ParamByName('FTRANSP_NDS').Value := qrMaterialFTRANSP_NDS.Value;
        ParamByName('MAT_PROC_ZAC').Value := qrMaterialMAT_PROC_ZAC.Value;
        ParamByName('MAT_PROC_PODR').Value := qrMaterialMAT_PROC_PODR.Value;
        ParamByName('TRANSP_PROC_ZAC').Value := qrMaterialTRANSP_PROC_ZAC.Value;
        ParamByName('TRANSP_PROC_PODR').Value := qrMaterialTRANSP_PROC_PODR.Value;
        ParamByName('AA' + CField).Value := CValue;
        ParamByName('id').Value := qrMaterialID.Value;
        ExecSQL;
      end;

      // Пересчет по строке материала
      ReCalcRowMat(CType);
    finally
      ReCalcMat := False;
    end;
  end;
end;

procedure TFormCalculationEstimate.qrMechanizmAfterScroll(DataSet: TDataSet);
var
  flag: Boolean;
begin
  if not CheckQrActiveEmpty(DataSet) then
    Exit;

  if not ReCalcMech then
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

    if (qrMechanizmID_REPLACED.AsInteger = 0) and (IdReplasedMech > 0) then
      flag := True;

    IdReplasedMech := qrMechanizmID_REPLACED.AsInteger;
    IdReplasingMech := qrMechanizmID.AsInteger;

    if btnMechanisms.Down then
      MemoRight.Text := qrMechanizmMECH_NAME.AsString;

    // Для красоты отрисовки
    if (IdReplasedMech > 0) or flag then
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

  if not ReCalcMech then
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

  if not ReCalcMech then
  begin
    ReCalcMech := True;
    // Пересчет по строке механизма
    try
      CField := Sender.FieldName;
      CValue := Sender.Value;
      CType := 0;

      if (Sender.FieldName = 'MECH_COUNT') then
        CType := 1;

      // Индивидуальное поведение для конкретных полей
      if (Sender.FieldName = 'PROC_PODR') or (Sender.FieldName = 'PROC_ZAC') then
      begin
        if Sender.AsInteger > 100 then
          Sender.AsInteger := 100;
        if Sender.AsInteger < 0 then
          Sender.AsInteger := 0;
        if (Sender.FieldName = 'PROC_PODR') then
          qrMechanizmPROC_ZAC.AsInteger := 100 - qrMechanizmPROC_PODR.AsInteger;
        if (Sender.FieldName = 'PROC_ZAC') then
          qrMechanizmPROC_PODR.AsInteger := 100 - qrMechanizmPROC_ZAC.AsInteger;
      end;

      // пересчитывается всегда, что-бы не писать кучу условий когда это актуально
      if NDSEstimate then
      begin
        qrMechanizmCOAST_NO_NDS.AsLargeInt := NDSToNoNDS(qrMechanizmCOAST_NDS.AsLargeInt,
          qrMechanizmNDS.AsInteger);
        qrMechanizmFCOAST_NO_NDS.AsLargeInt := NDSToNoNDS(qrMechanizmFCOAST_NDS.AsLargeInt,
          qrMechanizmNDS.AsInteger);
        qrMechanizmZP_MACH_NO_NDS.AsLargeInt := NDSToNoNDS(qrMechanizmZP_MACH_NDS.AsLargeInt,
          qrMechanizmNDS.AsInteger);
        qrMechanizmFZP_MACH_NO_NDS.AsLargeInt := NDSToNoNDS(qrMechanizmFZP_MACH_NDS.AsLargeInt,
          qrMechanizmNDS.AsInteger);
      end
      else
      begin
        qrMechanizmCOAST_NDS.AsLargeInt := NoNDSToNDS(qrMechanizmCOAST_NO_NDS.AsLargeInt,
          qrMechanizmNDS.AsInteger);
        qrMechanizmFCOAST_NDS.AsLargeInt := NoNDSToNDS(qrMechanizmFCOAST_NO_NDS.AsLargeInt,
          qrMechanizmNDS.AsInteger);
        qrMechanizmZP_MACH_NDS.AsLargeInt := NoNDSToNDS(qrMechanizmZP_MACH_NO_NDS.AsLargeInt,
          qrMechanizmNDS.AsInteger);
        qrMechanizmFZP_MACH_NDS.AsLargeInt := NoNDSToNDS(qrMechanizmFZP_MACH_NO_NDS.AsLargeInt,
          qrMechanizmNDS.AsInteger);
      end;

      // После изменения ячейки строка фиксируется
      qrMechanizm.Post;

      // Обновление в базе (так как датасет не связан с базой напрямую)
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
        ParamByName('COAST_NO_NDS').Value := qrMechanizmCOAST_NO_NDS.Value;
        ParamByName('COAST_NDS').Value := qrMechanizmCOAST_NDS.Value;
        ParamByName('FCOAST_NO_NDS').Value := qrMechanizmFCOAST_NO_NDS.Value;
        ParamByName('FCOAST_NDS').Value := qrMechanizmFCOAST_NDS.Value;
        ParamByName('ZP_MACH_NO_NDS').Value := qrMechanizmZP_MACH_NO_NDS.Value;
        ParamByName('ZP_MACH_NDS').Value := qrMechanizmZP_MACH_NDS.Value;
        ParamByName('FZP_MACH_NO_NDS').Value := qrMechanizmFZP_MACH_NO_NDS.Value;
        ParamByName('FZP_MACH_NDS').Value := qrMechanizmFZP_MACH_NDS.Value;
        ParamByName('PROC_ZAC').Value := qrMechanizmPROC_ZAC.Value;
        ParamByName('PROC_PODR').Value := qrMechanizmPROC_PODR.Value;
        ParamByName('AA' + CField).Value := CValue;
        ParamByName('id').Value := qrMechanizmID.Value;
        ExecSQL;
      end;

      // Пересчет по строке механизма
      ReCalcRowMech(CType);
    finally
      ReCalcMech := False;
    end;
  end;
end;

procedure TFormCalculationEstimate.MemoRightChange(Sender: TObject);
begin
  if not MemoRight.ReadOnly then
  begin
    // Редактирует название механизма, материала....
    // оочень много лишних sql
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

// Пересчитывает данные по строке в таблице механизмов
procedure TFormCalculationEstimate.ReCalcRowMech(ACType: byte);
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'CALL CalcMech(:id, :getdata, :ctype);';
  qrTemp.ParamByName('id').Value := qrMechanizmID.AsInteger;
  qrTemp.ParamByName('getdata').Value := 1;
  qrTemp.ParamByName('ctype').Value := ACType;
  qrTemp.Active := True;
  if not qrTemp.IsEmpty then
  begin
    qrMechanizm.Edit;
    qrMechanizmMECH_NORMA.AsFloat := qrTemp.FieldByName('MECH_NORMA').AsFloat;
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
  qrTemp.Active := False;
  CloseOpen(qrCalculations);
end;

// Пересчет одного материала
procedure TFormCalculationEstimate.ReCalcRowMat(ACType: byte);
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'CALL CalcMat(:id, :getdata, :ctype);';
  qrTemp.ParamByName('id').Value := qrMaterialID.AsInteger;
  qrTemp.ParamByName('getdata').Value := 1;
  qrTemp.ParamByName('ctype').Value := ACType;
  qrTemp.Active := True;
  if not qrTemp.IsEmpty then
  begin
    qrMaterial.Edit;
    qrMaterialMAT_NORMA.AsFloat := qrTemp.FieldByName('MAT_NORMA').AsFloat;
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
  qrTemp.Active := False;

  if qrMaterialID_REPLACED.AsInteger > 0 then
    UpdateMatCountInGridRate(qrMaterialID.AsInteger, qrMaterialMAT_COUNT.AsFloat);

  CloseOpen(qrCalculations);
end;

// Пересчет одного оборудование
procedure TFormCalculationEstimate.ReCalcRowDev;
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'CALL CalcDevice(:id, :getdata);';
  qrTemp.ParamByName('id').Value := qrDevicesID.AsInteger;
  qrTemp.ParamByName('getdata').Value := 1;
  qrTemp.Active := True;
  if not qrTemp.IsEmpty then
  begin
    qrDevices.Edit;
    qrDevicesFPRICE_NO_NDS.AsLargeInt := qrTemp.FieldByName('FPRICE_NO_NDS').AsLargeInt;
    qrDevicesFPRICE_NDS.AsLargeInt := qrTemp.FieldByName('FPRICE_NDS').AsLargeInt;
    qrDevicesDEVICE_SUM_NO_NDS.AsLargeInt := qrTemp.FieldByName('DEVICE_SUM_NO_NDS').AsLargeInt;
    qrDevicesDEVICE_SUM_NDS.AsLargeInt := qrTemp.FieldByName('DEVICE_SUM_NDS').AsLargeInt;
    qrDevices.Post;
  end;
  qrTemp.Active := False;
  CloseOpen(qrCalculations);
end;

function TFormCalculationEstimate.CheckMatINRates: Boolean;
begin
  Result :=  (qrRatesExID_RATE.AsInteger > 0) and
    (qrRatesExID_TYPE_DATA.AsInteger = 2);
end;

// проверка что материал неучтеный в таблице материалов
function TFormCalculationEstimate.CheckMatUnAccountingMatirials: Boolean;
begin
  Result := qrMaterialCONSIDERED.AsInteger = 0;
end;

procedure TFormCalculationEstimate.qrRatesExAfterPost(DataSet: TDataSet);
begin
  qrRatesExOBJ_COUNT.ReadOnly := False;
end;

// Для того что-бы скрол по таблице был быстрым обработка скрола происходит с задержкой
procedure TFormCalculationEstimate.qrRatesExAfterScroll(DataSet: TDataSet);
begin
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

procedure TFormCalculationEstimate.qrRatesExCODEChange(Sender: TField);
var
  NewCode: string;
  NewID: Integer;
begin
  NewCode := AnsiUpperCase(qrRatesExOBJ_CODE.AsString);
  grRatesEx.EditorMode := False;
  NewID := 0;

  // Замена литинских на кирилические
  if (NewCode[1] = 'Е') or (NewCode[1] = 'E') or (NewCode[1] = 'T') or (NewCode[1] = 'Ц') or (NewCode[1] = 'W')
  then // E кирилическая и латинская
  begin
    if (NewCode[1] = 'E') or (NewCode[1] = 'T') then
      NewCode[1] := 'Е';
    if NewCode[1] = 'W' then
      NewCode[1] := 'Ц';

    if NewCode[1] = 'W' then
      NewCode[1] := 'Ц';
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
      MessageBox(0, 'Расценка с указанным кодом не найдена!', CaptionForm,
        MB_ICONINFORMATION + MB_OK + mb_TaskModal);
      Exit;
    end;

    AddRate(NewID);
    grRatesEx.EditorMode := True;
    Exit;
  end;

  if (NewCode[1] = 'С') or (NewCode[1] = 'C') then // C кирилическая и латинская
  begin
    if NewCode[1] = 'C' then
      NewCode[1] := 'С';

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
      MessageBox(0, 'Материал с указанным кодом не найден!', CaptionForm,
        MB_ICONINFORMATION + MB_OK + mb_TaskModal);
      Exit;
    end;

    AddMaterial(NewID);
    grRatesEx.EditorMode := True;
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
      NewID := qrTemp.Fields[0].AsInteger;
    qrTemp.Active := False;
    if NewID = 0 then
    begin
      MessageBox(0, 'Механизм с указанным кодом не найден!', CaptionForm,
        MB_ICONINFORMATION + MB_OK + mb_TaskModal);
      Exit;
    end;

    AddMechanizm(NewID);
    grRatesEx.EditorMode := True;
    Exit;
  end;

  if CharInSet(NewCode[1], ['0' .. '9']) then
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
      MessageBox(0, 'Оборудование с указанным кодом не найден!', CaptionForm,
        MB_ICONINFORMATION + MB_OK + mb_TaskModal);
      Exit;
    end;
    AddDevice(NewID);
    grRatesEx.EditorMode := True;
    Exit;
  end;

  MessageBox(0, 'По указанному коду ничего не найдено!', CaptionForm,
    MB_ICONINFORMATION + MB_OK + mb_TaskModal);
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
      1: qrTemp.SQL.Text := 'UPDATE card_rate_temp set rate_count=:RC WHERE ID=:ID;';
      2: qrTemp.SQL.Text := 'UPDATE materialcard_temp set mat_count=:RC WHERE ID=:ID;';
      3: qrTemp.SQL.Text := 'UPDATE mechanizmcard_temp set mech_count=:RC WHERE ID=:ID;';
      4: qrTemp.SQL.Text := 'UPDATE devicescard_temp set device_count=:RC WHERE ID=:ID;';
      5: qrTemp.SQL.Text := 'UPDATE dumpcard_temp set WORK_COUNT = :RC WHERE ID=:ID;';
      6, 7, 8, 9:
          qrTemp.SQL.Text := 'UPDATE transpcard_temp set CARG_COUNT = :RC WHERE ID=:ID;';
      10, 11:
        begin
          if Act then
            qrTemp.SQL.Text := 'UPDATE data_act_temp set E1820_COUNT = :RC WHERE ID=:ID;'
          else
            qrTemp.SQL.Text := 'UPDATE data_estimate_temp set E1820_COUNT = :RC WHERE ID=:ID;';
        end
    else
      begin
        ShowMessage('Запрос обновления не реализован!');
        Exit;
      end;
    end;
    qrTemp.ParamByName('ID').AsInteger := qrRatesExID_TABLES.AsInteger;
    qrTemp.ParamByName('RC').AsFloat := Sender.Value;
    qrTemp.ExecSQL;
    // Пересчитывает все величины по данной строке
    ReCalcRowRates;
  end;
end;

procedure TFormCalculationEstimate.qrRatesExAfterOpen(DataSet: TDataSet);
var
  NumPP: Integer;
begin
  if not CheckQrActiveEmpty(qrRatesEx) then
    Exit;
  // Устанавливаем №пп
  qrRatesEx.DisableControls;
  NumPP := 0;
  try
    qrRatesEx.First;
    while not qrRatesEx.Eof do
    begin
      NumPP := NumPP + qrRatesEx.FieldByName('INCITERATOR').AsInteger;
      qrRatesEx.Edit;
      if qrRatesEx.FieldByName('ID_TYPE_DATA').AsInteger < 0 then
        qrRatesEx.FieldByName('ITERATOR').Value := null
      else
        qrRatesEx.FieldByName('ITERATOR').AsInteger := NumPP;
      qrRatesEx.Next;
    end;
  finally
    qrRatesEx.First; // исправить на SORD_ID
    qrRatesEx.EnableControls;
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

// пересчитывает все относящееся к строке в таблице расценок
procedure TFormCalculationEstimate.ReCalcRowRates;
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'CALL CalcRowInRateTab(:ID, :TYPE);';
  qrTemp.ParamByName('ID').AsInteger := qrRatesExID_TABLES.AsInteger;
  qrTemp.ParamByName('TYPE').AsInteger := qrRatesExID_TYPE_DATA.AsInteger;
  qrTemp.ExecSQL;

  // Для расценок обновляется кол-во у заменяющих материалов
  if qrRatesExID_TYPE_DATA.AsInteger = 1 then
    GridRatesUpdateCount;

  GridRatesRowLoad;

  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.GridRatesUpdateCount;
var
  RecNo: Integer;
  NewCount: Real;
begin
  RecNo := qrRatesEx.RecNo;
  // Для раценки обновляем COUNTFORCALC и у неучтенных или заменяющих материалов
  if qrRatesExID_TYPE_DATA.AsInteger = 1 then
  begin
    qrRatesEx.Tag := 1; // Блокирует обработчики событий датасета
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
          qrTemp.SQL.Text := 'Select MAT_COUNT FROM materialcard_temp ' +
            'WHERE ID = ' + IntToStr(qrRatesExID_TABLES.AsInteger);
          qrTemp.Active := True;
          if not qrTemp.Eof then
            NewCount := qrTemp.Fields[0].AsFloat;
          qrTemp.Active := False;

          qrRatesEx.Edit;
          qrRatesExOBJ_COUNT.AsFloat := NewCount;
          qrRatesEx.Post;
        end
        else
          Break; // так как датасет отсортирован
        qrRatesEx.Next;
      end;
      qrRatesEx.RecNo := RecNo;
    finally
      qrRatesEx.Tag := 0;
      qrRatesEx.EnableControls
    end;
  end;
end;

procedure TFormCalculationEstimate.UpdateMatCountInGridRate(AMId: Integer; AMCount: Real);
var
  RecNo: Integer;
begin
  RecNo := qrRatesEx.RecNo;
  // Для раценки обновляем COUNTFORCALC и у неучтенных или заменяющих материалов

  qrRatesEx.Tag := 1; // Блокирует обработчики событий датасета
  qrRatesEx.DisableControls;
  try
    qrRatesEx.First;

    while not qrRatesEx.Eof do
    begin
      if (qrRatesExID_TYPE_DATA.AsInteger = 2) and
        (qrRatesExID_TABLES.AsInteger = AMId) then
      begin
        qrRatesEx.Edit;
        qrRatesExOBJ_COUNT.AsFloat := AMCount;
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
  i: Integer;
begin
  if (TMenuItem(Sender).Tag = 1) then
    frmReplace := TfrmReplacement.Create(IdObject, IdEstimate, qrMechanizmID.AsInteger, 1, True)
  else
    frmReplace := TfrmReplacement.Create(IdObject, IdEstimate, qrMaterialID.AsInteger, 0, True);

  try
    if (frmReplace.ShowModal = mrYes) then
    begin
      qrTemp.Active := False;
      for i := 0 to frmReplace.RateCount - 1 do
      begin
        qrTemp.SQL.Text := 'CALL CalcCalculation(:ESTIMATE_ID, 1, :OWNER_ID, 0);';
        qrTemp.ParamByName('ESTIMATE_ID').Value := qrRatesExSM_ID.AsInteger;
        qrTemp.ParamByName('OWNER_ID').Value := frmReplace.RateIDs[i];
        qrTemp.ExecSQL;
      end;

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
  if (fWinterPrice.ShowModal = mrOk) and (fWinterPrice.OutValue <> 0) then
  begin
    qrTemp.SQL.Text := 'UPDATE card_rate_temp SET ZNORMATIVS_ID=:ZNORMATIVS_ID WHERE ID=:ID';
    qrTemp.ParamByName('ZNORMATIVS_ID').AsInteger := fWinterPrice.OutValue;
    qrTemp.ParamByName('ID').AsInteger := qrRatesExID_TABLES.AsInteger;
    qrTemp.ExecSQL;
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

procedure TFormCalculationEstimate.PMCoefOrdersClick(Sender: TObject);
begin
  // FormCoefficientOrders.ShowForm(IdEstimate, RateId, 0);
  GetStateCoefOrdersInRate;
end;

procedure TFormCalculationEstimate.PMMatDeleteClick(Sender: TObject);
begin
  if MessageBox(0, PChar('Вы действительно хотите удалить ' + qrMaterialMAT_CODE.AsString + '?'), CaptionForm,
    MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
    Exit;

  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL DeleteMaterial(:id);');
      ParamByName('id').Value := qrMaterialID.AsInteger;
      ExecSQL;
    end;

  except
    on E: Exception do
      MessageBox(0, PChar('При удалении материала возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
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

procedure TFormCalculationEstimate.PMMatFromRatesClick(Sender: TObject);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('INSERT INTO data_estimate_temp (id_estimate, id_type_data, id_tables) ' +
        'VALUE (:id_estimate, :id_type_data, :id_tables);');
      ParamByName('id_estimate').Value := IdEstimate;
      ParamByName('id_type_data').Value := 2;
      ParamByName('id_tables').Value := qrMaterialID.AsInteger;
      ExecSQL;

      SQL.Clear;
      SQL.Add('UPDATE materialcard_temp SET from_rate = 1 WHERE id = :id;');
      ParamByName('id').Value := qrMaterialID.AsInteger;
      ExecSQL;
    end;

    OutputDataToTable;
  except
    on E: Exception do
      MessageBox(0, PChar('При вынесении материала из расценки возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// Открытие строчки механизмов на редактирование
procedure TFormCalculationEstimate.PMMechDeleteClick(Sender: TObject);
begin
  if MessageBox(0, PChar('Вы действительно хотите удалить ' + qrMechanizmMECH_CODE.AsString + '?'),
    CaptionForm, MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
    Exit;

  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL DeleteMechanism(:id);');
      ParamByName('id').Value := qrMechanizmID.AsInteger;
      ExecSQL;
    end;

  except
    on E: Exception do
      MessageBox(0, PChar('При удалении механизма возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  OutputDataToTable;
end;

// включение режима расширенного редактирования механизма
procedure TFormCalculationEstimate.SetMechEditMode;
begin
  if CheckMechReadOnly then
    Exit;
  dbgrdMechanizm.Columns[2].ReadOnly := False; // Норма
  dbgrdMechanizm.Columns[4].ReadOnly := False; // Кол-во
  dbgrdMechanizm.Columns[5].ReadOnly := False; // ЗП машиниста
  dbgrdMechanizm.Columns[6].ReadOnly := False; // ЗП машиниста
  dbgrdMechanizm.Columns[9].ReadOnly := False; // Расценка
  dbgrdMechanizm.Columns[10].ReadOnly := False; // Расценка
  dbgrdMechanizm.Columns[13].ReadOnly := False; // НДС
  dbgrdMechanizm.Columns[22].ReadOnly := False; // норматив
  MemoRight.Color := $00AFFEFC;
  MemoRight.ReadOnly := False;
  MemoRight.Tag := 3;
  qrMechanizm.Tag := 1;
end;

// отключение режима расширенного редактирования механизма
procedure TFormCalculationEstimate.SetMechNoEditMode;
begin
  if qrMechanizm.Tag = 1 then
  begin
    dbgrdMechanizm.Columns[2].ReadOnly := True; // Норма
    dbgrdMechanizm.Columns[4].ReadOnly := True; // Кол-во
    dbgrdMechanizm.Columns[5].ReadOnly := True; // ЗП машиниста
    dbgrdMechanizm.Columns[6].ReadOnly := True; // ЗП машиниста
    dbgrdMechanizm.Columns[9].ReadOnly := True; // Расценка
    dbgrdMechanizm.Columns[10].ReadOnly := True; // Расценка
    dbgrdMechanizm.Columns[13].ReadOnly := True; // НДС
    dbgrdMechanizm.Columns[22].ReadOnly := True; // норматив
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
      SQL.Add('INSERT INTO data_estimate_temp (id_estimate, id_type_data, id_tables) ' +
        'VALUE (:id_estimate, :id_type_data, :id_tables);');
      ParamByName('id_estimate').Value := IdEstimate;
      ParamByName('id_type_data').Value := 3;
      ParamByName('id_tables').Value := qrMechanizmID.Value;
      ExecSQL;

      SQL.Clear;
      SQL.Add('UPDATE mechanizmcard_temp SET from_rate = 1 WHERE id = :id;');
      ParamByName('id').Value := qrMechanizmID.Value;
      ExecSQL;
    end;

    OutputDataToTable;
  except
    on E: Exception do
      MessageBox(0, PChar('При вынесении механизма из расценки возникла ошибка:' + sLineBreak + sLineBreak +
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
  DialogResult := MessageBox(0, PChar('Текущий ССР будет удален. Продолжить?'), 'Смета',
    MB_ICONINFORMATION + MB_YESNO + mb_TaskModal);

  if DialogResult = mrYes then
    MessageBox(0, PChar('Новый ССР'), 'Смета', MB_ICONINFORMATION + MB_OK + mb_TaskModal)
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
  DialogResult: Integer;
  FormCardAct: TfCardAct;
begin
  DialogResult := mrNone;

  if (not ActReadOnly) and (PanelCalculationYesNo.Tag = 1) then
    DialogResult := MessageBox(0, PChar('Сохранить сделанные изменения перед закрытием окна?'), 'Смета',
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
          on E: Exception do
            MessageBox(0, PChar('При сохранении данных акта возникла ошибка:' + sLineBreak + sLineBreak +
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
          MessageBox(0, PChar('При сохранении всех данных сметы возникла ошибка:' + sLineBreak + sLineBreak +
            E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
      end;

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
        // Заменяющие неучтенный материал в расценке
        if CheckMatINRates then
        begin
          FillingTableMaterials(qrRatesExID_RATE.AsInteger, 0);
        end
        else
        begin // Отдельный материал и вынесенные
          FillingTableMaterials(0, qrRatesExID_TABLES.AsInteger);
        end;
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
  EditWinterPrice.Text := '';

  PopupMenuCoefAddSet.Enabled := True;
  PopupMenuCoefDeleteSet.Enabled := True;

  CalcPrice := '00';

  PMDelete.Enabled := True;
  PMEdit.Enabled := False;

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
          MyFloatToStr(GetRankBuilders(IntToStr(qrRatesExID_TABLES.AsInteger)));

        // Запоняем строку зимнего удорожания
        FillingWinterPrice(qrRatesExOBJ_CODE.AsString);

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

        // Средний разряд рабочих-строителей
        {if CheckMatINRates then
        begin
          PMDelete.Enabled := False;
          EditCategory.Text :=
            MyFloatToStr(GetRankBuilders(IntToStr(qrRatesRATEIDINRATE.AsInteger)));
          EditCategory.Text :=
            MyFloatToStr(GetWorkCostBuilders(IntToStr(qrRatesRATEIDINRATE.AsInteger)));
          FillingWinterPrice(qrRatesCODEINRATE.AsString);
        end;}

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
        PMEdit.Enabled := True;
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
        PMEdit.Enabled := True;
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
    'SELECT COUNT(*) AS CNT FROM calculation_coef_temp where id_estimate=:id_estimate and id_owner=:id_owner and id_type_data=:id_type_data';
  qrTemp.ParamByName('id_estimate').AsInteger := qrRatesExSM_ID.AsInteger;
  qrTemp.ParamByName('id_owner').AsInteger := qrRatesExID_TABLES.AsInteger;
  qrTemp.ParamByName('id_type_data').AsInteger := qrRatesExID_TYPE_DATA.AsInteger;
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
  fCoefficients.ShowModal;
end;

procedure TFormCalculationEstimate.PopupMenuCoefDeleteSetClick(Sender: TObject);
begin
  if MessageBox(0, PChar('Вы действительно хотите удалить ' + sLineBreak + 'выделенный набор коэффициентов?'),
    'Смета', MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) <> mrYes then
    Exit;

  qrTemp.SQL.Text := 'Delete from calculation_coef_temp where calculation_coef_id=:id';
  qrTemp.ParamByName('id').AsInteger := qrCalculations.FieldByName('id').AsInteger;
  qrTemp.ExecSQL;
  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.PopupMenuCoefOrdersClick(Sender: TObject);
begin
  GetStateCoefOrdersInRate;
end;

procedure TFormCalculationEstimate.PopupMenuCoefPopup(Sender: TObject);
begin
  GetStateCoefOrdersInEstimate;
end;

// вид всплывающего меню материалов
procedure TFormCalculationEstimate.PopupMenuMaterialsPopup(Sender: TObject);
begin
  PMMatEdit.Enabled := not CheckMatReadOnly;

  PMMatReplace.Enabled := (qrMaterialFROM_RATE.AsInteger = 0) // В расценка
    and (qrMaterialTITLE.AsInteger = 0) // не загоровок
    and (qrMaterialID_REPLACED.AsInteger = 0); // не заменяющуй

  PMMatFromRates.Enabled := (not CheckMatReadOnly) and (not CheckMatUnAccountingMatirials) and
    (qrMaterialFROM_RATE.AsInteger = 0);

  PMMatDelete.Enabled := (qrMaterialID_REPLACED.AsInteger > 0) and (qrMaterialFROM_RATE.AsInteger = 0);
end;

// Настройка вида всплывающего меню таблицы механизмов
procedure TFormCalculationEstimate.PopupMenuMechanizmsPopup(Sender: TObject);
begin
  PMMechEdit.Enabled := not CheckMechReadOnly;

  PMMechFromRates.Enabled := (not CheckMechReadOnly) and
    (qrRatesExID_RATE.AsInteger > 0) and
    (qrMechanizmREPLACED.AsInteger = 0);

  PMMechReplace.Enabled := (qrMechanizmFROM_RATE.AsInteger = 0) and
    (qrMechanizmID_REPLACED.AsInteger = 0) and
    (qrRatesExID_RATE.AsInteger > 0); // не заменяющуй

  PMMechDelete.Enabled := (qrMechanizmID_REPLACED.AsInteger > 0) and
    (qrMechanizmFROM_RATE.AsInteger = 0);
end;

procedure TFormCalculationEstimate.PopupMenuRatesAdd352Click(Sender: TObject);
begin

end;

// Добавление расценки в смету
procedure TFormCalculationEstimate.AddRate(const vRateId: Integer);
var
  { i: Integer; }
  vMaxIdRate: Integer;
  vNormRas: Double;
  Month1, Year1: Integer;
  PriceVAT, PriceNoVAT: string;
  PT, PercentTransport: Real;
  { SQL1, SQL2: string; }
  ZonaId: Integer;
  SCode: string;
begin

  // Добавляем найденную расценку во временную таблицу card_rate_temp
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
    begin
      MessageBox(0, PChar('При добавлении расценки во временную таблицу возникла ошибка:' + sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
      Exit;
    end;
  end;

  // Заносим во временную таблицу materialcard_temp материалы находящиеся в расценке
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT year,monat FROM stavka WHERE stavka_id = ' +
        '(SELECT stavka_id FROM smetasourcedata WHERE sm_id = ' + IntToStr(IdEstimate) + ')');
      Active := True;
      Month1 := FieldByName('monat').AsInteger;
      Year1 := FieldByName('year').AsInteger;
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

      ZonaId := 0;
      SQL.Clear;
      SQL.Add('SELECT obj_region FROM objstroj WHERE ' + 'stroj_id = (SELECT stroj_id FROM objcards WHERE ' +
        'obj_id = ' + IntToStr(IdObject) + ')');
      Active := True;
      if not Eof then
        ZonaId := Fields[0].AsInteger;
      Active := False;

      SQL.Clear;
      SQL.Add('SELECT coef_tr_zatr FROM smetasourcedata WHERE sm_id = ' + IntToStr(IdEstimate));
      Active := True;
      PercentTransport := Fields[0].AsFloat;
      Active := False;

      SQL.Clear;
      SQL.Text := 'SELECT DISTINCT TMat.material_id as "MatId", TMat.mat_code as "MatCode", ' +
        'TMatNorm.norm_ras as "MatNorm", units.unit_name as "MatUnit", ' +
        'TMat.unit_id as "UnitId", mat_name as "MatName", ' + PriceVAT + ' as "PriceVAT", ' + PriceNoVAT +
        ' as "PriceNoVAT" ' + 'FROM materialnorm as TMatNorm ' +
        'JOIN material as TMat ON TMat.material_id = TMatNorm.material_id ' +
        'JOIN units ON TMat.unit_id = units.unit_id ' + 'LEFT JOIN (select material_id, ' + PriceVAT + ', ' +
        PriceNoVAT + ' from materialcoastg where (monat = ' + IntToStr(Month1) + ') and (year = ' +
        IntToStr(Year1) + ')) as TMatCoast ' + 'ON TMatCoast.material_id = TMatNorm.material_id ' +
        'WHERE (TMatNorm.normativ_id = ' + IntToStr(vRateId) + ') order by 1';
      Active := True;

      Filtered := False;
      Filter := 'MatCode LIKE ''С%''';
      Filtered := True;

      First;

      while not Eof do
      begin
        // Получение процента транспорта для материала
        qrTemp1.Active := False;
        SCode := FieldByName('MatCode').AsString;
        SCode := copy(SCode, 1, Pos('-', SCode) - 1) + ',';
        PT := 0;
        if ZonaId > 0 then
        begin
          qrTemp1.SQL.Clear;
          qrTemp1.SQL.Add('SELECT Transp' + IntToStr(ZonaId) + ' FROM materialtransp WHERE LOCATE(''' + SCode
            + ''', codestr)');
          qrTemp1.Active := True;
          if not qrTemp1.Eof then
            PT := qrTemp1.Fields[0].AsFloat;
          qrTemp1.Active := False;
        end;
        if PT = 0 then
          PT := PercentTransport;

        qrTemp1.SQL.Text := 'Insert into materialcard_temp (ID_CARD_RATE, MAT_ID, ' +
          'MAT_CODE, MAT_NAME, MAT_NORMA, MAT_UNIT, COAST_NO_NDS, COAST_NDS, ' +
          'PROC_TRANSP) values (:ID_CARD_RATE, :MAT_ID, ' +
          ':MAT_CODE, :MAT_NAME, :MAT_NORMA, :MAT_UNIT, :COAST_NO_NDS, ' + ':COAST_NDS, :PROC_TRANSP)';
        qrTemp1.ParamByName('ID_CARD_RATE').AsInteger := vMaxIdRate;
        qrTemp1.ParamByName('MAT_ID').AsInteger := FieldByName('MatId').AsInteger;
        qrTemp1.ParamByName('MAT_CODE').AsString := FieldByName('MatCode').AsString;
        qrTemp1.ParamByName('MAT_NAME').AsString := FieldByName('MatName').AsString;
        vNormRas := MyStrToFloatDef(FieldByName('MatNorm').AsString, 0);
        qrTemp1.ParamByName('MAT_NORMA').AsFloat := vNormRas;
        qrTemp1.ParamByName('MAT_UNIT').AsString := FieldByName('MatUnit').AsString;
        qrTemp1.ParamByName('COAST_NO_NDS').AsInteger := FieldByName('PriceNoVAT').AsInteger;
        qrTemp1.ParamByName('COAST_NDS').AsInteger := FieldByName('PriceVAT').AsInteger;
        qrTemp1.ParamByName('PROC_TRANSP').AsFloat := PT;
        qrTemp1.ExecSQL;

        Next;
      end;

      Filtered := False;
      Filter := 'MatCode LIKE ''П%''';
      Filtered := True;

      First;

      while not Eof do
      begin
        qrTemp1.Active := False;
        qrTemp1.SQL.Text := 'Insert into materialcard_temp (ID_CARD_RATE, CONSIDERED, MAT_ID, ' +
          'MAT_CODE, MAT_NAME, MAT_NORMA, MAT_UNIT, COAST_NO_NDS, COAST_NDS, ' +
          'PROC_TRANSP) values (:ID_CARD_RATE, :CONSIDERED, :MAT_ID, ' +
          ':MAT_CODE, :MAT_NAME, :MAT_NORMA, :MAT_UNIT, :COAST_NO_NDS, ' + ':COAST_NDS, :PROC_TRANSP)';
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
        qrTemp1.ParamByName('PROC_TRANSP').AsFloat := 0;
        qrTemp1.ExecSQL;

        Next;
      end;

      Filtered := False;
      Filter := '';

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При занесении материалов во временную таблицу возникла ошибка:' + sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // Заносим во временную таблицу mechanizmcard_temp механизмы находящиеся в расценке
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
        qrTemp1.SQL.Text := 'Insert into mechanizmcard_temp (ID_CARD_RATE, ' +
          'MECH_ID, MECH_CODE, MECH_NAME, MECH_NORMA, MECH_UNIT, COAST_NO_NDS, ' +
          'COAST_NDS, ZP_MACH_NO_NDS, ZP_MACH_NDS) values (:ID_CARD_RATE, ' +
          ':MECH_ID, :MECH_CODE, :MECH_NAME, :MECH_NORMA, :MECH_UNIT, :COAST_NO_NDS, ' +
          ':COAST_NDS, :ZP_MACH_NO_NDS, :ZP_MACH_NDS)';
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
      MessageBox(0, PChar('При занесении механизмов во временную таблицу возникла ошибка:' + sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  OutputDataToTable;
end;

procedure TFormCalculationEstimate.PMAddTranspClick(Sender: TObject);
begin
  if GetTranspForm(IdEstimate, -1, (Sender as TMenuItem).Tag, True) then
  begin
    OutputDataToTable;
  end;
end;

procedure TFormCalculationEstimate.PMAddAdditionHeatingE18Click(Sender: TObject);
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'INSERT INTO data_estimate_temp ' +
    '(id_estimate, id_type_data) VALUE (:IdEstimate, :SType);';
  qrTemp.ParamByName('IdEstimate').AsInteger := IdEstimate;
  qrTemp.ParamByName('SType').AsInteger := (Sender as TComponent).Tag;
  qrTemp.ExecSQL;

  OutputDataToTable;
end;

procedure TFormCalculationEstimate.PMAddDumpClick(Sender: TObject);
begin
  if GetDumpForm(IdEstimate, -1, True) then
  begin
    OutputDataToTable;
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

// Удаление чего-либо из сметы
procedure TFormCalculationEstimate.PMDeleteClick(Sender: TObject);
begin
  if MessageBox(0, PChar('Вы действительно хотите удалить ' +
    qrRatesExOBJ_CODE.AsString + '?'),
    CaptionForm, MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
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
          on E: Exception do
            MessageBox(0, PChar('При удалении расценки возникла ошибка:' +
              sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      2: // Материал
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteMaterial(:id);');
            ParamByName('id').Value := qrRatesExID_TABLES.AsInteger;
            ExecSQL;
          end;

        except
          on E: Exception do
            MessageBox(0, PChar('При удалении материала возникла ошибка:' +
              sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      3: // Механизм
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteMechanism(:id);');
            ParamByName('id').Value := qrRatesExID_TABLES.AsInteger;
            ExecSQL;
          end;

        except
          on E: Exception do
            MessageBox(0, PChar('При удалении механизма возникла ошибка:' +
              sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
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
          on E: Exception do
            MessageBox(0, PChar('При удалении оборудования возникла ошибка:' +
              sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
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
          on E: Exception do
            MessageBox(0, PChar('При удалении свалки возникла ошибка:' +
              sLineBreak + sLineBreak + E.Message),
              CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
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
          on E: Exception do
            MessageBox(0, PChar('При удалении транспорта возникла ошибка:' +
              sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      10, 11: // Пуск и регулировка
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('DELETE FROM data_estimate_temp WHERE (id_type_data = ' +
              IntToStr(qrRatesExID_TYPE_DATA.AsInteger) + ');');
            ExecSQL;
          end;
        except
          on E: Exception do
            MessageBox(0, PChar('При удалении транспорта возникла ошибка:' +
              sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
    end;
  OutputDataToTable;
end;

procedure TFormCalculationEstimate.PMDevEditClick(Sender: TObject);
begin
  SetDevEditMode;
end;

// Общий пункт для свалок и транспорта
procedure TFormCalculationEstimate.PMDumpEditClick(Sender: TObject);
begin
  if qrRatesExID_TYPE_DATA.AsInteger = 5 then
    if GetDumpForm(IdEstimate, qrDumpID.AsInteger, False) then
      OutputDataToTable;

  if qrRatesExID_TYPE_DATA.AsInteger in [6, 7, 8, 9] then
    if GetTranspForm(IdEstimate, qrTranspID.AsInteger,
      qrRatesExID_TYPE_DATA.AsInteger, False) then
      OutputDataToTable;
end;

procedure TFormCalculationEstimate.PMEditClick(Sender: TObject);
begin
  case qrRatesExID_TYPE_DATA.AsInteger of
    5:
      PMDumpEditClick(nil);
    6, 7, 8, 9:
      PMDumpEditClick(nil);
  end;
end;

procedure TFormCalculationEstimate.PopupMenuTableLeftPopup(Sender: TObject);
begin
  // Нельзя удалить неучтенный материал из таблицы расценок
  PMDelete.Enabled := not(CheckMatINRates);
end;

procedure TFormCalculationEstimate.EstimateBasicDataClick(Sender: TObject);
begin
  FormBasicData.ShowModal;
end;

procedure TFormCalculationEstimate.LabelObjectClick(Sender: TObject);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormObjectsAndEstimates)) then
    FormObjectsAndEstimates := TFormObjectsAndEstimates.Create(Self);

  FormObjectsAndEstimates.Show;

  // Закрываем форму ожидания
  FormWaiting.Close;
end;

procedure TFormCalculationEstimate.LabelEstimateClick(Sender: TObject);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormObjectsAndEstimates)) then
    FormObjectsAndEstimates := TFormObjectsAndEstimates.Create(Self);

  FormObjectsAndEstimates.Show;

  // Закрываем форму ожидания
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
  ReCalcMat := True;
  qrMaterialNUM.ReadOnly := False;
  // Открытие датасета для заполнения таблицы материалов
  qrMaterial.Active := False;
  // Заполняет materials_temp
  qrMaterial.SQL.Text := 'call GetMaterials(' + IntToStr(fType) + ',' + IntToStr(fID) + ')';
  qrMaterial.ExecSQL;

  qrMaterial.Active := False;
  // Открывает materials_temp
  qrMaterial.SQL.Text := 'SELECT * FROM materials_temp ORDER BY SRTYPE, TITLE DESC, ID';
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
    inc(i);
    qrMaterial.Edit;
    qrMaterialNUM.AsInteger := i;
    qrMaterial.Post;

    qrMaterial.Next;
  end;
  qrMaterialNUM.ReadOnly := True;

  if (qrRatesExID_RATE.AsInteger > 0) then
    dbgrdMaterial.Columns[2].Visible := True
  else
    dbgrdMaterial.Columns[2].Visible := False;

  qrMaterial.First;
  if (qrMaterialTITLE.AsInteger > 0) then
    qrMaterial.Next;

  ReCalcMat := False;
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
    'from card_rate_temp WHERE RATE_CODE LIKE "%' + LikeText + '%"';
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
  ReCalcMech := True;
  qrMechanizmNUM.ReadOnly := False;
  // Открытие датасета для заполнения таблицы материалов
  qrMechanizm.Active := False;
  // Заполняет Mechanizms_temp
  qrMechanizm.SQL.Text := 'call GetMechanizms(' + IntToStr(fType) + ',' +
    IntToStr(fID) + ')';
  qrMechanizm.ExecSQL;

  qrMechanizm.Active := False;
  // Открывает Mechanizms_temp
  qrMechanizm.SQL.Text := 'SELECT * FROM mechanizms_temp ORDER BY SRTYPE, TITLE DESC, ID';
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
    inc(i);
    qrMechanizm.Edit;
    qrMechanizmNUM.AsInteger := i;
    qrMechanizm.Post;

    qrMechanizm.Next;
  end;
  qrMechanizmNUM.ReadOnly := True;

  if (qrRatesExID_RATE.AsInteger > 0) then
    dbgrdMechanizm.Columns[2].Visible := True
  else
    dbgrdMechanizm.Columns[2].Visible := False;

  qrMechanizm.First;
  if (qrMechanizmTITLE.AsInteger > 0) then
    qrMechanizm.Next;

  ReCalcMech := False;
  qrMechanizm.EnableControls;
  qrMechanizmAfterScroll(qrMechanizm);
end;

procedure TFormCalculationEstimate.FillingTableDescription(const vIdNormativ: Integer);
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
  Result := 0;
  // Средний разряд рабочих-строителей
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT norma FROM normativwork WHERE normativ_id = ' +
        vIdNormativ + ' and work_id = 1;');
      Active := True;

      if FieldByName('norma').Value <> null then
        Result := FieldByName('norma').AsFloat;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении значения "Средний разряд" возникла ошибка:' +
        sLineBreak + sLineBreak
        + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
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
      SQL.Add('SELECT norma FROM normativwork WHERE normativ_id = ' + vIdNormativ +
        ' and work_id = 2;');
      Active := True;

      if FieldByName('norma').AsVariant <> null then
        Result := FieldByName('norma').AsVariant;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении значения "ЗТ строителей" возникла ошибка:' +
        sLineBreak + sLineBreak
        + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
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
      SQL.Add('SELECT norma FROM normativwork WHERE normativ_id = ' + vIdNormativ +
        ' and work_id = 3;');
      Active := True;

      if FieldByName('norma').AsVariant <> null then
        Result := FieldByName('norma').AsVariant;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении значения "ЗТ машинистов" возникла ошибка:' +
        sLineBreak + sLineBreak
        + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
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
        'WHERE objcards.stroj_id = objstroj.stroj_id and obj_id = ' +
        IntToStr(IdObject) + ';');
      Active := True;

      // Получаем регион (1-город, 2-село, 3-минск)
      IdRegion := FieldByName('IdRegion').AsVariant;

      // -----------------------------------------

      Active := False;
      SQL.Clear;

      if IdRegion = 3 then
        StrQuery := 'SELECT stavka_m_rab as "RateWorker" FROM stavka WHERE monat = ' +
          IntToStr(MonthEstimate) + ' and year = ' + IntToStr(YearEstimate) + ';'
      else
        StrQuery := 'SELECT stavka_rb_rab as "RateWorker" FROM stavka WHERE monat = ' +
          IntToStr(MonthEstimate) + ' and year = ' + IntToStr(YearEstimate) + ';';

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
    on E: Exception do
      MessageBox(0, PChar('Ошибка при вычислении «' + '», в таблице вычислений:' +
        sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetNormMechanizm(const vIdNormativ, vIdMechanizm: string): Double;
begin
  Result := 0;
  // Норма расхода по механизму
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT norm_ras FROM mechanizmnorm WHERE normativ_id = ' +
        vIdNormativ + ' and mechanizm_id = ' + vIdMechanizm + ';');
      Active := True;

      if FieldByName('norm_ras').AsVariant <> null then
        Result := MyStrToFloat(FieldByName('norm_ras').AsString)
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении нормы расхода по механизму возникла ошибка:' +
        sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetPriceMechanizm(const vIdNormativ, vIdMechanizm: string): Currency;
begin
  Result := 0;
  // Цена по механизму
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT norm_ras FROM mechanizmnorm WHERE normativ_id = ' +
        vIdNormativ + ' and mechanizm_id = ' + vIdMechanizm + ';');
      Active := True;

      if FieldByName('norm_ras').AsVariant <> null then
        Result := MyStrToFloat(FieldByName('norm_ras').AsString)
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении нормы расхода по механизму возникла ошибка:' +
        sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.SettingVisibleRightTables;
begin
  // Закрывает режим редактирования в мемо, если он включен
  // связано с тем, что спидбутоны не получают фокуса при нажатии на них
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
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT IFNULL(monat, 0) as "Month", IFNULL(year, 0) as "Year" ' +
        'FROM stavka WHERE stavka_id = (SELECT stavka_id From smetasourcedata '
        + 'WHERE sm_id = ' + IntToStr(IdEstimate) + ');');
      Active := True;

      MonthEstimate := FieldByName('Month').AsInteger;
      YearEstimate := FieldByName('Year').AsInteger;
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При запросе месяца и года из таблицы СТАВКА возникла ошибка:' +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
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
    on E: Exception do
      MessageBox(0, PChar('При получении исходных данных возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.ChangeGrigNDSStyle(aNDS: Boolean);
begin
  with dbgrdMaterial do
  begin
    // в зависимости от ндс скрывает одни и показывает другие калонки
    Columns[6].Visible := aNDS; // цена смет
    Columns[8].Visible := aNDS; // Трансп смет
    Columns[10].Visible := aNDS; // Стоим смет
    Columns[13].Visible := aNDS; // цена факт
    Columns[15].Visible := aNDS; // Трансп факт
    Columns[17].Visible := aNDS; // стоим факт

    Columns[7].Visible := not aNDS;
    Columns[9].Visible := not aNDS;
    Columns[11].Visible := not aNDS;
    Columns[14].Visible := not aNDS;
    Columns[16].Visible := not aNDS;
    Columns[18].Visible := not aNDS;
  end;

  with dbgrdMechanizm do
  begin
    // в зависимости от ндс скрывает одни и показывает другие калонки
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
    // в зависимости от ндс скрывает одни и показывает другие калонки
    Columns[5].Visible := aNDS; // цена факт
    Columns[7].Visible := aNDS; // Трансп
    Columns[9].Visible := aNDS; // стоим факт

    Columns[6].Visible := not aNDS;
    Columns[8].Visible := not aNDS;
    Columns[10].Visible := not aNDS;
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
    Columns[10].Visible := aNDS; // стоим факт

    Columns[8].Visible := not aNDS;
    Columns[11].Visible := not aNDS;
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
        EditWinterPrice.Text := FieldByName('Name').AsVariant;
      end
    else
    with qrTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT znormativs.ZNORMATIVS_ID, num as "Number", name as "Name", coef as "Coef", coef_zp as "CoefZP", s as "From", po as "On" '
          + 'FROM znormativs, znormativs_detail, znormativs_value '
          + 'WHERE znormativs.ZNORMATIVS_ID=znormativs_detail.ZNORMATIVS_ID  '
          + 'AND znormativs.ZNORMATIVS_ID = znormativs_value.ZNORMATIVS_ID '
          + 'AND znormativs.DEL_FLAG = 0 '
          + 'AND znormativs_value.ZNORMATIVS_ONDATE_ID = ('
          + '  SELECT znormativs_ondate.ID'
          + '    FROM znormativs_ondate'
          + '    WHERE `znormativs_ondate`.`onDate` <= (SELECT CONVERT(CONCAT(stavka.YEAR,"-",stavka.MONAT,"-01"), DATE) FROM stavka WHERE stavka.STAVKA_ID = (SELECT STAVKA_ID FROM smetasourcedata WHERE SM_ID='+qrRatesExSM_ID.AsString+'))'
          + '    AND `znormativs_ondate`.`DEL_FLAG` = 0)'
          + ';');
        Active := True;
        First;
        while not Eof do
        begin
          if (vNumber > FieldByName('From').AsVariant) and (vNumber < FieldByName('On').AsVariant) then
          begin
            EditWinterPrice.Text := FieldByName('Number').AsVariant + ' ' + FieldByName('Name').AsVariant;
            qrRatesExZNORMATIVS_ID.AsInteger := FieldByName('ZNORMATIVS_ID').AsInteger;
            Break;
          end;
          Next;
        end;
      end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении значений зимнего удорожания возникла ошибка:' + sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// Кусок кода оставлен, что-бы потом решить, что делать с журналом 6кс
procedure TFormCalculationEstimate.AddRowToTableRates(FieldRates: TFieldRates);
begin
  // Выделяем строчку в КС-6
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

procedure TFormCalculationEstimate.tmRateTimer(Sender: TObject);
begin
  tmRate.Enabled := False;
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

  // На всякий случай, что-бы избежать глюков
  if not qrRatesEx.Active then
    Exit;

  if qrRatesEx.State in [dsInsert] then
  begin
    // в режиме добавления строки редактируется код, а не количество
    qrRatesExOBJ_COUNT.ReadOnly := True;
    qrRatesExOBJ_CODE.ReadOnly := False;

    // Если нет расценок, гасим все кнопки, вешаем панель нет данных
    if qrRatesEx.Eof then
    begin
      BottomTopMenuEnabled(False);
      TestOnNoDataNew(qrMaterial);
      Exit;
    end;
  end;

  // Скрываем колонки зименого удорожания если не нужны
  dbgrdCalculations.Columns[13].Visible := qrRatesExAPPLY_WINTERPRISE_FLAG.AsInteger = 1;
  dbgrdCalculations.Columns[14].Visible := qrRatesExAPPLY_WINTERPRISE_FLAG.AsInteger = 1;
  dbgrdCalculations.Columns[13].Width := 64;
  dbgrdCalculations.Columns[14].Width := 64;
  FixDBGridColumnsWidth(dbgrdCalculations);

  // Можно редактировать кол-во для любой строки
  qrRatesExOBJ_CODE.ReadOnly := True;
  Panel1.Visible := (qrRatesExID_TYPE_DATA.Value = 1);

  // заполняет таблицы справа
  GridRatesRowSellect;
end;

// Проверка, что таблица является пустой(если пустая показывается картинка нет данных)
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

      if FieldByName('Salary').AsVariant <> null then
        Result := FieldByName('Salary').AsVariant;

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При запросе «ЗП машиниста» возникла ошибка:' +
        sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.GetCoastMechanizm(const vIdMechanizm: Integer): Currency;
begin
  // Цена использования (аренды, работы) механизма
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

      if FieldByName('Coast').AsVariant <> null then
        Result := FieldByName('Coast').AsVariant;

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При запросе «Цены аренды механизма» возникла ошибка:' + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.CreateTempTables;
var
  Str: string;
begin
  Str := 'CALL CreateTempTables(1);'; // Данные сметы

  try
    with qrTemp do
    begin
      SQL.Clear;
      SQL.Add(Str);
      ExecSQL;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При создании временных таблиц возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.OpenAllData;
begin
  GetMonthYearCalculationEstimate;
  GetSourceData; // Выводим информациию об исходных данных сметы
  GetStateCoefOrdersInRate;
  // Получаем состояние коэффициента по приказам (применять / не применять)

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
    on E: Exception do
      MessageBox(0, PChar('При открытии данных возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // Заполнение таблицы расценок
  OutputDataToTable;

  if not qrOXROPR.Active then
    qrOXROPR.Active := True;
  if not qrTypeData.Active then
    qrTypeData.Active := True;
end;

// Заполнение таблицы расценок
procedure TFormCalculationEstimate.OutputDataToTable;
begin
  // E18 и E20 - могут встречаться в смете только один раз
  PMAddAdditionHeatingE18.Enabled := True;
  PMAddAdditionHeatingE20.Enabled := True;

  // Новая процедура вывода левой части
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
  CloseOpen(qrRatesEx);
  // ----------------------------------

  CloseOpen(qrCalculations);
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

  FormMain.PanelCover.Visible := True;
  FormAdditionData := TFormAdditionData.Create(FormMain, vDataBase);
  FormAdditionData.WindowState := wsNormal;

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

  with FormAdditionData do
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
    Application.ProcessMessages;
  end;
  FormMain.PanelCover.Visible := False;
  Application.ProcessMessages;
end;

procedure TFormCalculationEstimate.GetStateCoefOrdersInEstimate;
begin
  // Получаем флаг состояние (применять или не применять) коэффициента по приказам

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
      MessageBox(0, PChar('При получения флага применения коэффициента по приказам для сметы возникла ошибка:'
        + sLineBreak + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  PopupMenuCoefDeleteSet.Enabled := (qrCalculations.FieldByName('ID').AsInteger > 0);
end;

procedure TFormCalculationEstimate.GetStateCoefOrdersInRate;
begin
  // Получаем флаг состояния коэффициента по приказам (применять или не применять)

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
      MessageBox(0, PChar('При получения флага применения коэффициента по приказам возникла ошибка:' +
        sLineBreak + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.AddCoefToRate(coef_id: Integer);
// Добавление коэфф. к строчке
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text :=
    'INSERT INTO calculation_coef_temp(id_estimate,id_type_data,id_owner,id_coef,COEF_NAME,COEF_VALUE,OSN_ZP,EKSP_MACH,MAT_RES,WORK_PERS,WORK_MACH)'#13
    + 'SELECT :id_estimate, :id_type_data, :id_owner, coef_id,COEF_NAME,COEF_VALUE,OSN_ZP,EKSP_MACH,MAT_RES,WORK_PERS,WORK_MACH'#13
    + 'FROM coef WHERE coef.coef_id=:coef_id';
  qrTemp.ParamByName('id_estimate').AsInteger := IdEstimate;
  qrTemp.ParamByName('id_owner').AsInteger := qrRatesExID_TABLES.AsInteger;
  qrTemp.ParamByName('id_type_data').AsInteger := qrRatesExID_TYPE_DATA.AsInteger;
  qrTemp.ParamByName('coef_id').AsInteger := coef_id;
  qrTemp.ExecSQL;
  CloseOpen(qrCalculations);
end;

procedure TFormCalculationEstimate.AddDevice(const vEquipId: Integer);
// Добавление оборудования к смете
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

    OutputDataToTable;
  except
    on E: Exception do
      MessageBox(0, PChar('При добавлении оборудования возникла ошибка:' +
        sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// Добавление материала к смете
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

    OutputDataToTable;
  except
    on E: Exception do
      MessageBox(0, PChar('При добавлении материала возникла ошибка:' +
        sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// Добавление механизма к смете
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

    OutputDataToTable;
  except
    on E: Exception do
      MessageBox(0, PChar('При добавлении механизма возникла ошибка:' +
        sLineBreak + sLineBreak + E.Message),
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
    if gdFocused in State then // Ячейка в фокусе
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    if Assigned(TMyDBGrid(dbgrdDescription).DataLink) and
      (dbgrdDescription.Row = TMyDBGrid(dbgrdDescription).DataLink.ActiveRecord + 1) and
      (dbgrdDescription = LastEntegGrd) then
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

    // Подсветка поля код (для красоты)
    if Column.Index = 1 then
      Brush.Color := $00F0F0FF;

    // Подсветка полей стоимости
    if (Sender as TJvDBGrid).Name = 'dbgrdTransp' then
    begin
      if Column.Index in [10, 11] then
        Brush.Color := $00FBFEBC;
    end
    else if Column.Index in [9, 10] then
      Brush.Color := $00FBFEBC;

    if Assigned(TMyDBGrid(Sender).DataLink) and
      ((Sender as TJvDBGrid).Row = TMyDBGrid(Sender).DataLink.ActiveRecord + 1) and
      (TJvDBGrid(Sender) = LastEntegGrd) then
    begin
      Font.Style := Font.Style + [fsbold];
      // Все поля открытые для редактирования подсвечиваются желтеньким
      if not Column.ReadOnly then
        Brush.Color := $00AFFEFC
    end;

    if gdFocused in State then // Ячейка в фокусе
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
  // Порядок строчек очень важен для данной процедуры
  with dbgrdMaterial.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    // Подсветка поля код (для красоты)
    if Column.Index = 1 then
      Brush.Color := $00F0F0FF;

    // Подсветка полей стоимости
    if Column.Index in [10, 11, 17, 18] then
    begin
      // Та стоимость которая используется в расчете подсвечивается берюзовым
      // другая серым
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

    // Подсветка красным пустых значений
    if (Column.Index in [2, 5, 6, 7]) and (Column.Field.AsFloat = 0) then
    begin
      Brush.Color := $008080FF;
    end;

    if Assigned(TMyDBGrid(dbgrdMaterial).DataLink) and
      (dbgrdMaterial.Row = TMyDBGrid(dbgrdMaterial).DataLink.ActiveRecord + 1) and
      (dbgrdMaterial = LastEntegGrd) then
    begin
      Font.Style := Font.Style + [fsbold];
      // Все поля открытые для редактирования подсвечиваются желтеньким
      if not Column.ReadOnly then
        Brush.Color := $00AFFEFC;
    end;

    // Зачеркиваем вынесеные из расцеки материалы
    if (qrMaterialFROM_RATE.AsInteger = 1) and
      (qrRatesExID_RATE.AsInteger > 0) then
    begin
      Font.Style := Font.Style + [fsStrikeOut];
      Brush.Color := $00DDDDDD;
    end;

    // подсвечиваем замененный материал
    if (qrMaterialREPLACED.AsInteger = 1) then
    begin
      Brush.Color := $00DDDDDD;
    end;

    // Подсветка замененного материяла (подсветка П-шки)
    if (IdReplasedMat > 0) and (qrMaterialID.AsInteger = IdReplasedMat) and
       (dbgrdMaterial = LastEntegGrd)
    then
      Font.Style := Font.Style + [fsbold];

    if (qrRatesExID_TYPE_DATA.AsInteger = 2) and
       (qrRatesExID_TABLES.AsInteger = qrMaterialID.AsInteger) and
       (grRatesEx = LastEntegGrd) then
      Font.Style := Font.Style + [fsbold];

    // Подсветка замененяющего материала
    if (qrMaterialFROM_RATE.AsInteger = 0) and
       (IdReplasingMat = qrMaterialID_REPLACED.AsInteger) and
       (dbgrdMaterial = LastEntegGrd) then
      Font.Style := Font.Style + [fsbold];


    Str := '';
    // Подсветка синим подшапок таблицы
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

    // Не отображает кол-во и суммы для замененных или вынесеных
    if ((qrMaterialFROM_RATE.AsInteger = 1) and
        (qrRatesExID_RATE.AsInteger > 0)) or
      (qrMaterialREPLACED.AsInteger = 1) then
    begin
      if Column.Index in [4, 8, 9, 10, 11, 15, 16, 17, 18] then
        Str := '';
    end;

    if gdFocused in State then // Ячейка в фокусе
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

procedure TFormCalculationEstimate.dbgrdMaterialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // 45 - Insert
  // Исловие аналогично условаю в PopupMenuMaterialsPopup
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

    // Подсветка поля код (для красоты)
    if Column.Index = 1 then
      Brush.Color := $00F0F0FF;

    // Подсветка полей стоимости
    if Column.Index in [7, 8, 11, 12, 16, 17, 20, 21] then
    begin
      // Та стоимость которая используется в расчете подсвечивается берюзовым
      // другая серым
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

    // Подсветка красным пустых значений
    if (Column.Index in [2, 5, 6]) and (Column.Field.AsFloat = 0) then
    begin
      Brush.Color := $008080FF;
    end;

    if Assigned(TMyDBGrid(dbgrdMechanizm).DataLink) and
      (dbgrdMechanizm.Row = TMyDBGrid(dbgrdMechanizm).DataLink.ActiveRecord + 1) and
      (dbgrdMechanizm = LastEntegGrd) then
    begin
      Font.Style := Font.Style + [fsbold];
      // Все поля открытые для редактирования подсвечиваются желтеньким
      if not Column.ReadOnly then
        Brush.Color := $00AFFEFC
    end;

    // Зачеркиваем вынесеные из расцеки механизмы
    if (qrMechanizmFROM_RATE.AsInteger = 1) and(qrRatesExID_RATE.AsInteger > 0) then
    begin
      Font.Style := Font.Style + [fsStrikeOut];
      Brush.Color := $00DDDDDD
    end;

    // подсвечиваем замененный механизм
    if (qrMechanizmREPLACED.AsInteger = 1) then
    begin
      Brush.Color := $00DDDDDD;
    end;

    // Подсветка замененного механизма
    if (IdReplasedMech > 0) and (qrMechanizmID.AsInteger = IdReplasedMech) and
      (dbgrdMechanizm = LastEntegGrd)
    then
      Font.Style := Font.Style + [fsbold];

    // Подсветка замененяющего материала
    if (qrMechanizmFROM_RATE.AsInteger = 0) and
      (IdReplasingMech = qrMechanizmID_REPLACED.AsInteger) and
      (dbgrdMechanizm = LastEntegGrd) then
      Font.Style := Font.Style + [fsbold];

    Str := '';
    // Подсветка синим подшапок таблицы
    if qrMechanizmTITLE.AsInteger > 0 then
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

    if ((qrMechanizmFROM_RATE.AsInteger = 1) and (qrRatesExID_RATE.AsInteger > 0)) or
      (qrMechanizmREPLACED.AsInteger = 1) then
    begin
      if Column.Index in [4, 7, 8, 11, 12, 16, 17, 20, 21, 24] then
        Str := '';
    end;

    if gdFocused in State then // Ячейка в фокусе
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
var
  j: Integer;
  sdvig: string;
begin
  j := 2;
  with grRatesEx.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;
    if gdFocused in State then // Ячейка в фокусе
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    if qrRatesExID_TYPE_DATA.AsInteger = -3 then
      Brush.Color := clSilver;


    // Подсвечивается жирным только если есть фокус
    if Assigned(TMyDBGrid(grRatesEx).DataLink) and
      (grRatesEx.Row = TMyDBGrid(grRatesEx).DataLink.ActiveRecord + 1) and
      (grRatesEx = LastEntegGrd) then
    begin
      Font.Style := Font.Style + [fsbold];
    end;

    // Подсветка вынесенного и заменяющего материала за расценку материала
    // Вынесение за расценку имеет приоритет над заменой
    if btnMaterials.Down and qrMaterial.Active and (dbgrdMaterial = LastEntegGrd) then
    begin
      if (qrRatesExID_TABLES.AsInteger = qrMaterialID.AsInteger) and
        (qrRatesExID_TYPE_DATA.AsInteger = 2) then
        Font.Style := Font.Style + [fsbold];
    end;

    // Подсветка вынесенного за расценку механизма
    if btnMechanisms.Down and qrMechanizm.Active and (dbgrdMechanizm = LastEntegGrd) then
    begin
      if (qrRatesExID_TABLES.AsInteger = qrMechanizmID.AsInteger) and
        (qrRatesExID_TYPE_DATA.AsInteger = 3) then
        Font.Style := Font.Style + [fsbold];
    end;

    FillRect(Rect);

    TextOut(Rect.Left + j, Rect.Top + 2, sdvig + Column.Field.AsString);
  end;
end;

procedure TFormCalculationEstimate.dbgrdRatesEnter(Sender: TObject);
begin
  LastEntegGrd := TJvDBGrid(Sender);

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

  grRatesEx.ReadOnly := PanelCalculationYesNo.Tag = 0;
end;

end.
