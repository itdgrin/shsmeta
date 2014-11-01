unit fFrameSmeta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TSmetaFrame = class(TFrame)
  protected
    fLoaded: boolean;
  public
    procedure ReceivingAll; Virtual; Abstract;
    property Loaded: boolean read fLoaded;
    constructor Create(AOwner: TComponent) ;
  end;

implementation

{$R *.dfm}

{ TSmetaFrame }

constructor TSmetaFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fLoaded := false;
end;

end.
