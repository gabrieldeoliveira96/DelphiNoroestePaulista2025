unit view.principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Layouts, System.Skia, UI.Base, UI.Standard, FMX.Skia,
  FMX.Objects, Alcinoe.FMX.Objects, FMX.ListBox, FMX.Effects,
  FMX.Filter.Effects, uGosObjects, heranca.botao, System.Generics.Collections,
  Alcinoe.FMX.Controls, uLoading, view.produtos, FMX.Platform, uSync;

type
  TfrmPrincipal = class(TfrmHerancaBotao)
    Layout1: TLayout;
    SkLabel1: TSkLabel;
    ButtonView1: TButtonView;
    Layout2: TLayout;
    SkLabel2: TSkLabel;
    SkLabel3: TSkLabel;
    GosCircle1: TGosCircle;
    FillRGBEffect1: TFillRGBEffect;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ALRectangle1: TGosRectangle;
    ALRectangle2: TGosRectangle;
    S: TGosRectangle;
    ALRectangle4: TGosRectangle;
    Layout3: TLayout;
    Layout4: TLayout;
    lblQtdVendas: TSkLabel;
    SkLabel5: TSkLabel;
    GosCircle2: TGosCircle;
    FillRGBEffect2: TFillRGBEffect;
    SkLabel6: TSkLabel;
    Layout5: TLayout;
    VertScrollBox1: TVertScrollBox;
    Layout6: TLayout;
    Layout7: TLayout;
    GosCircle4: TGosCircle;
    FillRGBEffect3: TFillRGBEffect;
    SkLabel4: TSkLabel;
    Layout8: TLayout;
    SkLabel7: TSkLabel;
    SkLabel8: TSkLabel;
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function AppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaTela;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

{ TfrmPrincipal }
function TfrmPrincipal.AppEvent(AAppEvent: TApplicationEvent;
  AContext: TObject): Boolean;
begin
//  {$IFNDEF MSWINDOWS}
  case AAppEvent of
    TApplicationEvent.WillBecomeForeground:
    begin
      uSync.Sync;
    end;
    TApplicationEvent.EnteredBackground:
    begin
      uSync.LSync:= false;
    end;
    TApplicationEvent.WillTerminate:
    begin
      uSync.LSync:= false;
    end;

  end;
//  {$ENDIF}
end;

procedure TfrmPrincipal.btnAddClick(Sender: TObject);
begin
  inherited;

  TLoading.Show(self,'Aguarde carregando tela');

  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      TThread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmProdutos) then
          Application.CreateForm(TfrmProdutos, frmProdutos);
      end);

      frmProdutos.CarregaTela;

      TThread.Synchronize(nil,
      procedure
      begin
        frmProdutos.Show;
      end);

    finally
      TThread.Synchronize(nil,
      procedure
      begin
        TLoading.Hide;
      end);
    end;

  end).Start;


end;

procedure TfrmPrincipal.CarregaTela;
begin
  sleep(4000);

  TThread.Synchronize(nil,
  procedure
  begin
    TLoading.ChangeText('Baixando tabela de clientes');
  end);

  sleep(4000);

  TThread.Synchronize(nil,
  procedure
  begin
    TLoading.ChangeText('Baixando tabela de produtos');
  end);

  sleep(4000);

  TThread.Synchronize(nil,
  procedure
  begin
    TLoading.ChangeText('Baixando tabela de vendas');
  end);

  sleep(4000);

  TThread.Synchronize(nil,
  procedure
  begin
    TLoading.ChangeText('Sincronizando dados');
  end);

  sleep(4000);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  LAppEvent: IFMXApplicationEventService;
begin
  inherited;
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(LAppEvent)) then
    LAppEvent.SetApplicationEventHandler(AppEvent);

end;

end.
