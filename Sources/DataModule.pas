unit DataModule;

interface

uses
  Classes, DB, ImgList, Controls, Menus, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    ImageListArrowsTop: TImageList;
    ImageListArrowsBottom: TImageList;
    ImageListHorozontalDots: TImageList;
    ImageListVerticalDots: TImageList;
    ImageListArrowsLeft: TImageList;
    ImageListArrowsRight: TImageList;
    ImageListModeTables: TImageList;
    ImageList1: TImageList;
    Connect: TFDConnection;
    Read: TFDTransaction;
    Write: TFDTransaction;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qrDifferent: TFDQuery;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

end.
