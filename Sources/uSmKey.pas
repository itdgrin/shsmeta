unit uSmKey;

interface
  uses Winapi.Windows, Winapi.Messages, System.SysUtils;


  function SmAssigned(AValue: Pointer): Boolean; export;
  function CheckKey(AHandle: THandle; ABeginDate, AEndDate: TDateTime): Boolean; export;

implementation
uses GlobsAndConst;

function SmAssigned(AValue: Pointer): Boolean;
begin
  Result := AValue <> nil;
end;

function CheckKey(AHandle: THandle; ABeginDate, AEndDate: TDateTime): Boolean;
begin
  Result := (Now >= ABeginDate) and (Now <= AEndDate);
  if not Result then
    PostMessage(AHandle, WM_CHECKLICENCE, 0, 0);
end;

end.
