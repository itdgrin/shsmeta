// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxPrinter.pas' rev: 26.00 (Windows)

#ifndef FrxprinterHPP
#define FrxprinterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Printers.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxprinter
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxCustomPrinter;
class DELPHICLASS TfrxPrinterCanvas;
class PASCALIMPLEMENTATION TfrxCustomPrinter : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FBin;
	int FDuplex;
	System::Classes::TStrings* FBins;
	TfrxPrinterCanvas* FCanvas;
	System::Uitypes::TPrinterOrientation FDefOrientation;
	int FDefPaper;
	System::Extended FDefPaperHeight;
	System::Extended FDefPaperWidth;
	int FDefDuplex;
	int FDefBin;
	System::Types::TPoint FDPI;
	System::UnicodeString FFileName;
	NativeUInt FHandle;
	bool FInitialized;
	System::UnicodeString FName;
	int FPaper;
	System::Classes::TStrings* FPapers;
	System::Extended FPaperHeight;
	System::Extended FPaperWidth;
	System::Extended FLeftMargin;
	System::Extended FTopMargin;
	System::Extended FRightMargin;
	System::Extended FBottomMargin;
	System::Uitypes::TPrinterOrientation FOrientation;
	System::UnicodeString FPort;
	bool FPrinting;
	System::UnicodeString FTitle;
	
public:
	__fastcall virtual TfrxCustomPrinter(const System::UnicodeString AName, const System::UnicodeString APort);
	__fastcall virtual ~TfrxCustomPrinter(void);
	virtual void __fastcall Init(void) = 0 ;
	virtual void __fastcall Abort(void) = 0 ;
	virtual void __fastcall BeginDoc(void) = 0 ;
	virtual void __fastcall BeginPage(void) = 0 ;
	virtual void __fastcall BeginRAWDoc(void) = 0 ;
	virtual void __fastcall EndDoc(void) = 0 ;
	virtual void __fastcall EndPage(void) = 0 ;
	virtual void __fastcall EndRAWDoc(void) = 0 ;
	virtual void __fastcall WriteRAWDoc(const System::AnsiString buf) = 0 ;
	int __fastcall BinIndex(int ABin);
	int __fastcall PaperIndex(int APaper);
	int __fastcall BinNameToNumber(const System::UnicodeString ABin);
	int __fastcall PaperNameToNumber(const System::UnicodeString APaper);
	virtual void __fastcall SetViewParams(int APaperSize, System::Extended APaperWidth, System::Extended APaperHeight, System::Uitypes::TPrinterOrientation AOrientation) = 0 ;
	virtual void __fastcall SetPrintParams(int APaperSize, System::Extended APaperWidth, System::Extended APaperHeight, System::Uitypes::TPrinterOrientation AOrientation, int ABin, int ADuplex, int ACopies) = 0 ;
	virtual void __fastcall PropertiesDlg(void) = 0 ;
	__property int Bin = {read=FBin, nodefault};
	__property int Duplex = {read=FDuplex, nodefault};
	__property System::Classes::TStrings* Bins = {read=FBins};
	__property TfrxPrinterCanvas* Canvas = {read=FCanvas};
	__property System::Uitypes::TPrinterOrientation DefOrientation = {read=FDefOrientation, nodefault};
	__property int DefPaper = {read=FDefPaper, nodefault};
	__property System::Extended DefPaperHeight = {read=FDefPaperHeight};
	__property System::Extended DefPaperWidth = {read=FDefPaperWidth};
	__property int DefBin = {read=FDefBin, nodefault};
	__property int DefDuplex = {read=FDefDuplex, nodefault};
	__property System::Types::TPoint DPI = {read=FDPI};
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property NativeUInt Handle = {read=FHandle, nodefault};
	__property System::UnicodeString Name = {read=FName};
	__property int Paper = {read=FPaper, nodefault};
	__property System::Classes::TStrings* Papers = {read=FPapers};
	__property System::Extended PaperHeight = {read=FPaperHeight};
	__property System::Extended PaperWidth = {read=FPaperWidth};
	__property System::Extended LeftMargin = {read=FLeftMargin};
	__property System::Extended TopMargin = {read=FTopMargin};
	__property System::Extended RightMargin = {read=FRightMargin};
	__property System::Extended BottomMargin = {read=FBottomMargin};
	__property System::Uitypes::TPrinterOrientation Orientation = {read=FOrientation, nodefault};
	__property System::UnicodeString Port = {read=FPort};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property bool Initialized = {read=FInitialized, nodefault};
};


class DELPHICLASS TfrxVirtualPrinter;
class PASCALIMPLEMENTATION TfrxVirtualPrinter : public TfrxCustomPrinter
{
	typedef TfrxCustomPrinter inherited;
	
public:
	virtual void __fastcall Init(void);
	virtual void __fastcall Abort(void);
	virtual void __fastcall BeginDoc(void);
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall BeginRAWDoc(void);
	virtual void __fastcall EndDoc(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall EndRAWDoc(void);
	virtual void __fastcall WriteRAWDoc(const System::AnsiString buf);
	virtual void __fastcall SetViewParams(int APaperSize, System::Extended APaperWidth, System::Extended APaperHeight, System::Uitypes::TPrinterOrientation AOrientation);
	virtual void __fastcall SetPrintParams(int APaperSize, System::Extended APaperWidth, System::Extended APaperHeight, System::Uitypes::TPrinterOrientation AOrientation, int ABin, int ADuplex, int ACopies);
	virtual void __fastcall PropertiesDlg(void);
public:
	/* TfrxCustomPrinter.Create */ inline __fastcall virtual TfrxVirtualPrinter(const System::UnicodeString AName, const System::UnicodeString APort) : TfrxCustomPrinter(AName, APort) { }
	/* TfrxCustomPrinter.Destroy */ inline __fastcall virtual ~TfrxVirtualPrinter(void) { }
	
};


class DELPHICLASS TfrxPrinter;
class PASCALIMPLEMENTATION TfrxPrinter : public TfrxCustomPrinter
{
	typedef TfrxCustomPrinter inherited;
	
private:
	NativeUInt FDeviceMode;
	HDC FDC;
	System::UnicodeString FDriver;
	_devicemodeW *FMode;
	void __fastcall CreateDevMode(void);
	void __fastcall FreeDevMode(void);
	void __fastcall GetDC(void);
	
public:
	__fastcall virtual ~TfrxPrinter(void);
	virtual void __fastcall Init(void);
	void __fastcall RecreateDC(void);
	virtual void __fastcall Abort(void);
	virtual void __fastcall BeginDoc(void);
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall BeginRAWDoc(void);
	virtual void __fastcall EndDoc(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall EndRAWDoc(void);
	virtual void __fastcall WriteRAWDoc(const System::AnsiString buf);
	virtual void __fastcall SetViewParams(int APaperSize, System::Extended APaperWidth, System::Extended APaperHeight, System::Uitypes::TPrinterOrientation AOrientation);
	virtual void __fastcall SetPrintParams(int APaperSize, System::Extended APaperWidth, System::Extended APaperHeight, System::Uitypes::TPrinterOrientation AOrientation, int ABin, int ADuplex, int ACopies);
	virtual void __fastcall PropertiesDlg(void);
	bool __fastcall UpdateDeviceCaps(void);
	__property Winapi::Windows::PDeviceModeW DeviceMode = {read=FMode};
public:
	/* TfrxCustomPrinter.Create */ inline __fastcall virtual TfrxPrinter(const System::UnicodeString AName, const System::UnicodeString APort) : TfrxCustomPrinter(AName, APort) { }
	
};


class DELPHICLASS TfrxPrinters;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPrinters : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxCustomPrinter* operator[](int Index) { return Items[Index]; }
	
private:
	bool FHasPhysicalPrinters;
	System::Classes::TStrings* FPrinters;
	int FPrinterIndex;
	System::Classes::TList* FPrinterList;
	System::UnicodeString __fastcall GetDefaultPrinter(void);
	TfrxCustomPrinter* __fastcall GetItem(int Index);
	TfrxCustomPrinter* __fastcall GetCurrentPrinter(void);
	void __fastcall SetPrinterIndex(int Value);
	
public:
	__fastcall TfrxPrinters(void);
	__fastcall virtual ~TfrxPrinters(void);
	int __fastcall IndexOf(System::UnicodeString AName);
	void __fastcall Clear(void);
	void __fastcall FillPrinters(void);
	__property TfrxCustomPrinter* Items[int Index] = {read=GetItem/*, default*/};
	__property bool HasPhysicalPrinters = {read=FHasPhysicalPrinters, nodefault};
	__property TfrxCustomPrinter* Printer = {read=GetCurrentPrinter};
	__property int PrinterIndex = {read=FPrinterIndex, write=SetPrinterIndex, nodefault};
	__property System::Classes::TStrings* Printers = {read=FPrinters};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxPrinterCanvas : public Vcl::Graphics::TCanvas
{
	typedef Vcl::Graphics::TCanvas inherited;
	
private:
	TfrxCustomPrinter* FPrinter;
	void __fastcall UpdateFont(void);
	
public:
	virtual void __fastcall Changing(void);
public:
	/* TCanvas.Create */ inline __fastcall TfrxPrinterCanvas(void) : Vcl::Graphics::TCanvas() { }
	/* TCanvas.Destroy */ inline __fastcall virtual ~TfrxPrinterCanvas(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall frxGetPaperDimensions(int PaperSize, System::Extended &Width, System::Extended &Height);
extern DELPHI_PACKAGE TfrxPrinters* __fastcall frxPrinters(void);
}	/* namespace Frxprinter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXPRINTER)
using namespace Frxprinter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxprinterHPP
