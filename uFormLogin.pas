unit uFormLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, TAdvEditP;

type
  TFormLogin = class(TForm)
    PnlBotoes: TPanel;
    BitBtnConfirmar: TBitBtn;
    BitBtnCancelar: TBitBtn;
    img_fundo: TImage;
    Label15: TLabel;
    EditLogin: TAdvEdit;
    Label1: TLabel;
    EditSenha: TAdvEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function VerifLogin : Boolean;
    function VerifDadosEmpresa : Boolean;
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.dfm}

Uses uDataModule;

procedure TFormLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case ord(key) of

    VK_RETURN : begin
                  Self.Perform(WM_NEXTDLGCTL,0,0);
                  key := #0;
                end;
    VK_ESCAPE : begin
                  Self.Perform(WM_NEXTDLGCTL, 1 , 0 );
                  key := #0;
                end;
  end;
end;

function TFormLogin.VerifLogin : Boolean;
begin
  with DataModulePrin.SQLQueryPesquisa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from Usuarios');
    SQL.Add('where Login = :Login  ');
    SQL.Add('  and Senha = :Senha  ');
    ParamByname('Login').asString := EditLogin.Text;
    ParamByname('Senha').asString := EditSenha.Text;
    Open;

    if not IsEmpty then
    begin
      DataModulePrin.UsuarioLogado := FieldByName('Codigo').asInteger;
      DataModulePrin.LoginLogado   := FieldByName('Login').asString;
      DataModulePrin.UsuarioAdmin  := FieldByName('Administrador').asInteger;
    end;
      
    Result := not IsEmpty;
  end;
end;

procedure TFormLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = MrOK then
  begin
    if VerifLogin = False then
    begin
      MessageDlg('Login ou Senha Inválida!', mtError, [mbOk], 0);
      EditLogin.SetFocus;
      Action := caNone;
    end
    else
    begin
      if VerifDadosEmpresa = False then
        MessageDlg('Dados Obrigatórios devem ser definidos no Cadastro da Empresa!', mtWarning, [mbOk], 0);
    end;
  end;
end;

function TFormLogin.VerifDadosEmpresa : Boolean;
begin
  Result := False;
  with DataModulePrin.SQLQueryPesquisa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from Empresa');
    Open;

    if not IsEmpty then
      Result := (not FieldByName('CodBanco').IsNull);
  end;
end;


end.
