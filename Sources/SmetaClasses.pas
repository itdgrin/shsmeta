unit SmetaClasses;

interface
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms;

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

{ TSmetaFrame }

constructor TSmetaFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fLoaded := false;
end;

end.
