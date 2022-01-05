unit uFormDuplicatas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormModelo, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids,
  DBGrids, StdCtrls, TAdvEditP, Buttons, ExtCtrls, DbXpress, uFrameBancos,
  uFramePedidoNota, uFrameModelo, uFrameCliente, uFrameVendedor;

type
  TFormDuplicatas = class(TFormModelo)
    PnlTipo: TPanel;
    ComboBoxTipo: TComboBox;
    Label2: TLabel;
    GBFiltros: TGroupBox;
    FrameCliente: TFrameCliente;
    FramePedidoNota: TFramePedidoNota;
    ComboBoxTipoPedido: TComboBox;
    Label8: TLabel;
    FrameBancos: TFrameBancos;
    sp_filtrar: TSpeedButton;
    lblTotalPago: TLabel;
    Label5: TLabel;
    lblTotalAberto: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    DataIni: TAdvEdit;
    Label6: TLabel;
    DataFim: TAdvEdit;
    rg_duplicatas: TRadioGroup;
    Label7: TLabel;
    FrameVendedor: TFrameVendedor;
    procedure FormShow(Sender: TObject);
    procedure CDSPrincipalAfterOpen(DataSet: TDataSet);
    procedure BitBtnIncluirClick(Sender: TObject);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure ComboBoxTipoChange(Sender: TObject);
    procedure sp_filtrarClick(Sender: TObject);
    procedure ComboBoxTipoPedidoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Apagar;
    function VerificaMovimentos : Boolean;
    procedure ExibirDuplicatas;
    procedure CalcularMovimentos;
  public
    { Public declarations }
  end;

var
  FormDuplicatas: TFormDuplicatas;

implementation

uses uFormManutencaoDuplicatas, uDataModule;

{$R *.dfm}

procedure TFormDuplicatas.FormShow(Sender: TObject);
begin
  inherited;
  DataIni.asDate := Now - 90;  
  DataFim.asDate := Now;
  ExibirDuplicatas;
end;

procedure TFormDuplicatas.CDSPrincipalAfterOpen(DataSet: TDataSet);
begin
  with CDSPrincipal do
  begin
    FieldByName('CODIGO').DisplayLabel         := 'Código';
    FieldByName('CODCLIENTE').DisplayLabel     := 'Cliente';
    FieldByName('CODFORNECEDOR').DisplayLabel  := 'Fornecedor';
    FieldByName('CODBANCO').DisplayLabel       := 'Banco';
    FieldByName('DATAEMISSAO').DisplayLabel    := 'Emissão';
    FieldByName('DATAVENCIMENTO').DisplayLabel := 'Vencimento';
    FieldByName('DATAPAGAMENTO').DisplayLabel  := 'Pagamento';
    FieldByName('VALORTOTAL').DisplayLabel     := 'Vlr. Total ';
    FieldByName('VALORDUPLICATA').DisplayLabel := 'Vlr. Dupl';
    FieldByName('VALORPAGO').DisplayLabel      := 'Vlr. Pago';
    FieldByName('VALORJUROS').DisplayLabel     := 'Vlr. Juros';
    FieldByName('CODPEDIDONF').DisplayLabel    := 'Pedido / NF';

    FieldByName('TIPOPEDIDONF').Visible   := False;
    FieldByName('TIPO').Visible           := False;
    FieldByName('CODCLIENTE').Visible     := (ComboBoxTipo.ItemIndex = 0);
    FieldByName('CODFORNECEDOR').Visible  := (ComboBoxTipo.ItemIndex = 1);


    FieldByName('CODIGO').DisplayWidth         := 8;
    FieldByName('TIPO').DisplayWidth           := 10;
    FieldByName('CODCLIENTE').DisplayWidth     := 15;
    FieldByName('CODFORNECEDOR').DisplayWidth  := 15;
    FieldByName('CODBANCO').DisplayWidth       := 10;
    FieldByName('DATAEMISSAO').DisplayWidth    := 15;
    FieldByName('DATAVENCIMENTO').DisplayWidth := 15;
    FieldByName('DATAPAGAMENTO').DisplayWidth  := 15;
    FieldByName('VALORTOTAL').DisplayWidth     := 15;
    FieldByName('VALORDUPLICATA').DisplayWidth := 15;
    FieldByName('VALORPAGO').DisplayWidth      := 15;
    FieldByName('VALORJUROS').DisplayWidth     := 15;
    FieldByName('CODPEDIDONF').DisplayWidth    := 10;

    (FieldByName('VALORTOTAL') as TNumericField).DisplayFormat     := '#,##0.00';
    (FieldByName('VALORDUPLICATA') as TNumericField).DisplayFormat := '#,##0.00';
    (FieldByName('VALORPAGO') as TNumericField).DisplayFormat      := '#,##0.00';
    (FieldByName('VALORJUROS') as TNumericField).DisplayFormat     := '#,##0.00';
  end;

  inherited;

end;

procedure TFormDuplicatas.BitBtnIncluirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormManutencaoDuplicatas, FormManutencaoDuplicatas);
    FormManutencaoDuplicatas.InicializaTela(1, CDSPrincipal);
    FormManutencaoDuplicatas.ComboBoxTipoDupl.ItemIndex := ComboBoxTipo.ItemIndex; 
    FormManutencaoDuplicatas.ShowModal;
  Finally
    ExibirDuplicatas;
    CDSPrincipal.Locate('Codigo',FormManutencaoDuplicatas.EditCodigo.asInteger,[]);
    FormManutencaoDuplicatas.Free;
  end;
end;

procedure TFormDuplicatas.BitBtnAlterarClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) Then
    Exit;
      
  Try
    Application.CreateForm(TFormManutencaoDuplicatas, FormManutencaoDuplicatas);
    FormManutencaoDuplicatas.InicializaTela(2, CDSPrincipal);
    FormManutencaoDuplicatas.ComboBoxTipoDupl.ItemIndex := ComboBoxTipo.ItemIndex;    
    FormManutencaoDuplicatas.ShowModal;
  Finally
    ExibirDuplicatas;
    CDSPrincipal.Locate('Codigo',FormManutencaoDuplicatas.EditCodigo.asInteger,[]);
    FormManutencaoDuplicatas.Free;
  end;
end;

procedure TFormDuplicatas.Apagar;
Var TransDesc : TTransactionDesc;
    BM : TBookMark;
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
        SQL.Add(' DELETE FROM DUPLICATAS');
        SQL.Add(' WHERE CODIGO = :CODIGO');
        SQL.Add('   AND TIPO = :TIPO');
        ParamByName('Codigo').asString := CDSPrincipal.FieldByName('Codigo').asString;
        ParamByName('TIPO').asFloat   := CDSPrincipal.FieldByName('TIPO').asFloat;
        ExecSQL;

        CDSPrincipal.Prior;
        BM := CDSPrincipal.GetBookMark;
        SQLConnectionPrin.Commit(TransDesc);
        ExibirDuplicatas;
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



procedure TFormDuplicatas.BitBtnExcluirClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    Exit;

  if VerificaMovimentos then
  begin
    Application.MessageBox('Duplicata não poderá ser excluída pois possui Movimentos!','Informação',0);
    Exit;
  end;

  If Application.MessageBox('Deseja Realmente Excluir a Duplicata Selecionada?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
    Apagar;
end;

procedure TFormDuplicatas.ComboBoxTipoChange(Sender: TObject);
begin
  inherited;
  ExibirDuplicatas;
end;

function TFormDuplicatas.VerificaMovimentos : Boolean;
begin
  with DataModulePrin.SQLQueryPesquisa do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' Select * from MovFinanceiro where CodDuplicata = :CodDuplicata and Tipo = :Tipo');
    Parambyname('CodDuplicata').asString := CDSPrincipal.FieldByname('Codigo').asString;
    Parambyname('Tipo').asInteger       := CDSPrincipal.FieldByname('Tipo').asInteger;
    Open;

    Result := (not IsEmpty)
  end;
end;


procedure TFormDuplicatas.ExibirDuplicatas;
Var MontaWhere : String;
begin
  inherited;
  MontaWhere := ' where Tipo = ' + IntToStr(ComboBoxTipo.ItemIndex + 1);

  if FrameCliente.EditCodigo.asFloat > 0 then
    MontaWhere := MontaWhere + ' and CODCLIENTE = ' + FrameCliente.EditCodigo.Text;

  if FrameBancos.EditCodigo.asFloat > 0 then
    MontaWhere := MontaWhere + ' and CODBANCO = ' + FrameBancos.EditCodigo.Text;

  if FramePedidoNota.EditCodigo.asFloat > 0 then
  begin
    MontaWhere := MontaWhere + ' and CODPEDIDONF  = ' + FramePedidoNota.EditCodigo.Text;
    MontaWhere := MontaWhere + ' and TIPOPEDIDONF = ' + IntToStr(ComboBoxTipoPedido.ItemIndex + 1);
  end;
  if DataIni.IsDate then
    MontaWhere := MontaWhere + ' and DATAEMISSAO >= Cast(' + QuotedStr(FormatdateTime('YYYY/MM/DD',DataIni.asDate)) + ' AS DATE)';
  if DataFim.IsDate then
    MontaWhere := MontaWhere + ' and DATAEMISSAO <= Cast(' + QuotedStr(FormatdateTime('YYYY/MM/DD',DataFim.asDate)) + ' AS DATE)';

  if rg_duplicatas.ItemIndex <> 0 then
  begin
    if rg_duplicatas.ItemIndex = 1 then
      MontaWhere := MontaWhere + ' and (VALORPAGO >= VALORDUPLICATA) '
    else if rg_duplicatas.ItemIndex = 2 then
      MontaWhere := MontaWhere + ' and (VALORPAGO < VALORDUPLICATA) ';
  end;

  if FrameVendedor.EditCodigo.asInteger <> 0 then
    MontaWhere := MontaWhere + ' and EXISTS(SELECT PN.CODIGO FROM PEDIDONOTA PN WHERE PN.CODVENDEDOR =  ' + FrameVendedor.EditCodigo.Text + ' AND PN.CODIGO = DUPLICATAS.CODPEDIDONF)';


  MostrarDados('Duplicatas','','Codigo',MontaWhere);
  CalcularMovimentos;
end;


procedure TFormDuplicatas.sp_filtrarClick(Sender: TObject);
begin
  inherited;
  ExibirDuplicatas;
end;

procedure TFormDuplicatas.ComboBoxTipoPedidoChange(Sender: TObject);
begin
  inherited;
  FramePedidoNota.vTipo := ComboBoxTipoPedido.ItemIndex + 1;
end;

procedure TFormDuplicatas.FormCreate(Sender: TObject);
begin
  inherited;
  FramePedidoNota.vTipo := ComboBoxTipoPedido.ItemIndex + 1;
  lblTotalPago.Caption := FormatFloat('#,##0.00',0);
  lblTotalAberto.Caption := FormatFloat('#,##0.00',0);    
end;

procedure TFormDuplicatas.CalcularMovimentos;
Var ValorPago, ValorAberto : Real;
begin
  with CDSPrincipal do
  begin
    DisableControls;
    First;
    ValorPago := 0;
    ValorAberto := 0;
    while not EOF do
    begin
      ValorPago   := ValorPago + FieldByname('VALORPAGO').asFloat;
      ValorAberto := ValorAberto + FieldByname('VALORDUPLICATA').asFloat;
      Next;
    end;
    EnableControls;
  end;
  ValorAberto := ValorAberto - ValorPago;
  lblTotalPago.Caption := FormatFloat('#,##0.00',ValorPago);
  lblTotalAberto.Caption := FormatFloat('#,##0.00',ValorAberto);
end;



end.
