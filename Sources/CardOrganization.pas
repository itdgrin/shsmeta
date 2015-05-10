unit CardOrganization;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, DB, Grids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Variants, Vcl.Mask, Vcl.DBCtrls;

type
  TfCardOrganization = class(TForm)
    Bevel: TBevel;
    ButtonSave: TButton;
    ButtonClose: TButton;
    lbl1: TLabel;
    dbedtNAME: TDBEdit;
    dbedtUNN: TDBEdit;
    dbedtACCOUNT: TDBEdit;
    dbedtOKPO: TDBEdit;
    dbedtADDRESS: TDBEdit;
    dbedtEMAIL: TDBEdit;
    dbedtPHONE: TDBEdit;
    dbedtRUK_PROF: TDBEdit;
    dbedtRUK_FIO: TDBEdit;
    dbedtCONTACT_FIO: TDBEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    dbedtFAX: TDBEdit;
    lbl12: TLabel;
    dbedtACCOUNT1: TDBEdit;
    lbl13: TLabel;
    lbl14: TLabel;
    dbedtBANK: TDBEdit;
    lbl15: TLabel;
    dbedtOKPO1: TDBEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    SkeepAskBeforeClose: Boolean;
  end;

var
  fCardOrganization: TfCardOrganization;

implementation

uses OrganizationsEx;

{$R *.dfm}

procedure TfCardOrganization.ButtonSaveClick(Sender: TObject);
begin
  fOrganizationsEx.qrMain.CheckBrowseMode;
  ModalResult := mrOk;
  SkeepAskBeforeClose := True;
  Close;
end;

procedure TfCardOrganization.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not SkeepAskBeforeClose then
  begin
    if MessageBox(0, PChar('«акрыть без сохранени€ сделанных изменений?'),
      PWideChar(fCardOrganization.Caption), MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) <> mrYes then
      CanClose := False
    else
      fOrganizationsEx.qrMain.Cancel;
  end;
end;

procedure TfCardOrganization.FormCreate(Sender: TObject);
begin
  SkeepAskBeforeClose := False;
end;

procedure TfCardOrganization.ButtonCloseClick(Sender: TObject);
begin
  fOrganizationsEx.qrMain.Cancel;
  ModalResult := mrCancel;
  Close;
end;

end.
