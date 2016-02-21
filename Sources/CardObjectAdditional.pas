unit CardObjectAdditional;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, DataModule, CardObject, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, JvExMask, JvToolEdit, JvDBControls, JvSpin, JvDBSpinEdit,
  JvComponentBase, JvFormPlacement, JvExExtCtrls, JvExtComponent, JvDBRadioPanel;

type
  TfCardObjectAdditional = class(TSmForm)
    pnl1: TPanel;
    btn1: TBitBtn;
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
    dbchkFL_APPLY_WINTERPRICE: TDBCheckBox;
    GridPanel6: TGridPanel;
    lbl6: TLabel;
    dbchkFL_APPLY_WINTERPRICE1: TDBCheckBox;
    GridPanel7: TGridPanel;
    lbl7: TLabel;
    dbchkFL_APPLY_WINTERPRICE2: TDBCheckBox;
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
    btn2: TBitBtn;
    procedure btn1Click(Sender: TObject);
    procedure dbchkAPPLY_WINTERPRISE_FLAGClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbl2Click(Sender: TObject);
    procedure lbl1Click(Sender: TObject);
    procedure lbl4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbl22Click(Sender: TObject);
  private

  public
    fCardObject: TfCardObject;
  end;

implementation

uses CardObjectContractorServices, SSR, Main;

{$R *.dfm}

procedure TfCardObjectAdditional.btn1Click(Sender: TObject);
begin
  Close;
end;

procedure TfCardObjectAdditional.dbchkAPPLY_WINTERPRISE_FLAGClick(Sender: TObject);
begin
  GridPanel24.Visible := dbchkAPPLY_WINTERPRISE_FLAG.Checked;
  dbchkAPPLY_WINTERPRISE_FLAG.Top := GridPanel24.Top - 1;
end;

procedure TfCardObjectAdditional.FormCreate(Sender: TObject);
begin
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

procedure TfCardObjectAdditional.FormShow(Sender: TObject);
begin
  GridPanel24.Visible := dbchkAPPLY_WINTERPRISE_FLAG.Checked;
  dbchkAPPLY_WINTERPRISE_FLAG.Top := GridPanel24.Top - 1;
end;

procedure TfCardObjectAdditional.lbl1Click(Sender: TObject);
var
  fSSR: TfSSR;
begin
  fSSR := TfSSR.Create(Self,
    VarArrayOf([2, 'Сметные нормы затрат на строительство временных зданий и сооружений', True]));
  try
    fSSR.ShowModal;
  finally
    FreeAndNil(fSSR);
  end;
end;

procedure TfCardObjectAdditional.lbl22Click(Sender: TObject);
var
  fSSR: TfSSR;
begin
  fSSR := TfSSR.Create(Self,
    VarArrayOf([1, 'НДЗ 1 (по видам строительства)', True]));
  try
    fSSR.ShowModal;
  finally
    FreeAndNil(fSSR);
  end;
end;

procedure TfCardObjectAdditional.lbl2Click(Sender: TObject);
var
  res: Variant;
begin
  res := EditContractorServices(fCardObject.qrMain.FieldByName('CONTRACTOR_SERV').AsInteger);
  if not VarIsNull(res) then
  begin
    fCardObject.qrMain.FieldByName('CONTRACTOR_SERV').Value := res[0];
    fCardObject.qrMain.FieldByName('PER_CONTRACTOR').Value := res[1];
  end;
end;

procedure TfCardObjectAdditional.lbl4Click(Sender: TObject);
var
  res: Variant;
begin
  res := EditContractorServices(fCardObject.qrMain.FieldByName('CONTRACTOR_SERV').AsInteger);
  if not VarIsNull(res) then
  begin
    fCardObject.qrMain.FieldByName('CONTRACTOR_SERV').Value := res[0];
    fCardObject.qrMain.FieldByName('PER_CONTRACTOR').Value := res[1];
  end;
end;

end.
