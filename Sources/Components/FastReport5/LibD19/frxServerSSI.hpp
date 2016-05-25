// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerSSI.pas' rev: 26.00 (Windows)

#ifndef FrxserverssiHPP
#define FrxserverssiHPP

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

//-- user supplied -----------------------------------------------------------

namespace Frxserverssi
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxSSIStream;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSSIStream : public System::Classes::TMemoryStream
{
	typedef System::Classes::TMemoryStream inherited;
	
private:
	System::UnicodeString FBasePath;
	System::Classes::TMemoryStream* FTempStream;
	Frxservervariables::TfrxServerVariables* FVariables;
	Frxservervariables::TfrxServerVariables* FLocalVariables;
	System::AnsiString __fastcall ParseVarName(int VarPos, int VarLen, char * Src);
	int __fastcall SearchSign(const System::AnsiString Sign, char * Src, int StartPos, int Len);
	
public:
	__fastcall TfrxSSIStream(void);
	__fastcall virtual ~TfrxSSIStream(void);
	void __fastcall Prepare(void);
	__property System::UnicodeString BasePath = {read=FBasePath, write=FBasePath};
	__property Frxservervariables::TfrxServerVariables* Variables = {read=FVariables, write=FVariables};
	__property Frxservervariables::TfrxServerVariables* LocalVariables = {read=FLocalVariables, write=FLocalVariables};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxserverssi */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSERVERSSI)
using namespace Frxserverssi;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserverssiHPP
