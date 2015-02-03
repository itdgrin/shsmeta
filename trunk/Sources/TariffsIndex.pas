unit TariffsIndex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Grids, DBGrids, StdCtrls, Buttons,
  ExtCtrls, Menus, Clipbrd, DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

const
  ColumnsInTable = 3; // ����� ������� �������� � �������

type
  TFormTariffsIndex = class(TForm)
    DataSourceTariffsIndex: TDataSource;

    PopupMenu: TPopupMenu;
    PopupMenuCopy: TMenuItem;

    PanelTop: TPanel;
    LabelData: TLabel;
    EditMonth: TEdit;
    EditVAT: TEdit;
    LabelRecordCount: TLabel;
    EditRecordCount: TEdit;
    LabelSearch: TLabel;
    EditSearch: TEdit;

    DBGrid: TDBGrid;

    PanelBottom: TPanel;
    BitBtnFind: TBitBtn;
    BitBtnLoad: TBitBtn;
    ADOQueryTariffsIndex: TFDQuery;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

    procedure DBGridColEnter(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBGridKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
      var Handled: Boolean);
    procedure DBGridMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure DBGridMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);

    procedure SetWidthColumns(const Column1: Integer; const Column2: Integer; const Column3: Integer;
      const SelIndex: Integer);
    procedure WidthColumnsFromDBGrid(const Grid: TDBGrid);
    procedure WidthColumnsToDBGrid(var Grid: TDBGrid);

    procedure EditSearchKeyPress(Sender: TObject; var Key: Char);

    procedure RunQuery(const P: Pointer);
    procedure PopupMenuCopyClick(Sender: TObject);
    procedure ADOQueryTariffsIndexAfterScroll(DataSet: TDataSet);

  private
    IdSelectRecord: Integer; // ��� ���������� ������
    StringQuery: String; // ������ ��� ������������ �������
    QuickSearch: String; // ������ �������� ������

    // ������ ����� ��� �������� ������ (��� ������� �������)
    StringQuickSearch: array [1 .. ColumnsInTable] of String[20];

  public

  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

  // �������� �������� ������ �������� ������� � ������ ��������� �������
  TWidthColumns = Record
    Column1: Integer;
    Column2: Integer;
    Column3: Integer;
    SelectedIndex: Integer;
  end;

const
  // �������� ������ ��� ����� ����
  CaptionButton = '���. �� ������. ��������';

  // ��������� ��� ��������� �� ������ ��� ����� ����
  HintButton = '���� ������ �� �������������� ��������';

  RenameColumns = 'id, i_statistic, i_rost, date_beg';

  // ����� ������
  Query = 'SELECT ' + RenameColumns + ' FROM indexs';

  // ������ ���������� �������� ���� ������� ��������
  NameColumns: array [1 .. ColumnsInTable] of String[11] = ('i_statistic', 'i_rost', 'date_beg');

  // ������ ���������� ������� �������� ���� ������� ��������
  RusNameColumns: array [1 .. ColumnsInTable] of String[21] = ('�������������� ������', '����', '����');

  OrderBy = 'date_beg ASC';

var
  FormTariffsIndex: TFormTariffsIndex;
  WidthColumns: TWidthColumns;

implementation

uses Main, DataModule, Waiting;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

// �������. ���� ����� ��������� ������������
procedure TFormTariffsIndex.ADOQueryTariffsIndexAfterScroll(DataSet: TDataSet);
begin
  // ��� ��������� ������, �������� � ���������� ���
  IdSelectRecord := DataSet.Fields.Fields[0].AsInteger;
end;

procedure TFormTariffsIndex.CreateParams(var Params: TCreateParams);
begin
  inherited;
  // Params.Width := FormMain.Width;
  // Params.Height := FormMain.Height - 27;
  // Params.X := -4;
  // Params.Y := -30;
end;
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsIndex.FormCreate(Sender: TObject);
begin
  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 20;
  Left := 20;

  WindowState := wsMaximized;

  // ������� ������ �������� ������
  QuickSearch := '';

  // -----------------------------------------

  // ������ ������
  StringQuery := Query + ' ORDER BY ' + OrderBy + ';';

  // ��������� ������
  RunQuery(@StringQuery);

  // ������������� ��������� ������ �������� � �������
  // � ����� ��������� �������
  SetWidthColumns(FormMain.ClientWidth div 3 - 16, FormMain.ClientWidth div 3 - 16, FormMain.ClientWidth div 3 - 16, 1);
  WidthColumnsToDBGrid(DBGrid);

  // -----------------------------------------

  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(CaptionButton, HintButton, FormMain.ShowTariffsIndex);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsIndex.FormShow(Sender: TObject);
begin
  // ������������� ����� � �������
  DBGrid.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsIndex.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsIndex.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsIndex.FormDestroy(Sender: TObject);
begin
  FormTariffsIndex := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

// ������� ������� � ��������� ��������� �������
procedure TFormTariffsIndex.DBGridColEnter(Sender: TObject);
var
  i: Integer;
  Str: String;
  Sim: Char;
begin
  Sim := '*';
  with DBGrid do
    for i := 1 to Columns.Count - 1 do
      if i = SelectedIndex then
        Columns[i].Title.Caption := Columns[i].Title.Caption + Sim
      else if Pos(Sim, Columns[i].Title.Caption) > 0 then
      begin
        Str := Columns[i].Title.Caption;
        Delete(Str, Pos(Sim, Str), 1);
        Columns[i].Title.Caption := Str;
      end;
end;

// ---------------------------------------------------------------------------------------------------------------------

// ����������� ����� �������
procedure TFormTariffsIndex.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if DBGrid.DataSource.DataSet.Fields.Fields[0].AsInteger = IdSelectRecord then
    if gdFocused in State then // ������ ����� �����
    begin
      DBGrid.Canvas.Font.Color := clWhite;
      DBGrid.Canvas.Brush.Color := $00393939;
    end
    else // �� ����� ������
    begin
      DBGrid.Canvas.Font.Color := clWhite;
      DBGrid.Canvas.Brush.Color := $007B7B7B;
    end;

  DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsIndex.EditSearchKeyPress(Sender: TObject; var Key: Char);
var
  SelectedColumn, CountWords, i, k: Integer;
  StringSearch: String;
  Words: array of String;
begin
  // ��������� ����� ��������
  FormWaiting.Show;
  Application.ProcessMessages;

  // ���� ������ ������� "Enter" � ������ ������ �� �����
  if (Key = #13) and (EditSearch.Text <> '') and (EditSearch.Text <> ' ') then
  begin
    // �������� ����� ����������� ������� � �������
    SelectedColumn := DBGrid.SelectedIndex;

    // �������� �������� ������������� ������ ������
    StringSearch := EditSearch.Text;

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
    while Pos(' ', StringSearch) > 0 do
    begin
      Words[i] := Copy(StringSearch, 1, Pos(' ', StringSearch) - 1);
      Delete(StringSearch, 1, Pos(' ', StringSearch));
      Inc(i);
    end;

    // ������� �������������� ������
    StringQuery := 'SELECT * FROM (' + Query + ' WHERE ((';

    // ��� ������ �� ���� ��������
    for k := 1 to ColumnsInTable do
    begin
      // C��������� �� ���� �������� ������ ��� ������ ���� � ������� �������
      // (� ������� ������ ��������� ��� ������� ����� ��� ����� ���� ����)
      for i := 0 to CountWords - 1 do
        StringQuery := StringQuery + NameColumns[k] + ' LIKE "%' + Words[i] + '%" and ';

      Delete(StringQuery, Length(StringQuery) - 4, 5);

      StringQuery := StringQuery + ') or (';
    end;

    Delete(StringQuery, Length(StringQuery) - 4, 5);

    StringQuery := StringQuery + ') ORDER BY ' + OrderBy + ') AS T1';

    // ���� ���������� ���� ������ ������, ��������� �� ��� ������ �� ��������� ������
    // (� ������� ������ ��������� ���� �� ������� ���� ��� ����� ����� �����)
    if CountWords > 1 then
    begin
      // ��� ������ ������� ���������� �����
      for i := 0 to CountWords - 1 do
      begin

        StringQuery := StringQuery + ' UNION SELECT * FROM (' + Query + ' WHERE (';

        // ����� � ��������
        for k := 1 to ColumnsInTable do
          StringQuery := StringQuery + NameColumns[k] + ' LIKE "%' + Words[i] + '%" or ';

        Delete(StringQuery, Length(StringQuery) - 3, 4);

        StringQuery := StringQuery + ') ORDER BY ' + OrderBy + ') AS T' + IntToStr(i + 2);
      end;
    end;

    StringQuery := StringQuery + ';';

    // ��������� ������ ������� ������� � ����� ��������� �������
    WidthColumnsFromDBGrid(DBGrid);

    // ��������� ������
    RunQuery(@StringQuery);

    // ��������������� ������ ������� ������� � ����� ��������� �������
    WidthColumnsToDBGrid(DBGrid);
  end
  // ���� ������ ������� Enter � ������ ������ ����� ��� ���� ������ ������� ESC � ������ ������ �� �����
  else if ((Key = #13) and (EditSearch.Text = '')) or
    ((Key = #27) and (EditSearch.Text <> '') and (EditSearch.Text <> ' ')) then
  begin
    EditSearch.Text := ''; // ������� ������ ������

    StringQuery := Query + ' ORDER BY ' + OrderBy + ';';

    // ��������� ������ ������� ������� � ����� ��������� �������
    WidthColumnsFromDBGrid(DBGrid);

    // ��������� ������
    RunQuery(@StringQuery);

    // ��������������� ������ ������� ������� � ����� ��������� �������
    WidthColumnsToDBGrid(DBGrid);
  end;

  // ��������� ����� � ������� ��������
  FormWaiting.Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

// ������� ����� �� ������ ������
procedure TFormTariffsIndex.DBGridKeyPress(Sender: TObject; var Key: Char);
var
  SelectedColumn, i: Integer;
begin
  // ��������� ���� ������� �������� (unicode) + ������ "������" + �����
  // �������: �-� = 1040-1071, � = 1025, �����: �-� = 1072-1103, � = 1105
  if ((Key >= #1040) and (Key <= #1103)) or (Key = #1025) or (Key = #1105) or (Key = #32) or
    ((Key >= '0') and (Key <= '9')) then
  begin
    // �������� ����� ����������� ������� � �������
    SelectedColumn := DBGrid.SelectedIndex;

    // ������� ������ ������ � ������ ��������������� �������
    StringQuickSearch[SelectedColumn] := StringQuickSearch[SelectedColumn] + string(Key);

    // ������� �������������� ������
    StringQuery := Query + ' WHERE ';

    // ���� ������ ������ �� ������� �� ������, �� ��������� ����� �� ����� �������
    for i := 1 to ColumnsInTable do
      if Length(StringQuickSearch[i]) > 0 then
        StringQuery := StringQuery + NameColumns[i] + ' LIKE "' + StringQuickSearch[i] + '%" and ';

    Delete(StringQuery, Length(StringQuery) - 4, 5);

    // ��������� ���������� �� ����������� �������
    StringQuery := StringQuery + ' ORDER BY ' + NameColumns[SelectedColumn] + ' ASC';

    StringQuery := StringQuery + ';';
  end
  else if Key = #08 then // ���� ���� ������ ������� "Backspace"
  begin
    // ������� ������ �������� ������
    for i := 1 to ColumnsInTable do
      StringQuickSearch[i] := '';

    // ��������� ��������� ������
    StringQuery := Query + ' ORDER BY ' + OrderBy + ';';
  end;

  // ��������� ������ ������� ������� � ����� ��������� �������
  WidthColumnsFromDBGrid(DBGrid);

  // ��������� ������
  RunQuery(@StringQuery);

  // ��������������� ������ ������� ������� � ����� ��������� �������
  WidthColumnsToDBGrid(DBGrid);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsIndex.DBGridMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  if DBGrid.SelectedIndex > 1 then
  begin
    // �������� ������ ����� �� ����������
    keybd_event(VK_LEFT, 0, 0, 0);
    keybd_event(VK_LEFT, 0, 2, 0);

    // �������� ������ ������ �� ����������
    keybd_event(VK_RIGHT, 0, 0, 0);
    keybd_event(VK_RIGHT, 0, 2, 0);
  end
  else
  begin
    // �������� ������ ������ �� ����������
    keybd_event(VK_RIGHT, 0, 0, 0);
    keybd_event(VK_RIGHT, 0, 2, 0);

    // �������� ������ ����� �� ����������
    keybd_event(VK_LEFT, 0, 0, 0);
    keybd_event(VK_LEFT, 0, 2, 0);
  end;
end;

procedure TFormTariffsIndex.DBGridMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  // �������� ������ ����� �� ����������
  keybd_event(VK_UP, 0, 0, 0);
  keybd_event(VK_UP, 0, 2, 0);

  // �������� ������ ���� �� ����������
  keybd_event(VK_DOWN, 0, 0, 0);
  keybd_event(VK_DOWN, 0, 2, 0);
end;

procedure TFormTariffsIndex.DBGridMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  // �������� ������ ���� �� ����������
  keybd_event(VK_DOWN, 0, 0, 0);
  keybd_event(VK_DOWN, 0, 2, 0);

  // �������� ������ ����� �� ����������
  keybd_event(VK_UP, 0, 0, 0);
  keybd_event(VK_UP, 0, 2, 0);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsIndex.RunQuery(const P: Pointer);
var
  i: Integer;
  PQuery: ^String;
begin
  PQuery := P;

  try
    with ADOQueryTariffsIndex do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(PQuery^);
      Active := True;
    end;

    // �������� ���� ���������� ��������� ���� ������� ������
    DBGrid.Columns[0].Visible := False;

    // �������� ���������� ������� � �������
    EditRecordCount.Text := IntToStr(ADOQueryTariffsIndex.RecordCount);

    // ��������������� ��������� �������� � �������
    for i := 1 to ColumnsInTable do
      DBGrid.Columns[i].Title.Caption := RusNameColumns[i];
  except
    on E: Exception do
      MessageBox(0, PChar('������ �� ��� ��������.' + #13#10 + '��������� �� ������ �������� ����:' + #13#10 +
        E.message), '������ � MySQL �������', MB_ICONWARNING + mb_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------



// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsIndex.SetWidthColumns(const Column1: Integer; const Column2: Integer; const Column3: Integer;
  const SelIndex: Integer);
begin
  WidthColumns.Column1 := Column1;
  WidthColumns.Column2 := Column2;
  WidthColumns.Column3 := Column3;
  WidthColumns.SelectedIndex := SelIndex;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsIndex.WidthColumnsFromDBGrid(const Grid: TDBGrid);
begin
  WidthColumns.Column1 := Grid.Columns[1].Width;
  WidthColumns.Column2 := Grid.Columns[2].Width;
  WidthColumns.Column3 := Grid.Columns[3].Width;
  WidthColumns.SelectedIndex := Grid.SelectedIndex;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsIndex.WidthColumnsToDBGrid(var Grid: TDBGrid);
begin
  Grid.Columns[1].Width := WidthColumns.Column1;
  Grid.Columns[2].Width := WidthColumns.Column2;
  Grid.Columns[3].Width := WidthColumns.Column3;
  Grid.SelectedIndex := WidthColumns.SelectedIndex;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsIndex.PopupMenuCopyClick(Sender: TObject);
var
  ClipBoard: TClipboard;
  Str: String;
begin
  ClipBoard := TClipboard.Create;

  with DBGrid do
  begin
    Str := Fields[SelectedIndex].AsString;
    ClipBoard.SetTextBuf(PWideChar(WideString(Str)));
  end;

  FreeAndNil(ClipBoard);
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
