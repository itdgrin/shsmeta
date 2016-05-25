
{******************************************}
{                                          }
{             FastReport v5.0              }
{            HTML <div> Export             }
{                                          }
{         Copyright (c) 1998-2011          }
{           by Anton Khayrudinov           }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxExportHTMLDiv;

{ General advice for using this export.

    • Avoid using vertical alignment in memos:
      it forces the export to create more
      complicated HTML. Leave the alignment vaTop
      whenever it's possible.

    • Use @-type anchors in TfrxView.URL instead of
      #-type, because #-type is much slower to export. }

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
  TfrxHTMLDivExportDialog = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure PageNumbersEChange(Sender: TObject);
    procedure PageNumbersEKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  end;

  { Represents a HTML tag }

  TfrxHTMLItem = class
  private
    FName: string;
    FKeys: TStrings;
    FValues: TStrings;
    FValue: string;
    FChildren: TObjList;
    FLeft, FTop, FWidth, FHeight: Extended;
    FLeftSet, FTopSet, FWidthSet, FHeightSet: Boolean;
    FStyle: TfrxCSSStyle;
    FClass: string;

    procedure SetProp(Index: string; const Value: string);
    function GetStyle: TfrxCSSStyle;

    procedure SetLeft(a: Extended);
    procedure SetTop(a: Extended);
    procedure SetWidth(a: Extended);
    procedure SetHeight(a: Extended);

  public

    constructor Create(const Name: string);
    destructor Destroy; override;

    function This: TfrxHTMLItem;

    procedure Save(Stream: TStream; Formatted: Boolean);

    function Add(const Tag: string): TfrxHTMLItem; overload;
    function Add(Item: TfrxHTMLItem): TfrxHTMLItem; overload;
    procedure AddCSSClass(const s: string);

    class function HasSpecialChars(const s: string): Boolean;
    class function EscapeText(const s: string): string;
    class function EscapeAttribute(const s: string): string;

    property Prop[Index: string]: string write SetProp; default;
    property Value: string write FValue;
    property Name: string write FName;

    { CSS style is created on demand }

    property Style: TfrxCSSStyle read GetStyle;

    { These lengths are measured in FR units (pixels) }

    property Left:    Extended read FLeft   write SetLeft;
    property Top:     Extended read FTop    write SetTop;
    property Width:   Extended read FWidth  write SetWidth;
    property Height:  Extended read FHeight write SetHeight;
  end;

  { Queue of automatically serialised HTML tags }

  TfrxHTMLItemQueue = class
  private
    FQueue: array of TfrxHTMLItem;
    FUsed: Integer;
    FStream: TStream;
    FFormatted: Boolean;
  protected
    procedure Flush;
  public
    constructor Create(Stream: TStream; Formatted: Boolean);
    destructor Destroy; override;

    procedure Push(Item: TfrxHTMLItem);
    procedure SetQueueLength(n: Integer);
  end;



  { Measures actual size of a TfrxView.
    Example:

      Gauge := TfrxBoundsGauge.Create;
      Gauge.Obj := MemoView;

      Gauge.Bounds.Left; // the leftmost coordinate including the left border
      Gauge.Borders.Left; // the left border width }

  TfrxBoundsGauge = class
  private
    FObj: TfrxView;
    FBoundsSet: Boolean;
    FBounds: TRect;
    FBorders: TRect;

    FX, FY, FX1, FY1, FDX, FDY: Integer;
    FFrameWidth: Integer;

    procedure SetObj(Obj: TfrxView);
    procedure AddBounds(r: TRect);
    function GetInnerWidth: Integer;
    function GetInnerHeight: Integer;
  protected
    procedure BeginDraw;
    procedure DrawBackground;
    procedure DrawFrame;
    procedure DrawLine(x1, y1, x2, y2, w: Integer; Side: TfrxFrameType);
  public
    property Obj: TfrxView read FObj write SetObj;
    property Bounds: TRect read FBounds;
    property Borders: TRect read FBorders;
    property InnerWidth: Integer read GetInnerWidth;
    property InnerHeight: Integer read GetInnerHeight;
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxHTMLDivExport = class(TfrxCustomExportFilter)
  private

    FOpenAfterExport: Boolean;
    FTitle: string;
    FHTML5: Boolean;
    FMultiPage: Boolean;
    FFormatted: Boolean;
    FPicFormat: TfrxPictureFormat;
    FAllPictures: Boolean;
    FUnifiedPictures: Boolean;
    FPageStyle: TfrxCSSStyle;
    FNavigation: Boolean;
    FExportAnchors: Boolean;
    FEmbeddedPictures: Boolean;
    FEmbeddedCSS: Boolean;
    FPictureTag: Integer;

    FCurrentHTMLFile: TStream;
    FCurrentPage: Integer; // 1-based index of the current report page
    FCSS: TfrxCSS; // stylesheet for all pages
    FQueue: TfrxHTMLItemQueue; // it represents the current page
    FPictures: TfrxPictureStorage;
    FHandlers: array of TfrxExportHandler;
    FGauge: TfrxBoundsGauge;

    procedure SetPicFormat(Fmt: TfrxPictureFormat);
    function GetPageStyle: TfrxCSSStyle;
    function GetAnchor(var Page: string; const Name: string): Boolean;
    function GetHRef(const URL: string): string;
    function GetCSSFileName: string;
    function GetCSSFilePath: string;
    procedure SaveCSS(const FileName: string);
    procedure PutsRaw(const s: AnsiString);
    procedure PutImg(Obj: TfrxView; Pic: TGraphic; WriteSize: Boolean);
    procedure RunExportsChain(Obj: TfrxView);
    procedure StartHTML;
    procedure EndHTML;

    { Handlers for specific kinds of TfrxView objects.

      They return "True" if they succeed to export an object,
      or "False" if they want to pass the object further along
      the handlers chain. }

    function ExportTaggedView (Obj: TfrxView): Boolean;
    function ExportAllPictures(Obj: TfrxView): Boolean;
    function ExportMemo       (Obj: TfrxView): Boolean;
    function ExportPicture    (Obj: TfrxView): Boolean;
    function ExportRectangle  (Obj: TfrxView): Boolean;
    function ExportLine       (Obj: TfrxView): Boolean;
    function ExportGradient   (Obj: TfrxView): Boolean;
    function ExportAsPicture  (Obj: TfrxView): Boolean;

  protected

    { Writes a string to the current HTML file }

    procedure PutsA(const s: AnsiString);
    procedure Puts(const s: string); overload;
    procedure Puts(const Fmt: string; const Args: array of const); overload;

    { Creates a new HTML tag and returns it. The tag don't need to be
      deleted or serialised to a stream: this is done automatically. }

    function AddTag(const Name: string): TfrxHTMLItem;

    { Registers a CSS style in the internal CSS table
      and returns a selector that can be used in the "class"
      attribute of HTML tags. }

    function LockStyle(Style: TfrxCSSStyle): string;

    { Creates an empty <div> tag with assigned styles }

    function CreateDiv(Obj: TfrxView): TfrxHTMLItem;
    function FilterHTML(const Text: string): string;

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

    { Report pages are represented as separate <div> tags. All these tags
      are associated with the same CSS style, so its possible to adjust
      appearance of pages by modifying this style. Example:

        PageStyle['border'] := '1mm solid orange';
        PageStyle['margin'] := '5mm';
        PageStyle.CSS3Style['box-shadow'] := '3mm 3mm 3mm gray';
        PageStyle.cSS3Style['border-radius'] := '3mm'; }

    property PageStyle: TfrxCSSStyle read GetPageStyle;

  published

    property OverwritePrompt;
    property OpenAfterExport: Boolean read FOpenAfterExport write FOpenAfterExport;
    property Title: string read FTitle write FTitle;

    { Allows using HTML5 features }

    property HTML5: Boolean read FHTML5 write FHTML5;

    { Exports each report page to a separate HTML page }

    property MultiPage: Boolean read FMultiPage write FMultiPage;

    { Makes HTML sources formatted (and sligtly bigger) }

    property Formatted: Boolean read FFormatted write FFormatted;

    { Format for pictures representing report objects that are not saved in HTML natively,
      like RichText objects. }

    property PictureFormat: TfrxPictureFormat read FPicFormat write SetPicFormat;

    { Exports all report components as pictures }

    property AllPictures: Boolean read FAllPictures write FAllPictures;

    { Converts all pictures to PictureFormat: if there's a BMP picture in a report
      and PictureFormat is PNG, then this BMP will be saved as a PNG. }

    property UnifiedPictures: Boolean read FUnifiedPictures write FUnifiedPictures;

    { Embeds pictures into HTML }

    property EmbeddedPictures: Boolean read FEmbeddedPictures write FEmbeddedPictures;

    { Creates navigation controls for Multipage mode }

    property Navigation: Boolean read FNavigation write FNavigation;

    { Creates anchors based on TfrxView.URL property. This option is useful only if
      the URLs begin with the "#" sign. }

    property ExportAnchors: Boolean read FExportAnchors write FExportAnchors;

    { Embeds CSS stylesheet into HTML }

    property EmbeddedCSS: Boolean read FEmbeddedCSS write FEmbeddedCSS;

    { If not equals zero, forces the export to save all report components
      with this value of the Tag property export as pictures. The format of pictures
      is defined by PictureFormat. }

    property PictureTag: Integer read FPictureTag write FPictureTag;

  end;

  { HTML export that uses modern HTML5 features }
{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxHTML5DivExport = class(TfrxHTMLDivExport)
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
  end;

  { HTML export that is compatible with old browsers, like IE6 }
{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxHTML4DivExport = class(TfrxHTMLDivExport)
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
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
  {$IFDEF HTML_DEBUG}frxDebug,{$ENDIF}
  frxrcExports;

{ Random TimerId contants }

{$IFDEF HTML_DEBUG}
const
  TimerTotal: Integer = 0;        // total exporting time
  TimerExport: Integer = 9928291; // time taken by ExportObject
  TimerCSS: Integer = 7727381;    // time taken by GetCSS
  TimerDiv: Integer = 171728182;  // time taken by CreateDiv
  TimerCSSSave: Integer = 81281;  // time taken by TfrxCSS.Save
  TimerHTMLSave: Integer = 18218; // time taken by TfrxHTMLItem.Save
  TimerCSSAdd: Integer = 8127377; // adding a new style with TfrxCSS.Add
{$ENDIF}  

{$R *.dfm}

{ Utility routines }

function FRLength(a: Extended): string;
begin
  if a < 0 then
    Result := '0'
  else
    Result := IntToStr(Round(a)) + 'px'
end;

function BoolStr(Flag: Boolean; const s: string): string;
begin
  if Flag then
    Result := s
  else
    Result := ''
end;

function GetColor(Color: TColor): string;
begin
  case Color of
    clBlack:  Result := 'black';
    clRed:    Result := 'red';
    clGreen:  Result := 'green';
    clBlue:   Result := 'blue';
    clGray:   Result := 'gray';
    clWhite:  Result := 'white';
    clNone:   Result := 'transparent';

    else
      if Color and $ff000000 <> 0 then
        Result := GetColor(GetSysColor(Color and $ffffff))
      else
        Result := HTMLRGBColor(Color)
  end
end;

function GetLineStyle(s: TfrxFrameStyle): string;
begin
  Result := '';

  case s of
    fsSolid:  Result := 'solid';
    fsDash:   Result := 'dashed';
    fsDot:    Result := 'dotted';
    fsDouble: Result := 'double';
  end
end;

function GetFrameLineStyle(w: Extended; s: TfrxFrameStyle; c: TColor): string; overload;
begin
  if w = 0 then
    Result := ''
  else if w < 1 then
    Result := GetFrameLineStyle(1, s, c)
  else
    Result := FRLength(w) + ' ' + GetLineStyle(s) + ' ' + GetColor(c)
end;

function GetFrameLineStyle(Line: TfrxFrameLine): string; overload;
begin
  Result := GetFrameLineStyle(Line.Width, Line.Style, Line.Color)
end;

function GetHAlign(Align: TfrxHAlign): string;
begin
  Result := '';

  case Align of
    haRight:  Result := 'right';
    haCenter: Result := 'center';
    haBlock:  Result := 'justified';
  end;
end;

function GetVAlign(Align: TfrxVAlign): string;
begin
  Result := '';

  case Align of
    vaTop:    Result := 'top';
    vaBottom: Result := 'bottom';
    vaCenter: Result := 'middle';
  end;
end;

function GetBorderRadius(Curve: Integer): string;
begin
  if Curve < 1 then
    Result := GetBorderRadius(2)
  else
    Result := IntToStr(Curve*4) + 'pt'
end;

function GetFont(Font: TFont): string;
begin
  Result := BoolStr(fsBold in Font.Style, 'bold ') +
    BoolStr(fsItalic in Font.Style, 'italic ') +
    IntToStr(Font.Size) + 'pt' + ' ' + Font.Name
end;

function GetTextDecoration(s: TFontStyles): string;
begin
  Result := BoolStr(fsUnderline in s, 'underline ') +
    BoolStr(fsStrikeOut in s, 'line-through')
end;

function GetCursor(Cursor: TCursor): string;
begin
  Result := '';

  case Cursor of
    crCross:      Result := 'crosshair';
    crArrow:      Result := 'arrow';
    crHelp:       Result := 'help';
    crUpArrow:    Result := 'n-resize';
    crHourGlass:  Result := 'wait';
    crDrag:       Result := 'move';
    crHandPoint:  Result := 'pointer';
  end;
end;

function GetPadding(Obj: TfrxCustomMemoView): string;

  function P(a: Extended): string;
  begin
    if a < 1 then
      Result := '0'
    else
      Result := FRLength(a - 1)
  end;

var
  L, T, R, B: string;
begin
  L := '0';
  T := '0';
  R := '0';
  B := '0';

  if Obj.GapX > 0 then
    case Obj.HAlign of
      haLeft:   L := P(Obj.GapX);
      haRight:  R := P(Obj.GapX);
      haCenter, haBlock:
        begin
          L := P(Obj.GapX);
          R := L;
        end
    end;

  if Obj.GapY > 0 then
    case Obj.VAlign of
      vaTop:    T := P(Obj.GapY);
      vaBottom: B := P(Obj.GapY);
    end;

  { It's correct to write

      Result := T + ' ' + R + ' ' + B + ' ' + L

    but it's also possible to write the same in a shorter way, since CSS allows
    simplified "padding" values. }

  if L = R then
    if T = B then
      if L = T then
        if L = '0' then
          Result := '' // no padding, equals 0 0 0 0
        else
          Result := L // equals L L L L
      else
        Result := T + ' ' + L // equals T L T L
    else
      Result := T + ' ' + L + ' ' + B // equals T L B L
  else
    Result := T + ' ' + R + ' ' + B + ' ' + L; // general case T R B L
end;

function GetBorderWidths(Obj: TfrxComponent): TfrxRect;
var
  f: TfrxFrame;
begin
  Result.Left := 0;
  Result.Right := 0;
  Result.Top := 0;
  Result.Bottom := 0;

  if Obj is TfrxView then
  begin
    f := TfrxView(Obj).Frame;

    if ftLeft in f.Typ then
      Result.Left := f.LeftLine.Width;

    if ftRight in f.Typ then
      Result.Right := f.RightLine.Width;

    if ftTop in f.Typ then
      Result.Top := f.TopLine.Width;

    if ftBottom in f.Typ then
      Result.Bottom := f.BottomLine.Width;
  end;
end;

function GetStr(const Id: string): string;
begin
  Result := frxResources.Get(Id)
end;

{ TfrxHTMLDivExportDialog }

procedure TfrxHTMLDivExportDialog.FormCreate(Sender: TObject);

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

procedure TfrxHTMLDivExportDialog.PageNumbersEChange(Sender: TObject);
begin
  PageNumbersRB.Checked := True
end;

procedure TfrxHTMLDivExportDialog.PageNumbersEKeyPress(Sender: TObject; var Key: Char);
begin
  if not (AnsiChar(Key) in ['0'..'9', #9, '-', ',']) then
    Key := #0
end;

procedure TfrxHTMLDivExportDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self)
end;

{ TfrxHTMLDivExport }

constructor TfrxHTMLDivExport.Create(AOwner: TComponent);
begin
  inherited;
  DefaultExt := '.html';

  AttachHandler(ExportAsPicture);
  AttachHandler(ExportGradient);
  AttachHandler(ExportLine);
  AttachHandler(ExportRectangle);
  AttachHandler(ExportPicture);
  AttachHandler(ExportMemo);
  AttachHandler(ExportAllPictures);
  AttachHandler(ExportTaggedView);

  FGauge := TfrxBoundsGauge.Create;
end;

destructor TfrxHTMLDivExport.Destroy;
begin
  FPageStyle.Free; // it's created by the getter of PageStyle
  FGauge.Free;
  inherited
end;

class function TfrxHTMLDivExport.GetDescription: String;
begin
  Result := GetStr('9300')
end;

function TfrxHTMLDivExport.ShowModal: TModalResult;
begin
  Result := mrOk;

  if Assigned(Stream) then
    Exit;

  with TfrxHTMLDivExportDialog.Create(nil) do
  try
    if SlaveExport then
    begin
      OpenCB.Enabled := False;
      OpenCB.State := cbGrayed;
      OpenAfterExport := False;
    end;

    if OverwritePrompt then
      sd.Options := sd.Options + [ofOverwritePrompt];

    sd.FileName := FileName;
    sd.DefaultExt := DefaultExt;
    sd.Filter := GetStr('9301');

    if (FileName = '') and not SlaveExport then
      sd.FileName := ChangeFileExt(
        ExtractFileName(
          frxUnixPath2WinPath(
            Report.FileName)),
          sd.DefaultExt);

    OpenCB.Checked := FOpenAfterExport;

    if PageNumbers <> '' then
    begin
      PageNumbersE.Text     := PageNumbers;
      PageNumbersRB.Checked := True;
    end;

    Result := ShowModal;

    if Result = mrOk then
    begin
      PageNumbers := '';
      CurPage := False;

      if CurPageRB.Checked then
        CurPage := True
      else if PageNumbersRB.Checked then
        PageNumbers := PageNumbersE.Text;

      OpenAfterExport := OpenCB.Checked;

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

function TfrxHTMLDivExport.AddTag(const Name: string): TfrxHTMLItem;
begin
  Result := TfrxHTMLItem.Create(Name);
  FQueue.Push(Result);
end;

procedure TfrxHTMLDivExport.AttachHandler(Handler: TfrxExportHandler);
begin
  SetLength(FHandlers, Length(FHandlers) + 1);
  FHandlers[Length(FHandlers) - 1] := Handler;
end;

procedure TfrxHTMLDivExport.RunExportsChain(Obj: TfrxView);
var
  i: Integer;
begin
  for i := Length(FHandlers) - 1 downto 0 do
    if TfrxExportHandler(FHandlers[i])(Obj) then
      Exit
end;

function TfrxHTMLDivExport.GetAnchor(var Page: string; const Name: string): Boolean;
var
  a: TfrxXMLItem;
begin
  Result := Report.PreviewPages is TfrxPreviewPages;

  if not Result then
    Exit;

  a := (Report.PreviewPages as TfrxPreviewPages).FindAnchor(Name);

  if a = nil then
    Exit;

  Page := a.Prop['page'];
  Result := Page <> '';
end;

function TfrxHTMLDivExport.GetHRef(const URL: string): string;
var
  Page: string;
begin
  if URL = '' then
    Result := ''
  else case URL[1] of
    '@':
      if Multipage then
        Result := Copy(URL, 2, Length(URL)) + '.html'
      else
        Result := '#page' + Copy(URL, 2, Length(URL));

    '#':
      if ExportAnchors and GetAnchor(Page, Copy(URL, 2, Length(URL))) then
      try
        Result := '#page' + IntToStr(StrToInt(Page) + 1)
      except
        Result := ''
      end;

    else
      Result := URL
  end
end;

function TfrxHTMLDivExport.GetPageStyle: TfrxCSSStyle;
begin
  if FPageStyle = nil then
    FPageStyle := TfrxCSSStyle.Create;

  Result := FPageStyle;
end;

function TfrxHTMLDivExport.LockStyle(Style: TfrxCSSStyle): string;
begin
  Result := FCSS.Add(Style)
end;

procedure TfrxHTMLDivExport.SetPicFormat(Fmt: TfrxPictureFormat);
begin
  if Fmt in [pfEMF, pfBMP, pfPNG, pfJPG] then
    FPicFormat := Fmt
  else
    raise Exception.Create('Invalid PictureFormat')
end;

procedure TfrxHTMLDivExport.StartHTML;
begin
  if HTML5 then
    Puts('<!doctype html>')
  else
    Puts('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" ' +
      '"http://www.w3.org/TR/html4/strict.dtd">');

  Puts('<html>');
  Puts('<head>');
  Puts('<title>%s</title>', [UTF8Encode(Title)]);
  Puts('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">');

  if not EmbeddedCSS then
    Puts('<link rel="stylesheet" href="%s">', [GetCSSFileName]);

  Puts('</head>');
  Puts('<body>');
end;

procedure TfrxHTMLDivExport.EndHTML;
begin
  { <style> can only appear inside <head>, but
    there's no other way to embed styles and this
    approach works perfectly for all browsers. }

  if EmbeddedCSS then
  begin
    Puts('<style>');
    FCSS.Save(FCurrentHTMLFile, Formatted);
    Puts('</style>');
  end;

  Puts('</body>');
  Puts('</html>');
end;

function TfrxHTMLDivExport.Start: Boolean;
begin
  {$IFDEF HTML_DEBUG}
  DbgTimerStart(TimerTotal, 'Start-Finish');
  {$ENDIF}

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
    FCurrentHTMLFile := TCachedStream.Create(Stream, False)
  else
    try
      FCurrentHTMLFile := TCachedStream.Create(
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

  with FCSS do
  begin
    Add('div, img, table')['position'] := 'absolute';
    Add('div, td')['overflow'] := 'hidden';

    with Add('tr, td, table, tbody') do
    begin
      Style['text-decoration'] := 'inherit';
      Style['vertical-align'] := 'inherit';
    end;

    with Add('table') do
    begin
      Style['width'] := '100%';
      Style['height'] := '100%';
      Style['border-spacing'] := '0';
    end;

    Add('img')['z-index'] := '1';

    with Add('.nav') do
    begin
      Style['font'] := Format('bold %s Calibri', [FRLength(12)]);
      Style['margin'] := '1em';
    end;

    with Add('.nav a') do
    begin
      Style['text-decoration'] := 'none';
      Style['margin-right'] := '1em';
      Style['color'] := 'black';
    end;

    Add('.nav a:hover')['text-decoration'] := 'underline';

    if FPageStyle <> nil then
      FPageStyle.AssignTo(Add('.page'));
  end;

  FCurrentPage := 0;
  Result := True;
end;

procedure TfrxHTMLDivExport.StartPage(Page: TfrxReportPage; Index: Integer);
begin
  inherited;
  Inc(FCurrentPage);

  if MultiPage then
    FCurrentHTMLFile := TCachedStream.Create(
      TFileStream.Create(
        Format('%s\%d.html', [FileName, FCurrentPage]),
        fmCreate),
      True);

  FQueue := TfrxHTMLItemQueue.Create(FCurrentHTMLFile, Formatted);

  if MultiPage or (FCurrentPage = 1) then
    StartHTML;

  if Multipage and Navigation then
  begin
    if Formatted then
      Puts('<!-- navigation -->');

    Puts('<div class="nav" style="position:relative">');

    if FCurrentPage > 1 then
      Puts(
        '<a href="%d.html" title="Goto page %d">Back</a>',
        [FCurrentPage - 1, FCurrentPage - 1]);

    Puts(
      '<a href="%d.html" title="Goto page %d">Next</a>',
      [FCurrentPage + 1, FCurrentPage + 1]);

    Puts('</div>');
  end;

  if Formatted then
    Puts('<!-- page #%d -->', [Index]);

  Puts(
    '<div id="page%d" class="page" style="position:relative;width:%s;height:%s">',
    [Index + 1, FRLength(Page.Width), FRLength(Page.Height)]);

  if not HTML5 then
    Puts('<a name="page%d"></a>', [Index + 1]);
end;

procedure TfrxHTMLDivExport.ExportObject(Obj: TfrxComponent);
begin
  {$IFDEF HTML_DEBUG}
  DbgTimerStart(TimerExport, 'ExportObject');
  {$ENDIF}

  if Obj is TfrxView then
    RunExportsChain(Obj as TfrxView);

  {$IFDEF HTML_DEBUG}
  DbgTimerStop(TimerExport);
  {$ENDIF}

  inherited
end;

procedure TfrxHTMLDivExport.FinishPage(Page: TfrxReportPage; Index: Integer);
begin
  FQueue.Free;

  Puts('</div>'); // <div class="page">...</div>

  if MultiPage then
    EndHTML;

  if MultiPage then
    FCurrentHTMLFile.Free;

  inherited
end;

procedure TfrxHTMLDivExport.Finish;
begin
  if not MultiPage then
    EndHTML;

  if not MultiPage then
    FCurrentHTMLFile.Free;

  if not Assigned(Stream) and not EmbeddedCSS then
    SaveCSS(GetCSSFilePath);

  FPictures.Free;
  FCSS.Free;

  {$IFDEF HTML_DEBUG}
  DbgTimerStop(TimerTotal);
  DbgPrint(AnsiString(DbgTimerInfo));
  {$ENDIF}

  if OpenAfterExport and not Assigned(Stream) then
    ShellExecute(0, 'open', PChar(FileName), nil, nil, SW_SHOW)
end;

function TfrxHTMLDivExport.ExportAllPictures(Obj: TfrxView): Boolean;
begin
  Result := AllPictures and ExportAsPicture(Obj)
end;

function TfrxHTMLDivExport.ExportAsPicture(Obj: TfrxView): Boolean;
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
    {$IFDEF HTML_DEBUG}
    on e: Exception do
      DbgPrint(
        '%s.Draw (unit %s) raised exception (%s)'#10,
        [Obj.ClassName, Obj.UnitName, e.Message])
    {$ENDIF}
  end;

  PutImg(Obj, Pic.Release, False);
  Pic.Free;
  Result := True;
end;

function TfrxHTMLDivExport.ExportGradient(Obj: TfrxView): Boolean;

  procedure FillProps(Style: TfrxCSSStyle; Grad: TfrxGradientView);
  var
    s: string;
  begin
    if HTML5 then
    begin
      s := '';

      with Grad do
        case Style of
          gsHorizontal: s := Format(
              'linear-gradient(left, %s, %s)',
              [GetColor(BeginColor), GetColor(EndColor)]);

          gsHorizCenter: s := Format(
              'linear-gradient(left, %s, %s, %s)',
              [GetColor(BeginColor), GetColor(EndColor), GetColor(BeginColor)]);

          gsVertical: s := Format(
              'linear-gradient(%s, %s)',
              [GetColor(BeginColor), GetColor(EndColor)]);

          gsVertCenter: s := Format(
              'linear-gradient(%s, %s, %s)',
              [GetColor(BeginColor), GetColor(EndColor), GetColor(BeginColor)]);

          gsRectangle, gsElliptic: s := Format(
              'radial-gradient(ellipse, %s, %s)',
              [GetColor(EndColor), GetColor(BeginColor)]);
        end;

      if s <> '' then
      begin
        Style['background'] := s;
        Style['background'] := '-webkit-' + s;
        Style['background'] := '-moz-' + s;
        Style['background'] := '-o-' + s;
      end
    end
  end;

begin
  Result := Obj is TfrxGradientView;

  if Result then
    with CreateDiv(Obj) do
      with TfrxCSSStyle.Create do
      begin
        FillProps(This, Obj as TfrxGradientView);

        if Count = 0 then
          Free
        else
          AddCSSClass(LockStyle(This))
      end;
end;

function TfrxHTMLDivExport.ExportLine(Obj: TfrxView): Boolean;
begin
  Result := (Obj is TfrxLineView)
    and (Min(Obj.Width, Obj.Height) = 0)  // horizontal or vertical lines
    and (CreateDiv(Obj) <> nil)
end;

function TfrxHTMLDivExport.ExportMemo(Obj: TfrxView): Boolean;

  procedure FillProps(Style: TfrxCSSStyle; Obj: TfrxCustomMemoView);
  begin
    with Style do
    begin
      Style['text-align'] := GetHAlign(Obj.HAlign);
      Style['cursor'] := GetCursor(Obj.Cursor);

      { It's ok to ignore vaTop and vaCenter alignments.
        For vaTop a <div> is created which has the top alignment
        by default; for vaCenter a <table> is created which has
        the middle alignment by default. }

      Style['vertical-align'] := GetVAlign(Obj.VAlign);

      if Obj.ParagraphGap > 0 then
        Style['text-indent'] := FRLength(Obj.ParagraphGap);

      if Obj.CharSpacing > 0 then
        Style['letter-spacing'] := FRLength(Obj.CharSpacing);
    end;
  end;

var
  Memo: TfrxMemoView;
  Text, Padding: string;
  InnerTag: TfrxHTMLItem;
  IsEmpty: Boolean;
begin
  Result := False;

  if Obj is TfrxMemoView then
    Memo := Obj as TfrxMemoView
  else
    Exit;

  Text := Trim(Memo.Lines.Text);
  IsEmpty := Memo.HideZeros and (Text = '0') or (Text = '');

  with CreateDiv(Memo) do
  begin
    with TfrxCSSStyle.Create do
    begin
      FillProps(This, Memo);
      AddCSSClass(LockStyle(This));
    end;

    if not IsEmpty then
    begin
      if Memo.VAlign = vaTop then
        InnerTag := This
      else
        with Add('table') do
        begin
          if not HTML5 then
          begin
            Prop['border'] := '0';
            Prop['cellpadding'] := '0';
            Prop['cellspacing'] := '0';
          end;

          InnerTag := Add('tr').Add('td');
        end;

      with InnerTag do
      begin
        if Memo.AllowHTMLTags then
          Value := FilterHTML(Text)
        else
          Value := EscapeText(Text);

        Padding := GetPadding(Memo);

        if Padding <> '' then
          with TfrxCSSStyle.Create do
          begin
            //Style['padding'] := Padding;
            AddCSSClass(LockStyle(This));
          end;
      end;
    end;
  end;

  Result := True;
end;

function TfrxHTMLDivExport.ExportPicture(Obj: TfrxView): Boolean;
var
  Pic: TGraphic;
  Typ: TfrxFrameTypes;
begin
  Result := False;

  if Obj is TfrxPictureView then
    Pic := (Obj as TfrxPictureView).Picture.Graphic
  else
    Exit;

  CreateDiv(Obj);

  if UnifiedPictures and (Pic <> nil) then
  begin
    Typ := Obj.Frame.Typ;
    Obj.Frame.Typ := [];
    ExportAsPicture(Obj);
    Obj.Frame.Typ := Typ;
  end
  else if Pic <> nil then
    PutImg(Obj, Pic, True);

  Result := True;
end;

function TfrxHTMLDivExport.ExportRectangle(Obj: TfrxView): Boolean;
var
  Shape: TfrxShapeView;
begin
  Result := False;

  if Obj is TfrxShapeView then
    Shape := Obj as TfrxShapeView
  else
    Exit;

  Result := Shape.Shape in [skRectangle, skRoundRectangle];

  if Result then
    with CreateDiv(Obj) do
      if HTML5 and (Shape.Shape = skRoundRectangle) then
        with TfrxCSSStyle.Create do
        begin
          Style['border-radius'] := GetBorderRadius(Shape.Curve);
          AddCSSClass(LockStyle(This));
        end;
end;

function TfrxHTMLDivExport.ExportTaggedView(Obj: TfrxView): Boolean;
begin
  Result := (PictureTag <> 0) and (Obj.Tag = PictureTag) and ExportAsPicture(Obj)
end;

procedure TfrxHTMlDivExport.PutImg(Obj: TfrxView; Pic: TGraphic; WriteSize: Boolean);
begin
  { If the HTML is written to a specified stream (maybe a TMemoryStream),
    additional files with pictures cannot be created. }

  if Assigned(Stream) and not EmbeddedPictures then
    Exit;

  PutsRaw('<img style="');

  PutsRaw('left:' + AnsiString(FRLength(Obj.AbsLeft)));
  PutsRaw(';top:' + AnsiString(FRLength(Obj.AbsTop)));

  if WriteSize then
  begin
    PutsRaw(';width:' + AnsiString(FRLength(
      Round(Obj.AbsLeft + Obj.Width) - Round(Obj.AbsLeft))));

    PutsRaw(';height:' + AnsiString(FRLength(
      Round(Obj.AbsTop + Obj.Height) - Round(Obj.AbsTop))));
  end;

  Puts('" src="');

  if not EmbeddedPictures then
    PutsRaw(AnsiString(FPictures.Save(Pic)))
  else
  begin
    PutsRaw(AnsiString(Format('data:%s;base64,', [TfrxPictureStorage.GetInfo(Pic).Mimetype])));

    with TBase64Encoder.Create(FCurrentHTMLFile) do
    begin
      Pic.SaveToStream(This);
      Free;
    end;
  end;

  Puts('">');
end;

procedure TfrxHTMLDivExport.SaveCSS(const FileName: string);
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

procedure TfrxHTMLDivExport.PutsRaw(const s: AnsiString);
begin
  if s <> '' then
    FCurrentHTMLFile.Write(s[1], Length(s))
end;

procedure TfrxHTMLDivExport.PutsA(const s: AnsiString);
begin
  PutsRaw(s);

  if Formatted then
    PutsRaw(#13#10)
end;

procedure TfrxHTMLDivExport.Puts(const s: string);
begin
  PutsA(AnsiString(s))
end;

procedure TfrxHTMLDivExport.Puts(const Fmt: string; const Args: array of const);
begin
  Puts(Format(Fmt, Args))
end;

function TfrxHTMLDivExport.CreateDiv(Obj: TfrxView): TfrxHTMLItem;

  procedure FillProps(Style: TfrxCSSStyle; Font: TFont); overload;
  begin
    with Style do
    begin
      Style['font'] := GetFont(Font);
      Style['text-decoration'] := GetTextDecoration(Font.Style);
    end
  end;

  procedure FillProps(Style: TfrxCSSStyle; Frame: TfrxFrame); overload;
  var
    L, T, R, B: string;
  begin
    L := BoolStr(ftLeft   in Frame.Typ, GetFrameLineStyle(Frame.LeftLine));
    T := BoolStr(ftTop    in Frame.Typ, GetFrameLineStyle(Frame.TopLine));
    R := BoolStr(ftRight  in Frame.Typ, GetFrameLineStyle(Frame.RightLine));
    B := BoolStr(ftBottom in Frame.Typ, GetFrameLineStyle(Frame.BottomLine));

    if (L <> '') and (L = T) and (L = R) and (L = B) then
      Style['border'] := L
    else
    begin
      Style['border-left']    := L;
      Style['border-top']     := T;
      Style['border-right']   := R;
      Style['border-bottom']  := B;
    end;

    if Frame.DropShadow and HTML5 then
      with Style do
        Style['box-shadow'] := FRLength(Frame.ShadowWidth) + ' ' +
          FRLength(Frame.ShadowWidth) + ' ' + FRLength(Frame.ShadowWidth) + ' ' +
          GetColor(Frame.ShadowColor);
  end;

  procedure FillProps(Style: TfrxCSSStyle; Obj: TfrxView); overload;
  begin
    with Style do
    begin
      if Obj.Color <> clNone then
        Style['background'] := GetColor(Obj.Color);

      Style['color'] := GetColor(Obj.Font.Color);

      FillProps(This, Obj.Font);
      FillProps(This, Obj.Frame);

      if Obj is TfrxShapeView then
        Style['border'] := GetFrameLineStyle(
          Obj.Frame.Width,
          Obj.Frame.Style,
          Obj.Frame.Color);
    end
  end;

  function GetBounds(Obj: TfrxView): TRect;
  begin
    Result.Left := Round(Obj.AbsLeft);
    Result.Top := Round(Obj.AbsTop);
    Result.Right := Round(Obj.AbsLeft + Obj.Width);
    Result.Bottom := Round(Obj.AbsTop + Obj.Height);
  end;

var
  Borders: TfrxRect;
  Bounds: TRect;
begin
  {$IFDEF HTML_DEBUG}
  DbgTimerStart(TimerDiv, 'CreateDiv');
  {$ENDIF}

  Borders := GetBorderWidths(Obj);
  Bounds := GetBounds(Obj);

  Result := AddTag('div');

  with Result do
  begin
    FGauge.Obj := Obj;

    Left    := FGauge.Bounds.Left;
    Top     := FGauge.Bounds.Top;
    Width   := FGauge.InnerWidth;
    Height  := FGauge.InnerHeight;

    with TfrxCSSStyle.Create do
    begin
      FillProps(This, Obj);
      AddCSSClass(LockStyle(This));
    end;

    if Obj.ShowHint then
      Prop['title'] := Obj.Hint;

    if Obj.URL <> '' then
      with Add('a') do
      begin
        Style['width']    := '100%';
        Style['height']   := '100%';
        Style['position'] := 'absolute';

        Prop['href'] := GetHRef(Obj.URL);
      end;
  end;

  {$IFDEF HTML_DEBUG}
  DbgTimerStop(TimerDiv);
  {$ENDIF}
end;

function TfrxHTMLDivExport.GetCSSFileName: string;
begin
  if Multipage then
    Result := 'styles.css'
  else
    Result := ExtractFileName(FileName) + '.css'
end;

function TfrxHTMLDivExport.GetCSSFilePath: string;
begin
  if Multipage then
    Result := FileName + '\' + GetCSSFileName
  else
    Result := ExtractFileDir(FileName) + '\' + GetCSSFileName
end;

function TfrxHTMLDivExport.FilterHTML(const Text: string): string;
type
  TRange = record
    First, Last: Integer;
  end;

var
  Tags: TStrings;

  function FindChar(From: Integer; c: Char): Integer;
  begin
    for Result := From to Length(Text) do
      if Text[Result] = c then
        Exit;

    Result := Length(Text)
  end;

  function SubStr(a, b: Integer): string;
  begin
    Result := Copy(Text, a, b - a + 1)
  end;

  function Filter(const s: string): string;
  begin
    Result := TfrxHTMLItem.EscapeText(s)
  end;

  function PopTag: string;
  begin
    Result := Tags[Tags.Count - 1];
    Tags.Delete(Tags.Count - 1);
  end;

  function PushTag(s: string): string;
  begin
    Result := '';
    s := Trim(s);

    if (Length(s) < 2) or (s[1] <> '<') or (s[Length(s)] <> '>') then
      Exit;

    s := Copy(s, 2, Length(s) - 2);

    if s[1] = '/' then
      if (Tags.Count = 0) or (Tags[Tags.Count - 1] <> Copy(s, 2, Length(s) - 2)) then
        Exit
      else
        Tags.Delete(Tags.Count - 1)
    else if (s = 'u') or (s = 'b') or (s = 'i') then
      Tags.Add(s)
    else
      Exit;

    Result := '<' + s + '>'
  end;

var
  r: TRange;
  Tag, s: string;
begin
  Result := '';
  Tags := TStringList.Create;
  r.First := 1;

  while r.First <= Length(Text) do
  begin
    if Text[r.First] = '<' then
    begin
      r.Last := FindChar(r.First + 1, '>');
      s := SubStr(r.First, r.Last);
      Tag := PushTag(s);

      if Tag = '' then
        Result := Result + Filter(s)
      else
        Result := Result + Tag
    end
    else
    begin
      r.Last := FindChar(r.First + 1, '<');

      if Text[r.Last] = '<' then
        Dec(r.Last);

      s := SubStr(r.First, r.Last);
      Result := Result + Filter(s)
    end;

    r.First := r.Last + 1
  end;

  while Tags.Count > 0 do
    Result := Result + '</' + PopTag + '>';

  Tags.Free
end;

{ TfrxHTMLItem }

constructor TfrxHTMLItem.Create(const Name: string);
begin
  FName := Name;
  FKeys := TStringList.Create;
  FValues := TStringList.Create;
  FChildren := TObjList.Create;
end;

destructor TfrxHTMLItem.Destroy;
begin
  FKeys.Free;
  FValues.Free;
  FChildren.Free;
  FStyle.Free;
  inherited;
end;

function TfrxHTMLItem.This: TfrxHTMLItem;
begin
  Result := Self
end;

function TfrxHTMLItem.GetStyle: TfrxCSSStyle;
begin
  if FStyle = nil then
    FStyle := TfrxCSSStyle.Create;

  Result := FStyle;
end;

procedure TfrxHTMLItem.SetTop(a: Extended);
begin
  FTopSet := True;
  FTop := a;
end;

procedure TfrxHTMLItem.SetLeft(a: Extended);
begin
  FLeftSet := True;
  FLeft := a;
end;

procedure TfrxHTMLItem.SetWidth(a: Extended);
begin
  FWidthSet := True;
  FWidth := a;
end;

procedure TfrxHTMLItem.SetHeight(a: Extended);
begin
  FHeightSet := True;
  FHeight := a;
end;

function TfrxHTMLItem.Add(const Tag: string): TfrxHTMLItem;
begin
  Result := TfrxHTMLItem.Create(Tag);
  FChildren.Add(Result);
end;

function TfrxHTMLItem.Add(Item: TfrxHTMLItem): TfrxHTMLItem;
begin
  FChildren.Add(Item);
  Result := Item;
end;

procedure TfrxHTMLItem.AddCSSClass(const s: string);
begin
  {$IFDEF HTML_DEBUG}
  if s = '' then
    raise Exception.Create('Empty CSS class name is not allowed');
  {$ENDIF}

  if FClass = '' then
    FClass := s
  else
    FClass := FClass + ' ' + s
end;

class function TfrxHTMLItem.HasSpecialChars(const s: string): Boolean;
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

class function TfrxHTMLItem.EscapeText(const s: string): string;
var
  Res: string;

  procedure Put(c: Char); overload;
  begin
    Res := Res + c
  end;

  procedure Put(s: string); overload;
  begin
    Res := Res + s
  end;

var
  i: Integer;
begin
  if not HasSpecialChars(s) then
  begin
    Result := s;
    Exit;
  end;

  Res := '';

  for i := 1 to Length(s) do
    case s[i] of
      '<': Put('&lt;');
      '>': Put('&gt;');
      '&': Put('&amp;');
      #10: Put('<br>');
      #13: {ignore this symbol};
      else
        if Word(s[i]) < 32 then
          Put('&#' + IntToStr(Word(s[i])) + ';')
        else
          Put(s[i])
    end;

  Result := Res
end;

class function TfrxHTMLItem.EscapeAttribute(const s: string): string;
var
  Res: string;

  procedure Put(c: Char); overload;
  begin
    Res := Res + c
  end;

  procedure Put(s: string); overload;
  begin
    Res := Res + s
  end;

var
  i: Integer;
begin
  if not HasSpecialChars(s) then
  begin
    Result := s;
    Exit;
  end;

  Res := '';

  for i := 1 to Length(s) do
    case s[i] of
      '<': Put('&lt;');
      '>': Put('&gt;');
      '&': Put('&amp;');
      #13: {ignore this symbol: W3C does not allow it in attributes};
      else
        if Word(s[i]) < 32 then
          Put('&#' + IntToStr(Word(s[i])) + ';')
        else
          Put(s[i])
    end;

  Result := Res
end;

procedure TfrxHTMLItem.Save(Stream: TStream; Formatted: Boolean);

  procedure Puts(const s: AnsiString); overload;
  begin
    if s <> '' then
      Stream.Write(s[1], Length(s))
  end;

  {procedure Puts(const s: string); overload;
  begin
    Puts(AnsiString(s))
  end;}

  procedure EndLine;
  begin
    Puts(AnsiString(#13#10))
  end;

  function DontNeedEndLine(const t: string): Boolean;
  begin
    Result := (t = 'a') or (t = 'tr') or (t = 'td')
  end;

  function IsShortTag(const t: string): Boolean;
  begin
    Result := (t = 'tr') or (t = 'td') or (t = 'p') or (t = 'img')
  end;

  procedure WriteDim;
  begin
    if FTopSet then
      Style['top'] := FRLength(Top);

    if FLeftSet then
      Style['left'] := FRLength(Left);

    if FWidthSet then
      Style['width'] := FRLength(Round(Left + Width) - Round(Left));

    if FHeightSet then
      Style['height'] := FRLength(Round(Top + Height) - Round(Top));

    if FStyle <> nil then
      Puts(AnsiString(' style="' + FStyle.Text + '"'));
  end;

var
  ShortTag: Boolean;
  i: Integer;
begin
  {$IFDEF HTML_DEBUG}
  DbgTimerStart(TimerHTMLSave, 'HTML.Save');
  {$ENDIF}

  ShortTag := IsShortTag(FName);

  Puts('<');
  Puts(AnsiString(FName));

  for i := 0 to FKeys.Count - 1 do
    Puts(AnsiString(' ' + FKeys[i] + '="' + string(UTF8Encode(EscapeAttribute(FValues[i]))) + '"'));

  if FClass <> '' then
    Puts(AnsiString(' class="' + FClass + '"'));

  WriteDim;

  Puts('>');

  if Formatted and not DontNeedEndLine(FName) then
    EndLine;

  for i := 0 to FChildren.Count - 1 do
    TfrxHTMLItem(FChildren[i]).Save(Stream, Formatted);

  if FValue <> '' then
  begin
    Puts(AnsiString(UTF8Encode(FValue)));

    if Formatted then
      EndLine;
  end;

  if not ShortTag then
  begin
    Puts(AnsiString('</' + FName + '>'));

    if Formatted then
      EndLine;
  end;

  {$IFDEF HTML_DEBUG}
  DbgTimerStop(TimerHTMLSave);
  {$ENDIF}
end;

procedure TfrxHTMLItem.SetProp(Index: string; const Value: string);
begin
  {$IFDEF HTML_DEBUG}
  if FKeys.IndexOf(Index) >= 0 then
    raise Exception.CreateFmt('Key %s already exists', [Index]);

  { TfrxHTMLItem.Style provides access to the "style" attribute of the html tag.
    CSS classes must be added via TfrxHTMLItem.AddCSSClass. }

  if (Index = 'style') or (Index = 'class') then
    raise Exception.CreateFmt(
      '"%s" attribute must be accessed via Style property',
      [Index]);
  {$ENDIF}

  FKeys.Add(Index);
  FValues.Add(Value);
end;

{ TfrxHTMLItemQueue }

constructor TfrxHTMLItemQueue.Create(Stream: TStream; Formatted: Boolean);
begin
  FStream := Stream;
  FFormatted := Formatted;
  SetQueueLength(10);
end;

destructor TfrxHTMLItemQueue.Destroy;
begin
  Flush;
  inherited
end;

procedure TfrxHTMLItemQueue.Flush;
var
  i: Integer;
begin
  for i := 0 to FUsed - 1 do
    with FQueue[i] do
    begin
      Save(FStream, FFormatted);
      Free;
    end;

  FUsed := 0
end;

procedure TfrxHTMLItemQueue.Push(Item: TfrxHTMLItem);
begin
  if FUsed = Length(FQueue) then
    Flush;

  FQueue[FUsed] := Item;
  Inc(FUsed);
end;

procedure TfrxHTMLItemQueue.SetQueueLength(n: Integer);
begin
  if FUsed > 0 then
    raise Exception.Create('Cannot resize a nonempty queue');

  SetLength(FQueue, n)
end;

{ TfrxBoundsGauge }

procedure TfrxBoundsGauge.AddBounds(r: TRect);
begin
  if not FBoundsSet then
    FBounds := r
  else
    with FBounds do
    begin
      Left    := Min(Left,    r.Left);
      Right   := Max(Right,   r.Right);
      Top     := Min(Top,     r.Top);
      Bottom  := Max(Bottom,  r.Bottom);
    end;

  FBoundsSet := True;
end;

procedure TfrxBoundsGauge.BeginDraw;
begin
  with Obj do
  begin
    FX := Round(AbsLeft);
    FY := Round(AbsTop);
    FX1 := Round(AbsLeft + Width);
    FY1 := Round(AbsTop + Height);

    if Frame.DropShadow then
    begin
      FX1 := FX1 - Round(Frame.ShadowWidth);
      FY1 := FY1 - Round(Frame.ShadowWidth);
    end;

    FDX := FX1 - FX;
    FDY := FY1 - FY;

    FFrameWidth := Round(Frame.Width);
  end;
end;

procedure TfrxBoundsGauge.DrawBackground;
begin
  with FObj do
  begin
    AddBounds(Rect(FX, FY, FX1 - 1, FY1 - 1));

    if BrushStyle <> bsSolid then
      AddBounds(Rect(FX, FY, FX1, FY1));
  end;
end;

procedure TfrxBoundsGauge.DrawFrame;
var
  d, PenWidth: Integer;

  procedure Line(x, y, x1, y1: Integer;
    Line: TfrxFrameLine; Typ: TfrxFrameType;
    gap1, gap2: Boolean);
  var
    g1, g2, fw: Integer;

  begin
    fw := Round(Line.Width);

    if Line.Style in [fsSolid, fsDouble] then
    begin
      if gap1 then g1 := 0 else g1 := 1;
      if gap2 then g2 := 0 else g2 := 1;

      if Typ in [ftTop, ftBottom] then
      begin
        x := x + (fw * g1 div 2);
        x1 := x1 - (fw * g2 div 2);
      end
      else
      begin
        y := y + (fw * g1 div 2);
        y1 := y1 - (fw * g2 div 2);
      end;
    end;

    DrawLine(x, y, x1, y1, fw, Typ);
  end;

  procedure SetPen(Line: TfrxFrameLine);
  begin
    if Line.Style in [fsSolid, fsDouble] then
      PenWidth := Round(Line.Width)
    else
      PenWidth := 1;
  end;

begin
  with Obj do
    if (Frame.Typ <> []) and (Frame.Color <> clNone) and (Frame.Width <> 0) then
    begin
      if ftLeft in Frame.Typ then
      begin
        SetPen(Frame.LeftLine);

        if (PenWidth = 2) and (Frame.Style <> fsSolid) then
          d := 1
        else
          d := 0;

        Line(FX, FY - d, FX, FY1,
          Frame.LeftLine, ftLeft,
          ftTop in Frame.Typ, ftBottom in Frame.Typ);
      end;

      if ftRight in Frame.Typ then
      begin
        SetPen(Frame.RightLine);

        Line(FX1, FY, FX1, FY1,
          Frame.RightLine, ftRight,
          ftTop in Frame.Typ, ftBottom in Frame.Typ);
      end;

      if ftTop in Frame.Typ then
      begin
        SetPen(Frame.TopLine);

        Line(FX, FY, FX1, FY,
          Frame.TopLine, ftTop,
          ftLeft in Frame.Typ, ftRight in Frame.Typ);
      end;

      if ftBottom in Frame.Typ then
      begin
        SetPen(Frame.BottomLine);

        if (PenWidth = 1) and (Frame.Style <> fsSolid) then
          d := 1
        else
          d := 0;

        Line(FX, FY1, FX1 + d, FY1,
          Frame.BottomLine, ftBottom,
          ftLeft in Frame.Typ, ftRight in Frame.Typ);
      end;
    end;
end;

procedure TfrxBoundsGauge.DrawLine(x1, y1, x2, y2, w: Integer; Side: TfrxFrameType);
var
  LineBounds: TRect;
begin
  with LineBounds do
  begin
    Left    := x1 - w div 2;
    Top     := y1 - w div 2;
    Right   := x2 + w - w div 2 - 1;
    Bottom  := y2 + w - w div 2 - 1;
  end;

  AddBounds(LineBounds);

  with FBorders do
    case Side of
      ftLeft:   Left    := w;
      ftRight:  Right   := w;
      ftTop:    Top     := w;
      ftBottom: Bottom  := w;
    end;
end;

function TfrxBoundsGauge.GetInnerHeight: Integer;
begin
  if FBoundsSet then
    Result := FBounds.Bottom - FBounds.Top + 1
  else
    Result := 0;

  Dec(Result, FBorders.Bottom + FBorders.Top);
end;

function TfrxBoundsGauge.GetInnerWidth: Integer;
begin
  if FBoundsSet then
    Result := FBounds.Right - FBounds.Left + 1
  else
    Result := 0;

  Dec(Result, FBorders.Right + FBorders.Left);
end;

procedure TfrxBoundsGauge.SetObj(Obj: TfrxView);
begin
  FObj := Obj;
  FBoundsSet := False;
  FBounds := Rect(0, 0, 0, 0);
  FBorders := Rect(0, 0, 0, 0);

  { Simulates TfrxView.Draw, but computes bounds and borders
    instead of actual drawing. }

  BeginDraw;
  DrawBackground;
  DrawFrame;
end;

{ TfrxHTML5DivExport }

constructor TfrxHTML5DivExport.Create(AOwner: TComponent);
begin
  inherited;

  HTML5             := True;  // use HTML5 features
  PictureFormat     := pfPNG; // save pictures as PNG
  UnifiedPictures   := True;  // convert all pictures to PNG
  Multipage         := False; // export all report into one HTML page
  ExportAnchors     := True;  // export page anchors
  EmbeddedPictures  := True;  // embed pictures into HTML
  EmbeddedCSS       := True;  // embed CSS into HTML

  { Make a rounded border around each page }

  PageStyle['border']         := '1mm solid orange';  // CSS1 style
  PageStyle['margin']         := '5mm';               // cSS1 style
  PageStyle['box-shadow']     := '3mm 3mm 3mm gray';  // CSS3 style
  PageStyle['border-radius']  := '2mm';               // CSS3 style
end;

class function TfrxHTML5DivExport.GetDescription: String;
begin
  Result := GetStr('9303')
end;

{ TfrxHTML4DivExport }

constructor TfrxHTML4DivExport.Create(AOwner: TComponent);
begin
  inherited;

  PictureFormat     := pfPNG; // save pictures as PNG
  UnifiedPictures   := True;  // convert all pictures to PNG
  Multipage         := False; // export all report into one HTML page
  ExportAnchors     := True;  // export page anchors
end;

class function TfrxHTML4DivExport.GetDescription: String;
begin
  Result := GetStr('9304')
end;

end.
