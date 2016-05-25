
{******************************************}
{                                          }
{             FastReport v5.0              }
{                OLE RTTI                  }
{                                          }
{         Copyright (c) 1998-2014          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxOLERTTI;

interface

{$I frx.inc}

implementation

uses
  Windows, Classes, Types, SysUtils, Forms, fs_iinterpreter, frxOLE, frxClassRTTI, Variants;
  

type
  TFunctions = class(TfsRTTIModule)
  private
    function GetProp(Instance: TObject; ClassType: TClass;
      const PropName: String): Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end;


{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
    AddEnum('TfrxSizeMode', 'fsmClip, fsmScale');
    with AddClass(TfrxOLEView, 'TfrxView') do
      AddProperty('OleContainer', 'TOleContainer', GetProp, nil);
  end;
end;

function TFunctions.GetProp(Instance: TObject; ClassType: TClass;
  const PropName: String): Variant;
begin
  Result := 0;

  if ClassType = TfrxOLEView then
  begin
    if PropName = 'OLECONTAINER' then
      Result := frxInteger(TfrxOLEView(Instance).OleContainer)
  end
end;


initialization
  fsRTTIModules.Add(TFunctions);

finalization
  if fsRTTIModules <> nil then
    fsRTTIModules.Remove(TFunctions);

end.


