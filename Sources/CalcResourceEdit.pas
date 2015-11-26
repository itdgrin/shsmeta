unit CalcResourceEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, DataModule, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Mask, JvExMask, JvSpin;

type
  TfCalcResourceEdit = class(TSmForm)
    pgc1: TPageControl;
    tsMaterial: TTabSheet;
    tsMechanizm: TTabSheet;
    tsDevice: TTabSheet;
    pnl1: TPanel;
    btnCancel: TBitBtn;
    btnOk: TBitBtn;
    chkMatCoast: TCheckBox;
    chkMatTransp: TCheckBox;
    chkMatNaklDate: TCheckBox;
    chkMatNakl: TCheckBox;
    chkMatZakPodr: TCheckBox;
    chkMatTranspZakPodr: TCheckBox;
    edtMatNakl: TEdit;
    dtpMatNaklDate: TDateTimePicker;
    edtMatCoast: TEdit;
    edtMatTranspPodr: TJvSpinEdit;
    lbl1: TLabel;
    edtMatTranspZak: TJvSpinEdit;
    edtMatPodr: TJvSpinEdit;
    lbl2: TLabel;
    edtMatZak: TJvSpinEdit;
    edtMatTransp: TJvSpinEdit;
    chkMechCoast: TCheckBox;
    edtMechCoast: TEdit;
    chkMechZPMash: TCheckBox;
    chkMechNaklDate: TCheckBox;
    dtpMechNaklDate: TDateTimePicker;
    edtMechNakl: TEdit;
    chkMechNakl: TCheckBox;
    chkMechZakPodr: TCheckBox;
    edtMechPodr: TJvSpinEdit;
    lbl3: TLabel;
    edtMechZak: TJvSpinEdit;
    chkDevCoast: TCheckBox;
    edtDevCoast: TEdit;
    chkDevTransp: TCheckBox;
    chkDevNaklDate: TCheckBox;
    dtpDevNaklDate: TDateTimePicker;
    edtDevNakl: TEdit;
    chkDevNakl: TCheckBox;
    chkDevZakPodr: TCheckBox;
    edtDevPodr: TJvSpinEdit;
    lbl5: TLabel;
    edtDevZak: TJvSpinEdit;
    chkDevTranspZakPodr: TCheckBox;
    edtDevTranspPodr: TJvSpinEdit;
    lbl6: TLabel;
    edtDevTranspZak: TJvSpinEdit;
    edtMechZPMash: TEdit;
    edtDevTransp: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure edtMatPodrChange(Sender: TObject);
    procedure edtMatZakChange(Sender: TObject);
    procedure edtMatTranspPodrChange(Sender: TObject);
    procedure edtMatTranspZakChange(Sender: TObject);
    procedure edtMatNaklChange(Sender: TObject);
    procedure dtpMatNaklDateChange(Sender: TObject);
    procedure edtMatTranspChange(Sender: TObject);
    procedure edtMatCoastChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtMechPodrChange(Sender: TObject);
    procedure edtMechZakChange(Sender: TObject);
    procedure edtMechCoastChange(Sender: TObject);
    procedure edtMechZPMashChange(Sender: TObject);
    procedure dtpMechNaklDateChange(Sender: TObject);
    procedure edtMechNaklChange(Sender: TObject);
    procedure edtDevCoastChange(Sender: TObject);
    procedure edtDevTranspChange(Sender: TObject);
    procedure dtpDevNaklDateChange(Sender: TObject);
    procedure edtDevNaklChange(Sender: TObject);
    procedure edtDevPodrChange(Sender: TObject);
    procedure edtDevZakChange(Sender: TObject);
    procedure edtDevTranspPodrChange(Sender: TObject);
    procedure edtDevTranspZakChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCalcResourceEdit: TfCalcResourceEdit;

implementation

{$R *.dfm}

procedure TfCalcResourceEdit.dtpDevNaklDateChange(Sender: TObject);
begin
  chkDevNaklDate.Checked := True;
end;

procedure TfCalcResourceEdit.dtpMatNaklDateChange(Sender: TObject);
begin
  chkMatNaklDate.Checked := True;
end;

procedure TfCalcResourceEdit.edtMatNaklChange(Sender: TObject);
begin
  chkMatNakl.Checked := True;
end;

procedure TfCalcResourceEdit.dtpMechNaklDateChange(Sender: TObject);
begin
  chkMechNaklDate.Checked := True;
end;

procedure TfCalcResourceEdit.edtDevCoastChange(Sender: TObject);
begin
  chkDevCoast.Checked := True;
end;

procedure TfCalcResourceEdit.edtDevNaklChange(Sender: TObject);
begin
  chkDevNakl.Checked := True;
end;

procedure TfCalcResourceEdit.edtDevPodrChange(Sender: TObject);
begin
  edtDevZak.OnChange := nil;
  edtDevZak.Value := 100 - edtDevPodr.Value;
  chkDevZakPodr.Checked := True;
  edtDevZak.OnChange := edtDevZakChange;
end;

procedure TfCalcResourceEdit.edtDevTranspChange(Sender: TObject);
begin
  chkDevTransp.Checked := True;
end;

procedure TfCalcResourceEdit.edtDevTranspPodrChange(Sender: TObject);
begin
  edtDevTranspZak.OnChange := nil;
  edtDevTranspZak.Value := 100 - edtDevTranspPodr.Value;
  chkDevTranspZakPodr.Checked := True;
  edtDevTranspZak.OnChange := edtDevTranspZakChange;
end;

procedure TfCalcResourceEdit.edtDevTranspZakChange(Sender: TObject);
begin
  edtDevTranspPodr.OnChange := nil;
  edtDevTranspPodr.Value := 100 - edtDevTranspZak.Value;
  chkDevTranspZakPodr.Checked := True;
  edtDevTranspPodr.OnChange := edtDevTranspPodrChange;
end;

procedure TfCalcResourceEdit.edtDevZakChange(Sender: TObject);
begin
  edtDevPodr.OnChange := nil;
  edtDevPodr.Value := 100 - edtDevZak.Value;
  chkDevZakPodr.Checked := True;
  edtDevPodr.OnChange := edtDevPodrChange;
end;

procedure TfCalcResourceEdit.edtMatCoastChange(Sender: TObject);
begin
  chkMatCoast.Checked := True;
end;

procedure TfCalcResourceEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCalcResourceEdit.FormCreate(Sender: TObject);
begin
  tsMaterial.TabVisible := False;
  tsMechanizm.TabVisible := False;
  tsDevice.TabVisible := False;
  pgc1.ActivePageIndex := InitParams - 1;
end;

procedure TfCalcResourceEdit.FormDestroy(Sender: TObject);
begin
  fCalcResourceEdit := nil;
end;

procedure TfCalcResourceEdit.edtMatTranspPodrChange(Sender: TObject);
begin
  edtMatTranspZak.OnChange := nil;
  edtMatTranspZak.Value := 100 - edtMatTranspPodr.Value;
  chkMatTranspZakPodr.Checked := True;
  edtMatTranspZak.OnChange := edtMatTranspZakChange;
end;

procedure TfCalcResourceEdit.edtMatTranspZakChange(Sender: TObject);
begin
  edtMatTranspPodr.OnChange := nil;
  edtMatTranspPodr.Value := 100 - edtMatTranspZak.Value;
  chkMatTranspZakPodr.Checked := True;
  edtMatTranspPodr.OnChange := edtMatTranspPodrChange;
end;

procedure TfCalcResourceEdit.edtMatPodrChange(Sender: TObject);
begin
  edtMatZak.OnChange := nil;
  edtMatZak.Value := 100 - edtMatPodr.Value;
  chkMatZakPodr.Checked := True;
  edtMatZak.OnChange := edtMatZakChange;
end;

procedure TfCalcResourceEdit.edtMatZakChange(Sender: TObject);
begin
  edtMatPodr.OnChange := nil;
  edtMatPodr.Value := 100 - edtMatZak.Value;
  chkMatZakPodr.Checked := True;
  edtMatPodr.OnChange := edtMatPodrChange;
end;

procedure TfCalcResourceEdit.edtMechCoastChange(Sender: TObject);
begin
  chkMechCoast.Checked := True;
end;

procedure TfCalcResourceEdit.edtMechNaklChange(Sender: TObject);
begin
  chkMechNakl.Checked := True;
end;

procedure TfCalcResourceEdit.edtMechPodrChange(Sender: TObject);
begin
  edtMechZak.OnChange := nil;
  edtMechZak.Value := 100 - edtMechPodr.Value;
  chkMechZakPodr.Checked := True;
  edtMechZak.OnChange := edtMechZakChange;
end;

procedure TfCalcResourceEdit.edtMechZakChange(Sender: TObject);
begin
  edtMechPodr.OnChange := nil;
  edtMechPodr.Value := 100 - edtMechZak.Value;
  chkMechZakPodr.Checked := True;
  edtMechPodr.OnChange := edtMechPodrChange;
end;

procedure TfCalcResourceEdit.edtMechZPMashChange(Sender: TObject);
begin
  chkMechZPMash.Checked := True;
end;

procedure TfCalcResourceEdit.edtMatTranspChange(Sender: TObject);
begin
  chkMatTransp.Checked := True;
end;

end.
