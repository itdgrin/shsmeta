unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  System.IOUtils;

type
  TMainForm = class(TForm)
    edtLocalDate: TEdit;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Bevel1: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtUser: TEdit;
    dateAct: TDateTimePicker;
    dateEnd: TDateTimePicker;
    lbLocalID: TLabel;
    edtLocalID: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses uMemoryLoader, winioctl, hwid_impl, SerialKeyModule, RC6;

{$R *.dfm}

procedure TMainForm.Button1Click(Sender: TObject);
var SI: TSerialKeyInfo;
    aa: TBytes;
    KeyDll, LocalData: TMemoryStream;
    SN: string;
begin
  if not TFile.Exists(edtLocalDate.Text) then
    raise Exception.Create('Укажите путь к файлу с локальными данными пользователя.');
  if not TFile.Exists(ExtractFilePath(Application.ExeName) + 'SmKey.dll') then
    raise Exception.Create('Файл SmKey.dll не найден.');

  if SaveDialog1.Execute(Self.Handle) then
  begin
    KeyDll := TMemoryStream.Create;
    LocalData := TMemoryStream.Create;
    try
      SaveDialog1.FileName := ChangeFileExt(SaveDialog1.FileName, '.key');
      KeyDll.LoadFromFile(ExtractFilePath(Application.ExeName) + 'SmKey.dll');

      SI.UserName := edtUser.Text;
      SetLength(SI.UserKey, 16);
      FillChar(SI.UserKey[0], Length(SI.UserKey), 0);
      SI.DateBegin := dateAct.Date;
      SI.DateEnd := dateEnd.Date;
      SI.LocalID := StrToInt64Def(edtLocalID.Text,0);

      LocalData.LoadFromFile(edtLocalDate.Text);
      GetLocalDataFromFile(SN, aa, LocalData);
      GetLocalKey(aa);
      CreateKeyFile(SaveDialog1.FileName, aa, SI, KeyDll);
      Showmessage('Файл "' + SaveDialog1.FileName + '" создан успешно.');
    finally
      FreeAndNil(LocalData);
      FreeAndNil(KeyDll);
    end;
  end;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
var LocalFile: TFileStream;
    LData: TBytes;
    SN: string;
begin
  if OpenDialog1.Execute(Self.Handle) then
  begin
    LocalFile := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
    try
      edtLocalDate.Text := OpenDialog1.FileName;
      GetLocalDataFromFile(SN, LData, LocalFile);
      Edit1.Text := SN;
      Edit2.Text := TEncoding.Default.GetString(LData);
    finally
      FreeAndNil(LocalFile);
    end;
  end;
end;

end.
