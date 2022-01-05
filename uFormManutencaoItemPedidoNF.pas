unit uFormManutencaoItemPedidoNF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, StdCtrls, Buttons, ExtCtrls,
  uFrameModelo, uFrameProdutos, TAdvEditP, FMTBcd, DB, SqlExpr, Provider,
  DBClient, DBCtrls, Math;

type
  TFormManutencaoItemPedidoNF = class(TFormManutencao)
    PnlDados: TPanel;
    FrameProdutos: TFrameProdutos;
    EditUnidade: TAdvEdit;
    Label5: TLabel;
    Label15: TLabel;
    EditValorTotalVenda: TAdvEdit;
    EditQuantEstoque: TAdvEdit;
    LblEstoque: TLabel;
    Label1: TLabel;
    EditQuantPedida: TAdvEdit;
    EditValorTotal: TAdvEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditGrupo: TAdvEdit;
    Label4: TLabel;
    EditClassif: TAdvEdit;
    Label6: TLabel;
    EditCodFornecedor: TAdvEdit;
    EditFornecedor: TAdvEdit;
    CDSVerifProduto: TClientDataSet;
    DSPVerifProduto: TDataSetProvider;
    SQLVerifProduto: TSQLDataSet;
    DS_VerifProduto: TDataSource;
    Label7: TLabel;
    EditAliqICMS: TAdvEdit;
    Label8: TLabel;
    EditSitTrib: TAdvEdit;
    EditSeq: TAdvEdit;
    Label9: TLabel;
    EditDesconto: TAdvEdit;
    EditValorComissao: TAdvEdit;
    Label10: TLabel;
    LabelAlterarPrecos: TLabel;
    EditQuantProduto: TAdvEdit;
    EditQuantProdutoExc: TAdvEdit;
    EditValorFrete: TAdvEdit;
    Label11: TLabel;
    EditDiferenca: TAdvEdit;
    EditPercComissao: TAdvEdit;
    Label12: TLabel;
    ck_alterar_comissao: TCheckBox;
    Edt_FlagComissaoAlterada: TAdvEdit;
    EditOK: TAdvEdit;
    procedure EditQuantPedidaExit(Sender: TObject);
    procedure EditValorTotalVendaExit(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditGrupoExit(Sender: TObject);
    procedure EditClassifExit(Sender: TObject);
    procedure FrameProdutosSpeedButtonConsultaClick(Sender: TObject);
    procedure DS_ManutencaoDataChange(Sender: TObject; Field: TField);
    procedure FrameProdutosEditCodigoChange(Sender: TObject);
    procedure FrameProdutosEditCodigoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditValorComissaoExit(Sender: TObject);
    procedure EditPercComissaoExit(Sender: TObject);
    procedure ck_alterar_comissaoClick(Sender: TObject);
  private
    { Private declarations }
    b_alterar_precos, b_alterar_comissao : Boolean;
    function DadosProduto(Verificar : Boolean) : Boolean;
    procedure CalcularTotal;
    function  ValidaTela : Boolean;
    procedure MostraDadosProduto;
    function  ValidaQuantPedida : Boolean;
    procedure PrepararTelaManutencao;
    procedure LimparTela;
    procedure GravarItens;
    procedure CalcularComissaoIndividual;
    procedure VerifProdutosDupl;
    procedure CalcularFrete;
    procedure CalcularDiferenca;
    procedure CalcularComissaoPercentual;
    procedure CalcularComissaoValor;
    procedure Setar_FlagOK;
  public
    { Public declarations }
    IsOk : Boolean;
  end;

var
  FormManutencaoItemPedidoNF: TFormManutencaoItemPedidoNF;

implementation

{$R *.dfm}
Uses uDataModule, uFuncoes, uFormPedidoNota;

function TFormManutencaoItemPedidoNF.DadosProduto(Verificar : Boolean) : Boolean;
begin
  Result := False;
  Screen.Cursor := crHourGlass;
  With CDSVerifProduto do
  begin
    SQL.Clear;
    SQL.Add(' Select Prod.CODGRUPO, Prod.CLASSIFICACAO,');
    SQL.Add('        Prod.DESCRICAO, Prod.UNIDADE, Ep.QUANTIDADE, Lp.VALORVENDAFRETE, Prod.CODFORNECEDOR, ');
    SQL.Add('        Fr.Nome as Fornecedor, Ep.QUANTIDADEMIN, Lp.PERCFRETEVENDA ');
    SQL.Add(' from Produtos Prod ');
    SQL.Add(' Left outer Join ListaPreco Lp on Lp.Codigo        = Prod.CodListaPreco');
    SQL.Add(' Left outer Join EstoqueProdutos Ep on Ep.CodGrupo      = Prod.CodGrupo');
    SQL.Add('                                   and Ep.CodProduto    = Prod.Codigo');
    SQL.Add('                                   and Ep.Classificacao = Prod.Classificacao');
    SQL.Add(' Left outer Join Fornecedores Fr on Fr.Codigo      = Prod.CodFornecedor');
    SQL.Add(' where (Prod.Codigo   = ' + FrameProdutos.EditCodigo.Text + ')');
    if EditGrupo.asInteger <> 0 then
      SQL.Add(' and (Prod.CodGrupo = ' + EditGrupo.Text + ')');
    if EditClassif.Text <> '' then
      SQL.Add(' and (Prod.Classificacao = ' + QuotedStr(EditClassif.Text) + ')')
    else
      SQL.Add(' and (Prod.Classificacao = '''')');
    SQL.Add(' Order by Prod.CodGrupo');
    Close;
    CommandText := SQL.Text;
    Open;


    Screen.Cursor := crDefault;

    if IsEmpty then
    begin
      MessageDlg('O Produto Não foi Encontrado!', mtInformation, [mbOk], 0);
      Close;
      Exit;
    end
    else
      if Verificar = False then
        MostraDadosProduto;
  end;
  Result := True;
end;

procedure TFormManutencaoItemPedidoNF.MostraDadosProduto;
begin
  with CDSVerifProduto do
  begin
    EditGrupo.asInteger          := FieldByName('CODGRUPO').asInteger;
    EditClassif.Text             := FieldByName('CLASSIFICACAO').asString;
    EditUnidade.Text             := FieldByName('UNIDADE').asString;
    EditCodFornecedor.asInteger  := FieldByName('CODFORNECEDOR').asInteger;
    EditFornecedor.Text          := FieldByName('Fornecedor').asString;
    FrameProdutos.EditNome.Text  := FieldByName('DESCRICAO').asString;
    VerifProdutosDupl;

    if iTipo = 1 then
    begin
      EditValorTotalVenda.asFloat  := FieldByName('VALORVENDAFRETE').asFloat;
      EditQuantPedida.asFloat      := 1;
    end;
    EditQuantEstoque.asFloat     := (FieldByName('QUANTIDADE').asFloat - FieldByName('QUANTIDADEMIN').asFloat) -
                                    EditQuantProduto.asFloat + EditQuantProdutoExc.asFloat;

    CalcularTotal;
    if EditQuantEstoque.asFloat <= 0 then
      EditQuantEstoque.Color := clRed
    else
      EditQuantEstoque.Color := $00EC7600;
   end;
end;

procedure TFormManutencaoItemPedidoNF.CalcularTotal;
begin
  EditValorTotal.asFloat := (EditQuantPedida.asFloat     * (EditValorTotalVenda.asFloat -
                            (EditValorTotalVenda.asFloat * (EditDesconto.asFloat / 100))) +
                            (EditValorTotalVenda.asFloat * (EditAliqICMS.asFloat / 100)));

  if (ck_alterar_comissao.Checked = False) then
    CalcularComissaoIndividual;
  CalcularFrete;
end;

procedure TFormManutencaoItemPedidoNF.EditQuantPedidaExit(Sender: TObject);
begin
  inherited;
  CalcularTotal;
end;

procedure TFormManutencaoItemPedidoNF.EditValorTotalVendaExit(
  Sender: TObject);
begin
  inherited;
  CalcularTotal;
end;

procedure TFormManutencaoItemPedidoNF.BitBtnCancelarClick(Sender: TObject);
begin
  inherited;
  close;
end;


function TFormManutencaoItemPedidoNF.ValidaTela : Boolean;
//Var BM : TBookMark;
begin
  Result := False;
  if FrameProdutos.EditCodigo.asInteger = 0 then
  begin
    MessageDlg('Informe o Produto!', mtInformation, [mbOk], 0);
    FrameProdutos.EditCodigo.SetFocus;
    Exit;
  end;

  if EditQuantPedida.asFloat = 0 then
  begin
    MessageDlg('Informe a Quantidade Pedida!', mtInformation, [mbOk], 0);
    EditQuantPedida.SetFocus;
    Exit;
  end;

  if ValidaQuantPedida = False then
  begin
    If Application.MessageBox('O Produto possui Estoque Insuficiente, Deseja Vender o Produto mesmo assim?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idno then
    begin
      EditQuantPedida.SetFocus;
      Exit;
    end;
  end;

  if EditDesconto.asFloat > 10 then
  begin
    MessageDlg('Não é Permitido Aplicar um Desconto Maior que 10%!', mtInformation, [mbOk], 0);
    EditDesconto.SetFocus;
    Exit;
  end;

 { with CDSCadastro do
  begin
    BM := GetBookmark;
    if Locate('CodGrupo;CodProduto;Classificacao',
       VarArrayof([EditGrupo.asInteger, FrameProdutos.EditCodigo.asInteger,EditClassif.Text]),[]) then
    begin
      if FieldByName('Sequencia').asInteger <> EditSeq.asInteger then
      begin
        Try
          GotoBookmark(BM);
          FreeBookmark(BM);
        Except
          FreeBookmark(BM);
        end;
        MessageDlg('O Produto já Existe no Pedido!', mtWarning, [mbOk], 0);
        if FrameProdutos.EditCodigo.CanFocus then
          FrameProdutos.EditCodigo.SetFocus;
        Exit;
      end;
    end;
  end;}

  if DadosProduto(True) = False then
    Exit;

  Result := True;
end;

procedure TFormManutencaoItemPedidoNF.BitBtnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  if FrameProdutos.EditNome.text = 'DESCONTO TOTAL' then
  begin
    Application.MessageBox('Este Produto não pode ser inserido Manualmente!','Informação',0);
    Exit;
  end;

  if iTipo = 1 then
  begin
    if FormPedidoNota.ComboBoxTipo.ItemIndex = 1 then
    begin
      if FormPedidoNota.ContadorItens >= 23 then
      begin
        Application.MessageBox('O Número Máximo de Itens na Nota foi Atingido','Informação',0);
        Exit;
      end;
    end;
  end;
  if EditPercComissao.asFloat > 10 then
  begin
    MessageDlg('O Percentual de Comissão não pode ser Maior que 10%!', mtInformation, [mbOk], 0);
    if EditPercComissao.CanFocus then
      EditPercComissao.SetFocus;
    Exit;
  end;


  Setar_FlagOK;

  DS_Manutencao.OnDataChange := nil;

  if ValidaTela = False then
    Exit;

  GravarItens;

  DS_Manutencao.OnDataChange := DS_ManutencaoDataChange;

  if CheckBoxFecharTela.Checked = True then
    Close
  else
  begin
    CDSCadastro.Next;
    if iTipo = 1 then
      EditGrupo.SetFocus
    else
      EditQuantPedida.SetFocus;
  end;
end;

procedure TFormManutencaoItemPedidoNF.FormShow(Sender: TObject);
begin
  if iTipo <> 1 then
    EditGrupo.SetFocus;
  inherited;
  IsOk := False;
  FrameProdutos.EditGrupo := Self.EditGrupo;
  FrameProdutos.EditClass := Self.EditClassif;

  PrepararTelaManutencao;
  if iTipo = 1 then
    FrameProdutos.SpeedButtonConsulta.OnClick(FrameProdutos.SpeedButtonConsulta);
end;

function TFormManutencaoItemPedidoNF.ValidaQuantPedida : Boolean;
Var QuantJahDigitada : Double;
begin
  QuantJahDigitada := 0;
  Result           := False;

  if iTipo = 2 then {Alteração}
  begin
    if CDSCadastro.FieldByname('Status').asString = 'A' then
      QuantJahDigitada := CDSCadastro.FieldByname('QuantPedida').asFloat;
  end;

  if (EditQuantPedida.asFloat <> 0) then
  begin
    if (EditQuantPedida.asFloat > EditQuantEstoque.asFloat + QuantJahDigitada) then
      Exit;
  end;
  Result := True;
end;

procedure TFormManutencaoItemPedidoNF.EditGrupoExit(Sender: TObject);
begin
  inherited;
  if (FrameProdutos.EditCodigo.asInteger <> 0) then
  begin
    if DadosProduto(False) = False then
      EditGrupo.SetFocus;
  end;
end;

procedure TFormManutencaoItemPedidoNF.EditClassifExit(Sender: TObject);
begin
  inherited;
  if (FrameProdutos.EditCodigo.asInteger <> 0) then
  begin
    if DadosProduto(False) = False then
      EditClassif.SetFocus;
  end;
end;

procedure TFormManutencaoItemPedidoNF.FrameProdutosSpeedButtonConsultaClick(
  Sender: TObject);
Var CodProdutoAnt, CodGrupoAnt : Integer;
    CodClass : String;
begin
  inherited;
  CodProdutoAnt := FrameProdutos.EditCodigo.asInteger;
  CodGrupoAnt   := EditGrupo.asInteger;
  CodClass      := EditClassif.Text;

  LimparTela;

  FrameProdutos.SpeedButtonConsultaClick(Sender);
  if FrameProdutos.EditCodigo.asInteger = 0 then
  begin
    FrameProdutos.EditCodigo.asInteger := CodProdutoAnt;
    FrameProdutos.EditCodigo.OnExit(FrameProdutos.EditCodigo);
    EditGrupo.asInteger := CodGrupoAnt;
    EditClassif.Text    := CodClass;
  end;
  EditClassif.OnExit(EditClassif);
end;

procedure TFormManutencaoItemPedidoNF.PrepararTelaManutencao;
begin
  FrameProdutos.CodGrupoLoc   := EditGrupo.asInteger;
  FrameProdutos.CodProdutoLoc := FrameProdutos.EditCodigo.asInteger;
  FrameProdutos.Expandido     := IfThen((Trim(EditClassif.Text) <> ''),1,0);


  with CDSCadastro do
  begin
    if iTipo = 1 then
      LimparTela
    else if iTipo = 2 then
    begin
      EditQuantPedida.asFloat       := FieldByName('QuantPedida').asFloat;
      EditAliqICMS.asFloat          := FieldByName('AliqICMS').asFloat;
      EditDesconto.asFloat          := FieldByName('ValorDesconto').asFloat;
      EditValorComissao.asFloat     := FieldByName('ValorComissao').asFloat;
      EditValorFrete.asFloat        := FieldByName('ValorFreteaPagar').asFloat;
      EditValorTotal.asFloat        := FieldByName('ValorTotal').asFloat;
      EditSitTrib.Text              := FieldByName('SitTrib').asString;
      EditSeq.asInteger             := FieldByName('Sequencia').asInteger;
      EditValorTotalVenda.asFloat   := FieldByName('ValorUnitario').asFloat;
      Edt_FlagComissaoAlterada.asInteger  := FieldByName('FlagComissaoAlterada').asInteger;
      EditOk.asInteger              := FieldByName('FlagOK').asInteger;

      EditGrupo.asInteger           := FieldByName('CodGrupo').asInteger;
      FrameProdutos.EditCodigo.asInteger := FieldByName('CodProduto').asInteger;
      EditClassif.Text              := FieldByName('Classificacao').asString;
      FrameProdutos.EditCodigo.Onexit(FrameProdutos.EditCodigo);

      if (FieldByName('PercComissao').asFloat = 0) and
         (Edt_FlagComissaoAlterada.asInteger = 0) then
        CalcularComissaoPercentual
      else
        EditPercComissao.asFloat    := FieldByName('PercComissao').asFloat;

      VerifPermissoesExtras(1);
      b_alterar_precos            := (DataModulePrin.SQLQueryPesquisa.FieldByName('FlagSimNao').asInteger = 1);
      LabelAlterarPrecos.Enabled  := b_alterar_precos;
      VerifPermissoesExtras(2);
      b_alterar_comissao          := (DataModulePrin.SQLQueryPesquisa.FieldByName('FlagSimNao').asInteger = 1);
      ck_alterar_comissao.Enabled := b_alterar_comissao;
      ck_alterar_comissao.Checked := (Edt_FlagComissaoAlterada.asInteger = 1) and
                                      b_alterar_comissao;

      HabilitaFrame(FrameProdutos, False);
      EditGrupo.Enabled   := False;
      EditClassif.Enabled := False;
      EditQuantPedida.SelectAll;
      EditQuantPedida.SetFocus;
    end;
  end;
end;

procedure TFormManutencaoItemPedidoNF.LimparTela;
begin
  FrameProdutos.LimparFrame;
  EditGrupo.Limpa;
  EditClassif.Limpa;
  EditCodFornecedor.Limpa;
  EditFornecedor.Limpa;
  EditQuantPedida.Limpa;
  EditAliqICMS.Limpa;
  EditDesconto.Limpa;
  EditValorTotal.Limpa;
  EditValorTotalVenda.Limpa;
  EditQuantEstoque.Limpa;
  EditUnidade.Limpa;
  EditSitTrib.Limpa;
  EditSeq.Limpa;
  EditValorComissao.Limpa;
  EditPercComissao.Limpa;
  EditValorFrete.Limpa;
  EditQuantProduto.Limpa;
  EditDiferenca.Limpa;
  Edt_FlagComissaoAlterada.Limpa;
  EditOK.Limpa;
  FrameProdutos.vCodGrupo      := 0;
  FrameProdutos.vClassificacao := '';
  FrameProdutos.vUnidade       := '';
  FrameProdutos.vFornecedor    := 0;
  FrameProdutos.fCodGrupo      := 0;
  ck_alterar_comissao.Checked  := False;
end;


procedure TFormManutencaoItemPedidoNF.GravarItens;
begin
  CalcularFrete;
  with CDSCadastro do
  begin
    if iTipo = 1 then
    begin
      FormPedidoNota.ContadorItens            := FormPedidoNota.ContadorItens + 1;

      Append;
      FormPedidoNota.NumSequencia             := FormPedidoNota.NumSequencia + 1;
      FieldByName('CodPedidoNF').asInteger    := FormPedidoNota.FramePedidoNota.EditCodigo.asInteger;
      FieldByName('Tipo').asInteger           := FormPedidoNota.ComboBoxTipo.ItemIndex + 1;
      FieldByName('Sequencia').asInteger      := FormPedidoNota.NumSequencia;
    end
    else
      Edit;
    FieldByName('CodProduto').asInteger      := FrameProdutos.EditCodigo.asInteger;
    FieldByName('DescricaoProduto').asString := FrameProdutos.EditNome.Text;
    FieldByName('CodGrupo').asInteger        := EditGrupo.asInteger;
    FieldByName('Classificacao').asString    := EditClassif.Text;
    FieldByName('SitTrib').asString          := EditSitTrib.Text;
    FieldByName('QuantPedida').asFloat       := EditQuantPedida.asFloat;
    FieldByName('ValorUnitario').asFloat     := EditValorTotalVenda.asFloat;
    FieldByName('ValorTotal').asFloat        := EditValorTotal.asFloat;
    FieldByName('AliqICMS').asFloat          := EditAliqICMS.asFloat;
    FieldByName('ValorDesconto').asFloat     := EditDesconto.asFloat;
    FieldByName('ValorComissao').asFloat     := EditValorComissao.asFloat;
    FieldByName('ValorFreteaPagar').asFloat  := EditValorFrete.asFloat;
    FieldByName('PercComissao').asFloat      := EditPercComissao.asFloat;
    FieldByName('FlagComissaoAlterada').asInteger := Edt_FlagComissaoAlterada.asInteger;
    FieldByName('FlagOK').asInteger          := EditOK.asInteger;
    if EditOK.asInteger = 0 then
      FieldByName('Conf').asString           := ''
    else
      FieldByName('Conf').asString           := 'OK';
      
    if iTipo = 1 then
      FieldByName('Status').asString := 'I'
    else if iTipo = 2 then
    begin
      if FieldByName('Status').asString <> 'I' then
        FieldByName('Status').asString := 'A';
    end;
    Post;
    IsOk := True;
  end;
end;

procedure TFormManutencaoItemPedidoNF.DS_ManutencaoDataChange(
  Sender: TObject; Field: TField);
begin
  inherited;
  if (CheckBoxFecharTela.Checked = False) and Self.Showing  then
  begin
    PrepararTelaManutencao;
    if iTipo = 1 then
      FrameProdutos.SpeedButtonConsulta.OnClick(FrameProdutos.SpeedButtonConsulta);
  end;
end;

procedure TFormManutencaoItemPedidoNF.FrameProdutosEditCodigoChange(
  Sender: TObject);
begin
  inherited;
  if FrameProdutos.EditCodigo.asInteger = 0 then
    LimparTela;
end;

procedure TFormManutencaoItemPedidoNF.FrameProdutosEditCodigoExit(
  Sender: TObject);
begin
  FrameProdutos.fCodGrupo := EditGrupo.asInteger;
  inherited;                                       
  if FrameProdutos.EditCodigo.asInteger <> 0 then
  begin
    if DadosProduto(False) = False then
      FrameProdutos.EditCodigo.SetFocus
    else
      FrameProdutos.EditCodigoExit(Sender);  
  end;
end;

procedure TFormManutencaoItemPedidoNF.CalcularComissaoIndividual;
Var Diferenca : Double;
begin
  CalcularDiferenca;
  if FormPedidoNota.EditPercComissao.asFloat > 0 then
  begin
    if EditDiferenca.asFloat >= 0 then
      Diferenca := EditDiferenca.asFloat
    else
      Diferenca := 0;
    EditPercComissao.asFloat  := RoundTo((FormPedidoNota.EditPercComissao.asFloat - (EditDesconto.asFloat + Diferenca)),-2);
    EditValorComissao.asFloat := RoundTo(((EditValorTotalVenda.asFloat * EditQuantPedida.asFloat)  * (EditPercComissao.asFloat / 100)),-2);
  end;

  if EditValorComissao.asFloat <= 0 then
  begin
    EditValorComissao.asFloat := 0;
    EditPercComissao.asFloat  := 0;
  end;


end;

procedure TFormManutencaoItemPedidoNF.CalcularComissaoPercentual;
Var PercComissao, Diferenca : Double;

begin
  CalcularDiferenca;
  if EditDiferenca.asFloat >= 0 then
    Diferenca := EditDiferenca.asFloat
  else
    Diferenca := 0;

  PercComissao := RoundTo((FormPedidoNota.EditPercComissao.asFloat - (EditDesconto.asFloat + Diferenca)),-2);
  if EditValorComissao.asFloat > 0 then
  begin
    if RoundTo(((EditValorTotalVenda.asFloat * EditQuantPedida.asFloat) * (PercComissao / 100)),-2) = EditValorComissao.asFloat then
      EditPercComissao.asFloat  := PercComissao
    else
      EditPercComissao.asFloat  := RoundTo(((EditValorComissao.asFloat * 100) / (EditValorTotalVenda.asFloat * EditQuantPedida.asFloat)),-2)
  end
  else
    EditPercComissao.asFloat  := 0;
end;

procedure TFormManutencaoItemPedidoNF.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if LabelAlterarPrecos.Enabled = False then
    Exit;
      
  if Key = VK_F7 then
  begin
    EditValorTotalVenda.ReadOnly := False;
    EditValorTotalVenda.SetFocus;
  end;
end;


procedure TFormManutencaoItemPedidoNF.VerifProdutosDupl;
Var BM : TBookMark;
begin
  EditQuantProduto.asFloat    := 0;
  EditQuantProdutoExc.asFloat := 0;
  DS_Manutencao.OnDataChange  := nil;

  with CDSCadastro do
  begin
    BM := GetBookmark;
    Filtered := False;
    Filter   := ' CodGrupo = ' + EditGrupo.Text +
                ' and CodProduto = ' + FrameProdutos.EditCodigo.Text +
                ' and Classificacao = ' + QuotedStr(EditClassif.Text);
    Filtered := True;
    First;
    while not EOF do
    begin
      if (FieldByName('Sequencia').asInteger <> EditSeq.asInteger) then
      begin
        if (FieldByName('Status').asString = 'I') then
          EditQuantProduto.asFloat := EditQuantProduto.asFloat + FieldByName('QuantPedida').asFloat
        else if (FieldByName('Status').asString = 'E') then
          EditQuantProdutoExc.asFloat := EditQuantProdutoExc.asFloat + FieldByName('QuantPedida').asFloat
      end;
      Next;
    end;
    Filtered := False;
    Filter   := ' Status <> ''E''';
    Filtered := True;
    Try
      GotoBookmark(BM);
      FreeBookmark(BM);
    Except
      FreeBookmark(BM);
    end;
  end;
  DS_Manutencao.OnDataChange := DS_ManutencaoDataChange;
end;

procedure TFormManutencaoItemPedidoNF.CalcularFrete;
begin
  CalcularDiferenca;
  if (CDSVerifProduto.FieldByName('VALORVENDAFRETE').asFloat <= EditValorTotalVenda.asFloat) and
     (EditDesconto.asFloat = 0) and (EditDiferenca.asFloat = 0) then
    EditValorFrete.asFloat := RoundTo((EditValorTotalVenda.asFloat * (CDSVerifProduto.FieldByName('PERCFRETEVENDA').asFloat / 100)),-2)
  else
    EditValorFrete.asFloat := 0;  
end;

procedure TFormManutencaoItemPedidoNF.CalcularDiferenca;
Var Diferenca : Double;
begin
  EditDiferenca.asFloat := 0;
  if CDSVerifProduto.FieldByName('VALORVENDAFRETE').AsFloat = 0 then
    Exit;

  if (CDSVerifProduto.FieldByName('VALORVENDAFRETE').AsFloat <> EditValorTotalVenda.asFloat) then
  begin
    Diferenca := (CDSVerifProduto.FieldByName('VALORVENDAFRETE').AsFloat - EditValorTotalVenda.asFloat);
    EditDiferenca.asFloat := RoundTo(((Diferenca * 100) / CDSVerifProduto.FieldByName('VALORVENDAFRETE').AsFloat),-2);
  end
  else
    EditDiferenca.asFloat := 0;
end;


procedure TFormManutencaoItemPedidoNF.EditValorComissaoExit(
  Sender: TObject);
begin
  inherited;
  CalcularComissaoPercentual;
end;

procedure TFormManutencaoItemPedidoNF.CalcularComissaoValor;
begin
  if EditPercComissao.asFloat > 0 then
    EditValorComissao.asFloat := RoundTo(((EditValorTotalVenda.asFloat * EditQuantPedida.asFloat)  * (EditPercComissao.asFloat / 100)),-2)
  else
    EditValorComissao.asFloat  := 0;
end;

procedure TFormManutencaoItemPedidoNF.EditPercComissaoExit(
  Sender: TObject);
begin
  inherited;
  CalcularComissaoValor;
end;

procedure TFormManutencaoItemPedidoNF.ck_alterar_comissaoClick(
  Sender: TObject);
begin
  inherited;
  EditValorComissao.Enabled  := (ck_alterar_comissao.Checked);
  EditPercComissao.Enabled   := (ck_alterar_comissao.Checked);
  if ck_alterar_comissao.Checked then
  begin
    CalcularComissaoValor;
    if EditPercComissao.CanFocus then
      EditPercComissao.SetFocus;
  end
  else
    CalcularComissaoIndividual;
  Edt_FlagComissaoAlterada.asInteger := IfThen((ck_alterar_comissao.Checked),1,0);
end;

procedure TFormManutencaoItemPedidoNF.Setar_FlagOK;
begin
  if ck_alterar_comissao.Checked then
    EditOK.asInteger := 1
  else
    EditOK.asInteger := IfThen((EditDiferenca.asFloat = 0),1,0);
end;


end.
