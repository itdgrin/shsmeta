unit frxCollections;

interface

{$I frx.inc}

uses
  SysUtils, {$IFNDEF FPC}Windows, Messages,{$ENDIF} Classes;

type

  { TfrxCollectionItem }

  TfrxCollectionItem = class(TCollectionItem)
  protected
    FInheritedName: String;
    FIsInherited: Boolean;
    function GetInheritedName: String; virtual;
    procedure SetInheritedName(const Value: String); virtual;
    function IsNameStored: Boolean; virtual;
  public
{$IFDEF FPC}
    constructor Create(ACollection: TCollection); override;
{$ENDIF}
    procedure CreateUniqueName;
    property IsInherited: Boolean read FIsInherited write FIsInherited;
  published
    property InheritedName: String read GetInheritedName write SetInheritedName stored IsNameStored;
  end;

{$WARNINGS OFF}
  TfrxCollection = class(TCollection)
  protected
{$IFNDEF FPC}
    procedure Added(var Item: TCollectionItem); override;
{$ENDIF}
  public
    procedure SerializeProperties(Writer: TObject; Ancestor: TfrxCollection; Owner: TComponent); virtual;
    procedure DeserializeProperties(PropName: String; Reader: TObject; Ancestor: TfrxCollection); virtual;
    function FindByName(Name: String): TfrxCollectionItem; virtual;
  end;
{$WARNINGS ON}

implementation

uses frxXMLSerializer;

{ TfrxCollectionItem }

procedure TfrxCollectionItem.CreateUniqueName;
var
  i: Integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupIgnore;

  for i := 0 to Collection.Count - 1 do
    sl.Add(TfrxCollectionItem(Collection.Items[i]).InheritedName);

  i := 1;
  while sl.IndexOf(String(ClassName) + IntToStr(i)) <> -1 do
    Inc(i);

  InheritedName := String(ClassName) + IntToStr(i);
  sl.Free;
end;

function TfrxCollectionItem.GetInheritedName: String;
begin
  Result := FInheritedName;
end;

function TfrxCollectionItem.IsNameStored: Boolean;
begin
  Result := False;
end;

{$IFDEF FPC}
constructor TfrxCollectionItem.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  CreateUniqueName;
end;
{$ENDIF}

procedure TfrxCollectionItem.SetInheritedName(const Value: String);
begin
  FInheritedName := Value;
end;

{ TfrxCollection }

{$WARNINGS OFF}
{$IFNDEF FPC}
procedure TfrxCollection.Added(var Item: TCollectionItem);
begin
  inherited;
  if Item is TfrxCollectionItem then
    TfrxCollectionItem(Item).CreateUniqueName;
end;
{$ENDIF}
{$WARNINGS ON}

procedure TfrxCollection.DeserializeProperties(PropName: String;
  Reader: TObject; Ancestor: TfrxCollection);
begin

end;

function TfrxCollection.FindByName(Name: String): TfrxCollectionItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if TfrxCollectionItem(Items[i]).InheritedName = Name then
    begin
      Result := TfrxCollectionItem(Items[i]);
      Exit;
    end;
end;

procedure TfrxCollection.SerializeProperties(Writer: TObject;
  Ancestor: TfrxCollection; Owner: TComponent);
begin
end;

end.


