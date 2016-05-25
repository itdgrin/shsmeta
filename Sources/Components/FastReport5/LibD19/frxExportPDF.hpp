// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportPDF.pas' rev: 26.00 (Windows)

#ifndef FrxexportpdfHPP
#define FrxexportpdfHPP

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
#include <System.Win.ComObj.hpp>	// Pascal unit
#include <Vcl.Printers.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <Vcl.Imaging.jpeg.hpp>	// Pascal unit
#include <Winapi.ShellAPI.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <frxRC4.hpp>	// Pascal unit
#include <frxTrueTypeFont.hpp>	// Pascal unit
#include <frxTrueTypeCollection.hpp>	// Pascal unit
#include <System.WideStrings.hpp>	// Pascal unit
#include <System.AnsiStrings.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------
#pragma link "usp10.lib"

namespace Frxexportpdf
{
//-- type declarations -------------------------------------------------------
typedef void * SCRIPT_CACHE;

typedef void * *PScriptCache;

struct DECLSPEC_DRECORD SCRIPT_ANALYSIS
{
public:
	System::Word fFlags;
	System::Word s;
};


typedef SCRIPT_ANALYSIS *PScriptAnalysis;

struct DECLSPEC_DRECORD SCRIPT_ITEM
{
public:
	int iCharPos;
	SCRIPT_ANALYSIS a;
};


typedef SCRIPT_ITEM *PScriptItem;

struct DECLSPEC_DRECORD GOFFSET
{
public:
	int du;
	int dv;
};


typedef GOFFSET *PGOffset;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TRGBTriple
{
public:
	System::Byte rgbtBlue;
	System::Byte rgbtGreen;
	System::Byte rgbtRed;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD TRGBAWord
{
public:
	System::Byte Blue;
	System::Byte Green;
	System::Byte Red;
	System::Byte Alpha;
};
#pragma pack(pop)


typedef System::StaticArray<TRGBAWord, 4096> TRGBAWordArray;

typedef TRGBAWordArray *PRGBAWord;

enum DECLSPEC_DENUM TfrxPDFEncBit : unsigned char { ePrint, eModify, eCopy, eAnnot };

typedef System::Set<TfrxPDFEncBit, TfrxPDFEncBit::ePrint, TfrxPDFEncBit::eAnnot> TfrxPDFEncBits;

class DELPHICLASS TfrxPDFExportDialog;
class PASCALIMPLEMENTATION TfrxPDFExportDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* ExportPage;
	Vcl::Comctrls::TTabSheet* InfoPage;
	Vcl::Comctrls::TTabSheet* SecurityPage;
	Vcl::Comctrls::TTabSheet* ViewerPage;
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Stdctrls::TCheckBox* OpenCB;
	Vcl::Stdctrls::TGroupBox* GroupQuality;
	Vcl::Stdctrls::TCheckBox* CompressedCB;
	Vcl::Stdctrls::TCheckBox* EmbeddedCB;
	Vcl::Stdctrls::TCheckBox* PrintOptCB;
	Vcl::Stdctrls::TCheckBox* OutlineCB;
	Vcl::Stdctrls::TCheckBox* BackgrCB;
	Vcl::Stdctrls::TGroupBox* GroupPageRange;
	Vcl::Stdctrls::TLabel* DescrL;
	Vcl::Stdctrls::TRadioButton* AllRB;
	Vcl::Stdctrls::TRadioButton* CurPageRB;
	Vcl::Stdctrls::TRadioButton* PageNumbersRB;
	Vcl::Stdctrls::TEdit* PageNumbersE;
	Vcl::Stdctrls::TGroupBox* SecGB;
	Vcl::Stdctrls::TLabel* OwnPassL;
	Vcl::Stdctrls::TLabel* UserPassL;
	Vcl::Stdctrls::TEdit* OwnPassE;
	Vcl::Stdctrls::TEdit* UserPassE;
	Vcl::Stdctrls::TGroupBox* PermGB;
	Vcl::Stdctrls::TCheckBox* PrintCB;
	Vcl::Stdctrls::TCheckBox* ModCB;
	Vcl::Stdctrls::TCheckBox* CopyCB;
	Vcl::Stdctrls::TCheckBox* AnnotCB;
	Vcl::Stdctrls::TGroupBox* DocInfoGB;
	Vcl::Stdctrls::TLabel* TitleL;
	Vcl::Stdctrls::TEdit* TitleE;
	Vcl::Stdctrls::TEdit* AuthorE;
	Vcl::Stdctrls::TLabel* AuthorL;
	Vcl::Stdctrls::TLabel* SubjectL;
	Vcl::Stdctrls::TEdit* SubjectE;
	Vcl::Stdctrls::TLabel* KeywordsL;
	Vcl::Stdctrls::TEdit* KeywordsE;
	Vcl::Stdctrls::TEdit* CreatorE;
	Vcl::Stdctrls::TLabel* CreatorL;
	Vcl::Stdctrls::TLabel* ProducerL;
	Vcl::Stdctrls::TEdit* ProducerE;
	Vcl::Stdctrls::TGroupBox* ViewerGB;
	Vcl::Stdctrls::TCheckBox* HideToolbarCB;
	Vcl::Stdctrls::TCheckBox* HideMenubarCB;
	Vcl::Stdctrls::TCheckBox* HideWindowUICB;
	Vcl::Stdctrls::TCheckBox* FitWindowCB;
	Vcl::Stdctrls::TCheckBox* CenterWindowCB;
	Vcl::Stdctrls::TCheckBox* PrintScalingCB;
	Vcl::Stdctrls::TEdit* Quality;
	Vcl::Stdctrls::TLabel* Label2;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageNumbersEChange(System::TObject* Sender);
	void __fastcall PageNumbersEKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxPDFExportDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxPDFExportDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxPDFExportDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxPDFExportDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TfrxPDFRun;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPDFRun : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	SCRIPT_ANALYSIS analysis;
	System::WideString text;
	__fastcall TfrxPDFRun(System::WideString t, SCRIPT_ANALYSIS a);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxPDFRun(void) { }
	
};

#pragma pack(pop)

typedef System::StaticArray<System::Byte, 16> TfrxPDFXObjectHash;

struct DECLSPEC_DRECORD TfrxPDFXObject
{
public:
	int ObjId;
	TfrxPDFXObjectHash Hash;
};


class DELPHICLASS TfrxPDFFont;
class PASCALIMPLEMENTATION TfrxPDFFont : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Vcl::Graphics::TBitmap* tempBitmap;
	void * *FUSCache;
	Frxtruetypecollection::TrueTypeCollection* TrueTypeTables;
	int __fastcall GetGlyphs(HDC hdc, TfrxPDFRun* run, PWORD glyphs, System::PInteger widths, int maxGlyphs, bool rtl);
	System::Classes::TList* __fastcall Itemize(System::WideString s, bool rtl, int maxItems);
	System::Classes::TList* __fastcall Layout(System::Classes::TList* runs, bool rtl);
	int __fastcall GetGlyphIndices(HDC hdc, System::WideString text, PWORD glyphs, System::PInteger widths, bool rtl);
	
public:
	int Index;
	System::Classes::TList* Widths;
	System::Classes::TList* UsedAlphabet;
	System::Classes::TList* UsedAlphabetUnicode;
	_OUTLINETEXTMETRICA *TextMetric;
	System::AnsiString Name;
	Vcl::Graphics::TFont* SourceFont;
	int Reference;
	bool Saved;
	bool PackFont;
	char *FontData;
	int FontDataSize;
	double PDFdpi_divider;
	double FDpiFX;
	__fastcall TfrxPDFFont(Vcl::Graphics::TFont* Font);
	__fastcall virtual ~TfrxPDFFont(void);
	void __fastcall Cleanup(void);
	void __fastcall FillOutlineTextMetrix(void);
	void __fastcall GetFontFile(void);
	System::WideString __fastcall RemapString(System::WideString str, bool rtl);
	System::AnsiString __fastcall GetFontName(void);
};


class DELPHICLASS TfrxPDFOutlineNode;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPDFOutlineNode : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int Number;
	int Dest;
	int Top;
	int CountTree;
	int Count;
	System::UnicodeString Title;
	TfrxPDFOutlineNode* First;
	TfrxPDFOutlineNode* Last;
	TfrxPDFOutlineNode* Next;
	TfrxPDFOutlineNode* Prev;
	TfrxPDFOutlineNode* Parent;
	__fastcall TfrxPDFOutlineNode(void);
	__fastcall virtual ~TfrxPDFOutlineNode(void);
};

#pragma pack(pop)

class DELPHICLASS TfrxPDFPage;
class PASCALIMPLEMENTATION TfrxPDFPage : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	double Height;
public:
	/* TObject.Create */ inline __fastcall TfrxPDFPage(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxPDFPage(void) { }
	
};


class DELPHICLASS TfrxPDFAnnot;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPDFAnnot : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int Number;
	System::UnicodeString Rect;
	System::UnicodeString Hyperlink;
	int DestPage;
	int DestY;
public:
	/* TObject.Create */ inline __fastcall TfrxPDFAnnot(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxPDFAnnot(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxPDFExport;
class PASCALIMPLEMENTATION TfrxPDFExport : public Frxclass::TfrxCustomExportFilter
{
	typedef Frxclass::TfrxCustomExportFilter inherited;
	
private:
	typedef System::DynamicArray<TfrxPDFXObject> _TfrxPDFExport__1;
	
	typedef System::DynamicArray<int> _TfrxPDFExport__2;
	
	
private:
	bool FCompressed;
	bool FEmbedded;
	bool FEmbedProt;
	bool FOpenAfterExport;
	bool FPrintOpt;
	System::Classes::TList* FPages;
	bool FOutline;
	int FQuality;
	Frxclass::TfrxCustomOutline* FPreviewOutline;
	System::WideString FSubject;
	System::WideString FAuthor;
	bool FBackground;
	System::WideString FCreator;
	bool FTags;
	bool FProtection;
	System::AnsiString FUserPassword;
	System::AnsiString FOwnerPassword;
	TfrxPDFEncBits FProtectionFlags;
	System::WideString FKeywords;
	System::WideString FTitle;
	System::WideString FProducer;
	bool FPrintScaling;
	bool FFitWindow;
	bool FHideMenubar;
	bool FCenterWindow;
	bool FHideWindowUI;
	bool FHideToolbar;
	System::Classes::TStream* pdf;
	int FRootNumber;
	int FPagesNumber;
	int FInfoNumber;
	int FStartXRef;
	System::Classes::TList* FFonts;
	System::Classes::TList* FPageFonts;
	System::Classes::TStringList* FXRef;
	System::Classes::TStringList* FPagesRef;
	System::Extended FWidth;
	System::Extended FHeight;
	System::Extended FMarginLeft;
	System::Extended FMarginWoBottom;
	System::Extended FMarginTop;
	System::AnsiString FEncKey;
	System::AnsiString FOPass;
	System::AnsiString FUPass;
	unsigned FEncBits;
	System::AnsiString FFileID;
	System::Extended FDivider;
	System::Uitypes::TColor FLastColor;
	System::UnicodeString FLastColorResult;
	System::Classes::TMemoryStream* OutStream;
	_TfrxPDFExport__1 FXObjects;
	_TfrxPDFExport__2 FUsedXObjects;
	unsigned FPicTotalSize;
	System::Classes::TMemoryStream* FPageAnnots;
	System::Classes::TList* FAnnots;
	System::UnicodeString __fastcall PrepXrefPos(int pos);
	System::UnicodeString __fastcall GetPDFDash(const Frxclass::TfrxFrameStyle LineStyle, System::Extended Width);
	void __fastcall Write(System::Classes::TStream* Stream, const System::AnsiString S)/* overload */;
	void __fastcall Write(System::Classes::TStream* Stream, const System::UnicodeString S)/* overload */;
	void __fastcall WriteLn(System::Classes::TStream* Stream, const System::AnsiString S)/* overload */;
	void __fastcall WriteLn(System::Classes::TStream* Stream, const System::UnicodeString S)/* overload */;
	System::AnsiString __fastcall GetID(void);
	System::AnsiString __fastcall CryptStr(System::AnsiString Source, System::AnsiString Key, bool Enc, int id);
	System::AnsiString __fastcall CryptStream(System::Classes::TStream* Source, System::Classes::TStream* Target, System::AnsiString Key, int id);
	System::AnsiString __fastcall PrepareString(const System::WideString Text, System::AnsiString Key, bool Enc, int id);
	System::AnsiString __fastcall EscapeSpecialChar(System::AnsiString TextStr);
	System::AnsiString __fastcall StrToUTF16(const System::WideString Value);
	System::AnsiString __fastcall StrToUTF16H(const System::WideString Value);
	System::AnsiString __fastcall PMD52Str(void * p);
	System::AnsiString __fastcall PadPassword(System::AnsiString Password);
	void __fastcall PrepareKeys(void);
	void __fastcall SetProtectionFlags(const TfrxPDFEncBits Value);
	void __fastcall Clear(void);
	void __fastcall WriteFont(TfrxPDFFont* pdfFont);
	void __fastcall AddObject(Frxclass::TfrxView* const Obj);
	System::AnsiString __fastcall StrToHex(const System::WideString Value);
	TfrxPDFPage* __fastcall AddPage(Frxclass::TfrxReportPage* Page);
	System::UnicodeString __fastcall ObjNumber(int FNumber);
	System::UnicodeString __fastcall ObjNumberRef(int FNumber);
	int __fastcall UpdateXRef(void);
	System::UnicodeString __fastcall GetPDFColor(const System::Uitypes::TColor Color);
	int __fastcall FindXObject(const TfrxPDFXObjectHash &Hash);
	int __fastcall AddXObject(int Id, const TfrxPDFXObjectHash &Hash);
	void __fastcall ClearXObject(void);
	void __fastcall GetStreamHash(/* out */ TfrxPDFXObjectHash &Hash, System::Classes::TStream* S);
	
public:
	__fastcall virtual TfrxPDFExport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxPDFExport(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	virtual void __fastcall Finish(void);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	
__published:
	__property bool Compressed = {read=FCompressed, write=FCompressed, default=1};
	__property bool EmbeddedFonts = {read=FEmbedded, write=FEmbedded, default=0};
	__property bool EmbedFontsIfProtected = {read=FEmbedProt, write=FEmbedProt, default=1};
	__property bool OpenAfterExport = {read=FOpenAfterExport, write=FOpenAfterExport, default=0};
	__property bool PrintOptimized = {read=FPrintOpt, write=FPrintOpt, nodefault};
	__property bool Outline = {read=FOutline, write=FOutline, nodefault};
	__property bool Background = {read=FBackground, write=FBackground, nodefault};
	__property bool HTMLTags = {read=FTags, write=FTags, nodefault};
	__property OverwritePrompt;
	__property int Quality = {read=FQuality, write=FQuality, nodefault};
	__property System::WideString Title = {read=FTitle, write=FTitle};
	__property System::WideString Author = {read=FAuthor, write=FAuthor};
	__property System::WideString Subject = {read=FSubject, write=FSubject};
	__property System::WideString Keywords = {read=FKeywords, write=FKeywords};
	__property System::WideString Creator = {read=FCreator, write=FCreator};
	__property System::WideString Producer = {read=FProducer, write=FProducer};
	__property System::AnsiString UserPassword = {read=FUserPassword, write=FUserPassword};
	__property System::AnsiString OwnerPassword = {read=FOwnerPassword, write=FOwnerPassword};
	__property TfrxPDFEncBits ProtectionFlags = {read=FProtectionFlags, write=SetProtectionFlags, nodefault};
	__property bool HideToolbar = {read=FHideToolbar, write=FHideToolbar, nodefault};
	__property bool HideMenubar = {read=FHideMenubar, write=FHideMenubar, nodefault};
	__property bool HideWindowUI = {read=FHideWindowUI, write=FHideWindowUI, nodefault};
	__property bool FitWindow = {read=FFitWindow, write=FFitWindow, nodefault};
	__property bool CenterWindow = {read=FCenterWindow, write=FCenterWindow, nodefault};
	__property bool PrintScaling = {read=FPrintScaling, write=FPrintScaling, nodefault};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxPDFExport(void) : Frxclass::TfrxCustomExportFilter() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern "C" HRESULT __stdcall ScriptFreeCache(PScriptCache psc);
extern "C" HRESULT __stdcall ScriptItemize(const System::WideChar * pwcInChars, int cInChars, int cMaxItems, const System::PInteger psControl, const PWORD psState, PScriptItem pItems, System::PInteger pcItems);
extern "C" HRESULT __stdcall ScriptLayout(int cRuns, const Frxrc4::PByte pbLevel, System::PInteger piVisualToLogical, System::PInteger piLogicalToVisual);
extern "C" HRESULT __stdcall ScriptShape(HDC hdc, PScriptCache psc, const System::WideChar * pwcChars, int cChars, int cMaxGlyphs, PScriptAnalysis psa, PWORD pwOutGlyphs, PWORD pwLogClust, PWORD psva, System::PInteger pcGlyphs);
extern "C" HRESULT __stdcall ScriptPlace(HDC hdc, PScriptCache psc, const PWORD pwGlyphs, int cGlyphs, const PWORD psva, PScriptAnalysis psa, System::PInteger piAdvance, const PGOffset pGoffset, PABC pABC);
extern DELPHI_PACKAGE System::Classes::TStringList* frxPDFFontsNeedStyleSimulation;
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfSetLineColor(System::Uitypes::TColor Color);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfSetLineWidth(double Width);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfFillRect(double Left, double Bottom, double Right, double Top, System::Uitypes::TColor Color);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfSetColor(System::Uitypes::TColor Color);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfFill(void);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfPoint(double x, double y);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfLine(double x, double y);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfMove(double x, double y);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfColor(System::Uitypes::TColor Color);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfString(const System::WideString Str);
}	/* namespace Frxexportpdf */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTPDF)
using namespace Frxexportpdf;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportpdfHPP
