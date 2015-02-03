unit Columns;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles,
  Grids;

type
  TFormColumns = class(TForm)

    ButtonSGLAll: TButton;
    ButtonSGLNone: TButton;

    PanelStringGridRates: TPanel;

    CheckBoxSGL1: TCheckBox;
    CheckBoxSGL2: TCheckBox;
    CheckBoxSGL3: TCheckBox;
    CheckBoxSGL4: TCheckBox;

    // -----------------------------------------

    PanelStringGridRight: TPanel;

    ButtonSGRAll: TButton;
    ButtonSGRNone: TButton;

    CheckBoxSGR1: TCheckBox;
    CheckBoxSGR2: TCheckBox;
    CheckBoxSGR3: TCheckBox;
    CheckBoxSGR4: TCheckBox;
    CheckBoxSGR5: TCheckBox;
    CheckBoxSGR6: TCheckBox;
    CheckBoxSGR7: TCheckBox;
    CheckBoxSGR8: TCheckBox;
    CheckBoxSGR9: TCheckBox;
    CheckBoxSGR10: TCheckBox;
    CheckBoxSGR11: TCheckBox;

    // -----------------------------------------

    Bevel: TBevel;
    ButtonCancel: TButton;
    ButtonSGRDefault: TButton;
    ButtonSGLDefault: TButton;
    CheckBoxSGR12: TCheckBox;
    PanelStringGridCoef: TPanel;
    CheckBoxSGC1: TCheckBox;
    CheckBoxSGC2: TCheckBox;
    CheckBoxSGC3: TCheckBox;
    CheckBoxSGC4: TCheckBox;
    CheckBoxSGC5: TCheckBox;
    CheckBoxSGC6: TCheckBox;
    CheckBoxSGC7: TCheckBox;
    CheckBoxSGC8: TCheckBox;
    CheckBoxSGC9: TCheckBox;
    CheckBoxSGC10: TCheckBox;
    CheckBoxSGC11: TCheckBox;
    ButtonSGCAll: TButton;
    ButtonSGCNone: TButton;
    ButtonSGCDefault: TButton;
    CheckBoxSGC12: TCheckBox;
    CheckBoxSGC13: TCheckBox;
    CheckBoxSGC14: TCheckBox;
    CheckBoxSGC15: TCheckBox;
    CheckBoxSGR13: TCheckBox;

    // -----------------------------------------

    procedure FormShow(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);

    procedure SetNameTable(const Value: String);
    function OpenFileSettingsAndGetCountColumns(): TIniFile;

    // -----------------------------------------

    // StringGridRates (FormCalculationEstimate)

    procedure SettingsCheckBoxSGL;
    procedure CheckBoxSGLClick(Sender: TObject);
    procedure ButtonSGLAllClick(Sender: TObject);
    procedure ButtonSGLNoneClick(Sender: TObject);
    procedure ButtonSGLDefaultClick(Sender: TObject);

    // -----------------------------------------

    // StringGridRight (FormCalculationEstimate)

    procedure SettingsCheckBoxSGR;
    procedure CheckBoxSGRClick(Sender: TObject);
    procedure ButtonSGRAllClick(Sender: TObject);
    procedure ButtonSGRNoneClick(Sender: TObject);
    procedure ButtonSGRDefaultClick(Sender: TObject);

    // -----------------------------------------

    // StringGridCoef (FormCalculationEstimate)

    procedure SettingsCheckBoxSGC;
    procedure CheckBoxSGCClick(Sender: TObject);
    procedure ButtonSGCAllClick(Sender: TObject);
    procedure ButtonSGCNoneClick(Sender: TObject);
    procedure ButtonSGCDefaultClick(Sender: TObject);

    // -----------------------------------------

    // procedure CheckBoxStringGridClick(Sender: TObject);

  private
    NameTable: String; // Название таблицы с которой работаем
    NameStringGrid: String;
    CountColumns: Integer; // Количество видимых столбцов в таблице
    CountColumnsHide: Integer; // Количество скрытых столбцов в таблице

  public

  end;

var
  FormColumns: TFormColumns;

implementation

uses Main, CalculationEstimate;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormColumns.FormShow(Sender: TObject);
begin
  with Constraints do
  begin
    MinWidth := 0;
    MaxWidth := 0;
    MinHeight := 0;
    MaxHeight := 0;
  end;

  PanelStringGridRates.Align := alNone;
  PanelStringGridRight.Align := alNone;
  PanelStringGridCoef.Align := alNone;

  PanelStringGridRates.Left := -2000;
  PanelStringGridRight.Left := -2000;
  PanelStringGridCoef.Left := -2000;

  // -----------------------------------------

  if NameTable = 'StringGridRates' then
  begin
    ClientWidth := PanelStringGridRates.Width;
    ClientHeight := PanelStringGridRates.Height + Bevel.Height;

    PanelStringGridRates.Align := alClient;
    SettingsCheckBoxSGL;
  end
  else if pos('TablePrice', NameTable) > 0 then
  begin
    ClientWidth := PanelStringGridRight.Width;

    if NameTable = 'TablePriceDescription' then
    begin
      NameStringGrid := 'StringGridDescription';
      ClientHeight := CheckBoxSGR2.Top + CheckBoxSGR2.Height + 8 + Bevel.Height;
    end
    else if NameTable = 'TablePriceMaterials' then
    begin
      NameStringGrid := 'StringGridMaterials';
      ClientHeight := CheckBoxSGR13.Top + CheckBoxSGR13.Height + 8 + Bevel.Height;
    end
    else if NameTable = 'TablePriceMechanizms' then
    begin
      NameStringGrid := 'StringGridMechanizms';
      ClientHeight := CheckBoxSGR11.Top + CheckBoxSGR10.Height + 8 + Bevel.Height;
    end;

    PanelStringGridRight.Align := alClient;
    SettingsCheckBoxSGR;
  end
  else if NameTable = 'TableCalculations' then
  begin
    ClientWidth := PanelStringGridCoef.Width;
    ClientHeight := PanelStringGridCoef.Height + Bevel.Height;

    PanelStringGridCoef.Align := alClient;
    SettingsCheckBoxSGC;
  end;


  // -----------------------------------------

  with Constraints do
  begin
    MinWidth := Width;
    MaxWidth := Width;
    MinHeight := Height;
    MaxHeight := Height;
  end;

  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormColumns.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormColumns.SetNameTable(const Value: String);
begin
  NameTable := Value;
end;

// ---------------------------------------------------------------------------------------------------------------------

function TFormColumns.OpenFileSettingsAndGetCountColumns(): TIniFile;
var
  Path: string;
  IFile: TIniFile;
begin
  // Получаем путь до файла
  Path := ExtractFilePath(Application.ExeName) + FileSettingsTables;

  // Открываем файл
  IFile := TIniFile.Create(Path);

  CountColumns := IFile.ReadInteger(NameTable, ColumnCount, 0);
  CountColumnsHide := IFile.ReadInteger(NameTable, ColumnCountHide, 0);

  Result := IFile;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormColumns.SettingsCheckBoxSGL;
var
  i: Integer;
  IFile: TIniFile;
begin
  try
    // Открываем файл настроек и получаем количество столбцов
    IFile := OpenFileSettingsAndGetCountColumns;

    for i := 1 to CountColumns do
      with (FindComponent('CheckBoxSGL' + IntToStr(i)) as TCheckBox), IFile do
      begin
        Checked := ReadBool(NameTable, ColumnVisible + IntToStr(i), True);
        Caption := ReadString(NameTable, ColumnName + IntToStr(i), 'Нет названия!');
      end;

  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormColumns.CheckBoxSGLClick(Sender: TObject);
var
  Nom: Integer;
  Value: Boolean;
  IFile: TIniFile;
begin
  // Получаем номер столбца
  with (Sender as TCheckBox) do
  begin
    Nom := StrToInt(Copy(Name, 12, Length(Name) - 11));
    Value := Checked;
  end;

  try
    // Открываем файл настроек и получаем количество столбцов
    IFile := OpenFileSettingsAndGetCountColumns;

    { if Value then
      FormCalculationEstimate.StringGridRates.ColWidths[Nom - 1] :=
      IFile.ReadInteger(NameTable, ColumnWidth + IntToStr(Nom), 100)
      else
      FormCalculationEstimate.StringGridRates.ColWidths[Nom - 1] := -1;
    }
    IFile.WriteBool(NameTable, ColumnVisible + IntToStr(Nom), Value);
    (FindComponent('CheckBoxSGL' + IntToStr(Nom)) as TCheckBox).Checked := Value;

  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormColumns.ButtonSGLAllClick(Sender: TObject);
var
  i: Integer;
  IFile: TIniFile;
begin
  try
    // Открываем файл настроек и получаем количество столбцов
    IFile := OpenFileSettingsAndGetCountColumns;

    for i := 1 to CountColumns do
    begin
      (FindComponent('CheckBoxSGL' + IntToStr(i)) as TCheckBox).Checked := True;

      { FormCalculationEstimate.StringGridRates.ColWidths[i - 1] :=
        IFile.ReadInteger(NameTable, ColumnWidth + IntToStr(i), 100);
      }
      IFile.WriteBool(NameTable, ColumnVisible + IntToStr(i), True);
    end;

  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormColumns.ButtonSGLNoneClick(Sender: TObject);
var
  i: Integer;
  IFile: TIniFile;
begin
  try
    // Открываем файл настроек и получаем количество столбцов
    IFile := OpenFileSettingsAndGetCountColumns;

    for i := 1 to CountColumns do
    begin
      (FindComponent('CheckBoxSGL' + IntToStr(i)) as TCheckBox).Checked := False;
      // FormCalculationEstimate.StringGridRates.ColWidths[i - 1] := -1;
      IFile.WriteBool(NameTable, ColumnVisible + IntToStr(i), False);
    end;

  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormColumns.ButtonSGLDefaultClick(Sender: TObject);
var
  { i: Integer; }
  Path: String;
  IDefaultFile, IFile: TIniFile;
  { ColWidth: Integer; }
begin
  try
    // Получаем путь до файла
    Path := ExtractFilePath(Application.ExeName) + FileDefaultSettingsTables;

    // Открываем файл
    IDefaultFile := TIniFile.Create(Path);

    CountColumns := IDefaultFile.ReadInteger(NameTable, ColumnCount, 0);

    // Получаем путь до файла
    Path := ExtractFilePath(Application.ExeName) + FileSettingsTables;

    // Открываем файл
    IFile := TIniFile.Create(Path);

    { for i := 1 to CountColumns do
      with (FindComponent('CheckBoxSGL' + IntToStr(i)) as TCheckBox), IDefaultFile,
      FormCalculationEstimate.StringGridRates do
      begin
      ColWidth := IDefaultFile.ReadInteger(NameTable, ColumnWidth + IntToStr(i), 100);
      IFile.WriteInteger(NameTable, ColumnWidth + IntToStr(i), ColWidth);

      Caption := ReadString(NameTable, ColumnName + IntToStr(i), 'Нет названия!');
      IFile.WriteString(NameTable, ColumnName + IntToStr(i), Caption);
      Cells[i - 1, 0] := Caption;

      Checked := ReadBool(NameTable, ColumnVisible + IntToStr(i), True);
      IFile.WriteBool(NameTable, ColumnVisible + IntToStr(i), Checked);

      if Checked then
      ColWidths[i - 1] := ColWidth
      else
      ColWidths[i - 1] := -1;
      end;
    }
  finally
    FreeAndNil(IDefaultFile); // Удаляем открытый файл из памяти
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormColumns.SettingsCheckBoxSGR;
var
  i: Integer;
  { NameColumn: String; }
  IFile: TIniFile;
begin
  try
    // Открываем файл настроек и получаем количество столбцов
    IFile := OpenFileSettingsAndGetCountColumns;

    // Скрываем ВСЕ компоненты CheckBoxSGR
    for i := 1 to 13 do
      with (FindComponent('CheckBoxSGR' + IntToStr(i)) as TCheckBox) do
        Visible := False;

    // Показываем нужные Checkbox-сы и подписываем их
    for i := 1 to CountColumns - CountColumnsHide do
      with (FindComponent('CheckBoxSGR' + IntToStr(i)) as TCheckBox), IFile do
      begin
        Caption := ReadString(NameTable, ColumnName + IntToStr(i), 'Нет названия');
        Checked := ReadBool(NameTable, ColumnVisible + IntToStr(i), True);
        Visible := True;
      end;

  finally
    FreeAndNil(IFile);
  end;
end;

procedure TFormColumns.CheckBoxSGRClick(Sender: TObject);
var
  Nom: Integer;
  Value: Boolean;
  IFile: TIniFile;
begin
  // Получаем номер этого столбца для удаления
  with (Sender as TCheckBox) do
  begin
    Nom := StrToInt(Copy(Name, 12, Length(Name) - 11));
    Value := Checked;
  end;

  try
    // Открываем файл настроек и получаем количество столбцов
    IFile := OpenFileSettingsAndGetCountColumns;

    with FormCalculationEstimate.FindComponent(NameStringGrid) as TStringGrid, IFile do
      if Value then
        ColWidths[Nom - 1] := ReadInteger(NameTable, ColumnWidth + IntToStr(Nom), 100)
      else
        ColWidths[Nom - 1] := -1;

    IFile.WriteBool(NameTable, ColumnVisible + IntToStr(Nom), Value);
    (FindComponent('CheckBoxSGR' + IntToStr(Nom)) as TCheckBox).Checked := Value;

  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormColumns.ButtonSGRAllClick(Sender: TObject);
var
  i: Integer;
  IFile: TIniFile;
begin
  try
    // Открываем файл настроек и получаем количество столбцов
    IFile := OpenFileSettingsAndGetCountColumns;

    for i := 1 to CountColumns do
    begin
      (FindComponent('CheckBoxSGR' + IntToStr(i)) as TCheckBox).Checked := True;

      // with FormCalculationEstimate.StringGridMaterials, IFile do
      // ColWidths[i - 1] := ReadInteger(NameTable, ColumnWidth + IntToStr(i), 100);
    end;

  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormColumns.ButtonSGRNoneClick(Sender: TObject);
var
  i: Integer;
  IFile: TIniFile;
begin
  try
    // Открываем файл настроек и получаем количество столбцов
    IFile := OpenFileSettingsAndGetCountColumns;

    for i := 1 to CountColumns do
    begin
      (FindComponent('CheckBoxSGR' + IntToStr(i)) as TCheckBox).Checked := False;
      // FormCalculationEstimate.StringGridMaterials.ColWidths[i - 1] := -1;
    end;

  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormColumns.ButtonSGRDefaultClick(Sender: TObject);
var
  i: Integer;
  Path: String;
  IDefaultFile, IFile: TIniFile;
  ColWidth: Integer;
begin
  try
    // Получаем путь до файла
    Path := ExtractFilePath(Application.ExeName) + FileDefaultSettingsTables;

    // Открываем файл
    IDefaultFile := TIniFile.Create(Path);

    CountColumns := IDefaultFile.ReadInteger(NameTable, ColumnCount, 0);

    // Получаем путь до файла
    Path := ExtractFilePath(Application.ExeName) + FileSettingsTables;

    // Открываем файл
    IFile := TIniFile.Create(Path);

    for i := 1 to CountColumns do
      with (FindComponent('CheckBoxSGR' + IntToStr(i)) as TCheckBox), IDefaultFile do
      begin
        ColWidth := IDefaultFile.ReadInteger(NameTable, ColumnWidth + IntToStr(i), 100);
        IFile.WriteInteger(NameTable, ColumnWidth + IntToStr(i), ColWidth);

        Caption := ReadString(NameTable, ColumnName + IntToStr(i), 'Нет названия!');
        IFile.WriteString(NameTable, ColumnName + IntToStr(i), Caption);

        Checked := ReadBool(NameTable, ColumnVisible + IntToStr(i), True);
        IFile.WriteBool(NameTable, ColumnVisible + IntToStr(i), Checked);
      end;

  finally
    FreeAndNil(IDefaultFile); // Удаляем открытый файл из памяти
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormColumns.SettingsCheckBoxSGC;
var
  i: Integer;
  IFile: TIniFile;
begin
  try
    // Открываем файл настроек и получаем количество столбцов
    IFile := OpenFileSettingsAndGetCountColumns;

    for i := 1 to CountColumns do
      with (FindComponent('CheckBoxSGC' + IntToStr(i)) as TCheckBox), IFile do
      begin
        Checked := ReadBool(NameTable, ColumnVisible + IntToStr(i), True);
        Caption := ReadString(NameTable, ColumnName + IntToStr(i), 'Нет названия!');
      end;

  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormColumns.CheckBoxSGCClick(Sender: TObject);
var
  Nom: Integer;
  Value: Boolean;
  IFile: TIniFile;
begin
  // Получаем номер столбца
  with (Sender as TCheckBox) do
  begin
    Nom := StrToInt(Copy(Name, 12, Length(Name) - 11));
    Value := Checked;
  end;

  try
    // Открываем файл настроек и получаем количество столбцов
    IFile := OpenFileSettingsAndGetCountColumns;

    if Value then
      with FormCalculationEstimate.dbgrdCalculations, IFile do
        Columns[Nom - 1].Width := ReadInteger(NameTable, ColumnWidth + IntToStr(Nom), 100)
    else
      FormCalculationEstimate.dbgrdCalculations.Columns[Nom - 1].Width := -1;

    IFile.WriteBool(NameTable, ColumnVisible + IntToStr(Nom), Value);
    (FindComponent('CheckBoxSGC' + IntToStr(Nom)) as TCheckBox).Checked := Value;

  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormColumns.ButtonSGCAllClick(Sender: TObject);
var
  i: Integer;
  IFile: TIniFile;
begin
  try
    // Открываем файл настроек и получаем количество столбцов
    IFile := OpenFileSettingsAndGetCountColumns;

    for i := 1 to CountColumns do
    begin
      (FindComponent('CheckBoxSGC' + IntToStr(i)) as TCheckBox).Checked := True;

      with FormCalculationEstimate.dbgrdCalculations, IFile do
      begin
        Columns[i - 1].Width := ReadInteger(NameTable, ColumnWidth + IntToStr(i), 100);

        WriteBool(NameTable, ColumnVisible + IntToStr(i), True);
      end;
    end;

  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormColumns.ButtonSGCNoneClick(Sender: TObject);
var
  i: Integer;
  IFile: TIniFile;
begin
  try
    // Открываем файл настроек и получаем количество столбцов
    IFile := OpenFileSettingsAndGetCountColumns;

    for i := 1 to CountColumns do
    begin
      (FindComponent('CheckBoxSGC' + IntToStr(i)) as TCheckBox).Checked := False;
      FormCalculationEstimate.dbgrdCalculations.Columns[i - 1].Width := -1;
      IFile.WriteBool(NameTable, ColumnVisible + IntToStr(i), False);
    end;

  finally
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

procedure TFormColumns.ButtonSGCDefaultClick(Sender: TObject);
var
  i: Integer;
  Path: String;
  IDefaultFile, IFile: TIniFile;
  ColWidth: Integer;
begin
  try
    // Получаем путь до файла
    Path := ExtractFilePath(Application.ExeName) + FileDefaultSettingsTables;

    // Открываем файл
    IDefaultFile := TIniFile.Create(Path);

    CountColumns := IDefaultFile.ReadInteger(NameTable, ColumnCount, 0);

    // Получаем путь до файла
    Path := ExtractFilePath(Application.ExeName) + FileSettingsTables;

    // Открываем файл
    IFile := TIniFile.Create(Path);

    for i := 1 to CountColumns do
      with (FindComponent('CheckBoxSGC' + IntToStr(i)) as TCheckBox), IDefaultFile,
        FormCalculationEstimate.dbgrdCalculations do
      begin
        ColWidth := IDefaultFile.ReadInteger(NameTable, ColumnWidth + IntToStr(i), 100);
        IFile.WriteInteger(NameTable, ColumnWidth + IntToStr(i), ColWidth);

        Caption := ReadString(NameTable, ColumnName + IntToStr(i), 'Нет названия!');
        IFile.WriteString(NameTable, ColumnName + IntToStr(i), Caption);

        Checked := ReadBool(NameTable, ColumnVisible + IntToStr(i), True);
        IFile.WriteBool(NameTable, ColumnVisible + IntToStr(i), Checked);

        if Checked then
          Columns[i - 1].Width := ColWidth
        else
          Columns[i - 1].Width := -1;
      end;

  finally
    FreeAndNil(IDefaultFile); // Удаляем открытый файл из памяти
    FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

{
  procedure TFormColumns.CheckBoxStringGridClick(Sender: TObject);
  var
  Nom: Integer;
  Value: Boolean;
  IFile: TIniFile;
  NT: String;
  SG: TStringGrid;
  CharTable: Char;
  begin
  // Получаем номер этого столбца для удаления
  with (Sender as TCheckBox) do
  begin
  Nom := StrToInt(Copy(Name, 12, Length(Name) - 11));
  Value := Checked;
  end;

  NT := Copy(NameTable, 1, pos('-', NameTable) - 1);

  with FormCalculationEstimate do
  if NT = 'StringGridRates' then
  begin
  SG := StringGridRates;
  CharTable := 'L';
  end
  else if NT = 'StringGridRight' then
  begin
  SG := StringGridRight;
  CharTable := 'R';
  end;

  try
  // Открываем файл настроек и получаем количество столбцов
  IFile := OpenFileSettingsAndGetCountColumns;

  if Value then
  with SG, IFile do
  ColWidths[Nom - 1] := ReadInteger(NameTable, ColumnWidth + IntToStr(Nom), 100)
  else
  SG.ColWidths[Nom - 1] := -1;

  IFile.WriteBool(NameTable, ColumnVisible + IntToStr(Nom), Value);
  (FindComponent('CheckBoxSG' + CharTable + IntToStr(Nom)) as TCheckBox).Checked := Value;

  finally
  FreeAndNil(IFile); // Удаляем открытый файл из памяти
  end;
  end;
}
// ---------------------------------------------------------------------------------------------------------------------

end.
