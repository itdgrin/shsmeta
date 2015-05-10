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

    Bevel: TBevel;
    btnSave: TButton;
    btnClose: TButton;
    PanelPart: TPanel;
    LabelPart: TLabel;
    PanelSection: TPanel;
    LabelSection: TLabel;
    PanelTypeWork: TPanel;
    LabelTypeWork: TLabel;
    qrTemp: TFDQuery;
    qrParts: TFDQuery;
    dsParts: TDataSource;
    qrSections: TFDQuery;
    dsSections: TDataSource;
    qrTypesWorks: TFDQuery;
    dsTypesWorks: TDataSource;
    dblkcbbParts: TDBLookupComboBox;
    dblkcbbSections: TDBLookupComboBox;
    dblkcbbTypesWorks: TDBLookupComboBox;
    qrMain: TFDQuery;
    dsMain: TDataSource;
    dbedtSM_NUMBER: TDBEdit;
    dbedtNAME: TDBEdit;
    dbedtCHAPTER: TDBEdit;
    dbedtROW_NUMBER: TDBEdit;
    dbedtPREPARER: TDBEdit;
    dbedtPOST_PREPARER: TDBEdit;
    dbedtEXAMINER: TDBEdit;
    dbedtPOST_EXAMINER: TDBEdit;
    dbedtSET_DRAWINGS: TDBEdit;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure ShowForm(const vIdObject, vIdEstimate, vTypeEstimate: Integer);
    procedure CreateNumberEstimate;
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EditingRecord(const Value: Boolean);
    function GetIdNewEstimate: Integer;
    procedure ComboBoxChange(Sender: TObject);
    procedure qrPartsAfterScroll(DataSet: TDataSet);

  private
    StrQuery: String;
    Editing: Boolean; // ��� ������������ ������ ���������� ��� �������������� ������
    SkeepEvent: Boolean;

    IdObject: Integer;
    IdEstimate: Integer;
    TypeEstimate: Integer;
  public

  end;

var
  FormCardEstimate: TFormCardEstimate;

implementation

uses Main, DataModule, ObjectsAndEstimates, BasicData, Tools;

{$R *.dfm}

function ReplaceDecimal(var vString: String; const vChar1: Char; const vChar2: Char): String;
var
  p: Integer;
begin
  p := Pos(vChar1, vString);
  if p > 0 then
    vString[p] := vChar2;
  Result := vString;
end;

procedure TFormCardEstimate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Editing := False;
end;

procedure TFormCardEstimate.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if btnSave.Tag = 0 then
    if MessageBox(0, PChar('������� ���� ��� ����������?'), PWideChar(Caption),
      MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrYes then
      CanClose := True
    else
      CanClose := False;
end;

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

procedure TFormCardEstimate.FormShow(Sender: TObject);
begin
  qrMain.Active := False;
  qrMain.ParamByName('SM_ID').AsInteger := IdEstimate;
  qrMain.Active := True;

  dbedtCHAPTER.SetFocus; // ������������� �����

  btnSave.Tag := 0;

  if not Editing then
    qrMain.Append
  else
    qrMain.Edit;
  // ----------------------------------------

  case TypeEstimate of
    1, 2:
      begin
        Caption := '�������� �����';

        PanelPart.Enabled := False;
        PanelSection.Enabled := False;
        PanelTypeWork.Enabled := False;

        LabelPart.Enabled := False;
        LabelSection.Enabled := False;
        LabelTypeWork.Enabled := False;

        dblkcbbParts.Enabled := False;
        dblkcbbSections.Enabled := False;
        dblkcbbTypesWorks.Enabled := False;

        qrParts.Close;
        qrSections.Close;
        qrTypesWorks.Close;
      end;
    3:
      begin
        Caption := '�������� ���';

        PanelPart.Enabled := True;
        PanelSection.Enabled := True;
        PanelTypeWork.Enabled := True;

        LabelPart.Enabled := True;
        LabelSection.Enabled := True;
        LabelTypeWork.Enabled := True;

        dblkcbbParts.Enabled := True;
        dblkcbbSections.Enabled := True;
        dblkcbbTypesWorks.Enabled := True;

        CloseOpen(qrParts);
        CloseOpen(qrSections);
        CloseOpen(qrTypesWorks);
        if not Editing then
        begin
          dblkcbbParts.KeyValue := 0;
          dblkcbbSections.KeyValue := 0;
          dblkcbbTypesWorks.KeyValue := 0;
        end;
        ComboBoxChange(Self);
      end;
  end;

  if not Editing then
    CreateNumberEstimate;

  SkeepEvent := False;
end;

procedure TFormCardEstimate.ShowForm(const vIdObject, vIdEstimate, vTypeEstimate: Integer);
begin
  IdObject := vIdObject;
  IdEstimate := vIdEstimate;
  TypeEstimate := vTypeEstimate;

  SkeepEvent := True;
  if vTypeEstimate = 3 then
    LabelNumberEstimate.Caption := '� ���:'
  else
    LabelNumberEstimate.Caption := '� �����:';
  if ShowModal = mrOk then
    FormBasicData.ShowForm(IdObject, IdEstimate);
end;

procedure TFormCardEstimate.EditingRecord(const Value: Boolean);
begin
  Editing := Value;
end;

procedure TFormCardEstimate.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCardEstimate.btnSaveClick(Sender: TObject);
  procedure addParentEstimate(aParentID, aType: Integer);
  begin
    qrMain.Append;
    qrMain.FieldByName('sm_type').AsInteger := aType;
    qrMain.FieldByName('obj_id').AsInteger := IdObject;
    qrMain.FieldByName('parent_id').AsInteger := aParentID;
    qrTemp.SQL.Text := 'SELECT * FROM smetasourcedata WHERE SM_ID=:SM_ID';
    qrTemp.ParamByName('SM_ID').AsInteger := aParentID;
    qrTemp.Active := True;
    qrMain.FieldByName('k40').Value := qrTemp.FieldByName('k40').Value;
    qrMain.FieldByName('k41').Value := qrTemp.FieldByName('k41').Value;
    qrMain.FieldByName('k31').Value := qrTemp.FieldByName('k31').Value;
    qrMain.FieldByName('k32').Value := qrTemp.FieldByName('k32').Value;
    qrMain.FieldByName('k33').Value := qrTemp.FieldByName('k33').Value;
    qrMain.FieldByName('k34').Value := qrTemp.FieldByName('k34').Value;
    qrMain.FieldByName('k35').Value := qrTemp.FieldByName('k35').Value;
    qrMain.FieldByName('coef_tr_zatr').Value := qrTemp.FieldByName('coef_tr_zatr').Value;
    qrMain.FieldByName('coef_tr_obor').Value := qrTemp.FieldByName('coef_tr_obor').Value;
    qrMain.FieldByName('stavka_id').Value := qrTemp.FieldByName('stavka_id').Value;
    qrMain.FieldByName('dump_id').Value := qrTemp.FieldByName('dump_id').Value;
    qrMain.FieldByName('MAIS_ID').Value := qrTemp.FieldByName('MAIS_ID').Value;
    qrMain.FieldByName('NDS').Value := qrTemp.FieldByName('NDS').Value;
    qrMain.FieldByName('APPLY_LOW_COEF_OHROPR_FLAG').Value :=
      qrTemp.FieldByName('APPLY_LOW_COEF_OHROPR_FLAG').Value;
    qrMain.FieldByName('growth_index').Value := qrTemp.FieldByName('growth_index').Value;
    qrMain.FieldByName('STAVKA_RAB').Value := qrTemp.FieldByName('STAVKA_RAB').Value;
    qrMain.FieldByName('K_LOW_OHROPR').Value := qrTemp.FieldByName('K_LOW_OHROPR').Value;
    qrMain.FieldByName('K_LOW_PLAN_PRIB').Value := qrTemp.FieldByName('K_LOW_PLAN_PRIB').Value;
    qrMain.FieldByName('APPLY_WINTERPRISE_FLAG').Value := qrTemp.FieldByName('APPLY_WINTERPRISE_FLAG').Value;
    case aType of
      1:
        begin
          qrMain.FieldByName('SM_NUMBER').Value := qrTemp.FieldByName('SM_NUMBER').Value + '.1';
          qrMain.FieldByName('NAME').Value := '��������� �1';
        end;
      3:
        begin
          qrMain.FieldByName('SM_NUMBER').Value := '�000';
          qrMain.FieldByName('NAME').Value := '';
        end;
    end;
    qrMain.Post;
  end;

var
  CountWarning: Integer;

  DateCompose: TDate;
  vYear, vMonth: Integer;

  VAT: Integer;
  IdStavka: Variant;
  PercentTransport, PercentTransportEquipment: String;
  K40, K41, K31, K32, K33, K34, K35: String;

  NameEstimate: String;
begin
  CountWarning := 0;
  vMonth := MonthOf(Now);
  vYear := YearOf(Now);
  DateCompose := Now;
  VAT := 0;
  with qrTemp do
  begin
    try
      Active := False;
      SQL.Clear;
      StrQuery := 'SELECT state_nds, BEG_STROJ FROM objcards WHERE obj_id = ' + IntToStr(IdObject) + ';';
      SQL.Add(StrQuery);
      Active := True;

      VAT := FieldByName('state_nds').AsInteger;
      // ��� �������� ����� ���� ��� �������� �������������� ��� � �������
      DateCompose := FieldByName('BEG_STROJ').AsDateTime;
      vMonth := MonthOf(FieldByName('BEG_STROJ').AsDateTime);
      vYear := YearOf(FieldByName('BEG_STROJ').AsDateTime);
    except
      on E: Exception do
        MessageBox(0, PChar('��� ������� ��� �������� ������:' + sLineBreak + E.Message), PWideChar(Caption),
          MB_ICONERROR + MB_OK + mb_TaskModal);
    end;

    // -----------------------------------------

    try
      Active := False;
      SQL.Clear;
      StrQuery := 'SELECT stavka_id as "IdStavka" FROM stavka WHERE year = ' + IntToStr(vYear) +
        ' and monat = ' + IntToStr(vMonth) + ';';
      SQL.Add(StrQuery);
      Active := True;

      if IsEmpty then
        Abort;

      IdStavka := FieldByName('IdStavka').Value;
    except
      on E: Exception do
      begin
        MessageBox(0, PChar('��� ������� ID ������ �������� ������:' + sLineBreak + E.Message),
          PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
        Exit;
      end;
    end;

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
        MessageBox(0, PChar('��� ������� % ������������ �������� ������:' + sLineBreak + E.Message),
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
  K35 := '1';

  with dbedtNAME do
    if Text = '' then
    begin
      Color := ColorWarningField;
      Inc(CountWarning);
    end
    else
      NameEstimate := '"' + Text + '"';

  if CountWarning > 0 then
  begin
    MessageBox(0, PChar('�� ��������� �� ��� ����!' + #13#10 +
      '���� ���������� ������� �� ��������� ��� ��������� �����������.'), PWideChar(Caption),
      MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;
  // -----------------------------------------
  try
    btnSave.Tag := 1;
    if Editing then
    begin
      if qrMain.State in [dsEdit] then
        qrMain.Post;

      ModalResult := mrCancel;
    end
    else
    begin
      qrMain.FieldByName('sm_type').AsInteger := TypeEstimate;
      qrMain.FieldByName('obj_id').AsInteger := IdObject;
      qrMain.FieldByName('date').AsDateTime := DateCompose;
      qrMain.FieldByName('nds').AsInteger := VAT;

      if TypeEstimate = 2 then
      begin
        // ����� ��������� �����
        qrMain.FieldByName('parent_id').AsInteger := 0;
        qrMain.FieldByName('stavka_id').Value := IdStavka;
        qrMain.FieldByName('KZP').Value := GetUniDictParamValue('K_KORR_ZP', vMonth, vYear);
        // qrMain.FieldByName('k40').Value := GetUniDictParamValue('', vMonth, vYear);
        // qrMain.FieldByName('k41').Value := GetUniDictParamValue('', vMonth, vYear);
        qrMain.FieldByName('k31').Value := GetUniDictParamValue('K_OXR_OPR_270', vMonth, vYear);
        qrMain.FieldByName('k32').Value := GetUniDictParamValue('K_PLAN_PRIB_270', vMonth, vYear);
        qrMain.FieldByName('k33').Value := GetUniDictParamValue('K_VREM_ZDAN_SOOR', vMonth, vYear);
        qrMain.FieldByName('k34').Value := GetUniDictParamValue('K_ZIM_UDOR_1', vMonth, vYear);
        qrMain.FieldByName('k35').Value := GetUniDictParamValue('K_ZIM_UDOR_2', vMonth, vYear);
        // qrMain.FieldByName('coef_tr_zatr').Value := GetUniDictParamValue('', vMonth, vYear);
        // qrMain.FieldByName('coef_tr_obor').Value := GetUniDictParamValue('', vMonth, vYear);
      end
      else
      begin
        // �������� ������ �� ������������ �����
        qrMain.FieldByName('parent_id').AsInteger := IdEstimate;
        qrTemp.SQL.Text := 'SELECT * FROM smetasourcedata WHERE SM_ID=:SM_ID';
        qrTemp.ParamByName('SM_ID').AsInteger := IdEstimate;
        qrTemp.Active := True;
        qrMain.FieldByName('KZP').Value := qrTemp.FieldByName('KZP').Value;
        qrMain.FieldByName('k40').Value := qrTemp.FieldByName('k40').Value;
        qrMain.FieldByName('k41').Value := qrTemp.FieldByName('k41').Value;
        qrMain.FieldByName('k31').Value := qrTemp.FieldByName('k31').Value;
        qrMain.FieldByName('k32').Value := qrTemp.FieldByName('k32').Value;
        qrMain.FieldByName('k33').Value := qrTemp.FieldByName('k33').Value;
        qrMain.FieldByName('k34').Value := qrTemp.FieldByName('k34').Value;
        qrMain.FieldByName('k35').Value := qrTemp.FieldByName('k35').Value;
        qrMain.FieldByName('coef_tr_zatr').Value := qrTemp.FieldByName('coef_tr_zatr').Value;
        qrMain.FieldByName('coef_tr_obor').Value := qrTemp.FieldByName('coef_tr_obor').Value;
        qrMain.FieldByName('stavka_id').Value := qrTemp.FieldByName('stavka_id').Value;
        qrMain.FieldByName('dump_id').Value := qrTemp.FieldByName('dump_id').Value;
        qrMain.FieldByName('MAIS_ID').Value := qrTemp.FieldByName('MAIS_ID').Value;
        qrMain.FieldByName('growth_index').Value := qrTemp.FieldByName('growth_index').Value;
        qrMain.FieldByName('APPLY_LOW_COEF_OHROPR_FLAG').Value :=
          qrTemp.FieldByName('APPLY_LOW_COEF_OHROPR_FLAG').Value;
        qrMain.FieldByName('NDS').Value := qrTemp.FieldByName('NDS').Value;
        qrMain.FieldByName('growth_index').Value := qrTemp.FieldByName('growth_index').Value;
        qrMain.FieldByName('STAVKA_RAB').Value := qrTemp.FieldByName('STAVKA_RAB').Value;
        qrMain.FieldByName('K_LOW_OHROPR').Value := qrTemp.FieldByName('K_LOW_OHROPR').Value;
        qrMain.FieldByName('K_LOW_PLAN_PRIB').Value := qrTemp.FieldByName('K_LOW_PLAN_PRIB').Value;
        qrMain.FieldByName('APPLY_WINTERPRISE_FLAG').Value :=
          qrTemp.FieldByName('APPLY_WINTERPRISE_FLAG').Value;
      end;

      if qrMain.State in [dsInsert] then
        qrMain.Post;

      qrTemp.SQL.Text := 'select LAST_INSERT_ID() as ID';
      qrTemp.Active := True;
      IdEstimate := qrTemp.FieldByName('ID').AsInteger;
      case TypeEstimate of
        // ���� ���������
        1:
          // ��������� ������������� ������
          addParentEstimate(IdEstimate, 3);
        // ���� ���������
        2:
          begin
            // ��������� ���������
            addParentEstimate(IdEstimate, 1);
            qrTemp.SQL.Text := 'select LAST_INSERT_ID() as ID';
            qrTemp.Active := True;
            IdEstimate := qrTemp.FieldByName('ID').AsInteger;
            // � ������ ���
            addParentEstimate(IdEstimate, 3);
          end;
      end;
      ModalResult := mrOk;
    end;
  except
    on E: Exception do
    begin
      MessageBox(0, PChar('��� ���������� ������ �������� ������:' + #13#10 + E.Message), PWideChar(Caption),
        MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
  end;
end;

procedure TFormCardEstimate.ComboBoxChange(Sender: TObject);
begin
  if not CheckQrActiveEmpty(qrParts) or not CheckQrActiveEmpty(qrSections) or
    not CheckQrActiveEmpty(qrTypesWorks) or not CheckQrActiveEmpty(qrMain) or SkeepEvent then
    Exit;
  qrMain.Edit;
  qrMain.FieldByName('SM_NUMBER').AsString := '�' + qrParts.FieldByName('CODE').AsString +
    qrSections.FieldByName('CODE').AsString + qrTypesWorks.FieldByName('CODE').AsString;
  qrMain.FieldByName('NAME').AsString := qrParts.FieldByName('NAME').AsString + qrSections.FieldByName('NAME')
    .AsString + qrTypesWorks.FieldByName('NAME').AsString;
  // qrMain.CheckBrowseMode;
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
        MessageBox(0, PChar('��� ��������� ������ ����� �������� ������:' + sLineBreak + E.Message),
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
            MessageBox(0, PChar('��� ������� ������ ��������� ��������� ����� �������� ������:' + sLineBreak +
              E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
        end;

        // ������� � ������ �� ��� ����� �� ��������� �����, ������� �����
        while Pos('.', str) > 0 do
          Delete(str, 1, 1);

        qrMain.FieldByName('SM_NUMBER').AsString := NumberEstimate + '.' + IntToStr(StrToInt(str) + 1);
        qrMain.FieldByName('NAME').AsString := '��������� ����� �' + IntToStr(StrToInt(str) + 1);
      end;
    2: // ��������� �����
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
            MessageBox(0, PChar('��� ��������� ������ ��������� ��������� ����� �������� ������:' + sLineBreak
              + E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
        end;

        // ������� � ������ �� ��� ����� �� ��������� �����, ������� �����
        while Pos('.', str) > 0 do
          Delete(str, 1, 1);

        qrMain.FieldByName('SM_NUMBER').AsString := IntToStr(StrToInt(str) + 1);
        qrMain.FieldByName('NAME').AsString := '��������� ����� �' + IntToStr(StrToInt(str) + 1);
      end;
    3: // ��� �����
      begin
        qrMain.FieldByName('SM_NUMBER').AsString := '�000';
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
      MessageBox(0, PChar('��� ��������� Id ������ ��� ����������� ����� �������� ������:' + sLineBreak +
        E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormCardEstimate.qrPartsAfterScroll(DataSet: TDataSet);
begin
  ComboBoxChange(Self);
end;

end.
