// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxMaximumProfileClass.pas' rev: 26.00 (Windows)

#ifndef FrxmaximumprofileclassHPP
#define FrxmaximumprofileclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <TTFHelpers.hpp>	// Pascal unit
#include <frxTrueTypeTable.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxmaximumprofileclass
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD MaximumProfile
{
public:
	System::Word maxComponentDepth;
	System::Word maxComponentElements;
	System::Word maxCompositeContours;
	System::Word maxCompositePoints;
	System::Word maxContours;
	System::Word maxFunctionDefs;
	System::Word maxInstructionDefs;
	System::Word maxPoints;
	System::Word maxSizeOfInstructions;
	System::Word maxStackElements;
	System::Word maxStorage;
	System::Word maxTwilightPoints;
	System::Word maxZones;
	System::Word numGlyphs;
	unsigned Version;
};
#pragma pack(pop)


class DELPHICLASS MaximumProfileClass;
#pragma pack(push,4)
class PASCALIMPLEMENTATION MaximumProfileClass : public Frxtruetypetable::TrueTypeTable
{
	typedef Frxtruetypetable::TrueTypeTable inherited;
	
private:
	MaximumProfile max_profile;
	
public:
	__fastcall MaximumProfileClass(Frxtruetypetable::TrueTypeTable* src);
	
private:
	HIDESBASE void __fastcall ChangeEndian(void);
	
public:
	virtual void __fastcall Load(void * font);
	virtual unsigned __fastcall Save(void * font, unsigned offset);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~MaximumProfileClass(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxmaximumprofileclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXMAXIMUMPROFILECLASS)
using namespace Frxmaximumprofileclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxmaximumprofileclassHPP
