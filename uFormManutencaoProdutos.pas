unit uFormManutencaoProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, Buttons, ExtCtrls, ComCtrls, StdCtrls,
  uFrameModelo, uFrameVendedor, uFrameGrupos, uFrameFornecedor,
  uFrameListaPreco, FMTBcd, DB, SqlExpr, Provider, DBClient,DBXpress, SqlTimSt, math,
  TAdvEditP, uFrameProdutos, DBCtrls;

type
  TFormManutencaoProdutos = class(TFormManutencao)
    GroupBox2: TGroupBox;
    FrameGrupos: TFrameGrupos;
    EditCodigo: TAdvEdit;
    Label3: TLabel;
    EditDescricao: TAdvEdit;
    Label1: TLabel;
    EditClassificacao: TAdvEdit;
    Label2: TLabel;
    EditUnidade: TAdvEdit;
    FrameFornecedor: TFrameFornecedor;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    EditQuantEstoque: TAdvEdit;
    Label5: TLabel;
    EditQtdeMax: TAdvEdit;
    Label6: TLabel;
    EditQtdeMed: TAdvEdit;
    Label7: TLabel;
    EditQtdeMin: TAdvEdit;
    Label8: TLabel;
    EditQtdeEntrada: TAdvEdit;
    SpeedButtonEntradaEstoque: TSpeedButton;
    CDSEstoque: TClientDataSet;
    DSPEstoque: TDataSetProvider;
    SQLEstoque: TSQLDataSet;
    DS_Estoque: TDataSource;
    Bevel1: TBevel;
    Bevel2: TBevel;
    FrameProdutos: TFrameProdutos;
    CheckBoxSelecionarProduto: TCheckBox;
    GroupBoxCustos: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    EditValorCusto: TAdvEdit;
    EditValorVenda: TAdvEdit;
    EditPercFreteVenda: TAdvEdit;
    EditValorVendaFrete: TAdvEdit;
    Label13: TLabel;
    EditPercFreteCompra: TAdvEdit;
    Label14: TLabel;
    EditPercICMS: TAdvEdit;
    Label18: TLabel;
    EditValorCustoCompra: TAdvEdit;
    GroupBox4: TGroupBox;
    Label17: TLabel;
    Label19: TLabel;
    EditPercLucro: TAdvEdit;
    EditValorLucro: TAdvEdit;
    RBLucroPercentual: TRadioButton;
    RBLucroValor: TRadioButton;
    CDSCustos: TClientDataSet;
    EditPercIPI: TAdvEdit;
    Label9: TLabel;
    CheckBoxManterDadosGrupo: TCheckBox;
    LabelAlterarPrecos: TLabel;
    ed_localizacao: TAdvEdit;
    Label15: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FrameGruposEditCodigoExit(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure SpeedButtonEntradaEstoqueClick(Sender: TObject);
    procedure EditQtdeEntradaExit(Sender: TObject);
    procedure CheckBoxSelecionarProdutoClick(Sender: TObject);
    procedure FrameProdutosEditCodigoExit(Sender: TObject);
    procedure EditValorCustoExit(Sender: TObject);
    procedure EditPercFreteCompraExit(Sender: TObject);
    procedure EditPercICMSExit(Sender: TObject);
    procedure RBLucroPercentualClick(Sender: TObject);
    procedure RBLucroValorClick(Sender: TObject);
    procedure EditPercLucroExit(Sender: TObject);
    procedure EditValorLucroExit(Sender: TObject);
    procedure EditPercFreteVendaExit(Sender: TObject);
    procedure EditValorVendaExit(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure EditPercIPIExit(Sender: TObject);
    procedure DS_ManutencaoDataChange(Sender: TObject; Field: TField);
    procedure EditDescricaoExit(Sender: TObject);
    procedure FrameProdutosSpeedButtonConsultaClick(Sender: TObject);
    procedure CheckBoxManterDadosGrupoClick(Sender: TObject);
    procedure CheckBoxFecharTelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditValorCustoCompraExit(Sender: TObject);
  private
    { Private declarations }
    CodListaPreco, CodProdutoAnt : Integer;
    procedure PrepararTelaManutencao;
    procedure Estoque;
    procedure LimparTela;
    procedure Gravar;
    procedure GravarEstoque(GerarEntrada : Boolean);
    function  ValidaTela : Boolean;
    function ValidaEntradaEstoque : Boolean;
    procedure TratarCampoEstoque;
    function ValidaProduto : Boolean;
    procedure TrazListaPreco;
    procedure CalcularValorVenda;
    procedure CalcularCustoCompra;
    procedure Custos;
    procedure GravarCustos;
    procedure LimparCusto;
    function RetornaProximaSequenciaProduto : Integer;
    function RetornaProximaSequenciaLista : Integer;
    procedure VoltaUltimSequencia;
    procedure AlterarTodosProdutosFilhos;
    procedure CriarProdutoPai(NovoProduto : Integer);
    procedure AtualizarEstoqueProdutoPrin;
  public
     TipoProduto : Integer; {1 - PRINCIPAL / 2 - FILHO}
     HouveAlteracao : Boolean;
     s_cod_grupo, s_cod_produto, s_cod_classificacao : String;
    { Public declarations }

  end;

var
  FormManutencaoProdutos: TFormManutencaoProdutos;

implementation

{$R *.dfm}

Uses uFuncoes, uDataModule;

procedure TFormManutencaoProdutos.PrepararTelaManutencao;
begin
  SpeedButtonEntradaEstoque.Enabled := (iTipo = 2);
  with CDSCadastro do
  begin
    if iTipo = 1 then
    begin
      with DataModulePrin.SQLQueryExecuta do
      begin
        Close;
        SQL.Clear;
        if CheckBoxSelecionarProduto.Checked = False then
        begin
          FrameProdutos.EditCodigo.asInteger := RetornaProximaSequenciaProduto;
          FrameProdutos.NovoProduto := True;

          {Lista Preco}
          CodListaPreco := RetornaProximaSequenciaLista;
        end;
        if CheckBoxSelecionarProduto.Checked then
          FrameProdutos.EditCodigo.SetFocus
        else
        begin
          if EditClassificacao.CanFocus then
            EditClassificacao.SetFocus
          else
            EditDescricao.SetFocus;
        end;

        EditCodigo.asInteger := RetornaProximaSequenciaProduto;
      end;
    end
    else if iTipo = 2 then
    begin
      HabilitaFrame(FrameGrupos,False);
      CheckBoxSelecionarProduto.Enabled := False;
      EditClassificacao.Enabled         := False;
      FrameGrupos.EditCodigo.asInteger := FieldByName('CodGrupo').asInteger;
      FrameGrupos.EditCodigo.OnExit(FrameGrupos.EditCodigo);

      FrameProdutos.EditCodigo.asInteger := FieldByName('Codigo').asInteger;
      EditClassificacao.Text := FieldByName('Classificacao').asString;
      EditDescricao.Text     := FieldByName('Descricao').asString;
      EditUnidade.Text       := FieldByName('Unidade').asString;
      ed_localizacao.Text    := FieldByName('Localizacao').asString;
      if FieldByName('CodFornecedor').asInteger <> 0 then
      begin
        FrameFornecedor.EditCodigo.asInteger := FieldByName('CodFornecedor').asInteger;
        FrameFornecedor.EditCodigo.OnExit(FrameFornecedor.EditCodigo);
      end;
      if not FieldByName('CodListaPreco').IsNull then
        CodListaPreco := FieldByName('CodListaPreco').asInteger
      else
        CodListaPreco := RetornaProximaSequenciaLista;
      Estoque;
      Custos;

      if FieldByName('Classificacao').asString <> '' then
      begin
        EditDescricao.Enabled := False;
        EditUnidade.Enabled   := False;
        HabilitaFrame(FrameFornecedor,False);
        HabilitaGroupBox(GroupBoxCustos,False);
      end;
      EditCodigo.asInteger := FrameProdutos.EditCodigo.asInteger;
    end;
  end;

end;

procedure TFormManutencaoProdutos.Estoque;
begin
  with CDSEstoque do
  begin
    SQL.Clear;
    SQL.Add(' Select * from EstoqueProdutos       ');
    SQL.Add(' where CodProduto    = :CodProduto   ');
    SQL.Add('   and CodGrupo      = :CodGrupo     ');
    SQL.Add('   and Classificacao = :Classificacao');
    Close;
    CommandText := SQL.Text;
    Params.ParambyName('CodProduto').asInteger   := FrameProdutos.EditCodigo.asInteger;
    Params.ParambyName('CodGrupo').asInteger     := FrameGrupos.EditCodigo.asInteger;
    Params.ParambyName('Classificacao').asString := EditClassificacao.Text;
    Open;

    if not IsEmpty then
    begin
      EditQuantEstoque.asFloat := FieldByName('Quantidade').asFloat;
      EditQtdeMax.asFloat      := FieldByName('QuantidadeMax').asFloat;
      EditQtdeMed.asFloat      := FieldByName('QuantidadeMed').asFloat;
      EditQtdeMin.asFloat      := FieldByName('QuantidadeMin').asFloat;
      EditQtdeEntrada.asFloat  := FieldByName('QuantEntrada').asFloat;
    end;
    TratarCampoEstoque;    
  end;
end;


procedure TFormManutencaoProdutos.TratarCampoEstoque;
begin
  if EditQuantEstoque.asFloat <= 0 then
    EditQuantEstoque.Color := clRed
  else
    EditQuantEstoque.Color := $00EC7600;
end;

procedure TFormManutencaoProdutos.FormShow(Sender: TObject);
begin
  if iTipo = 1 then
    FrameGrupos.EditCodigo.SetFocus
  else
  begin
    CheckBoxManterDadosGrupo.Enabled := False;
    CheckBoxManterDadosGrupo.Checked := False;
    EditDescricao.SetFocus;
  end;

  inherited;
  CodProdutoAnt := 0;
  HabilitaFrame(FrameProdutos,False);
  if TipoProduto = 1 then
  begin
    CheckBoxSelecionarProduto.Enabled := False;
    EditClassificacao.Enabled         := False;
    CheckBoxManterDadosGrupo.Checked  := False;
    CheckBoxManterDadosGrupo.Enabled  := False;
  end;

  if iTipo = 2 then
    PrepararTelaManutencao;

  if (EditClassificacao.Text <> '') then
    EditQtdeEntrada.SetFocus;

  VerifPermissoesExtras(1);
  LabelAlterarPrecos.Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('FlagSimNao').asInteger = 1);
end;

procedure TFormManutencaoProdutos.FrameGruposEditCodigoExit(
  Sender: TObject);
begin
  inherited;
  FrameGrupos.EditCodigoExit(Sender);

  if FrameGrupos.isValido = False then
    Exit;

  if FrameGrupos.EditCodigo.asInteger <> 0 then
  begin
    if iTipo = 1 then
      PrepararTelaManutencao;
  end;
end;

procedure TFormManutencaoProdutos.LimparTela;
begin
  s_cod_grupo         := FrameGrupos.EditCodigo.text;
  s_cod_produto       := EditCodigo.Text;
  s_cod_classificacao := EditClassificacao.Text;

  if CheckBoxManterDadosGrupo.Checked = False then
  begin
    FrameGrupos.EditCodigo.asInteger      := 0;
    EditCodigo.asInteger                  := 0;
    EditDescricao.Text                    := '';
    EditUnidade.Text                      := '';
    ed_localizacao.Text                   := '';
    FrameFornecedor.EditCodigo.asInteger  := 0;
    CodListaPreco                         := 0;
    CodProdutoAnt                         := 0;
    LimparCusto;
    FrameProdutos.EditCodigo.Limpa;
    FrameGrupos.EditNome.Limpa;
    FrameFornecedor.EditNome.Limpa;
    CheckBoxSelecionarProduto.Checked     := False;
  end
  else
  begin
    if (CodProdutoAnt = FrameProdutos.EditCodigo.asInteger) then
    begin
      CheckBoxSelecionarProduto.Checked := True;
      CheckBoxSelecionarProduto.OnClick(CheckBoxSelecionarProduto);
      EditCodigo.asInteger := RetornaProximaSequenciaProduto;
    end;
  end;
  EditClassificacao.Text                := '';
  EditQuantEstoque.asFloat              := 0;
  EditQtdeMax.asFloat                   := 0;
  EditQtdeMed.asFloat                   := 0;
  EditQtdeMin.asFloat                   := 0;
  EditQtdeEntrada.asFloat               := 0;
  EditQuantEstoque.Color                := $00EC7600;
end;

procedure TFormManutencaoProdutos.Gravar;
Var TransDesc : TTransactionDesc;
    CodigoProduto : Integer;
begin
  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);
      With SQLQueryExecuta do
      begin
        CodigoProduto := RetornaProximaSequenciaProduto;
        Close;
        if iTipo = 1 then
        begin
          SQL.Clear;
          SQL.Add(' INSERT INTO PRODUTOS (');
          SQL.Add('     CODIGO, CODGRUPO, CLASSIFICACAO, DESCRICAO, UNIDADE,');
          SQL.Add('     CODFORNECEDOR, CODLISTAPRECO, LOCALIZACAO)');
          if CheckBoxSelecionarProduto.Checked = False then
          begin
            SQL.Add('Values (:CODIGO, :CODGRUPO, :CLASSIFICACAO, :DESCRICAO, :UNIDADE,');
            SQL.Add('        :CODFORNECEDOR,:CODLISTAPRECO, :LOCALIZACAO)');
          end
          else
          begin
            SQL.Add(' Values( :CODIGO,:CODGRUPO, :CLASSIFICACAO, :DESCRICAO, :UNIDADE,');
            SQL.Add('         :CODFORNECEDOR,:CODLISTAPRECO, :LOCALIZACAO)');
          end;
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE PRODUTOS');
          SQL.Add(' SET  ');
          SQL.Add('   DESCRICAO         = :DESCRICAO,');
          SQL.Add('   UNIDADE           = :UNIDADE,');
          SQL.Add('   CODFORNECEDOR     = :CODFORNECEDOR,');
          SQL.Add('   CODLISTAPRECO     = :CODLISTAPRECO,');
          SQL.Add('   LOCALIZACAO       = :LOCALIZACAO');   
          SQL.Add(' WHERE CODIGO        = :CODIGO');
          SQL.Add('   AND CODGRUPO      = :CODGRUPO');
          SQL.Add('   AND CLASSIFICACAO = :CLASSIFICACAO');
        end;
        if (iTipo = 2) or (CheckBoxSelecionarProduto.Checked = True) then
          ParamByName('Codigo').asInteger      := FrameProdutos.EditCodigo.asInteger
        else
          ParamByName('Codigo').asInteger      := CodigoProduto;
        ParamByName('CodGrupo').asInteger      := FrameGrupos.EditCodigo.asInteger;
        ParamByName('Classificacao').asString  := EditClassificacao.Text;
        ParamByName('Descricao').asString      := EditDescricao.Text;
        ParamByName('Unidade').asString        := EditUnidade.Text;
        ParamByName('Localizacao').asString    := ed_localizacao.Text;
        ParamByName('CodFornecedor').asInteger := FrameFornecedor.EditCodigo.asInteger;
        ParamByName('CodListaPreco').asInteger := CodListaPreco;
        ExecSQL;

        if Trim(EditClassificacao.Text) = '' then
          AlterarTodosProdutosFilhos
        else
          CriarProdutoPai(CodigoProduto);

        HouveAlteracao := True;
        SQLConnectionPrin.Commit(TransDesc);
      end;
    end;
  Except
    on e: exception do
    begin
      HouveAlteracao := False;
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar o Registro! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
end;



procedure TFormManutencaoProdutos.BitBtnConfirmarClick(Sender: TObject);
begin
  inherited;
  if (FrameGrupos.EditNome.Text = 'DESCONTO') and (EditClassificacao.Text = 'DESC') then
  begin
    Application.MessageBox('Este Produto não pode ser Alterado!','Informação',0);
    Exit;
  end;

  if ValidaTela = False then
    Exit;

  if ValidaProduto = False then
    Exit;


  CodProdutoAnt := FrameProdutos.EditCodigo.asInteger;

  if CheckBoxSelecionarProduto.Checked = False then
    GravarCustos;

  Gravar;
  GravarEstoque(False);
  if CheckBoxFecharTela.Checked then
  begin
    s_cod_grupo         := FrameGrupos.EditCodigo.text;
    s_cod_produto       := EditCodigo.Text;
    s_cod_classificacao := EditClassificacao.Text;
    Self.Close;
  end
  else
  begin
    if not CDSCadastro.EOF then
    begin
      LimparTela;
      if iTipo = 2 then
      begin
        CDSCadastro.Next;
        PrepararTelaManutencao;
      end
    end
    else
    begin
      Self.Close;
      Exit;
    end;

    if CheckBoxManterDadosGrupo.Checked = False then
    begin
      if Trim(EditClassificacao.Text) <> '' then
        EditQtdeEntrada.SetFocus
      else
      begin
        if FrameGrupos.EditCodigo.CanFocus then
          FrameGrupos.EditCodigo.SetFocus
        else
          EditDescricao.SetFocus;
      end
    end
    else
      EditClassificacao.SetFocus;
  end;
end;

procedure TFormManutencaoProdutos.GravarEstoque(GerarEntrada : Boolean);
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
          SQL.Add(' INSERT INTO ESTOQUEPRODUTOS (');
          SQL.Add('     CODPRODUTO, CODGRUPO, CLASSIFICACAO, QUANTIDADE, QUANTIDADEMAX,');
          SQL.Add('     QUANTIDADEMED, QUANTIDADEMIN, QUANTENTRADA)');
          SQL.Add(' VALUES (');
          SQL.Add('     :CODPRODUTO, :CODGRUPO, :CLASSIFICACAO, :QUANTIDADE, :QUANTIDADEMAX,');
          SQL.Add('     :QUANTIDADEMED, :QUANTIDADEMIN, :QUANTENTRADA)');
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE ESTOQUEPRODUTOS');
          SQL.Add(' SET  ');
          SQL.Add('   QUANTIDADE        = :QUANTIDADE,');
          SQL.Add('   QUANTIDADEMAX     = :QUANTIDADEMAX,');
          SQL.Add('   QUANTIDADEMED     = :QUANTIDADEMED,');
          SQL.Add('   QUANTIDADEMIN     = :QUANTIDADEMIN,');
          SQL.Add('   QUANTENTRADA      = :QUANTENTRADA');
          SQL.Add(' WHERE CODPRODUTO    = :CODPRODUTO');
          SQL.Add('   AND CODGRUPO      = :CODGRUPO');
          SQL.Add('   AND CLASSIFICACAO = :CLASSIFICACAO');
        end;
        ParamByName('CodGrupo').asInteger     := FrameGrupos.EditCodigo.asInteger;
        ParamByName('CodProduto').asInteger   := FrameProdutos.EditCodigo.asInteger;
        ParamByName('Classificacao').asString := EditClassificacao.Text;
        if GerarEntrada then
          ParamByName('Quantidade').asFloat   := EditQuantEstoque.asFloat + EditQtdeEntrada.asFloat
        else
          ParamByName('Quantidade').asFloat   := EditQuantEstoque.asFloat;

        ParamByName('QuantidadeMax').asFloat  := EditQtdeMax.asFloat;
        ParamByName('QuantidadeMed').asFloat  := EditQtdeMed.asFloat;
        ParamByName('QuantidadeMin').asFloat  := EditQtdeMin.asFloat;
        ParamByName('QuantEntrada').asFloat   := EditQtdeEntrada.asFloat;
        ExecSQL;
        
        if GerarEntrada then
        begin
          if (EditClassificacao.Text <> '') then
            AtualizarEstoqueProdutoPrin;
        end;    
        
        SQLConnectionPrin.Commit(TransDesc);        
      end;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar o Estoque! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
end;


procedure TFormManutencaoProdutos.SpeedButtonEntradaEstoqueClick(
  Sender: TObject);
begin
  inherited;
  if ValidaEntradaEstoque = False then
    Exit;

  GravarEstoque(True);
  Estoque;  
end;

procedure TFormManutencaoProdutos.EditQtdeEntradaExit(Sender: TObject);
begin
  inherited;
  if iTipo = 1 then
  begin
    EditQuantEstoque.asFloat := EditQtdeEntrada.asFloat;
    TratarCampoEstoque;
  end;  
end;

function TFormManutencaoProdutos.ValidaTela : Boolean;
begin
  Result := False;
  if FrameGrupos.EditCodigo.asInteger = 0 then
  begin
    MessageDlg('Informe o Grupo!', mtInformation, [mbOk], 0);
    FrameGrupos.EditCodigo.SetFocus;
    Exit;
  end;

  if CheckBoxSelecionarProduto.Checked then
  begin
    if FrameProdutos.EditCodigo.asInteger = 0 then
    begin
      MessageDlg('Informe o Produto!', mtInformation, [mbOk], 0);
      FrameProdutos.EditCodigo.SetFocus;
      Exit;
    end;
  end;

  if FrameFornecedor.EditCodigo.asInteger = 0 then
  begin
    MessageDlg('Informe o Fornecedor!', mtInformation, [mbOk], 0);
    FrameFornecedor.EditCodigo.SetFocus;
    Exit;
  end;

  Result := True;
end;

function TFormManutencaoProdutos.ValidaEntradaEstoque : Boolean;
begin
  Result := False;

  if EditQtdeEntrada.asInteger = 0 then
  begin
    MessageDlg('Quantidade de Entrada deve ser Maior que Zero(0)!', mtInformation, [mbOk], 0);
    EditQtdeEntrada.SetFocus;
    Exit;
  end;

  if (EditQtdeMax.asFloat <> 0) and
     ((EditQtdeEntrada.asFloat > EditQtdeMax.asFloat) or
      (EditQuantEstoque.asFloat > EditQtdeMax.asFloat)) then
  begin
    MessageDlg('Quantidade de Entrada deve ser Menor que a Quantidade Máxima!', mtInformation, [mbOk], 0);
    EditQtdeEntrada.SetFocus;
    Exit;
  end;

  if EditQtdeEntrada.asFloat < EditQtdeMin.asFloat then
  begin
    MessageDlg('Quantidade de Entrada deve ser Maior que a Quantidade Mínima!', mtInformation, [mbOk], 0);
    EditQtdeEntrada.SetFocus;
    Exit;
  end;


  Result := True;
end;

procedure TFormManutencaoProdutos.CheckBoxSelecionarProdutoClick(
  Sender: TObject);
begin
  inherited;
  HabilitaFrame(FrameProdutos,CheckBoxSelecionarProduto.Checked);
  if CheckBoxSelecionarProduto.Checked then
  begin
    EditDescricao.Enabled := False;
    EditUnidade.Enabled   := False;
    HabilitaFrame(FrameFornecedor,False);
    HabilitaGroupBox(GroupBoxCustos,False);
    FrameProdutos.NovoProduto := False;
    if CheckBoxManterDadosGrupo.Checked then
    begin
      if CodProdutoAnt <> 0 then
      begin
        FrameProdutos.EditCodigo.asInteger := CodProdutoAnt;
        ActiveControl := FrameProdutos;
        FrameProdutos.EditCodigo.OnExit(FrameProdutos.EditCodigo);
      end
      else
      begin
        FrameProdutos.EditCodigo.Limpa;
        FrameProdutos.EditCodigo.SetFocus
      end;
    end
    else
    begin
      FrameProdutos.EditCodigo.Limpa;
      FrameProdutos.EditCodigo.SetFocus
    end;
  end
  else
  begin
    EditDescricao.Enabled := True;
    EditUnidade.Enabled   := True;
    HabilitaFrame(FrameFornecedor,True);
    LimparCusto;
    HabilitaGroupBox(GroupBoxCustos,True);
    FrameProdutos.NovoProduto := True;
    FrameProdutos.EditCodigo.asInteger := EditCodigo.asInteger;
    EditClassificacao.Limpa;
    EditDescricao.Limpa;
    FrameFornecedor.LimparFrame;
    EditUnidade.Limpa;
    ed_localizacao.Limpa;
    CodListaPreco := RetornaProximaSequenciaLista;
  end;
end;

function TFormManutencaoProdutos.ValidaProduto : Boolean;
begin
  Result := True;

  if iTipo <> 1 then
    Exit;

  with DataModulePrin.SQLQueryValida do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' Select * from Produtos');
    SQL.Add(' where Codigo        = ' + FrameProdutos.EditCodigo.Text);
    SQL.Add('   and CodGrupo      = ' + FrameGrupos.EditCodigo.Text);
    SQL.Add('   and Classificacao = ' + QuotedStr(EditClassificacao.Text));

    Open;

    if not IsEmpty then
    begin
      Application.MessageBox('Já existe um produto cadastrado com esta Classificação para este Grupo!','Erro',0);
      EditClassificacao.SetFocus;
      Result := False;
    end;
  end;
end;

procedure TFormManutencaoProdutos.TrazListaPreco;
begin
  with DataModulePrin.SQLQueryPesquisa do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' Select CodListaPreco from Produtos');
    SQL.Add(' where Codigo        = ' + FrameProdutos.EditCodigo.Text);
    SQL.Add('   and CodGrupo      = ' + FrameGrupos.EditCodigo.Text);
    Open;

    if not IsEmpty then
    begin
      CodListaPreco := FieldByName('CodListaPreco').asInteger;
      Custos;
      HabilitaGroupBox(GroupBoxCustos,False);
    end
    else
      HabilitaGroupBox(GroupBoxCustos,True);
  end;
end;


procedure TFormManutencaoProdutos.FrameProdutosEditCodigoExit(
  Sender: TObject);
begin
  inherited;
  if (ActiveControl = CheckBoxSelecionarProduto) then
    Exit;

  if FrameGrupos.EditCodigo.asInteger = 0 then
  begin
    MessageDlg('Informe o Grupo!', mtInformation, [mbOk], 0);
    FrameGrupos.EditCodigo.SetFocus;
    Exit;
  end;


  FrameProdutos.fCodGrupo := FrameGrupos.EditCodigo.asInteger;
  
  FrameProdutos.EditCodigoExit(Sender);

  if FrameProdutos.isValido = False then
    Exit;

  if FrameProdutos.EditCodigo.asInteger <> 0 then
  begin
    EditDescricao.Text  := FrameProdutos.EditNome.Text;
    EditUnidade.Text    := FrameProdutos.vUnidade;
    ed_localizacao.Text := FrameProdutos.vLocalizacao;
    FrameFornecedor.EditCodigo.asInteger := FrameProdutos.vFornecedor;
    FrameFornecedor.EditCodigo.OnExit(FrameFornecedor.EditCodigo);
    TrazListaPreco;
    if EditClassificacao.CanFocus then
      EditClassificacao.SetFocus
    else
      EditDescricao.SetFocus;
  end;
end;

procedure TFormManutencaoProdutos.CalcularCustoCompra;
begin
  EditValorCustoCompra.asFloat := EditValorCusto.asFloat +
                         ValorAplicandoPercentual(EditValorCusto.asFloat,
                                                  EditPercIPI.asFloat) + 
                         ValorAplicandoPercentual(EditValorCusto.asFloat,
                                                  EditPercFreteCompra.asFloat) +
                         ValorAplicandoPercentual(EditValorCusto.asFloat,
                                                  EditPercICMS.asFloat);
end;


procedure TFormManutencaoProdutos.CalcularValorVenda;
begin
  EditValorVenda.asFloat := EditValorCusto.asFloat +
                         ValorAplicandoPercentual(EditValorCusto.asFloat,
                                                  EditPercIPI.asFloat) +
                         ValorAplicandoPercentual(EditValorCusto.asFloat,
                                                  EditPercFreteCompra.asFloat) +
                         ValorAplicandoPercentual(EditValorCusto.asFloat,
                                                  EditPercICMS.asFloat) +
                         EditValorLucro.asFloat;

  EditValorVendaFrete.asFloat := EditValorVenda.asFloat +
                              ValorAplicandoPercentual(EditValorVenda.asFloat,EditPercFreteVenda.asFloat);

end;


procedure TFormManutencaoProdutos.EditValorCustoExit(Sender: TObject);
begin
  inherited;
  CalcularCustoCompra;  
  CalcularValorVenda;

end;

procedure TFormManutencaoProdutos.EditPercFreteCompraExit(Sender: TObject);
begin
  inherited;
  CalcularCustoCompra;  
  CalcularValorVenda;

end;

procedure TFormManutencaoProdutos.EditPercICMSExit(Sender: TObject);
begin
  inherited;
  CalcularCustoCompra;
  CalcularValorVenda;

end;

procedure TFormManutencaoProdutos.RBLucroPercentualClick(Sender: TObject);
begin
  inherited;
  EditValorLucro.asFloat := ValorAplicandoPercentual(EditValorCustoCompra.asFloat, EditPercLucro.asFloat);
  EditValorLucro.Enabled := False;
  EditPercLucro.Enabled  := True;
  EditPercLucro.SetFocus;
end;

procedure TFormManutencaoProdutos.RBLucroValorClick(Sender: TObject);
begin
  inherited;
  EditPercLucro.asFloat  := PercentualAplicandoValor(EditValorLucro.asFloat, EditValorCustoCompra.asFloat);;
  EditPercLucro.Enabled  := False;
  EditValorLucro.Enabled := True;
  EditValorLucro.SetFocus;
end;

procedure TFormManutencaoProdutos.EditPercLucroExit(Sender: TObject);
begin
  inherited;
  EditValorLucro.asFloat := ValorAplicandoPercentual(EditValorCustoCompra.asFloat, EditPercLucro.asFloat);
  CalcularValorVenda;
end;

procedure TFormManutencaoProdutos.EditValorLucroExit(Sender: TObject);
begin
  inherited;
  EditPercLucro.asFloat := PercentualAplicandoValor(EditValorLucro.asFloat, EditValorCustoCompra.asFloat);
  CalcularValorVenda;
end;

procedure TFormManutencaoProdutos.EditPercFreteVendaExit(Sender: TObject);
begin
  inherited;
  EditValorVendaFrete.asFloat := EditValorVenda.asFloat +
                              ValorAplicandoPercentual(EditValorVenda.asFloat, EditPercFreteVenda.asFloat);

end;

procedure TFormManutencaoProdutos.GravarCustos;
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
        if (iTipo = 1) or (CDSCadastro.FieldByName('CodListaPreco').isNull) then
        begin
          SQL.Clear;
          SQL.Add(' INSERT INTO LISTAPRECO (');
          SQL.Add('     CODIGO , DESCRICAO, VALORCUSTO,PERCFRETECOMPRA,PERCICMS,PERCLUCRO,');
          SQL.Add('     PERCFRETEVENDA,VALORLUCRO,VALORVENDA,VALORVENDAFRETE, VALORCUSTOCOMPRA, PERCIPI)');
          SQL.Add(' VALUES (');
          SQL.Add('     :CODIGO , :DESCRICAO, :VALORCUSTO, :PERCFRETECOMPRA, :PERCICMS, :PERCLUCRO,');
          SQL.Add('     :PERCFRETEVENDA, :VALORLUCRO, :VALORVENDA, :VALORVENDAFRETE,:VALORCUSTOCOMPRA, :PERCIPI)');
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE LISTAPRECO');
          SQL.Add(' SET DESCRICAO        = :DESCRICAO,');
          SQL.Add('     VALORCUSTO       = :VALORCUSTO,');
          SQL.Add('     PERCFRETECOMPRA  = :PERCFRETECOMPRA,');
          SQL.Add('     PERCICMS         = :PERCICMS,');
          SQL.Add('     PERCLUCRO        = :PERCLUCRO,');
          SQL.Add('     PERCFRETEVENDA   = :PERCFRETEVENDA,');
          SQL.Add('     VALORLUCRO       = :VALORLUCRO,');
          SQL.Add('     VALORVENDA       = :VALORVENDA,');
          SQL.Add('     VALORVENDAFRETE  = :VALORVENDAFRETE,');
          SQL.Add('     VALORCUSTOCOMPRA = :VALORCUSTOCOMPRA,');
          SQL.Add('     PERCIPI          = :PERCIPI');  
          SQL.Add(' WHERE CODIGO = :CODIGO');
        end;
        ParamByName('Codigo').asFloat           := CodListaPreco;
        ParamByName('Descricao').asString       := '';
        ParamByName('ValorCusto').asFloat       := EditValorCusto.asFloat;
        ParamByName('PercIPI').asFloat          := EditPercIPI.asFloat;
        ParamByName('PercFreteCompra').asFloat  := EditPercFreteCompra.asFloat;
        ParamByName('PercICMS').asFloat         := EditPercICMS.asFloat;
        ParamByName('PercLucro').asFloat        := EditPercLucro.asFloat;
        ParamByName('ValorLucro').asFloat       := EditValorLucro.asFloat;
        ParamByName('ValorVenda').asFloat       := EditValorVenda.asFloat;
        ParamByName('PercFreteVenda').asFloat   := EditPercFreteVenda.asFloat;
        ParamByName('ValorVendaFrete').asFloat  := EditValorVendaFrete.asFloat;
        ParamByName('ValorCustoCompra').asFloat := EditValorCustoCompra.asFloat;
        ExecSQL;
        SQLConnectionPrin.Commit(TransDesc);
      end;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar os Custos! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
end;

procedure TFormManutencaoProdutos.Custos;
begin
  with CDSCustos do
  begin
    SQL.Clear;
    SQL.Add(' Select * from ListaPreco            ');
    SQL.Add(' where Codigo        = :CodListaPreco');
    Close;
    CommandText := SQL.Text;
    Params.ParambyName('CodListaPreco').asInteger := CodListaPreco;
    Open;

    if not IsEmpty then
    begin
      EditValorCusto.asFloat       := FieldByName('ValorCusto').asFloat;
      EditPercIPI.asFloat          := FieldByName('PercIPI').asFloat;
      EditPercFreteCompra.asFloat  := FieldByName('PercFreteCompra').asFloat;
      EditPercICMS.asFloat         := FieldByName('PercICMS').asFloat;
      EditPercLucro.asFloat        := FieldByName('PercLucro').asFloat;
      EditValorLucro.asFloat       := FieldByName('ValorLucro').asFloat;
      EditValorVenda.asFloat       := FieldByName('ValorVenda').asFloat;
      EditPercFreteVenda.asFloat   := FieldByName('PercFreteVenda').asFloat;
      EditValorVendaFrete.asFloat  := FieldByName('ValorVendaFrete').asFloat;
      EditValorCustoCompra.asFloat := FieldByName('ValorCustoCompra').asFloat;
    end;
  end;
end;




procedure TFormManutencaoProdutos.EditValorVendaExit(Sender: TObject);
begin
  inherited;
  EditValorVendaFrete.asFloat := EditValorVenda.asFloat +
                                 ValorAplicandoPercentual(EditValorVenda.asFloat, EditPercFreteVenda.asFloat);
end;

procedure TFormManutencaoProdutos.LimparCusto;
begin
  EditValorCusto.asFloat                := 0;
  EditPercIPI.asFloat                   := 0;;
  EditPercFreteCompra.asFloat           := 0;
  EditPercICMS.asFloat                  := 0;
  EditPercLucro.asFloat                 := 0;
  EditValorLucro.asFloat                := 0;
  EditValorVenda.asFloat                := 0;
  EditPercFreteVenda.asFloat            := 0;
  EditValorVendaFrete.asFloat           := 0;
  RBLucroPercentual.Checked             := True;
  EditValorLucro.Enabled                := False;
  EditValorCustoCompra.asFloat          := 0;
end;

function TFormManutencaoProdutos.RetornaProximaSequenciaProduto : Integer;
begin
  Result := 1;
  with DataModulePrin.SQLQueryExecuta do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select Max(Codigo) as Prox from Produtos where CodGrupo = ' + FrameGrupos.EditCodigo.Text);
    Open;

    if not IsEmpty then
    begin
      if not FieldByName('Prox').IsNull then
        Result := (FieldByName('Prox').asInteger + 1);
    end;
  end;
end;

function TFormManutencaoProdutos.RetornaProximaSequenciaLista : Integer;
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
        SQL.Add('  Set CodListaPreco = CodListaPreco + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from ListaPreco where Codigo = (Select CodListaPreco from UltimaSequencia)');
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
      SQL.Add('Select CodListaPreco from UltimaSequencia');
      Open;

      Result := FieldByname('CodListaPreco').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequenciaLista;
end;


procedure TFormManutencaoProdutos.VoltaUltimSequencia;
Var TransDesc : TTransactionDesc;
begin
  if (FrameProdutos.EditCodigo.asInteger = 0) or
     (CheckBoxSelecionarProduto.Checked = True) then
     Exit;
        
  Try
    TransDesc.TransactionID  := 1;
    TransDesc.IsolationLevel := xilREADCOMMITTED;
    DataModulePrin.SQLConnectionPrin.StartTransaction(TransDesc);
    with DataModulePrin.SQLQueryExecuta do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Update UltimaSequencia');
      SQL.Add('  Set CodListaPreco = ' + IntToStr(CodListaPreco) + ' - 1');
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




procedure TFormManutencaoProdutos.BitBtnCancelarClick(Sender: TObject);
begin
  inherited;
  if iTipo = 1 then
    VoltaUltimSequencia;
end;

procedure TFormManutencaoProdutos.EditPercIPIExit(Sender: TObject);
begin
  inherited;
  CalcularCustoCompra;
  CalcularValorVenda;
end;

procedure TFormManutencaoProdutos.DS_ManutencaoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if (CheckBoxFecharTela.Checked = False) and Self.Showing then
    PrepararTelaManutencao;

end;

procedure TFormManutencaoProdutos.EditDescricaoExit(Sender: TObject);
begin
  inherited;
  if (ActiveControl = BitBtnCancelar)    or
     (ActiveControl = EditClassificacao) or
     (ActiveControl = FrameProdutos)     or
     (ActiveControl = FrameGrupos) then
    Exit;

  if Trim(EditDescricao.Text) = '' then
  begin
    EditDescricao.SetFocus;
    Exit;
  end;

end;

procedure TFormManutencaoProdutos.FrameProdutosSpeedButtonConsultaClick(
  Sender: TObject);
begin
  inherited;
  FrameProdutos.fCodGrupo := FrameGrupos.EditCodigo.asInteger;
  FrameProdutos.SpeedButtonConsultaClick(Sender);
end;

procedure TFormManutencaoProdutos.AlterarTodosProdutosFilhos;
begin
  with DataModulePrin.SQLQueryExecuta do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Update Produtos');
    SQL.Add('  set Descricao      = :Descricao,');
    SQL.Add('      Unidade        = :Unidade,');
    SQL.Add('      CodFornecedor  = :CodFornecedor');
    SQL.Add(' where CodGrupo      = :CodGrupo');
    SQL.Add('   and Codigo        = :Codigo');
    SQL.Add('   and Classificacao <> ''''');
    ParamByName('Codigo').asInteger        := FrameProdutos.EditCodigo.asInteger;
    ParamByName('CodGrupo').asInteger      := FrameGrupos.EditCodigo.asInteger;
    ParamByName('Descricao').asString      := EditDescricao.Text;
    ParamByName('Unidade').asString        := EditUnidade.Text;
    ParamByName('CodFornecedor').asInteger := FrameFornecedor.EditCodigo.asInteger;
    ExecSQL;
  end;
end;

procedure TFormManutencaoProdutos.CheckBoxManterDadosGrupoClick(
  Sender: TObject);
begin
  inherited;
  if CheckBoxManterDadosGrupo.Checked then
    CheckBoxFecharTela.Checked := False;
end;

procedure TFormManutencaoProdutos.CriarProdutoPai(NovoProduto : Integer);
begin
  if (CheckBoxSelecionarProduto.Checked = False) and (iTipo = 1) and (TipoProduto = 2) then
  begin
    with DataModulePrin.SQLQueryExecuta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' INSERT INTO PRODUTOS (');
      SQL.Add('     CODIGO, CODGRUPO, CLASSIFICACAO, DESCRICAO, UNIDADE,');
      SQL.Add('     CODFORNECEDOR, CODLISTAPRECO)');
      if CheckBoxSelecionarProduto.Checked = False then
      begin
        SQL.Add('Values (:CODIGO, :CODGRUPO, :CLASSIFICACAO, :DESCRICAO, :UNIDADE,');
        SQL.Add('        :CODFORNECEDOR,:CODLISTAPRECO)');
      end
      else
      begin
        SQL.Add(' Values( :CODIGO,:CODGRUPO, :CLASSIFICACAO, :DESCRICAO, :UNIDADE,');
        SQL.Add('         :CODFORNECEDOR,:CODLISTAPRECO)');
      end;
      ParamByName('Codigo').asInteger        := NovoProduto;
      ParamByName('CodGrupo').asInteger      := FrameGrupos.EditCodigo.asInteger;
      ParamByName('Classificacao').asString  := '';
      ParamByName('Descricao').asString      := EditDescricao.Text;
      ParamByName('Unidade').asString        := EditUnidade.Text;
      ParamByName('CodFornecedor').asInteger := FrameFornecedor.EditCodigo.asInteger;
      ParamByName('CodListaPreco').asInteger := CodListaPreco;
      ExecSQL;
    end;
  end;
end;


procedure TFormManutencaoProdutos.CheckBoxFecharTelaClick(Sender: TObject);
begin
  inherited;
  if CheckBoxFecharTela.Checked then
    CheckBoxManterDadosGrupo.Checked := False;
end;

procedure TFormManutencaoProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  HouveAlteracao := False;
  s_cod_grupo         := '';
  s_cod_produto       := '';
  s_cod_classificacao := '';
end;

procedure TFormManutencaoProdutos.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if LabelAlterarPrecos.Enabled = False then
    Exit;

  if Key = VK_F7 then
  begin
    HabilitaGroupBox(GroupBoxCustos,True);
    if RBLucroPercentual.Checked then
      EditValorLucro.Enabled := False
    else
      EditPercLucro.Enabled  := False;
  end;
end;

procedure TFormManutencaoProdutos.EditValorCustoCompraExit(
  Sender: TObject);
begin
  inherited;
  CalcularValorVenda;
end;


procedure TFormManutencaoProdutos.AtualizarEstoqueProdutoPrin;
begin
  with DataModulePrin do
  begin
    With SQLQueryExecuta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE ESTOQUEPRODUTOS');
      SQL.Add(' SET  ');
      SQL.Add('   QUANTIDADE        = QUANTIDADE + :QUANTIDADE,');
      SQL.Add('   QUANTENTRADA      = :QUANTENTRADA');
      SQL.Add(' WHERE CODPRODUTO    = :CODPRODUTO');
      SQL.Add('   AND CODGRUPO      = :CODGRUPO');
      SQL.Add('   AND CLASSIFICACAO = ''''');

      ParamByName('CodGrupo').asInteger     := FrameGrupos.EditCodigo.asInteger;
      ParamByName('CodProduto').asInteger   := FrameProdutos.EditCodigo.asInteger;
      ParamByName('Quantidade').asFloat     := EditQtdeEntrada.asFloat;
      ParamByName('QuantEntrada').asFloat   := EditQtdeEntrada.asFloat;
      ExecSQL;
    end;  
  end;
end;

end.
