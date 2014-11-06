unit CalculationDump;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Grids, ExtCtrls, DB,
  DBCtrls, Math, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFormCalculationDump = class(TForm)
    Bevel1: TBevel;
    Panel1: TPanel;
    LabelJustification: TLabel;
    EditJustificationNumber: TEdit;
    EditJustification: TEdit;
    PanelBottom: TPanel;
    PanelCenter: TPanel;
    PanelMemo: TPanel;
    PanelTable: TPanel;
    StringGrid: TStringGrid;
    ButtonCancel: TButton;
    ButtonSave: TButton;
    Panel2: TPanel;
    LabelND: TLabel;
    Memo: TMemo;
    DBLookupComboBoxND: TDBLookupComboBox;
    DataSourceND: TDataSource;
    Panel3: TPanel;
    LabelCount: TLabel;
    EditCount: TEdit;
    LabelMass: TLabel;
    EditMass: TEdit;
    ADOQueryND: TFDQuery;
    ADOQueryTemp: TFDQuery;

    procedure StringGridClick(Sender: TObject);
    procedure StringGridEnter(Sender: TObject);
    procedure StringGridExit(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure SettingsTable;
    procedure CalculationCost;
    procedure FillingComboBox;
    procedure DBLookupComboBoxNDClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure EditCountChange(Sender: TObject);
    procedure EditMassChange(Sender: TObject);

  private
    StrQuery: String; // Строка для формирования запроса
    vUnit: Integer;
    IdDump: Integer;

  public

  end;

const
  CaptionForm = 'Расчёт свалки';

var
  FormCalculationDump: TFormCalculationDump;

implementation

uses Main, DataModule, CalculationEstimate;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.ButtonSaveClick(Sender: TObject);
var
  Count: Double;
  FieldRates: TFieldRates;
begin
  if (vUnit = 24) and ((EditCount.Text = '') or (EditMass.Text = '')) then
  begin
    MessageBox(0, PChar('Поле «Количество» или «Удельный вес» не заполнено!' + sLineBreak + sLineBreak +
      'Заполните указанные поля и повторите добавление.'), CaptionForm, MB_ICONINFORMATION + MB_OK + mb_TaskModal);

    Exit;
  end
  else if (vUnit = 27) and (EditCount.Text = '') then
  begin
    MessageBox(0, PChar('Поле «Количество» не заполнено!' + sLineBreak + sLineBreak +
      'Заполните указанное поле и повторите добавление.'), CaptionForm, MB_ICONINFORMATION + MB_OK + mb_TaskModal);

    Exit;
  end;

  if vUnit = 24 then
    Count := StrToInt(EditCount.Text) * 1000 / StrToInt(EditMass.Text)
  else if vUnit = 27 then
    Count := StrToInt(EditCount.Text);

  with FieldRates do
  begin
    vRow := 0;
    vNumber := EditJustificationNumber.Text;
    vCount := RoundTo(Count, -2);
    vNameUnit := StringGrid.Cells[1, 1];;
    vDescription := EditJustification.Text;
    vTypeAddData := 9;
    vId := IdDump;
    // vDistance := EditCount.Text;
    // vClas := EditMass.Text;
  end;

  FormCalculationEstimate.AddRowToTableRates(FieldRates);

  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.DBLookupComboBoxNDClick(Sender: TObject);
begin
  with (Sender as TDBLookupComboBox) do
    Memo.Text := 'Плата за прием и захоронение отходов (строительного мусора). ' + Text + '.';

  IdDump := (Sender as TDBLookupComboBox).KeyValue;

  // -----------------------------------------

  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;

      StrQuery := 'SELECT dump_id, coast1, coast2 FROM dumpcoast WHERE dump_id = ' + IntToStr(IdDump) + ';';

      SQL.Add(StrQuery);
      Active := True;

      with StringGrid do
      begin
        Cells[1, 2] := FieldByName('coast1').AsVariant;
        Cells[1, 3] := FieldByName('coast2').AsVariant;
      end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении цен по свалке возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // -----------------------------------------

  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;

      StrQuery := 'SELECT unit_name, dump.unit_id FROM dump, units WHERE dump.unit_id = units.unit_id and dump_id = ' +
        IntToStr(IdDump);

      SQL.Add(StrQuery);
      Active := True;

      with StringGrid do
        Cells[1, 1] := FieldByName('unit_name').AsVariant;

      vUnit := FieldByName('unit_id').AsVariant;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении единицы измерения возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  CalculationCost;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.EditCountChange(Sender: TObject);
begin
  CalculationCost;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', #8]) then // Не цифра и не BackSpace
    Key := #0;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.EditMassChange(Sender: TObject);
begin
  CalculationCost;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.FormCreate(Sender: TObject);
begin
  SettingsTable;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.FormShow(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  EditCount.Text := '';
  EditMass.Text := '';

  FillingComboBox;

  DBLookupComboBoxNDClick(DBLookupComboBoxND);

  DBLookupComboBoxND.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.StringGridClick(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  // Так как свойство таблицы DefaultDrawing отключено (иначе ячейка таблицы будет обведена пунктирной линией)
  // необходимо самому прорисовывать шапку и все строки таблицы
  with (Sender as TStringGrid) do
  begin
    // Прорисовка шапки таблицы
    if (ARow = 0) { or (ACol = 0) } then
    begin
      Canvas.Brush.Color := PS.BackgroundHead;
      Canvas.Font.Color := PS.FontHead;
    end
    else // Прорисовка всех остальных строк
    begin
      Canvas.Brush.Color := PS.BackgroundRows;
      Canvas.Font.Color := PS.FontRows;
    end;

    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);

    // Если таблица в фокусе и строка не равна первой строке
    if { Focused and } (Row = ARow) { and (ACol > 0) } then
    begin
      Canvas.Brush.Color := PS.BackgroundSelectRow;
      Canvas.Font.Color := PS.FontSelectRow;

      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, Row]);
    end;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.StringGridEnter(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.StringGridExit(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.SettingsTable;
begin
  with StringGrid do
  begin
    ColCount := 2;
    RowCount := 6;

    FixedCols := 0;
    FixedRows := 1;

    Cells[0, 0] := 'Показатель';
    Cells[1, 0] := 'Значение';

    Cells[0, 1] := 'Ед. изм.';
    Cells[0, 2] := 'Цена без НДС, руб';
    Cells[0, 3] := 'Цена с НДС, руб';
    Cells[0, 4] := 'Стоимость без НДС, руб';
    Cells[0, 5] := 'Стоимость с НДС, руб';

    ColWidths[0] := 140;
    ColWidths[1] := 80;

    PanelTable.Width := ColWidths[0] + ColWidths[1] + 1;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.FillingComboBox;
begin
  try
    with ADOQueryND do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT dump_id, dump_name FROM dump ORDER BY dump_name ASC;');
      Active := True;
    end;

    with DBLookupComboBoxND do
    begin
      ListSource := DataSourceND;
      ListField := 'dump_name';
      KeyField := 'dump_id';
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении списка свалок возникла ошибка:' + sLineBreak + E.Message), CaptionForm,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // -----------------------------------------

  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;

      StrQuery := 'SELECT dump_id FROM smetasourcedata WHERE sm_id = ' +
        IntToStr(FormCalculationEstimate.GetIdEstimate) + ';';

      SQL.Add(StrQuery);
      Active := True;

      with DBLookupComboBoxND do
        KeyValue := FieldByName('dump_id').AsVariant;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении Id свалки возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCalculationDump.CalculationCost;
begin
  if ((vUnit = 24) and ((EditCount.Text = '') or (EditMass.Text = ''))) or ((vUnit = 27) and (EditCount.Text = '')) then
  begin
    with StringGrid do
    begin
      Cells[1, 4] := '';
      Cells[1, 5] := '';
    end;

    Exit;
  end;

  if vUnit = 24 then // м3
    with StringGrid do
    begin
      Cells[1, 4] := MyFloatToStr(RoundTo(StrToInt(Cells[1, 2]) * StrToInt(EditCount.Text) * 1000 /
        StrToInt(EditMass.Text), PS.RoundTo * -1));

      Cells[1, 5] := MyFloatToStr(RoundTo(StrToInt(Cells[1, 3]) * StrToInt(EditCount.Text) * 1000 /
        StrToInt(EditMass.Text), PS.RoundTo * -1));
    end
  else if vUnit = 27 then // т
    with StringGrid do
    begin
      Cells[1, 4] := MyFloatToStr(StrToInt(Cells[1, 2]) * StrToInt(EditCount.Text));
      Cells[1, 5] := MyFloatToStr(StrToInt(Cells[1, 3]) * StrToInt(EditCount.Text));
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
