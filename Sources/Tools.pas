unit Tools;

interface

uses DBGrids, Main, Graphics, Winapi.Windows, Winapi.Messages, FireDAC.Comp.Client,
  Data.DB, System.Variants, Vcl.Forms, Vcl.DBCtrls, Vcl.Samples.Spin,
  JvSpin, JvDBSpinEdit, System.Classes, System.SysUtils, ComObj, Vcl.Dialogs,
  System.UITypes, ShellAPI, Vcl.Grids, DataModule, Vcl.StdCtrls, Vcl.Clipbrd,
  GlobsAndConst, JvDBGrid, FireDAC.Stan.Option, FireDAC.Stan.Param, Controls,
  Vcl.Buttons, Vcl.ComCtrls, VirtualTrees, Vcl.FileCtrl, System.Types, Registry;

// Общий тип классификации форм

type
  TKindForm = (kdNone, kdInsert, kdEdit, kdSelect);

  TGlobParamType = (gptReportParam, gptFormParam);

  // Для выноса в паблик некоторых свойств грида
  TMyDBGrid = class(TJvDBGrid)
  public
    property TopRow;
    property DataLink;
  end;

  // класс формы для наследования всех форм
  TSmForm = class(TForm)
    // Процедура стандартной сортировки таблиц
    procedure TitleBtnClick(Sender: TObject; ACol: Integer; Field: TField);
    // Процедура управляет показом скроллов в таблице
    procedure GridResize(Sender: TObject);
  private
    procedure WMUpdateFormStyle(var Mes: TMessage); message WM_UPDATEFORMSTYLE;
    procedure SetStyleForAllComponents(AComponent: TComponent);
    procedure JvDBGridSelectColumns(Grid: TJvDBGrid; var DefaultDialog: Boolean);
  protected
    HintButton: string; // Подсказка в кнопке на панели
    CaptionButton: string; // Название кнопки на панели
    InitParams: Variant; // Входные параметры
    procedure SetComponentStyle(AComponent: TComponent); virtual;
    // Если у формы наследника переопределе конструктор, то все компоненты
    // созданные в нем после вызова inherited не получат новый стиль
    // В этом случае в конце переопределенного конструктора надо вызвать SetFormStyle повторно
    procedure SetFormStyle; virtual;
  public
    FormKind: TKindForm;
    // Процедура стандартной отрисовки таблиц
    class procedure DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    constructor Create(AOwner: TComponent; const AInitParams: Variant); overload;
    constructor Create(AOwner: TComponent); overload; override;
  end;

  TActivateEvent = procedure(ADataSet: TDataSet; ATag: Integer) of object;

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
    // Свойства не потокобезопасные, записывать можно только когда поток приостановлен
    property SQLText: string read FSQLText write FSQLText;
    property OnActivate: TActivateEvent read FOnActivate write FOnActivate;
    property Tag: Integer read FTag;

    constructor Create(const ASQLText: string; AHandle: HWND; ACreateSuspended: Boolean; ATag: Integer = 0);
  end;

  TSmClipData = class
  private
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
procedure DrawGridCheckBox(Canvas: TCanvas; Rect: TRect; Checked: Boolean);

// Удаление директории с содержимым !!!!Использовать осторожно!!!!!
procedure KillDir(const ADirName: string);
// Запускает процесс и ждет его завершения
function WinExecAndWait(AAppName, ACmdLine: PChar; ATimeout: DWord; var AWaitResult: DWord): Boolean;
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
procedure CloseOpen(const Query: TFDQuery; ADisableControls: Boolean = True);
// Функция проверки TDataSet на активность и пустоту
function CheckQrActiveEmpty(const ADataSet: TDataSet): Boolean;
// Функция получения значения из справочника ежемесячных величин
function GetUniDictParamValue(const AParamName: string; const AMonth, AYear: Integer): Variant;
// Функция подсчета итога по датасету. Возвращает вариантный одномерный массив соответствующий набору колонок
function CalcFooterSumm(const Query: TFDQuery): Variant;
// Процедура сортировки для использования в событии TitleBtnClick
procedure DoSort(const Query: TFDQuery; Grid: TJvDBGrid);

function MyFloatToStr(Value: Extended): string;
function MyStrToFloat(Value: string): Extended;
function MyStrToFloatDef(Value: string; DefRes: Extended): Extended;
function MyCurrToStr(Value: Currency): string;
function MyStrToCurr(Value: string): Currency;

// Функция смешания двух цветов
function MixColors(FG, BG: TColor; T: byte): TColor;
// Выполнение командной строки
procedure Exec(AParam: string);
// Функция получения ширины текста в пикселях внутри окна
function GetTextWidth(Text: string; W: HWND): Integer;
// Киляет указанные символы из строки
function StripCharsInSet(s: string; c: TSysCharSet): string;

// "Тихие" операции надо объектами файловой системы
function FullRename(ASource, ATarget: string): Boolean;
function FullCopy(ASource, ATarget: string): Boolean;
function FullRemove(ASource: string): Boolean;
// Диалог выбора директории
function GetDirDialog(var ADir: string): Boolean;
// Функция выбора значения по условию
function IIF(BoolExpression: Boolean; ifTrue, ifFalse: Variant): Variant;
// Процедура добавления колонки в таблицу
procedure addCol(const Grid: TJvDBGrid; fieldName, titleCaption: String; const Width: Integer);

// Функции записи/чтения реестра:
procedure SetGlob(const AParamName: String; const AValue: Variant;
  const AGlobParamType: TGlobParamType = gptReportParam);
function GetGlob(const AParamName: String; const AGlobParamType: TGlobParamType = gptReportParam): Variant;
function GetGlobDef(const AParamName: String; const ADefValue: Variant;
  const AGlobParamType: TGlobParamType = gptReportParam): Variant;

// Округления для расчетов в программе
function SmRound(AValue: Extended): Extended;

implementation

uses uSelectColumn;

// Заготовка пустышка
function SmRound(AValue: Extended): Extended;
begin
  Result := Round(AValue);
end;

procedure SetGlob(const AParamName: String; const AValue: Variant;
  const AGlobParamType: TGlobParamType = gptReportParam);
var
  Reg: TRegistry;
  CurKey: string;
begin
  Reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    Reg.RootKey := C_REGROOT;
    case AGlobParamType of
      gptReportParam:
        CurKey := C_REGKEY + '\Report\Params';
      gptFormParam:
        CurKey := C_REGKEY + '\Forms';
    end;
    Reg.OpenKey(CurKey, True);
    try
      case VarType(AValue) of
        varByte, varSmallint, varInteger, varLongWord:
          Reg.WriteInteger(AParamName, AValue);
        varSingle, varDouble:
          Reg.WriteFloat(AParamName, AValue);
        varCurrency:
          Reg.WriteCurrency(AParamName, AValue);
        varDate:
          Reg.WriteDateTime(AParamName, AValue);
        varBoolean:
          Reg.WriteBool(AParamName, AValue);
        varOleStr, varStrArg, varString:
          Reg.WriteString(AParamName, AValue);
      else
        Reg.WriteInteger(AParamName, AValue);
      end;
      Reg.WriteInteger(AParamName + '()', VarType(AValue));
    finally
      Reg.CloseKey;
      FreeAndNil(Reg);
    end;
  except
  end;
end;

function GetGlobDef(const AParamName: String; const ADefValue: Variant;
  const AGlobParamType: TGlobParamType = gptReportParam): Variant;
var
  K: Integer;
  s: String;
  Reg: TRegistry;
  CurKey: string;
begin
  Result := Null;
  Reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    case AGlobParamType of
      gptReportParam:
        CurKey := C_REGKEY + '\Report\Params';
      gptFormParam:
        CurKey := C_REGKEY + '\Forms';
    end;
    Reg.OpenKey(CurKey, True);
    try
      s := AParamName + '()';
      if Reg.ValueExists(s) then
      begin
        K := Reg.ReadInteger(s);
        case K of
          varByte, varSmallint, varInteger, varLongWord:
            Result := Reg.ReadInteger(AParamName);
          varSingle, varDouble:
            Result := Reg.ReadFloat(AParamName);
          varCurrency:
            Result := Reg.ReadCurrency(AParamName);
          varDate:
            Result := Reg.ReadDateTime(AParamName);
          varBoolean:
            Result := Reg.ReadBool(AParamName);
          varOleStr, varStrArg, varString:
            Result := Reg.ReadString(AParamName);
        end;
      end;
    finally
      Reg.CloseKey;
      FreeAndNil(Reg);
    end;
  except
  end;
  if VarIsNull(Result) then
    Result := ADefValue;
end;

function GetGlob(const AParamName: String; const AGlobParamType: TGlobParamType = gptReportParam): Variant;
begin
  Result := GetGlobDef(AParamName, Null, AGlobParamType);
end;

procedure addCol(const Grid: TJvDBGrid; fieldName, titleCaption: String; const Width: Integer);
var
  col: TColumn;
begin
  col := Grid.Columns.Add;
  col.Title.Caption := titleCaption;
  col.Title.Alignment := taCenter;
  col.Width := Width;
  col.fieldName := fieldName;
end;

function IIF(BoolExpression: Boolean; ifTrue, ifFalse: Variant): Variant;
begin
  if BoolExpression then
    Result := ifTrue
  else
    Result := ifFalse;
end;

function GetDirDialog(var ADir: string): Boolean;
{$WARN SYMBOL_PLATFORM OFF}
var
  TmpDialog: TFileOpenDialog; // TFileOpenDialog есть только в Vista и выше, нужен обычный TOpenDialog
begin
  Result := False;
  if Win32MajorVersion >= 6 then
  begin
    TmpDialog := TFileOpenDialog.Create(nil); // TOpenDialog
    try
      TmpDialog.Title := 'Выбор папки';
      TmpDialog.Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
      TmpDialog.OkButtonLabel := 'Выбор';
      TmpDialog.DefaultFolder := ADir;
      TmpDialog.FileName := TmpDialog.DefaultFolder;
      if TmpDialog.Execute then
      begin
        ADir := ExcludeTrailingPathDelimiter(TmpDialog.FileName);
        Result := True;
      end;
    finally
      FreeAndNil(TmpDialog);
    end
  end
  else
    Result := SelectDirectory('Select Directory', ExtractFileDrive(ADir), ADir, [sdNewUI, sdNewFolder]);
{$WARN SYMBOL_PLATFORM ON}
end;

function FullRename(ASource, ATarget: string): Boolean;
var
  SHFileOpStruct: TSHFileOpStruct;
begin
  FillChar(SHFileOpStruct, SizeOf(TSHFileOpStruct), 0);
  SHFileOpStruct.wFunc := FO_RENAME;
  SHFileOpStruct.pFrom := PChar(ExcludeTrailingPathDelimiter(ASource) + #0);
  SHFileOpStruct.pTo := PChar(ExcludeTrailingPathDelimiter(ATarget) + #0);
  SHFileOpStruct.fFlags := FOF_SILENT or FOF_NOCONFIRMATION or FOF_NOERRORUI;
  Result := SHFileOperation(SHFileOpStruct) = 0;
end;

function FullCopy(ASource, ATarget: string): Boolean;
var
  SHFileOpStruct: TSHFileOpStruct;
begin
  FillChar(SHFileOpStruct, SizeOf(TSHFileOpStruct), 0);
  SHFileOpStruct.wFunc := FO_COPY;
  SHFileOpStruct.pFrom := PChar(ExcludeTrailingPathDelimiter(ASource) + #0);
  SHFileOpStruct.pTo := PChar(ExcludeTrailingPathDelimiter(ATarget) + #0);
  SHFileOpStruct.fFlags := FOF_SILENT or FOF_NOCONFIRMATION or FOF_NOERRORUI;
  Result := SHFileOperation(SHFileOpStruct) = 0;
end;

function FullRemove(ASource: string): Boolean;
var
  SHFileOpStruct: TSHFileOpStruct;
begin
  FillChar(SHFileOpStruct, SizeOf(TSHFileOpStruct), 0);
  SHFileOpStruct.wFunc := FO_DELETE;
  SHFileOpStruct.pFrom := PChar(ExcludeTrailingPathDelimiter(ASource) + #0);
  SHFileOpStruct.fFlags := FOF_SILENT or FOF_NOCONFIRMATION or FOF_NOERRORUI;
  Result := SHFileOperation(SHFileOpStruct) = 0;
end;

function StripCharsInSet(s: string; c: TSysCharSet): string;
var
  i, j: Integer;
begin
  SetLength(Result, Length(s));
  j := 0;
  for i := 1 to Length(s) do
    if not CharInSet(s[i], c) then
    begin
      inc(j);
      Result[j] := s[i];
    end;
  SetLength(Result, j);
end;

function GetTextWidth(Text: string; W: HWND): Integer;
var
  DC: HDC;
  sz: SIZE;
begin
  DC := GetDC(W);
  GetTextExtentPoint32(DC, PChar(Text), Length(Text), sz);
  ReleaseDC(W, DC);
  Result := sz.cx;
end;

function Expand(const AParam: string): string;
var
  buf: array [0 .. $FF] of char;
  SIZE: Integer;
begin
  SIZE := ExpandEnvironmentStrings(PChar(AParam), buf, SizeOf(buf));
  Result := copy(buf, 1, SIZE);
end;

procedure Exec(AParam: string);
begin
  AParam := Expand(AParam);
  if FileExists(AParam) then
    ShellExecute(Application.Handle, 'open', PChar(AParam), nil, nil, SW_SHOWMAXIMIZED)
  else
    ShowMessage('Файл не найден.');

end;

procedure DoSort(const Query: TFDQuery; Grid: TJvDBGrid);
var
  s: string;
  { key: Variant; }
  i: Integer;
begin
  try
    if not CheckQrActiveEmpty(Query) then
      Exit;

    // Если выбранное поле не из набора, а расчетное или другое, то выходим...
    if (Grid.SortedField <> '') and (Query.FieldByName(Grid.SortedField).FieldKind <> fkData) then
      Exit;

    s := '';
    { key := Query.Fields[0].Value; }
    if Grid.SortMarker = smDown then
      s := ' DESC';

    // Пытаемся найти строку с запросом сортировки
    for i := Query.SQL.Count - 1 downto 0 do
    begin
      if Pos(UpperCase('order by'), UpperCase(Query.SQL[i])) <> 0 then
      begin
        // Строка найдена
        if Grid.SortedField <> '' then
        begin
          // Если сортируем некий код, то буквенные значения всегда выше в списке
          if Grid.SortedField = 'CODE' then
            Query.SQL[i] := 'ORDER BY CODE+1,' + Grid.SortedField + s
          else
            Query.SQL[i] := 'ORDER BY ' + Grid.SortedField + s;
        end
        else
          Query.SQL[i] := 'ORDER BY 1';
        CloseOpen(Query);
        Exit;
      end;
    end;
    if Grid.SortedField <> '' then
    begin
      if Grid.SortedField = 'CODE' then
        Query.SQL.Append('ORDER BY CODE+1' + Grid.SortedField + s)
      else
        Query.SQL.Append('ORDER BY ' + Grid.SortedField + s);
      CloseOpen(Query);
    end
    else
    begin
      Query.SQL.Append('ORDER BY 1');
      CloseOpen(Query);
    end;
    {
      Query.Active := True;
      if key <> Null then
      Query.Locate(Query.Fields[0].FieldName, key, []);
    }
  except

  end;
end;

// Выполняет медленный SQL в отдельном потоке
constructor TThreadQuery.Create(const ASQLText: string; AHandle: HWND; ACreateSuspended: Boolean;
  ATag: Integer = 0);
begin
  FHandle := AHandle;
  FTag := ATag;
  FSQLText := ASQLText;
  inherited Create(ACreateSuspended);
end;

procedure TThreadQuery.Execute;
var
  TmpConnect: TFDConnection;
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
      case VarType(AParams[i]) of
        varByte, varSmallint, varInteger, varLongWord:
          qr.Params.Items[i].AsInteger := AParams[i];
        varSingle, varDouble:
          qr.Params.Items[i].AsFloat := AParams[i];
        varCurrency:
          qr.Params.Items[i].AsCurrency := AParams[i];
        varDate:
          qr.Params.Items[i].AsDateTime := AParams[i];
        varBoolean:
          qr.Params.Items[i].AsBoolean := AParams[i];
        varOleStr, varStrArg, varString:
          qr.Params.Items[i].AsString := AParams[i];
      else
        qr.Params.Items[i].Value := AParams[i];
      end;
    // qr.Params.Items[i].Value := AParams[i];
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
    qr.ResourceOptions.ParamCreate := True;
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
    begin
      case VarType(AParams[i]) of
        varByte, varSmallint, varInteger, varLongWord:
          qr.Params.Items[i].AsInteger := AParams[i];
        varSingle, varDouble:
          qr.Params.Items[i].AsFloat := AParams[i];
        varCurrency:
          qr.Params.Items[i].AsCurrency := AParams[i];
        varDate:
          qr.Params.Items[i].AsDateTime := AParams[i];
        varBoolean:
          qr.Params.Items[i].AsBoolean := AParams[i];
        varOleStr, varStrArg, varString:
          qr.Params.Items[i].AsString := AParams[i];
      else
        qr.Params.Items[i].Value := AParams[i];
      end;
      { if VarIsNull(qr.Params.Items[i].Value) then
        qr.Params.Items[i].Clear; }

    end;
    // qr.Params.Items[i].Value := AParams[i];
    qr.ExecSQL;
  finally
    FreeAndNil(qr);
  end;
end;

// Запускает приложение и ожидает его завершения
function WinExecAndWait(AAppName, ACmdLine: PChar; ATimeout: DWord; var AWaitResult: DWord): Boolean;
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

  Result := CreateProcess(AAppName, ACmdLine, nil, nil, False, NORMAL_PRIORITY_CLASS, nil, nil,
    Start, ProcInf);

  if ATimeout = 0 then
    ATimeout := INFINITE;

  AWaitResult := WaitForSingleObject(ProcInf.hProcess, ATimeout);

  // В любом случае идет попытка унитожения процесса
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

function CheckQrActiveEmpty(const ADataSet: TDataSet): Boolean;
begin
  Result := True;
  if not ADataSet.Active or ADataSet.IsEmpty then
    Result := False;
end;

procedure CloseOpen(const Query: TFDQuery; ADisableControls: Boolean = True);
var
  key: Variant;
  // E: TDataSetNotifyEvent;
begin
  // E := Query.AfterScroll;
  if ADisableControls and not(Query.ControlsDisabled) then
    Query.DisableControls;
  try
    // Query.AfterScroll := nil;
    key := Null;
    if CheckQrActiveEmpty(Query) then
      key := Query.Fields[0].Value;
    Query.Active := False;
    Query.Active := True;
    if key <> Null then
      Query.Locate(Query.Fields[0].fieldName, key, []);
  finally
    // Query.AfterScroll := E;
    if ADisableControls and Query.ControlsDisabled then
      Query.EnableControls;
  end;
end;

function CalcFooterSumm(const Query: TFDQuery): Variant;
var
  key: Variant;
  e: TDataSetNotifyEvent;
  Res: Variant;
  i: Integer;
begin
  Result := Null;
  if not CheckQrActiveEmpty(Query) then
    Exit;

  e := Query.AfterScroll;
  if not Query.ControlsDisabled then
    Query.DisableControls;
  try
    // Выключаем событие на всякий случай
    Query.AfterScroll := nil;
    key := Query.Fields[0].Value;
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
          not(VarIsNull(Query.Fields[i].Value)) and
          ((Query.FindField('DELETED') = nil) or ((Query.FindField('DELETED') <> nil) and
          (Query.FindField('DELETED').Value = 0))) then
          Res[i] := Res[i] + Query.Fields[i].AsFloat;
      Query.Next;
    end;

    if key <> Null then
      Query.Locate(Query.Fields[0].fieldName, key, []);
    Result := Res;
  finally
    if Query.ControlsDisabled then
      Query.EnableControls;
    Query.AfterScroll := e;
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
    inc(ResizableColumnCount);
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
  if PS.GridFontName <> '' then
  begin
    DBGrid.Font.Name := PS.GridFontName;
    DBGrid.TitleFont.Name := PS.GridFontName;
  end;
  if PS.GridFontSize <> 0 then
  begin
    DBGrid.Font.SIZE := PS.GridFontSize;
    DBGrid.TitleFont.SIZE := PS.GridFontSize;
  end;
  DBGrid.Font.Style := TFontStyles(PS.GridFontStyle);
  DBGrid.TitleFont.Style := TFontStyles(PS.GridFontStyle);
end;

// Процедури рисования чекбокса на гриде
procedure DrawGridCheckBox(Canvas: TCanvas; Rect: TRect; Checked: Boolean);
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
  DS: char;
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
  DS: char;
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
  DS: char;
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
  DS: char;
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
  DS: char;
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
    Result := Round(BG + (FG - BG) / 255 * TRANS);
  end;

var
  r, g, b: byte;
begin
  r := MixBytes(FG and 255, BG and 255, T); // extracting and mixing Red
  g := MixBytes((FG shr 8) and 255, (BG shr 8) and 255, T); // the same with green
  b := MixBytes((FG shr 16) and 255, (BG shr 16) and 255, T); // and blue, of course
  Result := r + g * 256 + b * 65536; // finishing with combining all channels together
end;

{ TSmForm }

// procedure TSmForm.FormCreate(Sender: TObject);
constructor TSmForm.Create(AOwner: TComponent; const AInitParams: Variant);
begin
  InitParams := AInitParams; // Инициализационные параметны
  inherited Create(AOwner);
  SetFormStyle;
end;

constructor TSmForm.Create(AOwner: TComponent);
begin
  Create(AOwner, Null);
end;

procedure TSmForm.SetFormStyle;
begin
  Self.ShowHint := True;
  SetStyleForAllComponents(Self);
end;

procedure TSmForm.SetStyleForAllComponents(AComponent: TComponent);
var
  i: Integer;
begin
  for i := 0 to AComponent.ComponentCount - 1 do
  begin
    SetComponentStyle(AComponent.Components[i]);
    SetStyleForAllComponents(AComponent.Components[i]);
  end;
end;

procedure TSmForm.TitleBtnClick(Sender: TObject; ACol: Integer; Field: TField);
var
  s, sf: string;
  i: Integer;
begin
  if not CheckQrActiveEmpty(TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet)) then
    Exit;

  // Если заводом установлена "своя" сортировка, то не лезем...)
  if not(dgTitleClick in (Sender AS TJvDBGrid).Options) then
    Exit;

  if (Sender AS TJvDBGrid).SortedField = '' then
    Exit;

  // Если выбранное поле не из набора, а расчетное или другое, то выходим...
  { if TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet).FieldByName((Sender AS TJvDBGrid).SortedField)
    .FieldKind <> fkData then
    Exit;
  }
  case TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet).FieldByName((Sender AS TJvDBGrid).SortedField)
    .FieldKind of
    fkData:
      sf := (Sender AS TJvDBGrid).SortedField;
    fkLookup:
      sf := TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet).FieldByName((Sender AS TJvDBGrid).SortedField)
        .KeyFields;
    // Если выбранное поле не из набора, а расчетное или другое, то выходим...
  else
    Exit;
  end;

  s := '';
  if (Sender AS TJvDBGrid).SortMarker = smDown then
    s := ' DESC';

  // Пытаемся найти строку с запросом сортировки
  for i := TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet).SQL.Count - 1 downto 0 do
  begin
    if Pos(UpperCase('order by'), UpperCase(TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet).SQL[i])) <> 0
    then
    begin
      // Строка найдена
      if sf <> '' then
      begin
        // Если сортируем некий код, то буквенные значения всегда выше в списке
        if sf = 'CODE' then
          TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet).SQL[i] := 'ORDER BY CODE+1,' + sf + s
        else
          TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet).SQL[i] := 'ORDER BY ' + sf + s;
      end
      else
        TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet).SQL[i] := 'ORDER BY 1';
      CloseOpen(TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet));
      Exit;
    end;
  end;
  if sf <> '' then
  begin
    if sf = 'CODE' then
      TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet).SQL.Append('ORDER BY CODE+1' + sf + s)
    else
      TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet).SQL.Append('ORDER BY ' + sf + s);
    CloseOpen(TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet));
  end
  else
    TFDQuery((Sender AS TJvDBGrid).DataSource.DataSet).SQL.Append('ORDER BY 1');
end;

procedure TSmForm.JvDBGridSelectColumns(Grid: TJvDBGrid; var DefaultDialog: Boolean);
var
  r, WorkArea: TRect;
  Frm: TfSelectColumn;
  Pt: TPoint;
  CheckColumns: TCheckColumnArray;
  i: Integer;
begin
  SetLength(CheckColumns, Grid.Columns.Count);

  for i := Low(CheckColumns) to High(CheckColumns) do
  begin
    CheckColumns[i].key := Grid.Columns[i].Visible;
    CheckColumns[i].Value := Grid.Columns[i].Title.Caption;
  end;

  r := Grid.CellRect(0, 0);
  Frm := TfSelectColumn.Create(Application);
  try
    if not IsRectEmpty(r) then
    begin
      Pt := Grid.ClientToScreen(System.Classes.Point(r.Left, r.Bottom + 1));
      WorkArea := Screen.MonitorFromWindow(Handle).WorkareaRect;
      if Pt.X + Frm.Width > WorkArea.Right then
        Pt.X := WorkArea.Right - Frm.Width;
      if Pt.Y + Frm.Height > WorkArea.Bottom then
        Pt.Y := WorkArea.Bottom - Frm.Height;
      Frm.SetBounds(Pt.X, Pt.Y, Frm.Width, Frm.Height);
    end;
    Frm.Columns := CheckColumns;
    if Frm.ShowModal = mrOk then
    begin
      for i := Low(CheckColumns) to High(CheckColumns) do
        Grid.Columns[i].Visible := CheckColumns[i].key;
    end;
  finally
    DefaultDialog := Frm.DefaultDialog;
    FreeAndNil(Frm);
  end;
  Grid.Invalidate;
end;

class procedure TSmForm.DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  headerLines: Integer;
begin
  // Процедура наложения стилей отрисовки таблиц по умолчанию
  with (Sender AS TJvDBGrid).Canvas do
  begin
    if Column.Index >= (Sender AS TJvDBGrid).FixedCols then
    begin
      Brush.Color := PS.BackgroundRows;
      Font.Color := PS.FontRows;

      headerLines := 1;
      if not(dgTitles in (Sender AS TJvDBGrid).Options) then
        headerLines := 0;

      // Строка в фокусе
      if (Assigned(TMyDBGrid((Sender AS TJvDBGrid)).DataLink) and
        ((Sender AS TJvDBGrid).Row = TMyDBGrid((Sender AS TJvDBGrid)).DataLink.ActiveRecord + headerLines))
      then
      begin
        Brush.Color := PS.BackgroundSelectRow;
        Font.Color := PS.FontSelectRow;
      end;
      // Ячейка в фокусе
      if (gdSelected in State) then
      begin
        Brush.Color := PS.BackgroundSelectCell;
        Font.Color := PS.FontSelectCell;
        Font.Style := Font.Style + [fsBold];
      end;
    end;
    // (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TSmForm.GridResize(Sender: TObject);
begin
  {
    if (Sender AS TJvDBGrid).DataSource.DataSet.RecordCount > (Sender AS TJvDBGrid).VisibleRowCount then
    (Sender AS TJvDBGrid).ScrollBars := ssBoth
    else
    (Sender AS TJvDBGrid).ScrollBars := ssHorizontal;
  }
end;

procedure TSmForm.SetComponentStyle(AComponent: TComponent);
begin
  // Настройка кнопок -->
  if AComponent is TButton then
  begin
    // Меняем стили только там, где не изменены - приводит к обяз. перезапуску программы
    // if (TButton(AComponent).Font.Name = 'Tahoma') and (TButton(AComponent).Font.SIZE = 8) and
    // (TButton(AComponent).Font.Style = TFontStyles(0)) then
    // begin
    if PS.ControlsFontName <> '' then
      TButton(AComponent).Font.Name := PS.ControlsFontName;
    if PS.ControlsFontSize <> 0 then
      TButton(AComponent).Font.SIZE := PS.ControlsFontSize;
    TButton(AComponent).Font.Style := TFontStyles(PS.ControlsFontStyle);
    // end;
    if TButton(AComponent).Hint = '' then
      TButton(AComponent).Hint := TButton(AComponent).Caption;
    TButton(AComponent).ShowHint := True;
  end
  else if AComponent is TSpeedButton then
  begin
    if PS.ControlsFontName <> '' then
      TSpeedButton(AComponent).Font.Name := PS.ControlsFontName;
    if PS.ControlsFontSize <> 0 then
      TSpeedButton(AComponent).Font.SIZE := PS.ControlsFontSize;
    TSpeedButton(AComponent).Font.Style := TFontStyles(PS.ControlsFontStyle);
    if TSpeedButton(AComponent).Hint = '' then
      TSpeedButton(AComponent).Hint := TSpeedButton(AComponent).Caption;
    TSpeedButton(AComponent).ShowHint := True;
  end
  else if AComponent is TBitBtn then
  begin
    if PS.ControlsFontName <> '' then
      TBitBtn(AComponent).Font.Name := PS.ControlsFontName;
    if PS.ControlsFontSize <> 0 then
      TBitBtn(AComponent).Font.SIZE := PS.ControlsFontSize;
    TBitBtn(AComponent).Font.Style := TFontStyles(PS.ControlsFontStyle);
    if TBitBtn(AComponent).Hint = '' then
      TBitBtn(AComponent).Hint := TBitBtn(AComponent).Caption;
    TBitBtn(AComponent).ShowHint := True;
  end
  // <--
  // Настройка таблиц и списков -->
  else if AComponent is TListView then
  begin
    if PS.ControlsFontName <> '' then
      TListView(AComponent).Font.Name := PS.GridFontName;
    if PS.ControlsFontSize <> 0 then
      TListView(AComponent).Font.SIZE := PS.GridFontSize;
    TListView(AComponent).Font.Style := TFontStyles(PS.GridFontStyle);
  end
  else if AComponent is TStringGrid then
  begin
    if PS.ControlsFontName <> '' then
      TStringGrid(AComponent).Font.Name := PS.GridFontName;
    if PS.ControlsFontSize <> 0 then
      TStringGrid(AComponent).Font.SIZE := PS.GridFontSize;
    TStringGrid(AComponent).Font.Style := TFontStyles(PS.GridFontStyle);
  end
  else if AComponent is TVirtualStringTree then
  begin
    if PS.ControlsFontName <> '' then
    begin
      TVirtualStringTree(AComponent).Font.Name := PS.GridFontName;
      TVirtualStringTree(AComponent).Header.Font.Name := PS.GridFontName;
    end;
    if PS.ControlsFontSize <> 0 then
    begin
      TVirtualStringTree(AComponent).Font.SIZE := PS.GridFontSize;
      TVirtualStringTree(AComponent).Header.Font.SIZE := PS.GridFontSize;
    end;
    TVirtualStringTree(AComponent).Font.Style := TFontStyles(PS.GridFontStyle);
    TVirtualStringTree(AComponent).Header.Font.Style := TFontStyles(PS.GridFontStyle);

    TVirtualStringTree(AComponent).Colors.SelectionTextColor := PS.FontSelectCell;

    TVirtualStringTree(AComponent).Colors.UnfocusedSelectionColor := PS.SelectRowUnfocusedTable;
    TVirtualStringTree(AComponent).Colors.UnfocusedSelectionBorderColor := PS.SelectRowUnfocusedTable;

    TVirtualStringTree(AComponent).Colors.FocusedSelectionColor := PS.BackgroundSelectCell;
    TVirtualStringTree(AComponent).Colors.FocusedSelectionBorderColor := PS.BackgroundSelectCell;
  end
  else if AComponent is TJvDBGrid then
  begin
    LoadDBGridSettings(TJvDBGrid(AComponent));
    if not Assigned(TJvDBGrid(AComponent).OnDrawColumnCell) then
      TJvDBGrid(AComponent).OnDrawColumnCell := DrawColumnCell;
    if not Assigned(TJvDBGrid(AComponent).OnResize) then
      TJvDBGrid(AComponent).OnResize := GridResize;
    if not Assigned(TJvDBGrid(AComponent).OnSelectColumns) then
      TJvDBGrid(AComponent).OnSelectColumns := JvDBGridSelectColumns;
    if not(Assigned(TJvDBGrid(AComponent).OnTitleBtnClick)) and (dgTitleClick in TJvDBGrid(AComponent).Options)
    then
      TJvDBGrid(AComponent).OnTitleBtnClick := TitleBtnClick;
  end
  // <--
  // Настройка полей ввода/вывода -->
  else if AComponent is TEdit then
  begin
    if PS.TextFontName <> '' then
      TEdit(AComponent).Font.Name := PS.TextFontName;
    if PS.TextFontSize <> 0 then
      TEdit(AComponent).Font.SIZE := PS.TextFontSize;
    TEdit(AComponent).Font.Style := TFontStyles(PS.TextFontStyle);
  end
  else if AComponent is TDBEdit then
  begin
    if PS.TextFontName <> '' then
      TDBEdit(AComponent).Font.Name := PS.TextFontName;
    if PS.TextFontSize <> 0 then
      TDBEdit(AComponent).Font.SIZE := PS.TextFontSize;
    TDBEdit(AComponent).Font.Style := TFontStyles(PS.TextFontStyle);
  end
  else if AComponent is TMemo then
  begin
    if PS.TextFontName <> '' then
      TMemo(AComponent).Font.Name := PS.TextFontName;
    if PS.TextFontSize <> 0 then
      TMemo(AComponent).Font.SIZE := PS.TextFontSize;
    TMemo(AComponent).Font.Style := TFontStyles(PS.TextFontStyle);
  end
  else if AComponent is TDBMemo then
  begin
    if PS.TextFontName <> '' then
      TDBMemo(AComponent).Font.Name := PS.TextFontName;
    if PS.TextFontSize <> 0 then
      TDBMemo(AComponent).Font.SIZE := PS.TextFontSize;
    TDBMemo(AComponent).Font.Style := TFontStyles(PS.TextFontStyle);
  end
  else if AComponent is TComboBox then
  begin
    if PS.TextFontName <> '' then
      TComboBox(AComponent).Font.Name := PS.TextFontName;
    if PS.TextFontSize <> 0 then
      TComboBox(AComponent).Font.SIZE := PS.TextFontSize;
    TComboBox(AComponent).Font.Style := TFontStyles(PS.TextFontStyle);
  end
  else if AComponent is TDBLookupComboBox then
  begin
    if PS.TextFontName <> '' then
      TDBLookupComboBox(AComponent).Font.Name := PS.TextFontName;
    if PS.TextFontSize <> 0 then
      TDBLookupComboBox(AComponent).Font.SIZE := PS.TextFontSize;
    TDBLookupComboBox(AComponent).Font.Style := TFontStyles(PS.TextFontStyle);
  end
  else if AComponent is TSpinEdit then
  begin
    if PS.TextFontName <> '' then
      TSpinEdit(AComponent).Font.Name := PS.TextFontName;
    if PS.TextFontSize <> 0 then
      TSpinEdit(AComponent).Font.SIZE := PS.TextFontSize;
    TSpinEdit(AComponent).Font.Style := TFontStyles(PS.TextFontStyle);
  end
  else if AComponent is TJvDBSpinEdit then
  begin
    if PS.TextFontName <> '' then
      TJvDBSpinEdit(AComponent).Font.Name := PS.TextFontName;
    if PS.TextFontSize <> 0 then
      TJvDBSpinEdit(AComponent).Font.SIZE := PS.TextFontSize;
    TJvDBSpinEdit(AComponent).Font.Style := TFontStyles(PS.TextFontStyle);
  end
  else if AComponent is TJvSpinEdit then
  begin
    if PS.TextFontName <> '' then
      TJvSpinEdit(AComponent).Font.Name := PS.TextFontName;
    if PS.TextFontSize <> 0 then
      TJvSpinEdit(AComponent).Font.SIZE := PS.TextFontSize;
    TJvSpinEdit(AComponent).Font.Style := TFontStyles(PS.TextFontStyle);
  end
  else if AComponent is TDateTimePicker then
  begin
    if PS.TextFontName <> '' then
      TDateTimePicker(AComponent).Font.Name := PS.TextFontName;
    if PS.TextFontSize <> 0 then
      TDateTimePicker(AComponent).Font.SIZE := PS.TextFontSize;
    TDateTimePicker(AComponent).Font.Style := TFontStyles(PS.TextFontStyle);
  end
  else if AComponent is TNumericField then
  begin
    if TNumericField(AComponent).DisplayFormat = '' then
      TNumericField(AComponent).DisplayFormat := C_DISPFORMAT;
    if TNumericField(AComponent).EditFormat = '' then
      TNumericField(AComponent).EditFormat := C_EDITFORMAT;
  end;
  // <--
end;

procedure TSmForm.WMUpdateFormStyle(var Mes: TMessage);
begin
  SetFormStyle;
end;

initialization

// Регистрируем собственный формат для буфера обмена
G_SMETADATA := RegisterClipBoardFormat(C_SMETADATA);

end.
