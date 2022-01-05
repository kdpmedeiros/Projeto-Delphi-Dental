unit uFormRelatoriosGerais;

interface           

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, ppDB, ppDBPipe, ppBands, ppVar, ppCtrls, ppPrnabl,
  ppClass, ppCache, ppComm, ppRelatv, ppProd, ppReport, StdCtrls, TAdvEditP,
  uFrameModelo, uFrameVendedor, Buttons, ExtCtrls, SqlTimSt, FMTBcd,
  SqlExpr, Provider, ppStrtch, ppSubRpt, ppModule, raCodMod, ppRegion,
  uFrameCliente;
                
type
  TFormRelatoriosGerais = class(TForm)
    ppRelatorioFechamento: TppReport;
    ppDBPipelineRel: TppDBPipeline;
    DS_Principal: TDataSource;
    CDSRelFechamento: TClientDataSet;
    GroupBox1: TGroupBox;
    EditDataIni: TAdvEdit;
    EditDataFim: TAdvEdit;
    Label1: TLabel;
    Label2: TLabel;
    FrameVendedor: TFrameVendedor;
    PnlBotoes: TPanel;
    BitBtnImprimir: TSpeedButton;
    BitBtnFechar: TSpeedButton;
    GroupBoxRelatorios: TGroupBox;
    RadioButtonFechamento: TRadioButton;
    DSPPrincipal: TDataSetProvider;
    SQLPrincipal: TSQLDataSet;
    CDSRelFechamentoCODCLIENTE: TFMTBCDField;
    CDSRelFechamentoCLIENTE: TStringField;
    CDSRelFechamentoCODIGO: TFMTBCDField;
    CDSRelFechamentoDATAEMISSAO: TSQLTimeStampField;
    ppDBPipelinePagamentos: TppDBPipeline;
    CDSPagamentos: TClientDataSet;
    DS_Pagamentos: TDataSource;
    CDSPagamentosCODPEDIDONF: TFMTBCDField;
    CDSPagamentosTIPO: TSmallintField;
    CDSRelFechamentoTIPO: TSmallintField;
    CDSRelFechamentoVALORCOMISSAO: TFMTBCDField;
    CDSRelFechamentoValorFreteAPagar: TFMTBCDField;
    ppHeaderBand1: TppHeaderBand;
    ppLabelDescricaoRel: TppLabel;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel2: TppLabel;
    ppSystemVariable3: TppSystemVariable;
    ppLabel19: TppLabel;
    ppLabel44: TppLabel;
    ppLabel4: TppLabel;
    ppLblDataIni: TppLabel;
    ppLblDataFim: TppLabel;
    ppLabel6: TppLabel;
    ppLabel5: TppLabel;
    ppLabelVendedor: TppLabel;
    ppLabel25: TppLabel;
    ppBandaDetalhe: TppDetailBand;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText3: TppDBText;
    ppDBText2: TppDBText;
    ppDBText1: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppRegion1: TppRegion;
    ppLabel22: TppLabel;
    ppLabel24: TppLabel;
    ppLabel23: TppLabel;
    ppLabel3: TppLabel;
    ppVarSaldoDevedor: TppVariable;
    ppLabel15: TppLabel;
    ppDBValorTotal: TppDBCalc;
    ppRegionPagamentos: TppRegion;
    ppLabel18: TppLabel;
    ppLabel17: TppLabel;
    ppLabel16: TppLabel;
    ppSubReportPagamentos: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDetailBand1: TppDetailBand;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppSummaryBand1: TppSummaryBand;
    ppDBCalcTotalPago: TppDBCalc;
    ppLabel20: TppLabel;
    raCodeModule2: TraCodeModule;
    raCodeModule1: TraCodeModule;
    ppDBTextCodCliente: TppDBText;
    CDSPagamentosCODCLIENTE: TFMTBCDField;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    CDSPagamentosVALOR: TFMTBCDField;
    CDSRelFechamentoVALORDUPLICATA: TFMTBCDField;
    ppDBPipelineRelppField10: TppField;
    ppDBText10: TppDBText;
    CDSRelFechamentoSituacao: TStringField;
    ppDBPipelineRelppField11: TppField;
    ppDBText11: TppDBText;
    CDSRelFechamentoDATAVENCIMENTO: TDateField;
    CDSRelFechamentoDATAPAGAMENTO: TDateField;
    CDSPagamentosDATAEMISSAO: TDateField;
    CDSRelFechamentoTipoPedNF: TStringField;
    ppDBPipelineRelppField12: TppField;
    ppLabel14: TppLabel;
    ppDBText12: TppDBText;
    ppLabel26: TppLabel;
    ppLabel7: TppLabel;
    ppLabel21: TppLabel;
    FrameCliente: TFrameCliente;
    ppRelatorioComissoVend: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppSystemVariable4: TppSystemVariable;
    ppSystemVariable5: TppSystemVariable;
    ppLabel29: TppLabel;
    ppSystemVariable6: TppSystemVariable;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    ppLabel34: TppLabel;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppLabel38: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppFooterBand2: TppFooterBand;
    raCodeModule4: TraCodeModule;
    ppDBPipelineComissVend: TppDBPipeline;
    CDS_ComissVend: TClientDataSet;
    DS_ComissVend: TDataSource;
    RadioButtonComissVend: TRadioButton;
    CDS_ComissVendCODIGO: TFMTBCDField;
    CDS_ComissVendDATAEMISSAO: TSQLTimeStampField;
    CDS_ComissVendTIPO: TSmallintField;
    CDS_ComissVendTIPOPEDNF: TStringField;
    CDS_ComissVendVALORTOTALCOMISSAO: TFMTBCDField;
    CDS_ComissVendVALORTOTALPEDIDO: TFMTBCDField;
    CDS_ComissVendPERCCOMISSVEND: TFMTBCDField;
    CDS_ComissVendCODPRODUTO: TFMTBCDField;
    CDS_ComissVendCODGRUPO: TFMTBCDField;
    CDS_ComissVendCLASSIFICACAO: TStringField;
    CDS_ComissVendVALORUNITARIO: TFMTBCDField;
    CDS_ComissVendVALORTOTAL: TFMTBCDField;
    CDS_ComissVendVALORDESCONTO: TFMTBCDField;
    CDS_ComissVendVALORCOMISSAO: TFMTBCDField;
    CDS_ComissVendDESCRICAOPRODUTO: TStringField;
    CDS_ComissVendPRODUTOTRATADO: TStringField;
    CDS_ComissVendVALORFRETEAPAGAR: TFMTBCDField;
    CDS_ComissVendDIFERENCA: TFMTBCDField;
    CDS_ComissVendPERCCOMISSAO: TFMTBCDField;
    CDS_ComissVendFLAGCOMISSAOALTERADA: TSmallintField;
    CDS_ComissVendCODVENDEDOR: TFMTBCDField;
    CDS_ComissVendNOME: TStringField;
    ppDBPipelineComissVendppField20: TppField;
    ppDBPipelineComissVendppField21: TppField;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppGroup4: TppGroup;
    ppGroupHeaderBand4: TppGroupHeaderBand;
    ppGroupFooterBand4: TppGroupFooterBand;
    ppLabel47: TppLabel;
    ppDBText21: TppDBText;
    ppLabel37: TppLabel;
    ppDBText22: TppDBText;
    ppDBText23: TppDBText;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppLabel49: TppLabel;
    ppLabel51: TppLabel;
    ppLabel52: TppLabel;
    ppLabel53: TppLabel;
    ppLabel39: TppLabel;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppDBText20: TppDBText;
    ppLblOK: TppLabel;
    ppLabel40: TppLabel;
    ppLabel41: TppLabel;
    ppLabel42: TppLabel;
    ppLabel45: TppLabel;
    ppLabel46: TppLabel;
    ppLabel54: TppLabel;
    ppLabel55: TppLabel;
    ppLabel56: TppLabel;
    ppLblConferido: TppLabel;
    CDS_ComissVendCONFERIDO: TSmallintField;
    ppLabel30: TppLabel;
    ppDBPipelineComissVendppField22: TppField;
    CDS_ComissVendNomeCli: TStringField;
    ppLabel60: TppLabel;
    ppDBText27: TppDBText;
    CDS_ComissVendFLAGOK: TSmallintField;
    ppDBPipelineComissVendppField23: TppField;
    ppSubComissAPagar: TppSubReport;
    ppChildReport2: TppChildReport;
    DS_ComissoesAPagar: TDataSource;
    CDSComissoesAPagar: TClientDataSet;
    ppDBComissAPagar: TppDBPipeline;
    CDSComissoesAPagarPERCCOMISSAO: TFMTBCDField;
    CDSComissoesAPagarVALORTOTAL: TFMTBCDField;
    CDSComissoesAPagarVALORCOMISSAO: TFMTBCDField;
    ppDetailBand3: TppDetailBand;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppDBText30: TppDBText;
    ppFooterBand3: TppFooterBand;
    ppSummaryBand2: TppSummaryBand;
    ppRegionVendas: TppRegion;
    ppLabel66: TppLabel;
    ppLabel62: TppLabel;
    ppLabel64: TppLabel;
    ppLabel65: TppLabel;
    ppLabel67: TppLabel;
    CDS_ComissVendCODCLIENTE: TFMTBCDField;
    ppDBPipelineComissVendppField24: TppField;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppGroupFooterBand3: TppGroupFooterBand;
    ppLabel43: TppLabel;
    ppLabel57: TppLabel;
    ppVarTotalPag: TppVariable;
    ppLabel58: TppLabel;
    ppLabel61: TppLabel;
    ppDBTotalGeral: TppDBCalc;
    ppLabelTotalGeral: TppLabel;
    ppLabel59: TppLabel;
    ppDBText19: TppDBText;
    CDSRelFechamentoCODPEDIDONF: TFMTBCDField;
    ppDBPipelineRelppField13: TppField;
    ck_somentenf: TCheckBox;
    ppLabel48: TppLabel;
    ppLabel50: TppLabel;
    ppDBText24: TppDBText;
    CDS_ComissVendCODPEDNF: TFMTBCDField;
    ppDBPipelineComissVendppField25: TppField;
    CDS_ComissVendCPFCNPJ: TStringField;
    ppDBPipelineComissVendppField26: TppField;
    ppSummaryBand3: TppSummaryBand;
    ppSubDeclaracao: TppSubReport;
    ppChildReport3: TppChildReport;
    ppDetailBand4: TppDetailBand;
    ppLabel63: TppLabel;
    pplblvalortotal: TppLabel;
    pplblvalorextenso: TppLabel;
    ppLabel69: TppLabel;
    ppLabel70: TppLabel;
    ppLabel71: TppLabel;
    ppDBText31: TppDBText;
    ppDBText32: TppDBText;
    ppHeaderBand3: TppHeaderBand;
    ppLabel72: TppLabel;
    ppLabel73: TppLabel;
    ppSystemVariable7: TppSystemVariable;
    ppSystemVariable8: TppSystemVariable;
    ppLabel74: TppLabel;
    ppSystemVariable9: TppSystemVariable;
    ppLabel75: TppLabel;
    ppLabel76: TppLabel;
    ppLabel77: TppLabel;
    ppLabel78: TppLabel;
    ppLabel79: TppLabel;
    ppLabel80: TppLabel;
    ppLabel81: TppLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnFecharClick(Sender: TObject);
    procedure BitBtnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ppLblDataIniGetText(Sender: TObject; var Text: String);
    procedure ppLblDataFimGetText(Sender: TObject; var Text: String);
    procedure ppLabelVendedorGetText(Sender: TObject; var Text: String);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ppRegion1Print(Sender: TObject);
    procedure ppGroupHeaderBand2BeforePrint(Sender: TObject);
    procedure ppLblOKGetText(Sender: TObject; var Text: String);
    procedure ppLblConferidoGetText(Sender: TObject; var Text: String);
    procedure ppDBValorTotalPrint(Sender: TObject);
    procedure ppRelatorioFechamentoStartPage(Sender: TObject);
    procedure ppFooterBand1BeforePrint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ppDetailBand4BeforePrint(Sender: TObject);
  private
    { Private declarations }
    SQL : TStringList;
    procedure MontaRelatorioFechamento;
    procedure MontaPagamentos;
    procedure MontaRelatorioComissVendedores;
    procedure MontaComissoesAPagar;
    procedure AlimentarTotalComissao;
  public
    { Public declarations }
  end;

var
  FormRelatoriosGerais: TFormRelatoriosGerais;

implementation

{$R *.dfm}

Uses uDataModule, uFuncoes;

procedure TFormRelatoriosGerais.MontaRelatorioFechamento;
begin
  with CDSRelFechamento do
  begin
    SQL.Clear;
    SQL.Add('Select PNF.CodCliente, Cli.Nome as Cliente, CASE WHEN PNF.Tipo = 1 then PNF.Codigo else PNF.NumeroID end as Codigo, PNF.DataEmissao, PNF.Tipo,');
    SQL.Add('       Dpl.ValorDuplicata, Dpl.DataVencimento, Dpl.DataPagamento,');
    SQL.Add('       CASE WHEN PNF.Tipo = 1  then ''*'' ELSE ''**'' END AS TipoPedNF,');
    SQL.Add('       CASE WHEN Dpl.DataPagamento is null then '' '' ELSE ''PAGO'' END AS Situacao,');
    SQL.Add('    (Select Sum( PNF1.ValorComissao) From PedidoNota PNF1');
    SQL.Add('       where PNF1.CodCliente = PNF.CodCliente and');
    SQL.Add('                PNF1.Codigo = PNF.Codigo and');
    SQL.Add('                PNF1.Tipo = PNF.Tipo');
    SQL.Add('       group by PNF1.CodCliente) as ValorComissao,');
    SQL.Add('    (Select Sum( PNF1.ValorFreteAPagar) From PedidoNota PNF1');
    SQL.Add('       where PNF1.CodCliente = PNF.CodCliente and');
    SQL.Add('                PNF1.Codigo = PNF.Codigo and');
    SQL.Add('                PNF1.Tipo = PNF.Tipo');
    SQL.Add('       group by PNF1.CodCliente) as ValorFreteAPagar, PNF.Codigo as CODPEDIDONF');
    SQL.Add('From Duplicatas Dpl');
    SQL.Add('Left join PedidoNota PNF on PNF.Codigo = Dpl.CodPedidoNF and');
    SQL.Add('                            PNF.tipo   = Dpl.TipoPedidoNF');
    SQL.Add('Left join Clientes   Cli on Cli.Codigo = PNF.CodCliente');
    SQL.Add(' where PNF.CodVendedor    = :CodVendedor');
    SQL.Add('   and PNF.FLAGPROCESSADO = 0');
    if EditDataIni.IsDate then
      SQL.Add(' and PNF.DataEmissao >= :DataIni');
    if EditDataFim.IsDate then
      SQL.Add(' and PNF.DataEmissao <= :DataFim');
    if FrameCliente.EditCodigo.asFloat > 0 then
      SQL.Add(' and PNF.CodCliente = :CodCliente');
    if ck_somentenf.Checked then
      SQL.Add(' and PNF.Tipo = 2');
    SQL.Add(' Order by Cli.Nome');

    Close;
    CommandText := SQL.Text;
    Params.ParamByname('CodVendedor').asInteger  := FrameVendedor.EditCodigo.asInteger;
    if EditDataIni.IsDate then
      Params.ParamByname('DataIni').asSQLTimesTamp := DateTimeToSQLTimesTamp(EditDataIni.asDate);
    if EditDataFim.IsDate then
      Params.ParamByname('DataFim').asSQLTimesTamp := DateTimeToSQLTimesTamp(EditDataFim.asDate);
    if FrameCliente.EditCodigo.asFloat > 0 then
      Params.ParamByname('CodCliente').asFloat  := FrameCliente.EditCodigo.asFloat;
    Open;
  end;
  MontaPagamentos;
  ppRelatorioFechamento.Print;

end;

procedure TFormRelatoriosGerais.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ppRelatorioFechamento.Free;
  SQL.Free;       
end;

procedure TFormRelatoriosGerais.BitBtnFecharClick(Sender: TObject);
begin
  close;           
end;

procedure TFormRelatoriosGerais.BitBtnImprimirClick(Sender: TObject);
begin
  if (RadioButtonFechamento.Checked) or (RadioButtonComissVend.Checked)  then
  begin
    if FrameVendedor.EditCodigo.asInteger = 0 then
    begin
      Application.MessageBox('Informe o Vendedor!','Informação',0);
      FrameVendedor.EditCodigo.SetFocus;
      Exit;
    end
    else
      FrameVendedor.EditCodigo.OnExit(FrameVendedor.EditCodigo);

    if (RadioButtonFechamento.Checked) then
      MontaRelatorioFechamento
    else if (RadioButtonComissVend.Checked) then
      MontaRelatorioComissVendedores;
  end;
end;

procedure TFormRelatoriosGerais.FormCreate(Sender: TObject);
begin
  SQL := TStringList.Create;
end;

procedure TFormRelatoriosGerais.ppLblDataIniGetText(Sender: TObject;
  var Text: String);
begin
  if EditDataIni.IsDate then
    Text := EditDataIni.Text
  else
    Text := 'Não Info';
end;             
                
procedure TFormRelatoriosGerais.ppLblDataFimGetText(Sender: TObject;
  var Text: String);
begin
  if EditDataFim.IsDate then
    Text := EditDataFim.Text                             
  else
    Text := 'Não Info'
end;

procedure TFormRelatoriosGerais.ppLabelVendedorGetText(Sender: TObject;
  var Text: String);
begin
  Text := FrameVendedor.EditNome.Text;
end;

procedure TFormRelatoriosGerais.MontaPagamentos;
begin
  with CDSPagamentos do
  begin
    SQL.Clear;
    SQL.Add('Select Pag.*, PNF.CodCliente, PNF.Codigo as CodPedidoNF, PNF.Tipo');
    SQL.Add('From MovFinanceiro Pag');
    SQL.Add('Left Join Duplicatas Dpl on Dpl.Codigo = Pag.CodDuplicata');
    SQL.Add('                        and Dpl.Tipo = Pag.Tipo');
    SQL.Add('Left join PedidoNota PNF on PNF.Codigo = Dpl.CodPedidoNF and');
    SQL.Add('                            PNF.Tipo   = Dpl.TipoPedidoNF');
    SQL.Add(' where PNF.CodVendedor = :CodVendedor');
    SQL.Add('   and PNF.FLAGPROCESSADO = 0');
    if EditDataIni.IsDate then
      SQL.Add(' and PNF.DataEmissao >= :DataIni');
    if EditDataFim.IsDate then
      SQL.Add(' and PNF.DataEmissao <= :DataFim');
    if FrameCliente.EditCodigo.asFloat > 0 then
      SQL.Add(' and PNF.CodCliente = :CodCliente');
    if ck_somentenf.Checked then
      SQL.Add(' and PNF.Tipo = 2');
    SQL.Add(' Order by Pag.DataEmissao');


    Close;
    CommandText := SQL.Text;
    Params.ParamByname('CodVendedor').asInteger  := FrameVendedor.EditCodigo.asInteger;
    if EditDataIni.IsDate then
      Params.ParamByname('DataIni').asSQLTimesTamp := DateTimeToSQLTimesTamp(EditDataIni.asDate);
    if EditDataFim.IsDate then
      Params.ParamByname('DataFim').asSQLTimesTamp := DateTimeToSQLTimesTamp(EditDataFim.asDate);
    if FrameCliente.EditCodigo.asFloat > 0 then
      Params.ParamByname('CodCliente').asFloat  := FrameCliente.EditCodigo.asFloat;
    Open;
  end;
end;


procedure TFormRelatoriosGerais.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
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

procedure TFormRelatoriosGerais.ppRegion1Print(Sender: TObject);
begin
  ppVarSaldoDevedor.value := ppDBValorTotal.Value - ppDBCalcTotalPago.value;
end;
            
procedure TFormRelatoriosGerais.ppGroupHeaderBand2BeforePrint(
  Sender: TObject);
begin
  CDSPagamentos.Filtered := False;
  CDSPagamentos.Filter   := ' CodCliente = ' + ppDBTextCodCliente.Text;
  CDSPagamentos.Filtered := True;

  ppRegionPagamentos.Visible := (not CDSPagamentos.IsEmpty);
end;

procedure TFormRelatoriosGerais.MontaRelatorioComissVendedores;
begin
  with CDS_ComissVend do
  begin
    SQL.Clear;
    SQL.Add('   Select CASE WHEN PNF.Tipo = 1 then PNF.Codigo else PNF.NumeroID end as Codigo,PNF.Codigo as CodPedNF,');
    SQL.Add('   PNF.DataEmissao, PNF.Tipo,  CASE WHEN PNF.Tipo = 1  then ''PED'' ELSE ''NF'' END AS TipoPedNF,');
    SQL.Add('   PNF.ValorComissao as ValorTotalComissao,  (Select Sum( IPNFI.ValorTotal) From ItemPedidoNota IPNFI');
    SQL.Add('   where IPNFI.CodPedidoNF = PNF.Codigo and  IPNFI.Tipo = PNF.Tipo) as ValorTotalPedido,');
    SQL.Add('   V.PercComissao as PercComissVend,  IPNF.CODPRODUTO, IPNF.CODGRUPO, IPNF.CLASSIFICACAO,  IPNF.VALORUNITARIO,IPNF.VALORTOTAL,IPNF.VALORDESCONTO,');
    SQL.Add('   IPNF.VALORCOMISSAO, P.Descricao as DescricaoProduto,  ( Cast(IPNF.CodGrupo as varchar(6)) || ''.'' || Cast(IPNF.CodProduto as varchar(8)) ||');
    SQL.Add('   Case when IPNF.Classificacao <> '''' then  ''.'' ||');
    SQL.Add('   Cast(IPNF.Classificacao as varchar(7))   else '''' end ) as ProdutoTratado,');
    SQL.Add('   IPNF.VALORFRETEAPAGAR,  (Lp.ValorVendaFrete - IPNF.VALORUNITARIO) as Diferenca,');
    SQL.Add('   IPNF.PercComissao, IPNF.FLAGCOMISSAOALTERADA, IPNF.FLAGOK, PNF.CodVendedor, V.Nome, PNF.FLAGOK as Conferido,');
    SQL.Add('   CLI.Nome as NOMECLI, PNF.CodCliente, V.CPFCNPJ');
    SQL.Add('   From PedidoNota PNF');
    SQL.Add('   Left join Vendedores V on V.Codigo  = PNF.CodVendedor');
    SQL.Add('   Left join ItemPedidoNota IPNF on IPNF.CodPedidoNF  = PNF.Codigo and');
    SQL.Add('   IPNF.Tipo = PNF.Tipo');
    SQL.Add('   Left join Produtos P on P.Codigo   = IPNF.CodProduto');
    SQL.Add('                       and P.CodGrupo = IPNF.CodGrupo');
    SQL.Add('                       and P.Classificacao = IPNF.Classificacao');
    SQL.Add('   Left outer Join ListaPreco Lp on Lp.Codigo    = P.CodListaPreco');
    SQL.Add('   Left outer Join Clientes Cli on Cli.Codigo    = PNF.CodCliente');
    SQL.Add(' where PNF.CodVendedor = :CodVendedor');
    SQL.Add('   and PNF.FLAGPROCESSADO = 0');
    if EditDataIni.IsDate then
      SQL.Add(' and PNF.DataEmissao >= :DataIni');
    if EditDataFim.IsDate then
      SQL.Add(' and PNF.DataEmissao <= :DataFim');
    if FrameCliente.EditCodigo.asFloat > 0 then
      SQL.Add(' and PNF.CodCliente = :CodCliente');
    if ck_somentenf.Checked then
      SQL.Add(' and PNF.Tipo = 2');
    SQL.Add(' Order by Cli.Nome  ');

    Close;
    CommandText := SQL.Text;
    Params.ParamByname('CodVendedor').asInteger  := FrameVendedor.EditCodigo.asInteger;
    if EditDataIni.IsDate then
      Params.ParamByname('DataIni').asSQLTimesTamp := DateTimeToSQLTimesTamp(EditDataIni.asDate);
    if EditDataFim.IsDate then
      Params.ParamByname('DataFim').asSQLTimesTamp := DateTimeToSQLTimesTamp(EditDataFim.asDate);
    if FrameCliente.EditCodigo.asFloat > 0 then
      Params.ParamByname('CodCliente').asFloat  := FrameCliente.EditCodigo.asFloat;
    Open;
  end;
  MontaComissoesAPagar;
  ppRelatorioComissoVend.Print;                                   
end;
                 

procedure TFormRelatoriosGerais.ppLblOKGetText(Sender: TObject;
  var Text: String);
begin
  if CDS_ComissVend.FieldByName('FLAGOK').AsInteger = 1 then
    Text := '[OK]'
  else
    Text := '';
end;
                  
procedure TFormRelatoriosGerais.ppLblConferidoGetText(Sender: TObject;
  var Text: String);
begin
  if CDS_ComissVend.FieldByName('Conferido').AsInteger = 1 then
    Text := '[OK]'
  else
    Text := '';
end;

procedure TFormRelatoriosGerais.MontaComissoesAPagar;
begin
  with CDSComissoesAPagar do
  begin
    SQL.Clear;
    SQL.Add('   Select IPNF.PercComissao, Sum( IPNF.ValorTotal) as ValorTotal, ');
    SQL.Add('          Sum( IPNF.ValorComissao) as ValorComissao ');
    SQL.Add('   From ItemPedidoNota IPNF, PedidoNota PNF, CLIENTES CLI');
    SQL.Add(' where PNF.CODIGO = IPNF.CODPEDIDONF');
    SQL.Add('   AND PNF.TIPO = IPNF.TIPO');
    SQL.Add('   AND PNF.CODCLIENTE = CLI.CODIGO');
    SQL.Add('   AND PNF.CodVendedor = :CodVendedor');
    SQL.Add('   AND PNF.FLAGPROCESSADO = 0');
    if EditDataIni.IsDate then
      SQL.Add(' and PNF.DataEmissao >= :DataIni');
    if EditDataFim.IsDate then
      SQL.Add(' and PNF.DataEmissao <= :DataFim');
    if FrameCliente.EditCodigo.asFloat > 0 then
      SQL.Add(' and PNF.CodCliente = :CodCliente');
    if ck_somentenf.Checked then
      SQL.Add(' and PNF.Tipo = 2');
    SQL.Add(' Group by IPNF.PercComissao ');
    SQL.Add(' Order by IPNF.PercComissao DESC  ');
    Close;       
    CommandText := SQL.Text;
    Params.ParamByname('CodVendedor').asInteger  := FrameVendedor.EditCodigo.asInteger;
    if EditDataIni.IsDate then
      Params.ParamByname('DataIni').asSQLTimesTamp := DateTimeToSQLTimesTamp(EditDataIni.asDate);
    if EditDataFim.IsDate then
      Params.ParamByname('DataFim').asSQLTimesTamp := DateTimeToSQLTimesTamp(EditDataFim.asDate);
    if FrameCliente.EditCodigo.asFloat > 0 then
      Params.ParamByname('CodCliente').asFloat  := FrameCliente.EditCodigo.asFloat;
    Open;
  end;
end;



procedure TFormRelatoriosGerais.ppDBValorTotalPrint(Sender: TObject);
begin
  ppVarTotalPag.Value := ppVarTotalPag.Value + ppDBValorTotal.Value;
end;

procedure TFormRelatoriosGerais.ppRelatorioFechamentoStartPage(
  Sender: TObject);
begin
  ppVarTotalPag.Value := 0;
end;

procedure TFormRelatoriosGerais.ppFooterBand1BeforePrint(Sender: TObject);
begin
  if ppRelatorioFechamento.Page = ppRelatorioFechamento.PageCount then
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

procedure TFormRelatoriosGerais.FormShow(Sender: TObject);
begin
  VerifPermissoes;
  if DataModulePrin.SQLQueryPesquisa.Locate('CODIGOTELA',19,[]) then
    RadioButtonComissVend.Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('Visualizar').asInteger = 1);
  if DataModulePrin.SQLQueryPesquisa.Locate('CODIGOTELA',16,[]) then
    RadioButtonFechamento.Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('Visualizar').asInteger = 1);
end;

procedure TFormRelatoriosGerais.ppDetailBand4BeforePrint(Sender: TObject);
begin
  AlimentarTotalComissao;
end;

procedure TFormRelatoriosGerais.AlimentarTotalComissao;
Var CDSTotalComissao : TClientDataset;
begin
  CDSTotalComissao := TClientDataset.Create(Self);
  with CDSTotalComissao do
  begin          
    ProviderName := DSPPrincipal.Name;
    Close;                
    SQL.Clear;
    SQL.Add('   Select Sum( IPNF.ValorComissao) as TOTAL_COMISSAO ');
    SQL.Add('   From ItemPedidoNota IPNF, PedidoNota PNF ');
    SQL.Add(' where PNF.CODIGO = IPNF.CODPEDIDONF');
    SQL.Add('   AND PNF.TIPO = IPNF.TIPO');
    SQL.Add('   AND PNF.CodVendedor = :CodVendedor');
    SQL.Add('   AND PNF.FLAGPROCESSADO = 0');
    if EditDataIni.IsDate then                                 
      SQL.Add(' and PNF.DataEmissao >= :DataIni');
    if EditDataFim.IsDate then
      SQL.Add(' and PNF.DataEmissao <= :DataFim');
    if FrameCliente.EditCodigo.asFloat > 0 then
      SQL.Add(' and PNF.CodCliente = :CodCliente');
    if ck_somentenf.Checked then
      SQL.Add(' and PNF.Tipo = 2');
    CommandText := SQL.Text;
    Params.ParamByname('CodVendedor').asInteger  := FrameVendedor.EditCodigo.asInteger;
    if EditDataIni.IsDate then
      Params.ParamByname('DataIni').asSQLTimesTamp := DateTimeToSQLTimesTamp(EditDataIni.asDate);
    if EditDataFim.IsDate then
      Params.ParamByname('DataFim').asSQLTimesTamp := DateTimeToSQLTimesTamp(EditDataFim.asDate);
    if FrameCliente.EditCodigo.asFloat > 0 then
      Params.ParamByname('CodCliente').asFloat  := FrameCliente.EditCodigo.asFloat;
    Open;

    pplblvalortotal.Caption := FormatFloat('#,##0.00',FieldByname('TOTAL_COMISSAO').asFloat);
    pplblvalorextenso.Caption := Extenso(FieldByname('TOTAL_COMISSAO').asFloat);

    Free;
  end;
end;

end.

