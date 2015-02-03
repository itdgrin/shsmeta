unit fFramePriceDumps;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, Buttons, ExtCtrls, Menus, Clipbrd, DB,
  VirtualTrees, fFrameStatusBar, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, fFrameSmeta, Vcl.Samples.Spin, System.DateUtils;

type
  TSplitter = class(ExtCtrls.TSplitter)
  private
    procedure Paint(); override;
  end;

type
  TFramePriceDumps = class(TSmetaFrame)

    PopupMenu: TPopupMenu;
    CopyCell: TMenuItem;
    DumpSearch: TMenuItem;
    DumpSearchFast: TMenuItem;
    DumpSearchAccurate: TMenuItem;

    Panel: TPanel;
    PanelMemo: TPanel;
    PanelSearch: TPanel;
    PanelTable: TPanel;

    Memo: TMemo;
    EditSearch: TEdit;
    LabelSearch: TLabel;
    Splitter: TSplitter;
    ImageSplitter: TImage;
    VST: TVirtualStringTree;
    FrameStatusBar: TFrameStatusBar;
    SpeedButtonShowHide: TSpeedButton;
    ADOQuery: TFDQuery;
    LabelYear: TLabel;
    LabelMonth: TLabel;
    ComboBoxMonth: TComboBox;
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
    procedure VSTExit(Sender: TObject);
    procedure VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure VSTKeyPress(Sender: TObject; var Key: Char);
    procedure edtYearChange(Sender: TObject);
    procedure ComboBoxMonthChange(Sender: TObject);

  private
    StrQuickSearch: String[20];
    NomColumn: Integer;
  public
    procedure ReceivingAll; override;
    constructor Create(AOwner: TComponent);
  end;

implementation

uses DrawingTables, DataModule, CalculationEstimate;

{$R *.dfm}

const
  // �������� ����� ������
  CaptionFrame = '����� ������� �� �������';

  // ������ ���������� �������� ���� ������� �������� �������
  NameVisibleColumns: array [1 .. 1] of String[4] = ('Name');

  // ---------------------------------------------------------------------------------------------------------------------

  { TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
end;

// ---------------------------------------------------------------------------------------------------------------------

constructor TFramePriceDumps.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // ----------------------------------------

  VSTSetting(VST); // ����������� �����

  PanelMemo.Constraints.MinHeight := 35;
  SpeedButtonShowHide.Hint := '�������� ������';

  if Assigned(FormCalculationEstimate) then
  begin
    //������� �����������, ����� ���� ���������� ������
    ComboBoxMonth.ItemIndex := FormCalculationEstimate.GetMonth - 1;
    edtYear.Value := FormCalculationEstimate.GetYear;
  end
  else
  begin
    edtYear.Value := YearOf(Date);
    ComboBoxMonth.ItemIndex := MonthOf(Date) - 1;
  end;

  with DM do
  begin
    ImageListHorozontalDots.GetIcon(0, ImageSplitter.Picture.Icon);
    ImageListArrowsBottom.GetBitmap(0, SpeedButtonShowHide.Glyph);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.ReceivingAll;
var
  te : TDateTime;
begin
  StrQuickSearch := '';

  try
    ADOQuery.Active := False;

    ADOQuery.SQL.Text := 'SELECT dump.dump_id, dump_name as "Name", ' +
      'coast1 as "PriceNotVAT", coast2 as "PriceVAT", ' +
      'unit_name as "Unit", region_name as "NameRegion" ' +
      'FROM dump JOIN units ON dump.unit_id = units.unit_id ' +
      'JOIN regions ON dump.region_id = regions.region_id ' +
      'LEFT JOIN dumpcoast ON dump.dump_id = dumpcoast.dump_id ' +
      'WHERE (dumpcoast.DATE_BEG >= :date1) and (dumpcoast.DATE_BEG <= :date2);';

    te := EncodeDate(edtYear.Value, ComboBoxMonth.ItemIndex + 1, 1);
    ADOQuery.ParamByName('date1').Value := te;
    te := IncMonth(te) - 1;
    ADOQuery.ParamByName('date2').Value := te;

    ADOQuery.Active := True;

    VST.RootNodeCount := ADOQuery.RecordCount;
    VST.Selected[VST.GetFirst] := True;
    VST.FocusedNode := VST.GetFirst;

    FrameStatusBar.InsertText(1, IntToStr(1));
    FrameStatusBar.InsertText(2, '');
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� � �� �������� ������:' + sLineBreak + sLineBreak + E.Message), CaptionFrame,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
  fLoaded := true;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.ReceivingSearch(vStr: String);
begin
  ADOQuery.Filtered := False;
  ADOQuery.Filter := vStr;

  if vStr = '' then
    ADOQuery.Filtered := False
  else
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

procedure TFramePriceDumps.EditSearchEnter(Sender: TObject);
begin
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // �������
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // ����������
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.EditSearchKeyPress(Sender: TObject; var Key: Char);
begin
  with (Sender as TEdit) do
    if (Key = #13) and (Text <> '') then // ���� ������ ������� "Enter" � ������ ������ �� �����
      ReceivingSearch(FilteredString(Text, 'Name'))
    else if (Key = #27) or ((Key = #13) and (Text = '')) then // ������ ������� ESC, ��� Enter � ������ ������ �����
    begin
      Text := '';
      ReceivingSearch('');
    end;
end;

procedure TFramePriceDumps.edtYearChange(Sender: TObject);
begin
  inherited;
  ReceivingAll;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.FrameEnter(Sender: TObject);
begin
  FrameStatusBar.InsertText(0, IntToStr(ADOQuery.RecordCount)); // ���������� �������

  if ADOQuery.RecordCount > 0 then
    FrameStatusBar.InsertText(1, IntToStr(VST.FocusedNode.Index + 1)) // ����� ���������� ������
  else
    FrameStatusBar.InsertText(1, '-1'); // ��� �������

  EditSearch.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.FrameExit(Sender: TObject);
begin
  with FrameStatusBar do
  begin
    InsertText(0, '');
    InsertText(1, '');
    InsertText(2, '');
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.FrameResize(Sender: TObject);
begin
  AutoWidthColumn(VST, 1);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.PanelTableResize(Sender: TObject);
begin
  ImageSplitter.Top := Splitter.Top;
  ImageSplitter.Left := Splitter.Left + (Splitter.Width - ImageSplitter.Width) div 2;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.ComboBoxMonthChange(Sender: TObject);
begin
  inherited;
  ReceivingAll;
end;

procedure TFramePriceDumps.CopyCellClick(Sender: TObject);
var
  ClipBoard: TClipboard;
  CellText: string;
begin
  ADOQuery.RecNo := VST.FocusedNode.Index + 1;

  case VST.FocusedColumn of
    1:
      CellText := ADOQuery.FieldByName('Name').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('PriceNotVAT').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('PriceVAT').AsVariant;
    4:
      CellText := ADOQuery.FieldByName('Unit').AsVariant;
    5:
      CellText := ADOQuery.FieldByName('NameRegion').AsVariant;
  end;

  ClipBoard := TClipboard.Create;
  ClipBoard.SetTextBuf(PWideChar(WideString(CellText)));
  FreeAndNil(ClipBoard);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.MemoEnter(Sender: TObject);
begin
  Memo.SelStart := Length(Memo.Text);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.SpeedButtonShowHideClick(Sender: TObject);
begin
  MemoShowHide(Sender, Splitter, PanelMemo);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.VSTAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellRect: TRect);
var
  CellText: string;
begin
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) or
    (not Assigned(Node))
  then Exit;

  ADOQuery.RecNo := Node.Index + 1;

  case Column of
    1:
      CellText := ADOQuery.FieldByName('Name').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('PriceNotVAT').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('PriceVAT').AsVariant;
    4:
      CellText := ADOQuery.FieldByName('Unit').AsVariant;
    5:
      CellText := ADOQuery.FieldByName('NameRegion').AsVariant;
  end;

  VSTAfterCellPaintDefault(Sender, TargetCanvas, Node, Column, CellRect, CellText);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  VSTBeforeCellPaintDefault(Sender, TargetCanvas, Node, Column, CellPaintMode, CellRect, ContentRect);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.VSTEnter(Sender: TObject);
var
  NumCol: Integer;
begin
  NumCol := (Sender as TVirtualStringTree).FocusedColumn;

  if (NumCol = 1) then
    FrameStatusBar.InsertText(2, '-1') // ����� �� ������� ����
  else
    FrameStatusBar.InsertText(2, ''); // ����� �� ������� ���

  // ----------------------------------------

  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // �������
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // ����������
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.VSTExit(Sender: TObject);
begin
  StrQuickSearch := '';
  FrameStatusBar.InsertText(2, '');
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
begin
  VSTFocusChangedDefault(Sender, Node, Column);

  // ----------------------------------------

  // ���� ������� �� ������ ������� (�������), �� ������� ������ �������� ������
  if NomColumn <> Column then
  begin
    StrQuickSearch := '';
    if (Column = 1) then
      FrameStatusBar.InsertText(2, '-1') // ����� �� ������� ����
    else
      FrameStatusBar.InsertText(2, '') // ����� �� ������� ���
  end;

  NomColumn := Column;

  // ----------------------------------------

  // ������� �������� � Memo ��� ��������

  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) or
    (not Assigned(Node))
  then Exit;

  ADOQuery.RecNo := Node.Index + 1;
  Memo.Text := ADOQuery.FieldByName('Name').AsVariant;
  FrameStatusBar.InsertText(1, IntToStr(Node.Index + 1));
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
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
    end;

    Exit;
  end;

  if Column > 0 then
    ADOQuery.RecNo := Node.Index + 1;

  case Column of
    0:
      CellText := IntToStr(Node.Index + 1);
    1:
      CellText := ADOQuery.FieldByName('Name').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('PriceNotVAT').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('PriceVAT').AsVariant;
    4:
      CellText := ADOQuery.FieldByName('Unit').AsVariant;
    5:
      CellText := ADOQuery.FieldByName('NameRegion').AsVariant;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceDumps.VSTKeyPress(Sender: TObject; var Key: Char);
var
  NameColumn: string;
  NumCol: Integer;
begin
  NumCol := (Sender as TVirtualStringTree).FocusedColumn;

  if not(NumCol = 1) then
    Exit;

  // ��������� ���� ������� �������� (unicode) + ������ "������" + �����
  // �������: �-� = 1040-1071, � = 1025, �����: �-� = 1072-1103, � = 1105
  if ((Key >= #1040) and (Key <= #1103)) or (Key = #1025) or (Key = #1105) or (Key = #32) or
    ((Key >= '0') and (Key <= '9')) or (Key = '-') then
  begin
    NameColumn := string(NameVisibleColumns[NumCol]); // �������� ����������� �������

    StrQuickSearch := StrQuickSearch + string(Key); // ������� ������ � ������ �������� ������

    FrameStatusBar.InsertText(2, string(StrQuickSearch));

    ReceivingSearch(NameColumn + ' LIKE ''' + string(StrQuickSearch) + '%''');
  end
  else if Key = #08 then // ���� ���� ������ ������� "Backspace"
  begin
    StrQuickSearch := ''; // ������� ������ �������� ������

    FrameStatusBar.InsertText(2, '-1');

    ReceivingSearch('');
  end;
end;

end.
