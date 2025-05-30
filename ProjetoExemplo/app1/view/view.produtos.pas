unit view.produtos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Effects, FMX.Filter.Effects, FMX.Controls.Presentation,
  FMX.Layouts, frame.produtos, System.Generics.Collections, uConnection,
  System.JSON, FMX.Objects, FMX.Edit;

type
  TfrmProdutos = class(TfrmHerancaBase)
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    VertScrollBox1: TVertScrollBox;
    Layout2: TLayout;
    Layout3: TLayout;
    Edit1: TEdit;
    SearchEditButton1: TSearchEditButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VertScrollBox1ViewportPositionChange(Sender: TObject;
      const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
  private
    { Private declarations }
    FListProdutos:TObjectList<TframeProduto>;
    procedure CarregaImagens;
  public
    { Public declarations }
    procedure CarregaTela;
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.fmx}


{ TfrmProdutos }

procedure TfrmProdutos.CarregaImagens;
begin
  TThread.CreateAnonymousThread(
  procedure
  begin

    for var Litem in FListProdutos do
    begin
      var LCon:= TConnection.Create;
      var LResult: String;
      var LJo:TJSONObject;
      var LBitmap:TBitmap;
      try

        if not LCon.Get('https://fakestoreapi.com/products/'+Litem.Tag.ToString,
        [],LResult) then
          exit;

        LJo:= TJSONObject.ParseJSONValue(LResult) as TJSONObject;

        LBitmap:= LCon.GetImage(LJo.GetValue<string>('image'));

        TThread.Synchronize(nil,
        procedure
        begin
          Litem.recImg.Fill.Bitmap.Bitmap:= LBitmap;

          Litem.AniIndicator1.Enabled:= false;
          Litem.AniIndicator1.Visible:= false;
        end);

      finally
        FreeAndNil(LCon);
      end;

    end;

  end).Start;

end;

procedure TfrmProdutos.CarregaTela;
begin
  for var i := 0 to 10 do
  begin
    var LFrame:= TframeProduto.Create(self);

    LFrame.Name:= 'FRame'+i.ToString;
    LFrame.Align:= TAlignLayout.Top;

    LFrame.lblProduto.Text:= 'Produto '+i.ToString;
    LFrame.lblDescricao.Text:= 'Descrição do Produto '+i.ToString;

    LFrame.Margins.Left:= 24;
    LFrame.Margins.Right:= 24;
    LFrame.Margins.Top:= 16;

    LFrame.TagString:= LFrame.lblProduto.Text;
    LFrame.Tag:= i+1;

    VertScrollBox1.AddObject(LFrame);

    LFrame.AniIndicator1.Enabled:= true;

    FListProdutos.Add(LFrame);

  end;

end;


procedure TfrmProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FListProdutos);
  Action:= TCloseAction.caFree;
  frmProdutos:= nil;
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  FListProdutos:= TObjectList<TframeProduto>.Create;
end;

procedure TfrmProdutos.FormShow(Sender: TObject);
begin
  inherited;
  CarregaImagens;
end;

procedure TfrmProdutos.VertScrollBox1ViewportPositionChange(Sender: TObject;
  const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
begin
  inherited;

  if NewViewportPosition.Y < 145 then
     Layout2.Height:= 145
  else
  Layout2.Height:= Layout2.Height-(NewViewportPosition.Y/100);

end;

end.
