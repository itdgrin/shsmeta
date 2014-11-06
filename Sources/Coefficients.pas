unit Coefficients;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, ExtCtrls, Grids,
  DBGrids, StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFormCoefficients = class(TForm)
    PanelRight: TPanel;

    LabelSalary: TLabel;
    LabelExploitationCars: TLabel;
    LabelMaterialResources: TLabel;
    LabelWorkBuilders: TLabel;
    LabelWorkMachinist: TLabel;

    EditSalary: TEdit;
    EditExploitationCars: TEdit;
    EditMaterialResources: TEdit;
    EditWorkBuilders: TEdit;
    EditWorkMachinist: TEdit;

    Bevel1: TBevel;

    ButtonAdd: TButton;
    ButtonCancel: TButton;

    PanelTable: TPanel;
    StringGridTable: TStringGrid;
    DataSourceTable: TDataSource;
    ADOQueryTable: TFDQuery;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    // Заполнение таблицы
    procedure FillingTable;

    // Заполнение полей коэффициентов
    procedure FillingFieldsCoefficients;

    procedure ButtonCancelClick(Sender: TObject);
    procedure StringGridTableClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure StringGridTableDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCoefficients: TFormCoefficients;

implementation

uses DataModule, Main, CalculationEstimate;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficients.FormCreate(Sender: TObject);
begin
  with StringGridTable do
  begin
    ColCount := 8;
    RowCount := 2;

    Cells[0, 0] := '№ п/п';
    Cells[1, 0] := 'Название коэффициента';
    Cells[2, 0] := 'Основная зарплата';
    Cells[3, 0] := 'Эксплуатация машин';
    Cells[4, 0] := 'Материальные ресурсы';
    Cells[5, 0] := 'Трудозатраты рабочих';
    Cells[6, 0] := 'Трудозатраты машинистов';
    Cells[7, 0] := 'Id';

    ColWidths[0] := 40;
    ColWidths[1] := Width - ColWidths[0] - GetSystemMetrics(SM_CXVSCROLL) - 7;
    ColWidths[2] := -1;
    ColWidths[3] := -1;
    ColWidths[4] := -1;
    ColWidths[5] := -1;
    ColWidths[6] := -1;
    ColWidths[7] := -1;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficients.FormShow(Sender: TObject);

begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  // -----------------------------------------

  FillingTable;

  with StringGridTable do
  begin
    Row := 1;
    SetFocus;
  end;

  FillingFieldsCoefficients;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficients.StringGridTableClick(Sender: TObject);
begin
  FillingFieldsCoefficients;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficients.StringGridTableDblClick(Sender: TObject);
begin
  ButtonAddClick(ButtonAdd);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficients.FillingTable;
var
  i: Integer;
  StrQuery: String;
  CoefValue: Double;
begin
  with ADOQueryTable, DataSourceTable, StringGridTable do
  begin
    Active := False;
    SQL.Clear;

    StrQuery := 'SELECT coef_id as "Id", coef_name as "Name", osn_zp as "Salary", eksp_mach as "ExploitationCars", ' +
      'mat_res as "MaterialResources", work_pers as "WorkBuilders", work_mach as "WorkMachinist" FROM coef ORDER BY Name;';

    SQL.Add(StrQuery);
    Active := True;

    RowCount := DataSet.RecordCount + 1;

    First;
    i := 1;

    while not Eof do
    begin
      Cells[0, i] := IntToStr(i);
      Cells[1, i] := FieldByName('Name').AsVariant;

      if FieldByName('Salary').AsVariant <> Null then
        Cells[2, i] := MyFloatToStr(FieldByName('Salary').AsVariant)
      else
        Cells[2, i] := '0';

      if FieldByName('ExploitationCars').AsVariant <> Null then
        Cells[3, i] := MyFloatToStr(FieldByName('ExploitationCars').AsVariant)
      else
        Cells[3, i] := '0';

      if FieldByName('MaterialResources').AsVariant <> Null then
        Cells[4, i] := MyFloatToStr(FieldByName('MaterialResources').AsVariant)
      else
        Cells[4, i] := '0';

      if FieldByName('WorkBuilders').AsVariant <> Null then
        Cells[5, i] := MyFloatToStr(FieldByName('WorkBuilders').AsVariant)
      else
        Cells[5, i] := '0';

      if FieldByName('WorkMachinist').AsVariant <> Null then
        Cells[6, i] := MyFloatToStr(FieldByName('WorkMachinist').AsVariant)
      else
        Cells[6, i] := '0';

      Cells[7, i] := IntToStr(FieldByName('Id').AsVariant);

      Next;
      Inc(i);
    end;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficients.FillingFieldsCoefficients;
begin
  with StringGridTable do
  begin
    EditSalary.Text := Cells[2, Row];
    EditExploitationCars.Text := Cells[3, Row];
    EditMaterialResources.Text := Cells[4, Row];
    EditWorkBuilders.Text := Cells[5, Row];
    EditWorkMachinist.Text := Cells[6, Row];
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficients.ButtonAddClick(Sender: TObject);
begin
  if FormCalculationEstimate.GetCountCoef = 5 then
  begin
    MessageBox(0, PChar('Уже добавлено 5 наборов коэффициентов!' + sLineBreak + sLineBreak +
      'Добавление больше 5 наборов невозможно.'), 'Смета', MB_ICONINFORMATION + MB_OK + mb_TaskModal);
    Close;
  end
  else
    FormCalculationEstimate.FillingTableSetCoef;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficients.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
