
{******************************************}
{                                          }
{             FastReport v5.0              }
{             Image Converter              }
{                                          }
{         Copyright (c) 1998-2011          }
{           by Anton Khayrudinov           }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

{$I frx.inc}

unit frxImageConverter;

interface

uses
  Graphics,
  Classes;

type
  TfrxPictureType = (gpPNG, gpBMP, gpEMF, gpWMF, gpJPG, gpGIF);

procedure SaveGraphicAs(Graphic: TGraphic; Stream: TStream; PicType: TfrxPictureType); overload;
procedure SaveGraphicAs(Graphic: TGraphic; Path: string; PicType: TfrxPictureType); overload;

function GetPicFileExtension(PicType: TfrxPictureType): string;

implementation

uses
  {$IFDEF Delphi12}
  PNGImage,
  {$ELSE}
  frxPNGImage,
  {$ENDIF}
  JPEG,
  GIF;

function GetPicFileExtension(PicType: TfrxPictureType): string;
begin
  case PicType of
    gpPNG: Result := 'png';
    gpBMP: Result := 'bmp';
    gpEMF: Result := 'emf';
    gpWMF: Result := 'wmf';
    gpJPG: Result := 'jpg';
    gpGIF: Result := 'gif';
    else   Result := '';
  end;
end;

procedure SaveGraphicAs(Graphic: TGraphic; Path: string; PicType: TfrxPictureType);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(Path, fmCreate);

  try
    SaveGraphicAs(Graphic, Stream, PicType)
  finally
    Stream.Free
  end
end;

procedure SaveGraphicAs(Graphic: TGraphic; Stream: TStream; PicType: TfrxPictureType);

  procedure SaveAsMetafile(Enhanced: Boolean);
  var
    Metafile: TMetafile;
    Canvas: TCanvas;
  begin
    Metafile := TMetafile.Create;

    try
      Metafile.Width := Graphic.Width;
      Metafile.Height := Graphic.Height;
      Metafile.Enhanced := Enhanced;
      Canvas := TMetafileCanvas.Create(Metafile, 0);

      try
        Canvas.Draw(0, 0, Graphic)
      finally
        Canvas.Free
      end;

      Metafile.SaveToStream(Stream);
    finally
      Metafile.Free
    end
  end;

  procedure SaveAsBitmap(PixFormat: TPixelFormat);
  var
    Image: TBitmap;
  begin
    Image := TBitmap.Create;

    try
      Image.Width := Graphic.Width;
      Image.Height := Graphic.Height;
      Image.PixelFormat := PixFormat;

      Image.TransparentColor := $123456;
      Image.Canvas.Brush.Color := Image.TransparentColor;
      Image.Canvas.FillRect(Image.Canvas.ClipRect);

      Image.Canvas.Draw(0, 0, Graphic);
      Image.SaveToStream(Stream);
    finally
      Image.Free
    end
  end;

  procedure SaveAsPNG;
  {$IFNDEF Delphi12}
  type
    TPngImage = TPngObject;
  {$ENDIF}
  var
    Image: TPngImage;
  begin
    Image := TPngImage.CreateBlank(COLOR_RGB, 8, Graphic.Width, Graphic.Height);

    try
      Image.TransparentColor := $123456;
      Image.Canvas.Brush.Color := Image.TransparentColor;
      Image.Canvas.FillRect(Image.Canvas.ClipRect);

      Image.Canvas.Draw(0, 0, Graphic);
      Image.SaveToStream(Stream);
    finally
      Image.Free
    end
  end;

  procedure SaveAsJPG;
  var
    Bitmap: TBitmap;
    Image: TJPEGImage;
  begin
    Bitmap := TBitmap.Create;

    try
      Bitmap.Width := Graphic.Width;
      Bitmap.Height := Graphic.Height;
      Bitmap.Canvas.Draw(0, 0, Graphic);

      Image := TJPEGImage.Create;

      try
        Image.Assign(Bitmap);
        Image.SaveToStream(Stream);
      finally
        Image.Free
      end
    finally
      Bitmap.Free
    end
  end;

  procedure SaveAsGIF;
  var
    Bitmap: TBitmap;
  begin
    Bitmap := TBitmap.Create;

    try
      Bitmap.Width := Graphic.Width;
      Bitmap.Height := Graphic.Height;
      Bitmap.Canvas.Draw(0, 0, Graphic);
      GIFSaveToStream(Stream, Bitmap);
    finally
      Bitmap.Free
    end
  end;

begin
  case PicType of
    gpEMF: SaveAsMetafile(True);
    gpWMF: SaveAsMetafile(False);
    gpBMP: SaveAsBitmap(pf24bit);
    gpPNG: SaveAsPNG;
    gpJPG: SaveAsJPG;
    gpGIF: SaveAsGIF;
  end;
end;

end.
