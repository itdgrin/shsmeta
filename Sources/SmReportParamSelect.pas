unit SmReportParamSelect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, Main, DataModule, Vcl.Grids, Vcl.DBGrids, JvExDBGrids,
  JvDBGrid, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons;

type
  TfSmReportParamSelect = class(TSmForm)
    pnlBot: TPanel;
    grParamList: TJvDBGrid;
    qrParamList: TFDQuery;
    dsParamList: TDataSource;
    btnCancel: TBitBtn;
    btnOk: TBitBtn;
    pnlTop: TPanel;
    edtSearch: TEdit;
    btnSearch: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grParamListDblClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
    class function Select(AListIDorListName, ACodeLocate: Variant): Variant;
  end;

implementation

{$R *.dfm}

procedure TfSmReportParamSelect.btnSearchClick(Sender: TObject);
begin
  qrParamList.Filter := 'UPPER(VALUE) LIKE UPPER(''%' + Trim(edtSearch.Text) + '%'')';
  if (btnSearch.Tag = 0) and qrParamList.FindFirst then
    btnSearch.Tag := 1
  else if not qrParamList.FindNext then
  begin
    btnSearch.Tag := 0;
  end;
end;

procedure TfSmReportParamSelect.edtSearchChange(Sender: TObject);
begin
  btnSearch.Tag := 0;
end;

procedure TfSmReportParamSelect.edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnSearch.Click;
end;

procedure TfSmReportParamSelect.FormCreate(Sender: TObject);
begin
  // InitParams[0] - код списка REPORT_LIST_SQL_ID/строка, название списка
  // InitParams[1] - CODE дл€ локейта
  if VarIsNumeric(InitParams[0]) then
  begin
    qrParamList.SQL.Text :=
      VarToStr(FastSelectSQLOne('SELECT REPORT_LIST_SQL_SRC FROM report_list_sql WHERE REPORT_LIST_SQL_ID=:0',
      VarArrayOf([InitParams[0]])));
    grParamList.Columns[0].Title.Caption :=
      VarToStrDef(FastSelectSQLOne
      ('SELECT REPORT_LIST_SQL_DESCR FROM report_list_sql WHERE REPORT_LIST_SQL_ID=:0',
      VarArrayOf([InitParams[0]])), '  ');
    qrParamList.Active := True;
  end
  else
  begin
    qrParamList.SQL.Text :=
      VarToStr(FastSelectSQLOne
      ('SELECT REPORT_LIST_SQL_SRC FROM report_list_sql WHERE TRIM(UPPER(REPORT_LIST_SQL_NAME))=TRIM(UPPER(:0)) LIMIT 1',
      VarArrayOf([InitParams[0]])));
    grParamList.Columns[0].Title.Caption :=
      VarToStrDef(FastSelectSQLOne
      ('SELECT REPORT_LIST_SQL_DESCR FROM report_list_sql WHERE TRIM(UPPER(REPORT_LIST_SQL_NAME))=TRIM(UPPER(:0)) LIMIT 1',
      VarArrayOf([InitParams[0]])), '  ');
    qrParamList.Active := True;
  end;
  if not VarIsNull(InitParams[1]) then
    qrParamList.Locate('CODE', InitParams[1], []);
end;

procedure TfSmReportParamSelect.grParamListDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

class function TfSmReportParamSelect.Select(AListIDorListName, ACodeLocate: Variant): Variant;
// ‘ункци€ выбора значени€ из списка
// AFromListID - REPORT_LIST_SQL_ID - код списка
// ACodeLocate - CODE дл€ локейта
// ¬озврат массив [0..1] = [CODE, VALUE] выбранного значени€
var
  form: TfSmReportParamSelect;
begin
  Result := Null;
  form := TfSmReportParamSelect.Create(nil, VarArrayOf([AListIDorListName, ACodeLocate]));
  try
    if form.ShowModal = mrOk then
      Result := VarArrayOf([form.qrParamList.FieldByName('CODE').Value,
        form.qrParamList.FieldByName('VALUE').Value]);
  finally
    FreeAndNil(form);
  end;
end;

end.
