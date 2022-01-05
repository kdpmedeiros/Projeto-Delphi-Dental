unit uFormManutencaoBancos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, DB, DBCtrls, StdCtrls, Buttons, ExtCtrls,
  TAdvEditP, Math, DBXpress  ;

type
  TFormManutencaoBancos = class(TFormManutencao)
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label23: TLabel;
    Label1: TLabel;
    EditNome: TAdvEdit;
    EditCodigo: TAdvEdit;
    EditNumBanco: TAdvEdit;
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
    function  RetornaProximaSequencia : Integer;
    procedure VoltaUltimSequencia;
  public
    { Public declarations }
  end;

var
  FormManutencaoBancos: TFormManutencaoBancos;

implementation

uses uDataModule;

{$R *.dfm}

procedure TFormManutencaoBancos.PrepararTelaManutencao;
begin
  with CDSCadastro do
  begin
    if iTipo = 1 then
    begin
      LimparTela;
      EditCodigo.asInteger  := RetornaProximaSequencia;
    end
    else if iTipo = 2 then
    begin
      EditCodigo.asInteger   := FieldByName('Codigo').asInteger;
      EditNome.Text          := FieldByName('Descricao').asString;
      EditNumBanco.asInteger := FieldByName('NumeroBanco').asInteger;
    end;
  end;
end;


procedure TFormManutencaoBancos.FormShow(Sender: TObject);
begin
  EditNome.SetFocus;
  inherited;
  PrepararTelaManutencao;
end;

procedure TFormManutencaoBancos.Gravar;
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
          SQL.Add(' INSERT INTO BANCOS (');
          SQL.Add('     CODIGO , DESCRICAO, NUMEROBANCO )');
          SQL.Add(' VALUES (');
          SQL.Add('     :CODIGO , :DESCRICAO, :NUMEROBANCO )');
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE BANCOS');
          SQL.Add(' SET DESCRICAO    = :DESCRICAO,');
          SQL.Add('     NUMEROBANCO  = :NUMEROBANCO');
          SQL.Add(' WHERE CODIGO  = :CODIGO');
        end;
        ParamByName('Codigo').asFloat        := EditCodigo.asFloat;
        ParamByName('Descricao').asString    := EditNome.Text;
        ParamByName('NumeroBanco').asInteger := EditNumBanco.asInteger;
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


procedure TFormManutencaoBancos.BitBtnConfirmarClick(Sender: TObject);
begin
  inherited;
  Gravar;
end;

procedure TFormManutencaoBancos.LimparTela;
begin
  EditCodigo.asInteger := 0;
  EditNome.Text        := '';
  EditNumBanco.Limpa;
end;

function TFormManutencaoBancos.RetornaProximaSequencia : Integer;
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
        SQL.Add('  Set CodBanco = CodBanco + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from Bancos where Codigo = (Select CodBanco from UltimaSequencia)');
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
      SQL.Add('Select CodBanco from UltimaSequencia');
      Open;

      Result := FieldByname('CodBanco').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;

procedure TFormManutencaoBancos.VoltaUltimSequencia;
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
      SQL.Add('  Set CodBanco = ' + EditCodigo.Text + ' - 1');
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



procedure TFormManutencaoBancos.BitBtnCancelarClick(Sender: TObject);
begin
  inherited;
  if iTipo = 1 then
    VoltaUltimSequencia;
end;

procedure TFormManutencaoBancos.DS_ManutencaoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if (CheckBoxFecharTela.Checked = False) and Self.Showing then
    PrepararTelaManutencao;
end;

procedure TFormManutencaoBancos.EditNomeExit(Sender: TObject);
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
