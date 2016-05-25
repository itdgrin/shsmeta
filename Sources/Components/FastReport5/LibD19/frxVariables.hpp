// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxVariables.pas' rev: 26.00 (Windows)

#ifndef FrxvariablesHPP
#define FrxvariablesHPP

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
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <frxXML.hpp>	// Pascal unit
#include <frxCollections.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxvariables
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxVariable;
class PASCALIMPLEMENTATION TfrxVariable : public Frxcollections::TfrxCollectionItem
{
	typedef Frxcollections::TfrxCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	System::Variant FValue;
	
protected:
	virtual System::UnicodeString __fastcall GetInheritedName(void);
	virtual bool __fastcall IsNameStored(void);
	
public:
	__fastcall virtual TfrxVariable(System::Classes::TCollection* ACollection);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property System::Variant Value = {read=FValue, write=FValue};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxVariable(void) { }
	
};


class DELPHICLASS TfrxVariables;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxVariables : public Frxcollections::TfrxCollection
{
	typedef Frxcollections::TfrxCollection inherited;
	
public:
	System::Variant operator[](System::UnicodeString Index) { return Variables[Index]; }
	
private:
	TfrxVariable* __fastcall GetItems(int Index);
	System::Variant __fastcall GetVariable(System::UnicodeString Index);
	void __fastcall SetVariable(System::UnicodeString Index, const System::Variant &Value);
	
public:
	__fastcall TfrxVariables(void);
	HIDESBASE TfrxVariable* __fastcall Add(void);
	HIDESBASE TfrxVariable* __fastcall Insert(int Index);
	int __fastcall IndexOf(const System::UnicodeString Name);
	void __fastcall AddVariable(const System::UnicodeString ACategory, const System::UnicodeString AName, const System::Variant &AValue);
	void __fastcall DeleteCategory(const System::UnicodeString Name);
	void __fastcall DeleteVariable(const System::UnicodeString Name);
	void __fastcall GetCategoriesList(System::Classes::TStrings* List, bool ClearList = true);
	void __fastcall GetVariablesList(const System::UnicodeString Category, System::Classes::TStrings* List);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromXMLItem(Frxxml::TfrxXMLItem* Item, bool OldXMLFormat = true);
	void __fastcall SaveToFile(const System::UnicodeString FileName);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall SaveToXMLItem(Frxxml::TfrxXMLItem* Item);
	__property TfrxVariable* Items[int Index] = {read=GetItems};
	__property System::Variant Variables[System::UnicodeString Index] = {read=GetVariable, write=SetVariable/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxVariables(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxArray;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxArray : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	System::Variant operator[](System::Variant Index) { return Variables[Index]; }
	
private:
	TfrxVariable* __fastcall GetItems(int Index);
	System::Variant __fastcall GetVariable(const System::Variant &Index);
	void __fastcall SetVariable(const System::Variant &Index, const System::Variant &Value);
	
public:
	__fastcall TfrxArray(void);
	int __fastcall IndexOf(const System::Variant &Name);
	__property TfrxVariable* Items[int Index] = {read=GetItems};
	__property System::Variant Variables[System::Variant Index] = {read=GetVariable, write=SetVariable/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxArray(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxvariables */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXVARIABLES)
using namespace Frxvariables;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxvariablesHPP
