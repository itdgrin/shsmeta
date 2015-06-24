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
    function CheckFindCode(AFindCode: string): string; override;
    function CheckByffer: Boolean; override;
    procedure UpdateByffer; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      const APriceColumn, vAllowAddition: Boolean;
      const AStarDate: TDateTime;
      const ARegion: Integer;
      const AMat, AJBI: Boolean); reintroduce;
  end;

implementation

{$R *.dfm}

uses CalculationEstimate;

constructor TSprMaterial.Create(AOwner: TComponent;
      const APriceColumn, vAllowAddition: Boolean;
      const AStarDate: TDateTime;
      const ARegion: Integer;
      const AMat, AJBI: Boolean);
begin
  FAllowAddition := vAllowAddition;
  inherited Create(AOwner, APriceColumn, AStarDate);
  if (cmbRegion.Items.Count >= ARegion) and (ARegion > 0) then
    cmbRegion.ItemIndex := ARegion - 1;
  cbMat.Checked := AMat;
  cbJBI.Checked := AJBI;
end;

function TSprMaterial.CheckFindCode(AFindCode: string): string;
begin
  if AFindCode.Length > 0 then
  begin
    AFindCode := UpperCase(AFindCode);
    if AFindCode[1] = 'C' then  //латинска€
      AFindCode[1] := '—';      //кирилица
  end;
  Result := AFindCode;
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
  //ѕросто несущиствующий тип, что-бы запрос ничего не вернул
  if TmpStr = '' then
    TmpStr := '-1';

  if FPriceColumn then
    Result := 'SELECT material.material_id as "Id", mat_code as "Code", ' +
          'cast(mat_name as char(1024)) as "Name", unit_name as "Unit", ' +
          'coast' + IntToStr(cmbRegion.ItemIndex + 1) + '_2 as "PriceVAT", ' +
          'coast' + IntToStr(cmbRegion.ItemIndex + 1) + '_1 as "PriceNotVAT", ' +
          'MAT_TYPE ' +
          'FROM material LEFT JOIN units ON (material.unit_id = units.unit_id) ' +
          'LEFT JOIN materialcoastg mc ON (material.material_id = mc.material_id) ' +
          'and (year = ' + IntToStr(edtYear.Value) + ') AND (monat = ' +
          IntToStr(cmbMonth.ItemIndex + 1) + ') WHERE (material.MAT_TYPE IN (' +
          TmpStr + ')) ORDER BY mat_code;'
  else
    Result := 'SELECT material.material_id as "Id", mat_code as "Code", ' +
          'cast(mat_name as char(1024)) as "Name", unit_name as "Unit", ' +
          'MAT_TYPE FROM material left join units on (material.unit_id = units.unit_id) ' +
          'WHERE (material.MAT_TYPE in (' + TmpStr + ')) ORDER BY mat_code;';
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

function TSprMaterial.CheckByffer: Boolean;
begin
  if (G_MATBYFFER.Mat = cbMat.Checked) and
     (G_MATBYFFER.JBI = cbJBI.Checked) and
     (G_MATBYFFER.Region = cmbRegion.ItemIndex + 1) and
     (G_MATBYFFER.Month = cmbMonth.ItemIndex + 1) and
     (G_MATBYFFER.Year = edtYear.Value) then
  begin
    OnLoadStart;
    Application.ProcessMessages;
    try
      TMatSprByffer.CopyByffer(@G_MATBYFFER.SprArray, @FSprArray);
      FillSprList(edtFindCode.Text, edtFindName.Text);
    finally
      OnLoadDone;
      Result := True;
    end;
  end
  else
    Result := False;
end;

procedure TSprMaterial.UpdateByffer;
begin
  G_MATBYFFER.Mat := cbMat.Checked;
  G_MATBYFFER.JBI := cbJBI.Checked;
  G_MATBYFFER.Region := cmbRegion.ItemIndex + 1;
  G_MATBYFFER.Month := cmbMonth.ItemIndex + 1;
  G_MATBYFFER.Year := edtYear.Value;
  TMatSprByffer.CopyByffer(@FSprArray, @G_MATBYFFER.SprArray);
end;

end.
