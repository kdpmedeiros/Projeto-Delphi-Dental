unit uFormCotacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameCliente, uFramePedidoNota, StdCtrls, TAdvEditP,
  uFrameCondicoesPagto, uFrameModelo, uFrameVendedor, Buttons, ExtCtrls,
  DBCtrls, Grids, DBGrids, FMTBcd, DB, SqlExpr, Provider, DBClient, DBXpress,
  SqlTimSt, DateUtils, Types;

type
  TFormCotacoes = class(TForm)
    PnlCabecalho: TPanel;
    Label23: TLabel;
    Label8: TLabel;
    FrameVendedor: TFrameVendedor;
    EditDataEmissao: TAdvEdit;
    FramePedidoNota: TFramePedidoNota;
    GroupBoxDadosContato: TGroupBox;
    RadioButtonCadastrado: TRadioButton;
    RadioButtonNaoCadastrado: TRadioButton;
    PnlCadastrado: TPanel;
    FrameClientePrin: TFrameCliente;
    Label2: TLabel;
    DBText1: TDBText;
    PnlNaoCadastrado: TPanel;
    EditNome: TAdvEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
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
    PnlBotoes: TPanel;
    Panel3: TPanel;
    BitBtnFechar: TSpeedButton;
    PnlBotoesPrincipais: TPanel;
    BitBtnIncluirPrin: TSpeedButton;
    BitBtnExcluirPrin: TSpeedButton;
    BitBtnImprimir: TSpeedButton;
    BitBtnConfirmar: TSpeedButton;
    BitBtnCancelar: TSpeedButton;
    FrameCondicoesPagto: TFrameCondicoesPagto;
    GroupBoxProdutos: TGroupBox;
    DBGridItens: TDBGrid;
    PnlBotoesItem: TPanel;
    BitBtnIncluir: TSpeedButton;
    BitBtnAlterar: TSpeedButton;
    BitBtnExcluir: TSpeedButton;
    GroupBox1: TGroupBox;
    DBGridCotacoes: TDBGrid;
    CDSPrincipal: TClientDataSet;
    CDSPrincipalCODIGO: TFMTBCDField;
    CDSPrincipalTIPO: TSmallintField;
    CDSPrincipalCODCLIENTE: TFMTBCDField;
    CDSPrincipalCODVENDEDOR: TFMTBCDField;
    CDSPrincipalCODCONDPAGTO: TFMTBCDField;
    CDSPrincipalDATAEMISSAO: TSQLTimeStampField;
    CDSPrincipalVALORTOTAL: TFMTBCDField;
    DSPPrincipal: TDataSetProvider;
    SQLPrincipal: TSQLDataSet;
    DS_Principal: TDataSource;
    CDSCotacoes: TClientDataSet;
    DS_CotacoesMemoria: TDataSource;
    DS_Item: TDataSource;
    CDSItem: TClientDataSet;
    CDSPrincipalUSUARIO: TStringField;
    Label9: TLabel;
    EditValorTotal: TAdvEdit;
    CheckBoxTransf: TCheckBox;
    CDSCotacoesMemoria: TClientDataSet;
    CDSPrincipalCLICAD: TIntegerField;
    CDSPrincipalNOMECONTATO: TStringField;
    CDSPrincipalTELCOMERCIAL1: TStringField;
    CDSPrincipalTELCOMERCIAL2: TStringField;
    CDSPrincipalTELFAX: TStringField;
    CDSPrincipalTELRESIDENCIAL: TStringField;
    CDSPrincipalTELCELULAR: TStringField;
    CDSPrincipalCODUSUARIO: TFMTBCDField;
    CDSItemCODPEDIDONF: TFMTBCDField;
    CDSItemTIPO: TSmallintField;
    CDSItemSEQUENCIA: TFMTBCDField;
    CDSItemCODPRODUTO: TFMTBCDField;
    CDSItemCODGRUPO: TFMTBCDField;
    CDSItemCLASSIFICACAO: TStringField;
    CDSItemQUANTPEDIDA: TFMTBCDField;
    CDSItemVALORUNITARIO: TFMTBCDField;
    CDSItemVALORTOTAL: TFMTBCDField;
    CDSItemQUANTIDADE: TFMTBCDField;
    CDSItemDESCRICAOPRODUTO: TStringField;
    CDSItemUNIDADE: TStringField;
    CDSItemSTATUS: TStringField;
    CDSItemEMPMELHORPRECO: TIntegerField;
    CDSPrincipalFLAGPEDIDO: TSmallintField;
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
    procedure BitBtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButtonNaoCadastradoClick(Sender: TObject);
    procedure RadioButtonCadastradoClick(Sender: TObject);
    procedure BitBtnIncluirClick(Sender: TObject);
    procedure BitBtnIncluirPrinClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FramePedidoNotaEditCodigoExit(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure CDSItemAfterOpen(DataSet: TDataSet);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure DBGridItensDblClick(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure CDSItemAfterScroll(DataSet: TDataSet);
    procedure DBGridCotacoesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure BitBtnExcluirPrinClick(Sender: TObject);
    procedure BitBtnImprimirClick(Sender: TObject);
    procedure FramePedidoNotaSpeedButtonConsultaClick(Sender: TObject);
  private
    { Private declarations }
    Inclusao : Boolean;
    SQL : TStringList;
    CodPedidoCotacao : Double;
    procedure LimpaTela;
    function  RetornaProximaSequencia : Integer;
    procedure Incluir;
    procedure MostrarDadosCotacao;
    procedure AbrirCotacao;
    procedure CarregaItens;
    Procedure AlimentaNumSequencia;
    procedure VoltaUltimSequencia;
    procedure ExcluirItem;
    Procedure TrazerCotacoes;
    Procedure MontaManutencao;
    procedure CalcularValoresTotal;
    function  ValidarTela : Boolean;
    procedure GravarItensCotacaoOuPedido(Tipo : Integer);
    procedure ImprimirCupom;
    procedure GravarDadosCotacao(TransfEmPedido : Boolean);
    procedure GravarCotacao;
    procedure ExcluirCotacoes;
    procedure Marca_MelhorPreco;
    procedure TransformarEmPedido;
    procedure GravarCotacaoOuPedido(Tipo : Integer);
    function  RetornaProximaSequenciaPedido : Integer;
    Procedure CarregaDadosEmpresa;
    procedure GravarDuplicatas;
    procedure GerarDuplicatas;

  public
    { Public declarations }
    NumSequencia : Integer;    
  end;

var
  FormCotacoes: TFormCotacoes;

implementation

uses uFormManutencaoItemCotacao, uDataModule, uFuncoes,
  uFormManutencaoItemPedidoNF, uFormCupom, Math;

{$R *.dfm}

procedure TFormCotacoes.BitBtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCotacoes.FormShow(Sender: TObject);
begin
  Self.Left   := 2;
  Self.Top    := 48;
  Self.Height := 499;
  Self.Width  := 797;
  BitBtnConfirmar.Enabled := False;
  BitBtnCancelar.Enabled  := False;
  FramePedidoNota.EditCodigo.SetFocus;
  FramePedidoNota.vTipo    := 3;
end;

procedure TFormCotacoes.RadioButtonNaoCadastradoClick(Sender: TObject);
begin
  PnlNaoCadastrado.Visible := RadioButtonNaoCadastrado.Checked;
  PnlCadastrado.Visible    := RadioButtonCadastrado.Checked;
  EditNome.SetFocus;
end;

procedure TFormCotacoes.RadioButtonCadastradoClick(Sender: TObject);
begin
  PnlNaoCadastrado.Visible := RadioButtonNaoCadastrado.Checked;
  PnlCadastrado.Visible    := RadioButtonCadastrado.Checked;
  FrameClientePrin.EditCodigo.SetFocus;  
end;

procedure TFormCotacoes.BitBtnIncluirClick(Sender: TObject);
begin
  if (not CDSPrincipal.Active) then
    Exit;

  Try
    Application.CreateForm(TFormManutencaoItemCotacao, FormManutencaoItemCotacao);
    FormManutencaoItemCotacao.InicializaTela(1,CDSItem);
    FormManutencaoItemCotacao.Visible := False;
    FormManutencaoItemCotacao.ShowModal;
  Finally
    if FormManutencaoItemCotacao.IsOk then
      CalcularValoresTotal;     

    FormManutencaoItemCotacao.Free;
  end;
end;

procedure TFormCotacoes.Incluir;
begin
  LimpaTela;
  Inclusao := True;
  BitBtnConfirmar.Enabled   := True;
  BitBtnCancelar.Enabled    := True;
  BitBtnExcluirPrin.Enabled := False;
  BitBtnIncluirPrin.Enabled := False;
  BitBtnImprimir.Enabled    := False;
  FramePedidoNota.EditCodigo.asInteger := RetornaProximaSequencia;
  EditDataEmissao.asDate       := Now;
  EditDataEmissao.SetFocus;
  HabilitaFrame(FramePedidoNota,False);
end;

procedure TFormCotacoes.LimpaTela;
Var i : Integer;
begin
  FrameVendedor.LimparFrame;
  FrameCondicoesPagto.LimparFrame;
  FrameClientePrin.LimparFrame;
  EditDataEmissao.Limpa;
  EditDataEmissao.Enabled := True;
  FramePedidoNota.EditCodigo.Limpa;
  HabilitaFrame(FramePedidoNota,True);
  FramePedidoNota.EditCodigo.SetFocus;
  EditNome.Limpa;
  EditDDDCom1.Limpa;
  EditDDDCom2.Limpa;
  EditDDDFax.Limpa;
  EditDDDRes.Limpa;
  EditDDDCel.Limpa;
  EditTelComercial1.Limpa;
  EditTelComercial2.Limpa;
  EditTelFax.Limpa;
  EditTelResidencial.Limpa;
  EditTelCelular.Limpa;
  EditValorTotal.Limpa;
  BitBtnConfirmar.Enabled   := False;
  BitBtnCancelar.Enabled    := False;
  BitBtnExcluirPrin.Enabled := False;
  BitBtnIncluirPrin.Enabled := True;
  BitBtnImprimir.Enabled    := False;
  for I := 0 to DBGridItens.Columns.Count - 1 do
    DBGridItens.Columns[I].Title.Font.Style := [];
  CDSCotacoes.Close;
  CDSItem.Close;
  CDSPrincipal.Close;
  CDSCotacoesMemoria.Close;
  Inclusao := False;
  CodPedidoCotacao := 0;
  CheckBoxTransf.Checked := False;
  CheckBoxTransf.Enabled  := True;
  RadioButtonCadastrado.Checked := True;
  RadioButtonCadastrado.OnClick(RadioButtonCadastrado);
end;

function TFormCotacoes.RetornaProximaSequencia : Integer;
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
        SQL.Add('  CodCotacao = CodCotacao + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from PedidoNota');
        SQL.Add('where ((Tipo = 3) and (Codigo = (Select CodCotacao from UltimaSequencia)))');
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
      SQL.Add('CodCotacao as Codigo');
      SQL.Add('from UltimaSequencia');
      Open;

      Result := FieldByname('Codigo').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;

procedure TFormCotacoes.BitBtnIncluirPrinClick(Sender: TObject);
begin
  Incluir;
end;

procedure TFormCotacoes.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TFormCotacoes.AbrirCotacao;
begin
  SQL.Clear;
  SQL.Add(' Select PN.*, C.CLICAD, C.NOMECONTATO, C.TELCOMERCIAL1,');
  SQL.Add('     C.TELCOMERCIAL2, C.TELFAX, C.TELRESIDENCIAL, C.TELCELULAR, ');
  SQL.Add('     C.CODUSUARIO, U.NOME AS USUARIO, C.FLAGPEDIDO');
  SQL.Add(' from PedidoNota PN');
  SQL.Add(' Left Join Cotacao C on C.CodPedidoNF = PN.Codigo');
  SQL.Add('                    and C.Tipo        = PN.Tipo');
  SQL.Add(' Left Join Usuarios U on U.Codigo     = C.CodUsuario');
  SQL.Add(' where PN.Tipo   = 3');
  SQL.Add('   and PN.Codigo = ' + FramePedidoNota.EditCodigo.Text);
  with CDSPrincipal do
  begin
    Close;
    CommandText := SQL.Text;
    Open;

    if Inclusao = False then
    begin
      if IsEmpty then
      begin
        Application.MessageBox('Cotação não Existe no Sistema!','Informação',0);
        FramePedidoNota.EditCodigo.SelectAll;
        FramePedidoNota.EditCodigo.SetFocus;
      end
      else
      begin
        Inclusao := False;
        MostrarDadosCotacao;
        BitBtnConfirmar.Enabled   := True;
        BitBtnCancelar.Enabled    := True;
        BitBtnExcluirPrin.Enabled := True;
        BitBtnIncluirPrin.Enabled := False;
        BitBtnImprimir.Enabled    := True;
        HabilitaFrame(FramePedidoNota,False);
        EditDataEmissao.Enabled   := False;
        if FieldByname('FLAGPEDIDO').asInteger = 1 then
        begin
          CheckBoxTransf.Checked  := False;
          CheckBoxTransf.Enabled  := False;
          BitBtnImprimir.Enabled  := False;
        end
        else
        begin
          CheckBoxTransf.Enabled  := True;
          BitBtnImprimir.Enabled  := True;
        end;
        FrameVendedor.EditCodigo.SetFocus;
      end;
    end;
  end;
  CarregaItens;
  AlimentaNumSequencia;
end;

procedure TFormCotacoes.MostrarDadosCotacao;
begin
  with CDSPrincipal do
  begin
    EditDataEmissao.asDate                   := FieldByname('DATAEMISSAO').asDateTime;
    FrameCondicoesPagto.EditCodigo.asInteger := FieldByname('CODCONDPAGTO').asInteger;
    FrameCondicoesPagto.EditCodigo.OnExit(FrameCondicoesPagto.EditCodigo);
    FrameVendedor.EditCodigo.asInteger       := FieldByname('CODVENDEDOR').asInteger;
    FrameVendedor.EditCodigo.OnExit(FrameVendedor.EditCodigo);
    if FieldByname('CLICAD').asInteger = 1 then
    begin
      RadioButtonCadastrado.Checked := True;
      RadioButtonCadastrado.OnClick(RadioButtonCadastrado);
      FrameClientePrin.EditCodigo.asInteger    := FieldByname('CODCLIENTE').asInteger;
      FrameClientePrin.EditCodigo.OnExit(FrameClientePrin.EditCodigo);
    end
    else if FieldByname('CLICAD').asInteger = 2 then
    begin
      RadioButtonNaoCadastrado.Checked := True;
      RadioButtonNaoCadastrado.OnClick(RadioButtonNaoCadastrado);
    end;
    EditNome.Text := FieldByname('NOMECONTATO').asString;
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
  end;
end;

procedure TFormCotacoes.FormCreate(Sender: TObject);
begin
  SQL := TStringList.Create;
  CodPedidoCotacao := 0;
end;

procedure TFormCotacoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SQL.Free;
end;

procedure TFormCotacoes.CarregaItens;
begin
  SQL.Clear;
  SQL.Add(' Select IPN.CODPEDIDONF, IPN.TIPO, IPN.SEQUENCIA, IPN.CODPRODUTO,');
  SQL.Add('   IPN.CODGRUPO, IPN.CLASSIFICACAO, IPN.QUANTPEDIDA, IPN.VALORUNITARIO,');
  SQL.Add('   IPN.VALORTOTAL, Ep.QUANTIDADE, P.Descricao as DescricaoProduto, P.Unidade,');
  SQL.Add('   Cast(''A'' as Char(1)) as Status, Cast(0 as Integer) as EmpMelhorPreco');
  SQL.Add(' from ItemPedidoNota IPN');
  SQL.Add(' Left outer Join Produtos P on P.Codigo        = IPN.CodProduto');
  SQL.Add('                           and P.CodGrupo      = IPN.CodGrupo');
  SQL.Add('                           and P.Classificacao = IPN.Classificacao');
  SQL.Add(' Left Join EstoqueProdutos Ep on Ep.CodGrupo       = P.CodGrupo');
  SQL.Add('                              and Ep.CodProduto    = P.Codigo');
  SQL.Add('                              and Ep.Classificacao = P.Classificacao');
  SQL.Add(' where IPN.Tipo        = 3');
  SQL.Add('   and IPN.CodPedidoNF = ' + FramePedidoNota.EditCodigo.Text);
  with CDSItem do
  begin
    Close;
    CommandText := SQL.Text;
    TratarClientDatasetParaPost(CDSItem);

    Filtered := False;
    Filter   := ' Status <> ''E''';
    Filtered := True;
    
    IndexFieldNames := 'Sequencia';

    CalcularValoresTotal;

    First;
    While not EOF do
    begin
      Marca_MelhorPreco;
      Next;
    end;
  end;
end;

Procedure TFormCotacoes.AlimentaNumSequencia;
begin
  with DataModulePrin.SQLQueryExecuta do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select Max(Sequencia) as Seq from ItemPedidoNota');
    SQL.Add(' where Tipo        = 3');
    SQL.Add('   and CodPedidoNF = ' + FramePedidoNota.EditCodigo.Text);
    Open;

    if IsEmpty then
      NumSequencia := 1
    else
      NumSequencia := FieldByName('Seq').asInteger;
  end;
end;



procedure TFormCotacoes.FramePedidoNotaEditCodigoExit(Sender: TObject);
begin
  If FramePedidoNota.EditCodigo.asInteger = 0 then
  begin
    FramePedidoNota.EditCodigo.SetFocus;
    Exit;
  end;
  AbrirCotacao;
end;

procedure TFormCotacoes.BitBtnCancelarClick(Sender: TObject);
begin
  BitBtnConfirmar.Enabled := False;
  BitBtnCancelar.Enabled  := False;
  VoltaUltimSequencia;
  LimpaTela;
end;

procedure TFormCotacoes.VoltaUltimSequencia;
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
      SQL.Add('  CodCotacao = ' + FramePedidoNota.EditCodigo.Text + ' - 1');
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


procedure TFormCotacoes.CDSItemAfterOpen(DataSet: TDataSet);
begin
  with CDSItem do                      
  begin
    (FieldByName('QuantPedida') as TNumericField).DisplayFormat   := '#,##0.00';
    (FieldByName('ValorUnitario') as TNumericField).DisplayFormat := '#,##0.00';
    (FieldByName('ValorTotal') as TNumericField).DisplayFormat    := '#,##0.00';
  end;
end;

procedure TFormCotacoes.BitBtnAlterarClick(Sender: TObject);
begin
  if (not CDSPrincipal.Active) then
    Exit;

  if (not CDSItem.Active) or (CDSItem.IsEmpty) then
    exit;

  Try
    Application.CreateForm(TFormManutencaoItemCotacao, FormManutencaoItemCotacao);
    FormManutencaoItemCotacao.InicializaTela(2,CDSItem);
    FormManutencaoItemCotacao.Visible := False;
    FormManutencaoItemCotacao.ShowModal;
  Finally
    if FormManutencaoItemCotacao.IsOk then
      CalcularValoresTotal;
    FormManutencaoItemCotacao.Free;
  end;
end;

procedure TFormCotacoes.DBGridItensDblClick(Sender: TObject);
begin
  BitBtnAlterar.OnClick(BitBtnAlterar);
end;

procedure TFormCotacoes.BitBtnExcluirClick(Sender: TObject);
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
end;

procedure TFormCotacoes.ExcluirItem;
begin
  with CDSItem do
  begin
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

Procedure TFormCotacoes.TrazerCotacoes;
begin
  SQL.Clear;
  SQL.Add('Select EC.Codigo, EC.Nome,');
  SQL.Add('Case when EX.ValorCotado is null then 0 else EX.ValorCotado end as ValorCotado,');
  SQL.Add('EX.CodEmpConc as Cotacao');
  SQL.Add('From EmpresasConcorrentes EC');
  SQL.Add('Left join EmpresasXCotacao EX on EX.CodEmpConc    = EC.Codigo');
  SQL.Add('                             and EX.CodProduto    = :CodProduto');
  SQL.Add('                             and EX.CodGrupo      = :CodGrupo  ');
  SQL.Add('                             and EX.Classificacao = :Classificacao ');

  with CDSCotacoes do
  begin
    Close;
    CommandText := SQL.Text;
    Params.ParambyName('CodProduto').asInteger   := CDSItem.FieldByName('CodProduto').asInteger;
    Params.ParambyName('CodGrupo').asInteger     := CDSItem.FieldByName('CodGrupo').asInteger;
    Params.ParambyName('Classificacao').asString := CDSItem.FieldByName('Classificacao').asString;
    Open;
  end;
  MontaManutencao;
end;


Procedure TFormCotacoes.MontaManutencao;
Var i : Integer;
begin
  CDSCotacoesMemoria.Close;
  CDSCotacoesMemoria.FieldDefs.Clear;
  with CDSCotacoes do
  begin
    if not IsEmpty then
    begin
      First;
      while not EOF do
      begin
        CDSCotacoesMemoria.FieldDefs.Add(FieldByName('Codigo').asString + '_' + FieldByName('Nome').asString, ftFloat);
        Next;
      end;
    end
    else
      CDSCotacoesMemoria.FieldDefs.Add('1_NOVA RIBEIRÃO',ftFloat);
  end;

  with CDSCotacoesMemoria do
  begin
    for i := 0 to FieldDefs.Count - 1 do
      FieldDefs[i].Required := false;
    CreateDataSet;
    EmptyDataSet;

    for i := 0 to FieldCount - 1 do
    begin
      If i = 0 then
        Append
      else
        Edit;

      if not CDSCotacoes.IsEmpty then
      begin
        CDSCotacoes.Locate('Codigo;Nome',
                         VarArrayOf([Copy(Trim(Fields[i].FieldName),1,Pos('_',Trim(Fields[i].FieldName)) - 1),
                                     Copy(Trim(Fields[i].FieldName),Pos('_',Trim(Fields[i].FieldName)) + 1,Length(Trim(Fields[i].FieldName)))]),[]);
        Fields[i].Value := CDSCotacoes.FieldByName('ValorCotado').Value;

      end;
      Post;

      if not CDSCotacoes.IsEmpty then
        FieldByName(Fields[i].FieldName).DisplayLabel := CDSCotacoes.FieldByName('Codigo').asString + ' - ' + CDSCotacoes.FieldByName('Nome').asString
      else
        FieldByName(Fields[i].FieldName).DisplayLabel := '1 - NOVA RIBEIRÃO';

     (FieldByName(Fields[i].FieldName) as TNumericField).DisplayFormat := '#,##0.00';
    end;
  end;
end;


procedure TFormCotacoes.CDSItemAfterScroll(DataSet: TDataSet);
begin
  if (CDSItem.Active = False) or (CDSItem.IsEmpty) then
    Exit;

  TrazerCotacoes;
end;

procedure TFormCotacoes.DBGridCotacoesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (Copy(Column.FieldName,1,Pos('_',Column.FieldName) - 1) =
      CDSItem.FieldByName('EmpMelhorPreco').asString) then
  begin
    DBGridCotacoes.Canvas.Brush.Color  := $00EC7600;
    DBGridCotacoes.Canvas.Font.Color   := clWhite;
    DBGridCotacoes.Canvas.FillRect(Rect);
    DBGridCotacoes.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFormCotacoes.CalcularValoresTotal;
Var BM : TBookMark;
begin
  EditValorTotal.asFloat := 0;
  with CDSItem do
  begin
    DisableControls;
    BM := GetBookmark;
    AfterScroll := Nil;
    First;
    while not EOF do
    begin
      EditValorTotal.asFloat := EditValorTotal.asFloat + FieldByName('ValorTotal').asFloat;
      Next;
    end;
    EnableControls;
    Try
      GotoBookmark(BM);
      FreeBookmark(BM);
    Except
      FreeBookmark(BM);
    end;
    AfterScroll := CDSItemAfterScroll;
  end;
end;

function TFormCotacoes.ValidarTela : Boolean;
begin
  Result := False;
  if EditDataEmissao.IsDate = False then
  begin
    Application.MessageBox('Preencha Corretamente a Data de Emissão','Informação',0);
    EditDataEmissao.SetFocus;
    Exit;
  end;

  if RadioButtonCadastrado.Checked then
  begin
    if FrameClientePrin.EditCodigo.asInteger = 0 then
    begin
      Application.MessageBox('Preencha Corretamente o Cliente','Informação',0);
      FrameClientePrin.EditCodigo.SetFocus;
      Exit;
    end;
  end
  else
  begin
    if Trim(EditNome.Text) = ''  then
    begin
      Application.MessageBox('Preencha Corretamente o Nome do Contato','Informação',0);
      EditNome.SetFocus;
      Exit;
    end;
  end;
  Result := True;
end;



procedure TFormCotacoes.BitBtnConfirmarClick(Sender: TObject);
begin
  if ValidarTela = False then
   exit;

  GravarCotacao;
end;

procedure TFormCotacoes.GravarCotacao;
begin
  GravarCotacaoOuPedido(3);
  GravarDadosCotacao(CheckBoxTransf.Checked);
  GravarItensCotacaoOuPedido(3);

  if CheckBoxTransf.Checked then
  begin
    TransformarEmPedido;
    ImprimirCupom;
  end;
  LimpaTela;
end;


procedure TFormCotacoes.GravarItensCotacaoOuPedido(Tipo : Integer);
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
      while not CDSItem.EOF do
      begin
        With SQLQueryExecuta do
        begin
          Close;
          if (CDSItem.FieldByName('Status').asString = 'I') or (Tipo = 1)  then
          begin
            SQL.Clear;
            SQL.Add(' INSERT INTO ITEMPEDIDONOTA (');
            SQL.Add('   CODPEDIDONF, TIPO, SEQUENCIA, CODPRODUTO, CODGRUPO, CLASSIFICACAO, ');
            SQL.Add('   QUANTPEDIDA, VALORUNITARIO, VALORTOTAL)');
            SQL.Add(' VALUES ( ');
            SQL.Add('   :CODPEDIDONF, :TIPO, :SEQUENCIA, :CODPRODUTO, :CODGRUPO, :CLASSIFICACAO, ');
            SQL.Add('   :QUANTPEDIDA, :VALORUNITARIO, :VALORTOTAL)');
          end
          else if CDSItem.FieldByName('Status').asString = 'A' then
          begin
            SQL.Clear;
            SQL.Add(' UPDATE ITEMPEDIDONOTA');
            SQL.Add(' SET CODPRODUTO     = :CODPRODUTO,');
            SQL.Add('     CODGRUPO       = :CODGRUPO,');
            SQL.Add('     CLASSIFICACAO  = :CLASSIFICACAO,');
            SQL.Add('     QUANTPEDIDA    = :QUANTPEDIDA,');
            SQL.Add('     VALORUNITARIO  = :VALORUNITARIO,');
            SQL.Add('     VALORTOTAL     = :VALORTOTAL');
            SQL.Add(' WHERE CODPEDIDONF  = :CODPEDIDONF ');
            SQL.Add('   AND TIPO         = :TIPO ');
            SQL.Add('   AND SEQUENCIA    = :SEQUENCIA ');
          end
          else if CDSItem.FieldByName('Status').asString = 'E' then
          begin
            SQL.Clear;
            SQL.Add(' DELETE FROM ITEMPEDIDONOTA');
            SQL.Add(' WHERE CODPEDIDONF  = :CODPEDIDONF ');
            SQL.Add('   AND TIPO         = :TIPO ');
            SQL.Add('   AND SEQUENCIA    = :SEQUENCIA ');
          end;
          ParamByName('CODPEDIDONF').asFloat    := CodPedidoCotacao;
          ParamByName('TIPO').asInteger          := Tipo;
          ParamByName('SEQUENCIA').asInteger     := CDSItem.FieldByName('Sequencia').asInteger;
          if CDSItem.FieldByName('Status').asString <> 'E' then
          begin
            ParamByName('CODPRODUTO').asInteger    := CDSItem.FieldByName('CODPRODUTO').asInteger;
            ParamByName('CODGRUPO').asInteger      := CDSItem.FieldByName('CodGrupo').asInteger;
            ParamByName('CLASSIFICACAO').asString  := CDSItem.FieldByName('Classificacao').asString;
            ParamByName('QUANTPEDIDA').asFloat     := CDSItem.FieldByName('QuantPedida').asFloat;
            ParamByName('VALORUNITARIO').asFloat   := CDSItem.FieldByName('ValorUnitario').asFloat;
            ParamByName('VALORTOTAL').asFloat      := CDSItem.FieldByName('ValorTotal').asFloat;
          end;
          ExecSQL;
        end;
               
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


procedure TFormCotacoes.ImprimirCupom;
begin
  Try
    Application.CreateForm(TFormCupom, FormCupom);
    FormCupom.Visible := False;
    FormCupom.AlimentaCupom(FramePedidoNota.EditCodigo.asInteger, '');
    FormCupom.ShowModal;
  Finally
    FormCupom.Free;
  end;
end;

procedure TFormCotacoes.GravarDadosCotacao(TransfEmPedido : Boolean);
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
          SQL.Add(' INSERT INTO COTACAO (');
          SQL.Add('   CODPEDIDONF, TIPO, CLICAD, NOMECONTATO, TELCOMERCIAL1, ');
          SQL.Add('   TELCOMERCIAL2, TELFAX, TELRESIDENCIAL, TELCELULAR, CODUSUARIO, FLAGPEDIDO)');
          SQL.Add(' VALUES (:CODPEDIDONF, :TIPO, :CLICAD, :NOMECONTATO, :TELCOMERCIAL1, ');
          SQL.Add('         :TELCOMERCIAL2, :TELFAX, :TELRESIDENCIAL, :TELCELULAR, :CODUSUARIO, :FLAGPEDIDO) ');
        end
        else
        begin
          SQL.Clear;
          SQL.Add(' UPDATE COTACAO');
          SQL.Add(' SET CLICAD         = :CLICAD,');
          SQL.Add('     NOMECONTATO    = :NOMECONTATO,');
          SQL.Add('     TELCOMERCIAL1  = :TELCOMERCIAL1,');
          SQL.Add('     TELCOMERCIAL2  = :TELCOMERCIAL2,');
          SQL.Add('     TELFAX         = :TELFAX,');
          SQL.Add('     TELRESIDENCIAL = :TELRESIDENCIAL,');
          SQL.Add('     TELCELULAR     = :TELCELULAR,');
          SQL.Add('     CODUSUARIO     = :CODUSUARIO,');
          SQL.Add('     FLAGPEDIDO     = :FLAGPEDIDO'); 
          SQL.Add(' WHERE CODPEDIDONF  = :CODPEDIDONF ');
          SQL.Add('   AND TIPO         = :TIPO ');
        end;
        ParamByName('CODPEDIDONF').asInteger       := FramePedidoNota.EditCodigo.asInteger;
        ParamByName('TIPO').asInteger              := 3;
        if RadioButtonCadastrado.Checked then
        begin
          ParamByName('NOMECONTATO').asString      := FrameClientePrin.EditNome.Text;
          ParamByName('CLICAD').asInteger          := 1;
        end
        else
        begin
          ParamByName('CLICAD').asInteger          := 2;
          ParamByName('NOMECONTATO').asString      := EditNome.Text;
        end;
        ParamByName('TelComercial1').asString      := GravarTelefone(EditDDDCom1.Text,EditTelComercial1.Text);
        ParamByName('TelComercial2').asString      := GravarTelefone(EditDDDCom2.Text, EditTelComercial2.Text);
        ParamByName('TelFax').asString             := GravarTelefone(EditDDDFax.Text, EditTelFax.Text);
        ParamByName('TelResidencial').asString     := GravarTelefone(EditDDDRes.Text, EditTelResidencial.Text);
        ParamByName('TelCelular').asString         := GravarTelefone(EditDDDCel.Text, EditTelCelular.Text);
        ParamByName('CODUSUARIO').asInteger        := DataModulePrin.UsuarioLogado;
        if (Inclusao) or ((Inclusao = False) and (CDSPrincipal.FieldByName('FLAGPEDIDO').AsInteger = 0)) then
          ParamByName('FLAGPEDIDO').asInteger      := IfThen(TransfEmPedido,1,0);    
        ExecSQL;
        SQLConnectionPrin.Commit(TransDesc);
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

procedure TFormCotacoes.ExcluirCotacoes;
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
        ParamByName('TIPO').asInteger   := 3;
        ExecSQL;

        SQL.Clear;
        SQL.Add(' DELETE FROM COTACAO   ');
        SQL.Add(' WHERE CODPEDIDONF   = :CODIGO ');
        SQL.Add('   AND TIPO          = :TIPO   ');
        ParamByName('CODIGO').asInteger := FramePedidoNota.EditCodigo.asInteger;
        ParamByName('TIPO').asInteger   := 3;
        ExecSQL;                    

        SQL.Clear;
        SQL.Add(' DELETE FROM PEDIDONOTA   ');
        SQL.Add(' WHERE CODIGO   = :CODIGO ');
        SQL.Add('   AND TIPO     = :TIPO   ');
        ParamByName('CODIGO').asInteger := FramePedidoNota.EditCodigo.asInteger;
        ParamByName('TIPO').asInteger   := 3;
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);
      end;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Excluir a Cotação! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
      Close;
    end;
  end;
end;


procedure TFormCotacoes.BitBtnExcluirPrinClick(Sender: TObject);
begin
  if (CDSPrincipal.IsEmpty) or (not CDSPrincipal.Active) then
    Exit;
    
  If Application.MessageBox('Deseja Realmente Excluir a Cotação ?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
  begin
    ExcluirCotacoes;
    LimpaTela;
  end;
end;

procedure TFormCotacoes.BitBtnImprimirClick(Sender: TObject);
begin
  GravarDadosCotacao(True);
  TransformarEmPedido;
  ImprimirCupom;
  LimpaTela;

end;

procedure TFormCotacoes.FramePedidoNotaSpeedButtonConsultaClick(
  Sender: TObject);
begin
  FramePedidoNota.SpeedButtonConsultaClick(Sender);
end;

procedure TFormCotacoes.Marca_MelhorPreco;
Var MelhorPreco : Double;
begin
  MelhorPreco := CDSItem.FieldByName('VALORUNITARIO').asFloat;

  if (CDSCotacoes.Active = False) or (CDSCotacoes.IsEmpty) then
    Exit;

  with CDSCotacoes do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
      if FieldByName('ValorCotado').asInteger > 0 then
      begin
        if FieldByName('ValorCotado').asFloat <= MelhorPreco then
        begin
          MelhorPreco := FieldByName('ValorCotado').asFloat;

          CDSItem.AfterScroll := Nil;
          CDSItem.Edit;
          CDSItem.FieldByName('EmpMelhorPreco').asInteger := FieldByName('Codigo').asInteger;
          CDSItem.Post;
          CDSItem.AfterScroll := CDSItemAfterScroll;          
        end;
      end;
      Next;
    end;
  end;
end;

procedure TFormCotacoes.TransformarEmPedido;
begin
  try
    CarregaDadosEmpresa;
    GravarCotacaoOuPedido(1);
    GerarDuplicatas;    
    GravarItensCotacaoOuPedido(1);
    GravarDuplicatas;
  finally
    Application.MessageBox(PChar('Pedido N.º ' + FloatToStr(CodPedidoCotacao) + ' foi Gerado com Sucesso!'),'Informação',0);
  end;  
end;

procedure TFormCotacoes.GravarCotacaoOuPedido(Tipo : Integer);
Var TransDesc : TTransactionDesc;

begin
  if Tipo = 3 then
    CodPedidoCotacao := FramePedidoNota.EditCodigo.asInteger
  else
    CodPedidoCotacao := RetornaProximaSequenciaPedido;

  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);
      With SQLQueryExecuta do
      begin
        Close;
        if (Inclusao = True) or (Tipo = 1) then
        begin
          SQL.Clear;
          SQL.Add(' INSERT INTO PEDIDONOTA (');
          SQL.Add('   CODIGO, TIPO,');
          SQL.Add('   CODCLIENTE,');
          if FrameVendedor.EditCodigo.asInteger <> 0 then
            SQL.Add('   CODVENDEDOR,  ');
          if FrameCondicoesPagto.EditCodigo.asInteger <> 0 then
            SQL.Add('   CODCONDPAGTO, ');
          SQL.Add('   DATAEMISSAO, VALORTOTAL, VALORPRODUTOS)');
          SQL.Add(' VALUES ( ');
          SQL.Add('   :CODIGO, :TIPO, :CODCLIENTE,');
          if FrameVendedor.EditCodigo.asInteger <> 0 then
            SQL.Add('   :CODVENDEDOR,             ');
          if FrameCondicoesPagto.EditCodigo.asInteger <> 0 then
            SQL.Add('   :CODCONDPAGTO,');
          SQL.Add('   :DATAEMISSAO, :VALORTOTAL, :VALORPRODUTOS)');
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
          SQL.Add('     VALORTOTAL      = :VALORTOTAL,');
          SQL.Add('     VALORPRODUTOS   = :VALORPRODUTOS');
          SQL.Add(' WHERE CODIGO  = :CODIGO ');
          SQL.Add('   AND TIPO    = :TIPO ');
        end;
        ParamByName('CODIGO').asFloat            := CodPedidoCotacao;
        ParamByName('TIPO').asInteger              := Tipo;
        if RadioButtonCadastrado.Checked then
          ParamByName('CODCLIENTE').asInteger      := FrameClientePrin.EditCodigo.asInteger
        else
          ParamByName('CODCLIENTE').asInteger      := 823; //CLIENTE NÃO CADASTRADO
        if FrameVendedor.EditCodigo.asInteger <> 0 then
          ParamByName('CODVENDEDOR').asInteger     := FrameVendedor.EditCodigo.asInteger;
        if FrameCondicoesPagto.EditCodigo.asInteger <> 0 then
          ParamByName('CODCONDPAGTO').asInteger    := FrameCondicoesPagto.EditCodigo.asInteger;
        ParamByName('DATAEMISSAO').asSQLTimesTamp  := DateTimeToSQLTimesTamp(Now);
        ParamByName('VALORPRODUTOS').asFloat       := EditValorTotal.asFloat;
        ParamByName('VALORTOTAL').asFloat          := EditValorTotal.asFloat;
        ExecSQL;

        SQLConnectionPrin.Commit(TransDesc);
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

function TFormCotacoes.RetornaProximaSequenciaPedido : Integer;
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
        SQL.Add('  CodPedido = CodPedido + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from PedidoNota');
        SQL.Add('  where ((Tipo = 1) and (Codigo = (Select CodPedido from UltimaSequencia)))');
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
      SQL.Add('CodPedido as Codigo');
      SQL.Add('from UltimaSequencia');
      Open;

      Result := FieldByname('Codigo').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;

procedure TFormCotacoes.GerarDuplicatas;
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
      Params.ParambyName('CODIGO').asString     := FloatToStr(CodPedidoCotacao) + '/' + IntToStr(Parc);
      Params.ParambyName('CODPEDIDONF').asFloat := CodPedidoCotacao;
      TratarClientDatasetParaPost(CDSRetornaCodDupl);

      if FieldByName('Qtd').asInteger > 0 then
        Result := FloatToStr(CodPedidoCotacao) + '/' + IntToStr(Parc) + '_' + FieldByName('Qtd').AsString
      else
        Result := FloatToStr(CodPedidoCotacao) + '/' + IntToStr(Parc);
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
        if RadioButtonCadastrado.Checked then
          FieldByname('CODCLIENTE').asInteger  := FrameClientePrin.EditCodigo.asInteger
        else
          FieldByname('CODCLIENTE').asInteger  := 823; //CLIENTE NÃO CADASTRADO
      FieldByname('CODBANCO').asFloat          := CDSEmpresa.FieldByname('CODBANCO').asFloat;
      FieldByname('DATAEMISSAO').asDatetime    := Now;
      FieldByname('DATAVENCIMENTO').asDatetime := Montar_Vencimento(Dias);
      FieldByname('VALORTOTAL').AsFloat        := EditValorTotal.asFloat;
      FieldByname('VALORDUPLICATA').AsFloat    := Montar_Valor(NrParc);
      FieldByname('VALORPAGO').AsFloat         := 0;
      FieldByname('VALORJUROS').AsFloat        := 0;
      FieldByname('CODPEDIDONF').AsFloat       := CodPedidoCotacao;
      FieldByname('TIPOPEDIDONF').asInteger    := 1;
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

  procedure ExibirDuplicatas;
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
      Params.ParamByName('CODPEDIDONF').asFloat    := CodPedidoCotacao;
      Params.ParamByName('TIPOPEDIDONF').asInteger := 1;
      TratarClientDatasetParaPost(CDS_Duplicatas);
    end;
  end;

begin
  ValorTotalDupl := 0;

  ExibirDuplicatas;

  if Cds_Duplicatas.IsEmpty then
    Gerar_Novas_Parcelas;

  if CompareValue(ValorTotalDupl,EditValorTotal.asFloat) <> EqualsValue then
    AlterarPrimeiroValor;
end;

Procedure TFormCotacoes.CarregaDadosEmpresa;
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

procedure TFormCotacoes.GravarDuplicatas;
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
        CDS_Duplicatas.First;
        while not CDS_Duplicatas.EOF do
        begin
          Close;
          SQL.Clear;
          SQL.Add(' INSERT INTO DUPLICATAS (');
          SQL.Add('    CODIGO, TIPO, CODCLIENTE, CODBANCO, DATAEMISSAO, DATAVENCIMENTO, ');
          SQL.Add('    VALORTOTAL, VALORDUPLICATA, VALORPAGO,  VALORJUROS,');
          SQL.Add('    CODPEDIDONF, TIPOPEDIDONF)');
          SQL.Add(' VALUES(:CODIGO, :TIPO, :CODCLIENTE, :CODBANCO, :DATAEMISSAO, :DATAVENCIMENTO, ');
          SQL.Add('    :VALORTOTAL, :VALORDUPLICATA, :VALORPAGO,  :VALORJUROS,');
          SQL.Add('    :CODPEDIDONF, :TIPOPEDIDONF)');
          ParamByName('CODIGO').asString  := CDS_Duplicatas.FieldByName('CODIGO').asString;
          ParamByName('TIPO').asInteger   := 1;
          ParamByName('CODCLIENTE').asFloat            := CDS_Duplicatas.FieldByName('CODCLIENTE').asFloat;
          ParamByName('CODBANCO').asFloat              := CDS_Duplicatas.FieldByName('CODBANCO').asFloat;
          ParamByName('DATAEMISSAO').asSQLTimesTamp    := DateTimeToSQLTimeStamp(CDS_Duplicatas.FieldByName('DATAEMISSAO').asDateTime);
          ParamByName('VALORTOTAL').asFloat            := CDS_Duplicatas.FieldByName('VALORTOTAL').asFloat;
          ParamByName('VALORPAGO').asFloat             := CDS_Duplicatas.FieldByName('VALORPAGO').asFloat;
          ParamByName('VALORJUROS').asFloat            := CDS_Duplicatas.FieldByName('VALORJUROS').asFloat;
          ParamByName('CODPEDIDONF').asFloat           := CDS_Duplicatas.FieldByName('CODPEDIDONF').asFloat;
          ParamByName('TIPOPEDIDONF').asInteger        := CDS_Duplicatas.FieldByName('TIPOPEDIDONF').asInteger;
          ParamByName('DATAVENCIMENTO').asSQLTimesTamp := DateTimeToSQLTimeStamp(CDS_Duplicatas.FieldByName('DATAVENCIMENTO').asDateTime);
          ParamByName('VALORDUPLICATA').asFloat        := CDS_Duplicatas.FieldByName('VALORDUPLICATA').asFloat;
          ExecSQL;
          CDS_Duplicatas.Next;
        end;
        SQLConnectionPrin.Commit(TransDesc);
      end;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar as Duplicatas! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
end;





end.
