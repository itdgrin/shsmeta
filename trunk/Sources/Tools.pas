unit Tools;

interface

uses DBGrids, Main, Graphics, Windows, FireDAC.Comp.Client, Data.DB, System.Variants, Vcl.Forms,
  System.Classes, System.SysUtils, ComObj, Vcl.Dialogs, System.UITypes, EditExpression,
  ShellAPI;

// Пропорциональная автоширина колонок в таблице
procedure FixDBGridColumnsWidth(const DBGrid: TDBGrid);
// Установка стиля таблицы из формы настроек
procedure LoadDBGridSettings(const DBGrid: TDBGrid);
// Процедура рисования чекбокса на гриде
procedure DrawGridCheckBox(Canvas: TCanvas; Rect: TRect; Checked: boolean);
// Процедура переоткрытия запроса TFDQuery
procedure CloseOpen(const Query: TFDQuery);
// Процедура загрузки стилей всех таблиц на форме
procedure LoadDBGridsSettings(const aForm: TForm);
// Функция проверки TDataSet на активность и пустоту
function CheckQrActiveEmpty(const ADataSet: TDataSet): boolean;
// Функция вычисления формулы из строки !!!РАБОТАЕТ ЧЕРЕЗ OLE EXCEL - в дальнейшем переписать!
function CalcFormula(const AFormula: string): Variant;
//Удаление директории с содержимым !!!!Использовать остородно!!!!!
procedure KillDir(const ADirName: string);
//Запускает процесс и ждет его завершения
function WinExecAndWait(ACmdLine: PChar; ACmdShow: Word; ATimeout: DWord;
  var AWaitResult: DWord; var AExitCode: Cardinal): boolean;

implementation


//Запускает приложение и ожидает его завершения
function WinExecAndWait(ACmdLine: PChar; ACmdShow: Word; ATimeout: DWord;
  var AWaitResult: DWord; var AExitCode: Cardinal): boolean;
var ProcInf: TProcessInformation;
    Start: TStartupInfo;
begin
    FillChar(Start, SizeOf(TStartupInfo), 0);
    with Start do
    begin
        cb := SizeOf(TStartupInfo);
        dwFlags := STARTF_USESHOWWINDOW;
        wShowWindow := CmdShow;
    end;

    Result := CreateProcess(nil, ACmdLine, nil, nil,
      False, NORMAL_PRIORITY_CLASS, nil, nil, Start, ProcInf);

    if ATimeOut=0 then
      AWaitResult := WaitForSingleObject(ProcInf.hProcess, INFINITE)
    else
      AWaitResult := WaitForSingleObject(ProcInf.hProcess, ATimeout);

    GetExitCodeProcess(ProcInf.hProcess, AExitCode);
    TerminateProcess(ProcInf.hProcess, 0);
    CloseHandle(ProcInf.hProcess);
end;


//Удаление директории с содержимым
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

procedure CloseOpen(const Query: TFDQuery);
var
  Key: Variant;
begin
  Query.DisableControls;
  try
    Key := Null;
    if CheckQrActiveEmpty(Query) then
      Key := Query.Fields[0].Value;
    Query.Active := False;
    Query.Active := True;
    if Key <> Null then
      Query.Locate(Query.Fields[0].FieldName, Key, []);
  finally
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

end.
