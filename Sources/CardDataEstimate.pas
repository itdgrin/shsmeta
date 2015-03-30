unit CardDataEstimate;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, Dialogs, Grids, StdCtrls, ExtCtrls, DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFormCardDataEstimate = class(TForm)

    PanelTop: TPanel;
    LabelCode: TLabel;
    EditCode: TEdit;
    Memo: TMemo;
    PanelBottom: TPanel;
    ButtonSave: TButton;
    ButtonClose: TButton;
    PanelSeparator: TPanel;
    StringGrid: TStringGrid;
    ADOQueryTemp: TFDQuery;

    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure ShowForm(const vIdInRate: Integer);
    procedure StringGridClick(Sender: TObject);

  private
    IdInRate: Integer;

  end;

var
  FormCardDataEstimate: TFormCardDataEstimate;

implementation

uses Main, DataModule, Tools;

const
  FormCaption = 'Карточка расценки';

{$R *.dfm}
  // ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardDataEstimate.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardDataEstimate.ButtonSaveClick(Sender: TObject);
begin
  try
    with ADOQueryTemp, StringGrid do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE card_rate_temp SET rate_unit = :rate_unit, rate_count = :rate_count, b_zp_rab = :b_zp_rab, '
        + 'b_eksp_mach = :b_eksp_mach, b_zp_mach = :b_zp_mach, b_mr = :b_mr, b_tr_ras = :b_tr_ras, b_zt_rab = :b_zt_rab, '
        + 'b_zt_mach = :b_zt_mach, b_raz_rab = :b_raz_rab, s_zp_rab = :s_zp_rab, s_eksp_mach = :s_eksp_mach, '
        + 's_zp_mach = :s_zp_mach, s_mr = :s_mr, s_tr_ras = :s_tr_ras, s_zt_rab = :s_zt_rab, s_zt_mach = :s_zt_mach, '
        + 's_raz_rab = :s_raz_rab WHERE id = :id;');

      ParamByName('rate_unit').Value := Cells[1, 1];
      ParamByName('rate_count').Value := MyStrToFloat(Cells[1, 2]);

      ParamByName('b_zp_rab').Value := StrToInt(Cells[1, 3]);
      ParamByName('b_eksp_mach').Value := StrToInt(Cells[1, 4]);
      ParamByName('b_zp_mach').Value := StrToInt(Cells[1, 5]);
      ParamByName('b_mr').Value := StrToInt(Cells[1, 6]);
      ParamByName('b_tr_ras').Value := StrToInt(Cells[1, 7]);
      ParamByName('b_zt_rab').Value := StrToInt(Cells[1, 9]);
      ParamByName('b_zt_mach').Value := StrToInt(Cells[1, 10]);
      ParamByName('b_raz_rab').Value := StrToInt(Cells[1, 11]);

      ParamByName('s_zp_rab').Value := StrToInt(Cells[2, 3]);
      ParamByName('s_eksp_mach').Value := StrToInt(Cells[2, 4]);
      ParamByName('s_zp_mach').Value := StrToInt(Cells[2, 5]);
      ParamByName('s_mr').Value := StrToInt(Cells[2, 6]);
      ParamByName('s_tr_ras').Value := StrToInt(Cells[2, 7]);
      ParamByName('s_zt_rab').Value := StrToInt(Cells[2, 9]);
      ParamByName('s_zt_mach').Value := StrToInt(Cells[2, 10]);
      ParamByName('s_raz_rab').Value := StrToInt(Cells[2, 11]);

      ParamByName('id').Value := IdInRate;

      ExecSQL;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При сохранении возникла ошибка:' + sLineBreak + E.Message), FormCaption,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardDataEstimate.FormCreate(Sender: TObject);
begin
  Caption := FormCaption;

  with StringGrid do
  begin
    ColCount := 3;
    RowCount := 12;

    FixedCols := 1;
    FixedRows := 1;

    Cells[0, 0] := '';
    Cells[1, 0] := 'Базовая величина';
    Cells[2, 0] := 'Сметная величина';

    Cells[0, 1] := 'Ед. изм.';
    Cells[0, 2] := 'Количество';
    Cells[0, 3] := 'Заработная плата рабочих-строителей, руб';
    Cells[0, 4] := 'Эксплуатация машин';
    Cells[0, 5] := 'Заработная плата машинистов, руб';
    Cells[0, 6] := 'Материальные ресурсы';
    Cells[0, 7] := 'Транспортные расходы, руб';
    Cells[0, 8] := 'Прямые затраты, Итого:';
    Cells[0, 9] := 'Затраты труда рабочих-строителей';
    Cells[0, 10] := 'Затраты труда машинистов';
    Cells[0, 11] := 'Средний разряд рабочих-строителей';

    ColWidths[0] := 240;
    ColWidths[1] := 115;
    ColWidths[2] := 115;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardDataEstimate.FormShow(Sender: TObject);
var
  i: Integer;
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  try
    with ADOQueryTemp, StringGrid do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM card_rate_temp WHERE id = :id;');
      ParamByName('id').Value := IdInRate;
      Active := True;

      for i := 1 to 11 do
      begin
        Cells[1, i] := '';
        Cells[2, i] := '';
      end;

      EditCode.Text := FieldByName('rate_code').AsString;
      Memo.Text := FieldByName('rate_caption').AsString;

      Cells[1, 1] := FieldByName('rate_unit').AsString;
      Cells[1, 2] := IntToStr(FieldByName('rate_count').AsInteger);
      Cells[1, 3] := IntToStr(FieldByName('b_zp_rab').AsInteger);
      Cells[1, 4] := IntToStr(FieldByName('b_eksp_mach').AsInteger);
      Cells[1, 5] := IntToStr(FieldByName('b_zp_mach').AsInteger);
      Cells[1, 6] := IntToStr(FieldByName('b_mr').AsInteger);
      Cells[1, 7] := IntToStr(FieldByName('b_tr_ras').AsInteger);
      Cells[1, 8] := '';
      Cells[1, 9] := IntToStr(FieldByName('b_zt_rab').AsInteger);
      Cells[1, 10] := IntToStr(FieldByName('b_zt_mach').AsInteger);
      Cells[1, 11] := IntToStr(FieldByName('b_raz_rab').AsInteger);

      Cells[2, 3] := IntToStr(FieldByName('s_zp_rab').AsInteger);
      Cells[2, 4] := IntToStr(FieldByName('s_eksp_mach').AsInteger);
      Cells[2, 5] := IntToStr(FieldByName('s_zp_mach').AsInteger);
      Cells[2, 6] := IntToStr(FieldByName('s_mr').AsInteger);
      Cells[2, 7] := IntToStr(FieldByName('s_tr_ras').AsInteger);
      Cells[2, 8] := '';
      Cells[2, 9] := IntToStr(FieldByName('s_zt_rab').AsInteger);
      Cells[2, 10] := IntToStr(FieldByName('s_zt_mach').AsInteger);
      Cells[2, 11] := IntToStr(FieldByName('s_raz_rab').AsInteger);
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении данных возникла ошибка:' + sLineBreak + E.Message), FormCaption,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  StringGrid.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardDataEstimate.StringGridClick(Sender: TObject);
begin
  with (Sender as TStringGrid) do
  begin
    Options := Options + [goEditing];

    if (Col = 2) and ((Row = 1) or (Row = 2)) then
      Options := Options - [goEditing];
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardDataEstimate.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
var
  TL: Integer;
begin
  TL := 0;
  // Так как свойство таблицы DefaultDrawing отключено (иначе ячейка таблицы будет обведена пунктирной линией)
  // необходимо самому прорисовывать шапку и все строки таблицы
  with (Sender as TStringGrid) do
  begin
    if (ARow = 0) or (ARow = 8) or (ACol = 0) or ((ACol = 2) and (ARow in [1, 2])) then
    // Прорисовка шапки таблицы
    begin
      Canvas.Brush.Color := PS.BackgroundHead;
      Canvas.Font.Color := PS.FontHead;

      if ARow = 0 then
        TL := (Rect.Right - Rect.Left - Canvas.TextWidth(Cells[ACol, ARow])) div 2
      else if ACol = 0 then
        TL := Rect.Right - Rect.Left - Canvas.TextWidth(Cells[ACol, ARow]) - 3;
    end
    else // Прорисовка всех остальных строк
    begin
      Canvas.Brush.Color := PS.BackgroundRows;
      Canvas.Font.Color := PS.FontRows;
      TL := 3;
    end;

    if Focused and (ARow = Row) and (ACol = Col) and (ACol > 0) and (ARow > 0) then
    // Если таблица в фокусе и строка не равна первой строке
    begin
      Canvas.Brush.Color := PS.BackgroundSelectRow;
      Canvas.Font.Color := PS.FontSelectRow;
      TL := 3;
    end;

    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left + TL, Rect.Top + 3, Cells[ACol, ARow]);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardDataEstimate.ShowForm(const vIdInRate: Integer);
begin
  IdInRate := vIdInRate;
  ShowModal;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
