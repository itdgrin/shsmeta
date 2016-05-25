
{******************************************}
{                                          }
{             FastReport v5.0              }
{          2D Barcode base class           }
{                                          }
{         Copyright (c) 1998-2014          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}


unit frxBarcode2DBase;

interface

{$I frx.inc}

uses
    Classes,
    SysUtils,
{$IFDEF FPC}
    LResources, LMessages, LCLType, LCLIntf, LazarusPackageIntf,
    LCLProc, FileUtil, LazHelper,
{$ELSE}
    Windows,
{$ENDIF}
    Graphics,
    frxPrinter;

type

///////////////////////////////////////////////////////////////////////////////////////////////
//  базовый класс для баркода
//
///////////////////////////////////////////////////////////////////////////////////////////////

{$M+}
  TfrxBarcode2DBase  = class(TObject)

    protected

        FImage            : array of byte;            // массив, где готовое изображение кода
        FHeight           : integer;           // высота матрицы символа в точках
        FWidth            : integer;           // ширина
        FPixelWidth        : integer;
        FPixelHeight       : integer;
        FShowText         : boolean;           // виден ли текст
        FRotation         : Integer;           // угол поворота в градусах
        FText             : String;
        FZoom             : Extended;          // коэфф. увеличения
        FFontScaled       : Boolean;           // масштабируется ли текст вместе с баркодом
        FFont             : TFont;
        FColor            : TColor;
        FColorBar         : TColor;
        FErrorText        : string;
        FQuietZone        : integer;           // padding - отступ внутри рамки

        procedure SetShowText( v : boolean); virtual;
        procedure SetRotation(v: integer); virtual;
        procedure SetText( v : string ); virtual;
        procedure SetZoom( v : extended ); virtual;
        procedure SetFontScaled( v : boolean ); virtual;
        procedure SetFont( v : TFont ); virtual;
        procedure SetColor( v : TColor ); virtual;
        procedure SetColorBar( v : TColor ); virtual;
        procedure SetErrorText( v : string ); virtual;

        function GetWidth : integer; virtual;      //  размеры в пикселах ,без учета zoom !
        function GetHeight : integer; virtual;    //

    public

        constructor Create; virtual;
        procedure Assign( src : TfrxBarcode2DBase ); virtual;
        function GetFooterHeight : integer; virtual;          // высота текста в пикселах без учета zoom
        procedure Draw2DBarcode(var g : TCanvas; scalex, scaley : extended; x, y : integer ); virtual;

        property ShowText : boolean read FShowText write SetShowText;
        property Rotation : Integer read FRotation write SetRotation;          // угол поворота в градусах
        property Text     : String  read FText write SetText;
        property Zoom     : Extended read FZoom write SetZoom;                 // коэфф. увеличения
        property FontScaled : Boolean read FFontScaled write SetFontScaled;    // масштабируется ли текст вместе с баркодом
        property Font     : TFont read FFont write SetFont;
        property Color    : TColor read FColor write SetColor;
        property ColorBar : TColor read FColorBar write SetColorBar;
        property ErrorText : string read FErrorText write SetErrorText;
        property Width : integer read GetWidth;                                // ширина в пикселах
        property Height : integer read GetHeight;                              // высота в пикселах
        property PixelWidth : integer read FPixelWidth write FPixelWidth;
        property PixelHeight : integer read FPixelHeight write FPixelHeight;
        property QuietZone : integer read FQuietZone write FQuietZone; // отступ внутри рамки в пикселах

    end;


const
      cbDefaultText = '12345678';

implementation


constructor TfrxBarcode2DBase.Create;
begin
    FWidth := 0;
    FHeight := 0;
    FImage := nil;
    FPixelWidth := 2;
    FPixelHeight := 2;
    FShowText := true;
    FRotation := 0;
    FText := cbDefaultText;
    FZoom := 1;
    FFontScaled := true;
    FColor := clWhite;
    FColorBar := clBlack;
    FFont := TFont.Create;
    FFont.Name := 'Arial';
    FFont.Size := 9;
    FQuietZone := 0;
end;

procedure TfrxBarcode2DBase.Assign( src : TfrxBarcode2DBase);
begin
      FShowText := src.FShowText;
      FRotation := src.FRotation;
      FText := src.FText;
      FZoom := src.FZoom;
      FPixelWidth := src.FPixelWidth;
      FPixelHeight := src.FPixelHeight;
      FFontScaled := src.FFontScaled;
      FFont := src.FFont;
      FColor := src.FColor;
      FColorBar := src.FColorBar;
      FErrorText := src.FErrorText;
      FQuietZone := src.FQuietZone;
end;

procedure TfrxBarcode2DBase.SetShowText( v : boolean);
begin
    FShowText := v;
end;

procedure TfrxBarcode2DBase.SetRotation(v: integer);
begin
    FRotation := v;
end;
procedure TfrxBarcode2DBase.SetText( v : string );
begin
    if(FText <> v) then FText := v;
end;
procedure TfrxBarcode2DBase.SetZoom( v : extended );
begin
    FZoom := v;
end;
procedure TfrxBarcode2DBase.SetFontScaled( v : boolean );
begin
    FFontScaled := v;
end;
procedure TfrxBarcode2DBase.SetFont( v : TFont );
begin
    FFont.Assign(v);
end;
procedure TfrxBarcode2DBase.SetColor( v : TColor );
begin
    FColor := v;
end;
procedure TfrxBarcode2DBase.SetColorBar( v : TColor );
begin
    FColorBar := v;
end;
procedure TfrxBarcode2DBase.SetErrorText( v : string );
begin
    FErrorText := v;
end;

//  возвращает размер текста в прямоугольнике внизу баркода , без учета zoom ! ///////////////
//

function TfrxBarcode2DBase.GetFooterHeight : integer;
begin

    result := -Font.Height - Font.Height div 4;

end;

 // возвращает ширину в пикселах ///////////////////////////////////////////////////////////////

function TfrxBarcode2DBase.GetWidth : integer;
begin

    result := round(FWidth * FPixelWidth + FQuietZone * 2);

end;

// возвращает высоту в пикселах ///////////////////////////////////////////////////////////////

function TfrxBarcode2DBase.GetHeight : integer;
begin

    //  если показываем текст, то высота поболе...
    if FShowText then

        result := round(FHeight * FPixelHeight - FFont.Height -  FFont.Height div 4  + FQuietZone * 2)

    else

        result := round(FHeight * FPixelHeight + FQuietZone * 2);

end;



procedure TfrxBarcode2DBase.Draw2DBarcode(var g : TCanvas; scalex, scaley : extended; x, y : integer );
var
    stride, k, p, j, b,
    dx, dy, textLeftOffset,
    textSemiLength,footerHeight,
    saveFooter, paddingX, paddingY,
    x1,y1,x2,y2,txtX,txtY     : integer;
    kx, ky, saveKX, saveKY,
    koeff_for_font_height     : extended;
    F                         : TLogFont;
    FontHandle, OldFontHandle : HFont;
    bmp                       : TBitmap;    // используется при отрисовке на экране, когда масштаб < 1
    r                         : TRect;

begin

//    if ( FImage = nil ) then exit;

    kx := scalex * zoom;
    ky := scaley * zoom;
    footerHeight := 0;                         // высота подписи в пикселах
    dy := round(FHeight * PixelHeight * ky );  // размеры в пикселях
    dx := round(FWidth * PixelWidth * kx );    //
    paddingX := round(FQuietZone * kx);               // отступ внутри рамки
    paddingY := round(FQuietZone * ky);               //
    txtX := 0;
    txtY := 0;
// рисуем текст внизу
    if ShowText then
    begin

        g.Font.Assign(FFont);
        GetObject(g.Font.Handle, SizeOf(TLogFont), @F);
        F.lfEscapement := Round(Rotation * 10);
        F.lfOrientation := Round(Rotation * 10);
        // если на принтере печатаем, чтобы два раза не увеличивать фонт
        koeff_for_font_height := 1.0;
        if not (g is TfrxPrinterCanvas) then koeff_for_font_height := scaleY;
        if FontScaled then
            F.lfHeight := -round( MulDiv(FFont.Size, GetDeviceCaps(g.Handle, LOGPIXELSY), 72) * zoom * koeff_for_font_height)
        else
            F.lfHeight := -round(MulDiv(FFont.Size, GetDeviceCaps(g.Handle, LOGPIXELSY), 72) * koeff_for_font_height);
        FontHandle := CreateFontIndirect(F);
        OldFontHandle := SelectObject(g.Handle, FontHandle);
        g.Font.Handle := FontHandle;
        g.Brush.Color := Color;
        SetBkMode(g.Handle, Transparent);

        textSemiLength := g.TextWidth(Text) div 2;
        footerHeight := - g.Font.Height div 4 - g.Font.Height;
        x1 := 0; y1 := 0; x2 := 0; y2 := 0;

        case round(Rotation) of
            0:   begin
                     x1 := x;      y1 := y + dy;
                     x2 := x + dx; y2 := y + dy + footerHeight;
                     textLeftOffset := dx div 2 - textSemiLength; if textLeftOffset<0 then textLeftOffset:=0;
                     txtX := x + textLeftOffset;
                     txtY := y + dy
                 end;
            90:  begin
                     x1 := x + dy; x2 := x + dy + footerHeight; y1 := y; y2 := y + dx;
                     textLeftOffset := dx div 2 - textSemiLength; if textLeftOffset < 0 then textLeftOffset:=0;
                     txtX := x1; txtY := y2 - textLeftOffset;
                 end;
            180: begin
                     x1 := x; x2 := x + dx; y1 := y; y2 := y + footerHeight;
                     textLeftOffset := dx div 2 - textSemiLength; if textLeftOffset<0 then textLeftOffset:=0;
                     txtX := x + dx - textLeftOffset;
                     txtY := y + footerHeight;
                 end;
            270: begin
                     x1 := x; x2 := x + footerHeight;
                     y1 := y; y2 := y + dx;
                     textLeftOffset := dx div 2 - textSemiLength; if textLeftOffset<0 then textLeftOffset:=0;
                     txtX := x1+footerHeight; txtY := y1 + textLeftOffset;

                 end;

        end;

        g.TextRect( Rect( x1+paddingX, y1+paddingY, x2+paddingX, y2+paddingY ),txtX + paddingX,txtY+paddingY, Text);
        SelectObject(g.Handle, OldFontHandle);
        DeleteObject(FontHandle);

    end;

    // рисуем сам баркод

    stride := (FWidth + 7) div 8;

    saveKX := 0;
    saveKY := 0;
    saveFooter := footerHeight;
    bmp := nil;
    if( kx < 1 ) or (ky < 1) then // рисовать на канвасе или сначала на битмапе?
    begin
        saveKX := kx;
        saveKY := ky;
        kx := 1; ky := 1; footerHeight := 0;
        bmp := TBitmap.Create;
        bmp.Height := FHeight * PixelHeight;
        bmp.Width := FWidth * PixelWidth;
        if( Rotation=90 )or( Rotation=270 )then
        begin
            bmp.Height := FWidth * PixelWidth;
            bmp.Width := FHeight * PixelHeight;
        end;
        dy := round(FHeight * PixelHeight);
        dx := round(FWidth * PixelWidth);
    end;

    for k := 0 to FHeight-1 do
    begin
        p := k * stride;
        for j := 0 to FWidth-1 do
        begin
            b := FImage[p + (j div 8)] and $ff;
            b := b shl ( j mod 8 );

            if ( b and $80) = 0 then
            begin
                if ( saveKX <> 0) then
                begin
                    bmp.Canvas.Brush.Color := clWhite; bmp.Canvas.Pen.Color := clWhite;
                end
                else
                begin
                    g.Brush.Color := clWhite; g.Pen.Color := clWhite;
                end;
            end
            else
            begin
                if ( saveKX <> 0) then
                begin
                    bmp.Canvas.Brush.Color := clBlack; bmp.Canvas.Pen.Color := clBlack;
                end
                else
                begin
                    g.Brush.Color := clBlack; g.Pen.Color := clBlack;
                end;
            end;


            x1 := 0; x2 := 0; y1 := 0; y2 := 0;
            case round(Rotation) of
                0:  begin
                        x1 := Round(x + j * PixelWidth * kx);
                        y1 := Round(y + k * PixelHeight * ky);
                        x2 := Round(x + j * PixelWidth * kx + PixelWidth * kx);
                        y2 := Round(y + k * PixelHeight * ky + PixelHeight * ky);
                    end;
              90:   begin
                        x1 := Round(x + k * PixelHeight * kx);
                        x2 := Round(x + k * PixelHeight * kx + PixelHeight * kx);
                        y1 := Round(y + dx - j * PixelWidth * ky);
                        y2 := Round(y + dx - j * PixelWidth * ky - PixelWidth * ky);
                 end;
            180: begin
                        x1 := Round(x + dx - j * PixelWidth * kx);
                        x2 := Round(x + dx - j * PixelWidth * kx - PixelWidth * kx);
                        y1 := Round(y + footerHeight + dy - k * PixelHeight * ky);
                        y2 := Round(y + footerHeight + dy - k * PixelHeight * ky - PixelHeight * ky);
                 end;
            270: begin
                        x1 := Round(x + footerHeight + dy - k * PixelHeight * kx);
                        x2 := Round(x + footerHeight + dy - k * PixelHeight * kx - PixelHeight * kx);
                        y1 := Round(y + j * PixelWidth * ky);
                        y2 := Round(y + j * PixelWidth * ky + PixelWidth * ky);
                 end;

            end;

            if( saveKX = 0 ) then
                g.Rectangle( x1+paddingX, y1+paddingY, x2+paddingX, y2+paddingY )
            else
                bmp.Canvas.Rectangle( x1-x+paddingX, y1-y+paddingY, x2-x+paddingX, y2-y+paddingY );

        end
    end;

    // если рисовали на битмапе сначала, то переносим на канвас
    if( saveKX <> 0) then
    begin
        x1 := 0; x2 := 0; y1 := 0; y2 := 0;
        case Round(Rotation) of
            0: begin x1:=0; y1:=0; x2:=Round(FWidth * PixelWidth * saveKX); y2:=Round(FHeight * PixelHeight * saveKY); end;
            90: begin x1:=0; y1 :=0; x2:= Round(FHeight * PixelHeight * saveKY); y2:=Round(FWidth * PixelWidth * saveKX);end;
            180: begin x1:=0; y1:= saveFooter; x2:=Round(FWidth * PixelWidth * saveKX); y2:=Round(FHeight * PixelHeight * saveKY); end;
            270: begin x1:=saveFooter; y1:=0; x2:= Round(FHeight * PixelHeight * saveKY); y2:=Round(FWidth * PixelWidth * saveKX); end;
        end;
        r := Rect(x+x1+paddingX,y+y1+paddingY,x + x1 + x2+paddingX, y+y1 + y2+paddingY);
        g.StretchDraw(r, bmp);
    end;




end;

end.


