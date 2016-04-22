unit CalcSetupIndex;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, Vcl.StdCtrls, DataModule, Main, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  JvExControls, JvDBLookup, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, JvComponentBase, JvFormPlacement, JvToolEdit,
  JvDBControls, Vcl.ComCtrls, JvExComCtrls, JvDateTimePicker, JvDBDateTimePicker, JvExMask, JvMaskEdit,
  JvCheckedMaskEdit, JvDatePickerEdit, JvDBDatePickerEdit;

type
  TfCalcSetupIndex = class(TSmForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    JvDBLookupCombo1: TJvDBLookupCombo;
    JvDBLookupCombo2: TJvDBLookupCombo;
    qrMain: TFDQuery;
    dsMain: TDataSource;
    FormStorage: TJvFormStorage;
    dbedtINDEX_VAL_BEGIN: TDBEdit;
    dbedtINDEX_VAL_END: TDBEdit;
    qrInd: TFDQuery;
    dsInd: TDataSource;
    btnCancel: TBitBtn;
    btnSave: TBitBtn;
    lbl7: TLabel;
    dbedtINDEX_VAL: TDBEdit;
    JvDBDateTimePicker1: TJvDBDateTimePicker;
    JvDBDateTimePicker2: TJvDBDateTimePicker;
    JvDBDateTimePicker3: TJvDBDateTimePicker;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure qrMainBeforeOpen(DataSet: TDataSet);
    procedure qrMainNewRecord(DataSet: TDataSet);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure JvDBDateTimePicker3Change(Sender: TObject);
    procedure dbedtINDEX_VAL_ENDChange(Sender: TObject);
  private
    // Можно OBJ_ID не передавать, если нету под рукой
    OBJ_ID, SM_ID: Variant; // [0..1] InitParams->Create
    flSkip: Boolean;
  public
    { Public declarations }
  end;

implementation

// FN_getIndex(o.BEG_STROJ, DATE_ADD(o.BEG_STROJ2, INTERVAL -1 MONTH), o.index_type_id)
// SET NEW.IND = `FN_getIndex`(vBEG_STROJ2, NEW.OnDate, vindex_type_id);
{$R *.dfm}

procedure TfCalcSetupIndex.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfCalcSetupIndex.btnSaveClick(Sender: TObject);
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

procedure TfCalcSetupIndex.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  flSkip := True;
  if qrMain.State in [dsEdit, dsInsert] then
    qrMain.Cancel;
  Action := caFree;
end;

procedure TfCalcSetupIndex.FormCreate(Sender: TObject);
begin
  OBJ_ID := InitParams[0];
  SM_ID := InitParams[1];
  // Пытаемся установить OBJ_ID, если не передан
  if VarIsNull(OBJ_ID) and not VarIsNull(SM_ID) then
    OBJ_ID := FastSelectSQLOne('SELECT OBJ_ID FROM smetasourcedata WHERE SM_ID=:0', VarArrayOf([SM_ID]));
  qrInd.Active := True;
  qrMain.Active := True;

  if VarIsNull(qrMain.FieldByName('INDEX_VAL_BEGIN').Value) then
    JvDBDateTimePicker3Change(Sender);
end;

procedure TfCalcSetupIndex.JvDBDateTimePicker3Change(Sender: TObject);
begin
  if flSkip then
    Exit;
  flSkip := True;
  qrMain.Edit;
  // Перерасчет индекса на дату начала строительства
  qrMain.FieldByName('INDEX_VAL_BEGIN').Value :=
    FastSelectSQLOne('SELECT FN_getIndex(:0, DATE_ADD(:1, INTERVAL -1 MONTH), :2)',
    VarArrayOf([qrMain.FieldByName('DATE_CREATE').Value, qrMain.FieldByName('DATE_BEGIN').Value,
    qrMain.FieldByName('INDEX_TYPE_BEGIN').Value]));
  // Перерасчет индекса на дату выполнения работ
  qrMain.FieldByName('INDEX_VAL_END').Value := FastSelectSQLOne('SELECT FN_getIndex(:0, :1, :2)',
    VarArrayOf([qrMain.FieldByName('DATE_BEGIN').Value, qrMain.FieldByName('DATE_END').Value,
    qrMain.FieldByName('INDEX_TYPE_END').Value]));
  // Индекс роста
  qrMain.FieldByName('INDEX_VAL').Value := FastSelectSQLOne('SELECT FN_ROUND_TO(:0, :1)',
    VarArrayOf([qrMain.FieldByName('INDEX_VAL_BEGIN').AsFloat * qrMain.FieldByName('INDEX_VAL_END').AsFloat,
    'ИНДЕКС_РОСТА']));
  flSkip := False;
end;

procedure TfCalcSetupIndex.dbedtINDEX_VAL_ENDChange(Sender: TObject);
begin
  if flSkip then
    Exit;
  flSkip := True;
  qrMain.Edit;
  // Индекс роста
  qrMain.FieldByName('INDEX_VAL').Value := FastSelectSQLOne('SELECT FN_ROUND_TO(:0, :1)',
    VarArrayOf([qrMain.FieldByName('INDEX_VAL_BEGIN').AsFloat * qrMain.FieldByName('INDEX_VAL_END').AsFloat,
    'ИНДЕКС_РОСТА']));
  flSkip := False;
end;

procedure TfCalcSetupIndex.qrMainBeforeOpen(DataSet: TDataSet);
begin
  qrMain.ParamByName('OBJ_ID').Value := OBJ_ID;
  qrMain.ParamByName('SM_ID').Value := SM_ID;
end;

procedure TfCalcSetupIndex.qrMainNewRecord(DataSet: TDataSet);
begin
  qrMain.FieldByName('OBJ_ID').Value := OBJ_ID;
  qrMain.FieldByName('SM_ID').Value := SM_ID;
end;

end.
