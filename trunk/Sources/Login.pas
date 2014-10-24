unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls;

type
  TFormLogin = class(TForm)
    LabelUsername: TLabel;
    LabelPassword: TLabel;
    EditUsername: TEdit;
    EditPassword: TEdit;
    Image1: TImage;
    ButtonCancel: TButton;
    ButtonConnect: TButton;
    Bevel2: TBevel;
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonConnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

uses Main, ConnectDatabase;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormLogin.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormLogin.ButtonConnectClick(Sender: TObject);
begin
  FormConnectDatabase.ButtonConnectClick(nil);
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormLogin.FormShow(Sender: TObject);
begin
  Left := (FormMain.Width - Width) div 2;
  Top := (FormMain.Height - Height) div 2;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
