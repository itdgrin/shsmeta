unit fFrameMaterial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fFrameSpr, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, JvExControls, JvAnimatedImage, JvGIFCtrl,
  Vcl.Buttons, Data.DB, GlobsAndConst;

type
  TSprMaterial = class(TSprFrame)
    LabelRegion: TLabel;
    cmbRegion: TComboBox;
    cbMat: TCheckBox;
    cbJBI: TCheckBox;
    procedure ListSprDblClick(Sender: TObject);
  private
    { Private declarations }
    FAllowAddition: Boolean;
  protected
    function GetSprSQL: string; override;
    procedure OnLoadStart; override;
    procedure OnLoadDone; override;
    procedure SpecialFillArray(const AInd: Integer; ADataSet: TDataSet); override;
    function CheckFindCode(AFindStr: string): Boolean; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      const APriceColumn, vAllowAddition: Boolean;
      const AStarDate: TDateTime); reintroduce;
  end;

implementation

{$R *.dfm}

uses CalculationEstimate;

constructor TSprMaterial.Create(AOwner: TComponent;
      const APriceColumn, vAllowAddition: Boolean;
      const AStarDate: TDateTime);
begin
  FAllowAddition := vAllowAddition;
  inherited Create(AOwner, APriceColumn, AStarDate);
end;

function TSprMaterial.GetSprSQL: string;
var TmpStr: string;
begin
  TmpStr := '';
  if cbMat.Checked then
    TmpStr := '1';
  if cbJBI.Checked then
  begin
    if TmpStr <> '' then
      TmpStr := TmpStr + ',';
    TmpStr := TmpStr + '2';
  end;
  //Просто несущиствующий тип, что-бы запрос ничего не вернул
  if TmpStr = '' then
    TmpStr := '-1';

  if FPriceColumn then
    Result := 'SELECT material.material_id as "Id", mat_code as "Code", ' +
          'cast(mat_name as char(1024)) as "Name", unit_name as "Unit", ' +
          'coast' + IntToStr(cmbRegion.ItemIndex + 1) + '_1 as "PriceVAT", ' +
          'coast' + IntToStr(cmbRegion.ItemIndex + 1) + '_2 as "PriceNotVAT", ' +
          'MAT_TYPE ' +
          'FROM material, units, materialcoastg ' +
          'WHERE (material.unit_id = units.unit_id) ' +
          'and (material.material_id = materialcoastg.material_id) ' +
          'and (material.MAT_TYPE in (' + TmpStr + ')) and (year=' +
          IntToStr(edtYear.Value) + ') and (monat=' +
          IntToStr(cmbMonth.ItemIndex + 1) +') ORDER BY mat_code;'
  else
    Result := 'SELECT material.material_id as "Id", mat_code as "Code", ' +
          'cast(mat_name as char(1024)) as "Name", unit_name as "Unit", ' +
          'MAT_TYPE FROM material, units ' +
          'WHERE (material.unit_id = units.unit_id) ' +
          'and (material.MAT_TYPE in (' + TmpStr + ')) ORDER BY mat_code;';
end;

procedure TSprMaterial.ListSprDblClick(Sender: TObject);
begin
  inherited;
  if FAllowAddition and (ListSpr.ItemIndex > -1) then
    FormCalculationEstimate.AddMaterial(
      TSprRecord(ListSpr.Items[ListSpr.ItemIndex].Data^).ID);
end;

procedure TSprMaterial.OnLoadStart;
begin
  inherited;
  cmbRegion.Enabled := False;
  cbMat.Enabled := False;
  cbJBI.Enabled := False;
end;

procedure TSprMaterial.OnLoadDone;
begin
  inherited;
  if FPriceColumn then
    cmbRegion.Enabled := True;

  cbMat.Enabled := True;
  cbJBI.Enabled := True;
end;

procedure TSprMaterial.SpecialFillArray(const AInd: Integer; ADataSet: TDataSet);
begin
  FSprArray[AInd - 1].MType := ADataSet.FieldByName('MAT_TYPE').AsInteger;
end;

function TSprMaterial.CheckFindCode(AFindStr: string): Boolean;
begin
  Result := False;
  if (Length(AFindStr) > 1) then
    if (((AFindStr[1] = 'C') or (AFindStr[1] = 'c') or
        (AFindStr[1] = 'С') or (AFindStr[1] = 'с')) and
      CharInSet(AFindStr[2], ['1'..'9'])) then
    begin
      AFindStr[1] := 'С';
      Result := True;
    end;
end;

end.
