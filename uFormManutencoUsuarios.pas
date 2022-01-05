unit uFormManutencoUsuarios;

interface
                    
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, Buttons, ExtCtrls, StdCtrls,DBXpress, SqlTimSt, math, DB,
  TAdvEditP, DBCtrls;

type
  TFormManutencaoUsuarios = class(TFormManutencao)
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label9: TLabel;
    Label23: TLabel;
    EditNome: TAdvEdit;
    EditLogin: TAdvEdit;
    EditCodigo: TAdvEdit;
    EditSenha: TAdvEdit;
    Label5: TLabel;
    CheckBoxAdministrador: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure DS_ManutencaoDataChange(Sender: TObject; Field: TField);
    procedure EditNomeExit(Sender: TObject);
  private
    { Private declarations }
    procedure PrepararTelaManutencao;
    procedure Gravar;
    procedure LimparTela;
    function RetornaProximaSequencia : Integer;
    procedure VoltaUltimSequencia;
  public
    { Public declarations }
  end;

var
  FormManutencaoUsuarios: TFormManutencaoUsuarios;

implementation

uses uDataModule;

{$R *.dfm}

procedure TFormManutencaoUsuarios.PrepararTelaManutencao;
begin
  with CDSCadastro do
  begin
    if iTipo = 1 then
    begin
      LimparTela;
      EditCodigo.asInteger := RetornaProximaSequencia;
    end
    else if iTipo = 2 then
    begin
      EditCodigo.asInteger := FieldByName('Codigo').asInteger;
      EditNome.Text        := FieldByName('Nome').asString;
      EditLogin.Text       := FieldByName('Login').asString;
      EditSenha.Text       := FieldByName('Senha').asString;
      if FieldByName('Administrador').asInteger = 0 then
        CheckBoxAdministrador.Checked := False
      else
        CheckBoxAdministrador.Checked := True;
    end;
  end;
end;



procedure TFormManutencaoUsuarios.FormShow(Sender: TObject);
begin
  EditNome.SetFocus;
  inherited;
  PrepararTelaManutencao;  
end;

procedure TFormManutencaoUsuarios.Gravar;
Var TransDesc : TTransactionDesc;
begin
  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);
      With SQLQueryExecuta do
      begin
        Close;
        if iTipo = 1 then
        begin
          SQL.Clear;
          SQL.Add(' INSERT INTO USUARIOS (');
          SQL.Add('     CODIGO , NOME, LOGIN, SENHA, ADMINISTRADOR)');
          SQL.Add(' VALUES (');
          SQL.Add('     :CODIGO , :NOME, :LOGIN, :SENHA, :ADMINISTRADOR)');
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE USUARIOS');
          SQL.Add(' SET NOME           = :NOME,');
          SQL.Add('     LOGIN          = :LOGIN,');
          SQL.Add('     SENHA          = :SENHA,');
          SQL.Add('     ADMINISTRADOR  = :ADMINISTRADOR');
          SQL.Add(' WHERE CODIGO = :CODIGO');
        end;
        ParamByName('Codigo').asFloat  := EditCodigo.asFloat;
        ParamByName('Nome').asString   := EditNome.Text;
        ParamByName('Login').asString  := EditLogin.Text;
        ParamByName('Senha').asString  := EditSenha.Text;
        if CheckBoxAdministrador.Checked then
          ParamByName('Administrador').asInteger  := 1
        else
          ParamByName('Administrador').asInteger  := 0;
        ExecSQL;
        SQLConnectionPrin.Commit(TransDesc);
        if CheckBoxFecharTela.Checked then
          Self.Close
        else
        begin
          LimparTela;        
          if iTipo = 2 then
            CDSCadastro.Next;        
          PrepararTelaManutencao;
          EditNome.SetFocus;
        end;
      end;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar o Registro! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
end;


procedure TFormManutencaoUsuarios.BitBtnConfirmarClick(Sender: TObject);
begin
  inherited;
  if Trim(EditNome.Text) = '' then
  begin
    MessageDlg('Informe o Nome!', mtInformation, [mbOk], 0);
    EditNome.SetFocus;
    Exit;
  end;

  Gravar;
end;

procedure TFormManutencaoUsuarios.LimparTela;
begin
  EditCodigo.asFloat := 0;
  EditNome.Text      := '';
  EditLogin.Text     := '';
  EditSenha.Text     := '';
  CheckBoxAdministrador.Checked := False;
end;

function TFormManutencaoUsuarios.RetornaProximaSequencia : Integer;
Var TransDesc : TTransactionDesc;

  function GravaUltimaSequencia : Boolean;
  begin
    Result := False;
    Try
      TransDesc.TransactionID  := 1;
      TransDesc.IsolationLevel := xilREADCOMMITTED;
      DataModulePrin.SQLConnectionPrin.StartTransaction(TransDesc);
      with DataModulePrin.SQLQueryExecuta do
      begin
        Close;
        SQL.Clear;
        SQL.Add('Update UltimaSequencia');
        SQL.Add('  Set CodUsuario = CodUsuario + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from Usuarios where Codigo = (Select CodUsuario from UltimaSequencia)');
        Open;

        Result := (FieldByName('Qtde').asInteger = 0);
      end;
    Except
      on e: exception do
      begin
        Application.MessageBox(PChar('Ocorreram Erros ao Gravar Sequencia. O Registro Não Poderá ser Gravado! Erro: '+ e.Message),'Erro',0);
        DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
        Close;
      end;
    end;
  end;
begin
  if GravaUltimaSequencia = True then
  begin
    with DataModulePrin.SQLQueryExecuta do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Select CodUsuario from UltimaSequencia');
      Open;

      Result := FieldByname('CodUsuario').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;


procedure TFormManutencaoUsuarios.VoltaUltimSequencia;
Var TransDesc : TTransactionDesc;
begin
  Try
    TransDesc.TransactionID  := 1;
    TransDesc.IsolationLevel := xilREADCOMMITTED;
    DataModulePrin.SQLConnectionPrin.StartTransaction(TransDesc);
    with DataModulePrin.SQLQueryExecuta do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Update UltimaSequencia');
      SQL.Add('  Set CodUsuario = ' + EditCodigo.Text + ' - 1');
      ExecSQL;
      DataModulePrin.SQLConnectionPrin.Commit(TransDesc);
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Retornar Sequencia. O Registro Não Poderá ser Gravado! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
      Close;
    end;
  end;
end;   

procedure TFormManutencaoUsuarios.BitBtnCancelarClick(Sender: TObject);
begin
  inherited;
  if iTipo = 1 then
    VoltaUltimSequencia;
end;

procedure TFormManutencaoUsuarios.DS_ManutencaoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if (CheckBoxFecharTela.Checked = False) and Self.Showing then
    PrepararTelaManutencao;
end;

procedure TFormManutencaoUsuarios.EditNomeExit(Sender: TObject);
begin
  inherited;
  if ActiveControl = BitBtnCancelar then
    Exit;
      
  if Trim(EditNome.Text) = '' then
  begin
    EditNome.SetFocus;
    Exit;
  end;
end;

end.
