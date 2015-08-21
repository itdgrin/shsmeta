Unit Main;

interface

uses
  Classes, Windows, Messages, SysUtils, Variants,
  Graphics, Controls, Forms, Dialogs, ExtCtrls,
  Menus, ComCtrls, ToolWin, StdCtrls, Buttons,
  DBGrids, ShellAPI, DateUtils, IniFiles, Grids,
  UpdateModule, ArhivModule, Data.DB, GlobsAndConst,
  Vcl.Imaging.pngimage, JvComponentBase, JvAppStorage, JvAppIniStorage,
  JvFormPlacement, Vcl.Clipbrd, JvGIF, Vcl.Imaging.GIFImg;

type
  TLayeredWndAttr = function(hwnd: integer; color: integer; level: integer; mode: integer): integer; stdcall;

  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    MenuHelp: TMenuItem;
    HelpAbout: TMenuItem;
    MenuFile: TMenuItem;
    FileClose: TMenuItem;
    MenuWindows: TMenuItem;
    WindowsMinimize: TMenuItem;
    WindowsHorizontal: TMenuItem;
    WindowsVertical: TMenuItem;
    WindowsCascade: TMenuItem;
    WindowsSeparator: TMenuItem;
    WindowsExpand: TMenuItem;
    N3: TMenuItem;
    MenuConnectDatabase: TMenuItem;
    FileSaveAs: TMenuItem;
    MenuHRR: TMenuItem;
    HRRTariffs: TMenuItem;
    TariffsTransportation: TMenuItem;
    HelpSupport: TMenuItem;
    HelpRegistration: TMenuItem;
    HelpSite: TMenuItem;
    MenuService: TMenuItem;
    ServiceBackup: TMenuItem;
    ServiceRecovery: TMenuItem;
    ServiceUpdate: TMenuItem;
    ServiceAssistant: TMenuItem;
    ServiceSettings: TMenuItem;
    PanelOpenWindows: TPanel;
    TimerCover: TTimer;
    N4: TMenuItem;
    N5: TMenuItem;
    N9: TMenuItem;
    N31: TMenuItem;
    N51: TMenuItem;
    N62: TMenuItem;
    ActC6: TMenuItem;
    N1: TMenuItem;
    N14: TMenuItem;
    N17: TMenuItem;
    CalculationSettings: TMenuItem;
    MenuCatalogs: TMenuItem;
    HRRReferenceData: TMenuItem;
    HRROwnData: TMenuItem;
    PanelCover: TPanel;
    N16: TMenuItem;
    OXRandOPRg: TMenuItem;
    HRRPrices: TMenuItem;
    MMAeroAdmin: TMenuItem;
    MMAmmyyAdmin: TMenuItem;
    MenuOrganizations: TMenuItem;
    MenuLists: TMenuItem;
    MenuSetCoefficients: TMenuItem;
    MenuListsPartsEstimates: TMenuItem;
    MenuListsSectionsEstimates: TMenuItem;
    MenuListsTypesWorks: TMenuItem;
    MenuListsTypesActs: TMenuItem;
    MenuListsIndexesChangeCost: TMenuItem;
    MenuListsСategoriesObjects: TMenuItem;
    N61: TMenuItem;
    mCalcResources: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Administator: TMenuItem;
    UpdatePanel: TPanel;
    imgUpdate: TImage;
    Label1: TLabel;
    TimerUpdate: TTimer;
    LabelDot: TLabel;
    N11: TMenuItem;
    mnZP_OBJ: TMenuItem;
    mnZP_OBJ_AKT: TMenuItem;
    mnRASX_ACT: TMenuItem;
    PMAddNewBackup: TMenuItem;
    N18: TMenuItem;
    PMRestoreBackup: TMenuItem;
    PMDeleteBackup: TMenuItem;
    PMRestoreOldBackup: TMenuItem;
    vk1: TMenuItem;
    vk2: TMenuItem;
    vk3: TMenuItem;
    vk4: TMenuItem;
    vk5: TMenuItem;
    vk6: TMenuItem;
    vk7: TMenuItem;
    N10: TMenuItem;
    vk9: TMenuItem;
    mnREPORT_SMETA_OBJ_BUILD: TMenuItem;
    N12: TMenuItem;
    mN15: TMenuItem;
    mN16: TMenuItem;
    mN17: TMenuItem;
    mnSMETA_LSR_FROM_OBJ: TMenuItem;
    mnSMETA_LSR_ZIM: TMenuItem;
    mnSMETA_LSR_TRUD: TMenuItem;
    mnCALC_SMETA_OBJ_GRAPH_C: TMenuItem;
    mnSMETA_RES_FROM_OBJ: TMenuItem;
    N13: TMenuItem;
    jsMenu1: TMenuItem;
    jsMenu2: TMenuItem;
    jsMenu3: TMenuItem;
    jsMenu4: TMenuItem;
    N15: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    JSMenu10: TMenuItem;
    JSMenu9: TMenuItem;
    JSMenu6: TMenuItem;
    JSMenu7: TMenuItem;
    JSMenu8: TMenuItem;
    jsMenu5: TMenuItem;
    AppIni: TJvAppIniFileStorage;
    img1: TImage;
    img2: TImage;
    mN22: TMenuItem;
    mN2: TMenuItem;
    N2: TMenuItem;
    N22: TMenuItem;
    Excel1: TMenuItem;
    EXCEL2: TMenuItem;
    Excel3: TMenuItem;
    mN23: TMenuItem;
    mhfybkbotafqkjd1: TMenuItem;
    mN24: TMenuItem;
    mN27: TMenuItem;
    mN28: TMenuItem;
    mN32: TMenuItem;
    mN41: TMenuItem;
    mN52: TMenuItem;
    mN29: TMenuItem;
    mN110: TMenuItem;
    ArchivPanel: TPanel;
    lbArchStatys: TLabel;
    imgArchive: TImage;
    pnlArchiv1: TPanel;
    pgArchiv: TProgressBar;
    N23: TMenuItem;
    ServiceUpdNorm: TMenuItem;
    mConstractorService: TMenuItem;
    mTranspNorm: TMenuItem;
    mBuildZone: TMenuItem;
    mHelpKfSt: TMenuItem;
    mN33: TMenuItem;
    mN111: TMenuItem;
    mN34: TMenuItem;
    mN35: TMenuItem;
    mN42: TMenuItem;
    mUsers: TMenuItem;
    mLogIn: TMenuItem;
    mN31: TMenuItem;
    mN36: TMenuItem;
    mN26: TMenuItem;
    mN30: TMenuItem;
    N24: TMenuItem;
    mN37: TMenuItem;
    mN25: TMenuItem;
    mN38: TMenuItem;
    procedure TariffsTransportationClick(Sender: TObject);
    procedure TariffsMechanismClick(Sender: TObject);
    procedure TariffsDumpClick(Sender: TObject);
    procedure TariffsIndexClick(Sender: TObject);

    procedure WindowsHorizontalClick(Sender: TObject);
    procedure WindowsVerticalClick(Sender: TObject);
    procedure WindowsCascadeClick(Sender: TObject);
    procedure WindowsMinimizeClick(Sender: TObject);
    procedure WindowsExpandClick(Sender: TObject);

    procedure FileCloseClick(Sender: TObject);

    procedure HelpAboutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditOriginalDataClick(Sender: TObject);

    procedure CascadeForActiveWindow();
    procedure FormCreate(Sender: TObject);

    procedure CreateButtonOpenWindow(const CaptionButton, HintButton: String; const AForm: TForm;
      AEventType: Byte = 0);
    procedure DeleteButtonCloseWindow(const CaptionButton: String);
    procedure SelectButtonActiveWindow(const CaptionButton: String);
    procedure ReplaceButtonOpenWindow(const AFrom, ATo: TForm);

    procedure TimerCoverTimer(Sender: TObject);
    procedure ServiceSettingsClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ActC6Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure OXRandOPRgClick(Sender: TObject);
    procedure CalculationSettingsClick(Sender: TObject);
    procedure NormalClick(Sender: TObject);
    procedure ReadSettingsFromFile(PathFile: String);
    procedure WriteSettingsToFile(PathFile: String);
    procedure HRRReferenceDataClick(Sender: TObject);
    procedure HRROwnDataClick(Sender: TObject);
    procedure RunProgramsRemoteControl(Sender: TObject);
    procedure MenuPartsEstimatesClick(Sender: TObject);
    procedure MenuSetCoefficientsClick(Sender: TObject);
    procedure MenuOrganizationsClick(Sender: TObject);
    procedure MenuListsSectionsEstimatesClick(Sender: TObject);
    procedure MenuListsTypesWorksClick(Sender: TObject);
    procedure MenuListsTypesActsClick(Sender: TObject);
    procedure MenuListsIndexesChangeCostClick(Sender: TObject);
    procedure MenuListsСategoriesObjectsClick(Sender: TObject);
    procedure N61Click(Sender: TObject);
    procedure mCalcResourcesClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure ServiceUpdateClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure UpdatePanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure TimerUpdateTimer(Sender: TObject);
    procedure mnZP_OBJClick(Sender: TObject);
    procedure mnZP_OBJ_AKTClick(Sender: TObject);
    procedure mnRASX_ACTClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PMAddNewBackupClick(Sender: TObject);
    procedure ServiceBackupClick(Sender: TObject);
    procedure PMRestoreBackupClick(Sender: TObject);
    procedure PMDeleteBackupClick(Sender: TObject);
    procedure vk2Click(Sender: TObject);
    procedure vk3Click(Sender: TObject);
    procedure vk4Click(Sender: TObject);
    procedure vk5Click(Sender: TObject);
    procedure vk6Click(Sender: TObject);
    procedure vk7Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure vk9Click(Sender: TObject);
    procedure mnREPORT_SMETA_OBJ_BUILDClick(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure mN15Click(Sender: TObject);
    procedure mN17Click(Sender: TObject);
    procedure mnSMETA_LSR_FROM_OBJClick(Sender: TObject);
    procedure mnSMETA_LSR_ZIMClick(Sender: TObject);
    procedure mnSMETA_LSR_TRUDClick(Sender: TObject);
    procedure mnCALC_SMETA_OBJ_GRAPH_CClick(Sender: TObject);
    procedure mnSMETA_RES_FROM_OBJClick(Sender: TObject);
    procedure VK2N13Click(Sender: TObject);
    procedure JSMenuClick(Sender: TObject);
    procedure Excel2Click(Sender: TObject);
    procedure EXCEL3Click(Sender: TObject);
    procedure mN22Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure mN23Click(Sender: TObject);
    procedure mhfybkbotafqkjd1Click(Sender: TObject);
    procedure HRRPricesClick(Sender: TObject);
    procedure mN24Click(Sender: TObject);
    procedure mN27Click(Sender: TObject);
    procedure mN110Click(Sender: TObject);
    procedure MenuServiceClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N23Click(Sender: TObject);
    procedure ServiceUpdNormClick(Sender: TObject);
    procedure mConstractorServiceClick(Sender: TObject);
    procedure mTranspNormClick(Sender: TObject);
    procedure mBuildZoneClick(Sender: TObject);
    procedure mHelpKfStClick(Sender: TObject);
    procedure mN111Click(Sender: TObject);
    procedure mLogInClick(Sender: TObject);
    procedure mUsersClick(Sender: TObject);
    procedure mN26Click(Sender: TObject);
    procedure mN30Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure mN36Click(Sender: TObject);
    procedure mN25Click(Sender: TObject);
    procedure mN38Click(Sender: TObject);
  private
    CountOpenWindows: integer;
    ButtonsWindows: array [0 .. 11] of TSpeedButton;
    FUpdateThread: TUpdateThread; // Нить проверки обновлений
    SystemInfoResult: Boolean;

    FCurVersion: TVersion; // текущая версия приложения и БД
    DebugMode: Boolean; // Режим отладки приложения (блокирует некоторай функционал во время его отладки)

    FileReportPath: string; // путь к папке с отчетами(дабы не захламлять датамодуль лишними модулями)

    // Объект отвечает за создание бэкапов и их восстановление
    FArhiv: TBaseAppArhiv;

    procedure GetSystemInfo;
    procedure OnUpdate(var Mes: TMessage); message WM_SHOW_SPLASH;
    procedure ThreadEXCEPTION(var Mes: TMessage); message WM_EXCEPTION;
    procedure ARCHIVEPROGRESS(var Mes: TMessage); message WM_ARCHIVEPROGRESS;
    procedure ShowSplashForm;
    procedure ShowUpdateForm(const AResp: TServiceResponse);

    procedure ButtonClickEvent1(Sender: TObject);
    procedure ButtonClickEvent2(Sender: TObject);
    procedure FormShowEvent1(Sender: TObject);
    procedure FormShowEvent2(Sender: TObject);
  public

  end;

  TProgramSettings = record
    BackgroundHead: integer;
    FontHead: integer;
    BackgroundRows: integer;
    FontRows: integer;
    BackgroundSelectRow: integer;
    FontSelectRow: integer;
    BackgroundSelectCell: integer;
    FontSelectCell: integer;
    SelectRowUnfocusedTable: integer;

    RoundTo: integer; // Округлять числа до vRoundTo знаков после запятой

    ShowHint: Boolean;
  end;

const
  ColorWarningField = $008080FF;

  FolderSettings = 'Settings\';
  FileSettingsTables = FolderSettings + 'SettingsTables.ini';
  FileProgramSettings = FolderSettings + 'ProgramSettings.ini';
  FileDefaultSettingsTables = FolderSettings + 'SettingsDefault\SettingsTables.ini';
  FileDefaultProgramSettings = FolderSettings + 'SettingsDefault\ProgramSettings.ini';
  ProgramsRemoteControl = 'Programs remote control';
  AmmyyAdmin = 'AA_v3.exe';
  AeroAdmin = 'AeroAdmin.exe';
  // -----------------------------------------

  { SettingsTables.ini }

  ColumnCount = 'CC';
  ColumnCountHide = 'CCH';
  RowsCount = 'RC';
  ColumnWidth = 'CW';
  ColumnVisible = 'CV';
  ColumnName = 'CN';
  RowName = 'RN';

  // -----------------------------------------

  { ProgramSettings.ini }

  BackgroundHead = 'BH';
  FontHead = 'FH';
  BackgroundRows = 'BR';
  FontRows = 'FR';
  BackgroundSelectRow = 'BSR';
  FontSelectRow = 'FSR';
  BackgroundSelectCell = 'BSC';
  FontSelectCell = 'FSC';
  SelectRowUnfocusedTable = 'SRUT';

  vRoundTo = 'RT';
  vShowHint = 'SH';

  // Названия форм
  FormNameMain = 'Смета';
  FormNameCoefficientOrders = 'Коэффициент по приказам';
  FormNameCardOrganization = 'Карточка организации';
  FormNameCardCoefficients = 'Карточка коэффициентов';
  FormNameCardPartsEstimates = 'Карточка частей смет';
  FormNameCardSectionsEstimates = 'Карточка разделов смет';
  FormNameCardTypesWorks = 'Карточка видов работ';
  FormNameTypesActs = 'Типы актов';
  FormNameIndexesChangeCost = 'Индексы изменения стоимости';
  FormNameCardIndexesChangeCost = 'Карточка индексов изменения стоимости';
  FormNameCategoriesObjects = 'Виды строительства';
  FormNameCardCategoriesObjects = 'Карточка категорий объектов';
  FormNamePriceMaterials = 'Цены на материалы';
  FormNamePriceMechanizms = 'Цены на механизмы';
  FormNamePriceDumps = 'Тарифы по свалкам';
  FormNameOwnData = 'Собственные данные';
  FormNameReferenceData = 'Справочные данные';
  FormNamePricesOwnData = 'Цены по собственным данным';
  FormNamePricesReferenceData = 'Цены по справочным данным';
  FormNameAdditionData = 'Добавление данных';
  FormNamePartsEstimates = 'Части смет';
  FormNameSectionsEstimates = 'Разделы смет';
  FormNameTypesWorks = 'Виды работ';
  FormNameOrganizations = 'Организации';

const
  LWA_ALPHA = $2;
  LWA_COLORKEY = $1;
  WS_EX_LAYERED = $80000;

var
  FormMain: TFormMain;
  PS: TProgramSettings;
  FMEndTables: Char;

implementation

uses TariffsTransportanion, TariffsMechanism, TariffsDump, TariffsIndex, About, CalculationEstimate,
  ConnectDatabase, CardObject,
  DataModule, Login, Waiting, ActC6, WorkSchedule, HelpC3, HelpC5, CatalogSSR,
  OXRandOPR, DataTransfer, CalculationSettings, ProgramSettings, ObjectsAndEstimates, OwnData, ReferenceData,
  PricesOwnData, CardObjectContractorServices,
  PricesReferenceData, AdditionData, PartsEstimates, TypesActs, IndexesChangeCost, CategoriesObjects,
  KC6Journal, CalcResource, CalcTravel, UniDict, TravelList,
  Tools, fUpdate, EditExpression, dmReportU, Coef, WinterPrice, TariffDict, OXROPRSetup, OrganizationsEx, KC6,
  NormativDirectory, ForecastCostIndex, FileStorage, ForemanList, OXROPR,
  SprController, SSR, ArhivRestore, FireDAC.UI.Intf, CategoryList,
  NormativDictHelp, BuildZone, HelpKfSt, Users, RoundSetup, InstructionHelp, TypeWorkList,
  SectionEstimateList;

{$R *.dfm}

// ---------------------------------------------------------------------------------------------------------------------
procedure TFormMain.ShowSplashForm;
begin
  UpdatePanel.Left := ClientWidth - UpdatePanel.Width;
  UpdatePanel.Top := ClientHeight - UpdatePanel.Height;
  UpdatePanel.Visible := true;
  TimerUpdate.Enabled := UpdatePanel.Visible;
end;

procedure TFormMain.ShowUpdateForm(const AResp: TServiceResponse);
var
  UPForm: TUpdateForm;
begin
  UPForm := TUpdateForm.Create(nil);
  try
    UPForm.SetVersion(FCurVersion, AResp);
    UPForm.SetArhiv(FArhiv);

    UPForm.ShowModal;
    GetSystemInfo;
  finally
    UPForm.Free;
  end;
end;

// Вывод исключений из вспомогательных потоков
procedure TFormMain.ThreadEXCEPTION(var Mes: TMessage);
begin
  if Assigned(TObject(Mes.WParam)) and (TObject(Mes.WParam) is Exception) then
    Application.ShowException(Exception(Mes.WParam));
end;

procedure TFormMain.ARCHIVEPROGRESS(var Mes: TMessage);
begin
  if Mes.LParam in [0, 1] then
  begin
    ArchivPanel.Left := ClientWidth - ArchivPanel.Width;
    ArchivPanel.Top := ClientHeight - ArchivPanel.Height;
    ArchivPanel.Visible := true;
  end;

  if Mes.LParam = 0 then
  begin
    pgArchiv.Enabled := False;
    pgArchiv.State := pbsPaused;

    lbArchStatys.Caption := string(PChar(Mes.WParam));
  end;

  if Mes.LParam = 1 then
  begin
    pgArchiv.Enabled := true;
    pgArchiv.Style := pbstMarquee;
    pgArchiv.State := pbsNormal;

    lbArchStatys.Caption := string(PChar(Mes.WParam));
  end;

  if Mes.LParam = 2 then
  begin
    ArchivPanel.Visible := False;
    FArhiv.Update();
  end;
end;

// Уведомление о доступности новых обновлений
procedure TFormMain.OnUpdate(var Mes: TMessage);
var
  Resp: TServiceResponse;
begin
  UpdatePanel.Visible := False;
  TimerUpdate.Enabled := UpdatePanel.Visible;
  Resp := TServiceResponse.Create;
  try
    Resp.Assign(TServiceResponse(Mes.LParam));

    if not Resp.UserRequest then
      ShowSplashForm
    else
      ShowUpdateForm(Resp);
  finally
    Resp.Free;
  end;
end;

// Загрузка системной информации из smeta.ini и текущей версии приложения
procedure TFormMain.GetSystemInfo;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    if not ini.SectionExists('system') then
    begin
      ini.WriteInteger('system', 'version', 0);
      ini.WriteString('system', 'clientname', '');
      ini.WriteBool('system', 'sendreport', False);
      ini.WriteBool('system', 'debugmode', true);
    end;
    FCurVersion.App := ini.ReadInteger('system', 'version', 0);
    DebugMode := ini.ReadBool('system', 'debugmode', true);
  finally
    FreeAndNil(ini);
  end;
  DM.qrDifferent.Active := False;
  DM.qrDifferent.SQL.Text := 'SELECT max(version) FROM versionref WHERE ' +
    '(execresult > 0) and (SCRIPTCOUNT = SCRIPTNO)';
  DM.qrDifferent.Active := true;
  if not DM.qrDifferent.Eof then
    FCurVersion.Catalog := DM.qrDifferent.Fields[0].AsInteger;
  DM.qrDifferent.Active := False;

  DM.qrDifferent.SQL.Text := 'SELECT max(version) FROM versionuser WHERE ' +
    '(execresult > 0) and (SCRIPTCOUNT = SCRIPTNO)';
  DM.qrDifferent.Active := true;
  if not DM.qrDifferent.Eof then
    FCurVersion.User := DM.qrDifferent.Fields[0].AsInteger;
  DM.qrDifferent.Active := False;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  case Application.MessageBox('Вы действительно хотите закрыть программу?', 'Смета',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) of
    IDYES:
      begin
        CanClose := true;
      end;
    IDNO:
      begin
        CanClose := False;
      end;
  end;
  if FArhiv.CreateArhInProgress then
  begin
    Application.MessageBox('В данный момент идет создание архива. ' + #13#10 +
      'Дождитесь окончания операции.', 'Смета', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);

    CanClose := False;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FCurVersion.Clear;

  SystemInfoResult := False;

  CountOpenWindows := 0;

  Width := Screen.Width;
  Height := Screen.Height;

  img1.Align := alClient;
  img2.Align := alClient;
  PanelCover.Align := alClient;

  FMEndTables := 'g';
  // Локальная установка разделителя
  FormatSettings.DecimalSeparator := '.';

  ReadSettingsFromFile(ExtractFilePath(Application.ExeName) + FileProgramSettings);

  // Объект для управления архивом
  FArhiv := TBaseAppArhiv.Create(ExtractFilePath(Application.ExeName), ExtractFilePath(Application.ExeName) +
    C_ARHDIR);
  // путь к папке с отчетами (Вадим)

  // {$IFDEF DEBUG}
  // FileReportPath := Copy(ExtractFilePath(Application.ExeName), 1, Length(ExtractFilePath(Application.ExeName))
  // - 12) + C_REPORTDIR;
  // {$ELSE}
  // FileReportPath := ExtractFilePath(Application.ExeName) + C_REPORTDIR;
  // {$ENDIF}
  FileReportPath := ExtractFilePath(Application.ExeName) + C_REPORTDIR;

  // Переменная среды для работы относительных путей в хранилище
  Windows.SetEnvironmentVariable('SMETADIR', PChar(ExtractFileDir(Application.ExeName)));
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(SprControl);
  FreeAndNil(FArhiv);
  DM.Connect.Connected := False;
  if Assigned(FUpdateThread) then
  begin // Выполнить Terminate обязательно так как он переопределен
    FUpdateThread.Terminate;
    FUpdateThread.WaitFor;
    FreeAndNil(FUpdateThread);
  end;
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
  if UpdatePanel.Visible then
  begin
    UpdatePanel.Left := ClientWidth - UpdatePanel.Width;
    UpdatePanel.Top := PanelOpenWindows.Top - UpdatePanel.Height;
  end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  try
    if not DM.Connect.Connected then
    begin
      DM.Connect.Params.Text := G_CONNECTSTR;
      DM.Connect.Connected := true;

      mLogInClick(nil);
      if G_USER_ID = 0 then
        Exit;

      // Загрузка справочников
      FormWaiting.Height := 110;
      FormWaiting.lbProcess.Caption := 'Загрузка справочников:';
      FormWaiting.Show;
      Application.ProcessMessages;
      // Справочник сборников расценок
      FormWaiting.lbProcess.Caption := 'Загрузка справочников:'#13 + 'перечень сборников';
      Application.ProcessMessages;

      // Объект для загрузки справочников
      SprControl := TSprControl.Create(Handle);

      if (not Assigned(fNormativDirectory)) then
        fNormativDirectory := TfNormativDirectory.Create(Self);
      //
      FormWaiting.Close;
      FormWaiting.Height := 88;
      FormWaiting.lbProcess.Caption := '';
      Application.ProcessMessages;
    end;
  except
    on e: Exception do
    begin
      e.Message := 'Ошибка подключения к базе:' + sLineBreak + e.Message;
      Application.ShowException(e);
      Application.Terminate;
    end;
  end;

  try
    GetSystemInfo;
    SystemInfoResult := true;
  except
    on e: Exception do
      ShowMessage('Ошибка инициализации системы: ' + e.Message);
  end;

  // Запуск ниточки для мониторигра обновлений
  if SystemInfoResult and not DebugMode then
    FUpdateThread := TUpdateThread.Create(FCurVersion, Self.Handle)
  else
  begin
    if not SystemInfoResult then
      ShowMessage('Обновления недоступны.');
    FUpdateThread := nil;
    ServiceUpdate.Enabled := False;
  end;

  PanelCover.Visible := true;

  if (not Assigned(FormObjectsAndEstimates)) then
    FormObjectsAndEstimates := TFormObjectsAndEstimates.Create(Self);
end;

// ---------------------------------------------------------------------------------------------------------------------
// Управление кнопками на нижней панели
procedure TFormMain.ButtonClickEvent1(Sender: TObject);
var
  sb: TSpeedButton;
begin
  sb := TSpeedButton(Sender);
  if Assigned(TForm(sb.Tag)) then
    FormShowEvent1(TForm(sb.Tag));
end;

procedure TFormMain.ButtonClickEvent2(Sender: TObject);
var
  sb: TSpeedButton;
begin
  sb := TSpeedButton(Sender);
  if Assigned(TForm(sb.Tag)) then
    FormShowEvent2(TForm(sb.Tag));
end;

procedure TFormMain.FormShowEvent2(Sender: TObject);
var
  TmpForm: TForm;
begin
  // PanelCover.Visible := true;
  try
    TmpForm := TForm(Sender);
    if TmpForm.WindowState = wsMinimized then
      TmpForm.WindowState := wsNormal;

    TmpForm.Show;
  finally
    // PanelCover.Visible := False;
  end;
end;

procedure TFormMain.FormShowEvent1(Sender: TObject);
begin
  TForm(Sender).Show;
  TForm(Sender).BringToFront;
end;

procedure TFormMain.CreateButtonOpenWindow(const CaptionButton, HintButton: String; const AForm: TForm;
  AEventType: Byte = 0);
begin
  ButtonsWindows[CountOpenWindows] := TSpeedButton.Create(Application);
  ButtonsWindows[CountOpenWindows].Parent := PanelOpenWindows;
  ButtonsWindows[CountOpenWindows].Align := alLeft;
  ButtonsWindows[CountOpenWindows].Width := 140;
  ButtonsWindows[CountOpenWindows].Height := 25;
  ButtonsWindows[CountOpenWindows].Top := 1;
  ButtonsWindows[CountOpenWindows].Caption := CaptionButton;
  ButtonsWindows[CountOpenWindows].GroupIndex := 1;
  ButtonsWindows[CountOpenWindows].Down := true;
  ButtonsWindows[CountOpenWindows].ShowHint := true;
  ButtonsWindows[CountOpenWindows].Hint := HintButton;

  if (AEventType = 1) then
    ButtonsWindows[CountOpenWindows].OnClick := ButtonClickEvent2
  else
    ButtonsWindows[CountOpenWindows].OnClick := ButtonClickEvent1;

  ButtonsWindows[CountOpenWindows].Tag := integer(AForm);

  Inc(CountOpenWindows);
end;

procedure TFormMain.DeleteButtonCloseWindow(const CaptionButton: String);
var
  i, Y: integer;
begin
  if not Assigned(PanelOpenWindows) or Application.Terminated then
    Exit;

  Y := -1;
  for i := 0 to CountOpenWindows - 1 do
    if (ButtonsWindows[i].Caption = CaptionButton) then
    begin
      Y := i;
      Break;
    end;

  if (Y = -1) then // Нет кнопки с таким названием
    Exit;

  ButtonsWindows[Y].Free;
  ButtonsWindows[Y] := nil;

  while Y < CountOpenWindows - 1 do
  begin
    ButtonsWindows[Y] := ButtonsWindows[Y + 1];
    Inc(Y);
  end;

  Dec(CountOpenWindows);
end;

procedure TFormMain.SelectButtonActiveWindow(const CaptionButton: String);
var
  i: integer;
begin
  for i := 0 to CountOpenWindows - 1 do
    if ButtonsWindows[i].Caption = CaptionButton then
    begin
      ButtonsWindows[i].Down := true;
      Exit;
    end;
end;

procedure TFormMain.ServiceBackupClick(Sender: TObject);
var
  i: integer;
  Mi, TmpMi, TmpMi2: TMenuItem;
begin
  Mi := TMenuItem(Sender);
  // Первые 3и пункта существуют всегда, остальные добавляются при необходимости
  for i := 3 to Mi.Count - 1 do
    Mi.Delete(3);

  // Если надо перезапустить нечего по архивам лазить
  if G_STARTUPDATER > 0 then
  begin
    PMAddNewBackup.Enabled := False;
    Exit;
  end
  else
    PMAddNewBackup.Enabled := true;

  for i := Low(FArhiv.ArhFiles) to High(FArhiv.ArhFiles) do
  begin
    TmpMi := TMenuItem.Create(Mi);

    try
      TmpMi.Caption := DateTimeToStr(FArhiv.GetArhivTime(FArhiv.ArhFiles[i]));
    except
      TmpMi.Caption := ExtractFileName(FArhiv.ArhFiles[i]);
    end;

    TmpMi2 := TMenuItem.Create(TmpMi);
    TmpMi2.Caption := 'Восстановить';
    TmpMi2.OnClick := PMRestoreBackupClick;
    TmpMi.Add(TmpMi2);
    TmpMi2 := TMenuItem.Create(TmpMi);
    TmpMi2.Caption := 'Удалить';
    TmpMi2.OnClick := PMDeleteBackupClick;
    TmpMi.Add(TmpMi2);
    TmpMi.Tag := integer(FArhiv.ArhFiles[i]);
    Mi.Add(TmpMi);
  end;
end;

procedure TFormMain.ServiceSettingsClick(Sender: TObject);
var
  FormProgramSettings: TFormProgramSettings;
begin
  FormProgramSettings := TFormProgramSettings.Create(nil);
  try
    FormProgramSettings.ShowModal;
  finally
    FreeAndNil(FormProgramSettings);
  end;
end;

procedure TFormMain.ServiceUpdateClick(Sender: TObject);
begin
  if Assigned(FUpdateThread) then
    FUpdateThread.UserRequest;
end;

procedure TFormMain.ServiceUpdNormClick(Sender: TObject);
var
  tmp: TFDGUIxScreenCursor;
begin
  try
    with DM.qrDifferent do
    begin
      Active := False;
      SQL.Text := 'CALL `UpdateNormSortField`()';
      tmp := DM.FDGUIxWaitCursor1.ScreenCursor;
      try
        DM.FDGUIxWaitCursor1.ScreenCursor := TFDGUIxScreenCursor.gcrHourGlass;
        ExecSQL;
      finally
        DM.FDGUIxWaitCursor1.ScreenCursor := tmp;
      end;
    end;
  except
    on e: Exception do
    begin
      e.Message := 'Возникло исключение:' + sLineBreak + e.Message;
      Application.ShowException(e);
    end;
  end;
end;

procedure TFormMain.TimerCoverTimer(Sender: TObject);
begin
  (Sender as TTimer).Enabled := False;
  PanelCover.Visible := False;
end;

procedure TFormMain.TimerUpdateTimer(Sender: TObject);
var
  i: integer;
begin
  LabelDot.Caption := '';
  for i := 1 to TimerUpdate.Tag do
    LabelDot.Caption := LabelDot.Caption + '.';
  if TimerUpdate.Tag >= 3 then
    TimerUpdate.Tag := 0
  else
    TimerUpdate.Tag := TimerUpdate.Tag + 1;
end;

// Скрытие панели обновлений
procedure TFormMain.UpdatePanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: integer);
begin
  UpdatePanel.Visible := False;
  TimerUpdate.Enabled := UpdatePanel.Visible;
end;

procedure TFormMain.vk2Click(Sender: TObject);
begin

  // dmReportF.Report_WINTER_RS_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_WINTER_RS_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;
        dmReportF.Report_WINTER_RS_OBJ(FormCalculationEstimate.IdEstimate, FileReportPath);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.TariffsTransportationClick(Sender: TObject);
begin
  PanelCover.Visible := true;

  if (not Assigned(FormTariffsTransportation)) then
    FormTariffsTransportation := TFormTariffsTransportation.Create(Self);
end;

procedure TFormMain.TariffsMechanismClick(Sender: TObject);
begin
  if not Assigned(FormCalculationEstimate) then
  begin
    MessageBox(0, PChar('Cначала надо выбрать смету.'), FormNamePriceMechanizms,
      MB_ICONINFORMATION + MB_OK + mb_TaskModal);
    Exit;
  end;

  PanelCover.Visible := true;

  if (not Assigned(FormTariffsMechanism)) then
    FormTariffsMechanism := TFormTariffsMechanism.Create(Self);
end;

procedure TFormMain.TariffsDumpClick(Sender: TObject);
begin
  PanelCover.Visible := true;

  if (not Assigned(FormTariffsDump)) then
    FormTariffsDump := TFormTariffsDump.Create(Self);
end;

// Тарифы по статистическим индексам
procedure TFormMain.TariffsIndexClick(Sender: TObject);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormTariffsIndex)) then
    FormTariffsIndex := TFormTariffsIndex.Create(Self);

  FormTariffsIndex.Show;

  // Закрываем форму ожидания
  FormWaiting.Close;
end;

procedure TFormMain.ActC6Click(Sender: TObject);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormActC6)) then
    FormActC6 := TFormActC6.Create(Self);

  FormActC6.Show;

  // Закрываем форму ожидания
  FormWaiting.Close;
end;

procedure TFormMain.N1Click(Sender: TObject);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormWorkSchedule)) then
    FormWorkSchedule := TFormWorkSchedule.Create(Self);

  FormWorkSchedule.Show;

  // Закрываем форму ожидания
  FormWaiting.Close;
end;

procedure TFormMain.N22Click(Sender: TObject);
begin

  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      // **************************************************************************************************************************************

      ShellExecute(Handle, nil, 'report.exe', PChar('S' + INTTOSTR(FormObjectsAndEstimates.IdEstimate)),
        PChar(FileReportPath + 'report\'), SW_maximIZE);

      // **************************************************************************************************************************************
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;
        ShellExecute(Handle, nil, 'report.exe', PChar('S' + INTTOSTR(FormCalculationEstimate.IdEstimate)),
          PChar(FileReportPath + 'report\'), SW_maximIZE);

        // **************************************************************************************************************************************
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.N23Click(Sender: TObject);
begin

  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin

      if FormObjectsAndEstimates.qrActsEx.FieldByName('ID').AsInteger > 0 then
        ShellExecute(Handle, nil, 'report.exe',
          PChar('A' + INTTOSTR(FormObjectsAndEstimates.qrActsEx.FieldByName('ID').AsInteger)),
          PChar(FileReportPath + 'report\'), SW_maximIZE);

    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin

        if FormCalculationEstimate.IDAct > 0 then
          ShellExecute(Handle, nil, 'report.exe', PChar('A' + INTTOSTR(FormCalculationEstimate.IDAct)),
            PChar(FileReportPath + 'report\'), SW_maximIZE);

      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TFormMain.N24Click(Sender: TObject);
begin
  if Assigned(FormCalculationEstimate) then
  begin
    if FormCalculationEstimate.IdEstimate > 0 then
      ShellExecute(Handle, nil, 'report.exe', PChar('S' + INTTOSTR(FormCalculationEstimate.IdEstimate)),
        PChar(FileReportPath + 'report\'), SW_maximIZE)
    else
      ShellExecute(Handle, nil, 'report.exe', PChar('A' + INTTOSTR(FormCalculationEstimate.IDAct)),
        PChar(FileReportPath + 'report\'), SW_maximIZE);
  end;
end;

procedure TFormMain.mBuildZoneClick(Sender: TObject);
var
  fBuildZone: TfBuildZone;
begin
  fBuildZone := TfBuildZone.Create(Self);
  try
    fBuildZone.ShowModal;
  finally
    FreeAndNil(fBuildZone);
  end;
end;

procedure TFormMain.mCalcResourcesClick(Sender: TObject);
begin
  if Assigned(FormCalculationEstimate) then
    ShowCalcResource(FormCalculationEstimate.IdEstimate);
end;

// Расход материалов по акту
procedure TFormMain.mConstractorServiceClick(Sender: TObject);
begin {
    if (not Assigned(fUniDict)) then
    fUniDict := TfUniDict.Create(Self);
    fUniDict.qrUniDictType.Locate('unidicttype_id', 7, []);
    fUniDict.Show; }
  ShowContractorServices;
end;

procedure TFormMain.mLogInClick(Sender: TObject);
begin
  if (not Assigned(fLogIn)) then
    fLogIn := TfLogIn.Create(FormMain);
  if fLogIn.ShowModal <> mrOk then
    Close;
end;

procedure TFormMain.mhfybkbotafqkjd1Click(Sender: TObject);
begin
  if (not Assigned(fFileStorage)) then
    fFileStorage := TfFileStorage.Create(Self);
  fFileStorage.Show;
end;

procedure TFormMain.mN110Click(Sender: TObject);
begin
  if (not Assigned(fSSR)) then
    fSSR := TfSSR.Create((Sender as TMenuItem).Tag, (Sender as TMenuItem).Caption);
  fSSR.Show;
end;

procedure TFormMain.mN111Click(Sender: TObject);
begin
  if (not Assigned(fNormativDictHelp)) then
    fNormativDictHelp := TfNormativDictHelp.Create(FormMain);
  fNormativDictHelp.pgc1.ActivePageIndex := (Sender as TMenuItem).Tag;
  fNormativDictHelp.pgc1Change(nil);
  fNormativDictHelp.Show;
end;

procedure TFormMain.mN15Click(Sender: TObject);
begin
  if (not Assigned(fTariffDict)) then
    fTariffDict := TfTariffDict.Create(Self);
  fTariffDict.Show;
end;

procedure TFormMain.mN17Click(Sender: TObject);
begin
  if (not Assigned(fOXROPRSetup)) then
    fOXROPRSetup := TfOXROPRSetup.Create(Self);
  fOXROPRSetup.Show;
end;

procedure TFormMain.mN22Click(Sender: TObject);
begin
  if (not Assigned(fNormativDirectory)) then
    fNormativDirectory := TfNormativDirectory.Create(nil);
  fNormativDirectory.Show;
end;

procedure TFormMain.mN23Click(Sender: TObject);
begin
  if (not Assigned(fForecastCostIndex)) then
    fForecastCostIndex := TfForecastCostIndex.Create(nil);
  fForecastCostIndex.Show;
end;

procedure TFormMain.mN24Click(Sender: TObject);
begin
  if (not Assigned(fForemanList)) then
    fForemanList := TfForemanList.Create(FormMain);
  fForemanList.Show;
end;

procedure TFormMain.mN25Click(Sender: TObject);
begin
  if (not Assigned(fUniDict)) then
    fUniDict := TfUniDict.Create(Self);
  fUniDict.qrUniDictType.Filtered := False;
  fUniDict.qrUniDictType.Locate('unidicttype_id', 14, []);
  fUniDict.pnlLeft.Visible := False;
  fUniDict.lbl1.Visible := False;
  fUniDict.seYear.Visible := False;
  fUniDict.dbmmoparam_description1.Visible := False;
  FormMain.DeleteButtonCloseWindow(fUniDict.Caption);
  fUniDict.Caption := 'Прочие';
  fUniDict.FormStyle := fsNormal;
  fUniDict.Width := 400;
  fUniDict.Height := 200;
  fUniDict.pnlClient.Align := alClient;
  fUniDict.FormStorage.Active := False;
  fUniDict.Position := poMainFormCenter;
  fUniDict.grUniDictParam.RowsHeight := 17;
  fUniDict.grUniDictParam.RowResize := False;
  fUniDict.grUniDictParam.Options := fUniDict.grUniDictParam.Options - [dgIndicator];
  fUniDict.Show;
end;

procedure TFormMain.mN26Click(Sender: TObject);
begin
  if (not Assigned(fCategoryList)) then
    fCategoryList := TfCategoryList.Create(FormMain);
  fCategoryList.Show;
end;

procedure TFormMain.mN27Click(Sender: TObject);
begin
  if (not Assigned(fOXROPR)) then
    fOXROPR := TfOXROPR.Create(FormMain);
  fOXROPR.Show;
end;

procedure TFormMain.mN30Click(Sender: TObject);
begin
  if (not Assigned(fRoundSetup)) then
    fRoundSetup := TfRoundSetup.Create(FormMain);
  fRoundSetup.ShowModal;
end;

procedure TFormMain.mN36Click(Sender: TObject);
begin
  if (not Assigned(fInstructionHelp)) then
    fInstructionHelp := TfInstructionHelp.Create(FormMain);
  fInstructionHelp.ShowModal;
end;

procedure TFormMain.mN38Click(Sender: TObject);
begin
  if (not Assigned(FormObjectsAndEstimates)) then
    FormObjectsAndEstimates := TFormObjectsAndEstimates.Create(Self);
  FormObjectsAndEstimates.Show;
end;

procedure TFormMain.mUsersClick(Sender: TObject);
begin
  if (not Assigned(fUsers)) then
    fUsers := TfUsers.Create(FormMain);
  fUsers.ShowModal;
end;

procedure TFormMain.mHelpKfStClick(Sender: TObject);
begin
  if (not Assigned(fHelpKfSt)) then
    fHelpKfSt := TfHelpKfSt.Create(FormMain);
  fHelpKfSt.Show;
end;

// Расчет стоимости работ по объекту (графа С) v1.00 (Вадим)
procedure TFormMain.mnCALC_SMETA_OBJ_GRAPH_CClick(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_CALC_SMETA_OBJ_GRAPH_C(FormObjectsAndEstimates.IdEstimate, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;

        dmReportF.Report_CALC_SMETA_OBJ_GRAPH_C(FormObjectsAndEstimates.IdEstimate, FileReportPath);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.mnRASX_ACTClick(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.qrActsEx.IsEmpty then
      begin
        ShowMessage('Не выбран акт');
        Exit;
      end;
      dmReportF.Report_RASX_MAT(FormObjectsAndEstimates.qrActsEx.FieldByName('ID').AsInteger, FileReportPath);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

// --> "СМЕТА по объекту строительства" v.1.03
procedure TFormMain.mnREPORT_SMETA_OBJ_BUILDClick(Sender: TObject);
{ var
  param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15,
  param16, param17, param18, param19, param20, param21, param22, param23: Double; }
begin
  {
    Screen.Cursor := crSQLWait;
    try
    if Assigned(FormObjectsAndEstimates) then
    begin
    if FormObjectsAndEstimates.IdEstimate = 0 then
    begin
    ShowMessage('Не выбрана смета');
    Exit;
    end;

    // ShowEnter;

    dmReportF.Report_SMETA_OBJ_BUILD(FormObjectsAndEstimates.IdEstimate, FileReportPath, param4, param5,
    param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16,
    param17, param18, param19, param20, param21, param22, param23);
    end
    else
    begin
    if Assigned(FormCalculationEstimate) then
    begin
    if FormCalculationEstimate.IdEstimate = 0 then
    begin
    ShowMessage('Не выбрана смета');
    Exit;
    end;

    // ShowEnter;

    dmReportF.Report_SMETA_OBJ_BUILD(FormCalculationEstimate.IdEstimate, FileReportPath, param4, param5,
    param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16,
    param17, param18, param19, param20, param21, param22, param23);
    end;
    end;
    finally
    Screen.Cursor := crDefault;
    end;
  }
end;

// Смета (Локальный сметный расчет) по объекту v1.00 (Вадим)
procedure TFormMain.mnSMETA_LSR_FROM_OBJClick(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_SMETA_LSR_FROM_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;

        dmReportF.Report_SMETA_LSR_FROM_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

// Смета (Локальный сметный расчет) с трудозатратами по объекту v1.00 (Вадим)
procedure TFormMain.mnSMETA_LSR_TRUDClick(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_SMETA_LSR_TRUD(FormObjectsAndEstimates.IdEstimate, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;

        dmReportF.Report_SMETA_LSR_TRUD(FormObjectsAndEstimates.IdEstimate, FileReportPath);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

// Смета (Локальный сметный расчет) с зимними v1.00 (Вадим)
procedure TFormMain.mnSMETA_LSR_ZIMClick(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_SMETA_LSR_ZIM(FormObjectsAndEstimates.IdEstimate, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;

        dmReportF.Report_SMETA_LSR_ZIM(FormObjectsAndEstimates.IdEstimate, FileReportPath);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

// Смета (Ресурсно-сметный расчет) по объекту v1.00 (Вадим)
procedure TFormMain.mnSMETA_RES_FROM_OBJClick(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_SMETA_RES_FROM_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;

        dmReportF.Report_SMETA_RES_FROM_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.vk3Click(Sender: TObject);
begin

  // dmReportF.Report_WINTER_RS_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_RSMO_OBJ(0, FormObjectsAndEstimates.IdEstimate, 0, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;

        dmReportF.Report_RSMO_OBJ(0, 0, FormCalculationEstimate.IdObject, FileReportPath);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.vk4Click(Sender: TObject);
begin
  // dmReportF.Report_WINTER_RS_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_RSMO_OBJ(1, FormObjectsAndEstimates.IdEstimate, 0, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;

        dmReportF.Report_RSMO_OBJ(1, 0, FormCalculationEstimate.IdObject, FileReportPath);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.vk5Click(Sender: TObject);
begin
  // vk Расчет стоимости механизмов без НДС по объекту
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_RSMEH_OBJ(0, FormObjectsAndEstimates.IdEstimate, 0, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;

        dmReportF.Report_RSMEH_OBJ(0, 0, FormCalculationEstimate.IdObject, FileReportPath);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.vk6Click(Sender: TObject);
begin
  // vk - Расчет стоимости оборудования по объекту
end;

procedure TFormMain.vk7Click(Sender: TObject);
begin
  // vk ВЕДОМОСТЬ ОБЪЁМОВ И СТОИМОСТИ РАБОТ  вариант-1
  Screen.Cursor := crSQLWait;
  try

    if Assigned(FormCalculationEstimate) then
    begin
      if FormCalculationEstimate.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_VED_OANDPWV1_OBJ(1, 0, FormCalculationEstimate.IdObject, FileReportPath);
    end;

  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.vk9Click(Sender: TObject);
begin
  // vk Ведомость объемов работ и расхода ресурсов по смете
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_VED_OBRAB_RASHRES_SMET_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;
        dmReportF.Report_VED_OBRAB_RASHRES_SMET_OBJ(FormCalculationEstimate.IdObject, FileReportPath);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.N10Click(Sender: TObject);
begin
  // vk ВЕДОМОСТЬ ОБЪЁМОВ И СТОИМОСТИ РАБОТ  вариант-1
  Screen.Cursor := crSQLWait;
  try

    if Assigned(FormCalculationEstimate) then
    begin
      if FormCalculationEstimate.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_VED_OANDPWV1_OBJ(2, 0, FormCalculationEstimate.IdObject, FileReportPath);
    end;

  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.N12Click(Sender: TObject);
begin
  if (not Assigned(fWinterPrice)) then
    fWinterPrice := TfWinterPrice.Create(Self);
  fWinterPrice.Show;
end;

procedure TFormMain.VK2N13Click(Sender: TObject);
begin

  Screen.Cursor := crSQLWait;
  try

    // if Assigned(FormCalculationEstimate) then
    // begin
    // if FormCalculationEstimate.GetIdEstimate = 0 then
    // begin
    // showmessage('Не выбрана смета');
    // Exit;
    // end;
    dmReportF.vk2n13(FormObjectsAndEstimates.getCurObject, FileReportPath);
    // end;

  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TFormMain.N31Click(Sender: TObject);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormHelpC3)) then
    FormHelpC3 := TFormHelpC3.Create(Self);

  FormHelpC3.Show;

  // Закрываем форму ожидания
  FormWaiting.Close;
end;

procedure TFormMain.N51Click(Sender: TObject);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormHelpC5)) then
    FormHelpC5 := TFormHelpC5.Create(Self);

  FormHelpC5.Show;

  // Закрываем форму ожидания
  FormWaiting.Close;
end;

procedure TFormMain.N61Click(Sender: TObject);
begin
  if (not(Assigned(FormCalculationEstimate))) then
  begin
    if FormObjectsAndEstimates.qrTreeData.IsEmpty then
      Exit;
    if (not Assigned(fKC6Journal)) then
      fKC6Journal := TfKC6Journal.Create(Self);
    if Assigned(FormObjectsAndEstimates) then
      fKC6Journal.LocateObject(FormObjectsAndEstimates.getCurObject);
    fKC6Journal.LocateEstimate(FormObjectsAndEstimates.qrTreeData.FieldByName('SM_ID').Value);
    fKC6Journal.tvEstimates.SelectNode(FormObjectsAndEstimates.qrTreeData.FieldByName('SM_ID').Value)
      .Expand(False);
    fKC6Journal.tvEstimatesClick(Self);
    fKC6Journal.Show;
  end
  else
  begin
    if FormCalculationEstimate.IDAct <> 0 then
    // для акта
    begin
      if MessageBox(0, PChar('Произвести выборку данных из сметы?'), 'Расчёт сметы',
        MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrYes then
        fKC6.MyShow(FormCalculationEstimate.IdObject);
    end
    // Для сметы
    else
    begin
      if (not Assigned(fKC6Journal)) then
        fKC6Journal := TfKC6Journal.Create(Self);
      fKC6Journal.LocateObject(FormCalculationEstimate.IdObject);
      fKC6Journal.LocateEstimate(FormCalculationEstimate.IdEstimate);
      fKC6Journal.tvEstimates.SelectNode(FormCalculationEstimate.IdEstimate).Expand(False);
      fKC6Journal.tvEstimatesClick(Self);
      fKC6Journal.Show;
    end;
  end;
end;

procedure TFormMain.N6Click(Sender: TObject);
begin
  if (not Assigned(fTravelList)) then
    fTravelList := TfTravelList.Create(Self);
  fTravelList.Show;
end;

procedure TFormMain.N8Click(Sender: TObject);
{ var
  s: string; }
begin
  {
    s := InputBox('Справочник ежемесячных величин', 'Укажите пароль:', '');
    if s <> '1' then
    Exit;
  }
  if (not Assigned(fUniDict)) then
    fUniDict := TfUniDict.Create(Self);
  fUniDict.Show;
end;

procedure TFormMain.JSMenuClick(Sender: TObject);
begin

  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      // **************************************************************************************************************************************
      if (Sender as TMenuItem).Name = 'jsMenu1' then
        dmReportF.JSReport(1, FormObjectsAndEstimates.IdEstimate, FileReportPath);
      // Ведомость объемов работ и расхода ресурсов
      if (Sender as TMenuItem).Name = 'jsMenu2' then
        dmReportF.JSReport(2, FormObjectsAndEstimates.IdEstimate, FileReportPath);
      // Ведомость объемов работ и расхода ресурсов (по локальным сметам)
      if (Sender as TMenuItem).Name = 'jsMenu3' then
        dmReportF.JSReport(3, FormObjectsAndEstimates.IdEstimate, FileReportPath);
      // Ведомость объемов работ и расхода ресурсов (по объектным сметам)
      if (Sender as TMenuItem).Name = 'jsMenu4' then
        dmReportF.JSReport(4, FormObjectsAndEstimates.IdEstimate, FileReportPath);
      // !!! Ведомость объемов работ и расхода ресурсов (в стоимостном выражении)
      if (Sender as TMenuItem).Name = 'jsMenu5' then
        dmReportF.JSReport(5, FormObjectsAndEstimates.IdEstimate, FileReportPath);
      // Ведомость ресурсов по смете

      if (Sender as TMenuItem).Name = 'JSMenu6' then
        dmReportF.JSReport(6, FormObjectsAndEstimates.IdEstimate, FileReportPath);
      if (Sender as TMenuItem).Name = 'JSMenu7' then
        dmReportF.JSReport(7, FormObjectsAndEstimates.IdEstimate, FileReportPath);
      if (Sender as TMenuItem).Name = 'JSMenu8' then
        dmReportF.JSReport(8, FormObjectsAndEstimates.IdEstimate, FileReportPath);
      if (Sender as TMenuItem).Name = 'JSMenu9' then
        dmReportF.JSReport(9, FormObjectsAndEstimates.IdEstimate, FileReportPath);
      if (Sender as TMenuItem).Name = 'JSMenu10' then
        dmReportF.JSReport(10, FormObjectsAndEstimates.IdEstimate, FileReportPath);
      // **************************************************************************************************************************************
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;
        // **************************************************************************************************************************************
        if (Sender as TMenuItem).Name = 'jsMenu1' then
          dmReportF.JSReport(1, FormCalculationEstimate.IdEstimate, FileReportPath);
        // Ведомость объемов работ и расхода ресурсов
        if (Sender as TMenuItem).Name = 'jsMenu2' then
          dmReportF.JSReport(2, FormCalculationEstimate.IdEstimate, FileReportPath);
        // Ведомость объемов работ и расхода ресурсов (по локальным сметам)
        if (Sender as TMenuItem).Name = 'jsMenu3' then
          dmReportF.JSReport(3, FormCalculationEstimate.IdEstimate, FileReportPath);
        // Ведомость объемов работ и расхода ресурсов (по объектным сметам)
        if (Sender as TMenuItem).Name = 'jsMenu4' then
          dmReportF.JSReport(4, FormCalculationEstimate.IdEstimate, FileReportPath);
        // !!! Ведомость объемов работ и расхода ресурсов (в стоимостном выражении)
        if (Sender as TMenuItem).Name = 'jsMenu5' then
          dmReportF.JSReport(5, FormCalculationEstimate.IdEstimate, FileReportPath);
        // Ведомость ресурсов по смете

        if (Sender as TMenuItem).Name = 'JSMenu6' then
          dmReportF.JSReport(6, FormCalculationEstimate.IdEstimate, FileReportPath);
        if (Sender as TMenuItem).Name = 'JSMenu7' then
          dmReportF.JSReport(7, FormCalculationEstimate.IdEstimate, FileReportPath);
        if (Sender as TMenuItem).Name = 'JSMenu8' then
          dmReportF.JSReport(8, FormCalculationEstimate.IdEstimate, FileReportPath);
        if (Sender as TMenuItem).Name = 'JSMenu9' then
          dmReportF.JSReport(9, FormCalculationEstimate.IdEstimate, FileReportPath);
        if (Sender as TMenuItem).Name = 'JSMenu10' then
          dmReportF.JSReport(10, FormCalculationEstimate.IdEstimate, FileReportPath);
        // **************************************************************************************************************************************
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TFormMain.N14Click(Sender: TObject);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormCatalogSSR)) then
    FormCatalogSSR := TFormCatalogSSR.Create(Self);

  FormCatalogSSR.Show;

  // Закрываем форму ожидания
  FormWaiting.Close;
end;

procedure TFormMain.MenuServiceClick(Sender: TObject);
begin
  ServiceBackup.Enabled := not FArhiv.CreateArhInProgress and not FArhiv.RestoreArhInProgress;
end;

procedure TFormMain.MenuSetCoefficientsClick(Sender: TObject);
begin
  fCoefficients.Show;
end;

// --> вызовы отчетов (Вадим)
procedure TFormMain.mnZP_OBJClick(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_ZP_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;
        dmReportF.Report_ZP_OBJ(FormCalculationEstimate.IdEstimate, FileReportPath);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.mnZP_OBJ_AKTClick(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.qrActsEx.IsEmpty then
      begin
        ShowMessage('Не выбран акт');
        Exit;
      end;
      dmReportF.Report_ZP_OBJ_ACT(FormObjectsAndEstimates.qrActsEx.FieldByName('ID').AsInteger,
        FileReportPath);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.mTranspNormClick(Sender: TObject);
begin
  DM.qrDifferent.Active := False;
  DM.qrDifferent.SQL.Text := 'Select doc_id from doc where doc_id = ' + INTTOSTR(C_DOCID_TRANSP_XLT);
  DM.qrDifferent.Active := true;
  try
    if DM.qrDifferent.IsEmpty then
      raise Exception.Create('Связь с документом не установлена.')
    else
      RunDocument(DM.qrDifferent, False);
  finally
    DM.qrDifferent.Active := False;
  end;
end;

// <-- вызовы отчетов (Вадим)

procedure TFormMain.MenuListsTypesActsClick(Sender: TObject);
begin
  FormTypesActs.ShowModal;
end;

procedure TFormMain.MenuListsIndexesChangeCostClick(Sender: TObject);
begin
  FormIndexesChangeCost.ShowModal;
end;

procedure TFormMain.MenuListsСategoriesObjectsClick(Sender: TObject);
begin
  FormCategoriesObjects.ShowModal;
end;

procedure TFormMain.MenuPartsEstimatesClick(Sender: TObject);
begin
  if (not Assigned(FormPartsEstimates)) then
    FormPartsEstimates := TFormPartsEstimates.Create(FormMain)
  else
    FormPartsEstimates.Show;
end;

procedure TFormMain.MenuListsSectionsEstimatesClick(Sender: TObject);
begin
  if (not Assigned(fSectionEstimateList)) then
    fSectionEstimateList := TfSectionEstimateList.Create(FormMain);
  fSectionEstimateList.Show;
end;

procedure TFormMain.MenuListsTypesWorksClick(Sender: TObject);
begin
  if (not Assigned(fTypeWorkList)) then
    fTypeWorkList := TfTypeWorkList.Create(FormMain);
  fTypeWorkList.Show;
end;

procedure TFormMain.MenuOrganizationsClick(Sender: TObject);
begin
  if (not Assigned(fOrganizationsEx)) then
    fOrganizationsEx := TfOrganizationsEx.Create(FormMain);
  fOrganizationsEx.Show;
end;

procedure TFormMain.HRRReferenceDataClick(Sender: TObject);
begin
  if (not Assigned(FormReferenceData)) then
    FormReferenceData := TFormReferenceData.Create(Self, '0', False)
  else
    FormReferenceData.Show;
end;

procedure TFormMain.HRROwnDataClick(Sender: TObject);
begin
  if (not Assigned(FormOwnData)) then
    FormOwnData := TFormOwnData.Create(Self, '1', False);
end;

procedure TFormMain.HRRPricesClick(Sender: TObject);
begin
  // Справочные
  if (not Assigned(FormPricesReferenceData)) then
    FormPricesReferenceData := TFormPricesReferenceData.Create(Self, 'g', true);
  { Собственные
    if (not Assigned(FormPricesOwnData)) then
    FormPricesOwnData := TFormPricesOwnData.Create(Self, 's', true);
  }
end;

procedure TFormMain.OXRandOPRgClick(Sender: TObject);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormOXRandOPR)) then
    FormOXRandOPR := TFormOXRandOPR.Create(Self);

  FormOXRandOPR.Show;

  // Закрываем форму ожидания
  FormWaiting.Close;
end;

procedure TFormMain.PMAddNewBackupClick(Sender: TObject);
var
  i: integer;
begin
  // Максимуи C_ARHCOUNT копии, что-бы не забивать место
  for i := C_ARHCOUNT - 1 to High(FArhiv.ArhFiles) do
    FArhiv.DeleteArhiv(FArhiv.ArhFiles[i]);
  FArhiv.CreateNewArhiv(Handle);
end;

procedure TFormMain.PMDeleteBackupClick(Sender: TObject);
var
  Mi: TMenuItem;
begin
  Mi := TMenuItem(Sender);
  if (MessageBox(Self.Handle, PChar('Удалить резервную копию от ' + StringReplace(Mi.Parent.Caption, '&', '',
    [rfReplaceAll]) + '?'), 'Резервное копирование', MB_YESNO + MB_ICONQUESTION) = IDYES) then
    FArhiv.DeleteArhiv(string(Mi.Parent.Tag));
end;

procedure TFormMain.PMRestoreBackupClick(Sender: TObject);
var
  Mi: TMenuItem;
  ArhForm: TfrmArhRestore;
begin
  Mi := TMenuItem(Sender);
  beep;
  if (MessageBox(Self.Handle, PChar('Восстановить из резервной копии от ' + StringReplace(Mi.Parent.Caption,
    '&', '', [rfReplaceAll]) + '?' + #13#10 + 'Внимание, все данные внесенные после создания данной копии, ' +
    'будут утеряны!'), 'Резервное копирование', MB_YESNO + MB_ICONQUESTION) = IDYES) then
  begin
    try
      ArhForm := TfrmArhRestore.Create(Self);
      FArhiv.RestoreArhiv(ArhForm.Handle, string(Mi.Parent.Tag));
      ArhForm.ShowModal;
    finally
      FreeAndNil(ArhForm);
      Close;
    end;
  end;
end;

procedure TFormMain.NormalClick(Sender: TObject);
begin

end;

// По горизонтали
procedure TFormMain.WindowsHorizontalClick(Sender: TObject);
begin
  TileMode := tbHorizontal;
  Tile;
end;

// По вертикали
procedure TFormMain.WindowsVerticalClick(Sender: TObject);
begin
  TileMode := tbVertical;
  Tile;
end;

// По каскадом
procedure TFormMain.WindowsCascadeClick(Sender: TObject);
begin
  FormMain.PanelCover.Visible := true; // Показываем панель на главной форме
  Cascade;
  FormMain.PanelCover.Visible := False; // Скрываем панель на главной форме
end;

// Свернуть все
procedure TFormMain.WindowsMinimizeClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to MDIChildCount - 1 do
    MDIChildren[i].WindowState := wsMinimized;

  ActiveMDIChild.WindowState := wsMinimized;
end;

// Развернуть все
procedure TFormMain.WindowsExpandClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to MDIChildCount - 1 do
    MDIChildren[i].WindowState := wsNormal;
end;

procedure TFormMain.EditOriginalDataClick(Sender: TObject);
begin
  FormCardObject.ShowModal;
end;

procedure TFormMain.Excel2Click(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_EXCEL(FormObjectsAndEstimates.IdEstimate, 1);

      ShellExecute(Handle, nil, 'report.exe', PChar('E' + INTTOSTR(FormObjectsAndEstimates.IdEstimate)),
        PChar(GetCurrentDir + '\reports\report\'), SW_maximIZE);

    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;
        dmReportF.Report_EXCEL(FormCalculationEstimate.IdEstimate, 1);
        ShellExecute(Handle, nil, 'report.exe', PChar('E' + INTTOSTR(FormCalculationEstimate.IdEstimate)),
          PChar(GetCurrentDir + '\reports\report\'), SW_maximIZE);

      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.EXCEL3Click(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        ShowMessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_EXCEL(FormObjectsAndEstimates.IdEstimate, 2);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.IdEstimate = 0 then
        begin
          ShowMessage('Не выбрана смета');
          Exit;
        end;
        dmReportF.Report_EXCEL(FormCalculationEstimate.IdEstimate, 2);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.FileCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.CalculationSettingsClick(Sender: TObject);
begin
  FormCalculationSettings.Show;
end;

procedure TFormMain.HelpAboutClick(Sender: TObject);
var
  fAbout: TfAbout;
begin
  fAbout := TfAbout.Create(nil);
  try
    fAbout.ShowModal;
  finally
    FreeAndNil(fAbout);
  end;
end;

function ShiftDown: Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[vk_Shift] and 128) <> 0);
end;

function CtrlDown: Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[vk_Control] and 128) <> 0);
end;

function AltDown: Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[vk_Menu] and 128) <> 0);
end;

procedure TFormMain.CascadeForActiveWindow();
begin
  if (MDIChildCount > 1) and (CtrlDown = true) then
    Cascade;
end;

procedure TFormMain.ReadSettingsFromFile(PathFile: String);
var
  IFile: TIniFile;
begin
  try
    IFile := TIniFile.Create(PathFile); // Открываем файл

    with IFile do
    begin
      PS.BackgroundHead := ReadInteger('Tables', BackgroundHead, 14410967);
      PS.FontHead := ReadInteger('Tables', FontHead, 0);
      PS.BackgroundRows := ReadInteger('Tables', BackgroundRows, 16777215);
      PS.FontRows := ReadInteger('Tables', FontRows, 0);
      PS.BackgroundSelectRow := ReadInteger('Tables', BackgroundSelectRow, 5197647);
      PS.FontSelectRow := ReadInteger('Tables', FontSelectRow, 16777215);
      PS.BackgroundSelectCell := ReadInteger('Tables', BackgroundSelectCell, 2039583);
      PS.FontSelectCell := ReadInteger('Tables', FontSelectCell, 16777215);
      PS.SelectRowUnfocusedTable := ReadInteger('Tables', SelectRowUnfocusedTable, -16777201);

      PS.RoundTo := ReadInteger('Round', vRoundTo, 0);

      PS.ShowHint := ReadBool('ShowHint', vShowHint, true);
    end;
  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormMain.ReplaceButtonOpenWindow(const AFrom, ATo: TForm);
var
  i: integer;
begin
  for i := 0 to CountOpenWindows - 1 do
  begin
    if ButtonsWindows[i].Tag = integer(AFrom) then
      ButtonsWindows[i].Tag := integer(ATo);
  end;
end;

procedure TFormMain.WriteSettingsToFile(PathFile: String);
var
  IFile: TIniFile;
begin
  try
    IFile := TIniFile.Create(PathFile); // Открываем файл

    with IFile do
    begin
      WriteInteger('Tables', BackgroundHead, PS.BackgroundHead);
      WriteInteger('Tables', FontHead, PS.FontHead);
      WriteInteger('Tables', BackgroundRows, PS.BackgroundRows);
      WriteInteger('Tables', FontRows, PS.FontRows);
      WriteInteger('Tables', BackgroundSelectRow, PS.BackgroundSelectRow);
      WriteInteger('Tables', FontSelectRow, PS.FontSelectRow);
      WriteInteger('Tables', BackgroundSelectCell, PS.BackgroundSelectCell);
      WriteInteger('Tables', FontSelectCell, PS.FontSelectCell);
      WriteInteger('Tables', SelectRowUnfocusedTable, PS.SelectRowUnfocusedTable);

      WriteInteger('Round', vRoundTo, PS.RoundTo);

      WriteBool('ShowHint', vShowHint, PS.ShowHint);
    end;
  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormMain.RunProgramsRemoteControl(Sender: TObject);
var
  Path: string;
begin
  Path := ExtractFilePath(Application.ExeName) + ProgramsRemoteControl + '\';

  case (Sender as TMenuItem).Tag of
    1:
      Path := Path + AeroAdmin;
    2:
      Path := Path + AmmyyAdmin;
  end;

  if not FileExists(Path) then
  begin
    MessageBox(0, PChar('Файл программы расположенный по адресу:' + sLineBreak + Path + sLineBreak +
      'не найден!'), FormNameMain, MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;

  ShellExecute(Handle, nil, PChar(Path), nil, nil, SW_RESTORE);
end;

end.
