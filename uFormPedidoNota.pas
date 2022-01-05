unit uFormPedidoNota;

interface                                                                                    

uses                                                                                        
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TAdvEditP, ExtCtrls, uFrameVendedor, uFrameModelo,                                              
  uFrameCliente, uFrameCondicoesPagto, Buttons, Grids, DBGrids, FMTBcd, DB,                    
  SqlExpr, Provider, DBClient, DBCtrls, ComCtrls, Mask, math,DBXpress, SqlTimSt,                          
  uFramePedidoNota, ppBands, ppClass, myChkBox, ppPrnabl, ppCtrls, ppCache,                                             
  ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppReport, ppStrtch, ppMemo,
  ppModule, raCodMod, MaskUtils, ppVar, Types;
                                                                                            
type
  TFormPedidoNota = class(TForm)
    PnlCabecalho: TPanel;
    Label23: TLabel;
    FrameVendedor: TFrameVendedor;
    FrameCondicoesPagto: TFrameCondicoesPagto;
    PnlBotoes: TPanel;
    Panel3: TPanel;
    BitBtnFechar: TSpeedButton;
    PnlGrid: TPanel;
    CDSPrincipal: TClientDataSet;
    DSPPrincipal: TDataSetProvider;
    SQLPrincipal: TSQLDataSet;
    DS_Principal: TDataSource;
    ComboBoxTipo: TComboBox;
    EditDataEmissao: TAdvEdit;
    Label7: TLabel;
    Label8: TLabel;
    PnlBotoesPrincipais: TPanel;
    BitBtnIncluirPrin: TSpeedButton;
    BitBtnExcluirPrin: TSpeedButton;
    CDSItem: TClientDataSet;
    DS_Item: TDataSource;
    BitBtnImprimir: TSpeedButton;
    CDSNavegador: TClientDataSet;
    DS_Navegador: TDataSource;
    FramePedidoNota: TFramePedidoNota;
    BitBtnConfirmar: TSpeedButton;
    BitBtnCancelar: TSpeedButton;
    ppReportNF: TppReport;
    CDSEmpresa: TClientDataSet;
    DS_Empresa: TDataSource;
    ppDBPipelineEmpresa: TppDBPipeline;
    CDSPrincipalCODIGO: TFMTBCDField;
    CDSPrincipalTIPO: TSmallintField;
    CDSPrincipalCODCLIENTE: TFMTBCDField;
    CDSPrincipalCODVENDEDOR: TFMTBCDField;
    CDSPrincipalCODCONDPAGTO: TFMTBCDField;
    CDSPrincipalDATAEMISSAO: TSQLTimeStampField;
    CDSPrincipalVALORFRETE: TFMTBCDField;
    CDSPrincipalVALORSEGURO: TFMTBCDField;
    CDSPrincipalVALORICMS: TFMTBCDField;
    CDSPrincipalVALORIPI: TFMTBCDField;
    CDSPrincipalVALOROUTRAS: TFMTBCDField;
    CDSPrincipalVALORTOTAL: TFMTBCDField;
    CDSPrincipalCODTRANSP: TFMTBCDField;
    CDSPrincipalTIPOFRETE: TSmallintField;
    CDSPrincipalPLACAVEICULO: TStringField;
    CDSPrincipalUFTRANSP: TStringField;
    CDSPrincipalQTDETRANSP: TFMTBCDField;
    CDSPrincipalESPECIE: TStringField;
    CDSPrincipalMARCA: TStringField;
    CDSPrincipalNUMERO: TStringField;
    CDSPrincipalPESOBRUTO: TFMTBCDField;
    CDSPrincipalPESOLIQ: TFMTBCDField;
    CDSPrincipalDADOSADICIONAIS: TStringField;
    CDSPrincipalVALORTOTALDESCONTO: TFMTBCDField;
    CDSPrincipalNATUREZA: TStringField;
    CDSPrincipalCFOP: TStringField;
    CDSPrincipalIEST: TStringField;
    ppDBPipelinePrin: TppDBPipeline;
    ppDBPipelineItens: TppDBPipeline;
    DS_DadosCliente: TDataSource;
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
    ppDBPipelineDadosCliente: TppDBPipeline;
    CDSPrincipalDESCRCONDPAGTO: TStringField;
    ppDBPipelinePrinppField28: TppField;
    ppDBPipelineItensppField13: TppField;
    ppDBPipelineItensppField14: TppField;
    ppDBPipelinePrinppField29: TppField;
    ppDBPipelinePrinppField30: TppField;
    CDSPrincipalNOMETRANSP: TStringField;
    CDSPrincipalCPFCNPJ: TStringField;
    CDSPrincipalENDERECO: TStringField;
    CDSPrincipalCIDADE: TStringField;
    CDSPrincipalESTADO: TStringField;
    CDSPrincipalRGIE: TStringField;
    ppDBPipelinePrinppField31: TppField;
    ppDBPipelinePrinppField32: TppField;
    ppDBPipelinePrinppField33: TppField;
    ppDBPipelinePrinppField34: TppField;
    ppDBPipelinePrinppField35: TppField;
    ppDBPipelinePrinppField36: TppField;
    CDSPrincipalVALORPRODUTOS: TFMTBCDField;
    CDSPrincipalVALORBASESUBST: TFMTBCDField;
    EditValorComissao: TAdvEdit;
    Label31: TLabel;
    EditPercComissao: TAdvEdit;
    Label32: TLabel;
    CDSPrincipalVALORCOMISSAO: TFMTBCDField;
    sp_calcular_comissao: TSpeedButton;
    ppDBPipelineItensppField15: TppField;
    CDSItemCODPEDIDONF: TFMTBCDField;
    CDSItemTIPO: TSmallintField;
    CDSItemSEQUENCIA: TFMTBCDField;
    CDSItemCODPRODUTO: TFMTBCDField;
    CDSItemCODGRUPO: TFMTBCDField;
    CDSItemCLASSIFICACAO: TStringField;
    CDSItemSITTRIB: TStringField;
    CDSItemQUANTPEDIDA: TFMTBCDField;
    CDSItemVALORUNITARIO: TFMTBCDField;
    CDSItemVALORTOTAL: TFMTBCDField;
    CDSItemALIQICMS: TFMTBCDField;
    CDSItemVALORDESCONTO: TFMTBCDField;
    CDSItemVALORCOMISSAO: TFMTBCDField;
    CDSItemDESCRICAOPRODUTO: TStringField;
    CDSItemUNIDADE: TStringField;
    CDSItemSTATUS: TStringField;
    FrameClientePrin: TFrameCliente;
    PgControlPrin: TPageControl;
    TabSheetDados: TTabSheet;
    Panel2: TPanel;
    PnlBotoesItem: TPanel;
    BitBtnIncluir: TSpeedButton;
    BitBtnAlterar: TSpeedButton;
    BitBtnExcluir: TSpeedButton;
    DBGridItens: TDBGrid;
    TabSheetTransp: TTabSheet;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    FrameTransp: TFrameCliente;
    ComboBoxTipoFrete: TComboBox;
    EditPlaca: TAdvEdit;
    EditUFPlaca: TAdvEdit;
    EditCPFCNPJ: TMaskEdit;
    EditEndereco: TAdvEdit;
    EditMunicipio: TAdvEdit;
    EditUFTransp: TAdvEdit;
    EditRGIE: TAdvEdit;
    EditQtde: TAdvEdit;
    EditEspecie: TAdvEdit;
    EditMarca: TAdvEdit;
    EditNumeroTransp: TAdvEdit;
    EditPesoBruto: TAdvEdit;
    EditPesoLiquido: TAdvEdit;
    TabSheetDadosAd: TTabSheet;
    Label24: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label30: TLabel;
    MemoDadosAdicinais: TMemo;
    EditInscricaoST: TAdvEdit;
    EditValorBaseST: TAdvEdit;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label25: TLabel;
    Label29: TLabel;
    EditValorTotal: TAdvEdit;
    EditFrete: TAdvEdit;
    EditICMS: TAdvEdit;
    EditIPI: TAdvEdit;
    EditOutras: TAdvEdit;
    EditSeguro: TAdvEdit;
    EditTotalDesconto: TAdvEdit;
    EditTotalProdutos: TAdvEdit;
    Label33: TLabel;
    EditNumeroID: TAdvEdit;
    CDSPrincipalNUMEROID: TFMTBCDField;
    NUMEROID: TppField;
    CDSPrincipalNomeVendedor: TStringField;
    ppDBPipelinePrinppField37: TppField;
    ComboBoxNatureza: TComboBox;
    ComboBoxCFOP: TComboBox;
    CDSItemProdutoTratado: TStringField;
    ppDBPipelineItensppField16: TppField;
    CheckBoxImprimirHoraSaida: TCheckBox;
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
    CheckBoxMensagens: TCheckBox;
    Label34: TLabel;
    EditDescontoFinal: TAdvEdit;
    RBDescPercentual: TRadioButton;
    RBDescValor: TRadioButton;
    CheckBoxImprimir: TCheckBox;
    CDSPrincipalVALORDESCONTOFINAL: TFMTBCDField;
    CDSPrincipalTIPODESCONTOFINAL: TSmallintField;
    EditValorTotalReserv: TAdvEdit;
    ppDBPipelinePrinppField38: TppField;
    ppDBPipelinePrinppField39: TppField;
    CDSPrincipalVALORTOTALFINAL: TFMTBCDField;
    ppDBPipelinePrinppField40: TppField;
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
    EditFreteAPagar: TAdvEdit;
    CDSPrincipalVALORFRETEAPAGAR: TFMTBCDField;
    CDSItemVALORFRETEAPAGAR: TFMTBCDField;
    TabSheetDupl: TTabSheet;
    Panel4: TPanel;
    Panel5: TPanel;
    GroupBox1: TGroupBox;
    dbg_duplicatas: TDBGrid;
    GroupBox2: TGroupBox;
    dbg_movimentos: TDBGrid;
    DS_Duplicatas: TDataSource;
    CDS_Duplicatas: TClientDataSet;
    DS_Movimentos: TDataSource;
    CDS_Movimentos: TClientDataSet;
    Label39: TLabel;
    ed_venc_dupl: TAdvEdit;
    ed_valor_dupl: TAdvEdit;
    sp_gravar_parc: TSpeedButton;
    sp_cancelar_parc: TSpeedButton;
    Label40: TLabel;
    BtnGerarParc: TBitBtn;
    CDSEmpresaCODBANCO: TFMTBCDField;
    CDSEmpresaMENSAGEM_CUPOM: TStringField;
    pplblCondPagto: TppLabel;
    CDSItemValorOriginal: TFMTBCDField;
    CDSItemDiferenca: TFMTBCDField;
    CDSItemPERCCOMISSAO: TFMTBCDField;
    CDSItemFLAGCOMISSAOALTERADA: TSmallintField;
    EditOK: TAdvEdit;
    CDSPrincipalFLAGOK: TSmallintField;
    CDSItemFLAGOK: TSmallintField;
    CDSItemCONF: TStringField;
    CDSPrincipalFLAGPROCESSADO: TSmallintField;
    CDSPrincipalDATAIMPRESSAO: TSQLTimeStampField;
    Label35: TLabel;
    DBEdit1: TDBEdit;
    Label36: TLabel;
    DBEdit2: TDBEdit;
    CDSPrincipalLOGIN: TStringField;
    CDSPrincipalCODUSUARIO: TFMTBCDField;
    procedure BitBtnFecharClick(Sender: TObject);
    procedure BitBtnIncluirClick(Sender: TObject);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure BitBtnIncluirPrinClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CDSItemAfterOpen(DataSet: TDataSet);
    procedure DBGridItensDblClick(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure FrameTranspEditCodigoExit(Sender: TObject);
    procedure FramePedidoNotaEditCodigoExit(Sender: TObject);
    procedure ComboBoxTipoChange(Sender: TObject);
    procedure BitBtnExcluirPrinClick(Sender: TObject);
    procedure BitBtnImprimirClick(Sender: TObject);
    procedure FrameVendedorEditCodigoExit(Sender: TObject);
    procedure DBGridItensTitleClick(Column: TColumn);
    procedure ppDBText9GetText(Sender: TObject; var Text: String);
    procedure ppDBText8GetText(Sender: TObject; var Text: String);
    procedure ppDBText37GetText(Sender: TObject; var Text: String);
    procedure EditFreteExit(Sender: TObject);
    procedure EditSeguroExit(Sender: TObject);
    procedure EditIPIExit(Sender: TObject);
    procedure EditOutrasExit(Sender: TObject);
    procedure FramePedidoNotaSpeedButtonConsultaClick(Sender: TObject);
    procedure ComboBoxNaturezaChange(Sender: TObject);
    procedure LblHoraSaidaGetText(Sender: TObject; var Text: String);
    procedure EditNumeroIDExit(Sender: TObject);
    procedure ppDBText2GetText(Sender: TObject; var Text: String);
    procedure ppMemoMensagensPrint(Sender: TObject);
    procedure RBDescPercentualClick(Sender: TObject);
    procedure RBDescValorClick(Sender: TObject);
    procedure EditDescontoFinalExit(Sender: TObject);
    procedure FrameCondicoesPagtoEditCodigoExit(Sender: TObject);
    procedure FrameCondicoesPagtoEditCodigoEnter(Sender: TObject);
    procedure FrameCondicoesPagtoSpeedButtonConsultaClick(Sender: TObject);
    procedure CDS_DuplicatasAfterScroll(DataSet: TDataSet);
    procedure sp_gravar_parcClick(Sender: TObject);
    procedure sp_cancelar_parcClick(Sender: TObject);
    procedure BtnGerarParcClick(Sender: TObject);
    procedure CDS_DuplicatasAfterOpen(DataSet: TDataSet);
    procedure CDS_MovimentosAfterOpen(DataSet: TDataSet);
    procedure dbg_duplicatasDblClick(Sender: TObject);
    procedure pplblCondPagtoGetText(Sender: TObject; var Text: String);
    procedure FrameClientePrinEditCodigoExit(Sender: TObject);
    procedure DBGridItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure MemoDadosAdicinaisEnter(Sender: TObject);
    procedure MemoDadosAdicinaisExit(Sender: TObject);
  private
    { Private declarations }
    SQL : TStringList;
    Inclusao : Boolean;
    CondPagtoAnt : Integer;
    function RetornaProximaSequencia : Integer;
    procedure Incluir;
    procedure VoltaUltimSequencia;
    procedure LimpaTela;
    procedure CarregaItens;
    procedure CalcularValoresTotal;
    procedure ExcluirItem;
    procedure AbrirPedidoNota(CarregarDados : Boolean = False);
    procedure MostrarDadosPedidoNota;
    procedure GravarPedidoNota;
    function  ValidarTela : Boolean;
    procedure GravarItensPedidoNota;
    procedure TrazerDadosTransportadora;
    procedure ExcluirPedidoNota;
    Procedure AlimentaNumSequencia;
    procedure AbrirDadosCliente;
    procedure CalcularComissao;
    procedure ImprimirCupom;
    procedure RepassarComissaoItens;
    procedure CalcularAcrescimosTotal;
    function  ExisteNumeroID : Boolean;
    procedure AlimentarComboCFOP;
    function RetornaProximaSequenciaNumeroID : Integer;
    Procedure CarregaDadosEmpresa;
    procedure GravaSequenciaNumeroID;
    procedure CalcularTotalComDescontoFinal;
    procedure ExibirDuplicatas;
    procedure ExibirMovimentos;
    procedure GerarDuplicatas(Manual : Boolean);
    procedure GravarDuplicatas;
    Function  ExisteDuplicataPaga : Boolean;
    function  VerifValorDuplicatas : Boolean;
    procedure Verificar_Comissao;
    procedure Alterar_Duplicatas;
    function Retorna_Condicoes_Pagto : String;
    procedure DiscriminarDescontoNF;
  public
    { Public declarations }
    NumSequencia : Integer;
    ContadorItens : Integer;
    procedure InicializaTela(Tipo, Codigo : Integer);    

  end;

var
  FormPedidoNota: TFormPedidoNota;

implementation

uses uFormManutencaoItemPedidoNF, uDataModule, uFuncoes, uFormCupom,
  DateUtils, StrUtils;

{$R *.dfm}

procedure TFormPedidoNota.BitBtnFecharClick(Sender: TObject);
begin
  if Inclusao = True then
    VoltaUltimSequencia;
    
  Close;
end;                                                                                         

procedure TFormPedidoNota.BitBtnIncluirClick(Sender: TObject);
begin
  if (not CDSPrincipal.Active) then
    Exit;
  if ComboBoxTipo.ItemIndex = 1 then
  begin
    if ContadorItens >= 23 then
    begin
      Application.MessageBox('O Número Máximo de Itens na Nota foi Atingido','Informação',0);
      Exit;
    end;                                                                                   
  end;  


  Try
    Application.CreateForm(TFormManutencaoItemPedidoNF, FormManutencaoItemPedidoNF);
    FormManutencaoItemPedidoNF.InicializaTela(1,CDSItem);
    FormManutencaoItemPedidoNF.Visible := False;
    FormManutencaoItemPedidoNF.ShowModal;
  Finally
    if FormManutencaoItemPedidoNF.IsOk then
      CalcularValoresTotal;
    ContadorItens := CDSItem.RecordCount;            
    FormManutencaoItemPedidoNF.Free;
  end;
end;

procedure TFormPedidoNota.BitBtnAlterarClick(Sender: TObject);
begin
  if (not CDSPrincipal.Active) then
    Exit;

  if (not CDSItem.Active) or (CDSItem.IsEmpty) then
    exit;

  Try
    Application.CreateForm(TFormManutencaoItemPedidoNF, FormManutencaoItemPedidoNF);
    FormManutencaoItemPedidoNF.InicializaTela(2,CDSItem);
    FormManutencaoItemPedidoNF.Visible := False;
    FormManutencaoItemPedidoNF.ShowModal;
  Finally
    if FormManutencaoItemPedidoNF.IsOk then
      CalcularValoresTotal;
    FormManutencaoItemPedidoNF.Free;
  end;
end;

procedure TFormPedidoNota.FormShow(Sender: TObject);
begin
  Self.Left   := 2;
  Self.Top    := 48;
  Self.Height := 499;
  Self.Width  := 797;
  BitBtnConfirmar.Enabled := False;
  BitBtnCancelar.Enabled  := False;
  FramePedidoNota.EditCodigo.SetFocus;
  PgControlPrin.ActivePage := TabSheetDados;
  FramePedidoNota.vTipo    := (ComboBoxTipo.ItemIndex + 1);
  CarregaDadosEmpresa;
  if FramePedidoNota.EditCodigo.asInteger <> 0 then
    FramePedidoNota.EditCodigo.OnExit(FramePedidoNota.EditCodigo);
end;

procedure TFormPedidoNota.Incluir;
begin
  LimpaTela;
  Inclusao := True;
  BitBtnConfirmar.Enabled   := True;
  BitBtnCancelar.Enabled    := True;
  BitBtnExcluirPrin.Enabled := False;
  BitBtnIncluirPrin.Enabled := False;
  BitBtnImprimir.Enabled    := False;
  FramePedidoNota.EditCodigo.asInteger := RetornaProximaSequencia;
  if ComboBoxTipo.ItemIndex = 1 then
    EditNumeroID.asInteger  := RetornaProximaSequenciaNumeroID;
  EditDataEmissao.asDate    := Now;
  FrameClientePrin.EditCodigo.SetFocus;
  HabilitaFrame(FramePedidoNota,False);
  ComboBoxTipo.Enabled := False;
end;

function TFormPedidoNota.RetornaProximaSequencia : Integer;
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
        if ComboBoxTipo.ItemIndex = 0 then
          SQL.Add('  CodPedido = CodPedido + 1')
        else if ComboBoxTipo.ItemIndex = 1 then
          SQL.Add('  CodNota   = CodNota + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from PedidoNota');
        if ComboBoxTipo.ItemIndex = 0 then
          SQL.Add('  where ((Tipo = 1) and (Codigo = (Select CodPedido from UltimaSequencia)))')
        else if ComboBoxTipo.ItemIndex = 1 then
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
      if ComboBoxTipo.ItemIndex = 0 then
        SQL.Add('CodPedido as Codigo')
      else if ComboBoxTipo.ItemIndex = 1 then
        SQL.Add('CodNota as Codigo');
      SQL.Add('from UltimaSequencia');
      Open;

      Result := FieldByname('Codigo').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;

procedure TFormPedidoNota.BitBtnCancelarClick(Sender: TObject);
begin
  BitBtnConfirmar.Enabled := False;
  BitBtnCancelar.Enabled  := False;
  if Inclusao then
    VoltaUltimSequencia;
  LimpaTela;
end;

procedure TFormPedidoNota.VoltaUltimSequencia;
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
      if ComboBoxTipo.ItemIndex = 0 then
        SQL.Add('  CodPedido = ' + FramePedidoNota.EditCodigo.Text + ' - 1')
      else if ComboBoxTipo.ItemIndex = 1 then
        SQL.Add('  CodNota   = ' + FramePedidoNota.EditCodigo.Text + ' - 1');
        
      if ComboBoxTipo.ItemIndex = 1 then
        SQL.Add('  , NumeroNF   = ' + EditNumeroID.Text + ' - 1');
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

procedure TFormPedidoNota.LimpaTela;
Var i : Integer;
begin
  CondPagtoAnt  := 0;
  Inclusao      := False;
  EditValorTotal.Limpa;
  EditValorTotalReserv.Limpa;
  EditOutras.Limpa;
  EditTotalDesconto.Limpa;
  EditDescontoFinal.Limpa;
  RBDescPercentual.Checked := True;
  EditIPI.Limpa;
  EditICMS.Limpa;
  EditSeguro.Limpa;
  EditFrete.Limpa;
  ComboBoxNatureza.ItemIndex := 0;
  AlimentarComboCFOP;
  EditInscricaoST.Limpa;
  EditValorBaseST.Limpa;
  EditTotalProdutos.Limpa;
  MemoDadosAdicinais.Clear;
  EditPesoLiquido.Limpa;
  EditPesoBruto.Limpa;
  EditNumeroTransp.Limpa;
  EditMarca.Limpa;
  EditEspecie.Limpa;
  EditQtde.Limpa;
  EditRGIE.Limpa;
  EditUFTransp.Limpa;
  EditUFPlaca.Limpa;
  EditMunicipio.Limpa;
  EditEndereco.Limpa;
  EditCPFCNPJ.Clear;
  EditPlaca.Limpa;
  ComboBoxTipoFrete.ItemIndex := 0;
  EditNumeroID.Enabled := (ComboBoxTipo.ItemIndex = 1);
  FrameTransp.LimparFrame;
  FrameVendedor.LimparFrame;
  FrameCondicoesPagto.LimparFrame;
  FrameClientePrin.LimparFrame;
  EditDataEmissao.Limpa;
  EditNumeroID.Limpa;
  EditPercComissao.Limpa;
  EditValorComissao.Limpa;
  EditFreteAPagar.Limpa;
  EditDataEmissao.Enabled := True;
  FramePedidoNota.EditCodigo.Limpa;
  HabilitaFrame(FramePedidoNota,True);
  ComboBoxTipo.Enabled := True;
  FramePedidoNota.EditCodigo.SetFocus;
  CheckBoxImprimir.Checked := True;
  NumSequencia  := 0;
  ContadorItens := 0;
  CDSItem.Close;
  CDSPrincipal.Close;
  BitBtnConfirmar.Enabled   := False;
  BitBtnCancelar.Enabled    := False;
  BitBtnExcluirPrin.Enabled := False;
  BitBtnIncluirPrin.Enabled := True;
  BitBtnImprimir.Enabled    := False;
  CDS_Duplicatas.Close;
  CDS_Movimentos.Close;
  for I := 0 to DBGridItens.Columns.Count - 1 do
    DBGridItens.Columns[I].Title.Font.Style := [];
  PgControlPrin.ActivePage  := TabSheetDados;
end;



procedure TFormPedidoNota.BitBtnIncluirPrinClick(Sender: TObject);
begin
  Incluir;
end;

procedure TFormPedidoNota.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TFormPedidoNota.BitBtnExcluirClick(Sender: TObject);
begin
  if (not CDSPrincipal.Active) then
    Exit;

  if (not CDSItem.Active) or (CDSItem.IsEmpty) then
    exit;

  If Application.MessageBox('Deseja Realmente Excluir o Produto Selecionado?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
  begin
    ExcluirItem;
    CalcularValoresTotal;
  end;
  ContadorItens := CDSItem.RecordCount;  
end;

procedure TFormPedidoNota.CarregaItens;
begin
  SQL.Clear;                       
  SQL.Add(' Select IPN.CODPEDIDONF, IPN.TIPO, IPN.SEQUENCIA, IPN.CODPRODUTO, IPN.CODGRUPO, IPN.CLASSIFICACAO,');
  SQL.Add('        IPN.SITTRIB,IPN.QUANTPEDIDA,IPN.VALORUNITARIO,IPN.VALORTOTAL,IPN.ALIQICMS,IPN.VALORDESCONTO,');
  SQL.Add('        IPN.VALORCOMISSAO, P.Descricao as DescricaoProduto, P.Unidade, Cast(''A'' as Char(1)) as Status,');
  SQL.Add(' (Cast(IPN.CodGrupo as varchar(6)) || ''.'' || Cast(IPN.CodProduto as varchar(8)) || ');
  SQL.Add(' Case when IPN.Classificacao <> '''' then  ''.'' || Cast(IPN.Classificacao as varchar(7)) ');
  SQL.Add('      else '''' end ) as ProdutoTratado, IPN.VALORFRETEAPAGAR, ');
  SQL.Add(' Lp.ValorVendaFrete as ValorOriginal, (Lp.ValorVendaFrete - IPN.VALORUNITARIO) as Diferenca,   ');
  SQL.Add(' IPN.PercComissao, IPN.FLAGCOMISSAOALTERADA, IPN.FLAGOK, CASE WHEN IPN.FLAGOK = 1 THEN ''OK'' ELSE '' '' END AS CONF');
  SQL.Add(' from ItemPedidoNota IPN');
  SQL.Add(' Left outer Join Produtos P on P.Codigo        = IPN.CodProduto');
  SQL.Add('                           and P.CodGrupo      = IPN.CodGrupo');
  SQL.Add('                           and P.Classificacao = IPN.Classificacao');
  SQL.Add(' Left outer Join ListaPreco Lp on Lp.Codigo    = P.CodListaPreco');
  SQL.Add(' where IPN.Tipo        = ' + IntToStr(ComboBoxTipo.ItemIndex + 1));
  SQL.Add('   and IPN.CodPedidoNF = ' + FramePedidoNota.EditCodigo.Text);
  with CDSItem do
  begin
    DisableControls;
    Close;
    CommandText := SQL.Text;
    TratarClientDatasetParaPost(CDSItem);

    Filtered := False;
    Filter   := ' Status <> ''E''';
    Filtered := True;

    ContadorItens := CDSItem.RecordCount;

    IndexFieldNames := 'Sequencia';
    EnableControls;
  end;
end;

procedure TFormPedidoNota.FormCreate(Sender: TObject);
begin
  SQL := TStringList.Create;
end;

procedure TFormPedidoNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SQL.Free;
end;

                                   
procedure TFormPedidoNota.CDSItemAfterOpen(DataSet: TDataSet);                             
begin                             
  with CDSItem do
  begin
    (FieldByName('ValorDesconto') as TNumericField).DisplayFormat := '#,##0.00';
    (FieldByName('QuantPedida') as TNumericField).DisplayFormat   := '#,##0.00';
    (FieldByName('ValorUnitario') as TNumericField).DisplayFormat := '#,##0.00';
    (FieldByName('ValorTotal') as TNumericField).DisplayFormat    := '#,##0.00';
    (FieldByName('AliqIcms') as TNumericField).DisplayFormat      := '#,##0.00';
  end;
end;

procedure TFormPedidoNota.DBGridItensDblClick(Sender: TObject);
begin
  BitBtnAlterar.OnClick(BitBtnAlterar);
end;

procedure TFormPedidoNota.CalcularValoresTotal;
Var BM : TBookMark;
begin
  if (CDSItem.Active = False) or (CDSItem.IsEmpty) then
    Exit;
     
  EditTotalProdutos.asFloat := 0;
  EditValorTotal.asFloat    := 0;
  EditICMS.asFloat          := 0;
  EditTotalDesconto.asFloat := 0;
  EditValorComissao.asFloat := 0;
  EditValorTotalReserv.asFloat := 0;
  EditFreteAPagar.asFloat   := 0;

  with CDSItem do
  begin
    DisableControls;
    BM := GetBookmark;
    First;                                                                                                   
    while not EOF do
    begin                                                                                                     
      EditTotalProdutos.asFloat    := EditTotalProdutos.asFloat + FieldByName('ValorUnitario').asFloat;
      EditValorTotal.asFloat       := EditValorTotal.asFloat + FieldByName('ValorTotal').asFloat;
      EditICMS.asFloat             := EditICMS.asFloat + (FieldByName('ValorUnitario').asFloat * (FieldByName('AliqICMS').asFloat / 100));
      EditTotalDesconto.asFloat    := EditTotalDesconto.asFloat + ((FieldByName('ValorUnitario').asFloat * FieldByName('QuantPedida').asFloat) *
                                                               (FieldByName('ValorDesconto').asFloat / 100));
      EditFreteAPagar.asFloat      := EditFreteAPagar.asFloat + FieldByName('ValorFreteAPagar').asFloat;
      Next;
    end;
    EditValorTotalReserv.asFloat := EditValorTotal.asFloat;
    CalcularAcrescimosTotal;
    EnableControls;
    Try
      GotoBookmark(BM);
      FreeBookmark(BM);
    Except
      FreeBookmark(BM);
    end;
    CalcularComissao;    
    CalcularTotalComDescontoFinal;
  end;
end;


procedure TFormPedidoNota.ExcluirItem;
begin
  with CDSItem do
  begin
    if (NumSequencia = FieldByName('SEQUENCIA').asInteger) then
      NumSequencia := NumSequencia - 1;
        
    if FieldByName('Status').asString = 'I' then
      Delete
    else
    begin
      Edit;
      FieldByName('Status').asString := 'E';
      Post;
    end;
  end;
end;

procedure TFormPedidoNota.AbrirPedidoNota(CarregarDados : Boolean = False);
begin
  SQL.Clear;
  SQL.Add(' Select PN.*, CD.Descricao as DescrCondPagto, Transp.Nome as NomeTransp,');
  SQL.Add(' Transp.CpfCNPJ, Transp.Endereco, Transp.Cidade, Transp.Estado,');
  SQL.Add(' Transp.RGIE, Vend.Nome as NomeVendedor, Usu.Login,');
  SQL.Add(' CASE WHEN TIPODESCONTOFINAL = 0');
  SQL.Add('      THEN (PN.VALORTOTAL - (PN.VALORTOTAL * (PN.VALORDESCONTOFINAL /100)))');
  SQL.Add('      ELSE (PN.VALORTOTAL - PN.VALORDESCONTOFINAL) END AS VALORTOTALFINAL');
  SQL.Add(' from PedidoNota PN');
  SQL.Add(' Left Join CondicoesPagto CD     on CD.Codigo      = PN.CodCondPagto');
  SQL.Add(' Left Join Clientes       Transp on Transp.Codigo  = PN.CodTransp');
  SQL.Add(' Left Join Vendedores     Vend   on Vend.Codigo    = PN.CodVendedor');
  SQL.Add(' Left Join Usuarios       Usu    on Usu.Codigo     = PN.CodUsuario');
  SQL.Add(' where PN.Tipo   = ' + IntToStr(ComboBoxTipo.ItemIndex + 1));
  SQL.Add('   and PN.Codigo = ' + FramePedidoNota.EditCodigo.Text);
  with CDSPrincipal do
  begin
    Close;
    CommandText := SQL.Text;
    Open;

    ExibirDuplicatas;


    if CarregarDados = False then
    begin
      if Inclusao = False then
      begin
        if IsEmpty then
        begin
          Application.MessageBox(PChar(ComboBoxTipo.Text +  ' não Existe no Sistema!'),'Informação',0);
          FramePedidoNota.EditCodigo.SelectAll;
          FramePedidoNota.EditCodigo.SetFocus;
        end
        else
        begin
          Inclusao := False;
          MostrarDadosPedidoNota;
          BitBtnConfirmar.Enabled   := True;
          BitBtnCancelar.Enabled    := True;
          BitBtnExcluirPrin.Enabled := True;
          BitBtnIncluirPrin.Enabled := False;
          BitBtnImprimir.Enabled    := True;
          HabilitaFrame(FramePedidoNota,False);
          ComboBoxTipo.Enabled      := False;
          EditDataEmissao.Enabled   := False;
          if FrameClientePrin.EditCodigo.CanFocus then
            FrameClientePrin.EditCodigo.SetFocus;
        end;
      end;
    end;
  end;
  CarregaItens;
  CalcularValoresTotal;

  if CarregarDados = False then
    AlimentaNumSequencia;
end;

procedure TFormPedidoNota.MostrarDadosPedidoNota;
begin
  with CDSPrincipal do
  begin
    EditDataEmissao.asDate                   := FieldByname('DATAEMISSAO').asDateTime;
    EditNumeroID.asFloat                     := FieldByname('NUMEROID').asFloat;
    FrameClientePrin.EditCodigo.asInteger    := FieldByname('CODCLIENTE').asInteger;
    FrameClientePrin.EditCodigo.OnExit(FrameClientePrin.EditCodigo);
    FrameCondicoesPagto.EditCodigo.asInteger := FieldByname('CODCONDPAGTO').asInteger;
    FrameCondicoesPagto.EditCodigo.OnExit(FrameCondicoesPagto.EditCodigo);
    FrameVendedor.EditCodigo.asInteger       := FieldByname('CODVENDEDOR').asInteger;
    FrameVendedor.EditCodigo.OnExit(FrameVendedor.EditCodigo);
    EditValorComissao.asFloat         := FieldByname('VALORCOMISSAO').asFloat;
    EditFrete.asFloat                 := FieldByname('VALORFRETE').asFloat;
    EditFreteAPagar.asFloat           := FieldByname('VALORFRETEAPAGAR').asFloat;
    ComboBoxNatureza.ItemIndex        := ComboBoxNatureza.Items.IndexOf(FieldByname('NATUREZA').asString);
    AlimentarComboCFOP;
    ComboBoxCFOP.ItemIndex            := ComboBoxCFOP.Items.IndexOf(FieldByname('CFOP').asString);
    if ComboBoxNatureza.ItemIndex = -1 then
    begin
      ComboBoxNatureza.ItemIndex := 0;
      AlimentarComboCFOP;
    end;
    EditInscricaoST.Text      := FieldByname('IEST').asString;
    EditValorBaseST.asFloat   := FieldByname('VALORBASESUBST').asFloat;
    EditTotalProdutos.asFloat := FieldByname('VALORPRODUTOS').asFloat;
    EditSeguro.asFloat        := FieldByname('VALORSEGURO').asFloat;
    EditICMS.asFloat          := FieldByname('VALORICMS').asFloat;
    EditIPI.asFloat           := FieldByname('VALORIPI').asFloat;
    EditOutras.asFloat        := FieldByname('VALOROUTRAS').asFloat;
    EditTotalDesconto.asFloat := FieldByname('VALORTOTALDESCONTO').asFloat;
    EditDescontoFinal.asFloat := FieldByname('VALORDESCONTOFINAL').asFloat;
    RBDescPercentual.Checked  := FieldByname('TIPODESCONTOFINAL').asInteger = 0;
    RBDescValor.Checked       := FieldByname('TIPODESCONTOFINAL').asInteger = 1;
    EditValorTotal.asFloat    := FieldByname('VALORTOTAL').asFloat;
    FrameTransp.EditCodigo.asInteger := FieldByname('CODTRANSP').asInteger;
    FrameTransp.EditCodigo.OnExit(FrameTransp.EditCodigo);
    ComboBoxTipoFrete.ItemIndex    := FieldByname('TIPOFRETE').asInteger - 1;
    EditPlaca.Text                 := FieldByname('PLACAVEICULO').asString;
    EditUFPlaca.Text               := FieldByname('UFTRANSP').asString;
    EditQtde.asFloat               := FieldByname('QTDETRANSP').asFloat;
    EditEspecie.Text               := FieldByname('ESPECIE').asString;
    EditMarca.Text                 := FieldByname('MARCA').asString;
    EditNumeroTransp.Text          := FieldByname('NUMERO').asString;
    EditPesoBruto.asFloat          := FieldByname('PESOBRUTO').asFloat;
    EditPesoLiquido.asFloat        := FieldByname('PESOLIQ').asFloat;
    MemoDadosAdicinais.Lines.Text  := FieldByname('DADOSADICIONAIS').asString;
    EditOK.asInteger               := FieldByname('FLAGOK').asInteger;
  end;
end;

procedure TFormPedidoNota.GravarPedidoNota;
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
        if Inclusao = True then
        begin
          SQL.Clear;
          SQL.Add(' INSERT INTO PEDIDONOTA (');
          SQL.Add('   CODIGO, TIPO, CODCLIENTE,');
          if FrameVendedor.EditCodigo.asInteger <> 0 then
            SQL.Add('   CODVENDEDOR,  ');
          if FrameCondicoesPagto.EditCodigo.asInteger <> 0 then
            SQL.Add('   CODCONDPAGTO, ');
          SQL.Add('   DATAEMISSAO,    ');
          SQL.Add('   VALORFRETE, VALORSEGURO, VALORICMS, VALORIPI, VALOROUTRAS, VALORTOTAL,');
          if FrameTransp.EditCodigo.asInteger <> 0 then
            SQL.Add('   CODTRANSP,      ');
          SQL.Add('   TIPOFRETE, PLACAVEICULO, UFTRANSP, QTDETRANSP, ESPECIE,    ');
          SQL.Add('   MARCA, NUMERO, PESOBRUTO, PESOLIQ, DADOSADICIONAIS, VALORTOTALDESCONTO,');
          SQL.Add('   VALORPRODUTOS, VALORBASESUBST, IEST, CFOP, NATUREZA, VALORCOMISSAO, NUMEROID,');
          SQL.Add('   VALORDESCONTOFINAL, TIPODESCONTOFINAL, VALORFRETEAPAGAR, FLAGOK )');
          SQL.Add(' VALUES ( ');
          SQL.Add('   :CODIGO, :TIPO, :CODCLIENTE,');
          if FrameVendedor.EditCodigo.asInteger <> 0 then
            SQL.Add('   :CODVENDEDOR,             ');
          if FrameCondicoesPagto.EditCodigo.asInteger <> 0 then
            SQL.Add('   :CODCONDPAGTO,            ');
          SQL.Add('   :DATAEMISSAO,               ');
          SQL.Add('   :VALORFRETE, :VALORSEGURO, :VALORICMS, :VALORIPI, :VALOROUTRAS, :VALORTOTAL,');
          if FrameTransp.EditCodigo.asInteger <> 0 then
            SQL.Add('   :CODTRANSP, ');
          SQL.Add('   :TIPOFRETE, :PLACAVEICULO, :UFTRANSP, :QTDETRANSP, :ESPECIE,');
          SQL.Add('   :MARCA, :NUMERO, :PESOBRUTO, :PESOLIQ, :DADOSADICIONAIS, :VALORTOTALDESCONTO,');
          SQL.Add('   :VALORPRODUTOS, :VALORBASESUBST, :IEST, :CFOP, :NATUREZA, :VALORCOMISSAO, :NUMEROID,');
          SQL.Add('   :VALORDESCONTOFINAL, :TIPODESCONTOFINAL, :VALORFRETEAPAGAR,  :FLAGOK )');
        end
        else
        begin
          SQL.Clear;
          SQL.Add(' UPDATE PEDIDONOTA');
          SQL.Add(' SET CODCLIENTE      = :CODCLIENTE,');
          if FrameVendedor.EditCodigo.asInteger <> 0 then
            SQL.Add('   CODVENDEDOR     = :CODVENDEDOR,');
          if FrameCondicoesPagto.EditCodigo.asInteger <> 0 then
            SQL.Add('   CODCONDPAGTO    = :CODCONDPAGTO,');
          SQL.Add('     DATAEMISSAO     = :DATAEMISSAO,');
          SQL.Add('     VALORFRETE      = :VALORFRETE,');
          SQL.Add('     VALORSEGURO     = :VALORSEGURO,');
          SQL.Add('     VALORICMS       = :VALORICMS,');
          SQL.Add('     VALORIPI        = :VALORIPI,');
          SQL.Add('     VALOROUTRAS     = :VALOROUTRAS,');
          SQL.Add('     VALORTOTALDESCONTO = :VALORTOTALDESCONTO,');
          SQL.Add('     VALORTOTAL      = :VALORTOTAL,');
          if FrameTransp.EditCodigo.asInteger <> 0 then
            SQL.Add('   CODTRANSP       = :CODTRANSP,');
          SQL.Add('     TIPOFRETE       = :TIPOFRETE,');
          SQL.Add('     PLACAVEICULO    = :PLACAVEICULO,');
          SQL.Add('     UFTRANSP        = :UFTRANSP,');
          SQL.Add('     QTDETRANSP      = :QTDETRANSP,');
          SQL.Add('     ESPECIE         = :ESPECIE,');
          SQL.Add('     MARCA           = :MARCA,');
          SQL.Add('     NUMERO          = :NUMERO,');
          SQL.Add('     PESOBRUTO       = :PESOBRUTO,');
          SQL.Add('     PESOLIQ         = :PESOLIQ,');
          SQL.Add('     DADOSADICIONAIS = :DADOSADICIONAIS,');
          SQL.Add('     VALORPRODUTOS   = :VALORPRODUTOS,');
          SQL.Add('     VALORBASESUBST  = :VALORBASESUBST,');
          SQL.Add('     IEST            = :IEST,');
          SQL.Add('     CFOP            = :CFOP,');
          SQL.Add('     NATUREZA        = :NATUREZA,');
          SQL.Add('     VALORCOMISSAO   = :VALORCOMISSAO,');
          SQL.Add('     NUMEROID        = :NUMEROID,');
          SQL.Add('     VALORDESCONTOFINAL   = :VALORDESCONTOFINAL,');
          SQL.Add('     TIPODESCONTOFINAL    = :TIPODESCONTOFINAL,');
          SQL.Add('     VALORFRETEAPAGAR     = :VALORFRETEAPAGAR,');
          SQL.Add('     FLAGOK = :FLAGOK');          
          SQL.Add(' WHERE CODIGO  = :CODIGO ');
          SQL.Add('   AND TIPO    = :TIPO ');
        end;
        ParamByName('CODIGO').asInteger            := FramePedidoNota.EditCodigo.asInteger;
        ParamByName('TIPO').asInteger              := ComboBoxTipo.ItemIndex + 1;
        ParamByName('CODCLIENTE').asInteger        := FrameClientePrin.EditCodigo.asInteger;
        if FrameVendedor.EditCodigo.asInteger <> 0 then
          ParamByName('CODVENDEDOR').asInteger       := FrameVendedor.EditCodigo.asInteger;
        if FrameCondicoesPagto.EditCodigo.asInteger <> 0 then
          ParamByName('CODCONDPAGTO').asInteger      := FrameCondicoesPagto.EditCodigo.asInteger;
        ParamByName('VALORCOMISSAO').asFloat       := EditValorComissao.asFloat;
        ParamByName('DATAEMISSAO').asSQLTimesTamp  := DateTimeToSQLTimesTamp(EditDataEmissao.asDate);
        ParamByName('NUMEROID').asFloat            := EditNumeroID.asFloat;
        ParamByName('VALORFRETE').asFloat          := EditFrete.asFloat;
        ParamByName('NATUREZA').asString           := ComboBoxNatureza.Text;
        ParamByName('CFOP').asString               := ComboBoxCFOP.Text;
        ParamByName('IEST').asString               := EditInscricaoST.Text;
        ParamByName('VALORBASESUBST').asFloat      := EditValorBaseST.asFloat;
        ParamByName('VALORPRODUTOS').asFloat       := EditTotalProdutos.asFloat;
        ParamByName('VALORSEGURO').asFloat         := EditSeguro.asFloat;
        ParamByName('VALORICMS').asFloat           := EditICMS.asFloat;
        ParamByName('VALORIPI').asFloat            := EditIPI.asFloat;
        ParamByName('VALOROUTRAS').asFloat         := EditOutras.asFloat;
        ParamByName('VALORTOTALDESCONTO').asFloat  := EditTotalDesconto.asFloat;
        ParamByName('VALORTOTAL').asFloat          := EditValorTotal.asFloat;
        if FrameTransp.EditCodigo.asInteger <> 0 then
          ParamByName('CODTRANSP').asInteger       := FrameTransp.EditCodigo.asInteger;
        ParamByName('TIPOFRETE').asInteger         := ComboBoxTipoFrete.ItemIndex + 1;
        ParamByName('PLACAVEICULO').asString       := EditPlaca.Text;
        ParamByName('UFTRANSP').asString           := EditUFPlaca.Text;
        ParamByName('QTDETRANSP').asFloat          := EditQtde.asFloat;
        ParamByName('ESPECIE').asString            := EditEspecie.Text;
        ParamByName('MARCA').asString              := EditMarca.Text;
        ParamByName('NUMERO').asString             := EditNumeroTransp.Text;
        ParamByName('PESOBRUTO').asFloat           := EditPesoBruto.asFloat;
        ParamByName('PESOLIQ').asFloat             := EditPesoLiquido.asFloat;
        ParamByName('DADOSADICIONAIS').asString    := MemoDadosAdicinais.Lines.Text;
        ParamByName('VALORDESCONTOFINAL').asFloat  := EditDescontoFinal.asFloat;
        ParamByName('TIPODESCONTOFINAL').asInteger := IfThen(RBDescPercentual.Checked,0,1);
        ParamByName('VALORFRETEAPAGAR').asFloat    := EditFreteAPagar.asFloat;
        ParamByName('FLAGOK').asFloat               := EditOK.asInteger;        
        ExecSQL;
        SQLConnectionPrin.Commit(TransDesc);

        GravarItensPedidoNota;
        GravarDuplicatas;        
        if CheckBoxImprimir.Checked then
        begin
          AbrirPedidoNota(True);

          AbrirDadosCliente;
          CarregaDadosEmpresa;          

          if ComboBoxTipo.ItemIndex = 0 then
            ImprimirCupom
          else
          begin
            DiscriminarDescontoNF;
            ppReportNF.Print;

            if CDSItem.Locate('DESCRICAOPRODUTO','DESCONTO TOTAL',[]) then
              CDSItem.Delete;
          end;
        end;
        LimpaTela;
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

procedure TFormPedidoNota.BitBtnConfirmarClick(Sender: TObject);
begin
  if ValidarTela = False then
   exit;

  If (FrameCondicoesPagto.EditCodigo.asFloat > 0) and
     ((CDS_Duplicatas.Active = False) or (CDS_Duplicatas.IsEmpty)) and
     (CDSPrincipal.FieldByName('FLAGPROCESSADO').AsInteger = 0) then
    GerarDuplicatas(False);

  Verificar_Comissao;
  GravarPedidoNota;
end;

function TFormPedidoNota.ValidarTela : Boolean;
begin
  Result := False;
  if EditDataEmissao.IsDate = False then
  begin
    Application.MessageBox('Preencha Corretamente a Data de Emissão','Informação',0);
    EditDataEmissao.SetFocus;
    Exit;
  end;

  if FrameClientePrin.EditCodigo.asInteger = 0 then
  begin
    Application.MessageBox('Preencha Corretamente o Cliente','Informação',0);
    FrameClientePrin.EditCodigo.SetFocus;
    Exit;
  end;

  If (FrameCondicoesPagto.EditCodigo.asFloat = 0) and
     (not CDS_Duplicatas.IsEmpty) then
  begin
    Application.MessageBox('Preencha Corretamente a Condição de Pagamento, pois há Duplicatas!','Informação',0);
    FrameCondicoesPagto.EditCodigo.SetFocus;
    Exit;
  end;

  if (CDSPrincipal.FieldByName('FLAGPROCESSADO').AsInteger = 0) then
  begin
    if VerifValorDuplicatas = False then
    begin
      Application.MessageBox('Valor Total de Parcelas (Duplicatas) não Confere com o Total do Pedido / NF!','Informação',0);
      PgControlPrin.ActivePage := TabSheetDupl;
      Exit;
    end;

    if ((FrameCondicoesPagto.vNroParcelas <> 0) and
        (FrameCondicoesPagto.vNroParcelas <> CDS_Duplicatas.RecordCount)) or
       ((FrameCondicoesPagto.vNroParcelas = 0)  and
        ((CDS_Duplicatas.RecordCount > 1) or (CDS_Duplicatas.RecordCount = 0))) then
    begin
      Application.MessageBox('N.º de Parcelas (Duplicatas) não confere com o N.º de Parcelas da Condição de Pagamento!' + #13 + 'Gere Novamente as Duplicatas!','Informação',0);
      PgControlPrin.ActivePage := TabSheetDupl;
      FrameCondicoesPagto.EditCodigo.SetFocus;
      Exit;
    end;
  end;  

  if ExisteNumeroID = True then
    Exit;

  Result := True;
end;

procedure TFormPedidoNota.GravarItensPedidoNota;
Var TransDesc : TTransactionDesc;
begin
  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);

      CDSItem.DisableControls;
      CDSItem.Filtered := False;
      CDSItem.First;

      //AlimentaNumSequencia;
      while not CDSItem.EOF do
      begin
        With SQLQueryExecuta do
        begin
          Close;
          if CDSItem.FieldByName('Status').asString = 'I' then
          begin
            SQL.Clear;
            SQL.Add(' INSERT INTO ITEMPEDIDONOTA (');
            SQL.Add('   CODPEDIDONF, TIPO, SEQUENCIA, CODPRODUTO, CODGRUPO, CLASSIFICACAO, ');
            SQL.Add('   SITTRIB, QUANTPEDIDA, VALORUNITARIO, VALORTOTAL, ALIQICMS, VALORDESCONTO, VALORCOMISSAO, VALORFRETEAPAGAR, PERCCOMISSAO,FLAGCOMISSAOALTERADA, FLAGOK)');
            SQL.Add(' VALUES ( ');
            SQL.Add('   :CODPEDIDONF, :TIPO, :SEQUENCIA, :CODPRODUTO, :CODGRUPO, :CLASSIFICACAO, ');
            SQL.Add('   :SITTRIB, :QUANTPEDIDA, :VALORUNITARIO, :VALORTOTAL, :ALIQICMS, :VALORDESCONTO, :VALORCOMISSAO, :VALORFRETEAPAGAR, :PERCCOMISSAO, :FLAGCOMISSAOALTERADA, :FLAGOK)');
          end
          else if CDSItem.FieldByName('Status').asString = 'A' then
          begin
            SQL.Clear;
            SQL.Add(' UPDATE ITEMPEDIDONOTA');
            SQL.Add(' SET CODPRODUTO       = :CODPRODUTO,');
            SQL.Add('     CODGRUPO         = :CODGRUPO,');
            SQL.Add('     CLASSIFICACAO    = :CLASSIFICACAO,');
            SQL.Add('     SITTRIB          = :SITTRIB,');
            SQL.Add('     QUANTPEDIDA      = :QUANTPEDIDA,');
            SQL.Add('     VALORUNITARIO    = :VALORUNITARIO,');
            SQL.Add('     VALORTOTAL       = :VALORTOTAL,');
            SQL.Add('     ALIQICMS         = :ALIQICMS, ');
            SQL.Add('     VALORDESCONTO    = :VALORDESCONTO,');
            SQL.Add('     VALORCOMISSAO    = :VALORCOMISSAO,');
            SQL.Add('     VALORFRETEAPAGAR = :VALORFRETEAPAGAR,');
            SQL.Add('     PERCCOMISSAO     = :PERCCOMISSAO,');
            SQL.Add('     FLAGCOMISSAOALTERADA = :FLAGCOMISSAOALTERADA,');
            SQL.Add('     FLAGOK = :FLAGOK');
            SQL.Add(' WHERE CODPEDIDONF    = :CODPEDIDONF ');
            SQL.Add('   AND TIPO           = :TIPO ');
            SQL.Add('   AND SEQUENCIA      = :SEQUENCIA ');
          end
          else if CDSItem.FieldByName('Status').asString = 'E' then
          begin
            SQL.Clear;
            SQL.Add(' DELETE FROM ITEMPEDIDONOTA');
            SQL.Add(' WHERE CODPEDIDONF  = :CODPEDIDONF ');
            SQL.Add('   AND TIPO         = :TIPO ');
            SQL.Add('   AND SEQUENCIA    = :SEQUENCIA ');
          end;
          ParamByName('CODPEDIDONF').asInteger   := FramePedidoNota.EditCodigo.asInteger;
          ParamByName('TIPO').asInteger          := ComboBoxTipo.ItemIndex + 1;

          {if CDSItem.FieldByName('Status').asString = 'I' then
            ParamByName('SEQUENCIA').asInteger     := NumSequencia
          else}
            ParamByName('SEQUENCIA').asInteger     := CDSItem.FieldByName('Sequencia').asInteger;

          if CDSItem.FieldByName('Status').asString <> 'E' then
          begin
            ParamByName('CODPRODUTO').asInteger     := CDSItem.FieldByName('CODPRODUTO').asInteger;
            ParamByName('CODGRUPO').asInteger       := CDSItem.FieldByName('CodGrupo').asInteger;
            ParamByName('CLASSIFICACAO').asString   := CDSItem.FieldByName('Classificacao').asString;
            ParamByName('SITTRIB').asString         := CDSItem.FieldByName('SitTrib').asString;
            ParamByName('QUANTPEDIDA').asFloat      := CDSItem.FieldByName('QuantPedida').asFloat;
            ParamByName('VALORUNITARIO').asFloat    := CDSItem.FieldByName('ValorUnitario').asFloat;
            ParamByName('VALORTOTAL').asFloat       := CDSItem.FieldByName('ValorTotal').asFloat;
            ParamByName('ALIQICMS').asFloat         := CDSItem.FieldByName('AliqIcms').asFloat;
            ParamByName('VALORDESCONTO').asFloat    := CDSItem.FieldByName('ValorDesconto').asFloat;
            ParamByName('VALORCOMISSAO').asFloat    := CDSItem.FieldByName('ValorComissao').asFloat;
            ParamByName('VALORFRETEAPAGAR').asFloat := CDSItem.FieldByName('ValorFreteAPagar').asFloat;
            ParamByName('PERCCOMISSAO').asFloat     := CDSItem.FieldByName('PercComissao').asFloat;
            ParamByName('FLAGCOMISSAOALTERADA').asInteger := CDSItem.FieldByName('FLAGCOMISSAOALTERADA').asInteger;
            ParamByName('FLAGOK').asInteger := CDSItem.FieldByName('FLAGOK').asInteger;            
          end;
          ExecSQL;
        end;
        
        //if CDSItem.FieldByName('Status').asString = 'I' then
          //NumSequencia := NumSequencia + 1;

        CDSItem.Next;
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
  CDSItem.Filtered := False;
  CDSItem.Filter   := ' Status <> ''E''';
  CDSItem.Filtered := True;
  CDSItem.EnableControls;  
end;

procedure TFormPedidoNota.TrazerDadosTransportadora;
begin
  with DataModulePrin.SQLQueryExecuta do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from Clientes where Codigo = ' + IntToStr(FrameTransp.EditCodigo.asInteger));
    Open;

    if not IsEmpty then
    begin
      EditCPFCNPJ.Text   := FieldByName('CPFCNPJ').asString;
      EditEndereco.Text  := FieldByName('Endereco').asString;
      EditMunicipio.Text := FieldByName('Cidade').asString;
      EditUFTransp.Text  := FieldByName('Estado').asString;
      EditRGIE.Text      := FieldByName('RGIE').asString;
    end;
  end;
end;

procedure TFormPedidoNota.FrameTranspEditCodigoExit(Sender: TObject);
begin
  FrameTransp.EditCodigoExit(Sender);
  if FrameTransp.EditCodigo.asInteger <> 0 then
    TrazerDadosTransportadora;
end;

procedure TFormPedidoNota.FramePedidoNotaEditCodigoExit(Sender: TObject);
begin
  if (ActiveControl = ComboBoxTipo) then
    Exit;

  If FramePedidoNota.EditCodigo.asInteger = 0 then
  begin                                                                                     
    FramePedidoNota.EditCodigo.SetFocus;
    Exit;                                                                                   
  end;                                                                                      

  AbrirPedidoNota;
end;                                                                                                                 

procedure TFormPedidoNota.ComboBoxTipoChange(Sender: TObject);
begin                                                                                          
  FramePedidoNota.vTipo := (ComboBoxTipo.ItemIndex + 1);                                      
  EditNumeroID.Enabled  := (ComboBoxTipo.ItemIndex = 1);
end;

procedure TFormPedidoNota.BitBtnExcluirPrinClick(Sender: TObject);                                                  
begin                                                                                          
  if (CDSPrincipal.IsEmpty) or (not CDSPrincipal.Active) then
    Exit;                                                                                                            
    
  If Application.MessageBox(PChar('Deseja Realmente Excluir o(a) ' +  ComboBoxTipo.Text  + ' ?'),'Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
  begin
    ExcluirPedidoNota;
    LimpaTela;    
  end;
end;

procedure TFormPedidoNota.ExcluirPedidoNota;
Var TransDesc : TTransactionDesc;
begin
  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);
      with SQLQueryExecuta do
      begin
        SQL.Clear;
        SQL.Add(' DELETE FROM ITEMPEDIDONOTA');
        SQL.Add(' WHERE CODPEDIDONF  = :CODIGO ');
        SQL.Add('   AND TIPO         = :TIPO   ');
        ParamByName('CODIGO').asInteger := FramePedidoNota.EditCodigo.asInteger;
        ParamByName('TIPO').asInteger   := ComboBoxTipo.ItemIndex + 1;
        ExecSQL;

        SQL.Clear;        
        SQL.Add(' DELETE FROM PEDIDONOTA   ');
        SQL.Add(' WHERE CODIGO   = :CODIGO ');
        SQL.Add('   AND TIPO     = :TIPO   ');
        ParamByName('CODIGO').asInteger := FramePedidoNota.EditCodigo.asInteger;
        ParamByName('TIPO').asInteger   := ComboBoxTipo.ItemIndex + 1;
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);
      end;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Excluir o(a)' + ComboBoxTipo.Text + '. O Processo não pode Continuar! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
      Close;
    end;
  end;
end;

Procedure TFormPedidoNota.AlimentaNumSequencia;
begin
  with DataModulePrin.SQLQueryExecuta do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select Max(Sequencia) as Seq from ItemPedidoNota');
    SQL.Add(' where Tipo        = ' + IntToStr(ComboBoxTipo.ItemIndex + 1));
    SQL.Add('   and CodPedidoNF = ' + FramePedidoNota.EditCodigo.Text);
    Open;

    if IsEmpty then
      NumSequencia := 1
    else
      NumSequencia := FieldByName('Seq').asInteger;
  end;
end;

procedure TFormPedidoNota.BitBtnImprimirClick(Sender: TObject);
begin
  AbrirDadosCliente;
  CarregaDadosEmpresa;

  if ComboBoxTipo.ItemIndex = 0 then
    ImprimirCupom
  else
  begin
    DiscriminarDescontoNF;
    ppReportNF.Print;
    
    if CDSItem.Locate('DESCRICAOPRODUTO','DESCONTO TOTAL',[]) then
      CDSItem.Delete;
  end;
end;
                                                                                             
procedure TFormPedidoNota.AbrirDadosCliente;
begin
  SQL.Clear;                                                                                
  SQL.Add(' Select Cli.*');                                                                   
  SQL.Add(' from Clientes Cli');                                                              
  SQL.Add(' where Cli.Codigo = ' + FrameClientePrin.EditCodigo.Text);                     
  with CDSDadosCliente do
  begin
    Close;
    CommandText := SQL.Text;
    Open;
  end;
end;


procedure TFormPedidoNota.FrameVendedorEditCodigoExit(Sender: TObject);
begin
  FrameVendedor.EditCodigoExit(Sender);
  if FrameVendedor.EditCodigo.asInteger <> 0 then
  begin
    EditPercComissao.asFloat := FrameVendedor.PercComissao;
    if not CDSItem.IsEmpty then
      RepassarComissaoItens;
  end;
end;

procedure TFormPedidoNota.CalcularComissao;
Var BM : TBookMark;
    ValorComissao : Double;
begin
  ValorComissao := 0;
  with CDSItem do
  begin
    DisableControls;
    BM := GetBookmark;
    First;
    while not EOF do
    begin
      ValorComissao := ValorComissao + FieldByName('ValorComissao').asFloat;
      Next;
    end;
    EditValorComissao.asFloat := ValorComissao;
    EnableControls;
    Try
      GotoBookmark(BM);
      FreeBookmark(BM);
    Except
      FreeBookmark(BM);
    end;
  end;
end;


procedure TFormPedidoNota.DBGridItensTitleClick(Column: TColumn);
Var i : Integer;
begin
 if (not CDSItem.Active) or (CDSItem.IsEmpty) then
    Exit;

  if (Column.FieldName = '') then
    Exit;

  if CDSItem.IndexFieldNames = '' then
    CDSItem.IndexFieldNames := Column.FieldName
  else
  begin
    CDSItem.IndexDefs.Clear;
    CDSItem.IndexDefs.Add('idx' + Column.FieldName, Column.FieldName, [ixDescending]);
    CDSItem.IndexName :=  'idx' + Column.FieldName;
  end;

  for I := 0 to DBGridItens.Columns.Count - 1 do
    DBGridItens.Columns[I].Title.Font.Style := [];

  Column.Title.Font.Style := [fsBold];
end;


procedure TFormPedidoNota.ImprimirCupom;
begin
  Try
    Application.CreateForm(TFormCupom, FormCupom);
    FormCupom.Visible := False;
    FormCupom.AlimentaCupom(FramePedidoNota.EditCodigo.asInteger, Retorna_Condicoes_Pagto);
    FormCupom.ShowModal;
  Finally
    FormCupom.Free;
  end;
end;

procedure TFormPedidoNota.RepassarComissaoItens;
Var BM : TBookMark;
    PercDiferenca, PercComissao, ValorComissao : Double;
begin

  with CDSItem do
  begin
    DisableControls;
    BM := GetBookmark;
    First;
    while not EOF do
    begin

      if FieldByName('FlagComissaoAlterada').AsFloat = 0 then
      begin
        if FieldByName('ValorOriginal').AsFloat <> 0 then
        begin
          if FieldByName('Diferenca').asFloat <> 0 then
            PercDiferenca := RoundTo(((FieldByName('Diferenca').asFloat * 100) / FieldByName('ValorOriginal').AsFloat),-2)
          else
            PercDiferenca := 0;
        end
        else
          PercDiferenca := 0;

        PercComissao    := RoundTo((EditPercComissao.asFloat - (FieldByName('VALORDESCONTO').AsFloat + PercDiferenca)),-2);
        if PercComissao > 10 then
          PercComissao  := 10;
        ValorComissao   := RoundTo(((FieldByName('VALORUNITARIO').AsFloat * FieldByName('QUANTPEDIDA').AsFloat)  *
                                                        (PercComissao  / 100)),-2);

        Edit;
        FieldByName('PercComissao').asFloat  := PercComissao;
        FieldByName('ValorComissao').asFloat := ValorComissao;
        Post;
      end;  
      Next;
    end;
    
    EnableControls;
    Try
      GotoBookmark(BM);
      FreeBookmark(BM);
    Except
      FreeBookmark(BM);
    end;
  end;
  CalcularComissao;  
end;


procedure TFormPedidoNota.ppDBText9GetText(Sender: TObject;
  var Text: String);
begin
  if Text <> '0' then
    Text := FormataCep(Text)
  else
    Text := '';
end;

procedure TFormPedidoNota.ppDBText8GetText(Sender: TObject;
  var Text: String);
begin
  if Text <> '0' then
    Text := FormataCPFCNPJ(Text)
  else
    Text := '';
end;

procedure TFormPedidoNota.ppDBText37GetText(Sender: TObject;
  var Text: String);
begin
  if Text <> '' then
    Text := FormataCPFCNPJ(Text);
end;

procedure TFormPedidoNota.CalcularAcrescimosTotal;
begin
  EditValorTotal.asFloat := EditValorTotalReserv.asFloat + EditFrete.asFloat  + EditSeguro.asFloat +
                            EditIPI.asFloat + EditOutras.asFloat;
end;


procedure TFormPedidoNota.EditFreteExit(Sender: TObject);
begin
  CalcularValoresTotal;
end;

procedure TFormPedidoNota.EditSeguroExit(Sender: TObject);
begin
  CalcularValoresTotal;
end;

procedure TFormPedidoNota.EditIPIExit(Sender: TObject);
begin
  CalcularValoresTotal;
end;

procedure TFormPedidoNota.EditOutrasExit(Sender: TObject);
begin
  CalcularValoresTotal;
end;

procedure TFormPedidoNota.FramePedidoNotaSpeedButtonConsultaClick(
  Sender: TObject);
begin
  FramePedidoNota.SpeedButtonConsultaClick(Sender);

end;

function TFormPedidoNota.ExisteNumeroID : Boolean;
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
    SQL.Add('  AND Codigo   <> :Codigo');
    ParamByName('NumeroID').asFloat := EditNumeroID.asFloat;
    ParamByName('Codigo').asFloat   := FramePedidoNota.EditCodigo.asFloat;
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

procedure TFormPedidoNota.AlimentarComboCFOP;
begin
  with ComboBoxCFOP do
  begin
    Items.Clear;
    if ComboBoxNatureza.ItemIndex = 0 then {VENDAS}
    begin
      Items.Add('5.404');
      Items.Add('6.404');
    end
    else if ComboBoxNatureza.ItemIndex = 1 then {DEVOLUÇÃO DE COMPRA}
    begin
      Items.Add('5.202');
      Items.Add('6.202');
    end
    else if ComboBoxNatureza.ItemIndex = 2 then {REMESSA DE MERCADORIA}
    begin
      Items.Add('5.912');
      Items.Add('6.912');
    end
    else if ComboBoxNatureza.ItemIndex = 3 then {RETORNO DE MERCADORIA}
    begin
      Items.Add('5.913');
      Items.Add('6.913');
    end
    else if ComboBoxNatureza.ItemIndex = 4 then {REMESSA PARA TROCA}
      Items.Add('5.949')
    else if ComboBoxNatureza.ItemIndex = 5 then {OUTRAS SAIDAS}
      Items.Add('6.949')
    else if ComboBoxNatureza.ItemIndex = 6 then {PJ COM CNPJ E IE}
      Items.Add('6.102')
    else if ComboBoxNatureza.ItemIndex = 7 then {PJ COM CNPJ}
      Items.Add('6.108');
    ItemIndex := 0;
  end;
end;

procedure TFormPedidoNota.ComboBoxNaturezaChange(Sender: TObject);
begin
  AlimentarComboCFOP;
end;

function TFormPedidoNota.RetornaProximaSequenciaNumeroID : Integer;
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


procedure TFormPedidoNota.LblHoraSaidaGetText(Sender: TObject;
  var Text: String);
begin
  if CheckBoxImprimirHoraSaida.Checked then
    Text := FormatDateTime('hh:mm:ss',Now)
  else
    Text := '';
end;

Procedure TFormPedidoNota.CarregaDadosEmpresa;
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

procedure TFormPedidoNota.GravaSequenciaNumeroID;
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


procedure TFormPedidoNota.EditNumeroIDExit(Sender: TObject);
begin
  if Inclusao then
    GravaSequenciaNumeroID;
end;

procedure TFormPedidoNota.ppDBText2GetText(Sender: TObject;
  var Text: String);
begin
  Text := UpperCase(Text);
end;

procedure TFormPedidoNota.ppMemoMensagensPrint(Sender: TObject);
begin
  if CheckBoxMensagens.Checked then
    ppMemoMensagens.Lines.Text := CDSEmpresa.FieldByName('MENSAGENS').asString
  else
    ppMemoMensagens.Lines.Clear;
end;

procedure TFormPedidoNota.CalcularTotalComDescontoFinal;
begin
  if (EditValorTotal.asFloat > 0) then
  begin
    if RBDescPercentual.Checked then
      EditValorTotal.asFloat := (EditValorTotal.asFloat - (EditValorTotal.asFloat * (EditDescontoFinal.asFloat / 100)))
    else
      EditValorTotal.asFloat := (EditValorTotal.asFloat - EditDescontoFinal.asFloat);
  end;
end;


procedure TFormPedidoNota.RBDescPercentualClick(Sender: TObject);
begin
  CalcularValoresTotal;
  EditDescontoFinal.SetFocus;
end;

procedure TFormPedidoNota.RBDescValorClick(Sender: TObject);
begin
  CalcularValoresTotal;
  EditDescontoFinal.SetFocus;
end;

procedure TFormPedidoNota.EditDescontoFinalExit(Sender: TObject);
begin
  CalcularValoresTotal;
end;




procedure TFormPedidoNota.FrameCondicoesPagtoEditCodigoExit(
  Sender: TObject);
begin
  FrameCondicoesPagto.EditCodigoExit(Sender);

  if (CondPagtoAnt <> 0) and
     (CondPagtoAnt <> FrameCondicoesPagto.EditCodigo.asInteger) then
  begin
    if ExisteDuplicataPaga then
    begin
      Application.MessageBox('Não será possível Alterar a Condição de Pagamento! Há duplicatas Pagas!','Erro',0);
      FrameCondicoesPagto.EditCodigo.asInteger := CondPagtoAnt;
      FrameCondicoesPagto.EditCodigo.OnExit(FrameCondicoesPagto.EditCodigo);
      Exit;
    end;
    CondPagtoAnt := FrameCondicoesPagto.EditCodigo.asInteger;
  end;
end;


procedure TFormPedidoNota.FrameCondicoesPagtoEditCodigoEnter(
  Sender: TObject);
begin
  CondPagtoAnt := FrameCondicoesPagto.EditCodigo.asInteger;
end;

procedure TFormPedidoNota.FrameCondicoesPagtoSpeedButtonConsultaClick(
  Sender: TObject);
begin
  CondPagtoAnt := FrameCondicoesPagto.EditCodigo.asInteger;
  FrameCondicoesPagto.SpeedButtonConsultaClick(Sender);

end;

procedure TFormPedidoNota.ExibirDuplicatas;
begin
  With CDS_Duplicatas do
  begin
    SQL.Clear;
    SQL.Add('Select Dpl.*, CAST(''A'' as Char(1)) as STATUS From Duplicatas Dpl');
    SQL.Add('where Dpl.CODPEDIDONF  = :CODPEDIDONF');
    SQL.Add('  and Dpl.TIPOPEDIDONF = :TIPOPEDIDONF');
    SQL.Add('  Order by Dpl.DataVencimento');

    Close;
    CommandText := SQL.Text;
    Params.ParamByName('CODPEDIDONF').asFloat    := FramePedidoNota.EditCodigo.asFloat;
    Params.ParamByName('TIPOPEDIDONF').asInteger := ComboBoxTipo.ItemIndex + 1;
    AfterScroll := nil;
    TratarClientDatasetParaPost(CDS_Duplicatas);
    AfterScroll := CDS_DuplicatasAfterScroll;

    Filtered := False;
    Filter   := 'STATUS <> ''X''';
    Filtered := True;

    ExibirMovimentos;
  end;
end;

procedure TFormPedidoNota.ExibirMovimentos;
begin
  if CDS_Duplicatas.State <> dsBrowse then
    Exit;

  if Trim(CDS_Duplicatas.FieldByName('CODIGO').asString) = '' then
    Exit;

  With CDS_Movimentos do
  begin
    SQL.Clear;
    SQL.Add('Select * from MOVFINANCEIRO');
    SQL.Add('where CODDUPLICATA  = :CODDUPLICATA');
    SQL.Add('  and TIPO          = :TIPO');
    SQL.Add('  Order by DATAEMISSAO');
    Close;
    CommandText := SQL.Text;
    Params.ParamByName('CODDUPLICATA').asString := CDS_Duplicatas.FieldByName('CODIGO').asString;
    Params.ParamByName('TIPO').asInteger        := CDS_Duplicatas.FieldByName('TIPO').asInteger;
    TratarClientDatasetParaPost(CDS_Movimentos);
  end;
end;


procedure TFormPedidoNota.CDS_DuplicatasAfterScroll(DataSet: TDataSet);
begin
  ExibirMovimentos;
end;

procedure TFormPedidoNota.sp_gravar_parcClick(Sender: TObject);
begin
  if not CDS_Duplicatas.FieldByName('DATAPAGAMENTO').IsNull then
  begin
    Application.MessageBox('Duplicata não poderá ser Alterada pois já foi Paga!','Informação',0);
    Exit;
  end;  

  if (ed_valor_dupl.asFloat <= CDS_Duplicatas.FieldByName('VALORPAGO').asFloat)  then
  begin
    Application.MessageBox('Valor da Duplicata deve ser Maior que o Valor Pago!','Informação',0);
    PgControlPrin.ActivePage := TabSheetDupl;
    ed_valor_dupl.SetFocus;
    Exit;
  end;

  if (ed_venc_dupl.IsDate) and (ed_valor_dupl.asFloat > 0) then
  begin
    with CDS_Duplicatas do
    begin
      Edit;
      FieldByName('DATAVENCIMENTO').asDateTime  := ed_venc_dupl.asDate;
      FieldByName('VALORDUPLICATA').asFloat     := ed_valor_dupl.asFloat;
      Post;
    end;
    ed_venc_dupl.Limpa;
    ed_valor_dupl.Limpa;
  end;
end;

procedure TFormPedidoNota.sp_cancelar_parcClick(Sender: TObject);
begin
  ed_venc_dupl.Limpa;
  ed_valor_dupl.Limpa;
  ed_venc_dupl.SetFocus;
end;

procedure TFormPedidoNota.GerarDuplicatas(Manual : Boolean);
Var ValorTotalDupl : Double;

  Function Montar_Vencimento(Dias : Integer) : TDate;
  Var AnoVenc, MesVenc, DiaVenc : Integer;
  begin
    AnoVenc := YearOf(EditDataEmissao.asDate + Dias);
    MesVenc := MonthOf(EditDataEmissao.asDate + Dias);
    DiaVenc := DayOf(EditDataEmissao.asDate + Dias);

    Result := EncodeDate(AnoVenc,MesVenc,DiaVenc);
  end;

  Function Montar_Valor(NrParc : Integer) : Double;
  begin
    Result := RoundTo((EditValorTotal.asFloat / NrParc),-2);
  end;

  Function RetornaCodigoDuplicata(Parc : Integer) : String;
  Var CDSRetornaCodDupl : TClientDataset;
  begin
    CDSRetornaCodDupl := TClientDataset.Create(Self);
    with CDSRetornaCodDupl do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' Select Count(*) as Qtd from DUPLICATAS');
      SQL.Add(' where CODIGO      = :CODIGO ');
      SQL.Add('   and TIPO        = 1');
      SQL.Add('   and CODPEDIDONF <> :CODPEDIDONF');

      CommandText := SQL.Text;
      Params.ParambyName('CODIGO').asString     := IfThen(ComboBoxTipo.ItemIndex = 0,FramePedidoNota.EditCodigo.Text,EditNumeroID.Text) + '/' + IntToStr(Parc);
      Params.ParambyName('CODPEDIDONF').asFloat := FramePedidoNota.EditCodigo.asFloat;
      TratarClientDatasetParaPost(CDSRetornaCodDupl);

      if FieldByName('Qtd').asInteger > 0 then
        Result := IfThen(ComboBoxTipo.ItemIndex = 0,FramePedidoNota.EditCodigo.Text,EditNumeroID.Text) + '/' + IntToStr(Parc) + '_' + FieldByName('Qtd').AsString
      else
        Result := IfThen(ComboBoxTipo.ItemIndex = 0,FramePedidoNota.EditCodigo.Text,EditNumeroID.Text) + '/' + IntToStr(Parc);
    end;
    CDSRetornaCodDupl.Free;
  end;

  Procedure CriarDuplicatas(Parc, Dias, NrParc : Integer);
  begin
    with CDS_Duplicatas do
    begin
      DisableControls;
      Append;
      FieldByname('CODIGO').asString           := RetornaCodigoDuplicata(Parc);
      FieldByname('TIPO').asInteger            := 1; //receber
      FieldByname('CODCLIENTE').asFloat        := FrameClientePrin.EditCodigo.asFloat; //obrigar a digitacao antes
      FieldByname('CODBANCO').asFloat          := CDSEmpresa.FieldByname('CODBANCO').asFloat;
      FieldByname('DATAEMISSAO').asDatetime    := Now;
      FieldByname('DATAVENCIMENTO').asDatetime := Montar_Vencimento(Dias);
      FieldByname('VALORTOTAL').AsFloat        := EditValorTotal.asFloat;
      FieldByname('VALORDUPLICATA').AsFloat    := Montar_Valor(NrParc);
      FieldByname('VALORPAGO').AsFloat         := 0;
      FieldByname('VALORJUROS').AsFloat        := 0;
      FieldByname('CODPEDIDONF').AsFloat       := FramePedidoNota.EditCodigo.asFloat;
      FieldByname('TIPOPEDIDONF').asInteger    := ComboBoxTipo.ItemIndex + 1;
      FieldByname('STATUS').asString           := 'I';
      Post;

      ValorTotalDupl := ValorTotalDupl + Montar_Valor(NrParc);

      EnableControls;
    end;
  end;

  Procedure Gerar_Novas_Parcelas;
  begin
    if FrameCondicoesPagto.vNroParcelas > 0 then
    begin
      with DataModulePrin.SQLQueryPesquisa do
      begin
        Close;
        SQL.Clear;
        SQL.Add(' Select * from Venc_CondPagto');
        SQL.Add(' where CodCondPagto = :CodCondPagto ');
        SQL.Add(' Order by Parcela ');
        ParambyName('CodCondPagto').AsFloat := FrameCondicoesPagto.EditCodigo.asFloat;
        Open;

        if IsEmpty then
        begin
          Application.MessageBox('Não será possível Gerar Duplicatas!' + #13 + 'Configure Corretamente a Condição de Pagamento, pois não possui parcelas definidas!','Erro',0);
          Exit;
        end;

        First;
        While not EOF do
        begin
          CriarDuplicatas(FieldByname('PARCELA').AsInteger,
                          FieldByname('DIAVENC').AsInteger,
                          FrameCondicoesPagto.vNroParcelas);
          Next;
        end;
      end;
    end
    else
      CriarDuplicatas(1,0,1);
  end;

  Procedure ApagarParcelas;
  begin
    With CDS_Duplicatas do
    begin
      DisableControls;
      First;
      while not EOF do
      begin
        if FieldByname('STATUS').asString = 'A' then
        begin
          Edit;
          FieldByname('STATUS').asString := 'X';
          Post;
        end
        else
          Delete;
      end;
      EnableControls;
    end;
  end;

  Procedure AlterarPrimeiroValor;
  begin
    With CDS_Duplicatas do
    begin
      if IsEmpty then
        Exit;

      DisableControls;
      First;

      Edit;
      FieldByName('VALORDUPLICATA').AsFloat := FieldByName('VALORDUPLICATA').AsFloat + (EditValorTotal.asFloat - ValorTotalDupl);
      Post;

      EnableControls;
    end;
  end;

begin
  ValorTotalDupl := 0;

  if CDS_Duplicatas.Active = False then
    ExibirDuplicatas;

  if Cds_Duplicatas.IsEmpty then
    Gerar_Novas_Parcelas
  else
  begin
    if Manual then
    begin
      if ExisteDuplicataPaga then
      begin
        Application.MessageBox('Não será possível Gerar Duplicatas! Há duplicatas Pagas!','Erro',0);
        Exit;
      end;

      If Application.MessageBox('Deseja Gerar Novamente as Duplicatas e Perder as Duplicatas Atuais?','Confirmação',
                               MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idno then
        Exit;

      ApagarParcelas;
      Gerar_Novas_Parcelas;
    end;
  end;

  if CompareValue(ValorTotalDupl,EditValorTotal.asFloat) <> EqualsValue then
    AlterarPrimeiroValor;
end;


procedure TFormPedidoNota.BtnGerarParcClick(Sender: TObject);
begin
  if (CDSPrincipal.FieldByName('FLAGPROCESSADO').AsInteger = 1) then
    Exit;

  if EditValorTotal.asFloat = 0 then
  begin
    Application.MessageBox('Não há valor para a Geração de Duplicatas!','Informação',0);
    Exit;
  end;

  if FrameCondicoesPagto.EditCodigo.asInteger = 0 then
  begin
    Application.MessageBox('Preencha a Cond. de Pagamento para a Geração de Duplicatas!','Informação',0);
    FrameCondicoesPagto.EditCodigo.SetFocus;
    Exit;
  end;

  if FrameClientePrin.EditCodigo.asInteger = 0 then
  begin
    Application.MessageBox('Preencha o Cliente para a Geração de Duplicatas!','Informação',0);
    FrameClientePrin.EditCodigo.SetFocus;
    Exit;
  end;

  GerarDuplicatas(True);
end;

procedure TFormPedidoNota.CDS_DuplicatasAfterOpen(DataSet: TDataSet);
begin
  with CDS_Duplicatas do
  begin
    (FieldByName('VALORDUPLICATA') as TNumericField).DisplayFormat := '#,##0.00';
    (FieldByName('VALORPAGO') as TNumericField).DisplayFormat      := '#,##0.00';

    FieldByName('CODIGO').DisplayWidth         := 10;
    FieldByName('DATAVENCIMENTO').DisplayWidth := 12;
    FieldByName('VALORDUPLICATA').DisplayWidth := 12;
    FieldByName('VALORPAGO').DisplayWidth      := 12;
    FieldByName('DATAPAGAMENTO').DisplayWidth  := 12;
  end;
end;

procedure TFormPedidoNota.CDS_MovimentosAfterOpen(DataSet: TDataSet);
begin
  with CDS_Movimentos do
  begin
    (FieldByName('VALOR') as TNumericField).DisplayFormat := '#,##0.00';

    FieldByName('DATAEMISSAO').DisplayWidth := 12;
    FieldByName('VALOR').DisplayWidth       := 12;
  end;
end;

procedure TFormPedidoNota.dbg_duplicatasDblClick(Sender: TObject);
begin
  ed_venc_dupl.asDate   := CDS_Duplicatas.FieldByname('DATAVENCIMENTO').asDatetime;
  ed_valor_dupl.asFloat := CDS_Duplicatas.FieldByname('VALORDUPLICATA').asFloat;
  ed_venc_dupl.SetFocus;
end;

procedure TFormPedidoNota.GravarDuplicatas;

Var TransDesc : TTransactionDesc;

begin
  if CDS_Duplicatas.IsEmpty then
    Exit;

  CDS_Duplicatas.DisableControls;
  CDS_Duplicatas.Filtered := False;

  CDS_Duplicatas.IndexDefs.Clear;
  CDS_Duplicatas.IndexDefs.Add('idxSTATUS', 'STATUS', [ixDescending]);
  CDS_Duplicatas.IndexName :=  'idxSTATUS';


  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);
      With SQLQueryExecuta do
      begin
        CDS_Duplicatas.First;
        while not CDS_Duplicatas.EOF do
        begin
          Close;
          if CDS_Duplicatas.FieldByName('STATUS').asString = 'I' then
          begin
            SQL.Clear;
            SQL.Add(' INSERT INTO DUPLICATAS (');
            SQL.Add('    CODIGO, TIPO, CODCLIENTE, CODBANCO, DATAEMISSAO, DATAVENCIMENTO, ');
            SQL.Add('    VALORTOTAL, VALORDUPLICATA, VALORPAGO,  VALORJUROS,');
            SQL.Add('    CODPEDIDONF, TIPOPEDIDONF)');
            SQL.Add(' VALUES(:CODIGO, :TIPO, :CODCLIENTE, :CODBANCO, :DATAEMISSAO, :DATAVENCIMENTO, ');
            SQL.Add('    :VALORTOTAL, :VALORDUPLICATA, :VALORPAGO,  :VALORJUROS,');
            SQL.Add('    :CODPEDIDONF, :TIPOPEDIDONF)');
            ParamByName('CODIGO').asString  := CDS_Duplicatas.FieldByName('CODIGO').asString;
          end
          else if CDS_Duplicatas.FieldByName('STATUS').asString = 'A' then
          begin
            SQL.Clear;
            SQL.Add(' UPDATE DUPLICATAS');
            SQL.Add(' SET DATAVENCIMENTO = :DATAVENCIMENTO,');
            SQL.Add('     VALORDUPLICATA = :VALORDUPLICATA,');
            SQL.Add('     CODCLIENTE     = :CODCLIENTE');
            SQL.Add(' WHERE CODIGO = :CODIGO');
            SQL.Add('   AND TIPO  = :TIPO');
            ParamByName('CODIGO').asString     := CDS_Duplicatas.FieldByName('CODIGO').asString;
            ParamByName('CODCLIENTE').asFloat  := CDS_Duplicatas.FieldByName('CODCLIENTE').asFloat;
          end
          else if CDS_Duplicatas.FieldByName('STATUS').asString = 'X' then
          begin
            SQL.Clear;
            SQL.Add(' DELETE FROM DUPLICATAS');
            SQL.Add(' WHERE CODIGO = :CODIGO');
            SQL.Add('   AND TIPO  = :TIPO');
            ParamByName('CODIGO').asString  := CDS_Duplicatas.FieldByName('CODIGO').asString;
          end;
          ParamByName('TIPO').asInteger  := 1;

          if CDS_Duplicatas.FieldByName('STATUS').asString = 'I' then
          begin
            ParamByName('CODCLIENTE').asFloat            := CDS_Duplicatas.FieldByName('CODCLIENTE').asFloat;
            ParamByName('CODBANCO').asFloat              := CDS_Duplicatas.FieldByName('CODBANCO').asFloat;
            ParamByName('DATAEMISSAO').asSQLTimesTamp    := DateTimeToSQLTimeStamp(CDS_Duplicatas.FieldByName('DATAEMISSAO').asDateTime);
            ParamByName('VALORTOTAL').asFloat            := CDS_Duplicatas.FieldByName('VALORTOTAL').asFloat;
            ParamByName('VALORPAGO').asFloat             := CDS_Duplicatas.FieldByName('VALORPAGO').asFloat;
            ParamByName('VALORJUROS').asFloat            := CDS_Duplicatas.FieldByName('VALORJUROS').asFloat;
            ParamByName('CODPEDIDONF').asFloat           := CDS_Duplicatas.FieldByName('CODPEDIDONF').asFloat;
            ParamByName('TIPOPEDIDONF').asInteger        := CDS_Duplicatas.FieldByName('TIPOPEDIDONF').asInteger;
          end;

          if CDS_Duplicatas.FieldByName('STATUS').asString <> 'X' then
          begin
            ParamByName('DATAVENCIMENTO').asSQLTimesTamp := DateTimeToSQLTimeStamp(CDS_Duplicatas.FieldByName('DATAVENCIMENTO').asDateTime);
            ParamByName('VALORDUPLICATA').asFloat        := CDS_Duplicatas.FieldByName('VALORDUPLICATA').asFloat;
          end;
          ExecSQL;

          CDS_Duplicatas.Next;
        end;
        SQLConnectionPrin.Commit(TransDesc);
      end;
      CDS_Duplicatas.Filtered := True;
      CDS_Duplicatas.EnableControls;
    end;
  Except
    on e: exception do
    begin
      CDS_Duplicatas.Filtered := True;
      CDS_Duplicatas.EnableControls;      
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar as Duplicatas! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
end;

Function TFormPedidoNota.ExisteDuplicataPaga : Boolean;
begin
  Result := False;
  With CDS_Duplicatas do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
      if FieldByname('VALORPAGO').asFloat <> 0 then
      begin
        Result := True;
        Break;
      end;
      Next;
    end;
    EnableControls;
  end;
end;

function TFormPedidoNota.VerifValorDuplicatas : Boolean;
Var ValorTotalDupl : Double;
begin
  ValorTotalDupl := 0;


  With CDS_Duplicatas do
  begin
    if IsEmpty then
    begin
      Result := True;
      Exit;
    end;

    DisableControls;
    First;
    while not EOF do
    begin
      ValorTotalDupl := ValorTotalDupl + FieldByName('VALORDUPLICATA').AsFloat;
      Next;
    end;
    EnableControls;
  end;

  Result := (CompareValue(ValorTotalDupl,EditValorTotal.asFloat) = EqualsValue);
end;



procedure TFormPedidoNota.pplblCondPagtoGetText(Sender: TObject;
  var Text: String);
begin
  Text := Retorna_Condicoes_Pagto;
end;

procedure TFormPedidoNota.FrameClientePrinEditCodigoExit(Sender: TObject);
begin
  FrameClientePrin.EditCodigoExit(Sender);
  if Trim(FrameClientePrin.EditCodigo.Text) <> '0' then
  begin
    FrameVendedor.EditCodigo.Text := FloatToStr(FrameClientePrin.r_cod_vendedor);
    FrameVendedor.EditCodigo.OnExit(FrameVendedor.EditCodigo);
    Alterar_Duplicatas;

    if ComboBoxTipo.ItemIndex = 1 then {NF}
    begin
      if ComboBoxNatureza.ItemIndex = 0 then {VENDAS}
      begin
        If (FrameClientePrin.s_uf <> 'SP') then
          ComboBoxCFOP.ItemIndex := 1
        else
          ComboBoxCFOP.ItemIndex := 0;
      end;    
    end;
  end;
end;

procedure TFormPedidoNota.Verificar_Comissao;
Var BM : TBookMark;
    Tem_Itens_N_conferidos : Boolean;
begin
  Tem_Itens_N_conferidos := False;
  with CDSItem do
  begin
    DisableControls;
    BM := GetBookmark;
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
      EditOk.asInteger := 1
    else
      EditOk.asInteger := 0;

    EnableControls;
    Try
      GotoBookmark(BM);
      FreeBookmark(BM);
    Except
      FreeBookmark(BM);
    end;
  end;
end;

procedure TFormPedidoNota.InicializaTela(Tipo, Codigo : Integer);
begin
  ComboBoxTipo.ItemIndex := Tipo;
  FramePedidoNota.EditCodigo.asInteger := Codigo;
end;

procedure TFormPedidoNota.Alterar_Duplicatas;
begin
  with CDS_Duplicatas do
  begin
    if not IsEmpty then
    begin
      DisableControls;
      First;
      While not EOF do
      begin
        Edit;
        FieldByname('CODCLIENTE').asFloat := FrameClientePrin.EditCodigo.asFloat;
        Post;
        Next;
      end;
      EnableControls;
    end;
  end;
end;





procedure TFormPedidoNota.DBGridItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if UpperCase(Column.FieldName) = 'CONF'  then
  begin
    DBGridItens.Canvas.Font.Color   := clRed;
    DBGridItens.Canvas.Font.Style   := [fsBold];
    DBGridItens.Canvas.FillRect(Rect);
    DBGridItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

function TFormPedidoNota.Retorna_Condicoes_Pagto : String;
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
          Conteudo := FieldByname('CODIGO').asString + ' | R$' + FormatFloat('0.00',FieldByname('VALORDUPLICATA').asFloat) + ' | ' + FieldByname('DATAVENCIMENTO').asString
        else
          Conteudo := Conteudo + ' - ' + FieldByname('CODIGO').asString + ' | RS' + FormatFloat('0.00',FieldByname('VALORDUPLICATA').asFloat) + ' | ' + FieldByname('DATAVENCIMENTO').asString;
        Next;
      end;
    end;
  end;
  Result := Conteudo;
end;

procedure TFormPedidoNota.MemoDadosAdicinaisEnter(Sender: TObject);
begin
  Self.KeyPreview := False;
end;

procedure TFormPedidoNota.MemoDadosAdicinaisExit(Sender: TObject);
begin
  Self.KeyPreview := True;
end;

procedure TFormPedidoNota.DiscriminarDescontoNF;
Var r_valor_desconto : Real;

  procedure Calcular_Desconto;
  begin
    r_valor_desconto := EditTotalDesconto.asFloat;
    if RBDescPercentual.Checked then
      r_valor_desconto := r_valor_desconto +  (((EditValorTotalReserv.asFloat + EditFrete.asFloat  + EditSeguro.asFloat +
                                                 EditIPI.asFloat + EditOutras.asFloat) - EditTotalDesconto.asFloat)
                                                   * (EditDescontoFinal.asFloat / 100))
    else
      r_valor_desconto := r_valor_desconto + EditDescontoFinal.asFloat;
  end;
begin
  Calcular_Desconto;

  if (r_valor_desconto = 0) or (FormPedidoNota.ComboBoxTipo.ItemIndex = 0) then
    Exit;

  with DataModulePrin.SQLQueryPesquisa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from Produtos ');
    SQL.Add('where DESCRICAO = ''DESCONTO TOTAL''');
    Open;
  end;

  with CDSItem do
  begin
    ContadorItens  := ContadorItens + 1;

    Append;
    NumSequencia   := NumSequencia + 1;
    FieldByName('CodPedidoNF').asInteger     := FormPedidoNota.FramePedidoNota.EditCodigo.asInteger;
    FieldByName('Tipo').asInteger            := FormPedidoNota.ComboBoxTipo.ItemIndex + 1;
    FieldByName('Sequencia').asInteger       := FormPedidoNota.NumSequencia;
    FieldByName('CodProduto').asInteger      := DataModulePrin.SQLQueryPesquisa.FieldByName('Codigo').asInteger;
    FieldByName('DescricaoProduto').asString := DataModulePrin.SQLQueryPesquisa.FieldByName('Descricao').asString;
    FieldByName('CodGrupo').asInteger        := DataModulePrin.SQLQueryPesquisa.FieldByName('CodGrupo').asInteger;
    FieldByName('Classificacao').asString    := DataModulePrin.SQLQueryPesquisa.FieldByName('Classificacao').asString;
    FieldByName('SitTrib').asString          := '';
    FieldByName('QuantPedida').asFloat       := 1;
    FieldByName('ValorUnitario').asFloat     := r_valor_desconto;
    FieldByName('ValorTotal').asFloat        := r_valor_desconto;
    FieldByName('AliqICMS').asFloat          := 0;
    FieldByName('ValorDesconto').asFloat     := 0;
    FieldByName('ValorComissao').asFloat     := 0;
    FieldByName('ValorFreteaPagar').asFloat  := 0;
    FieldByName('PercComissao').asFloat      := 0;
    FieldByName('FlagComissaoAlterada').asInteger := 0;
    FieldByName('FlagOK').asInteger          := 0;
    FieldByName('Conf').asString             := '';
    FieldByName('Status').asString           := 'Z';
    Post;
  end;
end;



end.





