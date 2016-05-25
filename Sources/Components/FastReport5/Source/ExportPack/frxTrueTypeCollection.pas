unit frxTrueTypeCollection;

interface

{$I frx.inc}

uses
  Classes, SysUtils, Graphics, Windows,
  TTFHelpers, frxTrueTypeFont, frxFontHeaderClass, frxNameTableClass
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF};


type // Nested Types

  TFontCollection = TList;
  TTCollectionHeader = packed record
      TTCTag: Cardinal;
      Version: Cardinal;
      numFonts: Cardinal;
  end;

  TrueTypeCollection = class(TTF_Helpers)
    // Fields
    private fonts_collection: TFontCollection;

    private function get_FontCollection: TFontCollection;
    private function get_Item(FamilyName: string): TrueTypeFont;

    // Methods
    public constructor Create;
    destructor Destroy; override;
    public procedure Initialize(FD: PAnsiChar; FontDataSize: Longint);
    public function PackFont(font: Tfont; UsedAlphabet: TList) : TByteArray;

    // Properties
    public property FontCollection: TFontCollection read get_FontCollection;
    public property Item[FamilyName: string]: TrueTypeFont read get_Item;
  end;

{$WARNINGS OFF}
const
    // You may put national font names here
    Elements =10;
    Substitutes  : array  [1..Elements] of AnsiString = (
      'ＭＳ ゴシック',        'MS Gothic',
      'ＭＳ Ｐゴシック',     'MS PGothic',
      'ＭＳ 明朝',              'MS Mincho',
      'ＭＳ Ｐ明朝',           'MS PMincho',
      'メイリオ',               'Meiryo'
    );

implementation

  function TrueTypeCollection.get_FontCollection: TFontCollection;
  begin
    Result := fonts_collection;
  end;

  function TrueTypeCollection.get_Item(FamilyName: string): TrueTypeFont;
  var
    font: TrueTypeFont;
    nt: NameTableClass;
    s : String;
    i:  Integer;
  begin
    Result := nil;
    for i := 0 to fonts_collection.Count - 1 do
    begin
      font := TrueTypeFont(fonts_collection[i]);
      nt := font.Names;
      s := nt.Item[NameID_UniqueID];
      if s = FamilyName then
      begin
        Result := font;
        break
      end;
    end;
    if  Result = nil then raise Exception.Create('Font not found in collection');
  end;


  constructor TrueTypeCollection.Create;
  begin
    self.fonts_collection := TFontCollection.Create;
  end;

  destructor TrueTypeCollection.Destroy;
  var
    font: TrueTypeFont;
    i:  Integer;
  begin
    for i := 0 to fonts_collection.Count - 1 do
    begin
      font := TrueTypeFont(fonts_collection[i]);
      font.Free;
    end;
    fonts_collection.Free;
  end;

  procedure TrueTypeCollection.Initialize(FD: PAnsiChar; FontDataSize: Longint);
  var
    CollectionMode:   FontType;
    i: Cardinal;
    f: TrueTypeFont;
    pch: ^TTCollectionHeader;
    ch: TTCollectionHeader;
    subfont_table: ^Cardinal;
    subfont_idx: Cardinal;
    subfont_ptr: Pointer;
  begin
    if (FD[0] = AnsiChar(0)) and (FD[1] = AnsiChar(1)) and (FD[2] = AnsiChar(0)) and (FD[3] = AnsiChar(0)) then
      CollectionMode := FontType_TrueTypeFontType
    else if (FD[0] = 't') and (FD[1] = 't') and (FD[2] = 'c') and (FD[3] = 'f') then
      CollectionMode := FontType_TrueTypeCollection
    else if (FD[0] = 'O') and (FD[1] = 'T') and (FD[2] = 'T') and (FD[3] = 'O') then
      CollectionMode := FontType_OpenTypeFontType
    else
      raise Exception.Create('TrueType font format error');

    if (CollectionMode = FontType_TrueTypeFontType) then
    begin
      f := TrueTypeFont.Create( Pointer(FD), Pointer(FD), ChecksumFaultAction_Warn);
      self.fonts_collection.Add( f )
    end else if (CollectionMode = FontType_TrueTypeCollection) then
    begin
        pch := Pointer(FD);
        ch.TTCTag := TTF_Helpers.SwapUInt32(pch.TTCTag);
        ch.Version := TTF_Helpers.SwapUInt32(pch.Version);
        ch.numFonts := TTF_Helpers.SwapUInt32(pch.numFonts);
        case ch.Version of
        $10000: subfont_table := TTF_Helpers.Increment( pch, 12 ); // Version 1
        $20000: subfont_table := TTF_Helpers.Increment( pch, 12 ); // Version 2
        else raise Exception.Create('Unknown font collection version');
        end;

        i := 0;
        while i < ch.numFonts do
        begin
            subfont_idx := TTF_Helpers.SwapUInt32( subfont_table^ );
            subfont_ptr := TTF_Helpers.Increment( FD, subfont_idx);
            f := TrueTypeFont.Create(FD, subfont_ptr, ChecksumFaultAction_Warn);
            self.fonts_collection.Add( f );
            inc(i);
            inc( subfont_table, 1)
        end
    end
  end;

  function TrueTypeCollection.PackFont( font: Tfont; UsedAlphabet: TList) : TByteArray;
  var
    i, j:       Integer;
    ttf:       TrueTypeFont;
    skip_list:  TList;
    ch:         WideChar;
    s:          WideString;
    Name:       WideString;
    Transform:   WideString;
  begin
    Result := nil;
    if (self.fonts_collection.Count = 0) then Exit;
    skip_list := TList.Create;
    skip_list.Add( Pointer(TablesID_EmbedBitmapLocation));
    skip_list.Add( Pointer(TablesID_EmbededBitmapData));
    skip_list.Add( Pointer(TablesID_HorizontakDeviceMetrix));
    skip_list.Add( Pointer(TablesID_VerticalDeviceMetrix));
    skip_list.Add( Pointer(TablesID_DigitalSignature));

    Name := font.Name;

    i := 1;
    while i <= ((High(Substitutes)-Low(Substitutes)) ) do
    begin
      Transform := UTF8Decode(Substitutes[i]);
      if Transform = Name then
      begin
        Name := Substitutes[i+1];
        break;
      end;
      i := i + 2;
    end;

    if fsBold in font.Style   then Name := Name + ' Bold';
    if fsItalic in font.Style then Name := Name + ' Italic';

    ttf := nil;
    for i := 0 to Self.fonts_collection.Count - 1 do
    begin
      ttf := TrueTypeFont(Self.fonts_collection[i]);
      ttf.PrepareFont( skip_list );
      s := ttf.Names.Item[NameID_FullName];
      if s = Name then
      begin
        break;
      end;
    end;

    if ttf <> nil then
    begin
      for j := 0 to UsedAlphabet.Count - 1 do
      begin
        ch := WideChar(UsedAlphabet[j]);
        ttf.AddCharacterToKeepList(ch);
      end;
      Result := ttf.PackFont(FontType_TrueTypeFontType, True);
    end;
    skip_list.Free;
  end;
{$WARNINGS ON}
end.
