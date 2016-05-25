// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxKerningTableClass.pas' rev: 26.00 (Windows)

#ifndef FrxkerningtableclassHPP
#define FrxkerningtableclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <TTFHelpers.hpp>	// Pascal unit
#include <frxFontHeaderClass.hpp>	// Pascal unit
#include <frxTrueTypeTable.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxkerningtableclass
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD CommonKerningHeader
{
public:
	System::Word Coverage;
	System::Word Length;
	System::Word Version;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD FormatZero
{
public:
	System::Word entrySelector;
	System::Word nPairs;
	System::Word rangeShift;
	System::Word searchRange;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD FormatZeroPair
{
public:
	unsigned key_value;
	short value;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD KerningTableHeader
{
public:
	System::Word Version;
	System::Word nTables;
};
#pragma pack(pop)


class DELPHICLASS KerningSubtableClass;
#pragma pack(push,4)
class PASCALIMPLEMENTATION KerningSubtableClass : public Ttfhelpers::TTF_Helpers
{
	typedef Ttfhelpers::TTF_Helpers inherited;
	
private:
	CommonKerningHeader common_header;
	
public:
	__fastcall KerningSubtableClass(void * kerning_table_ptr);
	__fastcall virtual ~KerningSubtableClass(void);
	
private:
	short __fastcall get_Item(unsigned inx);
	
public:
	__property short Item[unsigned hash_value] = {read=get_Item};
	__property System::Word Length = {read=common_header.Length, nodefault};
};

#pragma pack(pop)

class DELPHICLASS KerningTableClass;
#pragma pack(push,4)
class PASCALIMPLEMENTATION KerningTableClass : public Frxtruetypetable::TrueTypeTable
{
	typedef Frxtruetypetable::TrueTypeTable inherited;
	
private:
	KerningTableHeader kerning_table_header;
	System::Classes::TList* kerning_subtables_collection;
	
public:
	__fastcall KerningTableClass(Frxtruetypetable::TrueTypeTable* src);
	__fastcall virtual ~KerningTableClass(void);
	
private:
	HIDESBASE void __fastcall ChangeEndian(void);
	
public:
	virtual void __fastcall Load(void * font);
	
private:
	short __fastcall get_Item(unsigned idx);
	
public:
	__property short Item[unsigned hash_value] = {read=get_Item};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxkerningtableclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXKERNINGTABLECLASS)
using namespace Frxkerningtableclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxkerningtableclassHPP
