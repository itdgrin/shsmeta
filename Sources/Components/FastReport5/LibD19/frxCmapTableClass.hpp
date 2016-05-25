// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxCmapTableClass.pas' rev: 26.00 (Windows)

#ifndef FrxcmaptableclassHPP
#define FrxcmaptableclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <TTFHelpers.hpp>	// Pascal unit
#include <frxTrueTypeTable.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcmaptableclass
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM EncodingFormats : unsigned char { ByteEncoding, HighByteMapping = 2, SegmentMapping = 4, TrimmedTable = 6 };

typedef System::DynamicArray<short> TSmallintArray;

typedef System::DynamicArray<System::Word> TWordArray;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TSegmentMapping
{
public:
	System::Word segCountX2;
	System::Word searchRange;
	System::Word entrySelector;
	System::Word rangeShift;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD Table_CMAP
{
public:
	System::Word TableVersion;
	System::Word NumSubTables;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD Table_Encode
{
public:
	System::Word Format;
	System::Word Length;
	System::Word Version;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD Table_SUBMAP
{
public:
	System::Word Platform;
	System::Word EncodingID;
	unsigned TableOffset;
};
#pragma pack(pop)


class DELPHICLASS CmapTableClass;
#pragma pack(push,4)
class PASCALIMPLEMENTATION CmapTableClass : public Frxtruetypetable::TrueTypeTable
{
	typedef Frxtruetypetable::TrueTypeTable inherited;
	
private:
	TWordArray endCount;
	TWordArray GlyphIndexArray;
	TSmallintArray idDelta;
	TWordArray idRangeOffset;
	TWordArray startCount;
	int segment_count;
	
public:
	__fastcall CmapTableClass(Frxtruetypetable::TrueTypeTable* src);
	System::Word __fastcall GetGlyphIndex(System::Word ch);
	
private:
	TWordArray __fastcall LoadCmapSegment(void * segment_ptr, int segment_count);
	
public:
	void __fastcall LoadCmapTable(void * font);
	
private:
	TSmallintArray __fastcall LoadSignedCmapSegment(void * segment_ptr, int segment_count);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~CmapTableClass(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxcmaptableclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCMAPTABLECLASS)
using namespace Frxcmaptableclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcmaptableclassHPP
