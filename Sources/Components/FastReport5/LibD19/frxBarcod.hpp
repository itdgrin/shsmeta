// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBarcod.pas' rev: 26.00 (Windows)

#ifndef FrxbarcodHPP
#define FrxbarcodHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxbarcod
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxBarcodeType : unsigned char { bcCode_2_5_interleaved, bcCode_2_5_industrial, bcCode_2_5_matrix, bcCode39, bcCode39Extended, bcCode128, bcCode128A, bcCode128B, bcCode128C, bcCode93, bcCode93Extended, bcCodeMSI, bcCodePostNet, bcCodeCodabar, bcCodeEAN8, bcCodeEAN13, bcCodeUPC_A, bcCodeUPC_E0, bcCodeUPC_E1, bcCodeUPC_Supp2, bcCodeUPC_Supp5, bcCodeEAN128, bcCodeEAN128A, bcCodeEAN128B, bcCodeEAN128C };

enum DECLSPEC_DENUM TfrxBarLineType : unsigned char { white, black, black_half };

enum DECLSPEC_DENUM TfrxCheckSumMethod : unsigned char { csmNone, csmModulo10 };

class DELPHICLASS TfrxBarcode;
class PASCALIMPLEMENTATION TfrxBarcode : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	double FAngle;
	System::Uitypes::TColor FColor;
	System::Uitypes::TColor FColorBar;
	bool FCheckSum;
	TfrxCheckSumMethod FCheckSumMethod;
	int FHeight;
	int FLeft;
	int FModul;
	double FRatio;
	System::AnsiString FText;
	int FTop;
	TfrxBarcodeType FTyp;
	Vcl::Graphics::TFont* FFont;
	System::StaticArray<System::Int8, 4> modules;
	void __fastcall DoLines(System::AnsiString data, Vcl::Graphics::TCanvas* Canvas);
	void __fastcall OneBarProps(char code, int &Width, TfrxBarLineType &lt);
	System::AnsiString __fastcall SetLen(System::Byte pI);
	System::AnsiString __fastcall Code_2_5_interleaved(void);
	System::AnsiString __fastcall Code_2_5_industrial(void);
	System::AnsiString __fastcall Code_2_5_matrix(void);
	System::AnsiString __fastcall Code_39(void);
	System::AnsiString __fastcall Code_39Extended(void);
	System::AnsiString __fastcall Code_128(void);
	System::AnsiString __fastcall Code_93(void);
	System::AnsiString __fastcall Code_93Extended(void);
	System::AnsiString __fastcall Code_MSI(void);
	System::AnsiString __fastcall Code_PostNet(void);
	System::AnsiString __fastcall Code_Codabar(void);
	System::AnsiString __fastcall Code_EAN8(void);
	System::AnsiString __fastcall Code_EAN13(void);
	System::AnsiString __fastcall Code_UPC_A(void);
	System::AnsiString __fastcall Code_UPC_E0(void);
	System::AnsiString __fastcall Code_UPC_E1(void);
	System::AnsiString __fastcall Code_Supp5(void);
	System::AnsiString __fastcall Code_Supp2(void);
	void __fastcall MakeModules(void);
	int __fastcall GetWidth(void);
	System::AnsiString __fastcall DoCheckSumming(const System::AnsiString data);
	System::AnsiString __fastcall MakeData(void);
	
public:
	__fastcall virtual TfrxBarcode(System::Classes::TComponent* Owner);
	__fastcall virtual ~TfrxBarcode(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall DrawBarcode(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect, bool ShowText);
	
__published:
	__property System::AnsiString Text = {read=FText, write=FText};
	__property int Modul = {read=FModul, write=FModul, nodefault};
	__property double Ratio = {read=FRatio, write=FRatio};
	__property TfrxBarcodeType Typ = {read=FTyp, write=FTyp, nodefault};
	__property bool Checksum = {read=FCheckSum, write=FCheckSum, nodefault};
	__property TfrxCheckSumMethod CheckSumMethod = {read=FCheckSumMethod, write=FCheckSumMethod, nodefault};
	__property double Angle = {read=FAngle, write=FAngle};
	__property int Width = {read=GetWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, nodefault};
	__property System::Uitypes::TColor ColorBar = {read=FColorBar, write=FColorBar, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=FFont};
};


#pragma pack(push,1)
struct DECLSPEC_DRECORD TBCdata
{
public:
	System::AnsiString Name;
	bool num;
};
#pragma pack(pop)


typedef System::StaticArray<TBCdata, 25> Frxbarcod__2;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Frxbarcod__2 BCdata;
}	/* namespace Frxbarcod */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBARCOD)
using namespace Frxbarcod;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxbarcodHPP
