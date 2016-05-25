
{******************************************}
{                                          }
{             FastReport v5.0              }
{           Syntax memo control            }
{                                          }
{         Copyright (c) 1998-2014          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxSynMemo;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}Windows, Messages, Imm,{$ENDIF}
  Types, SysUtils, Classes, Graphics, Controls, StdCtrls,
  Forms, frxCtrls, fs_iparser, frxPopupForm
  {$IFDEF FPC}
  , LCLType, LMessages, LazHelper, LCLIntf, LCLProc
  {$ENDIF}
  ;

type
  TCharAttr = (caNo, caText, caBlock, caComment, caKeyword, caString,
    caNumber);
  TCharAttributes = set of TCharAttr;

  TfrxCodeCompletionEvent = procedure(const Name: String; List: TStrings) of object;

  TfrxSyntaxMemo = class(TfrxScrollWin)
  private
    {$IFDEF NONWINFPC}
    FCaretCreated: Boolean;
    {$ENDIF}
    FActiveLine: Integer;
    FAllowLinesChange: Boolean;
    FBlockColor: TColor;
    FBlockFontColor: TColor;
    FBookmarks: array[0..9] of Integer;
    FCharHeight: Integer;
    FCharWidth: Integer;
    FCommentAttr: TFont;
    FCompletionForm: TfrxPopupForm;
    FCompletionLB: TListBox;
    FDoubleClicked: Boolean;
    FDown: Boolean;
    FToggleBreakPointDown: Boolean;
    FGutterWidth: Integer;
    FIsMonoType: Boolean;
    FKeywordAttr: TFont;
    FMaxLength: Integer;
    FMessage: String;
    FModified: Boolean;
    FMoved: Boolean;
    FNumberAttr: TFont;
    FOffset: TPoint;
    FOnChangePos: TNotifyEvent;
    FOnChangeText: TNotifyEvent;
    FOnCodeCompletion: TfrxCodeCompletionEvent;
    FParser: TfsParser;
    FPos: TPoint;
    FStringAttr: TFont;
    FSelEnd: TPoint;
    FSelStart: TPoint;
{$IFNDEF FPC}
    FCompSelStart: TPoint;
    FCompSelEnd: TPoint;
{$ENDIF}
    FShowGutter: boolean;
    FSynStrings: TStrings;
    FSyntax: String;
    FTempPos: TPoint;
    FText: TStringList;
    FTextAttr: TFont;
    FUndo: TStringList;
    FUpdatingSyntax: Boolean;
    FWindowSize: TPoint;
    FBreakPoints: TStringList;
{$IFNDEF FPC}
{$IFDEF JPN}
    FTmpCanvas: TBitmap;
    {  need for east languages carret correction  }
    function GetCharWidth(Str: String): Integer;
{$ENDIF}
{$ENDIF}
    function GetCharAttr(Pos: TPoint): TCharAttributes;
    function GetLineBegin(Index: Integer): Integer;
    function GetPlainTextPos(Pos: TPoint): Integer;
    function GetPosPlainText(Pos: Integer): TPoint;
    function GetRunLine(Index: Integer): Boolean;
    function GetSelText: String;
    function GetText: TStrings;
    function LineAt(Index: Integer): String;
    function LineLength(Index: Integer): Integer;
    function Pad(n: Integer): String;
    procedure AddSel;
    procedure AddUndo;
    procedure ClearSel;
    procedure ClearSyntax(ClearFrom: Integer);
    procedure CompletionLBDblClick(Sender: TObject);
    procedure CompletionLBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure CompletionLBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CorrectBookmark(Line, Delta: Integer);
    procedure CorrectBreakPoints(Line, Delta: Integer);
    procedure CreateSynArray(EndLine: Integer);
    procedure DoBackspace;
    procedure DoChange;
    procedure DoChar(Ch: Char);
    procedure DoCodeCompletion;
    procedure DoCtrlI;
    procedure DoCtrlU;
    procedure DoCtrlR;
    procedure DoCtrlL;
    procedure DoDel;
    procedure DoDown;
    procedure DoEnd(Ctrl: Boolean);
    procedure DoHome(Ctrl: Boolean);
    procedure DoLeft;
    procedure DoPgUp;
    procedure DoPgDn;
    procedure DoReturn;
    procedure DoRight;
    procedure DoUp;
    procedure EnterIndent;
    procedure LinesChange(Sender: TObject);
    procedure SetActiveLine(Line: Integer);
    procedure SetCommentAttr(Value: TFont);
    procedure SetKeywordAttr(Value: TFont);
    procedure SetNumberAttr(const Value: TFont);
    procedure SetRunLine(Index: Integer; const Value: Boolean);
    procedure SetSelText(const Value: String);
    procedure SetShowGutter(Value: Boolean);
    procedure SetStringAttr(Value: TFont);
    procedure SetSyntax(const Value: String);
    procedure SetText(Value: TStrings);
    procedure SetTextAttr(Value: TFont);
    procedure ShiftSelected(ShiftRight: Boolean);
    procedure ShowCaretPos;
    procedure TabIndent;
    procedure UnIndent;
    procedure UpdateScrollBar;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    { Inline IME realisation }
	{$IFNDEF FPC}
    procedure WMIMEStartComp(var Message: TMessage); message WM_IME_STARTCOMPOSITION;
    procedure WMIMEEndComp(var Message: TMessage); message WM_IME_ENDCOMPOSITION;
    procedure WMIMECOMPOSITION (var Message: TMessage); message WM_IME_COMPOSITION ;
	{$ENDIF}
    function GetTextSelected: Boolean;
  protected
    procedure DblClick; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    {$IFDEF FPC}
    procedure UTF8KeyPress(var UTF8Key: TUTF8Char); override;
    {$ENDIF}
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure OnHScrollChange(Sender: TObject); override;
    procedure OnVScrollChange(Sender: TObject); override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure PasteFromClipboard;
    procedure SelectAll;
    procedure SetPos(x, y: Integer);
    procedure ShowMessage(const s: String);
    procedure Undo;
    procedure UpdateView;
    function Find(const SearchText: String; CaseSensitive: Boolean;
      var SearchFrom: Integer): Boolean;
    function GetPlainPos: Integer;
    function GetPos: TPoint;
    function IsBookmark(Line: Integer): Integer;
    procedure AddBookmark(Line, Number: Integer);
    procedure DeleteBookmark(Number: Integer);
    procedure GotoBookmark(Number: Integer);
    procedure AddBreakPoint(Number: Integer; const Condition: String);
    procedure ToggleBreakPoint(Number: Integer; const Condition: String);
    procedure DeleteBreakPoint(Number: Integer);
    procedure DeleteF4BreakPoints;
    function IsBreakPoint(Number: Integer): Boolean;
    function GetBreakPointCondition(Number: Integer): String;

    property ActiveLine: Integer read FActiveLine write SetActiveLine;
    property BlockColor: TColor read FBlockColor write FBlockColor;
    property BlockFontColor: TColor read FBlockFontColor write FBlockFontColor;
    property BreakPoints: TStringList read FBreakPoints;
    property Color;
    property CommentAttr: TFont read FCommentAttr write SetCommentAttr;
    property Font;
	{$IFNDEF FPC}
    property ImeMode;
    property ImeName;
  	{$ENDIF}
    property GutterWidth: Integer read FGutterWidth write FGutterWidth;
    property KeywordAttr: TFont read FKeywordAttr write SetKeywordAttr;
    property Modified: Boolean read FModified write FModified;
    property NumberAttr: TFont read FNumberAttr write SetNumberAttr;
    property RunLine[Index: Integer]: Boolean read GetRunLine write SetRunLine;
    property SelText: String read GetSelText write SetSelText;
    property StringAttr: TFont read FStringAttr write SetStringAttr;
    property TextAttr: TFont read FTextAttr write SetTextAttr;
    property Lines: TStrings read GetText write SetText;
    property Syntax: String read FSyntax write SetSyntax;
    property ShowGutter: boolean read FShowGutter write SetShowGutter;
    property TextSelected: Boolean read GetTextSelected; 
    property OnChangePos: TNotifyEvent read FOnChangePos write FOnChangePos;
    property OnChangeText: TNotifyEvent read FOnChangeText write FOnChangeText;
    property OnCodeCompletion: TfrxCodeCompletionEvent read FOnCodeCompletion
      write FOnCodeCompletion;
    property OnDragDrop;
    property OnDragOver;
    property OnKeyDown;
  end;


implementation


uses Clipbrd, fs_itools, frxXML, frxUtils;

const
  SQLKeywords =
    'active,after,all,alter,and,any,as,asc,ascending,at,auto,' +
    'base_name,before,begin,between,by,cache,call,cast,check,column,commit,' +
    'committed,computed,conditional,constraint,containing,count,create,' +
    'current,cursor,database,debug,declare,default,delete,desc,descending,' +
    'distinct,do,domain,drop,else,end,entry_point,escape,exception,execute,' +
    'exists,exit,external,extract,filter,for,foreign,from,full,function,' +
    'generator,grant,group,having,if,in,inactive,index,inner,insert,into,is,' +
    'isolation,join,key,left,level,like,merge,names,no,not,null,of,on,only,' +
    'or,order,outer,parameter,password,plan,position,primary,privileges,' +
    'procedure,protected,read,retain,returns,revoke,right,rollback,schema,' +
    'select,set,shadow,shared,snapshot,some,suspend,table,then,to,' +
    'transaction,trigger,uncommitted,union,unique,update,user,using,values,' +
    'view,wait,when,where,while,with,work';

  WordChars = ['a'..'z', 'A'..'Z', 'à'..'ÿ', 'À'..'ß', '0'..'9', '_'];

  {$IFDEF NONWINFPC}
  LineBreak: String = #$A;
  {$ELSE}
  LineBreak: String = #$D#$A;
  {$ENDIF}

{$IFDEF Delphi12}
function IsUnicodeChar(Chr: Char): Boolean;
begin
  Result := ((Chr >= Char($007F)) and (Chr <= Char($FFFF)));
end;
{$ENDIF}

{ TfrxSyntaxMemo }

constructor TfrxSyntaxMemo.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited;
{$IFNDEF FPC}
{$IFDEF JPN}
  FTmpCanvas := TBitmap.Create;
{$ENDIF}
{$ENDIF}
  {$IFDEF NONWINFPC}
  FCaretCreated := False;
  {$ENDIF}
  DoubleBuffered := True;
  TabStop := True;
  Cursor := crIBeam;
  Color := clWindow;

  FBreakPoints := TStringList.Create;

  FBlockColor := clHighlight;
  FBlockFontColor := clHighlightText;

  FCommentAttr := TFont.Create;
  FCommentAttr.Color := clNavy;
  FCommentAttr.Style := [fsItalic];

  FKeywordAttr := TFont.Create;
  FKeywordAttr.Color := clWindowText;
  FKeywordAttr.Style := [fsBold];

  FNumberAttr := TFont.Create;
  FNumberAttr.Color := clGreen;
  FNumberAttr.Style := [];

  FStringAttr := TFont.Create;
  FStringAttr.Color := clNavy;
  FStringAttr.Style := [];

  FTextAttr := TFont.Create;
  FTextAttr.Color := clWindowText;
  FTextAttr.Style := [];

  Font.Size := 10;
  Font.Name := 'Courier New';

  FText := TStringList.Create;
  FParser := TfsParser.Create;
  FParser.SkipSpace := False;
  FParser.UseY := False;
  FSynStrings := TStringList.Create;
  FUndo := TStringList.Create;
  FText.Add('');
  FText.OnChange := LinesChange;
  FMaxLength := 1024;
  FMoved := True;
  SetPos(1, 1);

  ShowGutter := True;
  OnMouseWheelUp := MouseWheelUp;
  OnMouseWheelDown := MouseWheelDown;

  FActiveLine := -1;
  for i := 0 to 9 do
    FBookmarks[i] := -1;
end;

destructor TfrxSyntaxMemo.Destroy;
begin
{$IFNDEF FPC}
{$IFDEF JPN}
  FTmpCanvas.Free;
{$ENDIF}
{$ENDIF}
  FBreakPoints.Free;
  FCommentAttr.Free;
  FKeywordAttr.Free;
  FNumberAttr.Free;
  FStringAttr.Free;
  FTextAttr.Free;
  FText.Free;
  FUndo.Free;
  FSynStrings.Free;
  FParser.Free;
  inherited;
end;

{$IFNDEF FPC}
{ updating IME string and carret pos }
procedure TfrxSyntaxMemo.WMIMECOMPOSITION(var Message: TMessage);
var
  h: HIMC;
  nLen, nPos: Integer;
  StrBuf: String;
begin
  if Message.LParam = $1E00 then
    ResetImeComposition(CPS_CANCEL)
  else
  begin
    h := Imm32GetContext(Handle);
    if h <> 0 then
    begin
      nPos := Imm32GetCompositionString(h, GCS_CURSORPOS, nil, 0);
      nLen := Imm32GetCompositionString(h, GCS_COMPSTR, nil, 0);
      if nLen <> 0 then
      begin
        SetLength(StrBuf, nLen div 2);
        Imm32GetCompositionString(h, GCS_COMPSTR, @StrBuf[1], nLen);
        if (nLen div 2) > FCompSelEnd.X - FCompSelStart.X then
          FCompSelEnd.X := FCompSelStart.X + (nLen div 2) - 1;
        FSelStart.Y := FCompSelStart.Y;
        FSelStart.X := FCompSelStart.X;
        FSelEnd.Y := FCompSelEnd.Y;
        FSelEnd.X := FCompSelEnd.X;
        SelText := StrBuf;
        FPos.X := FCompSelStart.X + nPos;
        SetPos(FPos.X, FPos.Y);
        FCompSelEnd.X := FCompSelStart.X + (nLen div 2);
        Invalidate;
      end;
      Imm32ReleaseContext(Handle, h);
    end;
    Inherited;
  end;
end;

procedure TfrxSyntaxMemo.WMIMEEndComp(var Message: TMessage);
begin
  FInImeComposition := False;
end;

procedure TfrxSyntaxMemo.WMIMEStartComp(var Message: TMessage);
begin
  FCompSelStart.Y := FPos.Y;
  FCompSelStart.X := FPos.X;
  FCompSelEnd.Y := FPos.Y;
  FCompSelEnd.X := FPos.X;
  FInImeComposition := True;
end;
{$ENDIF}

procedure TfrxSyntaxMemo.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  {$IFDEF NONWINFPC}
  if not FCaretCreated then
    exit
  else
    FCaretCreated := False;
  {$ENDIF}
  HideCaret(Handle);
  DestroyCaret{$IFDEF FPC}(Handle){$ENDIF};
end;

procedure TfrxSyntaxMemo.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  {$IFDEF NONWINFPC}
  if not HandleAllocated then
    exit
  else
    FCaretCreated := True;
  {$ENDIF}
  CreateCaret(Handle, 0, 2, FCharHeight);
  ShowCaretPos;
end;

procedure TfrxSyntaxMemo.ShowCaretPos;
{$IFNDEF FPC}
var
  cWidth: Integer;
{$ENDIF}
begin
  if FPos.X > FOffset.X then
  begin
{$IFNDEF FPC}
{$IFDEF JPN}
    if Length(Lines[FPos.Y - 1]) > FPos.X then
      cWidth  := GetCharWidth(Copy(Lines[FPos.Y - 1], 1, FPos.X - 1  - FOffset.X))
    else
{$ENDIF}
      cWidth := FCharWidth * (FPos.X - 1 - FOffset.X);
    SetCaretPos(cWidth + FGutterWidth,
      FCharHeight * (FPos.Y - 1 - FOffset.Y));
{$ELSE}
    SetCaretPos(FCharWidth * (FPos.X - 1 - FOffset.X) + FGutterWidth,
      FCharHeight * (FPos.Y - 1 - FOffset.Y));
{$ENDIF}
    {$IFDEF NONWINFPC}
    if FCaretCreated then
      Update;
    {$ELSE}
    ShowCaret(Handle);
    {$ENDIF}
  end
  else
    SetCaretPos(-100, -100);
  if Assigned(FOnChangePos) then
    FOnChangePos(Self);
end;

procedure TfrxSyntaxMemo.CMFontChanged(var Message: TMessage);
var
  b: TBitmap;
begin
  FCommentAttr.Size := Font.Size;
  FCommentAttr.Name := Font.Name;
  FKeywordAttr.Size := Font.Size;
  FKeywordAttr.Name := Font.Name;
  FNumberAttr.Size := Font.Size;
  FNumberAttr.Name := Font.Name;
  FStringAttr.Size := Font.Size;
  FStringAttr.Name := Font.Name;
  FTextAttr.Size := Font.Size;
  FTextAttr.Name := Font.Name;

  b := TBitmap.Create;
  with b.Canvas do
  begin
    Font.Assign(Self.Font);
    Font.Style := [fsBold];
    FCharHeight := TextHeight('Wg') + 1;
    FCharWidth := TextWidth('W');
    FIsMonoType := Pos('COURIER NEW', AnsiUppercase(Self.Font.Name)) <> 0;
  end;
  b.Free;
end;

procedure TfrxSyntaxMemo.Resize;
begin
  inherited;
  if FCharWidth = 0 then Exit;
  FWindowSize := Point((ClientWidth - FGutterWidth) div FCharWidth,
    ClientHeight div FCharHeight);
  {$IFDEF FPC}
  if (ClientHeight > 0) and (ClientWidth > 0) then
  begin
    HorzPage := FWindowSize.X;
    VertPage := FWindowSize.Y;
    UpdateScrollBar;
  end;
  {$ELSE}
  HorzPage := FWindowSize.X;
  VertPage := FWindowSize.Y;
  UpdateScrollBar;
  {$ENDIF}
end;

procedure TfrxSyntaxMemo.UpdateScrollBar;
begin
  VertRange := FText.Count;
  HorzRange := FMaxLength;
  LargeChange := FWindowSize.Y;
  VertPosition := FOffset.Y;
  HorzPosition := FOffset.X;
end;

function TfrxSyntaxMemo.GetText: TStrings;
//var
//  i: Integer;
begin
//  FAllowLinesChange := False;
//  for i := 0 to FText.Count - 1 do
//    FText[i] := LineAt(i);
  Result := FText;
  FAllowLinesChange := True;
end;

function TfrxSyntaxMemo.GetPlainPos: Integer;
begin
  Result := GetPlainTextPos(FPos);
end;

function TfrxSyntaxMemo.GetPos: TPoint;
begin
  Result := FPos;
end;

procedure TfrxSyntaxMemo.SetText(Value: TStrings);
begin
  FAllowLinesChange := True;
  FText.Assign(Value);
end;

procedure TfrxSyntaxMemo.SetSyntax(const Value: String);
var
  sl: TStringList;

  procedure GetGrammar;
  var
    Grammar: TfrxXMLDocument;
    ss: TStringStream;
    ParserRoot, xi: TfrxXMLItem;
    i: Integer;
    Name, PropText: String;
  begin
    Grammar := TfrxXMLDocument.Create;
    ss := TStringStream.Create(fsGetLanguage(Value){$IFDEF Delphi12}, TEncoding.UTF8{$ENDIF});
    Grammar.LoadFromStream(ss);
    ss.Free;

    ParserRoot := Grammar.Root.FindItem('parser');
    xi := ParserRoot.FindItem('keywords');
    for i := 0 to xi.Count - 1 do
      FParser.Keywords.Add(xi[i].Name);

    for i := 0 to ParserRoot.Count - 1 do
    begin
      Name := LowerCase(ParserRoot[i].Name);
      PropText := ParserRoot[i].Prop['text'];
      if Name = 'identchars' then
        FParser.ConstructCharset(PropText)
      else if Name = 'commentline1' then
        FParser.CommentLine1 := PropText
      else if Name = 'commentline2' then
        FParser.CommentLine2 := PropText
      else if Name = 'commentblock1' then
        FParser.CommentBlock1 := PropText
      else if Name = 'commentblock2' then
        FParser.CommentBlock2 := PropText
      else if Name = 'stringquotes' then
        FParser.StringQuotes := PropText
      else if Name = 'hexsequence' then
        FParser.HexSequence := PropText
    end;

    Grammar.Free;
  end;

begin
  FSyntax := Value;
  FParser.Keywords.Clear;
  sl := TStringList.Create;
  if AnsiCompareText(Value, 'SQL') = 0 then
  begin
    sl.CommaText := SQLKeywords;
    FParser.Keywords.Assign(sl);
    FParser.CommentLine1 := '--';
    FParser.CommentLine2 := '';
    FParser.CommentBlock1 := '/*,*/';
    FParser.CommentBlock2 := '';
    FParser.StringQuotes := '"';
    FParser.HexSequence := '0x';
  end
  else
  begin
    fsGetLanguageList(sl);
    if sl.IndexOf(Value) <> -1 then
      GetGrammar;
  end;

  ClearSyntax(1);
  sl.Free;
end;

procedure TfrxSyntaxMemo.SetCommentAttr(Value: TFont);
begin
  FCommentAttr.Assign(Value);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetKeywordAttr(Value: TFont);
begin
  FKeywordAttr.Assign(Value);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetNumberAttr(const Value: TFont);
begin
  FNumberAttr.Assign(Value);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetStringAttr(Value: TFont);
begin
  FStringAttr.Assign(Value);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetTextAttr(Value: TFont);
begin
  FTextAttr.Assign(Value);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetActiveLine(Line: Integer);
begin
  FActiveLine := Line;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.DoChange;
begin
  FModified := True;
  if Assigned(FOnChangeText) then
    FOnChangeText(Self);
end;

procedure TfrxSyntaxMemo.LinesChange(Sender: TObject);
begin
  if FAllowLinesChange then
  begin
    FAllowLinesChange := False;
    if FText.Count = 0 then
      FText.Add('');
    ClearSyntax(1);
    FMoved := True;
    FUndo.Clear;
    FPos := Point(1, 1);
    FOffset := Point(0, 0);
    ClearSel;
    ShowCaretPos;
    UpdateScrollBar;
  end;
end;

procedure TfrxSyntaxMemo.ShowMessage(const s: String);
begin
  FMessage := s;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.CopyToClipboard;
begin
  if FSelStart.X <> 0 then
    Clipboard.AsText := SelText;
end;

procedure TfrxSyntaxMemo.CutToClipboard;
begin
  if FSelStart.X <> 0 then
  begin
    Clipboard.AsText := SelText;
    SelText := '';
  end;
  CorrectBookmark(FSelStart.Y, FSelStart.Y - FSelEnd.Y);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.PasteFromClipboard;
begin
  SelText := Clipboard.AsText;
end;

procedure TfrxSyntaxMemo.SelectAll;
begin
  SetPos(0, 0);
  FSelStart := FPos;
  SetPos(LineLength(FText.Count - 1) + 1, FText.Count);
  FSelEnd := FPos;
{$IFDEF FPC}
      frxUpdateControl(Self, True);
{$ELSE}
      Repaint;
{$ENDIF}
end;

function TfrxSyntaxMemo.LineAt(Index: Integer): String;
begin
  if Index < FText.Count then
    Result := TrimRight(FText[Index])
  else
    Result := '';
end;

function TfrxSyntaxMemo.LineLength(Index: Integer): Integer;
begin
  Result := Length(LineAt(Index));
end;

function TfrxSyntaxMemo.Pad(n: Integer): String;
begin
  Result := '';
  SetLength(Result, n);
{$IFDEF Delphi12}
  Result := StringOfChar(Char(' '), n);
{$ELSE}
  FillChar(Result[1], n, ' ');
{$ENDIF}
end;

procedure TfrxSyntaxMemo.AddUndo;
begin
  if not FMoved then exit;
  FUndo.Add(Format('%5d%5d', [FPos.X, FPos.Y]) + FText.Text);
  if FUndo.Count > 32 then
    FUndo.Delete(0);
  FMoved := False;
end;

procedure TfrxSyntaxMemo.Undo;
var
  s: String;
begin
  FMoved := True;
  if FUndo.Count = 0 then exit;
  s := FUndo[FUndo.Count - 1];
  FPos.X := StrToInt(Copy(s, 1, 5));
  FPos.Y := StrToInt(Copy(s, 6, 5));
  FAllowLinesChange := False;
  FText.Text := Copy(s, 11, Length(s) - 10);
  FAllowLinesChange := True;
  FUndo.Delete(FUndo.Count - 1);
  SetPos(FPos.X, FPos.Y);
  ClearSyntax(1);
  DoChange;
end;

function TfrxSyntaxMemo.GetPlainTextPos(Pos: TPoint): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Pos.Y - 2 do
    Result := Result + Length(FText[i]) + {$IFDEF FPC}Length(LineBreak){$ELSE}2{$ENDIF};
  Result := Result + Pos.X;
end;

function TfrxSyntaxMemo.GetPosPlainText(Pos: Integer): TPoint;
var
  i: Integer;
  s: String;
begin
  Result := Point(0, 1);
  s := FText.Text;
  i := 1;
  while i <= Pos do
    if s[i] = LineBreak[1] then
    begin
      Inc(i, length(LineBreak));
      if i <= Pos then
      begin
        Inc(Result.Y);
        Result.X := 0;
      end
      else
        Inc(Result.X);
    end
    else
    begin
      Inc(i);
      Inc(Result.X);
    end;
end;

function TfrxSyntaxMemo.GetLineBegin(Index: Integer): Integer;
var
  s: String;
begin
  s := FText[Index];
  Result := 1;
  if Trim(s) <> '' then
    for Result := 1 to Length(s) do
      if s[Result] <> ' ' then
        break;
end;

procedure TfrxSyntaxMemo.TabIndent;
begin
  SelText := Pad((FPos.X div 8 + 1) * 8 - FPos.X);
end;

procedure TfrxSyntaxMemo.EnterIndent;
var
  res: Integer;
begin
  if Trim(FText[FPos.Y - 1]) = '' then
    res := FPos.X else
    res := GetLineBegin(FPos.Y - 1);

  if FPos.X = 1 then
    CorrectBookmark(FPos.Y - 1, 1) else
    CorrectBookmark(FPos.Y, 1);

  FPos := Point(1, FPos.Y + 1);
  SelText := Pad(res - 1);
end;

procedure TfrxSyntaxMemo.UnIndent;
var
  i, res: Integer;
begin
  i := FPos.Y - 2;
  res := FPos.X - 1;
  CorrectBookmark(FPos.Y, -1);
  while i >= 0 do
  begin
    res := GetLineBegin(i);
    if (res < FPos.X) and (Trim(FText[i]) <> '') then
      break else
      Dec(i);
  end;
  FSelStart := FPos;
  FSelEnd := FPos;
  Dec(FSelEnd.X, FPos.X - res);
  SelText := '';
end;

procedure TfrxSyntaxMemo.ShiftSelected(ShiftRight: Boolean);
var
  i, ib, ie: Integer;
  s: String;
  Shift: Integer;
begin
  AddUndo;
  if FSelStart.X + FSelStart.Y * FMaxLength < FSelEnd.X + FSelEnd.Y * FMaxLength then
  begin
    ib := FSelStart.Y - 1;
    ie := FSelEnd.Y - 1;
  end
  else
  begin
    ib := FSelEnd.Y - 1;
    ie := FSelStart.Y - 1;
  end;
  if FSelEnd.X = 1 then
    Dec(ie);

  Shift := 2;
  if not ShiftRight then
    for i := ib to ie do
    begin
      s := FText[i];
      if (Trim(s) <> '') and (GetLineBegin(i) - 1 < Shift) then
        Shift := GetLineBegin(i) - 1;
    end;

  for i := ib to ie do
  begin
    s := FText[i];
    if ShiftRight then
      s := Pad(Shift) + s
    else if Trim(s) <> '' then
      Delete(s, 1, Shift);
    FText[i] := s;
  end;

  ClearSyntax(FSelStart.Y);
  DoChange;
end;

function TfrxSyntaxMemo.GetSelText: String;
var
  p1, p2: TPoint;
  i: Integer;
begin
  if FSelStart.X = 0 then
  begin
    Result := '';
    Exit;
  end;

  if FSelStart.X + FSelStart.Y * FMaxLength < FSelEnd.X + FSelEnd.Y * FMaxLength then
  begin
    p1 := FSelStart;
    p2 := FSelEnd;
    Dec(p2.X);
  end
  else
  begin
    p1 := FSelEnd;
    p2 := FSelStart;
    Dec(p2.X);
  end;

  if LineLength(p1.Y - 1) < p1.X then
  begin
    Inc(p1.Y);
    p1.X := 1;
  end;
  if LineLength(p2.Y - 1) < p2.X then
    p2.X := LineLength(p2.Y - 1);

  i := GetPlainTextPos(p1);
  Result := Copy(FText.Text, i, GetPlainTextPos(p2) - i + 1);
end;

procedure TfrxSyntaxMemo.SetSelText(const Value: String);
var
  p1, p2, p3: TPoint;
  i: Integer;
  s: String;
begin
  AddUndo;
  if FSelStart.X = 0 then
  begin
    p1 := FPos;
    p2 := p1;
    Dec(p2.X);
  end
  else if FSelStart.X + FSelStart.Y * FMaxLength < FSelEnd.X + FSelEnd.Y * FMaxLength then
  begin
    p1 := FSelStart;
    p2 := FSelEnd;
    Dec(p2.X);
  end
  else
  begin
    p1 := FSelEnd;
    p2 := FSelStart;
    Dec(p2.X);
  end;
  FAllowLinesChange := False;
  if LineLength(p1.Y - 1) < p1.X then
    FText[p1.Y - 1] := FText[p1.Y - 1] + Pad(p1.X - LineLength(p1.Y - 1) + 1);
  if LineLength(p2.Y - 1) < p2.X then
    p2.X := LineLength(p2.Y - 1);

  i := GetPlainTextPos(p1);
  s := FText.Text;
  Delete(s, i, GetPlainTextPos(p2) - i + 1);
  Insert(Value, s, i);
  FText.Text := s;
  p3 := GetPosPlainText(i + Length(Value));
  FAllowLinesChange := True;
  CorrectBookmark(FPos.Y, p3.y - FPos.Y);

  SetPos(p3.X, p3.Y);
  FSelStart.X := 0;
  DoChange;
  i := p3.Y;
  if p2.Y < i then
    i := p2.Y;
  if p1.Y < i then
    i := p1.Y;
  ClearSyntax(i);
end;

procedure TfrxSyntaxMemo.ClearSel;
begin
  if FSelStart.X <> 0 then
  begin
    FSelStart := Point(0, 0);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end;
end;

procedure TfrxSyntaxMemo.AddSel;
begin
  if FSelStart.X = 0 then
    FSelStart := FTempPos;
  FSelEnd := FPos;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetPos(x, y: Integer);
begin
  if FMessage <> '' then
  begin
    FMessage := '';
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end;

  if x > FMaxLength then x := FMaxLength;
  if x < 1 then x := 1;
  if y > FText.Count then y := FText.Count;
  if y < 1 then y := 1;

  FPos := Point(x, y);
  if (FWindowSize.X = 0) or (FWindowSize.Y = 0) then exit;

  if FOffset.Y >= FText.Count then
    FOffset.Y := FText.Count - 1;

  if FPos.X > FOffset.X + FWindowSize.X then
  begin
    Inc(FOffset.X, FPos.X - (FOffset.X + FWindowSize.X));
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end
  else if FPos.X <= FOffset.X then
  begin
    Dec(FOffset.X, FOffset.X - FPos.X + 1);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end
  else if FPos.Y > FOffset.Y + FWindowSize.Y then
  begin
    Inc(FOffset.Y, FPos.Y - (FOffset.Y + FWindowSize.Y));
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end
  else if FPos.Y <= FOffset.Y then
  begin
    Dec(FOffset.Y, FOffset.Y - FPos.Y + 1);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end;

  ShowCaretPos;
  UpdateScrollBar;

end;

procedure TfrxSyntaxMemo.OnHScrollChange(Sender: TObject);
begin
  FOffset.X := HorzPosition;
  if FOffset.X > 1024 then
    FOffset.X := 1024;
  ShowCaretPos;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.OnVScrollChange(Sender: TObject);
begin
  FOffset.Y := VertPosition;
  if FOffset.Y > FText.Count then
    FOffset.Y := FText.Count;
  ShowCaretPos;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.DblClick;
var
  s: String;
begin
  FDoubleClicked := True;
  DoCtrlL;
  FSelStart := FPos;
  s := LineAt(FPos.Y - 1);
  if s <> '' then
{$IFDEF Delphi12}
    while CharInSet(s[FPos.X], WordChars)
      or IsUnicodeChar(s[FPos.X]) do
{$ELSE}
    while s[FPos.X] in WordChars do
{$ENDIF}
      Inc(FPos.X);
  FSelEnd := FPos;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if FDoubleClicked then
  begin
    FDoubleClicked := False;
    Exit;
  end;

  FMoved := True;
  if not Focused then
    SetFocus;
  FDown := True;
  if X < FGutterWidth then
    FToggleBreakPointDown := True;
  X := (X - FGutterWidth) div FCharWidth + 1 + FOffset.X;
  Y := Y div FCharHeight + 1 + FOffset.Y;
  FTempPos := FPos;
  SetPos(X, Y);
  if ssShift in Shift then
    AddSel
  else
    ClearSel;
end;

procedure TfrxSyntaxMemo.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FDown then
  begin
    FTempPos := FPos;
    FPos.X := (X - FGutterWidth) div FCharWidth + 1 + FOffset.X;
    FPos.Y := Y div FCharHeight + 1 + FOffset.Y;
    if (FPos.X <> FTempPos.X) or (FPos.Y <> FTempPos.Y) then
    begin
      SetPos(FPos.X, FPos.Y);
      AddSel;
    end;
  end;

  if X < FGutterWidth then
    Cursor := crArrow
  else
    Cursor := crIBeam;
end;

procedure TfrxSyntaxMemo.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  FDown := False;
  if (X < FGutterWidth) and (FToggleBreakPointDown) then
    ToggleBreakPoint(FPos.Y, '');
  FToggleBreakPointDown := False;
end;

procedure TfrxSyntaxMemo.KeyDown(var Key: Word; Shift: TShiftState);
var
  MyKey: Boolean;
  TempPos: Tpoint;
begin
  inherited;
  FAllowLinesChange := False;

  FTempPos := FPos;
  MyKey := True;
  case Key of
    vk_Left:
      if ssCtrl in Shift then
        DoCtrlL else
        DoLeft;

    vk_Right:
      if ssCtrl in Shift then
        DoCtrlR else
        DoRight;

    vk_Up:
      DoUp;

    vk_Down:
      DoDown;

    vk_Home:
      DoHome(ssCtrl in Shift);

    vk_End:
      DoEnd(ssCtrl in Shift);

    vk_Prior:
      DoPgUp;

    vk_Next:
      DoPgDn;

    vk_Return:
      if Shift = [] then
        DoReturn;

    vk_Delete:
    begin
      if ssCtrl in Shift then // Ctrl+Del delete word before cursor
      begin
        TempPos := FPos;
        Inc(FPos.X);
        DblClick;
        FDoubleClicked := False;
        if FSelEnd.X <= TempPos.X then
        begin
          FSelStart := TempPos;
          FSelEnd := TempPos;
          dec(FSelStart.X);
        end;
      end;
      if ssShift in Shift then
        CutToClipboard else
        DoDel;
    end;

    vk_Back:
    begin
      if ssCtrl in Shift then // Ctrl+BackSpace delete word after cursor
      begin
        DblClick;
        FDoubleClicked := False;
      end;
      DoBackspace;
    end;

    vk_Insert:
      if ssCtrl in Shift then
        CopyToClipboard
      else if ssShift in Shift then
        PasteFromClipboard;

    vk_Tab:
      TabIndent;

  else
    MyKey := False;
  end;

  if Shift = [ssCtrl] then
    if Key = 65 then // Ctrl+A Select all
    begin
      SelectAll;
    end
    else if Key = 89 then // Ctrl+Y Delete line
    begin
      if FText.Count > FPos.Y then
      begin
        FMoved := True;
        AddUndo;
        FText.Delete(FPos.Y - 1);
        CorrectBookmark(FPos.Y, -1);
        DoChange;
      end
      else if FText.Count = FPos.Y then
      begin
        FMoved := True;
        AddUndo;
        FText[FPos.Y - 1] := '';
        FPos.X := 1;
        SetPos(FPos.X, FPos.Y);
        DoChange;
      end;
      ClearSyntax(FPos.Y);
    end
    else if Key in [48..57] then
      GotoBookmark(Key - 48)
    else if Key = 32 then // Ctrl+Space code completion
    begin
      if Assigned(FOnCodeCompletion) then
        DoCodeCompletion;
      MyKey := True;
    end
    else if Key = Ord('C') then
    begin
      CopyToClipboard;
      MyKey := True;
    end
    else if Key = Ord('V') then
    begin
      PasteFromClipboard;
      MyKey := True;
    end
    else if Key = Ord('X') then
    begin
      CutToClipboard;
      MyKey := True;
    end
    else if Key = Ord('I') then
    begin
      DoCtrlI;
      MyKey := True;
    end
    else if Key = Ord('U') then
    begin
      DoCtrlU;
      MyKey := True;
    end
    else if Key = Ord('Z') then
    begin
      Undo;
      MyKey := True;
    end;

  if Shift = [ssCtrl, ssShift] then
    if Key in [48..57] then
      if IsBookmark(FPos.Y - 1) < 0 then
        AddBookmark(FPos.Y - 1, Key - 48)
      else if IsBookmark(FPos.Y - 1) = (Key - 48) then
        DeleteBookmark(Key - 48);

  if Key in [vk_Left, vk_Right, vk_Up, vk_Down, vk_Home, vk_End, vk_Prior, vk_Next] then
  begin
    FMoved := True;
    if ssShift in Shift then
      AddSel else
      ClearSel;
  end
  else if Key in [vk_Return, vk_Delete, vk_Back, vk_Insert, vk_Tab] then
    FMoved := True;

  if MyKey then
    Key := 0;
end;

procedure TfrxSyntaxMemo.KeyPress(var Key: Char);
var
  MyKey, ControlKeyDown: Boolean;
begin
  inherited;

  ControlKeyDown := (((GetKeyState(VK_LCONTROL) and not $7FFF) <> 0) or
    ((GetKeyState(VK_RCONTROL) and not $7FFF) <> 0)) and
    (GetKeyState(VK_RMENU) >= 0);  
  MyKey := True;

{$IFDEF Delphi12}
  if ((Key = #32) and not ControlKeyDown) or (CharInSet(Key, [#33..#255]))
    or IsUnicodeChar(Key) and not((Key = #127) and ControlKeyDown) then
{$ELSE}
  if ((Key = #32) and not ControlKeyDown) or (Key in [#33..#255]) and not((Key = #127) and ControlKeyDown) then
{$ENDIF}
  begin
    DoChar(Key);
    FMoved := False;
  end
  else
    MyKey := False;

  if MyKey then
    Key := #0;
end;

{$IFDEF FPC}
procedure TfrxSyntaxMemo.UTF8KeyPress(var UTF8Key: TUTF8Char);
begin
  {$note TODO: fix handling of UTF8 keys}
  inherited UTF8KeyPress(UTF8Key);
  SelText := String(UTF8Key);
  UTF8Key := '';
end;
{$ENDIF}

procedure TfrxSyntaxMemo.DoCodeCompletion;
var
  p: TPoint;

  function GetCompletionString: String;
  var
    i: Integer;
    s: String;
    fl1, fl2: Boolean;
    fl3, fl4: Integer;
  begin
    Result := '';
    s := LineAt(FPos.Y - 1);
    s := Trim(Copy(s, 1, FPos.X));

    fl1 := False;
    fl2 := False;
    fl3 := 0;
    fl4 := 0;

    i := Length(s);
    while i > 1 do
    begin
      Dec(i);
      if (s[i] = '''') and not fl2 then
        fl1 := not fl1
      else if (s[i] = '"') and not fl1 then
        fl2 := not fl2
      else if not fl1 and not fl2 and (s[i] = ')') then
        Inc(fl3)
      else if not fl1 and not fl2 and (s[i] = '(') and (fl3 > 0) then
        Dec(fl3)
      else if not fl1 and not fl2 and (s[i] = ']') then
        Inc(fl4)
      else if not fl1 and not fl2 and (s[i] = '[') and (fl4 > 0) then
        Dec(fl4)
      else if not fl1 and not fl2 and (fl3 = 0) and (fl4 = 0) then
{$IFDEF Delphi12}
        if CharInSet(s[i], ['A'..'Z', 'a'..'z', '0'..'9', '_', '.', ' '])
        or IsUnicodeChar(s[i]) then
{$ELSE}
        if s[i] in ['A'..'Z', 'a'..'z', '0'..'9', '_', '.', ' '] then
{$ENDIF}
          Result := s[i] + Result
        else
          break;
    end;
  end;

begin
  FCompletionForm := TfrxPopupForm.Create(Self);
  FCompletionLB := TListBox.Create(FCompletionForm);
  with FCompletionLB do
  begin
    Parent := FCompletionForm;
    {$IFNDEF FPC}
    Ctl3D := False;
    {$ENDIF}
    Align := alClient;
    ItemHeight := ItemHeight + 2;
    Style := lbOwnerDrawFixed;
    Sorted := True;
    OnDblClick := CompletionLBDblClick;
    OnKeyDown := CompletionLBKeyDown;
    OnDrawItem := CompletionLBDrawItem;
    if Assigned(FOnCodeCompletion) then
      FOnCodeCompletion(GetCompletionString, Items);

    p := Self.ClientToScreen(
      Point(FCharWidth * (FPos.X - 1 - FOffset.X) + FGutterWidth,
            FCharHeight * (FPos.Y - FOffset.Y)));
    FCompletionForm.SetBounds(p.X, p.Y, 300, 100);
    FCompletionForm.Show;
  end;
end;

procedure TfrxSyntaxMemo.CompletionLBDblClick(Sender: TObject);
var
  s, s1: String;
  i: Integer;
  stepBack: Boolean;
begin
  if FCompletionLB.ItemIndex <> -1 then
  begin
    s := FCompletionLB.Items[FCompletionLB.ItemIndex];
    i := 2;
{$IFDEF Delphi12}
    while (i <= Length(s)) and ((CharInSet(s[i], WordChars) or IsUnicodeChar(s[i]))) do
{$ELSE}
    while (i <= Length(s)) and (s[i] in WordChars) do
{$ENDIF}
      Inc(i);
    s1 := Copy(s, 1, i - 1);
    stepBack := (i <= Length(s)) and (s[i] = '(');
    if stepBack then
      s1 := s1 + '()';
    SelText := s1;
    if stepBack then
      DoLeft;
  end;
  FCompletionForm.Close;
end;

procedure TfrxSyntaxMemo.CompletionLBKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    FCompletionForm.Close;
  if Key = VK_RETURN then
    CompletionLBDblClick(nil);
end;

procedure TfrxSyntaxMemo.CompletionLBDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
var
  i, w: Integer;
  s: String;
begin
  with FCompletionLB.Canvas do
  begin
    FillRect(ARect);
    if Index <> -1 then
    begin
      i := Integer(FCompletionLB.Items.Objects[Index]);
      s := '';
      Font.Color := clFuchsia;
      if Pos('Constructor', FCompletionLB.Items[Index]) <> 0 then
        s := 'constructor'
      else
        case i of
          0: begin s := 'var'; Font.Color := clBlue; end;
          1: begin s := 'property'; Font.Color := clBlue; end;
          2: s := 'procedure';
          3: s := 'function';
        end;

      if odSelected in State then
        Font.Color := clWhite;
      Font.Style := [];
      TextOut(ARect.Left + 2, ARect.Top + 2, s);
      w := TextWidth('constructor');
      Font.Color := clBlack;
      if odSelected in State then
        Font.Color := clWhite;
      Font.Style := [fsBold];
      s := FCompletionLB.Items[Index];
      i := 1;
{$IFDEF Delphi12}
      while (i <= Length(s)) and ((CharInSet(s[i], WordChars))
       or IsUnicodeChar(s[i])) do
{$ELSE}
      while (i <= Length(s)) and (s[i] in WordChars) do
{$ENDIF}
        Inc(i);
      s := Copy(s, 1, i - 1);
      TextOut(ARect.Left + w + 6, ARect.Top + 2, s);
      w := w + TextWidth(s);
      Font.Style := [];
      s := Copy(FCompletionLB.Items[Index], i, 255);
      if Pos(': Constructor', s) <> 0 then
        s := Copy(s, 1, Pos(': Constructor', s) - 1);
      TextOut(ARect.Left + w + 6, ARect.Top + 2, s);
    end;
  end;
end;

procedure TfrxSyntaxMemo.DoLeft;
begin
  Dec(FPos.X);
  if FPos.X < 1 then
    FPos.X := 1;
  SetPos(FPos.X, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoRight;
begin
  Inc(FPos.X);
  if FPos.X > FMaxLength then
    FPos.X := FMaxLength;
  SetPos(FPos.X, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoUp;
begin
  Dec(FPos.Y);
  if FPos.Y < 1 then
    FPos.Y := 1;
  SetPos(FPos.X, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoDown;
begin
  Inc(FPos.Y);
  if FPos.Y > FText.Count then
    FPos.Y := FText.Count;
  SetPos(FPos.X, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoHome(Ctrl: Boolean);
begin
  if Ctrl then
    SetPos(1, 1) else
    SetPos(1, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoEnd(Ctrl: Boolean);
begin
  if Ctrl then
    SetPos(LineLength(FText.Count - 1) + 1, FText.Count) else
    SetPos(LineLength(FPos.Y - 1) + 1, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoPgUp;
begin
  if FOffset.Y > FWindowSize.Y then
  begin
    Dec(FOffset.Y, FWindowSize.Y - 1);
    Dec(FPos.Y, FWindowSize.Y - 1);
  end
  else
  begin
    if FOffset.Y > 0 then
    begin
      Dec(FPos.Y, FOffset.Y);
      FOffset.Y := 0;
    end
    else
      FPos.Y := 1;
  end;
  SetPos(FPos.X, FPos.Y);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.DoPgDn;
begin
  if FOffset.Y + FWindowSize.Y < FText.Count then
  begin
    Inc(FOffset.Y, FWindowSize.Y - 1);
    Inc(FPos.Y, FWindowSize.Y - 1);
  end
  else
  begin
    FOffset.Y := FText.Count;
    FPos.Y := FText.Count;
  end;
  SetPos(FPos.X, FPos.Y);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.DoReturn;
var
  s: String;
begin
  s := LineAt(FPos.Y - 1);
  FText[FPos.Y - 1] := Copy(s, 1, FPos.X - 1);
  FText.Insert(FPos.Y, Copy(s, FPos.X, FMaxLength));
  EnterIndent;
end;

procedure TfrxSyntaxMemo.DoDel;
var
  s: String;
begin
  FMessage := '';
  if FSelStart.X <> 0 then
    SelText := ''
  else
  begin
    s := FText[FPos.Y - 1];
    AddUndo;
    if FPos.X <= LineLength(FPos.Y - 1) then
    begin
      Delete(s, FPos.X, 1);
      FText[FPos.Y - 1] := s;
    end
    else if FPos.Y < FText.Count then
    begin
      s := s + Pad(FPos.X - Length(s) - 1) + LineAt(FPos.Y);
      FText[FPos.Y - 1] := s;
      FText.Delete(FPos.Y);
      CorrectBookmark(FPos.Y, -1);
    end;
    UpdateScrollBar;
    ClearSyntax(FPos.Y);
    DoChange;
  end;
end;

procedure TfrxSyntaxMemo.DoBackspace;
var
  s: String;
begin
  FMessage := '';
  if FSelStart.X <> 0 then
    SelText := ''
  else
  begin
    s := FText[FPos.Y - 1];
    if FPos.X > 1 then
    begin
      if (GetLineBegin(FPos.Y - 1) = FPos.X) or (Trim(s) = '') then
        UnIndent
      else
      begin
        AddUndo;
        if Trim(s) <> '' then
        begin
          Delete(s, FPos.X - 1, 1);
          FText[FPos.Y - 1] := s;
          DoLeft;
        end
        else
          DoHome(False);
        ClearSyntax(FPos.Y);
        DoChange;
      end;
    end
    else if FPos.Y > 1 then
    begin
      AddUndo;
      CorrectBookmark(FPos.Y, -1);
      s := LineAt(FPos.Y - 2);
      FText[FPos.Y - 2] := s + FText[FPos.Y - 1];
      FText.Delete(FPos.Y - 1);
      SetPos(Length(s) + 1, FPos.Y - 1);
      ClearSyntax(FPos.Y);
      DoChange;
    end;
  end;
end;

procedure TfrxSyntaxMemo.DoCtrlI;
begin
  if FSelStart.X <> 0 then
    ShiftSelected(True);
end;

procedure TfrxSyntaxMemo.DoCtrlU;
begin
  if FSelStart.X <> 0 then
    ShiftSelected(False);
end;

procedure TfrxSyntaxMemo.DoCtrlL;
var
  i: Integer;
  s: String;
begin
  s := FText.Text;
  i := Length(LineAt(FPos.Y - 1));
  if FPos.X > i then
    FPos.X := i;

  i := GetPlainTextPos(FPos);

  Dec(i);
{$IFDEF Delphi12}
  while (i > 0) and not ((CharInSet(s[i], WordChars))
    or IsUnicodeChar(s[i])) do
{$ELSE}
  while (i > 0) and not (s[i] in WordChars) do
{$ENDIF}
    if s[i] = LineBreak[1] then
      break else
      Dec(i);
{$IFDEF Delphi12}
  while (i > 0) and ((CharInSet(s[i], WordChars))
    or IsUnicodeChar(s[i])) do
{$ELSE}
  while (i > 0) and (s[i] in WordChars) do
{$ENDIF}
    Dec(i);
  Inc(i);

  FPos := GetPosPlainText(i);
  SetPos(FPos.X, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoCtrlR;
var
  i: Integer;
  s: String;
begin
  s := FText.Text;
  i := Length(LineAt(FPos.Y - 1));
  if FPos.X > i then
  begin
    DoDown;
    DoHome(False);
    FPos.X := 0;
  end;

  i := GetPlainTextPos(FPos);

{$IFDEF Delphi12}
  while (i < Length(s)) and ((CharInSet(s[i], WordChars))
     or IsUnicodeChar(s[i])) do
{$ELSE}
  while (i < Length(s)) and (s[i] in WordChars) do
{$ENDIF}
    Inc(i);
{$IFDEF Delphi12}
  while (i < Length(s)) and not ((CharInSet(s[i], WordChars))
    or IsUnicodeChar(s[i])) do
{$ELSE}
  while (i < Length(s)) and not (s[i] in WordChars) do
{$ENDIF}
    if s[i] = #13 then
    begin
      while (i > 1) and (s[i - 1] = ' ') do
        Dec(i);
      break;
    end
    else
      Inc(i);

  FPos := GetPosPlainText(i);
  SetPos(FPos.X, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoChar(Ch: Char);
begin
  SelText := Ch;
end;

function TfrxSyntaxMemo.GetCharAttr(Pos: TPoint): TCharAttributes;

  function IsBlock: Boolean;
  var
    p1, p2, p3: Integer;
  begin
    Result := False;
    if FSelStart.X = 0 then Exit;

    p1 := FSelStart.X + FSelStart.Y * FMaxLength;
    p2 := FSelEnd.X + FSelEnd.Y * FMaxLength;
    if p1 > p2 then
    begin
      p3 := p1;
      p1 := p2;
      p2 := p3;
    end;
    p3 := Pos.X + Pos.Y * FMaxLength;
    Result := (p3 >= p1) and (p3 < p2);
  end;

  function CharAttr: TCharAttr;
  var
    s: String;
  begin
    if Pos.Y - 1 < FSynStrings.Count then
    begin
      s := FSynStrings[Pos.Y - 1];
      if Pos.X <= Length(s) then
        Result := TCharAttr(Ord(s[Pos.X])) else
        Result := caText;
    end
    else
      Result := caText;
  end;

begin
  Result := [CharAttr];
  if IsBlock then
    Result := Result + [caBlock];
end;

{$IFNDEF FPC}
{$IFDEF JPN}
function TfrxSyntaxMemo.GetCharWidth(Str: String): Integer;
begin
  with FTmpCanvas.Canvas do
  begin
    Font.Assign(Self.Font);
    Result := TextWidth(Str);
  end;
end;
{$ENDIF}
{$ENDIF}
procedure TfrxSyntaxMemo.Paint;
var
  i, j, j1: Integer;
  a, a1: TCharAttributes;
  s: String;

  procedure SetAttr(a: TCharAttributes; ALine: Integer);
  begin
    with Canvas do
    begin
      Brush.Color := Color;

      if caText in a then
        Font.Assign(FTextAttr);

      if caComment in a then
        Font.Assign(FCommentAttr);

      if caKeyword in a then
        Font.Assign(FKeywordAttr);

      if caNumber in a then
        Font.Assign(FNumberAttr);

      if caString in a then
        Font.Assign(FStringAttr);

      if (caBlock in a) or (ALine = FActiveLine - 1) then
      begin
        Brush.Color := FBlockColor;
        Font.Color := FBlockFontColor;
      end;

      Font.Charset := Self.Font.Charset;
    end;
  end;

  procedure MyTextOut(x, y: Integer; const s: String);
  var
    i: Integer;
  begin
    if FIsMonoType then
    begin
      Canvas.FillRect(Rect(x, y, x + Length(s) * FCharWidth, y + FCharHeight));
      Canvas.TextOut(x, y, s)
    end
    else
    with Canvas do
    begin
      FillRect(Rect(x, y, x + Length(s) * FCharWidth, y + FCharHeight));
      for i := 1 to Length(s) do
        TextOut(x + (i - 1) * FCharWidth, y, s[i]);
      MoveTo(x + Length(s) * FCharWidth, y);
    end;
  end;

  procedure DrawLineMarks(ALine, Y: Integer);
  begin
    if not FShowGutter then Exit;
    if IsBookmark(ALine) >= 0 then
      with Canvas do
      begin
        Brush.Color := clBlack;
        FillRect(Rect(13, Y + 3, 23, Y + 14));
        Brush.Color := clGreen;
        FillRect(Rect(12, Y + 4, 22, Y + 15));
        Font.Name := 'Tahoma';
        Font.Color := clWhite;
        Font.Style := [fsBold];
        Font.Size := 7;
        TextOut(14, Y + 4, IntToStr(IsBookmark(ALine)));
      end;
    if RunLine[ALine + 1] then
      with Canvas do
      begin
        Brush.Color := clBlue;
        Pen.Color := clBlack;
        Ellipse(4, Y + 7, 8, Y + 11);
        Pixels[5, Y + 7] := clAqua;
        Pixels[4, Y + 8] := clAqua;
      end;
    if IsBreakPoint(ALine + 1) then
      with Canvas do
      begin
        Brush.Color := clRed;
        Pen.Color := clRed;
        Ellipse(2, Y + 4, 13, Y + 15);
      end;
  end;

begin
  inherited;

  with Canvas do
  begin
    Brush.Color := clBtnFace;
    FillRect(Rect(0, 0, FGutterWidth - 2, Height));
    Pen.Color := clBtnHighlight;
    MoveTo(FGutterWidth - 4, 0);
    LineTo(FGutterWidth - 4, Height + 1);

    if FUpdatingSyntax then Exit;
    CreateSynArray(FOffset.Y + FWindowSize.Y - 1);

    for i := FOffset.Y to FOffset.Y + FWindowSize.Y - 1 do
    begin
      if i >= FText.Count then break;

      s := FText[i];
      PenPos := Point(FGutterWidth, (i - FOffset.Y) * FCharHeight);
      j1 := FOffset.X + 1;
      a := GetCharAttr(Point(j1, i + 1));
      a1 := a;

      for j := j1 to FOffset.X + FWindowSize.X do
      begin
        if j > Length(s) then break;

        a1 := GetCharAttr(Point(j, i + 1));
        if a1 <> a then
        begin
          SetAttr(a, i);
          MyTextOut(PenPos.X, PenPos.Y, Copy(FText[i], j1, j - j1));
          a := a1;
          j1 := j;
        end;
      end;

      SetAttr(a, i);
      MyTextOut(PenPos.X, PenPos.Y, Copy(s, j1, FMaxLength));
      if (caBlock in GetCharAttr(Point(1, i + 1))) or (i = FActiveLine - 1) then
        MyTextOut(PenPos.X, PenPos.Y, Pad(FWindowSize.X - Length(s) - FOffset.X + 3));

      DrawLineMarks(i, PenPos.Y);
    end;

    if FMessage <> '' then
    begin
      Font.Name := 'Tahoma';
      Font.Color := clWhite;
      Font.Style := [fsBold];
      Font.Size := 8;
      Brush.Color := clMaroon;
      FillRect(Rect(0, ClientHeight - TextHeight('|') - 6, ClientWidth, ClientHeight));
      TextOut(6, ClientHeight - TextHeight('|') - 5, FMessage);
    end;
    {$IFDEF NONWINFPC}
    if Visible and HandleAllocated and FCaretCreated then
    begin
      SetCaretPos(FCharWidth * (FPos.X - 1 - FOffset.X) + FGutterWidth,
      FCharHeight * (FPos.Y - 1 - FOffset.Y));
      // ShowCaret(Handle);
    end;
    {$ENDIF}
  end;
end;

procedure TfrxSyntaxMemo.ClearSyntax(ClearFrom: Integer);
begin
  Dec(ClearFrom);
  if ClearFrom < 1 then
    ClearFrom := 1;
  FUpdatingSyntax := True;
  while FSynStrings.Count > ClearFrom - 1 do
    FSynStrings.Delete(FSynStrings.Count - 1);
  FUpdatingSyntax := False;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.CreateSynArray(EndLine: Integer);
var
  i, j, n, Max: Integer;
  FSyn, s: String;
  attr: TCharAttr;
begin
  if EndLine >= FText.Count then
    EndLine := FText.Count - 1;
  if EndLine <= FSynStrings.Count - 1 then Exit;

  FUpdatingSyntax := True;
  FAllowLinesChange := False;

  for i := FSynStrings.Count to EndLine do
    FSynStrings.Add(FText[i]);
  FSyn := FSynStrings.Text;
  FParser.Text := FText.Text;
  Max := Length(FSyn);

  for i := Length(FSyn) downto 1 do
    if FSyn[i] = Chr(Ord(caText)) then
    begin
      j := i;
      while (j > 1) and (FSyn[j] = Chr(Ord(caText))) do
        Dec(j);
      FParser.Position := j + 1;
      break;
    end;

  while FParser.Position < Max do
  begin
    n := FParser.Position;
    FParser.SkipSpaces;
    for i := n to FParser.Position - 1 do
      if i <= Max then
        if FSyn[i] > #31 then
          FSyn[i] := Chr(Ord(caComment));

    attr := caText;
    n := FParser.Position;
    s := FParser.GetWord;
    if s <> '' then
    begin
      if FParser.IsKeyword(s) then
        attr := caKeyword;
    end
    else
    begin
      s := FParser.GetNumber;
      if s <> '' then
        attr := caNumber
      else
      begin
        s := FParser.GetString;
        if s <> '' then
          attr := caString else
          FParser.Position := FParser.Position + 1
      end
    end;

    for i := n to FParser.Position - 1 do
      if i <= Max then
        if FSyn[i] > #31 then
          FSyn[i] := Chr(Ord(attr));
  end;

  FSynStrings.Text := FSyn;
  FUpdatingSyntax := False;
  FAllowLinesChange := True;
end;

procedure TfrxSyntaxMemo.UpdateView;
begin
  Invalidate;
end;

procedure TfrxSyntaxMemo.MouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  VertPosition := VertPosition - SmallChange;
end;

procedure TfrxSyntaxMemo.MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  VertPosition := VertPosition + SmallChange;
end;

procedure TfrxSyntaxMemo.SetShowGutter(Value: Boolean);
begin
  FShowGutter := Value;
  if Value then
    FGutterWidth := 30 else
    FGutterWidth := 0;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

function TfrxSyntaxMemo.IsBookmark(Line: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to 9 do
    if FBookmarks[i] = Line then
    begin
      Result := i;
      break;
    end;
end;

procedure TfrxSyntaxMemo.AddBookmark(Line, Number: Integer);
begin
  if Number < Length(FBookmarks) then
  begin
    FBookmarks[Number] := Line;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end;
end;

procedure TfrxSyntaxMemo.DeleteBookmark(Number: Integer);
begin
  if Number < Length(FBookmarks) then
  begin
    FBookmarks[Number] := -1;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end;
end;

procedure TfrxSyntaxMemo.CorrectBookmark(Line, Delta: Integer);
var
  i: Integer;
begin
  if Delta = 0 then exit;
  CorrectBreakPoints(Line, Delta);
  for i := 0 to Length(FBookmarks) - 1 do
    if FBookmarks[i] >= Line then
      Inc(FBookmarks[i], Delta);
end;

procedure TfrxSyntaxMemo.GotoBookmark(Number : Integer);
begin
  if Number < Length(FBookmarks) then
    if FBookmarks[Number] >= 0 then
      SetPos(0, FBookmarks[Number] + 1);
end;

function TfrxSyntaxMemo.GetRunLine(Index: Integer): Boolean;
begin
  if (Index < 1) or (Index > FText.Count) then
    Result := False else
    Result := FText.Objects[Index - 1] = Pointer(1);
end;

procedure TfrxSyntaxMemo.SetRunLine(Index: Integer; const Value: Boolean);
begin
  if (Index < 1) or (Index > FText.Count) then Exit;
  if Value then
    FText.Objects[Index - 1] := Pointer(1) else
    FText.Objects[Index - 1] := Pointer(0);
end;

function TfrxSyntaxMemo.Find(const SearchText: String;
  CaseSensitive: Boolean; var SearchFrom: Integer): Boolean;
var
  i: Integer;
  s: String;
begin
  i := 0;
  Result := False;
  if FText.Count > 1 then
  begin
    s := FText.Text;
    if SearchFrom = 0 then
      SearchFrom := 1;
    s := Copy(s, SearchFrom, Length(s) - SearchFrom + 1);
    if CaseSensitive then
    begin
      i := Pos(SearchText, s);
      if i <> 0 then
        Result := True;
    end
    else
    begin
      i := Pos(AnsiUpperCase(SearchText), AnsiUpperCase(s));
      if i <> 0 then
        Result := True;
    end;
  end;

  if Result then
  begin
    Inc(SearchFrom, i);
    FSelStart := GetPosPlainText(SearchFrom - 1);
    FSelEnd := Point(FSelStart.X + Length(SearchText), FSelStart.Y);
    Inc(SearchFrom, Length(SearchText));
    SetPos(FSelStart.X, FSelStart.Y);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end;
end;

procedure TfrxSyntaxMemo.AddBreakPoint(Number: Integer; const Condition: String);
begin
  FBreakPoints.AddObject(Condition, TObject(Number));
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.ToggleBreakPoint(Number: Integer; const Condition: String);
begin
  if IsBreakPoint(Number) then
    DeleteBreakPoint(Number)
  else
    AddBreakPoint(Number, Condition);
end;

procedure TfrxSyntaxMemo.DeleteBreakPoint(Number: Integer);
begin
  if IsBreakPoint(Number) then
    FBreakPoints.Delete(FBreakPoints.IndexOfObject(TObject(Number)));
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

function TfrxSyntaxMemo.IsBreakPoint(Number: Integer): Boolean;
begin
  Result := FBreakPoints.IndexOfObject(TObject(Number)) <> -1;
end;

function TfrxSyntaxMemo.GetBreakPointCondition(Number: Integer): String;
begin
  Result := '';
  if IsBreakPoint(Number) then
    Result := FBreakPoints[FBreakPoints.IndexOfObject(TObject(Number))];
end;

procedure TfrxSyntaxMemo.DeleteF4BreakPoints;
var
  i: Integer;
begin
  i := 0;
  while i < FBreakPoints.Count do
    if FBreakPoints[i] = 'F4' then
      FBreakPoints.Delete(i)
    else
      Inc(i);
end;

procedure TfrxSyntaxMemo.CorrectBreakPoints(Line, Delta: Integer);
var
  i, bPos: Integer;
begin
// FBreakPoints[FBreakPoints.IndexOfObject(TObject(Number))]
  for i := 0 to FBreakPoints.Count - 1 do
  begin
    bPos := Integer(FBreakPoints.Objects[i]);
    if bPos >= Line then
    begin
      Inc(bPos, Delta);
      FBreakPoints.Objects[i] := TObject(bPos);
    end;
  end;
end;

function TfrxSyntaxMemo.GetTextSelected: Boolean;
begin
//
  Result := True;// FSelStart

end;

end.


