// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxSynMemo.pas' rev: 26.00 (Windows)

#ifndef FrxsynmemoHPP
#define FrxsynmemoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <Winapi.Imm.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <frxCtrls.hpp>	// Pascal unit
#include <fs_iparser.hpp>	// Pascal unit
#include <frxPopupForm.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxsynmemo
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TCharAttr : unsigned char { caNo, caText, caBlock, caComment, caKeyword, caString, caNumber };

typedef System::Set<TCharAttr, TCharAttr::caNo, TCharAttr::caNumber> TCharAttributes;

typedef void __fastcall (__closure *TfrxCodeCompletionEvent)(const System::UnicodeString Name, System::Classes::TStrings* List);

class DELPHICLASS TfrxSyntaxMemo;
class PASCALIMPLEMENTATION TfrxSyntaxMemo : public Frxctrls::TfrxScrollWin
{
	typedef Frxctrls::TfrxScrollWin inherited;
	
private:
	int FActiveLine;
	bool FAllowLinesChange;
	System::Uitypes::TColor FBlockColor;
	System::Uitypes::TColor FBlockFontColor;
	System::StaticArray<int, 10> FBookmarks;
	int FCharHeight;
	int FCharWidth;
	Vcl::Graphics::TFont* FCommentAttr;
	Frxpopupform::TfrxPopupForm* FCompletionForm;
	Vcl::Stdctrls::TListBox* FCompletionLB;
	bool FDoubleClicked;
	bool FDown;
	bool FToggleBreakPointDown;
	int FGutterWidth;
	bool FIsMonoType;
	Vcl::Graphics::TFont* FKeywordAttr;
	int FMaxLength;
	System::UnicodeString FMessage;
	bool FModified;
	bool FMoved;
	Vcl::Graphics::TFont* FNumberAttr;
	System::Types::TPoint FOffset;
	System::Classes::TNotifyEvent FOnChangePos;
	System::Classes::TNotifyEvent FOnChangeText;
	TfrxCodeCompletionEvent FOnCodeCompletion;
	Fs_iparser::TfsParser* FParser;
	System::Types::TPoint FPos;
	Vcl::Graphics::TFont* FStringAttr;
	System::Types::TPoint FSelEnd;
	System::Types::TPoint FSelStart;
	System::Types::TPoint FCompSelStart;
	System::Types::TPoint FCompSelEnd;
	bool FShowGutter;
	System::Classes::TStrings* FSynStrings;
	System::UnicodeString FSyntax;
	System::Types::TPoint FTempPos;
	System::Classes::TStringList* FText;
	Vcl::Graphics::TFont* FTextAttr;
	System::Classes::TStringList* FUndo;
	bool FUpdatingSyntax;
	System::Types::TPoint FWindowSize;
	System::Classes::TStringList* FBreakPoints;
	TCharAttributes __fastcall GetCharAttr(const System::Types::TPoint &Pos);
	int __fastcall GetLineBegin(int Index);
	int __fastcall GetPlainTextPos(const System::Types::TPoint &Pos);
	System::Types::TPoint __fastcall GetPosPlainText(int Pos);
	bool __fastcall GetRunLine(int Index);
	System::UnicodeString __fastcall GetSelText(void);
	HIDESBASE System::Classes::TStrings* __fastcall GetText(void);
	System::UnicodeString __fastcall LineAt(int Index);
	int __fastcall LineLength(int Index);
	System::UnicodeString __fastcall Pad(int n);
	void __fastcall AddSel(void);
	void __fastcall AddUndo(void);
	void __fastcall ClearSel(void);
	void __fastcall ClearSyntax(int ClearFrom);
	void __fastcall CompletionLBDblClick(System::TObject* Sender);
	void __fastcall CompletionLBDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall CompletionLBKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall CorrectBookmark(int Line, int Delta);
	void __fastcall CorrectBreakPoints(int Line, int Delta);
	void __fastcall CreateSynArray(int EndLine);
	void __fastcall DoBackspace(void);
	void __fastcall DoChange(void);
	void __fastcall DoChar(System::WideChar Ch);
	void __fastcall DoCodeCompletion(void);
	void __fastcall DoCtrlI(void);
	void __fastcall DoCtrlU(void);
	void __fastcall DoCtrlR(void);
	void __fastcall DoCtrlL(void);
	void __fastcall DoDel(void);
	void __fastcall DoDown(void);
	void __fastcall DoEnd(bool Ctrl);
	void __fastcall DoHome(bool Ctrl);
	void __fastcall DoLeft(void);
	void __fastcall DoPgUp(void);
	void __fastcall DoPgDn(void);
	void __fastcall DoReturn(void);
	void __fastcall DoRight(void);
	void __fastcall DoUp(void);
	void __fastcall EnterIndent(void);
	void __fastcall LinesChange(System::TObject* Sender);
	void __fastcall SetActiveLine(int Line);
	void __fastcall SetCommentAttr(Vcl::Graphics::TFont* Value);
	void __fastcall SetKeywordAttr(Vcl::Graphics::TFont* Value);
	void __fastcall SetNumberAttr(Vcl::Graphics::TFont* const Value);
	void __fastcall SetRunLine(int Index, const bool Value);
	void __fastcall SetSelText(const System::UnicodeString Value);
	void __fastcall SetShowGutter(bool Value);
	void __fastcall SetStringAttr(Vcl::Graphics::TFont* Value);
	void __fastcall SetSyntax(const System::UnicodeString Value);
	HIDESBASE void __fastcall SetText(System::Classes::TStrings* Value);
	void __fastcall SetTextAttr(Vcl::Graphics::TFont* Value);
	void __fastcall ShiftSelected(bool ShiftRight);
	void __fastcall ShowCaretPos(void);
	void __fastcall TabIndent(void);
	void __fastcall UnIndent(void);
	HIDESBASE void __fastcall UpdateScrollBar(void);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMIMEStartComp(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMIMEEndComp(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMIMECOMPOSITION(Winapi::Messages::TMessage &Message);
	bool __fastcall GetTextSelected(void);
	
protected:
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseWheelDown(System::TObject* Sender, System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos, bool &Handled);
	void __fastcall MouseWheelUp(System::TObject* Sender, System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos, bool &Handled);
	virtual void __fastcall OnHScrollChange(System::TObject* Sender);
	virtual void __fastcall OnVScrollChange(System::TObject* Sender);
	DYNAMIC void __fastcall Resize(void);
	
public:
	__fastcall virtual TfrxSyntaxMemo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxSyntaxMemo(void);
	virtual void __fastcall Paint(void);
	void __fastcall CopyToClipboard(void);
	void __fastcall CutToClipboard(void);
	void __fastcall PasteFromClipboard(void);
	void __fastcall SelectAll(void);
	void __fastcall SetPos(int x, int y);
	void __fastcall ShowMessage(const System::UnicodeString s);
	void __fastcall Undo(void);
	void __fastcall UpdateView(void);
	bool __fastcall Find(const System::UnicodeString SearchText, bool CaseSensitive, int &SearchFrom);
	int __fastcall GetPlainPos(void);
	System::Types::TPoint __fastcall GetPos(void);
	int __fastcall IsBookmark(int Line);
	void __fastcall AddBookmark(int Line, int Number);
	void __fastcall DeleteBookmark(int Number);
	void __fastcall GotoBookmark(int Number);
	void __fastcall AddBreakPoint(int Number, const System::UnicodeString Condition);
	void __fastcall ToggleBreakPoint(int Number, const System::UnicodeString Condition);
	void __fastcall DeleteBreakPoint(int Number);
	void __fastcall DeleteF4BreakPoints(void);
	bool __fastcall IsBreakPoint(int Number);
	System::UnicodeString __fastcall GetBreakPointCondition(int Number);
	__property int ActiveLine = {read=FActiveLine, write=SetActiveLine, nodefault};
	__property System::Uitypes::TColor BlockColor = {read=FBlockColor, write=FBlockColor, nodefault};
	__property System::Uitypes::TColor BlockFontColor = {read=FBlockFontColor, write=FBlockFontColor, nodefault};
	__property System::Classes::TStringList* BreakPoints = {read=FBreakPoints};
	__property Color = {default=-16777211};
	__property Vcl::Graphics::TFont* CommentAttr = {read=FCommentAttr, write=SetCommentAttr};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property int GutterWidth = {read=FGutterWidth, write=FGutterWidth, nodefault};
	__property Vcl::Graphics::TFont* KeywordAttr = {read=FKeywordAttr, write=SetKeywordAttr};
	__property bool Modified = {read=FModified, write=FModified, nodefault};
	__property Vcl::Graphics::TFont* NumberAttr = {read=FNumberAttr, write=SetNumberAttr};
	__property bool RunLine[int Index] = {read=GetRunLine, write=SetRunLine};
	__property System::UnicodeString SelText = {read=GetSelText, write=SetSelText};
	__property Vcl::Graphics::TFont* StringAttr = {read=FStringAttr, write=SetStringAttr};
	__property Vcl::Graphics::TFont* TextAttr = {read=FTextAttr, write=SetTextAttr};
	__property System::Classes::TStrings* Lines = {read=GetText, write=SetText};
	__property System::UnicodeString Syntax = {read=FSyntax, write=SetSyntax};
	__property bool ShowGutter = {read=FShowGutter, write=SetShowGutter, nodefault};
	__property bool TextSelected = {read=GetTextSelected, nodefault};
	__property System::Classes::TNotifyEvent OnChangePos = {read=FOnChangePos, write=FOnChangePos};
	__property System::Classes::TNotifyEvent OnChangeText = {read=FOnChangeText, write=FOnChangeText};
	__property TfrxCodeCompletionEvent OnCodeCompletion = {read=FOnCodeCompletion, write=FOnCodeCompletion};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnKeyDown;
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxSyntaxMemo(HWND ParentWindow) : Frxctrls::TfrxScrollWin(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxsynmemo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSYNMEMO)
using namespace Frxsynmemo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxsynmemoHPP
