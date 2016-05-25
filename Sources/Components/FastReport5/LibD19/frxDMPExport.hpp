// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDMPExport.pas' rev: 26.00 (Windows)

#ifndef FrxdmpexportHPP
#define FrxdmpexportHPP

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
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <frxDMPClass.hpp>	// Pascal unit
#include <frxXML.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxdmpexport
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TfrxTranslateEvent)(System::TObject* Sender, System::AnsiString &s);

class DELPHICLASS TfrxDotMatrixExport;
class PASCALIMPLEMENTATION TfrxDotMatrixExport : public Frxclass::TfrxCustomExportFilter
{
	typedef Frxclass::TfrxCustomExportFilter inherited;
	
private:
	typedef System::DynamicArray<char> _TfrxDotMatrixExport__1;
	
	typedef System::DynamicArray<System::Byte> _TfrxDotMatrixExport__2;
	
	typedef System::DynamicArray<int> _TfrxDotMatrixExport__3;
	
	
private:
	int FBufWidth;
	int FBufHeight;
	_TfrxDotMatrixExport__1 FCharBuf;
	int FCopies;
	System::AnsiString FCustomFrameSet;
	int FEscModel;
	_TfrxDotMatrixExport__2 FFrameBuf;
	bool FGraphicFrames;
	int FMaxHeight;
	bool FOEMConvert;
	bool FPageBreaks;
	int FPageStyle;
	System::AnsiString FPrinterInitString;
	bool FSaveToFile;
	System::Classes::TStream* FStream;
	_TfrxDotMatrixExport__3 FStyleBuf;
	bool FUseIniSettings;
	TfrxTranslateEvent FOnTranslate;
	System::UnicodeString __fastcall GetTempFName(void);
	Frxdmpclass::TfrxDMPFontStyles __fastcall IntToStyle(int i);
	System::UnicodeString __fastcall StyleChange(int OldStyle, int NewStyle);
	System::UnicodeString __fastcall StyleOff(int Style);
	System::UnicodeString __fastcall StyleOn(int Style);
	int __fastcall StyleToInt(Frxdmpclass::TfrxDMPFontStyles Style);
	void __fastcall CreateBuf(int Width, int Height);
	void __fastcall DrawFrame(int x, int y, int dx, int dy, int Style);
	void __fastcall DrawMemo(int x, int y, int dx, int dy, Frxdmpclass::TfrxDMPMemoView* Memo);
	void __fastcall FlushBuf(void);
	void __fastcall FormFeed(void);
	void __fastcall FreeBuf(void);
	void __fastcall Landscape(void);
	void __fastcall Portrait(void);
	void __fastcall Reset(void);
	void __fastcall SetFrame(int x, int y, System::Byte typ);
	void __fastcall SetString(int x, int y, System::AnsiString s);
	void __fastcall SetStyle(int x, int y, int Style);
	void __fastcall SpoolFile(const System::UnicodeString FileName);
	void __fastcall WriteStrLn(const System::AnsiString str);
	void __fastcall WriteStr(const System::AnsiString str);
	
public:
	__fastcall virtual TfrxDotMatrixExport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxDotMatrixExport(void);
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	
__published:
	__property System::AnsiString CustomFrameSet = {read=FCustomFrameSet, write=FCustomFrameSet};
	__property int EscModel = {read=FEscModel, write=FEscModel, nodefault};
	__property bool GraphicFrames = {read=FGraphicFrames, write=FGraphicFrames, nodefault};
	__property System::AnsiString InitString = {read=FPrinterInitString, write=FPrinterInitString};
	__property bool OEMConvert = {read=FOEMConvert, write=FOEMConvert, default=1};
	__property bool PageBreaks = {read=FPageBreaks, write=FPageBreaks, default=1};
	__property bool SaveToFile = {read=FSaveToFile, write=FSaveToFile, nodefault};
	__property bool UseIniSettings = {read=FUseIniSettings, write=FUseIniSettings, nodefault};
	__property TfrxTranslateEvent OnTranslate = {read=FOnTranslate, write=FOnTranslate};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxDotMatrixExport(void) : Frxclass::TfrxCustomExportFilter() { }
	
};


class DELPHICLASS TfrxDMPExportDialog;
class PASCALIMPLEMENTATION TfrxDMPExportDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OK;
	Vcl::Stdctrls::TButton* Cancel;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Stdctrls::TGroupBox* PrinterL;
	Vcl::Stdctrls::TComboBox* PrinterCB;
	Vcl::Stdctrls::TGroupBox* EscL;
	Vcl::Stdctrls::TComboBox* EscCB;
	Vcl::Stdctrls::TGroupBox* CopiesL;
	Vcl::Stdctrls::TLabel* CopiesNL;
	Vcl::Stdctrls::TEdit* CopiesE;
	Vcl::Comctrls::TUpDown* CopiesUD;
	Vcl::Stdctrls::TGroupBox* PagesL;
	Vcl::Stdctrls::TLabel* DescrL;
	Vcl::Stdctrls::TRadioButton* AllRB;
	Vcl::Stdctrls::TRadioButton* CurPageRB;
	Vcl::Stdctrls::TRadioButton* PageNumbersRB;
	Vcl::Stdctrls::TEdit* RangeE;
	Vcl::Stdctrls::TGroupBox* OptionsL;
	Vcl::Stdctrls::TCheckBox* SaveToFileCB;
	Vcl::Stdctrls::TCheckBox* PageBreaksCB;
	Vcl::Stdctrls::TCheckBox* OemCB;
	Vcl::Stdctrls::TCheckBox* PseudoCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PrinterCBDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall PrinterCBClick(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall RangeEEnter(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	int OldIndex;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxDMPExportDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxDMPExportDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxDMPExportDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxDMPExportDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


typedef System::StaticArray<System::UnicodeString, 23> Frxdmpexport__3;

class DELPHICLASS TfrxDMPrinter;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxDMPrinter : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	typedef System::StaticArray<System::UnicodeString, 23> _TfrxDMPrinter__1;
	
	
public:
	_TfrxDMPrinter__1 Commands;
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxDMPrinter(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxDMPrinter(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxDMPrinters;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxDMPrinters : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxDMPrinter* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TfrxDMPrinter* __fastcall GetItem(int Index);
	
public:
	__fastcall TfrxDMPrinters(void);
	HIDESBASE TfrxDMPrinter* __fastcall Add(void);
	void __fastcall ReadDefaultPrinters(void);
	void __fastcall ReadExtPrinters(void);
	void __fastcall ReadPrinters(Frxxml::TfrxXMLDocument* x);
	__property TfrxDMPrinter* Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxDMPrinters(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 cmdName = System::Int8(0x1);
static const System::Int8 cmdReset = System::Int8(0x2);
static const System::Int8 cmdFormFeed = System::Int8(0x3);
static const System::Int8 cmdLandscape = System::Int8(0x4);
static const System::Int8 cmdPortrait = System::Int8(0x5);
static const System::Int8 cmdBoldOn = System::Int8(0x6);
static const System::Int8 cmdBoldOff = System::Int8(0x7);
static const System::Int8 cmdItalicOn = System::Int8(0x8);
static const System::Int8 cmdItalicOff = System::Int8(0x9);
static const System::Int8 cmdUnderlineOn = System::Int8(0xa);
static const System::Int8 cmdUnderlineOff = System::Int8(0xb);
static const System::Int8 cmdSuperscriptOn = System::Int8(0xc);
static const System::Int8 cmdSuperscriptOff = System::Int8(0xd);
static const System::Int8 cmdSubscriptOn = System::Int8(0xe);
static const System::Int8 cmdSubscriptOff = System::Int8(0xf);
static const System::Int8 cmdCondensedOn = System::Int8(0x10);
static const System::Int8 cmdCondensedOff = System::Int8(0x11);
static const System::Int8 cmdWideOn = System::Int8(0x12);
static const System::Int8 cmdWideOff = System::Int8(0x13);
static const System::Int8 cmd12cpiOn = System::Int8(0x14);
static const System::Int8 cmd12cpiOff = System::Int8(0x15);
static const System::Int8 cmd15cpiOn = System::Int8(0x16);
static const System::Int8 cmd15cpiOff = System::Int8(0x17);
static const System::Int8 CommandCount = System::Int8(0x17);
extern DELPHI_PACKAGE Frxdmpexport__3 CommandNames;
extern DELPHI_PACKAGE TfrxDMPrinters* frxDMPrinters;
}	/* namespace Frxdmpexport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDMPEXPORT)
using namespace Frxdmpexport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdmpexportHPP
