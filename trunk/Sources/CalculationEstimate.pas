unit CalculationEstimate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls,
  StdCtrls, Grids, DBGrids, Buttons, DB, Menus, ShellAPI, DateUtils,
  IniFiles, ImgList, Clipbrd, Math, pngimage, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls;

type
  TSplitter = class(ExtCtrls.TSplitter)
  private
    procedure Paint(); override;
  end;

  TTwoValues = record
    ForOne: Currency;
    ForCount: Currency;
  end;

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
    Splitter5: TSplitter;
    PanelTop: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Edit10: TEdit;
    Memo3: TMemo;
    DBGrid5: TDBGrid;
    PanelSummaryCalculations: TPanel;
    DBGridButtonSummaryCalculation: TDBGrid;
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
    StringGridRates: TStringGrid;
    PopupMenuTableLeft: TPopupMenu;
    PMAdd: TMenuItem;
    PopupMenuTableLeftCopy: TMenuItem;
    PMDelete: TMenuItem;
    PopupMenuTableLeftTechnicalPart: TMenuItem;
    PopupMenuTableLeftInsert: TMenuItem;
    N20: TMenuItem;
    ModeData: TMenuItem;
    Normal: TMenuItem;
    Extended: TMenuItem;
    N22: TMenuItem;
    PopupMenuMaterials: TPopupMenu;
    PMMatColumns: TMenuItem;
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
    PMMatResourcesSettings: TMenuItem;
    SpeedButtonModeTables: TSpeedButton;
    PMMatResources: TMenuItem;
    PMMatResourcesDelete: TMenuItem;
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
    StringGridMaterials: TStringGrid;
    StringGridEquipments: TStringGrid;
    StringGridDescription: TStringGrid;
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
    PMMechColumns: TMenuItem;
    PopupMenuEquipments: TPopupMenu;
    PMEqFromRates: TMenuItem;
    PMEqColumns: TMenuItem;
    PanelHint: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
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
    qrData: TFDQuery;
    ADOQueryCardRates: TFDQuery;
    ADOQueryTemp: TFDQuery;
    ADOQueryMaterialCard: TFDQuery;
    ADOQueryMechanizmCard: TFDQuery;
    Memo1: TMemo;
    StringGridMechanizms: TStringGrid;

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

    // PopupMenu
    procedure StringGridRatesColumnsClick(Sender: TObject);
    procedure PMMatColumnsClick(Sender: TObject);

    // ������� ������ ������
    procedure SpeedButtonDescriptionClick(Sender: TObject);
    procedure SpeedButtonMaterialsClick(Sender: TObject);
    procedure SpeedButtonMechanismsClick(Sender: TObject);

    // ����� �������
    procedure StringGridRatesClick(Sender: TObject);
    procedure StringGridRatesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGridRatesKeyPress(Sender: TObject; var Key: Char);

    // ������ �������
    procedure StringGridRightClick(Sender: TObject);
    procedure StringGridRightDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);

    // ����� �������� �� ��� ������ �������
    procedure FillingTableMaterials(const vIdCardRate, vIdMat: string);
    procedure FillingMaterials(const AQ: TFDQuery; const vGroup: Char);
    procedure FillingTableMechanizm(const vIdCardRate, vIdMech: string);
    procedure FillingMechanizm;
    procedure FillingTableDescription(const vIdNormativ: string);

    procedure Calculation;

    procedure CalculationMaterial;
    procedure CalculationColumnPriceMaterial;

    procedure CalculationMechanizm;
    procedure CalculationColumnPriceMechanizm;

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

    // ����� ����������� ��������� � �������� StringGrid
    procedure ShowHintInTables(const SG: TStringGrid; const vCol, vRow: Integer);

    procedure EstimateBasicDataClick(Sender: TObject);
    procedure LabelObjectClick(Sender: TObject);
    procedure LabelEstimateClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure LabelMouseEnter(Sender: TObject);
    procedure LabelMouseLeave(Sender: TObject);
    procedure PanelObjectResize(Sender: TObject);
    procedure ComboBoxOXROPRChange(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure StringGridRatesEnter(Sender: TObject);
    procedure PanelTopMenuResize(Sender: TObject);
    procedure SettingVisibleRightTables;
    procedure PanelClientRightTablesResize(Sender: TObject);
    procedure SpeedButtonEquipmentsClick(Sender: TObject);
    procedure SpeedButtonModeTablesClick(Sender: TObject);
    procedure SettingTablesFromFile(SG: TStringGrid);
    procedure ClearTable(SG: TStringGrid);
    procedure GetMonthYearCalculationEstimate;
    procedure PanelClientLeftResize(Sender: TObject);
    procedure PMMatResourcesSettingsClick(Sender: TObject);
    procedure PMMatResourcesDeleteClick(Sender: TObject);
    procedure FillingOXROPR;
    procedure GetSourceData;
    procedure SetIndexOXROPR(vNumber: string);
    procedure GetValuesOXROPR;
    procedure FillingWinterPrice(vNumber: string);

    procedure PMDeleteClick(Sender: TObject);
    procedure PanelNoDataResize(Sender: TObject);
    procedure TestOnNoData(SG: TStringGrid);
    procedure PopupMenuTableLeftCopyClick(Sender: TObject);
    procedure PopupMenuTableLeftInsertClick(Sender: TObject);
    procedure StringGridKeyPress(Sender: TObject; var Key: Char);
    procedure PopupMenuRatesAdd(Sender: TObject);
    procedure PMMatFromRatesClick(Sender: TObject);
    procedure StringGridMouseLeaveRight(Sender: TObject);
    procedure StringGridMouseMoveRight(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure TestFromRates(const SG: TStringGrid; const vCol, vRow: Integer);
    procedure CopyEstimate;
    procedure VisibleColumnsWinterPrice(Value: Boolean);
    procedure StringGridRatesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure ReplacementNumber(Sender: TObject);
    procedure ReplacementMaterial(const vIdMat: Integer);
    procedure NumerationRates;

    procedure PMMatReplaceTableClick(Sender: TObject);
    procedure ShowFormAdditionData(const vDataBase: Char);
    procedure PMAddRatMatMechEquipRefClick(Sender: TObject);
    procedure PMAddRatMatMechEquipOwnClick(Sender: TObject);
    procedure PMMatEditClick(Sender: TObject);

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
    procedure SplitterLeftMoved(Sender: TObject);
    procedure Button4Click(Sender: TObject);

    procedure UpdateTableDataTemp;
    procedure UpdateTableCardRatesTemp;
    procedure UpdateTableCardMechanizmTemp;
    procedure UpdateTableCardMaterialTemp;

    procedure GetInfoAboutData;
    procedure OutputDataToTable;

    procedure AddMaterial(const vMatId: Integer);
    procedure AddMechanizm(const vMechId, vMonth, vYear: Integer);
    function AllocateMaterial(const vIdInMat: Integer): Boolean;
    function CrossOutMaterial(const vIdInMat: Integer): Boolean;
  private
    ActReadOnly: Boolean;
    CountRowRates: Integer;

    CountCoef: Integer;
    RowCoefDefault: Boolean;
    NameRowCoefDefault: String;

    IdObject: Integer;
    IdEstimate: Integer;

    MonthEstimate: Integer;
    YearEstimate: Integer;

    VisibleRightTables: String;

    WCWinterPrice: Integer;
    WCSalaryWinterPrice: Integer;

    CountFromRate: Double;

    DataBase: Char;

    // ----------------------------------------

    TypeData: Integer;
    // ��� ������: 0-������ ����� ������,1-��������, 2-���������, 3-��������, 4-������������

    IdInRate: Integer; // ���� Id � ������� card_rate
    RateId: Integer; // Id ��������
    RateCode: string; // ��� ��������

    IdInMat: Integer; // ���� Id � ������� materialcard
    MatId: Integer; // Id ���������
    MatIdCardRate: Integer; // ���� id_card_rate � ������� material_card
    MatIdReplaced: Integer;
    // ���� �� ����� 0, �� �������� ���������� ��������� ��������
    MatReplaced: Boolean;
    // ��� �� ��������� �������� ������ ������ ����������
    MatConsidered: Boolean; // ��Ҩ���� ��������
    MatFromRate: Boolean; // �������� �� �������� ���������� �� ��������
    MatIdForAllocate: Integer;
    // ���� Id � ������� ����������, ��� ��������� ����� ������

    IdInMech: Integer; // ���� Id � ������� mechanizmcard
    MechId: Integer; // Id ���������
    MechFromRate: Boolean; // �������� �� ��������� ���������� �� ��������
    MechIdForAllocate: Integer;
    // ���� Id � ������� ���������, ��� ��������� ����� ������

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
    function GetIdRate: Integer;
    function GetMonth: Integer;
    function GetYear: Integer;
    procedure AddRowToTableRates(FieldRates: TFieldRates);
    procedure CreateTempTables;
    procedure OpenAllData;

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
  CardAct;

{$R *.dfm}

{ TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
  FormCalculationEstimate.RepaintImagesForSplitters();
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

  VisibleRightTables := '1000';
  SettingVisibleRightTables;

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

  PanelClientLeft.Width := (FormMain.ClientWidth - 5) div 3;

  StringGridCalculations.Constraints.MinHeight := 50;
  PanelClientLeft.Constraints.MinWidth := 30;
  Memo1.Constraints.MinHeight := 45;
  MemoRight.Constraints.MinHeight := 45;
  StringGridMaterials.Constraints.MinHeight := 50;

  // -----------------------------------------

  FillingOXROPR;

  SettingTablesFromFile(StringGridRates);
  SettingTablesFromFile(StringGridMaterials);
  SettingTablesFromFile(StringGridMechanizms);
  // SettingTablesFromFile(StringGridEquipments);
  SettingTablesFromFile(StringGridDescription);
  SettingTablesFromFile(StringGridCalculations);

  FillingCoeffBottomTable; // ��������� ������ � ��������������

  CountRowRates := 1;
  // ����� ������ � ������� �������� ������� ������, � ��� �� ���������� ������� � ����� �������

  ConfirmCloseForm := True;

  CountCoef := 1;
  RowCoefDefault := True;

  // -----------------------------------------

  // ������ ������ � ������ ��������
  PanelTableBottom.Height := 110 + PanelBottom.Height;

  // -----------------------------------------

  FormMain.CreateButtonOpenWindow(CaptionButtonCalculationEstimate, HintButtonCalculationEstimate,
    FormMain.ShowCalculationEstimate);
end;

procedure TFormCalculationEstimate.FormShow(Sender: TObject);
begin
  SettingVisibleRightTables;

  // R �������� ����� ������� (������ �����������)
  // R Rates.ParamByName('').AsInteger:=1;
  // R Rates.ParamByName('').AsInteger:=2;
  // R Rates.Active := True;
  // ������������� �����
  // R GridRates.SetFocus;
  StringGridRates.SetFocus;

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

procedure TFormCalculationEstimate.SplitterLeftMoved(Sender: TObject);
begin
  FormMain.AutoWidthColumn(StringGridRates, 3);
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

    PanelButtonsSSR.Align := alClient;

    // -----------------------------------------

    // ������ ������ �������� ������� ���� �����������
    BottomTopMenuEnabled(False);

    PanelCalculationYesNo.Enabled := False;
    PanelCalculationYesNo.Color := clSilver;
  end;
end;

procedure TFormCalculationEstimate.SpeedButtonMaterialsClick(Sender: TObject);
begin
  TestOnNoData(StringGridMaterials);

  if SpeedButtonModeTables.Tag = 0 then
    VisibleRightTables := '1000'
  else
    VisibleRightTables := '1110';

  SettingVisibleRightTables;

  StringGridRightClick(StringGridMaterials);
end;

procedure TFormCalculationEstimate.SpeedButtonMechanismsClick(Sender: TObject);
begin
  TestOnNoData(StringGridMechanizms);

  if SpeedButtonModeTables.Tag = 0 then
    VisibleRightTables := '0100'
  else
    VisibleRightTables := '1110';

  SettingVisibleRightTables;

  StringGridRightClick(StringGridMechanizms);
end;

procedure TFormCalculationEstimate.SpeedButtonEquipmentsClick(Sender: TObject);
begin
  TestOnNoData(StringGridEquipments);

  if SpeedButtonModeTables.Tag = 0 then
    VisibleRightTables := '0010'
  else
    VisibleRightTables := '1110';

  SettingVisibleRightTables;

  StringGridRightClick(StringGridEquipments);
end;

procedure TFormCalculationEstimate.SpeedButtonDescriptionClick(Sender: TObject);
begin
  TestOnNoData(StringGridDescription);

  VisibleRightTables := '0001';

  SettingVisibleRightTables;

  StringGridRightClick(StringGridDescription);
end;

procedure TFormCalculationEstimate.SpeedButtonModeTablesClick(Sender: TObject);
begin
  with SpeedButtonModeTables do
  begin
    Glyph.Assign(nil);

    if Tag = 1 then
    begin
      Tag := 0;
      Hint := '����� ������ ������: ���������, ���������, ������������';
      DM.ImageListModeTables.GetBitmap(0, SpeedButtonModeTables.Glyph);
    end
    else
    begin
      Tag := 1;
      Hint := '����� ����� �������';
      DM.ImageListModeTables.GetBitmap(1, SpeedButtonModeTables.Glyph);
    end;
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

procedure TFormCalculationEstimate.PanelClientLeftResize(Sender: TObject);
begin
  FormMain.AutoWidthColumn(StringGridRates, 3);
end;

procedure TFormCalculationEstimate.PanelClientRightTablesResize(Sender: TObject);
var
  H: Integer;
begin
  if VisibleRightTables = '0001' then
  begin
    FormMain.AutoWidthColumn(StringGridDescription, 1);
  end
  else if VisibleRightTables = '1110' then
  begin
    H := PanelClientRightTables.Height - SplitterRight1.Height - SplitterRight2.Height;

    StringGridMaterials.Height := H div 3;
    StringGridMechanizms.Height := StringGridMaterials.Height;
    StringGridEquipments.Height := StringGridMaterials.Height;
  end;

  if VisibleRightTables[1] = '1' then
    FormMain.AutoWidthColumn(StringGridMaterials, 1);
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
  with StringGridRates do
    NumberNormativ := Cells[1, Row];

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

procedure TFormCalculationEstimate.N3Click(Sender: TObject);
begin
  FormSummaryCalculationSettings.ShowModal;
end;

procedure TFormCalculationEstimate.PMCoefOrdersClick(Sender: TObject);
begin
  FormCoefficientOrders.ShowForm(IdEstimate, RateId, 0);
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

procedure TFormCalculationEstimate.PMMatResourcesSettingsClick(Sender: TObject);
begin
  with FormPercentClientContractor, StringGridMaterials do
  begin
    StrPercent := Cells[ColCount - 1, Row];
    ShowModal;
  end;

  with StringGridMaterials do
  begin
    Cells[ColCount - 1, Row] := FormPercentClientContractor.StrPercent;
    Repaint;
  end;
end;

procedure TFormCalculationEstimate.PMMatResourcesDeleteClick(Sender: TObject);
begin
  with StringGridMaterials do
  begin
    Cells[ColCount - 1, Row] := '';
    Repaint;
  end;
end;

procedure TFormCalculationEstimate.PMMatFromRatesClick(Sender: TObject);
begin
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE materialcard_temp SET from_rate = 1 WHERE id = :id;');
      ParamByName('id').Value := IdInMat;
      ExecSQL;
    end;

    OutputDataToTable;

    StringGridRates.Repaint;
    StringGridMaterials.Repaint;
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
          with ADOQueryTemp do
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
      // CanClose := False; // �������
    end
    else
      try
        with ADOQueryTemp do
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

procedure TFormCalculationEstimate.StringGridKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if SpeedButtonMaterials.Down then
    begin
      CalculationMaterial;
      CalculationColumnPriceMaterial;
    end
    else if SpeedButtonMechanisms.Down then
    begin
      CalculationMechanizm;
      CalculationColumnPriceMechanizm;
    end;

    with Sender as TStringGrid do
      Repaint;

    Exit;
  end;

  if not(Key in ['0' .. '9', #8, '.', ',']) then
    Key := #0;

  with Sender as TStringGrid do
    Repaint;
end;

procedure TFormCalculationEstimate.StringGridMouseMoveRight(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  SG: TStringGrid;
  vCol, vRow: Integer;
begin
  SG := (Sender as TStringGrid);

  with SG do
    MouseToCell(X, Y, vCol, vRow);

  ShowHintInTables(SG, vCol, vRow);
  TestFromRates(SG, vCol, vRow);
end;

procedure TFormCalculationEstimate.StringGridMouseLeaveRight(Sender: TObject);
begin
  PanelHint.Visible := False;
end;

//����� ������ � ������� ��������
procedure TFormCalculationEstimate.StringGridRatesClick(Sender: TObject);
var
  i: Integer;
  vIdNormativ: string;
  VAT, vClass, Distance, More, Mass, IdDump, Count: Integer;
  TwoValuesSalary, TwoValuesEMiM: TTwoValues;
  CalcPrice: string[2];
begin
  PanelHint.Visible := False;
  // ���������/��������� �������������� � ������
  if (Sender.ClassName = 'TStringGrid') then
    with (Sender as TStringGrid) do
      // ���� ������� ������ "����������", � � ������� ������ ���� ������
      // ��� ������� ������ "� ���������", � � ������� ������ ��� ������
      if ((Col = 2) and (Cells[0, Row] <> '')) or
         ((Col = 1) and (Cells[0, Row] = '')) then
        Options := Options + [goEditing] // ��������� ��������������
      else
        Options := Options - [goEditing]; // ��������� ��������������

  // -----------------------------------------

  Memo1.Text := StringGridRates.Cells[4, StringGridRates.Row];
  // Rates.FieldByName('DESCR').AsString; // R SGRatesCells[4, Row];

  // -----------------------------------------

  // ��������� ���� ������ � ���������� ������
  with (Sender as TStringGrid) do
    if Cells[5, Row] <> '' then
      ComboBoxTypeData.ItemIndex := StrToInt(Cells[5, Row]) - 1
    else
      ComboBoxTypeData.ItemIndex := -1;

  // -----------------------------------------

  SpeedButtonDescription.Enabled := False;
  SpeedButtonMaterials.Enabled := False;
  SpeedButtonMechanisms.Enabled := False;
  SpeedButtonEquipments.Enabled := False;
  SpeedButtonModeTables.Enabled := False;

  PanelClientRight.Visible := False;
  PanelNoData.Visible := True;

  // -----------------------------------------

  // ������� ������ �������-����������
  EditCategory.Text := '';
  EditWinterPrice.Text := '';

  // ������� ����� �������-����������
  StringGridCalculations.Cells[11, CountCoef + 2] := '';

  // ������� ����� ����������
  StringGridCalculations.Cells[12, CountCoef + 2] := '';

  // -----------------------------------------

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
    Cells[1, RowCount - 2] := StringGridRates.Cells[3, StringGridRates.Row];
    Cells[1, RowCount - 1] := StringGridRates.Cells[2, StringGridRates.Row];
  end;
  StringGridCalculations.Enabled := True;

  PopupMenuCoefAddSet.Enabled := True;
  PopupMenuCoefDeleteSet.Enabled := True;

  CalcPrice := '00';

  // -----------------------------------------

  PMDelete.Enabled := True;
  PMReplace.Enabled := False;
  PMEdit.Enabled := False;

  GetInfoAboutData; //���������� ���������� �� ��������� ������

  // ���¨�������� ��������� �������� � �������� ������

  case ComboBoxTypeData.ItemIndex of
    0: // ��������
      begin
        PMEdit.Enabled := True;

        CountFromRate := MyStrToFloat(StringGridRates.Cells[2, StringGridRates.Row]);

        SpeedButtonDescription.Enabled := True;
        SpeedButtonMaterials.Enabled := True;
        SpeedButtonMaterials.Down := True;

        SpeedButtonMechanisms.Enabled := True;
        SpeedButtonEquipments.Enabled := True;
        SpeedButtonModeTables.Enabled := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // -----------------------------------------

        FillingTableMaterials(IntToStr(IdInRate), '0');
        FillingTableMechanizm(IntToStr(IdInRate), '0');
        FillingTableDescription(IntToStr(RateId));

        // SpeedButtonMaterials.Down := True;
        // SpeedButtonMaterialsClick(SpeedButtonMaterials);

        // -----------------------------------------

        // ��������, ���� ������� ������� � ������� ��� ������,
        // ���������� ������ ������ � ���������

        if SpeedButtonMaterials.Down then
          TestOnNoData(StringGridMaterials)
        else if SpeedButtonMechanisms.Down then
          TestOnNoData(StringGridMechanizms)
        else if SpeedButtonEquipments.Down then
          TestOnNoData(StringGridEquipments)
        else
          TestOnNoData(StringGridDescription);

        StringGridMaterials.Repaint;

        // ----------------------------------------

        // ������� ������ �������-����������
        EditCategory.Text := MyFloatToStr(GetRankBuilders(IntToStr(RateId)));

        // ������� ����� �������-����������
        StringGridCalculations.Cells[11, CountCoef + 2] :=
          MyFloatToStr(GetWorkCostBuilders(IntToStr(RateId)));

        // ������� ����� ����������
        StringGridCalculations.Cells[12, CountCoef + 2] :=
          MyFloatToStr(GetWorkCostMachinists(IntToStr(RateId)));

        SetIndexOXROPR(StringGridRates.Cells[1, StringGridRates.Row]);

        // �������� �������� ��� � ��� � ���� �������
        GetValuesOXROPR;

        // �������� ������ ������� ����������
        FillingWinterPrice(StringGridRates.Cells[1, StringGridRates.Row]);

        // if StringGridMaterials.RowCount > 1 then
        // StringGridMaterials.Row := 2;

        Calculation;

        CalcPrice := '11';
        //�������� �� ������ ����������, ��� ����������� ������� ����������
        SpeedButtonMaterialsClick(SpeedButtonMaterials);
      end;
    1: // ��������
      begin
        SpeedButtonMaterials.Enabled := True;
        SpeedButtonMaterials.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        with (Sender as TStringGrid) do
        begin
          if MatIdCardRate = 0 then
            FillingTableMaterials('', IntToStr(MatId))
          else
          begin
            if not MatConsidered then
            begin
              PMReplace.Enabled := True;
              PMDelete.Enabled := False;
            end
            else
              PMEdit.Enabled := True;

            StringGridMaterials.Repaint;
            Repaint;
            FillingTableMaterials(IntToStr(MatIdCardRate), '0');
          end;
        end;

        // -----------------------------------------

        // ������� ������ �������-����������
        EditCategory.Text := MyFloatToStr(GetRankBuilders(IntToStr(RateId)));

        // ������� ����� �������-����������
        StringGridCalculations.Cells[11, CountCoef + 2] :=
          MyFloatToStr(GetWorkCostBuilders(IntToStr(RateId)));

        EditCategory.Text := MyFloatToStr(GetWorkCostBuilders(IntToStr(RateId)));

        // ������� ����� ����������
        // StringGridCalculations.Cells[12, CountCoef + 2] := MyFloatToStr(GetWorkCostMachinists(IdNormativ));

        SetIndexOXROPR(StringGridRates.Cells[1, StringGridRates.Row]);

        // �������� �������� ��� � ��� � ���� �������
        GetValuesOXROPR;

        // �������� ������ ������� ����������
        FillingWinterPrice(RateCode);

        // -------------------------------------

        CalculationMaterial;

        CalcPrice := '10';
        //�������� �� ������ ����������, ��� ����������� ������� ����������
        SpeedButtonMaterialsClick(SpeedButtonMaterials);
      end;
    2: // ��������
      begin
        SpeedButtonMechanisms.Enabled := True;
        SpeedButtonMechanisms.Down := True;

        PanelClientRight.Visible := True;
        PanelNoData.Visible := False;

        // -----------------------------------------

        FillingTableMechanizm('', IntToStr(MechId));
        // FillingTableMechanizm(IntToStr(RateId), '0');

        // -----------------------------------------

        // ������� ������ �������-����������
        // EditCategory.Text := MyFloatToStr(GetRankBuilders(IdNormativ));

        // ������� ����� �������-����������
        // StringGridCalculations.Cells[11, CountCoef + 2] := MyFloatToStr(GetWorkCostBuilders(IdNormativ));

        // ������� ����� ����������
        StringGridCalculations.Cells[12, CountCoef + 2] :=
          MyFloatToStr(GetWorkCostMachinists(IntToStr(RateId)));

        SetIndexOXROPR(StringGridRates.Cells[1, StringGridRates.Row]);

        // �������� �������� ��� � ��� � ���� �������
        GetValuesOXROPR;

        // �������� ������ ������� ����������
        FillingWinterPrice(RateCode);

        // -------------------------------------

        CalculationMechanizm;

        CalcPrice := '01';

        //�������� �� ������ ����������, ��� ����������� ������� ����������
        SpeedButtonMechanismsClick(SpeedButtonMechanisms);
      end;
    3: // ������������
      begin

      end;
    4, 5, 6, 7: // ��������� ������/������ ����������� �310/�311
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
          with ADOQueryTemp do
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
          with ADOQueryTemp do
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
          with ADOQueryTemp do
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
          with ADOQueryTemp do
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
  end;

  if CalcPrice[1] = '1' then
    CalculationColumnPriceMaterial;

  if CalcPrice[2] = '1' then
    CalculationColumnPriceMechanizm;
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

function TFormCalculationEstimate.GetIdRate: Integer;
begin
  Result := RateId;
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

  StringGridRatesClick(StringGridRates);
end;

procedure TFormCalculationEstimate.PopupMenuCoefOrdersClick(Sender: TObject);
begin
  FormCoefficientOrders.ShowForm(IdEstimate, RateId, 0);
  GetStateCoefOrdersInRate;
end;

procedure TFormCalculationEstimate.PopupMenuCoefPopup(Sender: TObject);
begin
  GetStateCoefOrdersInEstimate;
end;

procedure TFormCalculationEstimate.PopupMenuMaterialsPopup(Sender: TObject);
begin
  PMMatFromRates.Enabled := False;

  with (StringGridMaterials) do
    if (Pos('�', Cells[1, Row]) = 1) then
      if not MatFromRate then
      begin
        PMMatFromRates.Enabled := True;
        // PMMatFromRates.Caption := '������ � ��������';
        // PMMatFromRates.Tag := 0;
      end
      else
      begin
        // PMMatFromRates.Caption := '������� �� ��������';
        // PMMatFromRates.Tag := 1;
      end;

  if Pos('�', StringGridMaterials.Cells[1, StringGridMaterials.Row]) = 1 then
  // ���� ������� ��������� (�-����)
  begin
    PMMatEdit.Enabled := False;
    PMMatResources.Enabled := False;
    PMMatReplace.Enabled := True;
  end
  else // ���� ������ �-���
  begin
    if IdInMat = 0 then PMMatEdit.Enabled := False  //���� ������ ������� �����
    else PMMatEdit.Enabled := True;

    PMMatResources.Enabled := True;
    PMMatReplace.Enabled := False;
  end;
end;

procedure TFormCalculationEstimate.StringGridRatesColumnsClick(Sender: TObject);
begin
  FormColumns.SetNameTable('StringGridRates');
  FormColumns.ShowModal;
end;

procedure TFormCalculationEstimate.StringGridRatesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  with Sender as TStringGrid do
  begin
    // ���������� ����� �������
    if (ARow = 0) or (ACol = 0) then
    begin
      Canvas.Brush.Color := PS.BackgroundHead;
      Canvas.Font.Color := PS.FontHead;
    end
    else // ���������� ���� ��������� �����
    begin
      Canvas.Brush.Color := PS.BackgroundRows;
      Canvas.Font.Color := PS.FontRows;
    end;

    Canvas.Font.Style := Canvas.Font.Style - [fsbold];
    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);

    // ----------------------------------------

    // ���� ������� � ������ � ������ �� ����� ������ ������
    if Focused and (Row = ARow) and (Row > 0) and (ACol > 0) then
    begin
      if gdFocused in State then // ������ � ������
      begin
        Canvas.Brush.Color := PS.BackgroundSelectCell;
        Canvas.Font.Color := PS.FontSelectCell;
      end;

      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, Row]);
    end;

    // ----------------------------------------

    // ��������� ������ ��������� ���������� ��������
    if Pos(Indent, Cells[1, ARow]) > 0 then
    begin
      Canvas.Font.Color := clGray;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
    end;

    // ----------------------------------------

    if Cells[5, ARow] = '2' then // ���� ������ � ����������
      // ��������� ������ ������� ����Ҩ���� ����������, ���������� ���������� �������, � ���������� �� �������� ����������
      if AllocateMaterial(StrToInt(Cells[6, ARow])) then
      begin
        Canvas.Font.Style := Canvas.Font.Style + [fsbold];
        Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
      end;
  end;
end;

procedure TFormCalculationEstimate.StringGridRatesEnter(Sender: TObject);
var
  KeyState: TKeyboardState;
begin
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // �������
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // ����������
end;

procedure TFormCalculationEstimate.StringGridRatesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // ��������� ������� ������� �� ��������� ������
  with (Sender as TStringGrid) do
    if (ColWidths[Col + 1] = -1) and (Key = Ord(#39)) then
      Key := Ord(#0);
end;

procedure TFormCalculationEstimate.StringGridRatesKeyPress(Sender: TObject; var Key: Char);
begin
  with StringGridRates do
    if (Col = 1) and (Key = #13) then // ������� ������ "� ���������"
    begin
      AddRate(Cells[1, Row], MyStrToFloatdef(Cells[2, Row], 0));
    end
    else if Col = 2 then
    // ������� ������ "����������"
    begin
      if not(Key in ['0' .. '9', #8, #13, ',', '.', '-']) then
        Key := #0;

      if Key = ',' then
        Key := '.';

      with StringGridRates do
        if Cells[Col, Row] = '' then
          Cells[Col, Row] := '0';

      // ��������� ������ � ������ �������
      if Key = #13 then
      begin
        if Cells[5, Row] = '1' then
        begin
          // -->���������� ���-��
          ADOQueryTemp.SQL.Text := 'UPDATE card_rate_temp set rate_count=:RC WHERE ID=:ID;';
          ADOQueryTemp.ParamByName('ID').AsInteger := StrToInt(Cells[6, Row]);
          ADOQueryTemp.ParamByName('RC').AsFloat := MyStrToFloat(Cells[2, Row]);
          ADOQueryTemp.ExecSQL;
          // <--
        end;
        if Cells[5, Row] = '2' then
        begin
          // -->���������� ���-��
          ADOQueryTemp.SQL.Text := 'UPDATE materialcard_temp set mat_count=:RC WHERE ID=:ID;';
          ADOQueryTemp.ParamByName('ID').AsInteger := StrToInt(Cells[6, Row]);
          ADOQueryTemp.ParamByName('RC').AsFloat := MyStrToFloat(Cells[2, Row]);
          ADOQueryTemp.ExecSQL;
          // <--
        end;
        StringGridRatesClick(Sender);
      end;
    end;
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
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT normativ_id FROM normativg WHERE norm_num = :norm_num;');
      ParamByName('norm_num').Value := RateNumber;
      Active := True;

      if RecordCount <= 0 then
      begin
        if MessageBox(0, PChar('�������� � ��������� ������� �� ���� �������!' + sLineBreak +
          '�������� ���� � �������� ���������?'), CaptionForm, MB_ICONINFORMATION + MB_YESNO + mb_TaskModal)
          = mrYes then
          StringGridRates.Cells[1, StringGridRates.Row] := '';

        Exit;
      end;

      vIdRate := FieldByName('normativ_id').AsVariant;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������ Id �������� �������� ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // -----------------------------------------

  // ��������� ��������� �������� �� ��������� ������� card_rate_temp
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL AddRate(:id_estimate, :id_rate, :cnt);');
      ParamByName('id_estimate').Value := IdEstimate;
      ParamByName('id_rate').Value := vIdRate;
      ParamByName('cnt').AsFloat := Count;
      ExecSQL;
    end;

    UpdateTableDataTemp;
    UpdateTableCardRatesTemp;

    with ADOQueryTemp do
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
    UpdateTableCardMaterialTemp;
    with ADOQueryTemp do
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
        with ADOQueryMaterialCard do
        begin
          Insert;
          FieldByName('BD_ID').AsInteger := 1;
          FieldByName('ID_CARD_RATE').AsInteger := vMaxIdRate;
          FieldByName('MAT_ID').AsInteger := ADOQueryTemp.FieldByName('MatId').AsInteger;
          FieldByName('MAT_CODE').AsString := ADOQueryTemp.FieldByName('MatCode').AsString;
          FieldByName('MAT_NAME').AsString := ADOQueryTemp.FieldByName('MatName').AsString;

          vNormRas := MyStrToFloatDef(ADOQueryTemp.FieldByName('MatNorm').AsString,0);

          FieldByName('MAT_NORMA').AsFloat := vNormRas;
          FieldByName('MAT_UNIT').AsString := ADOQueryTemp.FieldByName('MatUnit').AsString;
          FieldByName('COAST_NO_NDS').AsCurrency := ADOQueryTemp.FieldByName('PriceNoVAT').AsCurrency;
          FieldByName('COAST_NDS').AsCurrency := ADOQueryTemp.FieldByName('PriceVAT').AsCurrency;
          FieldByName('NDS').AsFloat := 0;
          FieldByName('COEF_TR_ZATR').AsFloat := ADOQueryTemp.FieldByName('PercentTransport').AsFloat;
          Refresh;
          //Post;
        end;

        Next;
      end;

      Filtered := False;
      Filter := 'MatCode LIKE ''�%''';
      Filtered := True;

      First;

      while not Eof do
      begin
        with ADOQueryMaterialCard do
        begin
          Insert;
          FieldByName('BD_ID').AsInteger := 1;
          FieldByName('ID_CARD_RATE').AsInteger := vMaxIdRate;
          FieldByName('CONSIDERED').AsInteger := 0;
          FieldByName('MAT_ID').AsInteger := ADOQueryTemp.FieldByName('MatId').AsVariant;
          FieldByName('MAT_CODE').Value := ADOQueryTemp.FieldByName('MatCode').AsVariant;
          FieldByName('MAT_NAME').AsString := ADOQueryTemp.FieldByName('MatName').AsString;

          vNormRas := MyStrToFloatDef(ADOQueryTemp.FieldByName('MatNorm').AsString,0);

          FieldByName('MAT_NORMA').AsFloat := vNormRas;
          FieldByName('MAT_UNIT').AsString := ADOQueryTemp.FieldByName('MatUnit').AsString;
          FieldByName('COAST_NO_NDS').AsCurrency := ADOQueryTemp.FieldByName('PriceNoVAT').AsCurrency;
          FieldByName('COAST_NDS').AsCurrency := ADOQueryTemp.FieldByName('PriceVAT').AsCurrency;
          FieldByName('NDS').AsFloat := 0;
          FieldByName('COEF_TR_ZATR').AsFloat := ADOQueryTemp.FieldByName('PercentTransport').AsFloat;

          Refresh;
          //Post;
        end;

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
    with ADOQueryMechanizmCard do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM mechanizmcard_temp;');
      Active := True;
    end;

    with ADOQueryTemp do
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
        with ADOQueryMechanizmCard do
        begin
          Insert;

          FieldByName('BD_ID').AsInteger := 1;
          FieldByName('ID_CARD_RATE').AsInteger := vMaxIdRate;
          FieldByName('MECH_ID').AsInteger := ADOQueryTemp.FieldByName('MechId').AsInteger;
          FieldByName('MECH_CODE').AsString := ADOQueryTemp.FieldByName('MechCode').AsString;
          FieldByName('MECH_NAME').AsString := ADOQueryTemp.FieldByName('MechName').AsString;

          vNormRas := MyStrToFloatDef(ADOQueryTemp.FieldByName('MechNorm').AsString, 0);

          FieldByName('MECH_NORMA').AsFloat := vNormRas;

          FieldByName('MECH_UNIT').AsString := ADOQueryTemp.FieldByName('Unit').AsString;
          FieldByName('COAST_NO_NDS').AsInteger := ADOQueryTemp.FieldByName('CoastNoVAT').AsInteger;
          FieldByName('COAST_NDS').AsInteger := ADOQueryTemp.FieldByName('CoastVAT').AsInteger;
          FieldByName('NDS').AsFloat := 0;
          FieldByName('ZP_MACH_NO_NDS').AsInteger := ADOQueryTemp.FieldByName('SalaryNoVAT').AsInteger;
          FieldByName('ZP_MACH_NDS').AsInteger := ADOQueryTemp.FieldByName('SalaryVAT').AsInteger;

          Post;
        end;

        Next;
      end;

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ���������� �� ��������� ������� �������� ������:' + sLineBreak +
        sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  OutputDataToTable;


  with StringGridRates do
  begin
    Col := 2;
    SetFocus;
  end;

  StringGridRatesClick(StringGridRates);
end;

procedure TFormCalculationEstimate.StringGridRightClick(Sender: TObject);
begin
  with (Sender as TStringGrid) do
  begin
    if Name = 'StringGridMaterials' then
    try
      IdInMat := 0;
      MatId := 0;
      MatIdCardRate := 0;
      MatIdReplaced := 0;
      MatConsidered := True;
      MatReplaced := False;
      MatFromRate := False;

      MatIdForAllocate := 0;

      //�� ������ ���� ������� ������ � ����� ����� �� ����� �������
      if StringGridMaterials.Row = 0 then exit;

      if StringGridMaterials.Cells[14, StringGridMaterials.Row] = '' then exit;

      with ADOQueryTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT id, mat_id, id_card_rate, id_replaced, considered, replaced, from_rate ' +
          'FROM materialcard_temp WHERE id = :id;');
        ParamByName('id').Value := StrToInt(StringGridMaterials.Cells[14, StringGridMaterials.Row]);
        Active := True;

        // ----------------------------------------

        IdInMat := FieldByName('id').AsInteger;
        MatId := FieldByName('mat_id').AsInteger;
        MatIdCardRate := FieldByName('id_card_rate').AsInteger;
        // Id �� ������� ��������
        MatIdReplaced := FieldByName('id_replaced').AsInteger;
        // Id � ����. ���., ����� ���. ��� ������ ���� ���.

        if MatIdReplaced > 0 then
          MatIdForAllocate := MatIdReplaced;

        if FieldByName('considered').AsInteger = 0 then
        // ���� ������� ����Ҩ���� ��������
        begin
          MatConsidered := False; // �������� �������� ����Ҩ����
          MatIdForAllocate := FieldByName('id').AsInteger;
          if FieldByName('replaced').AsInteger = 1 then
            // ���� ����Ҩ���� �������� ��� ������ �� ������
            MatReplaced := True;
        end;

        if FieldByName('from_rate').AsInteger = 1 then
        // ���� �������� ������� �� ��������
        begin
          MatFromRate := True;
          MatIdForAllocate := FieldByName('id').AsInteger;
        end;

        // ----------------------------------------

        Active := False;
      end;
    except
      on E: Exception do
        MessageBox(0, PChar('��� ��������� ����������������� ������ ��������� �������� ������:' + sLineBreak +
          sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
  end;
  // ----------------------------------------

  with (Sender as TStringGrid) do
  begin
    // ���������/��������� �������������� � ������

    if Name = 'StringGridMaterials' then
    begin
      if (Col = 10) then
        Options := Options + [goEditing] // ��������� ��������������
      else
        Options := Options - [goEditing]; // ��������� ��������������

      StringGridRates.Repaint;
    end;

    if Name = 'StringGridMechanizms' then
      if (Col = 7) then
        Options := Options + [goEditing] // ��������� ��������������
      else
        Options := Options - [goEditing]; // ��������� ��������������
  end;

  // ----------------------------------------

  // ������� �������� ������ � Memo ��� ��������
  with (Sender as TStringGrid), MemoRight do
  begin
    if SpeedButtonDescription.Down then
      Text := Cells[1, Row]
    else if SpeedButtonMaterials.Down then
      Text := (Sender as TStringGrid).Cells[ColCount - 2, Row]
    else if SpeedButtonMechanisms.Down then
      Text := (Sender as TStringGrid).Cells[ColCount - 3, Row];
  end;

  // -----------------------------------------

  with Sender as TStringGrid do
    Repaint;
end;

procedure TFormCalculationEstimate.PMAddRatMatMechEquipOwnClick(Sender: TObject);
begin
  ShowFormAdditionData('s');
end;

procedure TFormCalculationEstimate.PMAddRatMatMechEquipRefClick(Sender: TObject);
begin
  ShowFormAdditionData('g');
end;

procedure TFormCalculationEstimate.PMMatColumnsClick(Sender: TObject);
begin
  if ComboBoxTypeData.ItemIndex = 0 then
  begin
    if StringGridMaterials.Focused then
      FormColumns.SetNameTable('TablePriceMaterials')
    else if StringGridMechanizms.Focused then
      FormColumns.SetNameTable('TablePriceMechanizms')
    else if StringGridEquipments.Focused then
      FormColumns.SetNameTable('TablePriceEquipments')
    else if StringGridDescription.Focused then
      FormColumns.SetNameTable('TablePriceDescription');

    FormColumns.ShowModal;
  end;
end;

procedure TFormCalculationEstimate.PMMatEditClick(Sender: TObject);
begin
  FormCardMaterial.ShowForm(IdInMat);
  UpdateTableCardMaterialTemp;
  FillingTableMaterials(IntToStr(IdInRate), '0');
end;

procedure TFormCalculationEstimate.PMEditClick(Sender: TObject);
begin
  case StrToInt(StringGridRates.Cells[5, StringGridRates.Row]) of
    1: // ��������
      begin
        FormCardDataEstimate.ShowForm(IdInRate);
        UpdateTableCardRatesTemp;
        OutputDataToTable;
      end;
    2: // ��������
      begin
        FormCardMaterial.ShowForm(IdInMat);
        UpdateTableCardMaterialTemp;
        FillingTableMaterials(IntToStr(IdInRate), '0');
      end;
  end;
end;

procedure TFormCalculationEstimate.PopupMenuTableLeftCopyClick(Sender: TObject);
var
  i: Integer;
  Str: string;
  CB: TClipboard;
begin
  Str := '';

  with StringGridRates do
    for i := 1 to ColCount - 1 do
      Str := Str + Cells[i, Row] + #9;

  try
    CB := TClipboard.Create;
    CB.AsText := Str;
  finally
    FreeAndNil(CB);
  end;
end;
//�������� ����-���� �� �����
procedure TFormCalculationEstimate.PMDeleteClick(Sender: TObject);
begin
  if (TypeData = 0) then
  begin
    MessageBox(0, PChar('������ ������� ������ ��������������� ��� ����� ������!'), CaptionForm,
      MB_ICONINFORMATION + MB_OK + mb_TaskModal);
    Exit;
  end
  else if MessageBox(0, PChar('�� ������������� ������ ������� ' + IntToStr(StringGridRates.Row) +
    ' ������?'), CaptionForm, MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
    Exit;

  if Act then
  begin
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL DeleteDataFromAct(:IdTypeData, :Id);');
      ParamByName('IdTypeData').Value := TypeData;
      ParamByName('Id').Value := IdInRate;
      ExecSQL;
    end;

    OutputDataToTable;
  end
  else
    case TypeData of
      1: // ��������
        try
          with ADOQueryTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteRate(:id);');
            ParamByName('id').Value := IdInRate;
            ExecSQL;
          end;

          OutputDataToTable;
        except
          on E: Exception do
            MessageBox(0, PChar('��� �������� �������� �������� ������:' + sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      2: // ��������
        try
          with ADOQueryTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteMaterial(:id);');
            ParamByName('id').Value := IdInMat;
            ExecSQL;
          end;

          OutputDataToTable;
        except
          on E: Exception do
            MessageBox(0, PChar('��� �������� ��������� �������� ������:' + sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      3: // ��������
        try
          with ADOQueryTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('CALL DeleteMechanism(:id);');
            ParamByName('id').Value := IdInMech;
            ExecSQL;
          end;

          OutputDataToTable;
        except
          on E: Exception do
            MessageBox(0, PChar('��� �������� ��������� �������� ������:' + sLineBreak + sLineBreak +
              E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
    end;

  NumerationRates;

  StringGridRatesClick(StringGridRates);

  FormMain.AutoWidthColumn(StringGridRates, 3);
end;

procedure TFormCalculationEstimate.PopupMenuTableLeftInsertClick(Sender: TObject);
var
  CB: TClipboard;
  s: string;
  c, r, P: Integer;
begin
  try
    CB := TClipboard.Create;
    s := CB.AsText;
  finally
    FreeAndNil(CB);
  end;

  with StringGridRates do
  begin
    RowCount := RowCount + 1;

    r := RowCount - 2;

    while r > Row do
    begin
      for c := 0 to ColCount - 1 do
        if c = 0 then
          Cells[c, r] := IntToStr(StrToInt(Cells[c, r - 1]) + 1)
        else
          Cells[c, r] := Cells[c, r - 1];

      Dec(r);
    end;

    Cells[0, Row] := IntToStr(Row);

    for c := 1 to ColCount - 1 do
    begin
      P := Pos(#9, s);
      Cells[c, Row] := Copy(s, 1, P - 1);
      Delete(s, 1, P);
    end;
  end;

  Inc(CountRowRates);

  FormMain.AutoWidthColumn(StringGridRates, 3);
end;

procedure TFormCalculationEstimate.PopupMenuTableLeftPopup(Sender: TObject);
begin
  GetStateCoefOrdersInEstimate;
end;

procedure TFormCalculationEstimate.PopupMenuRatesAdd(Sender: TObject);
var
  FieldRates: TFieldRates;
begin
  case (Sender as TMenuItem).Tag of
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
      end;
  end;
end;

procedure TFormCalculationEstimate.StringGridRightDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
var
  Str: string;
begin
  with Sender as TStringGrid do
  begin
    // ���������� ����� �������
    if (ARow = 0) or (ACol = 0) then
    begin
      Canvas.Brush.Color := PS.BackgroundHead;
      Canvas.Font.Color := PS.FontHead;
    end
    else // ���������� ���� ��������� �����
    begin
      Canvas.Brush.Color := PS.BackgroundRows;
      Canvas.Font.Color := PS.FontRows;
    end;

    Canvas.Font.Style := Canvas.Font.Style - [fsbold];
    Canvas.Font.Style := Canvas.Font.Style - [fsStrikeOut];
    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);

    // ----------------------------------------

    // ���� ������� � ������ � ������ �� ����� ������ ������
    if Focused and (Row = ARow) and (Row > 0) and (ACol > 0) then
    begin
      if gdFocused in State then // ������ � ������
      begin
        Canvas.Brush.Color := PS.BackgroundSelectCell;
        Canvas.Font.Color := PS.FontSelectCell;
      end;

      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, Row]);
    end;

    // -----------------------------------------

    if Cells[ACol, ARow] = '�� ���������' then
    begin
      Canvas.Brush.Color := RGB(255, 191, 191);
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
    end
    else if Cells[ACol, ARow] = '��� ����' then
    begin
      Canvas.Brush.Color := RGB(255, 255, 191);
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
    end
    else if ((Cells[ACol, 0] = '�����. (����.)') or (Cells[ACol, 0] = '�����. (������.)')) and (ARow > 0) then
    begin
      Canvas.Brush.Color := RGB(191, 255, 202);
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
    end;

    // -----------------------------------------

    // ���������� ������ ������������ �� ����������� �����������
    // �������� ���������� ��� ���������
    {
      Str := Cells[ColCount - 1, ARow];

      if (Name = 'StringGridMaterials') and (Str > '') and (ARow > 0) then
      begin
      if (ACol in [5, 6, 12]) then
      if (GetTrClient(Str) = 100) then
      Canvas.Font.Color := clRed
      else if (GetTrContractor(Str) < 100) then
      Canvas.Font.Color := RGB(37, 50, 220);

      if (ACol >= 7) and (ACol <= 11) then
      if (GetMatClient(Str) = 100) then
      Canvas.Font.Color := clRed
      else if (GetMatContractor(Str) < 100) then
      Canvas.Font.Color := RGB(37, 50, 220);

      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
      end;
    }
    // -----------------------------------------

    // ���������� ������ ����

    if (Name = 'StringGridMaterials') and (ACol = 7) and (ARow > 0) then
      if Cells[10, ARow] <> '' then
      begin
        Canvas.Font.Color := clGray;
        Canvas.FillRect(Rect);
        Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
      end;

    if (Name = 'StringGridMechanizms') and (ACol = 6) and (ARow > 0) then
      if Cells[7, ARow] <> '' then
      begin
        Canvas.Font.Color := clGray;
        Canvas.FillRect(Rect);
        Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
      end;

    // -----------------------------------------

    if (Name = 'StringGridMaterials') then
    begin
      // ����������� ����y�� � ������y�� ���������� � �������
      if Cells[0, ARow] = '' then
      begin
        Canvas.Brush.Color := RGB(106, 116, 157);
        Rect.Right := Rect.Right + 1;
        Canvas.FillRect(Rect);
        Canvas.Font.Color := clWhite;
        Canvas.Font.Style := Canvas.Font.Style + [fsbold];
        Canvas.TextOut(Rect.Left + 1, Rect.Top + 2, Cells[ACol, ARow]);
      end;

      if (Cells[14, ARow] <> '') and (ARow > 0) then
      // ���� ������ �� ����� � � ���� � Id ���� ������
      begin
        if AllocateMaterial(StrToInt(Cells[14, ARow])) then
        // ���������� ����Ҩ���� � ���������� ����������
        begin
          Canvas.Font.Style := Canvas.Font.Style + [fsbold];
          Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
        end;

        if CrossOutMaterial(StrToInt(Cells[14, ARow])) then
        // ���������� ���������� �� �������� ����������
        begin
          Canvas.Font.Style := Canvas.Font.Style + [fsStrikeOut];
          Canvas.FillRect(Rect);
          Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
        end;
      end;
    end;
  end;
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
  StringGridRatesClick(StringGridRates);
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

procedure TFormCalculationEstimate.FillingTableMaterials(const vIdCardRate, vIdMat: string);
begin
  ClearTable(StringGridMaterials);

  // -----------------------------------------

  if ADOQueryMaterialCard.RecordCount = 0 then
  begin
    StringGridCalculations.Cells[5, CountCoef + 2] := '0';
    StringGridCalculations.Cells[5, CountCoef + 3] := '0';

    StringGridCalculations.Cells[6, CountCoef + 2] := '0';
    StringGridCalculations.Cells[6, CountCoef + 3] := '0';
    //� ������ ���� � ������� ��� ����������, �� ��������� �������������� ������� �������
    if StringGridMaterials.RowCount > 1 then
      with StringGridMaterials  do
      begin
        FixedCols := 1;
        FixedRows := 1;
      end;

    Exit;
  end;

  // -----------------------------------------

  if vIdMat <> '0' then // ���� ��������
    with ADOQueryMaterialCard do
    begin
      Filtered := False;
      Filter := 'mat_id = ' + vIdMat;
      Filtered := True;

      if RecordCount > 0 then
        FillingMaterials(ADOQueryMaterialCard, ' ');
    end
  else // ����� ����������
    with ADOQueryMaterialCard do
    begin
      // ������� ���������

      Filtered := False;
      //Filter := 'considered = 1 and id_replaced = 0';
      Filter := 'id_card_rate = ' + vIdCardRate + ' and considered = 1 and id_replaced = 0';

      Filtered := True;

      if RecordCount > 0 then
        FillingMaterials(ADOQueryMaterialCard, 'S');

      // --------------------

      // ��������� ���������

      Filtered := False;
      //Filter := 'considered = 0';
      Filter := 'id_card_rate = ' + vIdCardRate + ' and considered = 0';

      Filtered := True;

      if RecordCount > 0 then
        FillingMaterials(ADOQueryMaterialCard, 'P');

      // --------------------

      // ���������� (�-����) ���������

      Filtered := False;
      //Filter := 'considered = 1 and id_replaced > 0';
      Filter := 'id_card_rate = ' + vIdCardRate + ' and considered = 1 and id_replaced > 0';
      Filtered := True;

      if RecordCount > 0 then
        FillingMaterials(ADOQueryMaterialCard, 'Z');

      // --------------------

      Filtered := False;
      Filter := '';
    end;

  // -----------------------------------------
  //� ������ ���� � ������� ��� ����������, �� ��������� �������������� ������� �������
  if StringGridMaterials.RowCount > 1 then
    with StringGridMaterials do
    begin
      FixedCols := 1;
      FixedRows := 1;
    end;
end;

procedure TFormCalculationEstimate.FillingMaterials(const AQ: TFDQuery; const vGroup: Char);
var
  i, Nom: Integer;
  Price: Variant;
  f: Double;
  kf: Integer;
  NameGroup: string;
begin
  if vGroup = 'S' then
    NameGroup := '�������'
  else if vGroup = 'P' then
    NameGroup := '���������';

  if vGroup <> ' ' then
    with StringGridMaterials do
    begin
      RowCount := RowCount + 1;
      Cells[1, RowCount - 1] := NameGroup;
    end;

  // -----------------------------------------

  with StringGridMaterials, AQ do
  begin
    Nom := 1;

    First; // ���������� �� ������ ������ � ������ ������

    // ���� ���� ������ � ������ ������, ������� �� � �������
    while not Eof do
    begin
      RowCount := RowCount + 1;
      i := RowCount - 1;

      Cells[0, i] := IntToStr(Nom);
      Cells[1, i] := FieldByName('mat_code').AsVariant; // MatCode
      f := FieldByName('mat_norma').AsFloat;
      Cells[2, i] := MyFloatToStr(f); // MatNorm
      Cells[3, i] := FieldByName('mat_unit').AsString; // MatUnit
      Cells[4, i] := MyFloatToStr(CountFromRate);
      // StringGridRates.Cells[2, StringGridRates.Row];

      try
        f := MyStrToFloatDef(Cells[2, i], 0);

        Cells[4, i] := MyFloatToStr(MyStrToFloatDef(Cells[4, i], 0) * f);

        for kf := 1 to CountCoef do
          Cells[4, i] := MyFloatToStr(MyStrToFloat(Cells[4, i]) *
            MyStrToFloat(StringGridCalculations.Cells[5, kf]));
      except
        on E: Exception do
          MessageBox(0, PChar('������ ��� ���������� ���� �' + Cells[4, 0] + '�, � ������� ����������:' +
            sLineBreak + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
      end;

      // -----------------------------------------

      Cells[5, i] := MyFloatToStr(FieldByName('coef_tr_zatr').AsFloat);

      // -----------------------------------------

      Cells[6, i] := '';

      // -----------------------------------------

      // �������� ���� ��� ���
      Price := GetPriceMaterial;

      if Price <> Null then
      begin
        // ���� ����
        Cells[7, i] := Price;

        try
          Cells[8, i] := IntToStr(Round(StrToInt(Cells[7, i]) * MyStrToFloat(Cells[4, i])));
        except
          on E: Exception do
            MessageBox(0, PChar('������ ��� ���������� ���� �' + Cells[8, 0] + '�, � ������� ����������:' +
              sLineBreak + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;

        Cells[9, i] := MyFloatToStr(RoundTo(StrToInt(Cells[8, i]) * MyStrToFloat(Cells[5, i]), PS.RoundTo * -1));
      end
      else
      begin
        // ���� ���
        Cells[7, i] := '��� ����';
        Cells[8, i] := '�� ���������';
      end;

      // -----------------------------------------

      Cells[10, i] := '';
      Cells[11, i] := '';
      Cells[12, i] := '';
      Cells[13, i] := FieldByName('mat_name').AsVariant; // MatName
      Cells[14, i] := FieldByName('id').AsVariant; // MatId
      Cells[15, i] := '';
      Cells[16, i] := '';

      Next; // ������� �� ��������� ������ � ������ ������
      Inc(Nom);
    end;
  end;
end;

procedure TFormCalculationEstimate.FillingTableMechanizm(const vIdCardRate, vIdMech: string);
var
  i: Integer;
begin
  ClearTable(StringGridMechanizms);

  // -----------------------------------------

  if vIdMech <> '0' then // ���� ��������
    with ADOQueryMechanizmCard do
    begin
      Filtered := False;
      Filter := 'mech_id = ' + vIdMech;
      Filtered := True;

      if RecordCount > 0 then
        FillingMechanizm;
    end
  else // ����� ����������
    with ADOQueryMechanizmCard do
    begin
      Filtered := False;
      Filter := 'id_card_rate = ' + vIdCardRate;
      Filtered := True;

      i := RecordCount;

      if RecordCount > 0 then
        FillingMechanizm;
    end;

  // -----------------------------------------

  with ADOQueryMechanizmCard do
  begin
    Filtered := False;
    Filter := '';
  end;

  // -----------------------------------------

  with StringGridMechanizms do
  begin
    FixedCols := 1;
    if RowCount > 1 then
      FixedRows := 1;
  end;
end;

procedure TFormCalculationEstimate.FillingMechanizm;
var
  Nom: Integer;
  Price: Variant;
  f: Double;
  kf: Integer;
begin
  // ������� ���������� ������ � ������ ������� StringGrid
  with ADOQueryMechanizmCard, StringGridMechanizms do
  begin
    Nom := 1; // ����� ����������� ������ � �������

    First; // ���������� �� ������ ������ � ������ ������

    // ���� ���� ������ � ������ ������, ������� �� � �������
    while not Eof do
    begin
      RowCount := RowCount + 1;

      Cells[0, Nom] := IntToStr(Nom);
      Cells[1, Nom] := FieldByName('mech_code').AsVariant;

      f := FieldByName('mech_norma').AsFloat;

      Cells[2, Nom] := MyFloatToStr(f);
      Cells[3, Nom] := FieldByName('mech_unit').AsVariant;
      Cells[4, Nom] := MyFloatToStr(CountFromRate);
      // StringGridRates.Cells[2, StringGridRates.Row];

      try
        f := MyStrToFloat(Cells[2, Nom]);

        Cells[4, Nom] := MyFloatToStr(MyStrToFloatdef(Cells[4, Nom], 0) * f);

        for kf := 1 to CountCoef do
          Cells[4, Nom] := MyFloatToStr(MyStrToFloat(Cells[4, Nom]) *
            MyStrToFloat(StringGridCalculations.Cells[3, kf]));
      except
        on E: Exception do
          MessageBox(0, PChar('������ ��� ���������� ���� �' + Cells[4, 0] + '�, � ������� ����������:' +
            sLineBreak + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
      end;

      // -----------------------------------------

      // �������� �������� ���������
      Price := FieldByName('zp_mach_nds').AsVariant;

      if Price <> Null then
        Cells[5, Nom] := Price // ���� ����
      else
        Cells[5, Nom] := '��� ����'; // ���� ���

      // -----------------------------------------

      // �������� ������� ����
      Price := FieldByName('coast_nds').AsVariant;

      if Price <> Null then
      begin
        // ���� ����
        Cells[6, Nom] := Price;

        try
          Cells[7, Nom] := IntToStr(Round(StrToInt(Cells[6, Nom]) * MyStrToFloat(Cells[4, Nom])));
        except
          on E: Exception do
            MessageBox(0, PChar('������ ��� ���������� ���� �' + Cells[7, 0] + '�, � ������� ����������:' +
              sLineBreak + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      end
      else
      begin
        // ���� ���
        Cells[6, Nom] := '��� ����';
        Cells[7, Nom] := '�� ���������';
      end;

      // -----------------------------------------

      Cells[8, Nom] := '';
      Cells[9, Nom] := '';
      Cells[10, Nom] := '';
      Cells[11, Nom] := FieldByName('mech_name').AsVariant;
      Cells[12, Nom] := FieldByName('id').AsVariant;
      Cells[13, Nom] := '';

      Inc(Nom);
      Next; // ������� �� ��������� ������ � ������ ������
    end;
  end;
end;

procedure TFormCalculationEstimate.FillingTableDescription(const vIdNormativ: string);
var
  i: Integer;
begin
  ClearTable(StringGridDescription);

  // -----------------------------------------

  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT cast(sostav_name as char(1024)) as "work" FROM sostav, normativg ' +
      'WHERE normativg.tab_id = sostav.tab_id and normativg.normativ_id = ' + vIdNormativ +
      ' ORDER BY sostav_name ASC;');
    Active := True;
  end;

  // ������� ���������� ������ � ������� StringGrid
  with ADOQueryTemp, StringGridDescription do
  begin
    i := 1; // ����� ����������� ������ � StringGrid

    First; // ���������� �� ������ ������ � ������ ������

    StringGridDescription.RowCount := RecordCount + 1;

    // ���� ���� ������ � ������ ������, ������� �� � StringGrid
    while not Eof do
    begin
      Cells[0, i] := IntToStr(i);
      Cells[1, i] := Fields.Fields[0].AsString;

      Next;
      Inc(i);
    end;
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

  StringGridRatesClick(StringGridRates);
end;

function TFormCalculationEstimate.GetRankBuilders(const vIdNormativ: string): Double;
begin
  // ������� ������ �������-����������
  try
    with ADOQueryTemp do
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
    with ADOQueryTemp do
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
    with ADOQueryTemp do
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
  with ADOQueryMaterialCard do
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
  end;
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

procedure TFormCalculationEstimate.CalculationColumnPriceMaterial;
var
  i, Nom: Integer;
  vCount: Double;
begin
  with StringGridMaterials do
    try
      for i := 1 to RowCount - 1 do
        if StringGridMaterials.Cells[0, i] <> '' then
        begin
          vCount := MyStrToFloat(Cells[4, i]);

          if (Cells[10, i] <> '') then
            Cells[11, i] := MyFloatToStr(RoundTo(StrToInt(Cells[10, i]) * vCount, PS.RoundTo * -1))
          else
            Cells[11, i] := '';
        end;
    except
      on E: Exception do
        MessageBox(0, PChar('������ ��� ���������� ���� �' + Cells[11, 0] + '�, � ������� ����������:' +
          sLineBreak + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
end;

procedure TFormCalculationEstimate.CalculationColumnPriceMechanizm;
var
  i: Integer;
  vCount: Double;
begin
  with StringGridMechanizms do
    try
      for i := 1 to RowCount - 1 do
      begin
        vCount := MyStrToFloat(Cells[4, i]);

        if Cells[8, i] <> '' then
          Cells[9, i] := MyFloatToStr(RoundTo(StrToInt(Cells[8, i]) * vCount, PS.RoundTo * -1))
        else
          Cells[9, i] := '';
      end;
    except
      on E: Exception do
        MessageBox(0, PChar('������ ��� ���������� ���� �' + Cells[7, 0] + '�, � ������� ����������:' +
          sLineBreak + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
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
    with StringGridRates do
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
      with ADOQueryTemp do
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

    with ADOQueryTemp do
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
  try
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
    with StringGridRates do
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
  end;
end;

procedure TFormCalculationEstimate.CalculationPercentTransport;
var
  Percent: Double;
  Str: string;
begin
  try
    with ADOQueryTemp do
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
    with ADOQueryTemp do
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
    with ADOQueryTemp do
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
  try
    // �������� ��� Id ���������� � ��������
    try
      with ADOQueryTemp do
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
    with StringGridRates do
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
  end;
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
  try
    // ���������� ���������� � ��������
    CountMechanizm := StringGridMechanizms.RowCount - 1;

    // �������� ������
    SetLength(EMiM, CountMechanizm);
    SetLength(EMiM1, CountMechanizm);

    // ���������� �� ����� �������
    with StringGridRates do
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
  end;
end;

procedure TFormCalculationEstimate.CalculationCost;
begin
  try
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
  end;
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
        OXROPR := OXROPR + MyStrToCurr(Cells[4, CountCoef + 3]); // �� + �� ���.

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
  try
    with StringGridCalculations do
      // ���� % ����� ������� ���� � �������, ����� �������
      if Cells[9, CountCoef + 2] <> '' then
      begin
        PlanProfit := MyStrToCurr(Cells[2, CountCoef + 3]); // ��
        PlanProfit := PlanProfit + MyStrToCurr(Cells[4, CountCoef + 3]);
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
  end;
end;

procedure TFormCalculationEstimate.CalculationCostOXROPR;
var
  OXROPR, PlanProfit: Currency;
  i: Integer;
  Str: string;
begin
  try
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
  end;
end;

procedure TFormCalculationEstimate.CalculationWinterPrice;
var
  WinterPrice: Currency;
begin
  try
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
  end;
end;

procedure TFormCalculationEstimate.CalculationSalaryWinterPrice;
var
  SalaryWinterPrice: Currency;
begin
  try
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
  end;
end;

procedure TFormCalculationEstimate.CalculationWork;
var
  Work: Currency;
begin
  try
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
  end;
end;

procedure TFormCalculationEstimate.CalculationWorkMachinist;
var
  WorkMachinist: Currency;
begin
  try
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
  end;
end;

procedure TFormCalculationEstimate.ShowHintInTables(const SG: TStringGrid; const vCol, vRow: Integer);
var
  Point: TPoint;
begin
  if not PS.ShowHint then
    Exit;

  if (vCol = -1) or (vRow = -1) or (not ShowHint) then
  begin
    PanelHint.Visible := False;
    Exit;
  end;

  PanelHint.Caption := SG.Cells[vCol, vRow];

  if PanelHint.Caption <> '' then
  begin
    PanelHint.Visible := True
  end
  else
  begin
    PanelHint.Visible := False;
    Exit;
  end;

  PanelHint.Width := Canvas.TextWidth(PanelHint.Caption) + 20;

  GetCursorPos(Point);
  Point := ScreenToClient(Point);

  PanelHint.Left := Point.X + 12;
  PanelHint.Top := Point.Y + 20;
end;

procedure TFormCalculationEstimate.SettingVisibleRightTables;
begin
  SplitterRight1.Align := alBottom;
  SplitterRight2.Align := alBottom;

  SplitterRight1.Visible := False;
  SplitterRight2.Visible := False;

  StringGridMaterials.Align := alNone;
  StringGridMechanizms.Align := alNone;
  StringGridEquipments.Align := alNone;
  StringGridDescription.Align := alNone;

  StringGridMaterials.Visible := False;
  StringGridMechanizms.Visible := False;
  StringGridEquipments.Visible := False;
  StringGridDescription.Visible := False;

  ImageSplitterRight1.Visible := False;
  ImageSplitterRight2.Visible := False;

  if VisibleRightTables = '1000' then
  begin
    StringGridMaterials.Align := alClient;
    StringGridMaterials.Visible := True;
  end
  else if VisibleRightTables = '0100' then
  begin
    StringGridMechanizms.Align := alClient;
    StringGridMechanizms.Visible := True;
  end
  else if VisibleRightTables = '0010' then
  begin
    StringGridEquipments.Align := alClient;
    StringGridEquipments.Visible := True;
  end
  else if VisibleRightTables = '0001' then
  begin
    StringGridDescription.Align := alClient;
    StringGridDescription.Visible := True;
  end
  else if VisibleRightTables = '1110' then
  begin
    StringGridMaterials.Align := alTop;
    SplitterRight1.Align := alTop;

    StringGridEquipments.Align := alBottom;
    SplitterRight2.Align := alTop;
    SplitterRight2.Align := alBottom;

    StringGridMechanizms.Align := alClient;

    StringGridMaterials.Visible := True;
    StringGridMechanizms.Visible := True;
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
    with ADOQueryTemp do
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
    with ADOQueryTemp do
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
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT monat, year, nds FROM stavka, smetasourcedata ' +
        'WHERE stavka.stavka_id = smetasourcedata.stavka_id and sm_id = :sm_id;');
      ADOQueryTemp.ParamByName('sm_id').Value := IdEstimate;
      Active := True;

      EditMonth.Text := FormatDateTime('mmmm yyyy ����.',
        StrToDate('01.' + ADOQueryTemp.FieldByName('monat').AsString + '.' + ADOQueryTemp.FieldByName('year')
        .AsString));

      if FieldByName('nds').Value then
        EditVAT.Text := 'c ���'
      else
        EditVAT.Text := '��� ���';
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� �������� ������ �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.SetIndexOXROPR(vNumber: String);
begin
  try
    with ADOQueryTemp do
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
  with ADOQueryTemp do
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
    with ADOQueryTemp do
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

procedure TFormCalculationEstimate.AddRowToTableRates(FieldRates: TFieldRates);
var
  c, r, NumRow: Integer;
begin
  // �������� ������� � ��-6
  if Act and FormKC6.Showing then
    FormKC6.SelectDataEstimates(FieldRates.vTypeAddData, FieldRates.vId, FieldRates.vCount);

  NumRow := CountRowRates;

  with StringGridRates do
  begin
    Cells[0, NumRow] := '';
    Cells[1, NumRow] := '';
    Cells[2, NumRow] := '';
    Cells[3, NumRow] := '';
    Cells[4, NumRow] := '';
    Cells[5, NumRow] := '';
    Cells[6, NumRow] := '';

    RowCount := RowCount + 1;

    if FieldRates.vRow <> '0' then
    // ��������� ���� �� �������� ������ ����, ��� ��������� ���� �������
    begin
      r := RowCount - 2;

      // -------------------------------------

      // �������� ��� ������ �� ���� ����, ������� ����������
      while r > FieldRates.vRow do
      begin
        for c := 0 to ColCount - 1 do
          if (c = 0)
          { and (Pos('�', Cells[0, r]) <> 1) } then
            // ��. ��������� �������� ������
            Cells[c, r] := IntToStr(StrToInt(Cells[c, r - 1]) + 1)
          else
            Cells[c, r] := Cells[c, r - 1];

        Dec(r);
      end;

      for c := 0 to ColCount - 1 do
        Cells[c, r] := '';

      // -------------------------------------

      NumRow := FieldRates.vRow;
      Cells[0, NumRow] := IntToStr(NumRow);
    end
    else
      Cells[0, NumRow] := IntToStr(CountRowRates);

    with FieldRates do
    begin
      Cells[1, NumRow] := vNumber;

      if vCount = Null then
        Cells[2, NumRow] := ''
      else
      begin
        Cells[2, NumRow] := MyFloatToStr(Real(vCount));
      end;

      if vNameUnit = Null then
        Cells[3, NumRow] := ''
      else
        Cells[3, NumRow] := vNameUnit;

      if vDescription = Null then
        Cells[4, NumRow] := ''
      else
        Cells[4, NumRow] := vDescription;

      Cells[5, NumRow] := vTypeAddData;
      Cells[6, NumRow] := vId;
    end;
  end;

  NumRow := NumRow + 1;
  with StringGridRates do
  begin
    Cells[0, NumRow] := '';
    Cells[1, NumRow] := '';
    Cells[2, NumRow] := '';
    Cells[3, NumRow] := '';
    Cells[4, NumRow] := '';
    Cells[5, NumRow] := '';
    Cells[6, NumRow] := '';
  end;

  NumerationRates;

  Inc(CountRowRates);

  FormMain.AutoWidthColumn(StringGridRates, 3);
end;

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
    with ADOQueryTemp do
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
    with ADOQueryTemp do
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
    with ADOQueryTemp do
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
    with ADOQueryTemp do
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
  OutputDataToTable;
  //����� ��������, ���������� ���������� ���������� ������
  StringGridRatesClick(StringGridRates);
end;

//���������� ������� ��������
procedure TFormCalculationEstimate.OutputDataToTable;
var
  FieldRates: TFieldRates;
  i: Integer;
begin
  with StringGridRates do
  begin
    Cells[0, 1] := '';
    Cells[1, 1] := '';
    Cells[2, 1] := '';
    Cells[3, 1] := '';
    Cells[4, 1] := '';
    Cells[5, 1] := '';
    Cells[6, 1] := '';
    RowCount := 2;
  end;
  CountRowRates := 1;

  // ----------------------------------------
  //��������� ��������� ������� � ������� �� �����(����)
  UpdateTableDataTemp;
  UpdateTableCardRatesTemp;
  UpdateTableCardMaterialTemp;
  UpdateTableCardMechanizmTemp;

  try
    with qrData do
    begin
      // ShowMessage(IntToStr(ADOQueryData.RecordCount));
      First;

      while not Eof do
      begin
        case FieldByName('id_type_data').AsInteger of
          1: // ������� ��������
            try
              with ADOQueryCardRates do
              begin
                Filtered := False;
                Filter := 'id = ' + IntToStr(qrData.FieldByName('id_tables').AsInteger);
                Filtered := True;

                with FieldRates do
                begin
                  vRow := '0';
                  vNumber := FieldByName('rate_code').AsString;
                  vCount := FieldByName('rate_count').AsFloat;
                  vNameUnit := FieldByName('rate_unit').AsString;
                  vDescription := FieldByName('rate_caption').AsString;
                  vTypeAddData := 1;
                  vId := FieldByName('id').AsInteger;
                end;
                AddRowToTableRates(FieldRates);
              end;

              // ----------

              with ADOQueryMaterialCard do
              begin
                // ������� ��� ��������� ��������� ������� �� ���� ��������
                Filtered := False;
                Filter := 'id_card_rate = ' + IntToStr(ADOQueryCardRates.FieldByName('id').AsInteger) +
                  ' and considered = 0 and replaced = 0';
                Filtered := True;

                First;

                while not Eof do
                begin
                  with FieldRates do
                  begin
                    vRow := '0';
                    vNumber := Indent + FieldByName('mat_code').AsString;
                    vCount := FieldByName('mat_count').AsFloat;
                    vNameUnit := FieldByName('mat_unit').AsString;
                    vDescription := FieldByName('mat_name').AsString;
                    vTypeAddData := 2;
                    vId := FieldByName('id').AsInteger;
                  end;
                  AddRowToTableRates(FieldRates);

                  Next;
                end;

                // ----------------------------------------

                // ������� ��� ���������� ���������, �.�. ��������� �������� ���� �������� ���������
                Filtered := False;
                Filter := 'id_card_rate = ' + IntToStr(ADOQueryCardRates.FieldByName('id').AsInteger) +
                  ' and considered = 1 and id_replaced > 0';
                Filtered := True;

                First;

                while not Eof do
                begin
                  with FieldRates do
                  begin
                    vRow := '0';
                    vNumber := FieldByName('mat_code').AsString;
                    vCount := FieldByName('mat_count').AsFloat;
                    vNameUnit := FieldByName('mat_unit').AsString;
                    vDescription := FieldByName('mat_name').AsString;
                    vTypeAddData := 2;
                    vId := FieldByName('id').AsInteger;
                  end;
                  AddRowToTableRates(FieldRates);

                  Next;
                end;

                // ----------------------------------------

                // ������� ���������� �� �������� ���������
                Filtered := False;
                Filter := 'id_card_rate = ' + IntToStr(ADOQueryCardRates.FieldByName('id').AsInteger) +
                  ' and from_rate = 1';
                Filtered := True;

                First;

                while not Eof do
                begin
                  with FieldRates do
                  begin
                    vRow := '0';
                    vNumber := FieldByName('mat_code').AsString;
                    vCount := FieldByName('mat_count').AsFloat;
                    vNameUnit := FieldByName('mat_unit').AsString;
                    vDescription := FieldByName('mat_name').AsString;
                    vTypeAddData := 2;
                    vId := FieldByName('id').AsInteger;
                  end;
                  AddRowToTableRates(FieldRates);

                  Next;
                end;
              end;
            except
              on E: Exception do
                MessageBox(0, PChar('��� ������ �������� � ������� ������ �������� ������:' + sLineBreak +
                  sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
            end;
          2: // ������� ��������
            try
              with ADOQueryMaterialCard do
              begin

                Filtered := False;
                Filter := 'id = ' + IntToStr(qrData.FieldByName('id_tables').AsInteger);
                Filtered := True;

                with FieldRates do
                begin
                  vRow := '0';
                  vNumber := FieldByName('mat_code').AsString;
                  vCount := FieldByName('mat_count').AsFloat;
                  vNameUnit := FieldByName('mat_unit').AsString;
                  vDescription := FieldByName('mat_name').AsString;
                  vTypeAddData := 2;
                  vId := FieldByName('id').AsInteger;
                end;
                AddRowToTableRates(FieldRates);
              end;
            except
              on E: Exception do
                MessageBox(0, PChar('��� ������ ��������� � ������� ������ �������� ������:' + sLineBreak +
                  sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
            end;
          3: // ������� ��������
            try
              with ADOQueryMechanizmCard do
              begin
                i := RecordCount;
                Filtered := False;
                Filter := 'id = ' + IntToStr(qrData.FieldByName('id_tables').AsInteger);;
                Filtered := True;

                with FieldRates do
                begin
                  vRow := '0';
                  vNumber := FieldByName('mech_code').AsString;
                  vCount := FieldByName('mech_count').AsFloat;
                  vNameUnit := FieldByName('mech_unit').AsString;
                  vDescription := FieldByName('mech_name').AsString;
                  vTypeAddData := 3;
                  vId := FieldByName('id').AsInteger;
                end;
                AddRowToTableRates(FieldRates);
              end;
            except
              on E: Exception do
                MessageBox(0, PChar('��� ������ ��������� � ������� ������ �������� ������:' + sLineBreak +
                  sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
            end;
          4: // ������� ������������
            begin

            end;
        end;

        Next;
      end;

      with ADOQueryCardRates do
      begin
        // Close;
        Filtered := False;
        Filter := '';
      end;

      with ADOQueryMaterialCard do
      begin
        // Close;
        Filtered := False;
        Filter := '';
      end;

      with ADOQueryMechanizmCard do
      begin
        // Close;
        Filtered := False;
        Filter := '';
      end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� �������� ���� ������ �������� �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
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
  with FormSaveEstimate do
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
    with ADOQueryTemp do
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

      with ADOQueryTemp do
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
  end;
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
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL MaterialReplacement(:IdCardRate, :IdReplaced, :IdMat, :IdEstimate);');
      ParamByName('IdCardRate').Value := IdInRate;
      ParamByName('IdReplaced').Value := IdInMat;
      ParamByName('IdMat').Value := vIdMat;
      ParamByName('IdEstimate').Value := IdEstimate;
      ExecSQL;
    end;

    OutputDataToTable;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������ ���������� ��������� �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCalculationEstimate.NumerationRates;
var
  r, Nom, LowStr: Integer;
  Str: String;
begin
  Nom := 1;
  LowStr := 1;
  // Low(Str); // C���� ������ �������� ���� string (� �������� ���������� ������ ������ � ������)

  with StringGridRates do
    for r := 1 to RowCount - 2 do
    begin
      Str := Cells[1, r];

      if (Pos(Indent, Str) = 0) then
      // �������� �-���, ��� �������, ��������, ������������
      begin
        Cells[0, r] := IntToStr(Nom);
        Inc(Nom);
      end
      else if Pos(Indent + '�', Str) = LowStr then
        // ��������� �������� �-���
        Cells[0, r] := Cells[0, r - 1]
      else if Pos('�', Str) = LowStr then // ��������� �������� �-���
      begin
        Cells[0, r] := IntToStr(Nom);
        Inc(Nom);
      end;
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
  with ADOQueryTemp do
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
  end;
end;

procedure TFormCalculationEstimate.GetStateCoefOrdersInEstimate;
begin
  // �������� ���� ��������� (��������� ��� �� ���������) ������������ �� ��������

  try
    PMCoefOrders.Enabled := False;
    PopupMenuCoefOrders.Enabled := False;

    with ADOQueryTemp do
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
    with ADOQueryTemp do
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

procedure TFormCalculationEstimate.UpdateTableDataTemp;
var
  Str: string;
begin
  if Act then
    Str := 'data_act_temp'
  else
    Str := 'data_estimate_temp';

  with qrData do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + Str + ' ORDER BY 1;');
    Active := True;
  end;
end;

procedure TFormCalculationEstimate.UpdateTableCardRatesTemp;
begin
  with ADOQueryCardRates do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM card_rate_temp ORDER BY 1;');
    Active := True;
  end;
end;

procedure TFormCalculationEstimate.UpdateTableCardMaterialTemp;
begin
  with ADOQueryMaterialCard do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM materialcard_temp ORDER BY 1;');
    Active := True;
  end;
end;

procedure TFormCalculationEstimate.UpdateTableCardMechanizmTemp;
begin
  with ADOQueryMechanizmCard do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM mechanizmcard_temp ORDER BY 1;');
    Active := True;
  end;
end;

procedure TFormCalculationEstimate.GetInfoAboutData;
var
  vIdCardRate: Integer;
  Str: string;
begin
  // �������� ��� ������ ������ � �������
  with StringGridRates do
    if Cells[5, Row] = '' then
      TypeData := 0
    else
      TypeData := StrToInt(Cells[5, Row]);

  if TypeData = 0 then
    // ���� �������� ������ ��� ����� ������, �� ���������� ����������
    Exit;

  IdInRate := 0;
  RateId := 0;
  RateCode := '';

  IdInMat := 0;
  MatId := 0;
  MatIdCardRate := 0;
  MatIdReplaced := 0;
  MatReplaced := False;
  MatConsidered := True;
  MatFromRate := False;
  MatIdForAllocate := 0;

  IdInMech := 0;
  MechId := 0;
  MechFromRate := False;
  MechIdForAllocate := 0;

  case TypeData of
    1: // ��������
      try
        with ADOQueryTemp do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('SELECT id, rate_id, rate_code FROM card_rate_temp WHERE id = :id;');
          ParamByName('id').Value := StrToInt(StringGridRates.Cells[6, StringGridRates.Row]);
          Active := True;

          IdInRate := FieldByName('id').AsInteger;
          RateId := FieldByName('rate_id').AsInteger;
          RateCode := FieldByName('rate_code').AsString;

          Active := False;
        end;
      except
        on E: Exception do
          MessageBox(0, PChar('��� ��������b ����������������� ������ �������� �������� ������:' + sLineBreak
            + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
      end;
    2: // ��������
      try
        with ADOQueryTemp do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('SELECT id_card_rate FROM materialcard_temp WHERE id = :id;');
          ParamByName('id').Value := StrToInt(StringGridRates.Cells[6, StringGridRates.Row]);
          Active := True;
          vIdCardRate := FieldByName('id_card_rate').AsInteger;

          // ----------------------------------------

          if vIdCardRate = 0 then
            Str := 'SELECT id as IdInMat, mat_id, id_card_rate, id_replaced, considered, replaced, from_rate '
              + 'FROM materialcard_temp WHERE id = :id;'
          else
            Str := 'SELECT materialcard_temp.id as IdInMat, mat_id, id_card_rate, id_replaced, replaced, ' +
              'considered, from_rate, card_rate_temp.id as IdInRate, rate_id, rate_code ' +
              'FROM materialcard_temp, card_rate_temp ' +
              'WHERE materialcard_temp.id = :id and id_card_rate = card_rate_temp.id;';

          // ----------------------------------------

          Active := False;
          SQL.Clear;
          SQL.Add(Str);
          ParamByName('id').Value := StrToInt(StringGridRates.Cells[6, StringGridRates.Row]);
          Active := True;

          // ----------------------------------------

          IdInMat := FieldByName('IdInMat').AsInteger;
          MatId := FieldByName('mat_id').AsInteger;
          MatIdCardRate := FieldByName('id_card_rate').AsInteger;
          // Id �� ������� ��������
          MatIdReplaced := FieldByName('id_replaced').AsInteger;
          // Id � ����. ���., ����� ���. ��� ������ ���� ���.

          if MatIdReplaced > 0 then // ���� ��� ���������� ����Ҩ���� ��������
            MatIdForAllocate := MatIdReplaced;
          // �������� ��� Id � ������� ���������� ��� ���������

          if FieldByName('considered').AsInteger = 0 then
          // ���� ������� ����Ҩ���� ��������
          begin
            MatConsidered := False; // �������� �������� ����Ҩ����
            MatIdForAllocate := FieldByName('IdInMat').AsInteger;
            if FieldByName('replaced').AsInteger = 1 then
              // ���� ����Ҩ���� �������� ��� ������ �� ������
              MatReplaced := True;
          end;

          if FieldByName('from_rate').AsInteger = 1 then
          // ���� �������� ������� �� ��������
          begin
            MatFromRate := True;
            MatIdForAllocate := FieldByName('IdInMat').AsInteger;
          end;

          if vIdCardRate > 0 then
          // ���� �������� �� ��������, � �� ������ ��������, �������� ������ � ����� ��������
          begin
            IdInRate := FieldByName('IdInRate').AsInteger;;
            RateId := FieldByName('rate_id').AsInteger;
            RateCode := FieldByName('rate_code').AsString;
          end;

          Active := False;
        end;
      except
        on E: Exception do
          MessageBox(0, PChar('��� ��������� ����������������� ������ ��������� �������� ������:' + sLineBreak
            + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
      end;
    3: // ��������
      try
        with ADOQueryTemp do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('SELECT id_card_rate FROM mechanizmcard_temp WHERE id = :id;');
          ParamByName('id').Value := StrToInt(StringGridRates.Cells[6, StringGridRates.Row]);
          Active := True;
          vIdCardRate := FieldByName('id_card_rate').AsInteger;

          // ----------------------------------------

          if vIdCardRate = 0 then
            Str := 'SELECT id as IdInMech, mech_id, from_rate FROM mechanizmcard_temp ' +
              'WHERE id = :id;'
          else
            Str := 'SELECT mechanizmcard_temp.id as IdInMech, mech_id, card_rate_temp.id as IdInRate, ' +
              'rate_id, rate_code, from_rate FROM mechanizmcard_temp, card_rate_temp ' +
              'WHERE mechanizmcard_temp.id = :id and id_card_rate = card_rate_temp.id;';

          // ----------------------------------------

          Active := False;
          SQL.Clear;
          SQL.Add(Str);
          ParamByName('id').Value := StrToInt(StringGridRates.Cells[6, StringGridRates.Row]);
          Active := True;

          // ----------------------------------------

          IdInMech := FieldByName('IdInMech').AsInteger;
          MechId := FieldByName('mech_id').AsInteger;

          if FieldByName('from_rate').AsInteger = 1 then
          // ���� �������� ������� �� ��������
          begin
            MechFromRate := True;
            MechIdForAllocate := FieldByName('IdInMech').AsInteger;
          end;

          if vIdCardRate > 0 then
          // ���� �������� �� ��������, � �� ������ ��������, �������� ������ � ����� ��������
          begin
            IdInRate := FieldByName('IdInRate').AsInteger;;
            RateId := FieldByName('rate_id').AsInteger;
            RateCode := FieldByName('rate_code').AsString;
          end;

          Active := False;
        end;
      except
        on E: Exception do
          MessageBox(0, PChar('��� ��������� ����������������� ������ ��������� �������� ������:' + sLineBreak
            + sLineBreak + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
      end;
  end;
end;

//���������� ��������� � �����
procedure TFormCalculationEstimate.AddMaterial(const vMatId: Integer);
begin
  try
    with ADOQueryTemp do
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
      MessageBox(0, PChar('��� ���������� ��������� �������� ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;
//���������� ��������� � �����
procedure TFormCalculationEstimate.AddMechanizm(const vMechId, vMonth, vYear: Integer);
begin
  try
    with ADOQueryTemp do
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

    OutputDataToTable;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ���������� ��������� �������� ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.AllocateMaterial(const vIdInMat: Integer): Boolean;
begin
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT considered, id_replaced FROM materialcard_temp WHERE id = :id;');
      ParamByName('id').Value := vIdInMat;
      Active := True;

      // ��� ��������� ��� ���������
      if MatIdForAllocate = 0 then
      begin
        Result := False;
        Exit;
      end;

      // ���� �������� �������� ���������� �� ��������, �� �������� ��� � ��������
      if MatFromRate and (vIdInMat = MatIdForAllocate) then
      begin
        Result := True;
        Exit;
      end;

      // ���� ������� ��������� ��� ���������� �����., �� �������� ��������� �����. � ��� ��������� ��� ����������
      if ((vIdInMat = MatIdForAllocate) and (FieldByName('considered').AsInteger = 0)) or
        (MatIdForAllocate = FieldByName('id_replaced').AsInteger) then
        Result := True
      else
        Result := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ��������� ���������� �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

function TFormCalculationEstimate.CrossOutMaterial(const vIdInMat: Integer): Boolean;
begin
  Result := False;
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT from_rate FROM materialcard_temp WHERE id = :id;');
      ParamByName('id').AsInteger := vIdInMat;
      Active := True;
      if ADOQueryTemp.RecordCount > 0 then
        if (ADOQueryTemp.FieldByName('from_rate').Value = 1) then
          Result := True
        else
          Result := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������������ ����������� ��������� �������� ������:' + sLineBreak + sLineBreak
        + E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

end.
