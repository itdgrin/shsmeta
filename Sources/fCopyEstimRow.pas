unit fCopyEstimRow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, JvExComCtrls, JvDBTreeView,
  Tools;

type
  TFormCopyEstimRow = class(TSmForm)
    pnlLeft: TPanel;
    pnlRigth: TPanel;
    gbObjects: TGroupBox;
    gbTreeData: TGroupBox;
    gbRate: TGroupBox;
    qrObjects: TFDQuery;
    dsObjects: TDataSource;
    dbgrdObjects: TJvDBGrid;
    qrTreeData: TFDQuery;
    dsTreeData: TDataSource;
    tvEstimates: TJvDBTreeView;
    qrRatesEx: TFDQuery;
    strngfldRatesExSORT_ID: TStringField;
    qrRatesExITERATOR: TIntegerField;
    qrRatesExOBJ_CODE: TStringField;
    qrRatesExOBJ_NAME: TStringField;
    qrRatesExOBJ_UNIT: TStringField;
    qrRatesExID_TYPE_DATA: TIntegerField;
    qrRatesExDATA_ESTIMATE_OR_ACT_ID: TIntegerField;
    qrRatesExID_TABLES: TIntegerField;
    qrRatesExSM_ID: TIntegerField;
    qrRatesExWORK_ID: TIntegerField;
    qrRatesExZNORMATIVS_ID: TIntegerField;
    qrRatesExAPPLY_WINTERPRISE_FLAG: TShortintField;
    qrRatesExID_RATE: TIntegerField;
    qrRatesExOBJ_COUNT: TFloatField;
    qrRatesExADDED_COUNT: TIntegerField;
    qrRatesExREPLACED_COUNT: TIntegerField;
    qrRatesExINCITERATOR: TIntegerField;
    strngfldRatesExSORT_ID2: TStringField;
    qrRatesExNUM_ROW: TIntegerField;
    qrRatesExID_REPLACED: TIntegerField;
    qrRatesExCONS_REPLASED: TIntegerField;
    qrRatesExCOEF_ORDERS: TIntegerField;
    qrRatesExNOM_ROW_MANUAL: TIntegerField;
    qrRatesExMarkRow: TShortintField;
    dsRatesEx: TDataSource;
    grRatesEx: TJvDBGrid;
    SplitterCenter: TSplitter;
    Splitter1: TSplitter;
    procedure qrObjectsBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure qrObjectsAfterScroll(DataSet: TDataSet);
    procedure qrTreeDataAfterScroll(DataSet: TDataSet);
    procedure grRatesExDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure qrRatesExAfterOpen(DataSet: TDataSet);
    procedure qrRatesExCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses Main, GlobsAndConst, DataModule;

{$R *.dfm}

procedure TFormCopyEstimRow.FormShow(Sender: TObject);
begin
  CloseOpen(qrObjects);
end;

procedure TFormCopyEstimRow.grRatesExDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    with grRatesEx.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    if qrRatesExID_TYPE_DATA.AsInteger = -3 then
      Brush.Color := clSilver;
    if qrRatesExID_TYPE_DATA.AsInteger = -1 then
    begin
      Font.Style := Font.Style + [fsBold];
      Brush.Color := clSilver;
    end;
    if (qrRatesExID_TYPE_DATA.AsInteger = -4) or
       (qrRatesExID_TYPE_DATA.AsInteger = -5) then
    begin
      Font.Color := PS.FontRows;
      Brush.Color := clInactiveBorder;
    end;

    // ��������� ��������� ����� ��� ������������� �������
    if Column.Index = 0 then
      Brush.Color := grRatesEx.FixedColor;

    // ������������ �������� � ������������ �����������/�����������
    if qrRatesExADDED_COUNT.Value > 0 then
      Font.Color := clBlue;
    // ��������� �������������� ���-��
    if qrRatesExOBJ_COUNT.Value < 0 then
      Font.Color := clRed;
    // ��������� ���������� �����
    if qrRatesExMarkRow.Value > 0 then
      Font.Color := clPurple;
    // ��������� ���������
    if (grRatesEx.SelectedRows.CurrentRowSelected) and
       (grRatesEx.SelectedRows.Count > 1) then
      Font.Color := $008080FF;

    if Assigned(TMyDBGrid(grRatesEx).DataLink) and
      (grRatesEx.Row = TMyDBGrid(grRatesEx).DataLink.ActiveRecord + 1)
    // and (grRatesEx = LastEntegGrd) // �������������� ������ ������ ���� ���� �����
    then
    begin
      Font.Style := Font.Style + [fsBold];
    end;

    if gdFocused in State then // ������ � ������
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    if qrRatesExREPLACED_COUNT.Value > 0 then
      Font.Style := Font.Style + [fsItalic];

    (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFormCopyEstimRow.qrObjectsAfterScroll(DataSet: TDataSet);
begin
  qrTreeData.ParamByName('OBJ_ID').Value := qrObjects.FieldByName('obj_id').Value;
  CloseOpen(qrTreeData);
end;

procedure TFormCopyEstimRow.qrTreeDataAfterScroll(DataSet: TDataSet);
begin
  qrRatesEx.ParamByName('EAID').Value := qrTreeData.FieldByName('SM_ID').Value;
  CloseOpen(qrRatesEx);
  grRatesEx.SelectedRows.Clear;
end;

procedure TFormCopyEstimRow.qrObjectsBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('USER_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('USER_ID').Value := G_USER_ID;
end;

procedure TFormCopyEstimRow.qrRatesExAfterOpen(DataSet: TDataSet);
var
  NumPP: Integer;
  Key: Variant;
begin
  if not CheckQrActiveEmpty(qrRatesEx) then
    Exit;
  Key := qrRatesEx.FieldByName('SORT_ID').Value;
  // ������������� ���
  qrRatesEx.DisableControls;
  qrRatesEx.OnCalcFields := nil;
  NumPP := 0;
  try
    qrRatesEx.First;
    while not qrRatesEx.Eof do
    begin
      NumPP := NumPP + qrRatesEx.FieldByName('INCITERATOR').AsInteger;
      qrRatesEx.Edit;
      if qrRatesEx.FieldByName('ID_TYPE_DATA').AsInteger < 0 then
        qrRatesEx.FieldByName('ITERATOR').Value := Null
      else
        qrRatesEx.FieldByName('ITERATOR').AsInteger := NumPP;
      qrRatesEx.Next;
    end;
  finally
    qrRatesEx.OnCalcFields := qrRatesExCalcFields;
    qrRatesEx.Locate('SORT_ID', Key, []);
    qrRatesEx.EnableControls;
    // grRatesEx.SelectedRows.Clear;
  end;
end;

procedure TFormCopyEstimRow.qrRatesExCalcFields(DataSet: TDataSet);
// ������� ������� ������� ����������� ����������/���������� � ��������
  function GetAddedCount(const ID_CARD_RATE: Integer): Integer;
  begin
    Result := 0;
    DM.qrDifferent.SQL.Text :=
      'SELECT ADDED FROM materialcard WHERE ID_CARD_RATE=:ID_CARD_RATE AND ADDED=1 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('ADDED').AsInteger;
    // ���� ��� ��� �� �����, �� ����� ������ �� ����������� ������ ��������
    if Result > 0 then
      Exit;
    DM.qrDifferent.SQL.Text :=
      'SELECT ADDED FROM mechanizmcard WHERE ID_CARD_RATE=:ID_CARD_RATE AND ADDED=1 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('ADDED').AsInteger;
    DM.qrDifferent.Active := False;
  end;
  function GetReplacedCount(const ID_CARD_RATE: Integer): Integer;
  begin
    Result := 0;
    DM.qrDifferent.SQL.Text :=
      'SELECT 1 AS R FROM materialcard WHERE ID_CARD_RATE=:ID_CARD_RATE AND ID_REPLACED>0 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('R').AsInteger;
    // ���� ��� ��� �� �����, �� ����� ������ �� ����������� ������ ��������
    if Result > 0 then
      Exit;
    DM.qrDifferent.SQL.Text :=
      'SELECT 1 AS R FROM mechanizmcard WHERE ID_CARD_RATE=:ID_CARD_RATE AND ID_REPLACED>0 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('R').AsInteger;
    DM.qrDifferent.Active := False;
  end;

begin
  if not CheckQrActiveEmpty(qrRatesEx) then
    Exit;

  if qrRatesExID_TYPE_DATA.Value = 1 then
    qrRatesExADDED_COUNT.Value := GetAddedCount(qrRatesExID_TABLES.Value);

  if qrRatesExID_TYPE_DATA.Value = 1 then
    qrRatesExREPLACED_COUNT.Value := GetReplacedCount(qrRatesExID_TABLES.Value);
end;

end.
