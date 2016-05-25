
{******************************************}
{                                          }
{             FastReport v5.0              }
{          Barcode Add-in object           }
{                                          }
{         Copyright (c) 1998-2014          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxBarcode;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}Windows, Messages, {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, frxBarcod, frxClass, ExtCtrls
{$IFDEF FPC}
  , LCLType, LCLIntf, LazarusPackageIntf
{$ENDIF}
{$IFDEF Delphi6}
, Variants
{$ENDIF}
;


type
{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxBarCodeObject = class(TComponent);  // fake component

  TfrxBarCodeView = class(TfrxView)
  private
    FBarCode: TfrxBarCode;
    FBarType: TfrxBarcodeType;
    FCalcCheckSum: Boolean;
    FExpression: String;
    FHAlign: TfrxHAlign;
    FRotation: Integer;
    FShowText: Boolean;
    FText: String;
    FWideBarRatio: Extended;
    FZoom: Extended;
    procedure BcFontChanged(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; Flags: Word); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure GetData; override;
    class function GetDescription: String; override;
    function GetRealBounds: TfrxRect; override;
    property BarCode: TfrxBarCode read FBarCode;
  published
    property BarType: TfrxBarcodeType read FBarType write FBarType;
    property BrushStyle;
    property CalcCheckSum: Boolean read FCalcCheckSum write FCalcCheckSum default False;
    property FillType;
    property Fill;
    property Cursor;
    property DataField;
    property DataSet;
    property DataSetName;
    property Expression: String read FExpression write FExpression;
    property Frame;
    property HAlign: TfrxHAlign read FHAlign write FHAlign default haLeft;
    property Rotation: Integer read FRotation write FRotation;
    property ShowText: Boolean read FShowText write FShowText default True;
    property TagStr;
    property Text: String read FText write FText;
    property URL;
    property WideBarRatio: Extended read FWideBarRatio write FWideBarRatio;
    property Zoom: Extended read FZoom write FZoom;
    property Font;
  end;

{$IFDEF FPC}
  procedure Register;
{$ENDIF}
implementation

uses
{$IFNDEF NO_EDITORS}
  frxBarcodeEditor,
{$ENDIF}
  frxBarcodeRTTI, frxDsgnIntf, frxRes, frxUtils{$IFNDEF RAD_ED}, frxBarcode2D{$ENDIF};

const
  cbDefaultText = '12345678';


{ TfrxBarCodeView }

constructor TfrxBarCodeView.Create(AOwner: TComponent);
begin
  inherited;
  FBarCode := TfrxBarCode.Create(nil);
  FBarType := bcCode39;
  FShowText := True;
  FZoom := 1;
  FText := cbDefaultText;
  FWideBarRatio := 2;
  Font.Name := 'Arial';
  Font.Size := 9;
  Font.OnChange := BcFontChanged;
end;

constructor TfrxBarCodeView.DesignCreate(AOwner: TComponent; Flags: Word);
begin
  inherited;
  BarType := TfrxBarcodeType(Flags);
end;

destructor TfrxBarCodeView.Destroy;
begin
  FBarCode.Free;
  inherited Destroy;
end;

class function TfrxBarCodeView.GetDescription: String;
begin
  Result := frxResources.Get('obBarC');
end;

procedure TfrxBarCodeView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  SaveWidth: Extended;
  ErrorText: String;
  DrawRect: TRect;
  CorrL, CorrR: Integer;
begin
  FBarCode.Angle := FRotation;
  FBarCode.Font.Assign(Font);
  FBarCode.Checksum := FCalcCheckSum;
  FBarCode.Typ := FBarType;
  FBarCode.Ratio := FWideBarRatio;
//  if Color = clNone then
    FBarCode.Color := clWhite;// else
//    FBarCode.Color := Color;

  SaveWidth := Width;

  FBarCode.Text := AnsiString(FText);
  ErrorText := '';
  if FZoom < 0.0001 then
    FZoom := 1;

  { frame correction for some bacrode types }
  if FBarCode.Typ in [bcCodeUPC_E0, bcCodeUPC_E1, bcCodeUPC_A] then
    CorrR := 9
  else
    CorrR := 0;
  if FBarCode.Typ in [bcCodeEAN13, bcCodeUPC_A] then
    CorrL := 8
  else
    CorrL := 0;


  try
    if (FRotation = 0) or (FRotation = 180) then
      Width := (FBarCode.Width + CorrL + CorrR) * FZoom
    else
      Height := (FBarCode.Width + CorrL + CorrR) * FZoom;
  except
    on e: Exception do
    begin
      FBarCode.Text := '12345678';
      ErrorText := e.Message;
    end;
  end;

  if FHAlign = haRight then
    Left := Left + SaveWidth - Width
  else if FHAlign = haCenter then
    Left := Left + (SaveWidth - Width) / 2;

  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

  DrawBackground;
  if ErrorText = '' then
    FBarCode.DrawBarcode(Canvas, Rect(FX + Round(CorrL * ScaleX) , FY, FX1 - Round(CorrR * ScaleX), FY1), FShowText)
  else
    with Canvas do
    begin
      Font.Name := 'Arial';
      Font.Size := Round(8 * ScaleY);
      Font.Color := clRed;
      DrawRect := Rect(FX + 2, FY + 2, FX1, FY1);
      DrawText(Handle, PChar(ErrorText), Length(ErrorText),
        DrawRect, DT_WORDBREAK);
    end;
  DrawFrame;
end;

procedure TfrxBarCodeView.GetData;
begin
  inherited;
  if IsDataField then
    FText := VarToStr(DataSet.Value[DataField])
  else if FExpression <> '' then
    FText := VarToStr(Report.Calc(FExpression));
end;

function TfrxBarCodeView.GetRealBounds: TfrxRect;
var
  extra1, extra2, txtWidth: Integer;
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  Draw(bmp.Canvas, 1, 1, 0, 0);

  Result := inherited GetRealBounds;
  extra1 := 0;
  extra2 := 0;

  if (FRotation = 0) or (FRotation = 180) then
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
  end;

  if FBarType in [bcCodeEAN13, bcCodeUPC_A] then
    extra1 := 8;
  if FBarType in [bcCodeUPC_A, bcCodeUPC_E0, bcCodeUPC_E1] then
    extra2 := 8;
  case FRotation of
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

procedure TfrxBarCodeView.BcFontChanged(Sender: TObject);
begin
  if Font.Size > 9 then Font.Size := 9;
end;


{$IFDEF FPC}
procedure RegisterUnitfrxBarcode;
begin
  RegisterComponents('Fast Report 5',[TfrxBarCodeObject]);
end;

procedure Register;
begin
  RegisterUnit('frxBarcode',@RegisterUnitfrxBarcode);
end;
{$ENDIF}

initialization
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxBarCodeObject, TControl);
{$ENDIF}

  frxObjects.RegisterCategory('Barcode', nil, 'obCatBarcode', 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, '2_5_interleaved', 'Barcode', 0, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, '2_5_industrial', 'Barcode', 1, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, '2_5_matrix', 'Barcode', 2, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code39', 'Barcode', 3, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code39 Extended', 'Barcode', 4, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code128', 'Barcode', 5, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code128A', 'Barcode', 6, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code128B', 'Barcode', 7, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code128C', 'Barcode', 8, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code93', 'Barcode', 9, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code93Extended', 'Barcode', 10, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'MSI', 'Barcode', 11, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'PostNet', 'Barcode', 12, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Codabar', 'Barcode', 13, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'EAN8', 'Barcode', 14, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'EAN13', 'Barcode', 15, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'UPC_A', 'Barcode', 16, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'UPC_E0', 'Barcode', 17, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'UPC_E1', 'Barcode', 18, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'UPC_Supp2', 'Barcode', 19, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'UPC_Supp5', 'Barcode', 20, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'EAN128', 'Barcode', 21, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'EAN128A', 'Barcode', 22, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'EAN128B', 'Barcode', 23, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'EAN128C', 'Barcode', 24, 23);
{$IFNDEF RAD_ED}
  frxObjects.RegisterObject1(TfrxBarcode2DView, nil, 'PDF417', 'Barcode', 0, 23);
  frxObjects.RegisterObject1(TfrxBarcode2DView, nil, 'DataMatrix', 'Barcode', 1, 23);
  frxObjects.RegisterObject1(TfrxBarcode2DView, nil, 'QRCode', 'Barcode', 2, 23);
{$ENDIF}

finalization
  frxObjects.UnRegister(TfrxBarCodeView);
{$IFNDEF RAD_ED}
  frxObjects.Unregister(TfrxBarcode2DView);
{$ENDIF}

end.


