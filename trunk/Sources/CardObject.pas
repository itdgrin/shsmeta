unit CardObject;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls,
  DBCtrls, DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.Menus;

type
  TFormCardObject = class(TForm)

    DataSourceSF: TDataSource;
    DataSourceCl: TDataSource;
    DataSourceC: TDataSource;
    DataSourceCO: TDataSource;
    DataSourceR: TDataSource;
    DataSourceZP: TDataSource;
    GroupBoxObject: TGroupBox;
    GroupBoxContract: TGroupBox;
    GroupBoxShortDescription: TGroupBox;
    GroupBoxFullDescription: TGroupBox;
    GroupBoxDateBuilding: TGroupBox;
    GroupBoxSourseFinance: TGroupBox;
    GroupBoxClient: TGroupBox;
    GroupBoxContractor: TGroupBox;
    GroupBoxCategoryObject: TGroupBox;
    GroupBoxVAT: TGroupBox;
    GroupBoxRegion: TGroupBox;

    GroupBoxBasePrices: TGroupBox;
    GroupBoxTypeOXR: TGroupBox;
    GroupBoxZonePrices: TGroupBox;
    EditNumberObject: TEdit;
    EditNumberContract: TEdit;
    EditShortDescription: TEdit;
    EditCountMonth: TEdit;

    LabelNumberContract: TLabel;
    Label2: TLabel;
    LabelStartBuilding: TLabel;
    LabelCountMonth: TLabel;

    DateTimePickerDataCreateContract: TDateTimePicker;
    DateTimePickerStartBuilding: TDateTimePicker;

    DBLookupComboBoxSourseFinance: TDBLookupComboBox;
    DBLookupComboBoxCategoryObject: TDBLookupComboBox;
    DBLookupComboBoxZonePrices: TDBLookupComboBox;
    DBLookupComboBoxTypeOXR: TDBLookupComboBox;
    DBLookupComboBoxBasePrices: TDBLookupComboBox;
    DBLookupComboBoxRegion: TDBLookupComboBox;
    DBLookupComboBoxClient: TDBLookupComboBox;
    DBLookupComboBoxContractor: TDBLookupComboBox;

    ButtonListAgreements: TButton;
    ButtonSave: TButton;
    ButtonCancel: TButton;

    MemoFullDescription: TMemo;
    ComboBoxVAT: TComboBox;
    DataSourceBP: TDataSource;
    DataSourceTO: TDataSource;
    DataSourceDifferent: TDataSource;
    LabelNumberObject: TLabel;
    LabelCodeObject: TLabel;
    EditCodeObject: TEdit;
    Bevel1: TBevel;
    CheckBoxCalculationEconom: TCheckBox;
    ADOQueryDifferent: TFDQuery;
    ADOQuerySF: TFDQuery;
    ADOQueryC: TFDQuery;
    ADOQueryCl: TFDQuery;
    ADOQueryCO: TFDQuery;
    ADOQueryBP: TFDQuery;
    ADOQueryTO: TFDQuery;
    ADOQueryR: TFDQuery;
    ADOQueryZP: TFDQuery;
    GroupBox1: TGroupBox;
    DBLookupComboBoxMAIS: TDBLookupComboBox;
    ADOQueryMAIS: TFDQuery;
    DataSourceMAIS: TDataSource;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    dbedtPER_TEPM_BUILD: TDBEdit;
    dbedtPER_TEMP_BUILD_BACK: TDBEdit;
    dbedtPER_CONTRACTOR: TDBEdit;
    qrMain: TFDQuery;
    dsMain: TDataSource;
    pm1: TPopupMenu;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);

    procedure EditNumberObjectKeyPress(Sender: TObject; var Key: Char);

    procedure EditingRecord(const Value: Boolean);
    procedure SetIdSelectRow(const Value: Integer);
    procedure SetSourceFinance(const Value: Integer);
    procedure SetClient(const Value: Integer);
    procedure SetContractor(const Value: Integer);
    procedure SetCategory(const Value: Integer);
    procedure SetRegion(const Value: Integer);
    procedure SetVAT(const Value: Integer);
    procedure SetBasePrice(const Value: Integer);
    procedure SetTypeOXR(const Value: Integer);
    procedure SetMAIS(const Value: Integer);

    procedure SetColorDefaultToFields;
    procedure ClearAllFields;

    procedure GetValueDBLookupComboBoxTypeOXR(Sender: TObject);
    procedure N1Click(Sender: TObject);

  private
    Editing: Boolean; // ��� ������������ ������ ���������� ��� �������������� ������
    IdObject: Integer; // ID ���������� ������ � �������

    StrQuery: String;

    // -----------------------------------------

    // ��� ��������� �������� � ���������� ������� ��� �������������� ������

    SourceFinance: Integer;
    Client: Integer;
    Contractor: Integer;
    CategoryObject: Integer;
    Region: Integer;
    VAT: Integer;
    BasePrice: Integer;
    TypeOXR: Integer;
    MAIS: Integer;

    // ---------------------------------------

  public

  end;

const
  CaptionForm = '�������� �������';

var
  FormCardObject: TFormCardObject;

implementation

uses Main, DataModule, Tools;

{$R *.dfm}

procedure TFormCardObject.FormCreate(Sender: TObject);
begin
  with Constraints do
  begin
    MinHeight := Height;
    MaxHeight := Height;
    MinWidth := Width;
    MaxWidth := Width;
  end;

  Caption := CaptionForm;

  Editing := False;
end;

procedure TFormCardObject.FormShow(Sender: TObject);
begin
  grp1.Enabled := False;
  dbedtPER_TEPM_BUILD.Enabled := False;
  dbedtPER_TEMP_BUILD_BACK.Enabled := False;
  dbedtPER_CONTRACTOR.Enabled := False;

  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  qrMain.ParamByName('OBJ_ID').AsInteger := IdObject;
  CloseOpen(qrMain);

  // ������������� �����
  if EditCodeObject.Focused then
    EditCodeObject.SetFocus;

  ButtonSave.Tag := 0;

  // -----------------------------------------

  SetColorDefaultToFields; // ������������� ��������� ���� ����� ��������������

  // ������� ����� �����
  if not Editing then
    ClearAllFields;

  if not Editing then
    try
      with ADOQueryDifferent do
      begin

        Active := False;
        SQL.Clear;

        StrQuery := 'SELECT max(num) as "MaxNumber", count(*) as "CountObject" FROM objcards;';

        SQL.Add(StrQuery);
        Active := True;

        if FieldByName('CountObject').AsVariant > 0 then
          EditNumberObject.Text := IntToStr(FieldByName('MaxNumber').AsVariant + 1)
        else
          EditNumberObject.Text := '1';
      end;
    except
      on E: Exception do
        MessageBox(0, PChar('��� ������������ ������ ������� �������� ������:' + sLineBreak + E.Message),
          CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;;

  // �������� ��������������

  try
    with ADOQuerySF do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM istfin;');
      Active := True;
    end;

    with DBLookupComboBoxSourseFinance do
    begin
      ListSource := DataSourceSF;
      ListField := 'name';
      KeyField := 'fin_id';
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� ������ ��������� �������������� �������� ������:' + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ��������

  try
    with ADOQueryCl do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM clients;');
      Active := True;
    end;

    with DBLookupComboBoxClient do
    begin
      ListSource := DataSourceCl;
      ListField := 'full_name';
      KeyField := 'client_id';
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� ������ ��������� �������� ������:' + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ������������

  try
    with ADOQueryC do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM clients;');
      Active := True;
    end;

    with DBLookupComboBoxContractor do
    begin
      ListSource := DataSourceC;
      ListField := 'full_name';
      KeyField := 'client_id';
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� ������ ������������� �������� ������:' + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ��������� �������

  try
    with ADOQueryCO do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM objcategory;');
      Active := True;
    end;

    with DBLookupComboBoxCategoryObject do
    begin
      ListSource := DataSourceCO;
      ListField := 'cat_name';
      KeyField := 'cat_id';
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� ������ ��������� ������� �������� ������:' + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ������

  try
    with ADOQueryR do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM regions;');
      Active := True;
    end;

    with DBLookupComboBoxRegion do
    begin
      ListSource := DataSourceR;
      ListField := 'region_name';
      KeyField := 'region_id';
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� ������ �������� �������� ������:' + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ���� ��������

  try
    with ADOQueryBP do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM baseprices;');
      Active := True;
    end;

    with DBLookupComboBoxBasePrices do
    begin
      ListSource := DataSourceBP;
      ListField := 'base_name';
      KeyField := 'base_id';
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� ������ ��� �������� �������� ������:' + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ���� ��������

  try
    with ADOQueryZP do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM objregion;');
      Active := True;
    end;

    with DBLookupComboBoxZonePrices do
    begin
      ListSource := DataSourceZP;
      ListField := 'region';
      KeyField := 'obj_region_id';
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� ������ ��� �������� �������� ������:' + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  try
    with ADOQueryMAIS do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM mais;');
      Active := True;
    end;

    with DBLookupComboBoxMAIS do
    begin
      ListSource := DataSourceMAIS;
      ListField := 'NAME';
      KeyField := 'MAIS_ID';
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� ������ ������ �������� ������:' + sLineBreak + E.Message), CaptionForm,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  // ���������� ��������� �������� � ���������� �������
  if Editing then
  begin
    DBLookupComboBoxSourseFinance.KeyValue := SourceFinance;
    DBLookupComboBoxClient.KeyValue := Client;
    DBLookupComboBoxContractor.KeyValue := Contractor;
    DBLookupComboBoxCategoryObject.KeyValue := CategoryObject;
    DBLookupComboBoxRegion.KeyValue := Region;
    ComboBoxVAT.ItemIndex := VAT;
    DBLookupComboBoxBasePrices.KeyValue := BasePrice;
    DBLookupComboBoxMAIS.KeyValue := MAIS;

    try
      with ADOQueryDifferent do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT obj_region FROM objstroj WHERE stroj_id = ' + IntToStr(TypeOXR) + ';');
        Active := True;
      end;

      DBLookupComboBoxZonePrices.KeyValue := DataSourceDifferent.DataSet.FieldByName('obj_region').AsVariant;
    except
      on E: Exception do
        MessageBox(0, PChar('��� ��������� �������� � ���� �������� �������� ������:' + sLineBreak +
          E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;

    GetValueDBLookupComboBoxTypeOXR(nil);

    DBLookupComboBoxTypeOXR.KeyValue := TypeOXR;
  end;
end;

procedure TFormCardObject.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ButtonSave.Tag = 0 then
    if MessageBox(0, PChar('������� ���� ��� ����������?'), CaptionForm, MB_ICONINFORMATION + MB_YESNO +
      mb_TaskModal) = mrYes then
      CanClose := True
    else
      CanClose := False;
end;

procedure TFormCardObject.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Editing := False;
end;

procedure TFormCardObject.ButtonSaveClick(Sender: TObject);
var
  NumberObject, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19: string;
  CountField: Integer;
begin
  CountField := 0;
  // �������� ����� �� ���� ������ ��������

  SetColorDefaultToFields;

  NumberObject := EditNumberObject.Text;

  // ���� �������
  if EditCodeObject.Text <> '' then
    v17 := EditCodeObject.Text
  else
  begin
    v17 := '';
    // EditCodeObject.Color := ColorWarningField;
    // Inc(CountField);
  end;

  // ����� ��������
  if EditNumberContract.Text <> '' then
    v2 := EditNumberContract.Text
  else
  begin
    v2 := '';
    // EditNumberContract.Color := ColorWarningField;
    // Inc(CountField);
  end;

  // ���� ���������� ��������
  DateTimeToString(v3, 'yyyy-mm-dd', DateTimePickerDataCreateContract.Date);

  // ������ �������������� ����������
  v4 := '0'; // ???????????????????????

  // ������ ������������ �������
  if MemoFullDescription.Text <> '' then
    v5 := MemoFullDescription.Text
  else
  begin
    v5 := '';
    // MemoFullDescription.Color := ColorWarningField;
    // Inc(CountField);
  end;

  // ������� ������������ �������
  if EditShortDescription.Text <> '' then
    v6 := EditShortDescription.Text
  else
  begin
    v6 := '';
    // EditShortDescription.Color := ColorWarningField;
    // Inc(CountField);
  end;

  // ���� ������ �������������
  DateTimeToString(v7, 'yyyy-mm-dd', DateTimePickerStartBuilding.Date);

  // ���� ������������� (������)
  if EditCountMonth.Text <> '' then
    v8 := EditCountMonth.Text
  else
  begin
    v8 := 'Null';
    // EditCountMonth.Color := ColorWarningField;
    // Inc(CountField);
  end;

  // �������� ��������������
  if DBLookupComboBoxSourseFinance.KeyValue <> Null then
    v9 := DBLookupComboBoxSourseFinance.KeyValue
  else
  begin
    v9 := 'Null';
    // DBLookupComboBoxSourseFinance.Color := ColorWarningField;
    // Inc(CountField);
  end;

  // ��������
  if DBLookupComboBoxClient.KeyValue <> Null then
    v10 := DBLookupComboBoxClient.KeyValue
  else
  begin
    v10 := 'Null';
    // DBLookupComboBoxClient.Color := ColorWarningField;
    // Inc(CountField);
  end;

  // ������������
  if DBLookupComboBoxContractor.KeyValue <> Null then
    v11 := DBLookupComboBoxContractor.KeyValue
  else
  begin
    v11 := 'Null';
    // DBLookupComboBoxContractor.Color := ColorWarningField;
    // Inc(CountField);
  end;

  // ��������� �������
  if DBLookupComboBoxCategoryObject.KeyValue <> Null then
    v12 := DBLookupComboBoxCategoryObject.KeyValue
  else
  begin
    DBLookupComboBoxCategoryObject.Color := ColorWarningField;
    Inc(CountField);
  end;

  // �/��� ���
  v13 := IntToStr(ComboBoxVAT.ItemIndex);

  // ������
  if DBLookupComboBoxRegion.KeyValue <> Null then
    v14 := DBLookupComboBoxRegion.KeyValue
  else
  begin
    DBLookupComboBoxRegion.Color := ColorWarningField;
    Inc(CountField);
  end;

  // ���� ��������
  with DBLookupComboBoxBasePrices do
    if KeyValue <> Null then
      v15 := KeyValue
    else
    begin
      Color := ColorWarningField;
      Inc(CountField);
    end;

  // ���� ��������
  with DBLookupComboBoxZonePrices do
    if KeyValue = Null then
    begin
      Color := ColorWarningField;
      Inc(CountField);
    end;

  // ��� ��� � ��� � ���� �������
  with DBLookupComboBoxTypeOXR do
    if KeyValue <> Null then
      v16 := KeyValue
    else
    begin
      Color := ColorWarningField;
      Inc(CountField);
    end;

  with DBLookupComboBoxMAIS do
    if KeyValue <> Null then
      v19 := KeyValue
    else
    begin
      Color := ColorWarningField;
      Inc(CountField);
    end;

  // ������ ���. ��������
  if CheckBoxCalculationEconom.Checked then
    v18 := '1'
  else
    v18 := '0';

  if CountField > 0 then
  begin
    MessageBox(0, PChar('�� ��������� �� ��� ����!' + sLineBreak +
      '���� ���������� ������� �� ��������� ��� ��������� �����������.'), CaptionForm,
      MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;

  try
    with DM.qrDifferent do
    begin
      Active := False;
      SQL.Clear;

      if Editing then
        SQL.Add('UPDATE objcards SET num = "' + NumberObject + '", num_dog = "' + v2 + '", date_dog = "' + v3
          + '", agr_list = "' + v4 + '", full_name = "' + v5 + '", name = "' + v6 + '", beg_stroj = "' + v7 +
          '", srok_stroj = ' + v8 + ', ' + ' fin_id = ' + v9 + ', cust_id = ' + v10 + ', general_id = ' + v11
          + ', cat_id = "' + v12 + '", state_nds = "' + v13 + '", region_id = "' + v14 + '", base_norm_id = "'
          + v15 + '", stroj_id = "' + v16 + '", encrypt = "' + v17 + '", calc_econom = "' + v18 +
          '", MAIS_ID = "' + v19 +
          '", PER_TEPM_BUILD=:PER_TEPM_BUILD, PER_CONTRACTOR=:PER_CONTRACTOR, PER_TEMP_BUILD_BACK=:PER_TEMP_BUILD_BACK WHERE obj_id = "'
          + IntToStr(IdObject) + '";')
      else
        SQL.Add('INSERT INTO objcards (num, num_dog, date_dog, agr_list, full_name, name, beg_stroj, srok_stroj, '
          + ' fin_id, cust_id, general_id, cat_id, state_nds, region_id, base_norm_id, stroj_id, encrypt,' +
          ' calc_econom, MAIS_ID, PER_TEPM_BUILD, PER_CONTRACTOR, PER_TEMP_BUILD_BACK) ' + 'VALUE ("' +
          NumberObject + '", "' + v2 + '", "' + v3 + '", "' + v4 + '", "' + v5 + '", "' + v6 + '", "' + v7 +
          '", ' + v8 + ', ' + v9 + ', ' + v10 + ', ' + v11 + ', "' + v12 + '", "' + v13 + '", "' + v14 +
          '", "' + v15 + '", "' + v16 + '", "' + v17 + '", "' + v18 + '", "' + v19 +
          '", :PER_TEPM_BUILD, :PER_CONTRACTOR, :PER_TEMP_BUILD_BACK);');

      ParamByName('PER_TEPM_BUILD').Value := qrMain.FieldByName('PER_TEPM_BUILD').Value;
      ParamByName('PER_CONTRACTOR').Value := qrMain.FieldByName('PER_CONTRACTOR').Value;
      ParamByName('PER_TEMP_BUILD_BACK').Value := qrMain.FieldByName('PER_TEMP_BUILD_BACK').Value;
      ExecSQL;
    end;

    ButtonSave.Tag := 1;
    qrMain.Close;
    Close;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ���������� ������ �������� ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCardObject.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCardObject.EditNumberObjectKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> #8 then
    if (Key < '0') or (Key > '9') then // ��������� ���� �������� ����� ����
      Key := #0;
end;

procedure TFormCardObject.EditingRecord(const Value: Boolean);
begin
  Editing := Value;
end;

procedure TFormCardObject.SetIdSelectRow(const Value: Integer);
begin
  IdObject := Value;
end;

procedure TFormCardObject.SetSourceFinance(const Value: Integer);
begin
  SourceFinance := Value;
end;

procedure TFormCardObject.SetClient(const Value: Integer);
begin
  Client := Value;
end;

procedure TFormCardObject.SetContractor(const Value: Integer);
begin
  Contractor := Value;
end;

procedure TFormCardObject.SetCategory(const Value: Integer);
begin
  CategoryObject := Value;
end;

procedure TFormCardObject.SetRegion(const Value: Integer);
begin
  Region := Value;
end;

procedure TFormCardObject.SetVAT(const Value: Integer);
begin
  VAT := Value;
end;

procedure TFormCardObject.SetBasePrice(const Value: Integer);
begin
  BasePrice := Value;
end;

procedure TFormCardObject.SetTypeOXR(const Value: Integer);
begin
  TypeOXR := Value;
end;

procedure TFormCardObject.SetMAIS(const Value: Integer);
begin
  MAIS := Value;
end;

procedure TFormCardObject.SetColorDefaultToFields;
begin
  EditCodeObject.Color := clWindow;
  EditNumberContract.Color := clWindow;
  EditShortDescription.Color := clWindow;
  MemoFullDescription.Color := clWindow;
  EditCountMonth.Color := clWindow;
  DBLookupComboBoxSourseFinance.Color := clWindow;
  DBLookupComboBoxClient.Color := clWindow;
  DBLookupComboBoxContractor.Color := clWindow;
  DBLookupComboBoxCategoryObject.Color := clWindow;
  DBLookupComboBoxRegion.Color := clWindow;
  DBLookupComboBoxZonePrices.Color := clWindow;
  DBLookupComboBoxBasePrices.Color := clWindow;
  DBLookupComboBoxTypeOXR.Color := clWindow;
  DBLookupComboBoxMAIS.Color := clWindow;
end;

procedure TFormCardObject.ClearAllFields;
begin
  EditCodeObject.Text := '';
  EditNumberContract.Text := '';
  EditShortDescription.Text := '';
  MemoFullDescription.Text := '';
  EditCountMonth.Text := '';
  CheckBoxCalculationEconom.Checked := False;
  DateTimePickerDataCreateContract.Date := Now;
  DateTimePickerStartBuilding.Date := Now;
  DBLookupComboBoxSourseFinance.KeyValue := Null;
  DBLookupComboBoxClient.KeyValue := Null;
  DBLookupComboBoxContractor.KeyValue := Null;
  DBLookupComboBoxCategoryObject.KeyValue := Null;
  DBLookupComboBoxRegion.KeyValue := Null;
  DBLookupComboBoxZonePrices.KeyValue := Null;
  DBLookupComboBoxBasePrices.KeyValue := Null;
  DBLookupComboBoxTypeOXR.KeyValue := Null;
  DBLookupComboBoxMAIS.KeyValue := Null;
end;

procedure TFormCardObject.GetValueDBLookupComboBoxTypeOXR(Sender: TObject);
var
  IdRegion: Integer;
  IdCategory: Integer;
begin
  if (DBLookupComboBoxCategoryObject.KeyValue = Null) or (DBLookupComboBoxZonePrices.KeyValue = Null) then
    Exit;

  // ��� ��� � ��� � ���� �������

  IdRegion := DBLookupComboBoxZonePrices.KeyValue;
  IdCategory := DBLookupComboBoxCategoryObject.KeyValue;

  try
    with ADOQueryTO do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM objstroj WHERE obj_region = ' + IntToStr(IdRegion) + ' and obj_category_id = ' +
        IntToStr(IdCategory) + ';');
      Active := True;
    end;

    with DBLookupComboBoxTypeOXR do
    begin
      ListSource := DataSourceTO;
      ListField := 'name';
      KeyField := 'stroj_id';
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� ������ ��� � ��� �������� ������:' + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCardObject.N1Click(Sender: TObject);
begin
  grp1.Enabled := True;
  dbedtPER_TEPM_BUILD.Enabled := True;
  dbedtPER_TEMP_BUILD_BACK.Enabled := True;
  dbedtPER_CONTRACTOR.Enabled := True;
end;

end.
