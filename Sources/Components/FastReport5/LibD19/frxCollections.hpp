// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxCollections.pas' rev: 26.00 (Windows)

#ifndef FrxcollectionsHPP
#define FrxcollectionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcollections
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxCollectionItem;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCollectionItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
protected:
	System::UnicodeString FInheritedName;
	bool FIsInherited;
	virtual System::UnicodeString __fastcall GetInheritedName(void);
	virtual void __fastcall SetInheritedName(const System::UnicodeString Value);
	virtual bool __fastcall IsNameStored(void);
	
public:
	void __fastcall CreateUniqueName(void);
	__property bool IsInherited = {read=FIsInherited, write=FIsInherited, nodefault};
	
__published:
	__property System::UnicodeString InheritedName = {read=GetInheritedName, write=SetInheritedName, stored=IsNameStored};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxCollectionItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxCollectionItem(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxCollection;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCollection : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
protected:
	virtual void __fastcall Added(System::Classes::TCollectionItem* &Item);
	
public:
	virtual void __fastcall SerializeProperties(System::TObject* Writer, TfrxCollection* Ancestor, System::Classes::TComponent* Owner);
	virtual void __fastcall DeserializeProperties(System::UnicodeString PropName, System::TObject* Reader, TfrxCollection* Ancestor);
	virtual TfrxCollectionItem* __fastcall FindByName(System::UnicodeString Name);
public:
	/* TCollection.Create */ inline __fastcall TfrxCollection(System::Classes::TCollectionItemClass ItemClass) : System::Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxCollection(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxcollections */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCOLLECTIONS)
using namespace Frxcollections;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcollectionsHPP
