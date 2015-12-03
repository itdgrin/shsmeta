unit uSmKey;

interface
  uses System.SysUtils;


  function SmAssigned(AValue: Pointer): Boolean; export;
  function CheckKey(ABeginDate, AEndDate: TDateTime): Boolean; export;

implementation

function SmAssigned(AValue: Pointer): Boolean;
begin
  Result := AValue <> nil;
end;

function CheckKey(ABeginDate, AEndDate: TDateTime): Boolean;
begin
  Result := (Now >= ABeginDate) and (Now <= AEndDate);
end;

end.
