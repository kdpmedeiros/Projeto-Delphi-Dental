unit uFormProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormModelo, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids,
  DBGrids, StdCtrls, Buttons, ExtCtrls, DBXpress, SqlTimSt, math, TAdvEditP,
  ppDB, ppDBPipe, ppCtrls, ppBands, ppClass, ppVar, ppPrnabl, ppCache,
  ppComm,  ppRelatv, ppProd, ppReport, ppModule, raCodMod, ImgList;

type                                                                  
  TFormProdutos = class(TFormModelo)
    ppReportListaPorProdutos: TppReport;                                     
    CDSRelListaPreco: TClientDataSet;                               
    DS_RelListaPreco: TDataSource;
    CDSRelListaPrecoDESCRICAO: TStringField;
    CDSRelListaPrecoGRUPO: TStringField;
    CDSRelListaPrecoVALORVENDA: TFMTBCDField;
    CDSRelListaPrecoVALORVENDAFRETE: TFMTBCDField;
    CDSRelListaPrecoCODGRUPO: TFMTBCDField;
    CDSRelListaPrecoCODPRODUTO: TFMTBCDField;
    Panel2: TPanel;
    CDSClassificacao: TClientDataSet;
    DS_Classificacao: TDataSource;
    CDSRelListaPrecoPRODUTOTRATADO: TStringField;
    ppDBPipelineListaPorProdutos: TppDBPipeline;
    ppDBPipelineListaPorProdutosppField1: TppField;
    ppDBPipelineListaPorProdutosppField2: TppField;
    ppDBPipelineListaPorProdutosppField4: TppField;
    ppDBPipelineListaPorProdutosppField5: TppField;
    ppDBPipelineListaPorProdutosppField6: TppField;
    ppDBPipelineListaPorProdutosppField7: TppField;
    ppDBPipelineListaPorProdutosppField3: TppField;
    ppHeaderBand2: TppHeaderBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppSystemVariable4: TppSystemVariable;
    ppSystemVariable5: TppSystemVariable;
    ppLabel5: TppLabel;
    ppSystemVariable6: TppSystemVariable;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppDetailBand2: TppDetailBand;
    ppLabel8: TppLabel;
    ppDBText1: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppLabel9: TppLabel;
    ppColumnFooterBand1: TppColumnFooterBand;
    ppFooterBand2: TppFooterBand;
    ppLabel10: TppLabel;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppGroupFooterBand2: TppGroupFooterBand;
    raCodeModule2: TraCodeModule;
    Imagens: TImageList;
    PnlBotoesPrin: TPanel;
    BitBtnExcluirPrin: TSpeedButton;
    BitBtnAlterarPrin: TSpeedButton;
    BitBtnIncluirPrin: TSpeedButton;
    pnl_class: TPanel;
    Panel5: TPanel;
    DBGridClassificacao: TDBGrid;
    sb_zerar_estoque_class: TSpeedButton;
    sp_zerar_estoque_prod: TSpeedButton;
    sb_zerar_estoque_geral: TSpeedButton;
    LabelInserirClass: TLabel;
    ppDBProdutos: TppDBPipeline;
    ppField1: TppField;
    ppField2: TppField;
    ppField3: TppField;
    ppField4: TppField;
    ppDBPipeline1ppField1: TppField;
    ppDBPipeline1ppField2: TppField;
    ppDBPipeline1ppField3: TppField;
    ppDBPipeline1ppField4: TppField;
    ppRelProdutos: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel11: TppLabel;
    ppSystemVariable3: TppSystemVariable;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel23: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText4: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppLabel24: TppLabel;
    ppVarTotalPag: TppVariable;
    ppLabel58: TppLabel;
    ppDBTotalGeral: TppDBCalc;
    ppLabelTotalGeral: TppLabel;
    raCodeModule1: TraCodeModule;
    procedure FormShow(Sender: TObject);
    procedure BitBtnIncluirClick(Sender: TObject);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure CDSPrincipalAfterOpen(DataSet: TDataSet);
    procedure BitBtnImprimirClick(Sender: TObject);
    procedure CDSPrincipalAfterScroll(DataSet: TDataSet);
    procedure BitBtnIncluirPrinClick(Sender: TObject);
    procedure BitBtnAlterarPrinClick(Sender: TObject);
    procedure BitBtnExcluirPrinClick(Sender: TObject);
    procedure DBGridPrinDblClick(Sender: TObject);
    procedure DBGridClassificacaoDblClick(Sender: TObject);
    procedure DBGridClassificacaoTitleClick(Column: TColumn);
    procedure DBGridPrinCellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure DBGridPrinDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure sp_zerar_estoque_prodClick(Sender: TObject);
    procedure sb_zerar_estoque_classClick(Sender: TObject);
    procedure sb_zerar_estoque_geralClick(Sender: TObject);
    procedure CDSClassificacaoAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ppFooterBand1BeforePrint(Sender: TObject);
    procedure ppDBText13Print(Sender: TObject);
    private
    { Private declarations }
    CodGrupoLoc, CodProdutoLoc, Expandido  : Integer;    
    procedure ApagarProdutoPrin;
    procedure MostrarDadosProdutos;
    procedure MostrarDadosRelListaPreco;
    procedure MontarRelatorioProdutos;
    procedure MontarRelatorioProdutosPorLista;
    function  VerificaPendenciasProduto(CDSVerificar : TClientDataset) : Boolean;
    procedure MostrarDadosClassificacoes;
    procedure ApagarProdutoFilho;
    procedure FiltrarClassificacoes;
    procedure OcultarClassificacao;
    procedure ZerarEstoque(CDSConteudo : TClientDataset);
    procedure ZerarEstoqueGeral;
  public
    { Public declarations }
  end;

var
  FormProdutos: TFormProdutos;

implementation

uses uFormManutencaoProdutos, uDataModule, uRelatorioModelo,
  uFormTipoRelatorio, uFuncoes;

{$R *.dfm}

procedure TFormProdutos.FormShow(Sender: TObject);
begin
  inherited;
  MostrarDadosProdutos;

  VerifPermissoes;
  if DataModulePrin.SQLQueryPesquisa.Locate('NomeForm','FormProdutos',[]) then
  begin
    BitBtnIncluirPrin.Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('Inserir').asInteger = 1);
    BitBtnAlterarPrin.Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('Alterar').asInteger = 1);
    BitBtnExcluirPrin.Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('Excluir').asInteger = 1);
    LabelInserirClass.Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('Inserir').asInteger = 1);
  end;

  VerifPermissoesExtras(3);
  sb_zerar_estoque_geral.Enabled  := (DataModulePrin.SQLQueryPesquisa.FieldByName('FlagSimNao').asInteger = 1);
  sp_zerar_estoque_prod.Enabled   := (DataModulePrin.SQLQueryPesquisa.FieldByName('FlagSimNao').asInteger = 1);
  sb_zerar_estoque_class.Enabled  := (DataModulePrin.SQLQueryPesquisa.FieldByName('FlagSimNao').asInteger = 1);


  ComboBoxTipoPesquisa.ItemIndex := ComboBoxTipoPesquisa.Items.IndexOf('Descrição');  
end;

procedure TFormProdutos.BitBtnIncluirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormManutencaoProdutos, FormManutencaoProdutos);
    FormManutencaoProdutos.InicializaTela(1, CDSClassificacao);
    FormManutencaoProdutos.TipoProduto := 2;    
    FormManutencaoProdutos.ShowModal;
  Finally
    if FormManutencaoProdutos.HouveAlteracao then
    begin
      MostrarDadosProdutos;
      CDSPrincipal.Locate('CodGrupo;Codigo',
      VarArrayof([FormManutencaoProdutos.FrameGrupos.EditCodigo.asInteger,
                  FormManutencaoProdutos.FrameProdutos.EditCodigo.asInteger]),[]);
      CDSClassificacao.Locate('Classificacao',FormManutencaoProdutos.EditClassificacao.Text,[]);
    end;  
    FormManutencaoProdutos.Free;
  end;
end;

procedure TFormProdutos.BitBtnAlterarClick(Sender: TObject);
begin
  inherited;
  if (not CDSClassificacao.Active) or (CDSClassificacao.IsEmpty) Then
    Exit;

  Try
    Application.CreateForm(TFormManutencaoProdutos, FormManutencaoProdutos);
    FormManutencaoProdutos.InicializaTela(2, CDSClassificacao);
    FormManutencaoProdutos.TipoProduto := 2;    
    FormManutencaoProdutos.ShowModal;
  Finally
    if FormManutencaoProdutos.HouveAlteracao then
    begin
      MostrarDadosProdutos;
      CDSPrincipal.Locate('CodGrupo;Codigo',
      VarArrayof([FormManutencaoProdutos.FrameGrupos.EditCodigo.asInteger,
                  FormManutencaoProdutos.FrameProdutos.EditCodigo.asInteger]),[]);

      CDSClassificacao.Locate('Classificacao',FormManutencaoProdutos.EditClassificacao.Text,[]);
    end;  
    FormManutencaoProdutos.Free;
  end;
end;

procedure TFormProdutos.ApagarProdutoPrin;
Var TransDesc : TTransactionDesc;
    BM : TBookMark;
begin
  if VerificaPendenciasProduto(CDSPrincipal) then
    Exit;

  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);
      With SQLQueryExecuta do
      begin
        SQL.Clear;
        SQL.Add(' DELETE FROM ESTOQUEPRODUTOS');
        SQL.Add(' WHERE CODPRODUTO    = :CODPRODUTO');
        SQL.Add('   AND CODGRUPO      = :CODGRUPO');
        ParamByName('CodProduto').asFloat := CDSPrincipal.FieldByName('Codigo').asFloat;
        ParamByName('CodGrupo').asFloat   := CDSPrincipal.FieldByName('CodGrupo').asFloat;
        ExecSQL;

        SQL.Clear;
        SQL.Add(' DELETE FROM PRODUTOS');
        SQL.Add(' WHERE CODIGO        = :CODIGO');
        SQL.Add('   AND CODGRUPO      = :CODGRUPO');
        ParamByName('Codigo').asFloat        := CDSPrincipal.FieldByName('Codigo').asFloat;
        ParamByName('CodGrupo').asFloat      := CDSPrincipal.FieldByName('CodGrupo').asFloat;
        ExecSQL;

        CDSPrincipal.Prior;
        BM := CDSPrincipal.GetBookMark;
        SQLConnectionPrin.Commit(TransDesc);
        MostrarDadosProdutos;
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


procedure TFormProdutos.BitBtnExcluirClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    Exit;

  If Application.MessageBox('Deseja Realmente Excluir o Produto Selecionado?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
   ApagarProdutoFilho;

end;

procedure TFormProdutos.CDSPrincipalAfterOpen(DataSet: TDataSet);
begin
  with CDSPrincipal do
  begin
    FieldByName('CODIGO').DisplayLabel          := 'Código';
    FieldByName('CODGRUPO').DisplayLabel        := 'Grupo';
    FieldByName('DESCRICAO').DisplayLabel       := 'Descrição';
    FieldByName('UNIDADE').DisplayLabel         := 'Unid';
    FieldByName('VALORVENDA').DisplayLabel      := 'Vlr Venda';
    FieldByName('VALORVENDAFRETE').DisplayLabel := 'Vlr Total Venda';
    FieldByName('ESTOQUE').DisplayLabel         := 'Estoque Atual';
    FieldByName('FIGURA').DisplayLabel          := 'Ver';
    FieldByName('LOCALIZACAO').DisplayLabel     := 'Local';    

    (FieldByName('VALORVENDA') as TNumericField).DisplayFormat      := '#,##0.00';                                             
    (FieldByName('VALORVENDAFRETE') as TNumericField).DisplayFormat := '#,##0.00';
    (FieldByName('ESTOQUE') as TNumericField).DisplayFormat         := '#,##0.00';


    FieldByName('CODLISTAPRECO').Visible       := False;
    FieldByName('CODFORNECEDOR').Visible       := False;
    FieldByName('CLASSIFICACAO').Visible       := False;
    FieldByName('TemClass').Visible            := False;
    FieldByName('ExibindoClass').Visible       := False;
    FieldByName('ValorCusto').Visible          := False;
    FieldByName('ValorTotal').Visible          := False;
    FieldByName('GRUPO').Visible               := False;


    FieldByName('CODIGO').DisplayWidth          := 8;
    FieldByName('CODGRUPO').DisplayWidth        := 8;
    FieldByName('DESCRICAO').DisplayWidth       := 50;
    FieldByName('UNIDADE').DisplayWidth         := 5;
    FieldByName('VALORVENDA').DisplayWidth      := 12;
    FieldByName('VALORVENDAFRETE').DisplayWidth := 12;
    FieldByName('ESTOQUE').DisplayWidth         := 10;


  end;
  inherited;
end;

procedure TFormProdutos.BitBtnImprimirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormTipoRelatorio, FormTipoRelatorio);
    with FormTipoRelatorio do
    begin
      AdicionarTipo('Produtos');
      AdicionarTipo('Produtos por Lista de Preço');
      ShowModal;
      if MrOk then
      begin
        if RadioGroupTipoRelatorio.ItemIndex = 0 then
          MontarRelatorioProdutos
        else if RadioGroupTipoRelatorio.ItemIndex = 1 then
          MontarRelatorioProdutosPorLista;
      end;
    end;
  Finally
    CDSPrincipal.First;
    FormTipoRelatorio.Free;
  end;
end;

procedure TFormProdutos.MostrarDadosProdutos;
begin
  Screen.Cursor := crHourGlass;
  with CDSPrincipal do
  begin                                                    
    DisableControls;
    SQL.Clear;
    SQL.Add(' Select Prod.CODGRUPO, Prod.CODIGO, Prod.DESCRICAO, ');
    SQL.Add('        Prod.UNIDADE, Prod.Localizacao, LP.ValorVenda, Lp.ValorVendaFrete, Lp.ValorCusto, Ep.Quantidade as Estoque,');
    SQL.Add('        (Lp.ValorCusto * Ep.Quantidade) as ValorTotal, G.DESCRICAO as GRUPO,');
    SQL.Add('        Prod.Classificacao,Prod.CodFornecedor,Prod.CODLISTAPRECO,');
    SQL.Add('        (Select Count(*) from Produtos ProdI where ProdI.Codigo   = Prod.Codigo');
    SQL.Add('                                             and ProdI.CodGrupo = Prod.CodGrupo');
    SQL.Add('                                             and ProdI.Classificacao <> '''') as TemClass,');
    SQL.Add('        Cast(0 as SmallInt) as ExibindoClass, cast('''' as char(1)) as Figura ');
    SQL.Add(' from Produtos Prod');
    SQL.Add(' Left Join ListaPreco   Lp on LP.Codigo = Prod.CodListaPreco ');
    SQL.Add(' Left Join Fornecedores F  on F.Codigo  = Prod.CodFornecedor ');
    SQL.Add(' Left Join Grupos       G  on G.Codigo  = Prod.CODGRUPO ');
    SQL.Add(' Left Join EstoqueProdutos Ep on Ep.CodProduto    = Prod.Codigo  ');
    SQL.Add('                             and Ep.CodGrupo      = Prod.CodGrupo');
    SQL.Add('                             and Ep.Classificacao = Prod.Classificacao');
    SQL.Add(' where Prod.Classificacao = ''''');
    SQL.Add('Order by Prod.Descricao');
    Close;
    CommandText := SQL.Text;
    TratarClientDatasetParaPost(CDSPrincipal);

    MostrarDadosClassificacoes;       

    if (CodGrupoLoc <> 0) and (CodProdutoLoc <> 0) then
    begin
      if Locate('CodGrupo;Codigo',Vararrayof([CodGrupoLoc,CodProdutoLoc]),[]) then
      begin
        Edit;
        FieldByname('ExibindoClass').AsInteger := Expandido;
        Post;

        pnl_class.Visible      := (FieldByname('ExibindoClass').AsInteger = 1);
        BitBtnIncluir.Visible  := (FieldByname('ExibindoClass').AsInteger = 1);
        BitBtnAlterar.Visible  := (FieldByname('ExibindoClass').AsInteger = 1);
        BitBtnExcluir.Visible  := (FieldByname('ExibindoClass').AsInteger = 1);
        sb_zerar_estoque_class.Visible  := (FieldByname('ExibindoClass').AsInteger = 1);
      end;  
    end
    else
    begin
      pnl_class.Visible      := False;
      BitBtnIncluir.Visible  := False;
      BitBtnAlterar.Visible  := False;
      BitBtnExcluir.Visible  := False;
      sb_zerar_estoque_class.Visible  := False;
    end;                                     

    EnableControls;
  end;
  Screen.Cursor := crDefault;  
end;


procedure TFormProdutos.MostrarDadosRelListaPreco;
begin
  with CDSRelListaPreco do
  begin
    SQL.Clear;
    SQL.Add(' Select Prod.CODGRUPO, G.Descricao as Grupo, Prod.CODIGO AS CODPRODUTO, ');
    SQL.Add('        Prod.DESCRICAO,  LP.ValorVenda, Lp.ValorVendaFrete,');
    SQL.Add('        (Cast(Prod.CodGrupo as varchar(6)) || ''.'' || Cast(Prod.Codigo as varchar(8))) as ProdutoTratado');
    SQL.Add(' from Produtos Prod');
    SQL.Add(' Left Join ListaPreco Lp on LP.Codigo = Prod.CodListaPreco ');     
    SQL.Add(' Left Join Grupos     G  on G.Codigo  = Prod.CodGrupo      ');
    SQL.Add(' where Prod.CLASSIFICACAO = ''''');
    SQL.Add('Order by G.Descricao, Prod.CodGrupo, Prod.DESCRICAO');
    Close;
    CommandText := SQL.Text;
    Open;
  end;                                                                
end;                                                                

procedure TFormProdutos.MontarRelatorioProdutos;                                                                          
begin
  ppRelProdutos.Print;
{  Try
    Application.CreateForm(TFormRelatorioModelo, FormRelatorioModelo);
    with FormRelatorioModelo do
    begin
      DS_Principal.DataSet := Self.CDSPrincipal;
      MontaRelatorio;
      ppLabelDescricaoRel.Caption := 'Relatório de Produtos';
      ppRelatorio.Print;
    end;
  Finally
    CDSPrincipal.First;
    FormRelatorioModelo.Free;
  end;   }
end;

procedure TFormProdutos.MontarRelatorioProdutosPorLista;
begin
  MostrarDadosRelListaPreco;
  ppReportListaPorProdutos.Print;        
end;

function TFormProdutos.VerificaPendenciasProduto(CDSVerificar : TClientDataset) : Boolean;
begin
  Result := False;
  with DataModulePrin.SQLQueryPesquisa do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' select Ipn.CodPedidoNF from ItemPedidoNota Ipn ');
    SQL.Add(' WHERE Ipn.CODPRODUTO    = :CODPRODUTO');
    SQL.Add('   AND Ipn.CODGRUPO      = :CODGRUPO');
    SQL.Add('   AND Ipn.CLASSIFICACAO = :CLASSIFICACAO');
    ParamByName('CodProduto').asFloat     := CDSVerificar.FieldByName('Codigo').asFloat;
    ParamByName('CodGrupo').asFloat       := CDSVerificar.FieldByName('CodGrupo').asFloat;
    ParamByName('Classificacao').asString := CDSVerificar.FieldByName('Classificacao').asString;
    Open;   

    if not IsEmpty then
    begin
      Application.MessageBox(PChar('O Produto não poderá ser excluído pois está ligado ao Pedido / Nota Fiscal de N.º ' +  FieldByName('CodPedidoNF').asString + '!'),'Informação',0);
      Result := True;
    end;
  end;
end;


procedure TFormProdutos.MostrarDadosClassificacoes;
begin
  with CDSClassificacao do
  begin
    SQL.Clear;
    SQL.Add(' Select Prod.CODGRUPO, Prod.CODIGO, Prod.DESCRICAO, ');
    SQL.Add('        Prod.UNIDADE, Prod.Localizacao, LP.ValorVenda, Lp.ValorVendaFrete, Ep.Quantidade as Estoque,');
    SQL.Add('        Prod.Classificacao,Prod.CodFornecedor,Prod.CODLISTAPRECO ');
    SQL.Add(' from Produtos Prod');
    SQL.Add(' Left Join ListaPreco   Lp on LP.Codigo = Prod.CodListaPreco ');
    SQL.Add(' Left Join Fornecedores F  on F.Codigo  = Prod.CodFornecedor ');
    SQL.Add(' Left Join EstoqueProdutos Ep on Ep.CodProduto    = Prod.Codigo  ');
    SQL.Add('                             and Ep.CodGrupo      = Prod.CodGrupo');
    SQL.Add('                             and Ep.Classificacao = Prod.Classificacao');
    SQL.Add(' where Prod.Classificacao <> ''''');
    SQL.Add('Order By Prod.CODGRUPO,Prod.CODIGO');
    Close;
    CommandText := SQL.Text;
    TratarClientDatasetParaPost(CDSClassificacao);


  end;
end;




procedure TFormProdutos.CDSPrincipalAfterScroll(DataSet: TDataSet);
begin
  inherited;
  FiltrarClassificacoes;
end;

procedure TFormProdutos.BitBtnIncluirPrinClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormManutencaoProdutos, FormManutencaoProdutos);
    FormManutencaoProdutos.InicializaTela(1, CDSPrincipal);
    FormManutencaoProdutos.TipoProduto := 1;
    FormManutencaoProdutos.ShowModal;
  Finally
    if FormManutencaoProdutos.HouveAlteracao then
    begin
      MostrarDadosProdutos;
      CDSPrincipal.Locate('CodGrupo;Codigo;Classificacao',
      VarArrayof([FormManutencaoProdutos.s_cod_grupo,
                  FormManutencaoProdutos.s_cod_produto,
                  FormManutencaoProdutos.s_cod_classificacao]),[]);
    end;
    FormManutencaoProdutos.Free;
  end;
end;

procedure TFormProdutos.BitBtnAlterarPrinClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) Then
    Exit;

  Try
    Application.CreateForm(TFormManutencaoProdutos, FormManutencaoProdutos);
    FormManutencaoProdutos.InicializaTela(2, CDSPrincipal);
    FormManutencaoProdutos.TipoProduto := 1;    
    FormManutencaoProdutos.ShowModal;
  Finally
    if FormManutencaoProdutos.HouveAlteracao then
    begin
      MostrarDadosProdutos;
      CDSPrincipal.Locate('CodGrupo;Codigo;Classificacao',
      VarArrayof([FormManutencaoProdutos.s_cod_grupo,
                  FormManutencaoProdutos.s_cod_produto,
                  FormManutencaoProdutos.s_cod_classificacao]),[]);

    end;              
    FormManutencaoProdutos.Free;
  end;
end;

procedure TFormProdutos.BitBtnExcluirPrinClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    Exit;

  If Application.MessageBox('Deseja Realmente Excluir o Produto Selecionado e Todas as Suas Classificações?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
    ApagarProdutoPrin;
end;

procedure TFormProdutos.ApagarProdutoFilho;
Var TransDesc : TTransactionDesc;
    BM : TBookMark;
    GrupoAnt, ProdutoAnt : Integer;
begin
  if VerificaPendenciasProduto(CDSClassificacao) then
    Exit;

  GrupoAnt   := CDSPrincipal.FieldByName('CodGrupo').asInteger;
  ProdutoAnt := CDSPrincipal.FieldByName('Codigo').asInteger;
  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);
      With SQLQueryExecuta do
      begin
        SQL.Clear;
        SQL.Add(' DELETE FROM ESTOQUEPRODUTOS');
        SQL.Add(' WHERE CODPRODUTO    = :CODPRODUTO');
        SQL.Add('   AND CODGRUPO      = :CODGRUPO');
        SQL.Add('   AND CLASSIFICACAO = :CLASSIFICACAO');
        ParamByName('CodProduto').asFloat := CDSClassificacao.FieldByName('Codigo').asFloat;
        ParamByName('CodGrupo').asFloat   := CDSClassificacao.FieldByName('CodGrupo').asFloat;
        ParamByName('Classificacao').asString := CDSClassificacao.FieldByName('Classificacao').asString;
        ExecSQL;

        SQL.Clear;
        SQL.Add(' DELETE FROM PRODUTOS');
        SQL.Add(' WHERE CODIGO        = :CODIGO');
        SQL.Add('   AND CODGRUPO      = :CODGRUPO');
        SQL.Add('   AND CLASSIFICACAO = :CLASSIFICACAO');
        ParamByName('Codigo').asFloat         := CDSClassificacao.FieldByName('Codigo').asFloat;
        ParamByName('CodGrupo').asFloat       := CDSClassificacao.FieldByName('CodGrupo').asFloat;
        ParamByName('Classificacao').asString := CDSClassificacao.FieldByName('Classificacao').asString;
        ExecSQL;

        CDSClassificacao.Prior;
        BM := CDSClassificacao.GetBookMark;
        SQLConnectionPrin.Commit(TransDesc);
        MostrarDadosProdutos;
        CDSPrincipal.Locate('CodGrupo;Codigo', VarArrayof([GrupoAnt,ProdutoAnt]),[]);
        Try
          CDSClassificacao.GotoBookmark(BM);
          CDSClassificacao.FreeBookmark(BM);
        except
          CDSClassificacao.FreeBookmark(BM);
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


procedure TFormProdutos.DBGridPrinDblClick(Sender: TObject);
begin
  BitBtnAlterarPrin.OnClick(BitBtnAlterarPrin);
end;

procedure TFormProdutos.DBGridClassificacaoDblClick(Sender: TObject);
begin
  inherited;
  BitBtnAlterar.OnClick(BitBtnAlterar);
end;

procedure TFormProdutos.FiltrarClassificacoes;
begin
  if (CDSPrincipal.Active = False) or (CDSPrincipal.IsEmpty) then
    Exit;

  with CDSClassificacao do
  begin
    if (not CDSPrincipal.IsEmpty) and
       (CDSPrincipal.FieldByName('CodGrupo').asString <> '') and
       (CDSPrincipal.FieldByName('Codigo').asString <> '') then
    begin
      Filter   := ' CodGrupo   = ' + CDSPrincipal.FieldByName('CodGrupo').asString +
                  ' and Codigo = ' + CDSPrincipal.FieldByName('Codigo').asString;
    end
    else
      Filter   := ' CodGrupo   = 0 and Codigo = 0';
    Filtered := True;
  end;
end;

procedure TFormProdutos.DBGridClassificacaoTitleClick(Column: TColumn);
Var i : Integer;
begin
 if (not CDSClassificacao.Active) or (CDSClassificacao.IsEmpty) then
    Exit;

  if (Column.FieldName = '') then
    Exit;

  if CDSClassificacao.IndexFieldNames = '' then
    CDSClassificacao.IndexFieldNames := Column.FieldName
  else
  begin
    CDSClassificacao.IndexDefs.Clear;
    CDSClassificacao.IndexDefs.Add('idx' + Column.FieldName, Column.FieldName, [ixDescending]);
    CDSClassificacao.IndexName :=  'idx' + Column.FieldName;
  end;

  for I := 0 to DBGridClassificacao.Columns.Count - 1 do
    DBGridClassificacao.Columns[I].Title.Font.Style := [];

  Column.Title.Font.Style := [fsBold];

end;

procedure TFormProdutos.DBGridPrinCellClick(Column: TColumn);
begin
  inherited;
  if (Column.Index = 8) then
  begin
    if (not CDSPrincipal.FieldByName('TemClass').IsNull) and (CDSPrincipal.FieldByName('TemClass').asInteger > 0) then
    begin
      OcultarClassificacao;

      with CDSPrincipal do
      begin
        Edit;
        FieldByname('ExibindoClass').AsInteger := Ifthen(FieldByname('ExibindoClass').AsInteger = 0,1,0);
        Post;

        pnl_class.Visible      := (FieldByname('ExibindoClass').AsInteger = 1);
        BitBtnIncluir.Visible  := (FieldByname('ExibindoClass').AsInteger = 1);
        BitBtnAlterar.Visible  := (FieldByname('ExibindoClass').AsInteger = 1);
        BitBtnExcluir.Visible  := (FieldByname('ExibindoClass').AsInteger = 1);
        sb_zerar_estoque_class.Visible  := (FieldByname('ExibindoClass').AsInteger = 1);

        if pnl_class.Visible then
          DBGridClassificacao.SetFocus
        else
          DBGridPrin.SetFocus;
      end;
    end;
  end;

end;

procedure TFormProdutos.OcultarClassificacao;
Var BM : TBookMark;
    CodGrupoMarc, CodProdutoMarc : Integer;
begin
  with CDSPrincipal do
  begin
    BM := GetBookMark;
    CodGrupoMarc   := FieldByname('CodGrupo').asInteger;
    CodProdutoMarc := FieldByname('Codigo').asInteger;
    DisableControls;
    AfterScroll := nil;
    First;
    while not EOF do
    begin
      if (FieldByname('ExibindoClass').AsInteger = 1) and
         ((CodGrupoMarc <> FieldByname('CodGrupo').asInteger) or
          (CodProdutoMarc <> FieldByname('Codigo').asInteger)) then
      begin
        Edit;
        FieldByname('ExibindoClass').AsInteger := 0;
        Post;
      end;         
      Next;
    end;
    Try
      GotoBookMark(BM);
      FreeBookMark(BM);
    Except
      FreeBookMark(BM);
    end;
    EnableControls;
    CDSPrincipal.AfterScroll := CDSPrincipalAfterScroll;
  end;

end;


procedure TFormProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  CodGrupoLoc          := 0;
  CodProdutoLoc        := 0;
  Expandido            := 0;

end;

procedure TFormProdutos.DBGridPrinDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if (Column.Index = 8) then
  begin
    if (not CDSPrincipal.FieldByName('TemClass').IsNull) and (CDSPrincipal.FieldByName('TemClass').asInteger > 0) then
       Imagens.Draw(DBGridPrin.Canvas,Rect.left,Rect.top,CDSPrincipal.FieldByName('ExibindoClass').asInteger);
  end;
end;

procedure TFormProdutos.ZerarEstoque(CDSConteudo : TClientDataset);
Var TransDesc : TTransactionDesc;
    BM : TBookMark;
begin
  if (CDSConteudo.IsEmpty) or
     (CDSConteudo.Active = False) then
    Exit;

  If Application.MessageBox('Deseja Realmente Zerar o Estoque do Produto Selecionado?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idNo then
    Exit;

  BM := CDSConteudo.GetBookMark;
  Try
    TransDesc.TransactionID  := 1;
    TransDesc.IsolationLevel := xilREADCOMMITTED;
    DataModulePrin.SQLConnectionPrin.StartTransaction(TransDesc);
    with DataModulePrin.SQLQueryExecuta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' Update EstoqueProdutos');
      SQL.Add(' Set ');
      SQL.Add('   QUANTIDADE     = 0, ');
      SQL.Add('   QUANTIDADEMAX  = 0, ');
      SQL.Add('   QUANTIDADEMED  = 0, ');
      SQL.Add('   QUANTIDADEMIN  = 0, ');
      SQL.Add('   QUANTENTRADA   = 0  ');
      SQL.Add(' where CODPRODUTO    = :CODPRODUTO');
      SQL.Add('   and CODGRUPO      = :CODGRUPO');
      SQL.Add('   and CLASSIFICACAO = :CLASSIFICACAO');

      ParambyName('CODPRODUTO').asFloat     := CDSConteudo.FieldByname('CODIGO').asFloat;
      ParambyName('CODGRUPO').asFloat       := CDSConteudo.FieldByname('CODGRUPO').asFloat;
      ParambyName('CLASSIFICACAO').asString := CDSConteudo.FieldByname('CLASSIFICACAO').asString;
      ExecSQL;
      DataModulePrin.SQLConnectionPrin.Commit(TransDesc);
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Zerar o Estoque. Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
  CDSConteudo.Close;
  TratarClientDatasetParaPost(CDSConteudo);


  Try
    CDSConteudo.GotoBookMark(BM);
    CDSConteudo.FreeBookmark(BM);
  Except
    CDSConteudo.FreeBookmark(BM);
  end;
end;


procedure TFormProdutos.sp_zerar_estoque_prodClick(Sender: TObject);
begin
  inherited;
  ZerarEstoque(CDSPrincipal);
  with CDSPrincipal do
  begin
    MostrarDadosClassificacoes;

    if (CodGrupoLoc <> 0) and (CodProdutoLoc <> 0) then
    begin
      if Locate('CodGrupo;Codigo',Vararrayof([CodGrupoLoc,CodProdutoLoc]),[]) then
      begin
        Edit;
        FieldByname('ExibindoClass').AsInteger := Expandido;
        Post;

        pnl_class.Visible      := (FieldByname('ExibindoClass').AsInteger = 1);
        BitBtnIncluir.Visible  := (FieldByname('ExibindoClass').AsInteger = 1);
        BitBtnAlterar.Visible  := (FieldByname('ExibindoClass').AsInteger = 1);
        BitBtnExcluir.Visible  := (FieldByname('ExibindoClass').AsInteger = 1);
        sb_zerar_estoque_class.Visible  := (FieldByname('ExibindoClass').AsInteger = 1);
      end;  
    end
    else
    begin
      pnl_class.Visible      := False;
      BitBtnIncluir.Visible  := False;
      BitBtnAlterar.Visible  := False;
      BitBtnExcluir.Visible  := False;
      sb_zerar_estoque_class.Visible  := False;
    end;
  end;  

end;

procedure TFormProdutos.sb_zerar_estoque_classClick(Sender: TObject);
begin
  inherited;
  ZerarEstoque(CDSClassificacao);
end;

procedure TFormProdutos.ZerarEstoqueGeral;
Var TransDesc : TTransactionDesc;
begin
  If Application.MessageBox('Deseja Realmente Zerar o Estoque de TODOS os Produtos e suas Classificações?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idNo then
    Exit;

  Try
    TransDesc.TransactionID  := 1;
    TransDesc.IsolationLevel := xilREADCOMMITTED;
    DataModulePrin.SQLConnectionPrin.StartTransaction(TransDesc);
    with DataModulePrin.SQLQueryExecuta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' Update EstoqueProdutos');
      SQL.Add(' Set ');
      SQL.Add('   QUANTIDADE     = 0, ');
      SQL.Add('   QUANTIDADEMAX  = 0, ');
      SQL.Add('   QUANTIDADEMED  = 0, ');
      SQL.Add('   QUANTIDADEMIN  = 0, ');
      SQL.Add('   QUANTENTRADA   = 0  ');
      ExecSQL;
      DataModulePrin.SQLConnectionPrin.Commit(TransDesc);
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Zerar o Estoque Geral. Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
  MostrarDadosProdutos;
  MostrarDadosClassificacoes;
end;


procedure TFormProdutos.sb_zerar_estoque_geralClick(Sender: TObject);
begin
  inherited;
  ZerarEstoqueGeral;
end;

procedure TFormProdutos.CDSClassificacaoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  with CDSClassificacao do
  begin
    IndexFieldNames := 'CLASSIFICACAO';

    (FieldByName('ESTOQUE') as TNumericField).DisplayFormat  := '#,##0.00';

    FiltrarClassificacoes;
  end;
end;

procedure TFormProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_F7) and (BitBtnIncluir.Enabled) then
    BitBtnIncluirClick(BitBtnIncluir);
end;

procedure TFormProdutos.ppFooterBand1BeforePrint(Sender: TObject);
begin
  inherited;
  if ppRelProdutos.Page = ppRelProdutos.PageCount then
  begin
    ppLabelTotalGeral.Visible := True;
    ppDBTotalGeral.Visible    := True;
  end
  else
  begin
    ppLabelTotalGeral.Visible := False;
    ppDBTotalGeral.Visible    := False;
  end;
end;

procedure TFormProdutos.ppDBText13Print(Sender: TObject);
begin
  inherited;
  ppVarTotalPag.Value := ppVarTotalPag.Value + ppDBText13.FieldValue; 
end;

end.
                                                                                                                                                 
