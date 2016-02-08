unit CardAct;

interface

uses Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask,
  JvExMask, JvToolEdit, JvDBControls, Vcl.DBCtrls, Tools, Vcl.Buttons, System.Variants, System.DateUtils,
  Vcl.Dialogs, System.UITypes, JvExControls, JvDBLookup;

type
  TfCardAct = class(TSmForm)
    ButtonSave: TButton;
    Bevel: TBevel;
    qrTemp: TFDQuery;
    qrAct: TFDQuery;
    dsAct: TDataSource;
    qrMain: TFDQuery;
    btnClose: TButton;
    lblDate: TLabel;
    cbbType: TComboBox;
    edDate: TJvDBDateEdit;
    lbl2: TLabel;
    cbbPERFOM_ID: TComboBox;
    bvl1: TBevel;
    lbl1: TLabel;
    dbedtNAME1: TDBEdit;
    btnSelectForeman: TBitBtn;
    lblName: TLabel;
    dbedtNAME: TDBEdit;
    lblDescription: TLabel;
    dbmmoDESCRIPTION: TDBMemo;
    bvl2: TBevel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    cbbPASSED_ID: TComboBox;
    cbbRECEIVED_ID: TComboBox;
    qrClients: TFDQuery;
    dsClients: TDataSource;
    dblkcbbSUB_CLIENT_ID: TDBLookupComboBox;
    btnSelectOrganization: TBitBtn;
    dsTYPE_ACT: TDataSource;
    qrTYPE_ACT: TFDQuery;
    dblkcbbTYPE_ACT_ID: TDBLookupComboBox;
    btnSelectTypeAct: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edDateChange(Sender: TObject);
    procedure dbedtNAMEChange(Sender: TObject);
    procedure btnSelectForemanClick(Sender: TObject);
    procedure btnSelectOrganizationClick(Sender: TObject);
    procedure cbbPASSED_IDChange(Sender: TObject);
    procedure cbbRECEIVED_IDChange(Sender: TObject);
    procedure cbbPERFOM_IDChange(Sender: TObject);
    procedure btnSelectTypeActClick(Sender: TObject);
    procedure cbbTypeCloseUp(Sender: TObject);
    procedure cbbTypeChange(Sender: TObject);
  private
    cnt: Integer;
  public
    id: Integer;
  end;

implementation

uses Main, DataModule, CalculationEstimate, GlobsAndConst, ForemanList, ObjectsAndEstimates, OrganizationsEx,
  TypeAct;

{$R *.dfm}

procedure TfCardAct.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCardAct.FormCreate(Sender: TObject);
begin
  inherited;
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;
  qrClients.Active := True;
  qrTYPE_ACT.Active := True;
end;

procedure TfCardAct.FormShow(Sender: TObject);
begin
  qrMain.ParamByName('SM_ID').AsInteger := 0;
  qrMain.Active := True;
  case FormKind of
    kdInsert:
      begin
        qrAct.ParamByName('id').AsInteger := 0;
        CloseOpen(qrAct);
        qrTemp.Active := False;
        qrTemp.SQL.Text := 'SELECT COUNT(*) AS CNT from smetasourcedata WHERE ACT=1 AND OBJ_ID=:OBJ_ID;';
        qrTemp.ParamByName('OBJ_ID').Value := fObjectsAndEstimates.qrObjects.FieldByName('IdObject').Value;
        qrTemp.Active := True;
        cnt := qrTemp.FieldByName('CNT').AsInteger + 1;
        qrTemp.Active := False;

        qrAct.Insert;
        qrAct.FieldByName('DATE').AsDateTime := Now();
        qrAct.FieldByName('NAME').AsString := 'Акт№' + IntToStr(cnt) + 'от' + qrAct.FieldByName('DATE')
          .AsString + 'для' + fObjectsAndEstimates.qrObjects.FieldByName('NumberObject').AsString + ' ' +
          fObjectsAndEstimates.qrObjects.FieldByName('FullName').AsString;
        qrAct.FieldByName('DESCRIPTION').AsString := dbedtNAME.Text;
        qrAct.FieldByName('OBJ_ID').Value := fObjectsAndEstimates.qrObjects.FieldByName('IdObject').Value;
        dbedtNAME.SetFocus;
      end;
    kdEdit:
      begin
        qrAct.ParamByName('id').AsInteger := id;
        CloseOpen(qrAct);
        cbbType.ItemIndex := qrAct.FieldByName('TYPE_ACT').AsInteger;
        cbbPERFOM_ID.ItemIndex := qrAct.FieldByName('PERFOM_ID').AsInteger;
        cbbPASSED_ID.ItemIndex := qrAct.FieldByName('PASSED_ID').AsInteger;
        cbbRECEIVED_ID.ItemIndex := qrAct.FieldByName('RECEIVED_ID').AsInteger;
        cbbType.Enabled := cbbType.ItemIndex = 2;
      end;
  end;
end;

procedure TfCardAct.btnSelectForemanClick(Sender: TObject);
begin
  if (not Assigned(fForemanList)) then
    fForemanList := TfForemanList.Create(FormMain);
  fForemanList.FormKind := kdSelect;
  if (fForemanList.ShowModal = mrOk) and (fForemanList.OutValue <> 0) then
  begin
    qrAct.Edit;
    qrAct.FieldByName('foreman_id').Value := fForemanList.OutValue;
    qrAct.FieldByName('foreman_').Value :=
      FastSelectSQLOne
      ('SELECT CONCAT(IFNULL(foreman_first_name, ""), " ", IFNULL(foreman_name, ""), " ", IFNULL(foreman_second_name, "")) FROM foreman WHERE foreman_id=:0',
      VarArrayOf([fForemanList.OutValue]));
  end;
end;

procedure TfCardAct.btnSelectTypeActClick(Sender: TObject);
begin
  if (not Assigned(fTypeAct)) then
    fTypeAct := TfTypeAct.Create(Self);
  fTypeAct.FormKind := kdSelect;
  if fTypeAct.ShowModal = mrOk then
  begin
    CloseOpen(qrTYPE_ACT);
    dblkcbbTYPE_ACT_ID.KeyValue := fTypeAct.qrMain.FieldByName('TYPE_ACT_ID').Value;
    qrAct.Edit;
    qrAct.FieldByName('TYPE_ACT_ID').Value := fTypeAct.qrMain.FieldByName('TYPE_ACT_ID').Value;
  end;
end;

procedure TfCardAct.btnSelectOrganizationClick(Sender: TObject);
var
  res: Variant;
begin
  res := SelectOrganization(dblkcbbSUB_CLIENT_ID.KeyValue);
  if not VarIsNull(res) then
  begin
    CloseOpen(qrClients);
    dblkcbbSUB_CLIENT_ID.KeyValue := res;
    qrAct.Edit;
    qrAct.FieldByName('SUB_CLIENT_ID').Value := res;
  end;
end;

procedure TfCardAct.btnCloseClick(Sender: TObject);
begin
  case FormKind of
    kdInsert:
      begin
        if MessageBox(0, PChar('Если сейчас выйти, акт не будет сохранён.' + sLineBreak +
          'Выйти без сохранения акта?'), PWideChar(Caption), MB_ICONWARNING + MB_YESNO + mb_TaskModal) = mryes
        then
        begin
          if qrAct.State in [dsEdit, dsInsert] then
            qrAct.Cancel;
          Close;
        end;
      end;
    kdEdit:
      begin
        if qrAct.State in [dsEdit, dsInsert] then
          qrAct.Cancel;
        Close;
      end;
  end;
end;

procedure TfCardAct.ButtonSaveClick(Sender: TObject);

  function addParentEstimate(aParentID, aType: Integer): Integer;
  var
    NewID: Variant;
  begin
    NewID := FastSelectSQLOne('SELECT GetNewID(:IDType)', VarArrayOf([C_ID_SM]));

    if VarIsNull(NewID) then
      raise Exception.Create('Не удалось получить новый ID.');

    qrTemp.SQL.Text := 'SELECT * FROM smetasourcedata WHERE SM_ID=:SM_ID';
    qrTemp.ParamByName('SM_ID').AsInteger := aParentID;
    qrTemp.Active := True;

    qrMain.Append;
    qrMain.FieldByName('SM_ID').AsInteger := NewID;
    qrMain.FieldByName('sm_type').AsInteger := aType;
    qrMain.FieldByName('obj_id').AsInteger := qrTemp.FieldByName('obj_id').Value;
    qrMain.FieldByName('parent_id').AsInteger := aParentID;
    qrMain.FieldByName('ACT').Value := qrTemp.FieldByName('ACT').Value;
    qrMain.FieldByName('USER_ID').Value := qrTemp.FieldByName('USER_ID').Value;
    qrMain.FieldByName('TYPE_ACT').Value := qrTemp.FieldByName('TYPE_ACT').Value;
    qrMain.FieldByName('TYPE_ACT_ID').Value := qrTemp.FieldByName('TYPE_ACT_ID').Value;
    qrMain.FieldByName('FL_USE').Value := qrTemp.FieldByName('FL_USE').Value;
    qrMain.FieldByName('DESCRIPTION').Value := qrTemp.FieldByName('DESCRIPTION').Value;
    qrMain.FieldByName('k40').Value := qrTemp.FieldByName('k40').Value;
    qrMain.FieldByName('k41').Value := qrTemp.FieldByName('k41').Value;
    qrMain.FieldByName('k31').Value := qrTemp.FieldByName('k31').Value;
    qrMain.FieldByName('k32').Value := qrTemp.FieldByName('k32').Value;
    qrMain.FieldByName('k33').Value := qrTemp.FieldByName('k33').Value;
    qrMain.FieldByName('k34').Value := qrTemp.FieldByName('k34').Value;
    qrMain.FieldByName('k35').Value := qrTemp.FieldByName('k35').Value;
    qrMain.FieldByName('kzp').Value := qrTemp.FieldByName('kzp').Value;
    qrMain.FieldByName('DATE').Value := qrTemp.FieldByName('DATE').Value;
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
    qrMain.FieldByName('WINTERPRICE_TYPE').Value := qrTemp.FieldByName('WINTERPRICE_TYPE').Value;
    case aType of
      1:
        begin
          qrMain.FieldByName('SM_NUMBER').Value := qrTemp.FieldByName('SM_NUMBER').Value + '.1';
          qrMain.FieldByName('NAME').Value := 'Локальная №1';
        end;
      3:
        begin
          qrMain.FieldByName('SM_NUMBER').Value := 'Ж000';
          qrMain.FieldByName('NAME').Value := '';
          qrMain.FieldByName('TYPE_WORK_ID').Value := 0;
          qrMain.FieldByName('PART_ID').Value := 0;
          qrMain.FieldByName('SECTION_ID').Value := 0;
        end;
    end;
    qrMain.Post;

    Result := NewID;
  end;

var
  NewID, MAIS_ID, IdStavka, VAT, vMonth, vYear, SM_NUMBER, WINTERPRICE_TYPE, APPLY_WINTERPRISE_FLAG: Variant;
begin
  case FormKind of
    kdInsert:
      begin
        try
          with qrTemp do
          begin
            try
              Active := False;
              SQL.Clear;
              SQL.Add('SELECT objcards.FL_APPLY_WINTERPRICE,objcards.WINTERPRICE_TYPE,objcards.MAIS_ID, state_nds, BEG_STROJ FROM objcards, objstroj, objregion '
                + 'WHERE objcards.stroj_id = objstroj.stroj_id and objstroj.obj_region = objregion.obj_region_id and '
                + 'objcards.obj_id = ' + qrAct.FieldByName('OBJ_ID').AsString + ';');
              Active := True;

              APPLY_WINTERPRISE_FLAG := FieldByName('FL_APPLY_WINTERPRICE').Value;
              WINTERPRICE_TYPE := FieldByName('WINTERPRICE_TYPE').Value;
              VAT := FieldByName('state_nds').AsInteger;
              vMonth := MonthOf(FieldByName('BEG_STROJ').AsDateTime); // edDate.Date
              vYear := YearOf(FieldByName('BEG_STROJ').AsDateTime); // edDate.Date
              MAIS_ID := FieldByName('MAIS_ID').Value;
            except
              on E: Exception do
                MessageBox(0, PChar('При запросе НДС возникла ошибка:' + sLineBreak + E.Message),
                  PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
            end;

            // if cbbType.ItemIndex = 1 then
            begin
              try
                Active := False;
                SQL.Clear;
                SQL.Add('SELECT stavka_id FROM stavka WHERE year = ' + IntToStr(vYear) + ' and monat = ' +
                  IntToStr(vMonth) + ';');
                Active := True;

                if IsEmpty then
                  Abort;

                IdStavka := FieldByName('stavka_id').Value;
              except
                on E: Exception do
                begin
                  MessageDlg('Для выбранной даты составления значения ставок отсутствуют.'#13 +
                    'Загрузите ставки или укажите другую дату составления акта.', mtError, [mbOK], 0);
                  Exit;
                end;
              end;
            end;

            NewID := FastSelectSQLOne('SELECT GetNewID(:IDType)', VarArrayOf([C_ID_SM]));

            if VarIsNull(NewID) then
              raise Exception.Create('Не удалось получить новый ID.');

            SM_NUMBER := FastSelectSQLOne
              ('SELECT max(sm_number) FROM smetasourcedata WHERE ACT=1 and sm_type=2 and obj_id =:0',
              VarArrayOf([qrAct.FieldByName('OBJ_ID').Value]));
            if VarIsNull(SM_NUMBER) then
              SM_NUMBER := 0;
            SM_NUMBER := SM_NUMBER + 1;

            SQL.Clear;
            SQL.Add('INSERT INTO smetasourcedata (SM_ID,OBJ_ID,name,description,date,foreman_id,ACT,'#13 +
              'TYPE_ACT,SM_TYPE,PARENT_ID,MAIS_ID,nds,stavka_id,KZP,k31,k32,k33,k34,k35,coef_tr_obor,SM_NUMBER,USER_ID,APPLY_WINTERPRISE_FLAG,WINTERPRICE_TYPE,'#13
              + 'TYPE_ACT_ID, PERFOM_ID, SUB_CLIENT_ID, PASSED_ID, RECEIVED_ID) ' +
              'VALUE (:ID, :OBJ_ID, :name, :description, :date, :foreman_id, 1, :TYPE_ACT, 2, 0,'#13 +
              ':MAIS_ID,:nds,:stavka_id,:KZP,:k31,:k32,:k33,:k34,:k35,:coef_tr_obor,:SM_NUMBER,:USER_ID,:APPLY_WINTERPRISE_FLAG,:WINTERPRICE_TYPE,'#13
              + ':TYPE_ACT_ID, :PERFOM_ID, :SUB_CLIENT_ID, :PASSED_ID, :RECEIVED_ID);');
            ParamByName('ID').Value := NewID;
            ParamByName('name').Value := dbedtNAME.Text;
            ParamByName('description').Value := dbmmoDESCRIPTION.Text;
            ParamByName('date').AsDate := edDate.Date;
            ParamByName('foreman_id').Value := qrAct.FieldByName('foreman_id').Value;
            ParamByName('OBJ_ID').Value := qrAct.FieldByName('OBJ_ID').Value;
            ParamByName('TYPE_ACT').Value := cbbType.ItemIndex;
            ParamByName('MAIS_ID').Value := MAIS_ID;
            ParamByName('nds').Value := VAT;
            ParamByName('stavka_id').Value := IdStavka;
            ParamByName('USER_ID').Value := G_USER_ID;
            ParamByName('KZP').Value := GetUniDictParamValue('K_KORR_ZP', vMonth, vYear);
            ParamByName('k31').Value := GetUniDictParamValue('K_OXR_OPR_270', vMonth, vYear);
            ParamByName('k32').Value := GetUniDictParamValue('K_PLAN_PRIB_270', vMonth, vYear);
            ParamByName('k33').Value := GetUniDictParamValue('K_VREM_ZDAN_SOOR', vMonth, vYear);
            ParamByName('k34').Value := GetUniDictParamValue('K_ZIM_UDOR_1', vMonth, vYear);
            ParamByName('k35').Value := GetUniDictParamValue('K_ZIM_UDOR_2', vMonth, vYear);
            ParamByName('coef_tr_obor').Value := 2;
            ParamByName('SM_NUMBER').Value := SM_NUMBER;
            ParamByName('APPLY_WINTERPRISE_FLAG').Value := APPLY_WINTERPRISE_FLAG;
            ParamByName('WINTERPRICE_TYPE').Value := WINTERPRICE_TYPE;
            ParamByName('TYPE_ACT_ID').Value := dblkcbbTYPE_ACT_ID.KeyValue;
            ParamByName('PERFOM_ID').Value := cbbPERFOM_ID.ItemIndex;
            ParamByName('SUB_CLIENT_ID').Value := dblkcbbSUB_CLIENT_ID.KeyValue;
            ParamByName('PASSED_ID').Value := cbbPASSED_ID.ItemIndex;
            ParamByName('RECEIVED_ID').Value := cbbRECEIVED_ID.ItemIndex;
            ExecSQL;
            if qrAct.State in [dsInsert] then
              qrAct.Cancel;
          end;
          CloseOpen(fObjectsAndEstimates.qrActsEx, False);
          fObjectsAndEstimates.qrActsEx.Locate('MASTER_ID', NewID, []);
          // Если акт на допработы
          if cbbType.ItemIndex = 1 then
          begin
            // Создаем разделы по умолчанию
            // добавляем Локальную
            NewID := addParentEstimate(NewID, 1);
            // и раздел ПТМ
            addParentEstimate(NewID, 3);
          end;
          Close;
        except
          on E: Exception do
            MessageBox(0, PChar('При создании нового акта возникла ошибка:' + sLineBreak + sLineBreak +
              E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      end;
    kdEdit:
      begin
        if qrAct.State in [dsEdit] then
          qrAct.Post;
        Close;
      end;
  end;
end;

procedure TfCardAct.cbbPERFOM_IDChange(Sender: TObject);
begin
  // Принадлежность
  qrAct.Edit;
  qrAct.FieldByName('PERFOM_ID').AsInteger := cbbPERFOM_ID.ItemIndex;
end;

procedure TfCardAct.cbbPASSED_IDChange(Sender: TObject);
begin
  // Акт сдал
  qrAct.Edit;
  qrAct.FieldByName('PASSED_ID').AsInteger := cbbPASSED_ID.ItemIndex;
end;

procedure TfCardAct.cbbRECEIVED_IDChange(Sender: TObject);
begin
  // Акт принял
  qrAct.Edit;
  qrAct.FieldByName('RECEIVED_ID').AsInteger := cbbRECEIVED_ID.ItemIndex;
end;

procedure TfCardAct.cbbTypeChange(Sender: TObject);
begin
  // Тип акта
  qrAct.Edit;
  qrAct.FieldByName('TYPE_ACT').AsInteger := cbbType.ItemIndex;
end;

procedure TfCardAct.cbbTypeCloseUp(Sender: TObject);
begin
  if (qrAct.FieldByName('TYPE_ACT').AsInteger = 2) and (cbbType.ItemIndex = 0) then
  begin
    cbbType.ItemIndex := qrAct.FieldByName('TYPE_ACT').AsInteger;
    Application.MessageBox('Изменение типа акта на выбранный запрещено!', PChar(Caption),
      MB_OK + MB_ICONWARNING + MB_TOPMOST);
    Abort;
  end;
end;

procedure TfCardAct.dbedtNAMEChange(Sender: TObject);
begin
  { Оставляем пустое описание
    if not CheckQrActiveEmpty(qrAct) or =(FormKind <> kdInsert) then
    Exit;
    qrAct.FieldByName('DESCRIPTION').AsString := dbedtNAME.Text;
  }
end;

procedure TfCardAct.edDateChange(Sender: TObject);
begin
  if not CheckQrActiveEmpty(qrAct) or (FormKind <> kdInsert) then
    Exit;
  qrAct.FieldByName('NAME').AsString := 'Акт№' + IntToStr(cnt) + 'от' + qrAct.FieldByName('DATE').AsString +
    'для' + fObjectsAndEstimates.qrObjects.FieldByName('NumberObject').AsString + ' ' +
    fObjectsAndEstimates.qrObjects.FieldByName('FullName').AsString;
end;

end.
