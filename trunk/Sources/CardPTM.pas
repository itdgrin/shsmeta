unit CardPTM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, DB,
  DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFormCardPTM = class(TForm)
    PanelObject: TPanel;
    LabelObject: TLabel;
    PanelCountAndUnit: TPanel;
    LabelCount: TLabel;
    PanelPTMAndName: TPanel;
    LabelPTM: TLabel;
    PanelPart: TPanel;
    LabelPart: TLabel;
    PanelEstimate: TPanel;
    LabelEstimate: TLabel;
    EditObject: TEdit;
    EditEstimate: TEdit;
    EditPTM: TEdit;
    LabelName: TLabel;
    EditName: TEdit;
    EditCount: TEdit;
    LabelUnit: TLabel;
    EditUnit: TEdit;
    ButtonCancel: TButton;
    Bevel1: TBevel;
    ButtonSave: TButton;
    PanelTypeWork: TPanel;
    LabelTypeWork: TLabel;
    ComboBoxTypeWork: TComboBox;
    PanelSection: TPanel;
    LabelSection: TLabel;
    ComboBoxSection: TComboBox;
    ComboBoxPart: TComboBox;
    ADOQueryTemp: TFDQuery;

    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);

    procedure ShowForm(const vIdEstimate: Integer);

    procedure GetObject;
    procedure GetEstimate;
    procedure GetParts;
    procedure GetSections;
    procedure GetTypeWorks;

    function GetIdPart(): Integer;
    function GetIdSection(): Integer;
    function GetIdTypeWork(): Integer;

  private
    IdEstimate: Integer;

  public

  end;

var
  FormCardPTM: TFormCardPTM;

implementation

uses Main, DataModule;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardPTM.FormShow(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  GetObject;
  GetEstimate;
  GetParts;
  GetSections;
  GetTypeWorks;

  EditPTM.Text := '';
  EditName.Text := '';
  EditCount.Text := '';
  EditUnit.Text := '';

  ComboBoxPart.SetFocus; // Устанавливаем фокус
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardPTM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardPTM.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ButtonSave.Tag = 0 then
    if MessageBox(0, PChar('Закрыть окно без сохранения?'), PWideChar(Caption),
      MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrYes then
      CanClose := True
    else
      CanClose := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardPTM.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardPTM.ButtonSaveClick(Sender: TObject);
var
  IdPart, IdSection, IdTypeWork: Integer;
  str: string;
begin
  IdPart := GetIdPart;
  IdSection := GetIdSection;
  IdTypeWork := GetIdTypeWork;

  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('INSERT INTO card_ptm (id_estimate, part_id, section_id, type_work_id, ptm, name, count, unit) '
        + 'VALUE (:id_estimate, :part_id, :section_id, :type_work_id, :ptm, :name, :count, :unit);');
      str := SQL.Text;
      ParamByName('id_estimate').Value := IdEstimate;
      ParamByName('ptm').Value := EditPTM.Text;
      ParamByName('name').Value := EditName.Text;
      ParamByName('count').Value := StrToFloat(EditCount.Text);
      ParamByName('unit').Value := EditUnit.Text;
      ParamByName('part_id').Value := IdPart;
      ParamByName('section_id').Value := IdSection;
      ParamByName('type_work_id').Value := IdTypeWork;
      ExecSQL;
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При добавлении новой ПТМ в таблицу возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  ButtonSave.Tag := 1;
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardPTM.ShowForm(const vIdEstimate: Integer);
begin
  IdEstimate := vIdEstimate;
  ShowModal;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardPTM.GetObject;
begin
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT num, name FROM objcards WHERE obj_id = (SELECT obj_id FROM smetasourcedata WHERE sm_id = :sm_id);');
      ParamByName('sm_id').Value := IdEstimate;
      Active := True;
      EditObject.Text := IntToStr(FieldByName('num').AsInteger) + ' ' + FieldByName('name').AsString;
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении номера и названия объекта возникла ошибка:' + sLineBreak + sLineBreak
        + E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardPTM.GetEstimate;
begin
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT sm_number, name FROM smetasourcedata WHERE sm_id = :sm_id;');
      ParamByName('sm_id').Value := IdEstimate;
      Active := True;
      EditEstimate.Text := FieldByName('sm_number').AsString + ' ' + FieldByName('name').AsString;
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении номера и названия сметы возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardPTM.GetParts;
begin
  // SELECT id, code, cast(concat(code, ". " ,name) as char(1024)) as name FROM parts_estimates ORDER BY 2;
  {
    with DBLookupComboBoxPart do
    begin
    ListSource := DataSource1;
    ListField := 'name';
    KeyField := 'id';
    end;
  }

  ComboBoxPart.Items.Clear;

  try
    with ADOQueryTemp do
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

  ComboBoxPart.ItemIndex := 0;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardPTM.GetSections;
begin
  ComboBoxSection.Items.Clear;

  try
    with ADOQueryTemp do
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

  ComboBoxSection.ItemIndex := 0;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardPTM.GetTypeWorks;
begin
  ComboBoxTypeWork.Items.Clear;

  try
    with ADOQueryTemp do
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

  ComboBoxTypeWork.ItemIndex := 0;
end;

// ---------------------------------------------------------------------------------------------------------------------

function TFormCardPTM.GetIdPart(): Integer;
begin
  Result := 0;
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT id FROM parts_estimates ORDER BY code, name LIMIT ' + IntToStr(ComboBoxPart.ItemIndex)
        + ', 1;');
      Active := True;
      Result := FieldByName('id').AsInteger;
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении Id части возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

function TFormCardPTM.GetIdSection(): Integer;
begin
  Result := 0;
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT id FROM sections_estimates ORDER BY code, name LIMIT ' +
        IntToStr(ComboBoxSection.ItemIndex) + ', 1;');
      Active := True;
      Result := FieldByName('id').AsInteger;
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении Id раздела возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

function TFormCardPTM.GetIdTypeWork(): Integer;
begin
  Result := 0;
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT id FROM types_works ORDER BY code, name LIMIT ' + IntToStr(ComboBoxTypeWork.ItemIndex)
        + ', 1;');
      Active := True;
      Result := FieldByName('id').AsInteger;
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении Id вида работы возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
