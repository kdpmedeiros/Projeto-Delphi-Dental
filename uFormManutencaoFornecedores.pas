unit uFormManutencaoFornecedores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, Buttons, ExtCtrls, ComCtrls, StdCtrls,
  DBXpress, SqlTimSt, math, DB, TAdvEditP, Mask, DBCtrls;

type
  TFormManutencaoFornecedores = class(TFormManutencao)
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    EditNome: TAdvEdit;
    EditCPFCNPJ: TMaskEdit;
    EditEndereco: TAdvEdit;
    EditBairro: TAdvEdit;
    EditCidade: TAdvEdit;
    EditEstado: TAdvEdit;
    EditCEP: TMaskEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditTelComercial1: TAdvEdit;
    EditTelComercial2: TAdvEdit;
    EditTelFax: TAdvEdit;
    EditTelResidencial: TAdvEdit;
    EditTelCelular: TAdvEdit;
    EditDDDCom1: TAdvEdit;
    EditDDDCom2: TAdvEdit;
    EditDDDFax: TAdvEdit;
    EditDDDRes: TAdvEdit;
    EditDDDCel: TAdvEdit;
    EditRGIE: TAdvEdit;
    EditSite: TAdvEdit;
    EditEmail: TAdvEdit;
    EditContato: TAdvEdit;
    EditRepresentante: TAdvEdit;
    EditCodigo: TAdvEdit;
    EditDataCadastro: TAdvEdit;
    RadioButtonCNPJ: TRadioButton;
    RadioButtonCPF: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure EditDDDCom1Exit(Sender: TObject);
    procedure RadioButtonCPFClick(Sender: TObject);
    procedure RadioButtonCNPJClick(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure DS_ManutencaoDataChange(Sender: TObject; Field: TField);
    procedure EditNomeExit(Sender: TObject);
  private
    { Private declarations }
    procedure PrepararTelaManutencao;
    procedure Gravar;
    procedure LimparTela;
    function RetornaCPFCNPJ : String;
    function RetornaCEP : String;
    function RetornaProximaSequencia : Integer;
    procedure VoltaUltimSequencia;
  public
    { Public declarations }
  end;

var
  FormManutencaoFornecedores: TFormManutencaoFornecedores;

implementation

uses uDataModule, uFuncoes, StrUtils;

{$R *.dfm}

procedure TFormManutencaoFornecedores.PrepararTelaManutencao;
begin
  with CDSCadastro do
  begin
    if iTipo = 1 then
    begin
      LimparTela;
      EditCodigo.asInteger := RetornaProximaSequencia;
      EditDataCadastro.asDate := Now;
    end
    else if iTipo = 2 then
    begin
      EditCodigo.asInteger    := FieldByName('Codigo').asInteger;
      EditNome.Text           := FieldByName('Nome').asString;
      RadioButtonCPF.Checked     := (Length(FieldByName('CPFCNPJ').asString) <= 11);
      if RadioButtonCPF.Checked then
        RadioButtonCPF.OnClick(RadioButtonCPF);
      RadioButtonCNPJ.Checked    := (Length(FieldByName('CPFCNPJ').asString) > 11);
      if RadioButtonCNPJ.Checked then
        RadioButtonCNPJ.OnClick(RadioButtonCNPJ);
      EditCPFCNPJ.Text        := FieldByName('CPFCNPJ').asString;
      EditRGIE.Text           := FieldByName('RGIE').asString;
      EditEndereco.Text       := FieldByName('Endereco').asString;
      EditCEP.Text            := FieldByName('CEP').asString;
      EditBairro.Text         := FieldByName('Bairro').asString;
      EditCidade.Text         := FieldByName('Cidade').asString;
      EditEstado.Text         := FieldByName('Estado').asString;
      EditDataCadastro.asDate := FieldByName('DataCadastro').asDateTime;
      EditDDDCom1.asInteger   := RetornarDDD(FieldByName('TelComercial1').asString);
      EditDDDCom2.asInteger   := RetornarDDD(FieldByName('TelComercial2').asString);
      EditDDDFax.asInteger    := RetornarDDD(FieldByName('TelFax').asString);
      EditDDDRes.asInteger    := RetornarDDD(FieldByName('TelResidencial').asString);
      EditDDDCel.asInteger    := RetornarDDD(FieldByName('TelCelular').asString);
      EditTelComercial1.Text  := RetornarTelefone(FieldByName('TelComercial1').asString);
      EditTelComercial2.Text  := RetornarTelefone(FieldByName('TelComercial2').asString);
      EditTelFax.Text         := RetornarTelefone(FieldByName('TelFax').asString);
      EditTelResidencial.Text := RetornarTelefone(FieldByName('TelResidencial').asString);
      EditTelCelular.Text     := RetornarTelefone(FieldByName('TelCelular').asString);
      EditSite.Text           := FieldByName('Site').asString;
      EditEmail.Text          := FieldByName('EMail').asString;
      EditContato.Text        := FieldByName('Contato').asString;
      EditRepresentante.Text  := FieldByName('Representante').asString;
    end;
  end;
end;


procedure TFormManutencaoFornecedores.FormShow(Sender: TObject);
begin
  EditNome.SetFocus;
  inherited;
  PrepararTelaManutencao;
end;


procedure TFormManutencaoFornecedores.Gravar;
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
          SQL.Add(' INSERT INTO FORNECEDORES (');
          SQL.Add('     CODIGO , NOME,CPFCNPJ,ENDERECO,BAIRRO,CEP,CIDADE,TELCOMERCIAL1,');
          SQL.Add('     TELCOMERCIAL2,TELFAX,TELRESIDENCIAL,TELCELULAR,ESTADO,RGIE,SITE,');
          SQL.Add('     EMAIL,CONTATO,REPRESENTANTE,DATACADASTRO)');
          SQL.Add(' VALUES (');
          SQL.Add('     :CODIGO , :NOME,:CPFCNPJ,:ENDERECO,:BAIRRO,:CEP,:CIDADE,:TELCOMERCIAL1,');
          SQL.Add('     :TELCOMERCIAL2,:TELFAX,:TELRESIDENCIAL,:TELCELULAR,:ESTADO,:RGIE,:SITE,');
          SQL.Add('     :EMAIL,:CONTATO,:REPRESENTANTE,:DATACADASTRO)');
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE FORNECEDORES');
          SQL.Add(' SET NOME           = :NOME,');
          SQL.Add('     CPFCNPJ        = :CPFCNPJ,');
          SQL.Add('     ENDERECO       = :ENDERECO,');
          SQL.Add('     BAIRRO         = :BAIRRO,');
          SQL.Add('     CEP            = :CEP,');
          SQL.Add('     CIDADE         = :CIDADE,');
          SQL.Add('     TELCOMERCIAL1  = :TELCOMERCIAL1,');
          SQL.Add('     TELCOMERCIAL2  = :TELCOMERCIAL2,');
          SQL.Add('     TELFAX         = :TELFAX,');
          SQL.Add('     TELRESIDENCIAL = :TELRESIDENCIAL,');
          SQL.Add('     TELCELULAR     = :TELCELULAR,');
          SQL.Add('     ESTADO         = :ESTADO,');
          SQL.Add('     RGIE           = :RGIE,');
          SQL.Add('     SITE           = :SITE,');
          SQL.Add('     EMAIL          = :EMAIL,');
          SQL.Add('     CONTATO        = :CONTATO,');
          SQL.Add('     REPRESENTANTE  = :REPRESENTANTE,');
          SQL.Add('     DATACADASTRO   = :DATACADASTRO');
          SQL.Add(' WHERE CODIGO = :CODIGO');
        end;
        ParamByName('Codigo').asFloat        := EditCodigo.asFloat;
        ParamByName('Nome').asString         := EditNome.Text;
        if Trim(RetornaCPFCNPJ) <> '0' then
          ParamByName('CPFCNPJ').asString    := RetornaCPFCNPJ
        else
          ParamByName('CPFCNPJ').asString    := '0';
        ParamByName('RGIE').asString         := EditRGIE.Text;
        ParamByName('Endereco').asString     := EditEndereco.Text;
        ParamByName('CEP').asString          := RetornaCEP;
        ParamByName('Bairro').asString       := EditBairro.Text;
        ParamByName('Cidade').asString       := EditCidade.Text;
        ParamByName('Estado').asString       := EditEstado.Text;
        ParamByName('DataCadastro').DataType := ftTimeStamp;
        ParamByName('DataCadastro').Clear;
        if EditDataCadastro.IsDate then
          ParamByName('DataCadastro').asSQLTimestamp := DateTimeToSQLTImesTamp(EditDataCadastro.asDate);
        ParamByName('TelComercial1').asString  := GravarTelefone(EditDDDCom1.Text,EditTelComercial1.Text);
        ParamByName('TelComercial2').asString  := GravarTelefone(EditDDDCom2.Text, EditTelComercial2.Text);
        ParamByName('TelFax').asString         := GravarTelefone(EditDDDFax.Text, EditTelFax.Text);
        ParamByName('TelResidencial').asString := GravarTelefone(EditDDDRes.Text, EditTelResidencial.Text);
        ParamByName('TelCelular').asString     := GravarTelefone(EditDDDCel.Text, EditTelCelular.Text);
        ParamByName('Site').asString           := EditSite.Text;
        ParamByName('EMail').asString          := EditEmail.Text;
        ParamByName('Contato').asString        := EditContato.Text;
        ParamByName('Representante').asString  := EditRepresentante.Text;
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


procedure TFormManutencaoFornecedores.BitBtnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  if Trim(EditNome.Text) = '' then
  begin
    MessageDlg('Informe a Razão Social!', mtInformation, [mbOk], 0);
    EditNome.SetFocus;
    Exit;
  end;
    
  Gravar;
end;

procedure TFormManutencaoFornecedores.LimparTela;
begin
  EditCodigo.asInteger         := 0;
  EditNome.Text                := '';
  EditCPFCNPJ.Text             := '0';
  EditRGIE.Text                := '';
  EditEndereco.Text            := '';
  EditCEP.Text                 := '0';
  EditBairro.Text              := '';
  EditCidade.Text              := '';
  EditEstado.Text              := '';
  EditDDDCom1.asInteger        := 0;
  EditDDDCom2.asInteger        := 0;
  EditDDDFax.asInteger         := 0;
  EditDDDRes.asInteger         := 0;
  EditDDDCel.asInteger         := 0;
  EditTelComercial1.asInteger  := 0;
  EditTelComercial2.asInteger  := 0;
  EditTelFax.asInteger         := 0;
  EditTelResidencial.asInteger := 0;
  EditTelCelular.asInteger     := 0;
  EditSite.Text                := '';
  EditEmail.Text               := '';
  EditContato.Text             := '';
  EditRepresentante.Text       := '';
end;


procedure TFormManutencaoFornecedores.EditDDDCom1Exit(Sender: TObject);
begin
  inherited;
  ControlarDigitacao(Sender,2);
end;

procedure TFormManutencaoFornecedores.RadioButtonCPFClick(Sender: TObject);
begin
  inherited;
  EditCPFCNPJ.EditMask :=  '!999\.999\.999\-99;0;';
  EditCPFCNPJ.SetFocus;
end;

procedure TFormManutencaoFornecedores.RadioButtonCNPJClick(
  Sender: TObject);
begin
  inherited;
  EditCPFCNPJ.EditMask := '!99\.999\.999\/9999\-99;0;';
  EditCPFCNPJ.SetFocus;
end;

function TFormManutencaoFornecedores.RetornaCPFCNPJ : String;
begin
  Result := RetiraChar('/',RetiraChar('-',RetiraChar('.', SoNumeros(EditCPFCNPJ.EditText))));
end;

function TFormManutencaoFornecedores.RetornaCEP : String;
begin
  Result := RetiraChar('-',RetiraChar('.', SoNumeros(EditCEP.EditText)));
end;

function TFormManutencaoFornecedores.RetornaProximaSequencia : Integer;
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
        SQL.Add('  Set CodFornecedor = CodFornecedor + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from Fornecedores where Codigo = (Select CodFornecedor from UltimaSequencia)');
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
      SQL.Add('Select CodFornecedor from UltimaSequencia');
      Open;

      Result := FieldByname('CodFornecedor').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;

procedure TFormManutencaoFornecedores.VoltaUltimSequencia;
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
      SQL.Add('  Set CodFornecedor = ' + EditCodigo.Text + ' - 1');
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

procedure TFormManutencaoFornecedores.BitBtnCancelarClick(Sender: TObject);
begin
  inherited;
  if iTipo = 1 then
    VoltaUltimSequencia;
end;

procedure TFormManutencaoFornecedores.DS_ManutencaoDataChange(
  Sender: TObject; Field: TField);
begin
  inherited;
  if (CheckBoxFecharTela.Checked = False) and Self.Showing then
    PrepararTelaManutencao;

end;

procedure TFormManutencaoFornecedores.EditNomeExit(Sender: TObject);
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

