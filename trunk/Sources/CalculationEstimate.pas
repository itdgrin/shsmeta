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
  JvDBGrid;

type
  TSplitter = class(ExtCtrls.TSplitter)
  private
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
    StringGridCalculations: TStringGrid;
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
    StringGridEquipments: TStringGrid;
    ImageNoData: TImage;
    LabelNoData1: TLabel;
    LabelNoData2: TLabel;
    PMAddAdditionTransportation�310: TMenuItem;
    PMAddAdditionTransportation�311: TMenuItem;
    PMAddAdditionLandfilling: TMenuItem;
    PMAddAdditionHeatingE18: TMenuItem;
    PMAddAdditionHeatingE20: TMenuItem;
    PMAddAdditionWinterPrice: TMenuItem;
    PopupMenuRatesAdd352: TMenuItem;
    PMMatFromRates: TMenuItem;
    PopupMenuMechanizms: TPopupMenu;
    PMMechFromRates: TMenuItem;
    PopupMenuEquipments: TPopupMenu;
    PMEqFromRates: TMenuItem;
    PMEqColumns: TMenuItem;
    PMMatReplace: TMenuItem;
    PMMatReplaceNumber: TMenuItem;
    PMMatReplaceTable: TMenuItem;
    PMAddAddition: TMenuItem;
    PMAddRatMatMechEquip: TMenuItem;
    PMAddRatMatMechEquipRef: TMenuItem;
    PMAddRatMatMechEquipOwn: TMenuItem;
    PMAddAdditionTransportation: TMenuItem;
    PMAddAdditionHeating: TMenuItem;
    PMAddAdditionDumps: TMenuItem;
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
    Memo1: TMemo;
    frSummaryCalculations: TfrCalculationEstimateSummaryCalculations;
    frSSR: TfrCalculationEstimateSSR;
    qrRates: TFDQuery;
    dsRates: TDataSource;
    dbgrdRates: TDBGrid;
    dbgrdDescription: TDBGrid;
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
    qrMechanizmPRICE_NO_NDS: TIntegerField;
    qrMechanizmPRICE_NDS: TIntegerField;
    qrMechanizmFPRICE_NO_NDS: TIntegerField;
    qrMechanizmFPRICE_NDS: TIntegerField;
    qrMechanizmRENT_PRICE_NO_NDS: TIntegerField;
    qrMechanizmRENT_PRICE_NDS: TIntegerField;
    qrMechanizmRENT_COAST_NO_NDS: TIntegerField;
    qrMechanizmRENT_COAST_NDS: TIntegerField;
    qrMechanizmRENT_COUNT: TFloatField;
    qrMechanizmMECH_KOEF: TFloatField;
    qrMechanizmNUM: TIntegerField;
    qrMechanizmMECH_SUM_NO_NDS: TIntegerField;
    qrMechanizmMECH_SUM_NDS: TIntegerField;
    HeaderControl1: THeaderControl;
    N8: TMenuItem;
    qrMechanizmSCROLL: TIntegerField;
    qrRatesCOUNTFORCALC: TFloatField;
    PMMechEdit: TMenuItem;
    qrMechanizmFZP_MACH_NO_NDS: TIntegerField;
    qrMechanizmFZP_MACH_NDS: TIntegerField;
    dbgrdMechanizm: TJvDBGrid;
    qrMechanizmNDS: TSmallintField;
    qrMechanizmRENT_NDS: TSmallintField;
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
    qrMaterialMAT_SUM_NO_NDS: TIntegerField;
    qrMaterialMAT_SUM_NDS: TIntegerField;
    qrMaterialCOAST_NO_NDS: TIntegerField;
    qrMaterialCOAST_NDS: TIntegerField;
    qrMaterialTRANSP_NO_NDS: TIntegerField;
    qrMaterialTRANS_NDS: TIntegerField;
    qrMaterialPRICE_NO_NDS: TIntegerField;
    qrMaterialPRICE_NDS: TIntegerField;
    qrMaterialNDS: TIntegerField;
    qrMaterialFCOAST_NO_NDS: TIntegerField;
    qrMaterialFCOAST_NDS: TIntegerField;
    qrMaterialFTRANSP_NO_NDS: TIntegerField;
    qrMaterialFTRANSP_NDS: TIntegerField;
    qrMaterialFPRICE_NO_NDS: TIntegerField;
    qrMaterialFPRICE_NDS: TIntegerField;
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
    procedure AddRate(RateNumber: String; Count: Double);
    procedure PopupMenuTableLeftTechnicalPartClick(Sender: TObject);

    // ������� ����������� ���� � ������ �������
    procedure PopupMenuCoefAddSetClick(Sender: TObject);
    procedure PopupMenuCoefDeleteSetClick(Sender: TObject);


    // ������� ������ ������
    procedure SpeedButtonDescriptionClick(Sender: TObject);
    procedure SpeedButtonMaterialsClick(Sender: TObject);
    procedure SpeedButtonMechanismsClick(Sender: TObject);

    //���������� ������� ������ ������ �� ��������� ������ � ������� ��������
    procedure GridRatesRowSellect;

    // ����� �������� �� ��� ������ �������
    procedure FillingTableMaterials(const vIdCardRate, vIdMat: Integer);
    procedure FillingTableMechanizm(const vIdCardRate, vIdMech: integer);
    procedure FillingTableDescription(const vIdNormativ: integer);

    procedure Calculation;

    procedure CalculationMaterial;

    procedure CalculationMechanizm;

    // ����� �������� � ������ �������
    procedure FillingCoeffBottomTable;

    // ���������� ������ ������������� � �������
    procedure FillingTableSetCoef;

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
    procedure SettingTablesFromFile(SG: TStringGrid);
    procedure ClearTable(SG: TStringGrid);
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
    procedure PopupMenuRatesAdd(Sender: TObject);
    procedure PMMatFromRatesClick(Sender: TObject);
    procedure TestFromRates(const SG: TStringGrid; const vCol, vRow: Integer);
    procedure CopyEstimate;
    procedure VisibleColumnsWinterPrice(Value: Boolean);
    procedure ReplacementNumber(Sender: TObject);
    procedure ReplacementMaterial(const vIdMat: Integer);

    procedure PMMatReplaceTableClick(Sender: TObject);
    procedure ShowFormAdditionData(const vDataBase: Char);
    procedure PMAddRatMatMechEquipRefClick(Sender: TObject);
    procedure PMAddRatMatMechEquipOwnClick(Sender: TObject);

    function GetPriceMaterial(): Variant;
    procedure PMEditClick(Sender: TObject);
    procedure PopupMenuMaterialsPopup(Sender: TObject);

    procedure PMCoefOrdersClick(Sender: TObject);
    procedure PopupMenuTableLeftPopup(Sender: TObject);
    // �������� ����������� �� �������� ���������
    procedure GetStateCoefOrdersInEstimate;
    procedure GetStateCoefOrdersInRate;
    // �������� ���� ��������� (��������� ��� �� ���������) ������������ �� ��������
    procedure PopupMenuCoefOrdersClick(Sender: TObject);
    procedure PopupMenuCoefPopup(Sender: TObject);
    procedure PanelTableBottomResize(Sender: TObject);
    procedure Button4Click(Sender: TObject);

    procedure OutputDataToTable(aState: integer); //���������� ������� ��������

    procedure AddMaterial(const vMatId: Integer);
    procedure AddMechanizm(const vMechId, vMonth, vYear: Integer);

    procedure PMMechFromRatesClick(Sender: TObject);
    procedure dbgrdRatesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure qrRatesBeforeScroll(DataSet: TDataSet);
    procedure qrRatesAfterScroll(DataSet: TDataSet);
    procedure qrRatesCOUNTChange(Sender: TField);
    procedure dbgrdDescriptionDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure qrDescriptionAfterScroll(DataSet: TDataSet);
    procedure qrMechanizmBeforeInsert(DataSet: TDataSet);
    procedure qrMechanizmAfterScroll(DataSet: TDataSet);
    procedure qrMechanizmCalcFields(DataSet: TDataSet);
    procedure qrRatesBeforeInsert(DataSet: TDataSet);
    procedure dbgrdMechanizmDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
    procedure dbgrdMaterialDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure PMMatEditClick(Sender: TObject);
    procedure dbgrdMaterialExit(Sender: TObject);
  private
    ActReadOnly: Boolean;

    CountCoef: Integer;
    RowCoefDefault: Boolean;
    NameRowCoefDefault: String;

    IdObject: Integer;
    IdEstimate: Integer;
    NDSEstimate: boolean; //������  � ��� ��� ���

    MonthEstimate: Integer;
    YearEstimate: Integer;

    VisibleRightTables: String; //��������� ����������� ������ ������� ������

    WCWinterPrice: Integer;
    WCSalaryWinterPrice: Integer;

    CountFromRate: Double;

    DataBase: Char;

    //����� ��������� �� ������ ��������, ��������� ������������ � ������������ �nChange;
    ReCalcMech, ReCalcMat: boolean;
    //ID ����������� ��������� ������� ���� ����������
    IdReplasedMat: integer;
    //ID ����������� ��������� ������� ���� ����������
    IdReplasingMat: integer;

    //������������� ��� ����������� � ������ � ������� ��������
    procedure ReCalcRowRates;

    //�������� ������� ��� ������ � ����������� �� ���
    procedure ChangeGrigNDSStyle(aNDS: boolean);
    //�������� ��� �������� ��������� � ������� ��������
    function CheckMatUnAccountingRates: boolean;
    //��������� ��� �������� ������ �������� (��������� ��� ����������)
    function CheckMatINRates: boolean;

    //�������� ��� �������� ��������� � ������� ����������
    function CheckMatUnAccountingMatirials: boolean;

    procedure ReCalcRowMat; //�������� ������ ���������
    procedure UpdateRowMat; //��������� ������ � �� ���������
    procedure ReCalcAllMat; //�������� ���� ���������
    function CheckMatReadOnly: boolean; //�������� ����� �� ������������� ������ ������
    procedure SetMatReadOnly(AValue: boolean); //������������� ����� ��������������
    procedure SetMatEditMode; //��������� ������ ������������ �������������� ����������
    procedure SetMatNoEditMode; //���������� ������ ������������ �������������� ����������

    procedure ReCalcRowMech; //�������� ������ ���������
    procedure UpdateRowMech; //��������� ������ � �� ����������
    procedure ReCalcAllMech; //�������� ���� ����������
    function CheckMechReadOnly: boolean; //�������� ����� �� ������������� ������ ������
    procedure SetMechReadOnly(AValue: boolean); //������������� ����� ��������������
    procedure SetMechEditMode; //��������� ������ ������������ �������������� ���������
    procedure SetMechNoEditMode; //���������� ������ ������������ �������������� ���������
  public
    Act: Boolean;
    IdAct: Integer;
    ConfirmCloseForm: Boolean;
    function GetCountCoef(): Integer;
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
    procedure Wheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);

  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;

  const
    Indent = '     ';

  end;

var
  FormCalculationEstimate: TFormCalculationEstimate;
  TwoValues: TTwoValues;

implementation

uses Main, DataModule, Columns, SignatureSSR, Waiting,
  SummaryCalculationSettings, DataTransfer, Coefficients,
  BasicData, ObjectsAndEstimates, PercentClientContractor, Transportation,
  CalculationDump, SaveEstimate,
  ReplacementMaterial, Materials, AdditionData, CardMaterial, CardDataEstimate,
  ListCollections, CoefficientOrders, KC6,
  CardAct, Tools;

{$R *.dfm}

{ TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
  FormCalculationEstimate.RepaintImagesForSplitters();
end;

procedure TFormCalculationEstimate.Wheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  with TDBGrid(Sender) do
  begin
    if Assigned(DataSource) then
     if Assigned(DataSource.DataSet)then
       if DataSource.DataSet.Active then
         DataSource.DataSet.MoveBy(-1*Sign(WheelDelta));
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

  if VisibleRightTables <> '1000' then
  begin
    VisibleRightTables := '1000';
    SettingVisibleRightTables;
  end;

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

  StringGridCalculations.Constraints.MinHeight := 50;
  PanelClientLeft.Constraints.MinWidth := 30;
  Memo1.Constraints.MinHeight := 45;
  MemoRight.Constraints.MinHeight := 45;

  // -----------------------------------------

  FillingOXROPR;

  SettingTablesFromFile(StringGridCalculations);

  FillingCoeffBottomTable; // ��������� ������ � ��������������

  ConfirmCloseForm := True;

  CountCoef := 1;
  RowCoefDefault := True;
  // ������ ������ � ������ ��������
  PanelTableBottom.Height := 110 + PanelBottom.Height;

  //��������� ����� DBGrid �������
  LoadDBGridSettings(dbgrdRates);
  LoadDBGridSettings(dbgrdMaterial);
  LoadDBGridSettings(dbgrdMechanizm);
  LoadDBGridSettings(dbgrdDescription);

 // TCustomDbGridCracker(dbgrdRates).OnMouseWheel:=Wheel;

  FormMain.CreateButtonOpenWindow(CaptionButtonCalculationEstimate, HintButtonCalculationEstimate,
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

    //������������� ���������� ������ �������
    frSummaryCalculations.LoadData(IdEstimate);

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

    //������������� ���������� ������ �������
    frSSR.LoadData(IdEstimate);

    PanelButtonsSSR.Align := alClient;

    // -----------------------------------------

    // ������ ������ �������� ������� ���� �����������
    BottomTopMenuEnabled(False);

    PanelCalculationYesNo.Enabled := False;
    PanelCalculationYesNo.Color := clSilver;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonMaterialsClick(Sender: TObject);
var s : string;
begin
  TestOnNoDataNew(qrMaterial);

  if SpeedButtonModeTables.Tag = 0 then s := '1000'
  else s := '1110';

  if s <> VisibleRightTables then
  begin
    VisibleRightTables := s;
    SettingVisibleRightTables;
    if qrMaterial.Active then qrMaterial.First;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonMechanismsClick(Sender: TObject);
var s : string;
begin
  TestOnNoDataNew(qrMechanizm);

  if SpeedButtonModeTables.Tag = 0 then s := '0100'
  else s := '1110';

  if s <> VisibleRightTables then
  begin
    VisibleRightTables := s;
    SettingVisibleRightTables;
    if qrMechanizm.Active then qrMechanizm.First;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonEquipmentsClick(Sender: TObject);
var s : string;
begin
  TestOnNoData(StringGridEquipments);

  if SpeedButtonModeTables.Tag = 0 then s := '0010'
  else s := '1110';

  if s <> VisibleRightTables then
  begin
    VisibleRightTables := s;
    SettingVisibleRightTables;
  end;

end;

procedure TFormCalculationEstimate.SpeedButtonDescriptionClick(Sender: TObject);
begin
  TestOnNoDataNew(qrDescription);

  if VisibleRightTables <> '0001' then
  begin
    VisibleRightTables := '0001';
    SettingVisibleRightTables;
    if qrDescription.Active then qrDescription.First;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonModeTablesClick(Sender: TObject);
var s : string;
begin
  with SpeedButtonModeTables do
  begin
    Glyph.Assign(nil);

    if Tag = 0 then
    begin
      Tag := 1;
      Hint := '����� ������ ������: ���������, ���������, ������������';
      DM.ImageListModeTables.GetBitmap(1, SpeedButtonModeTables.Glyph);
      s := '1110';
    end
    else
    begin
      Tag := 0;
      Hint := '����� ����� �������';
      DM.ImageListModeTables.GetBitmap(0, SpeedButtonModeTables.Glyph);
      s := '1000';
      if SpeedButtonMechanisms.Down then s := '0100';
      if SpeedButtonEquipments.Down then s := '0010';
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
  if VisibleRightTables = '0001' then
  begin
    dbgrdDescription.Columns[0].Width := dbgrdDescription.Width - 50;
  end
  else if VisibleRightTables = '1110' then
  begin
    H := PanelClientRightTables.Height - SplitterRight1.Height -
      SplitterRight2.Height;

    dbgrdMaterial.Height := H div 3;
    dbgrdMechanizm.Height := dbgrdMaterial.Height;
    StringGridEquipments.Height := dbgrdMaterial.Height;
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

procedure TFormCalculationEstimate.PanelTableBottomResize(Sender: TObject);
var
  AddWidth, i: Integer;
begin
  with StringGridCalculations do
    if GridWidth < ClientWidth then
    begin
      AddWidth := (ClientWidth - GridWidth) div (ColCount - 1);
      for i := 1 to ColCount - 1 do
        ColWidths[i] := ColWidths[i] + AddWidth;

      if GridWidth < ClientWidth then
        ColWidths[0] := ColWidths[0] + (ClientWidth - GridWidth);
    end;
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

  WidthButton := ((Sender as TPanel).Width div 2 - 30 - OffsetCenter - SpeedButtonModeTables.Width) div 4;
  // 24 = 6 * 5 (����������: ����� 4 � 5, 5 � 6, 6 � 7, 7 � 8, � �� ����� �����)

  SpeedButtonMaterials.Left := BevelTopMenu.Left + OffsetCenter;
  SpeedButtonMaterials.Width := WidthButton;

  SpeedButtonMechanisms.Left := SpeedButtonMaterials.Left + SpeedButtonMaterials.Width + 6;
  SpeedButtonMechanisms.Width := WidthButton;

  SpeedButtonEquipments.Left := SpeedButtonMechanisms.Left + SpeedButtonMaterials.Width + 6;
  SpeedButtonEquipments.Width := WidthButton;

  SpeedButtonDescription.Left := SpeedButtonEquipments.Left + SpeedButtonEquipments.Width + 6;
  SpeedButtonDescription.Width := WidthButton;

  SpeedButtonModeTables.Left := SpeedButtonDescription.Left + SpeedButtonDescription.Width + 6;
end;

// ������ ������ ������ ������ �������� ���� �����������
procedure TFormCalculationEstimate.BottomTopMenuEnabled(const Value: Boolean);
begin
  SpeedButtonDescription.Enabled := Value;
  SpeedButtonMaterials.Enabled := Value;
  SpeedButtonMechanisms.Enabled := Value;
  SpeedButtonEquipments.Enabled := Value;
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
  if qrDescription.IsEmpty then exit;

  if SpeedButtonDescription.Down then
    MemoRight.Text := qrDescription.FieldByName('work').AsString;
end;

//�������� ����� �� ������������� ������ ������
function TFormCalculationEstimate.CheckMechReadOnly: boolean;
begin
  Result := false;
  if (qrMechanizmFROM_RATE.AsInteger = 1) and not (qrRatesMEID.AsInteger > 0)
  then Result := true;
end;

procedure TFormCalculationEstimate.SetMechReadOnly(AValue: boolean); //������������� ����� ��������������
begin
  dbgrdMechanizm.ReadOnly := AValue;
end;

//�������� ����� �� ������������� ������ ������
function TFormCalculationEstimate.CheckMatReadOnly: boolean;
begin
  Result := false;
    //���������� �� ��������
  if ((qrMaterialFROM_RATE.AsInteger = 1) and not (qrRatesMID.AsInteger > 0))
     or
     //��������� ���������
     (CheckMatUnAccountingMatirials)
  then Result := true;
end;

//������������� ����� ��������������
procedure TFormCalculationEstimate.SetMatReadOnly(AValue: boolean);
begin
  dbgrdMaterial.ReadOnly := AValue;
end;

//��������� ������ ������������ �������������� ����������
procedure TFormCalculationEstimate.SetMatEditMode;
begin
  if CheckMatReadOnly then exit;
  dbgrdMaterial.Columns[2].ReadOnly := false; //�����
  dbgrdMaterial.Columns[5].ReadOnly := false; //% ����������
  dbgrdMaterial.Columns[6].ReadOnly := false; //��������
  dbgrdMaterial.Columns[7].ReadOnly := false; //��������
  dbgrdMaterial.Columns[12].ReadOnly := false; //���
  MemoRight.Color := $00AFFEFC;
  MemoRight.ReadOnly := false;
  MemoRight.Tag := 2; // Type_Data
  qrMaterial.Tag := 1;
end;

//���������� ������ ������������ �������������� ����������
procedure TFormCalculationEstimate.SetMatNoEditMode;
begin
  if qrMaterial.Tag = 1 then
  begin
    dbgrdMaterial.Columns[2].ReadOnly := true; //�����
    dbgrdMaterial.Columns[5].ReadOnly := true; //% ����������
    dbgrdMaterial.Columns[6].ReadOnly := true; //��������
    dbgrdMaterial.Columns[7].ReadOnly := true; //��������
    dbgrdMaterial.Columns[12].ReadOnly := true; //���
    MemoRight.Color := clWindow;
    MemoRight.ReadOnly := true;
    MemoRight.Tag := 0;
    qrMaterial.Tag := 0;
  end;
end;

procedure TFormCalculationEstimate.qrMaterialAfterScroll(DataSet: TDataSet);
begin
  //�� ������ ������, ���-�� �������� ������
  if qrMaterial.IsEmpty then exit;

  if not ReCalcMat then
  begin
    if qrMaterialTITLE.AsInteger > 0 then
      if dbgrdMaterial.Tag > qrMaterial.RecNo then qrMaterial.Prior
      else qrMaterial.Next;

    SetMatReadOnly(CheckMatReadOnly);
    dbgrdRates.Repaint;

    IdReplasedMat := qrMaterialID_REPLACED.AsInteger;
    IdReplasingMat := qrMaterialID.AsInteger;

    DataSet.Edit;
    qrMaterialSCROLL.AsInteger := 1;
    DataSet.Post;

    if SpeedButtonMaterials.Down then
      MemoRight.Text := qrMaterialMAT_NAME.AsString;
  end;
end;

procedure TFormCalculationEstimate.qrMaterialBeforeScroll(DataSet: TDataSet);
begin
  if qrMaterial.IsEmpty then exit;

  if not ReCalcMat then
  begin
    //���������� ����� ������������ ��� ���������� ����������� �������� �� �������
    dbgrdMaterial.Tag := qrMaterial.RecNo;

    DataSet.Edit;
    qrMaterialSCROLL.AsInteger := 0;
    DataSet.Post;

    //�������� �������� �� �������������� ������
    SetMatNoEditMode;
  end;
end;


procedure TFormCalculationEstimate.MatRowChange(Sender: TField);
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    exit;
  end;

  if not ReCalcMat then
  begin
    ReCalcMat := true;
    //�������� �� ������ ���������
    try
      //�������������� ��������� ��� ���������� �����
      if Sender.FieldName = 'MAT_PROC_PODR' then
      begin
        if qrMaterialMAT_PROC_PODR.AsInteger > 100 then
          qrMaterialMAT_PROC_PODR.AsInteger := 100;

        if qrMaterialMAT_PROC_PODR.AsInteger < 0 then
          qrMaterialMAT_PROC_PODR.AsInteger := 0;

        qrMaterialMAT_PROC_ZA�.AsInteger := 100 - qrMaterialMAT_PROC_PODR.AsInteger;
      end;

      if Sender.FieldName = 'MAT_PROC_ZA�' then
      begin
        if qrMaterialMAT_PROC_ZA�.AsInteger > 100 then
          qrMaterialMAT_PROC_ZA�.AsInteger := 100;

        if qrMaterialMAT_PROC_ZA�.AsInteger < 0 then
          qrMaterialMAT_PROC_ZA�.AsInteger := 0;

        qrMaterialMAT_PROC_PODR.AsInteger := 100 -
          qrMaterialMAT_PROC_ZA�.AsInteger;
      end;

      if Sender.FieldName = 'TRANSP_PROC_PODR' then
      begin
        if qrMaterialTRANSP_PROC_PODR.AsInteger > 100 then
          qrMaterialTRANSP_PROC_PODR.AsInteger := 100;

        if qrMaterialTRANSP_PROC_PODR.AsInteger < 0 then
          qrMaterialTRANSP_PROC_PODR.AsInteger := 0;

        qrMaterialTRANSP_PROC_ZAC.AsInteger := 100 -
          qrMaterialTRANSP_PROC_PODR.AsInteger;
      end;

      if Sender.FieldName = 'TRANSP_PROC_ZAC' then
      begin
        if qrMaterialTRANSP_PROC_ZAC.AsInteger > 100 then
          qrMaterialTRANSP_PROC_ZAC.AsInteger := 100;

        if qrMaterialTRANSP_PROC_ZAC.AsInteger < 0 then
          qrMaterialTRANSP_PROC_ZAC.AsInteger := 0;

        qrMaterialTRANSP_PROC_PODR.AsInteger := 100 -
          qrMaterialTRANSP_PROC_ZAC.AsInteger;
      end;

      //�������� �� ������ ���������
      ReCalcRowMat;
      //����� ��������� ������ ������ ��������������� � �����������
      qrMaterial.Post;
      //��������� � ����
      UpdateRowMat;
    finally
      ReCalcMat := false;
    end;
  end;
end;

procedure TFormCalculationEstimate.qrMechanizmAfterScroll(DataSet: TDataSet);
begin
  if qrMechanizm.IsEmpty then exit;

  if not ReCalcMech then
  begin
    SetMechReadOnly(CheckMechReadOnly);
    dbgrdRates.Repaint;

    DataSet.Edit;
    qrMechanizmSCROLL.AsInteger := 1;
    DataSet.Post;

    if SpeedButtonMechanisms.Down then
      MemoRight.Text := qrMechanizmMECH_NAME.AsString;
  end;
end;

procedure TFormCalculationEstimate.qrMechanizmBeforeInsert(DataSet: TDataSet);
begin
  Abort; //������ ���������� ����� ������ � ������ ��������
end;

procedure TFormCalculationEstimate.qrMechanizmBeforeScroll(DataSet: TDataSet);
begin
  if qrMechanizm.IsEmpty then exit;

  if not ReCalcMech then
  begin

    DataSet.Edit;
    qrMechanizmSCROLL.AsInteger := 0;
    DataSet.Post;
    //�������� �������� �� �������������� ������
    SetMechNoEditMode;
  end;
end;

procedure TFormCalculationEstimate.qrMechanizmCalcFields(DataSet: TDataSet);
begin
  //���� ��������� ��� ������� ����������
  if DataSet.Bof then qrMechanizmNUM.AsInteger := 1
  else qrMechanizmNUM.AsInteger := DataSet.RecNo;
end;


//��������� ���� null � �������� ���� ������� �����
procedure TFormCalculationEstimate.MechRowChange(Sender: TField);
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    exit;
  end;

  if not ReCalcMech then
  begin
    ReCalcMech := true;
    //�������� �� ������ ���������
    try
      //�������������� ��������� ��� ���������� �����
      if Sender.FieldName = 'PROC_PODR' then
      begin
        if qrMechanizmPROC_PODR.AsInteger > 100 then
          qrMechanizmPROC_PODR.AsInteger := 100;

        if qrMechanizmPROC_PODR.AsInteger < 0 then
          qrMechanizmPROC_PODR.AsInteger := 0;

        qrMechanizmPROC_ZAC.AsInteger := 100 - qrMechanizmPROC_PODR.AsInteger;
      end;

      if Sender.FieldName = 'PROC_ZAC' then
      begin
        if qrMechanizmPROC_ZAC.AsInteger > 100 then
          qrMechanizmPROC_ZAC.AsInteger := 100;

        if qrMechanizmPROC_ZAC.AsInteger < 0 then
          qrMechanizmPROC_ZAC.AsInteger := 0;

        qrMechanizmPROC_PODR.AsInteger := 100 - qrMechanizmPROC_ZAC.AsInteger;
      end;
      //�������� �� ������ ���������
      ReCalcRowMech;
      //����� ��������� ������ ������ ��������������� � �����������
      qrMechanizm.Post;
      //��������� � ����( �� ��������� ��� ��� qrMechanizm �������� ������ �������� ���������� )
      //UpdateRowMech;
    finally
      ReCalcMech := false;
    end;
  end;
end;

procedure TFormCalculationEstimate.MemoRightChange(Sender: TObject);
begin
  if not MemoRight.ReadOnly then
  begin
    //����������� �������� ���������, ���������....
    //������ ����� ������ sql
    case MemoRight.Tag of
      2:
      begin
        qrMaterial.Edit;
        qrMaterialMAT_NAME.AsString := MemoRight.Text;
        qrMaterial.Post;
        qrTemp.SQL.Text := 'UPDATE materialcard_temp set ' +
          'MAT_NAME=:MAT_NAME WHERE ID=:ID;';
        qrTemp.ParamByName('ID').AsInteger := qrMaterialID.AsInteger;
        qrTemp.ParamByName('MAT_NAME').AsString := MemoRight.Text;
        qrTemp.ExecSQL;
      end;
      3:
      begin
        qrMechanizm.Edit;
        qrMechanizmMECH_NAME.AsString := MemoRight.Text;
        qrMechanizm.Post;

        {qrTemp.SQL.Text := 'UPDATE mechanizmcard_temp set ' +
          'MECH_NAME=:MECH_NAME WHERE ID=:ID;';
        qrTemp.ParamByName('ID').AsInteger := qrMechanizmID.AsInteger;
        qrTemp.ParamByName('MECH_NAME').AsString := MemoRight.Text;
        qrTemp.ExecSQL;  }
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
  end;
end;

//������������� ������ �� ������ � ������� ����������
procedure TFormCalculationEstimate.ReCalcRowMech;
begin
  qrMechanizmMECH_COUNT.AsFloat :=
    qrMechanizmMECH_NORMA.AsFloat * qrRatesCOUNTFORCALC.AsFloat *
    qrMechanizmMECH_KOEF.AsFloat;

  qrMechanizmPRICE_NO_NDS.AsInteger :=
    Round(qrMechanizmMECH_COUNT.AsFloat * qrMechanizmCOAST_NO_NDS.AsInteger) +
    qrMechanizmZP_MACH_NO_NDS.AsInteger;

  qrMechanizmPRICE_NDS.AsInteger :=
    Round(qrMechanizmMECH_COUNT.AsFloat * qrMechanizmCOAST_NDS.AsInteger) +
    qrMechanizmZP_MACH_NDS.AsInteger;

  //%��� ����� ������ 20%
  if NDSEstimate then
  begin
    qrMechanizmFCOAST_NO_NDS.AsInteger :=
      Round(qrMechanizmFCOAST_NDS.AsInteger /
      (1.000000 + 0.010000 * qrMechanizmNDS.AsInteger));

    qrMechanizmFZP_MACH_NO_NDS.AsInteger :=
      Round(qrMechanizmFZP_MACH_NDS.AsInteger /
      (1.000000 + 0.010000 * qrMechanizmNDS.AsInteger));

    qrMechanizmRENT_PRICE_NO_NDS.AsInteger :=
      Round(qrMechanizmRENT_PRICE_NDS.AsInteger /
      (1.000000 + 0.010000 * qrMechanizmRENT_NDS.AsInteger));
  end
  else
  begin
    qrMechanizmFCOAST_NDS.AsInteger :=
      Round(qrMechanizmFCOAST_NO_NDS.AsInteger *
      (1.000000 + 0.010000 * qrMechanizmNDS.AsInteger));

    qrMechanizmFZP_MACH_NDS.AsInteger :=
      Round(qrMechanizmFZP_MACH_NO_NDS.AsInteger *
      (1.000000 + 0.010000 * qrMechanizmNDS.AsInteger));

    qrMechanizmRENT_PRICE_NDS.AsInteger :=
      Round(qrMechanizmRENT_PRICE_NO_NDS.AsInteger *
      (1.000000 + 0.010000 * qrMechanizmRENT_NDS.AsInteger));
  end;

  qrMechanizmFPRICE_NO_NDS.AsInteger :=
    Round(qrMechanizmMECH_COUNT.AsFloat * qrMechanizmFCOAST_NO_NDS.AsInteger) +
    qrMechanizmFZP_MACH_NO_NDS.AsInteger;

  qrMechanizmFPRICE_NDS.AsInteger :=
    Round(qrMechanizmMECH_COUNT.AsFloat * qrMechanizmFCOAST_NDS.AsInteger) +
    qrMechanizmFZP_MACH_NDS.AsInteger;

  //���� ������ ������. ���������� ��, ���� ��� �� �������
  if qrMechanizmFPRICE_NO_NDS.AsInteger > 0 then
  begin
    qrMechanizmMECH_SUM_NO_NDS.AsInteger :=
      qrMechanizmFPRICE_NO_NDS.AsInteger + qrMechanizmRENT_PRICE_NO_NDS.AsInteger;
    qrMechanizmMECH_SUM_NDS.AsInteger :=
      qrMechanizmFPRICE_NDS.AsInteger + qrMechanizmRENT_PRICE_NDS.AsInteger;
  end
  else
  begin
    qrMechanizmMECH_SUM_NO_NDS.AsInteger :=
      qrMechanizmPRICE_NO_NDS.AsInteger + qrMechanizmRENT_PRICE_NO_NDS.AsInteger;
    qrMechanizmMECH_SUM_NDS.AsInteger :=
      qrMechanizmPRICE_NDS.AsInteger + qrMechanizmRENT_PRICE_NDS.AsInteger;
  end;
end;

//��������� ������ � �� �� ������� ����������
procedure TFormCalculationEstimate.UpdateRowMech;
begin
  with qrTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE mechanizmcard_temp SET MECH_NORMA = :MECH_NORMA, ' +
      'MECH_COUNT = :MECH_COUNT, COAST_NO_NDS = :COAST_NO_NDS, ' +
      'COAST_NDS = :COAST_NDS, NDS = :NDS, ZP_MACH_NO_NDS = :ZP_MACH_NO_NDS, ' +
      'ZP_MACH_NDS = :ZP_MACH_NDS, FCOAST_NO_NDS = :FCOAST_NO_NDS, ' +
      'FCOAST_NDS = :FCOAST_NDS, PRICE_NO_NDS = :PRICE_NO_NDS, PRICE_NDS = :PRICE_NDS, ' +
      'FPRICE_NO_NDS = :FPRICE_NO_NDS, FPRICE_NDS = :FPRICE_NDS, ' +
      'RENT_PRICE_NO_NDS = :RENT_PRICE_NO_NDS, RENT_PRICE_NDS = :RENT_PRICE_NDS, ' +
      'RENT_NDS = :RENT_NDS, RENT_COAST_NO_NDS = :RENT_COAST_NO_NDS, ' +
      'RENT_COAST_NDS = :RENT_COAST_NDS, RENT_COUNT = :RENT_COUNT, ' +
      'MECH_KOEF = :MECH_KOEF, MECH_SUM_NO_NDS = :MECH_SUM_NO_NDS, ' +
      'MECH_SUM_NDS = :MECH_SUM_NDS WHERE id = :id;');
    ParamByName('MECH_NORMA').Value := qrMechanizmMECH_NORMA.Value;
    ParamByName('MECH_COUNT').Value := qrMechanizmMECH_COUNT.Value;
    ParamByName('COAST_NO_NDS').Value := qrMechanizmCOAST_NO_NDS.Value;
    ParamByName('COAST_NDS').Value := qrMechanizmCOAST_NDS.Value;
    ParamByName('NDS').Value := qrMechanizmNDS.Value;
    ParamByName('ZP_MACH_NO_NDS').Value := qrMechanizmZP_MACH_NO_NDS.Value;
    ParamByName('ZP_MACH_NDS').Value := qrMechanizmZP_MACH_NDS.Value;
    ParamByName('FCOAST_NO_NDS').Value := qrMechanizmFCOAST_NO_NDS.Value;
    ParamByName('FCOAST_NDS').Value := qrMechanizmFCOAST_NDS.Value;
    ParamByName('PRICE_NO_NDS').Value := qrMechanizmPRICE_NO_NDS.Value;
    ParamByName('PRICE_NDS').Value := qrMechanizmPRICE_NDS.Value;
    ParamByName('FPRICE_NO_NDS').Value := qrMechanizmFPRICE_NO_NDS.Value;
    ParamByName('FPRICE_NDS').Value := qrMechanizmFPRICE_NDS.Value;
    ParamByName('RENT_PRICE_NO_NDS').Value := qrMechanizmRENT_PRICE_NO_NDS.Value;
    ParamByName('RENT_PRICE_NDS').Value := qrMechanizmRENT_PRICE_NDS.Value;
    ParamByName('RENT_NDS').Value := qrMechanizmRENT_NDS.Value;
    ParamByName('RENT_COAST_NO_NDS').Value := qrMechanizmRENT_COAST_NO_NDS.Value;
    ParamByName('RENT_COAST_NDS').Value := qrMechanizmRENT_COAST_NDS.Value;
    ParamByName('RENT_COUNT').Value := qrMechanizmRENT_COUNT.Value;
    ParamByName('MECH_KOEF').Value := qrMechanizmMECH_KOEF.Value;
    ParamByName('MECH_SUM_NO_NDS').Value := qrMechanizmMECH_SUM_NO_NDS.Value;
    ParamByName('MECH_SUM_NDS').Value := qrMechanizmMECH_SUM_NDS.Value;
    ParamByName('id').Value := qrMechanizmID.Value;
    ExecSQL;
  end;
end;

//������������� ��� ������ � ������� ����������
procedure TFormCalculationEstimate.ReCalcAllMech;
var RecNo: integer;
begin
  if not qrMechanizm.Active then exit;

  RecNo := qrMechanizm.RecNo;
  ReCalcMech := true;
  //�������� �� ������ ���������
  try
    qrMechanizm.DisableControls;
    qrMechanizm.First;
    while not qrMechanizm.Eof do
    begin
      //���������� �� �������� �� ��������������
      if (qrMechanizmFROM_RATE.AsInteger = 1) and
         (qrRatesMEID.AsInteger = 0) then
      begin
        qrMechanizm.Next;
        Continue;
      end;

      qrMechanizm.Edit;
      ReCalcRowMech;
      qrMechanizm.Post;
      //UpdateRowMech;

      qrMechanizm.Next;
    end;
    qrMechanizm.RecNo := RecNo;
  finally
    ReCalcMech := false;
    qrMechanizm.EnableControls;
  end;
end;

//�������� ������ ���������
procedure TFormCalculationEstimate.ReCalcRowMat;
begin
  //��� ��������� ������ ���� ������ ������� qrRates, �������� ��� ��� � ����
  //���-�� ��������� ������ � ����������� (�����������...)
  qrMaterialMAT_COUNT.AsFloat :=
    qrMaterialMAT_NORMA.AsFloat * qrRatesCOUNTFORCALC.AsFloat *
    qrMaterialMAT_KOEF.AsFloat;

  qrMaterialTRANSP_NO_NDS.AsInteger :=
    Round(qrMaterialPROC_TRANSP.AsFloat * qrMaterialCOAST_NO_NDS.AsInteger);

  qrMaterialTRANS_NDS.AsInteger :=
    Round(qrMaterialPROC_TRANSP.AsFloat * qrMaterialCOAST_NDS.AsInteger);

  qrMaterialPRICE_NO_NDS.AsInteger :=
    Round(qrMaterialMAT_COUNT.AsFloat * qrMaterialCOAST_NO_NDS.AsInteger) +
    qrMaterialTRANSP_NO_NDS.AsInteger;

  qrMaterialPRICE_NDS.AsInteger :=
    Round(qrMaterialMAT_COUNT.AsFloat * qrMaterialCOAST_NDS.AsInteger) +
    qrMaterialTRANS_NDS.AsInteger;

  if NDSEstimate then
  begin
    qrMaterialFCOAST_NO_NDS.AsInteger :=
      Round(qrMaterialFCOAST_NDS.AsInteger /
      (1.000000 + 0.010000 * qrMaterialNDS.AsInteger));

    qrMaterialFTRANSP_NO_NDS.AsInteger :=
      Round(qrMaterialFTRANSP_NDS.AsInteger /
      (1.000000 + 0.010000 * qrMaterialNDS.AsInteger));
  end
  else
  begin
    qrMaterialFCOAST_NDS.AsInteger :=
      Round(qrMaterialFCOAST_NO_NDS.AsInteger *
      (1.000000 + 0.010000 * qrMaterialNDS.AsInteger));

    qrMaterialFTRANSP_NDS.AsInteger :=
      Round(qrMaterialFTRANSP_NO_NDS.AsInteger *
      (1.000000 + 0.010000 * qrMaterialNDS.AsInteger));
  end;

  qrMaterialFPRICE_NO_NDS.AsInteger :=
    Round(qrMaterialMAT_COUNT.AsFloat * qrMaterialFCOAST_NO_NDS.AsInteger) +
    qrMaterialFTRANSP_NO_NDS.AsInteger;

  qrMaterialFPRICE_NDS.AsInteger :=
    Round(qrMaterialMAT_COUNT.AsFloat * qrMaterialFCOAST_NDS.AsInteger) +
    qrMaterialFTRANSP_NDS.AsInteger;

  //���� ������ ������. ���������� ��, ���� ��� �� �������
  if qrMaterialFPRICE_NO_NDS.AsInteger > 0 then
  begin
    qrMaterialMAT_SUM_NO_NDS.AsInteger := qrMaterialFPRICE_NO_NDS.AsInteger;
    qrMaterialMAT_SUM_NDS.AsInteger := qrMaterialFPRICE_NDS.AsInteger;
  end
  else
  begin
    qrMaterialMAT_SUM_NO_NDS.AsInteger := qrMaterialPRICE_NO_NDS.AsInteger;
    qrMaterialMAT_SUM_NDS.AsInteger := qrMaterialPRICE_NDS.AsInteger;
  end;
end;

//��������� ������ � �� ���������
procedure TFormCalculationEstimate.UpdateRowMat;
begin
  with qrTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE materialcard_temp SET MAT_NORMA = :MAT_NORMA, ' +
      'MAT_COUNT = :MAT_COUNT, COAST_NO_NDS = :COAST_NO_NDS, ' +
      'COAST_NDS = :COAST_NDS, NDS = :NDS, PROC_TRANSP = :PROC_TRANSP, ' +
      'TRANSP_NO_NDS = :TRANSP_NO_NDS, TRANS_NDS = :TRANS_NDS, ' +
      'PRICE_NO_NDS = :PRICE_NO_NDS, PRICE_NDS = :PRICE_NDS, ' +
      'FCOAST_NO_NDS = :FCOAST_NO_NDS, FCOAST_NDS = :FCOAST_NDS, ' +
      'FTRANSP_NO_NDS = :FTRANSP_NO_NDS, FTRANSP_NDS = :FTRANSP_NDS, ' +
      'FPRICE_NO_NDS = :FPRICE_NO_NDS, FPRICE_NDS = :FPRICE_NDS, ' +
      'MAT_PROC_ZA� = :MAT_PROC_ZA�, MAT_PROC_PODR = :MAT_PROC_PODR, ' +
      'TRANSP_PROC_ZAC = :TRANSP_PROC_ZAC, TRANSP_PROC_PODR = :TRANSP_PROC_PODR, ' +
      'MAT_KOEF = :MAT_KOEF, MAT_SUM_NO_NDS = :MAT_SUM_NO_NDS, ' +
      'MAT_SUM_NDS = :MAT_SUM_NDS WHERE id = :id;');
    ParamByName('MAT_NORMA').Value := qrMaterialMAT_NORMA.Value;
    ParamByName('MAT_COUNT').Value := qrMaterialMAT_COUNT.Value;
    ParamByName('COAST_NO_NDS').Value := qrMaterialCOAST_NO_NDS.Value;
    ParamByName('COAST_NDS').Value := qrMaterialCOAST_NDS.Value;
    ParamByName('NDS').Value := qrMaterialNDS.Value;
    ParamByName('PROC_TRANSP').Value := qrMaterialPROC_TRANSP.Value;
    ParamByName('TRANSP_NO_NDS').Value := qrMaterialTRANSP_NO_NDS.Value;
    ParamByName('TRANS_NDS').Value := qrMaterialTRANS_NDS.Value;
    ParamByName('PRICE_NO_NDS').Value := qrMaterialPRICE_NO_NDS.Value;
    ParamByName('PRICE_NDS').Value := qrMaterialPRICE_NDS.Value;
    ParamByName('FCOAST_NO_NDS').Value := qrMaterialFCOAST_NO_NDS.Value;
    ParamByName('FCOAST_NDS').Value := qrMaterialFCOAST_NDS.Value;
    ParamByName('FTRANSP_NO_NDS').Value := qrMaterialFTRANSP_NO_NDS.Value;
    ParamByName('FTRANSP_NDS').Value := qrMaterialFTRANSP_NDS.Value;
    ParamByName('FPRICE_NO_NDS').Value := qrMaterialFPRICE_NO_NDS.Value;
    ParamByName('FPRICE_NDS').Value := qrMaterialFPRICE_NDS.Value;
    ParamByName('MAT_PROC_ZA�').Value := qrMaterialMAT_PROC_ZA�.Value;
    ParamByName('MAT_PROC_PODR').Value := qrMaterialMAT_PROC_PODR.Value;
    ParamByName('TRANSP_PROC_ZAC').Value := qrMaterialTRANSP_PROC_ZAC.Value;
    ParamByName('TRANSP_PROC_PODR').Value := qrMaterialTRANSP_PROC_PODR.Value;
    ParamByName('MAT_KOEF').Value := qrMaterialMAT_KOEF.Value;
    ParamByName('MAT_SUM_NO_NDS').Value := qrMaterialMAT_SUM_NO_NDS.Value;
    ParamByName('MAT_SUM_NDS').Value := qrMaterialMAT_SUM_NDS.Value;
    ParamByName('id').Value := qrMaterialID.Value;
    ExecSQL;
  end;
end;

//�������� ���� ���������
procedure TFormCalculationEstimate.ReCalcAllMat;
var RecNo: integer;
    s: string;
begin
  if not qrMaterial.Active then exit;

  RecNo := qrMaterial.RecNo;
  ReCalcMat := true;
  //�������� �� ������ ���������
  try
    qrMaterial.DisableControls;
    qrMaterial.First;
    while not qrMaterial.Eof do
    begin
      //���������� �� �������� �� �������������� � ������������ ��������� � ���������
      if ((qrMaterialFROM_RATE.AsInteger = 1) and (qrRatesMID.AsInteger = 0)) or
         (qrMaterialTITLE.AsInteger > 0) or
          CheckMatUnAccountingMatirials then
      begin
        qrMaterial.Next;
        continue;
      end;

      qrMaterial.Edit;
      ReCalcRowMat;
      qrMaterial.Post;
      UpdateRowMat;

      qrMaterial.Next;
    end;
    qrMaterial.RecNo := RecNo;
  finally
    ReCalcMat := false;
    qrMaterial.EnableControls;
  end;
end;

//�������� �� ��������� �������� ��� ����������
function TFormCalculationEstimate.CheckMatUnAccountingRates: boolean;
begin
  Result := ((qrRatesMID.AsInteger > 0) and
             (qrRatesCONSIDERED.AsInteger = 0) and
             (qrRatesREPLACED.AsInteger = 0));
end;

function TFormCalculationEstimate.CheckMatINRates: boolean;
begin
   Result := CheckMatUnAccountingRates or
             ((qrRatesMID.AsInteger > 0) and
              (qrRatesID_REPLACED.AsInteger > 0));
end;

//�������� ��� �������� ��������� � ������� ����������
function TFormCalculationEstimate.CheckMatUnAccountingMatirials: boolean;
begin
  Result := qrMaterialCONSIDERED.AsInteger = 0;
end;

procedure TFormCalculationEstimate.qrRatesAfterScroll(DataSet: TDataSet);
begin
  //��� ����������� �� ������, ��� ��������� �� qrRates
  //��� ����� ������ �����������, ���-�� ��������� ��������� �������� �����������
  //�������� �������� �� ������ ������ ��������
  qrMaterial.Active := false;
  qrMechanizm.Active := false;
  qrDescription.Active := false;

  //�� ������ ������, ���-�� �������� ������
  if qrRates.IsEmpty then exit;

  //��������� ������ ��������, ���� � ����� ����������� ������ � qrRates
  if qrRates.Tag <> 1 then
  begin
    //� ������ ���������� ������ ������������� ���, � �� ����������
    qrRatesCOUNT.ReadOnly := DataSet.Eof;
    qrRatesCODE.ReadOnly := not DataSet.Eof;

    //���� ��� ��������, ����� ��� ������, ������ ������ ��� ������
    if DataSet.Eof then
    begin
      SpeedButtonMaterials.Enabled := false;
      SpeedButtonMechanisms.Enabled := false;
      SpeedButtonEquipments.Enabled := false;
      SpeedButtonDescription.Enabled := false;
      TestOnNoDataNew(qrMaterial);
      exit;
    end;

    DataSet.Edit;
    //��������� ������������� ���-�� ��� ���������� � ���������� ����������
    qrRatesCOUNT.ReadOnly := CheckMatINRates;
    //������������� �������� ��� ��������� ������ ������ � dbgrdRates
    qrRatesSCROLL.AsInteger := 1;
    DataSet.Post;
    //��������� ������� ������
    GridRatesRowSellect;
  end;
end;

procedure TFormCalculationEstimate.qrRatesBeforeInsert(DataSet: TDataSet);
begin
  if not DataSet.Eof then abort;
end;

procedure TFormCalculationEstimate.qrRatesBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert] then
  begin
    DataSet.Cancel;
    abort;
  end;
end;

procedure TFormCalculationEstimate.qrRatesBeforeScroll(DataSet: TDataSet);
begin
  //�� ������ ������, ���-�� �������� ������
  if qrRates.IsEmpty then exit;

  if qrRates.Tag <> 1 then
  begin
    if DataSet.Eof then exit;

    DataSet.Edit;
    qrRatesSCROLL.AsInteger := 0;
    DataSet.Post;
  end;
end;

procedure TFormCalculationEstimate.qrRatesCOUNTChange(Sender: TField);
var RCount: real;
    RecNo: integer;
begin
  if Sender.IsNull then
  begin
    Sender.AsInteger := 0;
    exit;
  end;

  //��������� ����� ��� �������
  RecNo := qrRates.RecNo;
  RCount := Sender.AsFloat;
  qrRatesCOUNTFORCALC.AsFloat := RCount;
  qrRates.Post;
  //��� ������� ��������� COUNTFORCALC � � ���������� ��� ���������� ����������
  if qrRatesTYPE_DATA.AsInteger = 1 then
  begin
    qrRates.Tag := 1; //��������� ����������� ������� ��������
    qrRates.DisableControls;
    try
    if not qrRates.Eof then qrRates.Next;
    while not qrRates.Eof do
    begin
      if CheckMatINRates then
      begin
        qrRates.Edit;
        qrRatesCOUNTFORCALC.AsFloat := RCount;
        qrRates.Post;
      end
      else Break; //��� ��� ������� ������������
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
  else
  begin
    showmessage('������ ���������� �� ����������!');
  end;
  end;
  ReCalcRowRates;
end;

//������������� ��� ����������� � ������ � ������� ��������
procedure TFormCalculationEstimate.ReCalcRowRates;
begin
  ReCalcAllMat;
  ReCalcAllMech;
end;

procedure TFormCalculationEstimate.N3Click(Sender: TObject);
begin
  FormSummaryCalculationSettings.ShowModal;
end;

procedure TFormCalculationEstimate.PMCoefOrdersClick(Sender: TObject);
begin
  //FormCoefficientOrders.ShowForm(IdEstimate, RateId, 0);
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
begin
  FormReplacementMaterial.SetDataBase('g');
  FormReplacementMaterial.ShowModal;
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

    OutputDataToTable(0);
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ��������� �� �������� �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;
//�������� ������� ���������� �� ��������������
procedure TFormCalculationEstimate.PMMechEditClick(Sender: TObject);
begin
  SetMechEditMode;
end;
//��������� ������ ������������ �������������� ���������
procedure TFormCalculationEstimate.SetMechEditMode;
begin
  if CheckMechReadOnly then exit;
  dbgrdMechanizm.Columns[2].ReadOnly := false; //�����
  dbgrdMechanizm.Columns[5].ReadOnly := false; //�� ���������
  dbgrdMechanizm.Columns[6].ReadOnly := false; //�� ���������
  dbgrdMechanizm.Columns[7].ReadOnly := false; //��������
  dbgrdMechanizm.Columns[8].ReadOnly := false; //��������
  dbgrdMechanizm.Columns[11].ReadOnly := false; //���
  MemoRight.Color := $00AFFEFC;
  MemoRight.ReadOnly := false;
  MemoRight.Tag := 3;
  qrMechanizm.Tag := 1;
end;
//���������� ������ ������������ �������������� ���������
procedure TFormCalculationEstimate.SetMechNoEditMode;
begin
  if qrMechanizm.Tag = 1 then
  begin
    dbgrdMechanizm.Columns[2].ReadOnly := true; //�����
    dbgrdMechanizm.Columns[5].ReadOnly := true; //�� ���������
    dbgrdMechanizm.Columns[6].ReadOnly := true; //�� ���������
    dbgrdMechanizm.Columns[7].ReadOnly := true; //��������
    dbgrdMechanizm.Columns[8].ReadOnly := true; //��������
    dbgrdMechanizm.Columns[11].ReadOnly := true; //���
    MemoRight.Color := clWindow;
    MemoRight.ReadOnly := true;
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

    OutputDataToTable(0);
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

procedure TFormCalculationEstimate.GridRatesRowSellect;
var
  i: Integer;
  vIdNormativ: string;
  VAT, vClass, Distance, More, Mass, IdDump, Count: Integer;
  TwoValuesSalary, TwoValuesEMiM: TTwoValues;
  CalcPrice: string[2];
  BtnChange: boolean; //������� ��������� �������� ������
begin
  //����� �������� ��������(��� ���������.....) � ���� ��� ��������
  Memo1.Text := qrRatesCAPTION.AsString;

  // ��������� ���� ������ � ���������� ������
  if qrRatesTYPE_DATA.AsInteger > 0 then
    ComboBoxTypeData.ItemIndex :=
      qrRatesTYPE_DATA.AsInteger - 1
  else
    ComboBoxTypeData.ItemIndex := -1;

  // ������� ������ �������-����������
  EditCategory.Text := '';
  EditWinterPrice.Text := '';
  // ������� ����� �������-����������
  StringGridCalculations.Cells[11, CountCoef + 2] := '';
  // ������� ����� ����������
  StringGridCalculations.Cells[12, CountCoef + 2] := '';

  // ������� 2 ��������� ������ � ������� �������
  StringGridCalculations.Enabled := False;
  with StringGridCalculations do
    for i := 1 to ColCount - 1 do
    begin
      Cells[i, RowCount - 2] := '';
      Cells[i, RowCount - 1] := '';
    end;
  // ��������� � ������� ������� ������ �������
  with StringGridCalculations do
  begin
    Cells[1, RowCount - 2] := qrRatesUNIT.AsString;
    Cells[1, RowCount - 1] := qrRatesCOUNT.AsString;
  end;
  StringGridCalculations.Enabled := True;

  PopupMenuCoefAddSet.Enabled := True;
  PopupMenuCoefDeleteSet.Enabled := True;

  CalcPrice := '00';

  PMDelete.Enabled := True;
  PMReplace.Enabled := False;
  PMEdit.Enabled := False;

  // ���¨�������� ��������� �������� � �������� ������
  BtnChange := false;
  case ComboBoxTypeData.ItemIndex of
    0: // ��������
      begin
        PMEdit.Enabled := True;

        //��������� �������� ������ ������, ��� �������� ������ ���������� "���������"
        SpeedButtonMaterials.Enabled := True;
        SpeedButtonMechanisms.Enabled := True;
        SpeedButtonEquipments.Enabled := True;
        SpeedButtonDescription.Enabled := True;

        //���������� ������ ������
        FillingTableMaterials(qrRatesRID.AsInteger, 0);
        FillingTableMechanizm(qrRatesRID.AsInteger, 0);
        FillingTableDescription(qrRatesIDID.AsInteger);

        // ��������, ���� ������� ������� � ������� ��� ������,
        // ���������� ������ ������ � ���������
        if SpeedButtonMaterials.Down then
          TestOnNoDataNEW(qrMaterial)
        else if SpeedButtonMechanisms.Down then
          TestOnNoDataNew(qrMechanizm)
        else if SpeedButtonEquipments.Down then
          TestOnNoData(StringGridEquipments)
        else
          TestOnNoDataNew(qrDescription);
        // ----------------------------------------

        // ������� ������ �������-����������
        EditCategory.Text :=
          MyFloatToStr(GetRankBuilders(IntToStr(qrRatesIDID.AsInteger)));

        // ������� ����� �������-����������
        StringGridCalculations.Cells[11, CountCoef + 2] :=
          MyFloatToStr(GetWorkCostBuilders(IntToStr(qrRatesIDID.AsInteger)));

        // ������� ����� ����������
        StringGridCalculations.Cells[12, CountCoef + 2] :=
          MyFloatToStr(GetWorkCostMachinists(IntToStr(qrRatesIDID.AsInteger)));

        SetIndexOXROPR(qrRatesCODE.AsString);

        // �������� �������� ��� � ��� � ���� �������
        GetValuesOXROPR;

        // �������� ������ ������� ����������
        FillingWinterPrice(qrRatesCODEINRATE.AsString);

        Calculation;

        CalcPrice := '11';
      end;
    1: // ��������
      begin
        SpeedButtonMaterials.Enabled := True;
        if not SpeedButtonMaterials.Down then BtnChange := true;
        SpeedButtonMaterials.Down := True;

        SpeedButtonDescription.Enabled := False;
        SpeedButtonMechanisms.Enabled := False;
        SpeedButtonEquipments.Enabled := False;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;
        //��������� �������� � ����������
        if ((qrRatesFROM_RATE.AsInteger > 0) and
            (qrRatesID_CARD_RATE.AsInteger > 0)) or
           (qrRatesID_CARD_RATE.AsInteger = 0) then
        begin
          FillingTableMaterials(0, qrRatesMID.AsInteger);
          // ���������
          if qrRatesID_CARD_RATE.AsInteger > 0 then
          begin
            PMReplace.Enabled := True;
            PMDelete.Enabled := False;
          end;
        end
        else
        begin //���������� ���������� �������� � ��������
          FillingTableMaterials(qrRatesID_CARD_RATE.AsInteger, 0);
          PMEdit.Enabled := True;
        end;

        //�������� �� ������ ����������, ��� ����������� ������� ����������
        if BtnChange then SpeedButtonMaterialsClick(SpeedButtonMaterials);

        // ������� ������ �������-����������
        EditCategory.Text :=
          MyFloatToStr(GetRankBuilders(IntToStr(qrRatesRATEIDINRATE.AsInteger)));

        // ������� ����� �������-����������
        StringGridCalculations.Cells[11, CountCoef + 2] :=
          MyFloatToStr(GetWorkCostBuilders(IntToStr(qrRatesRATEIDINRATE.AsInteger)));

        EditCategory.Text :=
          MyFloatToStr(GetWorkCostBuilders(IntToStr(qrRatesRATEIDINRATE.AsInteger)));

        SetIndexOXROPR(qrRatesCODE.AsString);

        // �������� �������� ��� � ��� � ���� �������
        GetValuesOXROPR;

        // �������� ������ ������� ����������
        FillingWinterPrice(qrRatesCODEINRATE.AsString);

        CalculationMaterial;

        CalcPrice := '10';
      end;
    2: // ��������
      begin
        SpeedButtonMechanisms.Enabled := True;
        if not SpeedButtonMechanisms.Down then BtnChange := true;
        SpeedButtonMechanisms.Down := True;

        SpeedButtonMaterials.Enabled := False;
        SpeedButtonDescription.Enabled := False;
        SpeedButtonEquipments.Enabled := False;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        //���������� ������� ����������
        FillingTableMechanizm(0, qrRatesMEID.AsInteger);

        //�������� �� ������ ����������, ��� ����������� ������� ����������
        if BtnChange then SpeedButtonMechanismsClick(SpeedButtonMechanisms);

        // ������� ����� ����������
        StringGridCalculations.Cells[12, CountCoef + 2] :=
          MyFloatToStr(GetWorkCostMachinists(IntToStr(qrRatesRATEIDINRATE.AsInteger)));

        SetIndexOXROPR(qrRatesCODE.AsString);

        // �������� �������� ��� � ��� � ���� �������
        GetValuesOXROPR;

        // �������� ������ ������� ����������
        FillingWinterPrice(qrRatesCODEINRATE.AsString);

        // -------------------------------------

        CalculationMechanizm;

        CalcPrice := '01';
      end;
    3: // ������������
      begin

      end;
  end;
    {4, 5, 6, 7: // ��������� ������/������ ����������� �310/�311
      begin
        with StringGridRates do
        begin
          Distance := StrToInt(Cells[7, Row]);
          vClass := StrToInt(Cells[8, Row]);
        end;

        More := 0;

        if Distance > 50 then
        begin
          More := Distance - 50;
          Distance := 50;
        end;

        // -----------------------------------------

        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('SELECT state_nds FROM objcards WHERE obj_id = ' + IntToStr(IdObject) + ';');
            Active := True;

            VAT := FieldByName('state_nds').AsVariant;
          end;
        except
          on E: Exception do
            MessageBox(0, PChar('��� ��������� ������� ��� ������� �������� ������:' + sLineBreak + sLineBreak
              + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;

        // -----------------------------------------

        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('SELECT * FROM transfercargo WHERE monat = ' + IntToStr(MonthEstimate) + ' and year = ' +
              IntToStr(YearEstimate) + ' and distance = ' + IntToStr(Distance) + ';');
            Active := True;

            with StringGridCalculations do
            begin
              Cells[6, RowCount - 2] := FieldByName('class' + IntToStr(vClass) + '_' + IntToStr(VAT + 1))
                .AsVariant;
              Cells[7, RowCount - 2] := Cells[6, RowCount - 2];
            end;

            // --------------------

            if More <> 0 then
            begin
              Active := False;
              SQL.Clear;
              SQL.Add('SELECT * FROM transfercargo WHERE monat = ' + IntToStr(MonthEstimate) + ' and year = '
                + IntToStr(YearEstimate) + ' and distance LIKE "%>50%";');
              Active := True;

              with StringGridCalculations do
              begin
                Cells[6, RowCount - 2] :=
                  IntToStr(FieldByName('class' + IntToStr(vClass) + '_' + IntToStr(VAT + 1)).AsInteger * More
                  + StrToInt(Cells[6, RowCount - 2]));
                Cells[7, RowCount - 2] := Cells[6, RowCount - 2]
              end;
            end;
          end;
        except
          on E: Exception do
            MessageBox(0, PChar('��� ��������� ��� �� ��������������� �������� ������:' + sLineBreak +
              sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;

        // -----------------------------------------

        with StringGridCalculations do
        begin
          Mass := StrToInt(Cells[1, RowCount - 1]);

          Cells[6, RowCount - 1] := IntToStr(StrToInt(Cells[6, RowCount - 2]) * Mass);
          Cells[7, RowCount - 1] := IntToStr(StrToInt(Cells[7, RowCount - 2]) * Mass);
        end;
      end;
    8:
      begin
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('SELECT state_nds FROM objcards WHERE obj_id = ' + IntToStr(IdObject) + ';');
            Active := True;

            VAT := FieldByName('state_nds').AsVariant;
          end;
        except
          on E: Exception do
            MessageBox(0, PChar('��� ��������� ������� ��� ������� �������� ������:' + sLineBreak + sLineBreak
              + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;

        // -----------------------------------------

        with StringGridRates do
          IdDump := StrToInt(Cells[ColCount - 3, Row]);

        // -----------------------------------------

        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('SELECT dump_id, coast' + IntToStr(VAT + 1) + ' FROM dumpcoast WHERE dump_id = ' +
              IntToStr(IdDump) + ';');
            Active := True;

            with StringGridCalculations do
            begin
              Cells[5, RowCount - 2] := FieldByName('coast' + IntToStr(VAT + 1)).AsVariant;
              Cells[7, RowCount - 2] := Cells[5, RowCount - 2];
            end;
          end;
        except
          on E: Exception do
            MessageBox(0, PChar('��� ��������� ���� �� ������ �������� ������:' + sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;

        // -----------------------------------------

        with StringGridRates do
          Count := StrToInt(Cells[2, Row]);

        // -----------------------------------------

        with StringGridCalculations do
        begin
          Cells[5, RowCount - 1] := MyFloatToStr(StrToInt(Cells[5, RowCount - 2]) * Count);
          Cells[7, RowCount - 1] := Cells[5, RowCount - 1];
          Cells[10, RowCount - 1] := Cells[5, RowCount - 1];
        end;
      end;
    19, 10:
      begin
        PopupMenuCoefAddSet.Enabled := False;
        PopupMenuCoefDeleteSet.Enabled := False;

        TwoValuesSalary.ForOne := 0;
        TwoValuesSalary.ForCount := 0;

        TwoValuesEMiM.ForOne := 0;
        TwoValuesEMiM.ForCount := 0;

        with (Sender as TStringGrid) do
          for i := 1 to RowCount - 2 do
            if ((ComboBoxTypeData.ItemIndex = 9) and (Pos('�18-', Cells[1, i]) > 0)) or
              ((ComboBoxTypeData.ItemIndex = 10) and (Pos('�20-', Cells[1, i]) > 0)) then
            begin
              vIdNormativ := Cells[6, i];

              TwoValues := CalculationSalary(vIdNormativ);

              TwoValuesSalary.ForOne := TwoValuesSalary.ForOne + TwoValues.ForOne;
              TwoValuesSalary.ForCount := TwoValuesSalary.ForCount + TwoValues.ForCount;

              TwoValues := CalculationEMiM(vIdNormativ);

              TwoValuesEMiM.ForOne := TwoValuesEMiM.ForOne + TwoValues.ForOne;
              TwoValuesEMiM.ForCount := TwoValuesEMiM.ForCount + TwoValues.ForCount;
            end;

        TwoValuesSalary.ForOne := TwoValuesSalary.ForOne; // * 0.03;
        TwoValuesSalary.ForCount := TwoValuesSalary.ForCount; // * 0.03;

        TwoValuesEMiM.ForOne := TwoValuesEMiM.ForOne; // * 0.03;
        TwoValuesEMiM.ForCount := TwoValuesEMiM.ForCount; // * 0.03;

        with StringGridCalculations do
        begin
          Cells[2, CountCoef + 2] := MyCurrToStr(RoundTo(TwoValuesSalary.ForOne, PS.RoundTo * -1));
          Cells[2, CountCoef + 3] := MyCurrToStr(RoundTo(TwoValuesSalary.ForCount, PS.RoundTo * -1));

          Cells[3, CountCoef + 2] := MyCurrToStr(RoundTo(TwoValuesEMiM.ForOne, PS.RoundTo * -1));
          Cells[3, CountCoef + 3] := MyCurrToStr(RoundTo(TwoValuesEMiM.ForCount, PS.RoundTo * -1));

          Cells[7, CountCoef + 2] := MyCurrToStr(RoundTo(TwoValuesSalary.ForOne + TwoValuesEMiM.ForOne,
            PS.RoundTo * -1));
          Cells[7, CountCoef + 3] := MyCurrToStr(RoundTo(TwoValuesSalary.ForCount + TwoValuesEMiM.ForCount,
            PS.RoundTo * -1));
        end;
      end;
  end; }

  {if CalcPrice[1] = '1' then
    CalculationColumnPriceMaterial;

  if CalcPrice[2] = '1' then
    CalculationColumnPriceMechanizm; }
end;

function TFormCalculationEstimate.GetCountCoef(): Integer;
begin
  Result := CountCoef;
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
  if CountCoef = 5 then
  begin
    MessageBox(0, PChar('��� ��������� 5 ������� �������������!' + sLineBreak + sLineBreak +
      '���������� ������ 5 ������� ����������.'), '�����', MB_ICONINFORMATION + MB_OK + mb_TaskModal);
    Exit;
  end;

  FormCoefficients.ShowModal;

  with StringGridCalculations do
  begin
    Row := CountCoef;
    SetFocus;
  end;
end;

procedure TFormCalculationEstimate.PopupMenuCoefDeleteSetClick(Sender: TObject);
var
  ResultDialog: Integer;
  c, r: Integer;
begin
  with StringGridCalculations do
    if (Row > CountCoef) or ((Row = 1) and RowCoefDefault) then
    begin
      MessageBox(0, PChar('��������� ������ �� �������� ������� �������������.' + sLineBreak +
        '������� ����� ������ ����������!'), '�����', MB_ICONWARNING + MB_OK + mb_TaskModal);
      Exit;
    end;

  ResultDialog := MessageBox(0, PChar('�� ������������� ������ ������� ' + sLineBreak +
    '���������� ����� �������������?'), '�����', MB_ICONINFORMATION + MB_YESNO + mb_TaskModal);

  if ResultDialog = mrNo then
    Exit;

  if (StringGridCalculations.Row = 1) and (CountCoef = 1) then
  begin
    with StringGridCalculations do
    begin
      Cells[0, 1] := NameRowCoefDefault;

      for c := 1 to ColCount - 1 do
        Cells[c, 1] := '1';
    end;

    RowCoefDefault := True;
  end
  else
  begin
    with StringGridCalculations do
    begin
      for r := Row to RowCount - 2 do
        for c := 0 to ColCount - 1 do
          Cells[c, r] := Cells[c, r + 1];

      RowCount := RowCount - 1;
    end;

    Dec(CountCoef);
  end;

  GridRatesRowSellect;
end;

procedure TFormCalculationEstimate.PopupMenuCoefOrdersClick(Sender: TObject);
begin
  //FormCoefficientOrders.ShowForm(IdEstimate, RateId, 0);
  GetStateCoefOrdersInRate;
end;

procedure TFormCalculationEstimate.PopupMenuCoefPopup(Sender: TObject);
begin
  GetStateCoefOrdersInEstimate;
end;

//��� ������������ ���� ����������
procedure TFormCalculationEstimate.PopupMenuMaterialsPopup(Sender: TObject);
begin
  PMMatEdit.Enabled := not CheckMatReadOnly;
  PMMatReplace.Enabled := CheckMatUnAccountingMatirials;
  PMMatFromRates.Enabled := (not CheckMatReadOnly) and
    (qrRatesMID.AsInteger = 0);
end;

//��������� ���� ������������ ���� ������� ����������
procedure TFormCalculationEstimate.PopupMenuMechanizmsPopup(Sender: TObject);
begin
  PMMechEdit.Enabled := not CheckMechReadOnly;
  PMMechFromRates.Enabled := (not CheckMechReadOnly) and
    (qrRatesMEID.AsInteger = 0);
end;

//���������� �������� � �����
procedure TFormCalculationEstimate.AddRate(RateNumber: String; Count: Double);
var
  i : integer;
  FieldRates: TFieldRates;
  vIdRate, vMaxIdRate: Integer;
  vNormRas: Double;
  Month1, Year1: integer;
  PriceVAT, PriceNoVAT: string;
  SQL1, SQL2 : string;
begin
  // ���� ������� ��������, ���� ������ ��������� ���, ����� ��������� � �������
  // ����� �������� ��� Id � ���������� ����������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT normativ_id FROM normativg WHERE norm_num = :norm_num;');
      ParamByName('norm_num').Value := RateNumber;
      Active := True;

      if RecordCount <= 0 then
      begin
        MessageBox(0, '�������� � ��������� ������� �� ���� �������!',
          CaptionForm, MB_ICONINFORMATION + MB_YESNO + mb_TaskModal);

        Exit;
      end;

      vIdRate := FieldByName('normativ_id').AsVariant;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������ Id �������� �������� ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ��������� ��������� �������� �� ��������� ������� card_rate_temp
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddRate(:id_estimate, :id_rate, :cnt);');
      ParamByName('id_estimate').Value := IdEstimate;
      ParamByName('id_rate').Value := vIdRate;
      ParamByName('cnt').AsFloat := Count;
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
      {
      Active := False;
      SQL.Clear;
      SQL.Add('CALL GetMaterialsAll(' + IntToStr(IdObject) + ', ' + IntToStr(IdEstimate) + ', ' +
        IntToStr(vIdRate) + ');');
      Active := True;
      }
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT year,monat FROM stavka WHERE stavka_id = ' +
        '(SELECT stavka_id FROM smetasourcedata WHERE sm_id = ' +
        IntToStr(IdEstimate) + ')');
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
      sql1 := '(SELECT TMat.material_id as "MatId", TMat.mat_code as "MatCode", ' +
        'TMatNorm.norm_ras as "MatNorm", units.unit_name as "MatUnit", ' +
        'TMat.unit_id as "UnitId", mat_name as "MatName", NULL as "PriceVAT", ' +
        'NULL as "PriceNoVAT", ' +
        '(SELECT coef_tr_zatr FROM smetasourcedata WHERE sm_id = ' + IntToStr(IdEstimate) +
        ') as "PercentTransport" FROM units, ' +
        '(SELECT * FROM material WHERE mat_code LIKE "�%") TMat, ' +
        '(SELECT material_id, norm_ras FROM materialnorm WHERE ' +
        'normativ_id = ' + IntToStr(vIdRate) + ') TMatNorm ' +
        'WHERE TMat.material_id = TMatNorm.material_id and ' +
        'TMat.unit_id = units.unit_id ORDER BY 1)';

      sql2 := '(SELECT material.material_id as "MatId", material.mat_code as "MatCode", ' +
        'TMatNorm.norm_ras as "MatNorm", units.unit_name as "MatUnit", ' +
        'material.unit_id as "UnitId", material.mat_name as "MatName", ' + PriceVAT +
        ' as "PriceVAT", ' + PriceNoVAT + ' as "PriceNoVAT", ' +
        '(SELECT coef_tr_zatr FROM smetasourcedata WHERE sm_id = ' + IntToStr(IdEstimate) +
        ') as "PercentTransport" FROM material, units, ' +
        '(SELECT material_id, norm_ras FROM materialnorm where ' +
        'normativ_id = ' + IntToStr(vIdRate) + ') TMatNorm, ' +
        '(SELECT material_id, ' + PriceVAT +', ' + PriceNoVAT +
        ' FROM materialcoastg WHERE monat = ' + IntToStr(Month1) +
        ' and year = ' + IntToStr(Year1) + ') TMatCoast WHERE ' +
        'material.material_id = TMatNorm.material_id and ' +
        'material.material_id = TMatCoast.material_id and ' +
        'material.unit_id = units.unit_id ORDER BY 1)';

      SQL.Add(sql1 + ' union ' + sql2 + ';');
      Active := True;

      Filtered := False;
      Filter := 'MatCode LIKE ''�%''';
      Filtered := True;

      First;

      while not Eof do
      begin
        qrTemp1.Active := false;
        qrTemp1.SQL.Text := 'Insert into materialcard_temp (BD_ID, ID_CARD_RATE, MAT_ID, ' +
          'MAT_CODE, MAT_NAME, MAT_NORMA, MAT_UNIT, COAST_NO_NDS, COAST_NDS, NDS, ' +
          'PROC_TRANSP) values (:BD_ID, :ID_CARD_RATE, :MAT_ID, ' +
          ':MAT_CODE, :MAT_NAME, :MAT_NORMA, :MAT_UNIT, :COAST_NO_NDS, ' +
          ':COAST_NDS, :NDS, :PROC_TRANSP)';
        qrTemp1.ParamByName('BD_ID').AsInteger := 1;
        qrTemp1.ParamByName('ID_CARD_RATE').AsInteger := vMaxIdRate;
        qrTemp1.ParamByName('MAT_ID').AsInteger := FieldByName('MatId').AsInteger;
        qrTemp1.ParamByName('MAT_CODE').AsString := FieldByName('MatCode').AsString;
        qrTemp1.ParamByName('MAT_NAME').AsString := FieldByName('MatName').AsString;
        vNormRas := MyStrToFloatDef(FieldByName('MatNorm').AsString,0);
        qrTemp1.ParamByName('MAT_NORMA').AsFloat := vNormRas;
        qrTemp1.ParamByName('MAT_UNIT').AsString := FieldByName('MatUnit').AsString;
        qrTemp1.ParamByName('COAST_NO_NDS').AsInteger := FieldByName('PriceNoVAT').AsInteger;
        qrTemp1.ParamByName('COAST_NDS').AsInteger := FieldByName('PriceVAT').AsInteger;
        qrTemp1.ParamByName('NDS').AsInteger := 20;
        qrTemp1.ParamByName('PROC_TRANSP').AsFloat := FieldByName('PercentTransport').AsFloat;
        qrTemp1.ExecSQL;

        Next;
      end;

      Filtered := False;
      Filter := 'MatCode LIKE ''�%''';
      Filtered := True;

      First;

      while not Eof do
      begin
        qrTemp1.Active := false;
        qrTemp1.SQL.Text := 'Insert into materialcard_temp (BD_ID, ID_CARD_RATE, CONSIDERED, MAT_ID, ' +
          'MAT_CODE, MAT_NAME, MAT_NORMA, MAT_UNIT, COAST_NO_NDS, COAST_NDS, NDS, ' +
          'PROC_TRANSP) values (:BD_ID, :ID_CARD_RATE, :CONSIDERED, :MAT_ID, ' +
          ':MAT_CODE, :MAT_NAME, :MAT_NORMA, :MAT_UNIT, :COAST_NO_NDS, ' +
          ':COAST_NDS, :NDS, :PROC_TRANSP)';
        qrTemp1.ParamByName('BD_ID').AsInteger := 1;
        qrTemp1.ParamByName('ID_CARD_RATE').AsInteger := vMaxIdRate;
        qrTemp1.ParamByName('CONSIDERED').AsInteger := 0;
        qrTemp1.ParamByName('MAT_ID').AsInteger := FieldByName('MatId').AsInteger;
        qrTemp1.ParamByName('MAT_CODE').AsString := FieldByName('MatCode').AsString;
        qrTemp1.ParamByName('MAT_NAME').AsString := FieldByName('MatName').AsString;
        vNormRas := MyStrToFloatDef(FieldByName('MatNorm').AsString,0);
        qrTemp1.ParamByName('MAT_NORMA').AsFloat := vNormRas;
        qrTemp1.ParamByName('MAT_UNIT').AsString := FieldByName('MatUnit').AsString;
        qrTemp1.ParamByName('COAST_NO_NDS').AsInteger := FieldByName('PriceNoVAT').AsInteger;
        qrTemp1.ParamByName('COAST_NDS').AsInteger := FieldByName('PriceVAT').AsInteger;
        qrTemp1.ParamByName('NDS').AsInteger := 20;
        qrTemp1.ParamByName('PROC_TRANSP').AsFloat := FieldByName('PercentTransport').AsFloat;
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

  // ----------------------------------------

  // ������� �� ��������� ������� mechanizmcard_temp ��������� ����������� � ��������
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL GetMechanizmsFromRate(:IdObject, :IdEstimate, :IdRate);');

      ParamByName('IdObject').Value := IdObject;
      ParamByName('IdEstimate').Value := IdEstimate;
      ParamByName('IdRate').Value := vIdRate;

      Active := True;
      First;

      while not Eof do
      begin
        qrTemp1.Active := false;
        qrTemp1.SQL.Text := 'Insert into mechanizmcard_temp (BD_ID, ID_CARD_RATE, ' +
          'MECH_ID, MECH_CODE, MECH_NAME, MECH_NORMA, MECH_UNIT, COAST_NO_NDS, ' +
          'COAST_NDS, NDS, ZP_MACH_NO_NDS, ZP_MACH_NDS) values (:BD_ID, :ID_CARD_RATE, ' +
          ':MECH_ID, :MECH_CODE, :MECH_NAME, :MECH_NORMA, :MECH_UNIT, :COAST_NO_NDS, ' +
          ':COAST_NDS, :NDS, :ZP_MACH_NO_NDS, :ZP_MACH_NDS)';
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
        qrTemp1.ParamByName('NDS').AsInteger := 20;
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

  OutputDataToTable(0);
end;

procedure TFormCalculationEstimate.PMAddRatMatMechEquipOwnClick(Sender: TObject);
begin
  ShowFormAdditionData('s');
end;

procedure TFormCalculationEstimate.PMAddRatMatMechEquipRefClick(Sender: TObject);
begin
  ShowFormAdditionData('g');
end;

procedure TFormCalculationEstimate.PMEditClick(Sender: TObject);
begin
  case qrRates.FieldByName('TYPE_DATA').AsInteger of
    1: // ��������
      begin
        FormCardDataEstimate.ShowForm(qrRates.FieldByName('RID').AsInteger);
        //  UpdateTableCardRatesTemp;
        OutputDataToTable(0);
      end;
    2: // ��������
      begin
        FormCardMaterial.ShowForm(qrRates.FieldByName('MID').AsInteger);
        //UpdateTableCardMaterialTemp;

       // FillingTableMaterials(IntToStr(IdInRate), '0');
      end;
  end;
end;

//�������� ����-���� �� �����
procedure TFormCalculationEstimate.PMDeleteClick(Sender: TObject);
begin
  if MessageBox(0, PChar('�� ������������� ������ ������� ' +
    qrRates.FieldByName('CODE').AsString + '?'),
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
    end;
  OutputDataToTable(0);
end;

procedure TFormCalculationEstimate.PopupMenuTableLeftPopup(Sender: TObject);
begin
  //������ ������� ���������� �������� �� ������� ��������
  PMDelete.Enabled := not(CheckMatUnAccountingRates);
end;

procedure TFormCalculationEstimate.PopupMenuRatesAdd(Sender: TObject);
var
  FieldRates: TFieldRates;
begin
  {case (Sender as TMenuItem).Tag of
    5, 6, 7, 8:
      with FormTransportation do
      begin
        SetIdRow((Sender as TMenuItem).Tag);
        FormTransportation.ShowModal;
      end;
    9:
      FormCalculationDump.ShowModal;
    10:
      begin
        FieldRates.vRow := '0';
        FieldRates.vNumber := '��18';
        FieldRates.vCount := 1;
        FieldRates.vNameUnit := '';
        FieldRates.vDescription := '������� �� ���� � ����������� ��������� (�������� �18)';
        FieldRates.vTypeAddData := 10;
        FieldRates.vId := '';

        AddRowToTableRates(FieldRates);
      end;
    11:
      with FieldRates do
      begin
        vRow := '0';
        vNumber := '��20';
        vCount := 1;
        vNameUnit := '';
        vDescription := '������� �� ���� � ����������� ��������� (�������� �20)';
        vTypeAddData := 11;
        vId := '';

        AddRowToTableRates(FieldRates);
      end;
    12:
      begin
        with StringGridRates do
          if Cells[10, Row] <> '1' then
            Cells[10, Row] := '1'
          else
            Cells[10, Row] := '';

        {
          with PopupMenuRatesAddWinterPrice do
          begin
          Checked := not Checked;
          VisibleColumnsWinterPrice(Checked);
          end;
        }
{      end;
  end;    }
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

//�������� �������� ������� ����������
procedure TFormCalculationEstimate.FillingTableMaterials(const vIdCardRate, vIdMat: integer);
var fType, fID, i: integer;
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
  ReCalcMat := true;
  qrMaterialNUM.ReadOnly := false;
  //�������� �������� ��� ���������� ������� ����������
  qrMaterial.Active := false;
  //��������� materials_temp
  qrMaterial.SQL.Text := 'call GetMaterials(' + IntToStr(fType) + ',' +
    IntToStr(fID) + ')';
  qrMaterial.ExecSQL;
  //��������� materials_temp
  qrMaterial.SQL.Text := 'SELECT * FROM materials_temp ORDER BY SRTYPE, TITLE DESC, ID';
  qrMaterial.Active := true;
  i := 0;
  //��������� �����, ������ ��������
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
  qrMaterialNUM.ReadOnly := true;
  ReCalcMat := false;
  qrMaterial.First;
  qrMaterial.EnableControls;
  dbgrdMaterial.Repaint;
end;

procedure TFormCalculationEstimate.FillingTableMechanizm(const vIdCardRate, vIdMech: integer);
var i : integer;
begin

  qrMechanizm.Active := false;
  if vIdMech > 0 then
  begin
    qrMechanizm.ParamByName('Type').asInteger := 0;
    qrMechanizm.ParamByName('IDValue').asInteger := vIdMech;
  end
  else
  begin
    qrMechanizm.ParamByName('Type').asInteger := 1;
    qrMechanizm.ParamByName('IDValue').asInteger := vIdCardRate;
  end;
  qrMechanizm.Active := true;
end;

procedure TFormCalculationEstimate.FillingTableDescription(const vIdNormativ: integer);
var i: integer;
begin
  with qrDescription do
  begin
    Active := False;
    ParamByName('IdNorm').AsInteger := vIdNormativ;
    Active := True;
  end;
end;

procedure TFormCalculationEstimate.FillingCoeffBottomTable;
var
  i: Integer;
begin
  with StringGridCalculations do
  begin
    for i := 2 to ColCount - 1 do
      if i <> 10 then
        Cells[i, 1] := '1';

    Cells[2, 2] := '1';
    Cells[5, 2] := '1';
    Cells[8, 2] := '1';
    Cells[9, 2] := '1';
  end;
end;

procedure TFormCalculationEstimate.FillingTableSetCoef;
var
  c, r: Integer;
begin
  with StringGridCalculations, FormCoefficients do
  begin
    if not RowCoefDefault then
    begin
      RowCount := RowCount + 1;

      Inc(CountCoef);

      // ��������� ��� ��������� ������ ����
      for r := RowCount - 1 downto RowCount - 3 do
        for c := 0 to ColCount - 1 do
          Cells[c, r] := Cells[c, r - 1];
    end
    else
      NameRowCoefDefault := Cells[0, CountCoef];
    // ��������� �������� ������ ������

    // ����������� ������ �������
    Cells[0, CountCoef] := StringGridTable.Cells[1, StringGridTable.Row];

    // ��������� ������ �������������
    Cells[2, CountCoef] := EditSalary.Text;
    Cells[3, CountCoef] := EditExploitationCars.Text;
    Cells[5, CountCoef] := EditMaterialResources.Text;
    Cells[11, CountCoef] := EditWorkBuilders.Text;
    Cells[12, CountCoef] := EditWorkMachinist.Text;

    Cells[4, CountCoef] := '0';

    for c := 6 to 10 do
      Cells[c, CountCoef] := '0';

    Cells[13, CountCoef] := '0';
    Cells[14, CountCoef] := '0';
  end;

  RowCoefDefault := False;

  GridRatesRowSellect
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

      if FieldByName('norma').AsVariant <> Null then
        Result := FieldByName('norma').AsVariant
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
  end;                 }
end;

procedure TFormCalculationEstimate.CalculationMaterial;
begin
  CalculationMR;

  CalculationPercentTransport;

  // ��������� ������ � ������ ������� � ������� (����)
  with StringGridCalculations do
  begin
    Cells[3, CountCoef + 2] := '0';
    Cells[3, CountCoef + 3] := '0';
  end;

  // CalculationSalaryMachinist;
  with StringGridCalculations do
  begin
    Cells[4, CountCoef + 2] := '0';
    Cells[4, CountCoef + 3] := '0';
  end;

  // ������������ �� (���������� �����)
  //TwoValues := CalculationSalary(IntToStr(RateId));

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
  // CalculationWorkMachinist;
end;

procedure TFormCalculationEstimate.CalculationMechanizm;
begin
  // CalculationMR;
  with StringGridCalculations do
  begin
    Cells[5, CountCoef + 2] := '0';
    Cells[5, CountCoef + 3] := '0';
  end;

  // CalculationPercentTransport;
  with StringGridCalculations do
  begin
    Cells[6, CountCoef + 2] := '0';
    Cells[6, CountCoef + 3] := '0';
  end;

  //TwoValues := CalculationEMiM(IntToStr(RateId));

  // ��������� ������ � ������ ������� � ������� (����)
  with StringGridCalculations do
  begin
    Cells[3, CountCoef + 2] := MyCurrToStr(TwoValues.ForOne);
    Cells[3, CountCoef + 3] := MyCurrToStr(TwoValues.ForCount);
  end;

  CalculationSalaryMachinist;

  // -------------------------------------

  // ������������ �� (���������� �����)
  // TwoValues := CalculationSalary(IdNormativ);

  // ��������� ������ � ������ ������� � ������� (��)
  with StringGridCalculations do
  begin
    // Cells[2, CountCoef + 2] := MyCurrToStr(TwoValues.ForOne);
    // Cells[2, CountCoef + 3] := MyCurrToStr(TwoValues.ForCount);

    Cells[2, CountCoef + 2] := '0';
    Cells[2, CountCoef + 3] := '0';
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
begin
  try
    // ���������� �� ����� �������
    Count := CountFromRate; // MyStrToFloat(Cells[2, Row]);

    TZ := GetWorkCostBuilders(vIdNormativ) * Count;
    // ������� ����� ������� * ����������
    TZ1 := GetWorkCostBuilders(vIdNormativ); // ������� ����� ������� * 1

    // ��������� �� ������� ������������� (��)
    for i := 1 to CountCoef + 1 do
      with StringGridCalculations do
      begin
        TZ := TZ * MyStrToFloat(Cells[2, i]);
        TZ1 := TZ1 * MyStrToFloat(Cells[2, i]);
      end;

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
        else MRCoef := 0;
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
      MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[2,
        0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
        MB_ICONERROR + MB_OK + mb_TaskModal);
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
  end;}
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

    with StringGridCalculations do
    begin
      Cells[6, CountCoef + 2] := MyFloatToStr(RoundTo(MyStrToFloatdef(Cells[5, CountCoef + 2], 0) * Percent / 100,
        PS.RoundTo * -1));
      Cells[6, CountCoef + 3] := MyFloatToStr(RoundTo(MyStrToFloatdef(Cells[5, CountCoef + 3], 0) * Percent / 100,
        PS.RoundTo * -1));
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[6,
        0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
        MB_ICONERROR + MB_OK + mb_TaskModal);
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
  {try
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
  end;}
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
  {try
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
  end;}
end;

procedure TFormCalculationEstimate.CalculationCost;
begin
  {try
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
  try
    with StringGridCalculations do
      // ���� ����� % ������� ���������� ���� � �������, ����� �������
      if Cells[8, CountCoef + 2] <> '' then
      begin
        OXROPR := MyStrToCurr(Cells[2, CountCoef + 3]); // ��
     //   OXROPR := OXROPR + MyStrToCurr(Cells[4, CountCoef + 3]); // �� + �� ���.

        // (�� + �� ���.) * % � ���� �������
        OXROPR := OXROPR * MyStrToCurr(Cells[8, CountCoef + 2]) / 100;

        // ��������� ������ � ������ ������� � ������� (��� � ���)
        Cells[8, CountCoef + 3] := MyFloatToStr(RoundTo(OXROPR, PS.RoundTo * -1));
      end
      else
      begin
        Cells[8, CountCoef + 2] := '���';
        Cells[8, CountCoef + 3] := '���';
      end;
  except
    on E: Exception do
      MessageBox(0, PChar('������ ��� ���������� �' + StringGridCalculations.Cells[8,
        0] + '�, � ������� ����������:' + sLineBreak + sLineBreak + E.Message), CaptionForm,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.CalculationPlanProfit;
var
  PlanProfit: Double;
begin
  {try
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
  end;  }
end;

procedure TFormCalculationEstimate.CalculationCostOXROPR;
var
  OXROPR, PlanProfit: Currency;
  i: Integer;
  Str: string;
begin
{  try
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
  {try
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
{  try
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
  end;  }
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
  end;   }
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
  //��������� ����� �������������� � ����, ���� �� �������
  //������� � ���, ��� ���������� �� �������� ������ ��� ������� �� ���
  if not MemoRight.ReadOnly then MemoRightExit(MemoRight);

  SplitterRight1.Align := alBottom;
  SplitterRight2.Align := alBottom;

  SplitterRight1.Visible := False;
  SplitterRight2.Visible := False;

  dbgrdMaterial.Visible := False;
  StringGridEquipments.Visible := False;
  dbgrdMechanizm.Visible := False;
  dbgrdDescription.Visible := False;

  dbgrdMaterial.Align := alNone;
  StringGridEquipments.Align := alNone;
  dbgrdDescription.Align := alNone;
  dbgrdMechanizm.Align := alNone;

  ImageSplitterRight1.Visible := False;
  ImageSplitterRight2.Visible := False;

  if VisibleRightTables = '1000' then
  begin
    dbgrdMaterial.Align := alClient;
    dbgrdMaterial.Visible := True;
  end
  else if VisibleRightTables = '0100' then
  begin
    dbgrdMechanizm.Align := alClient;
    dbgrdMechanizm.Visible := True;
  end
  else if VisibleRightTables = '0010' then
  begin
    StringGridEquipments.Align := alClient;
    StringGridEquipments.Visible := True;
  end
  else if VisibleRightTables = '0001' then
  begin
    dbgrdDescription.Align := alClient;
    dbgrdDescription.Visible := True;
    dbgrdDescription.Columns[0].Width := dbgrdDescription.Width - 50;
  end
  else if VisibleRightTables = '1110' then
  begin
    dbgrdMaterial.Align := alTop;
    SplitterRight1.Align := alTop;

    StringGridEquipments.Align := alBottom;
    SplitterRight2.Align := alTop;
    SplitterRight2.Align := alBottom;

    dbgrdMechanizm.Align := alClient;

    dbgrdMaterial.Visible := True;
    dbgrdMechanizm.Visible := True;
    StringGridEquipments.Visible := True;

    SplitterRight1.Visible := True;
    SplitterRight2.Visible := True;

    ImageSplitterRight1.Visible := True;
    ImageSplitterRight2.Visible := True;
  end;

  PanelClientRightTablesResize(PanelClientRightTables);
end;

procedure TFormCalculationEstimate.SettingTablesFromFile(SG: TStringGrid);
var
  i: Integer;
  Path: string;
  IFile: TIniFile;
  NameSection: string;
begin
  if SG.Name = 'StringGridRates' then
    NameSection := 'TableNormativs'
  else if SG.Name = 'StringGridMaterials' then
    NameSection := 'TablePriceMaterials'
  else if SG.Name = 'StringGridMechanizms' then
    NameSection := 'TablePriceMechanizms'
  else if SG.Name = 'StringGridEquipments' then
    NameSection := 'TablePriceEquipments'
  else if SG.Name = 'StringGridDescription' then
    NameSection := 'TablePriceDescription'
  else if SG.Name = 'StringGridCalculations' then
    NameSection := 'TableCalculations';

  try
    try
      Path := ExtractFilePath(Application.ExeName) + FileSettingsTables;
      IFile := TIniFile.Create(Path);

      with SG, IFile do
      begin
        ColCount := ReadInteger(NameSection, ColumnCount, 0);
        i := ColCount;
        RowCount := ReadInteger(NameSection, RowsCount, 2);

        FixedCols := 1;
        FixedRows := 1;

        for i := 1 to ColCount do
        begin
          Cells[i - 1, 0] := ReadString(NameSection, ColumnName + IntToStr(i), '��� ��������');
          // �������� �������

          // ���� ������� ������ (�� ������) � ����� ��������
          if ReadBool(NameSection, ColumnVisible + IntToStr(i), False) then
            // ��������� � ������������� � ������
            ColWidths[i - 1] := ReadInteger(NameSection, ColumnWidth + IntToStr(i), 100)
          else
            // ���� ������, �������� �������
            ColWidths[i - 1] := -1;
        end;

        if RowCount > 2 then
          for i := 1 to RowCount do
            Cells[0, i] := ReadString(NameSection, RowName + IntToStr(i), '��� ��������'); // �������� ������
      end;
    except
      on E: Exception do
        MessageBox(0, PChar('��� ��������� ������� �' + SG.Name + '� �������� ������:' + sLineBreak +
          sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
  finally
    FreeAndNil(IFile);
  end;
end;

procedure TFormCalculationEstimate.ClearTable(SG: TStringGrid);
var
  c, r: Integer;
begin
  with SG do
    for r := 1 to RowCount - 1 do
      for c := 0 to ColCount - 1 do
        Cells[c, r] := '';

  SG.RowCount := 1;
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

        Inc(i);
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
        StrToDate('01.' + qrTemp.FieldByName('monat').AsString + '.' +
        qrTemp.FieldByName('year').AsString));

      if FieldByName('nds').Value then
      begin
        EditVAT.Text := 'c ���';
        NDSEstimate := true;
      end
      else
      begin
        EditVAT.Text := '��� ���';
        NDSEstimate := false;
      end;
      Active := False;
    end;
    //������ �� ����, ������������ ��� ��� ��� ����������� ������� ��� ������ ������
    ChangeGrigNDSStyle(NDSEstimate);

  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� �������� ������ �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.ChangeGrigNDSStyle(aNDS: boolean);
begin
  with dbgrdMaterial do
  begin
    //� ����������� �� ��� �������� ���� � ���������� ������ �������
    Columns[6].Visible := aNDS; //���� ����
    Columns[8].Visible := aNDS; //������ ����
    Columns[10].Visible := aNDS; //����� ����
    Columns[13].Visible := aNDS; //���� ����
    Columns[15].Visible := aNDS; //������ ����
    Columns[17].Visible := aNDS; //����� ����

    Columns[7].Visible := not aNDS;
    Columns[9].Visible := not aNDS;
    Columns[11].Visible := not aNDS;
    Columns[14].Visible := not aNDS;
    Columns[16].Visible := not aNDS;
    Columns[18].Visible := not aNDS;
  end;

  with dbgrdMechanizm do
  begin
    //� ����������� �� ��� �������� ���� � ���������� ������ �������
    Columns[5].Visible := aNDS; //�� ��� ����
    Columns[7].Visible := aNDS; //���� ����
    Columns[9].Visible := aNDS; //����� ����
    Columns[12].Visible := aNDS; //�� ��� ����
    Columns[14].Visible := aNDS; //���� ����
    Columns[16].Visible := aNDS; //����� ����
    Columns[18].Visible := aNDS; //������

    Columns[6].Visible := not aNDS;
    Columns[8].Visible := not aNDS;
    Columns[10].Visible := not aNDS;
    Columns[13].Visible := not aNDS;
    Columns[15].Visible := not aNDS;
    Columns[17].Visible := not aNDS;
    Columns[19].Visible := not aNDS;
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

    with StringGridCalculations do
    begin
      if FieldByName('OXRandOPR').AsVariant <> Null then
        Cells[8, CountCoef + 2] := MyFloatToStr(FieldByName('OXRandOPR').AsVariant)
      else
        Cells[8, CountCoef + 2] := '0';

      if FieldByName('PlannedProfit').AsVariant <> Null then
        Cells[9, CountCoef + 2] := MyFloatToStr(FieldByName('PlannedProfit').AsVariant)
      else
        Cells[9, CountCoef + 2] := '0';
    end;
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

      StringGridCalculations.Cells[13, CountCoef + 2] := '0';
      StringGridCalculations.Cells[14, CountCoef + 2] := '0';

      while not Eof do
      begin
        if (vNumber > FieldByName('From').AsVariant) and (vNumber < FieldByName('On').AsVariant) then
        begin
          EditWinterPrice.Text := FieldByName('Number').AsVariant + ' ' + FieldByName('Name').AsVariant;

          StringGridCalculations.Cells[13, CountCoef + 2] := MyFloatToStr(FieldByName('Coef').AsVariant);
          StringGridCalculations.Cells[14, CountCoef + 2] := MyFloatToStr(FieldByName('CoefZP').AsVariant);

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

 //����� ���� ��������, ���-�� ����� ������, ��� ������ � �������� 6��
procedure TFormCalculationEstimate.AddRowToTableRates(FieldRates: TFieldRates);
begin
  // �������� ������� � ��-6
  if Act and FormKC6.Showing then
    FormKC6.SelectDataEstimates(FieldRates.vTypeAddData, FieldRates.vId, FieldRates.vCount);
end;

procedure TFormCalculationEstimate.TestOnNoDataNew(ADataSet: TDataSet);
begin
  if not ADataSet.Active or ADataSet.IsEmpty then
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

//��������, ��� ������� �������� ������(���� ������ ������������ �������� ��� ������)
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

//���������� ������� ��������
procedure TFormCalculationEstimate.OutputDataToTable(aState: integer);
var
  FieldRates: TFieldRates;
  i: Integer;
  Str: string;
begin
  if Act then
    Str := 'data_act_temp'
  else
    Str := 'data_estimate_temp';

  qrRates.DisableControls;
  //�������� �������� ��� ���������� GridRates
  qrRates.Tag := 1; //���-�� ��������� ������� �� ������ � ��������
  qrRates.Active := false;
  //��������� rates_temp
  qrRates.SQL.Text := 'call GetRates(:pr1, :pr2)';
  qrRates.ParamByName('pr1').Value := Str;
  qrRates.ParamByName('pr2').Value := IdEstimate;
  qrRates.ExecSQL;
  //��������� rates_temp
  qrRates.SQL.Text := 'SELECT * FROM rates_temp ORDER BY DID, RID, STYPE, MID, MEID';
  qrRates.Active := true;
  i := 0;
  while not qrRates.Eof do
  begin
    if not CheckMatINRates then inc(i);
    qrRates.Edit;
    qrRates.FieldByName('NUM').AsInteger := i;
    qrRates.Post;

    qrRates.Next;
  end;
  qrRates.Tag := 0;

  qrRates.First; //����������� ���� ���-�� ��������� �����
  if aState = 1 then qrRates.Last;
  qrRates.EnableControls;
  dbgrdRates.Repaint;
end;

procedure TFormCalculationEstimate.TestFromRates(const SG: TStringGrid; const vCol, vRow: Integer);
begin
  if (vCol = -1) or (vRow = -1) then
    Exit;

  PMMechFromRates.Enabled := True;
  PMEqFromRates.Enabled := True;

  with SG do
    if SpeedButtonMechanisms.Down then
      PMMechFromRates.Enabled := not(Cells[13, vRow] = '0')
    else if SpeedButtonEquipments.Down then
      PMEqFromRates.Enabled := not(Cells[2, vRow] = '0');
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
  {with FormSaveEstimate do
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
  end;    }
end;

procedure TFormCalculationEstimate.VisibleColumnsWinterPrice(Value: Boolean);
begin
  with StringGridCalculations do
    if Value then
    begin
      ColWidths[13] := WCWinterPrice;
      ColWidths[14] := WCSalaryWinterPrice;
    end
    else
    begin
      if ColWidths[13] > -1 then
        WCWinterPrice := ColWidths[13];

      if ColWidths[14] > -1 then
        WCSalaryWinterPrice := ColWidths[14];

      ColWidths[13] := -1;
      ColWidths[14] := -1;
    end;
end;
//������ ����������� ��������� � �����
procedure TFormCalculationEstimate.ReplacementMaterial(const vIdMat: Integer);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL ReplacedMaterial(:IdEstimate, :IdCardRate, :IdReplaced, :IdMat);');
      ParamByName('IdEstimate').Value := IdEstimate;
      ParamByName('IdCardRate').Value := qrMaterialID_CARD_RATE.AsInteger;
      ParamByName('IdReplaced').Value := qrMaterialID.AsInteger;
      ParamByName('IdMat').Value := vIdMat;

      ExecSQL;
    end;

    OutputDataToTable(0);
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
  {with qrTemp do
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


//���������� ��������� � �����
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

    OutputDataToTable(0);
  except
    on E: Exception do
      MessageBox(0, PChar('��� ���������� ��������� �������� ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;
//���������� ��������� � �����
procedure TFormCalculationEstimate.AddMechanizm(const vMechId, vMonth, vYear: Integer);
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddMechanizm(:IdEstimate, :IdMech, :Month, :Year);');
      ParamByName('IdEstimate').Value := IdEstimate;
      ParamByName('IdMech').Value := vMechId;
      ParamByName('Month').Value := vMonth;
      ParamByName('Year').Value := vYear;
      ExecSQL;
    end;

    OutputDataToTable(0);
  except
    on E: Exception do
      MessageBox(0, PChar('��� ���������� ��������� �������� ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.dbgrdDescriptionDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  with  dbgrdDescription.Canvas do
	begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;
    if gdFocused in State then // ������ � ������
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

		FillRect(Rect);
    TextOut(Rect.Left + 2, Rect.Top + 2, Column.Field.AsString);
	end;
end;

procedure TFormCalculationEstimate.dbgrdMaterialDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var str: string;
begin
  //������� ������� ����� ����� ��� ������ ���������
  with  dbgrdMaterial.Canvas do
	begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    //��������� ���� ��� (��� �������)
    if Column.Index = 1 then Brush.Color := $00F0F0FF;

    //��������� ����� ���������
    if Column.Index in [10,11,17,18] then
    begin
      //�� ��������� ������� ������������ � ������� �������������� ���������
      //������ �����
      if (Column.Index in [10,11]) then
        if (qrMaterialFPRICE_NO_NDS.AsInteger > 0) then
          Brush.Color := $00DDDDDD
        else Brush.Color := $00FBFEBC;

      if (Column.Index in [17,18]) then
        if (qrMaterialFPRICE_NO_NDS.AsInteger > 0) then
            Brush.Color := $00FBFEBC
        else Brush.Color := $00DDDDDD;
    end;

    //��������� ������� ������ ��������
    if (Column.Index in [2, 5, 6, 7]) and (Column.Field.AsFloat = 0) then
    begin
      Brush.Color := $008080FF;
    end;

    if qrMaterialSCROLL.AsInteger = 1 then
    begin
      Font.Style := Font.Style + [fsbold];
      //��� ���� �������� ��� �������������� �������������� ����������
      if not Column.ReadOnly then Brush.Color := $00AFFEFC
    end;

    //����������� ��������� �� ������� ���������
    if (qrMaterialFROM_RATE.AsInteger = 1) and
        not (qrRatesMID.AsInteger = qrMaterialID.AsInteger) then
    begin
      Font.Style := Font.Style + [fsStrikeOut];
      Brush.Color := $00DDDDDD
    end;

    //�������� ���������� �������� �� ������� ���������
    if (qrMaterialID_REPLACED.AsInteger > 0) and
       (qrMaterialFROM_RATE.AsInteger = 0) and
       (qrRatesMID.AsInteger = qrMaterialID.AsInteger) then
    begin
      Font.Style := Font.Style + [fsbold];
    end;

    //��������� ����������� ��� ����������� ���������
    if (IdReplasedMat = qrMaterialID.AsInteger) or
       (IdReplasingMat = qrMaterialID_REPLACED.AsInteger) then
      Font.Style := Font.Style + [fsbold];

    //������� �������� ��������� ��� ���������
    if CheckMatUnAccountingMatirials then
      Brush.Color := PS.BackgroundRows;

    //��������� ����� �������� �������
    if qrMaterialTITLE.AsInteger > 0 then
    begin
      Brush.Color := clNavy;
      Font.Color := clWhite;
      Font.Style := Font.Style + [fsbold];
      if Column.Index = 1 then str := Column.Field.AsString
      else str := '';
    end
    else str := Column.Field.AsString;

    if gdFocused in State then // ������ � ������
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

		FillRect(Rect);
    if Column.Alignment = taRightJustify then
      TextOut(Rect.Right - 2 - TextWidth(str), Rect.Top + 2, str)
    else
     TextOut(Rect.Left + 2, Rect.Top + 2, str);
	end;
end;

procedure TFormCalculationEstimate.dbgrdMaterialExit(Sender: TObject);
begin
  if not Assigned(FormCalculationEstimate.ActiveControl) or
    (FormCalculationEstimate.ActiveControl.Name <> 'MemoRight') then
    SetMatNoEditMode;
end;

procedure TFormCalculationEstimate.dbgrdMechanizmDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with  dbgrdMechanizm.Canvas do
	begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    //��������� ���� ��� (��� �������)
    if Column.Index = 1 then Brush.Color := $00F0F0FF;

    //��������� ����� ���������
    if Column.Index in [9,10,16,17] then
    begin
      //�� ��������� ������� ������������ � ������� �������������� ���������
      //������ �����
      if (Column.Index in [9,10]) then
        if (qrMechanizmFPRICE_NO_NDS.AsInteger > 0) then
          Brush.Color := $00DDDDDD
        else Brush.Color := $00FBFEBC;

      if (Column.Index in [16,17]) then
        if (qrMechanizmFPRICE_NO_NDS.AsInteger > 0) then
            Brush.Color := $00FBFEBC
        else Brush.Color := $00DDDDDD;
    end;

    //��������� ������� ������ ��������
    if (Column.Index in [2, 7, 8]) and (Column.Field.AsFloat = 0) then
    begin
      Brush.Color := $008080FF;
    end;

    if qrMechanizmSCROLL.AsInteger = 1 then
    begin
      Font.Style := Font.Style + [fsbold];
      //��� ���� �������� ��� �������������� �������������� ����������
      if not Column.ReadOnly then Brush.Color := $00AFFEFC
    end;

    //����������� ��������� �� ������� ���������
    if (qrMechanizmFROM_RATE.AsInteger = 1) and
        not (qrRatesMEID.AsInteger > 0) then
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
      TextOut(Rect.Right - 2 - TextWidth(Column.Field.AsString),
        Rect.Top + 2, Column.Field.AsString)
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

procedure TFormCalculationEstimate.dbgrdRatesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var j : integer;
    sdvig: string;
begin
  j := 2;
	with  dbgrdRates.Canvas do
	begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;
    if gdFocused in State then // ������ � ������
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    if qrRatesSCROLL.AsInteger = 1 then
    begin
      Font.Style := Font.Style + [fsbold];
      j := 3;
    end;

    //��������� ����������� � ����������� ��������� �� �������� ���������
    //��������� �� �������� ����� ��������� ��� �������
    if SpeedButtonMaterials.Down and qrMaterial.Active then
    begin
      if (qrRatesMID.AsInteger = qrMaterialID.AsInteger) and
         (qrRatesFROM_RATE.AsInteger = 1) then
        Font.Style := Font.Style + [fsbold];
    end;

    //��������� ����������� �� �������� ���������
    if SpeedButtonMechanisms.Down and qrMechanizm.Active then
    begin
      if (qrRatesMEID.AsInteger = qrMechanizmID.AsInteger)
         and (qrRatesFROM_RATE.AsInteger = 1) then
        Font.Style := Font.Style + [fsbold];
    end;

    // ��������� ������ ��������� ���������� �������� � ���������� ��
    if CheckMatINRates then
    begin
      Font.Color := clGray;
      if Column.Index = 1 then sdvig := Indent;
    end else sdvig := '';

		FillRect(Rect);

    TextOut(Rect.Left + j, Rect.Top + 2, sdvig + Column.Field.AsString);
	end;
end;

end.
