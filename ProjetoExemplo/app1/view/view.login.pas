unit view.login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Layouts, FMX.Controls.Presentation, FMX.Objects,
  Alcinoe.FMX.Controls, Alcinoe.FMX.Objects, Alcinoe.FMX.Edit, UI.Base,
  UI.Standard, view.principal, uLoading, uGosBase, uGosStandard, uSync;

type
  TfrmLogin = class(TfrmHerancaBase)
    Label1: TLabel;
    S: TLayout;
    Layout2: TLayout;
    Label2: TLabel;
    Rectangle1: TRectangle;
    Layout3: TLayout;
    Layout4: TLayout;
    edtEmail: TGosButtonView;
    Layout5: TLayout;
    Label3: TLabel;
    Layout6: TLayout;
    Layout7: TLayout;
    edtSenha: TGosButtonView;
    Label4: TLabel;
    Layout8: TLayout;
    btnLogin: TButtonView;
    Layout9: TLayout;
    Layout10: TLayout;
    Label5: TLabel;
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  TLoading.Show(self,'Aguarde carregando tela');

  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      TThread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmPrincipal) then
          Application.CreateForm(TfrmPrincipal, frmPrincipal);
      end);

      //frmPrincipal.CarregaTela();

      TThread.Synchronize(nil,
      procedure
      begin
        frmPrincipal.Show;
      end);

      uSync.Sync;

    finally
      TThread.Synchronize(nil,
      procedure
      begin
        TLoading.Hide;
      end);
    end;

  end).Start;



end;

end.
