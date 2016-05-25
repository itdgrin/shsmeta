{******************************************}
{                                          }
{            FastReport v5.0               }
{             SVG 1.1 Export               }
{                                          }
{           Copyright (c) 2015             }
{            by Oleg Adibekov              }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxExportSVG;

interface

{$I frx.inc}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ShellAPI,
  Graphics,
  ComCtrls,
  frxClass,
  frxCrypto,    // for hashing pictures and CSS styles
  frxStorage,   // for TObjList and TCachedStream
  frxGradient,
  frxExportHelpers
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

type
  TfrxSVGExportDialog = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    GroupPageRange: TGroupBox;
    DescrL: TLabel;
    AllRB: TRadioButton;
    CurPageRB: TRadioButton;
    PageNumbersRB: TRadioButton;
    PageNumbersE: TEdit;
    gbOptions: TGroupBox;
    OpenCB: TCheckBox;
    sd: TSaveDialog;
    GroupQuality: TGroupBox;
    PicturesL: TLabel;
    StylesCB: TCheckBox;
    UnifiedPicturesCB: TCheckBox;
    PicturesCB: TCheckBox;
    MultipageCB: TCheckBox;
    PFormatCB: TComboBox;
    FormattedCB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure PageNumbersEChange(Sender: TObject);
    procedure PageNumbersEKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  end;

  { SVG export filter }
{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxSVGExport = class(TfrxCustomExportFilter)
  private
    FOpenAfterExport: Boolean;
    FMultiPage: Boolean;
    FFormatted: Boolean;
    FUnifiedPictures: Boolean;
    FPicFormat: TfrxPictureFormat;
    FShadowStyle: TfrxCSSStyle;
    FEmbeddedPictures: Boolean;
    FEmbeddedCSS: Boolean;
    FCurrentSVGFile: TStream;
    FCurrentPage: Integer; // 1-based index of the current report page
    FCSS: TfrxCSS; // stylesheet for all pages
    FPictures: TfrxPictureStorage;
    FHandlers: array of TfrxExportHandler;

    procedure SetPicFormat(Fmt: TfrxPictureFormat);
    function GetShadowStyle: TfrxCSSStyle;
    function GetCSSFileName: string;
    function GetCSSFilePath: string;
    procedure SaveCSS(const FileName: string);
    procedure PutsRaw(const s: AnsiString);
    procedure PutImgage(Obj: TfrxView; Pic: TGraphic);
    procedure RunExportsChain(Obj: TfrxView);
    procedure StartSVG(Width, Height: double);
    procedure FinishSVG;

    { Handlers for specific kinds of TfrxView objects.
      They return "True" if they succeed to export an object,
      or "False" if they want to pass the object further along
      the handlers chain. }

    function ExportShape      (Obj: TfrxView): Boolean;
    function ExportLine       (Obj: TfrxView): Boolean;
    function ExportGradient   (Obj: TfrxView): Boolean;
    function ExportPicture    (Obj: TfrxView): Boolean;
    function ExportAsPicture  (Obj: TfrxView): Boolean;
    function ExportMemo       (Obj: TfrxView): Boolean;
  protected
    FGlobalPageY: double;
    FPageRect: string;
    FDefineCount: integer;

    { Writes a string to the current SVG file }
    procedure PutsA(const s: AnsiString);
    procedure Puts(const s: string); overload;
    procedure Puts(const Fmt: string; const Args: array of const); overload;

    { Registers a CSS style in the internal CSS table
      and returns a selector that can be used in the "class"
      attribute of SCG tags.  }
    function LockStyle(Style: TfrxCSSStyle): string;

    procedure DoGradient(Obj: TfrxView; BeginValue, EndValue: string; Style: TfrxGradientStyle);
    procedure DoFrameLine(x1, y1, x2, y2: double; frxFrameLine: TfrxFrameLine);
    procedure DoFill(Obj: TfrxView);
    procedure DoFrame(Obj: TfrxView);
    procedure DoFilledRect(Obj: TfrxView; FillValue: string);
    procedure DoBackground(Obj: TfrxView);
    function DoHyperLink(Obj: TfrxView): boolean;
    function WrapByCrLf(const Text: string; out BreakCount: integer; const x, dy: double): string;

    class function HasSpecialChars(const s: string): Boolean;
    class function EscapeTextAndAttribute(const s: string): string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    class function GetDescription: String; override;
    function ShowModal: TModalResult; override;

    function Start: Boolean; override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    procedure Finish; override;

    procedure AttachHandler(Handler: TfrxExportHandler);

    property ShadowStyle: TfrxCSSStyle read GetShadowStyle;
  published
    property OverwritePrompt;
    property OpenAfterExport: Boolean read FOpenAfterExport write FOpenAfterExport;

    { Exports each report page to a separate SVG page }

    property MultiPage: Boolean read FMultiPage write FMultiPage;

    { Makes SVG sources formatted (and sligtly bigger) }

    property Formatted: Boolean read FFormatted write FFormatted;

    { Format for pictures representing report objects that are not saved in SVG natively,
      like RichText objects.}

    property PictureFormat: TfrxPictureFormat read FPicFormat write SetPicFormat;

    { Converts all pictures to PictureFormat: if there's a BMP picture in a report
      and PictureFormat is PNG, then this BMP will be saved as a PNG. }

    property UnifiedPictures: Boolean read FUnifiedPictures write FUnifiedPictures;

    { Embeds pictures into SVG}

    property EmbeddedPictures: Boolean read FEmbeddedPictures write FEmbeddedPictures;

    { Embeds CSS stylesheet into SVG }

    property EmbeddedCSS: Boolean read FEmbeddedCSS write FEmbeddedCSS;
  end;

implementation

uses
  frxUtils,
  frxRes,
  Math,
{$IFDEF Delphi12}
 pngimage,
{$ELSE}
 frxpngimage,
{$ENDIF}
  jpeg,
  frxXML, // for access to TfrxPreviewPages.FindAnchor's results
  frxPreviewPages,
  frxrcExports;

{ Random TimerId contants }

{$R *.dfm}

{ Utility routines }

function IfStr(Flag: Boolean; const sTrue: string; sFalse: string = ''): string;
begin
  if Flag then
    Result := sTrue
  else
    Result := sFalse;
end;

function GetColor(Color: TColor): string;
begin
  case Color of
    clAqua:    Result := 'aqua';
    clBlack:   Result := 'black';
    clBlue:    Result := 'blue';
    clFuchsia: Result := 'fuchsia';
    clGray:    Result := 'gray';
    clGreen:   Result := 'green';
    clLime:    Result := 'lime';
    clLtGray:  Result := 'lightgray';
    clMaroon:  Result := 'maroon';
    clNavy:    Result := 'navy';
    clOlive:   Result := 'olive';
    clPurple:  Result := 'purple';
    clRed:     Result := 'red';
    clTeal:    Result := 'teal';
    clWhite:   Result := 'white';
    clYellow:  Result := 'yellow';

    clNone:    Result := 'transparent';
  else
    if Color and $ff000000 <> 0 then
      Result := GetColor(GetSysColor(Color and $ffffff))
    else
      Result := HTMLRGBColor(Color)
  end
end;

function GetBorderRadius(Curve: Integer): string;
begin
  if Curve < 1 then
    Result := GetBorderRadius(2)
  else
    Result := IntToStr(Curve * 4) + 'pt'
end;

function GetStr(const Id: string): string;
begin
  Result := frxResources.Get(Id)
end;

procedure TfrxSVGExportDialog.FormCreate(Sender: TObject);

  procedure AssignTexts(Root: TControl);
  var
    i: Integer;
  begin
    with Root do
    begin
      if Tag > 0 then
        SetTextBuf(PChar(GetStr(IntToStr(Tag))));

      if Root is TWinControl then
        with Root as TWinControl do
          for i := 0 to ControlCount - 1 do
            if Controls[i] is TControl then
              AssignTexts(Controls[i] as TControl);
    end;
  end;

begin
  AssignTexts(Self);

  if UseRightToLeftAlignment then
    FlipChildren(True)
end;

procedure TfrxSVGExportDialog.PageNumbersEChange(Sender: TObject);
begin
  PageNumbersRB.Checked := True
end;

procedure TfrxSVGExportDialog.PageNumbersEKeyPress(Sender: TObject; var Key: Char);
begin
  if not (AnsiChar(Key) in ['0'..'9', #9, '-', ',']) then
    Key := #0
end;

procedure TfrxSVGExportDialog.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self)
end;

{ TfrxSVGExport }

const
  PageIndent = 20;
  ShadowOpacity = '0.5';
  ShadowFilterName = 'pageshadowfilter';
  ShadowStyleName = 'shadow';
  BorderHalfWidth = 0.5;
  PageIdName = 'page';

procedure TfrxSVGExport.AttachHandler(Handler: TfrxExportHandler);
begin
  SetLength(FHandlers, Length(FHandlers) + 1);
  FHandlers[Length(FHandlers) - 1] := Handler;
end;

constructor TfrxSVGExport.Create(AOwner: TComponent);
begin
  inherited;
  DefaultExt := GetStr('9511');

  AttachHandler(ExportAsPicture);
  AttachHandler(ExportPicture);
  AttachHandler(ExportMemo);

  AttachHandler(ExportGradient);
  AttachHandler(ExportLine);
  AttachHandler(ExportShape);

  EmbeddedCSS      := True;  // embed CSS into SVG
  Multipage        := False; // export all report into one SVG page
  EmbeddedPictures := True;  // embed pictures into SVG
  PictureFormat    := pfPNG; // save pictures as PNG
  UnifiedPictures  := True;  // convert all pictures to PictureFormat
  Formatted        := False; // makes SVG sources formatted (and sligtly bigger)

  { Make a shadowed border around each page}
  ShadowStyle['fill'] := 'white';
  ShadowStyle['filter'] := 'url(#' + ShadowFilterName + ')';
  ShadowStyle['opacity'] := ShadowOpacity;
  ShadowStyle['stroke'] := 'black';
  ShadowStyle['stroke-width'] := IntToStr(Round(BorderHalfWidth * 2));
end;

destructor TfrxSVGExport.Destroy;
begin
  FShadowStyle.Free; // it's created by the getter
  inherited
end;

procedure TfrxSVGExport.DoBackground(Obj: TfrxView);
begin
  DoFilledRect(Obj, GetColor(Obj.Color));
end;

procedure TfrxSVGExport.DoFilledRect(Obj: TfrxView; FillValue: string);
begin
  if FillValue <> 'transparent' then
    Puts('<rect x="%d" y="%d" width="%d" height="%d" fill="%s" />',
      [Round(Obj.AbsLeft), Round(Obj.AbsTop), Round(Obj.Width), Round(Obj.Height), FillValue]);
end;

procedure TfrxSVGExport.DoFill(Obj: TfrxView);
var
  FillValue: string;

  procedure DefineAndFillPattern(XLine, YLine, Turn: boolean);
  var
    PatternName: string;
  begin
    PatternName := 'Pattern' + IntTostr(FDefineCount);
    FDefineCount := FDefineCount + 1;

    Puts('<defs>');
    Puts('<pattern id="%s" width="8" height="8" patternUnits="userSpaceOnUse"' +
      IfStr(Turn, ' patternTransform="rotate(45)"') + '>', [PatternName]);
    if XLine then
      Puts('<line x2="8" stroke="%s" />', [FillValue]);
    if YLine then
      Puts('<line y2="8" stroke="%s" />', [FillValue]);
    Puts('</pattern>');
    Puts('</defs>');
    DoFilledRect(Obj, Format('url(#%s)', [PatternName]));
  end;

begin
  case Obj.FillType of
    ftBrush:
    begin
      FillValue := GetColor((Obj.Fill as TfrxBrushFill).ForeColor);
      case (Obj.Fill as TfrxBrushFill).Style of
        bsHorizontal: DefineAndFillPattern(True,  False, False);
        bsVertical:   DefineAndFillPattern(False, True,  False);
        bsFDiagonal:  DefineAndFillPattern(True,  False, True);
        bsBDiagonal:  DefineAndFillPattern(False, True,  True);
        bsCross:      DefineAndFillPattern(True,  True,  False);
        bsDiagCross:  DefineAndFillPattern(True,  True,  True);
        else
      end;
    end;
    ftGradient:
      with Obj.Fill as TfrxGradientFill do
        DoGradient(Obj, frxExportSVG.GetColor(StartColor), frxExportSVG.GetColor(EndColor), TfrxGradientStyle(GradientStyle));
  else
  end;
end;

procedure TfrxSVGExport.DoFrame(Obj: TfrxView);
var
  Left, Top, Right, Bottom: double;
begin
  Left := Obj.AbsLeft;
  Top := Obj.AbsTop;
  Right := Left + Obj.Width;
  Bottom := Top + Obj.Height;
  if (ftLeft in Obj.Frame.Typ) then   DoFrameLine(Left,  Top,    Left,  Bottom, Obj.Frame.LeftLine);
  if (ftRight in Obj.Frame.Typ) then  DoFrameLine(Right, Top,    Right, Bottom, Obj.Frame.RightLine);
  if (ftTop in Obj.Frame.Typ) then    DoFrameLine(Left,  Top,    Right, Top,    Obj.Frame.TopLine);
  if (ftBottom in Obj.Frame.Typ) then DoFrameLine(Left,  Bottom, Right, Bottom, Obj.Frame.BottomLine);
end;

function TfrxSVGExport.DoHyperLink(Obj: TfrxView): boolean;

  function PutsTrue(const Fmt: string; const Args: array of const): boolean;
  begin
    Puts(Fmt, Args);
    Result := True; // :-)
  end;

begin
  Result := False;
  if (Obj.Hyperlink <> nil) and (Obj.Hyperlink.Value <> '') then
    case Obj.Hyperlink.Kind of
      hkURL: Result := PutsTrue(
        '<a xlink:href="%s" target="_blank">', [Obj.Hyperlink.Value]);
      hkAnchor: ;
      hkPageNumber: Result := PutsTrue(
        '<a xlink:href="#%s%s">', [PageIdName, Obj.Hyperlink.Value]);
      hkDetailReport: ;
      hkDetailPage: ;
    else { hkCustom: }
    end;
end;

procedure TfrxSVGExport.DoFrameLine(x1, y1, x2, y2: double; frxFrameLine: TfrxFrameLine);
var
  LineWidth: double;
  Dasharray, Dash, Dot, CSSClassName: string;
begin
  if frxFrameLine.Style = fsDouble then LineWidth := frxFrameLine.Width * 2
  else                                  LineWidth := frxFrameLine.Width;
  Dash := IntToStr(Round(6 * LineWidth));
  Dot := IntToStr(Round(2 * LineWidth));
  case frxFrameLine.Style of
    fsDash: Dasharray := Dash + ' ' + Dot;
    fsDot: Dasharray := Dot + ' ' + Dot;
    fsDashDot: Dasharray := Dash + ' ' + Dot + ' ' + Dot + ' ' + Dot;
    fsDashDotDot: Dasharray := Dash + ' ' + Dot + ' ' + Dot + ' ' + Dot + ' ' + Dot + ' ' + Dot;
    fsAltDot: Dasharray := Dash + ' ' + Dot + ' ' + Dot + ' ' + Dot;
  else // fsSolid, fsDouble, fsSquare:
    Dasharray := '';
  end;

  with TfrxCSSStyle.Create do
  begin
    Style['stroke'] := GetColor(frxFrameLine.Color);
    Style['stroke-width'] := IntToStr(Round(LineWidth));
    Style['stroke-dasharray'] := Dasharray;
    CSSClassName := LockStyle(This);
  end;

  Puts('<line x1="%d" y1="%d" x2="%d" y2="%d" class="%s"/>',
    [Round(x1), Round(y1), Round(x2), Round(y2), CSSClassName]);
end;

procedure TfrxSVGExport.DoGradient(Obj: TfrxView; BeginValue, EndValue: string; Style: TfrxGradientStyle);

  procedure DefineAndFillGradient(GradientValue: string; x2y2, r: boolean; c1, c2, c3: string);
  var
    GradientName: string;
  begin
    GradientName := 'Gradient' + IntTostr(FDefineCount);
    FDefineCount := FDefineCount + 1;

    Puts('<defs>');
    Puts('<%sGradient' + IfStr(x2y2, ' x2="0%%" y2 ="100%%"') +
      IfStr(r, ' r="70%%"') + ' id="%s">', [GradientValue, GradientName]);
    Puts('<stop offset="0%%" stop-color="%s"/>', [c1]);
    if c2 <> '' then
      Puts('<stop offset="50%%" stop-color="%s"/>', [c2]);
    Puts('<stop offset="100%%" stop-color="%s"/>', [c3]);
    Puts('</%sGradient>', [GradientValue]);
    Puts('</defs>');

    DoFilledRect(Obj, Format('url(#%s)', [GradientName]));
  end;

begin
  case Style of
    gsHorizontal:  DefineAndFillGradient('linear', False, False, BeginValue, '', EndValue);
    gsVertical:    DefineAndFillGradient('linear', True, False, BeginValue, '', EndValue);
    gsVertCenter:  DefineAndFillGradient('linear', True, False, BeginValue, EndValue, BeginValue);
    gsHorizCenter: DefineAndFillGradient('linear', False, False, BeginValue, EndValue, BeginValue);
  else // gsElliptic, gsRectangle:
                   DefineAndFillGradient('radial', False, True, EndValue, '', BeginValue);
  end;
end;

class function TfrxSVGExport.EscapeTextAndAttribute(const s: string): string;
var
  i: Integer;
begin
  if HasSpecialChars(s) then
  begin
    Result := '';

    for i := 1 to Length(s) do
      case s[i] of // http://commons.oreilly.com/wiki/index.php/SVG_Essentials/The_XML_You_Need_for_SVG
        '<': Result := Result + '&lt;';
        '>': Result := Result + '&gt;';
        '&': Result := Result + '&amp;';
        '"': Result := Result + '&quot;';
        '''': Result := Result + '&apos;';
        #13: { ignore this symbol: W3C does not allow it in attributes };
      else
        if (s[i] = ' ') and (i > 1) and (s[i - 1] = ' ') then
          Result := Result + '&#160;'
        else if Word(s[i]) < 32 then
          Result := Result + '&#' + IntToStr(Word(s[i])) + ';'
        else
          Result := Result + s[i];
      end;
  end
  else
    Result := s;
end;

function TfrxSVGExport.ExportAsPicture(Obj: TfrxView): Boolean;
var
  Pic: TfrxPicture;
begin
  { Some objects can have negative dimensions }

  Pic := TfrxPicture.Create(
    PictureFormat,
    Abs(Round(Obj.AbsLeft + Obj.Width) - Round(Obj.AbsLeft)),
    Abs(Round(Obj.AbsTop + Obj.Height) - Round(Obj.AbsTop)));

  with Pic.Canvas do
  begin
    Brush.Color := clWhite;
    FillRect(ClipRect);
  end;

  try
    Obj.Draw(Pic.Canvas, 1, 1, -Obj.AbsLeft, -Obj.AbsTop);
  except
  end;

  PutImgage(Obj, Pic.Release);
  Pic.Free;
  Result := True;
end;

function TfrxSVGExport.ExportGradient(Obj: TfrxView): Boolean;
begin
  Result := Obj is TfrxGradientView;
  if not Result then Exit;

  with Obj as TfrxGradientView do
    DoGradient(Obj, GetColor(BeginColor), GetColor(EndColor), Style);

  DoFrame(Obj);
end;

function TfrxSVGExport.ExportLine(Obj: TfrxView): Boolean;
var
  x1, x2, y1, y2: double;
begin
  Result := Obj is TfrxLineView;
  if not Result then Exit;

  x1 := Obj.AbsLeft; x2 := x1 + Obj.Width;
  y1 := Obj.AbsTop;  y2 := y1 + Obj.Height;

  if not (Obj as TfrxLineView).Diagonal then
    if Abs(x1 - x2) > Abs(y1 - y2) then y2 := y1
    else                                x2 := x2;

  Puts('<line x1="%d" y1="%d" x2="%d" y2="%d" stroke="%s"/>',
     [Round(x1), Round(y1), Round(x2), Round(y2), GetColor((Obj as TfrxLineView).Color)]);

  DoFrame(Obj);
end;

function TfrxSVGExport.ExportMemo(Obj: TfrxView): Boolean;

  function FontSizePx(Font: TFont): double;
  begin
    Result := Font.Size * 96 / 72;
  end;

  function GetCursor(Cursor: TCursor): string;
  begin
    case Cursor of
      crCross:      Result := 'crosshair';
      crIBeam:      Result := 'text';
      crHelp:       Result := 'help';
      crUpArrow:    Result := 'n-resize';
      crHourGlass:  Result := 'wait';
      crDrag:       Result := 'move';
      crHandPoint:  Result := 'pointer';
      else          Result := '';
    end;
  end;

  function TextAnchor(Memo: TfrxCustomMemoView): double;
  begin
    case Memo.HAlign of
      haRight:  Result := Memo.AbsLeft + Memo.Width - Memo.GapX;
      haCenter: Result := Memo.AbsLeft + Memo.Width / 2;
    else        Result := Memo.AbsLeft + Memo.GapX; // haLeft, haBlock:
    end;
  end;

  procedure FillProps(Style: TfrxCSSStyle; Obj: TfrxCustomMemoView);
  begin
    Style['cursor'] := GetCursor(Obj.Cursor);
    case Obj.HAlign of
      haRight:  Style['text-anchor'] := 'end';
      haCenter: Style['text-anchor'] := 'middle';
    else        Style['text-anchor'] := 'start'; // haLeft, haBlock:
    end;
    case Obj.VAlign of
      vaTop:    Style['dominant-baseline'] := 'text-after-edge'; // !!!
      vaCenter: Style['dominant-baseline'] := 'central';
      vaBottom: Style['dominant-baseline'] := 'text-after-edge';
    end;
    if Obj.CharSpacing > 0 then
      Style['letter-spacing'] := IntToStr(Round(Obj.CharSpacing));

    Style['font-family'] := Obj.Font.Name + ';';
    Style['font-size'] := IntToStr(Obj.Font.Size) + 'pt;';
    Style['fill'] := GetColor(Obj.Font.Color) + ';';
    Style['font-weight'] := IfStr(fsBold in Obj.Font.Style, 'bold;');
    Style['font-style'] := IfStr(fsItalic in Obj.Font.Style, 'italic;');
    Style['text-decoration'] := IfStr(fsStrikeout in Obj.Font.Style, 'line-through;');
    Style['text-decoration'] := IfStr(fsUnderline in Obj.Font.Style, 'underline;');
  end;

var
  Memo: TfrxMemoView;
  Text, CSSClassName, Turn: string;
  BreakCount: integer;
  TextLeft, TextTop, LineSpacing: double;
begin
  Result := Obj is TfrxMemoView;
  if not Result then Exit;
  Memo := Obj as TfrxMemoView;

  DoBackground(Obj);

  DoFill(Obj);

{$IFDEF Delphi12}
  Text := Trim(Memo.WrapText(True));
{$ELSE}
  Text := Trim(UTF8Encode(Memo.WrapText(True)));
{$ENDIF}

  if not ((Text = '') or (Text = '0') and Memo.HideZeros) then
  begin
    with TfrxCSSStyle.Create do
    begin
      FillProps(This, Memo);
      CSSClassName := LockStyle(This);
    end;

    TextLeft := TextAnchor(Memo);

    LineSpacing := Memo.LineSpacing + FontSizePx(Memo.Font) - 1;

    Text := WrapByCrLf(Text, BreakCount, TextLeft, LineSpacing);

    case Memo.VAlign of
      vaTop:
        TextTop := Memo.AbsTop + Memo.GapY + LineSpacing;
      vaCenter:
        TextTop := Memo.AbsTop + Memo.Height / 2 - BreakCount * LineSpacing / 2;
//        TextTop := Memo.AbsTop + Memo.Height / 2 - (BreakCount - 1) * LineSpacing / 2;
    else // vaBottom:
        TextTop := Memo.AbsTop + Memo.Height - Memo.GapY - BreakCount * LineSpacing;
    end;

    if Memo.Rotation <> 0 then
      Turn := Format(' transform="rotate(%d %d,%d)"',
        [-Memo.Rotation, Round(TextLeft), Round(TextTop)])
    else
      Turn := '';

    Puts('<text x="%d" y="%d" width="%d" height="%d" class="%s"' + Turn +'>',
      [Round(TextLeft), Round(TextTop), Round(Memo.Width), Round(Memo.Height), CSSClassName]);
    Puts(Text);
    Puts('</text>');
  end;

  DoFrame(Obj);
end;

procedure TfrxSVGExport.ExportObject(Obj: TfrxComponent);
begin
  if Obj is TfrxView then
    RunExportsChain(Obj as TfrxView);

  inherited
end;

function TfrxSVGExport.ExportPicture(Obj: TfrxView): Boolean;
var
  Pic: TGraphic;
  Typ: TfrxFrameTypes;
begin
  Result := Obj is TfrxPictureView;
  if not Result then Exit;

  Pic := (Obj as TfrxPictureView).Picture.Graphic;

  if Pic <> nil then
    if UnifiedPictures then
    begin
      Typ := Obj.Frame.Typ;
      Obj.Frame.Typ := [];
      ExportAsPicture(Obj);
      Obj.Frame.Typ := Typ;
    end
    else
      PutImgage(Obj, Pic);

  DoFrame(Obj);
end;

function TfrxSVGExport.ExportShape(Obj: TfrxView): Boolean;
var
  StrokeValue, FillValue, RadiusValue: string;
  w, h, h2, w2: double;
  x1, x2, x3, y1, y2, y3: double;
begin
  Result := Obj is TfrxShapeView;
  if not Result then Exit;

  DoBackGround(Obj);

  StrokeValue := GetColor(Obj.Frame.Color);
  FillValue := GetColor(Obj.Color);
  RadiusValue := GetBorderRadius((Obj as TfrxShapeView).Curve);
  w := Obj.Width;  w2 := w / 2;
  h := Obj.Height; h2 := h / 2;
  x1 := Obj.AbsLeft; x2 := x1 + w2; x3 := x1 + w;
  y1 := Obj.AbsTop;  y2 := y1 + h2; y3 := y1 + h;

  case (Obj as TfrxShapeView).Shape of
    skRectangle:
      Puts('<rect x="%d" y="%d" width="%d" height="%d" stroke="%s" fill="%s"/>',
        [Round(x1), Round(y1), Round(w), Round(h), StrokeValue, FillValue]);
    skRoundRectangle:
      Puts('<rect x="%d" y="%d" width="%d" height="%d" stroke="%s" fill="%s" rx="%s" ry="%s"/>',
        [Round(x1), Round(y1), Round(w), Round(h), StrokeValue, FillValue, RadiusValue, RadiusValue]);
    skEllipse:
      Puts('<ellipse cx="%d" cy="%d" rx="%d" ry="%d" stroke="%s" fill="%s"/>',
        [Round(x2), Round(y2), Round(w2), Round(h2), StrokeValue, FillValue]);
    skTriangle:
      Puts('<polygon points="%d,%d %d,%d %d,%d" stroke="%s" fill="%s"/>',
        [Round(x2), Round(y1), Round(x3), Round(y3), Round(x1), Round(y3), StrokeValue, FillValue]);
    skDiamond:
      Puts('<polygon points="%d,%d %d,%d %d,%d %d,%d" stroke="%s" fill="%s"/>',
        [Round(x2), Round(y1), Round(x3), Round(y2), Round(x2), Round(y3), Round(x1), Round(y2), StrokeValue, FillValue]);
    skDiagonal1:
      Puts('<line x1="%d" y1="%d" x2="%d" y2="%d" stroke="%s"/>',
        [Round(x1), Round(y3), Round(x3), Round(y1), StrokeValue]);
    skDiagonal2:
      Puts('<line x1="%d" y1="%d" x2="%d" y2="%d" stroke="%s"/>',
        [Round(x1), Round(y1), Round(x3), Round(y3), StrokeValue]);
  end;

  DoFrame(Obj);
end;

procedure TfrxSVGExport.Finish;
begin
  if not MultiPage then
    FinishSVG;

  if not MultiPage then
    FCurrentSVGFile.Free;

  if not Assigned(Stream) and not EmbeddedCSS then
    SaveCSS(GetCSSFilePath);

  FPictures.Free;
  FCSS.Free;

  if OpenAfterExport and not Assigned(Stream) then
    ShellExecute(0, 'open', PChar(FileName), nil, nil, SW_SHOW);
end;

procedure TfrxSVGExport.FinishPage(Page: TfrxReportPage; Index: Integer);
begin
  Puts('</svg>');

  if MultiPage then
    FinishSVG;

  if MultiPage then
    FCurrentSVGFile.Free;

  inherited
end;

procedure TfrxSVGExport.FinishSVG;
begin
  if EmbeddedCSS then
  begin
    Puts('<style type="text/css"><![CDATA[');
    FCSS.Save(FCurrentSVGFile, Formatted);
    Puts(']]></style>');
  end;

  Puts('</svg>');
end;

function TfrxSVGExport.GetCSSFileName: string;
begin
  if Multipage then
    Result := 'styles.css'
  else
    Result := ExtractFileName(FileName) + '.css'
end;

function TfrxSVGExport.GetCSSFilePath: string;
begin
  if Multipage then
    Result := FileName + '\' + GetCSSFileName
  else
    Result := ExtractFileDir(FileName) + '\' + GetCSSFileName
end;

class function TfrxSVGExport.GetDescription: String;
begin
  Result := GetStr('SVGexport');
end;

function TfrxSVGExport.GetShadowStyle: TfrxCSSStyle;
begin
  if FShadowStyle = nil then
    FShadowStyle := TfrxCSSStyle.Create;
  Result := FShadowStyle;
end;

class function TfrxSVGExport.HasSpecialChars(const s: string): Boolean;
var
  i: Integer;
begin
  Result := True;

  for i := 1 to Length(s) do
    case s[i] of
      '<', '>', '&': Exit;
      else if Word(S[i]) < 32 then
        Exit
    end;

  Result := False
end;

function TfrxSVGExport.LockStyle(Style: TfrxCSSStyle): string;
begin
  Result := FCSS.Add(Style)
end;

procedure TfrxSVGExport.PutImgage(Obj: TfrxView; Pic: TGraphic);
begin
  { If the SVG is written to a specified stream (maybe a TMemoryStream),
    additional files with pictures cannot be created.}
  if Assigned(Stream) and not EmbeddedPictures or (Pic.Height <= 0) then
    Exit;

  PutsRaw(AnsiString(Format('<image x="%d" y="%d" width="%d" height="%d" xlink:href="',
   [Round(Obj.AbsLeft), Round(Obj.AbsTop), Round(Obj.Width), Round(Obj.Height)])));

  if not EmbeddedPictures then
    PutsRaw(AnsiString(FPictures.Save(Pic)))
  else
  begin
    PutsRaw(AnsiString(Format('data:%s;base64,', [TfrxPictureStorage.GetInfo(Pic).Mimetype])));
    with TBase64Encoder.Create(FCurrentSVGFile) do
    begin
      Pic.SaveToStream(This);
      Free;
    end;
  end;

  Puts('"/>');

  DoFrame(Obj);
end;

procedure TfrxSVGExport.Puts(const Fmt: string; const Args: array of const);
begin
  Puts(Format(Fmt, Args));
end;

procedure TfrxSVGExport.Puts(const s: string);
begin
  PutsA(AnsiString(s));
end;

procedure TfrxSVGExport.PutsA(const s: AnsiString);
begin
  PutsRaw(s);

  if Formatted and (s <> '') then
    PutsRaw(#13#10);
end;

procedure TfrxSVGExport.PutsRaw(const s: AnsiString);
begin
  if s <> '' then
    FCurrentSVGFile.Write(s[1], Length(s))
end;

procedure TfrxSVGExport.RunExportsChain(Obj: TfrxView);
var
  i: Integer;
  IsAnchor: boolean;
begin
  IsAnchor := DoHyperLink(Obj);
  for i := Length(FHandlers) - 1 downto 0 do
    if TfrxExportHandler(FHandlers[i])(Obj) then
      Break;
  if IsAnchor then
    Puts('</a>');
end;

procedure TfrxSVGExport.SaveCSS(const FileName: string);
var
  s: TStream;
begin
  s := nil;

  try
    s := TCachedStream.Create(
      TFileStream.Create(FileName, fmCreate),
      True);

    FCSS.Save(s, Formatted)
  finally
    s.Free
  end
end;

procedure TfrxSVGExport.SetPicFormat(Fmt: TfrxPictureFormat);
begin
  if Fmt in [pfEMF, pfBMP, pfPNG, pfJPG] then
    FPicFormat := Fmt
  else
    raise Exception.Create('Invalid PictureFormat')
end;

function TfrxSVGExport.ShowModal: TModalResult;

  procedure DisableCB(CB: TCheckBox);
  begin
    CB.State := cbGrayed;
    CB.Enabled := False;
  end;

begin
  Result := mrOk;
  if Assigned(Stream) then Exit;

  with TfrxSVGExportDialog.Create(nil) do
  try
    if SlaveExport then
    begin
      OpenAfterExport := False;
      DisableCB(OpenCB);

      EmbeddedCSS := True;
      DisableCB(StylesCB);

      EmbeddedPictures := True;
      DisableCB(PicturesCB);

      MultiPage := False;
      DisableCB(MultipageCB);

      PictureFormat := pfPNG;
      PFormatCB.Enabled := False;

      UnifiedPictures := True;
      DisableCB(UnifiedPicturesCB);
    end;

    OpenCB.Checked := OpenAfterExport;
    StylesCB.Checked := EmbeddedCSS;
    PicturesCB.Checked := EmbeddedPictures;
    MultipageCB.Checked := MultiPage;
    UnifiedPicturesCB.Checked := UnifiedPictures;
    FormattedCB.Checked := Formatted;
    PFormatCB.ItemIndex := Integer(PictureFormat);

    if PageNumbers <> '' then
    begin
      PageNumbersE.Text     := PageNumbers;
      PageNumbersRB.Checked := True;
    end;

    if OverwritePrompt then
      sd.Options := sd.Options + [ofOverwritePrompt];
    sd.FileName := FileName;
    sd.DefaultExt := DefaultExt;
    sd.Filter := GetStr('9510');
    if (FileName = '') and not SlaveExport then
      sd.FileName := ChangeFileExt(
        ExtractFileName(frxUnixPath2WinPath(Report.FileName)), sd.DefaultExt);

    Result := ShowModal;

    if Result = mrOk then
    begin
      OpenAfterExport := OpenCB.Checked;
      EmbeddedCSS := StylesCB.Checked;
      EmbeddedPictures := PicturesCB.Checked;
      MultiPage := MultipageCB.Checked;
      UnifiedPictures := UnifiedPicturesCB.Checked;
      Formatted := FormattedCB.Checked;
      PictureFormat := TfrxPictureFormat(PFormatCB.ItemIndex);

      PageNumbers := '';
      CurPage := CurPageRB.Checked;
      if PageNumbersRB.Checked then
        PageNumbers := PageNumbersE.Text;

      if not SlaveExport then
      begin
        if DefaultPath <> '' then
          sd.InitialDir := DefaultPath;
        if sd.Execute then
          FileName := sd.FileName
        else
          Result := mrCancel;
      end;
    end;
  finally
    Free
  end;
end;

function TfrxSVGExport.Start: Boolean;
begin
  Result := False;

  if SlaveExport then
    if Report.FileName <> '' then
      FileName := ChangeFileExt(
        GetTemporaryFolder + ExtractFileName(Report.FileName),
        DefaultExt)
    else
      FileName := ChangeFileExt(GetTempFile, DefaultExt);

  if (FileName = '') and not Assigned(Stream) then
    Exit;

  if (ExtractFilePath(FileName) = '') and (DefaultPath <> '') then
    FileName := DefaultPath + '\' + FileName;

  if MultiPage then
  begin
    if FileExists(FileName) and not DeleteFile(FileName) then
      Exit;

    if not CreateDir(FileName) then
      Exit;
  end
  else if Assigned(Stream) then
    FCurrentSVGFile := TCachedStream.Create(Stream, False)
  else
    try
      FCurrentSVGFile := TCachedStream.Create(
        TFileStream.Create(FileName, fmCreate),
        True)
    except
      Exit
    end;

  if Multipage then
    FPictures := TfrxPictureStorage.Create(FileName)
  else
    FPictures := TfrxPictureStorage.Create(ExtractFileDir(FileName));

  FCSS := TfrxCSS.Create;
  FShadowStyle.AssignTo(FCSS.Add('.' + ShadowStyleName));

  FCurrentPage := 0;
  Result := True;
end;

procedure TfrxSVGExport.StartPage(Page: TfrxReportPage; Index: Integer);
var
  PreviewPages: TfrxPreviewPages;
  Width, Height: double;
  i: integer;
  pgN: TStringList;
begin
  inherited;
  Inc(FCurrentPage);

  if MultiPage then
    FCurrentSVGFile := TCachedStream.Create(
      TFileStream.Create(
        Format('%s\%d' + DefaultExt, [FileName, FCurrentPage]),
        fmCreate),
      True);

  PreviewPages := Report.PreviewPages as TfrxPreviewPages;
  if MultiPage then
    StartSVG(PreviewPages.Page[FCurrentPage - 1].Width + 2 * PageIndent,
             PreviewPages.Page[FCurrentPage - 1].Height + 2 * PageIndent)
  else if FCurrentPage = 1 then
  begin
    pgN := TStringList.Create;
    frxParsePageNumbers(PageNumbers, pgN, PreviewPages.Count);
    Width := 0;
    Height := PageIndent;
    for i := 0 to PreviewPages.Count - 1 do
      if (pgN.Count = 0) or (pgN.IndexOf(IntToStr(i + 1)) >= 0) then
      begin
        Width := Max(Width, PreviewPages.PageSize[i].X);
        Height := Height + PreviewPages.PageSize[i].Y + PageIndent;
      end;
    StartSVG(Width + 2 * PageIndent, Height);
    pgN.Free;
  end;

  Puts('<svg x="%d" y="%d" width="%d" height="%d">',
    [Round(Page.AbsLeft + PageIndent), Round(FGlobalPageY + PageIndent),
     Round(Page.Width + PageIndent), Round(Page.Height + PageIndent)]);

  FGlobalPageY := FGlobalPageY + Page.Height + PageIndent;

  if Formatted then
    Puts('<!-- page #%d -->', [Index]);

  FPageRect := Format('<rect x="%d" y="%d" width="%d" height="%d"',
    [Round(Page.AbsLeft + BorderHalfWidth), Round(Page.AbsTop + BorderHalfWidth),
     Round(Page.Width), Round(Page.Height)]);

  Puts(FPageRect + ' id="%s%d" class="%s"/>', [PageIdName, Index + 1, ShadowStyleName]);
end;

procedure TfrxSVGExport.StartSVG(Width, Height: double);
begin
  if not EmbeddedCSS then
    Puts('<?xml-stylesheet type="text/css" href="%s"?>', [GetCSSFileName]);

  Puts('<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"' +
       ' width="%d" height="%d">', [Round(Width), Round(Height)]);

  Puts('<defs><filter id="%s" width="200%%" height="200%%">' +
       '<feOffset result="offOut" in="SourceAlpha" dx="10" dy="10" />' +
       '<feGaussianBlur result="blurOut" in="offOut" stdDeviation="5" />' +
       '<feBlend in="SourceGraphic" in2="blurOut" mode="normal" />'+
       '</filter></defs>', [ShadowFilterName]);

  FGlobalPageY := 0.0;
  FDefineCount := 0;
end;

function TfrxSVGExport.WrapByCrLf(const Text: string; out BreakCount: integer; const x, dy: double): string;
var
  FirstList: TStringList;
  i: integer;
  PartUpToCRFL: string;

  procedure AddAndClear;
  begin
    if PartUpToCRFL <> '' then
      FirstList.Add(EscapeTextAndAttribute(PartUpToCRFL));
    PartUpToCRFL := '';
  end;

begin
  FirstList := TStringList.Create;
  PartUpToCRFL := '';
  for i := 1 to Length(Text) do
    if Text[i] = #10 then
      AddAndClear
    else if Text[i] <> #13 then
      PartUpToCRFL := PartUpToCRFL + Text[i];
  AddAndClear;

  BreakCount := FirstList.Count - 1;
  if BreakCount = 0 then
    Result := FirstList.Strings[0]
  else
    for i := 0 to FirstList.Count - 1 do
      Result := Result +
        IfStr(i = 0, '<tspan>', Format('<tspan x="%d" dy="%d">', [Round(x), Round(dy)])) +
        FirstList.Strings[i] + '</tspan>';

  FirstList.Free;
end;

end.