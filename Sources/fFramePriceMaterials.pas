unit fFramePriceMaterials;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, Buttons, ExtCtrls, Menus, Clipbrd, DB,
  VirtualTrees, fFrameStatusBar, DateUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, fFrameSmeta,
  system.AnsiStrings,dialogs ;  //vk

type
  TSplitter = class(ExtCtrls.TSplitter)
  public
    procedure Paint(); override;
  end;

type
  TFramePriceMaterial = class(TSmetaFrame)
    PopupMenu: TPopupMenu;
    CopyCell: TMenuItem;
    PriceMaterialSearch: TMenuItem;
    PriceMaterialSearchFast: TMenuItem;
    PriceMaterialSearchAccurate: TMenuItem;

    Panel: TPanel;
    PanelMemo: TPanel;
    PanelTable: TPanel;

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
    PanelSettings: TPanel;
    LabelYear: TLabel;
    LabelMonth: TLabel;
    LabelRegion: TLabel;
    ComboBoxYear: TComboBox;
    ComboBoxMonth: TComboBox;
    ComboBoxRegion: TComboBox;
    ADOQuery: TFDQuery;
    ADOQueryTemp: TFDQuery;

    procedure ReceivingSearch(vStr: String);

    procedure EditSearch1Enter(Sender: TObject);
    procedure EditSearch1KeyPress(Sender: TObject; var Key: Char);

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
    procedure ComboBoxRegionChange(Sender: TObject);

  private
    StrQuickSearch: String;
    NomColumn: Integer;

    DataBase: Char; // Справочные или собственные данные
    PriceColumn: Boolean; // Показывать/не показывать столбец цены
    AllowAddition: Boolean; // Разрешено/запрещено добавлять записи из фрейма
    AllowReplacement: Boolean; // Разрешено/запрещено заменять неучтённые метериалы из фрейма

    RegionColumn: string; // Номер столбца с ценами в зависимости от выбранного региона
  public
    procedure ReceivingAll; override;
    constructor Create(AOwner: TComponent; const vDataBase: Char;
      const vPriceColumn, vAllowAddition, vAllowReplacement: Boolean); reintroduce;
  end;

implementation

uses DrawingTables, DataModule, CalculationEstimate;

{$R *.dfm}

const
  // Название этого фрейма
  CaptionFrame = 'Фрейм «Цены на материалы»';

  // Массив содержащий названия всех видимых столбцов таблицы
  NameVisibleColumns: array [1 .. 2] of String[8] = ('mat_code', 'mat_name');

  // ---------------------------------------------------------------------------------------------------------------------

  { TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFramePriceMaterial.Create(AOwner: TComponent; const vDataBase: Char;
  const vPriceColumn, vAllowAddition, vAllowReplacement: Boolean);
begin
  inherited Create(AOwner);

  // ----------------------------------------

  DataBase := vDataBase;
  PriceColumn := vPriceColumn;
  AllowAddition := vAllowAddition;
  AllowReplacement := vAllowReplacement;

  if not PriceColumn then
  begin
    LabelRegion.Enabled := False;
    LabelMonth.Enabled := False;
    LabelYear.Enabled := False;
    ComboBoxRegion.Enabled := False;
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

procedure TFramePriceMaterial.ReceivingAll;
var
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
        try
          with ADOQuery do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('SELECT region_id FROM objcards WHERE obj_id = :obj_id;');
            ParamByName('obj_id').Value := FormCalculationEstimate.GetIdObject;
            Active := True;

            RegionColumn := IntToStr(FieldByName('region_id').AsInteger); // Получение номера региона
            ComboBoxRegion.ItemIndex := StrToInt(RegionColumn) - 1;

            ADOQueryTemp.Active := False;
            ADOQueryTemp.SQL.Clear;
            ADOQueryTemp.SQL.Add('SELECT stavka.monat, stavka.year'#13 +
              'FROM smetasourcedata, stavka WHERE smetasourcedata.sm_id=:sm_id and smetasourcedata.stavka_id=stavka.stavka_id;');
            ADOQueryTemp.ParamByName('sm_id').Value := FormCalculationEstimate.GetIdEstimate;
            ADOQueryTemp.Active := True;

            ComboBoxMonth.ItemIndex := ADOQueryTemp.FieldByName('monat').AsVariant - 1;
            // Опасная конструкция, может быть источником ошибок
            ComboBoxYear.ItemIndex := ADOQueryTemp.FieldByName('year').AsInteger - 2012;
          end;
        except
          on E: Exception do
            MessageBox(0, PChar('При получении номера региона возникла ошибка:' + sLineBreak + sLineBreak +
              E.Message), CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
        end
      else
      begin
        RegionColumn := IntToStr(ComboBoxRegion.ItemIndex + 1);
        // Ставит текущую дату
        ComboBoxMonth.ItemIndex := Month - 1;
        ComboBoxYear.ItemIndex := Year - 2012;
      end;
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

procedure TFramePriceMaterial.ReceivingSearch(vStr: String);
var
  WhereStr: string;
  StrQuery: string;
  t:TStringList;             //vk
  i:integer;                 //vk
  poisk,param1:string;       //vk
  region_id:integer;         //vk
begin
  if vStr <> '' then
    WhereStr := ' and ' + vStr
  else
    WhereStr := '';

  try
    //vk
    poisk:=EditSearch.Text ;

    poisk:=EditSearch.Text ;
    t:=TStringList.create;
    t.text:=stringReplace(poisk,' ',#13#10,[rfReplaceAll]);
    param1 :='';
    poisk  :='';
    for i := 0 to t.Count-1 do
    begin
       poisk  := poisk+' UPPER(TRIM(material.mat_name))  LIKE  ''%'+UPPERCASE(TRIM(t[i]))+'%'' or';    //vk
       param1 := param1+'(UPPER(TRIM(material.mat_name)) LIKE "%'  +UPPERCASE(TRIM(t[i]))+'%" )+';
    end;
    poisk  := LeftStr(poisk, length(poisk)-3);
    param1 := LeftStr(param1,length(param1)-1);
    //vk
    if PriceColumn then
    begin
    if EditSearch.Text ='' then
      StrQuery := 'SELECT material.material_id as "MatId", mat_code as "Code", ' +
        'cast(mat_name as char(1024)) as "Name", unit_name as "Unit", ' +
        'units.unit_id as "UnitId", coast1_1 as "PriceVAT1", ' +
        'coast1_2 as "PriceNotVAT1", coast2_1 "PriceVAT2", ' +
        'coast2_2 as "PriceNotVAT2", coast3_1 as "PriceVAT3", ' +
        'coast3_2 as "PriceNotVAT3", coast4_1 "PriceVAT4", ' +
        'coast4_2 as "PriceNotVAT4", coast5_1 as "PriceVAT5", ' +
        'coast5_2 as "PriceNotVAT5", coast6_1 "PriceVAT6", ' +
        'coast6_2 as "PriceNotVAT6", coast7_1 as "PriceVAT7", ' +
        'coast7_2 as "PriceNotVAT7", year, monat FROM material, units, ' + 'materialcoast' + DataBase +
        ' WHERE (material.unit_id = units.unit_id) ' + 'and (material.material_id = materialcoast' + DataBase
        + '.material_id) ' + 'and (not mat_code like "П%") and (year=:y1) and (monat=:m1)' + WhereStr +
        ' ORDER BY mat_code, mat_name ASC;'
    else
        StrQuery := 'SELECT material.material_id as "MatId", mat_code as "Code", ' +
        'cast(mat_name as char(1024)) as "Name", unit_name as "Unit", ' +
        ' (' +param1+ ') as ORDER_F, '+
        'units.unit_id as "UnitId", coast1_1 as "PriceVAT1", ' +
        'coast1_2 as "PriceNotVAT1", coast2_1 "PriceVAT2", ' +
        'coast2_2 as "PriceNotVAT2", coast3_1 as "PriceVAT3", ' +
        'coast3_2 as "PriceNotVAT3", coast4_1 "PriceVAT4", ' +
        'coast4_2 as "PriceNotVAT4", coast5_1 as "PriceVAT5", ' +
        'coast5_2 as "PriceNotVAT5", coast6_1 "PriceVAT6", ' +
        'coast6_2 as "PriceNotVAT6", coast7_1 as "PriceVAT7", ' +
        'coast7_2 as "PriceNotVAT7", year, monat FROM material, units, ' + 'materialcoast' + DataBase +
        ' WHERE (material.unit_id = units.unit_id) ' + 'and (material.material_id = materialcoast' + DataBase
        + '.material_id) ' + 'and (not mat_code like "П%") and (year=:y1) and (monat=:m1)' + WhereStr +
        ' and (' +poisk+') ORDER BY ORDER_F DESC, mat_code, mat_name ASC;'
    end
    else
    begin
        if EditSearch.Text ='' then
        StrQuery := 'SELECT material_id as "MatId", mat_code as "Code", ' +
        'cast(mat_name as char(1024)) as "Name", unit_name as "Unit" ' +
        'FROM material, units WHERE (material.unit_id = units.unit_id) ' + 'and (not mat_code LIKE "П%")' +
        WhereStr + ' ORDER BY mat_code, mat_name ASC;'
        else
       //vk
        StrQuery := 'SELECT material_id as "MatId", mat_code as "Code", ' +
        'cast(mat_name as char(1024)) as "Name", unit_name as "Unit" ,'+
        ' (' +param1+ ') as ORDER_F '+
        'FROM material, units WHERE (material.unit_id = units.unit_id) ' + 'and (not mat_code LIKE "П%")' +
        WhereStr +' and (' +poisk+') ORDER BY ORDER_F DESC,mat_code, mat_name ASC;';
        //vk
    end;



    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(StrQuery);
      if PriceColumn then
      begin
        ParamByName('y1').AsInteger := StrToInt(ComboBoxYear.Text);
        ParamByName('m1').AsInteger := ComboBoxMonth.ItemIndex + 1;
      end;
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
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.EditSearch1Enter(Sender: TObject);
begin
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // Русский
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // Английский
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.EditSearch1KeyPress(Sender: TObject; var Key: Char);
begin
  with (Sender as TEdit) do
    if (Key = #13) and (Text <> '') then // Если нажата клавиша "Enter" и строка поиска не пуста
      ReceivingSearch(FilteredString(Text, 'mat_name'))
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

procedure TFramePriceMaterial.FrameEnter(Sender: TObject);
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

procedure TFramePriceMaterial.FrameExit(Sender: TObject);
begin
  with FrameStatusBar do
  begin
    InsertText(0, '');
    InsertText(1, '');
    InsertText(2, '');
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.FrameResize(Sender: TObject);
begin
  AutoWidthColumn(VST, 2);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.PanelTableResize(Sender: TObject);
begin
  ImageSplitter.Top := Splitter.Top;
  ImageSplitter.Left := Splitter.Left + (Splitter.Width - ImageSplitter.Width) div 2;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.CopyCellClick(Sender: TObject);
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
        CellText := ADOQuery.FieldByName('PriceVAT' + RegionColumn).AsVariant;
      5:
        CellText := ADOQuery.FieldByName('PriceNotVAT' + RegionColumn).AsVariant;
    end;

  ClipBoard := TClipboard.Create;
  ClipBoard.SetTextBuf(PWideChar(WideString(CellText)));
  FreeAndNil(ClipBoard);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.MemoEnter(Sender: TObject);
begin
  Memo.SelStart := Length(Memo.Text);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.SpeedButtonShowHideClick(Sender: TObject);
begin
  MemoShowHide(Sender, Splitter, PanelMemo);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.VSTAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
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
        CellText := ADOQuery.FieldByName('PriceVAT' + RegionColumn).AsVariant;
      5:
        CellText := ADOQuery.FieldByName('PriceNotVAT' + RegionColumn).AsVariant;
    end;

  VSTAfterCellPaintDefault(Sender, TargetCanvas, Node, Column, CellRect, CellText);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
  var ContentRect: TRect);
begin
  VSTBeforeCellPaintDefault(Sender, TargetCanvas, Node, Column, CellPaintMode, CellRect, ContentRect);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.VSTDblClick(Sender: TObject);
begin
  if AllowReplacement then
    FormCalculationEstimate.ReplacementMaterial(ADOQuery.FieldByName('MatId').AsInteger);

  if AllowAddition then
    FormCalculationEstimate.AddMaterial(ADOQuery.FieldByName('MatId').AsInteger);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.VSTEnter(Sender: TObject);
var
  NumCol: Integer;
begin
  NumCol := (Sender as TVirtualStringTree).FocusedColumn;

  if (NumCol = 1) or (NumCol = 2) then
    FrameStatusBar.InsertText(2, '-1') // Поиск по столбцу есть
  else
    FrameStatusBar.InsertText(2, ''); // Поиска по столбцу нет

  // ----------------------------------------

  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // Русский
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // Английский
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.VSTExit(Sender: TObject);
begin
  StrQuickSearch := '';
  FrameStatusBar.InsertText(2, '');
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
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

procedure TFramePriceMaterial.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
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
        CellText := ADOQuery.FieldByName('PriceVAT' + RegionColumn).AsVariant;
      5:
        CellText := ADOQuery.FieldByName('PriceNotVAT' + RegionColumn).AsVariant;
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.VSTKeyPress(Sender: TObject; var Key: Char);
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
    NameColumn := string(NameVisibleColumns[NumCol]); // Название выделенного столбца

    StrQuickSearch := StrQuickSearch + Key; // Заносим символ в строку быстрого поиска

    FrameStatusBar.InsertText(2, StrQuickSearch);

    ReceivingSearch(NameColumn + ' LIKE ''' + StrQuickSearch + '%''');
  end
  else if Key = #08 then // Если была нажата клавиша "Backspace"
  begin
    StrQuickSearch := ''; // Очищаем строку быстрого поиска

    FrameStatusBar.InsertText(2, '-1');

    ReceivingSearch('');
  end
  else
    Key := #0;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.ComboBoxMonthYearChange(Sender: TObject);
begin
  ADOQuery.ParamByName('y1').AsInteger := StrToInt(ComboBoxYear.Text);
  ADOQuery.ParamByName('m1').AsInteger := ComboBoxMonth.ItemIndex + 1;
  ADOQuery.Active := False;
  ADOQuery.Active := True;
  EditSearch.Text := '';
  FrameStatusBar.InsertText(2, '-1');

  ReceivingSearch('');
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMaterial.ComboBoxRegionChange(Sender: TObject);
begin
  RegionColumn := IntToStr(ComboBoxRegion.ItemIndex + 1);
  VST.Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
