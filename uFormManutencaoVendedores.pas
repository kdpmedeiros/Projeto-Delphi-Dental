unit uFormManutencaoVendedores;

interface
                                                       
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, ComCtrls, StdCtrls, uFrameModelo,
  uFrameVendedor, Buttons, ExtCtrls, DBXpress, SqlTimSt, math, DB,
  TAdvEditP, Mask, DBCtrls;

type
  TFormManutencaoVendedores = class(TFormManutencao)
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    Label20: TLabel;
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
    EditCodigo: TAdvEdit;
    EditPercComissao: TAdvEdit;
    Label14: TLabel;
    EditDataAniver: TAdvEdit;
    EditDataCadastro: TAdvEdit;
    PnlCPFCNPJ: TPanel;
    RadioButtonCPF: TRadioButton;
    RadioButtonCNPJ: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure EditDDDCom1Exit(Sender: TObject);
    procedure RadioButtonCPFClick(Sender: TObject);
    procedure RadioButtonCNPJClick(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure DBNavegadorClick(Sender: TObject; Button: TNavigateBtn);
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
  FormManutencaoVendedores: TFormManutencaoVendedores;

implementation

uses uDataModule, uFuncoes, StrUtils;

{$R *.dfm}

procedure TFormManutencaoVendedores.PrepararTelaManutencao;
begin
  with CDSCadastro do
  begin
    if iTipo = 1 then
    begin
      LimparTela;
      EditCodigo.asInteger    := RetornaProximaSequencia;
      EditDataCadastro.asDate := Now;
    end
    else if iTipo = 2 then
    begin
      EditCodigo.asInteger    := FieldByName('Codigo').asInteger;
      EditNome.Text           := FieldByName('Nome').asString;
      RadioButtonCPF.Checked  := (Length(FieldByName('CPFCNPJ').asString) <= 11);
      if RadioButtonCPF.Checked then
        RadioButtonCPF.OnClick(RadioButtonCPF);
      RadioButtonCNPJ.Checked := (Length(FieldByName('CPFCNPJ').asString) > 11);
      if RadioButtonCNPJ.Checked then
        RadioButtonCNPJ.OnClick(RadioButtonCNPJ);      
      EditCPFCNPJ.Text        := FieldByName('CPFCNPJ').asString;
      EditRGIE.Text           := FieldByName('RGIE').asString;
      EditEndereco.Text       := FieldByName('Endereco').asString;
      EditCEP.Text            := FieldByName('CEP').asString;
      EditBairro.Text         := FieldByName('Bairro').asString;
      EditCidade.Text         := FieldByName('Cidade').asString;
      EditEstado.Text         := FieldByName('Estado').asString;
      if not FieldByName('DataAniver').IsNull then
        EditDataAniver.asDate   := FieldByName('DataAniver').asDateTime;
      EditDataCadastro.asDate := FieldByName('DataCadastro').asDateTime;
      EditPercComissao.asFloat := FieldByName('PercComissao').asFloat;
      EditDDDCom1.asInteger      := RetornarDDD(FieldByName('TelComercial1').asString);
      EditDDDCom2.asInteger      := RetornarDDD(FieldByName('TelComercial2').asString);
      EditDDDFax.asInteger       := RetornarDDD(FieldByName('TelFax').asString);
      EditDDDRes.asInteger       := RetornarDDD(FieldByName('TelResidencial').asString);
      EditDDDCel.asInteger       := RetornarDDD(FieldByName('TelCelular').asString);
      EditTelComercial1.Text     := RetornarTelefone(FieldByName('TelComercial1').asString);
      EditTelComercial2.Text     := RetornarTelefone(FieldByName('TelComercial2').asString);
      EditTelFax.Text            := RetornarTelefone(FieldByName('TelFax').asString);
      EditTelResidencial.Text    := RetornarTelefone(FieldByName('TelResidencial').asString);
      EditTelCelular.Text        := RetornarTelefone(FieldByName('TelCelular').asString);
      EditNome.SetFocus;      
    end;
  end;
end;


procedure TFormManutencaoVendedores.FormShow(Sender: TObject);
begin
  EditNome.SetFocus;
  inherited;
  PrepararTelaManutencao;
end;

procedure TFormManutencaoVendedores.Gravar;
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
          SQL.Add(' INSERT INTO VENDEDORES (');
          SQL.Add('     CODIGO , NOME,CPFCNPJ,ENDERECO,BAIRRO,CEP,CIDADE,TELCOMERCIAL1,');
          SQL.Add('     TELCOMERCIAL2,TELFAX,TELRESIDENCIAL,TELCELULAR,ESTADO,RGIE,');
          SQL.Add('     DATAANIVER,DATACADASTRO, PERCCOMISSAO)');
          SQL.Add(' VALUES (');
          SQL.Add('     :CODIGO , :NOME,:CPFCNPJ,:ENDERECO,:BAIRRO,:CEP,:CIDADE,:TELCOMERCIAL1,');
          SQL.Add('     :TELCOMERCIAL2,:TELFAX,:TELRESIDENCIAL,:TELCELULAR,:ESTADO,:RGIE,');
          SQL.Add('     :DATAANIVER,:DATACADASTRO,:PERCCOMISSAO)');
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE VENDEDORES');
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
          SQL.Add('     DATAANIVER     = :DATAANIVER,');
          SQL.Add('     DATACADASTRO   = :DATACADASTRO,');
          SQL.Add('     PERCCOMISSAO   = :PERCCOMISSAO');
          SQL.Add(' WHERE CODIGO = :CODIGO');
        end;
        ParamByName('Codigo').asFloat      := EditCodigo.asFloat;
        ParamByName('Nome').asString       := EditNome.Text;
        if Trim(RetornaCPFCNPJ) <> '0' then
          ParamByName('CPFCNPJ').asString  := RetornaCPFCNPJ
        else
          ParamByName('CPFCNPJ').asString  := '0';
        ParamByName('RGIE').asString       := EditRGIE.Text;
        ParamByName('Endereco').asString   := EditEndereco.Text;
        if RetornaCEP <> '0' then
          ParamByName('CEP').asString      := RetornaCEP
        else
          ParamByName('CEP').asInteger     := 0;
        ParamByName('Bairro').asString     := EditBairro.Text;
        ParamByName('Cidade').asString     := EditCidade.Text;
        ParamByName('Estado').asString     := EditEstado.Text;
        ParamByName('DataAniver').DataType := ftTimeStamp;
        ParamByName('DataAniver').Clear;
        if EditDataAniver.IsDate then
          ParamByName('DataAniver').asSQLTimestamp := DateTimeToSQLTImesTamp(EditDataAniver.asDate);
        ParamByName('DataCadastro').DataType := ftTimeStamp;
        ParamByName('DataCadastro').Clear;
        if EditDataCadastro.IsDate then
          ParamByName('DataCadastro').asSQLTimestamp := DateTimeToSQLTImesTamp(EditDataCadastro.asDate);
        ParamByName('TelComercial1').asString      := GravarTelefone(EditDDDCom1.Text,EditTelComercial1.Text);
        ParamByName('TelComercial2').asString      := GravarTelefone(EditDDDCom2.Text, EditTelComercial2.Text);
        ParamByName('TelFax').asString             := GravarTelefone(EditDDDFax.Text, EditTelFax.Text);
        ParamByName('TelResidencial').asString     := GravarTelefone(EditDDDRes.Text, EditTelResidencial.Text);
        ParamByName('TelCelular').asString         := GravarTelefone(EditDDDCel.Text, EditTelCelular.Text);
        ParamByName('PercComissao').asFloat    := EditPercComissao.asFloat;
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


procedure TFormManutencaoVendedores.BitBtnConfirmarClick(Sender: TObject);
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

procedure TFormManutencaoVendedores.LimparTela;
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
  EditPercComissao.asFloat     := 0;
  EditDataAniver.Limpa;
  EditDataCadastro.Limpa;
end;


procedure TFormManutencaoVendedores.EditDDDCom1Exit(Sender: TObject);
begin
  inherited;
  ControlarDigitacao(Sender,2);
end;

procedure TFormManutencaoVendedores.RadioButtonCPFClick(Sender: TObject);
begin
  inherited;
  EditCPFCNPJ.EditMask :=  '!999\.999\.999\-99;0;';
  EditCPFCNPJ.SetFocus;
end;

procedure TFormManutencaoVendedores.RadioButtonCNPJClick(Sender: TObject);
begin
  inherited;
  EditCPFCNPJ.EditMask := '!99\.999\.999\/9999\-99;0;';
  EditCPFCNPJ.SetFocus;
end;

function TFormManutencaoVendedores.RetornaCPFCNPJ : String;
begin
  Result := RetiraChar('/',RetiraChar('-',RetiraChar('.', SoNumeros(EditCPFCNPJ.EditText))));
end;

function TFormManutencaoVendedores.RetornaCEP : String;
begin
  Result := RetiraChar('-',RetiraChar('.', SoNumeros(EditCEP.EditText)));
end;

function TFormManutencaoVendedores.RetornaProximaSequencia : Integer;
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
        SQL.Add('  Set CodVendedor = CodVendedor + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from Vendedores where Codigo = (Select CodVendedor from UltimaSequencia)');
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
      SQL.Add('Select CodVendedor from UltimaSequencia');
      Open;

      Result := FieldByname('CodVendedor').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;

procedure TFormManutencaoVendedores.VoltaUltimSequencia;
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
      SQL.Add('  Set CodVendedor = ' + EditCodigo.Text + ' - 1');
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



procedure TFormManutencaoVendedores.BitBtnCancelarClick(Sender: TObject);
begin
  inherited;
  if iTipo = 1 then
    VoltaUltimSequencia
end;

procedure TFormManutencaoVendedores.DBNavegadorClick(Sender: TObject;
  Button: TNavigateBtn);
begin
  inherited;
  PrepararTelaManutencao;
end;

procedure TFormManutencaoVendedores.DS_ManutencaoDataChange(
  Sender: TObject; Field: TField);
begin
  inherited;
  if (CheckBoxFecharTela.Checked = False) and Self.Showing then
    PrepararTelaManutencao;

end;

procedure TFormManutencaoVendedores.EditNomeExit(Sender: TObject);
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
