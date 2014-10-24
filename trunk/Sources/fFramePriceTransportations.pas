unit fFramePriceTransportations;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, Buttons, ExtCtrls, Menus, Clipbrd, DB,
  VirtualTrees, fFrameStatusBar, DateUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TSplitter = class(ExtCtrls.TSplitter)
  private
    procedure Paint(); override;
  end;

type
  TFramePriceTransportations = class(TFrame)

    PopupMenu: TPopupMenu;
    CopyCell: TMenuItem;
    PriceTransportationSearch: TMenuItem;
    PriceTransportationSearchFast: TMenuItem;
    PriceTransportationSearchAccurate: TMenuItem;

    Panel: TPanel;
    PanelMemo: TPanel;
    PanelTable: TPanel;
    PanelSearch: TPanel;

    Memo: TMemo;
    EditSearch: TEdit;
    LabelSearch: TLabel;
    Splitter: TSplitter;
    ImageSplitter: TImage;
    VST: TVirtualStringTree;
    FrameStatusBar: TFrameStatusBar;
    SpeedButtonShowHide: TSpeedButton;
    LabelYear: TLabel;
    ComboBoxYear: TComboBox;
    LabelMonth: TLabel;
    ComboBoxMonth: TComboBox;
    ADOQuery: TFDQuery;

    constructor Create(AOwner: TComponent);

    procedure ReceivingAll;
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
    procedure VSTEnter(Sender: TObject);
    procedure VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);

    procedure ComboBoxMonthYearChange(Sender: TObject);

  private
    StrFilterData: string; // Фильтрация данных по месяцу и году

  end;

implementation

uses DrawingTables, DataModule;

{$R *.dfm}

const
  // Название этого фрейма
  CaptionFrame = 'Фрейм «Тарифы по грузоперевозкам»';

  // Массив содержащий названия всех видимых столбцов таблицы
  NameVisibleColumns: array [1 .. 1] of String[8] = ('distance');

  // ---------------------------------------------------------------------------------------------------------------------

  { TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFramePriceTransportations.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // ----------------------------------------

  StrFilterData := '';

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

procedure TFramePriceTransportations.ReceivingAll;
var
  StrQuery: string;
begin
  try
    if ADOQuery.Active then
      Exit;

    ComboBoxMonth.ItemIndex := MonthOf(Now) - 1;

    case YearOf(Now) of
      2012:
        ComboBoxYear.ItemIndex := 0;
      2013:
        ComboBoxYear.ItemIndex := 1;
      2014:
        ComboBoxYear.ItemIndex := 2;
    end;

    StrFilterData := 'year = ' + ComboBoxYear.Text + ' and monat = ' + IntToStr(ComboBoxMonth.ItemIndex + 1);

    StrQuery := 'SELECT * FROM transfercargo;';

    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(StrQuery);
      Active := True;

      ReceivingSearch('');
    end;

    VST.RootNodeCount := ADOQuery.RecordCount;
    VST.Selected[VST.GetFirst] := True;
    VST.FocusedNode := VST.GetFirst;

    FrameStatusBar.InsertText(1, IntToStr(1));
  except
    on E: Exception do
      MessageBox(0, PChar('При запросе к БД возникла ошибка:' + sLineBreak + sLineBreak + E.Message), CaptionFrame,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.ReceivingSearch(vStr: String);
begin
  ADOQuery.Filtered := False;

  if (StrFilterData <> '') and (vStr <> '') then
    ADOQuery.Filter := StrFilterData + ' and ' + vStr
  else if StrFilterData = '' then
    ADOQuery.Filter := vStr
  else if vStr = '' then
    ADOQuery.Filter := StrFilterData;

  ADOQuery.Filtered := True;

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
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.EditSearchEnter(Sender: TObject);
begin
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // Русский
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // Английский
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.EditSearchKeyPress(Sender: TObject; var Key: Char);
begin
  with (Sender as TEdit) do
    if (Key = #13) and (Text <> '') then // Если нажата клавиша "Enter" и строка поиска не пуста
      ReceivingSearch(FilteredString(Text, 'distance'))
    else if (Key = #27) or ((Key = #13) and (Text = '')) then // Нажата клавиша ESC, или Enter и строка поиска пуста
    begin
      Text := '';
      ReceivingSearch('');
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.FrameEnter(Sender: TObject);
begin
  EditSearch.SetFocus;

  if not ADOQuery.Active then
    Exit;

  FrameStatusBar.InsertText(0, IntToStr(ADOQuery.RecordCount)); // Количество записей

  if ADOQuery.RecordCount > 0 then
    FrameStatusBar.InsertText(1, IntToStr(VST.FocusedNode.Index + 1)) // Номер выделенной записи
  else
    FrameStatusBar.InsertText(1, '-1'); // Нет записей
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.FrameExit(Sender: TObject);
begin
  with FrameStatusBar do
  begin
    InsertText(0, '');
    InsertText(1, '');
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.FrameResize(Sender: TObject);
begin
  AutoWidthColumn(VST, 1);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.PanelTableResize(Sender: TObject);
begin
  ImageSplitter.Top := Splitter.Top;
  ImageSplitter.Left := Splitter.Left + (Splitter.Width - ImageSplitter.Width) div 2;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.CopyCellClick(Sender: TObject);
var
  ClipBoard: TClipboard;
  CellText: string;
begin
  ADOQuery.RecNo := VST.FocusedNode.Index + 1;

  case VST.FocusedColumn of
    1:
      CellText := ADOQuery.FieldByName('distance').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('class1_1').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('class1_2').AsVariant;
    4:
      CellText := ADOQuery.FieldByName('class2_1').AsVariant;
    5:
      CellText := ADOQuery.FieldByName('class2_2').AsVariant;
    6:
      CellText := ADOQuery.FieldByName('class3_1').AsVariant;
    7:
      CellText := ADOQuery.FieldByName('class3_2').AsVariant;
    8:
      CellText := ADOQuery.FieldByName('class4_1').AsVariant;
    9:
      CellText := ADOQuery.FieldByName('class4_2').AsVariant;
  end;

  ClipBoard := TClipboard.Create;
  ClipBoard.SetTextBuf(PWideChar(WideString(CellText)));
  FreeAndNil(ClipBoard);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.MemoEnter(Sender: TObject);
begin
  Memo.SelStart := Length(Memo.Text);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.SpeedButtonShowHideClick(Sender: TObject);
begin
  MemoShowHide(Sender, Splitter, PanelMemo);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.VSTAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellRect: TRect);
var
  CellText: string;
begin
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
    Exit;

  ADOQuery.RecNo := Node.Index + 1;

  case Column of
    1:
      CellText := ADOQuery.FieldByName('distance').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('class1_1').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('class1_2').AsVariant;
    4:
      CellText := ADOQuery.FieldByName('class2_1').AsVariant;
    5:
      CellText := ADOQuery.FieldByName('class2_2').AsVariant;
    6:
      CellText := ADOQuery.FieldByName('class3_1').AsVariant;
    7:
      CellText := ADOQuery.FieldByName('class3_2').AsVariant;
    8:
      CellText := ADOQuery.FieldByName('class4_1').AsVariant;
    9:
      CellText := ADOQuery.FieldByName('class4_2').AsVariant;
  end;

  VSTAfterCellPaintDefault(Sender, TargetCanvas, Node, Column, CellRect, CellText);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  VSTBeforeCellPaintDefault(Sender, TargetCanvas, Node, Column, CellPaintMode, CellRect, ContentRect);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.VSTEnter(Sender: TObject);
begin
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // Русский
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // Английский
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex);
begin
  VSTFocusChangedDefault(Sender, Node, Column);

  // ----------------------------------------

  // Выводим название в Memo под таблицей

  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
    Exit;

  ADOQuery.RecNo := Node.Index + 1;
  Memo.Text := ADOQuery.FieldByName('distance').AsVariant;
  FrameStatusBar.InsertText(1, IntToStr(Node.Index + 1));
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
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
        CellText := 'Записей не найдено!';
      2:
        CellText := '';
      3:
        CellText := '';
      4:
        CellText := '';
      5:
        CellText := '';
      6:
        CellText := '';
      7:
        CellText := '';
      8:
        CellText := '';
      9:
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
      CellText := ADOQuery.FieldByName('distance').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('class1_1').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('class1_2').AsVariant;
    4:
      CellText := ADOQuery.FieldByName('class2_1').AsVariant;
    5:
      CellText := ADOQuery.FieldByName('class2_2').AsVariant;
    6:
      CellText := ADOQuery.FieldByName('class3_1').AsVariant;
    7:
      CellText := ADOQuery.FieldByName('class3_2').AsVariant;
    8:
      CellText := ADOQuery.FieldByName('class4_1').AsVariant;
    9:
      CellText := ADOQuery.FieldByName('class4_2').AsVariant;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.ComboBoxMonthYearChange(Sender: TObject);
begin
  StrFilterData := 'year = ' + ComboBoxYear.Text + ' and monat = ' + IntToStr(ComboBoxMonth.ItemIndex + 1);

  EditSearch.Text := '';
  FrameStatusBar.InsertText(2, '-1');

  ReceivingSearch('');
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
