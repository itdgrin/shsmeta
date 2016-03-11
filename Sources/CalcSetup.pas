unit CalcSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, DataModule, CardObject, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, JvExMask, JvToolEdit, JvDBControls, JvSpin, JvDBSpinEdit,
  JvComponentBase, JvFormPlacement, JvExExtCtrls, JvExtComponent, JvDBRadioPanel, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfCalcSetup = class(TSmForm)
    pnl1: TPanel;
    btnCancel: TBitBtn;
    ScrollBox1: TScrollBox;
    GridPanel1: TGridPanel;
    lbl1: TLabel;
    JvDBSpinEdit3: TJvDBSpinEdit;
    GridPanel2: TGridPanel;
    lbl3: TLabel;
    dbchkAPPLY_WINTERPRISE_FLAG: TDBCheckBox;
    GridPanel3: TGridPanel;
    lbl4: TLabel;
    JvDBSpinEdit4: TJvDBSpinEdit;
    GridPanel4: TGridPanel;
    lbl2: TLabel;
    JvDBSpinEdit5: TJvDBSpinEdit;
    pnl2: TPanel;
    GridPanel5: TGridPanel;
    lbl5: TLabel;
    GridPanel6: TGridPanel;
    lbl6: TLabel;
    GridPanel7: TGridPanel;
    lbl7: TLabel;
    pnl3: TPanel;
    GridPanel8: TGridPanel;
    lbl8: TLabel;
    dbchkFL_K_PP: TDBCheckBox;
    GridPanel9: TGridPanel;
    lbl9: TLabel;
    dbchkFL_CALC_ZEM_NAL: TDBCheckBox;
    GridPanel10: TGridPanel;
    JvDBSpinEdit6: TJvDBSpinEdit;
    dbchkFl_SPEC_SCH: TDBCheckBox;
    GridPanel11: TGridPanel;
    JvDBSpinEdit1: TJvDBSpinEdit;
    dbchkFL_CALC_VEDOMS_NAL2: TDBCheckBox;
    pnl4: TPanel;
    pnl5: TPanel;
    GridPanel12: TGridPanel;
    lbl10: TLabel;
    dbchkFL_CALC_ZEM_NAL1: TDBCheckBox;
    GridPanel13: TGridPanel;
    lbl11: TLabel;
    dbchkFL_CALC_ZEM_NAL2: TDBCheckBox;
    GridPanel14: TGridPanel;
    lbl12: TLabel;
    dbchkFL_CALC_ZEM_NAL3: TDBCheckBox;
    GridPanel15: TGridPanel;
    lbl13: TLabel;
    dbchkFL_CALC_TRAVEL_WORK: TDBCheckBox;
    GridPanel16: TGridPanel;
    lbl14: TLabel;
    dbchkFL_CALC_TRAVEL_WORK1: TDBCheckBox;
    GridPanel17: TGridPanel;
    lbl15: TLabel;
    dbchkFL_CALC_TRAVEL_WORK2: TDBCheckBox;
    GridPanel18: TGridPanel;
    lbl16: TLabel;
    dbchkFL_CALC_TRAVEL_WORK3: TDBCheckBox;
    GridPanel19: TGridPanel;
    lbl17: TLabel;
    dbchkFL_CALC_TRAVEL_WORK4: TDBCheckBox;
    pnl6: TPanel;
    GridPanel20: TGridPanel;
    lbl18: TLabel;
    dbchkFL_DIFF_MAT_ZAK: TDBCheckBox;
    GridPanel21: TGridPanel;
    lbl19: TLabel;
    dbchkFL_DIFF_NAL_USN: TDBCheckBox;
    GridPanel22: TGridPanel;
    lbl20: TLabel;
    dbchkFL_DIFF_DEVICE_PODR_WITH_NAL: TDBCheckBox;
    GridPanel23: TGridPanel;
    lbl21: TLabel;
    dbchkFL_DIFF_NDS: TDBCheckBox;
    FormStorage: TJvFormStorage;
    GridPanel24: TGridPanel;
    JvDBSpinEdit2: TJvDBSpinEdit;
    pnl7: TPanel;
    JvDBRadioPanel1: TJvDBRadioPanel;
    pnl8: TPanel;
    lbl22: TLabel;
    lbl23: TLabel;
    btnSave: TBitBtn;
    JvDBSpinEdit7: TJvDBSpinEdit;
    JvDBSpinEdit8: TJvDBSpinEdit;
    jvdbspndtK_PP: TJvDBSpinEdit;
    GridPanel25: TGridPanel;
    lbl24: TLabel;
    jvdbspndtK_PP1: TJvDBSpinEdit;
    qrMain: TFDQuery;
    dsMain: TDataSource;
    procedure btnCancelClick(Sender: TObject);
    procedure dbchkAPPLY_WINTERPRISE_FLAGClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbl2Click(Sender: TObject);
    procedure lbl1Click(Sender: TObject);
    procedure lbl4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qrMainNewRecord(DataSet: TDataSet);
    procedure qrMainBeforeOpen(DataSet: TDataSet);
    procedure btnSaveClick(Sender: TObject);
  private
    // Можно OBJ_ID не передавать, если нету под рукой
    OBJ_ID, SM_ID: Variant; // [0..1] InitParams->Create
  public
    // fCardObject: TfCardObject;
  end;

implementation

uses CardObjectContractorServices, SSR, Main;

{$R *.dfm}

procedure TfCalcSetup.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfCalcSetup.btnSaveClick(Sender: TObject);
var
  TREE_PATH: Variant;
begin
  if qrMain.State in [dsEdit, dsInsert] then
    qrMain.Post;
  if Application.MessageBox('Обновить настройки в зависимых актах/сметах?', PChar(Caption),
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    // Если редактируются настройки объекта
    if VarIsNull(SM_ID) then
    begin
      // Удаляем все сметные/актные настройки
      FastExecSQL('DELETE FROM calc_setup WHERE OBJ_ID=:0 AND SM_ID IS NOT NULL;', VarArrayOf([OBJ_ID]));
    end
    // Иначе, работаем со сметой
    else
    begin
      // Удаляем по TREE_PATH все зависимые
      TREE_PATH := FastSelectSQLOne('SELECT TREE_PATH FROM smetasourcedata WHERE SM_ID=:0',
        VarArrayOf([SM_ID]));
      FastExecSQL
        ('DELETE FROM calc_setup WHERE OBJ_ID=:0 AND SM_ID IN (SELECT SM_ID FROM smetasourcedata WHERE OBJ_ID=:1 AND TREE_PATH LIKE CONCAT(:2, "%") AND TREE_PATH <> :3);',
        VarArrayOf([OBJ_ID, OBJ_ID, TREE_PATH, TREE_PATH]));
    end;
    // Вызываем фиктивное обновление всех записей - дальше триггер все сделает
    FastExecSQL('UPDATE smetasourcedata set sm_id=sm_id WHERE OBJ_ID=:0;', VarArrayOf([OBJ_ID]));
  end;
  Close;
end;

procedure TfCalcSetup.dbchkAPPLY_WINTERPRISE_FLAGClick(Sender: TObject);
begin
  GridPanel24.Visible := dbchkAPPLY_WINTERPRISE_FLAG.Checked;
  dbchkAPPLY_WINTERPRISE_FLAG.Top := GridPanel24.Top - 1;
end;

procedure TfCalcSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if qrMain.State in [dsEdit, dsInsert] then
    qrMain.Cancel;
  Action := caFree;
end;

procedure TfCalcSetup.FormCreate(Sender: TObject);
begin
  OBJ_ID := InitParams[0];
  SM_ID := InitParams[1];
  // Пытаемся установить OBJ_ID, если не передан
  if VarIsNull(OBJ_ID) and not VarIsNull(SM_ID) then
    OBJ_ID := FastSelectSQLOne('SELECT OBJ_ID FROM smetasourcedata WHERE SM_ID=:0', VarArrayOf([SM_ID]));

  qrMain.Active := True;
  pnl2.Color := PS.BackgroundHead;
  pnl2.Repaint;
  pnl3.Color := PS.BackgroundHead;
  pnl3.Repaint;
  pnl4.Color := PS.BackgroundHead;
  pnl4.Repaint;
  pnl5.Color := PS.BackgroundHead;
  pnl5.Repaint;
  pnl6.Color := PS.BackgroundHead;
  pnl6.Repaint;
end;

procedure TfCalcSetup.FormShow(Sender: TObject);
begin
  GridPanel24.Visible := dbchkAPPLY_WINTERPRISE_FLAG.Checked;
  dbchkAPPLY_WINTERPRISE_FLAG.Top := GridPanel24.Top - 1;
end;

procedure TfCalcSetup.lbl1Click(Sender: TObject);
var
  fSSR: TfSSR;
  TmpStr: string;
  per: Variant;
begin
  case (Sender as TLabel).Tag of
    1:
      TmpStr := 'Сметные нормы для дополнительных затрат при производстве работ в зимнее время';
    2:
      TmpStr := 'Сметные нормы затрат на строительство временных зданий и сооружений';
    3:
      TmpStr := 'Резерв на непредвиденные затраты';
    4:
      TmpStr := 'Содержание единых заказчиков';
    5:
      TmpStr := 'Затраты, связанные с подвижным и разъездным характером работ';
  end;

  fSSR := TfSSR.Create(Self, VarArrayOf([(Sender as TLabel).Tag, TmpStr, True]));
  try
    if fSSR.ShowModal = mrOk then
    begin
      per := FastSelectSQLOne('select COEF_NORM from ssrdetail where ID=:0', VarArrayOf([fSSR.SprID]));
      qrMain.Edit;
      case (Sender as TLabel).Tag of
        1:
          begin
            // TODO сохранить fSSR.SprID
            // бесполезно, т.к. может быть установлен руками
            qrMain.FieldByName('PER_WINTERPRICE').Value := per;
          end;
        2:
          begin
            // TODO сохранить fSSR.SprID
            // бесполезно, т.к. может быть установлен руками
            qrMain.FieldByName('PER_TEMP_BUILD').Value := per;
          end;
      end;
    end;

  finally
    FreeAndNil(fSSR);
  end;
end;

procedure TfCalcSetup.lbl2Click(Sender: TObject);
var
  res: Variant;
begin
  res := EditContractorServices( { fCardObject. } qrMain.FieldByName('CONTRACTOR_SERV').AsInteger);
  if not VarIsNull(res) then
  begin
    { fCardObject. } qrMain.FieldByName('CONTRACTOR_SERV').Value := res[0];
    { fCardObject. } qrMain.FieldByName('PER_CONTRACTOR').Value := res[1];
  end;
end;

procedure TfCalcSetup.lbl4Click(Sender: TObject);
var
  res: Variant;
begin
  res := EditContractorServices( { fCardObject. } qrMain.FieldByName('CONTRACTOR_SERV').AsInteger);
  if not VarIsNull(res) then
  begin
    { fCardObject. } qrMain.FieldByName('CONTRACTOR_SERV').Value := res[0];
    { fCardObject. } qrMain.FieldByName('PER_CONTRACTOR').Value := res[1];
  end;
end;

procedure TfCalcSetup.qrMainBeforeOpen(DataSet: TDataSet);
begin
  qrMain.ParamByName('OBJ_ID').Value := OBJ_ID;
  qrMain.ParamByName('SM_ID').Value := SM_ID;
end;

procedure TfCalcSetup.qrMainNewRecord(DataSet: TDataSet);
begin
  qrMain.FieldByName('OBJ_ID').Value := OBJ_ID;
  qrMain.FieldByName('SM_ID').Value := SM_ID;
end;

end.
