{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit fr4_lazarus;

interface

uses
  frxClass, frxBarcode, frxPrinter, frxCtrls, frxUtils, frxDock, frxDBSet, 
  frxChBox, frxGradient, frxCross, frxDesgnCtrls, frxBarcod, frxDCtrl, 
  frxDesgn, frxPreview, frxXML, frxXMLSerializer, frxLazarusComponentEditors, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('frxClass', @frxClass.Register);
  RegisterUnit('frxBarcode', @frxBarcode.Register);
  RegisterUnit('frxCtrls', @frxCtrls.Register);
  RegisterUnit('frxDock', @frxDock.Register);
  RegisterUnit('frxDBSet', @frxDBSet.Register);
  RegisterUnit('frxChBox', @frxChBox.Register);
  RegisterUnit('frxGradient', @frxGradient.Register);
  RegisterUnit('frxCross', @frxCross.Register);
  RegisterUnit('frxDesgnCtrls', @frxDesgnCtrls.Register);
  RegisterUnit('frxLazarusComponentEditors', 
    @frxLazarusComponentEditors.Register);
end;

initialization
  RegisterPackage('fr4_lazarus', @Register);
end.




