unit Transportation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Grids,
  ExtCtrls, DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Clipbrd, JvExGrids, JvStringGrid, JvJCLUtils;

type
  TJvStringGrid = class(JvStringGrid.TJvStringGrid)
  public
    procedure DefaultDrawCell(AColumn, ARow: Longint;
      Rect: TRect; State: TGridDrawState); override;
  end;

  TFormTransportation = class(TForm)
    Panel1: TPanel;
    EditJustificationNumber: TEdit;
    LabelJustification: TLabel;
    EditJustification: TEdit;
    Bevel1: TBevel;
    ButtonCancel: TButton;
    Panel2: TPanel;
    PanelBottom: TPanel;
    qrTemp: TFDQuery;
    Label7: TLabel;
    Label9: TLabel;
    edtPriceNoNDS: TEdit;
    Label8: TLabel;
    edtPriceNDS: TEdit;
    grbGruz: TGroupBox;
    Label6: TLabel;
    cmbUnit: TComboBox;
    Label1: TLabel;
    edtCount: TEdit;
    LabelMass: TLabel;
    edtYDW: TEdit;
    Label2: TLabel;
    cmbClass: TComboBox;
    ButtonAdd: TButton;
    EditDistance: TEdit;
    LabelDistance: TLabel;
    grbKoef: TGroupBox;
    cmbKoef: TComboBox;
    Panel3: TPanel;
    cbKoef: TCheckBox;
    grdPrice: TJvStringGrid;

    procedure FormShow(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure cmbUnitChange(Sender: TObject);
    procedure CalculationTransp;
    procedure GetCoast;
    procedure edtCountChange(Sender: TObject);
    procedure EditDistanceChange(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure cmbKoefMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure cmbKoefDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure grdPriceGetCellAlignment(Sender: TJvStringGrid; AColumn,
      ARow: Integer; State: TGridDrawState; var CellAlignment: TAlignment);
    procedure grdPriceSetCanvasProperties(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure grdPriceSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EditExit(Sender: TObject);
    procedure grdPriceKeyPress(Sender: TObject; var Key: Char);
    procedure grdPriceExitCell(Sender: TJvStringGrid; AColumn, ARow: Integer;
      const EditText: string);
    procedure cbKoefClick(Sender: TObject);
    procedure cmbKoefChange(Sender: TObject);
  private
    const CaptionForm = '��������� ������';
      CCoastNoNDS = 1;
      CCoastNDS = 2;
      CPriceNoNDS = 3;
      CNDS = 4;
      CPriceNDS = 5;

  private
    //����� � ��� ��������
    EstMonth,
    EstYear: integer;

    JustNumber: string;
    //����� ����� � ������
    TranspCount,
    CCount,
    Ydw: extended;
    //���� �� �������
    CoastNoNds,
    CoastNds: Double;
    Nds,
    DefNDS: integer;
    Distance: integer;
    //����� �����
    FClass: Byte;
    //���� ��������������� ������������ ������ ��� �������� ���� �� ����
    Loading: boolean;
    FCoef: Double;

    KoefLis: array of Double;
    procedure LoadKoef;
    procedure GetEstimateInfo(aIdEstimate: integer);
    procedure LoadTranspInfo(aIdTransp: integer);
    procedure CalcPrice;
  public
    IdEstimate: integer; // ID ����� � ������� ���������
    IdTransp: integer; // ID ���������� � �����
    TranspType: integer;
    InsMode: boolean; // ������� �������������
    IsSaved: boolean;
  end;

  // ����� ���� ����������. InsMode - ������� �������������  � �����
function GetTranspForm(IdEstimate, IdTransp, TranspType: integer; InsMode: boolean): boolean;

implementation

uses Main, CalculationEstimate, DataModule;

{$R *.dfm}

function GetTranspForm(IdEstimate, IdTransp, TranspType: integer; InsMode: boolean): boolean;
var
  FormTransp: TFormTransportation;
begin
  //Result := false;
  FormTransp := TFormTransportation.Create(nil);
  try
    FormTransp.IdEstimate := IdEstimate;
    FormTransp.IdTransp := IdTransp;
    FormTransp.InsMode := InsMode;
    FormTransp.TranspType := TranspType;
    FormTransp.IsSaved := false;
    FormTransp.ShowModal;
    Result := FormTransp.IsSaved;
  finally
    FormTransp.Free;
  end;
end;

procedure TFormTransportation.CalculationTransp;
begin
  //������ ��� ������ ����������� �������� �� ���� ������,
  //���-�� �� ��������� �����������
  if trim(edtCount.Text) = '' then
    CCount := 0
  else
  begin
    if edtCount.Text[length(edtCount.Text)] = '.' then
    begin
      CCount := StrToFloatDef(copy(edtCount.Text, 1, length(edtCount.Text) - 1), 0);
    end
    else
      CCount := StrToFloatDef(edtCount.Text, 0);
  end;

  if trim(edtYDW.Text) = '' then
    Ydw := 0
  else
  begin
    if edtYDW.Text[length(edtYDW.Text)] = '.' then
    begin
      Ydw := StrToFloatDef(copy(edtYDW.Text, 1, length(edtYDW.Text) - 1), 0);
    end
    else
      Ydw := StrToFloatDef(edtYDW.Text, 0);
  end;

  if 0 = cmbUnit.ItemIndex then
    TranspCount := CCount
  else
    TranspCount := (CCount * Ydw) / 1000;

  CalcPrice;

  if grdPrice.Cells[CNDS, FClass] = '' then
    Nds := 0
  else
    Nds := StrToInt(grdPrice.Cells[CNDS, FClass]);

  if grdPrice.Cells[CCoastNoNDS, FClass] = '' then
     CoastNoNds := 0
  else
    CoastNoNds := StrToFloat(grdPrice.Cells[CCoastNoNDS, FClass]);

  if grdPrice.Cells[CCoastNDS, FClass] = '' then
     CoastNds := 0
  else
    CoastNds := StrToFloat(grdPrice.Cells[CCoastNDS, FClass]);

  edtPriceNoNDS.Text := grdPrice.Cells[CPriceNoNDS, FClass];
  edtPriceNDS.Text := grdPrice.Cells[CPriceNDS, FClass];

  grdPrice.Repaint;
end;

procedure TFormTransportation.ButtonAddClick(Sender: TObject);
begin
  if InsMode then
  begin
    qrTemp.Active := false;
    qrTemp.SQL.Text := 'Insert into transpcard_temp (TRANSP_TYPE,TRANSP_CODE_JUST,' +
      'TRANSP_JUST,TRANSP_COUNT,TRANSP_DIST,TRANSP_SUM_NDS,TRANSP_SUM_NO_NDS,' +
      'COAST_NO_NDS,COAST_NDS,CARG_CLASS,CARG_UNIT,CARG_TYPE,CARG_COUNT,CARG_YDW,' +
      'NDS,PRICE_NDS,PRICE_NO_NDS,KOEF) values (' + ':TRANSP_TYPE,:TRANSP_CODE_JUST,' +
      ':TRANSP_JUST,:TRANSP_COUNT,:TRANSP_DIST,:TRANSP_SUM_NDS,:TRANSP_SUM_NO_NDS,' +
      ':COAST_NO_NDS,:COAST_NDS,:CARG_CLASS,:CARG_UNIT,:CARG_TYPE,:CARG_COUNT,:CARG_YDW,' +
      ':NDS,:PRICE_NDS,:PRICE_NO_NDS,:KOEF)';
    qrTemp.ParamByName('TRANSP_TYPE').Value := TranspType;
    qrTemp.ParamByName('TRANSP_CODE_JUST').Value := EditJustificationNumber.Text;
    qrTemp.ParamByName('TRANSP_JUST').Value := EditJustification.Text;
    qrTemp.ParamByName('TRANSP_COUNT').Value := TranspCount;
    qrTemp.ParamByName('TRANSP_DIST').Value := Distance;
    qrTemp.ParamByName('TRANSP_SUM_NDS').Value := StrToInt64(edtPriceNDS.Text);;
    qrTemp.ParamByName('TRANSP_SUM_NO_NDS').Value := StrToInt64(edtPriceNoNDS.Text);
    qrTemp.ParamByName('COAST_NO_NDS').Value := CoastNoNds;
    qrTemp.ParamByName('COAST_NDS').Value := CoastNds;
    qrTemp.ParamByName('CARG_CLASS').Value := cmbClass.ItemIndex;
    qrTemp.ParamByName('CARG_UNIT').Value := cmbUnit.Text;
    qrTemp.ParamByName('CARG_TYPE').Value := cmbUnit.ItemIndex;
    qrTemp.ParamByName('CARG_COUNT').Value := CCount;
    qrTemp.ParamByName('CARG_YDW').Value := Ydw;
    qrTemp.ParamByName('NDS').Value := Nds;
    qrTemp.ParamByName('PRICE_NDS').Value := StrToInt64(edtPriceNDS.Text);
    qrTemp.ParamByName('PRICE_NO_NDS').Value := StrToInt64(edtPriceNoNDS.Text);
    qrTemp.ParamByName('KOEF').Value := FCoef;

    qrTemp.ExecSQL;

    qrTemp.SQL.Text := 'INSERT INTO data_estimate_temp ' + '(id_estimate, id_type_data, id_tables) VALUE ' +
      '(' + IntToStr(IdEstimate) + ', ' + IntToStr(TranspType) + ', (SELECT max(id) FROM transpcard_temp));';

    qrTemp.ExecSQL;
  end
  else
  begin
    qrTemp.Active := false;
    qrTemp.SQL.Text := 'Update transpcard_temp set TRANSP_TYPE=:TRANSP_TYPE,' +
      'TRANSP_CODE_JUST=:TRANSP_CODE_JUST,TRANSP_JUST=:TRANSP_JUST,' +
      'TRANSP_COUNT=:TRANSP_COUNT,TRANSP_DIST=:TRANSP_DIST,' +
      'TRANSP_SUM_NDS=:TRANSP_SUM_NDS,TRANSP_SUM_NO_NDS=:TRANSP_SUM_NO_NDS,' +
      'COAST_NO_NDS=:COAST_NO_NDS,COAST_NDS=:COAST_NDS,CARG_CLASS=:CARG_CLASS,' +
      'CARG_UNIT=:CARG_UNIT,CARG_TYPE=:CARG_TYPE,CARG_COUNT=:CARG_COUNT,' +
      'CARG_YDW=:CARG_YDW,NDS=:NDS,PRICE_NDS=:PRICE_NDS,' +
      'PRICE_NO_NDS=:PRICE_NO_NDS,KOEF=:KOEF where ID = :ID';
    qrTemp.ParamByName('TRANSP_TYPE').Value := TranspType;
    qrTemp.ParamByName('TRANSP_CODE_JUST').Value := EditJustificationNumber.Text;
    qrTemp.ParamByName('TRANSP_JUST').Value := EditJustification.Text;
    qrTemp.ParamByName('TRANSP_COUNT').Value := TranspCount;
    qrTemp.ParamByName('TRANSP_DIST').Value := Distance;
    qrTemp.ParamByName('TRANSP_SUM_NDS').Value := StrToInt64(edtPriceNDS.Text);;
    qrTemp.ParamByName('TRANSP_SUM_NO_NDS').Value := StrToInt64(edtPriceNoNDS.Text);
    qrTemp.ParamByName('COAST_NO_NDS').Value := CoastNoNds;
    qrTemp.ParamByName('COAST_NDS').Value := CoastNds;
    qrTemp.ParamByName('CARG_CLASS').Value := cmbClass.ItemIndex;
    qrTemp.ParamByName('CARG_UNIT').Value := cmbUnit.Text;
    qrTemp.ParamByName('CARG_TYPE').Value := cmbUnit.ItemIndex;
    qrTemp.ParamByName('CARG_COUNT').Value := CCount;
    qrTemp.ParamByName('CARG_YDW').Value := Ydw;
    qrTemp.ParamByName('NDS').Value := Nds;
    qrTemp.ParamByName('PRICE_NDS').Value := StrToInt64(edtPriceNDS.Text);
    qrTemp.ParamByName('PRICE_NO_NDS').Value := StrToInt64(edtPriceNoNDS.Text);
    qrTemp.ParamByName('ID').Value := IdTransp;
    qrTemp.ParamByName('KOEF').Value := FCoef;

    qrTemp.ExecSQL;
  end;
  IsSaved := true;
  ButtonCancelClick(Sender);
end;

procedure TFormTransportation.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormTransportation.cmbUnitChange(Sender: TObject);
begin
  if Loading then
    exit;

  edtYDW.Enabled := (0 <> cmbUnit.ItemIndex);
  CalculationTransp;
end;

procedure TFormTransportation.cbKoefClick(Sender: TObject);
begin
  if Loading then
    Exit;

  cmbKoef.Enabled := cbKoef.Checked;
  if cbKoef.Checked then
  begin
    cmbKoef.ItemIndex := 0;
    FCoef := KoefLis[cmbKoef.ItemIndex];
  end
  else
  begin
    cmbKoef.ItemIndex := -1;
    FCoef := 1;
  end;
  CalculationTransp;
end;

procedure TFormTransportation.cmbKoefChange(Sender: TObject);
begin
  if Loading then
    Exit;

  FCoef := KoefLis[cmbKoef.ItemIndex];
  CalculationTransp;
end;

procedure TFormTransportation.cmbKoefDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  ItemString: string;
begin
  TComboBox(Control).Canvas.FillRect(Rect);
  ItemString := TComboBox(Control).Items.Strings[Index];
  Rect.Left := Rect.Left + 2;
  Rect.Width := Rect.Width - 2;
  DrawText(TComboBox(Control).Canvas.Handle, PChar(ItemString), -1, Rect, DT_WORDBREAK);
end;

procedure TFormTransportation.cmbKoefMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
var
  ItemString: string;
  MyRect: TRect;
  MyImage: TImage;
  MyCombo: TComboBox;
begin
  // Don't waste time with this on Index = -1
  if (Index > -1) then
  begin
    MyCombo := TComboBox(Control);
    // Create a temporary canvas to calculate the height
    MyImage := TImage.Create(MyCombo);
    try
      MyRect := MyCombo.ClientRect;
      MyRect.Left := MyRect.Left + 2;
      MyRect.Width := MyRect.Width - 2;
      ItemString := MyCombo.Items.Strings[Index];
      MyImage.Canvas.Font := MyCombo.Font;
      // Calc. using this ComboBox's font size
      Height := DrawText(MyImage.Canvas.Handle, PChar(ItemString),
        -1, MyRect, DT_CALCRECT or DT_WORDBREAK);
    finally
      MyImage.Free;
    end;
  end;
end;

// ���������� ����������� ���������� �� �����
procedure TFormTransportation.GetEstimateInfo(aIdEstimate: integer);
begin
  try
    qrTemp.SQL.Text := 'SELECT monat as "Month", year as "Year" FROM stavka WHERE ' +
      'stavka_id = (SELECT stavka_id From smetasourcedata ' + 'WHERE sm_id = ' + IntToStr(aIdEstimate) + ');';
    qrTemp.Active := true;
    EstMonth := qrTemp.FieldByName('Month').AsInteger;
    EstYear := qrTemp.FieldByName('Year').AsInteger;
    qrTemp.Active := false;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ������ �� ����� �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormTransportation.grdPriceExitCell(Sender: TJvStringGrid; AColumn,
  ARow: Integer; const EditText: string);
var TmpNds: Integer;
    TmpCoastNds,
    TmpCoastNoNds: Double;
begin
  if (AColumn = CCoastNoNDS) or
     (AColumn = CCoastNDS) or
     (AColumn = CNDS) then
  begin
    if trim(grdPrice.Cells[CNDS, FClass]) = '' then
      TmpNds := 0
    else
      TmpNds := StrToInt(grdPrice.Cells[CNDS, FClass]);
    grdPrice.Cells[CNDS, FClass] := IntToStr(TmpNds);

    if trim(grdPrice.Cells[CCoastNoNDS, FClass]) = '' then
      TmpCoastNoNds := 0
    else
      TmpCoastNoNds := StrToFloat(grdPrice.Cells[CCoastNoNDS, FClass]);
    grdPrice.Cells[CCoastNoNDS, FClass] := FloatToStr(TmpCoastNoNds);

    if trim(grdPrice.Cells[CCoastNDS, FClass]) = '' then
      TmpCoastNds := 0
    else
      TmpCoastNds := StrToFloat(grdPrice.Cells[CCoastNDS, FClass]);
    grdPrice.Cells[CCoastNDS, FClass] := FloatToStr(TmpCoastNds);

    if (AColumn = CCoastNoNDS) or (AColumn = CNDS)then
      grdPrice.Cells[CCoastNDS, FClass] :=
        FloatToStr(NoNDSToNDS(Trunc(TmpCoastNoNds), TmpNds));

    if (AColumn = CCoastNDS) then
      grdPrice.Cells[CCoastNoNDS, FClass] :=
        FloatToStr(NDSToNoNDS(Trunc(TmpCoastNds), TmpNds));

    CalculationTransp;
  end;
end;

procedure TFormTransportation.grdPriceGetCellAlignment(Sender: TJvStringGrid;
  AColumn, ARow: Integer; State: TGridDrawState; var CellAlignment: TAlignment);
begin
  //����� ������������� �� ������, ��������� �� ������� ����
  if (ARow = 0) or (AColumn = 0) then
    CellAlignment := TAlignment.taCenter
  else
    CellAlignment := TAlignment.taRightJustify;
end;

procedure TFormTransportation.grdPriceKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '0'..'9',#8,#13: ;
     else Key:= #0;
  end;
end;

procedure TFormTransportation.grdPriceSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  //��������� ������������� ������� ���� � ���
  if (ARow = FClass) and (
     (ACol = CCoastNoNDS) or
     (ACol = CCoastNDS) or
     (ACol = CNDS)) then
    grdPrice.Options := grdPrice.Options + [goEditing]
  else
    grdPrice.Options := grdPrice.Options - [goEditing];
end;

procedure TFormTransportation.grdPriceSetCanvasProperties(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  //��������� ������ �������� ������
  if (ARow = FClass) and
    (FClass > 0) and
    (ACol > 0) and
    not((ARow = grdPrice.Row) and (ACol = grdPrice.Col)) then
    grdPrice.Canvas.Brush.Color := $0080FFFF;
end;

procedure TFormTransportation.EditDistanceChange(Sender: TObject);
begin
  if Loading then
    exit;

  if (EditDistance.Text <> '') and (StrToInt(EditDistance.Text) > 0) then
    EditJustificationNumber.Text := JustNumber + '-' + EditDistance.Text
  else
    EditJustificationNumber.Text := JustNumber;

  GetCoast;
  CalculationTransp;
end;

procedure TFormTransportation.EditKeyPress(Sender: TObject; var Key: Char);
var s: string;
    f: Double;
begin
  if CharInSet(Key, [^C, ^X, ^Z]) then
      Exit;

  if (Key = ^V) then
  begin
    //�������� �� ������������ ������������ ������
    if TryStrToFloat(Clipboard.AsText, f) then
    begin
      s :=
        Copy(TEdit(Sender).Text, 1,
          TEdit(Sender).SelStart) + Clipboard.AsText +
          Copy(TEdit(Sender).Text, TEdit(Sender).SelStart +
            TEdit(Sender).SelLength + 1, Length(TEdit(Sender).Text) -
            TEdit(Sender).SelStart - TEdit(Sender).SelLength);
      if TryStrToFloat(s, f) then
        Exit;
    end;
  end;

  case Key of
    '0'..'9',#8: ;
    '.',',':
     begin
       Key := FormatSettings.DecimalSeparator;
       if (pos(FormatSettings.DecimalSeparator, TEdit(Sender).Text) <> 0) or
          (TEdit(Sender).Text = '') then
        Key:= #0;
     end;
     else Key:= #0;
  end;
end;

procedure TFormTransportation.edtCountChange(Sender: TObject);
begin
  if Loading then
    exit;
  CalculationTransp;
end;

procedure TFormTransportation.EditExit(Sender: TObject);
var s: string;
begin
  if (Length(TEdit(Sender).Text) > 0) and
    (TEdit(Sender).Text[High(TEdit(Sender).Text)] = FormatSettings.DecimalSeparator) then
  begin
    s := TEdit(Sender).Text;
    SetLength(s, Length(s) - 1);
    TEdit(Sender).Text := s;
  end;

  if TEdit(Sender).Text = '' then
    TEdit(Sender).Text := '0';
end;

procedure TFormTransportation.FormCreate(Sender: TObject);
begin
  grdPrice.RowHeights[0] := 30;

  grdPrice.ColWidths[0] := 40;
  grdPrice.Cells[0,0] := '�����';
  grdPrice.Cells[0,1] := 'I';
  grdPrice.Cells[0,2] := 'II';
  grdPrice.Cells[0,3] := 'III';
  grdPrice.Cells[0,4] := 'IV';
  grdPrice.ColWidths[CCoastNoNDS] := 100;
  grdPrice.Cells[CCoastNoNDS,0] := '���� �� �/�3' + sLineBreak + '��� ���, ���.';
  grdPrice.ColWidths[CCoastNDS] := 100;
  grdPrice.Cells[CCoastNDS,0] := '���� �� �/�3' + sLineBreak + '� ���, ���.';
  grdPrice.ColWidths[CPriceNoNDS] := 100;
  grdPrice.Cells[CPriceNoNDS,0] := '���������' + sLineBreak + '��� ���, ���.';
  grdPrice.ColWidths[CNDS] := 50;
  grdPrice.Cells[CNDS,0] := '���, %';
  grdPrice.ColWidths[CPriceNDS] := 100;
  grdPrice.Cells[CPriceNDS,0] := '���������' + sLineBreak + '� ���, ���.';

  //�� ��������� ��� 20%
  DefNDS := 20;
  FClass := cmbClass.ItemIndex + 1;
  FCoef := 1;
end;

procedure TFormTransportation.LoadKoef;
var i: Integer;
begin
  cmbKoef.Items.Clear;
  SetLength(KoefLis, 0);

  qrTemp.Active := false;
  qrTemp.SQL.Text := 'SELECT koef,description FROM transferkoef';
  qrTemp.Active := true;
  while not qrTemp.Eof do
  begin
    i := cmbKoef.Items.Add(qrTemp.Fields[0].AsString + '  ' + qrTemp.Fields[1].AsString);
    SetLength(KoefLis, i + 1);
    KoefLis[i] := qrTemp.Fields[0].AsFloat;
    qrTemp.Next;
  end;
  qrTemp.Active := false;
end;

procedure TFormTransportation.FormShow(Sender: TObject);
begin
  Loading := false;
  //���������� ����� ������ �� �����
  GetEstimateInfo(IdEstimate);
  LoadKoef;

  if TranspType in [6, 7] then
    JustNumber := 'C310';
  if TranspType in [8, 9] then
    JustNumber := 'C311';

  if InsMode then //���������� ������
  begin
    case TranspType of
      6:
        begin
          EditJustificationNumber.Text := 'C310';
          EditJustification.Text := '��������� ������ ������������ � ����������� C310';
        end;
      7:
        begin
          EditJustificationNumber.Text := 'C310';
          EditJustification.Text := '��������� ������ ������������ � ����������� C310';
        end;
      8:
        begin
          EditJustificationNumber.Text := 'C311';
          EditJustification.Text := '��������� ������ ������������ � ����������� C311';
        end;
      9:
        begin
          EditJustificationNumber.Text := 'C311';
          EditJustification.Text := '��������� ������ ������������ - ����������� C311';
        end;
    else
      raise Exception.Create('����������� ��� ���������� (' + IntToStr(TranspType) + ')');
    end;

    edtYDW.Enabled := (0 <> cmbUnit.ItemIndex);
    edtCount.Text := FloatToStr(CCount);
    edtYDW.Text := FloatToStr(Ydw);
    EditDistance.Text := IntToStr(Distance);
    if TranspType in [7, 9] then
      cmbClass.Enabled := false;
    GetCoast;
    CalculationTransp;
  end
  else  //����� �������������� ��� ���������
  begin
    LoadTranspInfo(IdTransp);
    ButtonAdd.Caption := '���������';
  end;

  EditDistance.SetFocus;
end;

procedure TFormTransportation.LoadTranspInfo(aIdTransp: integer);
var i : integer;
begin
  Loading := true;
  try
    qrTemp.Active := false;
    qrTemp.SQL.Text := 'SELECT * FROM transpcard_temp WHERE (ID = ' + IntToStr(aIdTransp) + ');';
    qrTemp.Active := true;

    EditJustificationNumber.Text := qrTemp.FieldByName('TRANSP_CODE_JUST').AsString;
    EditJustification.Text := qrTemp.FieldByName('TRANSP_JUST').AsString;
    EditDistance.Text := qrTemp.FieldByName('TRANSP_DIST').AsString;
    cmbClass.ItemIndex := qrTemp.FieldByName('CARG_CLASS').AsInteger;
    FClass := cmbClass.ItemIndex + 1;
    cmbUnit.ItemIndex := qrTemp.FieldByName('CARG_TYPE').AsInteger;
    edtCount.Text := qrTemp.FieldByName('CARG_COUNT').AsString;
    edtYDW.Text := qrTemp.FieldByName('CARG_YDW').AsString;

    TranspType := qrTemp.FieldByName('TRANSP_TYPE').AsInteger;
    TranspCount := qrTemp.FieldByName('TRANSP_COUNT').AsFloat;
    CCount := qrTemp.FieldByName('CARG_COUNT').AsFloat;
    Ydw := qrTemp.FieldByName('CARG_YDW').AsFloat;
    FCoef := qrTemp.FieldByName('KOEF').AsFloat;

    if FCoef > 1 then
    begin
      cbKoef.Checked := True;
      for i := 0 to Length(KoefLis) - 1 do
        if FCoef = KoefLis[i] then
        begin
          cmbKoef.ItemIndex := i;
          Break;
        end;
    end;

    qrTemp.Active := false;

    GetCoast;

    qrTemp.SQL.Text := 'SELECT * FROM transpcard_temp WHERE (ID = ' + IntToStr(aIdTransp) + ');';
    qrTemp.Active := true;
    grdPrice.Cells[CCoastNDS, FClass] := qrTemp.FieldByName('COAST_NDS').AsString;
    grdPrice.Cells[CCoastNoNDS, FClass] := qrTemp.FieldByName('COAST_NO_NDS').AsString;
    grdPrice.Cells[CNDS, FClass] := qrTemp.FieldByName('NDS').AsString;
    grdPrice.Cells[CPriceNDS, FClass] := qrTemp.FieldByName('TRANSP_SUM_NDS').AsString;
    grdPrice.Cells[CPriceNoNDS, FClass] := qrTemp.FieldByName('TRANSP_SUM_NO_NDS').AsString;

    edtPriceNoNDS.Text := grdPrice.Cells[CPriceNoNDS, FClass];
    edtPriceNDS.Text := grdPrice.Cells[CPriceNDS, FClass];

    qrTemp.Active := false;
    grdPrice.Repaint;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ��������� ������ �� ������ ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
  Loading := false;
end;

//�������� ���� �� ������� ������ �� ����������
procedure TFormTransportation.GetCoast;
var
  i: Integer;
  More: integer;
  TabName, DistanceText, LikeText: string;
begin
  Distance := 0;
  FClass := cmbClass.ItemIndex + 1;

  More := 0;
  LikeText := '';

  case TranspType of
    6, 7:
      TabName := 'transfercargo';
    8, 9:
      TabName := 'transfercargoboard';
  end;

  if EditDistance.Text <> '' then
  begin
    Distance := StrToInt(EditDistance.Text);
    DistanceText := EditDistance.Text;

    if TranspType in [6, 7] then
    begin
      if Distance > 50 then
      begin
        More := Distance - 50;
        DistanceText := '50';
        LikeText := '50 ��';
      end;
    end;

    if TranspType in [8, 9] then
    begin
      if Distance > 100 then
      begin
        if (Distance mod 5) = 0 then
          DistanceText := IntToStr(Distance - 4) + '-' + IntToStr(Distance)
        else
          DistanceText := IntToStr(Distance - (Distance mod 5) + 1) + '-' +
            IntToStr(Distance + (5 - (Distance mod 5)));
        if Distance > 200 then
        begin
          More := Distance - 200;
          DistanceText := '196-200';
          LikeText := '200 ��';
        end;
      end;
    end;
  end;

  for i := grdPrice.FixedRows to grdPrice.RowCount - 1 do
    grdPrice.Cells[CNDS,i] := IntToStr(DefNDS);

  try
    with qrTemp do
    begin
      Active := false;
      SQL.Text := 'SELECT * FROM ' + TabName +
        ' WHERE monat = ' + IntToStr(EstMonth) + ' and year = ' +
        IntToStr(EstYear) + ' and distance = :dist;';
      ParamByName('dist').Value := DistanceText;
      Active := true;

      if not IsEmpty then
      begin
        for i := grdPrice.FixedRows to grdPrice.RowCount - 1 do
        begin
          grdPrice.Cells[CCoastNoNDS,i] :=
            FloatToStr(FieldByName('class' + IntToStr(i) + '_1').AsFloat);
          grdPrice.Cells[CCoastNDS,i] :=
            FloatToStr(FieldByName('class' + IntToStr(i) + '_2').AsFloat);
        end;
      end
      else
      begin
        for i := grdPrice.FixedRows to grdPrice.RowCount - 1 do
        begin
          grdPrice.Cells[CCoastNoNDS,i] := '0';
          grdPrice.Cells[CCoastNDS,i]   := '0';
        end;
      end;

      Active := false;

      if (More > 0) then
      begin
        SQL.Text := 'SELECT * FROM ' + TabName + ' WHERE monat = ' + IntToStr(EstMonth) + ' and year = ' +
          IntToStr(EstYear) + ' and distance LIKE "%' + LikeText + '%";';
        Active := true;

        if not IsEmpty then
        begin
          for i := grdPrice.FixedRows to grdPrice.RowCount - 1 do
          begin
            grdPrice.Cells[CCoastNoNDS,i] := FloatToStr(
              StrToFloat(grdPrice.Cells[CCoastNoNDS,i]) +
              FieldByName('class' + IntToStr(i) + '_1').AsFloat * More);
            grdPrice.Cells[CCoastNDS,i]   := FloatToStr(
              StrToFloat(grdPrice.Cells[CCoastNDS,i]) +
              FieldByName('class' + IntToStr(i) + '_2').AsInteger * More);
          end;
        end;
        Active := false;
      end;
      CalcPrice;
    end;
  except
    on E: Exception do
    begin
      qrTemp.Active := false;

      MessageBox(0, PChar('��� ��������� ��� �� ��������������� �������� ������:' + sLineBreak + sLineBreak +
        E.Message), CaptionForm, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
  end;
end;

procedure TFormTransportation.CalcPrice;
var i: Integer;
  TmpCoastNoNds,
  TmpCoastNds: Double;
begin
  for i := grdPrice.FixedRows to grdPrice.RowCount - 1 do
  begin
    if trim(grdPrice.Cells[CCoastNoNDS, i]) = '' then
      TmpCoastNoNds := 0
    else
      TmpCoastNoNds := StrToFloat(grdPrice.Cells[CCoastNoNDS, i]);

    if trim(grdPrice.Cells[CCoastNDS, i]) = '' then
      TmpCoastNds := 0
    else
      TmpCoastNds := StrToFloat(grdPrice.Cells[CCoastNDS, i]);

    grdPrice.Cells[CPriceNoNDS, i] := IntToStr(Round(TranspCount * FCoef * TmpCoastNoNds));
    grdPrice.Cells[CPriceNDS, i] := IntToStr(Round(TranspCount * FCoef * TmpCoastNds));
  end;
end;

{ TJvStringGrid }

procedure TJvStringGrid.DefaultDrawCell(AColumn, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
const
  Flags: array [TAlignment] of DWORD = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  S: string;
begin
  Canvas.FillRect(Rect);
  S := Cells[AColumn, ARow];
  if Length(S) > 0 then
  begin
    InflateRect(Rect, -2, -2);
    DrawText(Canvas, S, Length(S), Rect,
      DT_NOPREFIX or DT_VCENTER or DT_WORDBREAK or
      Flags[GetCellAlignment(AColumn, ARow, State)]);
  end;
end;

end.
