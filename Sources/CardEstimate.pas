unit CardEstimate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, DB,
  ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, DateUtils, Vcl.Mask, Vcl.DBCtrls;

type
  TFormCardEstimate = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;

    LabelNumberEstimate: TLabel;
    LabelNumberChapter: TLabel;
    LabelNumberRow: TLabel;
    LabelNameEstimate: TLabel;
    LabelCompose: TLabel;
    LabelPostCompose: TLabel;
    LabelChecked: TLabel;
    LabelPostChecked: TLabel;
    LabelSetDrawing: TLabel;

    EditNumberEstimate: TEdit;
    EditNumberChapter: TEdit;
    EditNumberRow: TEdit;
    EditNameEstimate: TEdit;
    EditCompose: TEdit;
    EditPostCompose: TEdit;
    EditChecked: TEdit;
    EditPostChecked: TEdit;
    EditSetDrawing: TEdit;

    Bevel: TBevel;
    btnSave: TButton;
    btnClose: TButton;
    PanelPart: TPanel;
    LabelPart: TLabel;
    ComboBoxPart: TComboBox;
    PanelSection: TPanel;
    LabelSection: TLabel;
    ComboBoxSection: TComboBox;
    PanelTypeWork: TPanel;
    LabelTypeWork: TLabel;
    ComboBoxTypeWork: TComboBox;
    qrTemp: TFDQuery;
    qr1: TFDQuery;
    ds1: TDataSource;
    qr2: TFDQuery;
    ds2: TDataSource;
    qr3: TFDQuery;
    ds3: TDataSource;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure ShowForm(const vIdObject, vIdEstimate, vTypeEstimate: Integer);
    procedure ClearAllFields;
    procedure CreateNumberEstimate;
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EditingRecord(const Value: Boolean);
    function GetIdNewEstimate: Integer;

    procedure GetParts;
    procedure GetSections;
    procedure GetTypeWorks;
    procedure ComboBoxChange(Sender: TObject);

  private
    StrQuery: String;
    Editing: Boolean; // Для отслеживания режима добавления или редактирования записи

    IdObject: Integer;
    IdEstimate: Integer;
    TypeEstimate: Integer;
  public

  end;

var
  FormCardEstimate: TFormCardEstimate;

implementation

uses Main, DataModule, ObjectsAndEstimates, BasicData;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

function ReplaceDecimal(var vString: String; const vChar1: Char; const vChar2: Char): String;
var
  p: Integer;
begin
  p := Pos(vChar1, vString);
  if p > 0 then
    vString[p] := vChar2;
  Result := vString;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardEstimate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Editing := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardEstimate.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if btnSave.Tag = 0 then
    if MessageBox(0, PChar('Закрыть окно без сохранения?'), PWideChar(Caption),
      MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrYes then
      CanClose := True
    else
      CanClose := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardEstimate.FormCreate(Sender: TObject);
begin
  with Constraints do
  begin
    MinHeight := Height;
    MaxHeight := Height;
    MinWidth := Width;
    MaxWidth := Width;
  end;

  Caption := PWideChar(Caption);

  btnSave.Tag := 0;

  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  Editing := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardEstimate.FormShow(Sender: TObject);
{ var
  str: string; }
begin

  EditNumberChapter.SetFocus; // Устанавливаем фокус

  btnSave.Tag := 0;

  if not Editing then
    ClearAllFields; // Очистка полей формы

  // ----------------------------------------

  case TypeEstimate of
    1, 2:
      begin
        Caption := 'Карточка сметы';

        PanelPart.Enabled := False;
        PanelSection.Enabled := False;
        PanelTypeWork.Enabled := False;

        LabelPart.Enabled := False;
        LabelSection.Enabled := False;
        LabelTypeWork.Enabled := False;

        ComboBoxPart.Enabled := False;
        ComboBoxSection.Enabled := False;
        ComboBoxTypeWork.Enabled := False;
      end;
    3:
      begin
        Caption := 'Карточка ПТМ';

        PanelPart.Enabled := True;
        PanelSection.Enabled := True;
        PanelTypeWork.Enabled := True;

        LabelPart.Enabled := True;
        LabelSection.Enabled := True;
        LabelTypeWork.Enabled := True;

        ComboBoxPart.Enabled := True;
        ComboBoxSection.Enabled := True;
        ComboBoxTypeWork.Enabled := True;

        GetParts;
        GetSections;
        GetTypeWorks;
      end;
  end;

  // ----------------------------------------
  {
    str := ComboBoxPart.Text;
    Delete(str, 1, Pos('.', str) + 1);

    EditNameEstimate.Text := str;

    str := ComboBoxSection.Text;
    Delete(str, 1, Pos('.', str) + 1);

    EditNameEstimate.Text := EditNameEstimate.Text + str;

    str := ComboBoxTypeWork.Text;
    Delete(str, 1, Pos('.', str) + 1);

    EditNameEstimate.Text := EditNameEstimate.Text + str;
  }
  // ----------------------------------------

  CreateNumberEstimate;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardEstimate.ShowForm(const vIdObject, vIdEstimate, vTypeEstimate: Integer);
begin
  IdObject := vIdObject;
  IdEstimate := vIdEstimate;
  TypeEstimate := vTypeEstimate;
  if ShowModal = mrOk then
    FormBasicData.ShowForm(IdObject, IdEstimate);
end;

procedure TFormCardEstimate.EditingRecord(const Value: Boolean);
begin
  Editing := True;
end;

procedure TFormCardEstimate.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCardEstimate.btnSaveClick(Sender: TObject);
var
  CountWarning: Integer;

  DateCompose: String;
  vYear, vMonth: String;

  VAT: String;
  IdStavka: String;
  PercentTransport, PercentTransportEquipment: String;
  K40, K41, K31, K32, K33, K34: String;

  NumberChapter: String;
  NumberRow: String;
  NameEstimate: String;
  Compose: String;
  PostCompose: String;
  Checked: String;
  PostChecked: String;
  SetDrawing: String;
  IdParentLocal: Integer;

  // Node: TTreeNode;

begin
  CountWarning := 0;

  DateTimeToString(DateCompose, 'yyyy-mm-dd', Now);

  vMonth := IntToStr(MonthOf(Now));
  vYear := IntToStr(YearOf(Now));

  with qrTemp do
  begin
    try
      Active := False;
      SQL.Clear;

      StrQuery := 'SELECT state_nds, BEG_STROJ FROM objcards WHERE obj_id = ' + IntToStr(IdObject) + ';';

      SQL.Add(StrQuery);
      Active := True;

      VAT := FieldByName('state_nds').AsVariant;
      // При создании сметы дата для расценок проставляетсся как у объекта
      DateTimeToString(DateCompose, 'yyyy-mm-dd', FieldByName('BEG_STROJ').AsDateTime);
      vMonth := IntToStr(MonthOf(FieldByName('BEG_STROJ').AsDateTime));
      vYear := IntToStr(YearOf(FieldByName('BEG_STROJ').AsDateTime));
    except
      on E: Exception do
        MessageBox(0, PChar('При запросе НДС возникла ошибка:' + sLineBreak + E.Message), PWideChar(Caption),
          MB_ICONERROR + MB_OK + mb_TaskModal);
    end;

    // -----------------------------------------

    try
      Active := False;
      SQL.Clear;

      StrQuery := 'SELECT stavka_id as "IdStavka" FROM stavka WHERE year = ' + vYear + ' and monat = ' +
        vMonth + ';';

      SQL.Add(StrQuery);
      Active := True;

      IdStavka := IntToStr(FieldByName('IdStavka').AsInteger);

    except
      on E: Exception do
        MessageBox(0, PChar('При запросе ID СТАВКИ возникла ошибка:' + sLineBreak + E.Message),
          PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
    end;

    // -----------------------------------------

    try
      Active := False;
      SQL.Clear;

      StrQuery :=
        'SELECT objregion.percent_transport as "PercentTransport" FROM objcards, objstroj, objregion ' +
        'WHERE objcards.stroj_id = objstroj.stroj_id and objstroj.obj_region = objregion.obj_region_id and ' +
        'objcards.obj_id = ' + IntToStr(IdObject) + ';';

      SQL.Add(StrQuery);
      Active := True;

      PercentTransport := FieldByName('PercentTransport').AsString;
      ReplaceDecimal(PercentTransport, ',', '.');
      PercentTransportEquipment := '1';
    except
      on E: Exception do
        MessageBox(0, PChar('При запросе % ТРАНСПОРТНЫХ возникла ошибка:' + sLineBreak + E.Message),
          PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
  end;

  // -----------------------------------------

  K40 := '1';
  K41 := '1';
  K31 := '1';
  K32 := '1';
  K33 := '1';
  K34 := '1';

  with EditNumberChapter do
    if Text = '' then
      NumberChapter := 'NULL'
    else
      NumberChapter := '"' + Text + '"';

  with EditNumberRow do
    if Text = '' then
      NumberRow := 'NULL'
    else
      NumberRow := '"' + Text + '"';

  with EditNameEstimate do
    if Text = '' then
    begin
      Color := ColorWarningField;
      Inc(CountWarning);
    end
    else
      NameEstimate := '"' + Text + '"';

  with EditCompose do
    if Text = '' then
      Compose := '""'
    else
      Compose := '"' + Text + '"';

  with EditPostCompose do
    if Text = '' then
      PostCompose := '""'
    else
      PostCompose := '"' + Text + '"';

  with EditChecked do
    if Text = '' then
      Checked := '""'
    else
      Checked := '"' + Text + '"';

  with EditPostChecked do
    if Text = '' then
      PostChecked := '""'
    else
      PostChecked := '"' + Text + '"';

  with EditSetDrawing do
    if Text = '' then
      SetDrawing := '""'
    else
      SetDrawing := '"' + Text + '"';

  if CountWarning > 0 then
  begin
    MessageBox(0, PChar('Вы заполнили не все поля!' + #13#10 +
      'Поля выделенные красным не заполнены или заполнены неправильно.'), PWideChar(Caption),
      MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;
  // -----------------------------------------

  if TypeEstimate = 2 then
    IdParentLocal := 0
  else
    IdParentLocal := IdEstimate;

  try

    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      btnSave.Tag := 1;
      if Editing then
      begin
        StrQuery := 'UPDATE smetasourcedata SET name = ' + NameEstimate + ', chapter = ' + NumberChapter +
          ', row_number = ' + NumberRow + ', preparer = ' + Compose + ', ' + 'post_preparer = ' + PostCompose
          + ', examiner = ' + Checked + ', post_examiner = ' + PostChecked + ', set_drawings = ' + SetDrawing
          + ',sm_number = "' + EditNumberEstimate.Text + '"' + ' WHERE sm_id = ' + IntToStr(IdEstimate) + ';';
        SQL.Add(StrQuery);
        ExecSQL;

        ModalResult := mrCancel;
      end
      else
      begin
        SQL.Text :=
          'INSERT INTO smetasourcedata (sm_type, obj_id, parent_id, name, date, sm_number, '
          + 'chapter, row_number, preparer, post_preparer, examiner, post_examiner, set_drawings, k40, k41, k31, k32, '
          + 'k33, k34, coef_tr_zatr, coef_tr_obor, nds, stavka_id) Value("' + IntToStr(TypeEstimate) + '", "'
          + IntToStr(IdObject) + '", GetParentLocal(' + IntToStr(IdParentLocal) + ')+GetParentPTM(' +
          IntToStr(IdEstimate) + '), ' + NameEstimate + ', "' + DateCompose + '", "' + EditNumberEstimate.Text
          + '", ' + NumberChapter + ', ' + NumberRow + ', ' + Compose + ', ' + PostCompose + ', ' + Checked +
          ', ' + PostChecked + ', ' + SetDrawing + ', "' + K40 + '", "' + K41 + '", "' + K31 + '", "' + K32 +
          '", "' + K33 + '", "' + K34 + '", "' + PercentTransport + '", "' + PercentTransportEquipment +
          '", "' + VAT + '", "' + IdStavka + '");';
        ExecSQL;
        SQL.Text := 'select LAST_INSERT_ID() as ID';
        Active := True;
        IdEstimate := FieldByName('ID').AsInteger;
        Active := False;
        case TypeEstimate of
          1:
            begin
              SQL.Text :=
                'INSERT INTO smetasourcedata (sm_type, obj_id, parent_local_id, parent_ptm_id, name, date, sm_number, '
                + 'chapter, row_number, preparer, post_preparer, examiner, post_examiner, set_drawings, k40, k41, k31, k32, '
                + 'k33, k34, coef_tr_zatr, coef_tr_obor, nds, stavka_id) Value("' + IntToStr(3) + '", "' +
                IntToStr(IdObject) + '", 0, ' + IntToStr(IdEstimate) + ', "", "' + DateCompose + '", "Ж000", '
                + NumberChapter + ', ' + NumberRow + ', ' + Compose + ', ' + PostCompose + ', ' + Checked +
                ', ' + PostChecked + ', ' + SetDrawing + ', "' + K40 + '", "' + K41 + '", "' + K31 + '", "' +
                K32 + '", "' + K33 + '", "' + K34 + '", "' + PercentTransport + '", "' +
                PercentTransportEquipment + '", "' + VAT + '", "' + IdStavka + '");';
              ExecSQL;
            end;
          { 2:
            begin
            SQL.Text :=
            'INSERT INTO smetasourcedata (sm_type, obj_id, parent_local_id, parent_ptm_id, name, date, sm_number, '
            + 'chapter, row_number, preparer, post_preparer, examiner, post_examiner, set_drawings, k40, k41, k31, k32, '
            + 'k33, k34, coef_tr_zatr, coef_tr_obor, nds, stavka_id) Value("' + IntToStr(TypeEstimate) +
            '", "' + IntToStr(IdObject) + '", GetParentLocal(' + IntToStr(IdParentLocal) +
            '), GetParentPTM(' + IntToStr(IdEstimate) + '), ' + NameEstimate + ', "' + DateCompose +
            '", "' + EditNumberEstimate.Text + '", ' + NumberChapter + ', ' + NumberRow + ', ' + Compose +
            ', ' + PostCompose + ', ' + Checked + ', ' + PostChecked + ', ' + SetDrawing + ', "' + K40 +
            '", "' + K41 + '", "' + K31 + '", "' + K32 + '", "' + K33 + '", "' + K34 + '", "' +
            PercentTransport + '", "' + PercentTransportEquipment + '", "' + VAT + '", "' +
            IdStavka + '");';
            ExecSQL;
            SQL.Text := 'select LAST_INSERT_ID() as ID';
            Active := True;
            IdEstimateLocal := FieldByName('ID').AsInteger;
            Active := False;
            SQL.Text :=
            'INSERT INTO smetasourcedata (sm_type, obj_id, parent_local_id, parent_ptm_id, name, date, sm_number, '
            + 'chapter, row_number, preparer, post_preparer, examiner, post_examiner, set_drawings, k40, k41, k31, k32, '
            + 'k33, k34, coef_tr_zatr, coef_tr_obor, nds, stavka_id) Value("' + IntToStr(TypeEstimate) +
            '", "' + IntToStr(IdObject) + '", GetParentLocal(' + IntToStr(IdParentLocal) +
            '), GetParentPTM(' + IntToStr(IdEstimate) + '), ' + NameEstimate + ', "' + DateCompose +
            '", "' + EditNumberEstimate.Text + '", ' + NumberChapter + ', ' + NumberRow + ', ' + Compose +
            ', ' + PostCompose + ', ' + Checked + ', ' + PostChecked + ', ' + SetDrawing + ', "' + K40 +
            '", "' + K41 + '", "' + K31 + '", "' + K32 + '", "' + K33 + '", "' + K34 + '", "' +
            PercentTransport + '", "' + PercentTransportEquipment + '", "' + VAT + '", "' +
            IdStavka + '");';
            ExecSQL;
            end; }
        end;
        ModalResult := mrOk;
      end;
    end;
  except
    on E: Exception do
    begin
      MessageBox(0, PChar('При сохранении данных возникла ошибка:' + #13#10 + E.Message), PWideChar(Caption),
        MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
  end;
end;

procedure TFormCardEstimate.ClearAllFields;
begin
  EditNumberChapter.Text := '';
  EditNumberRow.Text := '';
  EditNameEstimate.Text := '';
  EditNameEstimate.Color := clWindow;
  EditCompose.Text := '';
  EditPostCompose.Text := '';
  EditChecked.Text := '';
  EditPostChecked.Text := '';
  EditSetDrawing.Text := '';
end;

procedure TFormCardEstimate.ComboBoxChange(Sender: TObject);
var
  str: string;
begin
  str := Copy(ComboBoxPart.Text, 1, Pos('.', ComboBoxPart.Text) - 1);
  EditNumberEstimate.Text := 'Ж' + str;
  str := Copy(ComboBoxSection.Text, 1, Pos('.', ComboBoxSection.Text) - 1);
  EditNumberEstimate.Text := EditNumberEstimate.Text + str;
  str := Copy(ComboBoxTypeWork.Text, 1, Pos('.', ComboBoxTypeWork.Text) - 1);

  if str = '' then
    str := '0';

  EditNumberEstimate.Text := EditNumberEstimate.Text + str;

  // ----------------------------------------
  str := ComboBoxPart.Text;
  Delete(str, 1, Pos('.', str) + 1);

  EditNameEstimate.Text := str;

  str := ComboBoxSection.Text;
  Delete(str, 1, Pos('.', str) + 1);

  EditNameEstimate.Text := EditNameEstimate.Text + str;

  str := ComboBoxTypeWork.Text;
  Delete(str, 1, Pos('.', str) + 1);

  EditNameEstimate.Text := EditNameEstimate.Text + str;
end;

procedure TFormCardEstimate.CreateNumberEstimate;
var
  NumberEstimate, str: String;
begin
  if (TypeEstimate = 1) or (TypeEstimate = 3) then
    try
      with qrTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT sm_number FROM smetasourcedata WHERE sm_id = :sm_id;');
        ParamByName('sm_id').Value := IdEstimate;
        Active := True;

        NumberEstimate := FieldByName('sm_number').AsVariant;
      end;
    except
      on E: Exception do
        MessageBox(0, PChar('При получении номера сметы возникла ошибка:' + sLineBreak + E.Message),
          PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
    end;

  // ----------------------------------------

  case TypeEstimate of
    1:
      begin
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('SELECT max(sm_number) as "MaxNumber" FROM smetasourcedata WHERE sm_type = 1 and sm_number LIKE "'
              + NumberEstimate + '%" and obj_id = ' + IntToStr(IdObject) + ';');
            Active := True;

            if FieldByName('MaxNumber').AsVariant <> NULL then
              str := FieldByName('MaxNumber').AsVariant
            else
              str := '0';
          end;
        except
          on E: Exception do
            MessageBox(0, PChar('При запросе номера последней ЛОКАЛЬНОЙ сметы возникла ошибка:' + sLineBreak +
              E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
        end;

        // Удаляем в строке всё что стоит до последней точки, включая точку
        while Pos('.', str) > 0 do
          Delete(str, 1, 1);

        EditNumberEstimate.Text := NumberEstimate + '.' + IntToStr(StrToInt(str) + 1);
        EditNameEstimate.Text := 'Локальная смета №' + IntToStr(StrToInt(str) + 1);
      end;
    2: // ОБЪЕКТНАЯ смета
      begin
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('SELECT max(sm_number) as "MaxNumber" FROM smetasourcedata WHERE sm_type = 2 and sm_number LIKE "'
              + NumberEstimate + '%" and obj_id = ' + IntToStr(IdObject) + ';');
            Active := True;

            if FieldByName('MaxNumber').AsVariant <> NULL then
              str := FieldByName('MaxNumber').AsVariant
            else
              str := '0';
          end;
        except
          on E: Exception do
            MessageBox(0, PChar('При получении номера последней ОБЪЕКТНОЙ сметы возникла ошибка:' + sLineBreak
              + E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
        end;

        // Удаляем в строке всё что стоит до последней точки, включая точку
        while Pos('.', str) > 0 do
          Delete(str, 1, 1);

        EditNumberEstimate.Text := IntToStr(StrToInt(str) + 1);
        EditNameEstimate.Text := 'Объектная смета №' + IntToStr(StrToInt(str) + 1);
      end;
    3: // ПТМ смета
      begin
        {
          try
          with ADOQueryTemp do
          begin
          Active := False;
          SQL.Clear;
          SQL.Add('SELECT max(sm_number) as "MaxNumber" FROM smetasourcedata WHERE sm_type = 3 and sm_number LIKE "Ж'
          + NumberEstimate + '%" and obj_id = ' + IntToStr(IdObject) + ';');
          Active := True;

          if FieldByName('MaxNumber').AsVariant <> NULL then
          Str := FieldByName('MaxNumber').AsVariant
          else
          Str := '0';
          end;
          except
          on E: Exception do
          MessageBox(0, PChar('При запросе номера последней ПТМ сметы возникла ошибка:' + sLineBreak + E.Message),
          CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
          end;

          // Удаляем в строке всё что стоит до последней точки, включая точку
          while Pos('.', Str) > 0 do
          delete(Str, 1, 1);

          EditNumberEstimate.Text := 'Ж' + NumberEstimate + '.' + IntToStr(StrToInt(Str) + 1);
        }

        str := Copy(ComboBoxPart.Text, 1, Pos('.', ComboBoxPart.Text) - 1);
        EditNumberEstimate.Text := 'Ж' + str;
        str := Copy(ComboBoxSection.Text, 1, Pos('.', ComboBoxSection.Text) - 1);
        EditNumberEstimate.Text := EditNumberEstimate.Text + str;
        str := Copy(ComboBoxTypeWork.Text, 1, Pos('.', ComboBoxTypeWork.Text) - 1);

        if str = '' then
          str := '0';

        EditNumberEstimate.Text := EditNumberEstimate.Text + str;
        ComboBoxChange(nil);
      end;
  end;
end;

function TFormCardEstimate.GetIdNewEstimate: Integer;
begin
  Result := 0;
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT LAST_INSERT_ID() as LastIdEstimate;');
      Active := True;

      Result := FieldByName('LastIdEstimate').AsInteger;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении Id только что вставленной сметы возникла ошибка:' + sLineBreak +
        E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCardEstimate.GetParts;
begin
  ComboBoxPart.Items.Clear;

  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM parts_estimates ORDER BY 2, 3;');
      Active := True;
      First;

      while not Eof do
      begin
        ComboBoxPart.Items.Add(IntToStr(FieldByName('code').AsInteger) + '. ' + FieldByName('name').AsString);
        Next;
      end;

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении списка всех частей возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCardEstimate.GetSections;
begin
  ComboBoxSection.Items.Clear;

  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM sections_estimates ORDER BY 2, 3;');
      Active := True;
      First;

      while not Eof do
      begin
        ComboBoxSection.Items.Add(IntToStr(FieldByName('code').AsInteger) + '. ' + FieldByName('name')
          .AsString);
        Next;
      end;

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении списка всех разделов возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCardEstimate.GetTypeWorks;
begin
  ComboBoxTypeWork.Items.Clear;
  ComboBoxTypeWork.Items.Add('');

  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM types_works ORDER BY 2, 3;');
      Active := True;
      First;

      while not Eof do
      begin
        ComboBoxTypeWork.Items.Add(IntToStr(FieldByName('code').AsInteger) + '. ' + FieldByName('name')
          .AsString);
        Next;
      end;

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении списка всех видов работ возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

end.
