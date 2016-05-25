// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportHTML.pas' rev: 26.00 (Windows)

#ifndef FrxexporthtmlHPP
#define FrxexporthtmlHPP

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
#include <Vcl.Imaging.jpeg.hpp>	// Pascal unit
#include <Winapi.ShellAPI.hpp>	// Pascal unit
#include <frxExportMatrix.hpp>	// Pascal unit
#include <frxProgress.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <frxExportImage.hpp>	// Pascal unit
#include <frxImageConverter.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxexporthtml
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxHTMLExportDialog;
class PASCALIMPLEMENTATION TfrxHTMLExportDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Stdctrls::TGroupBox* GroupQuality;
	Vcl::Stdctrls::TCheckBox* StylesCB;
	Vcl::Stdctrls::TCheckBox* PicsSameCB;
	Vcl::Stdctrls::TCheckBox* FixWidthCB;
	Vcl::Stdctrls::TCheckBox* NavigatorCB;
	Vcl::Stdctrls::TCheckBox* MultipageCB;
	Vcl::Stdctrls::TGroupBox* GroupPageRange;
	Vcl::Stdctrls::TLabel* DescrL;
	Vcl::Stdctrls::TRadioButton* AllRB;
	Vcl::Stdctrls::TRadioButton* CurPageRB;
	Vcl::Stdctrls::TRadioButton* PageNumbersRB;
	Vcl::Stdctrls::TEdit* PageNumbersE;
	Vcl::Stdctrls::TCheckBox* OpenAfterCB;
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TCheckBox* BackgrCB;
	Vcl::Stdctrls::TLabel* PicturesL;
	Vcl::Stdctrls::TComboBox* PFormatCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageNumbersEChange(System::TObject* Sender);
	void __fastcall PageNumbersEKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxHTMLExportDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxHTMLExportDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxHTMLExportDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxHTMLExportDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TfrxHTMLExportGetNavTemplate)(const System::UnicodeString ReportName, bool Multipage, bool PicsInSameFolder, System::UnicodeString Prefix, int TotalPages, System::UnicodeString &Template);

typedef void __fastcall (__closure *TfrxHTMLExportGetMainTemplate)(const System::UnicodeString Title, const System::UnicodeString FrameFolder, bool Multipage, bool Navigator, System::UnicodeString &Template);

typedef void __fastcall (__closure *TfrxHTMLExportGetToolbarTemplate)(int CurrentPage, int TotalPages, bool Multipage, bool Naviagtor, System::UnicodeString &Template);

typedef void __fastcall (__closure *TfrxHTMLExportImage)(Vcl::Graphics::TGraphic* Image, Frximageconverter::TfrxPictureType PicType, System::UnicodeString &FileName);

class DELPHICLASS TfrxHTMLExport;
class PASCALIMPLEMENTATION TfrxHTMLExport : public Frxclass::TfrxCustomExportFilter
{
	typedef Frxclass::TfrxCustomExportFilter inherited;
	
private:
	System::Classes::TStream* Exp;
	bool FAbsLinks;
	int FCurrentPage;
	bool FExportPictures;
	bool FExportStyles;
	bool FFixedWidth;
	Frxexportmatrix::TfrxIEMatrix* FMatrix;
	bool FMozillaBrowser;
	bool FMultipage;
	bool FNavigator;
	bool FOpenAfterExport;
	bool FPicsInSameFolder;
	int FPicturesCount;
	Frxprogress::TfrxProgress* FProgress;
	bool FServer;
	System::UnicodeString FPrintLink;
	System::UnicodeString FRefreshLink;
	bool FBackground;
	Vcl::Graphics::TBitmap* FBackImage;
	bool FBackImageExist;
	System::UnicodeString FReportPath;
	bool FCentered;
	bool FEmptyLines;
	System::UnicodeString FURLTarget;
	Frximageconverter::TfrxPictureType FPictureType;
	bool FPrint;
	bool FUseTemplates;
	TfrxHTMLExportGetNavTemplate FGetNavTemplate;
	TfrxHTMLExportGetMainTemplate FGetMainTemplate;
	TfrxHTMLExportGetToolbarTemplate FGetToolbarTemplate;
	TfrxHTMLExportImage FExportImage;
	System::Classes::TStrings* FHTMLDocumentBegin;
	System::Classes::TStrings* FHTMLDocumentBody;
	System::Classes::TStrings* FHTMLDocumentEnd;
	void __fastcall WriteExpLn(const System::UnicodeString str);
	void __fastcall WriteExpLnA(const System::AnsiString str);
	void __fastcall ExportPage(void);
	System::UnicodeString __fastcall ChangeReturns(const System::UnicodeString Str);
	System::WideString __fastcall TruncReturns(const System::WideString Str);
	System::UnicodeString __fastcall GetPicsFolder(void);
	System::UnicodeString __fastcall GetPicsFolderRel(void);
	System::UnicodeString __fastcall GetFrameFolder(void);
	System::UnicodeString __fastcall ReverseSlash(const System::UnicodeString S);
	System::UnicodeString __fastcall HTMLCodeStr(const System::UnicodeString Str);
	
public:
	__fastcall virtual TfrxHTMLExport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxHTMLExport(void);
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property bool Server = {read=FServer, write=FServer, nodefault};
	__property System::UnicodeString PrintLink = {read=FPrintLink, write=FPrintLink};
	__property System::UnicodeString RefreshLink = {read=FRefreshLink, write=FRefreshLink};
	__property System::UnicodeString ReportPath = {read=FReportPath, write=FReportPath};
	__property bool UseTemplates = {read=FUseTemplates, write=FUseTemplates, nodefault};
	__property TfrxHTMLExportGetMainTemplate OnGetMainTemplate = {read=FGetMainTemplate, write=FGetMainTemplate};
	__property TfrxHTMLExportGetToolbarTemplate OnGetToolbarTemplate = {read=FGetToolbarTemplate, write=FGetToolbarTemplate};
	__property TfrxHTMLExportGetNavTemplate OnGetNavTemplate = {read=FGetNavTemplate, write=FGetNavTemplate};
	__property TfrxHTMLExportImage OnExportImage = {read=FExportImage, write=FExportImage};
	
__published:
	__property bool OpenAfterExport = {read=FOpenAfterExport, write=FOpenAfterExport, default=0};
	__property bool FixedWidth = {read=FFixedWidth, write=FFixedWidth, default=0};
	__property bool ExportPictures = {read=FExportPictures, write=FExportPictures, default=1};
	__property bool PicsInSameFolder = {read=FPicsInSameFolder, write=FPicsInSameFolder, default=0};
	__property bool ExportStyles = {read=FExportStyles, write=FExportStyles, default=1};
	__property bool Navigator = {read=FNavigator, write=FNavigator, default=0};
	__property bool Multipage = {read=FMultipage, write=FMultipage, default=0};
	__property bool MozillaFrames = {read=FMozillaBrowser, write=FMozillaBrowser, default=0};
	__property bool AbsLinks = {read=FAbsLinks, write=FAbsLinks, default=0};
	__property bool Background = {read=FBackground, write=FBackground, nodefault};
	__property bool Centered = {read=FCentered, write=FCentered, nodefault};
	__property bool EmptyLines = {read=FEmptyLines, write=FEmptyLines, nodefault};
	__property OverwritePrompt;
	__property System::Classes::TStrings* HTMLDocumentBegin = {read=FHTMLDocumentBegin};
	__property System::Classes::TStrings* HTMLDocumentBody = {read=FHTMLDocumentBody};
	__property System::Classes::TStrings* HTMLDocumentEnd = {read=FHTMLDocumentEnd};
	__property System::UnicodeString URLTarget = {read=FURLTarget, write=FURLTarget};
	__property bool Print = {read=FPrint, write=FPrint, nodefault};
	__property Frximageconverter::TfrxPictureType PictureType = {read=FPictureType, write=FPictureType, nodefault};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxHTMLExport(void) : Frxclass::TfrxCustomExportFilter() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexporthtml */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTHTML)
using namespace Frxexporthtml;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexporthtmlHPP
