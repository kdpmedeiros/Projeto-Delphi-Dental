unit uFormBaixaDuplicatas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, DB, DBCtrls, StdCtrls, Buttons, ExtCtrls,
  uFrameModelo, uFrameDuplicatas, TAdvEditP, DbXPress, SqlTimSt;

type
  TFormBaixaDuplicatas = class(TFormManutencao)
    GroupBox2: TGroupBox;
    Label6: TLabel;
    EditValorPago: TAdvEdit;
    Label3: TLabel;
    EditDataPagamento: TAdvEdit;
    FrameDuplicatas: TFrameDuplicatas;
    Label1: TLabel;
    ComboBoxTipoPedido: TComboBox;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure FrameDuplicatasEditCodigoExit(Sender: TObject);
    procedure FrameDuplicatasSpeedButtonConsultaClick(Sender: TObject);
    procedure ComboBoxTipoPedidoChange(Sender: TObject);
  private
    { Private declarations }
    procedure GravaMovimento(Operacao : Integer);
    procedure LimparTela;
    procedure PrepararTelaManutencao;
    function  Retorna_ValorRestante : Double;
  public
    { Public declarations }
  end;

var
  FormBaixaDuplicatas: TFormBaixaDuplicatas;

implementation

uses uDataModule, SqlExpr, Math, uFuncoes;

{$R *.dfm}

procedure TFormBaixaDuplicatas.FormShow(Sender: TObject);
begin
  if FrameDuplicatas.EditCodigo.CanFocus then
    FrameDuplicatas.EditCodigo.SetFocus;
  inherited;
  FrameDuplicatas.b_somente_em_aberto := (iTipo = 1);

  PrepararTelaManutencao;

  if iTipo = 1 then
  begin
    FrameDuplicatas.SpeedButtonConsulta.OnClick(FrameDuplicatas.SpeedButtonConsulta);
    EditValorPago.asFloat :=  Retorna_ValorRestante;
  end;
  
  if EditDataPagamento.IsDate = False then
    EditDataPagamento.asDate := Now;
end;

procedure TFormBaixaDuplicatas.GravaMovimento(Operacao : Integer);
{1 - Inserção / 2 - Alteração}
Var TransDesc : TTransactionDesc;
    UltimaSeq : Integer;

  Procedure  PegaUltimaSequencia;
  begin
    with DataModulePrin.SQLQueryPesquisa do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' Select (Max(Codigo) + 1) as UltSeq from MovFinanceiro ');
      Open;

      If IsEmpty  then
        UltimaSeq := 1
      else
      begin
        if FieldByname('UltSeq').IsNull then
          UltimaSeq := 1
        else
          UltimaSeq := FieldByname('UltSeq').asInteger;
      end;
    end;
  end;

begin
  Try
    TransDesc.TransactionID  := 1;
    TransDesc.IsolationLevel := xilREADCOMMITTED;
    DataModulePrin.SQLConnectionPrin.StartTransaction(TransDesc);
    with DataModulePrin.SQLQueryExecuta do
    begin
      Close;
      SQL.Clear;
      if  Operacao = 1 then
      begin
        PegaUltimaSequencia;
        SQL.Add('INSERT INTO MOVFINANCEIRO (CODIGO, CODDUPLICATA, TIPO, DATAEMISSAO, VALOR) ');
        SQL.Add(' VALUES (:CODIGO, :CODDUPLICATA, :TIPO, :DATAEMISSAO, :VALOR) ');
        ParamByName('CODIGO').asInteger  := UltimaSeq;
      end
      else
      begin
        SQL.Add('Update MOVFINANCEIRO ');
        SQL.Add('  Set VALOR       = :VALOR, ');
        SQL.Add('      DATAEMISSAO = :DATAEMISSAO');
        SQL.Add('WHERE CODIGO      = :CODIGO ');
        SQL.Add(' AND CODDUPLICATA = :CODDUPLICATA ');
        SQL.Add(' AND TIPO         = :TIPO ');
        ParamByName('CODIGO').asInteger             := CDSCadastro.FieldByname('CODIGO').asInteger;
      end;
      ParamByname('CODDUPLICATA').asString        := FrameDuplicatas.EditCodigo.Text;
      ParamByname('TIPO').asInteger               := FrameDuplicatas.ComboBoxTipo.ItemIndex + 1;
      ParamByname('VALOR').asFloat                := EditValorPago.asFloat;
      ParamByname('DATAEMISSAO').asSqlTimesTamp   := DateTimetoSqlTimeStamp(EditDataPagamento.asDate);
      ExecSQL;
      DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

      if CheckBoxFecharTela.Checked = True then
        Self.Close
      else
      begin
        LimparTela;
        if iTipo = 2 then
          CDSCadastro.Next;

        if Self.Showing  then
        begin
          PrepararTelaManutencao;

          if iTipo = 1 then
          begin
            FrameDuplicatas.SpeedButtonConsulta.OnClick(FrameDuplicatas.SpeedButtonConsulta);
            EditValorPago.asFloat :=  Retorna_ValorRestante;
            if EditDataPagamento.IsDate = False then
              EditDataPagamento.asDate := Now;
          end;
        end;


        if FrameDuplicatas.EditCodigo.CanFocus then
          FrameDuplicatas.EditCodigo.SetFocus
        else
          EditValorPago.SetFocus;
      end;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar o Movimento. O Registro Não Poderá ser Gravado! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
      Close;
    end;
  end;
end;


procedure TFormBaixaDuplicatas.BitBtnConfirmarClick(Sender: TObject);
begin
  inherited;
  if Trim(FrameDuplicatas.EditCodigo.Text) = '' then
  begin
    Application.MessageBox('Informe a Duplicata!','Informação',0);
    FrameDuplicatas.EditCodigo.SetFocus;
    Exit;
  end;

  if EditValorPago.asFloat = 0 then
  begin
    Application.MessageBox('Informe o Valor Pago!','Informação',0);
    EditValorPago.SetFocus;
    Exit;
  end;

  if FrameDuplicatas.r_valor_duplicata < EditValorPago.asFloat then
  begin
    Application.MessageBox('O Valor Pago não pode ser maior que o valor da Duplicata!','Informação',0);
    EditValorPago.SetFocus;
    Exit;
  end;

  if RoundTo(EditValorPago.asFloat,-2) > RoundTo(Retorna_ValorRestante,-2) then
  begin
    Application.MessageBox('O Valor Pago é maior do que o Valor a Pagar da Duplicata!','Informação',0);
    EditValorPago.SetFocus;
    Exit;
  end;

  if EditDataPagamento.IsDate = False then
  begin
    Application.MessageBox('Informe a Data de Pagamento!','Informação',0);
    EditDataPagamento.SetFocus;
    Exit;
  end;

  GravaMovimento(iTipo);
end;

procedure TFormBaixaDuplicatas.LimparTela;
begin
  FrameDuplicatas.EditCodigo.Limpa;
  EditValorPago.Limpa;
  EditDataPagamento.Limpa;

  if FrameDuplicatas.EditCodigo.CanFocus then
    FrameDuplicatas.EditCodigo.SetFocus;
end;

procedure TFormBaixaDuplicatas.PrepararTelaManutencao;
begin
  with CDSCadastro do
  begin
    if iTipo = 1 then
      LimparTela
    else if iTipo = 2 then
    begin
      ComboBoxTipoPedido.Enabled         := False;
      FrameDuplicatas.EditCodigo.Text    := FieldByName('CODDUPLICATA').asString;
      HabilitaFrame(FrameDuplicatas,False);
      EditValorPago.asFloat              := FieldByName('VALOR').asFloat;
      EditDataPagamento.asDate           := FieldByName('DATAEMISSAO').asDateTime;
//      EditDataPagamento.Enabled          := False;
    end;
  end;
end;



function TFormBaixaDuplicatas.Retorna_ValorRestante : Double;
begin
  With DataModulePrin.SQLQueryPesquisa do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' Select VALORDUPLICATA, VALORPAGO from Duplicatas ');
    SQL.Add(' where Codigo = :Codigo ');
    SQL.Add('   and Tipo = :Tipo ');
    ParamByName('Codigo').asString  := FrameDuplicatas.EditCodigo.Text;
    ParamByName('Tipo').asInteger   := FrameDuplicatas.ComboBoxTipo.ItemIndex + 1;
    Open;

    if iTipo = 2 then
      Result := (FieldByName('VALORDUPLICATA').asFloat - FieldByName('VALORPAGO').asFloat) + DS_Manutencao.DataSet.FieldByName('VALOR').asFloat
    else
      Result := (FieldByName('VALORDUPLICATA').asFloat - FieldByName('VALORPAGO').asFloat);
  end;
end;

procedure TFormBaixaDuplicatas.FrameDuplicatasEditCodigoExit(
  Sender: TObject);
begin
  inherited;
  FrameDuplicatas.EditCodigoExit(Sender);
  if iTipo = 1 then
    EditValorPago.asFloat :=  Retorna_ValorRestante;
end;

procedure TFormBaixaDuplicatas.FrameDuplicatasSpeedButtonConsultaClick(
  Sender: TObject);
begin
  inherited;
  FrameDuplicatas.SpeedButtonConsultaClick(Sender);
  if iTipo = 1 then
    EditValorPago.asFloat :=  Retorna_ValorRestante;
end;

procedure TFormBaixaDuplicatas.ComboBoxTipoPedidoChange(Sender: TObject);
begin
  inherited;
  FrameDuplicatas.i_tipo_ped_nf := ComboBoxTipoPedido.ItemIndex + 1;
end;

end.
