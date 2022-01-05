unit uFormCupom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FMTBcd, DB, SqlExpr, Provider, DBClient, MaskUtils, uCupomNaoFiscal,
  Buttons, Math, Mask, ExtCtrls, DBXpress;

type
  TFormCupom = class(TForm)
    CDSPedidos: TClientDataSet;
    DSPPedidos: TDataSetProvider;
    SQLPedidos: TSQLDataSet;
    DS_Pedidos: TDataSource;
    CDSItem: TClientDataSet;
    CDSEmpresa: TClientDataSet;
    GroupBox6: TGroupBox;
    ComboBoxPorta: TComboBox;
    GroupBox1: TGroupBox;
    Mensagens: TMemo;
    GroupBox2: TGroupBox;
    BitBtnStatus: TBitBtn;
    MemoStatus: TMemo;
    BitBtnImprimir: TSpeedButton;
    BitBtnFechar: TSpeedButton;
    TimerStatus: TTimer;
    ck_teste: TCheckBox;
    CDS_Duplicatas: TClientDataSet;
    DS_Duplicatas: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aClick(Sender: TObject);
    procedure BitBtnStatusClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerStatusTimer(Sender: TObject);
    procedure BitBtnImprimirClick(Sender: TObject);

  private
    { Private declarations }
    SQL : TStringList;
    vCodPedido : Integer;
    arq : TextFile;
    s_CondPagto : String;
    procedure CarregaPedido;
    procedure CarregaItens;
    Procedure CarregaDadosEmpresa;
    procedure CabecalhoCupom;
    function TestaComando(Erro : Integer = 0) : Boolean;
    procedure VenderItens;
    procedure DadosCliente;
    procedure RodapeCupom;
    procedure ImprimirDadosDestaque;
    procedure ImprimirDadosMedio(Negrito : Integer);
    procedure ImprimirDadosSimples(Negrito : Integer);
    Function  FormataProduto(CodGrupo, CodProduto, Classificacao : String) : String;
    function  TratarTelefones : String;
    procedure ExibirDuplicatas;
    procedure Alterar_Pedido;
    procedure IniciarPorta(MemoMsg : TMemo);
  public
    { Public declarations }
    MemoStatusExt : TMemo;
    procedure AlimentaCupom(CodPedido : Integer; CondicoesPagto : String);
    procedure ImprimirCupom(MemoMsg : TMemo);
    procedure PreparaImpressoraCupom(MemoMsg, MemoStatus : TMemo);
    procedure FecharPorta(MemoMsg : TMemo);
  end;

var
  FormCupom : TFormCupom;
  Buffer, Cmd : String;
  Comunica    : String;
  Retorno, Envia, Porta, Comando, Fecha, Modo : Integer;
 

implementation

{$R *.dfm}

Uses uDataModule, uFuncoes;



procedure TFormCupom.FormCreate(Sender: TObject);
begin
  SQL := TStringList.Create;
end;

procedure TFormCupom.CarregaPedido;
begin
  SQL.Clear;
  SQL.Add(' Select Ped.*, Cli.Nome as NomeCli, Cli.CPFCNPJ, ');
  SQL.Add('        Cli.Endereco, Cli.CEP, Cli.Bairro, Cli.Cidade, Cli.Estado, Ven.Nome as NomeVendedor,');
  SQL.Add('        Cli.TelComercial1, Cli.TelFax, Cli.RGIE, CP.Descricao as DescrCondPagto, CP.Parcelas ');
  SQL.Add(' From PedidoNota Ped ');
  SQL.Add(' Left Join Clientes Cli on Cli.Codigo = Ped.CodCliente ');
  SQL.Add(' Left Join CondicoesPagto CP on CP.Codigo = Ped.CodCondPagto ');
  SQL.Add(' Left Join Vendedores Ven on Ven.Codigo = Ped.CodVendedor ');
  SQL.Add(' where Ped.Codigo =  ' + IntToStr(vCodPedido));
  SQL.Add('   and Ped.Tipo   = 1');
  with CDSPedidos do
  begin
    Close;
    CommandText := SQL.Text;
    Open;
  end;
end;


procedure TFormCupom.CarregaItens;
begin
  SQL.Clear;
  SQL.Add(' Select IPN.*, P.Descricao as DescricaoProduto, P.Unidade');
  SQL.Add(' from ItemPedidoNota IPN');
  SQL.Add(' Left outer Join Produtos P on P.Codigo        = IPN.CodProduto');
  SQL.Add('                           and P.CodGrupo      = IPN.CodGrupo');
  SQL.Add('                           and P.Classificacao = IPN.Classificacao');
  SQL.Add(' where IPN.Tipo        = 1');
  SQL.Add('   and IPN.CodPedidoNF = ' + IntToStr(vCodPedido));
  with CDSItem do
  begin
    Close;
    CommandText := SQL.Text;
    Open;
  end;
end;


procedure TFormCupom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TimerStatus.Enabled := False;
  FecharPorta(Mensagens);
  SQL.Free;
end;


procedure TFormCupom.AlimentaCupom(CodPedido : Integer; CondicoesPagto : String);
begin
  vCodPedido   := CodPedido;
  s_CondPagto  := CondicoesPagto;
end;

Procedure TFormCupom.CarregaDadosEmpresa;
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

procedure TFormCupom.CabecalhoCupom;
begin

  Buffer  := CDSEmpresa.FieldByName('Nome').asString + Chr(13) + Chr(10);
  ImprimirDadosDestaque;

  Buffer  := 'Comercio de Produtos e Equipamentos Odontologicos' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := CDSEmpresa.FieldByName('Endereco').asString + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := CDSEmpresa.FieldByName('Bairro').asString  + ' -  CEP: ' + FormataCep(CDSEmpresa.FieldByName('CEP').asString) + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := TratarTelefones + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  if Trim(CDSEmpresa.FieldByName('TelFax').asString) <> '' then
  begin
    Buffer  := 'Fax: ' +  '(' + IntToStr(RetornarDDD(CDSEmpresa.FieldByName('TelFax').asString)) + ')' + RetornarTelefone(CDSEmpresa.FieldByName('TelFax').asString) + Chr(13) + Chr(10);
    ImprimirDadosSimples(0);

  end;  

  Buffer  := 'EMail: ' + CDSEmpresa.FieldByName('Site').asString + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := CDSEmpresa.FieldByName('Cidade').asString + ' - ' + CDSEmpresa.FieldByName('Estado').asString + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := '------------------------------------------------------------' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := FormatDateTime('dd/mm/yyyy hh:mm:ss',Now) + '    N. Pedido ' + CDSPedidos.FieldByName('Codigo').asString  + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := 'Atendente: ' + DataModulePrin.LoginLogado + '   Vendedor: ' + CDSPedidos.FieldByName('NomeVendedor').asString + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '------------------------------------------------------------' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '                    Orcamento / Pedido                      ' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '------------------------------------------------------------' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);
end;


procedure TFormCupom.VenderItens;
Var Descricao : String;
    Contador  : Integer;
    ValorTotalItens, ValorTotalDesconto, ValorTotalAcrescimo, ValorDescontoFinal : Double;


begin

  Buffer   := 'Item  Codigo     Descricao' + Chr(13) + Chr(10);
  ImprimirDadosMedio(1);

  Buffer   := '  Qtd x Un          Vlr Unit        Vlr Total' + Chr(13) + Chr(10);
  ImprimirDadosMedio(1);

  Contador           := 0;
  ValorTotalItens    := 0;
  ValorTotalDesconto := 0;
  ValorDescontoFinal := 0;


  with CDSItem do
  begin
    First;
    while not EOF do
    begin
      Contador  := Contador + 1;
      Descricao := Copy(FieldByName('DescricaoProduto').AsString,1,28);
      Buffer    := PreencheEspaco(PreencheZeros(IntToStr(Contador),4),5) + ' ' +
                   PreencheEspaco(FormataProduto(FieldByName('CodGrupo').AsString,
                   FieldByName('CodProduto').AsString,
                   FieldByName('Classificacao').AsString),10) + ' ' + '[' + PreencheEspaco(Descricao,29) + ']' +
                   Chr(13) + Chr(10);
      ImprimirDadosMedio(0);

      Buffer    := '  ' + PreencheEspaco(Trim(FormatFloat('0.00',FieldByName('QuantPedida').AsFloat)),6) + ' ' +
                          PreencheEspaco(FieldByName('Unidade').AsString,6)  + ' x ' +  ' ' +
                   ' R$ ' + PreencheEspaco(Trim(FormatFloat('0.00',FieldByName('ValorUnitario').AsFloat)),11) + ' ' +
                   ' R$ ' + Trim(FormatFloat('0.00',FieldByName('ValorUnitario').AsFloat * FieldByName('QuantPedida').AsFloat))
                   + Chr(13) + Chr(10);
      ImprimirDadosMedio(0);

      ValorTotalItens    := ValorTotalItens    + (FieldByName('ValorUnitario').asFloat * FieldByName('QuantPedida').AsFloat);
      ValorTotalDesconto := ValorTotalDesconto + ((FieldByName('ValorUnitario').asFloat * FieldByName('QuantPedida').AsFloat) *  (FieldByName('ValorDesconto').asFloat / 100));

      Next;
    end;
    if CDSPedidos.FieldByName('TIPODESCONTOFINAL').asInteger = 0 then
      ValorDescontoFinal := (CDSPedidos.FieldbyName('ValorTotal').asFloat * (CDSPedidos.FieldbyName('ValorDescontoFinal').asFloat / 100))
    else
      ValorDescontoFinal := CDSPedidos.FieldbyName('ValorDescontoFinal').asFloat;
    ValorTotalDesconto   := ValorTotalDesconto + ValorDescontoFinal;

    ValorTotalAcrescimo := CDSPedidos.FieldByName('VALORFRETE').asFloat + CDSPedidos.FieldByName('VALORSEGURO').asFloat +
                           CDSPedidos.FieldByName('VALORICMS').asFloat + CDSPedidos.FieldByName('VALORIPI').asFloat +
                           CDSPedidos.FieldByName('VALOROUTRAS').asFloat;

    Buffer  := Chr(13) + Chr(10);
    ImprimirDadosSimples(0);

    Buffer  := '                 ' + PreencheEspaco('Sub Total R$',18) + Trim(FormatFloat('0.00',ValorTotalItens)) + Chr(13) + Chr(10);
    ImprimirDadosMedio(0);


    Buffer  := '                 ' + PreencheEspaco('Acrescimo R$',18) + Trim(FormatFloat('0.00',ValorTotalAcrescimo)) + Chr(13) + Chr(10);
    ImprimirDadosMedio(0);


    Buffer  := '                 ' + PreencheEspaco('Desconto  R$',18) + Trim(FormatFloat('0.00',ValorTotalDesconto)) + Chr(13) + Chr(10);
    ImprimirDadosMedio(0);


    Buffer  := PreencheEspaco((IntToStr(Contador) + ' Item(ns)'),17) +  PreencheEspaco('Total     R$',18) + Trim(FormatFloat('0.00',CDSPedidos.FieldbyName('ValorTotal').asFloat)) + Chr(13) + Chr(10);
    ImprimirDadosMedio(1);

  end;
  Buffer  := Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := 'Condições de Pagamento (Parcelas): ';
  ImprimirDadosSimples(0);

  with CDS_Duplicatas do
  begin
    if not IsEmpty then
    begin
      First;
      while not EOF do
      begin
        Buffer  := PreencheEspaco(Copy(FieldByname('CODIGO').asString + ' | R$' + FormatFloat('0.00',FieldByname('VALORDUPLICATA').asFloat) + ' | ' + FieldByname('DATAVENCIMENTO').asString,1,60),60) + Chr(13) + Chr(10);
        ImprimirDadosSimples(0);

        Next;
      end;
    end;
  end;
  Buffer  := Chr(13) + Chr(10);
  ImprimirDadosSimples(0);  

  Buffer  := 'Forma Pagto: ' + PreencheEspaco(Copy(CDSPedidos.FieldbyName('DescrCondPagto').asString,1,20),20) + ' ' + 'Conferido:_________________' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := '------------------------------------------------------------' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


end;

function TFormCupom.TestaComando(Erro : Integer = 0) : Boolean;
begin
 Result := False;
 if Comando = Erro then
 begin
   Mensagens.Lines.Add('>> Problemas na Impressão do Texto Formatado.' + ' => Possíveis causas: Impressora desligada, off-line ou sem papel');
   Exit;
 end;
 Result := True;
end;

procedure TFormCupom.DadosCliente;
Var NumCNPJ : String;
begin
  If (Length(CDSPedidos.FieldByName('CPFCNPJ').asString) > 11) then
    NumCNPJ := FormatMaskText('!99\.999\.999\/9999\-99;0;',CDSPedidos.FieldByName('CPFCNPJ').asString)
  else
    NumCNPJ := FormatMaskText('!999\.999\.999\-99;0;',CDSPedidos.FieldByName('CPFCNPJ').asString);

  Buffer  := 'Cliente: ' + CDSPedidos.FieldByname('NomeCli').asString + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := 'Endereco: ' + Trim(Copy(CDSPedidos.FieldByName('Endereco').AsString,1,50))  +  Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  if Length(CDSPedidos.FieldByName('Endereco').AsString) > 40 then
    Buffer  := Chr(13) + Chr(10)
  else
    Buffer  := '';


  Buffer  := Buffer + 'Bairro: ' + CDSPedidos.FieldByName('Bairro').AsString +  '   CEP: ' + FormataCep(CDSPedidos.FieldByName('CEP').AsString) + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := 'Telefone: ' +  '(' + IntToStr(RetornarDDD(CDSPedidos.FieldByName('TelComercial1').AsString)) + ')' + RetornarTelefone(CDSPedidos.FieldByName('TelComercial1').AsString) +
             '   Fax: '   +  '(' + IntToStr(RetornarDDD(CDSPedidos.FieldByName('TelFax').AsString)) + ')' + RetornarTelefone(CDSPedidos.FieldByName('TelFax').AsString) + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := 'CPF: ' + NumCNPJ  + ' RG: ' + CDSPedidos.FieldByName('RGIE').AsString + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := 'Cidade: ' + CDSPedidos.FieldByName('Cidade').AsString + '   Estado: ' + CDSPedidos.FieldByName('Estado').AsString + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := '          ___/___/_____    ___:___' + Chr(13) + Chr(10);
  ImprimirDadosMedio(0);


  Buffer  := '              Data           Hora ' + Chr(13) + Chr(10);
  ImprimirDadosMedio(0);


  Buffer  := Chr(13) + Chr(10);
  ImprimirDadosSimples(0);


  Buffer  := '     ____________________________________' + Chr(13) + Chr(10);
  ImprimirDadosMedio(0);


  Buffer  := '                 Assinatura              ' + Chr(13) + Chr(10);
  ImprimirDadosMedio(0);


  Buffer  := Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  if Trim(Copy(CDSPedidos.FieldByName('DADOSADICIONAIS').AsString,1,50)) <> '' then
  begin
    Buffer  := Copy(CDSPedidos.FieldByName('DADOSADICIONAIS').AsString,1,50) + Chr(13) + Chr(10);
    ImprimirDadosSimples(0);
  end;

  if Trim(Copy(CDSPedidos.FieldByName('DADOSADICIONAIS').AsString,51,50)) <> '' then
  begin
    Buffer  := Copy(CDSPedidos.FieldByName('DADOSADICIONAIS').AsString,51,50) + Chr(13) + Chr(10);
    ImprimirDadosSimples(0);
  end;

  if Trim(Copy(CDSPedidos.FieldByName('DADOSADICIONAIS').AsString,101,50)) <> '' then
  begin
    Buffer  := Copy(CDSPedidos.FieldByName('DADOSADICIONAIS').AsString,101,50) + Chr(13) + Chr(10);
    ImprimirDadosSimples(0);
  end;

  if Trim(Copy(CDSPedidos.FieldByName('DADOSADICIONAIS').AsString,151,50)) <> '' then
  begin
    Buffer  := Copy(CDSPedidos.FieldByName('DADOSADICIONAIS').AsString,151,50) + Chr(13) + Chr(10);
    ImprimirDadosSimples(0);
  end;

  Buffer  := Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  if Trim(Copy(CDSEmpresa.FieldByName('MENSAGEM_CUPOM').AsString,1,50)) <> '' then
  begin
    Buffer  := Copy(CDSEmpresa.FieldByName('MENSAGEM_CUPOM').AsString,1,50) + Chr(13) + Chr(10);
    ImprimirDadosSimples(0);
  end;

  if Trim(Copy(CDSEmpresa.FieldByName('MENSAGEM_CUPOM').AsString,51,50)) <> '' then
  begin
    Buffer  := Copy(CDSEmpresa.FieldByName('MENSAGEM_CUPOM').AsString,51,50) + Chr(13) + Chr(10);
    ImprimirDadosSimples(0);
  end;

  if Trim(Copy(CDSEmpresa.FieldByName('MENSAGEM_CUPOM').AsString,101,50)) <> '' then
  begin
    Buffer  := Copy(CDSEmpresa.FieldByName('MENSAGEM_CUPOM').AsString,101,50) + Chr(13) + Chr(10);
    ImprimirDadosSimples(0);
  end;

  if Trim(Copy(CDSEmpresa.FieldByName('MENSAGEM_CUPOM').AsString,151,50)) <> '' then
  begin
    Buffer  := Copy(CDSEmpresa.FieldByName('MENSAGEM_CUPOM').AsString,151,50) + Chr(13) + Chr(10);
    ImprimirDadosSimples(0);
  end;

  Buffer  := '------------------------------------------------------------' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

end;


procedure TFormCupom.RodapeCupom;
begin
  Buffer  := FormatDateTime('dd/mm/yyyy hh:mm:ss',Now) + '    N. Pedido ' + CDSPedidos.FieldByName('Codigo').asString  + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '------------------------------------------------------------' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '                                                            ' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '                                                            ' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '                                                            ' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '                                                            ' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '                                                            ' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '                                                            ' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '                                                            ' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '                                                            ' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);

  Buffer  := '                                                            ' + Chr(13) + Chr(10);
  ImprimirDadosSimples(0);
end;

procedure TFormCupom.ImprimirCupom(MemoMsg : TMemo);
begin
  if ck_teste.Checked then
  begin
    AssignFile ( arq, 'C:\TESTE\CUPOM.TXT' );
    Rewrite ( arq );
  end
  else
  begin
    if (Retorno <> 24) and (Retorno <> 144) then
    begin
      MemoMsg.Lines.Add('>> Impressora não está Pronta! Verifique o Status!');
      Exit;
    end
    else
      MemoMsg.Lines.Add('>> Imprimindo... Pedido N.º ' + FloatToStr(vCodPedido));
  end;

  Alterar_Pedido;
  CarregaDadosEmpresa;
  ExibirDuplicatas;
  CarregaPedido;
  CarregaItens;

  Try
    CabecalhoCupom;
    VenderItens;
  Finally
    DadosCliente;
    RodapeCupom;
    MemoMsg.Lines.Clear;
  end;
  if ck_teste.Checked then
    CloseFile ( arq );
end;


procedure TFormCupom.IniciarPorta(MemoMsg : TMemo);
var
  Ret  : integer;
begin
  Ret := FechaPorta();
  if Ret <= 0 then
    MemoMsg.Lines.Add('>> Problemas ao fechar a porta de Comunicação!');

  if (ComboBoxPorta.ItemIndex) = 0 then
    Comunica := 'LPT1'#0;
  if (ComboBoxPorta.ItemIndex) = 1 then
    Comunica := 'COM1'#0;
  if (ComboBoxPorta.ItemIndex) = 2 then
    Comunica := 'COM2'#0;
  if (ComboBoxPorta.ItemIndex) = 3 then
    Comunica := 'USB'#0;

  MemoMsg.Lines.Add('>> Abrindo a Porta de Comunicação...');
  // Abre a porta de comunicacao
  Ret := IniciaPorta(Pchar(Comunica));
  if Ret <= 0 then
    MemoMsg.Lines.Add('>> Problemas ao abrir a Porta de Comunicação!')
end;



procedure TFormCupom.aClick(Sender: TObject);
begin
  close;
end;

procedure TFormCupom.FecharPorta(MemoMsg : TMemo);
Var Ret : Integer;
begin
  MemoMsg.Lines.Add('>> Fechando a Porta de Comunicação...');

  Ret := FechaPorta();
  if Ret <= 0 then
    MemoMsg.Lines.Add('>> Problemas ao Fechar a Porta de Comunicação!');
end;

procedure TFormCupom.ImprimirDadosDestaque;
begin
  if ck_teste.Checked then
    WriteLn (arq,  Copy(RemoveAcento(Buffer),1,60) )
  else
  begin
    Comando := FormataTX(Copy(RemoveAcento(Buffer),1,60),2,0,0,1,1);
    if TestaComando(0) = False then Exit;
  end;
end;

procedure TFormCupom.ImprimirDadosMedio(Negrito : Integer);
begin
  if ck_teste.Checked then
    WriteLn (arq,  Copy(RemoveAcento(Buffer),1,60) )
  else
  begin
    Comando := FormataTX(Copy(RemoveAcento(Buffer),1,60),2,0,0,0,Negrito);
    if TestaComando(0) = False then Exit;
  end;
end;

procedure TFormCupom.ImprimirDadosSimples(Negrito : Integer);
begin
  if ck_teste.Checked then
    WriteLn (arq,  Copy(RemoveAcento(Buffer),1,60) )
  else
  begin
    Comando := FormataTX(Copy(RemoveAcento(Buffer),1,60),1,0,0,0,0);
    if TestaComando(0) = False then Exit;
  end;
end;

Function TFormCupom.FormataProduto(CodGrupo, CodProduto, Classificacao : String) : String;
begin
  if Classificacao <> '' then
    Result := CodGrupo + '.' + CodProduto + '.' + Trim(Copy(Classificacao,1,3))
  else
    Result := CodGrupo + '.' + CodProduto;
end;


procedure TFormCupom.BitBtnStatusClick(Sender: TObject);
begin
  if TimerStatus.Enabled = False then
  begin
    TimerStatus.Enabled  := True;
    BitBtnStatus.Caption := '&Parar';
  end
  else
  begin
    TimerStatus.Enabled  := False;
    BitBtnStatus.Caption := 'I&niciar';
  end;
end;

procedure TFormCupom.FormShow(Sender: TObject);
begin
  PreparaImpressoraCupom(Mensagens,MemoStatus);
end;

procedure TFormCupom.TimerStatusTimer(Sender: TObject);
begin
  MostraStatus(MemoStatus);
end;


procedure TFormCupom.BitBtnImprimirClick(Sender: TObject);
begin
  ImprimirCupom(Mensagens);
end;

function TFormCupom.TratarTelefones : String;
Var Telefones : String;
begin
  Telefones := 'Telefones: ';
  if Trim(CDSEmpresa.FieldByName('TelComercial1').asString) <> '' then
    Telefones := Telefones + '(' + IntToStr(RetornarDDD(CDSEmpresa.FieldByName('TelComercial1').asString)) + ')' + RetornarTelefone(CDSEmpresa.FieldByName('TelComercial1').asString);
  if Trim(CDSEmpresa.FieldByName('TelComercial2').asString) <> '' then
    Telefones := Telefones + ' / ' + '(' + IntToStr(RetornarDDD(CDSEmpresa.FieldByName('TelComercial2').asString)) + ')' + RetornarTelefone(CDSEmpresa.FieldByName('TelComercial2').asString);
  if Trim(CDSEmpresa.FieldByName('TelResidencial').asString) <> '' then
    Telefones := Telefones + ' / ' + '(' + IntToStr(RetornarDDD(CDSEmpresa.FieldByName('TelResidencial').asString)) + ')' + RetornarTelefone(CDSEmpresa.FieldByName('TelResidencial').asString);
  Result := Telefones;
end;

procedure TFormCupom.ExibirDuplicatas;
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
    Params.ParamByName('CODPEDIDONF').asFloat    := vCodPedido;
    Params.ParamByName('TIPOPEDIDONF').asInteger := 1;
    TratarClientDatasetParaPost(CDS_Duplicatas);
  end;
end;


procedure TFormCupom.Alterar_Pedido;
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
      SQL.Add('Update PedidoNota');
      SQL.Add('  Set ');
      SQL.Add(' CodUsuario    = :CodUsuario,');
      SQL.Add(' DataImpressao = Current_Timestamp');
      SQL.Add(' where Tipo   = 1 ');
      SQL.Add('   and Codigo = :Codigo ');
      ParamByName('CodUsuario').AsFloat := DataModulePrin.UsuarioLogado;
      ParamByName('Codigo').AsFloat     := vCodPedido;
      ExecSQL;
      DataModulePrin.SQLConnectionPrin.Commit(TransDesc);
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar Pedido como Impresso. O Registro Não Poderá ser Gravado! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
      Close;
    end;
  end;
end;


procedure TFormCupom.PreparaImpressoraCupom(MemoMsg, MemoStatus : TMemo);
begin
  MemoStatusExt := MemoStatus;
  Comando := ConfiguraModeloImpressora(1);
  If Comando = -2 Then
    MemoMsg.Lines.Add('>> Parâmetro inválido na função "ConfiguraModeloImpressora"');
  IniciarPorta(MemoMsg);
  BitBtnStatus.OnClick(BitBtnStatus);
  MemoMsg.Lines.Add('>> Aguardando Impressão...');
end;


end.
