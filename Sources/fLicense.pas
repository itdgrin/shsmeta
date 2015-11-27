unit fLicense;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ExtCtrls, JvExControls, JvLabel, JvExStdCtrls, JvHtControls,
  Vcl.Imaging.pngimage;

type
  TLicenseForm = class(TForm)
    ButtonPanel: TPanel;
    MainPanel: TPanel;
    imgLicense: TImage;
    btnClose: TButton;
    lbTitle: TJvHTLabel;
    lbTitleState: TJvLabel;
    lbState: TLabel;
    Bevel1: TBevel;
    lbUserNameTitle: TJvLabel;
    lbActDateTitle: TJvLabel;
    lbEndDateTitle: TJvLabel;
    lbLicenFileTitle: TJvLabel;
    lbLicenFile: TJvLabel;
    lbEndDate: TJvLabel;
    lbActDate: TJvLabel;
    lbUserName: TJvLabel;
    Bevel2: TBevel;
    btnNewLicense: TButton;
    btnSaveDataFile: TButton;
    edtSerial1: TEdit;
    edtSerial2: TEdit;
    edtSerial3: TEdit;
    edtSerial4: TEdit;
    lbSerialTitle: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pmNewLicense: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure btnNewLicenseDropDownClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtSerial1Change(Sender: TObject);
    procedure edtSerial1Enter(Sender: TObject);
    procedure edtSerial1Exit(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LicenseForm: TLicenseForm;

implementation

{$R *.dfm}

procedure TLicenseForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TLicenseForm.btnNewLicenseDropDownClick(Sender: TObject);
var Point: TPoint;
begin
  Point.X := btnNewLicense.Left;
  Point.Y := btnNewLicense.Top + btnNewLicense.Height;
  Point := MainPanel.ClientToScreen(Point);
  pmNewLicense.Popup(Point.X, Point.Y);
end;

procedure TLicenseForm.edtSerial1Change(Sender: TObject);
begin
  if Length((Sender as TEdit).Text) >= 4 then
    SelectNext((Sender as TEdit), True, True);
end;

procedure TLicenseForm.edtSerial1Enter(Sender: TObject);
var
  Layout: array[0.. KL_NAMELENGTH] of char;
begin
 (Sender as TEdit).Tag := LoadKeyboardLayout(StrCopy(Layout,'00000409'),KLF_ACTIVATE);
end;

procedure TLicenseForm.edtSerial1Exit(Sender: TObject);
begin
  UnloadKeyboardLayout((Sender as TEdit).Tag);
end;

procedure TLicenseForm.N1Click(Sender: TObject);
begin
  //Передача данных через иент на сервер и сохрание ответа
end;

end.
