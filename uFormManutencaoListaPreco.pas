unit uFormManutencaoListaPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, Buttons, ExtCtrls, StdCtrls, DBXpress, SqlTimSt, math, DB,
  TAdvEditP, DBCtrls;

type
  TFormManutencaoListaPreco = class(TFormManutencao)
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label23: TLabel;
    EditNome: TAdvEdit;
    EditValorCusto: TAdvEdit;
    EditValorVenda: TAdvEdit;
    EditPercFreteVenda: TAdvEdit;
    EditCodigo: TAdvEdit;
    Label16: TLabel;
    EditValorVendaFrete: TAdvEdit;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    EditPercFreteCompra: TAdvEdit;
    EditPercICMS: TAdvEdit;
    Label2: TLabel;
    EditPercLucro: TAdvEdit;
    Label10: TLabel;
    Label4: TLabel;
    EditValorLucro: TAdvEdit;
    RBLucroPercentual: TRadioButton;
    RBLucroValor: TRadioButton;
    Label1: TLabel;
    EditValorCustoCompra: TAdvEdit;
    procedure FormShow(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure EditValorCustoExit(Sender: TObject);
    procedure EditPercFreteCompraExit(Sender: TObject);
    procedure EditPercICMSExit(Sender: TObject);
    procedure EditPercLucroExit(Sender: TObject);
    procedure EditValorLucroExit(Sender: TObject);
    procedure EditPercFreteVendaExit(Sender: TObject);
    procedure RBLucroPercentualClick(Sender: TObject);
    procedure RBLucroValorClick(Sender: TObject);
  private
    { Private declarations }
    procedure PrepararTelaManutencao;
    procedure Gravar;
    procedure LimparTela;
    procedure CalcularValorVenda;
    procedure CalcularCustoCompra;
    function RetornaProximaSequencia : Integer;
  public
    { Public declarations }
  end;

var
  FormManutencaoListaPreco: TFormManutencaoListaPreco;

implementation

uses uDataModule, uFuncoes;

{$R *.dfm}

procedure TFormManutencaoListaPreco.PrepararTelaManutencao;
begin

  with CDSCadastro do
  begin
    if iTipo = 1 then
    begin
      LimparTela;
      EditCodigo.asInteger := RetornaProximaSequencia;
    end
    else if iTipo = 2 then
    begin
      EditCodigo.asInteger         := FieldByName('Codigo').asInteger;
      EditNome.Text                := FieldByName('Descricao').asString;
      EditValorCusto.asFloat       := FieldByName('ValorCusto').asFloat;
      EditPercFreteCompra.asFloat  := FieldByName('PercFreteCompra').asFloat;
      EditPercICMS.asFloat         := FieldByName('PercICMS').asFloat;
      EditPercLucro.asFloat        := FieldByName('PercLucro').asFloat;
      EditValorLucro.asFloat       := FieldByName('ValorLucro').asFloat;
      EditValorVenda.asFloat       := FieldByName('ValorVenda').asFloat;
      EditPercFreteVenda.asFloat   := FieldByName('PercFreteVenda').asFloat;
      EditValorVendaFrete.asFloat  := FieldByName('ValorVendaFrete').asFloat;
      EditValorCustoCompra.asFloat := FieldByName('ValorCustoCompra').asFloat;
    end;
  end;
end;


procedure TFormManutencaoListaPreco.FormShow(Sender: TObject);
begin
  inherited;
  PrepararTelaManutencao;
end;

procedure TFormManutencaoListaPreco.Gravar;
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
          SQL.Add(' INSERT INTO LISTAPRECO (');
          SQL.Add('     CODIGO , DESCRICAO, VALORCUSTO,PERCFRETECOMPRA,PERCICMS,PERCLUCRO,');
          SQL.Add('     PERCFRETEVENDA,VALORLUCRO,VALORVENDA,VALORVENDAFRETE, VALORCUSTOCOMPRA)');
          SQL.Add(' VALUES (');
          SQL.Add('     :CODIGO , :DESCRICAO, :VALORCUSTO, :PERCFRETECOMPRA, :PERCICMS, :PERCLUCRO,');
          SQL.Add('     :PERCFRETEVENDA, :VALORLUCRO, :VALORVENDA, :VALORVENDAFRETE,:VALORCUSTOCOMPRA)');
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE LISTAPRECO');
          SQL.Add(' SET DESCRICAO        = :DESCRICAO,');
          SQL.Add('     VALORCUSTO       = :VALORCUSTO,');
          SQL.Add('     PERCFRETECOMPRA  = :PERCFRETECOMPRA,');
          SQL.Add('     PERCICMS         = :PERCICMS,');
          SQL.Add('     PERCLUCRO        = :PERCLUCRO,');
          SQL.Add('     PERCFRETEVENDA   = :PERCFRETEVENDA,');
          SQL.Add('     VALORLUCRO       = :VALORLUCRO,');
          SQL.Add('     VALORVENDA       = :VALORVENDA,');
          SQL.Add('     VALORVENDAFRETE  = :VALORVENDAFRETE,');
          SQL.Add('     VALORCUSTOCOMPRA = :VALORCUSTOCOMPRA');
          SQL.Add(' WHERE CODIGO = :CODIGO');
        end;
        ParamByName('Codigo').asFloat           := EditCodigo.asFloat;
        ParamByName('Descricao').asString       := EditNome.Text;
        ParamByName('ValorCusto').asFloat       := EditValorCusto.asFloat;
        ParamByName('PercFreteCompra').asFloat  := EditPercFreteCompra.asFloat;
        ParamByName('PercICMS').asFloat         := EditPercICMS.asFloat;
        ParamByName('PercLucro').asFloat        := EditPercLucro.asFloat;
        ParamByName('ValorLucro').asFloat       := EditValorLucro.asFloat;
        ParamByName('ValorVenda').asFloat       := EditValorVenda.asFloat;
        ParamByName('PercFreteVenda').asFloat   := EditPercFreteVenda.asFloat;
        ParamByName('ValorVendaFrete').asFloat  := EditValorVendaFrete.asFloat;
        ParamByName('ValorCustoCompra').asFloat := EditValorCustoCompra.asFloat;
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


procedure TFormManutencaoListaPreco.BitBtnConfirmarClick(Sender: TObject);
begin
  inherited;
  if Trim(EditNome.Text) = '' then
  begin
    MessageDlg('Informe a Descrição!', mtInformation, [mbOk], 0);
    EditNome.SetFocus;
    Exit;
  end;

  Gravar;
end;

procedure TFormManutencaoListaPreco.EditValorCustoExit(Sender: TObject);
begin
  inherited;
  CalcularCustoCompra;  
  CalcularValorVenda;
end;

procedure TFormManutencaoListaPreco.EditPercFreteCompraExit(
  Sender: TObject);
begin
  inherited;
  CalcularCustoCompra;  
  CalcularValorVenda;
end;

procedure TFormManutencaoListaPreco.EditPercICMSExit(Sender: TObject);
begin
  inherited;
  CalcularCustoCompra;  
  CalcularValorVenda;
end;

procedure TFormManutencaoListaPreco.EditPercLucroExit(Sender: TObject);
begin
  inherited;
  EditValorLucro.asFloat := ValorAplicandoPercentual(EditValorCusto.asFloat, EditPercLucro.asFloat);
  CalcularValorVenda;                                                             
end;

procedure TFormManutencaoListaPreco.EditValorLucroExit(Sender: TObject);
begin
  inherited;
  EditPercLucro.asFloat := PercentualAplicandoValor(EditValorLucro.asFloat, EditValorCusto.asFloat);
  CalcularValorVenda;
end;

procedure TFormManutencaoListaPreco.EditPercFreteVendaExit(
  Sender: TObject);
begin
  inherited;
  EditValorVendaFrete.asFloat := EditValorVenda.asFloat +
                              ValorAplicandoPercentual(EditValorVenda.asFloat, EditPercFreteVenda.asFloat);
end;

procedure TFormManutencaoListaPreco.LimparTela;
begin
  EditCodigo.asInteger         := 0;
  EditNome.Text                := '';
  EditValorCusto.asFloat       := 0;
  EditPercFreteCompra.asFloat  := 0;
  EditPercICMS.asFloat         := 0;
  EditPercLucro.asFloat        := 0;
  EditValorLucro.asFloat       := 0;
  EditValorVenda.asFloat       := 0;
  EditPercFreteVenda.asFloat   := 0;
  EditValorVendaFrete.asFloat  := 0;
  RBLucroPercentual.Checked    := True;
  EditValorLucro.Enabled       := False;
  EditValorCustoCompra.asFloat := 0;
end;

procedure TFormManutencaoListaPreco.RBLucroPercentualClick(
  Sender: TObject);
begin
  inherited;
  EditValorLucro.asFloat := 0;
  EditValorLucro.Enabled := False;
  EditPercLucro.Enabled  := True;
  EditPercLucro.SetFocus;
end;

procedure TFormManutencaoListaPreco.RBLucroValorClick(Sender: TObject);
begin
  inherited;
  EditPercLucro.asFloat  := 0;
  EditPercLucro.Enabled  := False;
  EditValorLucro.Enabled := True;
  EditValorLucro.SetFocus;
end;

procedure TFormManutencaoListaPreco.CalcularValorVenda;
begin
  EditValorVenda.asFloat := EditValorCusto.asFloat +
                         ValorAplicandoPercentual(EditValorCusto.asFloat,
                                                  EditPercFreteCompra.asFloat) +
                         ValorAplicandoPercentual(EditValorCusto.asFloat,
                                                  EditPercICMS.asFloat) +
                        EditValorLucro.asFloat;

  EditValorVendaFrete.asFloat := EditValorVenda.asFloat +
                              ValorAplicandoPercentual(EditValorVenda.asFloat,EditPercFreteVenda.asFloat);

end;


procedure TFormManutencaoListaPreco.CalcularCustoCompra;
begin
  EditValorCustoCompra.asFloat := EditValorCusto.asFloat +
                         ValorAplicandoPercentual(EditValorCusto.asFloat,
                                                  EditPercFreteCompra.asFloat) +
                         ValorAplicandoPercentual(EditValorCusto.asFloat,
                                                  EditPercICMS.asFloat);
end;

function TFormManutencaoListaPreco.RetornaProximaSequencia : Integer;
Var TransDesc : TTransactionDesc;

  function GravaUltimaSequencia : Boolean;
  begin
    Result := False;
    Try
      TransDesc.TransactionID  := 1;
      TransDesc.IsolationLevel := xilREADCOMMITTED;

      with DataModulePrin.SQLQueryExecuta do
      begin
        Close;
        SQL.Clear;
        SQL.Add('Update UltimaSequencia');
        SQL.Add('  Set CodListaPreco = CodListaPreco + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from ListaPreco where Codigo = (Select CodListaPreco from UltimaSequencia)');
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
      SQL.Add('Select CodListaPreco from UltimaSequencia');
      Open;

      Result := FieldByname('CodListaPreco').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;



end.
