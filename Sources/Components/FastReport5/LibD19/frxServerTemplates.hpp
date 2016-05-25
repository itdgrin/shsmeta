// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerTemplates.pas' rev: 26.00 (Windows)

#ifndef FrxservertemplatesHPP
#define FrxservertemplatesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <frxServerVariables.hpp>	// Pascal unit
#include <frxServerSSI.hpp>	// Pascal unit
#include <frxServerUtils.hpp>	// Pascal unit
#include <frxServerConfig.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxservertemplates
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxServerTemplate;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxServerTemplate : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Frxservervariables::TfrxServerVariables* FVariables;
	Frxserverssi::TfrxSSIStream* FSSI;
	System::Classes::TStringList* FTemplate;
	
public:
	__fastcall TfrxServerTemplate(void);
	__fastcall virtual ~TfrxServerTemplate(void);
	void __fastcall Clear(void);
	void __fastcall Prepare(void);
	void __fastcall SetTemplate(const System::UnicodeString Name);
	__property System::Classes::TStringList* TemplateStrings = {read=FTemplate};
	__property Frxservervariables::TfrxServerVariables* Variables = {read=FVariables};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxservertemplates */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSERVERTEMPLATES)
using namespace Frxservertemplates;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxservertemplatesHPP
