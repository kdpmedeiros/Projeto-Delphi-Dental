unit uFormGruposProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormModelo, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids,
  DBGrids, StdCtrls, Buttons, ExtCtrls, DBXpress, SqlTimSt, math, TAdvEditP,
  ppDB, ppDBPipe, ppCtrls, ppBands, ppClass, ppVar, ppPrnabl, ppCache,
  ppComm, ppRelatv, ppProd, ppReport;

type
  TFormGruposProdutos = class(TFormModelo)
    CDSGrupoProdutos: TClientDataSet;
    CDSGrupoProdutosCodGrupo: TFMTBCDField;
    CDSGrupoProdutosCodProduto: TFMTBCDField;
    CDSGrupoProdutosClassificacao: TStringField;
    CDSGrupoProdutosDescrProduto: TStringField;
    CDSGrupoProdutosDescrGrupo: TStringField;
    DS_GrupoProdutos: TDataSource;
    ppDBPipelineGrupoProdutos: TppDBPipeline;
    ppReportGrupoProdutos: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppShape1: TppShape;
    ppLabelDescricaoRel: TppLabel;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel2: TppLabel;
    ppSystemVariable3: TppSystemVariable;
    ppLabel3: TppLabel;
    ppLblPageCount: TppLabel;
    ppLabel4: TppLabel;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppLabel5: TppLabel;
    ppLabel7: TppLabel;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText5: TppDBText;
    ppLine1: TppLine;
    ppLabel9: TppLabel;
    ppDBCalcTotalLista: TppDBCalc;
    ppLine2: TppLine;
    procedure FormShow(Sender: TObject);
    procedure BitBtnIncluirClick(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure CDSPrincipalAfterOpen(DataSet: TDataSet);
    procedure BitBtnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure Apagar;
    procedure MontarRelatorioGrupoProdutos;
    procedure MontarRelatorioGrupo;
    function VerificaPendenciasGrupo : Boolean;
  public
    { Public declarations }
  end;

var
  FormGruposProdutos: TFormGruposProdutos;

implementation

uses uFormManutencaoGrupos, uDataModule, uRelatorioModelo,
  uFormTipoRelatorio;

{$R *.dfm}

procedure TFormGruposProdutos.FormShow(Sender: TObject);
begin
  inherited;
  MostrarDados('Grupos','','Descricao');
end;

procedure TFormGruposProdutos.BitBtnIncluirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormManutencaoGrupos, FormManutencaoGrupos);
    FormManutencaoGrupos.InicializaTela(1, CDSPrincipal);
    FormManutencaoGrupos.ShowModal;
  Finally
    MostrarDados('Grupos','','Descricao');
    CDSPrincipal.Locate('Codigo',FormManutencaoGrupos.EditCodigo.asInteger,[]);    
    FormManutencaoGrupos.Free;
  end;
end;


procedure TFormGruposProdutos.BitBtnExcluirClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    Exit;

  If Application.MessageBox('Deseja Realmente Excluir o Grupo Selecionado?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
    Apagar;
end;

procedure TFormGruposProdutos.Apagar;
Var TransDesc : TTransactionDesc;
    BM : TBookMark;
begin
  if VerificaPendenciasGrupo = True then
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
        SQL.Add(' DELETE FROM GRUPOS');
        SQL.Add(' WHERE CODIGO = :CODIGO');
        ParamByName('Codigo').asFloat := CDSPrincipal.FieldByName('Codigo').asFloat;
        ExecSQL;
        CDSPrincipal.Prior;
        BM := CDSPrincipal.GetBookMark;
        SQLConnectionPrin.Commit(TransDesc);
        
        MostrarDados('Grupos','','Descricao');
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


procedure TFormGruposProdutos.BitBtnAlterarClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) Then
    Exit;

  Try
    Application.CreateForm(TFormManutencaoGrupos, FormManutencaoGrupos);
    FormManutencaoGrupos.InicializaTela(2, CDSPrincipal);
    FormManutencaoGrupos.ShowModal;
  Finally
    MostrarDados('Grupos','','Descricao');
    CDSPrincipal.Locate('Codigo',FormManutencaoGrupos.EditCodigo.asInteger,[]);
    FormManutencaoGrupos.Free;
  end;

end;

procedure TFormGruposProdutos.CDSPrincipalAfterOpen(DataSet: TDataSet);
begin
  with CDSPrincipal do
  begin
    FieldByName('CODIGO').DisplayLabel         := 'Código';
    FieldByName('DESCRICAO').DisplayLabel      := 'Descrição';

    FieldByName('CODIGO').DisplayWidth         := 8;
    FieldByName('DESCRICAO').DisplayWidth      := 50;
  end;
  inherited;

end;

procedure TFormGruposProdutos.BitBtnImprimirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormTipoRelatorio, FormTipoRelatorio);
    with FormTipoRelatorio do
    begin
      AdicionarTipo('Grupos');
      AdicionarTipo('Produtos por Grupo');
      ShowModal;
      if MrOk then
      begin
        if RadioGroupTipoRelatorio.ItemIndex = 0 then
          MontarRelatorioGrupo
        else if RadioGroupTipoRelatorio.ItemIndex = 1 then
          MontarRelatorioGrupoProdutos;
      end;
    end;
  Finally
    CDSPrincipal.First;
    FormTipoRelatorio.Free;
  end;
end;

procedure TFormGruposProdutos.MontarRelatorioGrupoProdutos;
begin
  inherited;
  with CDSGrupoProdutos do
  begin
    SQL.Clear;
    SQL.Add('Select Prod.CodGrupo, Prod.Codigo as CodProduto,');
    SQL.Add('       Prod.Classificacao, Prod.Descricao as DescrProduto,');
    SQL.Add('       Gr.Descricao as DescrGrupo');
    SQL.Add('From Produtos Prod');
    SQL.Add('Inner join Grupos  Gr on Prod.CodGrupo = Gr.Codigo');
    SQL.Add('Order by Prod.CodGrupo, Prod.Codigo, Prod.Classificacao');
    Close;
    CommandText := SQL.Text;
    Open;
    First;
  end;
  ppReportGrupoProdutos.Print;
end;

procedure TFormGruposProdutos.MontarRelatorioGrupo;
begin
  Try
    Application.CreateForm(TFormRelatorioModelo, FormRelatorioModelo);
    with FormRelatorioModelo do
    begin
      DS_Principal.DataSet := Self.CDSPrincipal;
      MontaRelatorio;
      ppLabelDescricaoRel.Caption := 'Relatório de Grupos';
      ppRelatorio.Print;
    end;
  Finally
    FormRelatorioModelo.Free;
  end;
end;

function TFormGruposProdutos.VerificaPendenciasGrupo : Boolean;
begin
  Result := False;
  with DataModulePrin.SQLQueryPesquisa do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' select Codigo from Produtos ');
    SQL.Add(' WHERE CODGRUPO = :CODGRUPO');
    ParamByName('CodGrupo').asFloat  := CDSPrincipal.FieldByName('Codigo').asFloat;
    Open;

    if not IsEmpty then
    begin
      Application.MessageBox(PChar('O Grupo não poderá ser Excluído pois está ligado ao Produto N.º ' + FieldByName('Codigo').asString + '!'),'Informação',0);
      Result := True;
    end;
  end;
end;



end.
