// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxXMLSerializer.pas' rev: 26.00 (Windows)

#ifndef FrxxmlserializerHPP
#define FrxxmlserializerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <System.TypInfo.hpp>	// Pascal unit
#include <frxXML.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxxmlserializer
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TfrxGetAncestorEvent)(const System::UnicodeString ComponentName, System::Classes::TPersistent* &Ancestor);

class DELPHICLASS TfrxXMLSerializer;
class PASCALIMPLEMENTATION TfrxXMLSerializer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStringList* FErrors;
	System::Classes::TList* FFixups;
	Frxclass::TfrxComponent* FOwner;
	System::Classes::TReader* FReader;
	System::Classes::TMemoryStream* FReaderStream;
	bool FSerializeDefaultValues;
	System::Classes::TStream* FStream;
	bool FOldFormat;
	TfrxGetAncestorEvent FOnGetAncestor;
	Frxclass::TfrxGetCustomDataEvent FGetCustomDataEvent;
	Frxclass::TfrxSaveCustomDataEvent FOnSaveCustomDataEvent;
	bool FHandleNestedProperties;
	bool FSaveAncestorOnly;
	void __fastcall AddFixup(System::Classes::TPersistent* Obj, System::Typinfo::PPropInfo p, System::UnicodeString Value);
	void __fastcall ClearFixups(void);
	void __fastcall FixupReferences(void);
	
public:
	__fastcall TfrxXMLSerializer(System::Classes::TStream* Stream);
	__fastcall virtual ~TfrxXMLSerializer(void);
	System::UnicodeString __fastcall ObjToXML(System::Classes::TPersistent* Obj, const System::UnicodeString Add = System::UnicodeString(), System::Classes::TPersistent* Ancestor = (System::Classes::TPersistent*)(0x0));
	Frxclass::TfrxComponent* __fastcall ReadComponent(Frxclass::TfrxComponent* Root);
	Frxclass::TfrxComponent* __fastcall ReadComponentStr(Frxclass::TfrxComponent* Root, System::UnicodeString s, bool DontFixup = false);
	System::UnicodeString __fastcall WriteComponentStr(Frxclass::TfrxComponent* c);
	void __fastcall ReadRootComponent(Frxclass::TfrxComponent* Root, Frxxml::TfrxXMLItem* XMLItem = (Frxxml::TfrxXMLItem*)(0x0));
	void __fastcall CopyFixupList(System::Classes::TList* FixList);
	void __fastcall ReadPersistentStr(System::Classes::TComponent* Root, System::Classes::TPersistent* Obj, const System::UnicodeString s);
	void __fastcall WriteComponent(Frxclass::TfrxComponent* c);
	void __fastcall WriteRootComponent(Frxclass::TfrxComponent* Root, bool SaveChildren = true, Frxxml::TfrxXMLItem* XMLItem = (Frxxml::TfrxXMLItem*)(0x0), bool Streaming = false);
	void __fastcall XMLToObj(const System::UnicodeString s, System::Classes::TPersistent* Obj);
	__property System::Classes::TStringList* Errors = {read=FErrors};
	__property Frxclass::TfrxComponent* Owner = {read=FOwner, write=FOwner};
	__property System::Classes::TStream* Stream = {read=FStream};
	__property System::Classes::TList* Fixups = {read=FFixups};
	__property bool SerializeDefaultValues = {read=FSerializeDefaultValues, write=FSerializeDefaultValues, nodefault};
	__property TfrxGetAncestorEvent OnGetAncestor = {read=FOnGetAncestor, write=FOnGetAncestor};
	__property Frxclass::TfrxGetCustomDataEvent OnGetCustomDataEvent = {read=FGetCustomDataEvent, write=FGetCustomDataEvent};
	__property Frxclass::TfrxSaveCustomDataEvent OnSaveCustomDataEvent = {read=FOnSaveCustomDataEvent, write=FOnSaveCustomDataEvent};
	__property bool OldFormat = {read=FOldFormat, write=FOldFormat, nodefault};
	__property bool HandleNestedProperties = {read=FHandleNestedProperties, write=FHandleNestedProperties, nodefault};
	__property bool SaveAncestorOnly = {read=FSaveAncestorOnly, write=FSaveAncestorOnly, nodefault};
};


class DELPHICLASS TfrxFixupItem;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxFixupItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Classes::TPersistent* Obj;
	System::Typinfo::TPropInfo *PropInfo;
	System::UnicodeString Value;
public:
	/* TObject.Create */ inline __fastcall TfrxFixupItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxFixupItem(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxxmlserializer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXXMLSERIALIZER)
using namespace Frxxmlserializer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxxmlserializerHPP
