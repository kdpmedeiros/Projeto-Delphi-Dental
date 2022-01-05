unit uFormPermissoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ImgList, uDataModule, FMTBcd, SqlExpr,
  Provider, DB, DBClient, uFormPrincipal, math, DBXPress, uFrameModelo,
  uFrameUsuario, Buttons, ExtCtrls;

type
  TFormPermissoes = class(TForm)
    GroupBoxPermissoes: TGroupBox;
    DBGridPermissoesBasicas: TDBGrid;
    GroupBoxPermissoesExcl: TGroupBox;
    DBGridPermissoesExcl: TDBGrid;
    ImageListPrin: TImageList;
    DS_PermissoesBasicas: TDataSource;
    DS_PermissoesExcl: TDataSource;
    CDSPermissoesBasicas: TClientDataSet;
    CDSPermissoesExcl: TClientDataSet;
    DSPPermissoes: TDataSetProvider;
    SQLPrincipal: TSQLDataSet;
    GroupBoxUsuario: TGroupBox;
    FrameUsuario: TFrameUsuario;
    PnlBotoes: TPanel;
    BitBtnConfirmar: TBitBtn;
    BitBtnFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DBGridPermissoesBasicasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBGridPermissoesBasicasCellClick(Column: TColumn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FrameUsuarioEditCodigoExit(Sender: TObject);
    procedure BitBtnFecharClick(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure DBGridPermissoesExclDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBGridPermissoesExclCellClick(Column: TColumn);
  private
    { Private declarations }
    SQL : TStringList;
    procedure MontaPermissoesBasicas;
    procedure GravarPermissoes;
    procedure MontaPermissoesExtras;
    procedure GravarPermissoesExtras;
  public
    { Public declarations }
  end;

var
  FormPermissoes: TFormPermissoes;

implementation

uses Menus, uFuncoes;

{$R *.dfm}

procedure TFormPermissoes.MontaPermissoesBasicas;
Var i, j, k : Integer;

  Procedure VerifCadastroTela(Codigo : Integer);
  begin
    with DataModulePrin.SQLQueryPesquisa do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Select * from Permissoes ');
      SQL.Add('where CodigoTela = :CodigoTela');
      SQL.Add('  and CodUsuario = :CodUsuario');
      ParambyName('CodigoTela').asInteger := Codigo;
      ParambyName('CodUsuario').asInteger := FrameUsuario.EditCodigo.asInteger;
      Open;
    end;
  end;

  Procedure CadastrarItemMenu(Menu : TMenuItem);
  begin
    if Menu.Tag <> 0 then
    begin
      VerifCadastroTela(Menu.Tag);

      with CDSPermissoesBasicas do
      begin
        Append;
        if not DataModulePrin.SQLQueryPesquisa.IsEmpty then
        begin
          FieldByName('CODIGOTELA').asInteger  := DataModulePrin.SQLQueryPesquisa.FieldByname('CODIGOTELA').asInteger;
          FieldByName('NOMETELA').asString     := DataModulePrin.SQLQueryPesquisa.FieldByname('NOMETELA').asString;
          FieldByName('NOMEFORM').asString     := DataModulePrin.SQLQueryPesquisa.FieldByname('NOMEFORM').asString;
          FieldByName('TELA').asString         := RetiraChar('&',Menu.Caption);
          FieldByName('VISUALIZAR').asInteger  := DataModulePrin.SQLQueryPesquisa.FieldByname('VISUALIZAR').asInteger;
          FieldByName('INSERIR').asInteger     := DataModulePrin.SQLQueryPesquisa.FieldByname('INSERIR').asInteger;
          FieldByName('ALTERAR').asInteger     := DataModulePrin.SQLQueryPesquisa.FieldByname('ALTERAR').asInteger;
          FieldByName('EXCLUIR').asInteger     := DataModulePrin.SQLQueryPesquisa.FieldByname('EXCLUIR').asInteger;
          FieldByName('STATUS').asString       := 'A';
        end
        else
        begin
          FieldByName('CODIGOTELA').asInteger  := Menu.Tag;
          FieldByName('NOMETELA').asString     := Menu.Name;
          FieldByName('NOMEFORM').asString     := Menu.Hint;
          FieldByName('TELA').asString         := RetiraChar('&',Menu.Caption);
          FieldByName('VISUALIZAR').asInteger  := 1;
          FieldByName('INSERIR').asInteger     := DataModulePrin.UsuarioAdmin;
          FieldByName('ALTERAR').asInteger     := DataModulePrin.UsuarioAdmin;
          FieldByName('EXCLUIR').asInteger     := DataModulePrin.UsuarioAdmin;
          FieldByName('STATUS').asString       := 'I';
        end;
        Post;
      end;
    end;
  end;
begin
  with DataModulePrin.SQLQueryPesquisa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select P.*, cast('' '' as varchar(50)) as Tela,');
    SQL.Add('            cast(''A'' as Char(1)) as Status');
    SQL.Add('From Permissoes P');
    SQL.Add('where CodigoTela = 0');
    Open;
  end;

  with CDSPermissoesBasicas do
  begin
    if Active then
    begin
      Close;
      FieldDefs.Clear;
    end;
    FieldDefs.Assign(DataModulePrin.SQLQueryPesquisa.FieldDefs);
    for i := 0 to FieldDefs.Count - 1 do
      FieldDefs[i].Required := false;
    CreateDataSet;

    for i := 0 to FormPrincipal.MainMenuPrin.Items.Count - 1 do
    begin
      for j := 0 to FormPrincipal.MainMenuPrin.Items.Items[i].Count - 1 do
      begin
        CadastrarItemMenu(FormPrincipal.MainMenuPrin.Items.Items[i].Items[j]);
        for k := 0 to FormPrincipal.MainMenuPrin.Items.Items[i].Items[j].Count - 1 do
          CadastrarItemMenu(FormPrincipal.MainMenuPrin.Items.Items[i].Items[j].Items[k]);
      end;
    end;
    CDSPermissoesBasicas.First;
  end;
  BitBtnConfirmar.Enabled := False;
end;

procedure TFormPermissoes.FormCreate(Sender: TObject);
begin
  SQL := TStringList.Create;
end;

procedure TFormPermissoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SQL.Free;
end;

procedure TFormPermissoes.FormShow(Sender: TObject);
begin
  FrameUsuario.EditCodigo.asInteger := DataModulePrin.UsuarioLogado;
  FrameUsuario.EditCodigo.OnExit(FrameUsuario.EditCodigo);

  HabilitaFrame(FrameUsuario,DataModulePrin.UsuarioAdmin = 1);
  HabilitaGroupBox(GroupBoxPermissoes,DataModulePrin.UsuarioAdmin = 1);
  HabilitaGroupBox(GroupBoxPermissoesExcl,DataModulePrin.UsuarioAdmin = 1);
  MontaPermissoesBasicas;
  MontaPermissoesExtras;  
end;

procedure TFormPermissoes.DBGridPermissoesBasicasDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (Column.Index = 0) then
    ImageListPrin.Draw(DBGridPermissoesBasicas.Canvas,Rect.left + 17,Rect.top,CDSPermissoesBasicas.FieldByName('VISUALIZAR').asInteger);
  if (Column.Index = 1) then
    ImageListPrin.Draw(DBGridPermissoesBasicas.Canvas,Rect.left + 12,Rect.top,CDSPermissoesBasicas.FieldByName('INSERIR').asInteger);
  if (Column.Index = 2) then
    ImageListPrin.Draw(DBGridPermissoesBasicas.Canvas,Rect.left + 12,Rect.top,CDSPermissoesBasicas.FieldByName('ALTERAR').asInteger);
  if (Column.Index = 3) then
    ImageListPrin.Draw(DBGridPermissoesBasicas.Canvas,Rect.left + 12,Rect.top,CDSPermissoesBasicas.FieldByName('EXCLUIR').asInteger);


end;

procedure TFormPermissoes.DBGridPermissoesBasicasCellClick(
  Column: TColumn);

  Procedure AlterarPermissao(Coluna : String);
  begin
    with CDSPermissoesBasicas do
    begin
      Edit;
      FieldByname(Coluna).AsInteger := Ifthen(FieldByname(Coluna).AsInteger = 0,1,0);
      Post;

      BitBtnConfirmar.Enabled := True;
    end;
  end;
begin
  if (Column.Index = 0) then
    AlterarPermissao('VISUALIZAR')
  else if (Column.Index = 1) then
    AlterarPermissao('INSERIR')
  else if (Column.Index = 2) then
    AlterarPermissao('ALTERAR')
  else if (Column.Index = 3) then
    AlterarPermissao('EXCLUIR');
end;

procedure TFormPermissoes.GravarPermissoes;
Var TransDesc : TTransactionDesc;
    BM : TBookMark;
begin
  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);
      BM := CDSPermissoesBasicas.GetBookmark;
      CDSPermissoesBasicas.DisableControls;
      CDSPermissoesBasicas.First;
      while not CDSPermissoesBasicas.EOF do
      begin
        With SQLQueryExecuta do
        begin
          Close;
          if CDSPermissoesBasicas.FieldByName('STATUS').asString = 'I' then
          begin
            SQL.Clear;
              SQL.Add(' INSERT INTO PERMISSOES (');
            SQL.Add('   CODIGOTELA, CODUSUARIO, NOMETELA, NOMEFORM, VISUALIZAR, INSERIR, ALTERAR, EXCLUIR)');
            SQL.Add(' VALUES ( ');
            SQL.Add('   :CODIGOTELA, :CODUSUARIO,  :NOMETELA, :NOMEFORM, :VISUALIZAR, :INSERIR, :ALTERAR, :EXCLUIR )');
          end
          else if CDSPermissoesBasicas.FieldByName('STATUS').asString = 'A' then
          begin
            SQL.Clear;
            SQL.Add(' UPDATE PERMISSOES');
            SQL.Add(' SET NOMETELA      = :NOMETELA,');
            SQL.Add('     NOMEFORM      = :NOMEFORM,');
            SQL.Add('     VISUALIZAR    = :VISUALIZAR,');
            SQL.Add('     INSERIR       = :INSERIR,');
            SQL.Add('     ALTERAR       = :ALTERAR,');
            SQL.Add('     EXCLUIR       = :EXCLUIR ');
            SQL.Add(' WHERE CODIGOTELA  = :CODIGOTELA ');
            SQL.Add('   AND CODUSUARIO  = :CODUSUARIO ');
          end;
          ParamByName('CODIGOTELA').asInteger  := CDSPermissoesBasicas.FieldByname('CODIGOTELA').asInteger;
          ParamByName('NOMETELA').asString     := CDSPermissoesBasicas.FieldByname('NOMETELA').asString;
          ParamByName('NOMEFORM').asString     := CDSPermissoesBasicas.FieldByname('NOMEFORM').asString;
          ParamByName('VISUALIZAR').asInteger  := CDSPermissoesBasicas.FieldByname('VISUALIZAR').asInteger;
          ParamByName('INSERIR').asInteger     := CDSPermissoesBasicas.FieldByname('INSERIR').asInteger;
          ParamByName('ALTERAR').asInteger     := CDSPermissoesBasicas.FieldByname('ALTERAR').asInteger;
          ParamByName('EXCLUIR').asInteger     := CDSPermissoesBasicas.FieldByname('EXCLUIR').asInteger;
          ParamByName('CODUSUARIO').asInteger  := FrameUsuario.EditCodigo.asInteger;
          ExecSQL;
        end;
        CDSPermissoesBasicas.Next;
      end;
      SQLConnectionPrin.Commit(TransDesc);
      Try
        CDSPermissoesBasicas.GotoBookmark(BM);
        CDSPermissoesBasicas.FreeBookmark(BM);
      Except
        CDSPermissoesBasicas.FreeBookmark(BM);
      end;
      CDSPermissoesBasicas.EnableControls;
      BitBtnConfirmar.Enabled := False;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar o Registro! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
end;

procedure TFormPermissoes.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TFormPermissoes.FrameUsuarioEditCodigoExit(Sender: TObject);
begin
  if ActiveControl = BitBtnFechar then
    Exit;
    
  FrameUsuario.EditCodigoExit(Sender);

  if FrameUsuario.EditCodigo.asInteger <> 0 then
  begin
    MontaPermissoesBasicas;
    MontaPermissoesExtras;
  end
  else
  begin
    Application.MessageBox('Informe o Usuário!','Informação',0);
    FrameUsuario.EditCodigo.SetFocus;
  end;
end;

procedure TFormPermissoes.BitBtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormPermissoes.BitBtnConfirmarClick(Sender: TObject);
begin
  GravarPermissoes;
  GravarPermissoesExtras;
end;

procedure TFormPermissoes.MontaPermissoesExtras;
begin
  with CDSPermissoesExcl do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select Pe.*, cast(''A'' as Char(1)) as Status');
    SQL.Add('From PermissoesExtras Pe');
    SQL.Add('where CodUsuario = :CodUsuario');
    CommandText := SQL.Text;
    Params.ParambyName('CodUsuario').asInteger := FrameUsuario.EditCodigo.asInteger;
    TratarClientDatasetParaPost(CDSPermissoesExcl);

    if Locate('CODPERMISSAO',1,[])  = False then
    begin
      Append;
      FieldByName('CODPERMISSAO').asInteger  := 1;
      FieldByName('CODUSUARIO').asInteger    := FrameUsuario.EditCodigo.asInteger;
      FieldByName('DESCRPERMISSAO').asString := 'Alterar Preços';
      FieldByName('FLAGSIMNAO').asInteger    := DataModulePrin.UsuarioAdmin;
      FieldByName('STATUS').asString         := 'I';
      Post;
    end;
  end;
end;

procedure TFormPermissoes.GravarPermissoesExtras;
Var TransDesc : TTransactionDesc;
    BM : TBookMark;
begin
  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);
      BM := CDSPermissoesExcl.GetBookmark;
      CDSPermissoesExcl.DisableControls;
      CDSPermissoesExcl.First;
      while not CDSPermissoesExcl.EOF do
      begin
        With SQLQueryExecuta do
        begin
          Close;
          if CDSPermissoesExcl.FieldByName('STATUS').asString = 'I' then
          begin
            SQL.Clear;
            SQL.Add(' INSERT INTO PERMISSOESEXTRAS (');
            SQL.Add('   CODPERMISSAO, CODUSUARIO, DESCRPERMISSAO, FLAGSIMNAO)');
            SQL.Add(' VALUES ( ');
            SQL.Add('   :CODPERMISSAO, :CODUSUARIO, :DESCRPERMISSAO, :FLAGSIMNAO )');
          end
          else if CDSPermissoesExcl.FieldByName('STATUS').asString = 'A' then
          begin
            SQL.Clear;
            SQL.Add(' UPDATE PERMISSOESEXTRAS');
            SQL.Add(' SET FLAGSIMNAO     = :FLAGSIMNAO,');
            SQL.Add('     DESCRPERMISSAO = :DESCRPERMISSAO');
            SQL.Add(' WHERE CODPERMISSAO = :CODPERMISSAO ');
            SQL.Add('   AND CODUSUARIO   = :CODUSUARIO ');
          end;
          ParamByName('CODPERMISSAO').asInteger  := CDSPermissoesExcl.FieldByname('CODPERMISSAO').asInteger;
          ParamByName('DESCRPERMISSAO').asString := CDSPermissoesExcl.FieldByname('DESCRPERMISSAO').asString;
          ParamByName('FLAGSIMNAO').asInteger    := CDSPermissoesExcl.FieldByname('FLAGSIMNAO').asInteger;
          ParamByName('CODUSUARIO').asInteger    := FrameUsuario.EditCodigo.asInteger;
          ExecSQL;
        end;
        CDSPermissoesExcl.Next;
      end;
      SQLConnectionPrin.Commit(TransDesc);
      Try
        CDSPermissoesExcl.GotoBookmark(BM);
        CDSPermissoesExcl.FreeBookmark(BM);
      Except
        CDSPermissoesExcl.FreeBookmark(BM);
      end;
      CDSPermissoesExcl.EnableControls;
      BitBtnConfirmar.Enabled := False;      
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar o Registro! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
end;



procedure TFormPermissoes.DBGridPermissoesExclDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (Column.Index = 1) then
    ImageListPrin.Draw(DBGridPermissoesExcl.Canvas,Rect.left + 5,Rect.top,CDSPermissoesExcl.FieldByName('FLAGSIMNAO').asInteger);
  if (Column.Index = 2) then
  begin
    if CDSPermissoesExcl.FieldByName('FLAGSIMNAO').asInteger = 0 then
      ImageListPrin.Draw(DBGridPermissoesExcl.Canvas,Rect.left + 5,Rect.top,1)
    else
      ImageListPrin.Draw(DBGridPermissoesExcl.Canvas,Rect.left + 5,Rect.top,0);    
  end
end;

procedure TFormPermissoes.DBGridPermissoesExclCellClick(Column: TColumn);
begin
  with CDSPermissoesExcl do
  begin
    Edit;
    FieldByname('FLAGSIMNAO').AsInteger := Ifthen(FieldByname('FLAGSIMNAO').AsInteger = 0,1,0);
    Post;

    BitBtnConfirmar.Enabled := True;
  end;
end;

end.
