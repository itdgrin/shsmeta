// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditFrame.pas' rev: 26.00 (Windows)

#ifndef FrxeditframeHPP
#define FrxeditframeHPP

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
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.ToolWin.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <frxCtrls.hpp>	// Pascal unit
#include <frxDock.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxDesgnCtrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxeditframe
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxFrameEditorForm;
class PASCALIMPLEMENTATION TfrxFrameEditorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TGroupBox* FrameGB;
	Vcl::Buttons::TSpeedButton* FrameAllB;
	Vcl::Buttons::TSpeedButton* FrameNoB;
	Vcl::Buttons::TSpeedButton* FrameTopB;
	Vcl::Buttons::TSpeedButton* FrameBottomB;
	Vcl::Buttons::TSpeedButton* FrameLeftB;
	Vcl::Buttons::TSpeedButton* FrameRightB;
	Vcl::Stdctrls::TCheckBox* ShadowCB;
	Vcl::Stdctrls::TLabel* ShadowWidthL;
	Vcl::Stdctrls::TComboBox* ShadowWidthCB;
	Vcl::Stdctrls::TLabel* ShadowColorL;
	Vcl::Stdctrls::TGroupBox* LineGB;
	Vcl::Stdctrls::TLabel* LineStyleL;
	Vcl::Stdctrls::TLabel* LineWidthL;
	Vcl::Stdctrls::TComboBox* LineWidthCB;
	Vcl::Stdctrls::TLabel* LineColorL;
	Vcl::Stdctrls::TLabel* HintL;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FrameAllBClick(System::TObject* Sender);
	void __fastcall FrameNoBClick(System::TObject* Sender);
	void __fastcall FrameLineClick(System::TObject* Sender);
	void __fastcall ShadowCBClick(System::TObject* Sender);
	void __fastcall ShadowWidthCBChange(System::TObject* Sender);
	
private:
	Frxclass::TfrxFrame* FFrame;
	Frxdesgnctrls::TfrxFrameSampleControl* SampleC;
	Frxdesgnctrls::TfrxLineStyleControl* LineStyleC;
	Frxdesgnctrls::TfrxColorComboBox* ShadowColorCB;
	Frxdesgnctrls::TfrxColorComboBox* LineColorCB;
	void __fastcall SetFrame(Frxclass::TfrxFrame* const Value);
	void __fastcall FrameLineClicked(Frxclass::TfrxFrameType Line, bool state);
	void __fastcall ShadowColorChanged(System::TObject* Sender);
	Frxclass::TfrxFrameStyle __fastcall LineStyle(void);
	System::Extended __fastcall LineWidth(void);
	System::Uitypes::TColor __fastcall LineColor(void);
	void __fastcall UpdateControls(void);
	void __fastcall Change(void);
	
public:
	__property Frxclass::TfrxFrame* Frame = {read=FFrame, write=SetFrame};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxFrameEditorForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxFrameEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxFrameEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxFrameEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditframe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEDITFRAME)
using namespace Frxeditframe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditframeHPP
