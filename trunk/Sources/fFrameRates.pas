unit fFrameRates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons,
  DBGrids, Grids, System.UITypes,
  ExtCtrls, DB, VirtualTrees, fFrameStatusBar, Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, fFrameSmeta;

type
  TSplitter = class(ExtCtrls.TSplitter)
  public
    procedure Paint(); override;
  end;

type
  TFrameRates = class(TSmetaFrame)
    PanelRates: TPanel;
    SplitterLeft: TSplitter;
    ImageSplitterLeft: TImage;
    ImageSplitterRight: TImage;
    SplitterRight: TSplitter;
    PanelLeft: TPanel;
    PanelRight: TPanel;
    PanelCenter: TPanel;
    PanelShowHideButton: TPanel;
    SpeedButtonShowHideRightPanel: TSpeedButton;
    PanelCenterClient: TPanel;
    ImageSplitterTop: TImage;
    SplitterTop: TSplitter;
    PanelCollection: TPanel;
    PanelHeaderCollection: TPanel;
    MemoDescription: TMemo;
    PanelSearchNormative: TPanel;
    LabelSearchNormative: TLabel;
    EditSearchNormative: TEdit;
    VST: TVirtualStringTree;
    FrameStatusBar: TFrameStatusBar;
    EditRate: TEdit;
    EditCollection: TEdit;
    LabelSbornik: TLabel;
    PopupMenuRates: TPopupMenu;
    FindToRates: TMenuItem;
    Panel1: TPanel;
    PanelHorizontal1: TPanel;
    LabelJustification: TLabel;
    LabelUnit: TLabel;
    EditJustification: TEdit;
    Edit5: TEdit;
    EditUnit: TEdit;
    PanelHorizontal2: TPanel;
    PanelHorizontal3: TPanel;
    Label2: TLabel;
    CheckBoxNorm�onsumption: TCheckBox;
    CheckBoxStructureWorks: TCheckBox;
    CheckBoxChangesAdditions: TCheckBox;
    ImageSplitter1: TImage;
    ImageSplitter2: TImage;
    Panel2: TPanel;
    LabelOXROPR: TLabel;
    ComboBoxOXROPR: TComboBox;
    LabelWinterPrice: TLabel;
    EditWinterPrice: TEdit;
    Panel3: TPanel;
    PanelChangesAdditions: TPanel;
    Shape1: TShape;
    PanelCAHeader: TPanel;
    PanelNorm�onsumption: TPanel;
    PanelNCHeader: TPanel;
    StringGridNC: TStringGrid;
    PanelStructureWorks: TPanel;
    PanelSWHeader: TPanel;
    StringGridSW: TStringGrid;
    Splitter2: TSplitter;
    Splitter1: TSplitter;
    ADOQueryNormativ: TFDQuery;
    ADOQueryNC: TFDQuery;
    ADOQuerySW: TFDQuery;
    ADOQueryTemp: TFDQuery;
    tmrFilter: TTimer;

    procedure FrameResize(Sender: TObject);

    procedure SettingTable;
    procedure ReceivingSearch(vStr: string);

    procedure StringGridNCClick(Sender: TObject);
    procedure StringGridNCDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridNCEnter(Sender: TObject);
    procedure StringGridNCExit(Sender: TObject);
    procedure StringGridNCKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGridNCMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure StringGridNCMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

    procedure StringGridSWDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);

    procedure VSTDblClick(Sender: TObject);
    procedure VSTEnter(Sender: TObject);
    procedure VSTExit(Sender: TObject);
    procedure VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure VSTKeyPress(Sender: TObject; var Key: Char);
    procedure VSTResize(Sender: TObject);

    procedure PanelNorm�onsumptionResize(Sender: TObject);
    procedure PanelStructureWorksResize(Sender: TObject);
    procedure PanelCenterClientResize(Sender: TObject);
    procedure PanelHorizontal2Resize(Sender: TObject);

    procedure SplitterLeftMoved(Sender: TObject);
    procedure SplitterRightMoved(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure Splitter2Moved(Sender: TObject);
    procedure SplitterTopMoved(Sender: TObject);

    procedure LabelSbornikClick(Sender: TObject);
    procedure LabelSbornikMouseEnter(Sender: TObject);
    procedure LabelSbornikMouseLeave(Sender: TObject);

    procedure EditSearchNormativeKeyPress(Sender: TObject; var Key: Char);
    procedure EditRateEnter(Sender: TObject);
    procedure EditSearchNormativeEnter(Sender: TObject);

    procedure SpeedButtonShowHideRightPanelClick(Sender: TObject);
    procedure ShowHidePanels(Sender: TObject);
    procedure FindToRatesClick(Sender: TObject);
    procedure Sbornik(const IdRate: string);
    procedure FilteredRates(const vStr: string);
    procedure EditRateChange(Sender: TObject);
    procedure EditRateKeyPress(Sender: TObject; var Key: Char);
    procedure GetWinterPrice;
    procedure tmrFilterTimer(Sender: TObject);

  private
    StrQuery: String; // ��� ������������ ������ ������� � ��
    OldNormChkState: Boolean;

    { StrQuickSearch: String[20]; }

    DataBase: Char; // ���������� ��� ����������� ������
    AllowAddition: Boolean; // ���������/��������� ��������� ������ �� ������

    Group1, Group2, Group3, Group4: Integer;
  public
    procedure ReceivingAll; override;
    constructor Create(AOwner: TComponent; const vDataBase: Char; const vAllowAddition: Boolean); reintroduce;

  end;

implementation

uses Main, DataModule, DrawingTables, CalculationEstimate, ListCollections;

{$R *.dfm}

const
  // �������� ����� ������
  CaptionFrame = '����� ���������';

  { TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
end;

constructor TFrameRates.Create(AOwner: TComponent; const vDataBase: Char; const vAllowAddition: Boolean);
begin
  inherited Create(AOwner);

  // ----------------------------------------

  DataBase := vDataBase;
  AllowAddition := vAllowAddition;

  // ----------------------------------------

  SettingTable;

  Group1 := 0;
  Group2 := 0;
  Group3 := 0;
  Group4 := 0;

  PanelChangesAdditions.Visible := False;

  // ----------------------------------------

  with DM do
  begin
    with ImageListHorozontalDots do
    begin
      GetIcon(0, ImageSplitterTop.Picture.Icon);
      GetIcon(0, ImageSplitter1.Picture.Icon);
      GetIcon(0, ImageSplitter2.Picture.Icon);
    end;

    with ImageListVerticalDots do
    begin
      GetIcon(0, ImageSplitterLeft.Picture.Icon);
      GetIcon(0, ImageSplitterRight.Picture.Icon);
    end;

    ImageListArrowsLeft.GetBitmap(0, SpeedButtonShowHideRightPanel.Glyph);
  end;

  // ----------------------------------------

  // ��������� ������� B ������

  PanelRight.Constraints.MinWidth := 35;
  SpeedButtonShowHideRightPanel.Hint := '�������� ������';

  PanelCollection.Constraints.MinHeight := 50;
  PanelNorm�onsumption.Constraints.MinHeight := 50;
  PanelChangesAdditions.Constraints.MinHeight := 50;

  SplitterRight.Visible := False;
  PanelRight.Visible := False;
  PanelRight.Constraints.MinWidth := 100;

  ShowHidePanels(nil);
end;

procedure TFrameRates.FrameResize(Sender: TObject);
var
  PHeight: Integer;
begin
  PHeight := PanelNorm�onsumption.Height + PanelStructureWorks.Height + PanelChangesAdditions.Height;
  PHeight := PHeight div 3;
  PanelNorm�onsumption.Height := PHeight;
  PanelChangesAdditions.Height := PHeight;

  SplitterTopMoved(nil);
  SplitterLeftMoved(nil);
  SplitterRightMoved(nil);
  Splitter1Moved(nil);
  Splitter2Moved(nil);
end;

procedure TFrameRates.LabelSbornikClick(Sender: TObject);
begin
  // FormListCollections.RateNum := EditJustification.Text;
  // FormListCollections.ShowModal;

  FormListCollections.Filling(EditJustification.Text);

  if FormListCollections.Open then
    FormListCollections.Show;
end;

procedure TFrameRates.LabelSbornikMouseEnter(Sender: TObject);
begin
  with (Sender as TLabel) do
  begin
    Cursor := crHandPoint;
    Font.Style := Font.Style + [fsUnderline];
  end;
end;

procedure TFrameRates.LabelSbornikMouseLeave(Sender: TObject);
begin
  with (Sender as TLabel) do
  begin
    Cursor := crDefault;
    Font.Style := Font.Style - [fsUnderline];
  end;
end;

procedure TFrameRates.FindToRatesClick(Sender: TObject);
begin
  FormListCollections.Filling(EditJustification.Text);

  if FormListCollections.Open then
    FormListCollections.Show;
end;

procedure TFrameRates.PanelCenterClientResize(Sender: TObject);
var
  PHeight: Integer;
begin
  PHeight := PanelNorm�onsumption.Height + PanelStructureWorks.Height + PanelChangesAdditions.Height;
  PHeight := PHeight div 3;
  PanelNorm�onsumption.Height := PHeight;
  PanelChangesAdditions.Height := PHeight;
end;

procedure TFrameRates.PanelHorizontal2Resize(Sender: TObject);
begin
  // ComboBoxOXROPR.Width := LabelWinterPrice.Left - ComboBoxOXROPR.Left - 6;
end;

procedure TFrameRates.PanelNorm�onsumptionResize(Sender: TObject);
begin
  AutoWidthColumn(StringGridNC, 1);
end;

procedure TFrameRates.PanelStructureWorksResize(Sender: TObject);
begin
  AutoWidthColumn(StringGridSW, 1);
end;

procedure TFrameRates.SettingTable;
begin
  // ����������� ������� (StringGridNormative)

  VST.Colors.SelectionTextColor := PS.FontSelectCell;

  VST.Colors.UnfocusedSelectionColor := PS.SelectRowUnfocusedTable;
  VST.Colors.UnfocusedSelectionBorderColor := PS.SelectRowUnfocusedTable;

  VST.Colors.FocusedSelectionColor := PS.BackgroundSelectCell;
  VST.Colors.FocusedSelectionBorderColor := PS.BackgroundSelectCell;

  // ----------------------------------------

  // ����������� ������� ��� ������ ���� ��������

  with StringGridNC do
  begin
    ColCount := 4; // �������� � �������
    RowCount := 2; // �����  � �������

    // ����������� ������ ��������
    ColWidths[0] := 80;
    ColWidths[1] := 600;
    ColWidths[2] := 60;
    ColWidths[3] := 60;

    // �������� ���������� ��������
    Cells[0, 0] := '���';
    Cells[1, 0] := '��������';
    Cells[2, 0] := '���. ���.';
    Cells[3, 0] := '��. ���.';
  end;

  // ����������� ������� ��� ������ ���� ��������

  with StringGridSW do
  begin
    ColCount := 2; // �������� � �������
    RowCount := 2; // �����  � �������

    // ����������� ������ ��������
    ColWidths[0] := 40;
    ColWidths[1] := 600;

    // �������� ���������� ��������
    Cells[0, 0] := '� �/�';
    Cells[1, 0] := '�������� ������� �����';
  end;

end;

procedure TFrameRates.ReceivingAll;
begin
  ReceivingSearch('');
  fLoaded := true;
end;

procedure TFrameRates.SpeedButtonShowHideRightPanelClick(Sender: TObject);
begin
  SpeedButtonShowHideRightPanel.Glyph.Assign(nil);

  with SpeedButtonShowHideRightPanel do
    if Tag = 1 then
    begin
      Tag := 0;
      SplitterRight.Visible := False;
      PanelRight.Visible := False;
      DM.ImageListArrowsLeft.GetBitmap(0, SpeedButtonShowHideRightPanel.Glyph);
      SpeedButtonShowHideRightPanel.Hint := '���������� ������';
    end
    else
    begin
      Tag := 1;
      PanelRight.Visible := true;
      SplitterRight.Visible := true;
      SpeedButtonShowHideRightPanel.Hint := '�������� ������';
      DM.ImageListArrowsRight.GetBitmap(0, SpeedButtonShowHideRightPanel.Glyph);
    end;
end;

procedure TFrameRates.Splitter1Moved(Sender: TObject);
begin
  ImageSplitter1.Top := Splitter1.Top;
  ImageSplitter1.Left := Splitter1.Left + (Splitter1.Width - ImageSplitter1.Width) div 2;
end;

procedure TFrameRates.Splitter2Moved(Sender: TObject);
begin
  ImageSplitter2.Top := Splitter2.Top;
  ImageSplitter2.Left := Splitter2.Left + (Splitter2.Width - ImageSplitter2.Width) div 2;
end;

procedure TFrameRates.SplitterLeftMoved(Sender: TObject);
begin
  ImageSplitterLeft.Left := SplitterLeft.Left;
  ImageSplitterLeft.Top := SplitterLeft.Top + (SplitterLeft.Height - ImageSplitterLeft.Height) div 2;
end;

procedure TFrameRates.SplitterRightMoved(Sender: TObject);
begin
  ImageSplitterRight.Left := SplitterRight.Left;
  ImageSplitterRight.Top := SplitterRight.Top + (SplitterRight.Height - ImageSplitterRight.Height) div 2;
end;

procedure TFrameRates.SplitterTopMoved(Sender: TObject);
begin
  ImageSplitterTop.Top := SplitterTop.Top;
  ImageSplitterTop.Left := SplitterTop.Left + (SplitterTop.Width - ImageSplitterTop.Width) div 2;
end;

procedure TFrameRates.StringGridNCClick(Sender: TObject);
begin
  (Sender as TStringGrid).Repaint;
end;

procedure TFrameRates.StringGridNCDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
var
  TW: Integer;
begin
  StringGridDrawCellDefault(Sender, ACol, ARow, Rect, State);

  if ((ARow = Group1) and (Group1 <> 0)) or ((ARow = Group2) and (Group2 <> 0)) or
    ((ARow = Group3) and (Group3 <> 0)) or ((ARow = Group4) and (Group4 <> 0)) then
  begin
    with StringGridNC.Canvas do
    begin
      Font.Style := Font.Style + [fsBold];
      Font.Color := PS.FontSelectRow;
      Brush.Color := RGB(106, 116, 157);
      FillRect(Rect);

      if (Group1 > 0) and (Group1 = ARow) and (ACol = 1) then
      begin
        TW := TextWidth(StringGridNC.Cells[1, Group1]);
        TW := (Rect.Right - TW) div 2;
        TextOut(Rect.Left + TW, Rect.Top + 3, StringGridNC.Cells[1, Group1]);
      end;

      if (Group2 > 0) and (Group2 = ARow) and (ACol = 1) then
      begin
        TW := TextWidth(StringGridNC.Cells[1, Group2]);
        TW := (Rect.Right - TW) div 2;
        TextOut(Rect.Left + TW, Rect.Top + 3, StringGridNC.Cells[1, Group2]);
      end;

      if (Group3 > 0) and (Group3 = ARow) and (ACol = 1) then
      begin
        TW := TextWidth(StringGridNC.Cells[1, Group3]);
        TW := (Rect.Right - TW) div 2;
        TextOut(Rect.Left + TW, Rect.Top + 3, StringGridNC.Cells[1, Group3]);
      end;

      if (Group4 > 0) and (Group4 = ARow) and (ACol = 1) then
      begin
        TW := TextWidth(StringGridNC.Cells[1, Group4]);
        TW := (Rect.Right - TW) div 2;
        TextOut(Rect.Left + TW, Rect.Top + 3, StringGridNC.Cells[1, Group4]);
      end;

      Font.Style := Font.Style - [fsBold];
    end;
  end;
end;

procedure TFrameRates.StringGridNCEnter(Sender: TObject);
begin
  (Sender as TStringGrid).Repaint;
end;

procedure TFrameRates.StringGridNCExit(Sender: TObject);
begin
  (Sender as TStringGrid).Repaint;
end;

procedure TFrameRates.StringGridNCKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  with (Sender as TStringGrid) do
    if (Key = Ord(#39)) and (ColWidths[Col + 1] = -1) then
      Key := Ord(#0);
end;

procedure TFrameRates.StringGridNCMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  (Sender as TStringGrid).Repaint;
end;

procedure TFrameRates.StringGridNCMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    (Sender as TStringGrid).Repaint;
end;

procedure TFrameRates.StringGridSWDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  StringGridDrawCellDefault(Sender, ACol, ARow, Rect, State);
end;

procedure TFrameRates.tmrFilterTimer(Sender: TObject);
begin
  tmrFilter.Enabled := False;
  ReceivingSearch(FilteredString(EditRate.Text, 'norm_num'));
end;

procedure TFrameRates.VSTDblClick(Sender: TObject);
begin
  // ���� ��������� ��������� ������ �� ������
  if AllowAddition then
    FormCalculationEstimate.AddRate(ADOQueryNormativ.FieldByName('IdNormative').AsInteger);
end;

procedure TFrameRates.VSTEnter(Sender: TObject);
begin
  FrameStatusBar.InsertText(2, '-1'); // ����� �� ������� ����
  // R EditRate.Text := '';

  // ----------------------------------------

  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // �������
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // ����������
end;

procedure TFrameRates.VSTExit(Sender: TObject);
begin
  FrameStatusBar.InsertText(2, '');
  // R EditRate.Text := '';
end;

procedure TFrameRates.VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
var
  i: Integer;
  IdNormative: String;
begin
  if not Assigned(Node) then
    exit;

  ADOQueryNormativ.RecNo := Node.Index + 1;

  IdNormative := ADOQueryNormativ.FieldByName('IdNormative').AsVariant; // �������� Id ���������

  Sbornik(IdNormative);
  // -----------------------------------------

  // ��������� � ��������� ������ � ��

  StrQuery :=
    'SELECT norm_num as "NumberNormative", norm_caption as "CaptionNormative", unit_name as "Unit" FROM normativ'
    + DataBase + ', units WHERE normativ' + DataBase + '.unit_id = units.unit_id and normativ' + DataBase +
    '.normativ_id = ' + IdNormative + ';';

  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(StrQuery);
    Active := true;

    MemoDescription.Clear;
    MemoDescription.Lines.Add(FieldByName('CaptionNormative').AsString);
    EditJustification.Text := FieldByName('NumberNormative').AsString;
    EditUnit.Text := FieldByName('Unit').AsString;
  end;

  // -----------------------------------------

  // ������� ������ ������� �����
  with ADOQuerySW do
  begin
    Active := False;
    SQL.Clear;

    StrQuery := 'SELECT cast(sostav_name as char(1024)) as "ScopeWork" FROM sostav, normativ' + DataBase +
      ' WHERE normativ' + DataBase + '.tab_id = sostav.tab_id and normativ' + DataBase + '.normativ_id = ' +
      IdNormative + ';';

    SQL.Add(StrQuery);
    Active := true;

    First;
    i := 1;

    StringGridSW.RowCount := ADOQuerySW.RecordCount + 1;

    while not Eof do
    begin
      with StringGridSW do
      begin
        Cells[0, i] := IntToStr(i);
        Cells[1, i] := FieldByName('ScopeWork').AsVariant;
      end;

      Inc(i);
      Next;
    end;
  end;

  // -----------------------------------------

  Group1 := 0;
  Group2 := 0;
  Group3 := 0;
  Group4 := 0;

  // -----------------------------------------

  // ����� ������� �� ������� � ����������

  // ��������� � ��������� ������ ��� ��������� ���� �������
  with ADOQueryNC do
  begin
    Active := False;
    SQL.Clear;

    StrQuery := 'SELECT mech_code, mech_name, norm_ras, unit_name FROM mechanizm, mechanizmnorm, units ' +
      'WHERE mechanizm.unit_id = units.unit_id and mechanizm.mechanizm_id = mechanizmnorm.mechanizm_id ' +
      'and mechanizmnorm.normativ_id = ' + IdNormative + ';';

    SQL.Add(StrQuery);
    Active := true;
  end;

  // ������� ���������� ������ � ������� StringGrid
  with ADOQueryNC, StringGridNC do
  begin
    ColCount := 4; // �������� � �������
    RowCount := 2; // �����  � �������

    Group1 := 1;

    Cells[1, Group1] := '������ � ���������';

    i := Group1 + 1; // ����� ����������� ������ � StringGrid

    First; // ���������� �� ������ ������ � ������ ������

    // ���� ���� ������ � ������ ������, ������� �� � StringGrid
    while not Eof do
    begin
      RowCount := i + 1;

      Cells[0, i] := Fields.Fields[0].AsString;
      Cells[1, i] := Fields.Fields[1].AsString;
      Cells[2, i] := Fields.Fields[2].Value;
      Cells[3, i] := Fields.Fields[3].AsString;

      Inc(i);
      Next;
    end;
  end;

  // -----------------------------------------

  // ����� ������� �� ����������

  // ��������� � ��������� ������ ��� ��������� ���� �������
  with ADOQueryNC do
  begin
    Active := False;
    SQL.Clear;

    StrQuery := 'SELECT mat_code, mat_name, norm_ras, unit_name FROM materialnorm, material, units ' +
      'WHERE materialnorm.material_id = material.material_id and material.unit_id = units.unit_id ' +
      'and materialnorm.normativ_id = ' + IdNormative + ';';

    SQL.Add(StrQuery);
    Active := true;
  end;

  // ������� ���������� ������ � ������� StringGrid
  with ADOQueryNC, StringGridNC do
  begin
    with StringGridNC do
    begin
      Group2 := RowCount;
      RowCount := RowCount + 1;
    end;

    Filtered := False;
    Filter := 'mat_code LIKE ''�%''';
    Filtered := true;

    Cells[1, Group2] := '��������� �������';

    i := Group2 + 1; // ����� ����������� ������ � StringGrid

    First; // ���������� �� ������ ������ � ������ ������

    // ���� ���� ������ � ������ ������, ������� �� � StringGrid
    while not Eof do
    begin
      RowCount := i + 1;

      Cells[0, i] := Fields.Fields[0].AsString;
      Cells[1, i] := Fields.Fields[1].AsString;
      Cells[2, i] := Fields.Fields[2].Value;
      Cells[3, i] := Fields.Fields[3].AsString;

      Inc(i);
      Next;
    end;

    // ----------------------------------------

    with StringGridNC do
    begin
      Group3 := RowCount;
      RowCount := RowCount + 1;
    end;

    Filtered := False;
    Filter := 'mat_code LIKE ''�%''';
    Filtered := true;

    Cells[1, Group3] := '��������� ���������';

    i := Group3 + 1; // ����� ����������� ������ � StringGrid

    First; // ���������� �� ������ ������ � ������ ������

    // ���� ���� ������ � ������ ������, ������� �� � StringGrid
    while not Eof do
    begin
      RowCount := i + 1;

      Cells[0, i] := Fields.Fields[0].AsString;
      Cells[1, i] := Fields.Fields[1].AsString;
      Cells[2, i] := Fields.Fields[2].Value;
      Cells[3, i] := Fields.Fields[3].AsString;

      Inc(i);
      Next;
    end;

    Filtered := False;
    Filter := '';
    Filtered := true;
  end;

  // -----------------------------------------

  // ����� ������� �� �������� �����

  // ��������� � ��������� ������ ��� ��������� ���� �������
  with ADOQueryNC do
  begin
    Active := False;
    SQL.Clear;

    StrQuery := 'SELECT works.work_caption, normativwork.norma FROM normativwork, works ' +
      'WHERE normativwork.work_id = works.work_id and normativwork.normativ_id = ' + IdNormative + ';';

    SQL.Add(StrQuery);
    Active := true;
  end;

  // ������� ���������� ������ � ������� StringGrid
  with ADOQueryNC, StringGridNC do
  begin

    with StringGridNC do
    begin
      Group4 := RowCount;
      RowCount := RowCount + 1;
    end;

    Cells[1, Group4] := '������� �����';

    i := Group4 + 1; // ����� ����������� ������ � StringGrid

    First; // ���������� �� ������ ������ � ������ ������

    // ���� ���� ������ � ������ ������, ������� �� � StringGrid
    while not Eof do
    begin
      RowCount := i + 1;

      Cells[0, i] := '';
      Cells[1, i] := Fields.Fields[0].AsString;
      Cells[2, i] := Fields.Fields[1].Value;
      Cells[3, i] := '';

      Inc(i);
      Next;
    end;
  end;

  // ----------------------------------

  // ������� ��� � ��� � ���� �������
  with ADOQueryTemp do
  begin
    ComboBoxOXROPR.ItemIndex := 0;

    Active := False;
    SQL.Clear;
    StrQuery := 'SELECT work_id, s, po FROM onormativs where ((s <= "' + ADOQueryNormativ.FieldByName
      ('NumberNormative').AsString + '") and (po >= "' + ADOQueryNormativ.FieldByName('NumberNormative')
      .AsString + '"));';
    SQL.Add(StrQuery);
    Active := true;
    // ������� ���������, ��� ���� work_id �� ������� �� �������
    if not Eof then
      ComboBoxOXROPR.ItemIndex := FieldByName('work_id').AsVariant - 1;
  end;

  // ----------------------------------------

  GetWinterPrice;
end;

procedure TFrameRates.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
begin
  if not ADOQueryNormativ.Active then
    exit;

  if (ADOQueryNormativ.RecordCount <= 0) then
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
    end;

    exit;
  end;

  if Column > 0 then
    ADOQueryNormativ.RecNo := Node.Index + 1;

  case Column of
    0:
      CellText := IntToStr(Node.Index + 1);
    1:
      CellText := ADOQueryNormativ.FieldByName('NumberNormative').AsVariant;
  end;
end;

procedure TFrameRates.VSTKeyPress(Sender: TObject; var Key: Char);
var
  vCode: Integer;
begin
  // 1057 = � ; 1045 = � ; 1062 = � ; 8 = BackSpace ; 27 = Esc

  Key := AnsiUpperCase(Key)[1];
  vCode := Ord(Key);

  // ������� ����������� � �����
  if not((vCode = 1057) or (vCode = 1045) or (vCode = 1062) or (vCode = 8) or (vCode = 27) or (Key = '-') or
    ((Key >= '0') and (Key <= '9'))) then
  begin
    Key := #0;
    exit;
  end;

  if (vCode = 27) then
  begin
    EditRate.Text := '';
    exit;
  end;

  // ���� ����� �� ������ ��������
  if (EditRate.Text = '') and (Key >= '0') and (Key <= '9') then
    Key := #0;

  // ���� ����� ������ ������ ��������
  if (EditRate.Text > '') and ((vCode = 1057) or (vCode = 1045) or (vCode = 1062)) then
    Key := #0;

  // ���� ���� � ������ �����, �������, ����� ������ ��������� ������, ��� ��������� � �������� ������ ������
  if (Key = '-') and (EditRate.Text = '') then
    Key := #0;

  // ���� ���� ������ ����� �����
  with EditRate do
    if (Key = '-') and (Text <> '') then
      if ((Text[Length(Text)] < '0') or (Text[Length(Text)] > '9')) then
        Key := #0;

  if vCode = VK_BACK then
    EditRate.Text := Copy(EditRate.Text, 0, Length(EditRate.Text) - 1)
  else
    EditRate.Text := EditRate.Text + Key;
  { // ��������� ���� ������� �������� (unicode) + ������ "������" + �����
    // �������: �-� = 1040-1071, � = 1025, �����: �-� = 1072-1103, � = 1105
    if ((Key >= #1040) and (Key <= #1103)) or (Key = #1025) or (Key = #1105) or (Key = #32) or
    ((Key >= '0') and (Key <= '9')) or (Key = '-') then
    begin
    StrQuickSearch := StrQuickSearch + Key; // ������� ������ � ������ �������� ������

    FrameStatusBar.InsertText(2, StrQuickSearch);
    EditRate.Text := StrQuickSearch;

    ReceivingSearch('NumberNormative' + ' LIKE ''' + StrQuickSearch + '%''');
    end
    else if Key = #27 then // ���� ���� ������ ������� "Esc"
    begin
    StrQuickSearch := ''; // ������� ������ �������� ������

    FrameStatusBar.InsertText(2, StrQuickSearch);
    EditRate.Text := StrQuickSearch;

    ReceivingSearch('');
    end
    else if Key = #08 then // ���� ���� ������ ������� "Backspace"
    begin
    Delete(StrQuickSearch, Length(StrQuickSearch), 1);

    FrameStatusBar.InsertText(2, StrQuickSearch);
    EditRate.Text := StrQuickSearch;

    if StrQuickSearch <> '' then
    ReceivingSearch('NumberNormative' + ' LIKE ''' + StrQuickSearch + '%''')
    else
    ReceivingSearch('');
    end
    else Key := #0; }
end;

procedure TFrameRates.VSTResize(Sender: TObject);
begin
  AutoWidthColumn(VST, 1);
end;

procedure TFrameRates.EditRateEnter(Sender: TObject);
begin
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // �������
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // ����������

  EditSearchNormative.Text := '';
end;

procedure TFrameRates.EditRateChange(Sender: TObject);
begin
  tmrFilter.Enabled := False;
  tmrFilter.Enabled := true;
end;

procedure TFrameRates.EditRateKeyPress(Sender: TObject; var Key: Char);
var
  vCode: Integer;
begin
  // 1057 = � ; 1045 = � ; 1062 = � ; 8 = BackSpace ; 27 = Esc

  Key := AnsiUpperCase(Key)[1];
  vCode := Ord(Key);

  // ������� ����������� � �����
  if not((vCode = 1057) or (vCode = 1045) or (vCode = 1062) or (vCode = 8) or (vCode = 27) or (Key = '-') or
    ((Key >= '0') and (Key <= '9'))) then
  begin
    Key := #0;
    exit;
  end;

  if (vCode = 27) then
  begin
    (Sender as TEdit).Text := '';
    exit;
  end;

  // ���� ����� �� ������ ��������
  if ((Sender as TEdit).Text = '') and (Key >= '0') and (Key <= '9') then
    Key := #0;

  // ���� ����� ������ ������ ��������
  if ((Sender as TEdit).Text > '') and ((vCode = 1057) or (vCode = 1045) or (vCode = 1062)) then
    Key := #0;

  // ���� ���� � ������ �����, �������, ����� ������ ��������� ������, ��� ��������� � �������� ������ ������
  if (Key = '-') and ((Sender as TEdit).Text = '') then
    Key := #0;

  // ���� ���� ������ ����� �����
  with (Sender as TEdit) do
    if (Key = '-') and (Text <> '') then
      if ((Text[Length(Text)] < '0') or (Text[Length(Text)] > '9')) then
        Key := #0;

  // �������
  if Key = #13 then
    Key := #0;
end;

procedure TFrameRates.EditSearchNormativeEnter(Sender: TObject);
begin
  LoadKeyboardLayout('00000419', KLF_ACTIVATE);
  // �������
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // ����������

  EditRate.Text := '';
end;

procedure TFrameRates.EditSearchNormativeKeyPress(Sender: TObject; var Key: Char);
var
  StringSearch: String;
  CountWords, i: Integer;
  Words: array of String;
begin
  StringSearch := (Sender as TEdit).Text;
  // �������� �������� ��������� ������

  // ���� ������ ������� "Enter" � ������ ������ �� �����
  // ��� ������ ������� "������" � ������ ������ ������� ����� 1 �������
  if (Key = #13) and (StringSearch <> '') or (Key = #32) and (Length(StringSearch) > 1) then
  begin
    // ���� � ����� ��� �������, ������
    if StringSearch[Length(StringSearch)] <> ' ' then
      StringSearch := StringSearch + ' ';

    // �������� ������� ���������� ����
    CountWords := 0;

    // ������������ ���������� �������� (������� �� ����� � ����)
    for i := 1 to Length(StringSearch) do
      if StringSearch[i] = ' ' then
        Inc(CountWords);

    // ������ ������ ��� ����
    SetLength(Words, CountWords);

    i := 0;

    // ������� ����� � ������
    while pos(' ', StringSearch) > 0 do
    begin
      Words[i] := Copy(StringSearch, 1, pos(' ', StringSearch) - 1);
      Delete(StringSearch, 1, pos(' ', StringSearch));
      Inc(i);
    end;

    StringSearch := '';

    for i := 0 to CountWords - 1 do
      StringSearch := StringSearch + 'norm_caption LIKE ''%' + Words[i] + '%'' and ';

    Delete(StringSearch, Length(StringSearch) - 4, 5);

    ReceivingSearch(StringSearch);
  end
  // ���� ������ ������� ESC, ��� ���� ������ ������� Enter � ������ ������ �����
  else if (Key = #27) or ((Key = #13) and (StringSearch = '')) then
  begin
    (Sender as TEdit).Text := '';

    ReceivingSearch('');
  end;
  // �������
  if Key = #13 then
    Key := #0;
end;

procedure TFrameRates.ReceivingSearch(vStr: string);
var
  QueryStr: string;
  WhereStr: string;
begin
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT work_id, work_name FROM objworks ORDER BY work_id;');
      Active := true;

      First;;

      ComboBoxOXROPR.Items.Clear;

      while not Eof do
      begin
        ComboBoxOXROPR.Items.Add(Fields[0].AsString + '. ' + Fields[1].AsString);
        Next;
      end;
    end;

    with ADOQueryNormativ do
    begin
      Active := False;
      SQL.Clear;
      if vStr <> '' then
        WhereStr := ' where ' + vStr
      else
        WhereStr := '';
      QueryStr := 'SELECT normativ_id as "IdNormative", norm_num as "NumberNormative",' +
        ' norm_caption as "CaptionNormativ", sbornik_id, razd_id, tab_id FROM ' + 'normativ' + DataBase +
        WhereStr + ' ORDER BY NumberNormative ASC;';

      SQL.Add(QueryStr);
      Active := true;
    end;

    ADOQueryNormativ.FetchOptions.RecordCountMode := cmTotal;

    if ADOQueryNormativ.RecordCount <= 0 then
    begin
      VST.RootNodeCount := 1;
      VST.ClearSelection;

      FrameStatusBar.InsertText(1, '-1');
    end
    else
    begin
      VST.RootNodeCount := ADOQueryNormativ.RecordCount;
      VST.Selected[VST.GetFirst] := true;
      VST.FocusedNode := VST.GetFirst;
    end;

    FrameStatusBar.InsertText(0, IntToStr(ADOQueryNormativ.RecordCount));

    if ADOQueryNormativ.RecordCount > 0 then
      VSTFocusChanged(VST, VST.FocusedNode, VST.FocusedColumn);

    ADOQueryNormativ.FetchOptions.RecordCountMode := cmVisible;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� � �� �������� ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFrameRates.ShowHidePanels(Sender: TObject);
var
  P1, P2, P3: Boolean;
begin
  PanelNorm�onsumption.Align := alNone;
  PanelStructureWorks.Align := alNone;
  PanelChangesAdditions.Align := alNone;

  PanelNorm�onsumption.Visible := False;
  PanelStructureWorks.Visible := False;
  PanelChangesAdditions.Visible := False;

  // ----------------------------------------

  Splitter1.Align := alNone;
  Splitter2.Align := alNone;

  Splitter1.Visible := False;
  Splitter2.Visible := False;

  // ----------------------------------------

  ImageSplitter1.Visible := False;
  ImageSplitter2.Visible := False;

  // ----------------------------------------

  PanelNorm�onsumption.Top := Height + 10;
  PanelStructureWorks.Top := Height + 10;
  PanelChangesAdditions.Top := Height + 10;

  // ----------------------------------------

  P1 := CheckBoxNorm�onsumption.Checked;
  P2 := CheckBoxStructureWorks.Checked;
  P3 := CheckBoxChangesAdditions.Checked;

  // H := PanelCollection.Height;
  // PanelCollection.Height := 50;

  // ----------------------------------------

  // ���� ������� ������ ���� �� �Ш� �������

  if (P1 = true) and (P2 = False) and (P3 = False) then
  begin
    PanelNorm�onsumption.Visible := true;
    PanelNorm�onsumption.Align := alClient;
  end;

  if (P1 = False) and (P2 = true) and (P3 = False) then
  begin
    PanelStructureWorks.Visible := true;
    PanelStructureWorks.Align := alClient;
  end;

  if (P1 = False) and (P2 = False) and (P3 = true) then
  begin
    PanelChangesAdditions.Visible := true;
    PanelChangesAdditions.Align := alClient;
  end;

  // ----------------------------------------

  // ���� ������� ����� ��� �� �Ш� �������

  if (P1 = true) and (P2 = true) and (P3 = False) then
  begin
    PanelStructureWorks.Visible := true;
    PanelStructureWorks.Align := alBottom;

    Splitter2.Visible := true;
    Splitter2.Align := alNone;
    Splitter2.Align := alBottom;

    PanelNorm�onsumption.Visible := true;
    PanelNorm�onsumption.Align := alClient;

    ImageSplitter2.Visible := true;
  end;

  if (P1 = False) and (P2 = true) and (P3 = true) then
  begin
    PanelChangesAdditions.Visible := true;
    PanelChangesAdditions.Align := alBottom;

    Splitter2.Visible := true;
    Splitter2.Align := alNone;
    Splitter2.Align := alBottom;

    PanelStructureWorks.Visible := true;
    PanelStructureWorks.Align := alClient;

    ImageSplitter2.Visible := true;
  end;

  if (P1 = true) and (P2 = False) and (P3 = true) then
  begin
    PanelChangesAdditions.Visible := true;
    PanelChangesAdditions.Align := alBottom;

    Splitter2.Visible := true;
    Splitter2.Align := alNone;
    Splitter2.Align := alBottom;

    PanelNorm�onsumption.Visible := true;
    PanelNorm�onsumption.Align := alClient;

    ImageSplitter2.Visible := true;
  end;

  // ----------------------------------------

  // ���� ������� ��� ��� ������

  if (P1 = true) and (P2 = true) and (P3 = true) then
  begin
    PanelNorm�onsumption.Visible := true;
    PanelNorm�onsumption.Align := alTop;

    Splitter1.Visible := true;
    // ��������� �������� ���� ������, ����� �������� ������������� � �������� ����
    Splitter1.Top := PanelNorm�onsumption.Top + PanelNorm�onsumption.Height + 10;
    Splitter1.Align := alTop;

    PanelChangesAdditions.Visible := true;
    PanelChangesAdditions.Align := alBottom;

    Splitter2.Visible := true;
    // ��������� �������� ���� ������, ����� �������� ������������� � ������� ����
    Splitter2.Top := PanelChangesAdditions.Top - 10;
    Splitter2.Align := alBottom;

    PanelStructureWorks.Visible := true;
    PanelStructureWorks.Align := alClient;

    ImageSplitter1.Visible := true;
    ImageSplitter2.Visible := true;
  end;
end;

procedure TFrameRates.Sbornik(const IdRate: string);
begin
  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT sbornik_name, sbornik_caption FROM sbornik WHERE sbornik_id = ' +
      '(SELECT sbornik_id FROM normativg WHERE normativ_id = ' + IdRate + ');');
    Active := true;

    EditCollection.Text := FieldByName('sbornik_name').AsString + ' ' +
      FieldByName('sbornik_caption').AsString;
    Active := False;
  end;
end;

procedure TFrameRates.FilteredRates(const vStr: string);
{ var
  i: Integer; }
begin
  with ADOQueryNormativ do
  begin
    Filtered := False;
    Filter := vStr;
    Filtered := true;
  end;

  try
    if ADOQueryNormativ.RecordCount <= 0 then
    begin
      VST.RootNodeCount := 1;
      VST.ClearSelection;
    end
    else
    begin
      VST.FocusedNode := VST.GetFirst;

      VST.RootNodeCount := ADOQueryNormativ.RecordCount;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('������ ���������� ����� � ����������.' + sLineBreak + E.Message), '��������',
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  FrameStatusBar.InsertText(0, IntToStr(ADOQueryNormativ.RecordCount));
  VST.Repaint;
end;

procedure TFrameRates.GetWinterPrice;
var
  s: string;
begin
  try
    with ADOQueryTemp do
    begin
      Active := False;
      s := ADOQueryNormativ.FieldByName('NumberNormative').AsString;
      SQL.Clear;
      SQL.Add('SELECT num, name, s, po FROM znormativs, znormativs_detail WHERE znormativs.ZNORMATIVS_ID=znormativs_detail.ZNORMATIVS_ID AND znormativs.DEL_FLAG = 0 AND '
        + '((s <= ''' + s + ''') and (po >= ''' + s + ''')) LIMIT 1;');
      Active := true;

      if not Eof then
        EditWinterPrice.Text := FieldByName('num').AsVariant + ' ' + FieldByName('name').AsVariant
      else
        EditWinterPrice.Text := '�� �������';

    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� �������� ������� ���������� �������� ������:' + sLineBreak +
        sLineBreak + E.Message), CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

end.
