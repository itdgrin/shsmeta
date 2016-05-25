// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBarcodePDF417.pas' rev: 26.00 (Windows)

#ifndef Frxbarcodepdf417HPP
#define Frxbarcodepdf417HPP

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
#include <System.Types.hpp>	// Pascal unit
#include <System.StrUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <frxBarcode2DBase.hpp>	// Pascal unit
#include <frxPrinter.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxbarcodepdf417
{
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<int> TInt;

typedef TInt *PInt;

enum DECLSPEC_DENUM PDF417ErrorCorrection : unsigned char { AutoCorr, Level0, Level1, Level2, Level3, Level4, Level5, Level6, Level7, Level8 };

enum DECLSPEC_DENUM PDF417CompactionMode : unsigned char { AutoCompaction, TextComp, Numeric, Binary };

class DELPHICLASS Segment;
#pragma pack(push,4)
class PASCALIMPLEMENTATION Segment : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::WideChar _type;
	int _start;
	int _end;
	__fastcall Segment(System::WideChar _t, int _s, int _e);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Segment(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TSegmentList;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSegmentList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Classes::TList* list;
	__fastcall TSegmentList(void);
	void __fastcall Add(System::WideChar _type, int _start, int _end);
	Segment* __fastcall Get(int idx);
	void __fastcall Remove(int idx);
	int __fastcall Size(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TSegmentList(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxBarcodePDF417;
class PASCALIMPLEMENTATION TfrxBarcodePDF417 : public Frxbarcode2dbase::TfrxBarcode2DBase
{
	typedef Frxbarcode2dbase::TfrxBarcode2DBase inherited;
	
private:
	typedef System::DynamicArray<System::Byte> _TfrxBarcodePDF417__1;
	
	
private:
	int codeColumns;
	int FRows;
	int FColumns;
	System::StaticArray<int, 928> codewords;
	int lenCodewords;
	int errorLevel;
	PDF417ErrorCorrection FErrorCorrection;
	PDF417CompactionMode FCompactionMode;
	_TfrxBarcodePDF417__1 bytes;
	System::Extended FAspectRatio;
	int FCodePage;
	int bitPtr;
	int cwPtr;
	TSegmentList* segmentList;
	bool __fastcall CheckSegmentType(Segment* &segm, System::WideChar typ);
	int __fastcall GetSegmentLength(Segment* &segm);
	void __fastcall OutCodeword17(int codeword);
	void __fastcall OutCodeword18(int codeword);
	void __fastcall OutCodeword(int codeword);
	void __fastcall OutStopPattern(void);
	void __fastcall OutStartPattern(void);
	void __fastcall OutPaintCode(void);
	void __fastcall CalculateErrorCorrection(int dest);
	int __fastcall GetTextTypeAndValue(System::Byte *input, const int input_Size, int maxLength, int idx)/* overload */;
	int __fastcall GetTextTypeAndValue(int maxLength, int idx)/* overload */;
	void __fastcall TextCompaction(System::Byte *input, const int input_Size, int start, int length)/* overload */;
	void __fastcall TextCompaction(int start, int length)/* overload */;
	void __fastcall BasicNumberCompaction(int start, int length)/* overload */;
	void __fastcall BasicNumberCompaction(System::Byte *input, const int input_Size, int start, int length)/* overload */;
	void __fastcall NumberCompaction(System::Byte *input, const int input_Size, int start, int length)/* overload */;
	void __fastcall NumberCompaction(int start, int length)/* overload */;
	void __fastcall ByteCompaction6(int start);
	void __fastcall ByteCompaction(int start, int length);
	void __fastcall BreakString(void);
	void __fastcall Assemble(void);
	int __fastcall MaxPossibleErrorLevel(int remain);
	int __fastcall GetMaxSquare(void);
	void __fastcall PaintCode(void);
	void __fastcall Initialize(void);
	void __fastcall SetAspectRatio(System::Extended v);
	void __fastcall SetColumns(int v);
	void __fastcall SetRows(int v);
	void __fastcall SetErrorCorrection(PDF417ErrorCorrection v);
	void __fastcall SetCodePage(int v);
	void __fastcall SetCompactionMode(PDF417CompactionMode v);
	
protected:
	virtual void __fastcall SetText(System::UnicodeString v);
	
public:
	__fastcall virtual TfrxBarcodePDF417(void);
	virtual void __fastcall Assign(Frxbarcode2dbase::TfrxBarcode2DBase* source);
	
__published:
	__property System::Extended AspectRatio = {read=FAspectRatio, write=SetAspectRatio};
	__property int Columns = {read=FColumns, write=SetColumns, nodefault};
	__property int Rows = {read=FRows, write=SetRows, nodefault};
	__property PDF417ErrorCorrection ErrorCorrection = {read=FErrorCorrection, write=SetErrorCorrection, nodefault};
	__property int CodePage = {read=FCodePage, write=SetCodePage, nodefault};
	__property PDF417CompactionMode CompactionMode = {read=FCompactionMode, write=SetCompactionMode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxBarcodePDF417(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const int START_PATTERN = int(0x1fea8);
static const int STOP_PATTERN = int(0x3fa29);
static const System::Int8 START_CODE_SIZE = System::Int8(0x11);
static const System::Int8 STOP_SIZE = System::Int8(0x12);
static const System::Word _MOD = System::Word(0x3a1);
static const int ALPHA = int(0x10000);
static const int LOWER = int(0x20000);
static const int MIXED = int(0x40000);
static const int PUNCTUATION = int(0x80000);
static const int ISBYTE = int(0x100000);
static const System::Word BYTESHIFT = System::Word(0x391);
static const System::Int8 PL = System::Int8(0x19);
static const System::Int8 LL = System::Int8(0x1b);
static const System::Int8 _AS = System::Int8(0x1b);
static const System::Int8 ML = System::Int8(0x1c);
static const System::Int8 AL = System::Int8(0x1c);
static const System::Int8 PS = System::Int8(0x1d);
static const System::Int8 PAL = System::Int8(0x1d);
static const System::Int8 SPACE = System::Int8(0x1a);
static const System::Word TEXT_MODE = System::Word(0x384);
static const System::Word BYTE_MODE_6 = System::Word(0x39c);
static const System::Word BYTE_MODE = System::Word(0x385);
static const System::Word NUMERIC_MODE = System::Word(0x386);
static const System::Word ABSOLUTE_MAX_TEXT_SIZE = System::Word(0x152c);
static const System::Word MAX_DATA_CODEWORDS = System::Word(0x39e);
static const System::Word MACRO_SEGMENT_ID = System::Word(0x3a0);
static const System::Word MACRO_LAST_SEGMENT = System::Word(0x39a);
#define MIXED_SET L"0123456789&\r\t,:#-.$/+%*=^"
#define PUNCTUATION_SET L";<>@[\\]_`~!\r\t,:\n-.$/\"|*()?{}'"
extern DELPHI_PACKAGE System::StaticArray<System::StaticArray<int, 929>, 3> CLUSTERS;
extern DELPHI_PACKAGE System::StaticArray<int, 2> ERRLVL0;
extern DELPHI_PACKAGE System::StaticArray<int, 4> ERRLVL1;
extern DELPHI_PACKAGE System::StaticArray<int, 8> ERRLVL2;
extern DELPHI_PACKAGE System::StaticArray<int, 16> ERRLVL3;
extern DELPHI_PACKAGE System::StaticArray<int, 32> ERRLVL4;
extern DELPHI_PACKAGE System::StaticArray<int, 64> ERRLVL5;
extern DELPHI_PACKAGE System::StaticArray<int, 128> ERRLVL6;
extern DELPHI_PACKAGE System::StaticArray<int, 256> ERRLVL7;
extern DELPHI_PACKAGE System::StaticArray<int, 512> ERRLVL8;
extern DELPHI_PACKAGE System::StaticArray<PInt, 9> ERROR_LEVEL;
}	/* namespace Frxbarcodepdf417 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBARCODEPDF417)
using namespace Frxbarcodepdf417;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frxbarcodepdf417HPP
