unit fFramePriceTransportations;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, Buttons, ExtCtrls, Menus, Clipbrd, DB,
  VirtualTrees, fFrameStatusBar, DateUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, fFrameSmeta, Vcl.Samples.Spin;

type
  TSplitter = class(ExtCtrls.TSplitter)
  private
    procedure Paint(); override;
  end;

type
  TFramePriceTransportations = class(TSmetaFrame)

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
    LabelMonth: TLabel;
    ComboBoxMonth: TComboBox;
    ADOQuery: TFDQuery;
    edtYear: TSpinEdit;

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
    StrFilterData: string; // ���������� ������ �� ������ � ����
  public
    procedure ReceivingAll; override;
    constructor Create(AOwner: TComponent);
  end;

implementation

uses DrawingTables, DataModule, CalculationEstimate;

{$R *.dfm}

const
  // �������� ����� ������
  CaptionFrame = '����� ������� �� ���������������';

  // ������ ���������� �������� ���� ������� �������� �������
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

  VSTSetting(VST); // ����������� �����

  PanelMemo.Constraints.MinHeight := 35;
  SpeedButtonShowHide.Hint := '�������� ������';

  with DM do
  begin
    ImageListHorozontalDots.GetIcon(0, ImageSplitter.Picture.Icon);
    ImageListArrowsBottom.GetBitmap(0, SpeedButtonShowHide.Glyph);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.ReceivingAll;
begin
  try
    if ADOQuery.Active then
      Exit;

    if Assigned(FormCalculationEstimate) then
    begin
      //������� �����������, ����� ���� ���������� ������
      ComboBoxMonth.ItemIndex := FormCalculationEstimate.GetMonth - 1;
      edtYear.Value := FormCalculationEstimate.GetYear;
    end
    else
    begin
      //������ ������� ����
      ComboBoxMonth.ItemIndex := MonthOf(Now) - 1;
      edtYear.Value := YearOf(Now);
    end;

    StrFilterData := '(year = ' + IntToStr(edtYear.Value) +
      ') and (monat = ' + IntToStr(ComboBoxMonth.ItemIndex + 1) + ')';

    ReceivingSearch('');
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� � �� �������� ������:' + sLineBreak + sLineBreak + E.Message), CaptionFrame,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  fLoaded := true;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.ReceivingSearch(vStr: String);
var
  WhereStr: string;
  FilterStr, StrQuery: string;
begin
  FilterStr := '';
  if (StrFilterData <> '') and (vStr <> '') then
    FilterStr := StrFilterData + ' and (' + vStr + ')'
  else if StrFilterData = '' then
    FilterStr := vStr
  else if vStr = '' then
    FilterStr := StrFilterData;

  if FilterStr <> '' then WhereStr := ' where ' + FilterStr
  else WhereStr := '';


  StrQuery := 'SELECT * FROM transfercargo' + WhereStr + ';';

  with ADOQuery do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(StrQuery);
    Active := True;
    FetchAll;
  end;

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
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // �������
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // ����������
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.EditSearchKeyPress(Sender: TObject; var Key: Char);
begin
  with (Sender as TEdit) do
    if (Key = #13) and (Text <> '') then // ���� ������ ������� "Enter" � ������ ������ �� �����
      ReceivingSearch(FilteredString(Text, 'distance'))
    else if (Key = #27) or ((Key = #13) and (Text = '')) then // ������ ������� ESC, ��� Enter � ������ ������ �����
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

  FrameStatusBar.InsertText(0, IntToStr(VST.RootNodeCount)); // ���������� �������

  if ADOQuery.RecordCount > 0 then
    FrameStatusBar.InsertText(1, IntToStr(VST.FocusedNode.Index + 1)) // ����� ���������� ������
  else
    FrameStatusBar.InsertText(1, '-1'); // ��� �������
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
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) or
    (not Assigned(Node))
  then Exit;

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
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // �������
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // ����������
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceTransportations.VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex);
begin
  VSTFocusChangedDefault(Sender, Node, Column);

  // ----------------------------------------

  // ������� �������� � Memo ��� ��������

  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) or
    (not Assigned(Node))
  then Exit;

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
        CellText := '������� �� �������!';
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
  StrFilterData := '(year = ' + IntToStr(edtYear.Value) +
    ') and (monat = ' + IntToStr(ComboBoxMonth.ItemIndex + 1) + ')';

  EditSearch.Text := '';
  FrameStatusBar.InsertText(2, '-1');

  ReceivingSearch('');
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
