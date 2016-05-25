// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportSVG.pas' rev: 26.00 (Windows)

#ifndef FrxexportsvgHPP
#define FrxexportsvgHPP

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
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Winapi.ShellAPI.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxCrypto.hpp>	// Pascal unit
#include <frxStorage.hpp>	// Pascal unit
#include <frxGradient.hpp>	// Pascal unit
#include <frxExportHelpers.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxexportsvg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxSVGExportDialog;
class PASCALIMPLEMENTATION TfrxSVGExportDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TGroupBox* GroupPageRange;
	Vcl::Stdctrls::TLabel* DescrL;
	Vcl::Stdctrls::TRadioButton* AllRB;
	Vcl::Stdctrls::TRadioButton* CurPageRB;
	Vcl::Stdctrls::TRadioButton* PageNumbersRB;
	Vcl::Stdctrls::TEdit* PageNumbersE;
	Vcl::Stdctrls::TGroupBox* gbOptions;
	Vcl::Stdctrls::TCheckBox* OpenCB;
	Vcl::Dialogs::TSaveDialog* sd;
	Vcl::Stdctrls::TGroupBox* GroupQuality;
	Vcl::Stdctrls::TLabel* PicturesL;
	Vcl::Stdctrls::TCheckBox* StylesCB;
	Vcl::Stdctrls::TCheckBox* UnifiedPicturesCB;
	Vcl::Stdctrls::TCheckBox* PicturesCB;
	Vcl::Stdctrls::TCheckBox* MultipageCB;
	Vcl::Stdctrls::TComboBox* PFormatCB;
	Vcl::Stdctrls::TCheckBox* FormattedCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageNumbersEChange(System::TObject* Sender);
	void __fastcall PageNumbersEKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxSVGExportDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxSVGExportDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxSVGExportDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxSVGExportDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TfrxSVGExport;
class PASCALIMPLEMENTATION TfrxSVGExport : public Frxclass::TfrxCustomExportFilter
{
	typedef Frxclass::TfrxCustomExportFilter inherited;
	
private:
	typedef System::DynamicArray<Frxexporthelpers::TfrxExportHandler> _TfrxSVGExport__1;
	
	
private:
	bool FOpenAfterExport;
	bool FMultiPage;
	bool FFormatted;
	bool FUnifiedPictures;
	Frxexporthelpers::TfrxPictureFormat FPicFormat;
	Frxexporthelpers::TfrxCSSStyle* FShadowStyle;
	bool FEmbeddedPictures;
	bool FEmbeddedCSS;
	System::Classes::TStream* FCurrentSVGFile;
	int FCurrentPage;
	Frxexporthelpers::TfrxCSS* FCSS;
	Frxexporthelpers::TfrxPictureStorage* FPictures;
	_TfrxSVGExport__1 FHandlers;
	void __fastcall SetPicFormat(Frxexporthelpers::TfrxPictureFormat Fmt);
	Frxexporthelpers::TfrxCSSStyle* __fastcall GetShadowStyle(void);
	System::UnicodeString __fastcall GetCSSFileName(void);
	System::UnicodeString __fastcall GetCSSFilePath(void);
	void __fastcall SaveCSS(const System::UnicodeString FileName);
	void __fastcall PutsRaw(const System::AnsiString s);
	void __fastcall PutImgage(Frxclass::TfrxView* Obj, Vcl::Graphics::TGraphic* Pic);
	void __fastcall RunExportsChain(Frxclass::TfrxView* Obj);
	void __fastcall StartSVG(double Width, double Height);
	void __fastcall FinishSVG(void);
	bool __fastcall ExportShape(Frxclass::TfrxView* Obj);
	bool __fastcall ExportLine(Frxclass::TfrxView* Obj);
	bool __fastcall ExportGradient(Frxclass::TfrxView* Obj);
	bool __fastcall ExportPicture(Frxclass::TfrxView* Obj);
	bool __fastcall ExportAsPicture(Frxclass::TfrxView* Obj);
	bool __fastcall ExportMemo(Frxclass::TfrxView* Obj);
	
protected:
	double FGlobalPageY;
	System::UnicodeString FPageRect;
	int FDefineCount;
	void __fastcall PutsA(const System::AnsiString s);
	void __fastcall Puts(const System::UnicodeString s)/* overload */;
	void __fastcall Puts(const System::UnicodeString Fmt, System::TVarRec const *Args, const int Args_Size)/* overload */;
	System::UnicodeString __fastcall LockStyle(Frxexporthelpers::TfrxCSSStyle* Style);
	void __fastcall DoGradient(Frxclass::TfrxView* Obj, System::UnicodeString BeginValue, System::UnicodeString EndValue, Frxgradient::TfrxGradientStyle Style);
	void __fastcall DoFrameLine(double x1, double y1, double x2, double y2, Frxclass::TfrxFrameLine* frxFrameLine);
	void __fastcall DoFill(Frxclass::TfrxView* Obj);
	void __fastcall DoFrame(Frxclass::TfrxView* Obj);
	void __fastcall DoFilledRect(Frxclass::TfrxView* Obj, System::UnicodeString FillValue);
	void __fastcall DoBackground(Frxclass::TfrxView* Obj);
	bool __fastcall DoHyperLink(Frxclass::TfrxView* Obj);
	System::UnicodeString __fastcall WrapByCrLf(const System::UnicodeString Text, /* out */ int &BreakCount, const double x, const double dy);
	__classmethod bool __fastcall HasSpecialChars(const System::UnicodeString s);
	__classmethod System::UnicodeString __fastcall EscapeTextAndAttribute(const System::UnicodeString s);
	
public:
	__fastcall virtual TfrxSVGExport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxSVGExport(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall Finish(void);
	void __fastcall AttachHandler(Frxexporthelpers::TfrxExportHandler Handler);
	__property Frxexporthelpers::TfrxCSSStyle* ShadowStyle = {read=GetShadowStyle};
	
__published:
	__property OverwritePrompt;
	__property bool OpenAfterExport = {read=FOpenAfterExport, write=FOpenAfterExport, nodefault};
	__property bool MultiPage = {read=FMultiPage, write=FMultiPage, nodefault};
	__property bool Formatted = {read=FFormatted, write=FFormatted, nodefault};
	__property Frxexporthelpers::TfrxPictureFormat PictureFormat = {read=FPicFormat, write=SetPicFormat, nodefault};
	__property bool UnifiedPictures = {read=FUnifiedPictures, write=FUnifiedPictures, nodefault};
	__property bool EmbeddedPictures = {read=FEmbeddedPictures, write=FEmbeddedPictures, nodefault};
	__property bool EmbeddedCSS = {read=FEmbeddedCSS, write=FEmbeddedCSS, nodefault};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxSVGExport(void) : Frxclass::TfrxCustomExportFilter() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexportsvg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTSVG)
using namespace Frxexportsvg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportsvgHPP
