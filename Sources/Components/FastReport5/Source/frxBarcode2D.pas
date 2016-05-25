{ ****************************************** }
{ }
{ FastReport v5.0 }
{ Barcode Add-in object }
{ }
{ Copyright (c) 1998-2014 }
{ by Alexander Tzyganenko, }
{ Fast Reports Inc. }
{ }
{ ****************************************** }


unit frxBarcode2D;

interface

{$I frx.inc}

uses
{$IFDEF FPC}
  LCLType, LMessages, LazHelper, LCLIntf,
{$ELSE}
  Windows, Messages,
{$ENDIF}
  SysUtils, Classes, Graphics, Types, Controls,
  Forms, Dialogs,
  StdCtrls, Menus, frxClass, ExtCtrls,frxdesgn,frxBarcodePDF417,frxBarcodeDataMatrix, frxBarcodeQR, frxBarcode2DBase,frxBarcodeProperties,
  Variants;

type

// “ипы штрих-кодов /////////////////////////////////////////////////////////////////////////////////////////

  TfrxBarcode2DType =
  (
      bcCodePDF417,
      bcCodeDataMatrix,
      bcCodeQR
  );

    TfrxBarcode2DView = class(TfrxView)
    private

        FBarCode: TfrxBarcode2DBase;
        FBarType: TfrxBarcode2DType;
        FHAlign: TfrxHAlign;
        FProp : TfrxBarcode2DProperties;                            // класс содержит свойства дл€ текущего типа баркода
        FExpression: String;
        procedure SetZoom(z: Extended);
        function GetZoom : extended;
        procedure SetRotation(v : integer);
        function GetRotation: Integer;
        procedure SetShowText( v : boolean);
        function GetShowText : boolean;
        procedure SetText( v : String);
        function GetText : string;
        procedure SetFontScaled(v : Boolean);
        function GetFontScaled : boolean;
        procedure SetErrorText(v : string);
        function GetErrorText : string;
        procedure SetQuietZone(v : integer);
        function GetQuietZone : integer;

        procedure SetProp (v : TfrxBarcode2DProperties);
        procedure SetBarType( v : TfrxBarcode2DType);

    public

        constructor Create(AOwner: TComponent); override;
        constructor DesignCreate(AOwner: TComponent; Flags: Word); override;
        destructor Destroy; override;
        procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY : Extended); override;
        class function GetDescription: String; override;
        procedure GetData; override;
        function GetRealBounds: TfrxRect; override;

  published
        property Expression: String read FExpression write FExpression;
        property BarType: TfrxBarcode2DType read FBarType write SetBarType;
        property BarProperties : TfrxBarcode2DProperties read FProp write SetProp;
        property BrushStyle;
        property Color;
        property Cursor;
        property DataField;
        property DataSet;
        property DataSetName;
        property Frame;
        property HAlign: TfrxHAlign read FHAlign write FHAlign default haLeft;
        property Rotation: Integer read GetRotation write SetRotation;
        property ShowText: Boolean read GetShowText write SetShowText;
        property TagStr;
        property Text: String read GetText write SetText;
        property URL;
        property Zoom: Extended read GetZoom write SetZoom;
        property Font;
        property FontScaled: Boolean read GetFontScaled write SetFontScaled;
        property ErrorText  : string read GetErrorText write SetErrorText;
        property QuietZone : integer read GetQuietZone write SetQuietZone;

    end;

implementation

uses
{$IFNDEF NO_EDITORS}
    frxBarcodeEditor,
{$ENDIF}
    frxRes, frxUtils, frxDsgnIntf, frxBarcode2DRTTI;

type
  TfrxBarcode2DPropertiesProperty = class(TfrxClassProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
  end;


    { TfrxBarcode2DView }

constructor TfrxBarcode2DView.Create(AOwner: TComponent);
begin
    inherited;
    FBarCode := TfrxBarcodePDF417.Create;
    FBarType := bcCodePDF417;
    FBarCode.Font.Assign(Font);
    Width := 0;
    Height := 0;
    FProp := TfrxPDF417Properties.Create;
    FProp.SetWhose(FBarcode);
end;

constructor TfrxBarCode2DView.DesignCreate(AOwner: TComponent; Flags: Word);
begin
  inherited;
  BarType := TfrxBarcode2DType(Flags);
end;

destructor TfrxBarcode2DView.Destroy;
begin
    FBarCode.Free;
    FProp.free;
    inherited Destroy;
end;

procedure TfrxBarcode2DView.SetProp (v : TfrxBarcode2DProperties);
begin
    FProp.Assign(v);
end;

procedure TfrxBarcode2DView.SetBarType( v : TfrxBarcode2DType);
begin
    if FBarType = v then exit;
    // в зависимости от типа баркода создаем экземпл€р свойств
    if v = bcCodePDF417 then
    begin
        FBarType := v;
        FBarCode.free;
        FBarCode := TfrxBarcodePDF417.Create;
        FProp.free;
        FProp := TfrxPDF417Properties.create;
        FProp.SetWhose(FBarCode);
        if (Tfrxcomponent(self).Report <> nil) and (tfrxcomponent(self).Report.Designer <> nil) then
          TfrxCustomDesigner(tfrxcomponent(self).report.designer ).UpdateInspector;
    end
    else
        if v = bcCodeDataMatrix then
        begin
            FBarType := v;
            FBarCode.free;
            FBarCode := TfrxBarcodeDataMatrix.Create;
            FProp.free;
            FProp := TfrxDataMatrixProperties.create;
            FProp.SetWhose(FBarCode);
            if (Tfrxcomponent(self).Report <> nil) and (tfrxcomponent(self).Report.Designer <> nil) then
              TfrxCustomDesigner(tfrxcomponent(self).report.designer ).UpdateInspector;
        end
    else
        if v = bcCodeQR then
        begin
            FBarType := v;
            FBarCode.free;
            FBarCode := TfrxBarcodeQR.Create;
            FProp.free;
            FProp := TfrxQRProperties.create;
            FProp.SetWhose(FBarCode);
            if (Tfrxcomponent(self).Report <> nil) and (tfrxcomponent(self).Report.Designer <> nil) then
              TfrxCustomDesigner(tfrxcomponent(self).report.designer ).UpdateInspector;
        end;
end;

procedure TfrxBarcode2DView.SetZoom(z: Extended);
begin
    FBarcode.Zoom := z;
end;

// возвращаютс€ и устанавливаютс€ соответствующие свойства в FBarcode
function TfrxBarcode2DView.GetZoom : extended;begin result:=FBarcode.Zoom;end;
procedure TfrxBarcode2DView.SetRotation(v : integer);begin FBarcode.Rotation := v; end;
function TfrxBarcode2DView.GetRotation: Integer;begin result:=FBarcode.Rotation;end;
procedure TfrxBarcode2DView.SetShowText( v : boolean);begin FBarcode.ShowText := v; end;
function TfrxBarcode2DView.GetShowText : boolean;begin result:=FBarcode.ShowText;end;
procedure TfrxBarcode2DView.SetText( v : String);begin FBarcode.Text := v; end;
function TfrxBarcode2DView.GetText : string;begin result:=FBarcode.Text;end;
procedure TfrxBarcode2DView.SetFontScaled(v : Boolean);begin FBarcode.FontScaled := v; end;
function TfrxBarcode2DView.GetFontScaled : boolean;begin result:=FBarcode.FontScaled;end;
procedure TfrxBarcode2DView.SetErrorText(v : string);begin FBarcode.ErrorText := v;end;
function TfrxBarcode2DView.GetErrorText : string;begin result:=FBarcode.ErrorText;end;
procedure TfrxBarcode2DView.SetQuietZone(v : integer);begin FBarcode.QuietZone:=v; end;
function TfrxBarcode2DView.GetQuietZone : integer; begin result := FBarcode.QuietZone; end;

procedure TfrxBarcode2DView.GetData;
begin
  inherited;
  if IsDataField then
    FBarcode.Text := VarToStr(DataSet.Value[DataField])
  else if FExpression <> '' then
    FBarcode.Text := VarToStr(Report.Calc(FExpression));
end;

class function TfrxBarcode2DView.GetDescription: String;
begin
    result := frxResources.Get('obBarC');
end;

procedure TfrxBarcode2DView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var

    w, h, tmp: Extended;
    scaledFontCorrX, scaledFontCorrY: Integer;
    DrawRect: TRect;

begin

    // корректируем угол в 4 возможных значени€
    case Round(Rotation) of

        0 .. 44:    Rotation := 0;
        45 .. 135:  Rotation := 90;
        136 .. 224: Rotation := 180;
        225 .. 315: Rotation := 270;
    else
        Rotation := 0;

    end;

    // значени€ из редактора свойств ///////////////////////////////////////////////
    FBarCode.Font.Assign(Font);

    if Color = clNone then
        FBarCode.Color := clWhite
    else
        FBarCode.Color := Color;

    w := FBarCode.Width; // это размеры баркода в пиксел€х
    h := FBarCode.Height; // дл€ zoom == 1

    // если размер шрифта не прив€зан к размерам штрихкода, это надо учитывать при масштабировании

    if FontScaled or (not ShowText) then
    begin
        scaledFontCorrX := 0;
        scaledFontCorrY := 0;
    end
    else
    begin

        scaledFontCorrY := FBarCode.GetFooterHeight;
        scaledFontCorrX := 0;
        if (Rotation = 90) or (Rotation = 270) then
        begin
            scaledFontCorrX := FBarCode.GetFooterHeight;
            scaledFontCorrY := 0;
        end;

    end;

    // если на боку штрих-код, мен€ем местами высоту и ширину
    if (Rotation = 90) or (Rotation = 270) then
    begin
        tmp := w;
        w := h;
        h := tmp;
    end;

    // не даем изменить размер
    Height := (h - scaledFontCorrY) * Zoom + scaledFontCorrY;
    Width := (w - scaledFontCorrX)  * Zoom + scaledFontCorrX;
    if Frame.DropShadow then
    begin
        Height := Height + round(Frame.ShadowWidth);
        Width := Width +  round(Frame.ShadowWidth);
    end;

    // if FHAlign = haRight then
    // Left := Left + SaveWidth - Width
    // else if FHAlign = haCenter then
    // Left := Left + (SaveWidth - Width) / 2;

    BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

   // если был кос€к при генерации кода, нарисуем алерт
    if FBarcode.ErrorText <> '' then
    begin
        with Canvas do
        begin
            Font.Name := 'Arial';
            Font.Size := Round(8 * ScaleY);
            Font.Color := clRed;
            Pen.Color := clBlack;
            DrawRect := Rect(FX + 2, FY + 2, FX1, FY1);
            DrawText(Handle, PChar(FBarcode.ErrorText), Length(FBarcode.ErrorText), DrawRect, DT_WORDBREAK);
            exit;
        end;
    end;

    DrawBackground;
    FBarCode.Draw2DBarcode(Canvas, FScaleX, FScaleY, FX, FY);
    DrawFrame;

end;

function TfrxBarCode2DView.GetRealBounds: TfrxRect;
var
  extra1, extra2: Integer;
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  Draw(bmp.Canvas, 1, 1, 0, 0);

  Result := inherited GetRealBounds;
  extra1 := 0;
  extra2 := 0;

(*  if (Rotation = 0) or (Rotation = 180) then
  begin
    with bmp.Canvas do
    begin
      {Font.Name := 'Arial';
      Font.Size := 9;
      Font.Style := []; }
      Font.Assign(Self.Font);
      txtWidth := TextWidth(String(FBarcode.Text));
      if Width < txtWidth then
      begin
        extra1 := Round((txtWidth - Width) / 2) + 2;
        extra2 := extra1;
      end;
    end;
  end;*)

  case Rotation of
    0:
      begin
        Result.Left := Result.Left - extra1;
        Result.Right := Result.Right + extra2;
      end;
    90:
      begin
        Result.Bottom := Result.Bottom + extra1;
        Result.Top := Result.Top - extra2;
      end;
    180:
      begin
        Result.Left := Result.Left - extra2;
        Result.Right := Result.Right + extra1;
      end;
    270:
      begin
        Result.Bottom := Result.Bottom + extra2;
        Result.Top := Result.Top - extra1;
      end;
  end;

  bmp.Free;
end;


{ TfrxBarcode2DPropertiesProperty }

function TfrxBarcode2DPropertiesProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paSubProperties, paReadOnly]; // no multiselect!
end;


initialization
  frxPropertyEditors.Register(TypeInfo(TfrxBarcode2DProperties), nil, '', TfrxBarcode2DPropertiesProperty);


end.





