unit CardCoefficients;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, Grids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormCardCoefficients = class(TForm)
    MemoName: TMemo;
    Bevel: TBevel;
    PanelSeparator: TPanel;

    ButtonSave: TButton;
    ButtonClose: TButton;
    PanelName: TPanel;
    LabelName: TLabel;
    StringGrid: TStringGrid;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);

    procedure ShowForm(const vIdEdit: Integer; const vADOQuery: TFDQuery);

    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);

  private
    ADOQuery: TFDQuery;
    ConfirmationClose: Boolean;
    IdEdit: Integer; // Id редактируемой записи, если Id = -1, то идёт добавление записи.
  end;

var
  FormCardCoefficients: TFormCardCoefficients;

implementation

uses Main;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCoefficients.FormCreate(Sender: TObject);
begin
  Caption := FormNameCardCoefficients;

  with StringGrid do
  begin
    Options := Options + [goEditing];

    ColCount := 2;
    RowCount := 5;

    FixedCols := 1;
    FixedRows := 0;

    Cells[0, 0] := 'Основная зарплата:';
    Cells[0, 1] := 'Эксплуатация машин:';
    Cells[0, 2] := 'Материальные ресурсы:';
    Cells[0, 3] := 'Трудозатраты рабочих:';
    Cells[0, 4] := 'Трудозатраты машинистов:';

    ColWidths[0] := 200;
    ColWidths[1] := Width - ColWidths[0] - 5;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCoefficients.FormShow(Sender: TObject);
var
  i: Integer;
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  ConfirmationClose := True;

  // ----------------------------------------

  MemoName.Text := '';

  for i := 0 to 4 do
    StringGrid.Cells[1, i] := '';

  MemoName.SetFocus;

  if IdEdit = -1 then
    Exit;

  try
    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM coef WHERE coef_id = :coef_id;');
      ParamByName('coef_id').Value := IdEdit;
      Active := True;

      MemoName.Text := FieldByName('coef_name').AsString;

      with StringGrid do
      begin
        Cells[1, 0] := MyFloatToStr(FieldByName('osn_zp').AsFloat);
        Cells[1, 1] := MyFloatToStr(FieldByName('eksp_mach').AsFloat);
        Cells[1, 2] := MyFloatToStr(FieldByName('mat_res').AsFloat);
        Cells[1, 3] := MyFloatToStr(FieldByName('work_pers').AsFloat);
        Cells[1, 4] := MyFloatToStr(FieldByName('work_mach').AsFloat);
      end;

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении данных редактируемой записи возникла ошибка:' + sLineBreak +
        sLineBreak + E.Message), FormNameCardCoefficients, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCoefficients.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ConfirmationClose then
    if MessageBox(0, PChar('Закрыть без сохранения сделанных изменений?'), FormNameCardCoefficients,
      MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
      CanClose := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCoefficients.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
var
  TW: Integer;
begin
  // Так как свойство таблицы DefaultDrawing отключено (иначе ячейка таблицы будет обведена пунктирной линией)
  // необходимо самому прорисовывать шапку и все строки таблицы
  with (Sender as TStringGrid) do
  begin
    if (ACol = 0) then // Прорисовка фиксированных столбцов и строк
    begin
      Canvas.Brush.Color := PS.BackgroundHead;
      Canvas.Font.Color := PS.FontHead;

      TW := Canvas.TextWidth(Cells[ACol, ARow]);
      TW := Rect.Left + (Rect.Right - Rect.Left - TW);
    end
    else // Прорисовка всех остальных ячеек
    begin
      Canvas.Brush.Color := PS.BackgroundRows;
      Canvas.Font.Color := PS.FontRows;

      TW := Canvas.TextWidth(Cells[ACol, ARow]);
      TW := Rect.Left + (Rect.Right - Rect.Left - TW) div 2;
    end;

    if Focused and (ACol = Col) and (ARow = Row) then // Если таблица в фокусе
    begin
      Canvas.Brush.Color := PS.BackgroundSelectRow;
      Canvas.Font.Color := PS.FontSelectRow;
    end;

    Canvas.FillRect(Rect);
    Canvas.TextOut(TW, Rect.Top + 3, Cells[ACol, ARow]);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCoefficients.ShowForm(const vIdEdit: Integer; const vADOQuery: TFDQuery);
begin
  IdEdit := vIdEdit;
  ADOQuery := vADOQuery;

  ShowModal;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCoefficients.ButtonSaveClick(Sender: TObject);
var
  Count, i: Integer;
begin
  Count := 0;

  if MemoName.Text = '' then
    Inc(Count);

  for i := 0 to 4 do
    if StringGrid.Cells[1, i] = '' then
      Inc(Count);

  if Count > 0 then
  begin
    MessageBox(0, PChar('Одно или более полей не были заполнены!'), FormNameCardCoefficients,
      MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;

  with ADOQuery do
  begin
    Active := False;
    SQL.Clear;

    if IdEdit = -1 then
      SQL.Add('INSERT INTO coef (coef_name, coef_value, osn_zp, eksp_mach, mat_res, work_pers, work_mach) ' +
        'VALUE(:coef_name, :coef_value, :osn_zp, :eksp_mach, :mat_res, :work_pers, :work_mach);')
    else
      SQL.Add('UPDATE coef SET coef_name = :coef_name, coef_value = :coef_value, osn_zp = :osn_zp, ' +
        'eksp_mach = :eksp_mach, mat_res = :mat_res, work_pers = :work_pers, work_mach = :work_mach ' +
        'WHERE coef_id = :coef_id;');

    with StringGrid do
    begin
      ParamByName('coef_name').Value := MemoName.Text;
      ParamByName('coef_value').Value := 0;
      ParamByName('osn_zp').Value := Cells[1, 0];
      ParamByName('eksp_mach').Value := Cells[1, 1];
      ParamByName('mat_res').Value := Cells[1, 2];
      ParamByName('work_pers').Value := Cells[1, 3];
      ParamByName('work_mach').Value := Cells[1, 4];

      if IdEdit > -1 then
        ParamByName('coef_id').Value := IdEdit;
    end;

    ExecSQL;
    Active := False;
  end;

  ConfirmationClose := False;
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCoefficients.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
