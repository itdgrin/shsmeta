unit frxBarcodeProperties;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Types, Controls,
    Forms, Dialogs,
    StdCtrls, Menus, frxClass, ExtCtrls,frxdesgn,frxBarcodePDF417,frxBarcodeDataMatrix, frxBarcodeQR, frxDelphiZXingQRCode, frxBarcode2DBase;

type

{$M+}
    // свойство, добавляемое ?рантайме

    TfrxBarcode2DProperties = class (TPersistent)

    private

      FOnChange: TNotifyEvent;

    public

      FWhose : TObject;   // чь?свойства
      procedure Changed;
      procedure Assign(Source: TPersistent); override; abstract;
      procedure SetWhose( w : TObject);

    end;


    TfrxPDF417Properties = class( TfrxBarcode2DProperties )

    private


        function GetAspectRatio : extended;
        function GetColumns : integer;
        function GetRows : integer;
        function GetErrorCorrection : PDF417ErrorCorrection;
        function GetCodePage : integer;
        function GetCompactionMode : PDF417CompactionMode;
        function GetPixelWidth : integer;
        function GetPixelHeight : integer;

        procedure SetAspectRatio(v : extended);
        procedure SetColumns(v : integer);
        procedure SetRows(v : integer);
        procedure SetErrorCorrection(v : PDF417ErrorCorrection);
        procedure SetCodePage(v : integer);
        procedure SetCompactionMode(v : PDF417CompactionMode);
        procedure SetPixelWidth(v : integer);
        procedure SetPixelHeight(v : integer);


    public

      procedure Assign(Source: TPersistent); override;

    published

        property AspectRatio : extended read GetAspectRatio write SetAspectRatio;
        property Columns : integer read GetColumns write SetColumns;
        property Rows : integer read GetRows write SetRows;
        property ErrorCorrection : PDF417ErrorCorrection read GetErrorCorrection write SetErrorCorrection;
        property CodePage : integer read GetCodePage write SetCodePage;
        property CompactionMode : PDF417CompactionMode read GetCompactionMode write SetCompactionMode;
        property PixelWidth : integer read GetPixelWidth write SetPixelWidth;
        property PixelHeight : integer read GetPixelHeight write SetPixelHeight;

    end;

  TfrxDataMatrixProperties = class( TfrxBarcode2DProperties )

    private


        function GetCodePage    : integer;
        function GetPixelSize   : integer;
        function GetSymbolSize  : DatamatrixSymbolSize;
        function GetEncoding    : DatamatrixEncoding;

        procedure SetCodePage(v : integer);
        procedure SetPixelSize(v : integer);
        procedure SetSymbolSize(v : DatamatrixSymbolSize);
        procedure SetEncoding(v : DatamatrixEncoding);


    public

      procedure Assign(Source: TPersistent); override;

    published

        property CodePage : integer read GetCodePage write SetCodePage;
        property PixelSize : integer read GetPixelSize write SetPixelSize;
        property SymbolSize : DatamatrixSymbolSize read GetSymbolSize write SetSymbolSize;
        property Encoding : DatamatrixEncoding read GetEncoding write SetEncoding;

    end;

  TfrxQRProperties = class( TfrxBarcode2DProperties )
  private
    function GetEncoding: TQRCodeEncoding;
    function GetQuietZone: Integer;
    function GetPixelSize   : integer;
    procedure SetPixelSize(v : integer);
    procedure SetEncoding(const Value: TQRCodeEncoding);
    procedure SetQuietZone(const Value: Integer);
    function GetErrorLevels: TQRErrorLevels;
    procedure SetErrorLevels(const Value: TQRErrorLevels);

    public

      procedure Assign(Source: TPersistent); override;

    published

      property Encoding: TQRCodeEncoding read GetEncoding write SetEncoding;
      property QuietZone: Integer read GetQuietZone write SetQuietZone;
      property ErrorLevels: TQRErrorLevels read GetErrorLevels write SetErrorLevels;
      property PixelSize : integer read GetPixelSize write SetPixelSize;

    end;

implementation

procedure TfrxBarcode2DProperties.SetWhose( w : TObject);
begin
    FWhose := w;
end;

procedure TfrxBarcode2DProperties.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TfrxPDF417Properties.Assign(Source: TPersistent);
var
  src : TfrxPDF417Properties;
begin
    if Source is TfrxPDF417Properties then
    begin
        src := TfrxPDF417Properties(Source);
        SetAspectRatio(src.AspectRatio);
        SetColumns(src.Columns);
        SetRows(src.Rows);
        SetErrorCorrection(src.ErrorCorrection);
        SetCodePage(src.Codepage);
        SetCompactionMode(src.CompactionMode);
        SetPixelWidth(src.PixelWidth);
        SetPixelHeight(src.PixelHeight);
        SetWhose(src.FWhose);
    end
    else
       inherited;
end;

function TfrxPDF417Properties.GetAspectRatio : extended;
begin
    result := TfrxBarcodePDF417(FWhose).AspectRatio;
end;
function TfrxPDF417Properties.GetColumns : integer;
begin
    result := TfrxBarcodePDF417(FWhose).Columns;
end;
function TfrxPDF417Properties.GetRows : integer;
begin
    result := TfrxBarcodePDF417(FWhose).Rows;
end;
function TfrxPDF417Properties.GetErrorCorrection : PDF417ErrorCorrection;
begin
    result := TfrxBarcodePDF417(FWhose).ErrorCorrection;
end;
function TfrxPDF417Properties.GetCodePage : integer;
begin
    result := TfrxBarcodePDF417(FWhose).CodePage;
end;
function TfrxPDF417Properties.GetCompactionMode : PDF417CompactionMode;
begin
    result := TfrxBarcodePDF417(FWhose).CompactionMode;
end;
function TfrxPDF417Properties.GetPixelHeight : integer;
begin
    result := TfrxBarcodePDF417(FWhose).PixelHeight;
end;
function TfrxPDF417Properties.GetPixelWidth : integer;
begin
    result := TfrxBarcodePDF417(FWhose).PixelWidth;
end;
procedure TfrxPDF417Properties.SetAspectRatio(v : extended);
begin
    TfrxBarcodePDF417(FWhose).AspectRatio := v;
end;
procedure TfrxPDF417Properties.SetColumns(v : integer);
begin
    TfrxBarcodePDF417(FWhose).Columns := v;
end;
procedure TfrxPDF417Properties.SetRows(v : integer);
begin
    TfrxBarcodePDF417(FWhose).Rows := v;
end;
procedure TfrxPDF417Properties.SetErrorCorrection(v : PDF417ErrorCorrection);
begin
    TfrxBarcodePDF417(FWhose).ErrorCorrection := v;
end;
procedure TfrxPDF417Properties.SetCodePage(v : integer);
begin
    TfrxBarcodePDF417(FWhose).CodePage := v;
end;
procedure TfrxPDF417Properties.SetCompactionMode(v : PDF417CompactionMode);
begin
    TfrxBarcodePDF417(FWhose).CompactionMode := v;
end;
procedure TfrxPDF417Properties.SetPixelWidth(v : integer);
begin
    TfrxBarcodePDF417(FWhose).PixelWidth := v;
end;
procedure TfrxPDF417Properties.SetPixelHeight(v : integer);
begin
    TfrxBarcodePDF417(FWhose).PixelHeight := v;
end;

////////////////////////////////////////////////////////////////////////////////////////

function TfrxDataMatrixProperties.GetCodePage    : integer;begin result := TfrxBarcodeDataMatrix(FWhose).CodePage; end;
function TfrxDataMatrixProperties.GetPixelSize   : integer;begin result := TfrxBarcodeDataMatrix(FWhose).PixelSize; end;
function TfrxDataMatrixProperties.GetSymbolSize  : DatamatrixSymbolSize;begin result := TfrxBarcodeDataMatrix(FWhose).SymbolSize; end;
function TfrxDataMatrixProperties.GetEncoding    : DatamatrixEncoding;begin result := TfrxBarcodeDataMatrix(FWhose).Encoding; end;

procedure TfrxDataMatrixProperties.SetCodePage(v : integer);begin TfrxBarcodeDataMatrix(FWhose).CodePage := v;end;
procedure TfrxDataMatrixProperties.SetPixelSize(v : integer);
begin
    if v < 2 then v := 2;  TfrxBarcodeDataMatrix(FWhose).PixelSize := v;end;
procedure TfrxDataMatrixProperties.SetSymbolSize(v : DatamatrixSymbolSize);begin TfrxBarcodeDataMatrix(FWhose).SymbolSize := v;end;
procedure TfrxDataMatrixProperties.SetEncoding(v : DatamatrixEncoding);begin TfrxBarcodeDataMatrix(FWhose).Encoding := v;end;

procedure TfrxDataMatrixProperties.Assign(Source: TPersistent);
var
  src : TfrxDataMatrixProperties;
begin
    if Source is TfrxDataMatrixProperties then
    begin
        src := TfrxDataMatrixProperties(Source);
        SetCodePage(src.CodePage);
        SetPixelSize(src.PixelSize);
        SetSymbolSize(src.SymbolSize);
        SetEncoding(src.Encoding);
    end
    else
       inherited;
end;



{ TfrxQRProperties }

procedure TfrxQRProperties.Assign(Source: TPersistent);
var
  src : TfrxQRProperties;
begin
    if Source is TfrxQRProperties then
    begin
        src := TfrxQRProperties(Source);
        SetEncoding(src.Encoding);
        SetQuietZone(src.QuietZone);
        SetErrorLevels(src.ErrorLevels);
    end
    else
       inherited;
end;

function TfrxQRProperties.GetEncoding: TQRCodeEncoding;
begin
  Result := TfrxBarcodeQR(FWhose).Encoding;
end;

function TfrxQRProperties.GetErrorLevels: TQRErrorLevels;
begin
  Result := TfrxBarcodeQR(FWhose).ErrorLevels;
end;

function TfrxQRProperties.GetQuietZone: Integer;
begin
  Result := TfrxBarcodeQR(FWhose).QuietZone;
end;

procedure TfrxQRProperties.SetEncoding(const Value: TQRCodeEncoding);
begin
  TfrxBarcodeQR(FWhose).Encoding := Value;
end;

procedure TfrxQRProperties.SetErrorLevels(const Value: TQRErrorLevels);
begin
  TfrxBarcodeQR(FWhose).ErrorLevels := Value;
end;

procedure TfrxQRProperties.SetQuietZone(const Value: Integer);
begin
  TfrxBarcodeQR(FWhose).QuietZone := Value;
end;

function TfrxQRProperties.GetPixelSize: integer;
begin
  result := TfrxBarcodeQR(FWhose).PixelSize;
end;

procedure TfrxQRProperties.SetPixelSize(v : integer);
begin
  if v < 2 then v := 2;
  TfrxBarcodeQR(FWhose).PixelSize := v;
end;

end.


 