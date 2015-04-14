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
    Editing: Boolean; // Для отслеживания режима добавления или редактирования записи
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
    if MessageBox(0, PChar('Закрыть окно без сохранения?'), PWideChar(Caption),
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
  qrMain.ParamByName('SM_ID').AsInteger := IdEstimate;
  CloseOpen(qrMain);

  dbedtCHAPTER.SetFocus; // Устанавливаем фокус

  btnSave.Tag := 0;

  if not Editing then
    qrMain.Append
  else
    qrMain.Edit;
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

        dblkcbbParts.Enabled := False;
        dblkcbbSections.Enabled := False;
        dblkcbbTypesWorks.Enabled := False;

        qrParts.Close;
        qrSections.Close;
        qrTypesWorks.Close;
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

        dblkcbbParts.Enabled := True;
        dblkcbbSections.Enabled := True;
        dblkcbbTypesWorks.Enabled := True;

        CloseOpen(qrParts);
        CloseOpen(qrSections);
        CloseOpen(qrTypesWorks);
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

  with qrTemp do
  begin
    try
      Active := False;
      SQL.Clear;
      StrQuery := 'SELECT state_nds, BEG_STROJ FROM objcards WHERE obj_id = ' + IntToStr(IdObject) + ';';
      SQL.Add(StrQuery);
      Active := True;

      VAT := FieldByName('state_nds').AsInteger;
      // При создании сметы дата для расценок проставляетсся как у объекта
      DateCompose := FieldByName('BEG_STROJ').AsDateTime;
      vMonth := MonthOf(FieldByName('BEG_STROJ').AsDateTime);
      vYear := YearOf(FieldByName('BEG_STROJ').AsDateTime);
    except
      on E: Exception do
        MessageBox(0, PChar('При запросе НДС возникла ошибка:' + sLineBreak + E.Message), PWideChar(Caption),
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

      IdStavka := FieldByName('IdStavka').Value;
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
    MessageBox(0, PChar('Вы заполнили не все поля!' + #13#10 +
      'Поля выделенные красным не заполнены или заполнены неправильно.'), PWideChar(Caption),
      MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;
  // -----------------------------------------
  try
    with qrTemp do
    begin
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
          // Новая объектная смета
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
          // Копируем данные из родительской сметы
          qrMain.FieldByName('parent_id').AsInteger := IdEstimate;
          SQL.Text :=
            'SELECT k40, k41, k31, k32, k33, k34, k35, coef_tr_zatr, coef_tr_obor, stavka_id, dump_id, MAIS_ID, KZP, growth_index, APPLY_LOW_COEF_OHROPR_FLAG FROM smetasourcedata WHERE SM_ID=:SM_ID';
          ParamByName('SM_ID').AsInteger := IdEstimate;
          Active := True;
          qrMain.FieldByName('KZP').Value := FieldByName('KZP').Value;
          qrMain.FieldByName('k40').Value := FieldByName('k40').Value;
          qrMain.FieldByName('k41').Value := FieldByName('k41').Value;
          qrMain.FieldByName('k31').Value := FieldByName('k31').Value;
          qrMain.FieldByName('k32').Value := FieldByName('k32').Value;
          qrMain.FieldByName('k33').Value := FieldByName('k33').Value;
          qrMain.FieldByName('k34').Value := FieldByName('k34').Value;
          qrMain.FieldByName('k35').Value := FieldByName('k35').Value;
          qrMain.FieldByName('coef_tr_zatr').Value := FieldByName('coef_tr_zatr').Value;
          qrMain.FieldByName('coef_tr_obor').Value := FieldByName('coef_tr_obor').Value;
          qrMain.FieldByName('stavka_id').Value := FieldByName('stavka_id').Value;
          qrMain.FieldByName('dump_id').Value := FieldByName('dump_id').Value;
          qrMain.FieldByName('MAIS_ID').Value := FieldByName('MAIS_ID').Value;
          qrMain.FieldByName('growth_index').Value := FieldByName('growth_index').Value;
          qrMain.FieldByName('APPLY_LOW_COEF_OHROPR_FLAG').Value := FieldByName('growth_index').Value;
        end;

        if qrMain.State in [dsInsert] then
          qrMain.Post;

        SQL.Text := 'select LAST_INSERT_ID() as ID';
        Active := True;
        IdEstimate := FieldByName('ID').AsInteger;
        Active := False;
        case TypeEstimate of
          1:
            begin
              qrMain.Append;
              qrMain.FieldByName('sm_type').AsInteger := 3;
              qrMain.FieldByName('obj_id').AsInteger := IdObject;
              qrMain.FieldByName('parent_id').AsInteger := IdEstimate;
              SQL.Text :=
                'SELECT k40, k41, k31, k32, k33, k34, k35, coef_tr_zatr, coef_tr_obor, stavka_id, dump_id, MAIS_ID FROM smetasourcedata WHERE SM_ID=:SM_ID';
              ParamByName('SM_ID').AsInteger := IdEstimate;
              Active := True;
              qrMain.FieldByName('k40').Value := FieldByName('k40').Value;
              qrMain.FieldByName('k41').Value := FieldByName('k41').Value;
              qrMain.FieldByName('k31').Value := FieldByName('k31').Value;
              qrMain.FieldByName('k32').Value := FieldByName('k32').Value;
              qrMain.FieldByName('k33').Value := FieldByName('k33').Value;
              qrMain.FieldByName('k34').Value := FieldByName('k34').Value;
              qrMain.FieldByName('k35').Value := FieldByName('k35').Value;
              qrMain.FieldByName('coef_tr_zatr').Value := FieldByName('coef_tr_zatr').Value;
              qrMain.FieldByName('coef_tr_obor').Value := FieldByName('coef_tr_obor').Value;
              qrMain.FieldByName('stavka_id').Value := FieldByName('stavka_id').Value;
              qrMain.FieldByName('dump_id').Value := FieldByName('dump_id').Value;
              qrMain.FieldByName('MAIS_ID').Value := FieldByName('MAIS_ID').Value;
              qrMain.Post;
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

procedure TFormCardEstimate.ComboBoxChange(Sender: TObject);
begin
  if not CheckQrActiveEmpty(qrParts) or not CheckQrActiveEmpty(qrSections) or
    not CheckQrActiveEmpty(qrTypesWorks) or not CheckQrActiveEmpty(qrMain) or SkeepEvent then
    Exit;

  qrMain.FieldByName('SM_NUMBER').AsString := 'Ж' + qrParts.FieldByName('CODE').AsString +
    qrSections.FieldByName('CODE').AsString + qrTypesWorks.FieldByName('CODE').AsString;
  qrMain.FieldByName('NAME').AsString := qrParts.FieldByName('NAME').AsString + qrSections.FieldByName('NAME')
    .AsString + qrTypesWorks.FieldByName('NAME').AsString;
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

        qrMain.FieldByName('SM_NUMBER').AsString := NumberEstimate + '.' + IntToStr(StrToInt(str) + 1);
        qrMain.FieldByName('NAME').AsString := 'Локальная смета №' + IntToStr(StrToInt(str) + 1);
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

        qrMain.FieldByName('SM_NUMBER').AsString := IntToStr(StrToInt(str) + 1);
        qrMain.FieldByName('NAME').AsString := 'Объектная смета №' + IntToStr(StrToInt(str) + 1);
      end;
    3: // ПТМ смета
      begin
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

procedure TFormCardEstimate.qrPartsAfterScroll(DataSet: TDataSet);
begin
  ComboBoxChange(Self);
end;

end.
