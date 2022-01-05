unit uFormCondicoesPagto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormModelo, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids,
  DBGrids, StdCtrls, TAdvEditP, Buttons, ExtCtrls,DBXpress,
  SqlTimSt, math;

type
  TFormCondicoesPagto = class(TFormModelo)
    procedure FormShow(Sender: TObject);
    procedure BitBtnIncluirClick(Sender: TObject);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure CDSPrincipalAfterOpen(DataSet: TDataSet);
    procedure BitBtnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure Apagar;
  public
    { Public declarations }
  end;

var
  FormCondicoesPagto: TFormCondicoesPagto;

implementation

uses uFormManutencaoCondicoesPagto, uDataModule, uRelatorioModelo;

{$R *.dfm}

procedure TFormCondicoesPagto.FormShow(Sender: TObject);
begin
  
  inherited;
  MostrarDados('CondicoesPagto','','Descricao');
end;

procedure TFormCondicoesPagto.BitBtnIncluirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormManutencaoCondicoesPagto, FormManutencaoCondicoesPagto);
    FormManutencaoCondicoesPagto.InicializaTela(1, CDSPrincipal);
    FormManutencaoCondicoesPagto.ShowModal;
  Finally
    MostrarDados('CondicoesPagto','','Descricao');
    CDSPrincipal.Locate('Codigo',FormManutencaoCondicoesPagto.EditCodigo.asInteger,[]);
    FormManutencaoCondicoesPagto.Free;
  end;
end;

procedure TFormCondicoesPagto.BitBtnAlterarClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) Then
    Exit;
      
  Try
    Application.CreateForm(TFormManutencaoCondicoesPagto, FormManutencaoCondicoesPagto);
    FormManutencaoCondicoesPagto.InicializaTela(2, CDSPrincipal);
    FormManutencaoCondicoesPagto.ShowModal;
  Finally
    MostrarDados('CondicoesPagto','','Descricao');
    CDSPrincipal.Locate('Codigo',FormManutencaoCondicoesPagto.EditCodigo.asInteger,[]);    
    FormManutencaoCondicoesPagto.Free;
  end;
end;

procedure TFormCondicoesPagto.BitBtnExcluirClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    Exit;

  If Application.MessageBox('Deseja Realmente Excluir a Condição de Pagamento Selecionada?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
    Apagar;
end;

procedure TFormCondicoesPagto.Apagar;
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
        SQL.Add(' DELETE FROM CONDICOESPAGTO');
        SQL.Add(' WHERE CODIGO = :CODIGO');
        ParamByName('Codigo').asFloat := CDSPrincipal.FieldByName('Codigo').asFloat;
        ExecSQL;

        CDSPrincipal.Prior;
        BM := CDSPrincipal.GetBookMark;
        SQLConnectionPrin.Commit(TransDesc);
        MostrarDados('CondicoesPagto','','Descricao');
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


procedure TFormCondicoesPagto.CDSPrincipalAfterOpen(DataSet: TDataSet);
begin
  with CDSPrincipal do
  begin
    FieldByName('CODIGO').DisplayLabel         := 'Código';
    FieldByName('DESCRICAO').DisplayLabel      := 'Descrição';
    FieldByName('PARCELAS').DisplayLabel       := 'Nº Parcelas';
    FieldByName('DIAVENC').DisplayLabel        := 'Dia Venc.';

    FieldByName('CODIGO').DisplayWidth         := 8;
    FieldByName('DESCRICAO').DisplayWidth      := 50;
    
    FieldByName('FLAGAVISTA').Visible          := False;
    FieldByName('DIAVENC').Visible             := False;
  end;
  inherited;

end;

procedure TFormCondicoesPagto.BitBtnImprimirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormRelatorioModelo, FormRelatorioModelo);
    with FormRelatorioModelo do
    begin
      DS_Principal.DataSet := Self.CDSPrincipal;
      MontaRelatorio;
      ppLabelDescricaoRel.Caption := 'Relatório de Condições de Pagamento';
      ppRelatorio.Print;
    end;
  Finally
    FormRelatorioModelo.Free;
  end;
end;

end.
