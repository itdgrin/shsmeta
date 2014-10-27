unit Waiting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, gifImg, JvExControls, JvAnimatedImage, JvGIFCtrl;

type
  TFormWaiting = class(TForm)
    Shape1: TShape;
    Label1: TLabel;
    JvGIFAnimator1: TJvGIFAnimator;

    procedure FormCreate(Sender: TObject);
  private

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
  // Расположение файла
  FileName := ExtractFilePath(Application.ExeName) + 'Settings\Waiting.gif';

  // Если файл существует, открываем его
  if FileExists(FileName) then
    JvGIFAnimator1.Image.LoadFromFile(FileName);
end;
end.
