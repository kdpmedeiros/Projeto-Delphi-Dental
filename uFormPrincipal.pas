unit uFormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DBXpress, DB, SqlExpr, uDataModule, jpeg, ExtCtrls,
  ImgList, ComCtrls, XPMenu, StdCtrls, Buttons, IniFiles, math;

type
  TFormPrincipal = class(TForm)
    MainMenuPrin: TMainMenu;
    Cadastros1: TMenuItem;
    MenuProdutos: TMenuItem;
    Relatorios: TMenuItem;
    Imagens: TImageList;
    Estoque1: TMenuItem;
    ContasaPagarReceber1: TMenuItem;
    Sistema1: TMenuItem;
    MnuLogin: TMenuItem;
    MnuPermissoes: TMenuItem;
    Sobre1: TMenuItem;
    MnuUsuarios: TMenuItem;
    MnuEmpresa: TMenuItem;
    MnuProdutos: TMenuItem;
    MnuGrupos: TMenuItem;
    MnuConsultadeProdutos: TMenuItem;
    N3: TMenuItem;
    StatusBarPrin: TStatusBar;
    TimerDataHora: TTimer;
    BitBtnFechar: TBitBtn;
    MnuMovFinanceiro: TMenuItem;
    MnuCadastrodeDuplicatas: TMenuItem;
    MnuRelVendasFechamento: TMenuItem;
    MnuRelVendasComissaoVend: TMenuItem;
    img_prin: TImage;
    Bevel3: TBevel;
    Label3: TLabel;
    BitBtnProdutos: TBitBtn;
    BitBtnConsultaProdutos: TBitBtn;
    BitBtnGrupos: TBitBtn;
    Bevel4: TBevel;
    BitBtnMovFinanceiro: TBitBtn;
    BitBtnDuplicatas: TBitBtn;
    BitBtnBancos: TBitBtn;
    Label4: TLabel;
    Bevel5: TBevel;
    Label5: TLabel;
    btn_permissoes: TBitBtn;
    BitBtnUsuarios: TBitBtn;
    BitBtnEmpresa: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MnuUsuariosClick(Sender: TObject);
    procedure MnuEmpresaClick(Sender: TObject);
    procedure MnuProdutosClick(Sender: TObject);
    procedure MnuGruposClick(Sender: TObject);
    procedure MnuConsultadeProdutosClick(Sender: TObject);
    procedure TimerDataHoraTimer(Sender: TObject);
    procedure BitBtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MnuCadastrodeDuplicatasClick(Sender: TObject);
    procedure MnuBancosClick(Sender: TObject);
    procedure MnuRelVendasFechamentoClick(Sender: TObject);
    procedure MnuLoginClick(Sender: TObject);
    procedure MnuPermissoesClick(Sender: TObject);
    procedure MnuMovFinanceiroClick(Sender: TObject);
    procedure MnuRelVendasComissaoVendClick(Sender: TObject);
  private
    { Private declarations }
    XPMenuPrin   : TXpMenu;
    DadosConexao : TIniFile;
    function ConectaBanco(Servidor, Caminho : String) : Boolean;
    procedure VerificaConexao;
    procedure VerificaPermissoes;
  public
    { Public declarations }

  end;

var
  FormPrincipal: TFormPrincipal;

implementation                    

uses uFormClientes, uFormVendedores, uFormFornecedores, uFormUsuarios,
  uFormEmpresa, uFormProdutos, uFormGruposProdutos, 
  uFormConsultaProdutos, uFormConexao, uFormCondicoesPagto,
  uFormPedidoNota, uFormProcessamento, uFormCotacoes, uFormDuplicatas,
  uFormBanco, uFormRelatoriosGerais, uFormLogin, uFormPermissoes, uFuncoes,
  uFormContasPagRec, uFormConsultaPedidos;

{$R *.dfm}

procedure TFormPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  DataModulePrin := TDataModulePrin.Create(Self);
//  DataModulePrin.SQLConnectionPrin.Connected := False;
//  DataModulePrin.SQLConnectionPrin.Connected := True;
  XPMenuPrin := TXPMenu.Create(Self);
  XPMenuPrin.Active := True;
end;

procedure TFormPrincipal.FormDestroy(Sender: TObject);
begin
  DataModulePrin.Free;
  XPMenuPrin.Active := False;
  XPMenuPrin.Free;
end;

procedure TFormPrincipal.MnuUsuariosClick(Sender: TObject);
begin
  if MnuUsuarios.Enabled = False then
  begin
    Application.MessageBox('Acesso Negado!','Informação',0);
    Exit;
  end;

  Try
    LockWindowUpdate(Handle);
    Application.CreateForm(TFormUsuarios, FormUsuarios);
    FormUsuarios.Visible := False;
    FormUsuarios.ShowModal;
    LockWindowUpdate(0);
  Finally
    FormUsuarios.Free;
  end;
end;

procedure TFormPrincipal.MnuEmpresaClick(Sender: TObject);
begin
  if MnuEmpresa.Enabled = False then
  begin
    Application.MessageBox('Acesso Negado!','Informação',0);
    Exit;
  end;

  Try
    LockWindowUpdate(Handle);
    Application.CreateForm(TFormEmpresa, FormEmpresa);
    FormEmpresa.Visible := False;
    FormEmpresa.ShowModal;
    LockWindowUpdate(0);
  Finally
    FormEmpresa.Free;
  end;
end;

procedure TFormPrincipal.MnuProdutosClick(Sender: TObject);
begin
  if MnuProdutos.Enabled = False then
  begin
    Application.MessageBox('Acesso Negado!','Informação',0);
    Exit;
  end;

  Try
    LockWindowUpdate(Handle);
    Application.CreateForm(TFormProdutos, FormProdutos);
    FormProdutos.Visible := False;
    FormProdutos.ShowModal;
    LockWindowUpdate(0);
  Finally
    FormProdutos.Free;
  end;
end;

procedure TFormPrincipal.MnuGruposClick(Sender: TObject);
begin
  if MnuGrupos.Enabled = False then
  begin
    Application.MessageBox('Acesso Negado!','Informação',0);
    Exit;
  end;

  Try
    LockWindowUpdate(Handle);
    Application.CreateForm(TFormGruposProdutos, FormGruposProdutos);
    FormGruposProdutos.Visible := False;
    FormGruposProdutos.ShowModal;
    LockWindowUpdate(0);
  Finally
    FormGruposProdutos.Free;
  end;
end;

procedure TFormPrincipal.MnuConsultadeProdutosClick(Sender: TObject);
begin
  if MnuConsultadeProdutos.Enabled = False then
  begin
    Application.MessageBox('Acesso Negado!','Informação',0);
    Exit;
  end;

  Try
    LockWindowUpdate(Handle);
    Application.CreateForm(TFormConsultaProdutos, FormConsultaProdutos);
    FormConsultaProdutos.Visible := False;
    FormConsultaProdutos.ShowModal;
    LockWindowUpdate(0);
  Finally
    FormConsultaProdutos.Free;
  end;
end;

procedure TFormPrincipal.TimerDataHoraTimer(Sender: TObject);
begin
 StatusBarPrin.Panels[0].Text := DateTimeToStr(Now);
end;

procedure TFormPrincipal.BitBtnFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormPrincipal.VerificaConexao;
Var Servidor, Caminho : String;
begin
  Try
    DadosConexao := TIniFile.Create(Extractfilepath(Application.ExeName) + 'Dados.ini');
    Servidor     := '';
    Caminho      := '';
    if DadosConexao.ReadString('Banco','Servidor','') = '' then
    begin
      Try
        Application.CreateForm(TFormConexao, FormConexao);
        FormConexao.ShowModal;
      Finally
        if FormConexao.Modal_Ok then
        begin
          Servidor  := FormConexao.EditServidor.Text;
          Caminho   := FormConexao.EditCaminho.Text;
          if ConectaBanco(Servidor, Caminho) then
          begin
            DadosConexao.WriteString('Banco','Servidor',Servidor);
            DadosConexao.WriteString('Banco','Caminho',Caminho);
          end
          else
          begin
            FormConexao.Free;
            Application.Terminate;
          end;
        end
        else
        begin
          FormConexao.Free;
          Application.Terminate;
        end;
      end;
    end
    else
    begin                                         
      Servidor := DadosConexao.ReadString('Banco','Servidor','LOCALHOST');
      Caminho  := DadosConexao.ReadString('Banco','Caminho','c:\Dental\Dental.GDB');
      if ConectaBanco(Servidor, Caminho) = False then
        Application.Terminate
      else
      begin
        DadosConexao.WriteString('Banco','Servidor',Servidor);
        DadosConexao.WriteString('Banco','Caminho',Caminho);
      end;
    end;
    
  Finally
    DadosConexao.Free;
  end;  
end;

function TFormPrincipal.ConectaBanco(Servidor, Caminho : String) : Boolean;
begin
  Result := True;
  Try
    with DataModulePrin.SQLConnectionPrin do
    begin
      //LOCALHOST:c:\Dental\Dental.GDB
      Connected := False;
      Params.Values['Database'] := Servidor + ':' + Caminho;
      Connected := True;

      Try
        Application.CreateForm(TFormLogin, FormLogin);
        FormLogin.ShowModal;
      Finally
        if FormLogin.ModalResult <> MrOK then
        begin
          FormLogin.Free;
          Result := False;
          Application.Terminate;
        end;
      end;
    end;
  Except
    on e : exception do
    begin
      Result := False;
      MessageDlg('Ocorreram Erros ao Tentar Conectar! Erro: ' + e.Message, mtError, [mbOk], 0);
      Application.Terminate;
    end;
  end;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin

  VerificaConexao;
  StatusBarPrin.Panels[1].Text := 'Usuário Logado - ' + DataModulePrin.LoginLogado;
  VerificaPermissoes;
end;

procedure TFormPrincipal.MnuCadastrodeDuplicatasClick(Sender: TObject);
begin
  if MnuCadastrodeDuplicatas.Enabled = False then
  begin
    Application.MessageBox('Acesso Negado!','Informação',0);
    Exit;
  end;       

  Try
    LockWindowUpdate(Handle);
    Application.CreateForm(TFormDuplicatas, FormDuplicatas);
    FormDuplicatas.Visible := False;
    FormDuplicatas.ShowModal;
    LockWindowUpdate(0);
  Finally
    FormDuplicatas.Free;
  end;
end;

procedure TFormPrincipal.MnuBancosClick(Sender: TObject);
begin
  if MnuBancos.Enabled = False then
  begin
    Application.MessageBox('Acesso Negado!','Informação',0);
    Exit;
  end;
  
  Try
    LockWindowUpdate(Handle);
    Application.CreateForm(TFormBancos, FormBancos);
    FormBancos.Visible := False;
    FormBancos.ShowModal;
    LockWindowUpdate(0);
  Finally
    FormBancos.Free;
  end;
end;

procedure TFormPrincipal.MnuRelVendasFechamentoClick(
  Sender: TObject);
begin
  if MnuRelVendasFechamento.Enabled = False then
  begin
    Application.MessageBox('Acesso Negado!','Informação',0);
    Exit;
  end;

  Try
    LockWindowUpdate(Handle);
    Application.CreateForm(TFormRelatoriosGerais, FormRelatoriosGerais);
    FormRelatoriosGerais.Visible := False;
    FormRelatoriosGerais.RadioButtonFechamento.Checked := True;    
    FormRelatoriosGerais.ShowModal;
    LockWindowUpdate(0);
  Finally
    FormRelatoriosGerais.Free;
  end;
end;

procedure TFormPrincipal.MnuLoginClick(Sender: TObject);
begin
  if MnuLogin.Enabled = False then
  begin
    Application.MessageBox('Acesso Negado!','Informação',0);
    Exit;
  end;

  Try
    Application.CreateForm(TFormLogin, FormLogin);
    FormLogin.Visible := False;
    FormLogin.ShowModal;
  Finally
    if FormLogin.ModalResult <> MrOK then
    begin
      FormLogin.Free;
      Application.Terminate;
    end
    else
    begin
      StatusBarPrin.Panels[1].Text := 'Usuário Logado - ' + DataModulePrin.LoginLogado;
      VerificaPermissoes;
    end;
  end;
end;

procedure TFormPrincipal.MnuPermissoesClick(Sender: TObject);
begin
  if MnuPermissoes.Enabled = False then
  begin
    Application.MessageBox('Acesso Negado!','Informação',0);
    Exit;
  end;

  Try
    LockWindowUpdate(Handle);
    Application.CreateForm(TFormPermissoes, FormPermissoes);
    FormPermissoes.Visible := False;
    FormPermissoes.ShowModal;
    LockWindowUpdate(0);
  Finally
    FormPermissoes.Free;
    VerificaPermissoes;    
  end;
end;

procedure TFormPrincipal.VerificaPermissoes;
Var i, j, k : Integer;
begin
  VerifPermissoes;
  for i := 0 to MainMenuPrin.Items.Count - 1 do
  begin
    for j := 0 to MainMenuPrin.Items.Items[i].Count - 1 do
    begin
      if DataModulePrin.SQLQueryPesquisa.Locate('CodigoTela',MainMenuPrin.Items.Items[i].Items[j].Tag,[]) then
        MainMenuPrin.Items.Items[i].Items[j].Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('Visualizar').asInteger = 1);

      for k := 0 to MainMenuPrin.Items.Items[i].Items[j].Count - 1 do
      begin
        if DataModulePrin.SQLQueryPesquisa.Locate('CodigoTela',MainMenuPrin.Items.Items[i].Items[j].Items[k].Tag,[]) then
          MainMenuPrin.Items.Items[i].Items[j].Items[k].Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('Visualizar').asInteger = 1);
      end;
    end;
  end;
end;

procedure TFormPrincipal.MnuMovFinanceiroClick(Sender: TObject);
begin
  if MnuMovFinanceiro.Enabled = False then
  begin
    Application.MessageBox('Acesso Negado!','Informação',0);
    Exit;
  end;

  Try
    LockWindowUpdate(Handle);
    Application.CreateForm(TFormContasPagRec, FormContasPagRec);
    FormContasPagRec.Visible := False;
    FormContasPagRec.ShowModal;
    LockWindowUpdate(0);
  Finally
    FormContasPagRec.Free;
  end;

end;

procedure TFormPrincipal.MnuRelVendasComissaoVendClick(Sender: TObject);
begin
  if MnuRelVendasComissaoVend.Enabled = False then
  begin
    Application.MessageBox('Acesso Negado!','Informação',0);
    Exit;
  end;

  Try
    LockWindowUpdate(Handle);
    Application.CreateForm(TFormRelatoriosGerais, FormRelatoriosGerais);
    FormRelatoriosGerais.Visible := False;
    FormRelatoriosGerais.RadioButtonComissVend.Checked := True;
    FormRelatoriosGerais.ShowModal;
    LockWindowUpdate(0);
  Finally
    FormRelatoriosGerais.Free;
  end;
end;

end.
