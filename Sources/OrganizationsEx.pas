unit OrganizationsEx;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls;

type
  TfOrganizationsEx = class(TForm)
    qrMain: TFDQuery;
    dsMain: TDataSource;
    grMain: TJvDBGrid;
    pnlBott: TPanel;
    btnCancel: TBitBtn;
    btnSelect: TBitBtn;
    pnl1: TPanel;
    lbl1: TLabel;
    dbnvgr1: TDBNavigator;
    edt1: TEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fOrganizationsEx: TfOrganizationsEx;

  // Возвращает clients.client_id выбранной организации
function SelectOrganization(const ALocateValue: Variant): Variant;

implementation

{$R *.dfm}

uses Tools;

function SelectOrganization(const ALocateValue: Variant): Variant;
begin
  Result := Null;
  if (not Assigned(fOrganizationsEx)) then
    fOrganizationsEx := TfOrganizationsEx.Create(nil);
  fOrganizationsEx.qrMain.Active := True;
  if not VarIsNull(ALocateValue) then
    fOrganizationsEx.qrMain.Locate('client_id', ALocateValue, []);
  fOrganizationsEx.btnSelect.Visible := True;
  if fOrganizationsEx.ShowModal = mrOk then
    Result := fOrganizationsEx.qrMain.FieldByName('client_id').AsInteger;
end;

procedure TfOrganizationsEx.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfOrganizationsEx.btnSelectClick(Sender: TObject);
begin
  qrMain.CheckBrowseMode;
  ModalResult := mrOk;
end;

procedure TfOrganizationsEx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfOrganizationsEx.FormCreate(Sender: TObject);
begin
  LoadDBGridSettings(grMain);
end;

procedure TfOrganizationsEx.FormDestroy(Sender: TObject);
begin
  fOrganizationsEx := nil;
end;

end.
