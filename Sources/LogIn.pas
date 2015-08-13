unit LogIn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfLogIn = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    btn1: TBitBtn;
    btn2: TBitBtn;
    edt1: TEdit;
    edt2: TEdit;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLogIn: TfLogIn;

implementation

{$R *.dfm}

procedure TfLogIn.btn1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfLogIn.btn2Click(Sender: TObject);
begin
  Close;
end;

end.
