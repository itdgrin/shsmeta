
{******************************************}
{                                          }
{             FastScript v1.9              }
{            Registration unit             }
{                                          }
{  (c) 2003-2007 by Alexander Tzyganenko,  }
{             Fast Reports Inc             }
{                                          }
{******************************************}

unit fs_iibxreg;

{$i fs.inc}

interface


procedure Register;

implementation

uses
  Classes
{$IFNDEF Delphi6}
, DsgnIntf
{$ELSE}
{$IFDEF DELPHI16}
, Controls
{$ENDIF}
, DesignIntf
{$ENDIF}
, fs_iibxrtti;

{-----------------------------------------------------------------------}

procedure Register;
begin
{$IFDEF DELPHI16}
  //GroupDescendentsWith(TfsIBXRTTI, TControl);
{$ENDIF}
  RegisterComponents('FastScript', [TfsIBXRTTI]);
end;

end.
