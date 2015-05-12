unit GlobsAndConst;

interface
uses Winapi.Messages;

type
  TAppElement = record
    EName: string;
    EType: Byte;  //0 - файл, 1 - папка (содержимое не описывается)
  end;

  //Запись для справочников материалов и механизмов
  TSprRecord = record
    ID: Integer;
    Code,
    Name,
    Unt: string;
    CoastNDS,
    CoastNoNDS: Extended;
    MType: byte;
  end;
  PSprRecord = ^TSprRecord;
  TSprArray = array of TSprRecord;

  //Контейнер
  TSmClipRec = packed record
    ObjID,
    SmID,
    DataID,
    DataType: Integer;
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
  //Папка с обновлениями
  C_UPDATEDIR = 'Updates\';
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

  CTabNameAndID: array [0..17, 0..1] of string =
    (('objcards', 'obj_id'),
    ('smetasourcedata', 'SM_ID'),
    ('card_rate', 'ID'),
    ('materialcard', 'ID'),
    ('mechanizmcard', 'ID'),
    ('devicescard', 'ID'),
    ('dumpcard', 'ID'),
    ('transpcard', 'ID'),
    ('data_estimate', 'ID'),
    ('card_acts', 'ID'),
    ('card_rate_act', 'ID'),
    ('materialcard_act', 'ID'),
    ('mechanizmcard_act', 'ID'),
    ('devicescard_act', 'ID'),
    ('dumpcard_act', 'ID'),
    ('transpcard_act', 'ID'),
    ('data_act', 'ID'),
    ('calculation_coef', 'calculation_coef_id'));

type
  TIDConvertArray = array [0..17, 0..1] of array of Integer;
//******************************************************************************

//******************************************************************************
// константы необходимые для работа системы резервного копирования
const
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
  С_APPSTRUCT: array [0..8] of TAppElement =
    ((EName: 'smeta.exe'; EType: 0),
     (EName: 'smeta.ini'; EType: 0),
     (EName: 'libmysql.dll'; EType: 0),
     (EName: C_UPDATERNAME; EType: 0),
     (EName: C_ARHDIR + '\' + C_BASETODUMP; EType: 0),
     (EName: C_ARHDIR + '\' + C_DUMPTOBASE; EType: 0),
     (EName: 'sql'; EType: 1),
     (EName: 'settings'; EType: 1),
     (EName: 'reports'; EType: 1));
  //Допустимое кол-во архивов
  C_ARHCOUNT = 3;
//******************************************************************************

//******************************************************************************
//  константы необходимые для работа системы обновления
  //Интервал времени через который происходит опрос сервака
  C_GETVERSINTERVAL = 1200000;
  //Сообщение отсылаемое главному окну по завершению проверки обновлений
  WM_SHOW_SPLASH = WM_USER + 1;
  //Адрес сервера обновления
  C_UPDATESERV = 'http://31.130.201.132:3000';
  //Адрес почты техподдержки
  C_SUPPORTMAIL = 'd_grin@mail.ru';
  //Настройки файла лагирования
  C_UPDATELOG = 'update.log';
//******************************************************************************

//******************************************************************************
//  константы управления апдейтером
  C_UPD_UPDATE = '-u'; //Обновление
  C_UPD_RESTOR = '-r'; //Восспановление из архива
  C_UPD_PATH = '-path'; //Путь к папке с обновлениями (копией)
  C_UPD_VERS = '-v'; //Новая версия программы
  C_UPD_START = '-s'; //Необходимо запустить смету после отработки апдейтера
//******************************************************************************

//******************************************************************************
//  Уведомление окна о выполнении запроса
  WM_EXCECUTE = WM_USER + 2;
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
                         'SERVER=localhost' + sLineBreak +
                         'DATABASE=smeta' + sLineBreak +
                         'CharacterSet=cp1251' + sLineBreak +
                         'TinyIntFormat=Integer';
//******************************************************************************

//******************************************************************************
  //Используемые расчетные формулы
  G_CALCMODE: Byte = 1;   //0 - Старый (точный) вариант расчета
  //Используемый вариант отображения таблиц
  G_SHOWMODE: Byte = 1;  //0 - С разделением на заменяющие и добавленные
  //Результат RegisterClipboardFormat()
  G_SMETADATA: Integer;

implementation

end.
