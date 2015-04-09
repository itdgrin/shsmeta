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
  else  qrMain.Edit;
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
      Active := False;
      SQL.Clear;
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
        qrMain.FieldByName('parent_id').AsInteger := IdEstimate;
        if qrMain.State in [dsInsert] then
          qrMain.Post;
        // SQL.Text := 'INSERT INTO smetasourcedata (sm_type, obj_id, parent_id, name, date, sm_number, ' +
        // 'chapter, row_number, preparer, post_preparer, examiner, post_examiner, set_drawings, k40, k41, k31, k32, '
        // + 'k33, k34, coef_tr_zatr, coef_tr_obor, nds, stavka_id) Value("' + IntToStr(TypeEstimate) + '", "'
        // + IntToStr(IdObject) + '", GetParentLocal(' + IntToStr(IdParentLocal) + ')+GetParentPTM(' +
        // IntToStr(IdEstimate) + '), ' + NameEstimate + ', "' + DateCompose + '", "' + EditNumberEstimate.Text
        // + '", ' + NumberChapter + ', ' + NumberRow + ', ' + Compose + ', ' + PostCompose + ', ' + Checked +
        // ', ' + PostChecked + ', ' + SetDrawing + ', "' + K40 + '", "' + K41 + '", "' + K31 + '", "' + K32 +
        // '", "' + K33 + '", "' + K34 + '", "' + PercentTransport + '", "' + PercentTransportEquipment +
        // '", "' + VAT + '", "' + IdStavka + '");';
        // ExecSQL;
        SQL.Text := 'select LAST_INSERT_ID() as ID';
        Active := True;
        IdEstimate := FieldByName('ID').AsInteger;
        Active := False;
        case TypeEstimate of
          1:
            begin
              SQL.Text := 'INSERT INTO smetasourcedata (sm_type, obj_id, parent_id, name, date, sm_number, ' +
                'chapter, row_number, preparer, post_preparer, examiner, post_examiner, set_drawings, k40, k41, k31, k32, '
                + 'k33, k34, coef_tr_zatr, coef_tr_obor, nds, stavka_id) Value("' + IntToStr(3) + '", "' +
                IntToStr(IdObject) + '", ' + IntToStr(IdEstimate) + ', "", "' + DateCompose + '", "Ж000", ' +
                NumberChapter + ', ' + NumberRow + ', ' + Compose + ', ' + PostCompose + ', ' + Checked + ', '
                + PostChecked + ', ' + SetDrawing + ', "' + K40 + '", "' + K41 + '", "' + K31 + '", "' + K32 +
                '", "' + K33 + '", "' + K34 + '", "' + PercentTransport + '", "' + PercentTransportEquipment +
                '", "' + VAT + '", "' + IdStavka + '");';
              ExecSQL;
              qrMain.Append;
              qrMain.FieldByName('sm_type').AsInteger := 3;
              qrMain.FieldByName('obj_id').AsInteger := IdObject;
              qrMain.FieldByName('parent_id').AsInteger := IdEstimate;
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
