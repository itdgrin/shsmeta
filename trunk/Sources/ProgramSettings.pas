unit ProgramSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, UITypes,
  Grids, IniFiles;

type
  TFormProgramSettings = class(TForm)
    PageControl1: TPageControl;
    ButtonCancel: TButton;
    ButtonSave: TButton;
    TabSheet3: TTabSheet;
    GroupBoxColor: TGroupBox;
    LabelFontSelectRow: TLabel;
    LabelFontSelectCell: TLabel;
    Button3: TButton;
    ShapeFontRows: TShape;
    ShapeBackgroundSelectRow: TShape;
    Bevel1: TBevel;
    StringGridDemo: TStringGrid;
    LabelBackgroundHead: TLabel;
    LabelBackgroundSelectRow: TLabel;
    LabelBackgroundSelectCell: TLabel;
    ShapeBackgroundHead: TShape;
    ShapeBackgroundSelectCell: TShape;
    LabelFontHead: TLabel;
    ShapeFontHead: TShape;
    ShapeFontSelectCell: TShape;
    LabelBackgroundRows: TLabel;
    LabelFontRows: TLabel;
    ShapeFontSelectRow: TShape;
    ShapeBackgroundRows: TShape;
    ColorDialog: TColorDialog;
    ButtonDefaultSettingsTables: TButton;
    Label1: TLabel;
    TabSheet1: TTabSheet;
    GroupBoxRound: TGroupBox;
    LabelRound1: TLabel;
    ComboBoxRound: TComboBox;
    LabelRound2: TLabel;
    ButtonDefaultOtherSettings: TButton;
    CheckBoxShowHint: TCheckBox;
    ShapeSelectRowUnfocusedTable: TShape;
    LabelSelectRowUnfocusedTable: TLabel;

    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure StringGridDemoDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure ShapeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure StringGridDemoEnter(Sender: TObject);
    procedure StringGridDemoClick(Sender: TObject);
    procedure StringGridDemoExit(Sender: TObject);
    procedure ButtonDefaultSettingsTablesClick(Sender: TObject);
    procedure ButtonDefaultOtherSettingsClick(Sender: TObject);
    procedure GetSettings;
    procedure StringGridDemoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

  private

  public

  end;

const
  CaptionForm = '��������� ���������';

implementation

uses Main;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.FormShow(Sender: TObject);
var
  i: Integer;
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  ButtonSave.Tag := 0;

  GetSettings;

  // -----------------------------------------

  // ����������� ���������������� �������
  with StringGridDemo do
  begin
    ColCount := 4;
    RowCount := 11;

    FixedCols := 0;
    FixedRows := 1;

    ColWidths[0] := 40;
    ColWidths[2] := 80;
    ColWidths[3] := 50;
    ColWidths[1] := Width - ColWidths[0] - ColWidths[2] - ColWidths[3] - GetSystemMetrics(SM_CXVSCROLL) - 9;

    Cells[0, 0] := '� �/�';
    Cells[1, 0] := '������������';
    Cells[2, 0] := '���-��';
    Cells[3, 0] := '�������';

    for i := 1 to RowCount - 1 do
    begin
      Cells[0, i] := IntToStr(i);
      Cells[1, i] := '�������� ' + IntToStr(i);
      Cells[2, i] := IntToStr(Random(100));

      if StrToInt(Cells[2, i]) > 50 then
        Cells[3, i] := '��'
      else
      begin
        Cells[2, i] := '0';
        Cells[3, i] := '���';
      end;
    end;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ButtonSave.Tag = 0 then
    if MessageBox(0, PChar('�� ������� ��� ������ ����� ��� ����������?'), CaptionForm,
      MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrYes then
      CanClose := True
    else
      CanClose := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.StringGridDemoClick(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.StringGridDemoDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  // ��� ��� �������� ������� DefaultDrawing ��������� (����� ������ ������� ����� �������� ���������� ������)
  // ���������� ������ ������������� ����� � ��� ������ �������

  with (Sender as TStringGrid) do
  begin
    // ���������� ����� �������
    if (ARow = 0) or (ACol = 0) then
    begin
      Canvas.Brush.Color := ShapeBackgroundHead.Brush.Color;
      Canvas.Font.Color := ShapeFontHead.Brush.Color;
    end
    else // ���������� ���� ��������� �����
    begin
      Canvas.Brush.Color := ShapeBackgroundRows.Brush.Color;
      Canvas.Font.Color := ShapeFontRows.Brush.Color;
    end;

    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);

    // ���� ������� � ������ � ������ �� ����� ������ ������
    if Focused and (Row = ARow) and (Row > 0) and (ACol > 0) then
    begin
      if gdFocused in State then // ������ � ������
      begin
        Canvas.Brush.Color := ShapeBackgroundSelectCell.Brush.Color;
        Canvas.Font.Color := ShapeFontSelectCell.Brush.Color;
      end
      else // ������ �� � ������
      begin
        Canvas.Brush.Color := ShapeBackgroundSelectRow.Brush.Color;
        Canvas.Font.Color := ShapeFontSelectRow.Brush.Color;
      end;

      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, Row]);
    end;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.StringGridDemoEnter(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.StringGridDemoExit(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

procedure TFormProgramSettings.StringGridDemoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.ShapeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Button <> mbLeft then
    Exit;

  if ColorDialog.Execute then
  begin
    with (Sender as TShape) do
      Brush.Color := ColorDialog.Color;

    StringGridDemo.Repaint;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.ButtonDefaultSettingsTablesClick(Sender: TObject);
var
  Path: string;
  IFile: TIniFile;
begin
  try
    // �������� ���� �� �����
    Path := ExtractFilePath(Application.ExeName) + FileDefaultProgramSettings;

    // ��������� ����
    IFile := TIniFile.Create(Path);

    with IFile do
    begin
      ShapeBackgroundHead.Brush.Color := ReadInteger('Tables', BackgroundHead, 14410967);
      ShapeFontHead.Brush.Color := ReadInteger('Tables', FontHead, 0);
      ShapeBackgroundRows.Brush.Color := ReadInteger('Tables', BackgroundRows, 16777215);
      ShapeFontRows.Brush.Color := ReadInteger('Tables', FontRows, 0);
      ShapeBackgroundSelectRow.Brush.Color := ReadInteger('Tables', BackgroundSelectRow, 5197647);
      ShapeFontSelectRow.Brush.Color := ReadInteger('Tables', FontSelectRow, 16777215);
      ShapeBackgroundSelectCell.Brush.Color := ReadInteger('Tables', BackgroundSelectCell, 2039583);
      ShapeFontSelectCell.Brush.Color := ReadInteger('Tables', FontSelectCell, 16777215);
      ShapeSelectRowUnfocusedTable.Brush.Color := ReadInteger('Tables', SelectRowUnfocusedTable, -16777201);
    end;
  finally
    FreeAndNil(IFile); // ������� �������� ���� �� ������
  end;

  StringGridDemo.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.ButtonDefaultOtherSettingsClick(Sender: TObject);
var
  Path: string;
  IFile: TIniFile;
begin
  try
    // �������� ���� �� �����
    Path := ExtractFilePath(Application.ExeName) + FileDefaultProgramSettings;

    // ��������� ����
    IFile := TIniFile.Create(Path);

    with IFile do
    begin
      ComboBoxRound.ItemIndex := ReadInteger('Round', vRoundTo, 0);
      CheckBoxShowHint.Checked := ReadBool('ShowHint', vShowHint, True);
    end;
  finally
    FreeAndNil(IFile); // ������� �������� ���� �� ������
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.ButtonSaveClick(Sender: TObject);
begin
  PS.BackgroundHead := ShapeBackgroundHead.Brush.Color;
  PS.FontHead := ShapeFontHead.Brush.Color;
  PS.BackgroundRows := ShapeBackgroundRows.Brush.Color;
  PS.FontRows := ShapeFontRows.Brush.Color;
  PS.BackgroundSelectRow := ShapeBackgroundSelectRow.Brush.Color;
  PS.FontSelectRow := ShapeFontSelectRow.Brush.Color;
  PS.BackgroundSelectCell := ShapeBackgroundSelectCell.Brush.Color;
  PS.FontSelectCell := ShapeFontSelectCell.Brush.Color;
  PS.SelectRowUnfocusedTable := ShapeSelectRowUnfocusedTable.Brush.Color;

  PS.RoundTo := ComboBoxRound.ItemIndex;

  PS.ShowHint := CheckBoxShowHint.Checked;

  FormMain.WriteSettingsToFile(ExtractFilePath(Application.ExeName) + FileProgramSettings);

  MessageBox(0, PChar('��������� ��������� ����� ���� ��������� ' + sLineBreak +
    '������ ����� ����������� ���������!'), CaptionForm, MB_ICONINFORMATION + mb_OK + mb_TaskModal);

  ButtonSave.Tag := 1;
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.GetSettings;
begin
  ShapeBackgroundHead.Brush.Color := PS.BackgroundHead;
  ShapeFontHead.Brush.Color := PS.FontHead;
  ShapeBackgroundRows.Brush.Color := PS.BackgroundRows;
  ShapeFontRows.Brush.Color := PS.FontRows;
  ShapeBackgroundSelectRow.Brush.Color := PS.BackgroundSelectRow;
  ShapeFontSelectRow.Brush.Color := PS.FontSelectRow;
  ShapeBackgroundSelectCell.Brush.Color := PS.BackgroundSelectCell;
  ShapeFontSelectCell.Brush.Color := PS.FontSelectCell;
  ShapeSelectRowUnfocusedTable.Brush.Color := PS.SelectRowUnfocusedTable;

  ComboBoxRound.ItemIndex := PS.RoundTo;

  CheckBoxShowHint.Checked := PS.ShowHint;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
