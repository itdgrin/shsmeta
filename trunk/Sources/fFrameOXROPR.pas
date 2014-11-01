unit fFrameOXROPR;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, Buttons, ExtCtrls, Menus, Clipbrd, DB,
  DBCtrls, VirtualTrees, fFrameStatusBar, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, fFrameSmeta;

type
  TSplitter = class(ExtCtrls.TSplitter)
  private
    procedure Paint(); override;
  end;

type
  TFrameOXROPR = class(TSmetaFrame)
    DataSourceTypeWork: TDataSource;

    PopupMenu: TPopupMenu;
    CopyCell: TMenuItem;
    OXROPRSearch: TMenuItem;
    OXROPRSearchFast: TMenuItem;
    OXROPRSearchAccurate: TMenuItem;

    Panel: TPanel;
    PanelTop: TPanel;
    PanelMemo: TPanel;
    PanelTable: TPanel;

    RadioButtonCity: TRadioButton;
    RadioButtonVillage: TRadioButton;
    RadioButtonMinsk: TRadioButton;

    Memo: TMemo;
    BevelLine: TBevel;

    Splitter: TSplitter;
    ImageSplitter: TImage;
    LabelTypeWork: TLabel;
    LabelResolution: TLabel;
    VST: TVirtualStringTree;
    ComboBoxResolution: TComboBox;
    FrameStatusBar: TFrameStatusBar;
    SpeedButtonShowHide: TSpeedButton;
    DBLookupComboBoxTypeWork: TDBLookupComboBox;
    ADOQueryTemp: TFDQuery;
    ADOQueryTypeWork: TFDQuery;
    ADOQuery: TFDQuery;

    procedure FillingTypeWork;
    procedure FillingResolution;
    procedure ReceivingSearch(vStr: String);
    procedure DBLookupComboBoxTypeWorkClick(Sender: TObject);

    procedure FrameEnter(Sender: TObject);
    procedure FrameExit(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure PanelTableResize(Sender: TObject);
    procedure PanelTopResize(Sender: TObject);
    procedure RadioButtonClick(Sender: TObject);

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
  public
     procedure ReceivingAll; override;
     constructor Create(AOwner: TComponent);
  end;

implementation

uses DrawingTables, DataModule;

{$R *.dfm}

const
  // Название этого фрейма
  CaptionFrame = 'Фрейм «ОХР и ОПР»';

  // ---------------------------------------------------------------------------------------------------------------------

  { TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFrameOXROPR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // ----------------------------------------

  VSTSetting(VST); // НАСТРАИВАЕМ ЦВЕТА

  PanelMemo.Constraints.MinHeight := 35;
  SpeedButtonShowHide.Hint := 'Свернуть панель';

  with DM do
  begin
    ImageListHorozontalDots.GetIcon(0, ImageSplitter.Picture.Icon);
    ImageListArrowsBottom.GetBitmap(0, SpeedButtonShowHide.Glyph);
  end;

  // ----------------------------------------

  FillingTypeWork;
  FillingResolution;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.FillingTypeWork;
var
  StrQuery: string;
  IdRegion: Integer;
begin
  try
    if RadioButtonMinsk.Checked then
      IdRegion := 3
    else if RadioButtonCity.Checked then
      IdRegion := 1
    else
      IdRegion := 2;

    StrQuery := 'SELECT * FROM objstroj WHERE obj_region = ' + IntToStr(IdRegion);

    with ADOQueryTypeWork do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(StrQuery);
      Active := True;
    end;

    // Находим минимальный Id типа строительства
    with DataSourceTypeWork.DataSet do
    begin
      First;
      IdRegion := FieldByName('stroj_id').AsVariant;
      Next;

      while Eof do
        if IdRegion < FieldByName('stroj_id').AsVariant then
          IdRegion := FieldByName('stroj_id').AsVariant;

      Next;
    end;

    with DBLookupComboBoxTypeWork do
    begin
      ListSource := DataSourceTypeWork;
      ListField := 'name';
      KeyField := 'stroj_id';
      KeyValue := IdRegion;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При заполнении выпадающего списка ' + sLineBreak + '«Вид работ» возникла ошибка:' +
        sLineBreak + sLineBreak + E.Message), CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.FillingResolution;
var
  StrQuery: string;
begin
  try
    StrQuery := 'SELECT * FROM mais ORDER BY comment;';

    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(StrQuery);
      Active := True;

      First;
      ComboBoxResolution.Items.Clear;

      while not Eof do
      begin
        ComboBoxResolution.Items.Add(FieldByName('comment').AsVariant);
        Next;
      end;
    end;

    ComboBoxResolution.ItemIndex := 0;
  except
    on E: Exception do
      MessageBox(0, PChar('При заполнении выпадающего списка ' + sLineBreak + '«Постановления» возникла ошибка:' +
        sLineBreak + sLineBreak + E.Message), CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.ReceivingAll;
begin
  ReceivingSearch('stroj_id = ' + IntToStr(DBLookupComboBoxTypeWork.KeyValue));
  fLoaded := true;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.ReceivingSearch(vStr: String);
var
  StrQuery: string;
  WhereStr: string;
begin
  if vStr <> '' then WhereStr := ' where ' + vStr
  else WhereStr := '';

  StrQuery := 'SELECT id as "Id", stroj_id as "IdStroj", number as "Number", ' +
    'name as "NameWork", p1 as "P1", p2 as "P2" ' +
    'FROM objdetail' + WhereStr + ' ORDER BY number ASC';

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
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.DBLookupComboBoxTypeWorkClick(Sender: TObject);
begin
  ReceivingSearch('stroj_id = ' + IntToStr((Sender as TDBLookupComboBox).KeyValue));

  VST.Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.FrameEnter(Sender: TObject);
begin
  FrameStatusBar.InsertText(0, IntToStr(VST.RootNodeCount)); // Количество записей

  if ADOQuery.RecordCount > 0 then
    FrameStatusBar.InsertText(1, IntToStr(VST.FocusedNode.Index + 1)) // Номер выделенной записи
  else
    FrameStatusBar.InsertText(1, '-1'); // Нет записей
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.FrameExit(Sender: TObject);
begin
  with FrameStatusBar do
  begin
    InsertText(0, '');
    InsertText(1, '');
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.FrameResize(Sender: TObject);
begin
  AutoWidthColumn(VST, 2);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.PanelTableResize(Sender: TObject);
begin
  ImageSplitter.Top := Splitter.Top;
  ImageSplitter.Left := Splitter.Left + (Splitter.Width - ImageSplitter.Width) div 2;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.PanelTopResize(Sender: TObject);
begin
  DBLookupComboBoxTypeWork.Left := LabelTypeWork.Left + LabelTypeWork.Width + 6;
  DBLookupComboBoxTypeWork.Width := 200;

  LabelResolution.Left := DBLookupComboBoxTypeWork.Left + DBLookupComboBoxTypeWork.Width + 6;

  ComboBoxResolution.Left := LabelResolution.Left + LabelResolution.Width + 6;
  ComboBoxResolution.Width := PanelTop.Width - ComboBoxResolution.Left - 3;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.RadioButtonClick(Sender: TObject);
begin
  FillingTypeWork;
  ReceivingSearch('stroj_id = ' + IntToStr(DBLookupComboBoxTypeWork.KeyValue));

  VST.Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.CopyCellClick(Sender: TObject);
var
  ClipBoard: TClipboard;
  CellText: string;
begin
  ADOQuery.RecNo := VST.FocusedNode.Index + 1;

  case VST.FocusedColumn of
    1:
      CellText := ADOQuery.FieldByName('Number').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('NameWork').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('P1').AsVariant;
    4:
      CellText := ADOQuery.FieldByName('P2').AsVariant;
  end;

  ClipBoard := TClipboard.Create;
  ClipBoard.SetTextBuf(PWideChar(WideString(CellText)));
  FreeAndNil(ClipBoard);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.MemoEnter(Sender: TObject);
begin
  Memo.SelStart := Length(Memo.Text);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.SpeedButtonShowHideClick(Sender: TObject);
begin
  MemoShowHide(Sender, Splitter, PanelMemo);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.VSTAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellRect: TRect);
var
  CellText: string;
begin
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
    Exit;

  ADOQuery.RecNo := Node.Index + 1;

  case Column of
    1:
      CellText := ADOQuery.FieldByName('Number').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('NameWork').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('P1').AsVariant;
    4:
      CellText := ADOQuery.FieldByName('P2').AsVariant;
  end;

  VSTAfterCellPaintDefault(Sender, TargetCanvas, Node, Column, CellRect, CellText);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  VSTBeforeCellPaintDefault(Sender, TargetCanvas, Node, Column, CellPaintMode, CellRect, ContentRect);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.VSTEnter(Sender: TObject);
begin
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // Русский
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // Английский
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
begin
  VSTFocusChangedDefault(Sender, Node, Column);

  // ----------------------------------------

  // Выводим название в Memo под таблицей

  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) or (not Assigned(Node))
  then Exit;

  ADOQuery.RecNo := Node.Index + 1;
  Memo.Text := ADOQuery.FieldByName('NameWork').AsVariant;
  FrameStatusBar.InsertText(1, IntToStr(Node.Index + 1));
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
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
    end;

    Exit;
  end;

  if Column > 0 then
    ADOQuery.RecNo := Node.Index + 1;

  case Column of
    0:
      CellText := IntToStr(Node.Index + 1);
    1:
      CellText := ADOQuery.FieldByName('Number').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('NameWork').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('P1').AsVariant;
    4:
      CellText := ADOQuery.FieldByName('P2').AsVariant;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
