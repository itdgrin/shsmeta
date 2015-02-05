unit EditExpression;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ImgList, Vcl.Buttons,
  System.Win.ComObj, System.UITypes;

type
  TfEditExpression = class(TForm)
    edtFormula: TEdit;
    btnCancel: TSpeedButton;
    btnOk: TSpeedButton;
    lbl1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ShowEditExpression: Variant;

var
  fEditExpression: TfEditExpression;

exports ShowEditExpression;

implementation

uses Tools;

{$R *.dfm}

function ShowEditExpression: Variant;
var
  res: Variant;
  flNoError: boolean;

  procedure Formula(Formula_Text: string; var Formula_Val: Variant; var flag1: boolean);
  var
    E, Sheet, MyCell: Variant;
  begin
    flag1 := False;
    if Formula_Text[1] <> '=' then
      Formula_Text := '=' + Formula_Text;
    try
      // Если Excel загружен, то подключиться к нему
      E := GetActiveOLEObject('Excel.Application');
    except
      // Иначе Создать объект MS Excel
      E := CreateOLEObject('Excel.Application');
    end;
    E.WorkBooks.Add; // Добавить книгу MS Excel
    Sheet := E.Sheets.Item[1]; // Перейти на первую страницу книги
    MyCell := Sheet.Cells[1, 1]; // Определить ячейку для занесения формулы
    MyCell.Value := Formula_Text; // Заносим формулу
    Formula_Val := MyCell.Value; // Вычисляем формулу
    if (VarIsFloat(Formula_Val) = False) or (VarIsNumeric(Formula_Val) = False) then
    begin
      MessageDlg('Внимание! Ошибка в формуле: ', mtWarning, [mbOk], 0, mbOk);
      flag1 := False;
    end
    else
      flag1 := True; // расчет выполнен правильно, без ошибок
    E.DisplayAlerts := False;
    try
      E.Quit; // Выйти из созданного Excel
      E := UnAssigned; // Освободить память
    except
    end;
  end;

begin
  Result := Null;
  try
    fEditExpression := TfEditExpression.Create(nil);
    if (fEditExpression.ShowModal = mrOk) and (trim(fEditExpression.edtFormula.Text) <> '') then
    begin
      Formula(StringReplace(fEditExpression.edtFormula.Text, ',', '.', [rfReplaceAll]), res, flNoError);
      if flNoError then
        Result := res;
    end;
  finally
    fEditExpression.Free;
  end;
end;

procedure TfEditExpression.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfEditExpression.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfEditExpression.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfEditExpression.FormDestroy(Sender: TObject);
begin
  fEditExpression := nil;
end;

procedure TfEditExpression.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      btnOk.Click;
    VK_ESCAPE:
      btnCancel.Click;
  end;
end;

end.
