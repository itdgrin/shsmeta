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

unit frxrcExports;

interface

implementation

uses frxRes;

const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1251"><StrRes Name="8000" Text="Экспорт в Excel"/><StrRes Name="8001" Text="Сти�' + 
'�и"/><StrRes Name="8002" Text="Картинки"/><StrRes Name="8003" Text="Объединять ячейки"/><StrRes Name="8004" Text="Быстр�' + 
'�й экспорт"/><StrRes Name="8005" Text="WYSIWYG"/><StrRes Name="8006" Text="Как текст"/><StrRes Name="8007" Text="Фон"/><StrRes Name' + 
'="8008" Text="Открыть Excel после экспорта"/><StrRes Name="8009" Text="Файл Excel (*.xls)|*.xls"/><StrRes Name="8010" Text=".x' + 
'ls"/><StrRes Name="8100" Text="Экспорт в Excel"/><StrRes Name="8101" Text="Стили"/><StrRes Name="8102" Text="WYSIWYG"/><StrRes Name="8103' + 
'" Text="Фон"/><StrRes Name="8104" Text="Открыть Excel после экспорта"/><StrRes Name="8105" Text="Файл Excel (*.xls)|*.xls"/' + 
'><StrRes Name="8106" Text=".xls"/><StrRes Name="8200" Text="Экспорт в HTML (табличный)"/><StrRes Name="8201" Text="Открыть п�' + 
'�сле экспорта"/><StrRes Name="8202" Text="Стили"/><StrRes Name="8203" Text="Картинки"/><StrRes Name="8204" Text="Все в о�' + 
'�ной папке"/><StrRes Name="8205" Text="Фикс.ширина"/><StrRes Name="8206" Text="Навигатор"/><StrRes Name="8207" Text="Мно' + 
'гостраничный"/><StrRes Name="8208" Text="Браузер Mozilla"/><StrRes Name="8209" Text="Фон"/><StrRes Name="8210" Text="Файл HT' + 
'ML (*.html)|*.html"/><StrRes Name="8211" Text=".html"/><StrRes Name="8300" Text="Экспорт в текст"/><StrRes Name="8301" Text="Просмо' + 
'тр результата"/><StrRes Name="8302" Text=" Опции  "/><StrRes Name="8303" Text="Разрывы страниц"/><StrRes Name="8304" Te' + 
'xt="OEM-кодировка"/><StrRes Name="8305" Text="Пустые строки"/><StrRes Name="8306" Text="Пробелы слева"/><StrRes Name=' + 
'"8307" Text="Номера"/><StrRes Name="8308" Text="Введите номера и/или диапазоны страниц, разделенные ' + 
'запятыми. Например, 1,3,5-12"/><StrRes Name="8309" Text=" Масштаб "/><StrRes Name="8310" Text="по оси X"/><StrRes Name="83' + 
'11" Text="по оси Y"/><StrRes Name="8312" Text=" Рамки "/><StrRes Name="8313" Text="Нет"/><StrRes Name="8314" Text="Текстовые"/><' + 
'StrRes Name="8315" Text="Графические"/><StrRes Name="8316" Text="Only with OEM codepage"/><StrRes Name="8317" Text="Печать после' + 
' экспорта"/><StrRes Name="8318" Text="Сохранить настройки"/><StrRes Name="8319" Text=" Просмотр "/><StrRes Name="832' + 
'0" Text="Ширина:"/><StrRes Name="8321" Text="Высота:"/><StrRes Name="8322" Text="Страница"/><StrRes Name="8323" Text="Увелич' + 
'ить"/><StrRes Name="8324" Text="Уменьшить"/><StrRes Name="8325" Text="Текстовый файл (*.txt)|*.txt"/><StrRes Name="8326" Text' + 
'=".txt"/><StrRes Name="8400" Text="Печать"/><StrRes Name="8401" Text="Принтер"/><StrRes Name="8402" Text="Имя"/><StrRes Name="8403" Te' + 
'xt="Настройки..."/><StrRes Name="8404" Text="Копии"/><StrRes Name="8405" Text="Количество"/><StrRes Name="8406" Text=" Опц�' + 
'�и "/><StrRes Name="8407" Text="Тип принтера"/><StrRes Name="8408" Text=".fpi"/><StrRes Name="8409" Text="Настройки принте�' + 
'�а (*.fpi)|*.fpi"/><StrRes Name="8410" Text=".fpi"/><StrRes Name="8411" Text="Настройки принтера (*.fpi)|*.fpi"/><StrRes Name="8500"' + 
' Text="Экспорт в RTF (табличный)"/><StrRes Name="8501" Text="Картинки"/><StrRes Name="8502" Text="WYSIWYG"/><StrRes Name="850' + 
'3" Text="Открыть после экспорта"/><StrRes Name="8504" Text="Файл RTF (*.rtf)|*.rtf"/><StrRes Name="8505" Text=".rtf"/><StrRes ' + 
'Name="8600" Text="Экспорт в рисунок"/><StrRes Name="8601" Text=" Опции "/><StrRes Name="8602" Text="Качество JPEG"/><StrRe' + 
's Name="8603" Text="Разрешение (dpi)"/><StrRes Name="8604" Text="Раздельные файлы"/><StrRes Name="8605" Text="Обрезат�' + 
'� страницу"/><StrRes Name="8606" Text="Монохромный"/><StrRes Name="8700" Text="Экспорт в PDF"/><StrRes Name="8701" Text="К' + 
'омпрессия"/><StrRes Name="8702" Text="Встроить шрифты"/><StrRes Name="8703" Text="Высокое разрешение"/><StrRes' + 
' Name="8704" Text="Оглавление"/><StrRes Name="8705" Text="Фон"/><StrRes Name="8706" Text="Открыть после экспорта"/><S' + 
'trRes Name="8707" Text="Файл Adobe PDF (*.pdf)|*.pdf"/><StrRes Name="8708" Text=".pdf"/><StrRes Name="RTFexport" Text="Документ Word (та' + 
'бличный)"/><StrRes Name="BMPexport" Text="Рисунок BMP"/><StrRes Name="JPEGexport" Text="Рисунок JPEG"/><StrRes Name="TIFFexport" ' + 
'Text="Рисунок TIFF"/><StrRes Name="PNGexport" Text="Рисунок PNG"/><StrRes Name="EMFexport" Text="Рисунок EMF"/><StrRes Name="Text' + 
'Export" Text="Текстовый файл (prn)"/><StrRes Name="XlsOLEexport" Text="Документ Excel (OLE)"/><StrRes Name="HTMLexport" Text="Д�' + 
'�кумент HTML (табличный)"/><StrRes Name="XlsXMLexport" Text="Документ Excel (XML)"/><StrRes Name="PDFexport" Text="Докуме' + 
'нт PDF"/><StrRes Name="ProgressWait" Text="Подождите, пожалуйста"/><StrRes Name="ProgressRows" Text="Настройка стро�' + 
'�"/><StrRes Name="ProgressColumns" Text="Настройка колонок"/><StrRes Name="ProgressStyles" Text="Настройка стилей"/><St' + 
'rRes Name="ProgressObjects" Text="Экспорт объектов"/><StrRes Name="TIFFexportFilter" Text="Рисунок TIFF (*.tif)|*.tif"/><StrRes ' + 
'Name="BMPexportFilter" Text="Рисунок BMP (*.bmp)|*.bmp"/><StrRes Name="JPEGexportFilter" Text="Рисунок JPEG (*.jpg)|*.jpg"/><StrRes Name' + 
'="PNGexportFilter" Text="Рисунок PNG (*.png)|*.png"/><StrRes Name="EMFexportFilter" Text="Рисунок EMF (*.emf)|*.emf"/><StrRes Name="HTML' + 
'NavFirst" Text="Начало"/><StrRes Name="HTMLNavPrev" Text="Пред."/><StrRes Name="HTMLNavNext" Text="След."/><StrRes Name="HTMLNavLast" Te' + 
'xt="Конец"/><StrRes Name="HTMLNavRefresh" Text="Обновить"/><StrRes Name="HTMLNavPrint" Text="Печать"/><StrRes Name="HTMLNavTotal" T' + 
'ext="Всего страниц"/><StrRes Name="8800" Text="Экспорт в текст"/><StrRes Name="8801" Text="Текстовый файл (*.txt' + 
')|*.txt"/><StrRes Name="8802" Text=".txt"/><StrRes Name="SimpleTextExport" Text="Текстовый файл"/><StrRes Name="8850" Text="Экспор�' + 
'� в CSV"/><StrRes Name="8851" Text="CSV файл (*.csv)|*.csv"/><StrRes Name="8852" Text=".csv"/><StrRes Name="8853" Text="Разделитель"/>' + 
'<StrRes Name="CSVExport" Text="CSV файл"/><StrRes Name="8900" Text="Отослать по E-mail"/><StrRes Name="8901" Text="E-mail"/><StrRes Name' + 
'="8902" Text="Ящик"/><StrRes Name="8903" Text="Подключение"/><StrRes Name="8904" Text="Адрес"/><StrRes Name="8905" Text="Прил�' + 
'�жение"/><StrRes Name="8906" Text="Формат"/><StrRes Name="8907" Text="Адрес"/><StrRes Name="8908" Text="Автор"/><StrRes Name="890' + 
'9" Text="Сервер"/><StrRes Name="8910" Text="Имя"/><StrRes Name="8911" Text="Письмо"/><StrRes Name="8912" Text="Сообщение"/><St' + 
'rRes Name="8913" Text="Текст"/><StrRes Name="8914" Text="Организация"/><StrRes Name="8915" Text="Пароль"/><StrRes Name="8916" Te' + 
'xt="Порт"/><StrRes Name="8917" Text="Запомнить настройки"/><StrRes Name="8918" Text="Необходимые поля не зап' + 
'олнены"/><StrRes Name="8919" Text="Расширенные настройки экспорта"/><StrRes Name="8920" Text="Подпись"/><StrR' + 
'es Name="8921" Text="Собрать"/><StrRes Name="8922" Text="Тема"/><StrRes Name="8923" Text="С уважением"/><StrRes Name="8924" Text=' + 
'"Отправка письма на"/><StrRes Name="EmailExport" Text="E-mail"/><StrRes Name="FastReportFile" Text="FastReport файл"/><StrRes Name' + 
'="GifexportFilter" Text="Рисунок Gif (*.gif)|*.gif"/><StrRes Name="GIFexport" Text="Рисунок Gif"/><StrRes Name="8950" Text="Неразр' + 
'ывный"/><StrRes Name="8951" Text="Колонтитулы"/><StrRes Name="8952" Text="Текст"/><StrRes Name="8953" Text="Колонтитул�' + 
'�"/><StrRes Name="8954" Text="Нет"/><StrRes Name="ODSExportFilter" Text="Open Document Таблица (*.ods)|*.ods"/><StrRes Name="ODSExport" Text' + 
'="Open Document Таблица"/><StrRes Name="ODTExportFilter" Text="Open Document Текст (*.odt)|*.odt"/><StrRes Name="ODTExport" Text="Open Doc' + 
'ument Текст"/><StrRes Name="8960" Text=".ods"/><StrRes Name="8961" Text=".odt"/><StrRes Name="8962" Text="Защита"/><StrRes Name="8963" Text' + 
'="Настройки защиты"/><StrRes Name="8964" Text="Пароль владельца"/><StrRes Name="8965" Text="Пароль пользов�' + 
'�теля"/><StrRes Name="8966" Text="Печать документа"/><StrRes Name="8967" Text="Изменение документа"/><StrRes Name' + 
'="8968" Text="Копирование текста и графики"/><StrRes Name="8969" Text="Аннотации"/><StrRes Name="8970" Text="Защ�' + 
'�та PDF"/><StrRes Name="8971" Text="Информация о документе"/><StrRes Name="8972" Text="Информация"/><StrRes Name="8973' + 
'" Text="Заголовок"/><StrRes Name="8974" Text="Автор"/><StrRes Name="8975" Text="Тема"/><StrRes Name="8976" Text="Слова"/><StrRe' + 
's Name="8977" Text="Создатель"/><StrRes Name="8978" Text="Программа"/><StrRes Name="8979" Text="Аутентификация"/><StrR' + 
'es Name="8980" Text="Права доступа"/><StrRes Name="8981" Text="Просмотр"/><StrRes Name="8982" Text="Настройки просм�' + 
'�тра"/><StrRes Name="8983" Text="Спрятать toolbar"/><StrRes Name="8984" Text="Спрятать menubar"/><StrRes Name="8985" Text="Спря' + 
'тать интерфейс окна"/><StrRes Name="8986" Text="Растянуть окно"/><StrRes Name="8987" Text="Центровать окно' + 
'"/><StrRes Name="8988" Text="Растягивать при печати"/><StrRes Name="8989" Text="Подтверждение прочтения"/><S' + 
'trRes Name="9000" Text="Кол-во строк:"/><StrRes Name="9001" Text="Разбить на листы"/><StrRes Name="9002" Text="Не разби' + 
'вать"/><StrRes Name="9003" Text="Использовать стр. отчета"/><StrRes Name="9004" Text="Использовать печать �' + 
'�а родителе"/><StrRes Name="9101" Text="Экспорт в DBF"/><StrRes Name="9102" Text="dBase (DBF) экспорт"/><StrRes Name="9103" Te' + 
'xt=".dbf"/><StrRes Name="9104" Text="Не удалось загрузить файл"/><StrRes Name="9105" Text="Ошибка"/><StrRes Name="9106" Te' + 
'xt="Имена столбцов"/><StrRes Name="9107" Text="Автоматически"/><StrRes Name="9108" Text="Вручную"/><StrRes Name="9109' + 
'" Text="Загрузить из файла"/><StrRes Name="9110" Text="Текстовые файлы (*.txt)|*.txt|Все файлы|*.*"/><StrRes Nam' + 
'e="9111" Text="DBF файлы (*.dbf)|*.dbf|Все файлы|*.*"/><StrRes Name="9151" Text="Документ Excel 97/2000/XP"/><StrRes Name="9152" ' + 
'Text="Автоматически создать файл"/><StrRes Name="9153" Text="Опции"/><StrRes Name="9154" Text="Страница"/><StrRes' + 
' Name="9155" Text="Линии сетки"/><StrRes Name="9156" Text="Всё в одну страницу"/><StrRes Name="9157" Text="Объедине�' + 
'�ие данных"/><StrRes Name="9158" Text="Как в отчёте"/><StrRes Name="9159" Text="Блоками. Каждый блок по (стро' + 
'к):"/><StrRes Name="9160" Text="Размер блока должен быть положительным целым числом."/><StrRes Name="916' + 
'1" Text="SingleSheet должно быть False при экспорте блоками."/><StrRes Name="9162" Text="Автор"/><StrRes Name="9163" ' + 
'Text="Комментарий"/><StrRes Name="9164" Text="Ключевые слова"/><StrRes Name="9165" Text="Ревизия"/><StrRes Name="9166" ' + 
'Text="Версия"/><StrRes Name="9167" Text="Приложение"/><StrRes Name="9168" Text="Тема"/><StrRes Name="9169" Text="Категори�' + 
'�"/><StrRes Name="9170" Text="Компания"/><StrRes Name="9171" Text="Заголовок"/><StrRes Name="9172" Text="Менеджер"/><StrRes N' + 
'ame="9173" Text="Общее"/><StrRes Name="9174" Text="Информация"/><StrRes Name="9175" Text="Защита"/><StrRes Name="9176" Text="Па' + 
'роль"/><StrRes Name="9177" Text="Если вы установите непустой пароль, создаваемый файл будет за' + 
'щищён этим паролем. Пароль всегда записывается символами Юникода и должен иметь м' + 
'енее 256 символов."/><StrRes Name="9178" Text="Подтверждение"/><StrRes Name="9179" Text="Подтверждение паро�' + 
'�я не совпадает с паролем. Введите пароль заново."/><StrRes Name="9180" Text="Попытка установит' + 
'ь пароль длиной %d символов. Максимальная длина пароля равна %d символов."/><StrRes Name="918' + 
'1" Text="Подобрать размер"/><StrRes Name="9182" Text="Экспорт в Excel 97/2000/XP"/><StrRes Name="9183" Text="Удалять п�' + 
'�стые строки"/><StrRes Name="9184" Text="Экспортировать формулы"/><StrRes Name="expMailAddr" Text="Address or addresses' + 
' delimited by comma"/><StrRes Name="BiffCol" Text="Resizing columns"/><StrRes Name="BiffRow" Text="Resizing rows"/><StrRes Name="BiffCell" Text="Expor' + 
'ting cells"/><StrRes Name="BiffImg" Text="Exporting pictures"/><StrRes Name="9200" Text="Microsoft Excel 2007 XML"/><StrRes Name="9201" Text="Microsof' + 
't PowerPoint 2007 XML"/><StrRes Name="9203" Text="Microsoft Word 2007 XML"/><StrRes Name="9300" Text="HTML Layered"/><StrRes Name="9301" Text="HTML fi' + 
'les (*.html)|*.html|All files|*.*"/><StrRes Name="9302" Text="HTML Layered Export"/><StrRes Name="9303" Text="HTML5 Layered"/><StrRes Name="9304" Text' + 
'="HTML4 Layered"/><StrRes Name="9400" Text="Reordering components"/><StrRes Name="9401" Text="Rendering components"/><StrRes Name="9402" Text="Adjusti' + 
'ng intersecting components"/><StrRes Name="9403" Text="Removing empty rows"/><StrRes Name="9404" Text="Adjusting frames"/><StrRes Name="9405" Text="Sp' + 
'litting big cells"/><StrRes Name="9406" Text="Composing BIFF file"/><StrRes Name="xProto" Text="Export Prototype"/><StrRes Name="xBlank" Text="Blank E' + 
'xport"/></Resources>' + 
' ';

initialization
  frxResources.AddXML(resXML);

end.
