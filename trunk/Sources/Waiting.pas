unit Waiting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, gifImg;

type
  TFormWaiting = class(TForm)
    Shape1: TShape;
    Label1: TLabel;
    Image: TImage;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    Gif: TGIFImage;

  public

  end;

var
  FormWaiting: TFormWaiting;

implementation

uses Main;

{$R *.dfm}

procedure TFormWaiting.FormCreate(Sender: TObject);
var
  FileName: String;
begin
  Gif := TGIFImage.Create;

  // Расположение файла
  FileName := ExtractFilePath(Application.ExeName) + 'Settings\Waiting.gif';

  // Если файл существует, открываем его
  if FileExists(FileName) then
    Gif.LoadFromFile(FileName);

  Gif.Animate := True;

  Image.Picture.Assign(Gif);
end;

procedure TFormWaiting.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Gif);
end;

end.
