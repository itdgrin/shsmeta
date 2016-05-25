{******************************************}
{                                          }
{             FastReport v5.0              }
{        Helper classes for Exports        }
{                                          }
{         Copyright (c) 1998-2015          }
{          by Anton Khayrudinov            }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxExportHelpers;

{ General advice for using this export.

    � Avoid using vertical alignment in memos:
      it forces the export to create more
      complicated HTML. Leave the alignment vaTop
      whenever it's possible.

    � Use @-type anchors in TfrxView.URL instead of
      #-type, because #-type is much slower to export.}

interface

{$I frx.inc}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ShellAPI,
  Graphics,
  ComCtrls,
  frxClass,
  frxCrypto,    // for hashing pictures and CSS styles
  frxStorage,   // for TObjList and TCachedStream
  frxGradient
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

  { Represents a CSS style, like "div.page"}
type
  TfrxCSSStyle = class
  private
    FKeys, FValues: TStrings;
    FName: string;

    procedure SetStyle(Index: string; const Value: string);

  public

    constructor Create;
    destructor Destroy; override;

    function This: TfrxCSSStyle;
    function Count: Integer;
    function Text(Formatted: Boolean = False): string;
    procedure AssignTo(Dest: TfrxCSSStyle);

    property Style[Index: string]: string write SetStyle; default;
    property Name: string read FName write FName;
  end;

  { Represents a CSS (Cascading Style Sheet) with a list of CSS styles}

  TfrxCSS = class
    FStyles: TObjList;
    FStyleHashes: TList;

  protected

    function GetStyle(i: Integer): TfrxCSSStyle;
    function GetHash(const s: string): Integer;
    function GetStyleName(i: Integer): string;
    function GetStylesCount: Integer;

  public
    constructor Create;
    destructor Destroy; override;

    function Add(Style: TfrxCSSStyle): string; overload;
    function Add(const StyleName: string): TfrxCSSStyle; overload;

    procedure Save(Stream: TStream; Formatted: Boolean);
  end;

    { Saves pictures and ensures that there will not be identical copies saved }

  TfrxPictureInfo = record
    Extension: string;
    Mimetype: string;
  end;

  TfrxPictureStorage = class
  private
    FWorkDir: string;
    FHashes: TList;
  protected
    function GetHash(Stream: TMemoryStream): Integer;
  public
    constructor Create(const WorkDir: string);
    destructor Destroy; override;

    function Save(Pic: TGraphic): string;

    class function GetInfo(Pic: TGraphic): TfrxPictureInfo;
  end;

  { Generalised picture}

  TfrxPictureFormat = (pfPNG, pfEMF, pfBMP, pfJPG);

  TfrxPicture = class
  private
    FFormat: TfrxPictureFormat;
    FGraphic: TGraphic;
    FCanvas: TCanvas;
    FBitmap: TBitmap; // for TJPEGImage that doesn't provide a canvas
  public
    constructor Create(Format: TfrxPictureFormat; Width, Height: Integer);
    destructor Destroy; override;

    function Release: TGraphic;

    property Canvas: TCanvas read FCanvas;
  end;

  TfrxExportHandler = function(Obj: TfrxView): Boolean of object;

implementation

uses
  frxUtils,
  Math,
{$IFDEF Delphi12}
 pngimage,
{$ELSE}
 frxpngimage,
{$ENDIF}
  jpeg,
  frxXML;

function Join(const s: array of string; sn: Integer; Sep: Char): string;
var
  i, n, p: Integer;
begin
  if (sn = 0) or (sn > Length(s)) then
  begin
    Result := '';
    Exit;
  end;

  n := sn - 1;

  for i := 0 to sn - 1 do
    Inc(n, Length(s[i]));

  SetLength(Result, n);

  n := Length(s[0]);

  if n > 0 then
    Move(s[0][1], Result[1], n*SizeOf(Char));

  p := n + 1;

  for i := 1 to sn - 1 do
  begin
    Result[p] := Sep;
    n := Length(s[i]);

    if n > 0 then
      Move(s[i][1], Result[p + 1], n*SizeOf(Char));

    Inc(p, n + 1);
  end;
end;

{ TfrxCSSStyle }

constructor TfrxCSSStyle.Create;
begin
  FKeys := TStringList.Create;
  FValues := TStringList.Create;
end;

destructor TfrxCSSStyle.Destroy;
begin
  FKeys.Free;
  FValues.Free;
  inherited
end;

procedure TfrxCSSStyle.AssignTo(Dest: TfrxCSSStyle);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Dest[FKeys[i]] := FValues[i]
end;

function TfrxCSSStyle.Count: Integer;
begin
  Result := FKeys.Count
end;

procedure TfrxCSSStyle.SetStyle(Index: string; const Value: string);
begin
  if (Index = 'border-radius') or (Index = 'box-shadow') then
  begin
    SetStyle('-webkit-' + Index, Value);
    SetStyle('-moz-' + Index, Value);
    SetStyle('-o-' + Index, Value);
  end;

  FKeys.Add(Index);
  FValues.Add(Value);
end;

function TfrxCSSStyle.Text(Formatted: Boolean): string;
var
  Sep, Gap: string;
  i, j: Integer;
  Lines: array of string;
begin
  if Formatted then
  begin
    Sep := #13#10#9;
    Gap := ' ';
  end
  else
  begin
    Sep := '';
    Gap := '';
  end;

  SetLength(Lines, Count);
  j := 0;

  for i := 0 to Count - 1 do
    if FValues[i] <> '' then
    begin
      Lines[j] := Sep + FKeys[i] + ':' + Gap + string(UTF8Encode(FValues[i]));
      Inc(j);
  end;

  Result := Join(Lines, j, ';')
end;

function TfrxCSSStyle.This: TfrxCSSStyle;
begin
  Result := Self
end;

{ TfrxCSS }

constructor TfrxCSS.Create;
begin
  FStyles := TObjList.Create;
  FStyleHashes := TList.Create;
end;

destructor TfrxCSS.Destroy;
begin
  FStyles.Free;
  FStyleHashes.Free;
  inherited;
end;

function TfrxCSS.GetHash(const s: string): Integer;
begin
  if s = '' then
    Result := -1
  else
    TCryptoHash.Hash('Jenkins', Result, SizeOf(Result), s[1], Length(s)*SizeOf(s[1]))
end;

function TfrxCSS.GetStyle(i: Integer): TfrxCSSStyle;
begin
  if i < GetStylesCount then
    Result := TfrxCSSStyle(FStyles[i])
  else
    Result := nil
end;

function TfrxCSS.GetStyleName(i: Integer): string;
begin
  { There're two kinds of styles: with automatically generated names
    (added via Add(TfrxCSSStyle) and with specified names (added via
    Add(string)). This function returns a name for a style with
    automatically generated style. }

  if FStyleHashes[i] = nil then
    raise Exception.CreateFmt('Cannot generate style name for style #%d', [i]);

  Result := 's' + IntToStr(i)
end;

function TfrxCSS.GetStylesCount: Integer;
begin
  Result := FStyles.Count
end;

function TfrxCSS.Add(Style: TfrxCSSStyle): string;
var
  i: Integer;
  s: string;
  h: Integer;
begin
  {$IFDEF HTML_DEBUG}
  DbgTimerStart(TimerCSSAdd, 'CSS.Add(Style)');
  {$ENDIF}

  s := Style.Text;
  h := GetHash(s);

  {$IFDEF HTML_DEBUG}
  if h = 0 then
    DbgPrint('Style (%s) hash zero hash'#10, [Style.Text]);
  {$ENDIF}

  if h <> 0 then
    for i := 0 to GetStylesCount - 1 do
      if Integer(FStyleHashes[i]) = h then
        if GetStyle(i).Text = s then
        begin
          Style.Free;
          Result := GetStyleName(i);

          {$IFDEF HTML_DEBUG}
          DbgTimerStop(TimerCSSAdd);
          {$ENDIF}

          Exit;
        end;

  FStyles.Add(Style);
  FStyleHashes.Add(Pointer(h));

  Result := GetStyleName(GetStylesCount - 1);
  Style.Name := '.' + Result;

  {$IFDEF HTML_DEBUG}
  DbgTimerStop(TimerCSSAdd);
  {$ENDIF}
end;

function TfrxCSS.Add(const StyleName: string): TfrxCSSStyle;
begin
  Result := TfrxCSSStyle.Create;
  Result.Name := StyleName;

  FStyles.Add(Result);
  FStyleHashes.Add(nil); // zero hash
end;

procedure TfrxCSS.Save(Stream: TStream; Formatted: Boolean);

  function Encode(const s: string): string;
  begin
    Result := string(UTF8Encode(s))
  end;

  procedure Puts(const Text: string);
  var
    s: AnsiString;
  begin
    s := AnsiString(Text);
    Stream.Write(s[1], Length(s));
  end;

var
  i: Integer;
  Sep: string;
begin
  {$IFDEF HTML_DEBUG}
  DbgTimerStart(TimerCSSSave, 'CSS.Save');
  {$ENDIF}

  if Formatted then
    Sep := #13#10
  else
    Sep := '';

  for i := 0 to GetStylesCount - 1 do
    with GetStyle(i) do
      Puts(This.Name + Sep + '{' +
        Encode(This.Text(Formatted)) + Sep + '}' + Sep);

  {$IFDEF HTML_DEBUG}
  DbgTimerStop(TimerCSSSave);
  {$ENDIF}
end;

{ TfrxPictureStorage }

constructor TfrxPictureStorage.Create(const WorkDir: string);
begin
  FHashes := TList.Create;

  if (WorkDir = '') or (WorkDir[Length(WorkDir)] = '\') then
    FWorkDir := WorkDir
  else
    FWorkDir := WorkDir + '\';
end;

destructor TfrxPictureStorage.Destroy;
begin
  FHashes.Free;
  inherited;
end;

class function TfrxPictureStorage.GetInfo(Pic: TGraphic): TfrxPictureInfo;
var
  cn: string;
begin
  cn := Pic.ClassName;

  with Result do
    if cn = 'TMetafile' then
    begin
      Extension := '.emf';
      Mimetype := 'image/metafile';
    end
    else if cn = 'TBitmap' then
    begin
      Extension := '.bmp';
      Mimetype := 'image/bitmap';
    end
    else if cn = 'TPngImage' then
    begin
      Extension := '.png';
      Mimetype := 'image/png';
    end
    else if cn = 'TJPEGImage' then
    begin
      Extension := '.jpg';
      Mimetype := 'image/jpeg';
    end
    else
    begin
      Extension := '.pic';
      Mimetype := 'image/unknown';

      {$IFDEF HTML_DEBUG}
      DbgPrint('Graphic %s (unit %s) is unknown'#10, [Pic.ClassName, Pic.UnitName]);
      {$ENDIF}
    end
end;

function TfrxPictureStorage.GetHash(Stream: TMemoryStream): Integer;
begin
  TCryptoHash.Hash('Jenkins', Result, SizeOf(Result), Stream.Memory^, Stream.Size)
end;

function TfrxPictureStorage.Save(Pic: TGraphic): string;
var
  Stream: TMemoryStream;
  Ext: string;
  Hash, i: Integer;
begin
  Stream := TMemoryStream.Create;
  Pic.SaveToStream(Stream);
  Ext := GetInfo(Pic).Extension;
  Hash := GetHash(Stream);

  i := FHashes.IndexOf(Pointer(Hash));

  try
    if i >= 0 then
      Result := IntToStr(i) + Ext
    else
    begin
      Result := IntToStr(FHashes.Count) + Ext;
      Stream.SaveToFile(FWorkDir + Result);
      FHashes.Add(Pointer(Hash));
    end
  finally
    Stream.Free
  end
end;

{ TfrxPicture }

constructor TfrxPicture.Create(Format: TfrxPictureFormat; Width, Height: Integer);
begin
  case Format of
    pfPNG:
      begin
        FGraphic := TPngObject.CreateBlank(COLOR_RGB, 8, Width, Height);
        FCanvas := TPngObject(FGraphic).Canvas;
      end;

    pfEMF:
      begin
        FGraphic := TMetafile.Create;
        //FGraphic.SetSize(Width, Height);
        FGraphic.Width := Width;
        FGraphic.Height := Height;
        FCanvas := TMetafileCanvas.Create(TMetafile(FGraphic), 0);
      end;

    pfBMP:
      begin
        FGraphic := TBitmap.Create;
        FGraphic.Width := Width;
        FGraphic.Height := Height;
        //FGraphic.SetSize(Width, Height);
        FCanvas := TBitmap(FGraphic).Canvas;
      end;

    pfJPG:
      begin
        FGraphic := TJPEGImage.Create;
        FBitmap := TBitmap.Create;
        //FBitmap.SetSize(Width, Height);
        FBitmap.Width := Width;
        FBitmap.Height := Height;
        FCanvas := FBitmap.Canvas;
      end;

    else
      raise Exception.Create('Unknown picture format');
  end;

  FFormat := Format;
end;

destructor TfrxPicture.Destroy;
begin
  FGraphic.Free;
  inherited;
end;

function TfrxPicture.Release: TGraphic;
begin
  case FFormat of
    pfEMF:
      FCanvas.Free;

    pfJPG:
      begin
        FGraphic.Assign(FBitmap);
        FBitmap.Free;
      end;
  end;

  FCanvas := nil;
  Result := FGraphic;
end;

end.