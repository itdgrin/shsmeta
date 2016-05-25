
{******************************************}
{                                          }
{             FastReport v5.0              }
{         Exports Registration unit        }
{                                          }
{         Copyright (c) 1998-2014          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxeReg;

{$I frx.inc}

interface


procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFNDEF Delphi6}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors,
{$ENDIF}
{$IFNDEF RAD_ED}
  frxExportXML, frxExportXLS, frxExportMail, frxExportHTMLDiv, 
  frxExportODF, frxExportDBF, frxExportBIFF, frxExportDOCX, frxExportPPTX, frxExportXLSX, frxExportSVG,
{$ENDIF}
  frxExportHTML, {$IFNDEF Delphi12}frxExportTXT, {$ENDIF}frxExportImage,
  frxExportRTF, frxExportPDF, frxExportText, frxExportCSV;

{-----------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents('FastReport 5.0 exports',
    [
{$IFNDEF RAD_ED}
     TfrxXLSExport, TfrxXMLExport, TfrxMailExport,
      {$IFNDEF Delphi12}TfrxTXTExport, {$ENDIF}TfrxODSExport, TfrxODTExport,
      TfrxDBFExport, TfrxBIFFExport, TfrxDOCXExport, TfrxPPTXExport, TfrxXLSXExport,
      TfrxHTML4DivExport, TfrxHTML5DivExport, TfrxSVGExport,
{$ENDIF}
      TfrxPDFExport, TfrxHTMLExport, TfrxRTFExport,
      TfrxBMPExport, TfrxJPEGExport, TfrxTIFFExport,
      TfrxGIFExport, TfrxSimpleTextExport, TfrxCSVExport]);
{$IFDEF DELPHI16}
  //StartClassGroup(TControl);
  //ActivateClassGroup(TControl);
  //GroupDescendentsWith(TfrxHTMLExport, TControl);
  //GroupDescendentsWith(TfrxRTFExport, TControl);
  //GroupDescendentsWith(TfrxCSVExport, TControl);
  //GroupDescendentsWith(TfrxSimpleTextExport, TControl);
  //GroupDescendentsWith(TfrxPDFExport, TControl);
  //GroupDescendentsWith(TfrxPNGExport, TControl);
  //GroupDescendentsWith(TfrxGIFExport, TControl);
  //GroupDescendentsWith(TfrxEMFExport, TControl);
  //GroupDescendentsWith(TfrxBMPExport, TControl);
  //GroupDescendentsWith(TfrxTIFFExport, TControl);
  //GroupDescendentsWith(TfrxJPEGExport, TControl);
{$IFNDEF RAD_ED}
  //GroupDescendentsWith(TfrxBIFFExport, TControl);
  //GroupDescendentsWith(TfrxXLSExport, TControl);
  //GroupDescendentsWith(TfrxXMLExport, TControl);
  //GroupDescendentsWith(TfrxMailExport, TControl);
  //GroupDescendentsWith(TfrxODSExport, TControl);
  //GroupDescendentsWith(TfrxODTExport, TControl);
  //GroupDescendentsWith(TfrxDBFExport, TControl);
{$ENDIF}
{$ENDIF}
end;

end.
