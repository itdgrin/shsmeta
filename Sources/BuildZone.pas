unit BuildZone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, JvComponentBase, JvFormPlacement;

type
  TfBuildZone = class(TForm)
    lbl1: TLabel;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    redt1: TRichEdit;
    redt2: TRichEdit;
    FormStorage: TJvFormStorage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fBuildZone: TfBuildZone;

implementation

{$R *.dfm}
uses Main;

end.
