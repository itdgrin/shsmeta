unit SprSelection;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  fFrameSpr,   Tools,
  SprController,
  GlobsAndConst;

type
  TfSprSelection = class(TSmForm)
    Panel4: TPanel;
    btnSelect: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
  private
    FFrame: TSprFrame;
    FSelectionValue: TSprRecord;
    procedure SprSelection(ASprId, AManPriceID: Integer;
      APriceDate: TDateTime;
      ASprRecord: TSprRecord);
  public
    property SelectionValue: TSprRecord read FSelectionValue;
    constructor Create(AType: Integer; AShowPrice: Boolean; ABaseType: Byte;
      AStarDate: TDateTime; ARegion: Integer); reintroduce;
    destructor Destroy; override;
  end;

//Не дает выбора между материалами и жби
//ABaseType 1 - нормативная база, 2 - собственная база, 0 - обе
function SelectMaterial(AShowPrice: Boolean = False; ABaseType: Byte = 0;
  AStarDate: TDateTime = 0; ARegion: Integer = 0): TSprRecord;
function SelectMechanizm(AShowPrice: Boolean = False; ABaseType: Byte = 0;
  AStarDate: TDateTime = 0): TSprRecord;
function SelectDevice(ABaseType: Byte = 0): TSprRecord;
function SelectFromSpr(AType: Integer; AShowPrice: Boolean; ABaseType: Byte;
  AStarDate: TDateTime; ARegion: Integer): TSprRecord;

implementation

uses fFrameMaterial, fFrameMechanizm, fFrameEquipment;

{$R *.dfm}

function SelectMaterial(AShowPrice: Boolean; ABaseType: Byte;
  AStarDate: TDateTime; ARegion: Integer): TSprRecord;
begin
  Result := SelectFromSpr(2, AShowPrice, ABaseType, AStarDate, ARegion);
end;

function SelectMechanizm(AShowPrice: Boolean; ABaseType: Byte;
  AStarDate: TDateTime): TSprRecord;
begin
  Result := SelectFromSpr(3, AShowPrice, ABaseType, AStarDate, 0);
end;

function SelectDevice(ABaseType: Byte): TSprRecord;
begin
  Result := SelectFromSpr(4, False, ABaseType, 0, 0);
end;

function SelectFromSpr(AType: Integer; AShowPrice: Boolean; ABaseType: Byte;
  AStarDate: TDateTime; ARegion: Integer): TSprRecord;
var fSprSelection: TfSprSelection;
begin
  Result := Default(TSprRecord);

  if not AType in [2,3,4] then
    raise Exception.Create('Неизвестный тип справочника');
  fSprSelection :=
    TfSprSelection.Create(AType, AShowPrice, ABaseType, AStarDate, ARegion);
  try
    if fSprSelection.ShowModal = mrOk then
      Result := fSprSelection.SelectionValue;
  finally
    FreeAndNil(fSprSelection);
  end;
end;

procedure TfSprSelection.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfSprSelection.btnSelectClick(Sender: TObject);
begin
  FFrame.ListSprDblClick(FFrame.ListSpr);
end;

constructor TfSprSelection.Create(AType: Integer; AShowPrice: Boolean; ABaseType: Byte;
  AStarDate: TDateTime; ARegion: Integer);
begin
  inherited Create(nil);

  if AStarDate = 0 then
    AStarDate := Date;
  if ARegion = 0 then
    ARegion := 7;

  case AType of
  2:
  begin
    Caption := 'Выбор материала';
    //Стартует с материалов
    FFrame :=
      TSprMaterial.Create(Self, AShowPrice, AStarDate, ARegion, True, False, ABaseType);
  end;
  3:
  begin
    Caption := 'Выбор механизма';
    FFrame := TSprMechanizm.Create(Self, AShowPrice, AStarDate, ABaseType);
  end;
  4:
  begin
    Caption := 'Выбор оборудования';
    FFrame := TSprEquipment.Create(Self, AShowPrice, ABaseType);
  end;
  end;
  FFrame.Parent := Self;
  FFrame.Align := alClient;
  FFrame.OnSelect := SprSelection;
  FFrame.LoadSpr;
end;

destructor TfSprSelection.Destroy;
begin
  FreeAndNil(FFrame);
  inherited;
end;

procedure TfSprSelection.SprSelection(ASprId, AManPriceID: Integer;
  APriceDate: TDateTime; ASprRecord: TSprRecord);
begin
  FSelectionValue.CopyFrom(ASprRecord);
  ModalResult := mrOk;

end;

end.
