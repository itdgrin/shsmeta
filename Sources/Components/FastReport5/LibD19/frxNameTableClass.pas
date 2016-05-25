unit frxNameTableClass;

interface

{$I frx.inc}

uses Windows, TTFHelpers, frxFontHeaderClass, frxTrueTypeTable;

type
  NameID = (NameID_CompatibleFull=$12, NameID_CopyrightNotice=0, NameID_Description=10, NameID_Designer=9,
  NameID_FamilyName=1, NameID_FullName=4, NameID_LicenseDescription=13, NameID_LicenseInfoURL=14,
  NameID_Manufacturer=8, NameID_PostscriptCID=20, NameID_PostscriptName=6, NameID_PreferredFamily=$10,
  NameID_PreferredSubFamily=$11, NameID_SampleText=$13, NameID_SubFamilyName=2, NameID_Trademark=7,
  NameID_UniqueID=3, NameID_URL_Designer=12, NameID_URL_Vendor=11, NameID_Version=5, NameID_WWS_Family_Name=$15,
  NameID_WWS_SubFamily_Name=$16);

  NamingTableHeader = packed record
      TableVersion: Word;
      Count: Word;
      stringOffset: Word;
  end;

  NamingRecord = packed record
      PlatformID: Word;
      EncodingID: Word;
      LanguageID: Word;
      NameID: Word;
      Length: Word;
      Offset: Word;
  end;

  NameTableClass = class(TrueTypeTable)
    // Fields
    private name_header: NamingTableHeader;
    private namerecord_ptr: Pointer;
    private string_storage_ptr: Pointer;

    // Methods
    public constructor Create(src: TrueTypeTable);
    destructor Destroy; override;
    private procedure ChangeEndian;
    public procedure Load(font: Pointer); override;
    private function  get_Item(Index: NameID): AnsiString;

    // Properties
    public property Item[Index: NameID]: AnsiString read get_Item;
  end;

  implementation

  constructor NameTableClass.Create(src: TrueTypeTable);
  begin
      inherited Create(src);
  end;

  destructor NameTableClass.Destroy;
  begin
      inherited Destroy;
  end;

  function  NameTableClass.get_Item(Index: NameID): AnsiString;
  var
    i,sz:  Integer;
    name_record_ptr: ^NamingRecord;
    name_rec: NamingRecord;
    string_ptr: Pointer;

    p: PAnsiChar;

  begin
    Result := '';
    name_record_ptr := namerecord_ptr;
    for i := 0 to name_header.Count do
    begin
      name_rec.PlatformID := SwapUInt16(name_record_ptr.PlatformID);
      name_rec.EncodingID := SwapUInt16(name_record_ptr.EncodingID);
      name_rec.LanguageID := SwapUInt16(name_record_ptr.LanguageID);
      name_rec.NameID := SwapUInt16(name_record_ptr.NameID);
      name_rec.Length := SwapUInt16(name_record_ptr.Length);
      name_rec.Offset := SwapUInt16(name_record_ptr.Offset);

      if (((name_rec.PlatformID = 3) and (name_rec.EncodingID = 1))
            or (name_rec.PlatformID = 0)) and (NameID(name_rec.NameID) = Index) then
      begin
        { Dirty dirty hack with +1 }
        string_ptr := TTF_Helpers.Increment(string_storage_ptr, name_rec.Offset + 1);
        GetMem(p, name_rec.Length);
        sz := WideCharToMultiByte( CP_ACP, 0, string_ptr, name_rec.Length Div 2, p, name_rec.Length, nil, nil);
        Result := p;
        if sz > 0 then SetLength(Result, sz);
        FreeMem(p);
        Exit
      end;
      Inc(name_record_ptr);
    end;
  end;

  procedure NameTableClass.ChangeEndian;
  begin
    self.name_header.Count := TTF_Helpers.SwapUInt16(self.name_header.Count);
    self.name_header.stringOffset := TTF_Helpers.SwapUInt16(self.name_header.stringOffset);
    self.name_header.TableVersion := TTF_Helpers.SwapUInt16(self.name_header.TableVersion);
  end;

  procedure NameTableClass.Load(font: Pointer);
  var
    pNTH:               ^NamingTableHeader;
  begin
    pNTH := TTF_Helpers.Increment( font, self.entry.offset );
    name_header.TableVersion  := pNTH.TableVersion;
    name_header.stringOffset  := pNTH.stringOffset;
    name_header.Count         := pNTH.Count;
    ChangeEndian;
    namerecord_ptr := Pointer(NativeInt(pNTH) + SizeOf(NamingTableHeader));
    string_storage_ptr := Pointer(NativeInt(pNTH) + name_header.stringOffset);
  end;

end.
