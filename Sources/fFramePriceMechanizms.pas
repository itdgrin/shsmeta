unit fFramePriceMechanizms;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, Buttons,
  ExtCtrls, Menus, Clipbrd, DB, VirtualTrees, fFrameStatusBar, DateUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, fFrameSmeta,
  system.AnsiStrings,dialogs ;//vk

type
  TSplitter = class(ExtCtrls.TSplitter)
  public
    procedure Paint(); override;
  end;

type
  TFramePriceMechanizm = class(TSmetaFrame)

    PopupMenu: TPopupMenu;
    CopyCell: TMenuItem;
    PriceMechanizmSearch: TMenuItem;
    PriceMechanizmSearchFast: TMenuItem;
    PriceMechanizmSearchAccurate: TMenuItem;

    Panel: TPanel;
    PanelMemo: TPanel;
    PanelTable: TPanel;
    PanelSettings: TPanel;

    Memo: TMemo;
    Splitter: TSplitter;
    ImageSplitter: TImage;
    VST: TVirtualStringTree;
    FrameStatusBar: TFrameStatusBar;
    SpeedButtonShowHide: TSpeedButton;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    PanelSearch: TPanel;
    LabelSearch: TLabel;
    EditSearch: TEdit;
    LabelYear: TLabel;
    ComboBoxYear: TComboBox;
    LabelMonth: TLabel;
    ComboBoxMonth: TComboBox;
    ADOQueryTemp: TFDQuery;
    ADOQuery: TFDQuery;

    procedure ReceivingSearch(vStr: String);

    procedure EditSearchEnter(Sender: TObject);
    procedure EditSearchKeyPress(Sender: TObject; var Key: Char);

    procedure FrameEnter(Sender: TObject);
    procedure FrameExit(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure PanelTableResize(Sender: TObject);

    procedure CopyCellClick(Sender: TObject);
    procedure MemoEnter(Sender: TObject);
    procedure SpeedButtonShowHideClick(Sender: TObject);

    procedure VSTAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; CellRect: TRect);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTDblClick(Sender: TObject);
    procedure VSTEnter(Sender: TObject);
    procedure VSTExit(Sender: TObject);
    procedure VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure VSTKeyPress(Sender: TObject; var Key: Char);

    procedure ComboBoxMonthYearChange(Sender: TObject);

  private
    StrQuickSearch: String;
    NomColumn: Integer;

    DataBase: Char; // Справочные или собственные данные
    PriceColumn: Boolean; // Показывать/не показывать столбец цены
    AllowAddition: Boolean; // Разрешено/запрещено добавлять записи из фрейма

    StrFilterData: string; // Фильтрация данных по месяцу и году
  public
    procedure ReceivingAll; override;
    constructor Create(AOwner: TComponent; const vDataBase: Char;
      const vPriceColumn, vAllowAddition: Boolean); reintroduce;
  end;

implementation

uses Main, DrawingTables, DataModule, CalculationEstimate;

{$R *.dfm}

const
  // Название этого фрейма
  CaptionFrame = 'Фрейм «Цены на механизмы»';

  // Массив содержащий названия всех видимых столбцов таблицы
  NameVisibleColumns: array [1 .. 2] of String = ('mech_code', 'mech_name');

  // ---------------------------------------------------------------------------------------------------------------------

  { TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFramePriceMechanizm.Create(AOwner: TComponent; const vDataBase: Char;
  const vPriceColumn, vAllowAddition: Boolean);
begin
  inherited Create(AOwner);

  // ----------------------------------------

  DataBase := vDataBase;
  PriceColumn := vPriceColumn;
  AllowAddition := vAllowAddition;

  StrFilterData := '';

  if not PriceColumn then
  begin
    LabelMonth.Enabled := False;
    LabelYear.Enabled := False;
    ComboBoxMonth.Enabled := False;
    ComboBoxYear.Enabled := False;
  end;

  // ----------------------------------------

  // Показываем или скрываем столбцы с ценой
  if PriceColumn then
    with VST.Header do
    begin
      Columns[4].Options := Columns[4].Options + [coVisible];
      Columns[5].Options := Columns[5].Options + [coVisible];
    end
  else
    with VST.Header do
    begin
      Columns[4].Options := Columns[4].Options - [coVisible];
      Columns[5].Options := Columns[5].Options - [coVisible];
    end;

  // ----------------------------------------

  VSTSetting(VST); // НАСТРАИВАЕМ ЦВЕТА

  PanelMemo.Constraints.MinHeight := 35;
  SpeedButtonShowHide.Hint := 'Свернуть панель';

  with DM do
  begin
    ImageListHorozontalDots.GetIcon(0, ImageSplitter.Picture.Icon);
    ImageListArrowsBottom.GetBitmap(0, SpeedButtonShowHide.Glyph);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.ReceivingAll;
var
  { StrQuery: string; }
  Year, Month, Day: Word;
begin
  StrQuickSearch := '';

  try
    if ADOQuery.Active then
      Exit;

    if PriceColumn then
    begin
      DecodeDate(Date, Year, Month, Day);
      if Assigned(FormCalculationEstimate) then
      begin
        try
          ADOQueryTemp.Active := False;
          ADOQueryTemp.SQL.Clear;
          ADOQueryTemp.SQL.Add('SELECT stavka.monat, stavka.year'#13 +
            'FROM smetasourcedata, stavka WHERE smetasourcedata.sm_id=:sm_id and smetasourcedata.stavka_id=stavka.stavka_id;');
          ADOQueryTemp.ParamByName('sm_id').Value := FormCalculationEstimate.GetIdEstimate;
          ADOQueryTemp.Active := True;

          ComboBoxMonth.ItemIndex := ADOQueryTemp.FieldByName('monat').AsVariant - 1;
          ComboBoxYear.ItemIndex := ADOQueryTemp.FieldByName('year').AsInteger - 2012;
        except
          on E: Exception do
            MessageBox(0, PChar('При получении номера региона возникла ошибка:' + sLineBreak + sLineBreak +
              E.Message), CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
        end
      end
      else
      begin
        ComboBoxMonth.ItemIndex := Month - 1;
        ComboBoxYear.ItemIndex := Year - 2012;
      end;

      StrFilterData := 'year = ' + ComboBoxYear.Text + ' and monat = ' +
        IntToStr(ComboBoxMonth.ItemIndex + 1);
    end;

    ReceivingSearch('');
  except
    on E: Exception do
      MessageBox(0, PChar('При запросе к БД возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
  fLoaded := True;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.ReceivingSearch(vStr: String);
var
  WhereStr: string;
  FilterStr, StrQuery: string;
  t:TStringList;            //vk
  i:integer;                //vk
  poisk,param1:string;      //vk
  region_id:integer;        //vk

begin
  if (StrFilterData <> '') and (vStr <> '') then
    FilterStr := StrFilterData + ' and ' + vStr
  else if StrFilterData = '' then
    FilterStr := vStr
  else if vStr = '' then
    FilterStr := StrFilterData;

  if FilterStr <> '' then
    WhereStr := ' and ' + FilterStr
  else
    WhereStr := '';

  try
    //vk
    poisk:=EditSearch.Text ;
    t:=TStringList.create;
    t.text:=stringReplace(poisk,' ',#13#10,[rfReplaceAll]);
    param1 :='';
    poisk  :='';
    for i := 0 to t.Count-1 do
    begin
       poisk  := poisk+' UPPER(TRIM(mechanizm.mech_name))  LIKE  ''%'+UPPERCASE(TRIM(t[i]))+'%'' or';    //vk
       param1 := param1+'(UPPER(TRIM(mechanizm.mech_name)) LIKE "%'  +UPPERCASE(TRIM(t[i]))+'%" )+';
    end;
    poisk  := LeftStr(poisk, length(poisk)-3);
    param1 := LeftStr(param1,length(param1)-1);
    //vk


    if PriceColumn then
    begin
    if EditSearch.Text ='' then
        StrQuery := 'SELECT mechanizm.mechanizm_id as "Id", mech_code as "Code", ' +
        'cast(mech_name as char(1024)) as "Name", unit_name as "Unit", ' +
        'coast1 as "PriceVAT", coast2 as "PriceNotVAT", monat, year ' + 'FROM mechanizm, units, mechanizmcoast' +
        DataBase + ' WHERE (mechanizm.unit_id = units.unit_id) and ' +
        '(mechanizm.mechanizm_id = mechanizmcoast' + DataBase + '.mechanizm_id)' + WhereStr +
        ' ORDER BY mech_code, mech_name ASC' + ' ;'
     else
      //vk
      StrQuery:= 'SELECT   mechanizm.mechanizm_id as "Id",mechanizm.mech_code as "Code",cast(mech_name as char(1024)) as "Name",units.unit_name as "Unit",'+
                 ' coast1 as "PriceVAT", coast2 as "PriceNotVAT", monat, year, '+
                 ' (' +param1+ ') as ORDER_F '+
                 ' FROM  mechanizm '+
                 ' left  join  units on mechanizm.unit_id = units.unit_id' +
                 ' LEFT OUTER JOIN mechanizmcoast' + DataBase + '  ON mechanizmcoast' + DataBase + '.mechanizm_id = mechanizm.mechanizm_id'+
                 ' WHERE '+poisk+' ORDER BY ORDER_F DESC, mech_name ;';
      //vk

    end
    else
    begin
     //vk
     if EditSearch.Text ='' then
     StrQuery := 'SELECT mechanizm_id as "Id", mech_code as "Code", ' +
        'cast(mech_name as char(1024)) as "Name", unit_name as "Unit" ' +
        'FROM mechanizm, units WHERE (mechanizm.unit_id = units.unit_id)' + WhereStr +
        ' ORDER BY mech_code, mech_name ASC ;'
     else
     StrQuery:= ' SELECT mechanizm.mechanizm_id as "Id",mech_code as "Code",cast(mech_name as char(1024)) as "Name",units.unit_name as "Unit",'+
                ' (' +param1+ ') as ORDER_F '+
                ' FROM  mechanizm '+
                ' left  join  units on mechanizm.unit_id = units.unit_id' +
                ' WHERE '+poisk+' ORDER BY ORDER_F DESC, mech_name ;';
     //vk
    end;
    vst.Visible:=false;
    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(StrQuery);
      Active := True;
    end;

    ADOQuery.FetchOptions.RecordCountMode := cmTotal;

    if ADOQuery.RecordCount <= 0 then
    begin
      VST.RootNodeCount := 1;
      VST.ClearSelection;

      FrameStatusBar.InsertText(1, '-1');
    end
    else
    begin
      VST.RootNodeCount := ADOQuery.RecordCount;

      VST.Selected[VST.GetFirst] := True;
      VST.FocusedNode := VST.GetFirst;

      FrameStatusBar.InsertText(1, '1');
    end;

    FrameStatusBar.InsertText(0, IntToStr(ADOQuery.RecordCount));

    ADOQuery.FetchOptions.RecordCountMode := cmVisible;
  except
    on E: Exception do
      MessageBox(0, PChar('При запросе к БД возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
  vst.Visible:=true;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.EditSearchEnter(Sender: TObject);
begin
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // Русский
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // Английский
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.EditSearchKeyPress(Sender: TObject; var Key: Char);
begin
  with (Sender as TEdit) do
    if (Key = #13) and (Text <> '') then // Если нажата клавиша "Enter" и строка поиска не пуста
    begin
      ReceivingSearch(FilteredString(Text, 'mech_name')) ;
      EditSearch.SelStart :=0;
      EditSearch.SelLength:=Length(Text);
    end
    else if (Key = #27) or ((Key = #13) and (Text = '')) then
    // Нажата клавиша ESC, или Enter и строка поиска пуста
    begin
      Text := '';
      ReceivingSearch('');
    end;

  // Антибип
  if Key = #13 then
    Key := #0;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.FrameEnter(Sender: TObject);
begin

  EditSearch.SetFocus;

  if not ADOQuery.Active then
    Exit;

  FrameStatusBar.InsertText(0, IntToStr(VST.RootNodeCount));

  if ADOQuery.RecordCount > 0 then
    FrameStatusBar.InsertText(1, IntToStr(VST.FocusedNode.Index + 1)) // Номер выделенной записи
  else
    FrameStatusBar.InsertText(1, '-1'); // Нет записей
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.FrameExit(Sender: TObject);
begin
  with FrameStatusBar do
  begin
    InsertText(0, '');
    InsertText(1, '');
    InsertText(2, '');
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.FrameResize(Sender: TObject);
begin
  AutoWidthColumn(VST, 2);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.PanelTableResize(Sender: TObject);
begin
  ImageSplitter.Top := Splitter.Top;
  ImageSplitter.Left := Splitter.Left + (Splitter.Width - ImageSplitter.Width) div 2;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.CopyCellClick(Sender: TObject);
var
  ClipBoard: TClipboard;
  CellText: string;
begin
  ADOQuery.RecNo := VST.FocusedNode.Index + 1;

  case VST.FocusedColumn of
    1:
      CellText := ADOQuery.FieldByName('Code').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('Name').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('Unit').AsVariant;
  end;

  if PriceColumn then
    case VST.FocusedColumn of
      4:
        CellText := ADOQuery.FieldByName('PriceVAT').AsVariant;
      5:
        CellText := ADOQuery.FieldByName('PriceNotVAT').AsVariant;
    end;

  ClipBoard := TClipboard.Create;
  ClipBoard.SetTextBuf(PWideChar(WideString(CellText)));
  FreeAndNil(ClipBoard);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.MemoEnter(Sender: TObject);
begin
  Memo.SelStart := Length(Memo.Text);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.SpeedButtonShowHideClick(Sender: TObject);
begin
  MemoShowHide(Sender, Splitter, PanelMemo);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.VSTAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellRect: TRect);
var
  CellText: string;
begin
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
    Exit;

  ADOQuery.RecNo := Node.Index + 1;

  case Column of
    1:
      CellText := ADOQuery.FieldByName('Code').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('Name').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('Unit').AsVariant;
  end;

  if PriceColumn then
    case Column of
      4:
        CellText := ADOQuery.FieldByName('PriceVAT').AsVariant;
      5:
        CellText := ADOQuery.FieldByName('PriceNotVAT').AsVariant;
    end;

  VSTAfterCellPaintDefault(Sender, TargetCanvas, Node, Column, CellRect, CellText);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
  var ContentRect: TRect);
begin
  VSTBeforeCellPaintDefault(Sender, TargetCanvas, Node, Column, CellPaintMode, CellRect, ContentRect);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.VSTDblClick(Sender: TObject);
begin
  if AllowAddition then
    FormCalculationEstimate.AddMechanizm(ADOQuery.FieldByName('Id').AsInteger);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.VSTEnter(Sender: TObject);
var
  NumCol: Integer;
begin
  NumCol := (Sender as TVirtualStringTree).FocusedColumn;

  if (NumCol = 1) or (NumCol = 2) then
    FrameStatusBar.InsertText(2, '-1') // Поиск по столбцу есть
  else
    FrameStatusBar.InsertText(2, ''); // Поиск по столбцу нет

  // ----------------------------------------

  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // Русский
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // Английский
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.VSTExit(Sender: TObject);
begin
  StrQuickSearch := '';
  FrameStatusBar.InsertText(2, '');
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex);
begin
  VSTFocusChangedDefault(Sender, Node, Column);

  // ----------------------------------------

  // Если перешли на другой столбец (колонку), то очищаем строку быстрого поиска
  if NomColumn <> Column then
  begin
    StrQuickSearch := '';
    if (Column = 1) or (Column = 2) then
      FrameStatusBar.InsertText(2, '-1') // Поиск по столбцу есть
    else
      FrameStatusBar.InsertText(2, '') // Поиск по столбцу нет
  end;

  NomColumn := Column;

  // ----------------------------------------

  // Выводим название в Memo под таблицей

  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) or (not Assigned(Node)) then
    Exit;

  ADOQuery.RecNo := Node.Index + 1;
  Memo.Text := ADOQuery.FieldByName('Name').AsVariant;
  FrameStatusBar.InsertText(1, IntToStr(Node.Index + 1));
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
begin
  if not ADOQuery.Active then
    Exit;

  if (ADOQuery.RecordCount <= 0) then
  begin
    case Column of
      0:
        CellText := '';
      1:
        CellText := '';
      2:
        CellText := 'Записей не найдено!';
      3:
        CellText := '';
      4:
        CellText := '';
      5:
        CellText := '';
    end;

    Exit;
  end;

  if Column > 0 then
    ADOQuery.RecNo := Node.Index + 1;

  case Column of
    0:
      CellText := IntToStr(Node.Index + 1);
    1:
      CellText := ADOQuery.FieldByName('Code').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('Name').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('Unit').AsVariant;
  end;

  if PriceColumn then
    case Column of
      4:
        CellText := ADOQuery.FieldByName('PriceVAT').AsVariant;
      5:
        CellText := ADOQuery.FieldByName('PriceNotVAT').AsVariant;
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.VSTKeyPress(Sender: TObject; var Key: Char);
var
  NameColumn: string;
  NumCol: Integer;
begin
  NumCol := (Sender as TVirtualStringTree).FocusedColumn;

  if not(NumCol = 1) and not(NumCol = 2) then
    Exit;

  // Разрешаем ввод русских смиволов (unicode) + символ "пробел" + цифры
  // Большие: А-Я = 1040-1071, Ё = 1025, Малые: а-я = 1072-1103, ё = 1105
  if ((Key >= #1040) and (Key <= #1103)) or (Key = #1025) or (Key = #1105) or (Key = #32) or
    ((Key >= '0') and (Key <= '9')) or (Key = '-') then
  begin
    NameColumn := NameVisibleColumns[NumCol]; // Название выделенного столбца

    StrQuickSearch := StrQuickSearch + Key; // Заносим символ в строку быстрого поиска

    FrameStatusBar.InsertText(2, StrQuickSearch);

    ReceivingSearch(NameColumn + ' LIKE ''' + StrQuickSearch + '%''');
  end
  else if Key = #08 then // Если была нажата клавиша "Backspace"
  begin
    StrQuickSearch := ''; // Очищаем строку быстрого поиска

    FrameStatusBar.InsertText(2, '-1');

    ReceivingSearch('');
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.ComboBoxMonthYearChange(Sender: TObject);
begin
  StrFilterData := 'year = ' + ComboBoxYear.Text + ' and monat = ' + IntToStr(ComboBoxMonth.ItemIndex + 1);

  EditSearch.Text := '';
  FrameStatusBar.InsertText(2, '-1');

  ReceivingSearch('');
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
