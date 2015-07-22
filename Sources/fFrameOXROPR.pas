unit fFrameOXROPR;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, Buttons, ExtCtrls, Menus, Clipbrd, DB,
  DBCtrls, VirtualTrees, fFrameStatusBar, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, fFrameSmeta, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid;

type
  TSplitter = class(ExtCtrls.TSplitter)
  public
    procedure Paint(); override;
  end;

type
  TFrameOXROPR = class(TSmetaFrame)
    DataSourceTypeWork: TDataSource;

    PopupMenu: TPopupMenu;
    CopyCell: TMenuItem;
    OXROPRSearch: TMenuItem;
    OXROPRSearchFast: TMenuItem;
    OXROPRSearchAccurate: TMenuItem;

    Panel: TPanel;
    PanelTop: TPanel;
    PanelMemo: TPanel;
    PanelTable: TPanel;

    RadioButtonCity: TRadioButton;
    RadioButtonVillage: TRadioButton;
    RadioButtonMinsk: TRadioButton;

    Memo: TMemo;
    BevelLine: TBevel;

    Splitter: TSplitter;
    ImageSplitter: TImage;
    LabelTypeWork: TLabel;
    LabelResolution: TLabel;
    ComboBoxResolution: TComboBox;
    FrameStatusBar: TFrameStatusBar;
    SpeedButtonShowHide: TSpeedButton;
    DBLookupComboBoxTypeWork: TDBLookupComboBox;
    ADOQueryTemp: TFDQuery;
    ADOQueryTypeWork: TFDQuery;
    ADOQuery: TFDQuery;
    JvDBGrid1: TJvDBGrid;
    ds1: TDataSource;
    ADOQueryNumber: TIntegerField;
    ADOQueryNameWork: TStringField;
    ADOQueryP1: TFloatField;
    ADOQueryP2: TFloatField;

    procedure FillingTypeWork;
    procedure FillingResolution;
    procedure ReceivingSearch;
    procedure DBLookupComboBoxTypeWorkClick(Sender: TObject);

    procedure PanelTableResize(Sender: TObject);
    procedure PanelTopResize(Sender: TObject);
    procedure RadioButtonClick(Sender: TObject);

    procedure MemoEnter(Sender: TObject);
    procedure SpeedButtonShowHideClick(Sender: TObject);
    procedure ComboBoxResolutionChange(Sender: TObject);
    procedure ADOQueryAfterScroll(DataSet: TDataSet);
    procedure JvDBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  public
    MaisCodeList: TStringList;
    procedure ReceivingAll; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses DrawingTables, DataModule, Tools, Main;

{$R *.dfm}

const
  // Название этого фрейма
  CaptionFrame = 'Фрейм «ОХР и ОПР»';

  // ---------------------------------------------------------------------------------------------------------------------

  { TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
end;

destructor TFrameOXROPR.Destroy;
begin
  MaisCodeList.Free;
  inherited;
end;

constructor TFrameOXROPR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // ----------------------------------------
  LoadDBGridSettings(JvDBGrid1);

  PanelMemo.Constraints.MinHeight := 35;
  SpeedButtonShowHide.Hint := 'Свернуть панель';

  with DM do
  begin
    ImageListHorozontalDots.GetIcon(0, ImageSplitter.Picture.Icon);
    ImageListArrowsBottom.GetBitmap(0, SpeedButtonShowHide.Glyph);
  end;

  // ----------------------------------------
  MaisCodeList := TStringList.Create;

  FillingTypeWork;
  FillingResolution;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.FillingTypeWork;
var
  StrQuery: string;
  IdRegion: Integer;
begin
  try
    ADOQueryP1.DisplayFormat := '0.000';
    ADOQueryP2.DisplayFormat := '0.000';
    if RadioButtonMinsk.Checked then
    begin
      IdRegion := 3;
       ADOQueryP1.DisplayFormat := '0.0000';
       ADOQueryP2.DisplayFormat := '0.0000';
    end
    else if RadioButtonCity.Checked then
      IdRegion := 1
    else
      IdRegion := 2;

    StrQuery := 'SELECT * FROM objstroj WHERE obj_region = ' + IntToStr(IdRegion) + ' order by stroj_id';

    with ADOQueryTypeWork do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(StrQuery);
      Active := True;
    end;

    with DBLookupComboBoxTypeWork do
    begin
      ListSource := DataSourceTypeWork;
      ListField := 'name';
      KeyField := 'stroj_id';
      KeyValue := ADOQueryTypeWork.FieldByName('stroj_id').AsInteger;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При заполнении выпадающего списка ' + sLineBreak + '«Вид работ» возникла ошибка:' +
        sLineBreak + sLineBreak + E.Message), CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFrameOXROPR.JvDBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  with (Sender AS TJvDBGrid).Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    if (gdSelected in State) then // Ячейка в фокусе
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
      Font.Style := Font.Style + [fsBold];
    end;
  end;
  (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.FillingResolution;
var
  StrQuery: string;
begin
  try
    StrQuery := 'SELECT * FROM mais ORDER BY onDate DESC;';

    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(StrQuery);
      Active := True;

      First;
      ComboBoxResolution.Items.Clear;

      while not Eof do
      begin
        ComboBoxResolution.Items.Add(FieldByName('comment').AsString);
        MaisCodeList.Add(FieldByName('mais_id').AsString);
        Next;
      end;
    end;

    ComboBoxResolution.ItemIndex := 0;
  except
    on E: Exception do
      MessageBox(0, PChar('При заполнении выпадающего списка ' + sLineBreak +
        '«Постановления» возникла ошибка:' + sLineBreak + sLineBreak + E.Message), CaptionFrame,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.ReceivingAll;
begin
  ReceivingSearch;
  fLoaded := True;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.ReceivingSearch;
var
  StrQuery: string;
  WhereStr: string;
  colP1, colP2: string;
begin
  WhereStr := ' where MAIS_ID = ' + MaisCodeList[ComboBoxResolution.ItemIndex];

  colP1 := ADOQueryTypeWork.FieldByName('COL1NAME').AsString;
  colP2 := ADOQueryTypeWork.FieldByName('COL2NAME').AsString;

  StrQuery := 'SELECT number as "Number", ' +
    '(SELECT WORK_NAME FROM objworks ' +
    'WHERE WORK_ID = number) as "NameWork", ' + colP1 + ' as "P1", ' +
    colP2 + ' as "P2" FROM objdetailex' +
    WhereStr + ' ORDER BY number ASC';

  with ADOQuery do
  begin
    Active := False;
    SQL.Text := StrQuery;
    Active := True;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.DBLookupComboBoxTypeWorkClick(Sender: TObject);
begin
  ReceivingSearch;
end;


procedure TFrameOXROPR.PanelTableResize(Sender: TObject);
begin
  ImageSplitter.Top := Splitter.Top;
  ImageSplitter.Left := Splitter.Left + (Splitter.Width - ImageSplitter.Width) div 2;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.PanelTopResize(Sender: TObject);
begin
  DBLookupComboBoxTypeWork.Left := LabelTypeWork.Left + LabelTypeWork.Width + 6;
  DBLookupComboBoxTypeWork.Width := 200;

  LabelResolution.Left := DBLookupComboBoxTypeWork.Left + DBLookupComboBoxTypeWork.Width + 6;

  ComboBoxResolution.Left := LabelResolution.Left + LabelResolution.Width + 6;
  ComboBoxResolution.Width := PanelTop.Width - ComboBoxResolution.Left - 3;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.RadioButtonClick(Sender: TObject);
begin
  FillingTypeWork;
  ReceivingSearch;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOXROPR.ADOQueryAfterScroll(DataSet: TDataSet);
begin
  inherited;
  FrameStatusBar.InsertText(0, IntToStr(ADOQuery.RecordCount)); // Количество записей

  if ADOQuery.RecordCount > 0 then
    FrameStatusBar.InsertText(1, IntToStr(ADOQuery.RecNo)) // Номер выделенной записи
  else
    FrameStatusBar.InsertText(1, '-1'); // Нет записей

  Memo.Text := string(ADOQueryNameWork.Value);
end;

procedure TFrameOXROPR.ComboBoxResolutionChange(Sender: TObject);
begin
  inherited;
  ReceivingSearch;
end;

procedure TFrameOXROPR.MemoEnter(Sender: TObject);
begin
  Memo.SelStart := Length(Memo.Text);
end;

procedure TFrameOXROPR.SpeedButtonShowHideClick(Sender: TObject);
begin
  MemoShowHide(Sender, Splitter, PanelMemo);
end;

end.
