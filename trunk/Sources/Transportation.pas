unit Transportation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Grids, ExtCtrls, DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFormTransportation = class(TForm)
    Panel1: TPanel;
    EditJustificationNumber: TEdit;
    LabelJustification: TLabel;
    EditJustification: TEdit;
    Bevel1: TBevel;
    PanelTable: TPanel;
    StringGrid: TStringGrid;
    ButtonAdd: TButton;
    ButtonCancel: TButton;
    PanelMemo: TPanel;
    Memo: TMemo;
    Panel2: TPanel;
    LabelDistance: TLabel;
    LabelCount: TLabel;
    EditDistance: TEdit;
    EditMass: TEdit;
    PanelCenter: TPanel;
    PanelBottom: TPanel;
    LabelCostNoVAT: TLabel;
    EditCostNoVAT: TEdit;
    LabelCostVAT: TLabel;
    EditCostVAT: TEdit;
    ADOQueryTemp: TFDQuery;

    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridRepaint(Sender: TObject);
    procedure StringGridExit(Sender: TObject);
    procedure StringGridClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure SettingsTable;
    procedure FillingTable;
    procedure ClearTable;
    procedure EditDistanceChange(Sender: TObject);
    procedure StringGridDblClick(Sender: TObject);
    procedure CalculationCost;
    procedure EditMassChange(Sender: TObject);

  private
    StrQuery: String; // Строка для формирования запроса
    MonthEstimate: Integer;
    YearEstimate: Integer;
    IdRow: Integer;

  public
    procedure SetIdRow(const vId: Integer);
  end;

const
  CaptionForm = 'Перевозка грузов';

var
  FormTransportation: TFormTransportation;

implementation

uses Main, CalculationEstimate, DataModule;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.ButtonAddClick(Sender: TObject);
var
  vName: string;
  FieldRates: TFieldRates;
begin
  if (EditDistance.Text = '') or (EditMass.Text = '') then
  begin
    MessageBox(0, PChar('Поле «Расстояние» или «Масса» не заполнено!' + sLineBreak + sLineBreak +
      'Заполните указанные поля и повторите добавление.'), CaptionForm, MB_ICONINFORMATION + MB_OK + mb_TaskModal);

    Exit;
  end;

  vName := EditJustificationNumber.Text + ' - ' + EditDistance.Text + '.' + IntToStr(StringGrid.Row);

  with FieldRates do
  begin
    vRow := 0;
    vNumber := vName;
    vCount := EditMass.Text;
    vNameUnit := 'т';
    vDescription := EditJustification.Text;
    vTypeAddData := IdRow;
    vId := '';
    // vDistance := EditDistance.Text;
    // vClas := StringGrid.Row;
  end;

 // FormCalculationEstimate.AddRowToTableRates(FieldRates);

  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.EditDistanceChange(Sender: TObject);
begin
  FillingTable;

  CalculationCost;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', #8]) then // Не цифра и не BackSpace
    Key := #0;
end;

procedure TFormTransportation.EditMassChange(Sender: TObject);
begin
  CalculationCost;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.FormCreate(Sender: TObject);
begin
  SettingsTable;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.FormShow(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  with FormCalculationEstimate do
  begin
    MonthEstimate := GetMonth;
    YearEstimate := GetYear;
  end;

  case IdRow of
    5:
      begin
        EditJustificationNumber.Text := 'C310';
        EditJustification.Text := 'Перевозка грузов автомобилями – самосвалами C310';
      end;
    6:
      begin
        EditJustificationNumber.Text := 'C310';
        EditJustification.Text := 'Перевозка мусора автомобилями – самосвалами C310';
      end;
    7:
      begin
        EditJustificationNumber.Text := 'C311';
        EditJustification.Text := 'Перевозка грузов автомобилями – самосвалами C311';
      end;
    8:
      begin
        EditJustificationNumber.Text := 'C311';
        EditJustification.Text := 'Перевозка мусора автомобилями - самосвалами C311';
      end;
  end;

  ClearTable;

  EditDistance.Text := '';
  EditMass.Text := '';
  EditCostNoVAT.Text := '';
  EditCostVAT.Text := '';

  EditDistance.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.StringGridClick(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    Repaint;

  CalculationCost;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.StringGridDblClick(Sender: TObject);
begin
  ButtonAddClick(ButtonAdd);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  // Так как свойство таблицы DefaultDrawing отключено (иначе ячейка таблицы будет обведена пунктирной линией)
  // необходимо самому прорисовывать шапку и все строки таблицы
  with (Sender as TStringGrid) do
  begin
    // Прорисовка шапки таблицы
    if (ARow = 0) or (ACol = 0) then
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
    if { Focused and } (Row = ARow) and (ACol > 0) then
    begin
      Canvas.Brush.Color := PS.BackgroundSelectRow;
      Canvas.Font.Color := PS.FontSelectRow;

      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, Row]);
    end;

    if (ACol = 0) and (ARow > 0) then
    begin
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + (ColWidths[0] - Canvas.TextWidth(Cells[ACol, ARow])) div 2, Rect.Top + 3,
        Cells[ACol, ARow]);
    end;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.StringGridRepaint(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.StringGridExit(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.SettingsTable;
begin
  with StringGrid do
  begin
    ColCount := 3;
    RowCount := 5;

    FixedCols := 1;
    FixedRows := 1;

    Cells[0, 0] := 'Класс груза';
    Cells[1, 0] := 'Цена (1т./км.) без НДС, руб';
    Cells[2, 0] := 'Цена (1т./км.) с НДС, руб';

    Cells[0, 1] := 'I';
    Cells[0, 2] := 'II';
    Cells[0, 3] := 'III';
    Cells[0, 4] := 'IV';

    ColWidths[0] := 70;
    ColWidths[1] := 150;
    ColWidths[2] := 150;

    PanelTable.Width := ColWidths[0] + ColWidths[1] + ColWidths[2] + 6 + 1;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.FillingTable;
var
  i: Integer;
  Distance: Integer;
  More: Integer;
begin
  if EditDistance.Text <> '' then
  begin
    More := 0;
    Distance := StrToInt(EditDistance.Text);

    if Distance > 50 then
    begin
      More := Distance - 50;
      Distance := 50;
    end;
  end
  else
  begin
    for i := 1 to 4 do
      with StringGrid do
      begin
        Cells[1, i] := '0';
        Cells[2, i] := '0';
      end;

    Exit;
  end;

  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;

      StrQuery := 'SELECT * FROM transfercargo WHERE monat = ' + IntToStr(MonthEstimate) + ' and year = ' +
        IntToStr(YearEstimate) + ' and distance = ' + IntToStr(Distance) + ';';

      SQL.Add(StrQuery);
      Active := True;

      for i := 1 to 4 do
        with StringGrid do
        begin
          Cells[1, i] := FieldByName('class' + IntToStr(i) + '_1').AsVariant;
          Cells[2, i] := FieldByName('class' + IntToStr(i) + '_2').AsVariant;
          Cells[3, i] := FieldByName('id').AsVariant;
        end;

      // -----------------------------------------

      if More = 0 then
        Exit;

      Active := False;
      SQL.Clear;

      StrQuery := 'SELECT * FROM transfercargo WHERE monat = ' + IntToStr(MonthEstimate) + ' and year = ' +
        IntToStr(YearEstimate) + ' and distance LIKE "%>50%";';

      SQL.Add(StrQuery);
      Active := True;

      for i := 1 to 4 do
        with StringGrid do
        begin
          Cells[1, i] := IntToStr(FieldByName('class' + IntToStr(i) + '_1').AsInteger * More + StrToInt(Cells[1, i]));
          Cells[2, i] := IntToStr(FieldByName('class' + IntToStr(i) + '_2').AsInteger * More + StrToInt(Cells[2, i]));
        end;

      Active := False;
    end;
  except
    on E: Exception do
    begin
      ADOQueryTemp.Active := False;

      MessageBox(0, PChar('При получении цен по грузоперевозкам возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.ClearTable;
var
  c, r: Integer;
begin
  with StringGrid do
    for r := 1 to RowCount - 1 do
      for c := 1 to ColCount - 1 do
        Cells[c, r] := '';
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.CalculationCost;
begin
  if (EditDistance.Text = '') or (EditMass.Text = '') then
  begin
    EditCostNoVAT.Text := '';
    EditCostVAT.Text := '';

    Exit;
  end;

  with StringGrid do
  begin
    EditCostNoVAT.Text := IntToStr(StrToInt(Cells[1, Row]) * StrToInt(EditMass.Text));
    EditCostVAT.Text := IntToStr(StrToInt(Cells[2, Row]) * StrToInt(EditMass.Text));
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTransportation.SetIdRow(const vId: Integer);
begin
  IdRow := vId;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.

