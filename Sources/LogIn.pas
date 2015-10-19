unit LogIn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Tools,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, JvComponentBase, JvFormPlacement;

type
  TfLogIn = class(TSmForm)
    lbl1: TLabel;
    lbl2: TLabel;
    btn1: TBitBtn;
    btn2: TBitBtn;
    edtName: TEdit;
    edtPass: TEdit;
    FormStorage: TJvFormStorage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLogIn: TfLogIn;

implementation

{$R *.dfm}

uses Main, DataModule, GlobsAndConst;

procedure TfLogIn.btn2Click(Sender: TObject);
var
  res: Variant;
begin
  res := FastSelectSQLOne('SELECT USER_ID FROM USER WHERE UPPER(USER_NAME)=UPPER(:0) AND USER_PASS=:1',
    VarArrayOf([Trim(edtName.Text), Trim(edtPass.Text)]));
  if VarIsNull(res) then
  begin
    Application.MessageBox('Неверное имя пользователя или пароль!'#13 + 'Повторите попытку.',
      'Авторизация пользователя', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  end
  else
  begin
    try
      FastExecSQL('UPDATE USER SET USER_LAST_LOGIN_TIME=:0 WHERE USER_ID=:1', VarArrayOf([Now, res]));
    except
      Application.MessageBox('Ошибка обновления даты последнего входа!', 'Авторизация пользователя',
        MB_OK + MB_ICONSTOP + MB_TOPMOST);
    end;
    G_USER_ID := res;
    ModalResult := mrOk;
  end;
end;

procedure TfLogIn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfLogIn.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfLogIn.FormDestroy(Sender: TObject);
begin
  fLogIn := nil;
end;

procedure TfLogIn.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ([ssCtrl, ssShift] = Shift) and (Key = VK_RETURN) then
  begin
    G_USER_ID := -1;
    ModalResult := mrOk;
  end;
end;

end.
