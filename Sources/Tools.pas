unit Tools;

interface

uses DBGrids, Main, Graphics, Windows, FireDAC.Comp.Client, Data.DB, System.Variants, Vcl.Forms,
  System.Classes, System.SysUtils, ComObj, Vcl.Dialogs, System.UITypes, EditExpression,
  ShellAPI, Vcl.Grids, DataModule, Vcl.StdCtrls, GlobsAndConst;

// Общий тип классификации форм
type
  TKindForm = (kdNone, kdInsert, kdEdit, kdSelect);

  //Выполнение медленных запросов к базе в отдельном потоке
  TThreadQuery = class(TThread)
  private
    FHandle: HWND;
    FQrTemp: TFDQuery;
    FConnect: TFDConnection;
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create(const ASQLText: string; AHandle: HWND);
    destructor Destroy; override;
  end;

  // Пропорциональная автоширина колонок в таблице
procedure FixDBGridColumnsWidth(const DBGrid: TDBGrid);
// Установка стиля таблицы из формы настроек
procedure LoadDBGridSettings(const DBGrid: TDBGrid);
// Процедура рисования чекбокса на гриде
procedure DrawGridCheckBox(Canvas: TCanvas; Rect: TRect; Checked: boolean);
// Процедура переоткрытия запроса TFDQuery с локейтом на значение Поля[0]
procedure CloseOpen(const Query: TFDQuery; ADisableControls: boolean = True);
// Процедура загрузки стилей всех таблиц на форме
procedure LoadDBGridsSettings(const aForm: TForm);
// Функция проверки TDataSet на активность и пустоту
function CheckQrActiveEmpty(const ADataSet: TDataSet): boolean;
// Функция вычисления формулы из строки !!!РАБОТАЕТ ЧЕРЕЗ OLE EXCEL - в дальнейшем переписать!
function CalcFormula(const AFormula: string): Variant;
// Удаление директории с содержимым !!!!Использовать остородно!!!!!
procedure KillDir(const ADirName: string);
// Запускает процесс и ждет его завершения
function WinExecAndWait(AAppName, ACmdLine: PChar; ACmdShow: Word; ATimeout: DWord;
  var AWaitResult: DWord): boolean;
// Функция получения значения из справочника ежемесячных величин
function GetUniDictParamValue(const AParamName: string; const AMonth, AYear: Integer): Variant;
// Функция подсчета итога по датасету. Возвращает вариантный одномерный массив соответствующий набору колонок
function CalcFooterSumm(const Query: TFDQuery): Variant;

function MyFloatToStr(Value: Extended): string;
function MyStrToFloat(Value: string): Extended;
function MyStrToFloatDef(Value: string; DefRes: Extended): Extended;
function MyCurrToStr(Value: Currency): string;
function MyStrToCurr(Value: string): Currency;

implementation

{ TThreadQuery }

//Выполняет медленный SQL в отдельном потоке
constructor TThreadQuery.Create(const ASQLText: String; AHandle: HWND);
begin
  inherited Create(true);
  FHandle := AHandle;

  FConnect := TFDConnection.Create(nil);
  FConnect.Params.Text := G_CONNECTSTR;
  FQrTemp := TFDQuery.Create(nil);
  FQrTemp.Connection := FConnect;
  FQrTemp.SQL.Text := ASQLText;

  FreeOnTerminate := True;
  Priority := tpLower;
  Resume;
end;

destructor TThreadQuery.Destroy;
begin
  FreeAndNil(FQrTemp);
  FreeAndNil(FConnect);
  inherited;
end;

procedure TThreadQuery.Execute;
begin
  inherited;
  try
    FQrTemp.Active := True;
    SendMessage(FHandle, WM_EXCECUTE, WParam(FQrTemp), LParam(nil));
  except
    on e: exception do
      SendMessage(FHandle, WM_EXCECUTE, WParam(nil), LParam(e));
  end;
end;

// Запускает приложение и ожидает его завершения
function WinExecAndWait(AAppName, ACmdLine: PChar; ACmdShow: Word; ATimeout: DWord;
  var AWaitResult: DWord): boolean;
var
  ProcInf: TProcessInformation;
  Start: TStartupInfo;
begin
  FillChar(Start, SizeOf(TStartupInfo), 0);
  with Start do
  begin
    cb := SizeOf(TStartupInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := ACmdShow;
  end;

  Result := CreateProcess(AAppName, ACmdLine, nil, nil, False, NORMAL_PRIORITY_CLASS, nil, nil,
    Start, ProcInf);

  if ATimeout = 0 then
    repeat
    begin
      AWaitResult := WaitForSingleObject(ProcInf.hProcess, 2000);
      Application.ProcessMessages;
    end;
    until AWaitResult <> WAIT_TIMEOUT
  else
    AWaitResult := WaitForSingleObject(ProcInf.hProcess, ATimeout);

  TerminateProcess(ProcInf.hProcess, 0);
  CloseHandle(ProcInf.hProcess);
end;

// Удаление директории с содержимым
procedure KillDir(const ADirName: string);
var
  FileFolderOperation: TSHFileOpStruct;
begin
  FillChar(FileFolderOperation, SizeOf(FileFolderOperation), 0);
  FileFolderOperation.wFunc := FO_DELETE;
  FileFolderOperation.pFrom := PChar(ExcludeTrailingPathDelimiter(ADirName) + #0);
  FileFolderOperation.fFlags := FOF_SILENT or FOF_NOERRORUI or FOF_NOCONFIRMATION;
  SHFileOperation(FileFolderOperation);
end;

function CalcFormula(const AFormula: string): Variant;
var
  Res: Variant;
  flNoError: boolean;
  f: string;

  procedure Formula(Formula_Text: string; var Formula_Val: Variant; var flag1: boolean);
  var
    E, Sheet, MyCell: Variant;
  begin
    flag1 := False;
    if Formula_Text[1] <> '=' then
      Formula_Text := '=' + Formula_Text;
    try
      // Если Excel загружен, то подключиться к нему
      E := GetActiveOLEObject('Excel.Application');
    except
      // Иначе Создать объект MS Excel
      E := CreateOLEObject('Excel.Application');
    end;
    E.WorkBooks.Add; // Добавить книгу MS Excel
    Sheet := E.Sheets.Item[1]; // Перейти на первую страницу книги
    MyCell := Sheet.Cells[1, 1]; // Определить ячейку для занесения формулы
    MyCell.Value := Formula_Text; // Заносим формулу
    Formula_Val := MyCell.Value; // Вычисляем формулу
    if (VarIsFloat(Formula_Val) = False) or (VarIsNumeric(Formula_Val) = False) then
    begin
      MessageDlg('Внимание! Ошибка в формуле: ', mtWarning, [mbOk], 0, mbOk);
      flag1 := False;
    end
    else
      flag1 := True; // расчет выполнен правильно, без ошибок
    E.DisplayAlerts := False;
    try
      E.Quit; // Выйти из созданного Excel
      E := UnAssigned; // Освободить память
    except
    end;
  end;

begin
  Result := Null;
  f := AnsiUpperCase(ShowEditExpression);
  StringReplace(f, ',', '.', [rfReplaceAll]);
  Formula(Trim(f), Res, flNoError);
  if flNoError then
    Result := Res;
end;

function CheckQrActiveEmpty(const ADataSet: TDataSet): boolean;
begin
  Result := True;
  if not ADataSet.Active or ADataSet.IsEmpty then
    Result := False;
end;

procedure LoadDBGridsSettings(const aForm: TForm);
var
  i: Integer;
begin
  for i := 0 to aForm.ComponentCount do
    if (aForm.Components[i].ClassName = 'TDBGrid') or (aForm.Components[i].ClassName = 'TJvDBGrid') then
      LoadDBGridSettings((aForm.Components[i] as TDBGrid));
end;

procedure CloseOpen(const Query: TFDQuery; ADisableControls: boolean = True);
var
  Key: Variant;
  // E: TDataSetNotifyEvent;
begin
  // E := Query.AfterScroll;
  if ADisableControls then
    Query.DisableControls;
  try
    // Query.AfterScroll := nil;
    Key := Null;
    if CheckQrActiveEmpty(Query) then
      Key := Query.Fields[0].Value;
    Query.Active := False;
    Query.Active := True;
    if Key <> Null then
      Query.Locate(Query.Fields[0].FieldName, Key, []);
  finally
    // Query.AfterScroll := E;
    if ADisableControls then
      Query.EnableControls;
  end;
end;

function CalcFooterSumm(const Query: TFDQuery): Variant;
var
  Key: Variant;
  E: TDataSetNotifyEvent;
  Res: Variant;
  i: Integer;
begin
  Result := Null;
  E := Query.AfterScroll;
  Query.DisableControls;
  try
    // Выключаем событие на всякий случай
    Query.AfterScroll := nil;
    Key := Null;
    if CheckQrActiveEmpty(Query) then
      Key := Query.Fields[0].Value;
    // Создаем массив возвращаемых значений
    Res := VarArrayCreate([0, Query.FieldCount - 1], varDouble);
    // Инициализируем начальными значениями
    for i := 0 to Query.FieldCount - 1 do
      Res[i] := 0;

    Query.First;
    while not Query.Eof do
    begin
      for i := 0 to Query.FieldCount - 1 do
        if (Query.Fields[i].DataType in [ftInteger, ftFloat, ftBCD, ftFMTBcd, ftLargeint]) and
          not(VarIsNull(Query.Fields[i].Value)) then
          Res[i] := Res[i] + Query.Fields[i].AsFloat;
      Query.Next;
    end;

    // for i := 0 to Query.FieldCount - 1 do ShowMessage(FloatToStr(Res[i]));

    if Key <> Null then
      Query.Locate(Query.Fields[0].FieldName, Key, []);
    Result := Res;
  finally
    Query.AfterScroll := E;
    Query.EnableControls;
  end;
end;

// Пропорциональная автоширина колонок в таблице
procedure FixDBGridColumnsWidth(const DBGrid: TDBGrid);
const
  MIN_WHIDTH = 10;
var
  i: Integer;
  TotWidth: Integer;
  VarWidth: Integer;
  ResizableColumnCount: Integer;
  AColumn: TColumn;
begin
  TotWidth := 0;
  ResizableColumnCount := 0;

  for i := 0 to -1 + DBGrid.Columns.Count do
  begin
    TotWidth := TotWidth + DBGrid.Columns[i].Width;
    // if DBGrid.Columns[i].Field.Tag <> 0 then
    Inc(ResizableColumnCount);
  end;

  if dgColLines in DBGrid.Options then
    TotWidth := TotWidth + DBGrid.Columns.Count;

  // add indicator column width
  if dgIndicator in DBGrid.Options then
    TotWidth := TotWidth + IndicatorWidth;

  VarWidth := DBGrid.ClientWidth - TotWidth;

  if ResizableColumnCount > 0 then
    VarWidth := VarWidth div ResizableColumnCount;

  for i := 0 to -1 + DBGrid.Columns.Count do
  begin
    AColumn := DBGrid.Columns[i];
    // if AColumn.Field.Tag <> 0 then
    begin
      AColumn.Width := AColumn.Width + VarWidth;
      if AColumn.Width < MIN_WHIDTH then
        AColumn.Width := MIN_WHIDTH;
    end;
  end;
end;

// Установка стиля таблицы из формы настроек
procedure LoadDBGridSettings(const DBGrid: TDBGrid);
begin
  DBGrid.DrawingStyle := gdsClassic;
  DBGrid.FixedColor := PS.BackgroundHead;
  DBGrid.TitleFont.Color := PS.FontHead;
  DBGrid.Color := PS.BackgroundRows;
  DBGrid.Font.Color := PS.FontRows;
  {
    DBGrid.TitleFont.
    with (Sender as TStringGrid) do
    begin
    // Прорисовка шапки таблицы
    if ARow = 0 then
    begin
    Canvas.Brush.Color := PS.BackgroundHead;
    Canvas.FillRect(Rect);
    Canvas.Font.Color := PS.FontHead;
    Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);
    end
    else
    // Прорисовка всех остальных строк
    begin
    Canvas.Brush.Color := PS.BackgroundRows;
    Canvas.FillRect(Rect);
    Canvas.Font.Color := PS.FontRows;
    Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);
    end;

    // Для выделенной строки в активной (в фокусе) таблице
    if focused and (Row = ARow) and (Row > 0) then
    begin
    Canvas.Brush.Color := PS.BackgroundSelectRow;
    Canvas.FillRect(Rect);
    Canvas.Font.Color := PS.FontSelectRow;
    Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, Row]);
    end
    end;
  }
end;

// Процедури рисования чекбокса на гриде
procedure DrawGridCheckBox(Canvas: TCanvas; Rect: TRect; Checked: boolean);
var
  DrawFlags: Integer;
begin
  Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, ' ');
  DrawFrameControl(Canvas.Handle, Rect, DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_ADJUSTRECT);
  DrawFlags := DFCS_BUTTONCHECK or DFCS_ADJUSTRECT; // DFCS_BUTTONCHECK
  if Checked then
    DrawFlags := DrawFlags or DFCS_CHECKED;
  DrawFrameControl(Canvas.Handle, Rect, DFC_BUTTON, DrawFlags);
end;

function MyFloatToStr(Value: Extended): string;
var
  DS: Char;
begin
  DS := FormatSettings.DecimalSeparator;
  try
    FormatSettings.DecimalSeparator := '.';
    Result := FloatToStr(Value);
  finally
    FormatSettings.DecimalSeparator := DS;
  end;
end;

function MyStrToFloat(Value: string): Extended;
var
  DS: Char;
begin
  DS := FormatSettings.DecimalSeparator;
  try
    FormatSettings.DecimalSeparator := '.';
    if not TextToFloat(Value, Result, FormatSettings) then
    begin
      FormatSettings.DecimalSeparator := ',';
      Result := StrToFloat(Value);
    end;
  finally
    FormatSettings.DecimalSeparator := DS;
  end;
end;

function MyCurrToStr(Value: Currency): string;
var
  DS: Char;
begin
  DS := FormatSettings.DecimalSeparator;
  try
    FormatSettings.DecimalSeparator := '.';
    Result := CurrToStr(Value);
  finally
    FormatSettings.DecimalSeparator := DS;
  end;
end;

function MyStrToCurr(Value: string): Currency;
var
  DS: Char;
begin
  DS := FormatSettings.DecimalSeparator;
  try
    FormatSettings.DecimalSeparator := '.';
    if not TextToFloat(Value, Result, FormatSettings) then
    begin
      FormatSettings.DecimalSeparator := ',';
      Result := StrToCurr(Value);
    end;
  finally
    FormatSettings.DecimalSeparator := DS;
  end;
end;

function MyStrToFloatDef(Value: string; DefRes: Extended): Extended;
var
  DS: Char;
begin
  DS := FormatSettings.DecimalSeparator;
  try
    FormatSettings.DecimalSeparator := '.';
    if not TextToFloat(Value, Result, FormatSettings) then
    begin
      FormatSettings.DecimalSeparator := ',';
      if not TextToFloat(Value, Result, FormatSettings) then
        Result := DefRes;
    end;
  finally
    FormatSettings.DecimalSeparator := DS;
  end;
end;

function GetUniDictParamValue(const AParamName: string; const AMonth, AYear: Integer): Variant;
var
  qr: TFDQuery;
begin
  qr := TFDQuery.Create(nil);
  try
    qr.Connection := DM.Connect;
    qr.UpdateTransaction := DM.Write;
    qr.Transaction := DM.Read;
    qr.SQL.Text := 'SELECT `FN_getParamValue`(:inPARAM_CODE, :inMONTH, :inYEAR) AS res;';
    qr.ParamByName('inPARAM_CODE').AsString := AParamName;
    qr.ParamByName('inMONTH').AsInteger := AMonth;
    qr.ParamByName('inYEAR').AsInteger := AYear;
    qr.Active := True;
    Result := qr.FieldByName('res').AsVariant;
    qr.Active := False;
  finally
    FreeAndNil(qr);
  end;
end;

end.
