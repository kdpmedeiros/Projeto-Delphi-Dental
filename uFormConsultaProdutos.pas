unit uFormConsultaProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls, Grids, DBGrids, TAdvEditP, FMTBcd,
  DB, SqlExpr, Provider, DBClient, AdoDb, ImgList, Math, ppBands, ppCtrls,
  ppVar, ppPrnabl, ppClass, ppCache, ppProd, ppReport, ppDB, ppComm,                                                  
  ppRelatv, ppDBPipe, ppModule, raCodMod;    
                                                                                                                                              
type                                                                                                                                          
  TCampos = record
    Index   : Integer;
    Campo   : String;
    Tipo    : TDataType;
    Visivel : Boolean;
  end;

  TFormConsultaProdutos = class(TForm)
    PnlConsulta: TPanel;
    PnlGrid: TPanel;
    PnlDados: TPanel;
    PnlBotoes: TPanel;
    BitBtnConsulta: TSpeedButton;
    SpeedButtonAplicarFiltros: TSpeedButton;
    CDSPrincipal: TClientDataSet;
    DSPPrincipal: TDataSetProvider;
    SQLPrincipal: TSQLDataSet;
    DS_Principal: TDataSource;
    BitBtnImprimir: TSpeedButton;
    EditConsulta: TAdvEdit;
    Panel3: TPanel;
    BitBtnFechar: TSpeedButton;
    GroupBoxProdClass: TGroupBox;
    GroupBoxProdPrin: TGroupBox;
    DBGridConsulta: TDBGrid;
    DBGridClassificacoes: TDBGrid;
    CDSClassificacao: TClientDataSet;
    DS_Classificacao: TDataSource;
    ComboBoxTipoPesquisa: TComboBox;
    Label21: TLabel;
    RadioButtonIniciaCom: TRadioButton;
    RadioButtonContem: TRadioButton;
    Label1: TLabel;
    Imagens: TImageList;
    BitBtnAlterarPrin: TSpeedButton;
    SplitterClass: TSplitter;
    ppDBProdutos: TppDBPipeline;
    ppField1: TppField;
    ppField2: TppField;
    ppField3: TppField;
    ppField4: TppField;
    ppDBPipeline1ppField1: TppField;
    ppDBPipeline1ppField2: TppField;
    ppDBPipeline1ppField3: TppField;
    ppDBPipeline1ppField4: TppField;
    ppRelProdutos: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel11: TppLabel;
    ppSystemVariable3: TppSystemVariable;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel23: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText4: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppLabel24: TppLabel;
    raCodeModule1: TraCodeModule;
    ppVarTotalPag: TppVariable;
    ppLabel58: TppLabel;
    ppDBTotalGeral: TppDBCalc;
    ppLabelTotalGeral: TppLabel;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnFecharClick(Sender: TObject);
    procedure BitBtnConsultaClick(Sender: TObject);
    procedure EditConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure CDSPrincipalAfterOpen(DataSet: TDataSet);
    procedure SpeedButtonAplicarFiltrosClick(Sender: TObject);
    procedure DBGridConsultaTitleClick(Column: TColumn);
    procedure BitBtnImprimirClick(Sender: TObject);
    procedure DBGridConsultaDblClick(Sender: TObject);
    procedure EditConsultaChange(Sender: TObject);
    procedure CDSPrincipalAfterScroll(DataSet: TDataSet);
    procedure CDSClassificacaoAfterOpen(DataSet: TDataSet);
    procedure BitBtnAlterarPrinClick(Sender: TObject);
    procedure DBGridClassificacoesDblClick(Sender: TObject);
    procedure DBGridClassificacoesTitleClick(Column: TColumn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridConsultaCellClick(Column: TColumn);
    procedure DBGridConsultaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure ppFooterBand1BeforePrint(Sender: TObject);
    procedure ppDBText13Print(Sender: TObject);
  private
    { Private declarations }
    SQL : TStringList;
    OrdemSelecionada : Integer;
    CampoAlimentarCodigo, CampoAlimentarGrupo, CampoAlimentarClass : TAdvEdit;
    Campos : array of TCampos;
    FiltroGrupo : Integer;
    procedure MontaConsulta;
    function  Pesquisar : Boolean;
    procedure MontaConsultaClassificacao;
    procedure FiltrarClassificacoes;
    procedure AlimentarCombo;
    procedure OcultarClassificacao;
  public
    { Public declarations }
    Filtros, FiltrosClassificacao : TStringList;
    CodGrupoLoc, CodProdutoLoc, Expandido  : Integer;
    procedure MontarConsultaExterna(var CampoCodigo, CampoGrupo, CampoClass : TAdvEdit; Pai : TForm;
                                    FiltroGrupo : Integer);
  end;

var
  FormConsultaProdutos: TFormConsultaProdutos;

implementation

uses uFormFiltrosProdutos, uFormManutencaoProdutos, uRelatorioModelo,
  uDataModule, uFuncoes;

{$R *.dfm}

procedure TFormConsultaProdutos.FormShow(Sender: TObject);
begin
  Self.Left   := 2;
  Self.Top    := 48;
  Self.Height := 499;
  Self.Width  := 797;
  MontaConsulta;
  AlimentarCombo;

  VerifPermissoes;
  if DataModulePrin.SQLQueryPesquisa.Locate('NomeForm','FormProdutos',[]) then
    BitBtnAlterarPrin.Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('Alterar').asInteger = 1) and (DataModulePrin.SQLQueryPesquisa.FieldByName('Visualizar').asInteger = 1);
end;

procedure TFormConsultaProdutos.FormDestroy(Sender: TObject);
begin
  SQL.Free;
  Filtros.Free;
  FiltrosClassificacao.Free;
end;

procedure TFormConsultaProdutos.FormCreate(Sender: TObject);
begin
  SQL     := TStringList.Create;
  Filtros := TStringList.Create;
  FiltrosClassificacao := TStringList.Create;
  OrdemSelecionada     := -1;
  CodGrupoLoc          := 0;
  CodProdutoLoc        := 0;
  Expandido            := 0;
end;

procedure TFormConsultaProdutos.BitBtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormConsultaProdutos.MontaConsulta;
begin
  Screen.Cursor := crHourGlass;
  With CDSPrincipal do
  begin
    SQL.Clear;
    SQL.Add(' Select Prod.CODGRUPO, ');
    SQL.Add('        Prod.CODIGO, Prod.DESCRICAO, Prod.Localizacao,');
    SQL.Add('        Prod.UNIDADE, Ep.QUANTIDADE, Lp.VALORVENDAFRETE, ');
    SQL.Add('        Prod.CodListaPreco, Prod.Classificacao, Prod.CodFornecedor, Lp.ValorCusto, Ep.Quantidade as Estoque,');
    SQL.Add('            (Lp.ValorCusto * Ep.Quantidade) as ValorTotal, GR.DESCRICAO as GRUPO,');
    SQL.Add('        (Select Count(*) from Produtos ProdI where ProdI.Codigo   = Prod.Codigo');
    SQL.Add('                                             and ProdI.CodGrupo = Prod.CodGrupo');
    SQL.Add('                                             and ProdI.Classificacao <> '''') as TemClass,');
    SQL.Add('        Cast(0 as SmallInt) as ExibindoClass, cast('''' as char(1)) as Figura ');
    SQL.Add(' from Produtos Prod ');
    SQL.Add(' Left Join ListaPreco Lp on Lp.Codigo        = Prod.CodListaPreco');
    SQL.Add(' Left Join EstoqueProdutos Ep on Ep.CodGrupo = Prod.CodGrupo');
    SQL.Add('                              and Ep.CodProduto  = Prod.Codigo');
    SQL.Add('                              and Ep.Classificacao = Prod.Classificacao');
    SQL.Add(' Left Join Grupos          Gr on Gr.Codigo = Prod.CodGrupo');
    SQL.Add(' Left Join Fornecedores Fr on Fr.Codigo    = Prod.CodFornecedor');
    SQL.Add(' where Prod.Classificacao = ''''');
    if FiltroGrupo <> 0 then
      SQL.Add(' and Prod.CODGRUPO = ' + IntToStr(FiltroGrupo));

    SQL.Add(Filtros.Text);
    SQL.Add(' Order by Prod.Descricao');

    Close;
    CommandText := SQL.Text;
    TratarClientDatasetParaPost(CDSPrincipal);
    MontaConsultaClassificacao;

    if (CodGrupoLoc <> 0) and (CodProdutoLoc <> 0) then
    begin
      if Locate('CodGrupo;Codigo',Vararrayof([CodGrupoLoc,CodProdutoLoc]),[]) then
      begin
        Edit;
        FieldByname('ExibindoClass').AsInteger := Expandido;
        Post;

        PnlDados.Visible      := (FieldByname('ExibindoClass').AsInteger = 1);
        SplitterClass.Visible := (FieldByname('ExibindoClass').AsInteger = 1);        
      end;  
    end
    else
    begin
      PnlDados.Visible      := False;
      SplitterClass.Visible := False;
    end;

    Screen.Cursor := crDefault;


    if IsEmpty then
    begin
      MessageDlg('Nenhum Produto foi Encontrado!', mtInformation, [mbOk], 0);
      Close;
    end;
  end;
end;

procedure TFormConsultaProdutos.BitBtnConsultaClick(Sender: TObject);
begin
  if Pesquisar = False then
    MessageDlg('Registro não Encontrado!', mtInformation, [mbOk], 0);
end;

procedure TFormConsultaProdutos.EditConsultaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    DBGridConsulta.OnDblClick(DBGridConsulta);
end;

procedure TFormConsultaProdutos.CDSPrincipalAfterOpen(DataSet: TDataSet);
begin
  with CDSPrincipal do
  begin
    FieldByName('CODIGO').DisplayLabel          := 'Código';
    FieldByName('CodGrupo').DisplayLabel        := 'Grupo';
    FieldByName('DESCRICAO').DisplayLabel       := 'Descrição';
    FieldByName('UNIDADE').DisplayLabel         := 'Unid.';
    FieldByName('VALORVENDAFRETE').DisplayLabel := 'Vlr Total Venda';
    FieldByName('QUANTIDADE').DisplayLabel      := 'Estoque Atual';
    FieldByName('FIGURA').DisplayLabel          := 'Ver';
    FieldByName('LOCALIZACAO').DisplayLabel     := 'Local';    

    FieldByName('Classificacao').Visible        := False;
    FieldByName('CodFornecedor').Visible        := False;
    FieldByName('CodListaPreco').Visible        := False;
    FieldByName('TemClass').Visible             := False;
    FieldByName('ExibindoClass').Visible        := False;
    FieldByName('ValorCusto').Visible          := False;
    FieldByName('ValorTotal').Visible          := False;
    FieldByName('GRUPO').Visible               := False;
    

    FieldByName('CODIGO').DisplayWidth          := 8;
    FieldByName('DESCRICAO').DisplayWidth       := 50;
    FieldByName('UNIDADE').DisplayWidth         := 5;
    FieldByName('VALORVENDAFRETE').DisplayWidth := 12;
    FieldByName('QUANTIDADE').DisplayWidth      := 8;

    (FieldByName('VALORVENDAFRETE') as TNumericField).DisplayFormat := '#,##0.00';

    (FieldByName('QUANTIDADE') as TNumericField).DisplayFormat      := '#,##0.00';
  end;
end;


procedure TFormConsultaProdutos.SpeedButtonAplicarFiltrosClick(Sender: TObject);
begin
  Try
    if FormFiltrosProdutos = nil then
      Application.CreateForm(TFormFiltrosProdutos, FormFiltrosProdutos);
    FormFiltrosProdutos.Visible := False;
    FormFiltrosProdutos.refFormConsultaProdutos := Self;
    FormFiltrosProdutos.ShowModal;
  Finally
    if FormFiltrosProdutos.MrOk then
    begin
      SpeedButtonAplicarFiltros.Tag := 1;
      SpeedButtonAplicarFiltros.Font.Style := [fsBold];
      MontaConsulta;
    end
    else
    begin
      SpeedButtonAplicarFiltros.Tag := 0;    
      SpeedButtonAplicarFiltros.Font.Style := [];
      Filtros.Clear;
      FiltrosClassificacao.Clear;      
      MontaConsulta;      
      FormFiltrosProdutos := nil;
      FormFiltrosProdutos.Free;
    end;
  end;
end;



procedure TFormConsultaProdutos.DBGridConsultaTitleClick(Column: TColumn);
Var i : Integer;
begin
 if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    Exit;

  if (Column.FieldName = '') then
    Exit;

  if CDSPrincipal.IndexFieldNames = '' then
    CDSPrincipal.IndexFieldNames := Column.FieldName
  else
  begin
    CDSPrincipal.IndexDefs.Clear;
    CDSPrincipal.IndexDefs.Add('idx' + Column.FieldName, Column.FieldName, [ixDescending]);
    CDSPrincipal.IndexName :=  'idx' + Column.FieldName;
  end;

  for I := 0 to DBGridConsulta.Columns.Count - 1 do
    DBGridConsulta.Columns[I].Title.Font.Style := [];

  Column.Title.Font.Style := [fsBold];
end;

procedure TFormConsultaProdutos.BitBtnImprimirClick(Sender: TObject);
begin
  if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) Then
    Exit;

  ppRelProdutos.Print;
{  Try
    Application.CreateForm(TFormRelatorioModelo, FormRelatorioModelo);
    with FormRelatorioModelo do
    begin
      DS_Principal.DataSet := Self.CDSPrincipal;                              
      MontaRelatorio;
      ppLabelDescricaoRel.Caption := 'Relatório Consulta de Produtos';
      ppRelatorio.Print;                                                                           
    end;
  Finally
    CDSPrincipal.First;
    FormRelatorioModelo.Free;
  end; }
end;                                                                                                                                          
                                                                                                                                               
procedure TFormConsultaProdutos.MontarConsultaExterna(var CampoCodigo, CampoGrupo, CampoClass : TAdvEdit; Pai : TForm;
                                                      FiltroGrupo : Integer);
begin
  CampoAlimentarCodigo := CampoCodigo;
  CampoAlimentarGrupo  := CampoGrupo;
  CampoAlimentarClass  := CampoClass;
  Self.FiltroGrupo     := FiltroGrupo;
                                                                
  if Pai.Name = 'FormManutencaoProdutos' then
    BitBtnAlterarPrin.Enabled := False;
end;

procedure TFormConsultaProdutos.DBGridConsultaDblClick(Sender: TObject);
begin
  if CampoAlimentarCodigo = Nil then
    Exit;

  if (CDSPrincipal.FieldByName('TemClass').AsInteger > 0) then
  begin
    MessageDlg('Selecione uma Classificação!', mtInformation, [mbOk], 0);
    Exit;  
  end;

  if Assigned(CampoAlimentarCodigo.OnExit) then
  begin
    CampoAlimentarCodigo.Text := CDSPrincipal.FieldByName('Codigo').AsString;
    CampoAlimentarCodigo.OnExit(CampoAlimentarCodigo);
  end;


  if CampoAlimentarGrupo <> nil then
    CampoAlimentarGrupo.Text := CDSPrincipal.FieldByName('CodGrupo').AsString;

  if CampoAlimentarClass <> nil then
    CampoAlimentarClass.Text := CDSPrincipal.FieldByName('Classificacao').AsString;

  Close;
end;

function TFormConsultaProdutos.Pesquisar : Boolean;
var
  PosicaoAnteriorPesq : TBookmark;
begin
  Result := False;

  Try
    If Trim(EditConsulta.Text) <> '' then
    begin
      if RadioButtonContem.Checked then
      begin
        with CDSPrincipal do
        begin
          PosicaoAnteriorPesq := GetBookMark;
          DisableControls;
          AfterScroll := nil;
          First;
          while Not EOF do
          begin
            If Pos(EditConsulta.Text,UpperCase(FieldByName(Campos[ComboBoxTipoPesquisa.ItemIndex].Campo).asString)) > 0 then
            begin
              AfterScroll := CDSPrincipalAfterScroll;
              FiltrarClassificacoes;
              Result := True;
              Break;
            end;
            Next;
          end;
          if Result = False then
            GotoBookMark(PosicaoAnteriorPesq);
          FreeBookMark(PosicaoAnteriorPesq);

          EnableControls;
        end;
      end
      else
        Result := CDSPrincipal.Locate(Campos[ComboBoxTipoPesquisa.ItemIndex].Campo,EditConsulta.Text,[loCaseInsensitive, loPartialKey])
    end;
  Except
    CDSPrincipal.FreeBookMark(PosicaoAnteriorPesq);
  end;
end;


procedure TFormConsultaProdutos.EditConsultaChange(Sender: TObject);
begin
  Pesquisar;
end;

procedure TFormConsultaProdutos.MontaConsultaClassificacao;
begin
  Screen.Cursor := crHourGlass;
  With CDSClassificacao do
  begin
    SQL.Clear;
    SQL.Add(' Select Prod.Classificacao, Ep.QUANTIDADE, Prod.CODIGO, Prod.DESCRICAO, Prod.CODGRUPO,');
    SQL.Add('        Prod.CodFornecedor, Prod.Localizacao, Prod.UNIDADE, Prod.CodListaPreco');
    SQL.Add(' from Produtos Prod ');
    SQL.Add(' Inner Join EstoqueProdutos Ep on Ep.CodGrupo      = Prod.CodGrupo');
    SQL.Add('                              and Ep.CodProduto    = Prod.Codigo');
    SQL.Add('                              and Ep.Classificacao = Prod.Classificacao');
    SQL.Add(' where Prod.Classificacao <> ''''');
    SQL.Add(FiltrosClassificacao.Text);
    SQL.Add(' Order By Prod.CODGRUPO,Prod.CODIGO, Prod.Classificacao');

    Close;
    CommandText := SQL.Text;
    Open;

    if not IsEmpty then
      FiltrarClassificacoes;

    Screen.Cursor := crDefault;
  end;
end;


procedure TFormConsultaProdutos.CDSPrincipalAfterScroll(DataSet: TDataSet);
begin
  if (CDSPrincipal.Active = False) or (CDSPrincipal.IsEmpty) then
    Exit;

  FiltrarClassificacoes;
end;

procedure TFormConsultaProdutos.CDSClassificacaoAfterOpen(
  DataSet: TDataSet);
begin
  with CDSClassificacao do
  begin
    FieldByName('CLASSIFICACAO').DisplayLabel := 'Classificação';
    FieldByName('QUANTIDADE').DisplayLabel    := 'Estoque Atual';
    FieldByName('LOCALIZACAO').DisplayLabel   := 'Local';

    FieldByName('CLASSIFICACAO').DisplayWidth := 60;

    FieldByName('CODGRUPO').Visible      := False;
    FieldByName('CodFornecedor').Visible := False;
    FieldByName('DESCRICAO').Visible     := False;
    FieldByName('UNIDADE').Visible       := False;
    FieldByName('CODLISTAPRECO').Visible := False;
    FieldByName('CODIGO').Visible        := False;

    (FieldByName('QUANTIDADE') as TNumericField).DisplayFormat      := '#,##0.00';
  end;
end;

procedure TFormConsultaProdutos.BitBtnAlterarPrinClick(Sender: TObject);
Var BM : TBookMark;
begin
  if (ActiveControl = DbGridConsulta) or (ActiveControl <> DBGridClassificacoes) then
  begin
    if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) Then
      Exit;

    Bm := CDSPrincipal.GetBookmark;
    Try
      Application.CreateForm(TFormManutencaoProdutos, FormManutencaoProdutos);
      FormManutencaoProdutos.InicializaTela(2, CDSPrincipal);
      FormManutencaoProdutos.TipoProduto := 1;
      FormManutencaoProdutos.ShowModal;
    Finally
      if FormManutencaoProdutos.HouveAlteracao then
      begin
        MontaConsulta;
        Try
          CDSPrincipal.GotoBookmark(BM);
          CDSPrincipal.FreeBookmark(BM);
        Except
          CDSPrincipal.FreeBookmark(BM);
        end;
      end;
      FormManutencaoProdutos.Free;
    end;
  end
  else if ActiveControl = DBGridClassificacoes then
  begin
    if (not CDSClassificacao.Active) or (CDSClassificacao.IsEmpty) Then
      Exit;

    Bm := CDSClassificacao.GetBookmark;
    Try
      Application.CreateForm(TFormManutencaoProdutos, FormManutencaoProdutos);
      FormManutencaoProdutos.InicializaTela(2, CDSClassificacao);
      FormManutencaoProdutos.TipoProduto := 2;

      FormManutencaoProdutos.ShowModal;
    Finally
      if FormManutencaoProdutos.HouveAlteracao then
      begin
        MontaConsultaClassificacao;
        Try
          CDSClassificacao.GotoBookmark(BM);
          CDSClassificacao.FreeBookmark(BM);
        Except
          CDSClassificacao.FreeBookmark(BM);
        end;
      end;
      FormManutencaoProdutos.Free;
    end;
  end;
end;

procedure TFormConsultaProdutos.FiltrarClassificacoes;
begin
  if (CDSPrincipal.Active = False) then
    Exit;

  with CDSClassificacao do
  begin
    Filtered := False;
    if (not CDSPrincipal.IsEmpty) and
       (CDSPrincipal.FieldByName('CodGrupo').asString <> '') and
       (CDSPrincipal.FieldByName('Codigo').asString <> '') then
    begin
      Filter   := ' CodGrupo   = ' + CDSPrincipal.FieldByName('CodGrupo').asString +
                  ' and Codigo = ' + CDSPrincipal.FieldByName('Codigo').asString;
    end
    else
      Filter   := ' CodGrupo   = 0 and Codigo = 0';
    Filtered := True;
  end;
end;


procedure TFormConsultaProdutos.AlimentarCombo;
Var i : Integer;
begin
  ComboBoxTipoPesquisa.Items.Clear;
  with CDSPrincipal do
  begin
    for i := 0 to Fields.Count - 1 do
    begin
      if Fields[i].Visible then
        ComboBoxTipoPesquisa.Items.Add(Fields[i].DisplayLabel);

      if High(Campos) < 0 then
        SetLength(Campos,2)
      else
        SetLength(Campos,High(Campos) + 2);

      Campos[i].Index   := i;
      Campos[i].Campo   := Fields[i].FieldName;
      Campos[i].Tipo    := Fields[i].DataType;
      Campos[i].Visivel := Fields[i].Visible;
    end;
  end;
  ComboBoxTipoPesquisa.ItemIndex := ComboBoxTipoPesquisa.Items.IndexOf('Descrição')
end;


procedure TFormConsultaProdutos.DBGridClassificacoesDblClick(
  Sender: TObject);
begin
  if CampoAlimentarCodigo = Nil then
    Exit;               
    
  if Assigned(CampoAlimentarCodigo.OnExit) then
  begin
    CampoAlimentarCodigo.Text := CDSClassificacao.FieldByName('Codigo').AsString;
    CampoAlimentarCodigo.OnExit(CampoAlimentarCodigo);
  end;

  if CampoAlimentarGrupo = nil then
    Exit;

  CampoAlimentarGrupo.Text := CDSClassificacao.FieldByName('CodGrupo').AsString;

  if CampoAlimentarClass = nil then
    Exit;

  CampoAlimentarClass.Text := CDSClassificacao.FieldByName('Classificacao').AsString;

  Close;
end;

procedure TFormConsultaProdutos.DBGridClassificacoesTitleClick(
  Column: TColumn);
Var i : Integer;
begin
 if (not CDSClassificacao.Active) or (CDSClassificacao.IsEmpty) then
    Exit;

  if (Column.FieldName = '') then
    Exit;

  if CDSClassificacao.IndexFieldNames = '' then
    CDSClassificacao.IndexFieldNames := Column.FieldName
  else
  begin
    CDSClassificacao.IndexDefs.Clear;
    CDSClassificacao.IndexDefs.Add('idx' + Column.FieldName, Column.FieldName, [ixDescending]);
    CDSClassificacao.IndexName :=  'idx' + Column.FieldName;
  end;

  for I := 0 to DBGridClassificacoes.Columns.Count - 1 do
    DBGridClassificacoes.Columns[I].Title.Font.Style := [];

  Column.Title.Font.Style := [fsBold];
end;

procedure TFormConsultaProdutos.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
{  case ord(key) of

    VK_RETURN : begin
                  Self.Perform(WM_NEXTDLGCTL,0,0);
                  key := #0;
                end;
    VK_ESCAPE : begin
                  Self.Perform(WM_NEXTDLGCTL, 1 , 0 );
                  key := #0;
                end;
  end;  RETIREI PELO ENTER AO SELECIONAR O PRODUTO}

end;

procedure TFormConsultaProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
  begin
    EditConsulta.Limpa;
    EditConsulta.SetFocus;
  end;
end;

procedure TFormConsultaProdutos.DBGridConsultaCellClick(Column: TColumn);
begin
  if (Column.Index = 7) then
  begin
    if (not CDSPrincipal.FieldByName('TemClass').IsNull) and (CDSPrincipal.FieldByName('TemClass').asInteger > 0) then
    begin
      OcultarClassificacao;

      with CDSPrincipal do
      begin
        Edit;
        FieldByname('ExibindoClass').AsInteger := Ifthen(FieldByname('ExibindoClass').AsInteger = 0,1,0);
        Post;

        PnlDados.Visible := (FieldByname('ExibindoClass').AsInteger = 1);
        SplitterClass.Visible := (FieldByname('ExibindoClass').AsInteger = 1);
        if PnlDados.Visible then
          DBGridClassificacoes.SetFocus
        else
          DBGridConsulta.SetFocus; 
      end;
    end;  
  end;
end;

procedure TFormConsultaProdutos.DBGridConsultaDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (Column.Index = 7) then
  begin
    if (not CDSPrincipal.FieldByName('TemClass').IsNull) and (CDSPrincipal.FieldByName('TemClass').asInteger > 0) then
       Imagens.Draw(DBGridConsulta.Canvas,Rect.left,Rect.top,CDSPrincipal.FieldByName('ExibindoClass').asInteger);
  end;

  if UpperCase(Column.FieldName) = 'QUANTIDADE'  then
  begin
    if CDSPrincipal.FieldByName('Quantidade').AsFloat < 0 then
      DBGridConsulta.Canvas.Font.Color   := clRed
    else
      DBGridConsulta.Canvas.Font.Color   := clBlack;    
    DBGridConsulta.Canvas.FillRect(Rect);
    DBGridConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFormConsultaProdutos.OcultarClassificacao;
Var BM : TBookMark;
    CodGrupoMarc, CodProdutoMarc : Integer;
begin
  with CDSPrincipal do
  begin
    BM := GetBookMark;
    CodGrupoMarc   := FieldByname('CodGrupo').asInteger;
    CodProdutoMarc := FieldByname('Codigo').asInteger;
    DisableControls;
    AfterScroll := nil;
    First;
    while not EOF do
    begin
      if (FieldByname('ExibindoClass').AsInteger = 1) and
         ((CodGrupoMarc <> FieldByname('CodGrupo').asInteger) or
          (CodProdutoMarc <> FieldByname('Codigo').asInteger)) then
      begin
        Edit;
        FieldByname('ExibindoClass').AsInteger := 0;
        Post;
      end;         
      Next;
    end;
    Try
      GotoBookMark(BM);
      FreeBookMark(BM);
    Except
      FreeBookMark(BM);
    end;
    EnableControls;
    CDSPrincipal.AfterScroll := CDSPrincipalAfterScroll;
  end;

end;


procedure TFormConsultaProdutos.ppFooterBand1BeforePrint(Sender: TObject);
begin
  if ppRelProdutos.Page = ppRelProdutos.PageCount then
  begin
    ppLabelTotalGeral.Visible := True;
    ppDBTotalGeral.Visible    := True;                          
  end
  else
  begin
    ppLabelTotalGeral.Visible := False;
    ppDBTotalGeral.Visible    := False;                                                                                                       
  end;
end;

procedure TFormConsultaProdutos.ppDBText13Print(Sender: TObject);                                                                             
begin
  ppVarTotalPag.Value := ppVarTotalPag.Value + ppDBText13.FieldValue;
end;                                                                                                                                        

end.                                                                                                                                               
