Unit Main;

interface

uses
  Classes, Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ComCtrls, ToolWin, StdCtrls, Buttons, DBGrids,
  ShellAPI, DateUtils, IniFiles, Grids, UpdateModule, ArhivModule,
  Data.DB, GlobsAndConst, Vcl.Imaging.pngimage;

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
    N13: TMenuItem;
    CalculationSettings: TMenuItem;
    MenuCatalogs: TMenuItem;
    HRRReferenceData: TMenuItem;
    HRROwnData: TMenuItem;
    PanelCover: TPanel;
    N16: TMenuItem;
    OXRandOPRg: TMenuItem;
    HRRPrices: TMenuItem;
    HRRPricesReferenceData: TMenuItem;
    HRRPricesOwnData: TMenuItem;
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
    MenuListsSeparator: TMenuItem;
    N61: TMenuItem;
    N2: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Administator: TMenuItem;
    UpdatePanel: TPanel;
    Image1: TImage;
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
    procedure TariffsTransportationClick(Sender: TObject);
    procedure TariffsSalaryClick(Sender: TObject);
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

    procedure TimerCoverTimer(Sender: TObject);
    procedure ServiceSettingsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ActC6Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure OXRandOPRgClick(Sender: TObject);
    procedure CalculationSettingsClick(Sender: TObject);
    procedure NormalClick(Sender: TObject);
    procedure ReadSettingsFromFile(PathFile: String);
    procedure WriteSettingsToFile(PathFile: String);
    procedure FileSaveAsClick(Sender: TObject);
    procedure HRRReferenceDataClick(Sender: TObject);
    procedure HRROwnDataClick(Sender: TObject);
    procedure HRRPricesReferenceDataClick(Sender: TObject);
    procedure HRRPricesOwnDataClick(Sender: TObject);
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
    procedure N2Click(Sender: TObject);
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
  private
    CountOpenWindows: integer;
    ButtonsWindows: array [0 .. 11] of TSpeedButton;
    FUpdateThread: TUpdateThread; // Нить проверки обновлений
    SystemInfoResult: boolean;

    FCurVersion: TVersion; // текущая версия приложения и БД
    DebugMode: boolean; // Режим отладки приложения (блокирует некоторай функционал во время его отладки)

    FileReportPath: string; // путь к папке с отчетами(дабы не захламлять датамодуль лишними модулями)

    // Объект отвечает за создание бэкапов и их восстановление
    FArhiv: TBaseAppArhiv;

    procedure GetSystemInfo;
    procedure OnUpdate(var Mes: TMessage); message WM_SHOW_SPLASH;
    procedure ShowSplashForm;
    procedure ShowUpdateForm(const AResp: TServiceResponse);

    procedure ButtonClickEvent1(Sender: TObject);
    procedure ButtonClickEvent2(Sender: TObject);
    procedure FormShowEvent1(Sender: TObject);
    procedure FormShowEvent2(Sender: TObject);
  public
    procedure AutoWidthColumn(SG: TStringGrid; Nom: integer);
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

    ShowHint: boolean;
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
  FormNameMain = 'Расчёт сметы';
  FormNameCoefficientOrders = 'Коэффициент по приказам';
  FormNameCardOrganization = 'Карточка организации';
  FormNameCardCoefficients = 'Карточка коэффициентов';
  FormNameCardPartsEstimates = 'Карточка частей смет';
  FormNameCardSectionsEstimates = 'Карточка разделов смет';
  FormNameCardTypesWorks = 'Карточка видов работ';
  FormNameTypesActs = 'Типы актов';
  FormNameIndexesChangeCost = 'Индексы изменения стоимости';
  FormNameCardIndexesChangeCost = 'Карточка индексов изменения стоимости';
  FormNameCategoriesObjects = 'Категории объектов';
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

uses TariffsTransportanion, TariffsSalary, TariffsMechanism, TariffsDump,
  TariffsIndex, About, CalculationEstimate, ConnectDatabase, CardObject,
  DataModule, Login, Waiting, ActC6, WorkSchedule, HelpC3, HelpC5, CatalogSSR,
  OXRandOPR, DataTransfer, CardPTM, CalculationSettings,
  ProgramSettings, ObjectsAndEstimates, OwnData, ReferenceData, PricesOwnData,
  PricesReferenceData, AdditionData, PartsEstimates,
  Organizations, SectionsEstimates, TypesWorks, TypesActs, IndexesChangeCost,
  CategoriesObjects, KC6Journal, CalcResource, CalcTravel, UniDict, TravelList,
  Tools, fUpdate, EditExpression, dmReportU, Coef, WinterPrise;

{$R *.dfm}

// ---------------------------------------------------------------------------------------------------------------------
procedure TFormMain.ShowSplashForm;
begin
  UpdatePanel.Left := ClientWidth - UpdatePanel.Width;
  UpdatePanel.Top := PanelOpenWindows.Top - UpdatePanel.Height;
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

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FCurVersion.Clear;

  SystemInfoResult := False;

  CountOpenWindows := 0;

  Width := Screen.Width;
  Height := Screen.Height;

  FMEndTables := 'g';
  // Локальная установка разделителя
  FormatSettings.DecimalSeparator := '.';

  ReadSettingsFromFile(ExtractFilePath(Application.ExeName) + FileProgramSettings);

  // Объект для управления архивом
  FArhiv := TBaseAppArhiv.Create(ExtractFilePath(Application.ExeName), ExtractFilePath(Application.ExeName) +
    C_ARHDIR);

  // путь к папке с отчетами (Вадим)
{$IFDEF DEBUG}
  FileReportPath := Copy(ExtractFilePath(Application.ExeName), 1, Length(ExtractFilePath(Application.ExeName))
    - 12) + C_REPORTDIR;
{$ELSE}
  FileReportPath := ExtractFilePath(Application.ExeName) + C_REPORTDIR;
{$ENDIF}
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  DM.Connect.Connected := False;
  if Assigned(FUpdateThread) then
  begin // Выполнить Terminate обязательно так как он переопределен
    FUpdateThread.Terminate;
    FUpdateThread.WaitFor;
    FreeAndNil(FUpdateThread);
  end;
  FreeAndNil(FArhiv);
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
    end;
  except
    on e: exception do
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
    on e: exception do
      showmessage('Ошибка инициализации системы: ' + e.Message);
  end;

  // Запуск ниточки для мониторигра обновлений
  if SystemInfoResult and not DebugMode then
    FUpdateThread := TUpdateThread.Create(FCurVersion, Self.Handle)
  else
  begin
    if not SystemInfoResult then
      showmessage('Обновления недоступны.');
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
  PanelCover.Visible := true;
  try
    TmpForm := TForm(Sender);
    if TmpForm.WindowState = wsMinimized then
      TmpForm.WindowState := wsNormal;

    TmpForm.Show;
  finally
    PanelCover.Visible := False;
  end;
end;

procedure TFormMain.FormShowEvent1(Sender: TObject);
begin
  TForm(Sender).Show;
end;

procedure TFormMain.CreateButtonOpenWindow(const CaptionButton, HintButton: String; const AForm: TForm;
  AEventType: Byte = 0);
begin
  ButtonsWindows[CountOpenWindows] := TSpeedButton.Create(PanelOpenWindows);
  with ButtonsWindows[CountOpenWindows] do
  begin
    Parent := PanelOpenWindows;
    Align := alLeft;
    Width := 140;
    Height := 25;
    Top := 1;
    Caption := CaptionButton;
    GroupIndex := 1;
    Down := true;
    ShowHint := true;
    Hint := HintButton;

    if (AEventType = 1) then
      OnClick := ButtonClickEvent2
    else
      OnClick := ButtonClickEvent1;

    Tag := integer(AForm);
  end;

  Inc(CountOpenWindows);
end;

procedure TFormMain.DeleteButtonCloseWindow(const CaptionButton: String);
var
  i, Y: integer;
begin
  Y := -1;
  for i := 0 to CountOpenWindows - 1 do
    if Assigned(ButtonsWindows[Y]) and (ButtonsWindows[i].Caption = CaptionButton) then
    begin
      Y := i;
      Break;
    end;

  if (Y = -1) then // Нет кнопки с таким названием
    Exit;

  if Assigned(PanelOpenWindows) then
  begin
    ButtonsWindows[Y].Free;
    ButtonsWindows[Y] := nil;
  end;

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
        showmessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_WINTER_RS_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.GetIdEstimate = 0 then
        begin
          showmessage('Не выбрана смета');
          Exit;
        end;
        dmReportF.Report_WINTER_RS_OBJ(FormCalculationEstimate.GetIdEstimate, FileReportPath);
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

procedure TFormMain.TariffsSalaryClick(Sender: TObject);
begin
  if (not Assigned(FormTariffsSalary)) then
    FormTariffsSalary := TFormTariffsSalary.Create(Self);

  // Получаем данные из БД в таблицу
  // FormTariffsSalary.ReceivingData(nil);

  // -----------------------------------------

  FormTariffsSalary.Show;
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

procedure TFormMain.N2Click(Sender: TObject);
begin
  if (not Assigned(fCalcResource)) then
    fCalcResource := TfCalcResource.Create(Self);
  if Assigned(FormObjectsAndEstimates) then
    fCalcResource.LocateObject(FormObjectsAndEstimates.getCurObject);
  fCalcResource.Show;
end;

// Расход материалов по акту
procedure TFormMain.mnRASX_ACTClick(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.qrActsEx.IsEmpty then
      begin
        showmessage('Не выбран акт');
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
begin
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        showmessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_SMETA_OBJ_BUILD(FormObjectsAndEstimates.IdEstimate, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.GetIdEstimate = 0 then
        begin
          showmessage('Не выбрана смета');
          Exit;
        end;
        dmReportF.Report_SMETA_OBJ_BUILD(FormCalculationEstimate.GetIdEstimate, FileReportPath);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;
// <-- "СМЕТА по объекту строительства" v.1.03

procedure TFormMain.vk3Click(Sender: TObject);
begin

  // dmReportF.Report_WINTER_RS_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
  Screen.Cursor := crSQLWait;
  try
    if Assigned(FormObjectsAndEstimates) then
    begin
      if FormObjectsAndEstimates.IdEstimate = 0 then
      begin
        showmessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_RSMO_OBJ(0, FormObjectsAndEstimates.IdEstimate, 0, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.GetIdEstimate = 0 then
        begin
          showmessage('Не выбрана смета');
          Exit;
        end;

        dmReportF.Report_RSMO_OBJ(0, 0, FormCalculationEstimate.GetIdObject, FileReportPath);
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
        showmessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_RSMO_OBJ(1, FormObjectsAndEstimates.IdEstimate, 0, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.GetIdEstimate = 0 then
        begin
          showmessage('Не выбрана смета');
          Exit;
        end;

        dmReportF.Report_RSMO_OBJ(1, 0, FormCalculationEstimate.GetIdObject, FileReportPath);
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
        showmessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_RSMEH_OBJ(0, FormObjectsAndEstimates.IdEstimate, 0, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.GetIdEstimate = 0 then
        begin
          showmessage('Не выбрана смета');
          Exit;
        end;

        dmReportF.Report_RSMEH_OBJ(0, 0, FormCalculationEstimate.GetIdObject, FileReportPath);
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
      if FormCalculationEstimate.GetIdEstimate = 0 then
      begin
        showmessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_VED_OANDPWV1_OBJ(1, 0, FormCalculationEstimate.GetIdObject, FileReportPath);
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
        showmessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_VED_OBRAB_RASHRES_SMET_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.GetIdEstimate = 0 then
        begin
          showmessage('Не выбрана смета');
          Exit;
        end;
        dmReportF.Report_VED_OBRAB_RASHRES_SMET_OBJ(FormCalculationEstimate.GetIdObject, FileReportPath);
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
      if FormCalculationEstimate.GetIdEstimate = 0 then
      begin
        showmessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_VED_OANDPWV1_OBJ(2, 0, FormCalculationEstimate.GetIdObject, FileReportPath);
    end;

  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMain.N12Click(Sender: TObject);
begin
  fWinterPrice.Show;
end;

procedure TFormMain.N13Click(Sender: TObject);
begin
  FormCardPTM.Show;
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
  if (not Assigned(fKC6Journal)) then
    fKC6Journal := TfKC6Journal.Create(Self);
  if Assigned(FormObjectsAndEstimates) then
    fKC6Journal.LocateObject(FormObjectsAndEstimates.getCurObject);
  fKC6Journal.Show;
end;

procedure TFormMain.N6Click(Sender: TObject);
begin
  if (not Assigned(fTravelList)) then
    fTravelList := TfTravelList.Create(Self);
  if Assigned(FormObjectsAndEstimates) then
    fTravelList.LocateObject(FormObjectsAndEstimates.getCurObject);
  fTravelList.Show;
end;

procedure TFormMain.N8Click(Sender: TObject);
var
  s: string;
begin
  s := InputBox('Справочник ежемесячных величин', 'Укажите пароль:', '');
  if s <> '1' then
    Exit;

  if (not Assigned(fUniDict)) then
    fUniDict := TfUniDict.Create(Self);
  fUniDict.Show;
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
        showmessage('Не выбрана смета');
        Exit;
      end;
      dmReportF.Report_ZP_OBJ(FormObjectsAndEstimates.IdEstimate, FileReportPath);
    end
    else
    begin
      if Assigned(FormCalculationEstimate) then
      begin
        if FormCalculationEstimate.GetIdEstimate = 0 then
        begin
          showmessage('Не выбрана смета');
          Exit;
        end;
        dmReportF.Report_ZP_OBJ(FormCalculationEstimate.GetIdEstimate, FileReportPath);
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
        showmessage('Не выбран акт');
        Exit;
      end;
      dmReportF.Report_ZP_OBJ_ACT(FormObjectsAndEstimates.qrActsEx.FieldByName('ID').AsInteger,
        FileReportPath);
    end;
  finally
    Screen.Cursor := crDefault;
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
  if (not Assigned(FormSectionsEstimates)) then
    FormSectionsEstimates := TFormSectionsEstimates.Create(FormMain)
  else
    FormSectionsEstimates.Show;
end;

procedure TFormMain.MenuListsTypesWorksClick(Sender: TObject);
begin
  if (not Assigned(FormTypesWorks)) then
    FormTypesWorks := TFormTypesWorks.Create(FormMain)
  else
    FormTypesWorks.Show;
end;

procedure TFormMain.MenuOrganizationsClick(Sender: TObject);
begin
  if (not Assigned(FormOrganizations)) then
    FormOrganizations := TFormOrganizations.Create(FormMain)
  else
    FormOrganizations.Show;
end;

procedure TFormMain.HRRReferenceDataClick(Sender: TObject);
begin
  if (not Assigned(FormReferenceData)) then
    FormReferenceData := TFormReferenceData.Create(Self, 'g', False);
end;

procedure TFormMain.HRROwnDataClick(Sender: TObject);
begin
  if (not Assigned(FormOwnData)) then
    FormOwnData := TFormOwnData.Create(Self, 's', False);
end;

procedure TFormMain.HRRPricesReferenceDataClick(Sender: TObject);
begin
  if (not Assigned(FormPricesReferenceData)) then
    FormPricesReferenceData := TFormPricesReferenceData.Create(Self, 'g', true);
end;

procedure TFormMain.HRRPricesOwnDataClick(Sender: TObject);
begin
  if (not Assigned(FormPricesOwnData)) then
    FormPricesOwnData := TFormPricesOwnData.Create(Self, 's', true);
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
  if (MessageBox(Self.Handle, PChar('Создать резервную копию?'), 'Резервное копирование',
    MB_YESNO + MB_ICONQUESTION) = IDYES) then
  begin
    FormMain.PanelCover.Visible := true;
    FormWaiting.Show;
    Application.ProcessMessages;
    try
      // Максимуи C_ARHCOUNT копии, что-бы не забивать место
      for i := C_ARHCOUNT - 1 to High(FArhiv.ArhFiles) do
        FArhiv.DeleteArhiv(FArhiv.ArhFiles[i]);
      FArhiv.CreateNewArhiv;
    finally
      FormWaiting.Close;
      FormMain.PanelCover.Visible := False;
    end;
  end;
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
begin
  Mi := TMenuItem(Sender);
  if (MessageBox(Self.Handle, PChar('Восстановить из резервной копии от ' + StringReplace(Mi.Parent.Caption,
    '&', '', [rfReplaceAll]) + '?' + #13#10 +
    'Внимание, все данные внесенные после создания данной копии, будут утеряны!'), 'Резервное копирование',
    MB_YESNO + MB_ICONQUESTION) = IDYES) then
  begin
    FormMain.PanelCover.Visible := true;
    FormWaiting.Show;
    Application.ProcessMessages;
    try
      FArhiv.RestoreArhiv(string(Mi.Parent.Tag));
      Close;
    except
      FormWaiting.Close;
      FormMain.PanelCover.Visible := False;
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

procedure TFormMain.FileCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.FileSaveAsClick(Sender: TObject);
begin
  // FormCalculationEstimate.CopyEstimate;
end;

procedure TFormMain.CalculationSettingsClick(Sender: TObject);
begin
  FormCalculationSettings.Show;
end;

procedure TFormMain.FormActivate(Sender: TObject);
begin
  // FormLogin.ShowModal;
end;

procedure TFormMain.HelpAboutClick(Sender: TObject);
var
  FormAbout: TFormAbout;
begin
  FormAbout := TFormAbout.Create(nil);
  try
    FormAbout.ShowModal;
  finally
    FreeAndNil(FormAbout);
  end;
end;

function ShiftDown: boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[vk_Shift] and 128) <> 0);
end;

function CtrlDown: boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[vk_Control] and 128) <> 0);
end;

function AltDown: boolean;
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

procedure TFormMain.AutoWidthColumn(SG: TStringGrid; Nom: integer);
var
  i: integer;
  CalcWidth: integer;
  ColNotVisible: integer;
begin
  ColNotVisible := 0;

  with SG do
  begin
    CalcWidth := Width;

    for i := 0 to ColCount - 1 do
    begin
      if (i <> Nom) and (ColWidths[i] <> -1) then
        CalcWidth := CalcWidth - ColWidths[i];
      if ColWidths[i] = -1 then
        Inc(ColNotVisible);
    end;

    CalcWidth := CalcWidth - 5;

    if VisibleRowCount < (RowCount - 1) then
      CalcWidth := CalcWidth - GetSystemMetrics(SM_CXVSCROLL) - 1;

    CalcWidth := CalcWidth - (ColCount - ColNotVisible - 1);

    ColWidths[Nom] := CalcWidth;
  end;
end;

end.
