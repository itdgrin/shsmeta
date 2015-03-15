unit WinterPrise;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.ComCtrls, JvExComCtrls, JvDBTreeView, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Menus, Tools;

type
  TfWinterPrise = class(TForm)
    qrTreeData: TFDQuery;
    dsTreeData: TDataSource;
    tvEstimates: TJvDBTreeView;
    grp1: TGroupBox;
    lblCoef: TLabel;
    lblCoefZP: TLabel;
    lblCoefZPMach: TLabel;
    dbedtCOEF: TDBEdit;
    dbedtCOEF_ZP: TDBEdit;
    dbedtCOEF_ZP_MACH: TDBEdit;
    JvDBGrid1: TJvDBGrid;
    qrZnormativs_detail: TFDQuery;
    dsZnormativs_detail: TDataSource;
    pnl1: TPanel;
    btnClose: TBitBtn;
    btnSelect: TBitBtn;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public
    OutValue: Integer;
    Kind: TKindForm;
  end;

var
  fWinterPrise: TfWinterPrise;

implementation

uses DataModule;

{$R *.dfm}

procedure TfWinterPrise.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfWinterPrise.btnSelectClick(Sender: TObject);
begin
  OutValue := 0;
  if Application.MessageBox('Вы действительно хотите заменить коэф. зимнего удорожания в выбранной расценке?',
    'Application.Title', MB_OKCANCEL + MB_ICONQUESTION + MB_TOPMOST) = IDOK then
  begin
    OutValue := qrTreeData.FieldByName('ZNORMATIVS_ID').AsInteger;
    ModalResult := mrOk;
  end;
end;

procedure TfWinterPrise.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Kind := kdNone;
end;

procedure TfWinterPrise.FormCreate(Sender: TObject);
begin
  Kind := kdNone;
  LoadDBGridSettings(JvDBGrid1);
end;

procedure TfWinterPrise.FormShow(Sender: TObject);
begin
  case Kind of
    kdSelect:
      begin
        btnSelect.Visible := True;
      end;
  else
    begin
      btnSelect.Visible := False;
    end;
  end;
  CloseOpen(qrTreeData);
  CloseOpen(qrZnormativs_detail);
end;

end.
