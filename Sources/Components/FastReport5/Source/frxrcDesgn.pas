{******************************************}
{                                          }
{             FastReport v4.0              }
{          Language resource file          }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxrcDesgn;

interface

implementation

uses frxRes;

const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1251"><StrRes Name="2000" Text="Инспектор"/><StrRes Name="oiProp" Text="Свойс' + 
'тва"/><StrRes Name="oiEvent" Text="События"/><StrRes Name="2100" Text="Дерево данных"/><StrRes Name="2101" Text="Поля БД"/' + 
'><StrRes Name="2102" Text="Переменные"/><StrRes Name="2103" Text="Функции"/><StrRes Name="2104" Text="Вставлять поле"/><' + 
'StrRes Name="2105" Text="Вставлять заголовок"/><StrRes Name="2106" Text="Классы"/><StrRes Name="dtNoData" Text="Нет дан�' + 
'�ых."/><StrRes Name="dtNoData1" Text="Зайдите в меню &#38;#34;Отчет|Данные...&#38;#34;, чтобы добавить суще�' + 
'�твующие наборы данных в отчет, или переключитесь на закладку &#38;#34;Данные&#38;#34; и с�' + 
'�здайте новые наборы данных."/><StrRes Name="dtData" Text="Данные"/><StrRes Name="dtSysVar" Text="Системные"/><S' + 
'trRes Name="dtVar" Text="Переменные"/><StrRes Name="dtFunc" Text="Функции"/><StrRes Name="2200" Text="Дерево отчета"/><St' + 
'rRes Name="2300" Text="Открыть скрипт"/><StrRes Name="2301" Text="Сохранить скрипт"/><StrRes Name="2302" Text="Запус�' + 
'�ить отчет"/><StrRes Name="2303" Text="Отладка"/><StrRes Name="2304" Text="Остановить"/><StrRes Name="2305" Text="Вычис�' + 
'�ить"/><StrRes Name="2306" Text="Язык:"/><StrRes Name="2307" Text="Выравнивание"/><StrRes Name="2308" Text="Выровнять ле' + 
'вые края"/><StrRes Name="2309" Text="Центрировать по горизонтали"/><StrRes Name="2310" Text="Выровнять пра' + 
'вые края"/><StrRes Name="2311" Text="Выровнять верхние края"/><StrRes Name="2312" Text="Центрировать по го�' + 
'�изонтали"/><StrRes Name="2313" Text="Выровнять нижние края"/><StrRes Name="2314" Text="Расположить равном' + 
'ерно по ширине"/><StrRes Name="2315" Text="Расположить равномерно по высоте"/><StrRes Name="2316" Text="Це�' + 
'�трировать по горизонтали на бэнде"/><StrRes Name="2317" Text="Центрировать по вертикали на бэ' + 
'нде"/><StrRes Name="2318" Text="Та же ширина"/><StrRes Name="2319" Text="Та же высота"/><StrRes Name="2320" Text="Текст"/>' + 
'<StrRes Name="2321" Text="Стиль"/><StrRes Name="2322" Text="Имя шрифта"/><StrRes Name="2323" Text="Размер шрифта"/><StrRes N' + 
'ame="2324" Text="Полужирный"/><StrRes Name="2325" Text="Курсив"/><StrRes Name="2326" Text="Подчеркивание"/><StrRes Name="' + 
'2327" Text="Цвет шрифта"/><StrRes Name="2328" Text="Условное выделение"/><StrRes Name="2329" Text="Поворот текс�' + 
'�а"/><StrRes Name="2330" Text="Выровнять текст влево"/><StrRes Name="2331" Text="Центрировать текст по гори' + 
'зонтали"/><StrRes Name="2332" Text="Выровнять текст вправо"/><StrRes Name="2333" Text="Выровнять текст по �' + 
'�ирине"/><StrRes Name="2334" Text="Выровнять по верхнему краю"/><StrRes Name="2335" Text="Центрировать тек�' + 
'�т по вертикали"/><StrRes Name="2336" Text="Выровнять по нижнему краю"/><StrRes Name="2337" Text="Рамка"/><StrR' + 
'es Name="2338" Text="Верхняя линия"/><StrRes Name="2339" Text="Нижняя линия"/><StrRes Name="2340" Text="Левая линия"/' + 
'><StrRes Name="2341" Text="Правая линия"/><StrRes Name="2342" Text="Все линии рамки"/><StrRes Name="2343" Text="Убрать �' + 
'�амку"/><StrRes Name="2344" Text="Редактировать рамку"/><StrRes Name="2345" Text="Цвет заливки"/><StrRes Name="2346" ' + 
'Text="Цвет рамки"/><StrRes Name="2347" Text="Стиль рамки"/><StrRes Name="2348" Text="Толщина рамки"/><StrRes Name="2349' + 
'" Text="Стандартная"/><StrRes Name="2350" Text="Новый отчет"/><StrRes Name="2351" Text="Открыть"/><StrRes Name="2352" Text' + 
'="Сохранить"/><StrRes Name="2353" Text="Предварительный просмотр"/><StrRes Name="2354" Text="Добавить стра' + 
'ницу в отчет"/><StrRes Name="2355" Text="Добавить форму в отчет"/><StrRes Name="2356" Text="Удалить страниц' + 
'у"/><StrRes Name="2357" Text="Настройки страницы"/><StrRes Name="2358" Text="Переменные"/><StrRes Name="2359" Text="Выр' + 
'езать"/><StrRes Name="2360" Text="Копировать"/><StrRes Name="2361" Text="Вставить"/><StrRes Name="2362" Text="Копирова�' + 
'�ь формат"/><StrRes Name="2363" Text="Отменить"/><StrRes Name="2364" Text="Повторить"/><StrRes Name="2365" Text="Сгрупп�' + 
'�ровать"/><StrRes Name="2366" Text="Разгруппировать"/><StrRes Name="2367" Text="Показывать сетку"/><StrRes Name="2' + 
'368" Text="Выравнивание по сетке"/><StrRes Name="2369" Text="Расположить объекты в узлах сетки"/><StrR' + 
'es Name="2370" Text="Масштаб"/><StrRes Name="2371" Text="Мастера"/><StrRes Name="2372" Text="Выбор объектов"/><StrRes Name=' + 
'"2373" Text="Рука"/><StrRes Name="2374" Text="Лупа"/><StrRes Name="2375" Text="Редактор текста"/><StrRes Name="2376" Text="Ко�' + 
'�ирование внешнего вида"/><StrRes Name="2377" Text="Вставить бэнд"/><StrRes Name="2378" Text="&amp;Файл"/><StrRes ' + 
'Name="2379" Text="&amp;Правка"/><StrRes Name="2380" Text="Найти..."/><StrRes Name="2381" Text="Найти далее"/><StrRes Name="2382" ' + 
'Text="Заменить..."/><StrRes Name="2383" Text="&amp;Отчет"/><StrRes Name="2384" Text="Данные..."/><StrRes Name="2385" Text="Наст' + 
'ройки..."/><StrRes Name="2386" Text="Стили..."/><StrRes Name="2387" Text="&amp;Вид"/><StrRes Name="2388" Text="Панели инстру�' + 
'�ентов"/><StrRes Name="2389" Text="Стандартная"/><StrRes Name="2390" Text="Текст"/><StrRes Name="2391" Text="Рамка"/><StrRes' + 
' Name="2392" Text="Выравнивание"/><StrRes Name="2393" Text="Мастера"/><StrRes Name="2394" Text="Инспектор"/><StrRes Name="' + 
'2395" Text="Дерево данных"/><StrRes Name="2396" Text="Дерево отчета"/><StrRes Name="2397" Text="Линейки"/><StrRes Name=' + 
'"2398" Text="Выносные линии"/><StrRes Name="2399" Text="Удалить выносные линии"/><StrRes Name="2400" Text="Настр' + 
'ойки..."/><StrRes Name="2401" Text="&amp;?"/><StrRes Name="2402" Text="Справка..."/><StrRes Name="2403" Text="О FastReport..."/><StrRes Na' + 
'me="2404" Text="Редактор TabOrder..."/><StrRes Name="2405" Text="Отменить"/><StrRes Name="2406" Text="Повторить"/><StrRes Nam' + 
'e="2407" Text="Вырезать"/><StrRes Name="2408" Text="Копировать"/><StrRes Name="2409" Text="Вставить"/><StrRes Name="2410" Te' + 
'xt="Сгруппировать"/><StrRes Name="2411" Text="Разгруппировать"/><StrRes Name="2412" Text="Удалить"/><StrRes Name="2' + 
'413" Text="Удалить страницу"/><StrRes Name="2414" Text="Выбрать все"/><StrRes Name="2415" Text="Редактировать...' + 
'"/><StrRes Name="2416" Text="На передний план"/><StrRes Name="2417" Text="На задний план"/><StrRes Name="2418" Text="Нов�' + 
'�й..."/><StrRes Name="2419" Text="Новый отчет"/><StrRes Name="2420" Text="Новая страница"/><StrRes Name="2421" Text="Нова�' + 
'� форма"/><StrRes Name="2422" Text="Открыть..."/><StrRes Name="2423" Text="Сохранить"/><StrRes Name="2424" Text="Сохранит' + 
'ь как..."/><StrRes Name="2425" Text="Переменные..."/><StrRes Name="2426" Text="Настройки страницы..."/><StrRes Name="24' + 
'27" Text="Просмотр"/><StrRes Name="2428" Text="Выход"/><StrRes Name="2429" Text="Заголовок отчета"/><StrRes Name="2430" Te' + 
'xt="Подвал отчета"/><StrRes Name="2431" Text="Заголовок страницы"/><StrRes Name="2432" Text="Подвал страниц�' + 
'�"/><StrRes Name="2433" Text="Заголовок данных"/><StrRes Name="2434" Text="Подвал данных"/><StrRes Name="2435" Text="Дан' + 
'ные 1 уровня"/><StrRes Name="2436" Text="Данные 2 уровня"/><StrRes Name="2437" Text="Данные 3 уровня"/><StrRes Name="' + 
'2438" Text="Данные 4 уровня"/><StrRes Name="2439" Text="Данные 5 уровня"/><StrRes Name="2440" Text="Данные 6 уровн�' + 
'�"/><StrRes Name="2441" Text="Заголовок группы"/><StrRes Name="2442" Text="Подвал группы"/><StrRes Name="2443" Text="Доч' + 
'ерний бэнд"/><StrRes Name="2444" Text="Заголовок колонки"/><StrRes Name="2445" Text="Подвал колонки"/><StrRes Na' + 
'me="2446" Text="Фоновый бэнд"/><StrRes Name="2447" Text="Вертикальные бэнды"/><StrRes Name="2448" Text="Заголовок' + 
' данных"/><StrRes Name="2449" Text="Подвал данных"/><StrRes Name="2450" Text="Данные 1 уровня"/><StrRes Name="2451" Text' + 
'="Данные 2 уровня"/><StrRes Name="2452" Text="Данные 3 уровня"/><StrRes Name="2453" Text="Заголовок группы"/><S' + 
'trRes Name="2454" Text="Подвал группы"/><StrRes Name="2455" Text="Дочерний бэнд"/><StrRes Name="2456" Text="0°"/><StrRes Name' + 
'="2457" Text="45°"/><StrRes Name="2458" Text="90°"/><StrRes Name="2459" Text="180°"/><StrRes Name="2460" Text="270°"/><StrRes Name="2461" Text="П' + 
'араметры шрифта"/><StrRes Name="2462" Text="Полужирный"/><StrRes Name="2463" Text="Наклонный"/><StrRes Name="2464" Te' + 
'xt="Подчеркнутый"/><StrRes Name="2465" Text="Верхний индекс"/><StrRes Name="2466" Text="Нижний индекс"/><StrRes N' + 
'ame="2467" Text="Сжатый"/><StrRes Name="2468" Text="Широкий"/><StrRes Name="2469" Text="12 символов/дюйм"/><StrRes Name="2470' + 
'" Text="15 символов/дюйм"/><StrRes Name="2471" Text="Отчет (*.fr3)|*.fr3"/><StrRes Name="2472" Text="Файлы Pascal (*.pas)|*.pas|' + 
'Файлы C++ (*.cpp)|*.cpp|Файлы JavaScript (*.js)|*.js|Файлы Basic (*.vb)|*.vb|All files|*.*"/><StrRes Name="2473" Text="Файлы Pasca' + 
'l (*.pas)|*.pas|Файлы C++ (*.cpp)|*.cpp|Файлы JavaScript (*.js)|*.js|Файлы Basic (*.vb)|*.vb|All files|*.*"/><StrRes Name="2474" Text="' + 
'Подключения..."/><StrRes Name="2475" Text="Язык"/><StrRes Name="2476" Text="Точка останова"/><StrRes Name="2477" Text="В�' + 
'�полнить до текущей позиции"/><StrRes Name="2478" Text="Добавить дочерний бэнд"/><StrRes Name="2479" Text="' + 
'Редактор заливки"/><StrRes Name="dsCm" Text="Сантиметры"/><StrRes Name="dsInch" Text="Дюймы"/><StrRes Name="dsPix" Text=' + 
'"Точки"/><StrRes Name="dsChars" Text="Символы"/><StrRes Name="dsCode" Text="Код"/><StrRes Name="dsData" Text="Данные"/><StrRes Na' + 
'me="dsPage" Text="Стр."/><StrRes Name="dsRepFilter" Text="Отчет (*.fr3)|*.fr3"/><StrRes Name="dsComprRepFilter" Text="Сжатый отчет ' + 
'(*.fr3)|*.fr3"/><StrRes Name="dsSavePreviewChanges" Text="Сохранить изменения?"/><StrRes Name="dsSaveChangesTo" Text="Сохрани' + 
'ть изменения в "/><StrRes Name="dsCantLoad" Text="Не удалось открыть файл"/><StrRes Name="dsStyleFile" Text="Стил�' + 
'�"/><StrRes Name="dsCantFindProc" Text="Не удалось найти главную процедуру"/><StrRes Name="dsClearScript" Text="Это �' + 
'�чистит весь код. Продолжить?"/><StrRes Name="dsNoStyle" Text="Нет стиля"/><StrRes Name="dsStyleSample" Text="Прим�' + 
'�р стиля"/><StrRes Name="dsTextNotFound" Text="Текст ''%s'' не найден"/><StrRes Name="dsReplace" Text="Заменить ''%s''?"/><StrR' + 
'es Name="2600" Text="О FastReport"/><StrRes Name="2601" Text="Посетите нашу страницу:"/><StrRes Name="2602" Text="Продажи:' + 
'"/><StrRes Name="2603" Text="Поддержка:"/><StrRes Name="2700" Text="Настройки страницы"/><StrRes Name="2701" Text="Стра�' + 
'�ица"/><StrRes Name="2702" Text="Ширина"/><StrRes Name="2703" Text="Высота"/><StrRes Name="2704" Text="Формат"/><StrRes Name="270' + 
'5" Text="Ориентация"/><StrRes Name="2706" Text="Левое"/><StrRes Name="2707" Text="Верхнее"/><StrRes Name="2708" Text="Право' + 
'е"/><StrRes Name="2709" Text="Нижнее"/><StrRes Name="2710" Text="Поля"/><StrRes Name="2711" Text="Источник бумаги"/><StrRes N' + 
'ame="2712" Text="Для первой страницы"/><StrRes Name="2713" Text="Для остальных"/><StrRes Name="2714" Text="Портрет' + 
'ная"/><StrRes Name="2715" Text="Альбомная"/><StrRes Name="2716" Text="Прочее"/><StrRes Name="2717" Text="Колонки"/><StrRes Na' + 
'me="2718" Text="Количество"/><StrRes Name="2719" Text="Ширина"/><StrRes Name="2720" Text="Позиции"/><StrRes Name="2721" Text="�' + 
'�рочее"/><StrRes Name="2722" Text="Дуплекс"/><StrRes Name="2723" Text="Печатать на пред.странице"/><StrRes Name="272' + 
'4" Text="Зеркальные поля"/><StrRes Name="2725" Text="Большая высота в дизайнере"/><StrRes Name="2726" Text="Бе�' + 
'�конечная ширина"/><StrRes Name="2727" Text="Бесконечная высота"/><StrRes Name="2800" Text="Данные отчета"/' + 
'><StrRes Name="2900" Text="Список переменных"/><StrRes Name="2901" Text="Категория"/><StrRes Name="2902" Text="Перемен' + 
'ная"/><StrRes Name="2903" Text="Изменить"/><StrRes Name="2904" Text="Удалить"/><StrRes Name="2905" Text="Список"/><StrRes Name' + 
'="2906" Text="Открыть"/><StrRes Name="2907" Text="Сохранить"/><StrRes Name="2908" Text=" Выражение:"/><StrRes Name="2909" Tex' + 
't="Список переменных (*.fd3)|*.fd3"/><StrRes Name="2910" Text="Список переменных (*.fd3)|*.fd3"/><StrRes Name="vaNoVar' + 
'" Text="(нет переменных)"/><StrRes Name="vaVar" Text="Переменные"/><StrRes Name="vaDupName" Text="Переменная с та�' + 
'�им именем уже существует"/><StrRes Name="3000" Text="Настройки дизайнера"/><StrRes Name="3001" Text="Сетк�' + 
'�"/><StrRes Name="3002" Text="Тип"/><StrRes Name="3003" Text="Размер"/><StrRes Name="3004" Text="Диалоговая форма:"/><StrRes N' + 
'ame="3005" Text="Прочее"/><StrRes Name="3006" Text="Шрифты"/><StrRes Name="3007" Text="Редактор кода"/><StrRes Name="3008" Tex' + 
't="Редактор текста"/><StrRes Name="3009" Text="Размер"/><StrRes Name="3010" Text="Размер"/><StrRes Name="3011" Text="Цве�' + 
'�а"/><StrRes Name="3012" Text="Промежуток между бэндами:"/><StrRes Name="3013" Text="см"/><StrRes Name="3014" Text="in"/><Str' + 
'Res Name="3015" Text="pt"/><StrRes Name="3016" Text="pt"/><StrRes Name="3017" Text="pt"/><StrRes Name="3018" Text="Сантиметры:"/><StrRes Nam' + 
'e="3019" Text="Дюймы:"/><StrRes Name="3020" Text="Точки:"/><StrRes Name="3021" Text="Показывать сетку"/><StrRes Name="3022" T' + 
'ext="Выравнивать по сетке"/><StrRes Name="3023" Text="Вызывать редактор после вставки"/><StrRes Name="30' + 
'24" Text="Использовать шрифт объекта"/><StrRes Name="3025" Text="Рабочее поле"/><StrRes Name="3026" Text="Окна"' + 
'/><StrRes Name="3027" Text="Цвет сетки для LCD-монитора"/><StrRes Name="3028" Text="Свободное размещение бэн' + 
'дов"/><StrRes Name="3029" Text="Показывать выпадающий список полей"/><StrRes Name="3030" Text="Показывать ' + 
'окно приветствия"/><StrRes Name="3031" Text="Восстановить настройки"/><StrRes Name="3032" Text="Показыват' + 
'ь заголовки бэндов"/><StrRes Name="3100" Text="Источник данных"/><StrRes Name="3101" Text="Количество запи' + 
'сей:"/><StrRes Name="3102" Text="Источник данных"/><StrRes Name="3103" Text="Фильтр"/><StrRes Name="dbNotAssigned" Text="[не ' + 
'назначен]"/><StrRes Name="3200" Text="Группа"/><StrRes Name="3201" Text="Условие"/><StrRes Name="3202" Text="Свойства"/><' + 
'StrRes Name="3203" Text="Поле БД"/><StrRes Name="3204" Text="Выражение"/><StrRes Name="3205" Text="Выводить группу на �' + 
'�дной странице"/><StrRes Name="3206" Text="Формировать новую страницу"/><StrRes Name="3207" Text="Показыва' + 
'ть в дереве отчета"/><StrRes Name="3300" Text="Служебный текст"/><StrRes Name="3301" Text="Дата-бэнд"/><StrRes Na' + 
'me="3302" Text="Набор данных"/><StrRes Name="3303" Text="Поле БД"/><StrRes Name="3304" Text="Функция"/><StrRes Name="3305" Tex' + 
't="Выражение"/><StrRes Name="3306" Text="Агрегатная функция"/><StrRes Name="3307" Text="Системная переменн�' + 
'�я"/><StrRes Name="3308" Text="Учитывать невидимые бэнды"/><StrRes Name="3309" Text="Текст"/><StrRes Name="3310" Text="Н' + 
'арастающим итогом"/><StrRes Name="agAggregate" Text="Вставить агрегатную функцию"/><StrRes Name="vt1" Text="[' + 
'DATE]"/><StrRes Name="vt2" Text="[TIME]"/><StrRes Name="vt3" Text="[PAGE#]"/><StrRes Name="vt4" Text="[TOTALPAGES#]"/><StrRes Name="vt5" Text="[PAGE#]' + 
' из [TOTALPAGES#]"/><StrRes Name="vt6" Text="[LINE#]"/><StrRes Name="3400" Text="OLE объект"/><StrRes Name="3401" Text="Вставить..."/>' + 
'<StrRes Name="3402" Text="Редактор..."/><StrRes Name="3403" Text="Закрыть"/><StrRes Name="olStretched" Text="Растягиваемый' + 
'"/><StrRes Name="3500" Text="Штрихкод"/><StrRes Name="3501" Text="Код"/><StrRes Name="3502" Text="Тип штрихкода"/><StrRes Name=' + 
'"3503" Text="Масштаб:"/><StrRes Name="3504" Text="Свойства"/><StrRes Name="3505" Text="Ориентация"/><StrRes Name="3506" Text=' + 
'"Контрольная сумма"/><StrRes Name="3507" Text="Показывать текст"/><StrRes Name="3508" Text="0°"/><StrRes Name="3509" T' + 
'ext="90°"/><StrRes Name="3510" Text="180°"/><StrRes Name="3511" Text="270°"/><StrRes Name="bcCalcChecksum" Text="Контрольная сумма"' + 
'/><StrRes Name="bcShowText" Text="Показывать текст"/><StrRes Name="3600" Text="Псевдонимы"/><StrRes Name="3601" Text="Наж�' + 
'�ите Enter для редактирования"/><StrRes Name="3602" Text="Псевдоним набора данных"/><StrRes Name="3603" Text=' + 
'"Псевдонимы полей"/><StrRes Name="3604" Text="Сброс"/><StrRes Name="3605" Text="Обновить"/><StrRes Name="alUserName" Text=' + 
'"Псевдоним"/><StrRes Name="alOriginal" Text="Оригинальное имя"/><StrRes Name="3700" Text="Параметры"/><StrRes Name="q' + 
'pName" Text="Имя"/><StrRes Name="qpDataType" Text="Тип"/><StrRes Name="qpValue" Text="Значение"/><StrRes Name="3800" Text="Редакт�' + 
'�р Master-Detail"/><StrRes Name="3801" Text="Поля Detail"/><StrRes Name="3802" Text="Поля Master"/><StrRes Name="3803" Text="Связанны' + 
'е поля"/><StrRes Name="3804" Text="Добавить"/><StrRes Name="3805" Text="Очистить"/><StrRes Name="3900" Text="Редактор т�' + 
'�кста"/><StrRes Name="3901" Text="Вставить выражение"/><StrRes Name="3902" Text="Вставить агрегатную функц' + 
'ию"/><StrRes Name="3903" Text="Вставить формат"/><StrRes Name="3904" Text="Переносить слова"/><StrRes Name="3905" Text=' + 
'"Текст"/><StrRes Name="3906" Text="Формат"/><StrRes Name="3907" Text="Выделение"/><StrRes Name="4000" Text="Картинка"/><St' + 
'rRes Name="4001" Text="Загрузить"/><StrRes Name="4002" Text="Копировать"/><StrRes Name="4003" Text="Вставить"/><StrRes Name' + 
'="4004" Text="Очистить"/><StrRes Name="piEmpty" Text="Пусто"/><StrRes Name="4100" Text="Диаграмма"/><StrRes Name="4101" Text="Д' + 
'обавить серию"/><StrRes Name="4102" Text="Удалить серию"/><StrRes Name="4103" Text="Редактировать серию"/><S' + 
'trRes Name="4104" Text="Данные из бэнда"/><StrRes Name="4105" Text="Фиксированные данные"/><StrRes Name="4106" Text="�' + 
'�абор данных"/><StrRes Name="4107" Text="Данные"/><StrRes Name="4108" Text="Значения"/><StrRes Name="4109" Text="Выбери�' + 
'�е серию или добавьте новую."/><StrRes Name="4114" Text="Свойства"/><StrRes Name="4115" Text="Показывать TopN ' + 
'значений"/><StrRes Name="4116" Text="Заголовок TopN"/><StrRes Name="4117" Text="Сортировка"/><StrRes Name="4126" Text="Ос' + 
'ь X как"/><StrRes Name="ch3D" Text="Трехмерная"/><StrRes Name="chAxis" Text="Показывать оси"/><StrRes Name="chsoNone" Text=' + 
'"Нет"/><StrRes Name="chsoAscending" Text="По возрастанию"/><StrRes Name="chsoDescending" Text="По убыванию"/><StrRes Name="c' + 
'hxtText" Text="Текст"/><StrRes Name="chxtNumber" Text="Число"/><StrRes Name="chxtDate" Text="Дата"/><StrRes Name="4200" Text="RichEdit"/' + 
'><StrRes Name="4201" Text="Открыть"/><StrRes Name="4202" Text="Сохранить"/><StrRes Name="4203" Text="Отменить"/><StrRes Name="' + 
'4204" Text="Шрифт"/><StrRes Name="4205" Text="Вставить выражение"/><StrRes Name="4206" Text="Полужирный"/><StrRes Name' + 
'="4207" Text="Курсив"/><StrRes Name="4208" Text="Подчеркивание"/><StrRes Name="4209" Text="Выровнять текст влево' + 
'"/><StrRes Name="4210" Text="Выровнять текст по центру"/><StrRes Name="4211" Text="Выровнять текст вправо"/>' + 
'<StrRes Name="4212" Text="Выровнять текст по ширине"/><StrRes Name="4213" Text="Список"/><StrRes Name="4300" Text="Ред�' + 
'�ктор Cross-tab"/><StrRes Name="4301" Text="Данные"/><StrRes Name="4302" Text="Размерность"/><StrRes Name="4303" Text="Строк' + 
'и"/><StrRes Name="4304" Text="Колонки"/><StrRes Name="4305" Text="Ячейки"/><StrRes Name="4306" Text="Структура таблицы"/' + 
'><StrRes Name="4307" Text="Заголовок строки"/><StrRes Name="4308" Text="Заголовок колонки"/><StrRes Name="4309" Text="�' + 
'�тог строки"/><StrRes Name="4310" Text="Итог колонки"/><StrRes Name="4311" Text="Поменять строки/колонки"/><S' + 
'trRes Name="4312" Text="Выберите стиль"/><StrRes Name="4313" Text="Сохранить текущий стиль..."/><StrRes Name="4314" ' + 
'Text="Заголовок таблицы"/><StrRes Name="4315" Text="Угол таблицы"/><StrRes Name="4316" Text="Повторять загол�' + 
'�вки на новой странице"/><StrRes Name="4317" Text="Авто-размер"/><StrRes Name="4318" Text="Рамка вокруг яче�' + 
'�к"/><StrRes Name="4319" Text="Печатать вниз, потом вбок"/><StrRes Name="4320" Text="Ячейки одной строкой"/><S' + 
'trRes Name="4321" Text="Объединять одинаковые ячейки"/><StrRes Name="4322" Text="Нет"/><StrRes Name="4323" Text="Sum"/><S' + 
'trRes Name="4324" Text="Min"/><StrRes Name="4325" Text="Max"/><StrRes Name="4326" Text="Average"/><StrRes Name="4327" Text="Count"/><StrRes Name="4328' + 
'" Text="По возрастанию (А-Я)"/><StrRes Name="4329" Text="По убыванию (Я-А)"/><StrRes Name="4330" Text="Не сортиро�' + 
'�ать"/><StrRes Name="crStName" Text="Введите имя стиля:"/><StrRes Name="crResize" Text="Чтобы изменить размеры �' + 
'�чеек, установите свойство AutoSize = False."/><StrRes Name="crSubtotal" Text="Подитоги"/><StrRes Name="crNone" Text="н' + 
'ет"/><StrRes Name="crSum" Text="Sum"/><StrRes Name="crMin" Text="Min"/><StrRes Name="crMax" Text="Max"/><StrRes Name="crAvg" Text="Avg"/><StrRes Nam' + 
'e="crCount" Text="Count"/><StrRes Name="crAsc" Text="А-Я"/><StrRes Name="crDesc" Text="Я-А"/><StrRes Name="4400" Text="Редактор выраж' + 
'ений"/><StrRes Name="4401" Text="Выражение:"/><StrRes Name="4500" Text="Форматирование"/><StrRes Name="4501" Text="Кате' + 
'гория"/><StrRes Name="4502" Text="Формат"/><StrRes Name="4503" Text="Строка форматирования:"/><StrRes Name="4504" Text=' + 
'"Разделитель дроби:"/><StrRes Name="fkText" Text="Текст"/><StrRes Name="fkNumber" Text="Число"/><StrRes Name="fkDateTime" Te' + 
'xt="Дата/время"/><StrRes Name="fkBoolean" Text="Логическое"/><StrRes Name="fkNumber1" Text="1234.5;%g"/><StrRes Name="fkNumber2" Te' + 
'xt="1234.50;%2.2f"/><StrRes Name="fkNumber3" Text="1,234.50;%2.2n"/><StrRes Name="fkNumber4" Text="1,234.50р;%2.2m"/><StrRes Name="fkDateTime1" Text=' + 
'"28.11.2002;dd.mm.yyyy"/><StrRes Name="fkDateTime2" Text="28 Ноя 2002;dd mmm yyyy"/><StrRes Name="fkDateTime3" Text="28 Ноябрь 2002;dd mmmm y' + 
'yyy"/><StrRes Name="fkDateTime4" Text="02:14;hh:mm"/><StrRes Name="fkDateTime5" Text="02:14am;hh:mm am/pm"/><StrRes Name="fkDateTime6" Text="02:14:00;' + 
'hh:mm:ss"/><StrRes Name="fkDateTime7" Text="02:14, 28 Ноября 2002;hh:mm dd mmmm yyyy"/><StrRes Name="fkBoolean1" Text="0,1;0,1"/><StrRes Name="f' + 
'kBoolean2" Text="Нет,Да;Нет,Да"/><StrRes Name="fkBoolean3" Text="_,x;_,x"/><StrRes Name="fkBoolean4" Text="False,True;False,True"/><StrRes N' + 
'ame="4600" Text="Условное выделение"/><StrRes Name="4601" Text="Условия"/><StrRes Name="4602" Text="Добавить"/><StrRes' + 
' Name="4603" Text="Удалить"/><StrRes Name="4604" Text="Изменить"/><StrRes Name="4605" Text="Стиль"/><StrRes Name="4606" Text="Ра' + 
'мка"/><StrRes Name="4607" Text="Заливка"/><StrRes Name="4608" Text="Шрифт"/><StrRes Name="4609" Text="Видимый"/><StrRes Name="47' + 
'00" Text="Настройки отчета"/><StrRes Name="4701" Text="Основные"/><StrRes Name="4702" Text="Настройки печати"/><' + 
'StrRes Name="4703" Text="Копии"/><StrRes Name="4704" Text="Свойства"/><StrRes Name="4705" Text="Пароль"/><StrRes Name="4706" Text="' + 
'Разобрать по копиям"/><StrRes Name="4707" Text="Два прохода"/><StrRes Name="4708" Text="Печатать, если пуст' + 
'ой"/><StrRes Name="4709" Text="Описание"/><StrRes Name="4710" Text="Имя"/><StrRes Name="4711" Text="Описание"/><StrRes Name="4712' + 
'" Text="Картинка"/><StrRes Name="4713" Text="Автор"/><StrRes Name="4714" Text="Major"/><StrRes Name="4715" Text="Minor"/><StrRes Name="47' + 
'16" Text="Release"/><StrRes Name="4717" Text="Build"/><StrRes Name="4718" Text="Создан"/><StrRes Name="4719" Text="Изменен"/><StrRes Name' + 
'="4720" Text="Описание"/><StrRes Name="4721" Text="Версия"/><StrRes Name="4722" Text="Выбрать..."/><StrRes Name="4723" Text="На' + 
'следование"/><StrRes Name="4724" Text="Выберите действие:"/><StrRes Name="4725" Text="Не менять"/><StrRes Name="4726' + 
'" Text="Отсоединить базовый отчет"/><StrRes Name="4727" Text="Наследовать от базового отчета:"/><Str' + 
'Res Name="4728" Text="Наследование"/><StrRes Name="rePrnOnPort" Text="на"/><StrRes Name="riNotInherited" Text="Этот отчет не ' + 
'наследован."/><StrRes Name="riInherited" Text="Этот отчет наследован от базового: %s"/><StrRes Name="4800" Text' + 
'="Редактор строк"/><StrRes Name="4900" Text="Редактор SQL"/><StrRes Name="4901" Text="Построитель запроса"/><St' + 
'rRes Name="5000" Text="Пароль"/><StrRes Name="5001" Text="Введите пароль:"/><StrRes Name="5100" Text="Стили"/><StrRes Name="51' + 
'01" Text="Цвет..."/><StrRes Name="5102" Text="Шрифт..."/><StrRes Name="5103" Text="Рамка..."/><StrRes Name="5104" Text="Добавить' + 
'"/><StrRes Name="5105" Text="Удалить"/><StrRes Name="5106" Text="Правка"/><StrRes Name="5107" Text="Загрузить"/><StrRes Name="51' + 
'08" Text="Сохранить"/><StrRes Name="5200" Text="Редактор рамки"/><StrRes Name="5201" Text="Рамка"/><StrRes Name="5202" Text' + 
'="Линия"/><StrRes Name="5203" Text="Тень"/><StrRes Name="5211" Text="Стиль:"/><StrRes Name="5214" Text="Цвет:"/><StrRes Name="5215" ' + 
'Text="Толщина:"/><StrRes Name="5216" Text="Выберите тип линии и с помощью мыши укажите, к какой ча�' + 
'�ти рамки он относится."/><StrRes Name="5300" Text="Создать новый..."/><StrRes Name="5301" Text="Список"/><StrRes ' + 
'Name="5302" Text="Шаблоны"/><StrRes Name="5303" Text="Наследовать отчет"/><StrRes Name="5400" Text="Редактор TabOrder"/' + 
'><StrRes Name="5401" Text="Элементы управления:"/><StrRes Name="5402" Text="Вверх"/><StrRes Name="5403" Text="Вниз"/><StrRe' + 
's Name="5500" Text="Вычислить"/><StrRes Name="5501" Text="Выражение"/><StrRes Name="5502" Text="Результат"/><StrRes Name="5' + 
'600" Text="Мастер отчетов"/><StrRes Name="5601" Text="Данные"/><StrRes Name="5602" Text="Поля"/><StrRes Name="5603" Text="Гр�' + 
'�ппы"/><StrRes Name="5604" Text="Размещение"/><StrRes Name="5605" Text="Стиль"/><StrRes Name="5606" Text="Шаг 1. Выберите' + 
' набор данных."/><StrRes Name="5607" Text="Шаг 2. Выберите поля для отображения в отчете."/><StrRes Nam' + 
'e="5608" Text="Шаг 3. Создайте группы (не обязательно)."/><StrRes Name="5609" Text="Шаг 4. Выберите орие�' + 
'�тацию листа и размещение данных."/><StrRes Name="5610" Text="Шаг 5. Выберите стиль отчета."/><StrRes' + 
' Name="5611" Text="Добавить &#62;"/><StrRes Name="5612" Text="Добавить все &#38;#62;&#38;#62;"/><StrRes Name="5613" Text="&#60; У�' + 
'�алить"/><StrRes Name="5614" Text="&#38;#60;&#38;#60; Удалить все"/><StrRes Name="5615" Text="Добавить &#62;"/><StrRes Name="56' + 
'16" Text="&#60; Удалить"/><StrRes Name="5617" Text="Выбранные поля:"/><StrRes Name="5618" Text="Доступные поля:"/><St' + 
'rRes Name="5619" Text="Группы:"/><StrRes Name="5620" Text="Ориентация"/><StrRes Name="5621" Text="Размещение"/><StrRes Name=' + 
'"5622" Text="Портретная"/><StrRes Name="5623" Text="Альбомная"/><StrRes Name="5624" Text="В виде таблицы"/><StrRes Name' + 
'="5625" Text="В виде колонок"/><StrRes Name="5626" Text="Уместить все поля по ширине"/><StrRes Name="5627" Text="&#' + 
'60;&#60; Назад"/><StrRes Name="5628" Text="Далее &#62;&#62;"/><StrRes Name="5629" Text="Готово"/><StrRes Name="5630" Text="Новая ' + 
'таблица..."/><StrRes Name="5631" Text="Новый запрос..."/><StrRes Name="5632" Text="Выберите подключение:"/><StrRe' + 
's Name="5633" Text="Выберите таблицу:"/><StrRes Name="5634" Text="или"/><StrRes Name="5635" Text="Создайте запрос..."/' + 
'><StrRes Name="5636" Text="Настройка подключений"/><StrRes Name="wzStd" Text="Мастер стандартного отчета"/' + 
'><StrRes Name="wzDMP" Text="Мастер матричного отчета"/><StrRes Name="wzStdEmpty" Text="Пустой стандартный от�' + 
'�ет"/><StrRes Name="wzDMPEmpty" Text="Пустой матричный отчет"/><StrRes Name="5700" Text="Мастер подключения к ' + 
'БД"/><StrRes Name="5701" Text="Подключение"/><StrRes Name="5702" Text="Выберите тип подключения:"/><StrRes Name="57' + 
'03" Text="Выберите базу данных:"/><StrRes Name="5704" Text="Имя пользователя"/><StrRes Name="5705" Text="Пароль' + 
'"/><StrRes Name="5706" Text="Спрашивать пароль"/><StrRes Name="5707" Text="Использовать пароль:"/><StrRes Name="5708' + 
'" Text="Таблица"/><StrRes Name="5709" Text="Выберите имя таблицы:"/><StrRes Name="5710" Text="Фильтровать запи' + 
'си:"/><StrRes Name="5711" Text="Запрос"/><StrRes Name="5712" Text="Текст запроса:"/><StrRes Name="5713" Text="Построител' + 
'ь запроса"/><StrRes Name="5714" Text="Редактировать параметры"/><StrRes Name="ftAllFiles" Text="Все файлы"/><Str' + 
'Res Name="ftPictures" Text="Картинки"/><StrRes Name="ftDB" Text="Базы данных"/><StrRes Name="ftRichFile" Text="Файл RichText"/><' + 
'StrRes Name="ftTextFile" Text="Текстовый файл"/><StrRes Name="prNotAssigned" Text="(Не определен)"/><StrRes Name="prInvProp" T' + 
'ext="Неверное значение свойства"/><StrRes Name="prDupl" Text="Повторяющееся имя"/><StrRes Name="prPict" Text="' + 
'(Картинка)"/><StrRes Name="mvExpr" Text="Выражения в тексте"/><StrRes Name="mvStretch" Text="Растягиваемый"/><Str' + 
'Res Name="mvStretchToMax" Text="Растягивание до макс.высоты"/><StrRes Name="mvShift" Text="Смещаемый"/><StrRes Name="' + 
'mvShiftOver" Text="Смещаемый при перекрытии"/><StrRes Name="mvVisible" Text="Видимый"/><StrRes Name="mvPrintable" Text="�' + 
'�ечатаемый"/><StrRes Name="mvFont" Text="Шрифт..."/><StrRes Name="mvFormat" Text="Форматирование..."/><StrRes Name="mvClea' + 
'r" Text="Очистить текст"/><StrRes Name="mvAutoWidth" Text="Автоширина"/><StrRes Name="mvWWrap" Text="Переносить сл�' + 
'�ва"/><StrRes Name="mvSuppress" Text="Скрывать повторяющиеся"/><StrRes Name="mvHideZ" Text="Скрывать нули"/><StrRes' + 
' Name="mvHTML" Text="HTML-тэги в тексте"/><StrRes Name="lvDiagonal" Text="Диагональная"/><StrRes Name="pvAutoSize" Text="Авт' + 
'оразмер"/><StrRes Name="pvCenter" Text="Центрировать"/><StrRes Name="pvAspect" Text="Сохранять пропорции"/><StrRe' + 
's Name="bvSplit" Text="Разрешить разрыв"/><StrRes Name="bvKeepChild" Text="Держать Child вместе"/><StrRes Name="bvPrintChi' + 
'ld" Text="Печатать Child если невидимый"/><StrRes Name="bvStartPage" Text="Формировать новую страницу"/><' + 
'StrRes Name="bvPrintIfEmpty" Text="Печатать, если Detail пуст"/><StrRes Name="bvKeepDetail" Text="Держать Detail вместе"/' + 
'><StrRes Name="bvKeepFooter" Text="Держать подвал вместе"/><StrRes Name="bvReprint" Text="Выводить на новой стра' + 
'нице"/><StrRes Name="bvOnFirst" Text="Печатать на первой странице"/><StrRes Name="bvOnLast" Text="Печатать на п' + 
'оследней странице"/><StrRes Name="bvKeepGroup" Text="Держать вместе"/><StrRes Name="bvFooterAfterEach" Text="Footer по�' + 
'�ле каждой записи"/><StrRes Name="bvDrillDown" Text="Разворачиваемый"/><StrRes Name="bvResetPageNo" Text="Сбрасыв�' + 
'�ть номер страницы"/><StrRes Name="srParent" Text="Печатать на бэнде"/><StrRes Name="bvKeepHeader" Text="Держать ' + 
'заголовок вместе"/><StrRes Name="obCatDraw" Text="Рисование"/><StrRes Name="obCatOther" Text="Другие объекты"/><S' + 
'trRes Name="obCatOtherControls" Text="Другие элементы"/><StrRes Name="obDiagLine" Text="Диагональная линия"/><StrRes Na' + 
'me="obRect" Text="Прямоугольник"/><StrRes Name="obRoundRect" Text="Скругленный прямоугольник"/><StrRes Name="obEl' + 
'lipse" Text="Эллипс"/><StrRes Name="obTrian" Text="Треугольник"/><StrRes Name="obDiamond" Text="Ромб"/><StrRes Name="obLabel" Tex' + 
't="Элемент управления Label"/><StrRes Name="obEdit" Text="Элемент управления Edit"/><StrRes Name="obMemoC" Text="Э�' + 
'�емент управления Memo"/><StrRes Name="obButton" Text="Элемент управления Button"/><StrRes Name="obChBoxC" Text="Эл�' + 
'�мент управления CheckBox"/><StrRes Name="obRButton" Text="Элемент управления RadioButton"/><StrRes Name="obLBox" Text=' + 
'"Элемент управления ListBox"/><StrRes Name="obCBox" Text="Элемент управления ComboBox"/><StrRes Name="obDateEdit" Te' + 
'xt="Элемент управления DateEdit"/><StrRes Name="obImageC" Text="Элемент управления Image"/><StrRes Name="obPanel" Te' + 
'xt="Элемент управления Panel"/><StrRes Name="obGrBox" Text="Элемент управления GroupBox"/><StrRes Name="obBBtn" Text' + 
'="Элемент управления BitBtn"/><StrRes Name="obSBtn" Text="Элемент управления SpeedButton"/><StrRes Name="obMEdit" Te' + 
'xt="Элемент управления MaskEdit"/><StrRes Name="obChLB" Text="Элемент управления CheckListBox"/><StrRes Name="obDBLo' + 
'okup" Text="Элемент управления DBLookupComboBox"/><StrRes Name="obBevel" Text="Элемент управления Bevel"/><StrRes Na' + 
'me="obShape" Text="Элемент управления Shape"/><StrRes Name="obText" Text="Объект &#38;#34;Текст&#38;#34;"/><StrRes Name="o' + 
'bSysText" Text="Объект &#38;#34;Служебный текст&#38;#34;"/><StrRes Name="obLine" Text="Объект &#38;#34;Линия&#38;#34;"/' + 
'><StrRes Name="obPicture" Text="Объект &#38;#34;Рисунок&#38;#34;"/><StrRes Name="obBand" Text="Объект &#34;Бэнд&#34;"/><StrRes ' + 
'Name="obDataBand" Text="Объект &#38;#34;Дата-бэнд&#38;#34;"/><StrRes Name="obSubRep" Text="Объект &#38;#34;Вложенный от' + 
'чет&#38;#34;"/><StrRes Name="obDlgPage" Text="Диалоговая форма"/><StrRes Name="obRepPage" Text="Страница отчета"/><Str' + 
'Res Name="obReport" Text="Объект &#38;#34;Отчет&#38;#34;"/><StrRes Name="obRich" Text="Объект &#34;RichText&#34;"/><StrRes Name="obOL' + 
'E" Text="Объект &#34;OLE&#34;"/><StrRes Name="obChBox" Text="Объект &#34;CheckBox&#34;"/><StrRes Name="obChart" Text="Объект &#38;#3' + 
'4;Диаграмма&#38;#34;"/><StrRes Name="obBarC" Text="Объект &#38;#34;Штрихкод&#38;#34;"/><StrRes Name="obCross" Text="Объек�' + 
'� &#38;#34;Cross-tab&#38;#34;"/><StrRes Name="obDBCross" Text="Объект &#38;#34;DB Cross-tab&#38;#34;"/><StrRes Name="obGrad" Text="Объект ' + 
'&#38;#34;Градиент&#38;#34;"/><StrRes Name="obDMPText" Text="Объект &#38;#34;Матричный текст&#38;#34;"/><StrRes Name="obDMP' + 
'Line" Text="Объект &#38;#34;Матричная линия&#38;#34;"/><StrRes Name="obDMPCmd" Text="Объект &#38;#34;ESC-команда&#38;' + 
'#34;"/><StrRes Name="obBDEDB" Text="База данных BDE"/><StrRes Name="obBDETb" Text="Таблица BDE"/><StrRes Name="obBDEQ" Text="Запр' + 
'ос BDE"/><StrRes Name="obBDEComps" Text="Компоненты BDE"/><StrRes Name="obIBXDB" Text="База данных IBX"/><StrRes Name="obIBXTb" ' + 
'Text="Таблица IBX"/><StrRes Name="obIBXQ" Text="Запрос IBX"/><StrRes Name="obIBXComps" Text="Компоненты IBX"/><StrRes Name="obA' + 
'DODB" Text="База данных ADO"/><StrRes Name="obADOTb" Text="Таблица ADO"/><StrRes Name="obADOQ" Text="Запрос ADO"/><StrRes Name=' + 
'"obADOComps" Text="Компоненты ADO"/><StrRes Name="obDBXDB" Text="База данных DBX"/><StrRes Name="obDBXTb" Text="Таблица DBX' + 
'"/><StrRes Name="obDBXQ" Text="Запрос DBX"/><StrRes Name="obDBXComps" Text="Компоненты DBX"/><StrRes Name="obFIBDB" Text="База д�' + 
'�нных FIB"/><StrRes Name="obFIBTb" Text="Таблица FIB"/><StrRes Name="obFIBQ" Text="Запрос FIB"/><StrRes Name="obFIBComps" Text="Ко�' + 
'�поненты FIB"/><StrRes Name="ctString" Text="Строки"/><StrRes Name="ctDate" Text="Дата и время"/><StrRes Name="ctConv" Text="К' + 
'онвертирование"/><StrRes Name="ctFormat" Text="Форматирование"/><StrRes Name="ctMath" Text="Математические"/' + 
'><StrRes Name="ctOther" Text="Прочие"/><StrRes Name="IntToStr" Text="Конвертирует целое число в строку"/><StrRes Na' + 
'me="FloatToStr" Text="Конвертирует вещественное число в строку"/><StrRes Name="DateToStr" Text="Конвертир' + 
'ует дату в строку"/><StrRes Name="TimeToStr" Text="Конвертирует время в строку"/><StrRes Name="DateTimeToStr" Te' + 
'xt="Конвертирует дату и время в строку"/><StrRes Name="VarToStr" Text="Конвертирует вариант в стр�' + 
'�ку"/><StrRes Name="StrToInt" Text="Конвертирует строку в целое число"/><StrRes Name="StrToInt64" Text="Converts a stri' + 
'ng to an Int64 value"/><StrRes Name="StrToFloat" Text="Конвертирует строку в вещественное число"/><StrRes Name="St' + 
'rToDate" Text="Конвертирует строку в дату"/><StrRes Name="StrToTime" Text="Конвертирует строку во врем�' + 
'�"/><StrRes Name="StrToDateTime" Text="Конвертирует строку в дату и время"/><StrRes Name="Format" Text="Возвраща�' + 
'�т форматированную строку"/><StrRes Name="FormatFloat" Text="Форматирует вещественное число"/><StrRe' + 
's Name="FormatDateTime" Text="Форматирует дату и время"/><StrRes Name="FormatMaskText" Text="Форматирует текст, �' + 
'�спользуя заданную маску"/><StrRes Name="EncodeDate" Text="Возвращает значение TDateTime, соответств�' + 
'�ющее заданным значениям Year, Month, Day"/><StrRes Name="DecodeDate" Text="Разбивает значение TDateTime на з' + 
'начения Year, Month, Day"/><StrRes Name="EncodeTime" Text="Возвращает значение TDateTime, соответствующее за' + 
'данным значениям Hour, Min, Sec, MSec"/><StrRes Name="DecodeTime" Text="Разбивает значение TDateTime на значен' + 
'ия Hour, Min, Sec, MSec"/><StrRes Name="Date" Text="Возвращает текущую дату"/><StrRes Name="Time" Text="Возвращает т' + 
'екущее время"/><StrRes Name="Now" Text="Возвращает текущую дату и время"/><StrRes Name="DayOfWeek" Text="Воз�' + 
'�ращает номер дня недели, соответствующий заданной дате"/><StrRes Name="IsLeapYear" Text="Возвра�' + 
'�ает True, если заданный год - високосный"/><StrRes Name="DaysInMonth" Text="Возвращает число дней в �' + 
'�аданном месяце"/><StrRes Name="Length" Text="Возвращает длину строки или массива"/><StrRes Name="Copy" Te' + 
'xt="Возвращает подстроку"/><StrRes Name="Pos" Text="Возвращает позицию подстроки в строке"/><StrRe' + 
's Name="Delete" Text="Удаляет часть символов строки"/><StrRes Name="Insert" Text="Вставляет подстроку в �' + 
'�троку"/><StrRes Name="Uppercase" Text="Конвертирует все символы строки в верхний регистр"/><StrRes Na' + 
'me="Lowercase" Text="Конвертирует все символы строки в нижний регистр"/><StrRes Name="Trim" Text="Удаля' + 
'ет пробелы в начале и конце строки"/><StrRes Name="NameCase" Text="Конвертирует первый символ сл' + 
'ова в верхний регистр"/><StrRes Name="CompareText" Text="Сравнивает две строки без учета регистра' + 
'"/><StrRes Name="Chr" Text="Конвертирует целое число в символ"/><StrRes Name="Ord" Text="Конвертирует сим�' + 
'�ол в целое число"/><StrRes Name="SetLength" Text="Устанавливает длину строки"/><StrRes Name="Round" Text="Окр' + 
'угляет число до ближайшего целого значения"/><StrRes Name="Trunc" Text="Отбрасывает дробную ч�' + 
'�сть числа"/><StrRes Name="Int" Text="Возвращает целую часть вещественного значения"/><StrRes Name="F' + 
'rac" Text="Возвращает дробную часть вещественного значения"/><StrRes Name="Sqrt" Text="Возвращает' + 
' корень квадратный из числа"/><StrRes Name="Abs" Text="Возвращает модуль числа"/><StrRes Name="Sin" Text="' + 
'Возвращает синус угла (в радианах)"/><StrRes Name="Cos" Text="Возвращает косинус угла (в радиа�' + 
'�ах)"/><StrRes Name="ArcTan" Text="Возвращает арктангенс"/><StrRes Name="Tan" Text="Возвращает тангенс"/><StrRe' + 
's Name="Exp" Text="Возвращает экспоненту"/><StrRes Name="Ln" Text="Возращает натуральный логарифм за' + 
'данного числа"/><StrRes Name="Pi" Text="Возвращает число &#38;#34;пи&#38;#34;"/><StrRes Name="Inc" Text="Увеличив' + 
'ает целое число на 1"/><StrRes Name="Dec" Text="Уменьшает целое число на 1"/><StrRes Name="RaiseException" Text="�' + 
'�ызывает исключение"/><StrRes Name="ShowMessage" Text="Показывает окно сообщения"/><StrRes Name="Randomize" Te' + 
'xt="Запускает генератор случайных чисел"/><StrRes Name="Random" Text="Возвращает случайное числ' + 
'о"/><StrRes Name="ValidInt" Text="Возвращает True если заданная строка может быть преобразована в ' + 
'целое число"/><StrRes Name="ValidFloat" Text="Возвращает True если заданная строка может быть прео�' + 
'�разована в вещественное число"/><StrRes Name="ValidDate" Text="Возвращает True если заданная стро' + 
'ка может быть преобразована в дату"/><StrRes Name="IIF" Text="Возвращает TrueValue если заданное в' + 
'ыражение равно True, иначе возвращает FalseValue"/><StrRes Name="Get" Text="Возвращает значение пере' + 
'менной из списка переменных"/><StrRes Name="Set" Text="Устанавливает значение переменной из �' + 
'�писка переменных"/><StrRes Name="InputBox" Text="Показывает диалог ввода строки"/><StrRes Name="InputQuery"' + 
' Text="Показывает диалог ввода строки"/><StrRes Name="MessageDlg" Text="Показывает окно сообщения"/>' + 
'<StrRes Name="CreateOleObject" Text="Создает OLE объект"/><StrRes Name="VarArrayCreate" Text="Создает массив вариант�' + 
'�в"/><StrRes Name="VarType" Text="Возвращает тип варианта"/><StrRes Name="DayOf" Text="Возвращает день (1..31) д�' + 
'�ты Date"/><StrRes Name="MonthOf" Text="Возвращает месяц (1..12) даты Date"/><StrRes Name="YearOf" Text="Возвращает г�' + 
'�д даты Date"/><StrRes Name="ctAggregate" Text="Агрегатные"/><StrRes Name="Sum" Text="Возвращает сумму выражени�' + 
'� Expr для бэнда Band"/><StrRes Name="Avg" Text="Возвращает среднее значение выражения Expr для бэнд�' + 
'� Band"/><StrRes Name="Min" Text="Возвращает минимальное значение выражения Expr для бэнда Band"/><StrRe' + 
's Name="Max" Text="Возвращает максимальное значение выражения Expr для бэнда Band"/><StrRes Name="Count' + 
'" Text="Возвращает количество строк в бэнде Band"/><StrRes Name="wzDBConn" Text="Новое подключение к �' + 
'�Д"/><StrRes Name="wzDBTable" Text="Новая таблица"/><StrRes Name="wzDBQuery" Text="Новый запрос"/><StrRes Name="5800" Text="С' + 
'оединения"/><StrRes Name="5801" Text="Новое"/><StrRes Name="5802" Text="Удалить"/><StrRes Name="cpName" Text="Имя"/><StrRes Na' + 
'me="cpConnStr" Text="Строка подключения"/><StrRes Name="startCreateNew" Text="Создать новый отчет"/><StrRes Name="st' + 
'artCreateBlank" Text="Содать пустой отчет"/><StrRes Name="startOpenReport" Text="Открыть отчет"/><StrRes Name="startOpenL' + 
'ast" Text="Открыть последний отчет"/><StrRes Name="startEditAliases" Text="Соединения"/><StrRes Name="startHelp" Text="' + 
'Помощь"/><StrRes Name="5900" Text="Инспектор переменных"/><StrRes Name="5901" Text="Добавить переменную"/><' + 
'StrRes Name="5902" Text="Удалить переменную"/><StrRes Name="5903" Text="Редактировать переменную"/><StrRes Nam' + 
'e="6000" Text="Ошибка наследования"/><StrRes Name="6001" Text="Базовый и наследованный отчет имеют о' + 
'динаковые объекты. Выберите действие:"/><StrRes Name="6002" Text="Удалить одинаковые объекты"/' + 
'><StrRes Name="6003" Text="Переименовать объекты"/><StrRes Name="6004" Text="Сортировать по имени"/><StrRes Name' + 
'="dsColorOth" Text="Другой..."/><StrRes Name="6100" Text="Редактор заливки"/><StrRes Name="6101" Text="Штриховка"/><StrR' + 
'es Name="6102" Text="Градиент"/><StrRes Name="6103" Text="Стекло"/><StrRes Name="6104" Text="Штриховка:"/><StrRes Name="6105" T' + 
'ext="Цвет заливки:"/><StrRes Name="6106" Text="Цвет штриховки:"/><StrRes Name="6107" Text="Стиль градиента:"/><S' + 
'trRes Name="6108" Text="Начальный цвет:"/><StrRes Name="6109" Text="Конечный цвет:"/><StrRes Name="6110" Text="Ориента' + 
'ция:"/><StrRes Name="6111" Text="Цвет:"/><StrRes Name="6112" Text="Смесь (0..1):"/><StrRes Name="6113" Text="Показывать штри' + 
'ховку"/><StrRes Name="bsSolid" Text="Сплошная"/><StrRes Name="bsClear" Text="Нет"/><StrRes Name="bsHorizontal" Text="Горизонт�' + 
'�льная"/><StrRes Name="bsVertical" Text="Вертикальная"/><StrRes Name="bsFDiagonal" Text="Диагональная"/><StrRes Name="bsB' + 
'Diagonal" Text="Обр. диагональная"/><StrRes Name="bsCross" Text="Клетка"/><StrRes Name="bsDiagCross" Text="Диагон. клет' + 
'ка"/><StrRes Name="gsHorizontal" Text="Горизонтальный"/><StrRes Name="gsVertical" Text="Вертикальный"/><StrRes Name="gsEll' + 
'iptic" Text="Круглый"/><StrRes Name="gsRectangle" Text="Прямоугольный"/><StrRes Name="gsVertCenter" Text="Вертикальный' + 
' центр"/><StrRes Name="gsHorizCenter" Text="Горизонтальный центр"/><StrRes Name="foVertical" Text="Вертикальная"/>' + 
'<StrRes Name="foHorizontal" Text="Горизонтальная"/><StrRes Name="foVerticalMirror" Text="Обратн. вертикальная"/><StrRe' + 
's Name="foHorizontalMirror" Text="Обратн. горизонтальная"/><StrRes Name="6200" Text="Редактор гиперссылки"/><St' + 
'rRes Name="6201" Text="Тип гиперссылки"/><StrRes Name="6202" Text="Ссылка"/><StrRes Name="6203" Text="Номер страницы"' + 
'/><StrRes Name="6204" Text="Якорь"/><StrRes Name="6205" Text="Детальный отчет"/><StrRes Name="6206" Text="Детальная стр' + 
'аница отчета"/><StrRes Name="6207" Text="Пользовательский"/><StrRes Name="6208" Text="Свойства"/><StrRes Name="6209' + 
'" Text="Укажите ссылку (например, http://www.url.com):"/><StrRes Name="6210" Text="или введите выражение, во' + 
'звращающее ссылку:"/><StrRes Name="6211" Text="Укажите номер страницы:"/><StrRes Name="6212" Text="или введ' + 
'ите выражение, возвращающее номер страницы:"/><StrRes Name="6213" Text="Укажите имя якоря:"/><StrR' + 
'es Name="6214" Text="или введите выражение, возвращающее имя якоря:"/><StrRes Name="6215" Text="Отчет:"/><' + 
'StrRes Name="6216" Text="Переменная отчета:"/><StrRes Name="6217" Text="Укажите значение переменной:"/><StrRe' + 
's Name="6218" Text="или введите выражение, возвращающее значение переменной:"/><StrRes Name="6219" Te' + 
'xt="Страница отчета:"/><StrRes Name="6220" Text="Укажите значение гиперссылки:"/><StrRes Name="6221" Text="и�' + 
'�и введите выражение, возвращающее значение гиперссылки:"/><StrRes Name="6222" Text="Что произ' + 
'ойдет, если вы нажмете на этот объект в окне просмотра:"/><StrRes Name="6223" Text="Будет откры�' + 
'� указанный адрес."/><StrRes Name="6224" Text="Вы перейдете на страницу с указанным номером."/><St' + 
'rRes Name="6225" Text="Вы перейдете на якорь с указанным именем."/><StrRes Name="6226" Text="Указанный от' + 
'чет будет построен и открыт в новой закладке окна просмотра."/><StrRes Name="6227" Text="Указа�' + 
'�ная страница будет построена и открыта в новой закладке окна просмотра."/><StrRes Name="6' + 
'228" Text="Вы должны определить обработчик события OnClick у объекта."/><StrRes Name="6229" Text="Изме�' + 
'�ить внешний вид объекта, чтобы он выглядел как ссылка"/><StrRes Name="mvHyperlink" Text="Гиперссы' + 
'лка..."/><StrRes Name="4729" Text="Templates path :"/><StrRes Name="obDataBases" Text="DataBases"/><StrRes Name="obTables" Text="Tables"/><StrRes N' + 
'ame="obQueries" Text="Queries"/><StrRes Name="crGroup" Text="Group"/><StrRes Name="4331" Text="Grouping"/><StrRes Name="6300" Text="Выделить �' + 
'�акого же типа на предке"/><StrRes Name="6301" Text="Выделить такого же типа на странице"/><StrRes Na' + 
'me="6302" Text="Сбросить в значения предка"/><StrRes Name="6303" Text="Сбросить в значения предка с д�' + 
'�черними"/></Resources>' + 
' ';

initialization
  frxResources.AddXML(resXML);

end.
