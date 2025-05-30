unit Unit1;


interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FMX.ScrollBox, FMX.TabControl;

type
  TForm1 = class(TForm)
    RctTopBar: TRectangle;
    LblLogo: TLabel;
    LayoutBusca: TLayout;
    SearchBoxBusca: TButton;
    ScrollCategorias: THorzScrollBox;
    RctCat1: TRectangle;
    ImgCat1: TImage;
    LblCat1: TLabel;
    RctCat2: TRectangle;
    ImgCat2: TImage;
    LblCat2: TLabel;
    LblRestDesc1: TLabel;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

end.
