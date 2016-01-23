{ Модуль печати отчетов }
unit SmReportMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, Main, DataModule, SmReportData, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, Vcl.ComCtrls,
  JvExComCtrls, JvDBTreeView, JvComponentBase, JvFormPlacement, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, SmReportParams,
  frxExportCSV, frxExportRTF, frxClass, frxExportPDF, frxDBSet;

type
  TfSmReportMain = class(TSmForm)
    pnlCategory: TPanel;
    splCategory: TSplitter;
    pnlReport: TPanel;
    splReport: TSplitter;
    dsTreeCategory: TDataSource;
    qrTreeCategory: TFDQuery;
    FormStorage: TJvFormStorage;
    tvCategory: TJvDBTreeView;
    lblCategory: TLabel;
    lblReport: TLabel;
    pmCategory: TPopupMenu;
    mCategoryAddSub: TMenuItem;
    mCategoryAdd: TMenuItem;
    mCategoryDel: TMenuItem;
    qrReport: TFDQuery;
    dsReport: TDataSource;
    pnlBott: TPanel;
    btnPreview: TBitBtn;
    grReport: TJvDBGrid;
    pmReport: TPopupMenu;
    mReportAdd: TMenuItem;
    mReportDel: TMenuItem;
    mReportEdit: TMenuItem;
    mCategoryEditName: TMenuItem;
    sbParams: TScrollBox;
    mReportEditParams: TMenuItem;
    lblParams: TLabel;
    frxReport: TfrxReport;
    frxDS: TfrxDBDataset;
    frxPDF: TfrxPDFExport;
    frxRTF: TfrxRTFExport;
    frxCSV: TfrxCSVExport;
    qrReportData: TFDQuery;
    mReportCopy: TMenuItem;
    qrActMat: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure mCategoryAddClick(Sender: TObject);
    procedure mCategoryAddSubClick(Sender: TObject);
    procedure mCategoryDelClick(Sender: TObject);
    procedure pmCategoryPopup(Sender: TObject);
    procedure mReportDelClick(Sender: TObject);
    procedure mReportEditClick(Sender: TObject);
    procedure mReportAddClick(Sender: TObject);
    procedure pmReportPopup(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure qrReportAfterScroll(DataSet: TDataSet);
    procedure mReportEditParamsClick(Sender: TObject);
    procedure mCategoryEditNameClick(Sender: TObject);
    procedure mReportCopyClick(Sender: TObject);
    procedure qrReportDataBeforeOpen(DataSet: TDataSet);
  private
    ReportParams: TfSmReportParams;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
  public
  end;

var
  fSmReportMain: TfSmReportMain;

implementation

{$R *.dfm}

uses SmReportParamsEdit, SmReportListSQL;

procedure TfSmReportMain.btnPreviewClick(Sender: TObject);
var
  tmpReportName: string;
begin
  // Печать выбранного отчета
  // Заглушка, пока реализуется генератор
  case qrReport.FieldByName('REPORT_ID').AsInteger of
    // Реестры по прорабам
    2:
      begin
        tmpReportName := ExtractFileDir(Application.ExeName) + '\Reports\rst_foreman.fr3';
        frxDS.DataSet := qrReportData;
      end;
    // Реестры по типам актов
    3:
      begin
        tmpReportName := ExtractFileDir(Application.ExeName) + '\Reports\rst_type_act.fr3';
        frxDS.DataSet := qrReportData;
      end;
    // Акт списания материалов С-29 смета свод
    5:
      begin
        tmpReportName := ExtractFileDir(Application.ExeName) + '\Reports\c_39_s.fr3';
        frxDS.DataSet := qrActMat;
        qrActMat.Filter := 'CNT<>0 AND CNT IS NOT NULL';
        qrActMat.Filtered := True;
      end;
    // Акт списания материалов С-29 факт свод
    6:
      begin
        tmpReportName := ExtractFileDir(Application.ExeName) + '\Reports\c_39_f.fr3';
        frxDS.DataSet := qrActMat;
        qrActMat.Filter := 'CNT_F<>0 AND CNT_F IS NOT NULL';
        qrActMat.Filtered := True;
      end;
    // Акт списания материалов С-29 норм
    7:
      begin
        tmpReportName := ExtractFileDir(Application.ExeName) + '\Reports\c_39.fr3';
        frxDS.DataSet := qrActMat;
        qrActMat.Filter := '';
        qrActMat.Filtered := False;
      end;
  end;
  frxReport.LoadFromFile(tmpReportName);
  frxDS.DataSet.Active := True;
  frxReport.PrepareReport();
  frxReport.ShowPreparedReport;

  { пример говнокода

    dm.frxReport.Variables['ccc'] := dm.roomerCQ.RecordCount;
    frxReport.Variables.FieldAddress('')

    if sCheckBox1.Checked then
    dm.frxReport.FindObject('GroupHeader2').Visible := true
    else
    dm.frxReport.FindObject('GroupHeader2').Visible := false;
  }
end;

procedure TfSmReportMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(ReportParams) then
    FreeAndNil(ReportParams);
  Action := caFree;
end;

procedure TfSmReportMain.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(Caption, Caption, Self, 1);
  // Добавление системного меню
  AppendMenu(GetSystemMenu(Handle, False), MF_SEPARATOR, 0, '');
  AppendMenu(GetSystemMenu(Handle, False), MF_STRING, 5555, 'Настройка списков');

  // Создаем окно параметров отчета
  if (not Assigned(ReportParams)) then
    ReportParams := TfSmReportParams.Create(Self);
  ReportParams.Parent := sbParams;
  ReportParams.Align := alTop;
  ReportParams.BorderStyle := bsNone;

  qrTreeCategory.Active := True;
  qrReport.Active := True;

  // Если передали сылку на список отчетов, то скрываем дерево
  if not VarIsNull(InitParams) then
  begin
    pnlCategory.Visible := False;
    qrTreeCategory.Locate('REPORT_CATEGORY_ID', InitParams, []);
  end;
end;

procedure TfSmReportMain.WMSysCommand(var Msg: TWMSysCommand);
begin
  if Msg.CmdType = 5555 then
  begin
    if (not Assigned(fSmReportListSQL)) then
      fSmReportListSQL := TfSmReportListSQL.Create(Self);
    fSmReportListSQL.ShowModal;
  end
  else
    inherited;
end;

procedure TfSmReportMain.FormDestroy(Sender: TObject);
begin
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
  fSmReportMain := nil;
end;

procedure TfSmReportMain.mCategoryAddClick(Sender: TObject);
var
  s: string;
begin
  // Добавление раздела
  s := InputBox('Создание раздела', 'Укажите название раздела:', '');

  if TRIM(s) <> '' then
  begin
    qrTreeCategory.Insert;
    qrTreeCategory.FieldByName('REPORT_CATEGORY_NAME').AsString := s;
    qrTreeCategory.FieldByName('PARENT_ID').AsInteger := 0;
    qrTreeCategory.Post;
  end
end;

procedure TfSmReportMain.mCategoryAddSubClick(Sender: TObject);
var
  s: string;
  PARENT_ID: Integer;
begin
  // Добавление подраздела
  s := InputBox('Создание подраздела', 'Укажите название подраздела:', '');

  if TRIM(s) <> '' then
  begin
    PARENT_ID := qrTreeCategory.FieldByName('REPORT_CATEGORY_ID').AsInteger;
    qrTreeCategory.Insert;
    qrTreeCategory.FieldByName('REPORT_CATEGORY_NAME').AsString := s;
    qrTreeCategory.FieldByName('PARENT_ID').AsInteger := PARENT_ID;
    qrTreeCategory.Post;
  end
end;

procedure TfSmReportMain.mCategoryDelClick(Sender: TObject);
begin
  // Удаление раздела/подраздела
  if Application.MessageBox('Вы действительно хотите удалить запись?', 'Удаление раздела',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    qrTreeCategory.Delete;
  end;
end;

procedure TfSmReportMain.mCategoryEditNameClick(Sender: TObject);
var
  s: string;
  flOk: Boolean;
begin
  // Редактирование названия раздела/подраздела
  flOk := False;
  while not flOk do
  begin
    s := InputBox('Редактирование', 'Укажите новое название:',
      qrTreeCategory.FieldByName('REPORT_CATEGORY_NAME').AsString);

    if TRIM(s) <> '' then
    begin
      qrTreeCategory.Edit;
      qrTreeCategory.FieldByName('REPORT_CATEGORY_NAME').AsString := s;
      qrTreeCategory.Post;
      flOk := True;
    end
    else
      Application.MessageBox('Название раздела/подраздела не может быть пустым!', 'Редактирование',
        MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TfSmReportMain.mReportAddClick(Sender: TObject);
var
  s: string;
begin
  // Добавление отчета
  s := InputBox('Создание отчета', 'Укажите название отчета:', '');

  if TRIM(s) <> '' then
  begin
    qrReport.Insert;
    qrReport.FieldByName('REPORT_NAME').AsString := s;
    qrReport.FieldByName('REPORT_CATEGORY_ID').AsInteger := qrTreeCategory.FieldByName('REPORT_CATEGORY_ID')
      .AsInteger;
    qrReport.Post;
  end
end;

procedure TfSmReportMain.mReportCopyClick(Sender: TObject);
begin
  // Копирование отчета
  // TODO
end;

procedure TfSmReportMain.mReportDelClick(Sender: TObject);
begin
  // Удаление отчета
  if Application.MessageBox('Вы действительно хотите удалить запись?', 'Удаление отчета',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    qrReport.Delete;
  end;
end;

procedure TfSmReportMain.mReportEditClick(Sender: TObject);
begin
  // Редактирование шаблона отчета
  // TODO
end;

procedure TfSmReportMain.mReportEditParamsClick(Sender: TObject);
begin
  // Вызов редактора переменных отчета
  if (not Assigned(fSmreportParamsEdit)) then
    fSmreportParamsEdit := TfSmreportParamsEdit.Create(Self, qrReport.FieldByName('REPORT_ID').Value);
  fSmreportParamsEdit.ShowModal;
  ReportParams.ReloadReportParams(qrReport.FieldByName('REPORT_ID').AsInteger);
end;

procedure TfSmReportMain.pmCategoryPopup(Sender: TObject);
var
  isExists: Boolean;
begin
  // Настройка видимости меню с разделами
  isExists := CheckQrActiveEmpty(qrTreeCategory);
  mCategoryAddSub.Visible := isExists;
  mCategoryDel.Visible := isExists and qrReport.IsEmpty;
  mCategoryEditName.Visible := isExists;
end;

procedure TfSmReportMain.pmReportPopup(Sender: TObject);
var
  isExists: Boolean;
begin
  // Настройка видимости меню с отчетами
  isExists := CheckQrActiveEmpty(qrReport);
  mReportDel.Visible := isExists;
  mReportEdit.Visible := isExists;
  mReportEditParams.Visible := isExists;
  mReportCopy.Visible := isExists;
end;

procedure TfSmReportMain.qrReportAfterScroll(DataSet: TDataSet);
begin
  ReportParams.Visible := not qrReport.IsEmpty;
  btnPreview.Enabled := not qrReport.IsEmpty;
  if not CheckQrActiveEmpty(qrReport) then
    Exit;
  ReportParams.ReloadReportParams(qrReport.FieldByName('REPORT_ID').AsInteger);
end;

procedure TfSmReportMain.qrReportDataBeforeOpen(DataSet: TDataSet);
begin
  // Заполняем параметры
  ReportParams.WriteReportParams(TFDQuery(DataSet));
end;

end.
