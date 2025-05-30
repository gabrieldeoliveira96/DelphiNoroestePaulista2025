program app1;

uses
  System.StartUpCopy,
  FMX.Forms,
  heranca.base in 'heranca\heranca.base.pas' {frmHerancaBase},
  heranca.botao in 'heranca\heranca.botao.pas' {frmHerancaBotao},
  view.login in 'view\view.login.pas' {frmLogin},
  view.principal in 'view\view.principal.pas' {frmPrincipal},
  uLoading in 'feature\uLoading.pas',
  model.con in 'model\model.con.pas' {dmCon: TDataModule},
  model.clientes in 'model\model.clientes.pas' {dmCliente: TDataModule},
  view.produtos in 'view\view.produtos.pas' {frmProdutos},
  frame.produtos in 'view\frame\frame.produtos.pas' {frameProduto: TFrame},
  uConnection in 'feature\uConnection.pas',
  uSync in 'feature\uSync.pas',
  NetWork.State in 'feature\ConnectInfo\NetWork.State.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TdmCon, dmCon);
  Application.CreateForm(TdmCliente, dmCliente);
  Application.CreateForm(TfrmProdutos, frmProdutos);
  Application.Run;
end.
