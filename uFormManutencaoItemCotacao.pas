unit uFormManutencaoItemCotacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, DB, DBCtrls, StdCtrls, Buttons, ExtCtrls,
  Grids, DBGrids, TAdvEditP, uFrameModelo, uFrameProdutos, FMTBcd, SqlExpr,
  Provider, DBClient, DBXpress, Math, SqlTimSt,                          
  uFramePedidoNota, ppBands, ppClass, myChkBox, ppPrnabl, ppCtrls, ppCache,                                             
  ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppReport, ppStrtch, ppMemo,
  ppModule, raCodMod, MaskUtils, ppVar, Types;

type
  TFormManutencaoItemCotacao = class(TFormManutencao)
    PnlDados: TPanel;
    LblEstoque: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    FrameProdutos: TFrameProdutos;
    EditQuantEstoque: TAdvEdit;
    EditQuantPedida: TAdvEdit;
    EditGrupo: TAdvEdit;
    EditClassif: TAdvEdit;
    GroupBox1: TGroupBox;
    DBGridCotacoes: TDBGrid;
    CDSVerifProduto: TClientDataSet;
    DSPVerifProduto: TDataSetProvider;
    SQLVerifProduto: TSQLDataSet;
    DS_VerifProduto: TDataSource;
    CDSCotacoes: TClientDataSet;
    Panel1: TPanel;
    Label2: TLabel;
    EditNome: TAdvEdit;
    PnlBotoesItem: TPanel;
    BitBtnExcluir: TSpeedButton;
    Label5: TLabel;
    EditUnidade: TAdvEdit;
    EditValorTotalVenda: TAdvEdit;
    EditValorCotado: TAdvEdit;
    Label6: TLabel;
    EditCodigo: TAdvEdit;
    BitBtnGravarItem: TSpeedButton;
    BitBtnCancelarItem: TSpeedButton;
    EditSeq: TAdvEdit;
    CDSManutencaoCot: TClientDataSet;
    DS_ManutencaoCot: TDataSource;
    CheckBoxMelhorPreco: TCheckBox;
    EditEmpresaMelhorPreco: TAdvEdit;
    procedure FrameProdutosEditCodigoExit(Sender: TObject);
    procedure EditGrupoExit(Sender: TObject);
    procedure EditClassifExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FrameProdutosSpeedButtonConsultaClick(Sender: TObject);
    procedure FrameProdutosEditCodigoChange(Sender: TObject);
    procedure BitBtnGravarItemClick(Sender: TObject);
    procedure BitBtnCancelarItemClick(Sender: TObject);
    procedure DBGridCotacoesDblClick(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure DBGridCotacoesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure EditValorCotadoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DS_ManutencaoDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    Excluindo : Boolean;
    Procedure TrazerEmpresasConcorrentes;
    Procedure MontaManutencao;
    procedure MostraDadosProduto;
    function  DadosProduto(Verificar : Boolean) : Boolean;
    Procedure GravarDadosConcorrentes(Tipo :Integer; PrimeiraEmpresa : Boolean);
    Procedure GravarCotacaoProduto(Tipo, Empresa : Integer; Valor : Double);
    Procedure LimparDadosCotacao;
    Procedure LimparTela;
    Procedure ApagarDadosConcorrentes;
    function  ValidaTela : Boolean;
    procedure GravarItens;
    procedure PrepararTelaManutencao;
    function  BuscarMelhorPreco : Double;
    procedure Marca_MelhorPreco;    
  public
    { Public declarations }
    IsOk : Boolean;    
  end;

var
  FormManutencaoItemCotacao: TFormManutencaoItemCotacao;

implementation

uses uDataModule, uFormCotacoes, uFuncoes;

{$R *.dfm}

Procedure TFormManutencaoItemCotacao.TrazerEmpresasConcorrentes;
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
    Params.ParambyName('CodProduto').asInteger   := FrameProdutos.EditCodigo.asInteger;
    Params.ParambyName('CodGrupo').asInteger     := EditGrupo.asInteger;
    Params.ParambyName('Classificacao').asString := EditClassif.Text;
    Open;
  end;
  MontaManutencao;
end;

Procedure TFormManutencaoItemCotacao.MontaManutencao;
Var i : Integer;
begin
  CDSManutencaoCot.Close;
  CDSManutencaoCot.FieldDefs.Clear;
  with CDSCotacoes do
  begin
    if not IsEmpty then
    begin
      First;
      while not EOF do
      begin
        CDSManutencaoCot.FieldDefs.Add(FieldByName('Codigo').asString + '_' + FieldByName('Nome').asString, ftFloat);
        if (FieldByName('Cotacao').IsNull) and (FieldByName('Codigo').asInteger = 1) then
          GravarCotacaoProduto(1, FieldByName('Codigo').asInteger,EditValorTotalVenda.asFloat);
        Next;
      end;
    end
    else
    begin
      CDSManutencaoCot.FieldDefs.Add('1_NOVA RIBEIRÃO',ftFloat);
      EditNome.Text := 'NOVA RIBEIRÃO';
      GravarDadosConcorrentes(1, True);
    end;
    Close;
    Open;
  end;

  with CDSManutencaoCot do
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

      end
      else
        Fields[i].Value := EditValorTotalVenda.asFloat;

      Post;

      if not CDSCotacoes.IsEmpty then
        FieldByName(Fields[i].FieldName).DisplayLabel := CDSCotacoes.FieldByName('Codigo').asString + ' - ' + CDSCotacoes.FieldByName('Nome').asString
      else
        FieldByName(Fields[i].FieldName).DisplayLabel := '1 - NOVA RIBEIRÃO';

     (FieldByName(Fields[i].FieldName) as TNumericField).DisplayFormat := '#,##0.00';
    end;
  end;
end;

function TFormManutencaoItemCotacao.DadosProduto(Verificar : Boolean) : Boolean;
begin
  Result := False;
  Screen.Cursor := crHourGlass;
  With CDSVerifProduto do
  begin
    SQL.Clear;
    SQL.Add(' Select Prod.CODGRUPO, Prod.CLASSIFICACAO, Prod.Unidade, ');
    SQL.Add('        Prod.DESCRICAO, Ep.QUANTIDADE, Ep.QUANTIDADEMIN,Lp.VALORVENDAFRETE');
    SQL.Add(' from Produtos Prod ');
    SQL.Add(' Left outer Join ListaPreco Lp on Lp.Codigo        = Prod.CodListaPreco');
    SQL.Add(' Inner Join EstoqueProdutos Ep on Ep.CodGrupo      = Prod.CodGrupo');
    SQL.Add('                              and Ep.CodProduto    = Prod.Codigo');
    SQL.Add('                              and Ep.Classificacao = Prod.Classificacao');
    SQL.Add(' where (Prod.Codigo   = ' + FrameProdutos.EditCodigo.Text + ')');
    if EditGrupo.asInteger <> 0 then
      SQL.Add(' and (Prod.CodGrupo = ' + EditGrupo.Text + ')');
    if EditClassif.Text <> '' then
      SQL.Add(' and (Prod.Classificacao = ' + QuotedStr(EditClassif.Text) + ')')
    else
      SQL.Add(' and (Prod.Classificacao = '''')');
    SQL.Add(' Order by Prod.CodGrupo');

    Close;
    CommandText := SQL.Text;
    Open;

    Screen.Cursor := crDefault;

    if IsEmpty then
    begin
      MessageDlg('O Produto Não foi Encontrado!', mtInformation, [mbOk], 0);
      Close;
      Exit;
    end
    else
    begin
      if Verificar = False then
      begin
        MostraDadosProduto;
        TrazerEmpresasConcorrentes;
      end;        
    end;
  end;
  Result := True;
end;

procedure TFormManutencaoItemCotacao.MostraDadosProduto;
begin
  with CDSVerifProduto do
  begin
    EditGrupo.asInteger          := FieldByName('CODGRUPO').asInteger;
    EditClassif.Text             := FieldByName('CLASSIFICACAO').asString;
    EditUnidade.Text             := FieldByName('UNIDADE').asString;
    EditValorTotalVenda.asFloat  := FieldByName('VALORVENDAFRETE').asFloat;
    EditQuantEstoque.asFloat     := (FieldByName('QUANTIDADE').asFloat - FieldByName('QUANTIDADEMIN').asFloat);
    FrameProdutos.EditNome.Text  := FieldByName('DESCRICAO').asString;

    if iTipo = 1 then
      EditQuantPedida.asFloat      := 1;

    if EditQuantEstoque.asFloat <= 0 then
      EditQuantEstoque.Color := clRed
    else
      EditQuantEstoque.Color := $00EC7600;
  end;    
end;



procedure TFormManutencaoItemCotacao.FrameProdutosEditCodigoExit(
  Sender: TObject);
begin
  FrameProdutos.fCodGrupo := EditGrupo.asInteger;
  inherited;
    
  if FrameProdutos.EditCodigo.asInteger <> 0 then
  begin
    if DadosProduto(false) = False then
      FrameProdutos.EditCodigo.SetFocus
    else
      FrameProdutos.EditCodigoExit(Sender);
  end;
end;

procedure TFormManutencaoItemCotacao.EditGrupoExit(Sender: TObject);
begin
  inherited;
  if (FrameProdutos.EditCodigo.asInteger <> 0) then
  begin
    if DadosProduto(false) = False then
      EditGrupo.SetFocus;
  end;
end;

procedure TFormManutencaoItemCotacao.EditClassifExit(Sender: TObject);
begin
  inherited;
  if (FrameProdutos.EditCodigo.asInteger <> 0) and
     (EditGrupo.asInteger <> 0) then
  begin
    if DadosProduto(false) = False then
      EditClassif.SetFocus;
  end;
end;

procedure TFormManutencaoItemCotacao.FormShow(Sender: TObject);
begin
  EditGrupo.SetFocus;
  inherited;
  IsOk := False;
  PrepararTelaManutencao;

  FrameProdutos.EditGrupo := Self.EditGrupo;
  FrameProdutos.EditClass := Self.EditClassif;
end;

procedure TFormManutencaoItemCotacao.FrameProdutosSpeedButtonConsultaClick(
  Sender: TObject);
Var CodProdutoAnt, CodGrupoAnt : Integer;
    CodClass : String;
begin
  inherited;
  CodProdutoAnt := FrameProdutos.EditCodigo.asInteger;
  CodGrupoAnt   := EditGrupo.asInteger;
  CodClass      := EditClassif.Text;

  LimparTela;

  FrameProdutos.SpeedButtonConsultaClick(Sender);
  if FrameProdutos.EditCodigo.asInteger = 0 then
  begin
    FrameProdutos.EditCodigo.asInteger := CodProdutoAnt;
    FrameProdutos.EditCodigo.OnExit(FrameProdutos.EditCodigo);
    EditGrupo.asInteger := CodGrupoAnt;
    EditClassif.Text    := CodClass;
  end;
  EditClassif.OnExit(EditClassif);
end;


Procedure TFormManutencaoItemCotacao.GravarDadosConcorrentes(Tipo :Integer; PrimeiraEmpresa : Boolean);
Var TransDesc : TTransactionDesc;
    CodConcorrente : Integer;
    Valor : Double;
begin
  CodConcorrente := 0;
  if PrimeiraEmpresa then
    Valor := EditValorTotalVenda.asFloat
  else
    Valor := EditValorCotado.asFloat;

  if Tipo = 1 then
  begin
    with DataModulePrin.SQLQueryPesquisa do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Select Max(Codigo) + 1 as Proximo from EmpresasConcorrentes');
      Open;

      if IsEmpty then
        CodConcorrente := 1
      else
      begin
        if FieldByName('Proximo').isNull then
          CodConcorrente := 1
        else
          CodConcorrente := FieldByName('Proximo').asInteger;
      end;
    end;
  end;
  Try
    TransDesc.TransactionID  := 1;
    TransDesc.IsolationLevel := xilREADCOMMITTED;
    DataModulePrin.SQLConnectionPrin.StartTransaction(TransDesc);
    with DataModulePrin.SQLQueryExecuta do
    begin
      Close;
      SQL.Clear;
      if Tipo = 1 then
      begin
        if CDSCotacoes.IsEmpty then
        begin
          SQL.Add('Insert Into EMPRESASCONCORRENTES(Codigo, Nome)');
          SQL.Add('Values(' + IntToStr(CodConcorrente) + ', ''NOVA RIBEIRÃO'')');
          ExecSQL;
        end
        else
        begin
          SQL.Clear;
          SQL.Add('Insert Into EMPRESASCONCORRENTES(Codigo, Nome)');
          SQL.Add('Values(' + IntToStr(CodConcorrente) + ', :Nome)');
          ParamByname('Nome').asString := EditNome.Text;
          ExecSQL;
        end;
      end
      else if Tipo = 2 then
      begin
        SQL.Clear;
        SQL.Add('Update EMPRESASCONCORRENTES');
        SQL.Add(' Set Nome     = :Nome');
        SQL.Add(' where Codigo = :Codigo');
        ParamByname('Nome').asString    := EditNome.Text;
        ParamByname('Codigo').asInteger := EditCodigo.asInteger;
        ExecSQL;
      end
      else if Tipo = 3 then
      begin
        SQL.Clear;
        SQL.Add('Delete from EMPRESASCONCORRENTES');
        SQL.Add(' where Codigo = :Codigo');
        ParamByname('Codigo').asInteger := EditCodigo.asInteger;
        ExecSQL;
      end;
      DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

      if Tipo = 1 then
        GravarCotacaoProduto(Tipo, CodConcorrente, Valor)
      else
        GravarCotacaoProduto(Tipo, EditCodigo.asInteger, Valor);

      LimparDadosCotacao;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar a Empresa da Cotação. O Registro Não Poderá ser Gravado! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
      Close;
    end;
  end;
end;

Procedure TFormManutencaoItemCotacao.GravarCotacaoProduto(Tipo, Empresa : Integer; Valor : Double);
Var TransDesc : TTransactionDesc;
begin
  Try
    TransDesc.TransactionID  := 1;
    TransDesc.IsolationLevel := xilREADCOMMITTED;
    DataModulePrin.SQLConnectionPrin.StartTransaction(TransDesc);
    with DataModulePrin.SQLQueryPesquisa do
    begin
      if Tipo = 1 then
      begin
        SQL.Clear;
        SQL.Add('Insert Into EMPRESASXCOTACAO(CODPRODUTO, CODGRUPO, CLASSIFICACAO, CODEMPCONC,VALORCOTADO)');
        SQL.Add('values(:CODPRODUTO, :CODGRUPO, :CLASSIFICACAO, :CODEMPCONC,:VALORCOTADO)');
        ParamByname('CODPRODUTO').asInteger   := FrameProdutos.EditCodigo.asInteger;
        ParamByname('CODGRUPO').asInteger     := EditGrupo.asInteger;
        ParamByname('CLASSIFICACAO').asString := EditClassif.Text;
        ParamByname('CODEMPCONC').asInteger   := Empresa;
        ParamByname('VALORCOTADO').asFloat    := Valor;
        ExecSQL;
      end
      else if Tipo = 2 then
      begin
        SQL.Clear;
        SQL.Add('UPDATE EMPRESASXCOTACAO  ');
        SQL.Add(' SET VALORCOTADO    = :VALORCOTADO');
        SQL.Add('WHERE CODPRODUTO    = :CODPRODUTO');
        SQL.Add('  AND CODGRUPO      = :CODGRUPO');
        SQL.Add('  AND CLASSIFICACAO = :CLASSIFICACAO');
        SQL.Add('  AND CODEMPCONC    = :CODEMPCONC');
        ParamByname('VALORCOTADO').asFloat    := Valor;
        ParamByname('CODPRODUTO').asInteger   := FrameProdutos.EditCodigo.asInteger;
        ParamByname('CODGRUPO').asInteger     := EditGrupo.asInteger;
        ParamByname('CLASSIFICACAO').asString := EditClassif.Text;
        ParamByname('CODEMPCONC').asInteger   := Empresa;
        ExecSQL;
      end
      else if Tipo = 3 then
      begin
        SQL.Clear;
        SQL.Add('DELETE FROM EMPRESASXCOTACAO');
        SQL.Add('WHERE CODPRODUTO    = :CODPRODUTO');
        SQL.Add('  AND CODGRUPO      = :CODGRUPO');
        SQL.Add('  AND CLASSIFICACAO = :CLASSIFICACAO');
        SQL.Add('  AND CODEMPCONC    = :CODEMPCONC');
        ParamByname('CODPRODUTO').asInteger   := FrameProdutos.EditCodigo.asInteger;
        ParamByname('CODGRUPO').asInteger     := EditGrupo.asInteger;
        ParamByname('CLASSIFICACAO').asString := EditClassif.Text;
        ParamByname('CODEMPCONC').asInteger   := Empresa;
        ExecSQL;
      end;
    end;
    DataModulePrin.SQLConnectionPrin.Commit(TransDesc);
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar a Cotação. O Registro Não Poderá ser Gravado! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
      Close;
    end;
  end;
end;

Procedure TFormManutencaoItemCotacao.LimparDadosCotacao;
begin
  EditCodigo.Limpa;
  EditNome.Limpa;
  EditValorCotado.Limpa;
end;

Procedure TFormManutencaoItemCotacao.LimparTela;
begin
  Excluindo := False;
  FrameProdutos.LimparFrame;
  EditGrupo.Limpa;
  EditClassif.Limpa;
  EditUnidade.Limpa;
  EditQuantEstoque.Limpa;
  EditQuantPedida.Limpa;
  CDSManutencaoCot.Close;
  CDSVerifProduto.Close;
  CDSCotacoes.Close;
  FrameProdutos.vCodGrupo      := 0;
  FrameProdutos.vClassificacao := '';
  FrameProdutos.vUnidade       := '';
  FrameProdutos.fCodGrupo      := 0;
  LimparDadosCotacao;
end;



procedure TFormManutencaoItemCotacao.FrameProdutosEditCodigoChange(
  Sender: TObject);
begin
  inherited;
  if FrameProdutos.EditCodigo.asInteger = 0 then
    LimparTela;
end;

procedure TFormManutencaoItemCotacao.BitBtnGravarItemClick(Sender: TObject);
begin
  inherited;
  if Trim(EditNome.Text) = '' then
  begin
    MessageDlg('Digite o Nome da Empresa!', mtInformation, [mbOk], 0);
    EditNome.SetFocus;
    Exit;
  end;


  if EditCodigo.asInteger = 0 then
    GravarDadosConcorrentes(1, False)
  else
  begin
    if CDSCotacoes.Locate('Codigo',EditCodigo.asInteger,[]) then
    begin
      if CDSCotacoes.FieldByName('Cotacao').IsNull then
        GravarCotacaoProduto(1,EditCodigo.asInteger, EditValorCotado.asFloat)
      else
        GravarDadosConcorrentes(2, False);
    end;
  end;
  TrazerEmpresasConcorrentes;
  LimparDadosCotacao;
  EditNome.SetFocus;
end;

procedure TFormManutencaoItemCotacao.BitBtnCancelarItemClick(
  Sender: TObject);
begin
  inherited;
  LimparDadosCotacao;
  EditNome.SetFocus;
end;

procedure TFormManutencaoItemCotacao.DBGridCotacoesDblClick(
  Sender: TObject);
begin
  inherited;
  if DBGridCotacoes.SelectedField.FieldName = '' then
    Exit;
    
  EditCodigo.asInteger    := StrToInt(Copy(DBGridCotacoes.SelectedField.FieldName,1,Pos('_',DBGridCotacoes.SelectedField.FieldName) - 1));
  EditNome.text           := Copy(DBGridCotacoes.SelectedField.FieldName,Pos('_',DBGridCotacoes.SelectedField.FieldName) + 1,
                                  Length(DBGridCotacoes.SelectedField.FieldName));
  EditValorCotado.asFloat := DBGridCotacoes.SelectedField.AsFloat;
  EditValorCotado.SetFocus;
end;

procedure TFormManutencaoItemCotacao.BitBtnExcluirClick(Sender: TObject);
begin
  inherited;
  if EditCodigo.asInteger = 0 then
  begin
    MessageDlg('Selecione uma Cotação para Excluir!', mtInformation, [mbOk], 0);
    Exit;
  end;

  Excluindo := True;
  If Application.MessageBox('Deseja Realmente Excluir a Empresa e TODAS as suas Cotações?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
  begin
    EditNome.SetFocus;
    ApagarDadosConcorrentes;
    LimparDadosCotacao;
    Excluindo := False;    
    EditNome.SetFocus;
  end
  else
    BitBtnCancelarItem.OnClick(BitBtnCancelarItem);
end;

Procedure TFormManutencaoItemCotacao.ApagarDadosConcorrentes;
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
      SQL.Add('Delete from EMPRESASCONCORRENTES');
      SQL.Add('where Codigo = :Codigo');
      ParamByname('Codigo').asInteger := EditCodigo.asInteger;
      ExecSQL;
      DataModulePrin.SQLConnectionPrin.Commit(TransDesc);
      TrazerEmpresasConcorrentes;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Excluir a Empresa da Cotação. O Registro Não Poderá ser Gravado! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
      Close;
    end;
  end;
end;


function TFormManutencaoItemCotacao.ValidaTela : Boolean;
Var BM : TBookMark;
begin
  Result := False;
  if FrameProdutos.EditCodigo.asInteger = 0 then
  begin
    MessageDlg('Informe o Produto!', mtInformation, [mbOk], 0);
    FrameProdutos.EditCodigo.SetFocus;
    Exit;
  end;

  if EditQuantPedida.asFloat = 0 then
  begin
    MessageDlg('Informe a Quantidade Cotada!', mtInformation, [mbOk], 0);
    EditQuantPedida.SetFocus;
    Exit;
  end;

  {COMENTAR QUANDO FOREM FEITAS AS ALTERAÇÕES DE SEGURANÇA NA TELA}
  with CDSCadastro do
  begin
    BM := GetBookmark;
    if Locate('CodGrupo;CodProduto;Classificacao',
       VarArrayof([EditGrupo.asInteger, FrameProdutos.EditCodigo.asInteger,EditClassif.Text]),[]) then
    begin
      if FieldByName('Sequencia').asInteger <> EditSeq.asInteger then
      begin
        Try
          GotoBookmark(BM);
          FreeBookmark(BM);
        Except
          FreeBookmark(BM);
        end;
        MessageDlg('O Produto já Existe na Cotação!', mtWarning, [mbOk], 0);
        if FrameProdutos.EditCodigo.CanFocus then
          FrameProdutos.EditCodigo.SetFocus;
        Exit;
      end;
    end;
  end;

  if DadosProduto(True) = False then
    Exit;
  Result := True;
end;



procedure TFormManutencaoItemCotacao.BitBtnConfirmarClick(Sender: TObject);
begin
  inherited;
  DS_Manutencao.OnDataChange := nil;

  if ValidaTela = False then
    Exit;

  GravarItens;


  DS_Manutencao.OnDataChange := DS_ManutencaoDataChange;  

  if CheckBoxFecharTela.Checked = True then
    Close
  else
  begin
    CDSCadastro.Next;
    PrepararTelaManutencao;
    if iTipo = 1 then
      FrameProdutos.EditCodigo.SetFocus
    else
      EditQuantPedida.SetFocus;
  end;
end;

procedure TFormManutencaoItemCotacao.GravarItens;
begin
  with CDSCadastro do
  begin
    if iTipo = 1 then
    begin
      Append;
      FormCotacoes.NumSequencia                 := FormCotacoes.NumSequencia + 1;
      FieldByName('CodPedidoNF').asInteger      := FormCotacoes.FramePedidoNota.EditCodigo.asInteger;
      FieldByName('Tipo').asInteger             := 3;
      FieldByName('Sequencia').asInteger        := FormCotacoes.NumSequencia;
    end
    else
      Edit;
    FieldByName('CodProduto').asInteger         := FrameProdutos.EditCodigo.asInteger;
    FieldByName('DescricaoProduto').asString    := FrameProdutos.EditNome.Text;
    FieldByName('CodGrupo').asInteger           := EditGrupo.asInteger;
    FieldByName('Classificacao').asString       := EditClassif.Text;
    FieldByName('QuantPedida').asFloat          := EditQuantPedida.asFloat;
    FieldByName('ValorUnitario').asFloat        := BuscarMelhorPreco;
    FieldByName('ValorTotal').asFloat           := BuscarMelhorPreco * EditQuantPedida.asFloat;
    FieldByName('Quantidade').asFloat           := EditQuantEstoque.asFloat;

    Marca_MelhorPreco;
    FieldByName('EmpMelhorPreco').asInteger     := EditEmpresaMelhorPreco.asInteger;

    if iTipo = 1 then
      FieldByName('Status').asString := 'I'
    else if iTipo = 2 then
    begin
      if FieldByName('Status').asString <> 'I' then
        FieldByName('Status').asString := 'A';
    end;
    Post;


    IsOk := True;
  end;
end;


procedure TFormManutencaoItemCotacao.DBGridCotacoesDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if (Column.FieldName = '1_NOVA RIBEIRÃO') then
  begin
    DBGridCotacoes.Canvas.Brush.Color  := $00EC7600;
    DBGridCotacoes.Canvas.Font.Color   := clWhite;
    DBGridCotacoes.Canvas.FillRect(Rect);
    DBGridCotacoes.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFormManutencaoItemCotacao.EditValorCotadoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_Return then
  begin
    if (EditCodigo.asInteger = 0) or (Excluindo = False) then
      BitBtnGravarItem.OnClick(BitBtnGravarItem);
  end;
end;

procedure TFormManutencaoItemCotacao.PrepararTelaManutencao;
begin
  with CDSCadastro do
  begin
    if iTipo = 1 then
      LimparTela
    else if iTipo = 2 then
    begin
      FrameProdutos.EditCodigo.asInteger := FieldByName('CodProduto').asInteger;
      EditGrupo.asInteger           := FieldByName('CodGrupo').asInteger;
      EditClassif.Text              := FieldByName('Classificacao').asString;
      EditQuantPedida.asFloat       := FieldByName('QuantPedida').asFloat;
      EditSeq.asInteger             := FieldByName('Sequencia').asInteger;
      EditValorTotalVenda.asFloat   := FieldByName('ValorUnitario').asFloat;
      EditQuantEstoque.asFloat      := FieldByName('Quantidade').asFloat;

      FrameProdutos.EditCodigo.Onexit(FrameProdutos.EditCodigo);
      HabilitaFrame(FrameProdutos, False);
      EditGrupo.Enabled   := False;
      EditClassif.Enabled := False;
      EditQuantPedida.SelectAll;
      EditQuantPedida.SetFocus;
    end;
  end;
end;

procedure TFormManutencaoItemCotacao.DS_ManutencaoDataChange(
  Sender: TObject; Field: TField);
begin
  inherited;
  if (CheckBoxFecharTela.Checked = False) and Self.Showing  then
    PrepararTelaManutencao;

end;

function TFormManutencaoItemCotacao.BuscarMelhorPreco : Double;
Var MelhorPreco : Double;
begin
  inherited;
  if EditValorTotalVenda.asFloat <> 0 then
    MelhorPreco := EditValorTotalVenda.asFloat
  else
  begin
    CDSCotacoes.Locate('CODIGO',1,[]);
    MelhorPreco := CDSCotacoes.FieldByName('ValorCotado').AsFloat;
  end;
  EditEmpresaMelhorPreco.asInteger := 1;

  if CheckBoxMelhorPreco.Checked then
  begin
    with CDSCotacoes do
    begin
      First;
      while not EOF do
      begin
        if FieldByName('ValorCotado').asInteger > 0 then
        begin
          if FieldByName('ValorCotado').asFloat < MelhorPreco then
          begin
            MelhorPreco := FieldByName('ValorCotado').asFloat;
            EditEmpresaMelhorPreco.asInteger := FieldByName('Codigo').asInteger;
          end;
        end;
        Next;
      end;
    end;
  end;
  Result := MelhorPreco;
end;

procedure TFormManutencaoItemCotacao.Marca_MelhorPreco;
Var MelhorPreco : Double;
begin
  inherited;
  if EditValorTotalVenda.asFloat <> 0 then
    MelhorPreco := EditValorTotalVenda.asFloat
  else
  begin
    CDSCotacoes.Locate('CODIGO',1,[]);
    MelhorPreco := CDSCotacoes.FieldByName('ValorCotado').AsFloat;
  end;
  EditEmpresaMelhorPreco.asInteger := 1;

  with CDSCotacoes do
  begin
    First;
    while not EOF do
    begin
      if FieldByName('ValorCotado').asInteger > 0 then
      begin
        if FieldByName('ValorCotado').asFloat < MelhorPreco then
        begin
          MelhorPreco := FieldByName('ValorCotado').asFloat;
          EditEmpresaMelhorPreco.asInteger := FieldByName('Codigo').asInteger;
        end;
      end;
      Next;
    end;
  end;
end;




end.
