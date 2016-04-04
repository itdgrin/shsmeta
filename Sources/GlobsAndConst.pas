unit GlobsAndConst;

interface
uses Winapi.Messages, Winapi.Windows;

type
  TAppElement = record
    EName: string;
    EType: Byte;  //0 - файл, 1 - папка (содержимое не описывается)
  end;

  //Контейнер для работы с буфером обмена
  TSmClipRec = record
    ObjID,
    SmID,
    DataID,
    DataType: Integer;
    RateType: Integer; //Расценка или пусконаладка(флаг для легкой обработки SubType сметы)
  end;

  PSmClipRec = ^TSmClipRec;

  //Типы контейнеров для отчета ССР
  TKoefRec = record
    LineNom: string;
    Pers: Variant;
    Koef1: Variant;
    Koef2: Variant;
    SprID: Variant;
  end;
  TKoefArray = array of TKoefRec;

  TRepSSRLine = record
    ZP,
    ZP5,
    EMiM,
    ZPMash,
    Mat,
    MatTransp,
    OXROPR,
    PlanPrib,
    Devices,
    Transp,
    Other,
    Total,
    Trud: Double;
    procedure CalcTotal;
    procedure Summ(ARepSSRLine: TRepSSRLine);
  end;

const
//******************************************************************************
// константы общего назначения
  //Константа для временных папок на все случаи
  C_TMPDIR = 'Tmp\';
  //Папке с архивом
  C_ARHDIR = 'Arhiv\';
  //Папке с отчетами
  C_REPORTDIR = 'Reports\';
  //Папка с логами
  C_LOGDIR = 'Logs\';
  //Папка с лицензией
  C_LICENSEDIR = 'Lisence\';
  C_LICENSEKEY = 'Lisence';
  C_LICENSEFILE = 'Lisence.key';
  //Папка с обновлениями
  C_UPDATEDIR = 'Updates\';
  C_UPDMIRRORTMP = 'MirrorTmp\';
  //Название софтины для перезаписи приложения (апдейтер)
  C_UPDATERNAME = 'SmUpd.exe';

  arraymes: array[1..12, 1..2] of string =
    (('Январь',   'Января'),
    ('Февраль',  'Февраля'),
    ('Март',     'Марта'),
    ('Апрель',   'Апреля'),
    ('Май',      'Мая'),
    ('Июнь',     'Июня'),
    ('Июль',     'Июля'),
    ('Август',   'Августа'),
    ('Сентябрь', 'Сентября'),
    ('Октябрь',  'Октября'),
    ('Ноябрь',   'Ноября'),
    ('Декабрь',  'Декабря'));

  //Тип данных для буфера обмена
  C_SMETADATA = 'CF_SMETA';

  //Итераторы (сортировка в левой таблице) для ET18, ET20
  C_ET18ITER = 2000000000;
  C_ET20ITER = 2000000001;

  //типы ID для функции GetNewID
  C_ID_OBJ     = 1;  //1 - объект
  C_ID_SM      = 2;  //2 - смета
  C_ID_SMRAT   = 3;  //3 - смета расценка
  C_ID_SMMAT   = 4;  //4 - смета материал
  C_ID_SMMEC   = 5;  //5 - смета механизм
  C_ID_SMDEV   = 6;  //6 - смета оборудование
  C_ID_SMDUM   = 7;  //7 - смета свалки
  C_ID_SMTR    = 8;  //8 - смета транспорт
  C_ID_DATA    = 9;  //9 - смета data_row
  C_ID_SMCOEF  = 10; //10 - смета calculation_coef
  //C_ID_ACT     = 11; //11 - акт  ------------устарело
  C_ID_TRAVEL  = 12; //12 - Расчет командировочных  //Можно вернуть автоинкримент
  C_ID_TRWORK  = 13; //13 - Расчет разъездных работ  //Можно вернуть автоинкримент
  C_ID_WORKDEP = 14; //14 - Расчет перевозки рабочих  //Можно вернуть автоинкримент
  C_ID_SUPPAG  = 15; //15 - Дополнительные соглашения  //Можно вернуть автоинкримент
  C_ID_DOC     = 16; //16 - Хранилище документов

  //типы ID для функции GetNewManualID
  C_MANID_UNIT       = 1;
  C_MANID_MAT        = 2;
  C_MANID_MECH       = 3;
  C_MANID_DEV        = 4;
  C_MANID_NORM       = 5;
  C_MANID_NORM_MAT   = 6;
  C_MANID_NORM_MECH  = 7;
  C_MANID_NORM_WORK  = 8;

  CTabNameAndID: array [1..15, 0..1] of string =
    (('objcards', 'obj_id'),
    ('smetasourcedata', 'SM_ID'),
    ('card_rate', 'ID'),
    ('materialcard', 'ID'),
    ('mechanizmcard', 'ID'),
    ('devicescard', 'ID'),
    ('dumpcard', 'ID'),
    ('transpcard', 'ID'),
    ('data_row', 'ID'),
    ('calculation_coef', 'calculation_coef_id'),
    ('card_acts', 'ID'),
    ('travel', 'travel_id'),
    ('travel_work', 'travel_work_id'),
    ('worker_deartment', 'worker_department_id'),
    ('supp_agreement', 'supp_agreement_id'));

  CManTabNameAndID: array [1..8, 0..1] of string =
    (('normativg', 'NORMATIV_ID'),
    ('materialnorm', 'ID'),
    ('mechanizmnorm', 'ID'),
    ('normativwork', 'ID'),
    ('material', 'MATERIAL_ID'),
    ('mechanizm', 'MECHANIZM_ID'),
    ('devices', 'DEVICE_ID'),
    ('units', 'UNIT_ID'));

  С_MANIDDELIMETER = 1000000000; //Разделитель ID для собственных данных в справочниках.

type
  TIDConvertArray = array [1..15, 0..1] of array of Integer;
  TManIDConvertArray = array [1..8, 0..1] of array of Integer;
//******************************************************************************

//******************************************************************************
// константы необходимые для работа системы резервного копирования
const
//Константы для отображения полей БД
  C_NUMMASK = '###,##0.######';
  C_DISPFORMAT = '###,##0.######';
  C_EDITFORMAT = '#####0.######';
//******************************************************************************
//  константы необходимые для работа системы обновления
  С_UPD_NAME = 'Update';
  //Интервал времени через который происходит опрос сервака
  C_GETVERSINTERVAL = 1200000;
  //Сообщение отсылаемое главному окну по завершению проверки обновлений
  WM_SHOW_SPLASH = WM_USER + 1;
  //Адрес сервера обновления
  C_UPDATESERV = 'http://85.143.218.164:3113';
  //Адрес почты техподдержки
  C_SUPPORTMAIL = 'd_grin@mail.ru';
  //Настройки файла лагирования
  C_UPDATELOG = 'update.log';
  C_UPD_MIRRORNAME = 'AppVersion%0:d.zip';
  C_UPD_MIRRORMASK = 'AppVersion*.zip';
  C_UPD_MIRRORPAT1 = 'AppVersion';
  C_UPD_MIRRORPAT2 = '.zip';

  C_REGROOT = HKEY_CURRENT_USER;
  C_REGKEY = 'SOFTWARE\Smeta';
//******************************************************************************

  //Имена папок внутри архива
  C_ARHBASEDIR = 'Base\';
  C_ARHAPPDIR = 'App\';

  //Батники должны лежать в папке с архивом
  C_BASETODUMP = 'To_Dump_all_database.bat';
  C_DUMPTOBASE = 'From_Dump_all_database.bat';
  //Имя дампа должно соответствовать имени прописаному в батнике
  C_DUMPNAME = 'all_database.sql';

  //Массив содержит состав приложения который будет
  //использоваться для резервного копирования
  //Любый добавления в приложении которые необходимо
  //резервировать должны быть в него внесены
  С_APPSTRUCT: array [0..11] of TAppElement =
    ((EName: 'SMR-HPP2012.exe'; EType: 0),
     (EName: 'SMR-HPP2012.ini'; EType: 0),
     (EName: С_UPD_NAME + '.ini'; EType: 0),
     (EName: 'libmysql.dll'; EType: 0),
     (EName: C_UPDATERNAME; EType: 0),
     (EName: C_ARHDIR + '\' + C_BASETODUMP; EType: 0),
     (EName: C_ARHDIR + '\' + C_DUMPTOBASE; EType: 0),
     (EName: 'sql'; EType: 1),
     (EName: 'settings'; EType: 1),
     (EName: 'reports'; EType: 1),
     (EName: 'xls'; EType: 1),
     (EName: 'docs'; EType: 1));

  //Допустимое кол-во архивов
  C_ARHCOUNT = 5;
//******************************************************************************

//******************************************************************************
//  константы управления апдейтером
  C_UPD_UPDATE = '-u'; //Обновление
  C_UPD_RESTOR = '-r'; //Восспановление из архива
  C_UPD_PATH = '-path'; //Путь к папке с обновлениями (копией)
  C_UPD_VERS = '-v'; //Новая версия программы
  C_UPD_START = '-s'; //Необходимо запустить смету после отработки апдейтера
  C_UPD_APP = '-a'; //Имя запускаемого приложения
//******************************************************************************

//******************************************************************************
//  Уведомление окна о выполнении запроса
  WM_EXCECUTE = WM_USER + 2;
  WM_EXCEPTION = WM_USER + 3;
  WM_SPRLOAD = WM_USER + 4;
  WM_PRICELOAD = WM_USER + 5;
  //Управление прогрессом создания архива
  WM_ARCHIVEPROGRESS = WM_USER + 6;
  WM_UPDATEFORMSTYLE = WM_USER + 7;
  //обновление хода обновления
  WM_UPDATESTATE = WM_USER + 8;
  WM_UPDATEPROGRESS = WM_USER + 9;
  //Уведомление о проверки лицензии
  WM_CHECKLICENCE = WM_USER + 10;

//******************************************************************************

//******************************************************************************
//  Константы ID документов
  C_DOCID_MAIS450 = 7;
  C_DOCID_TRANSP_XLT = 8;
//******************************************************************************

var
//******************************************************************************
  //Глобальные переменные обеспечивающие выполнение обновлений
  //Флаг необходимости запустить апдейтер по завершению программы
  // 1 - обновление, 2 - восстановление из резервной копии
  G_STARTUPDATER: Byte = 0;

  G_UPDPATH: string = ''; //Путь к папке с обновлениями или резервной копией приложения
  G_NEWAPPVERS: Integer = 0; //Новая версия приложения
  G_STARTAPP: Boolean = False; //Запускать приложение после обновления

  G_CONNECTSTR: string = 'DriverID=MySQL' + sLineBreak +
                         'User_name=root' + sLineBreak +
                         'Password=serg' + sLineBreak +
                         'SERVER=xxx' + sLineBreak +
                         'DATABASE=smeta' + sLineBreak +
                         'CharacterSet=cp1251' + sLineBreak +
                         'TinyIntFormat=Integer';
//******************************************************************************

//******************************************************************************
  //Используемые расчетные формулы
  G_CALCMODE: Byte = 0;   //0 - Новый (точный) вариант расчета; 1 - старый (не точный), как в старой программе
  //Используемый вариант отображения таблиц
  G_SHOWMODE: Byte = 1;  //0 - С разделением на заменяющие и добавленные
  //Результат RegisterClipboardFormat()
  G_SMETADATA: Integer;
  //ID текущего пользователя
  G_USER_ID: Integer = 0;
  //Переменные для увязки периодов справочников
  G_CURYEAR,
  G_CURMONTH: Integer;
  //Значение НДС принимаемое по умолчанию в программе
  G_NDS: Double = 20;
  //Имя текущего файла лицензии
  G_CURLISENSE: string = '';

implementation

{ TRepSSRLine }

procedure TRepSSRLine.CalcTotal;
begin
  Total := ZP + EMiM + Mat + MatTransp + OXROPR +
    PlanPrib + Devices + Transp + Other;
end;

procedure TRepSSRLine.Summ(ARepSSRLine: TRepSSRLine);
begin
  ZP := ZP + ARepSSRLine.ZP;
  ZP5 := ZP5 + ARepSSRLine.ZP5;
  EMiM := EMiM + ARepSSRLine.EMiM;
  ZPMash := ZPMash + ARepSSRLine.ZPMash;
  Mat := Mat + ARepSSRLine.Mat;
  MatTransp := MatTransp + ARepSSRLine.MatTransp;
  OXROPR := OXROPR + ARepSSRLine.OXROPR;
  PlanPrib := PlanPrib + ARepSSRLine.PlanPrib;
  Devices := Devices + ARepSSRLine.Devices;
  Transp := Transp + ARepSSRLine.Transp;
  Other := Other + ARepSSRLine.Other;
  Total := Total + ARepSSRLine.Total;
  Trud := Trud + ARepSSRLine.Trud;
end;

end.
