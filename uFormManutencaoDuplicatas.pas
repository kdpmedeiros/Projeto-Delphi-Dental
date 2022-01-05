unit uFormManutencaoDuplicatas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, StdCtrls, Mask, TAdvEditP, DB, DBCtrls,
  Buttons, ExtCtrls, uFrameModelo, uFrameCliente, uFrameBancos,
  uFramePedidoNota, DBxpress, SqlTimSt, uFrameFornecedor;

type
  TFormManutencaoDuplicatas = class(TFormManutencao)
    GroupBox2: TGroupBox;
    Label23: TLabel;
    EditCodigo: TAdvEdit;
    FrameBancos: TFrameBancos;
    EditDataEmissao: TAdvEdit;
    EditDataVencimento: TAdvEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditDataPagamento: TAdvEdit;
    EditValorTotal: TAdvEdit;
    Label4: TLabel;
    Label5: TLabel;
    EditValorDupl: TAdvEdit;
    EditValorPago: TAdvEdit;
    Label6: TLabel;
    Label7: TLabel;
    EditValorJuros: TAdvEdit;
    FramePedidoNota: TFramePedidoNota;
    ComboBoxTipoPedido: TComboBox;
    Label8: TLabel;
    ComboBoxTipoDupl: TComboBox;
    FrameFornecedor: TFrameFornecedor;
    FrameCliente: TFrameCliente;
    procedure FormShow(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure ComboBoxTipoPedidoChange(Sender: TObject);
    procedure FramePedidoNotaSpeedButtonConsultaClick(Sender: TObject);
    procedure FramePedidoNotaEditCodigoExit(Sender: TObject);
  private
    { Private declarations }
    procedure Gravar;
    procedure VoltaUltimSequencia;
    procedure PrepararTelaManutencao;
    procedure LimparTela;
    function RetornaProximaSequencia : Integer;
  public
    { Public declarations }
  end;

var
  FormManutencaoDuplicatas: TFormManutencaoDuplicatas;

implementation

uses uDataModule;

{$R *.dfm}

procedure TFormManutencaoDuplicatas.PrepararTelaManutencao;
begin

  with CDSCadastro do
  begin
    if iTipo = 1 then
    begin
      LimparTela;
      EditCodigo.text   := IntToStr(RetornaProximaSequencia);
      EditDataEmissao.asDate := Now;
    end
    else if iTipo = 2 then
    begin
      EditCodigo.Text                      := FieldByName('Codigo').asString;
      EditDataEmissao.asDate               := FieldByName('DATAEMISSAO').asDateTime;
      EditDataVencimento.asDate            := FieldByName('DATAVENCIMENTO').asDateTime;
      if not FieldByName('DATAPAGAMENTO').isNull then
        EditDataPagamento.asDate             := FieldByName('DATAPAGAMENTO').asDateTime;
      if not FieldByName('CODCLIENTE').IsNull then
      begin
        FrameCliente.EditCodigo.asInteger      := FieldByName('CODCLIENTE').asInteger;
        FrameCliente.EditCodigo.OnExit(FrameCliente.EditCodigo);
      end;  
      if not FieldByName('CODFORNECEDOR').isNull then
      begin
        FrameFornecedor.EditCodigo.asInteger := FieldByName('CODFORNECEDOR').asInteger;
        FrameFornecedor.EditCodigo.OnExit(FrameFornecedor.EditCodigo);
      end;
      FrameBancos.EditCodigo.asInteger     := FieldByName('CODBANCO').asInteger;
      FrameBancos.EditCodigo.OnExit(FrameBancos.EditCodigo);
      EditValorTotal.asFloat               := FieldByName('VALORTOTAL').asFloat;
      EditValorDupl.asFloat                := FieldByName('VALORDUPLICATA').asFloat;
      EditValorPago.asFloat                := FieldByName('VALORPAGO').asFloat;
      EditValorJuros.asFloat               := FieldByName('VALORJUROS').asFloat;
      ComboBoxTipoPedido.ItemIndex         := FieldByName('TIPOPEDIDONF').asInteger - 1;
      FramePedidoNota.EditCodigo.asInteger := FieldByName('CODPEDIDONF').asInteger;
    end;
    FramePedidoNota.vTipo := ComboBoxTipoPedido.ItemIndex + 1;
  end;
  FrameCliente.Visible    := (ComboBoxTipoDupl.ItemIndex = 0);
  FrameFornecedor.Visible := (ComboBoxTipoDupl.ItemIndex  = 1);
end;


procedure TFormManutencaoDuplicatas.FormShow(Sender: TObject);
begin
  EditDataVencimento.SetFocus;
  inherited;
  PrepararTelaManutencao;
end;

procedure TFormManutencaoDuplicatas.Gravar;
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
        if iTipo = 1 then
        begin
          SQL.Clear;
          SQL.Add(' INSERT INTO DUPLICATAS (');
          SQL.Add('     CODIGO, TIPO, CODCLIENTE, CODBANCO, DATAEMISSAO, DATAVENCIMENTO,');
          SQL.Add('     DATAPAGAMENTO, VALORTOTAL, VALORDUPLICATA, VALORPAGO,');
          SQL.Add('     VALORJUROS, CODPEDIDONF, TIPOPEDIDONF, CODFORNECEDOR)');
          SQL.Add(' VALUES (');
          SQL.Add('     :CODIGO, :TIPO, :CODCLIENTE, :CODBANCO, :DATAEMISSAO, :DATAVENCIMENTO,');
          SQL.Add('     :DATAPAGAMENTO, :VALORTOTAL, :VALORDUPLICATA, :VALORPAGO,');
          SQL.Add('     :VALORJUROS, :CODPEDIDONF, :TIPOPEDIDONF, :CODFORNECEDOR)');
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE DUPLICATAS');
          SQL.Add(' SET CODCLIENTE     = :CODCLIENTE,');
          SQL.Add('      CODBANCO       = :CODBANCO,');
          SQL.Add('      DATAEMISSAO    = :DATAEMISSAO,');
          SQL.Add('      DATAVENCIMENTO = :DATAVENCIMENTO,');
          SQL.Add('      DATAPAGAMENTO  = :DATAPAGAMENTO,');
          SQL.Add('      VALORTOTAL     = :VALORTOTAL,');
          SQL.Add('      VALORDUPLICATA = :VALORDUPLICATA,');
          SQL.Add('      VALORPAGO      = :VALORPAGO,');
          SQL.Add('      VALORJUROS     = :VALORJUROS,');
          SQL.Add('      CODPEDIDONF    = :CODPEDIDONF,');
          SQL.Add('      TIPOPEDIDONF   = :TIPOPEDIDONF,');
          SQL.Add('      CODFORNECEDOR  = :CODFORNECEDOR');
          SQL.Add(' WHERE CODIGO  = :CODIGO');
          SQL.Add('   and TIPO    = :TIPO');
        end;
        ParamByName('Codigo').asString       := EditCodigo.Text;
        ParamByName('TIPO').asInteger        := ComboBoxTipoDupl.ItemIndex + 1;
        ParamByName('CODCLIENTE').DataType   := ftInteger;
        ParamByName('CODCLIENTE').Clear;
        if FrameCliente.EditCodigo.asInteger > 0 then
          ParamByName('CODCLIENTE').asInteger  := FrameCliente.EditCodigo.asInteger;

        ParamByName('CODFORNECEDOR').DataType := ftInteger;
        ParamByName('CODFORNECEDOR').Clear;
        if FrameFornecedor.EditCodigo.asInteger > 0 then
          ParamByName('CODFORNECEDOR').asInteger  := FrameFornecedor.EditCodigo.asInteger;

        ParamByName('CODBANCO').asInteger   := FrameBancos.EditCodigo.asInteger;
        ParamByName('DATAEMISSAO').DataType := ftTimeStamp;
        ParamByName('DATAEMISSAO').Clear;
        if EditDataEmissao.IsDate then
          ParamByName('DATAEMISSAO').asSQLTimestamp := DateTimeToSQLTImesTamp(EditDataEmissao.asDate);
        ParamByName('DATAVENCIMENTO').DataType := ftTimeStamp;
        ParamByName('DATAVENCIMENTO').Clear;
        if EditDataVencimento.IsDate then
          ParamByName('DATAVENCIMENTO').asSQLTimestamp := DateTimeToSQLTImesTamp(EditDataVencimento.asDate);
        ParamByName('DATAPAGAMENTO').DataType := ftTimeStamp;
        ParamByName('DATAPAGAMENTO').Clear;
        if EditDataPagamento.IsDate then
          ParamByName('DATAPAGAMENTO').asSQLTimestamp := DateTimeToSQLTImesTamp(EditDataPagamento.asDate);
        ParamByName('VALORTOTAL').asFloat     := EditValorTotal.asFloat;
        ParamByName('VALORDUPLICATA').asFloat := EditValorDupl.asFloat;
        ParamByName('VALORPAGO').asFloat      := EditValorPago.asFloat;
        ParamByName('VALORJUROS').asFloat     := EditValorJuros.asFloat;
        ParamByName('CODPEDIDONF').asInteger  := FramePedidoNota.EditCodigo.asInteger;
        ParamByName('TIPOPEDIDONF').asInteger := ComboBoxTipoPedido.ItemIndex + 1;
        ExecSQL;
        SQLConnectionPrin.Commit(TransDesc);
        if CheckBoxFecharTela.Checked then
          Self.Close
        else
        begin
          LimparTela;
          if iTipo = 2 then
            CDSCadastro.Next;
          PrepararTelaManutencao;
          EditDataVencimento.SetFocus;
        end;
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


procedure TFormManutencaoDuplicatas.VoltaUltimSequencia;
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
      if ComboBoxTipoDupl.itemIndex = 0 then
        SQL.Add('  Set CodDuplicataRec = ' + EditCodigo.Text + ' - 1')
      else
        SQL.Add('  Set CodDuplicataPag = ' + EditCodigo.Text + ' - 1');
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


procedure TFormManutencaoDuplicatas.BitBtnCancelarClick(Sender: TObject);
begin
  inherited;
  if iTipo = 1 then
    VoltaUltimSequencia;
end;

procedure TFormManutencaoDuplicatas.LimparTela;
begin
  EditCodigo.Limpa;
  EditDataEmissao.Limpa;
  EditDataVencimento.Limpa;
  FrameCliente.LimparFrame;
  FrameFornecedor.LimparFrame;
  FrameBancos.LimparFrame;
  EditValorTotal.Limpa;
  EditValorDupl.Limpa;
  EditValorPago.Limpa;
  EditValorJuros.Limpa;
  EditDataPagamento.Limpa;
  ComboBoxTipoPedido.ItemIndex := 0;
  FramePedidoNota.LimparFrame;
end;

function TFormManutencaoDuplicatas.RetornaProximaSequencia : Integer;
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
        if ComboBoxTipoDupl.ItemIndex = 0 then
          SQL.Add('  Set CodDuplicataRec = CodDuplicataRec + 1')
        else
          SQL.Add('  Set CodDuplicataPag = CodDuplicataPag + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        if ComboBoxTipoDupl.ItemIndex = 0 then
          SQL.Add('Select Count(*) as Qtde from Duplicatas where Codigo = cast((Select CodDuplicataRec from UltimaSequencia) as varchar(20))')
        else
          SQL.Add('Select Count(*) as Qtde from Duplicatas where Codigo = cast((Select CodDuplicataPag from UltimaSequencia) as varchar(20))');
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
        if ComboBoxTipoDupl.ItemIndex = 0 then
          SQL.Add('  Select  CodDuplicataRec as Codigo from UltimaSequencia')
        else
          SQL.Add('  Select  CodDuplicataPag as Codigo from UltimaSequencia');
      Open;

      Result := FieldByname('Codigo').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;



procedure TFormManutencaoDuplicatas.BitBtnConfirmarClick(Sender: TObject);
begin
  inherited;
  if FramePedidoNota.EditCodigo.asInteger <> 0 then
  begin
    if FramePedidoNota.Pesquisar = False then
    begin
      Application.MessageBox(PChar(ComboBoxTipoPedido.Text +  ' não Existe no Sistema!'),'Informação',0);
      FramePedidoNota.EditCodigo.SetFocus;
      Exit;
    end;
  end;

  if EditDataVencimento.IsDate = False then
  begin
    Application.MessageBox('Informe o Vencimento!','Informação',0);
    EditDataVencimento.SetFocus;
    Exit;
  end;

  if ComboBoxTipoDupl.ItemIndex = 0 then
  begin
    if FrameCliente.EditCodigo.asFloat = 0 then
    begin
      Application.MessageBox('Informe o Cliente!','Informação',0);
      FrameCliente.EditCodigo.SetFocus;
      Exit;
    end;
  end
  else
  begin
    if FrameFornecedor.EditCodigo.asFloat = 0 then
    begin
      Application.MessageBox('Informe o Fornecedor!','Informação',0);
      FrameFornecedor.EditCodigo.SetFocus;
      Exit;
    end;
  end;

  if FrameBancos.EditCodigo.asFloat = 0 then
  begin
    Application.MessageBox('Informe o Banco!','Informação',0);
    FrameBancos.EditCodigo.SetFocus;
    Exit;
  end;

  if EditValorTotal.asFloat = 0 then
  begin
    Application.MessageBox('Informe o Valor Total da Duplicata','Informação',0);
    EditValorTotal.SetFocus;
    Exit;
  end;

  if EditValorDupl.asFloat = 0 then
  begin
    Application.MessageBox('Informe o Valor da Duplicata','Informação',0);
    EditValorDupl.SetFocus;
    Exit;
  end;

  if EditDataPagamento.IsDate then
  begin
    Application.MessageBox('Duplicata não poderá ser Alterada pois já foi Paga!','Informação',0);
    Exit;
  end;
  Gravar;
end;

procedure TFormManutencaoDuplicatas.ComboBoxTipoPedidoChange(
  Sender: TObject);
begin
  inherited;
  FramePedidoNota.vTipo := ComboBoxTipoPedido.ItemIndex + 1;
end;

procedure TFormManutencaoDuplicatas.FramePedidoNotaSpeedButtonConsultaClick(
  Sender: TObject);
begin
  inherited;
  FramePedidoNota.SpeedButtonConsultaClick(Sender);

end;

procedure TFormManutencaoDuplicatas.FramePedidoNotaEditCodigoExit(
  Sender: TObject);
begin
  inherited;
  if FramePedidoNota.EditCodigo.asInteger <> 0 then
  begin
    if FramePedidoNota.Pesquisar = False then
    begin
      Application.MessageBox(PChar(ComboBoxTipoPedido.Text +  ' não Existe no Sistema!'),'Informação',0);
      FramePedidoNota.EditCodigo.SetFocus;
    end;
  end;
end;

end.
