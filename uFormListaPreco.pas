unit uFormListaPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormModelo, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids,
  DBGrids, StdCtrls, Buttons, ExtCtrls, DBXpress, SqlTimSt, math, TAdvEditP,
  ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppClass, ppReport, ppBands,
  ppCache, ppVar, ppCtrls, ppPrnabl;

type
  TFormListaPreco = class(TFormModelo)
    CDSListaPrecoProdutos: TClientDataSet;
    DS_ListaPrecoProdutos: TDataSource;
    CDSListaPrecoProdutosCodLista: TFMTBCDField;
    CDSListaPrecoProdutosCodGrupo: TFMTBCDField;
    CDSListaPrecoProdutosCodProduto: TFMTBCDField;
    CDSListaPrecoProdutosClassificacao: TStringField;
    CDSListaPrecoProdutosDescrProduto: TStringField;
    CDSListaPrecoProdutosDescricao: TStringField;
    CDSListaPrecoProdutosDescrGrupo: TStringField;
    CDSListaPrecoProdutosValorVenda: TFMTBCDField;
    procedure FormShow(Sender: TObject);
    procedure BitBtnIncluirClick(Sender: TObject);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure CDSPrincipalAfterOpen(DataSet: TDataSet);
    procedure BitBtnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure Apagar;
    procedure MontarRelatorioListaPrecoProdutos;
    procedure MontarRelatorioListaPreco;
  public
    { Public declarations }
  end;

var
  FormListaPreco: TFormListaPreco;

implementation

uses uFormManutencaoListaPreco, uDataModule, uRelatorioModelo,
  uFormTipoRelatorio, DateUtils;

{$R *.dfm}

procedure TFormListaPreco.FormShow(Sender: TObject);
begin
  inherited;
  MostrarDados('ListaPreco');
end;

procedure TFormListaPreco.BitBtnIncluirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormManutencaoListaPreco, FormManutencaoListaPreco);
    FormManutencaoListaPreco.InicializaTela(1, CDSPrincipal);
    FormManutencaoListaPreco.ShowModal;
  Finally
    MostrarDados('ListaPreco');
    CDSPrincipal.Locate('Codigo',FormManutencaoListaPreco.EditCodigo.asInteger,[]);
    FormManutencaoListaPreco.Free;
  end;
end;

procedure TFormListaPreco.BitBtnAlterarClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) Then
    Exit;

  Try
    Application.CreateForm(TFormManutencaoListaPreco, FormManutencaoListaPreco);
    FormManutencaoListaPreco.InicializaTela(2, CDSPrincipal);
    FormManutencaoListaPreco.ShowModal;
  Finally
    MostrarDados('ListaPreco');
    CDSPrincipal.Locate('Codigo',FormManutencaoListaPreco.EditCodigo.asInteger,[]);    
    FormManutencaoListaPreco.Free;
  end;
end;

procedure TFormListaPreco.Apagar;
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
        SQL.Clear;
        SQL.Add(' DELETE FROM LISTAPRECO');
        SQL.Add(' WHERE CODIGO = :CODIGO');
        ParamByName('Codigo').asFloat := CDSPrincipal.FieldByName('Codigo').asFloat;
        ExecSQL;
        SQLConnectionPrin.Commit(TransDesc);

        MostrarDados('ListaPreco');
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



procedure TFormListaPreco.BitBtnExcluirClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    Exit;
      
  If Application.MessageBox('Deseja Realmente Excluir a Lista de Preço Selecionada?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
    Apagar;
end;

procedure TFormListaPreco.CDSPrincipalAfterOpen(DataSet: TDataSet);
begin
  with CDSPrincipal do
  begin
    FieldByName('CODIGO').DisplayLabel          := 'Código';
    FieldByName('DESCRICAO').DisplayLabel       := 'Descrição';
    FieldByName('VALORCUSTO').DisplayLabel      := 'Valor Custo';
    FieldByName('PERCFRETECOMPRA').DisplayLabel := '% Frete Compra';
    FieldByName('PERCICMS').DisplayLabel        := '% ICMS';
    FieldByName('PERCLUCRO').DisplayLabel       := '% Lucro';
    FieldByName('PERCFRETEVENDA').DisplayLabel  := '% Frete Venda';
    FieldByName('VALORLUCRO').DisplayLabel      := 'Valor Lucro';
    FieldByName('VALORVENDA').DisplayLabel      := 'Valor Venda';
    FieldByName('VALORVENDAFRETE').DisplayLabel := 'Valor Venda + Frete';

    FieldByName('CODIGO').DisplayWidth          := 8;
    FieldByName('DESCRICAO').DisplayWidth       := 30;
    FieldByName('VALORCUSTO').DisplayWidth      := 15;
    FieldByName('PERCFRETECOMPRA').DisplayWidth := 10;
    FieldByName('PERCICMS').DisplayWidth        := 10;
    FieldByName('PERCLUCRO').DisplayWidth       := 10;
    FieldByName('PERCFRETEVENDA').DisplayWidth  := 10;
    FieldByName('VALORLUCRO').DisplayWidth      := 15;
    FieldByName('VALORVENDA').DisplayWidth      := 15;
    FieldByName('VALORVENDAFRETE').DisplayWidth := 15;

    (FieldByName('VALORCUSTO') as TNumericField).DisplayFormat      := '#,##0.00';
    (FieldByName('PERCFRETECOMPRA') as TNumericField).DisplayFormat := '#,##0.00';
    (FieldByName('PERCICMS') as TNumericField).DisplayFormat        := '#,##0.00';
    (FieldByName('PERCLUCRO') as TNumericField).DisplayFormat       := '#,##0.00';
    (FieldByName('PERCFRETEVENDA') as TNumericField).DisplayFormat  := '#,##0.00';
    (FieldByName('VALORLUCRO') as TNumericField).DisplayFormat      := '#,##0.00';
    (FieldByName('VALORVENDA') as TNumericField).DisplayFormat      := '#,##0.00';
    (FieldByName('VALORVENDAFRETE') as TNumericField).DisplayFormat := '#,##0.00';
  end;
  inherited;

end;

procedure TFormListaPreco.BitBtnImprimirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormTipoRelatorio, FormTipoRelatorio);
    with FormTipoRelatorio do
    begin
      AdicionarTipo('Lista de Preço');
      AdicionarTipo('Produtos por Lista Preço');
      ShowModal;
      if MrOk then        
      begin
        if RadioGroupTipoRelatorio.ItemIndex = 0 then
          MontarRelatorioListaPreco
        else if RadioGroupTipoRelatorio.ItemIndex = 1 then
          MontarRelatorioListaPrecoProdutos;
      end;
    end;
  Finally
    CDSPrincipal.First;
    FormTipoRelatorio.Free;
  end;
end;

procedure TFormListaPreco.MontarRelatorioListaPrecoProdutos;
begin
  inherited;
  with CDSListaPrecoProdutos do
  begin
    SQL.Clear;
    SQL.Add('Select Lp.Codigo as CodLista, Prod.CodGrupo, Prod.Codigo as CodProduto,');
    SQL.Add('       Prod.Classificacao, Prod.Descricao as DescrProduto,     ');
    SQL.Add('       Gr.Descricao as DescrGrupo, Lp.Descricao, Lp.ValorVenda ');
    SQL.Add('From ListaPreco Lp');
    SQL.Add('Inner join Produtos Prod on Prod.CodListaPreco = Lp.Codigo');
    SQL.Add('Inner join Grupos   Gr on Prod.CodGrupo = Gr.Codigo');
    SQL.Add('Order by Lp.Codigo, Prod.CodGrupo, Prod.Codigo, Prod.Classificacao');
    Close;
    CommandText := SQL.Text;
    Open;
    First;
  end;


end;

procedure TFormListaPreco.MontarRelatorioListaPreco;
begin
  Try
    Application.CreateForm(TFormRelatorioModelo, FormRelatorioModelo);
    with FormRelatorioModelo do
    begin
      DS_Principal.DataSet := Self.CDSPrincipal;
      MontaRelatorio;
      ppLabelDescricaoRel.Caption := 'Relatório de Lista de Preços';
      ppRelatorio.Print;
    end;
  Finally
    FormRelatorioModelo.Free;
  end;    
end;


end.
