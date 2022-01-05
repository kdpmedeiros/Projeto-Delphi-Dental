unit uFormClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormModelo, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids,
  DBGrids, StdCtrls, Buttons, ExtCtrls, uDataModule, ComCtrls,DBXpress,math,
  TAdvEditP, XPMenu, uFrameModelo, uFrameVendedor;

type
  TFormClientes = class(TFormModelo)
    GroupBox1: TGroupBox;
    FrameVendedor: TFrameVendedor;
    EditCidade: TAdvEdit;
    Label5: TLabel;
    Label2: TLabel;
    EditEstado: TAdvEdit;
    btn_filtrar: TSpeedButton;
    Label3: TLabel;
    cmb_especialidade: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure BitBtnIncluirClick(Sender: TObject);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure CDSPrincipalAfterOpen(DataSet: TDataSet);
    procedure BitBtnImprimirClick(Sender: TObject);
    procedure btn_filtrarClick(Sender: TObject);
    procedure FrameVendedorEditCodigoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    procedure Apagar;
    function TratarEspecializacoes : String;
    procedure ExibirClientes;
  public
    { Public declarations }

  end;

var
  FormClientes: TFormClientes;

implementation

{$R *.dfm}

Uses uFormManutencaoClientes, uRelatorioModelo, uFormPrincipal;

procedure TFormClientes.FormShow(Sender: TObject);
begin
  inherited;
  ExibirClientes;
  ComboBoxTipoPesquisa.ItemIndex := ComboBoxTipoPesquisa.Items.IndexOf('Nome');
end;

procedure TFormClientes.BitBtnIncluirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormManutencaoClientes, FormManutencaoClientes);
    FormManutencaoClientes.InicializaTela(1, CDSPrincipal);
    FormManutencaoClientes.ShowModal;
  Finally
    ExibirClientes;
    CDSPrincipal.Locate('Codigo',FormManutencaoClientes.EditCodigo.asInteger,[]);
    FormManutencaoClientes.Free;
  end;
end;

procedure TFormClientes.BitBtnAlterarClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) Then
    Exit;

  Try
    Application.CreateForm(TFormManutencaoClientes, FormManutencaoClientes);
    FormManutencaoClientes.InicializaTela(2, CDSPrincipal);
    FormManutencaoClientes.ShowModal;
  Finally
    ExibirClientes;
    CDSPrincipal.Locate('Codigo',FormManutencaoClientes.EditCodigo.asInteger,[]);    
    FormManutencaoClientes.Free;
  end;
end;

procedure TFormClientes.Apagar;
Var TransDesc : TTransactionDesc;
    BM : TBookMark;
begin
  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);
      With SQLQueryExecuta do
      begin
        SQL.Clear;
        SQL.Add(' DELETE FROM CLIENTES');
        SQL.Add(' WHERE CODIGO = :CODIGO');
        ParamByName('Codigo').asFloat := CDSPrincipal.FieldByName('Codigo').asFloat;
        ExecSQL;

        CDSPrincipal.Prior;
        BM := CDSPrincipal.GetBookMark;
        SQLConnectionPrin.Commit(TransDesc);
        ExibirClientes;
        Try
          CDSPrincipal.GotoBookmark(BM);
          CDSPrincipal.FreeBookmark(BM);
        except
          CDSPrincipal.FreeBookmark(BM);
        end;
      end;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Apagar o Registro! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
end;


procedure TFormClientes.BitBtnExcluirClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    Exit;

  If Application.MessageBox('Deseja Realmente Excluir o Cliente Selecionado?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
    Apagar;
end;

procedure TFormClientes.CDSPrincipalAfterOpen(DataSet: TDataSet);
begin
  with CDSPrincipal do
  begin
    FieldByName('CODIGO').DisplayLabel         := 'Código';
    FieldByName('NOME').DisplayLabel           := 'Nome';
    FieldByName('CPFCNPJ').OnGetText           := GetTextCPFCNPJ;
    FieldByName('CPFCNPJ').DisplayLabel        := 'CPF/CNPJ';
    FieldByName('ENDERECO').DisplayLabel       := 'Endereço';
    FieldByName('BAIRRO').DisplayLabel         := 'Bairro';
    FieldByName('CEP').OnGetText               := GetTextCEP;
    FieldByName('CEP').DisplayLabel            := 'CEP';
    FieldByName('CIDADE').DisplayLabel         := 'Cidade';
    FieldByName('TELCOMERCIAL1').DisplayLabel  := 'Tel. Comercial (1)';
    FieldByName('TELCOMERCIAL2').DisplayLabel  := 'Tel. Comercial (2)';
    FieldByName('TELFAX').DisplayLabel         := 'Tel. Fax';
    FieldByName('TELRESIDENCIAL').DisplayLabel := 'Tel. Residencial';
    FieldByName('TELCELULAR').DisplayLabel     := 'Tel. Celular';
    FieldByName('ESTADO').DisplayLabel         := 'Estado';
    FieldByName('RGIE').DisplayLabel           := 'RG / Inscrição Estadual';
    FieldByName('SITE').DisplayLabel           := 'Site';
    FieldByName('EMAIL').DisplayLabel          := 'E-Mail';
    FieldByName('CRO').DisplayLabel            := 'CRO';
    FieldByName('PROFISSAO').DisplayLabel      := 'Profissão';
    FieldByName('ESPECIALIDADE').DisplayLabel  := 'Especialidade';
    FieldByName('SECRETARIA').DisplayLabel     := 'Secretária';
    FieldByName('SITUACAO').DisplayLabel       := 'Situação';
    FieldByName('BLOQUEADO').DisplayLabel      := 'Bloqueado';
    FieldByName('DATAANIVER').DisplayLabel     := 'Data Aniversário';
    FieldByName('DATACADASTRO').DisplayLabel   := 'Data Cadastro';
    FieldByName('CODVENDEDOR').DisplayLabel    := 'Cód. Vendedor';
    FieldByName('OBSERVACAO').DisplayLabel     := 'Observação';
    FieldByName('CLINICAGERAL_S').DisplayLabel  := 'Clínica Geral';
    FieldByName('CIRURGIA_S').DisplayLabel      := 'Cirurgia';
    FieldByName('ENDODONTIA_S').DisplayLabel    := 'Endodontia';
    FieldByName('DENTISTICA_S').DisplayLabel    := 'Dentística';
    FieldByName('IMPLANTOLOGIA_S').DisplayLabel := 'Implantologia';
    FieldByName('PERIODONTIA_S').DisplayLabel   := 'Periodontia';
    FieldByName('PROTESE_S').DisplayLabel       := 'Prótese Dental';
    FieldByName('RADIOLOGIA_S').DisplayLabel    := 'Radiologia Dental';
    FieldByName('REABILITACAO_S').DisplayLabel  := 'Reabilitação Oral';
    FieldByName('ORTODONTIA_S').DisplayLabel    := 'Ortodontia';

    FieldByName('CLINICAGERAL').Visible   := False;
    FieldByName('CIRURGIA').Visible       := False;
    FieldByName('ENDODONTIA').Visible     := False;
    FieldByName('DENTISTICA').Visible     := False;
    FieldByName('IMPLANTOLOGIA').Visible  := False;
    FieldByName('PERIODONTIA').Visible    := False;
    FieldByName('PROTESE').Visible        := False;
    FieldByName('RADIOLOGIA').Visible     := False;
    FieldByName('REABILITACAO').Visible   := False;
    FieldByName('ORTODONTIA').Visible     := False;


    FieldByName('CODIGO').DisplayWidth         := 8;
    FieldByName('NOME').DisplayWidth           := 50;
    FieldByName('CPFCNPJ').DisplayWidth        := 20;
    FieldByName('ENDERECO').DisplayWidth       := 50;
    FieldByName('BAIRRO').DisplayWidth         := 25;
    FieldByName('CEP').DisplayWidth            := 10;
    FieldByName('CIDADE').DisplayWidth         := 30;
    FieldByName('TELCOMERCIAL1').DisplayWidth  := 15;
    FieldByName('TELCOMERCIAL2').DisplayWidth  := 15;
    FieldByName('TELFAX').DisplayWidth         := 15;
    FieldByName('TELRESIDENCIAL').DisplayWidth := 15;
    FieldByName('TELCELULAR').DisplayWidth     := 15;
    FieldByName('ESTADO').DisplayWidth         := 6;
    FieldByName('RGIE').DisplayWidth           := 20;
    FieldByName('SITE').DisplayWidth           := 25;
    FieldByName('EMAIL').DisplayWidth          := 25;
    FieldByName('CRO').DisplayWidth            := 20;
    FieldByName('PROFISSAO').DisplayWidth      := 25;
    FieldByName('ESPECIALIDADE').DisplayWidth  := 25;
    FieldByName('SECRETARIA').DisplayWidth     := 50;
    FieldByName('SITUACAO').DisplayWidth       := 7;
    FieldByName('BLOQUEADO').DisplayWidth      := 8;
    FieldByName('DATAANIVER').DisplayWidth     := 15;
    FieldByName('DATACADASTRO').DisplayWidth   := 15;
    FieldByName('CODVENDEDOR').DisplayWidth    := 5;
    FieldByName('OBSERVACAO').DisplayWidth     := 100;
  end;

  inherited;
end;

procedure TFormClientes.BitBtnImprimirClick(Sender: TObject);
begin
  inherited;
  Try
    ExibirClientes;  
    Application.CreateForm(TFormRelatorioModelo, FormRelatorioModelo);
    with FormRelatorioModelo do
    begin
      DS_Principal.DataSet := Self.CDSPrincipal;
      if FrameVendedor.EditCodigo.asInteger <> 0 then
        MontaCabecalhoLabel('Vendedor', FrameVendedor.EditNome.Text);
      MontaRelatorio;
      ppLabelDescricaoRel.Caption := 'Relatório de Clientes';
      ppRelatorio.Print;
    end;
  Finally
    CDSPrincipal.First;
    FormRelatorioModelo.Free;
  end;
end;

function TFormClientes.TratarEspecializacoes : String;
begin
  inherited;
  Result := ' , Case When (CLINICAGERAL  = 0 or CLINICAGERAL  is Null) then ''Não'' else ''Sim'' end as CLINICAGERAL_S,'  +
              ' Case When (CIRURGIA      = 0 or CIRURGIA      is Null) then ''Não'' else ''Sim'' end as CIRURGIA_S,'      +
              ' Case When (ENDODONTIA    = 0 or ENDODONTIA    is Null) then ''Não'' else ''Sim'' end as ENDODONTIA_S,'    +
              ' Case When (DENTISTICA    = 0 or DENTISTICA    is Null) then ''Não'' else ''Sim'' end as DENTISTICA_S,'    +
              ' Case When (IMPLANTOLOGIA = 0 or IMPLANTOLOGIA is Null) then ''Não'' else ''Sim'' end as IMPLANTOLOGIA_S,' +
              ' Case When (PERIODONTIA   = 0 or PERIODONTIA   is Null) then ''Não'' else ''Sim'' end as PERIODONTIA_S,'   +
              ' Case When (PROTESE       = 0 or PROTESE       is Null) then ''Não'' else ''Sim'' end as PROTESE_S,'       +
              ' Case When (RADIOLOGIA    = 0 or RADIOLOGIA    is Null) then ''Não'' else ''Sim'' end as RADIOLOGIA_S,'    +
              ' Case When (REABILITACAO  = 0 or REABILITACAO  is Null) then ''Não'' else ''Sim'' end as REABILITACAO_S,'  +
              ' Case When (ORTODONTIA    = 0 or ORTODONTIA    is Null) then ''Não'' else ''Sim'' end as ORTODONTIA_S';

end;


procedure TFormClientes.ExibirClientes;
Var s_Filtros : String;
    b_Tem_where : Boolean;

begin
  s_Filtros   := '';
  b_Tem_where := False;
  if (FrameVendedor.EditCodigo.asFloat <> 0) then
  begin
    if b_Tem_where = False then
    begin
      s_Filtros := ' Where ';
      b_Tem_where := True;
    end
    else
      s_Filtros := s_Filtros + ' and ';
    s_Filtros := s_Filtros + ' CODVENDEDOR =  ' + FrameVendedor.EditCodigo.Text;
  end;

  if (Trim(EditCidade.Text) <> '') then
  begin
    if b_Tem_where = False then
    begin
      s_Filtros := ' Where ';
      b_Tem_where := True;
    end
    else
      s_Filtros := s_Filtros + ' and ';

    s_Filtros := s_Filtros + ' CIDADE =  ' + QuotedStr(EditCidade.Text);
  end;

  if (Trim(EditEstado.Text) <> '') then
  begin
    if b_Tem_where = False then
      s_Filtros := ' Where '
    else
      s_Filtros := s_Filtros + ' and ';

    s_Filtros := s_Filtros + ' ESTADO =  ' + QuotedStr(EditEstado.Text);
  end;
  if cmb_especialidade.ItemIndex <> 0 then
  begin
    if b_Tem_where = False then
      s_Filtros := ' Where '
    else
      s_Filtros := s_Filtros + ' and ';

    if cmb_especialidade.ItemIndex = 1 then
      s_Filtros := s_Filtros + ' CLINICAGERAL =  1 '
    else if cmb_especialidade.ItemIndex = 2 then
      s_Filtros := s_Filtros + ' CIRURGIA =  1 '
    else if cmb_especialidade.ItemIndex = 3 then
      s_Filtros := s_Filtros + ' ENDODONTIA =  1 '
    else if cmb_especialidade.ItemIndex = 4 then
      s_Filtros := s_Filtros + ' DENTISTICA =  1 '
    else if cmb_especialidade.ItemIndex = 5 then
      s_Filtros := s_Filtros + ' IMPLANTOLOGIA =  1 '
    else if cmb_especialidade.ItemIndex = 6 then
      s_Filtros := s_Filtros + ' REABILITACAO =  1 '
    else if cmb_especialidade.ItemIndex = 7 then
      s_Filtros := s_Filtros + ' PERIODONTIA =  1 '
    else if cmb_especialidade.ItemIndex = 8 then
      s_Filtros := s_Filtros + ' PROTESE =  1 '
    else if cmb_especialidade.ItemIndex = 9 then
      s_Filtros := s_Filtros + ' RADIOLOGIA =  1 '
    else if cmb_especialidade.ItemIndex = 10 then
      s_Filtros := s_Filtros + ' ORTODONTIA =  1 ';
  end;

  MostrarDados('Clientes',TratarEspecializacoes, 'Nome', s_Filtros);
end;

procedure TFormClientes.btn_filtrarClick(Sender: TObject);
begin
  inherited;
  ExibirClientes;
end;

procedure TFormClientes.FrameVendedorEditCodigoExit(Sender: TObject);
begin
  inherited;
  FrameVendedor.EditCodigoExit(Sender);

end;

procedure TFormClientes.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
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

end.
