unit uFormEmpresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormModelo, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids,
  DBGrids, StdCtrls, Buttons, ExtCtrls,DBXpress, SqlTimSt, math, TAdvEditP;

type
  TFormEmpresa = class(TFormModelo)
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
  FormEmpresa: TFormEmpresa;

implementation

uses uFormManutencaoEmpresa, uDataModule, uRelatorioModelo;

{$R *.dfm}

procedure TFormEmpresa.FormShow(Sender: TObject);
begin
  inherited;
  MostrarDados('Empresa','','Nome');
end;

procedure TFormEmpresa.BitBtnIncluirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormManutencaoEmpresa, FormManutencaoEmpresa);
    FormManutencaoEmpresa.InicializaTela(1, CDSPrincipal);
    FormManutencaoEmpresa.ShowModal;
  Finally
    MostrarDados('Empresa','','Nome');
    CDSPrincipal.Locate('Codigo',FormManutencaoEmpresa.EditCodigo.asInteger,[]);
    FormManutencaoEmpresa.Free;
  end;
end;

procedure TFormEmpresa.BitBtnAlterarClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) Then
    Exit;

  Try
    Application.CreateForm(TFormManutencaoEmpresa, FormManutencaoEmpresa);
    FormManutencaoEmpresa.InicializaTela(2, CDSPrincipal);
    FormManutencaoEmpresa.ShowModal;
  Finally
    MostrarDados('Empresa','','Nome');
    CDSPrincipal.Locate('Codigo',FormManutencaoEmpresa.EditCodigo.asInteger,[]);    
    FormManutencaoEmpresa.Free;
  end;
end;

procedure TFormEmpresa.BitBtnExcluirClick(Sender: TObject);
begin
  inherited;
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    Exit;

  If Application.MessageBox('Deseja Realmente Excluir a Empresa Selecionada?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
    Apagar;
end;

procedure TFormEmpresa.Apagar;
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
        SQL.Add(' DELETE FROM EMPRESA');
        SQL.Add(' WHERE CODIGO = :CODIGO');
        ParamByName('Codigo').asFloat := CDSPrincipal.FieldByName('Codigo').asFloat;
        ExecSQL;

        CDSPrincipal.Prior;
        BM := CDSPrincipal.GetBookMark;
        SQLConnectionPrin.Commit(TransDesc);
        MostrarDados('Empresa','','Nome');
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

procedure TFormEmpresa.CDSPrincipalAfterOpen(DataSet: TDataSet);
begin
  with CDSPrincipal do
  begin
    FieldByName('CODIGO').DisplayLabel         := 'Código';
    FieldByName('NOME').DisplayLabel           := 'Nome';
    FieldByName('CPFCNPJ').OnGetText           := GetTextCPFCNPJ;
    FieldByName('CPFCNPJ').DisplayLabel        := 'CPF/CNPJ';
    FieldByName('ENDERECO').DisplayLabel       := 'Endereço';
    FieldByName('BAIRRO').DisplayLabel         := 'Bairro';
    FieldByName('CEP').OnGetText               := GetTextCEP;        
    FieldByName('CEP').DisplayLabel            := 'CEP';
    FieldByName('CIDADE').DisplayLabel         := 'Cidade';
    FieldByName('TELCOMERCIAL1').DisplayLabel  := 'Tel. Comercial (1)';
    FieldByName('TELCOMERCIAL2').DisplayLabel  := 'Tel. Comercial (2)';
    FieldByName('TELFAX').DisplayLabel         := 'Tel. Fax';
    FieldByName('TELRESIDENCIAL').DisplayLabel := 'Tel. Residencial';
    FieldByName('TELCELULAR').DisplayLabel     := 'Tel. Celular';
    FieldByName('ESTADO').DisplayLabel         := 'Estado';
    FieldByName('IE').DisplayLabel             := 'Inscrição Estadual';
    FieldByName('SITE').DisplayLabel           := 'Site';
    FieldByName('EMAIL').DisplayLabel          := 'E-Mail';
    FieldByName('MATRIZ').DisplayLabel         := 'Matriz';

    FieldByName('CODIGO').DisplayWidth         := 8;
    FieldByName('NOME').DisplayWidth           := 50;
    FieldByName('CPFCNPJ').DisplayWidth        := 20;
    FieldByName('ENDERECO').DisplayWidth       := 50;
    FieldByName('BAIRRO').DisplayWidth         := 25;
    FieldByName('CEP').DisplayWidth            := 10;
    FieldByName('CIDADE').DisplayWidth         := 30;
    FieldByName('TELCOMERCIAL1').DisplayWidth  := 15;
    FieldByName('TELCOMERCIAL2').DisplayWidth  := 15;
    FieldByName('TELFAX').DisplayWidth         := 15;
    FieldByName('TELRESIDENCIAL').DisplayWidth := 15;
    FieldByName('TELCELULAR').DisplayWidth     := 15;
    FieldByName('ESTADO').DisplayWidth         := 6;
    FieldByName('IE').DisplayWidth             := 20;
    FieldByName('SITE').DisplayWidth           := 25;
    FieldByName('EMAIL').DisplayWidth          := 25;
    FieldByName('MATRIZ').DisplayWidth         := 7;
  end;                                        
  inherited;

end;

procedure TFormEmpresa.BitBtnImprimirClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormRelatorioModelo, FormRelatorioModelo);
    with FormRelatorioModelo do
    begin
      DS_Principal.DataSet := Self.CDSPrincipal;
      MontaRelatorio;
      ppLabelDescricaoRel.Caption := 'Relatório de Empresas';
      ppRelatorio.Print;
    end;
  Finally
    CDSPrincipal.First;  
    FormRelatorioModelo.Free;
  end;
end;

end.
