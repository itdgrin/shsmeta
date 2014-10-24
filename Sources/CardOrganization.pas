unit CardOrganization;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, DB, Grids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormCardOrganization = class(TForm)

    StringGrid: TStringGrid;

    Bevel: TBevel;
    ButtonSave: TButton;
    ButtonClose: TButton;
    ADOQuery: TFDQuery;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure ShowForm(const vId: Integer);

    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);

  private
    FormCaption: PWideChar;
    ConfirmationClose: Boolean;
    Id: Integer; // Id редактирцемой записи, если Id = -1, то идёт добавление записи.
  end;

var
  FormCardOrganization: TFormCardOrganization;

implementation

uses Main;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardOrganization.FormCreate(Sender: TObject);
begin
  FormCaption := FormNameCardOrganization;
  Caption := FormCaption;;

  with StringGrid do
  begin
    Options := Options + [goEditing];

    ColCount := 2;
    RowCount := 12;

    FixedCols := 1;
    FixedRows := 0;

    Cells[0, 0] := 'Наименование организации (краткое):';
    Cells[0, 1] := 'Наименование организации (полное):';
    Cells[0, 2] := 'Наименование банка:';
    Cells[0, 3] := 'Код банка:';
    Cells[0, 4] := '№ счёта:';
    Cells[0, 5] := 'УНН:';
    Cells[0, 6] := 'ОКПО:';
    Cells[0, 7] := 'Адрес:';
    Cells[0, 8] := 'Должность руковидителя:';
    Cells[0, 9] := 'Ф.И.О. руководителя:';
    Cells[0, 10] := 'Телефон/факс:';
    Cells[0, 11] := 'Контактное лицо:';

    ColWidths[0] := 210;
    ColWidths[1] := Width - ColWidths[0] - 5;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardOrganization.FormShow(Sender: TObject);
var
  i: Integer;
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  ConfirmationClose := True;

  // ----------------------------------------

  with StringGrid do
    for i := 0 to RowCount - 1 do
      Cells[1, i] := '';

  StringGrid.Row := 0;
  StringGrid.SetFocus;

  if Id = -1 then
    Exit;

  try
    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM clients WHERE client_id = :client_id;');
      ParamByName('client_id').Value := Id;
      Active := True;

      with StringGrid do
      begin
        Cells[1, 0] := FieldByName('name').AsString;
        Cells[1, 1] := FieldByName('full_name').AsString;
        Cells[1, 2] := FieldByName('bank').AsString;
        Cells[1, 3] := FieldByName('code').AsString;
        Cells[1, 4] := FieldByName('account').AsString;
        Cells[1, 5] := FieldByName('unn').AsString;
        Cells[1, 6] := FieldByName('okpo').AsString;
        Cells[1, 7] := FieldByName('address').AsString;
        Cells[1, 8] := FieldByName('ruk_prof').AsString;
        Cells[1, 9] := FieldByName('ruk_fio').AsString;
        Cells[1, 10] := FieldByName('phone').AsString;
        Cells[1, 11] := FieldByName('contact_fio').AsString;
      end;

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении данных редактируемой записи возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), FormCaption, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardOrganization.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ConfirmationClose then
    if MessageBox(0, PChar('Закрыть без сохранения сделанных изменений?'), FormCaption,
      MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
      CanClose := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardOrganization.ShowForm(const vId: Integer);
begin
  Id := vId;
  ShowModal;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardOrganization.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
var
  TL: Integer;
begin
  // Так как свойство таблицы DefaultDrawing отключено (иначе ячейка таблицы будет обведена пунктирной линией)
  // необходимо самому прорисовывать шапку и все строки таблицы
  with (Sender as TStringGrid) do
  begin
    if (ACol = 0) then // Прорисовка шапки таблицы
    begin
      Canvas.Brush.Color := PS.BackgroundHead;
      Canvas.Font.Color := PS.FontHead;

      TL := Rect.Right - Rect.Left - Canvas.TextWidth(Cells[ACol, ARow]) - 3;
    end
    else // Прорисовка всех остальных строк
    begin
      Canvas.Brush.Color := PS.BackgroundRows;
      Canvas.Font.Color := PS.FontRows;
      TL := 3;
    end;

    if Focused and (ACol = Col) and (ARow = Row) then
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

procedure TFormCardOrganization.ButtonSaveClick(Sender: TObject);
var
  Count, i: Integer;
begin
  Count := 0;

  with StringGrid do
    for i := 0 to RowCount - 1 do
      if Cells[1, i] = '' then
        Inc(Count);

  if Count > 0 then
  begin
    MessageBox(0, PChar('Одно или более полей не были заполнены!'), FormCaption, MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;

  try
    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;

      if Id = -1 then
        SQL.Add('INSERT INTO clients (name, full_name, bank, code, account, unn, okpo, address, ruk_prof, ' +
          'ruk_fio, phone, contact_fio) VALUES (:name, :full_name, :bank, :code, :account, :unn, :okpo, ' +
          ':address, :ruk_prof, :ruk_fio, :phone, :contact_fio);')
      else
        SQL.Add('UPDATE clients SET name = :name, full_name = :full_name, bank = :bank, code = :code, ' +
          'account = :account, unn = :unn, okpo = :okpo, address = :address, ruk_prof = :ruk_prof, ' +
          'ruk_fio = :ruk_fio, phone = :phone, contact_fio = :contact_fio WHERE client_id = :client_id;');

      with StringGrid do
      begin
        ParamByName('name').Value := Cells[1, 0];
        ParamByName('full_name').Value := Cells[1, 1];
        ParamByName('bank').Value := Cells[1, 2];
        ParamByName('code').Value := Cells[1, 3];
        ParamByName('account').Value := Cells[1, 4];
        ParamByName('unn').Value := Cells[1, 5];
        ParamByName('okpo').Value := Cells[1, 6];
        ParamByName('address').Value := Cells[1, 7];
        ParamByName('ruk_prof').Value := Cells[1, 8];
        ParamByName('ruk_fio').Value := Cells[1, 9];
        ParamByName('phone').Value := Cells[1, 10];
        ParamByName('contact_fio').Value := Cells[1, 11];

        if Id > -1 then
          ParamByName('client_id').Value := Id;
      end;

      ExecSQL;
      Active := False;
    end;

    ConfirmationClose := False;
    Close;
  except
    on E: Exception do
      MessageBox(0, PChar('При добавлении записи в БД возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        FormCaption, MB_ICONERROR + MB_OK + mb_TaskModal);
  end
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardOrganization.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
