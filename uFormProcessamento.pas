unit uFormProcessamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormModelo, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids,
  DBGrids, StdCtrls, TAdvEditP, Buttons, ExtCtrls, uFrameCondicoesPagto,
  uFrameModelo, uFrameCliente, uFrameVendedor, dbxpress, ImgList, Math, DateUtils,
  Types, ppDB, ppDBPipe, ppModule, raCodMod, ppBands, ppClass, ppMemo,
  ppStrtch, ppCtrls, ppPrnabl, ppCache, ppComm, ppRelatv, ppProd, ppReport, SqlTimSt;

type
  TFormProcessamento = class(TFormModelo)
    BitBtnConfirmar: TSpeedButton;
    CheckBoxImprimir: TCheckBox;
    CDSItem: TClientDataSet;
    DS_Item: TDataSource;
    CDSItens_NF: TClientDataSet;
    DS_Itens_NF: TDataSource;
    CDS_NF: TClientDataSet;
    DS_NF: TDataSource;
    btn_ver_pedido: TSpeedButton;
    GroupBox1: TGroupBox;
    dbg_itens: TDBGrid;
    ImageListPrin: TImageList;
    Label2: TLabel;
    Label33: TLabel;
    EdDataProc: TAdvEdit;
    BitBtnBuscar: TBitBtn;
    FrameCliente: TFrameCliente;
    EditNumeroID: TAdvEdit;
    FrameVendedor: TFrameVendedor;
    CDS_Duplicatas: TClientDataSet;
    DS_Duplicatas: TDataSource;
    CDSEmpresa: TClientDataSet;
    CDSEmpresaCODIGO: TFMTBCDField;
    CDSEmpresaNOME: TStringField;
    CDSEmpresaCPFCNPJ: TStringField;
    CDSEmpresaENDERECO: TStringField;
    CDSEmpresaBAIRRO: TStringField;
    CDSEmpresaCEP: TFMTBCDField;
    CDSEmpresaCIDADE: TStringField;
    CDSEmpresaTELCOMERCIAL1: TStringField;
    CDSEmpresaTELCOMERCIAL2: TStringField;
    CDSEmpresaTELFAX: TStringField;
    CDSEmpresaTELRESIDENCIAL: TStringField;
    CDSEmpresaTELCELULAR: TStringField;
    CDSEmpresaESTADO: TStringField;
    CDSEmpresaIE: TStringField;
    CDSEmpresaSITE: TStringField;
    CDSEmpresaEMAIL: TStringField;
    CDSEmpresaMATRIZ: TFMTBCDField;
    CDSEmpresaNOMEFANTASIA: TStringField;
    CDSEmpresaMENSAGENS: TStringField;
    CDSEmpresaCODBANCO: TFMTBCDField;
    CDSEmpresaMENSAGEM_CUPOM: TStringField;
    DS_Empresa: TDataSource;
    ppReportNF: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppDBText16: TppDBText;
    ppLabel1: TppLabel;
    LblHoraSaida: TppLabel;
    pplblCondPagto: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    ppDBText21: TppDBText;
    ppDBText23: TppDBText;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppDBText51: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppDBText26: TppDBText;
    ppDBText27: TppDBText;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppDBText30: TppDBText;
    ppDBText31: TppDBText;
    ppDBText32: TppDBText;
    ppDBText33: TppDBText;
    ppDBText34: TppDBText;
    ppDBText35: TppDBText;
    ppDBText36: TppDBText;
    ppDBText37: TppDBText;
    ppDBText38: TppDBText;
    ppDBText39: TppDBText;
    ppDBText40: TppDBText;
    ppDBText41: TppDBText;
    ppDBText42: TppDBText;
    ppDBText43: TppDBText;
    ppDBText44: TppDBText;
    ppDBText45: TppDBText;
    ppDBText46: TppDBText;
    ppDBText47: TppDBText;
    ppDBMemo1: TppDBMemo;
    ppDBText50: TppDBText;
    ppDBText49: TppDBText;
    ppDBText22: TppDBText;
    ppLabel2: TppLabel;
    ppMemoMensagens: TppMemo;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    raCodeModule1: TraCodeModule;
    ppDBPipelineItens: TppDBPipeline;
    ppDBPipelineItensppField1: TppField;
    ppDBPipelineItensppField2: TppField;
    ppDBPipelineItensppField3: TppField;
    ppDBPipelineItensppField4: TppField;
    ppDBPipelineItensppField5: TppField;
    ppDBPipelineItensppField6: TppField;
    ppDBPipelineItensppField7: TppField;
    ppDBPipelineItensppField8: TppField;
    ppDBPipelineItensppField9: TppField;
    ppDBPipelineItensppField10: TppField;
    ppDBPipelineItensppField11: TppField;
    ppDBPipelineItensppField12: TppField;
    ppDBPipelineItensppField13: TppField;
    ppDBPipelineItensppField14: TppField;
    ppDBPipelineItensppField15: TppField;
    ppDBPipelineItensppField16: TppField;
    ppDBPipelinePrin: TppDBPipeline;
    ppDBPipelinePrinppField1: TppField;
    ppDBPipelinePrinppField2: TppField;
    ppDBPipelinePrinppField3: TppField;
    ppDBPipelinePrinppField4: TppField;
    ppDBPipelinePrinppField5: TppField;
    ppDBPipelinePrinppField6: TppField;
    ppDBPipelinePrinppField7: TppField;
    ppDBPipelinePrinppField8: TppField;
    ppDBPipelinePrinppField9: TppField;
    ppDBPipelinePrinppField10: TppField;
    ppDBPipelinePrinppField11: TppField;
    ppDBPipelinePrinppField12: TppField;
    ppDBPipelinePrinppField13: TppField;
    ppDBPipelinePrinppField14: TppField;
    ppDBPipelinePrinppField15: TppField;
    ppDBPipelinePrinppField16: TppField;
    ppDBPipelinePrinppField17: TppField;
    ppDBPipelinePrinppField18: TppField;
    ppDBPipelinePrinppField19: TppField;
    ppDBPipelinePrinppField20: TppField;
    ppDBPipelinePrinppField21: TppField;
    ppDBPipelinePrinppField22: TppField;
    ppDBPipelinePrinppField23: TppField;
    ppDBPipelinePrinppField24: TppField;
    ppDBPipelinePrinppField25: TppField;
    ppDBPipelinePrinppField26: TppField;
    ppDBPipelinePrinppField27: TppField;
    ppDBPipelinePrinppField28: TppField;
    ppDBPipelinePrinppField29: TppField;
    ppDBPipelinePrinppField30: TppField;
    ppDBPipelinePrinppField31: TppField;
    ppDBPipelinePrinppField32: TppField;
    ppDBPipelinePrinppField33: TppField;
    ppDBPipelinePrinppField34: TppField;
    ppDBPipelinePrinppField35: TppField;
    ppDBPipelinePrinppField36: TppField;
    NUMEROID: TppField;
    ppDBPipelinePrinppField37: TppField;
    ppDBPipelinePrinppField38: TppField;
    ppDBPipelinePrinppField39: TppField;
    ppDBPipelinePrinppField40: TppField;
    ppDBPipelineEmpresa: TppDBPipeline;
    ppDBPipelineEmpresappField1: TppField;
    ppDBPipelineEmpresappField2: TppField;
    ppDBPipelineEmpresappField3: TppField;
    ppDBPipelineEmpresappField4: TppField;
    ppDBPipelineEmpresappField5: TppField;
    ppDBPipelineEmpresappField6: TppField;
    ppDBPipelineEmpresappField7: TppField;
    ppDBPipelineEmpresappField8: TppField;
    ppDBPipelineEmpresappField9: TppField;
    ppDBPipelineEmpresappField10: TppField;
    ppDBPipelineEmpresappField11: TppField;
    ppDBPipelineEmpresappField12: TppField;
    ppDBPipelineEmpresappField13: TppField;
    ppDBPipelineEmpresappField14: TppField;
    ppDBPipelineEmpresappField15: TppField;
    ppDBPipelineEmpresappField16: TppField;
    ppDBPipelineEmpresappField17: TppField;
    ppDBPipelineEmpresappField18: TppField;
    ppDBPipelineEmpresappField19: TppField;
    ppDBPipelineDadosCliente: TppDBPipeline;
    ppDBPipelineDadosClienteppField1: TppField;
    ppDBPipelineDadosClienteppField2: TppField;
    ppDBPipelineDadosClienteppField3: TppField;
    ppDBPipelineDadosClienteppField4: TppField;
    ppDBPipelineDadosClienteppField5: TppField;
    ppDBPipelineDadosClienteppField6: TppField;
    ppDBPipelineDadosClienteppField7: TppField;
    ppDBPipelineDadosClienteppField8: TppField;
    ppDBPipelineDadosClienteppField9: TppField;
    ppDBPipelineDadosClienteppField10: TppField;
    ppDBPipelineDadosClienteppField11: TppField;
    ppDBPipelineDadosClienteppField12: TppField;
    ppDBPipelineDadosClienteppField13: TppField;
    ppDBPipelineDadosClienteppField14: TppField;
    ppDBPipelineDadosClienteppField15: TppField;
    ppDBPipelineDadosClienteppField16: TppField;
    ppDBPipelineDadosClienteppField17: TppField;
    ppDBPipelineDadosClienteppField18: TppField;
    ppDBPipelineDadosClienteppField19: TppField;
    ppDBPipelineDadosClienteppField20: TppField;
    ppDBPipelineDadosClienteppField21: TppField;
    ppDBPipelineDadosClienteppField22: TppField;
    ppDBPipelineDadosClienteppField23: TppField;
    ppDBPipelineDadosClienteppField24: TppField;
    ppDBPipelineDadosClienteppField25: TppField;
    ppDBPipelineDadosClienteppField26: TppField;
    ppDBPipelineDadosClienteppField27: TppField;
    ppDBPipelineDadosClienteppField28: TppField;
    ppDBPipelineDadosClienteppField29: TppField;
    ppDBPipelineDadosClienteppField30: TppField;
    ppDBPipelineDadosClienteppField31: TppField;
    ppDBPipelineDadosClienteppField32: TppField;
    ppDBPipelineDadosClienteppField33: TppField;
    ppDBPipelineDadosClienteppField34: TppField;
    CDSDadosCliente: TClientDataSet;
    CDSDadosClienteCODIGO: TFMTBCDField;
    CDSDadosClienteNOME: TStringField;
    CDSDadosClienteCPFCNPJ: TStringField;
    CDSDadosClienteENDERECO: TStringField;
    CDSDadosClienteBAIRRO: TStringField;
    CDSDadosClienteCEP: TFMTBCDField;
    CDSDadosClienteCIDADE: TStringField;
    CDSDadosClienteTELCOMERCIAL1: TStringField;
    CDSDadosClienteTELCOMERCIAL2: TStringField;
    CDSDadosClienteTELFAX: TStringField;
    CDSDadosClienteTELRESIDENCIAL: TStringField;
    CDSDadosClienteTELCELULAR: TStringField;
    CDSDadosClienteESTADO: TStringField;
    CDSDadosClienteRGIE: TStringField;
    CDSDadosClienteSITE: TStringField;
    CDSDadosClienteEMAIL: TStringField;
    CDSDadosClienteCRO: TStringField;
    CDSDadosClientePROFISSAO: TStringField;
    CDSDadosClienteESPECIALIDADE: TStringField;
    CDSDadosClienteSECRETARIA: TStringField;
    CDSDadosClienteSITUACAO: TFMTBCDField;
    CDSDadosClienteBLOQUEADO: TFMTBCDField;
    CDSDadosClienteDATAANIVER: TDateField;
    CDSDadosClienteDATACADASTRO: TDateField;
    CDSDadosClienteCODVENDEDOR: TFMTBCDField;
    CDSDadosClienteOBSERVACAO: TStringField;
    CDSDadosClienteCLINICAGERAL: TFMTBCDField;
    CDSDadosClienteCIRURGIA: TFMTBCDField;
    CDSDadosClienteENDODONTIA: TFMTBCDField;
    CDSDadosClienteDENTISTICA: TFMTBCDField;
    CDSDadosClienteIMPLANTOLOGIA: TFMTBCDField;
    CDSDadosClientePERIODONTIA: TFMTBCDField;
    CDSDadosClientePROTESE: TFMTBCDField;
    CDSDadosClienteRADIOLOGIA: TFMTBCDField;
    DS_DadosCliente: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure CDSPrincipalAfterOpen(DataSet: TDataSet);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure BitBtnBuscarClick(Sender: TObject);
    procedure FrameClienteSpeedButtonConsultaClick(Sender: TObject);
    procedure FrameClienteEditCodigoExit(Sender: TObject);
    procedure CDSPrincipalAfterScroll(DataSet: TDataSet);
    procedure CDSItemAfterOpen(DataSet: TDataSet);
    procedure btn_ver_pedidoClick(Sender: TObject);
    procedure DBGridPrinDblClick(Sender: TObject);
    procedure DBGridPrinDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbg_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridPrinCellClick(Column: TColumn);
    procedure dbg_itensCellClick(Column: TColumn);
    procedure EditNumeroIDExit(Sender: TObject);
    procedure LblHoraSaidaGetText(Sender: TObject; var Text: String);
    procedure ppDBText9GetText(Sender: TObject; var Text: String);
    procedure ppDBText8GetText(Sender: TObject; var Text: String);
    procedure ppDBText37GetText(Sender: TObject; var Text: String);
    procedure pplblCondPagtoGetText(Sender: TObject; var Text: String);
    procedure ppDBText2GetText(Sender: TObject; var Text: String);
    procedure ppMemoMensagensPrint(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnFecharClick(Sender: TObject);
  private
    { Private declarations }
    i_contador_itens : Integer;
    procedure PesquisarPedidos;
    procedure Processar;
    procedure CarregaItens(Pedido : Double);
    procedure AlimentarItens_NF;
    procedure Grava_NF;
    function  RetornaProximaSequencia : Integer;
    function  RetornaProximaSequenciaNumeroID : Integer;
    procedure FiltraItens(Pedido : Double);
    procedure AlimentarDados_NF;
    Procedure CarregaDadosEmpresa;
    procedure GravaSequenciaNumeroID;
    function  VerificarSelecao : Boolean;
    procedure SetarItemFaturado(CodPed, Seq : Double);
    procedure SetarPedidoFaturado(CodPed : Double);
    procedure GravarItensPedidoNota;
    procedure AbrirDadosCliente;
    function ExisteNumeroID : Boolean;
    procedure VoltaUltimSequencia;
  public
    { Public declarations }

  end;

var
  FormProcessamento: TFormProcessamento;

implementation

{$R *.dfm}

Uses uDataModule, uFuncoes, uFormPedidoNota;

procedure TFormProcessamento.PesquisarPedidos;
Var BM : TBookMark;
begin

  SQL.Clear;
  SQL.Add(' Select PN.*, CD.Descricao as DescrCondPagto, Transp.Nome as NomeTransp,');
  SQL.Add(' Transp.CpfCNPJ, Transp.Endereco, Transp.Cidade, Transp.Estado,');
  SQL.Add(' Transp.RGIE, Ven.Nome as NomeVendedor,');
  SQL.Add(' (cast(PN.CodCliente as Varchar(8)) || '' - '' || Cli.Nome) as NomeCliente,');
  SQL.Add(' (cast(PN.CodVendedor as Varchar(8)) || '' - '' || Ven.Nome) as NomeVend,');
  SQL.Add(' CASE WHEN TIPODESCONTOFINAL = 0');
  SQL.Add('      THEN (PN.VALORTOTAL - (PN.VALORTOTAL * (PN.VALORDESCONTOFINAL /100)))');
  SQL.Add('      ELSE (PN.VALORTOTAL - PN.VALORDESCONTOFINAL) END AS VALORTOTALFINAL,');
  SQL.Add(' CD.Descricao as CondPagto, Cast(0 as SmallInt) as Status' );
  SQL.Add(' from PedidoNota PN');
  SQL.Add(' Left Join Clientes    Cli on Cli.Codigo  = PN.CodCliente');
  SQL.Add(' Left Join Vendedores  Ven on Ven.Codigo  = PN.CodVendedor');
  SQL.Add(' Left Join CondicoesPagto CD on CD.Codigo = PN.CodCondPagto');
  SQL.Add(' Left Join Clientes    Transp on Transp.Codigo  = PN.CodTransp');
  SQL.Add(' where PN.Tipo   = 1');
  SQL.Add('   and PN.FlagFaturado = 0');
  if FrameCliente.EditCodigo.asFloat > 0 then
    SQL.Add(' and PN.CodCliente = ' + FrameCliente.EditCodigo.Text);

  with CDSPrincipal do
  begin
    BM := GetBookmark;
    Close;
    CommandText := SQL.Text;
    TratarClientDatasetParaPost(CDSPrincipal);
    Try
      GotoBookmark(BM);
      FreeBookmark(BM);
    except
      FreeBookmark(BM);
    end;
    CarregaItens(CDSPrincipal.FieldByName('Codigo').AsFloat);
  end;

  if EditNumeroID.asFloat = 0 then
    EditNumeroID.asFloat := RetornaProximaSequenciaNumeroID;
end;

procedure TFormProcessamento.FormShow(Sender: TObject);
begin
  inherited;
  BitBtnAlterar.Enabled := False;
  EdDataProc.asDate := Now;
end;

procedure TFormProcessamento.CDSPrincipalAfterOpen(DataSet: TDataSet);
begin
  inherited;
  with CDSPrincipal do
  begin
    FieldByName('Codigo').DisplayLabel       := 'Código';
    FieldByName('DataEmissao').DisplayLabel  := 'Data';
    FieldByName('NomeCliente').DisplayLabel  := 'Cliente';
    FieldByName('NomeVendedor').DisplayLabel := 'Vendedor';
    FieldByName('CondPagto').DisplayLabel    := 'Cond. Pagto';
    FieldByName('ValorTotal').DisplayLabel   := 'Valor Total';

    FieldByName('Codigo').DisplayWidth       := 10;
    FieldByName('DataEmissao').DisplayWidth  := 10;
    FieldByName('NomeCliente').DisplayWidth  := 50;
    FieldByName('NomeVendedor').DisplayWidth := 15;
    FieldByName('CondPagto').DisplayWidth    := 12;
    FieldByName('ValorTotal').DisplayWidth   := 15;
    (FieldByName('ValorTotal') as TNumericField).DisplayFormat  := '#,##0.00';
  end;
end;

procedure TFormProcessamento.BitBtnConfirmarClick(Sender: TObject);
begin
  inherited;
  if (CDSPrincipal.Active = False) or (CDSPrincipal.IsEmpty) then
    Exit;
      
  if FrameCliente.EditCodigo.asFloat = 0 then
  begin
    MessageDlg('Preencha o Cliente!', mtInformation, [mbOk], 0);
    FrameCliente.EditCodigo.SetFocus;
    Exit;
  end;

  if not EdDataProc.IsDate then
  begin
    MessageDlg('Preencha a Data de Processamento!', mtInformation, [mbOk], 0);
    EdDataProc.SetFocus;
    Exit;
  end;


  if ExisteNumeroID = True then
    Exit;  

  if VerificarSelecao = False then
  begin
    MessageDlg('Selecione o(s) Item(ns) para a Geração da NF!', mtInformation, [mbOk], 0);
    dbg_itens.SetFocus;
    Exit;
  end;

  if i_contador_itens >= 23 then
  begin
    Application.MessageBox('O Número Máximo de Itens na Nota foi Atingido','Informação',0);
    Exit;
  end;

  Processar;
end;

procedure TFormProcessamento.BitBtnBuscarClick(Sender: TObject);
begin
  inherited;
  if FrameCliente.EditCodigo.asFloat = 0 then
  begin
    MessageDlg('Preencha o Cliente!', mtInformation, [mbOk], 0);
    FrameCliente.EditCodigo.SetFocus;
    Exit;
  end;
    
  PesquisarPedidos;
end;

procedure TFormProcessamento.FrameClienteSpeedButtonConsultaClick(
  Sender: TObject);
begin
  inherited;
  FrameCliente.SpeedButtonConsultaClick(Sender);
end;

procedure TFormProcessamento.FrameClienteEditCodigoExit(Sender: TObject);
begin
  inherited;
  FrameCliente.EditCodigoExit(Sender);
  if Trim(FrameCliente.EditCodigo.Text) <> '0' then
  begin
    FrameVendedor.EditCodigo.Text := FloatToStr(FrameCliente.r_cod_vendedor);
    FrameVendedor.EditCodigo.OnExit(FrameVendedor.EditCodigo);
  end;
end;

procedure TFormProcessamento.Processar;
Var BM : TBookMark;
begin
  with CDSPrincipal do
  begin
    BM := GetBookMark;
    DisableControls;
    First;
    while not EOF do
    begin
      if FieldByName('STATUS').asInteger = 1 then
      begin
        AlimentarItens_NF;
        SetarPedidoFaturado(FieldByName('CODIGO').asFloat); //VER NÃO ESTÁ MARCANDO        
      end;
      Next;
    end;
    Try
     GotoBookmark(BM);
     FreeBookmark(BM);
    Except
     FreeBookmark(BM);    
    end;
    EnableControls;
  end;

  CarregaDadosEmpresa;
  //UPDATE NO ITEM/PEDIDO PARA FATURADO


  AlimentarDados_NF;
  Grava_NF;
  i_contador_itens := 0;
end;

procedure TFormProcessamento.CarregaItens(Pedido : Double);
begin
  SQL.Clear;
  SQL.Add(' Select IPN.CODPEDIDONF, IPN.TIPO, IPN.SEQUENCIA, IPN.CODPRODUTO, IPN.CODGRUPO, IPN.CLASSIFICACAO,');
  SQL.Add('        IPN.SITTRIB,IPN.QUANTPEDIDA,IPN.VALORUNITARIO,IPN.VALORTOTAL,IPN.ALIQICMS,IPN.VALORDESCONTO,');
  SQL.Add('        IPN.VALORCOMISSAO, P.Descricao as DescricaoProduto, P.Unidade, Cast(0 as SmallInt) as Status,');
  SQL.Add('        IPN.VALORFRETEAPAGAR, Lp.ValorVendaFrete as ValorOriginal, (Lp.ValorVendaFrete - IPN.VALORUNITARIO) as Diferenca,  ');
  SQL.Add('        IPN.PercComissao, IPN.FLAGCOMISSAOALTERADA, IPN.FLAGOK, CASE WHEN IPN.FLAGOK = 1 THEN ''OK'' ELSE '' '' END AS CONF,');
  SQL.Add(' (Cast(IPN.CodGrupo as varchar(6)) || ''.'' || Cast(IPN.CodProduto as varchar(8)) || ');
  SQL.Add(' Case when IPN.Classificacao <> '''' then  ''.'' || Cast(IPN.Classificacao as varchar(7)) ');
  SQL.Add('      else '''' end ) as ProdutoTratado');
  SQL.Add(' from ItemPedidoNota IPN     ');
  SQL.Add(' Left outer Join Produtos P on P.Codigo        = IPN.CodProduto');
  SQL.Add('                           and P.CodGrupo      = IPN.CodGrupo');
  SQL.Add('                           and P.Classificacao = IPN.Classificacao');
  SQL.Add(' Join PedidoNota         PN on PN.Codigo       = IPN.CodPedidoNF');
  SQL.Add('                           and PN.Tipo         = IPN.Tipo');
  SQL.Add(' Left outer Join ListaPreco Lp on Lp.Codigo    = P.CodListaPreco');
  SQL.Add(' where IPN.Tipo         = 1');
  SQL.Add('   and PN.FlagFaturado  = 0');
  SQL.Add('   and IPN.FlagFaturado = 0');
  if FrameCliente.EditCodigo.asFloat > 0 then
    SQL.Add(' and PN.CodCliente = ' + FrameCliente.EditCodigo.Text);

  with CDSItem do
  begin
    Close;
    CommandText := SQL.Text;
    TratarClientDatasetParaPost(CDSItem);
  end;
  FiltraItens(Pedido);  
end;

procedure TFormProcessamento.AlimentarItens_NF;
Var i : Integer;
begin
  if CDSItens_NF.Active = False then
  begin
    with CDSItens_NF do
    begin
      Close;
      FieldDefs.Clear;
      FieldDefs.Assign(CDSItem.FieldDefs);
      for i := 0 to FieldDefs.Count - 1 do
        FieldDefs[i].Required := false;
      CreateDataSet;
      EmptyDataSet;
    end;
  end;

  with CDSItem do
  begin
    First;
    while not EOF do
    begin
      if FieldByName('STATUS').asInteger = 1 then
      begin
        SetarItemFaturado(FieldByName('CODPEDIDONF').asFloat, FieldByName('SEQUENCIA').asFloat);
        CDSItens_NF.Append;
        for i := 0 to FieldCount - 1 do
          CDSItens_NF.Fields[i].Value := Fields[i].Value;
        CDSItens_NF.Post;
      end;
      Next;
    end;
  end;
end;

procedure TFormProcessamento.Grava_NF;
Var TransDesc : TTransactionDesc;
begin
  Try
    TransDesc.TransactionID  := 1;
    TransDesc.IsolationLevel := xilREADCOMMITTED;
    DataModulePrin.SQLConnectionPrin.StartTransaction(TransDesc);
    with DataModulePrin.SQLQueryExecuta do
    begin
      SQL.Clear;
      SQL.Clear;
      SQL.Add(' INSERT INTO PEDIDONOTA (');
      SQL.Add('   CODIGO, TIPO, CODCLIENTE,');
      if FrameVendedor.EditCodigo.asInteger <> 0 then
        SQL.Add('   CODVENDEDOR,  ');
      SQL.Add('   DATAEMISSAO,    ');
      SQL.Add('   VALORFRETE, VALORSEGURO, VALORICMS, VALORIPI, VALOROUTRAS, VALORTOTAL,');
      SQL.Add('   TIPOFRETE, PLACAVEICULO, UFTRANSP, QTDETRANSP, ESPECIE,    ');
      SQL.Add('   MARCA, NUMERO, PESOBRUTO, PESOLIQ, DADOSADICIONAIS, VALORTOTALDESCONTO,');
      SQL.Add('   VALORPRODUTOS, VALORBASESUBST, IEST, CFOP, NATUREZA, VALORCOMISSAO, NUMEROID,');
      SQL.Add('   VALORDESCONTOFINAL, TIPODESCONTOFINAL, VALORFRETEAPAGAR, FLAGOK, FLAGFATURADO, FLAGPROCESSADO )');
      SQL.Add(' VALUES ( ');
      SQL.Add('   :CODIGO, :TIPO, :CODCLIENTE,');
      if FrameVendedor.EditCodigo.asInteger <> 0 then
        SQL.Add('   :CODVENDEDOR,             ');
      SQL.Add('   :DATAEMISSAO,               ');
      SQL.Add('   :VALORFRETE, :VALORSEGURO, :VALORICMS, :VALORIPI, :VALOROUTRAS, :VALORTOTAL,');
      SQL.Add('   :TIPOFRETE, :PLACAVEICULO, :UFTRANSP, :QTDETRANSP, :ESPECIE,');
      SQL.Add('   :MARCA, :NUMERO, :PESOBRUTO, :PESOLIQ, :DADOSADICIONAIS, :VALORTOTALDESCONTO,');
      SQL.Add('   :VALORPRODUTOS, :VALORBASESUBST, :IEST, :CFOP, :NATUREZA, :VALORCOMISSAO, :NUMEROID,');
      SQL.Add('   :VALORDESCONTOFINAL, :TIPODESCONTOFINAL, :VALORFRETEAPAGAR, :FLAGOK, :FLAGFATURADO, :FLAGPROCESSADO )');
      ParamByName('CODIGO').asInteger            := CDS_NF.FieldByName('CODIGO').asInteger;
      ParamByName('TIPO').asInteger              := 2;
      ParamByName('CODCLIENTE').asInteger        := CDS_NF.FieldByName('CODCLIENTE').asInteger;
      if FrameVendedor.EditCodigo.asInteger <> 0 then
        ParamByName('CODVENDEDOR').asInteger     := CDS_NF.FieldByName('CODVENDEDOR').asInteger;
      ParamByName('VALORCOMISSAO').asFloat       := CDS_NF.FieldByName('VALORCOMISSAO').asFloat;
      ParamByName('DATAEMISSAO').asSQLTimesTamp  := CDS_NF.FieldByName('DATAEMISSAO').asSQLTimesTamp;
      ParamByName('NUMEROID').asFloat            := EditNumeroID.asFloat;
      ParamByName('VALORFRETE').asFloat          := CDS_NF.FieldByName('VALORFRETE').asFloat;
      ParamByName('NATUREZA').asString           := CDS_NF.FieldByName('NATUREZA').asString;
      ParamByName('CFOP').asString               := CDS_NF.FieldByName('CFOP').asString;
      ParamByName('IEST').asString               := CDS_NF.FieldByName('IEST').asString;
      ParamByName('VALORBASESUBST').asFloat      := CDS_NF.FieldByName('VALORBASESUBST').asFloat;
      ParamByName('VALORPRODUTOS').asFloat       := CDS_NF.FieldByName('VALORPRODUTOS').asFloat;
      ParamByName('VALORSEGURO').asFloat         := CDS_NF.FieldByName('VALORSEGURO').asFloat;
      ParamByName('VALORICMS').asFloat           := CDS_NF.FieldByName('VALORICMS').asFloat;
      ParamByName('VALORIPI').asFloat            := CDS_NF.FieldByName('VALORIPI').asFloat;
      ParamByName('VALOROUTRAS').asFloat         := CDS_NF.FieldByName('VALOROUTRAS').asFloat;
      ParamByName('VALORTOTALDESCONTO').asFloat  := CDS_NF.FieldByName('VALORTOTALDESCONTO').asFloat;
      ParamByName('VALORTOTAL').asFloat          := CDS_NF.FieldByName('VALORTOTAL').asFloat;
      ParamByName('TIPOFRETE').asInteger         := 0;
      ParamByName('PLACAVEICULO').asString       := CDS_NF.FieldByName('PLACAVEICULO').asString;
      ParamByName('UFTRANSP').asString           := CDS_NF.FieldByName('UFTRANSP').asString;
      ParamByName('QTDETRANSP').asFloat          := CDS_NF.FieldByName('QTDETRANSP').asFloat;
      ParamByName('ESPECIE').asString            := CDS_NF.FieldByName('ESPECIE').asString;
      ParamByName('MARCA').asString              := CDS_NF.FieldByName('MARCA').asString;
      ParamByName('NUMERO').asString             := CDS_NF.FieldByName('NUMERO').asString;
      ParamByName('PESOBRUTO').asFloat           := CDS_NF.FieldByName('PESOBRUTO').asFloat;
      ParamByName('PESOLIQ').asFloat             := CDS_NF.FieldByName('PESOLIQ').asFloat;
      ParamByName('DADOSADICIONAIS').asString    := CDS_NF.FieldByName('DADOSADICIONAIS').asString;
      ParamByName('VALORDESCONTOFINAL').asFloat  := CDS_NF.FieldByName('VALORDESCONTOFINAL').asFloat;
      ParamByName('TIPODESCONTOFINAL').asInteger := CDS_NF.FieldByName('TIPODESCONTOFINAL').asInteger;
      ParamByName('VALORFRETEAPAGAR').asFloat    := CDS_NF.FieldByName('VALORFRETEAPAGAR').asFloat;
      ParamByName('FLAGOK').asFloat              := CDS_NF.FieldByName('FLAGOK').asFloat;
      ParamByName('FLAGFATURADO').asFloat        := 0;
      ParamByName('FLAGPROCESSADO').asFloat      := CDS_NF.FieldByName('FLAGPROCESSADO').asFloat;
      ExecSQL;
    end;
    DataModulePrin.SQLConnectionPrin.Commit(TransDesc);


    GravarItensPedidoNota;    
    
    PesquisarPedidos;
    if CheckBoxImprimir.Checked then
    begin
      AbrirDadosCliente;
      ppReportNF.Print;
      Self.Close;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar a Nota Fiscal! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
end;

function TFormProcessamento.RetornaProximaSequencia : Integer;
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
        SQL.Add('  Set ');
        SQL.Add('   CodNota   = CodNota + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from PedidoNota');
        SQL.Add('  where ((Tipo = 2) and (Codigo = (Select CodNota from UltimaSequencia)))');
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
      SQL.Add('Select');
      SQL.Add('CodNota as Codigo');
      SQL.Add('from UltimaSequencia');
      Open;

      Result := FieldByname('Codigo').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;

function TFormProcessamento.RetornaProximaSequenciaNumeroID : Integer;
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
        SQL.Add('  Set ');
        SQL.Add('  NumeroNF = NumeroNF + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from PedidoNota');
        SQL.Add('  where ((Tipo = 2) and (NumeroID = (Select NumeroNF from UltimaSequencia)))');
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
      SQL.Add('Select');
      SQL.Add('NumeroNF as NumeroID');
      SQL.Add('from UltimaSequencia');
      Open;

      Result := FieldByname('NumeroID').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequenciaNumeroID;
end;



procedure TFormProcessamento.CDSPrincipalAfterScroll(DataSet: TDataSet);
begin
  inherited;
  FiltraItens(CDSPrincipal.FieldByName('Codigo').AsFloat);
end;

procedure TFormProcessamento.CDSItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  with CDSItem do
  begin
    FieldByName('CODPRODUTO').DisplayLabel       := 'Código';
    FieldByName('CODGRUPO').DisplayLabel         := 'Grupo';
    FieldByName('CLASSIFICACAO').DisplayLabel    := 'Class';
    FieldByName('DescricaoProduto').DisplayLabel := 'Descrição';
    FieldByName('QUANTPEDIDA').DisplayLabel      := 'Qtde';
    FieldByName('VALORUNITARIO').DisplayLabel    := 'Vlr Unit.';
    FieldByName('VALORDESCONTO').DisplayLabel    := 'Dscto';
    FieldByName('VALORTOTAL').DisplayLabel       := 'Vlr Total';
    FieldByName('VALORCOMISSAO').DisplayLabel    := 'Comissão'; 

    FieldByName('CODPRODUTO').DisplayWidth       := 7;
    FieldByName('CODGRUPO').DisplayWidth         := 7;
    FieldByName('CLASSIFICACAO').DisplayWidth    := 10;
    FieldByName('DescricaoProduto').DisplayWidth := 30;
    FieldByName('QUANTPEDIDA').DisplayWidth      := 10;
    FieldByName('VALORUNITARIO').DisplayWidth    := 15;
    FieldByName('VALORTOTAL').DisplayWidth       := 15;
    FieldByName('VALORCOMISSAO').DisplayWidth    := 10;
    FieldByName('VALORDESCONTO').DisplayWidth    := 10;

    (FieldByName('VALORUNITARIO') as TNumericField).DisplayFormat := '#,##0.00';
    (FieldByName('VALORTOTAL')    as TNumericField).DisplayFormat := '#,##0.00';
    (FieldByName('VALORCOMISSAO') as TNumericField).DisplayFormat := '#,##0.00';
    (FieldByName('QUANTPEDIDA')   as TNumericField).DisplayFormat := '#,##0.00';
    (FieldByName('VALORDESCONTO') as TNumericField).DisplayFormat := '#,##0.00';

    FieldByName('CODPEDIDONF').Visible := False;
    FieldByName('TIPO').Visible        := False;
    FieldByName('SEQUENCIA').Visible   := False;
    FieldByName('SITTRIB').Visible     := False;
    FieldByName('ALIQICMS').Visible    := False;
    FieldByName('VALORFRETEAPAGAR').Visible  := False;
    FieldByName('UNIDADE').Visible     := False;
    FieldByName('STATUS').Visible      := False;
  end;
end;

procedure TFormProcessamento.btn_ver_pedidoClick(Sender: TObject);
begin
  inherited;
  if (CDSPrincipal.Active = False) or (CDSPrincipal.IsEmpty) then
    Exit;
     
  Try
    Application.CreateForm(TFormPedidoNota, FormPedidoNota);
    FormPedidoNota.InicializaTela(0, CDSPrincipal.FieldByName('CODIGO').AsInteger);
    FormPedidoNota.Visible := False;
    FormPedidoNota.ShowModal;
  Finally
    FormPedidoNota.Free;
    PesquisarPedidos;
  end;
end;

procedure TFormProcessamento.DBGridPrinDblClick(Sender: TObject);
begin
  inherited;
  btn_ver_pedido.OnClick(btn_ver_pedido);
end;

procedure TFormProcessamento.DBGridPrinDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if (CDSPrincipal.Active = False) or (CDSPrincipal.IsEmpty) then
    Exit;
      
  if (Column.Index = 0) then
    ImageListPrin.Draw(DBGridPrin.Canvas,Rect.left + 2,Rect.top,CDSPrincipal.FieldByName('STATUS').asInteger);
end;

procedure TFormProcessamento.dbg_itensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if (CDSItem.Active = False) or (CDSItem.IsEmpty) then
    Exit;
  
  if (Column.Index = 0) then
    ImageListPrin.Draw(dbg_itens.Canvas,Rect.left + 2,Rect.top,CDSItem.FieldByName('STATUS').asInteger);
end;



procedure TFormProcessamento.DBGridPrinCellClick(Column: TColumn);
begin
  inherited;
  if (CDSPrincipal.Active = False) or (CDSPrincipal.IsEmpty) then
    Exit;
      
  if (Column.FieldName = '') then
  begin
    with CDSPrincipal do
    begin
      Edit;
      FieldByname('STATUS').AsInteger := Ifthen(FieldByname('STATUS').AsInteger = 0,1,0);
      Post;

      if FieldByname('STATUS').AsInteger = 0 then
      begin
        with CDSItem do
        begin
          First;
          while not eof do
          begin
            Edit;
            if (i_contador_itens > 0) and (FieldByname('STATUS').AsInteger = 1) then
              i_contador_itens := i_contador_itens - 1;

            FieldByname('STATUS').AsInteger := 0;
            Post;

            Next;
          end;
        end;
      end;
    end;

  end;
end;

procedure TFormProcessamento.dbg_itensCellClick(Column: TColumn);
begin
  inherited;
  if (CDSItem.Active = False) or (CDSItem.IsEmpty) then
    Exit;

  if (Column.FieldName = '') then
  begin
    with CDSItem do
    begin
      Edit;
      if (FieldByname('STATUS').AsInteger = 1) then
      begin
        if (i_contador_itens > 0) then
          i_contador_itens := i_contador_itens - 1;
      end
      else
        i_contador_itens := i_contador_itens + 1;
        
      FieldByname('STATUS').AsInteger := Ifthen(FieldByname('STATUS').AsInteger = 0,1,0);
      Post;
    end;
  end;
end;

procedure TFormProcessamento.FiltraItens(Pedido : Double);
begin
  with CDSItem do
  begin
    Filtered := False;
    Filter   := 'CODPEDIDONF = ' + FloatToStr(Pedido);
    Filtered := True;
  end;
end;


procedure TFormProcessamento.AlimentarDados_NF;
Var i : Integer;
    TotalProdutos,
    ValorTotal,
    ICMS,
    TotalDesconto,
    ValorComissao,
    FreteAPagar,
    FlagOk,
    CodigoNota : Double;


  procedure CalcularValoresTotal;
  begin
    if (CDSItens_NF.Active = False) or (CDSItens_NF.IsEmpty) then
      Exit;

    TotalProdutos := 0;
    ValorTotal    := 0;
    ICMS          := 0;
    TotalDesconto := 0;
    ValorComissao := 0;
    FreteAPagar   := 0;
    ValorComissao := 0;

    with CDSItens_NF do
    begin
      First;
      while not EOF do
      begin
        TotalProdutos := TotalProdutos + FieldByName('ValorUnitario').asFloat;
        ValorTotal    := ValorTotal    + FieldByName('ValorTotal').asFloat;
        ICMS          := ICMS          + (FieldByName('ValorUnitario').asFloat * (FieldByName('AliqICMS').asFloat / 100));
        TotalDesconto := TotalDesconto + ((FieldByName('ValorUnitario').asFloat * FieldByName('QuantPedida').asFloat) *
                                          (FieldByName('ValorDesconto').asFloat / 100));
        FreteAPagar   := FreteAPagar   + FieldByName('ValorFreteAPagar').asFloat;
        ValorComissao := ValorComissao + FieldByName('ValorComissao').asFloat;
        Next;
      end;
    end;
  end;

  procedure Verificar_Comissao;
  Var Tem_Itens_N_conferidos : Boolean;
  begin
    Tem_Itens_N_conferidos := False;
    with CDSItens_NF do
    begin
      First;
      while not EOF do
      begin
        if (FieldByName('FlagOK').AsFloat = 0) and
           (FieldByName('FlagComissaoAlterada').AsFloat = 0) then
        begin
          Tem_Itens_N_conferidos := True;
          Break;
        end;
        Next;
      end;

      if Tem_Itens_N_conferidos = False then
        FlagOk := 1
      else
        FlagOk := 0;
    end;
  end;

begin
  CalcularValoresTotal;
  Verificar_Comissao;

  if CDS_NF.Active = False then
  begin
    with CDS_NF do
    begin
      Close;
      FieldDefs.Clear;
      FieldDefs.Assign(CDSPrincipal.FieldDefs);
      for i := 0 to FieldDefs.Count - 1 do
        FieldDefs[i].Required := false;
      CreateDataSet;
      EmptyDataSet;
    end;
  end;

  CodigoNota := RetornaProximaSequencia;

  with CDS_NF do
  begin
    Append;
    FieldByName('CODIGO').asFloat             := CodigoNota;
    FieldByName('TIPO').asFloat               := 2;
    FieldByName('CODVENDEDOR').asFloat        := FrameVendedor.EditCodigo.asFloat;
    FieldByName('DATAEMISSAO').asDatetime     := EdDataProc.asDate;
    FieldByName('CODCLIENTE').asFloat         := FrameCliente.EditCodigo.asFloat;
    FieldByName('VALORFRETE').asFloat         := 0;
    FieldByName('VALORSEGURO').asFloat        := 0;
    FieldByName('VALORICMS').asFloat          := ICMS;
    FieldByName('VALORIPI').asFloat           := 0;
    FieldByName('VALOROUTRAS').asFloat        := 0;
    FieldByName('VALORTOTAL').asFloat         := ValorTotal;
    FieldByName('VALORTOTALDESCONTO').asFloat := TotalDesconto;
    FieldByName('VALORPRODUTOS').asFloat      := TotalProdutos;
    FieldByName('VALORCOMISSAO').asFloat      := ValorComissao;
    FieldByName('NUMEROID').asFloat           := EditNumeroID.asFloat;
    FieldByName('VALORDESCONTOFINAL').asFloat := 0;
    FieldByName('TIPODESCONTOFINAL').asFloat  := 0;
    FieldByName('VALORFRETEAPAGAR').asFloat   := FreteAPagar;
    FieldByName('FLAGOK').asFloat             := FlagOk;
    FieldByName('FLAGPROCESSADO').asFloat     := 1;
    FieldByName('NOMEVENDEDOR').asString      := FrameVendedor.EditNome.Text;   

    Post;
  end;
end;


Procedure TFormProcessamento.CarregaDadosEmpresa;
begin
  with CDSEmpresa do
  begin
    SQL.Clear;
    SQL.Add(' Select * from Empresa ');

    Close;
    CommandText := SQL.Text;
    Open;
  end;
end;

procedure TFormProcessamento.GravaSequenciaNumeroID;
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
      SQL.Add('  Set ');
      SQL.Add('  NumeroNF = ' + EditNumeroID.Text);
      ExecSQL;
      DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

      Close;
      SQL.Clear;
      SQL.Add('Select Count(*) as Qtde from PedidoNota');
      SQL.Add('  where ((Tipo = 2) and (NumeroID = (Select NumeroNF from UltimaSequencia)))');
      Open;

      if (FieldByName('Qtde').asInteger > 0) then
      begin
        EditNumeroID.SetFocus;
        Application.MessageBox('O Número informado já está Vinculado a Outra Nota!','Erro',0);
      end;
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

procedure TFormProcessamento.EditNumeroIDExit(Sender: TObject);
begin
  inherited;
  if EditNumeroID.asFloat > 0 then
    GravaSequenciaNumeroID;
end;


function TFormProcessamento.VerificarSelecao : Boolean;
Var BM : TBookMark;

  function VerificarSelecao_Itens : Boolean;
  begin
    Result := False;
    with CDSItem do
    begin
      First;
      while not EOF do
      begin
        if FieldByName('STATUS').asInteger = 1 then
        begin
          Result := True;
          Break;
        end;
        Next;
      end;
    end;
  end;
begin
  Result := False;
  with CDSPrincipal do
  begin
    BM := GetBookmark;
    DisableControls;
    First;
    while not EOF do
    begin
      if FieldByName('STATUS').asInteger = 1 then
      begin
        if VerificarSelecao_Itens then
        begin
          Result := True;
          Break;
        end;
      end;
      Next;
    end;
    Try
      GotoBookmark(BM);
      FreeBookmark(BM);
    except
      FreeBookmark(BM);
    end;
    EnableControls;
  end;
end;

procedure TFormProcessamento.SetarItemFaturado(CodPed, Seq : Double);
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
      SQL.Add('Update ITEMPEDIDONOTA');
      SQL.Add('  Set FLAGFATURADO = 1');
      SQL.Add('WHERE CODPEDIDONF = :CODPEDIDONF');
      SQL.Add('  AND TIPO        = 1');
      SQL.Add('  AND SEQUENCIA   = :SEQUENCIA');
      ParambyName('CODPEDIDONF').asFloat := CodPed;
      ParambyName('SEQUENCIA').asFloat   := Seq;
      ExecSQL;
      DataModulePrin.SQLConnectionPrin.Commit(TransDesc);
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Setar o Item como Faturado. O Registro Não Poderá ser Gravado! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
      Close;
    end;
  end;
end;

procedure TFormProcessamento.SetarPedidoFaturado(CodPed : Double);
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
      SQL.Add('Update PEDIDONOTA');
      SQL.Add('  Set FLAGFATURADO = 1');
      SQL.Add('WHERE CODIGO      = :CODIGO');
      SQL.Add('  AND TIPO        = 1');
      SQL.Add('  AND NOT EXISTS(SELECT SEQUENCIA FROM ITEMPEDIDONOTA IM');
      SQL.Add('                 WHERE IM.CODPEDIDONF  = PEDIDONOTA.CODIGO');
      SQL.Add('                   AND IM.TIPO         = 1');
      SQL.Add('                   AND IM.FLAGFATURADO = 0)');
      ParambyName('CODIGO').asFloat := CodPed;
      ExecSQL;
      DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Setar o Pedido como Faturado. O Registro Não Poderá ser Gravado! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
      Close;
    end;
  end;
end;

procedure TFormProcessamento.GravarItensPedidoNota;
Var TransDesc : TTransactionDesc;
    Sequencia : Integer;
begin
  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);
      Sequencia := 0;
      CDSItens_NF.First;
      while not CDSItens_NF.EOF do
      begin
        Sequencia := Sequencia + 1;
        With SQLQueryExecuta do
        begin
          Close;
          SQL.Clear;
          SQL.Add(' INSERT INTO ITEMPEDIDONOTA (');
          SQL.Add('   CODPEDIDONF, TIPO, SEQUENCIA, CODPRODUTO, CODGRUPO, CLASSIFICACAO, ');
          SQL.Add('   SITTRIB, QUANTPEDIDA, VALORUNITARIO, VALORTOTAL, ALIQICMS, VALORDESCONTO, VALORCOMISSAO, VALORFRETEAPAGAR, PERCCOMISSAO,FLAGCOMISSAOALTERADA, FLAGOK, FLAGFATURADO)');
          SQL.Add(' VALUES ( ');
          SQL.Add('   :CODPEDIDONF, :TIPO, :SEQUENCIA, :CODPRODUTO, :CODGRUPO, :CLASSIFICACAO, ');
          SQL.Add('   :SITTRIB, :QUANTPEDIDA, :VALORUNITARIO, :VALORTOTAL, :ALIQICMS, :VALORDESCONTO, :VALORCOMISSAO, :VALORFRETEAPAGAR, :PERCCOMISSAO, :FLAGCOMISSAOALTERADA, :FLAGOK, :FLAGFATURADO)');
          ParamByName('CODPEDIDONF').asInteger    := CDS_NF.FieldByName('CODIGO').AsInteger;
          ParamByName('TIPO').asInteger           := 2;
          ParamByName('SEQUENCIA').asInteger      := Sequencia;
          ParamByName('CODPRODUTO').asInteger     := CDSItens_NF.FieldByName('CODPRODUTO').asInteger;
          ParamByName('CODGRUPO').asInteger       := CDSItens_NF.FieldByName('CodGrupo').asInteger;
          ParamByName('CLASSIFICACAO').asString   := CDSItens_NF.FieldByName('Classificacao').asString;
          ParamByName('SITTRIB').asString         := CDSItens_NF.FieldByName('SitTrib').asString;
          ParamByName('QUANTPEDIDA').asFloat      := CDSItens_NF.FieldByName('QuantPedida').asFloat;
          ParamByName('VALORUNITARIO').asFloat    := CDSItens_NF.FieldByName('ValorUnitario').asFloat;
          ParamByName('VALORTOTAL').asFloat       := CDSItens_NF.FieldByName('ValorTotal').asFloat;
          ParamByName('ALIQICMS').asFloat         := CDSItens_NF.FieldByName('AliqIcms').asFloat;
          ParamByName('VALORDESCONTO').asFloat    := CDSItens_NF.FieldByName('ValorDesconto').asFloat;
          ParamByName('VALORCOMISSAO').asFloat    := CDSItens_NF.FieldByName('ValorComissao').asFloat;
          ParamByName('VALORFRETEAPAGAR').asFloat := CDSItens_NF.FieldByName('ValorFreteAPagar').asFloat;
          ParamByName('PERCCOMISSAO').asFloat     := CDSItens_NF.FieldByName('PercComissao').asFloat;
          ParamByName('FLAGCOMISSAOALTERADA').asInteger := CDSItens_NF.FieldByName('FLAGCOMISSAOALTERADA').asInteger;
          ParamByName('FLAGOK').asInteger := CDSItens_NF.FieldByName('FLAGOK').asInteger;
          ParamByName('FLAGFATURADO').asInteger := 0;
          ExecSQL;
        end;
        CDSItens_NF.Next;
      end;
      SQLConnectionPrin.Commit(TransDesc);
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar o Registro! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
end;


procedure TFormProcessamento.AbrirDadosCliente;
begin
  SQL.Clear;                                                                                
  SQL.Add(' Select Cli.*');                                                                   
  SQL.Add(' from Clientes Cli');                                                              
  SQL.Add(' where Cli.Codigo = ' + FrameCliente.EditCodigo.Text);
  with CDSDadosCliente do
  begin
    Close;
    CommandText := SQL.Text;
    Open;
  end;
end;




procedure TFormProcessamento.LblHoraSaidaGetText(Sender: TObject;
  var Text: String);
begin
  inherited;
  Text := FormatDateTime('hh:mm:ss',Now);
end;

procedure TFormProcessamento.ppDBText9GetText(Sender: TObject;
  var Text: String);
begin
  inherited;
  if Text <> '0' then
    Text := FormataCep(Text)
  else
    Text := '';
end;

procedure TFormProcessamento.ppDBText8GetText(Sender: TObject;
  var Text: String);
begin
  inherited;
  if Text <> '0' then
    Text := FormataCPFCNPJ(Text)
  else
    Text := '';

end;

procedure TFormProcessamento.ppDBText37GetText(Sender: TObject;
  var Text: String);
begin
  inherited;
  if Text <> '' then
    Text := FormataCPFCNPJ(Text);
end;

procedure TFormProcessamento.pplblCondPagtoGetText(Sender: TObject;
  var Text: String);
Var Conteudo : String;
begin
  Conteudo := '';
  with CDS_Duplicatas do
  begin
    if not IsEmpty then
    begin
      First;
      while not EOF do
      begin
        if Conteudo = '' then
          Conteudo := FieldByname('CODIGO').asString + ' | ' + FormatFloat('0.00',FieldByname('VALORDUPLICATA').asFloat) + ' | ' + FieldByname('DATAVENCIMENTO').asString
        else
          Conteudo := Conteudo + ' - ' + FieldByname('CODIGO').asString + ' | ' + FormatFloat('0.00',FieldByname('VALORDUPLICATA').asFloat) + ' | ' + FieldByname('DATAVENCIMENTO').asString;
        Next;
      end;
    end;
  end;
  Text := Conteudo;
end;

procedure TFormProcessamento.ppDBText2GetText(Sender: TObject;
  var Text: String);
begin
  inherited;
  Text := UpperCase(Text);
end;

procedure TFormProcessamento.ppMemoMensagensPrint(Sender: TObject);
begin
  inherited;
  ppMemoMensagens.Lines.Text := CDSEmpresa.FieldByName('MENSAGENS').asString
end;

function TFormProcessamento.ExisteNumeroID : Boolean;
begin
  Result := False;
  
  if EditNumeroID.asFloat = 0 then
    Exit;
    
  with DataModulePrin.SQLQueryPesquisa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select Codigo, NumeroID from PedidoNota ');
    SQL.Add('where NumeroID = :NumeroID');
    ParamByName('NumeroID').asFloat := EditNumeroID.asFloat;
    Open;

    if not IsEmpty then
    begin
      Application.MessageBox(PChar('O Número Informado já foi Associado a outra Nota Fiscal! Código: ' + FieldByName('Codigo').asString),'Informação',0);
      if EditNumeroID.CanFocus then
        EditNumeroID.SetFocus;
      Result := True;
    end;
  end;
end;



procedure TFormProcessamento.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TFormProcessamento.VoltaUltimSequencia;
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
      SQL.Add('  Set NumeroNF   = ' + EditNumeroID.Text + ' - 1');
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


procedure TFormProcessamento.BitBtnFecharClick(Sender: TObject);
begin
  inherited;
  VoltaUltimSequencia;
end;

end.
