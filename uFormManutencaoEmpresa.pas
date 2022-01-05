unit uFormManutencaoEmpresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, Buttons, ExtCtrls, StdCtrls, ComCtrls,
  DBXpress, SqlTimSt, math, DB, TAdvEditP, Mask, DBCtrls, uFrameModelo,
  uFrameBancos;

type
  TFormManutencaoEmpresa = class(TFormManutencao)
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
    EditCodigo: TAdvEdit;
    CheckBoxMatriz: TCheckBox;
    PnlCPFCNPJ: TPanel;
    RadioButtonCPF: TRadioButton;
    RadioButtonCNPJ: TRadioButton;
    Label16: TLabel;
    EditNomeFantasia: TAdvEdit;
    MemoMensagens: TMemo;
    Label24: TLabel;
    Label17: TLabel;
    mem_msg_cupom: TMemo;
    FrameBancos: TFrameBancos;
    procedure FormShow(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure EditDDDCom1Exit(Sender: TObject);
    procedure RadioButtonCPFClick(Sender: TObject);
    procedure RadioButtonCNPJClick(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure DS_ManutencaoDataChange(Sender: TObject; Field: TField);
    procedure EditNomeExit(Sender: TObject);
    procedure MemoMensagensEnter(Sender: TObject);
    procedure MemoMensagensExit(Sender: TObject);
    procedure mem_msg_cupomEnter(Sender: TObject);
    procedure mem_msg_cupomExit(Sender: TObject);
  private
    { Private declarations }
    procedure PrepararTelaManutencao;
    procedure Gravar;
    procedure LimparTela;
    function RetornaCEP : String;
    function RetornaCPFCNPJ : String;
    function RetornaProximaSequencia : Integer;
    procedure VoltaUltimSequencia;
  public
    { Public declarations }
  end;

var
  FormManutencaoEmpresa: TFormManutencaoEmpresa;

implementation

uses uDataModule, uFuncoes, StrUtils;

{$R *.dfm}

procedure TFormManutencaoEmpresa.PrepararTelaManutencao;
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
      EditCodigo.asInteger       := FieldByName('Codigo').asInteger;
      EditNome.Text              := FieldByName('Nome').asString;
      EditNomeFantasia.Text      := FieldByName('NomeFantasia').asString;
      RadioButtonCPF.Checked     := (Length(FieldByName('CPFCNPJ').asString) <= 11);
      if RadioButtonCPF.Checked then
        RadioButtonCPF.OnClick(RadioButtonCPF);
      RadioButtonCNPJ.Checked    := (Length(FieldByName('CPFCNPJ').asString) > 11);
      if RadioButtonCNPJ.Checked then
        RadioButtonCNPJ.OnClick(RadioButtonCNPJ);      
      EditCPFCNPJ.Text           := FieldByName('CPFCNPJ').asString;
      EditRGIE.Text              := FieldByName('IE').asString;
      EditEndereco.Text          := FieldByName('Endereco').asString;
      EditCEP.Text               := FieldByName('CEP').asString;
      EditBairro.Text            := FieldByName('Bairro').asString;
      EditCidade.Text            := FieldByName('Cidade').asString;
      EditEstado.Text            := FieldByName('Estado').asString;
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
      MemoMensagens.Text         := FieldByName('Mensagens').asString;
      mem_msg_cupom.Text         := FieldByName('MENSAGEM_CUPOM').asString;
      if FieldByName('CODBANCO').asFloat > 0 then
      begin
        FrameBancos.EditCodigo.asFloat := FieldByName('CODBANCO').asFloat;
        FrameBancos.EditCodigo.OnExit(FrameBancos.EditCodigo);
      end;

      if FieldByName('Matriz').asInteger = 0 then
        CheckBoxMatriz.Checked := False
      else
        CheckBoxMatriz.Checked := True;
      EditNome.SetFocus;
    end;
  end;
end;

procedure TFormManutencaoEmpresa.FormShow(Sender: TObject);
begin
  EditNome.SetFocus;
  inherited;
  PrepararTelaManutencao;
end;

procedure TFormManutencaoEmpresa.Gravar;
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
          SQL.Add(' INSERT INTO EMPRESA (');
          SQL.Add('     CODIGO , NOME,CPFCNPJ,ENDERECO,BAIRRO,CEP,CIDADE,TELCOMERCIAL1,');
          SQL.Add('     TELCOMERCIAL2,TELFAX,TELRESIDENCIAL,TELCELULAR,ESTADO,IE,SITE,');
          SQL.Add('     EMAIL,MATRIZ, NOMEFANTASIA, MENSAGENS, MENSAGEM_CUPOM, CODBANCO)');
          SQL.Add(' VALUES (');
          SQL.Add('     :CODIGO , :NOME,:CPFCNPJ,:ENDERECO,:BAIRRO,:CEP,:CIDADE,:TELCOMERCIAL1,');
          SQL.Add('     :TELCOMERCIAL2,:TELFAX,:TELRESIDENCIAL,:TELCELULAR,:ESTADO,:IE,:SITE,');
          SQL.Add('     :EMAIL,:MATRIZ, :NOMEFANTASIA, :MENSAGENS, :MENSAGEM_CUPOM, :CODBANCO)');
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE EMPRESA');
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
          SQL.Add('     IE             = :IE,');
          SQL.Add('     SITE           = :SITE,');
          SQL.Add('     EMAIL          = :EMAIL,');
          SQL.Add('     MATRIZ         = :MATRIZ,');
          SQL.Add('     NOMEFANTASIA   = :NOMEFANTASIA,');
          SQL.Add('     MENSAGENS      = :MENSAGENS,');
          SQL.Add('     MENSAGEM_CUPOM = :MENSAGEM_CUPOM,');
          SQL.Add('     CODBANCO       = :CODBANCO');
          SQL.Add(' WHERE CODIGO = :CODIGO');
        end;
        ParamByName('Codigo').asFloat        := EditCodigo.asFloat;
        ParamByName('Nome').asString         := EditNome.Text;
        ParamByName('NomeFantasia').asString := EditNomeFantasia.Text;

        if Trim(RetornaCPFCNPJ) <> '0' then
          ParamByName('CPFCNPJ').asString  := RetornaCPFCNPJ
        else
          ParamByName('CPFCNPJ').asString  := '0';        
        ParamByName('IE').asString         := EditRGIE.Text;
        ParamByName('Endereco').asString   := EditEndereco.Text;
        if RetornaCEP <> '0' then
          ParamByName('CEP').asString      := RetornaCEP
        else
          ParamByName('CEP').asInteger     := 0;
        ParamByName('Bairro').asString     := EditBairro.Text;
        ParamByName('Cidade').asString     := EditCidade.Text;
        ParamByName('Estado').asString     := EditEstado.Text;
        ParamByName('TelComercial1').asString  := GravarTelefone(EditDDDCom1.Text,EditTelComercial1.Text);
        ParamByName('TelComercial2').asString  := GravarTelefone(EditDDDCom2.Text, EditTelComercial2.Text);
        ParamByName('TelFax').asString         := GravarTelefone(EditDDDFax.Text, EditTelFax.Text);
        ParamByName('TelResidencial').asString := GravarTelefone(EditDDDRes.Text, EditTelResidencial.Text);
        ParamByName('TelCelular').asString     := GravarTelefone(EditDDDCel.Text, EditTelCelular.Text);
        ParamByName('Site').asString           := EditSite.Text;
        ParamByName('EMail').asString          := EditEmail.Text;
        if CheckBoxMatriz.Checked then
          ParamByName('Matriz').asInteger := 1
        else
          ParamByName('Matriz').asInteger := 0;
        ParamByName('Mensagens').asString      := MemoMensagens.Text;
        ParamByName('Mensagem_Cupom').asString := mem_msg_cupom.Text;
        ParamByName('CodBanco').DataType := ftFloat;
        if FrameBancos.EditCodigo.asFloat > 0 then
          ParamByName('CodBanco').AsFloat      := FrameBancos.EditCodigo.asFloat
        else
          ParamByName('CodBanco').Clear;
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


procedure TFormManutencaoEmpresa.BitBtnConfirmarClick(Sender: TObject);
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

procedure TFormManutencaoEmpresa.LimparTela;
begin
  EditCodigo.asInteger    := 0;
  EditNome.Text           := '';
  EditCPFCNPJ.Text        := '0';
  EditRGIE.Text           := '';
  EditEndereco.Text       := '';
  EditCEP.Text            := '0';
  EditBairro.Text         := '';
  EditCidade.Text         := '';
  EditEstado.Text         := '';
  EditDDDCom1.asInteger   := 0;
  EditDDDCom2.asInteger   := 0;
  EditDDDFax.asInteger    := 0;
  EditDDDRes.asInteger    := 0;
  EditDDDCel.asInteger    := 0;
  EditTelComercial1.asInteger  := 0;
  EditTelComercial2.asInteger  := 0;
  EditTelFax.asInteger         := 0;
  EditTelResidencial.asInteger := 0;
  EditTelCelular.asInteger     := 0;
  EditSite.Text           := '';
  EditEmail.Text          := '';
  EditNomeFantasia.Text   := '';
  MemoMensagens.Clear;
  mem_msg_cupom.Clear;
  FrameBancos.LimparFrame;
  CheckBoxMatriz.Checked  := False;
end;


procedure TFormManutencaoEmpresa.EditDDDCom1Exit(Sender: TObject);
begin
  inherited;
  ControlarDigitacao(Sender,2);
end;

function TFormManutencaoEmpresa.RetornaCPFCNPJ : String;
begin
  Result := RetiraChar('/',RetiraChar('-',RetiraChar('.', SoNumeros(EditCPFCNPJ.EditText))));
end;

function TFormManutencaoEmpresa.RetornaCEP : String;
begin
  Result := RetiraChar('-',RetiraChar('.', SoNumeros(EditCEP.EditText)));
end;

procedure TFormManutencaoEmpresa.RadioButtonCPFClick(Sender: TObject);
begin
  inherited;
  EditCPFCNPJ.EditMask :=  '!999\.999\.999\-99;0;';
  EditCPFCNPJ.SetFocus;
end;

procedure TFormManutencaoEmpresa.RadioButtonCNPJClick(Sender: TObject);
begin
  inherited;
  EditCPFCNPJ.EditMask := '!99\.999\.999\/9999\-99;0;';
  EditCPFCNPJ.SetFocus;
end;

function TFormManutencaoEmpresa.RetornaProximaSequencia : Integer;
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
        SQL.Add('  Set CodEmpresa = CodEmpresa + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from Empresa where Codigo = (Select CodEmpresa from UltimaSequencia)');
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
      SQL.Add('Select CodEmpresa from UltimaSequencia');
      Open;

      Result := FieldByname('CodEmpresa').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;

procedure TFormManutencaoEmpresa.VoltaUltimSequencia;
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
      SQL.Add('  Set CodEmpresa = ' + EditCodigo.Text + ' - 1');
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



procedure TFormManutencaoEmpresa.BitBtnCancelarClick(Sender: TObject);
begin
  inherited;
  if iTipo = 1 then
    VoltaUltimSequencia;
end;



procedure TFormManutencaoEmpresa.DS_ManutencaoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if (CheckBoxFecharTela.Checked = False) and Self.Showing then
    PrepararTelaManutencao;

end;

procedure TFormManutencaoEmpresa.EditNomeExit(Sender: TObject);
begin
  inherited;
  if ActiveControl = BitBtnCancelar then
    Exit;

  if Trim(EditNome.Text) = '' then
    EditNome.SetFocus;
end;

procedure TFormManutencaoEmpresa.MemoMensagensEnter(Sender: TObject);
begin
  inherited;
  Self.KeyPreview := False;
end;

procedure TFormManutencaoEmpresa.MemoMensagensExit(Sender: TObject);
begin
  inherited;
  Self.KeyPreview := True;
end;

procedure TFormManutencaoEmpresa.mem_msg_cupomEnter(Sender: TObject);
begin
  inherited;
  Self.KeyPreview := False;
end;

procedure TFormManutencaoEmpresa.mem_msg_cupomExit(Sender: TObject);
begin
  inherited;
  Self.KeyPreview := True;
end;

end.
