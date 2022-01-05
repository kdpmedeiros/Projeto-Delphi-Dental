unit uFormBanco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormModelo, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids,
  DBGrids, StdCtrls, TAdvEditP, Buttons, ExtCtrls, DBXpress;

type
  TFormBancos = class(TFormModelo)
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
  FormBancos: TFormBancos;

implementation

uses uFormManutencaoBancos, uDataModule, uRelatorioModelo;

{$R *.dfm}

procedure TFormBancos.FormShow(Sender: TObject);
begin
  inherited;
  MostrarDados('Bancos','','Descricao');
end;

procedure TFormBancos.BitBtnIncluirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormManutencaoBancos, FormManutencaoBancos);
    FormManutencaoBancos.InicializaTela(1, CDSPrincipal);
    FormManutencaoBancos.ShowModal;
  Finally
    MostrarDados('Bancos','','Descricao');
    CDSPrincipal.Locate('Codigo',FormManutencaoBancos.EditCodigo.asInteger,[]);
    FormManutencaoBancos.Free;
  end;
end;

procedure TFormBancos.BitBtnAlterarClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) Then
    Exit;

  Try
    Application.CreateForm(TFormManutencaoBancos, FormManutencaoBancos);
    FormManutencaoBancos.InicializaTela(2, CDSPrincipal);
    FormManutencaoBancos.ShowModal;
  Finally
    MostrarDados('Bancos','','Descricao');
    CDSPrincipal.Locate('Codigo',FormManutencaoBancos.EditCodigo.asInteger,[]);
    FormManutencaoBancos.Free;
  end;
end;

procedure TFormBancos.BitBtnExcluirClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    Exit;

  If Application.MessageBox('Deseja Realmente Excluir o Banco Selecionado?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
    Apagar;
end;

procedure TFormBancos.Apagar;
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
        SQL.Add(' DELETE FROM BANCOS');
        SQL.Add(' WHERE CODIGO = :CODIGO');
        ParamByName('Codigo').asFloat := CDSPrincipal.FieldByName('Codigo').asFloat;
        ExecSQL;

        CDSPrincipal.Prior;
        BM := CDSPrincipal.GetBookMark;
        SQLConnectionPrin.Commit(TransDesc);
        MostrarDados('BANCOS','','Descricao');
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


procedure TFormBancos.CDSPrincipalAfterOpen(DataSet: TDataSet);
begin
  with CDSPrincipal do
  begin
    FieldByName('CODIGO').DisplayLabel         := 'Código';
    FieldByName('DESCRICAO').DisplayLabel      := 'Descrição';
    FieldByName('NUMEROBANCO').DisplayLabel    := 'Nº Banco';

    FieldByName('CODIGO').DisplayWidth         := 8;
    FieldByName('DESCRICAO').DisplayWidth      := 50;
  end;

  inherited;

end;

procedure TFormBancos.BitBtnImprimirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormRelatorioModelo, FormRelatorioModelo);
    with FormRelatorioModelo do
    begin
      DS_Principal.DataSet := Self.CDSPrincipal;
      MontaRelatorio;
      ppLabelDescricaoRel.Caption := 'Relatório de Bancos';
      ppRelatorio.Print;
    end;
  Finally
    FormRelatorioModelo.Free;
  end;

end;

end.
