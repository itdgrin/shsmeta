unit fFramePriceMechanizms;

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
  TFramePriceMechanizm = class(TFrame)

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

    constructor Create(AOwner: TComponent; const vDataBase: Char;
      const vPriceColumn, vAllowAddition: Boolean);

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
    procedure VSTDblClick(Sender: TObject);
    procedure VSTEnter(Sender: TObject);
    procedure VSTExit(Sender: TObject);
    procedure VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure VSTKeyPress(Sender: TObject; var Key: Char);

    procedure ComboBoxMonthYearChange(Sender: TObject);

  private
    StrQuickSearch: String[20];
    NomColumn: Integer;

    DataBase: Char; // ���������� ��� ����������� ������
    PriceColumn: Boolean; // ����������/�� ���������� ������� ����
    AllowAddition: Boolean; // ���������/��������� ��������� ������ �� ������

    StrFilterData: string; // ���������� ������ �� ������ � ����
  end;

implementation

uses Main, DrawingTables, DataModule, CalculationEstimate;

{$R *.dfm}

const
  // �������� ����� ������
  CaptionFrame = '����� ����� �� ����������';

  // ������ ���������� �������� ���� ������� �������� �������
  NameVisibleColumns: array [1 .. 2] of String[4] = ('Code', 'Name');

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

  // ���������� ��� �������� ������� � �����
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

procedure TFramePriceMechanizm.ReceivingAll;
var
  StrQuery: string;
begin
  StrQuickSearch := '';

  try
    if ADOQuery.Active then
      Exit;

    if PriceColumn then
    begin
      ADOQueryTemp.Active := False;
      ADOQueryTemp.SQL.Clear;
      ADOQueryTemp.SQL.Add('SELECT stavka.monat, stavka.year'#13 +
        'FROM smetasourcedata, stavka WHERE smetasourcedata.sm_id=:sm_id and smetasourcedata.stavka_id=stavka.stavka_id;');
      ADOQueryTemp.ParamByName('sm_id').Value := FormCalculationEstimate.GetIdEstimate;
      ADOQueryTemp.Active := True;

      ComboBoxMonth.ItemIndex := ADOQueryTemp.FieldByName('monat').AsVariant - 1;
      ComboBoxYear.ItemIndex := 2012 - ADOQueryTemp.FieldByName('year').AsInteger;

      StrFilterData := 'year = ' + ComboBoxYear.Text + ' and monat = ' +
        IntToStr(ComboBoxMonth.ItemIndex + 1);

      StrQuery :=
        'SELECT mechanizm.mechanizm_id as "Id", mech_code as "Code", cast(mech_name as char(1024)) as "Name", '
        + 'unit_name as "Unit", coast1 "PriceVAT", coast2 as "PriceNotVAT", monat, year ' +
        'FROM mechanizm, units, mechanizmcoast' + DataBase +
        ' WHERE mechanizm.unit_id = units.unit_id and mechanizm.mechanizm_id = mechanizmcoast' + DataBase +
        '.mechanizm_id ORDER BY mech_code, mech_name ASC' + ';'
    end
    else
      StrQuery :=
        'SELECT mechanizm_id as "Id", mech_code as "Code", cast(mech_name as char(1024)) as "Name", ' +
        'unit_name as "Unit" FROM mechanizm, units WHERE mechanizm.unit_id = units.unit_id ORDER BY mech_code, mech_name ASC;';

    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(StrQuery);
      Active := True;
      FetchAll;

      ReceivingSearch('');
    end;

    VST.RootNodeCount := ADOQuery.RecordCount;
    VST.Selected[VST.GetFirst] := True;
    VST.FocusedNode := VST.GetFirst;

    FrameStatusBar.InsertText(0, IntToStr(ADOQuery.RecordCount));
    FrameStatusBar.InsertText(1, IntToStr(1));
    FrameStatusBar.InsertText(2, '');
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� � �� �������� ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.ReceivingSearch(vStr: String);
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

procedure TFramePriceMechanizm.EditSearchEnter(Sender: TObject);
begin
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // �������
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // ����������
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.EditSearchKeyPress(Sender: TObject; var Key: Char);
begin
  with (Sender as TEdit) do
    if (Key = #13) and (Text <> '') then // ���� ������ ������� "Enter" � ������ ������ �� �����
      ReceivingSearch(FilteredString(Text, 'Name'))
    else if (Key = #27) or ((Key = #13) and (Text = '')) then
    // ������ ������� ESC, ��� Enter � ������ ������ �����
    begin
      Text := '';
      ReceivingSearch('');
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.FrameEnter(Sender: TObject);
begin
  EditSearch.SetFocus;

  if not ADOQuery.Active then
    Exit;

  FrameStatusBar.InsertText(0, IntToStr(ADOQuery.RecordCount)); // ���������� �������

  if ADOQuery.RecordCount > 0 then
    FrameStatusBar.InsertText(1, IntToStr(VST.FocusedNode.Index + 1)) // ����� ���������� ������
  else
    FrameStatusBar.InsertText(1, '-1'); // ��� �������
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
    FormCalculationEstimate.AddMechanizm(ADOQuery.FieldByName('Id').AsInteger,
      ADOQuery.FieldByName('monat').AsInteger, ADOQuery.FieldByName('year').AsInteger);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePriceMechanizm.VSTEnter(Sender: TObject);
var
  NumCol: Integer;
begin
  NumCol := (Sender as TVirtualStringTree).FocusedColumn;

  if (NumCol = 1) or (NumCol = 2) then
    FrameStatusBar.InsertText(2, '-1') // ����� �� ������� ����
  else
    FrameStatusBar.InsertText(2, ''); // ����� �� ������� ���

  // ----------------------------------------

  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // �������
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // ����������
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

  // ���� ������� �� ������ ������� (�������), �� ������� ������ �������� ������
  if NomColumn <> Column then
  begin
    StrQuickSearch := '';
    if (Column = 1) or (Column = 2) then
      FrameStatusBar.InsertText(2, '-1') // ����� �� ������� ����
    else
      FrameStatusBar.InsertText(2, '') // ����� �� ������� ���
  end;

  NomColumn := Column;

  // ----------------------------------------

  // ������� �������� � Memo ��� ��������

  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
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
        CellText := '������� �� �������!';
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

  // ��������� ���� ������� �������� (unicode) + ������ "������" + �����
  // �������: �-� = 1040-1071, � = 1025, �����: �-� = 1072-1103, � = 1105
  if ((Key >= #1040) and (Key <= #1103)) or (Key = #1025) or (Key = #1105) or (Key = #32) or
    ((Key >= '0') and (Key <= '9')) or (Key = '-') then
  begin
    NameColumn := NameVisibleColumns[NumCol]; // �������� ����������� �������

    StrQuickSearch := StrQuickSearch + Key; // ������� ������ � ������ �������� ������

    FrameStatusBar.InsertText(2, StrQuickSearch);

    ReceivingSearch(NameColumn + ' LIKE ''' + StrQuickSearch + '%''');
  end
  else if Key = #08 then // ���� ���� ������ ������� "Backspace"
  begin
    StrQuickSearch := ''; // ������� ������ �������� ������

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
