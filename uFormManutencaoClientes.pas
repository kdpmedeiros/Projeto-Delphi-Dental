unit uFormManutencaoClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, Buttons, ExtCtrls, StdCtrls, ComCtrls,
  uFrameModelo, uFrameVendedor, DBXpress, SqlTimSt, math, DB, TAdvEditP,
  Mask, DBCtrls;

type
  TFormManutencaoClientes = class(TFormManutencao)
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    EditNome: TAdvEdit;
    EditCPFCNPJ: TMaskEdit;
    EditEndereco: TAdvEdit;
    EditBairro: TAdvEdit;
    EditCidade: TAdvEdit;
    EditEstado: TAdvEdit;
    EditCEP: TMaskEdit;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    EditTelComercial1: TAdvEdit;
    Label2: TLabel;
    EditTelComercial2: TAdvEdit;
    Label4: TLabel;
    EditTelFax: TAdvEdit;
    Label6: TLabel;
    EditTelResidencial: TAdvEdit;
    Label7: TLabel;
    Label8: TLabel;
    EditTelCelular: TAdvEdit;
    EditDDDCom1: TAdvEdit;
    EditDDDCom2: TAdvEdit;
    EditDDDFax: TAdvEdit;
    EditDDDRes: TAdvEdit;
    EditDDDCel: TAdvEdit;
    EditRGIE: TAdvEdit;
    Label9: TLabel;
    EditSite: TAdvEdit;
    Label14: TLabel;
    EditEmail: TAdvEdit;
    Label15: TLabel;
    Label16: TLabel;
    EditCro: TAdvEdit;
    Label17: TLabel;
    EditProfissao: TAdvEdit;
    Label18: TLabel;
    Label19: TLabel;
    EditSecretaria: TAdvEdit;
    GBSituacao: TGroupBox;
    GroupBox3: TGroupBox;
    FrameVendedor: TFrameVendedor;
    LblSituacao: TLabel;
    LblBloqueado: TLabel;
    MemoObservacao: TMemo;
    Label22: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    EditCodigo: TAdvEdit;
    EditDataAniver: TAdvEdit;
    EditDataCadastro: TAdvEdit;
    RadioButtonDentista: TRadioButton;
    RadioButtonProtetico: TRadioButton;
    RadioButtonOutros: TRadioButton;
    CheckBoxCG: TCheckBox;
    CheckBoxC: TCheckBox;
    CheckBoxD: TCheckBox;
    CheckBoxE: TCheckBox;
    CheckBoxI: TCheckBox;
    CheckBoxP: TCheckBox;
    CheckBoxPD: TCheckBox;
    CheckBoxRD: TCheckBox;
    PnlCPFCNPJ: TPanel;
    RadioButtonCPF: TRadioButton;
    RadioButtonCNPJ: TRadioButton;
    CheckBoxReabOralEst: TCheckBox;
    CheckBoxOD: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure EditDDDCom1Exit(Sender: TObject);
    procedure RadioButtonCPFClick(Sender: TObject);
    procedure RadioButtonCNPJClick(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure DS_ManutencaoDataChange(Sender: TObject; Field: TField);
    procedure EditNomeExit(Sender: TObject);
    procedure MemoObservacaoEnter(Sender: TObject);
    procedure MemoObservacaoExit(Sender: TObject);
  private
    { Private declarations }
    procedure PrepararTelaManutencao;
    procedure TratarSituacaoBloqueio;
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
  FormManutencaoClientes: TFormManutencaoClientes;

implementation

uses uDataModule, uFuncoes, StrUtils;

{$R *.dfm}

procedure TFormManutencaoClientes.PrepararTelaManutencao;
begin
  LblSituacao.Caption     := 'Ativo';
  LblSituacao.Font.Color  := clBlue;
  LblBloqueado.Caption    := 'Não';
  LblBloqueado.Font.Color := clBlue;

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
      EditCodigo.asInteger       := FieldByName('Codigo').asInteger;
      EditNome.Text              := FieldByName('Nome').asString;
      RadioButtonCPF.Checked     := (Length(FieldByName('CPFCNPJ').asString) <= 11);
      if RadioButtonCPF.Checked then
        RadioButtonCPF.OnClick(RadioButtonCPF);
      RadioButtonCNPJ.Checked    := (Length(FieldByName('CPFCNPJ').asString) > 11);
      if RadioButtonCNPJ.Checked then
        RadioButtonCNPJ.OnClick(RadioButtonCNPJ);
      EditCPFCNPJ.Text           := FieldByName('CPFCNPJ').asString;
      EditRGIE.Text              := FieldByName('RGIE').asString;
      EditEndereco.Text          := FieldByName('Endereco').asString;
      EditCEP.Text               := FieldByName('CEP').asString;
      EditBairro.Text            := FieldByName('Bairro').asString;
      EditCidade.Text            := FieldByName('Cidade').asString;
      EditEstado.Text            := FieldByName('Estado').asString;
      if not FieldByName('DataAniver').IsNull then
        EditDataAniver.asDate      := FieldByName('DataAniver').asDateTime;
      EditDataCadastro.asDate    := FieldByName('DataCadastro').asDateTime;
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
      EditSite.Text              := FieldByName('Site').asString;
      EditEmail.Text             := FieldByName('EMail').asString;
      if UpperCase(FieldByName('Profissao').asString) = 'DENTISTA' then
        RadioButtonDentista.Checked   := True
      else if UpperCase(FieldByName('Profissao').asString) = 'PROTETICO' then
        RadioButtonProtetico.Checked  := True
      else
      begin
        RadioButtonOutros.Checked     := True;
        EditProfissao.Text            := FieldByName('Profissao').asString;
      end;
      CheckBoxCG.Checked              := FieldByName('CLINICAGERAL').asInteger  = 1;
      CheckBoxC.Checked               := FieldByName('CIRURGIA').asInteger      = 1;
      CheckBoxE.Checked               := FieldByName('ENDODONTIA').asInteger    = 1;
      CheckBoxD.Checked               := FieldByName('DENTISTICA').asInteger    = 1;
      CheckBoxI.Checked               := FieldByName('IMPLANTOLOGIA').asInteger = 1;
      CheckBoxP.Checked               := FieldByName('PERIODONTIA').asInteger   = 1;
      CheckBoxPD.Checked              := FieldByName('PROTESE').asInteger       = 1;
      CheckBoxRD.Checked              := FieldByName('RADIOLOGIA').asInteger    = 1;
      CheckBoxReabOralEst.Checked     := FieldByName('REABILITACAO').asInteger  = 1;
      CheckBoxOD.Checked              := FieldByName('ORTODONTIA').asInteger    = 1;      
      EditCRO.Text                    := FieldByName('CRO').asString;
      EditSecretaria.Text             := FieldByName('Secretaria').asString;
      if FieldByName('CodVendedor').asInteger <> 0 then
      begin
        FrameVendedor.EditCodigo.asInteger := FieldByName('CodVendedor').asInteger;
        FrameVendedor.EditCodigo.OnExit(FrameVendedor.EditCodigo);
      end;
      MemoObservacao.Text     := FieldByName('Observacao').asString;
      TratarSituacaoBloqueio;
    end;
  end;
end;

procedure TFormManutencaoClientes.TratarSituacaoBloqueio;
begin
  if CDSCadastro.FieldByName('Situacao').asInteger = 0 then
  begin
    LblSituacao.Caption    := 'Ativo';
    LblSituacao.Font.Color := clBlue;
  end
  else if CDSCadastro.FieldByName('Situacao').asInteger = 1 then
  begin
    LblSituacao.Caption    := 'Inativo';
    LblSituacao.Font.Color := clRed;
  end;

  if CDSCadastro.FieldByName('Bloqueado').asInteger = 0 then
  begin
    LblBloqueado.Caption    := 'Não';
    LblBloqueado.Font.Color := clBlue;
  end
  else if CDSCadastro.FieldByName('Bloqueado').asInteger = 1 then
  begin
    LblBloqueado.Caption    := 'Sim';
    LblBloqueado.Font.Color := clRed;
  end;
end;

procedure TFormManutencaoClientes.FormShow(Sender: TObject);
begin
  EditNome.SetFocus;  
  inherited;
  PrepararTelaManutencao;
end;

procedure TFormManutencaoClientes.Gravar;
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
          SQL.Add(' INSERT INTO CLIENTES (');
          SQL.Add('     CODIGO , NOME,CPFCNPJ,ENDERECO,BAIRRO,CEP,CIDADE,TELCOMERCIAL1,');
          SQL.Add('     TELCOMERCIAL2,TELFAX,TELRESIDENCIAL,TELCELULAR,ESTADO,RGIE,SITE,');
          SQL.Add('     EMAIL,CRO,PROFISSAO,SECRETARIA,SITUACAO,BLOQUEADO,');
          SQL.Add('     DATAANIVER,DATACADASTRO,');
          SQL.Add('     CODVENDEDOR,');
          SQL.Add('     OBSERVACAO, CLINICAGERAL,CIRURGIA,ENDODONTIA,DENTISTICA,IMPLANTOLOGIA,');
          SQL.Add('     PERIODONTIA,PROTESE,RADIOLOGIA, REABILITACAO, ORTODONTIA)');
          SQL.Add(' VALUES (');
          SQL.Add('     :CODIGO , :NOME,:CPFCNPJ,:ENDERECO,:BAIRRO,:CEP,:CIDADE,:TELCOMERCIAL1,');
          SQL.Add('     :TELCOMERCIAL2,:TELFAX,:TELRESIDENCIAL,:TELCELULAR,:ESTADO,:RGIE,:SITE,');
          SQL.Add('     :EMAIL,:CRO,:PROFISSAO,:SECRETARIA,0,0,');
          SQL.Add('     :DATAANIVER,:DATACADASTRO,');
          if FrameVendedor.EditCodigo.asInteger <> 0 then
            SQL.Add('     :CODVENDEDOR,')
          else
            SQL.Add('     NULL,');          
          SQL.Add('     :OBSERVACAO, :CLINICAGERAL,:CIRURGIA,:ENDODONTIA,:DENTISTICA,:IMPLANTOLOGIA,');
          SQL.Add('     :PERIODONTIA,:PROTESE,:RADIOLOGIA, :REABILITACAO, :ORTODONTIA)');
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE CLIENTES');
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
          SQL.Add('     CRO            = :CRO,');
          SQL.Add('     PROFISSAO      = :PROFISSAO,');
          SQL.Add('     SECRETARIA     = :SECRETARIA,');
          SQL.Add('     DATAANIVER     = :DATAANIVER,');
          SQL.Add('     DATACADASTRO   = :DATACADASTRO,');
          if FrameVendedor.EditCodigo.asInteger <> 0 then
            SQL.Add('     CODVENDEDOR    = :CODVENDEDOR,')
          else
            SQL.Add('     CODVENDEDOR    = NULL,');          
          SQL.Add('     OBSERVACAO     = :OBSERVACAO,');
          SQL.Add('     CLINICAGERAL   = :CLINICAGERAL,');
          SQL.Add('     CIRURGIA       = :CIRURGIA,');
          SQL.Add('     ENDODONTIA     = :ENDODONTIA,');
          SQL.Add('     DENTISTICA     = :DENTISTICA,');
          SQL.Add('     IMPLANTOLOGIA  = :IMPLANTOLOGIA,');
          SQL.Add('     PERIODONTIA    = :PERIODONTIA,');
          SQL.Add('     PROTESE        = :PROTESE,');
          SQL.Add('     RADIOLOGIA     = :RADIOLOGIA,');
          SQL.Add('     REABILITACAO   = :REABILITACAO,');
          SQL.Add('     ORTODONTIA     = :ORTODONTIA');          
          SQL.Add(' WHERE CODIGO = :CODIGO');
        end;
        ParamByName('Codigo').asInteger    := EditCodigo.asInteger;
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
        ParamByName('Site').asString               := EditSite.Text;
        ParamByName('EMail').asString              := EditEmail.Text;
        if RadioButtonDentista.Checked then
          ParamByName('Profissao').asString        := 'DENTISTA'
        else if RadioButtonProtetico.Checked then
          ParamByName('Profissao').asString        := 'PROTETICO'
        else if RadioButtonOutros.Checked then
          ParamByName('Profissao').asString        := EditProfissao.Text;

        ParamByName('CLINICAGERAL').asInteger  := IfThen(CheckBoxCG.Checked,1,0);
        ParamByName('CIRURGIA').asInteger      := IfThen(CheckBoxC.Checked,1,0);
        ParamByName('ENDODONTIA').asInteger    := IfThen(CheckBoxE.Checked,1,0);
        ParamByName('DENTISTICA').asInteger    := IfThen(CheckBoxD.Checked,1,0);
        ParamByName('IMPLANTOLOGIA').asInteger := IfThen(CheckBoxI.Checked,1,0);
        ParamByName('PERIODONTIA').asInteger   := IfThen(CheckBoxP.Checked,1,0);
        ParamByName('PROTESE').asInteger       := IfThen(CheckBoxPD.Checked,1,0);
        ParamByName('RADIOLOGIA').asInteger    := IfThen(CheckBoxRD.Checked,1,0);
        ParamByName('REABILITACAO').asInteger  := IfThen(CheckBoxReabOralEst.Checked,1,0);
        ParamByName('ORTODONTIA').asInteger    := IfThen(CheckBoxOD.Checked,1,0);
        ParamByName('CRO').asString                := EditCRO.Text;
        ParamByName('Secretaria').asString         := EditSecretaria.Text;
        if FrameVendedor.EditCodigo.asInteger <> 0 then
          ParamByName('CodVendedor').asInteger       := FrameVendedor.EditCodigo.asInteger;
        ParamByName('Observacao').asString           := MemoObservacao.Text;
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


procedure TFormManutencaoClientes.BitBtnConfirmarClick(Sender: TObject);
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

procedure TFormManutencaoClientes.LimparTela;
begin
  EditCodigo.asInteger             := 0;
  EditNome.Text                    := '';
  EditCPFCNPJ.Text                 := '0';
  EditRGIE.Text                    := '';
  EditEndereco.Text                := '';
  EditCEP.Text                     := '0';
  EditBairro.Text                  := '';
  EditCidade.Text                  := '';
  EditEstado.Text                  := '';
  EditDDDCom1.asInteger            := 0;
  EditDDDCom2.asInteger            := 0;
  EditDDDFax.asInteger             := 0;
  EditDDDRes.asInteger             := 0;
  EditDDDCel.asInteger             := 0;
  EditTelComercial1.Text           := '';
  EditTelComercial2.Text           := '';
  EditTelFax.Text                  := '';
  EditTelResidencial.Text          := '';
  EditTelCelular.Text              := '';
  EditSite.Text                    := '';
  EditEmail.Text                   := '';
  EditProfissao.Text               := '';
  RadioButtonDentista.Checked      := True;
  EditCRO.Text                     := '';
  EditSecretaria.Text              := '';
  MemoObservacao.Text              := '';
  CheckBoxCG.Checked               := False;
  CheckBoxC.Checked                := False;
  CheckBoxE.Checked                := False;
  CheckBoxD.Checked                := False;
  CheckBoxI.Checked                := False;
  CheckBoxP.Checked                := False;
  CheckBoxPD.Checked               := False;
  CheckBoxRD.Checked               := False;
  CheckBoxReabOralEst.Checked      := False;
  CheckBoxOD.Checked               := False;
  RadioButtonCPF.Checked           := True;
  FrameVendedor.EditCodigo.Limpa;
  FrameVendedor.EditNome.Limpa;
  EditDataAniver.Limpa;
  EditDataCadastro.Limpa;
end;



procedure TFormManutencaoClientes.EditDDDCom1Exit(Sender: TObject);
begin
  inherited;
  ControlarDigitacao(Sender,2);
end;

procedure TFormManutencaoClientes.RadioButtonCPFClick(Sender: TObject);
begin
  inherited;
  EditCPFCNPJ.EditMask :=  '!999\.999\.999\-99;0;';
  EditCPFCNPJ.SetFocus;
end;

procedure TFormManutencaoClientes.RadioButtonCNPJClick(Sender: TObject);
begin
  inherited;
  EditCPFCNPJ.EditMask := '!99\.999\.999\/9999\-99;0;';
  EditCPFCNPJ.SetFocus;
end;

function TFormManutencaoClientes.RetornaCPFCNPJ : String;
begin
  Result := RetiraChar('/',RetiraChar('-',RetiraChar('.', SoNumeros(EditCPFCNPJ.EditText))));
end;

function TFormManutencaoClientes.RetornaCEP : String;
begin
  Result := RetiraChar('-',RetiraChar('.', SoNumeros(EditCEP.EditText)));
end;

function TFormManutencaoClientes.RetornaProximaSequencia : Integer;
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
        SQL.Add('  Set CodCliente = CodCliente + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from Clientes where Codigo = (Select CodCliente from UltimaSequencia)');
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
      SQL.Add('Select CodCliente from UltimaSequencia');
      Open;

      Result := FieldByname('CodCliente').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;

procedure TFormManutencaoClientes.VoltaUltimSequencia;
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
      SQL.Add('  Set CodCliente = ' + EditCodigo.Text + ' - 1');
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


procedure TFormManutencaoClientes.BitBtnCancelarClick(Sender: TObject);
begin
  inherited;
  if iTipo = 1 then
    VoltaUltimSequencia;
end;

procedure TFormManutencaoClientes.DS_ManutencaoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if (CheckBoxFecharTela.Checked = False) and Self.Showing then
    PrepararTelaManutencao;
end;

procedure TFormManutencaoClientes.EditNomeExit(Sender: TObject);
begin
  inherited;
  if ActiveControl = BitBtnCancelar then
    Exit;

  if (Trim(EditNome.Text) = '') then
  begin
    EditNome.SetFocus;
    Exit;
  end;
end;

procedure TFormManutencaoClientes.MemoObservacaoEnter(Sender: TObject);
begin
  inherited;
  Self.KeyPreview := False;
end;

procedure TFormManutencaoClientes.MemoObservacaoExit(Sender: TObject);
begin
  inherited;
  Self.KeyPreview := True;
end;

end.

