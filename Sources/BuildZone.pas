unit BuildZone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, JvExStdCtrls, JvCombobox,
  JvDBCombobox, JvExControls, JvDBLookup;

type
  TfBuildZone = class(TForm)
    Panel1: TPanel;
    gbZone: TGroupBox;
    grdZone: TJvDBGrid;
    gbDescript: TGroupBox;
    DBMemo1: TDBMemo;
    dsObjRegion: TDataSource;
    qrObjRegion: TFDQuery;
    qrRegionObject: TFDQuery;
    dsRegionObject: TDataSource;
    qrRegionObjectID_OBL: TIntegerField;
    qrRegionObjectNAME: TStringField;
    qrRegionObjectNUM: TIntegerField;
    qrRegions: TFDQuery;
    gbObject: TGroupBox;
    Panel3: TPanel;
    cbRegions: TComboBox;
    grdObject: TJvDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure qrRegionObjectCalcFields(DataSet: TDataSet);
    procedure cbRegionsChange(Sender: TObject);
    procedure qrObjRegionAfterScroll(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private
    FRefID: TStringList;
    { Private declarations }
  public
    { Public declarations }
  end;


implementation
uses DataModule, Tools;

{$R *.dfm}

procedure TfBuildZone.FormCreate(Sender: TObject);
begin
  LoadDBGridSettings(grdZone);
  LoadDBGridSettings(grdObject);

  FRefID := TStringList.Create;
  cbRegions.Items.Clear;
  CloseOpen(qrRegions);
  while  not qrRegions.Eof do
  begin
    FRefID.Add(IntToStr(qrRegions.FieldByName('REGION_ID').AsInteger));
    cbRegions.Items.Add(qrRegions.FieldByName('REGION_NAME').AsString);
    qrRegions.Next;
  end;
  qrRegions.Close;

  if cbRegions.Items.Count > 0 then
    cbRegions.ItemIndex := 0;

  CloseOpen(qrObjRegion);
  CloseOpen(qrRegionObject);
  qrObjRegionAfterScroll(qrObjRegion);
  Refresh;
end;

procedure TfBuildZone.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FRefID);
end;

procedure TfBuildZone.cbRegionsChange(Sender: TObject);
begin
  if cbRegions.ItemIndex = -1 then
    Exit;

  if qrObjRegion.FieldByName('OBJ_REGION_ID').Value  = 2 then
  begin
    qrRegionObject.Filtered := False;
    qrRegionObject.Filter := 'ID_OBL = ' + FRefID[cbRegions.ItemIndex];
    qrRegionObject.Filtered := True;
  end
  else
    qrRegionObject.Filtered := False;
end;

procedure TfBuildZone.qrObjRegionAfterScroll(DataSet: TDataSet);
begin
  if qrObjRegion.FieldByName('OBJ_REGION_ID').Value  = 2 then
  begin
    Panel3.Visible := True;
    gbObject.Caption := ' Перечень районов ';
  end
  else
  begin
    Panel3.Visible := False;
    gbObject.Caption := ' Перечень городов ';
  end;

  cbRegionsChange(cbRegions);
end;

procedure TfBuildZone.qrRegionObjectCalcFields(DataSet: TDataSet);
begin
  qrRegionObjectNUM.AsInteger := qrRegionObject.RecNo;
  if (qrRegionObjectNUM.AsInteger = 0) and (qrRegionObject.Bof) then
    qrRegionObjectNUM.AsInteger := 1;
end;

end.
