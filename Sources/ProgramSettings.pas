unit ProgramSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, UITypes,
  Grids, IniFiles, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls;

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
    chkAutoCreateEstimates: TCheckBox;
    chkAutoExpandTreeEstimates: TCheckBox;
    chkCalcResourcesAutoSave: TCheckBox;
    chkAutosaveRateDescr: TCheckBox;
    chkAutoSaveCalcResourcesAfterExitCell: TCheckBox;
    chkShowNeedSaveDialog: TCheckBox;
    chkFindAutoRepInAllRate: TCheckBox;
    lblOXROPR: TLabel;
    qrOXROPR: TFDQuery;
    dsOXROPR: TDataSource;
    qrMainData: TFDQuery;
    dsMainData: TDataSource;
    dblkcbbOXROPR: TDBLookupComboBox;

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
  CaptionForm = 'Настройки программы';

implementation

uses Main, DataModule, Tools;

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
  CloseOpen(qrMainData);
  CloseOpen(qrOXROPR);

  // -----------------------------------------

  // Настраиваем демонстрационную таблицу
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

    Cells[0, 0] := '№ п/п';
    Cells[1, 0] := 'Наименование';
    Cells[2, 0] := 'Кол-во';
    Cells[3, 0] := 'Наличие';

    for i := 1 to RowCount - 1 do
    begin
      Cells[0, i] := IntToStr(i);
      Cells[1, i] := 'Материал ' + IntToStr(i);
      Cells[2, i] := IntToStr(Random(100));

      if StrToInt(Cells[2, i]) > 50 then
        Cells[3, i] := 'Да'
      else
      begin
        Cells[2, i] := '0';
        Cells[3, i] := 'Нет';
      end;
    end;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormProgramSettings.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ButtonSave.Tag = 0 then
    if MessageBox(0, PChar('Вы уверены что хотите выйти без сохранения?'), CaptionForm,
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
  // Так как свойство таблицы DefaultDrawing отключено (иначе ячейка таблицы будет обведена пунктирной линией)
  // необходимо самому прорисовывать шапку и все строки таблицы

  with (Sender as TStringGrid) do
  begin
    // Прорисовка шапки таблицы
    if (ARow = 0) or (ACol = 0) then
    begin
      Canvas.Brush.Color := ShapeBackgroundHead.Brush.Color;
      Canvas.Font.Color := ShapeFontHead.Brush.Color;
    end
    else // Прорисовка всех остальных строк
    begin
      Canvas.Brush.Color := ShapeBackgroundRows.Brush.Color;
      Canvas.Font.Color := ShapeFontRows.Brush.Color;
    end;

    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);

    // Если таблица в фокусе и строка не равна первой строке
    if Focused and (Row = ARow) and (Row > 0) and (ACol > 0) then
    begin
      if gdFocused in State then // Ячейка в фокусе
      begin
        Canvas.Brush.Color := ShapeBackgroundSelectCell.Brush.Color;
        Canvas.Font.Color := ShapeFontSelectCell.Brush.Color;
      end
      else // Ячейка не в фокусе
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
    // Получаем путь до файла
    Path := ExtractFilePath(Application.ExeName) + FileDefaultProgramSettings;

    // Открываем файл
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
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
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
    // Получаем путь до файла
    Path := ExtractFilePath(Application.ExeName) + FileDefaultProgramSettings;

    // Открываем файл
    IFile := TIniFile.Create(Path);

    with IFile do
    begin
      ComboBoxRound.ItemIndex := ReadInteger('Round', vRoundTo, 0);
      CheckBoxShowHint.Checked := ReadBool('ShowHint', vShowHint, True);
    end;
  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
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
  PS.AutoCreateEstimates := chkAutoCreateEstimates.Checked;
  PS.AutoExpandTreeEstimates := chkAutoExpandTreeEstimates.Checked;
  PS.RoundTo := ComboBoxRound.ItemIndex;
  PS.CalcResourcesAutoSave := chkCalcResourcesAutoSave.Checked;
  PS.ShowHint := CheckBoxShowHint.Checked;
  PS.AutosaveRateDescr := chkAutosaveRateDescr.Checked;
  PS.AutoSaveCalcResourcesAfterExitCell := chkAutoSaveCalcResourcesAfterExitCell.Checked;
  PS.ShowNeedSaveDialog := chkShowNeedSaveDialog.Checked;
  PS.FindAutoRepInAllRate := chkFindAutoRepInAllRate.Checked;

  FormMain.WriteSettingsToFile(ExtractFilePath(Application.ExeName) + FileProgramSettings);

  MessageBox(0, PChar('Некоторые изменения могут быть применены ' + sLineBreak +
    'только после перезапуска программы!'), CaptionForm, MB_ICONINFORMATION + mb_OK + mb_TaskModal);

  ButtonSave.Tag := 1;
  if qrMainData.State in [dsEdit, dsInsert] then
    qrMainData.Post;
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

  chkAutoCreateEstimates.Checked := PS.AutoCreateEstimates;
  chkAutoExpandTreeEstimates.Checked := PS.AutoExpandTreeEstimates;
  chkCalcResourcesAutoSave.Checked := PS.CalcResourcesAutoSave;
  chkAutosaveRateDescr.Checked := PS.AutosaveRateDescr;
  chkAutoSaveCalcResourcesAfterExitCell.Checked := PS.AutoSaveCalcResourcesAfterExitCell;
  chkShowNeedSaveDialog.Checked := PS.ShowNeedSaveDialog;
  chkFindAutoRepInAllRate.Checked := PS.FindAutoRepInAllRate;
end;

end.
