unit Tools;

interface

uses DBGrids, Main, Graphics, Windows, FireDAC.Comp.Client, Data.DB, System.Variants, Vcl.Forms,
  System.Classes, System.SysUtils, ComObj, Vcl.Dialogs, System.UITypes, EditExpression,
  ShellAPI, Vcl.Grids, DataModule, Vcl.StdCtrls, Vcl.Clipbrd, GlobsAndConst, JvDBGrid, FireDAC.Stan.Option,
  FireDAC.Stan.Param;

// Общий тип классификации форм
type
  TKindForm = (kdNone, kdInsert, kdEdit, kdSelect);

  // Будующий класс формы для наследования всех форм
  TSmForm = class(TForm)
  private
  protected
  public
    FormKind: TKindForm;
  end;

  TActivateEvent = procedure (ADataSet: TDataSet; ATag: Integer) of object;

  // Выполнение медленных запросов к базе в отдельном потоке
  TThreadQuery = class(TThread)
  private
    FHandle: HWND;
    FSQLText: string;
    FTag: Integer;

    FOnActivate: TActivateEvent;
    { Private declarations }
  protected
    procedure Execute; override;
  public
    //Свойства не потокобезопасные, записывать можно только когда поток приостановлен
    property SQLText: string read FSQLText write FSQLText;
    property OnActivate: TActivateEvent read FOnActivate write FOnActivate;
    property Tag: Integer read FTag;

    constructor Create(const ASQLText: string; AHandle: HWND;
      ACreateSuspended: Boolean; ATag: Integer = 0);
  end;

  TSmClipData = class
  public
    SmClipArray: array of TSmClipRec;
    procedure CopyToClipBoard;
    procedure GetFromClipBoard;
  end;

  // Пропорциональная автоширина колонок в таблице
procedure FixDBGridColumnsWidth(const DBGrid: TDBGrid);
// Установка стиля таблицы из формы настроек
procedure LoadDBGridSettings(const DBGrid: TJvDBGrid);
// Процедура рисования чекбокса на гриде
procedure DrawGridCheckBox(Canvas: TCanvas; Rect: TRect; Checked: boolean);

// Удаление директории с содержимым !!!!Использовать остородно!!!!!
procedure KillDir(const ADirName: string);
// Запускает процесс и ждет его завершения
function WinExecAndWait(AAppName, ACmdLine: PChar; ATimeout: DWord;
  var AWaitResult: DWord): boolean;
// Обновляет итератор, использовать при добавлении, вставке и удалении из сметы
function UpdateIterator(ADestSmID, AIterator, AFromRate: Integer): Integer;

/// Функции работы с БД:
/// ASelectSQL - 'SELECT FIELD FROM TABLE'
/// AExecSQL - 'DELETE FROM TABLE'
/// AParams - VarArrayOf([a,b,c,d...]) || VarArrayOf([]), если запрос без параметров
// Функция быстрого выполнения запроса, возвращает назад единственное полученное значение (Выборка)
function FastSelectSQLOne(const ASelectSQL: string; const AParams: Variant): Variant;
// Функция быстрого выполнения запроса, назад ничего не возвращает (Для обновлений и пр.)
procedure FastExecSQL(const AExecSQL: string; const AParams: Variant);
// Процедура переоткрытия запроса TFDQuery с локейтом на значение Поля[0]
procedure CloseOpen(const Query: TFDQuery; ADisableControls: boolean = True);
// Функция проверки TDataSet на активность и пустоту
function CheckQrActiveEmpty(const ADataSet: TDataSet): boolean;
// Функция получения значения из справочника ежемесячных величин
function GetUniDictParamValue(const AParamName: string; const AMonth, AYear: Integer): Variant;
// Функция подсчета итога по датасету. Возвращает вариантный одномерный массив соответствующий набору колонок
function CalcFooterSumm(const Query: TFDQuery): Variant;

function MyFloatToStr(Value: Extended): string;
function MyStrToFloat(Value: string): Extended;
function MyStrToFloatDef(Value: string; DefRes: Extended): Extended;
function MyCurrToStr(Value: Currency): string;
function MyStrToCurr(Value: string): Currency;

// Функция смешания двух цветов
function MixColors(FG, BG: TColor; T: byte): TColor;
// Выполнение командной строки
procedure Exec(AParam: string);

implementation

function Expand(const AParam: string): string;
var buf : array[0..$FF] of char;
    Size : integer;
begin
  Size := ExpandEnvironmentStrings(PChar(AParam), buf, sizeof(buf));
  Result := copy(buf, 1, Size);
end;

procedure Exec(AParam: string);
begin
  AParam := Expand(AParam);
  ShellExecute(Application.Handle, 'open', PChar(AParam), nil, nil, SW_SHOWMAXIMIZED);
end;

// Выполняет медленный SQL в отдельном потоке
constructor TThreadQuery.Create(const ASQLText: string; AHandle: HWND;
  ACreateSuspended: Boolean; ATag: Integer = 0);
begin
  FHandle := AHandle;
  FTag := ATag;
  FSQLText := ASQLText;
  inherited Create(ACreateSuspended);
end;

procedure TThreadQuery.Execute;
var TmpConnect: TFDConnection;
    TmpTrans: TFDTransaction;
    TmpQuery: TFDQuery;
begin
  TmpConnect := nil;
  TmpTrans := nil;
  TmpQuery := nil;
  try
    TmpConnect := TFDConnection.Create(nil);
    TmpConnect.Params.Text := G_CONNECTSTR;

    TmpTrans := TFDTransaction.Create(nil);
    TmpTrans.Connection := TmpConnect;

    TmpQuery := TFDQuery.Create(nil);
    TmpQuery.Connection := TmpConnect;
    TmpQuery.SQL.Text := FSQLText;

    TmpConnect.Connected := True;
    TmpQuery.Active := True;

    if Terminated then
      Exit;

    if FHandle > 0 then
      SendMessage(FHandle, WM_EXCECUTE, WParam(TmpQuery), LParam(FTag));

    if Terminated then
      Exit;

    if Assigned(OnActivate) then
      OnActivate(TmpQuery, FTag);
  finally
    if Assigned(TmpConnect) then
      FreeAndNil(TmpConnect);
    if Assigned(TmpTrans) then
      FreeAndNil(TmpTrans);
    if Assigned(TmpQuery) then
      FreeAndNil(TmpQuery);
  end;
end;

{ TSmClipData }
procedure TSmClipData.CopyToClipBoard;
var
  Data: THandle;
  DataPtr: Pointer;
  i: Integer;
begin
  if Length(SmClipArray) = 0 then
    Exit;

  Data := GlobalAlloc(GMEM_MOVEABLE, SizeOf(Integer) + SizeOf(TSmClipRec) * Length(SmClipArray));
  try
    DataPtr := GlobalLock(Data);
    try
      i := Length(SmClipArray);
      Move(i, DataPtr^, SizeOf(Integer));
      DataPtr := Ptr(Cardinal(DataPtr) + SizeOf(Integer));
      Move(SmClipArray[0], DataPtr^, SizeOf(TSmClipRec) * Length(SmClipArray));
      ClipBoard.SetAsHandle(G_SMETADATA, Data);
    finally
      GlobalUnlock(Data);
    end;
  except
    GlobalFree(Data);
    raise;
  end;
end;

procedure TSmClipData.GetFromClipBoard;
var
  Data: THandle;
  DataPtr: Pointer;
  i: Integer;
begin
  Data := ClipBoard.GetAsHandle(G_SMETADATA);
  if Data = 0 then
    Exit;
  DataPtr := GlobalLock(Data);
  try
    Move(DataPtr^, i, SizeOf(Integer));
    SetLength(SmClipArray, i);
    if i = 0 then
      Exit;
    DataPtr := Ptr(Cardinal(DataPtr) + SizeOf(Integer));
    Move(DataPtr^, SmClipArray[0], SizeOf(TSmClipRec) * Length(SmClipArray));
  finally
    GlobalUnlock(Data);
  end;
end;

function FastSelectSQLOne(const ASelectSQL: string; const AParams: Variant): Variant;
var
  qr: TFDQuery;
  i: Integer;
begin
  Result := Null;
  qr := TFDQuery.Create(nil);
  try
    // Получаем только 1 запись
    qr.FetchOptions.AutoFetchAll := afDisable;
    qr.FetchOptions.RowsetSize := 1;
    qr.Connection := DM.Connect;
    qr.UpdateTransaction := DM.Write;
    qr.Transaction := DM.Read;
    qr.SQL.Text := ASelectSQL;
    if VarArrayHighBound(AParams, 1) <> (qr.ParamCount - 1) then
    begin
      ShowMessage('Передано неверное число параметров!');
      Exit;
    end;
    // Заполняем запрос параметрами
    for i := 0 to qr.ParamCount - 1 do
      qr.Params.Items[i].Value := AParams[i];
    qr.Active := True;
    qr.First;
    if qr.FieldCount > 0 then
      Result := qr.Fields[0].Value;
    qr.Active := False;
  finally
    FreeAndNil(qr);
  end;
end;

procedure FastExecSQL(const AExecSQL: string; const AParams: Variant);
var
  qr: TFDQuery;
  i: Integer;
begin
  qr := TFDQuery.Create(nil);
  try
    qr.Connection := DM.Connect;
    qr.UpdateTransaction := DM.Write;
    qr.Transaction := DM.Read;
    qr.SQL.Text := AExecSQL;
    if VarArrayHighBound(AParams, 1) <> (qr.ParamCount - 1) then
    begin
      ShowMessage('Передано неверное число параметров!');
      Exit;
    end;
    // Заполняем запрос параметрами
    for i := 0 to qr.ParamCount - 1 do
      qr.Params.Items[i].Value := AParams[i];
    qr.ExecSQL;
  finally
    FreeAndNil(qr);
  end;
end;

// Запускает приложение и ожидает его завершения
function WinExecAndWait(AAppName, ACmdLine: PChar; ATimeout: DWord;
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
    wShowWindow := SW_HIDE;
  end;

  Result := CreateProcess(AAppName, ACmdLine, nil, nil, False,
    NORMAL_PRIORITY_CLASS, nil, nil, Start, ProcInf);

  if ATimeout = 0 then
    ATimeout := INFINITE;

  AWaitResult := WaitForSingleObject(ProcInf.hProcess, ATimeout);

  //В любом случае идет попытка унитожения процесса
  TerminateProcess(ProcInf.hProcess, 0);

  CloseHandle(ProcInf.hProcess);
  CloseHandle(ProcInf.hThread);
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

function CheckQrActiveEmpty(const ADataSet: TDataSet): boolean;
begin
  Result := True;
  if not ADataSet.Active or ADataSet.IsEmpty then
    Result := False;
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
  e: TDataSetNotifyEvent;
  Res: Variant;
  i: Integer;
begin
  Result := Null;
  if not CheckQrActiveEmpty(Query) then
    Exit;

  e := Query.AfterScroll;
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

    if Key <> Null then
      Query.Locate(Query.Fields[0].FieldName, Key, []);
    Result := Res;
  finally
    Query.AfterScroll := e;
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
procedure LoadDBGridSettings(const DBGrid: TJvDBGrid);
begin
  DBGrid.DrawingStyle := gdsClassic;
  DBGrid.FixedColor := PS.BackgroundHead;
  DBGrid.TitleFont.Color := PS.FontHead;
  DBGrid.Color := PS.BackgroundRows;
  DBGrid.Font.Color := PS.FontRows;
  DBGrid.SelectColumn := scGrid;
  DBGrid.TitleArrow := True;
  DBGrid.TitleButtons := True;
  DBGrid.ShowCellHint := True;
  DBGrid.ShowHint := True;
  // DBGrid.ShowTitleHint := True;
  DBGrid.SelectColumnsDialogStrings.NoSelectionWarning := 'Должна быть выбрана хотя бы одна колонка!';
  DBGrid.SelectColumnsDialogStrings.Caption := 'Настройка видимости колонок';
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
begin
  Result := FastSelectSQLOne('SELECT `FN_getParamValue`(:inPARAM_CODE, :inMONTH, :inYEAR)',
    VarArrayOf([AParamName, AMonth, AYear]));
end;

function UpdateIterator(ADestSmID, AIterator, AFromRate: Integer): Integer;
begin
  Result := FastSelectSQLOne('Select UpdateIterator(:IdEstimate, :AIterator, :AFromRate)',
    VarArrayOf([ADestSmID, AIterator, AFromRate]));
end;

function MixColors(FG, BG: TColor; T: byte): TColor;
  function MixBytes(FG, BG, TRANS: byte): byte;
  begin
    Result := round(BG + (FG - BG) / 255 * TRANS);
  end;

var
  r, g, b: byte;
begin
  r := MixBytes(FG and 255, BG and 255, T); // extracting and mixing Red
  g := MixBytes((FG shr 8) and 255, (BG shr 8) and 255, T); // the same with green
  b := MixBytes((FG shr 16) and 255, (BG shr 16) and 255, T); // and blue, of course
  Result := r + g * 256 + b * 65536; // finishing with combining all channels together
end;

initialization

// Регистрируем собственный формат для буфера обмена
G_SMETADATA := RegisterClipBoardFormat(C_SMETADATA);

end.
