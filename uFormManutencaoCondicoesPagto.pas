unit uFormManutencaoCondicoesPagto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, Buttons, ExtCtrls, StdCtrls, TAdvEditP, DBXpress,
  SqlTimSt, math, DB, DBCtrls, FMTBcd, SqlExpr, Provider, DBClient, Grids,
  DBGrids;

type
  TFormManutencaoCondicoesPagto = class(TFormManutencao)
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label23: TLabel;
    EditNome: TAdvEdit;
    EditCodigo: TAdvEdit;
    Label1: TLabel;
    EditParcelas: TAdvEdit;
    BtnGerarParc: TBitBtn;
    ds_parcelas: TDataSource;
    Cds_Parcelas: TClientDataSet;
    GroupBox1: TGroupBox;
    dbg_parcelas: TDBGrid;
    Panel1: TPanel;
    Label2: TLabel;
    sp_gravar_parc: TSpeedButton;
    sp_cancelar_parc: TSpeedButton;
    EditDiaVenc: TAdvEdit;
    ck_avista: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure DS_ManutencaoDataChange(Sender: TObject; Field: TField);
    procedure EditNomeExit(Sender: TObject);
    procedure BtnGerarParcClick(Sender: TObject);
    procedure sp_gravar_parcClick(Sender: TObject);
    procedure sp_cancelar_parcClick(Sender: TObject);
    procedure dbg_parcelasDblClick(Sender: TObject);
    procedure ck_avistaClick(Sender: TObject);
  private
    { Private declarations }
    procedure PrepararTelaManutencao;
    procedure Gravar;
    procedure LimparTela;
    function  RetornaProximaSequencia : Integer;
    procedure VoltaUltimSequencia;
    procedure MontarParcelas(Manual : Boolean);
    function  Busca_Parcela_Zerada : Boolean;
    procedure GravarParcelas;
  public
    { Public declarations }
  end;

var
  FormManutencaoCondicoesPagto: TFormManutencaoCondicoesPagto;

implementation

uses uDataModule, DateUtils, uFuncoes;

{$R *.dfm}

procedure TFormManutencaoCondicoesPagto.PrepararTelaManutencao;
begin
  with CDSCadastro do
  begin
    if iTipo = 1 then
    begin
      LimparTela;
      EditCodigo.asInteger  := RetornaProximaSequencia;
    end
    else if iTipo = 2 then
    begin
      EditCodigo.asInteger   := FieldByName('Codigo').asInteger;
      EditNome.Text          := FieldByName('Descricao').asString;
      EditParcelas.asInteger := FieldByName('Parcelas').asInteger;
      ck_avista.Checked      := (FieldByName('FlagAVista').asInteger = 1);
    end;
  end;
  MontarParcelas(False);
end;


procedure TFormManutencaoCondicoesPagto.FormShow(Sender: TObject);
begin
  EditNome.SetFocus;
  inherited;
  PrepararTelaManutencao;
end;

procedure TFormManutencaoCondicoesPagto.Gravar;
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
          SQL.Add(' INSERT INTO CONDICOESPAGTO (');
          SQL.Add('     CODIGO , DESCRICAO, PARCELAS, DIAVENC, FLAGAVISTA)');
          SQL.Add(' VALUES (');
          SQL.Add('     :CODIGO , :DESCRICAO, :PARCELAS, 0, :FLAGAVISTA)');
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE CONDICOESPAGTO');
          SQL.Add(' SET DESCRICAO = :DESCRICAO,');
          SQL.Add('     PARCELAS  = :PARCELAS,');
          SQL.Add('     DIAVENC   = 0,');
          SQL.Add('     FLAGAVISTA = :FLAGAVISTA');
          SQL.Add(' WHERE CODIGO  = :CODIGO');
        end;
        ParamByName('Codigo').asFloat     := EditCodigo.asFloat;
        ParamByName('Descricao').asString := EditNome.Text;
        ParamByName('Parcelas').asInteger := EditParcelas.asInteger;
        ParamByName('FlagAVista').asInteger := IfThen(ck_avista.Checked,1,0);
        ExecSQL;
        SQLConnectionPrin.Commit(TransDesc);
        GravarParcelas;


        if CheckBoxFecharTela.Checked then
          Self.Close
        else
        begin
          LimparTela;
          if iTipo = 2 then
            CDSCadastro.Next;
          PrepararTelaManutencao;
          EditNome.SetFocus;
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


procedure TFormManutencaoCondicoesPagto.BitBtnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  if Busca_Parcela_Zerada then
  begin
    Application.MessageBox('Parcela(s) ainda não Configuradas, não será possível Gravar!','Erro',0);
    EditParcelas.SetFocus;
    Exit;
  end;

  if EditParcelas.asFloat <> Cds_Parcelas.RecordCount then
  begin
    Application.MessageBox('O Nr. de Parcelas não confere com a(s) Parcela(s) Configurada(s)!','Erro',0);
    EditParcelas.SetFocus;
    Exit;
  end;

  if (EditParcelas.asFloat = 0) and (ck_avista.Checked = False) then
  begin
    Application.MessageBox('Condição de Pagamento sem Parcelas deve ser "Á Vista"!','Erro',0);
    ck_avista.SetFocus;
    Exit;
  end;

  
  Gravar;
end;

procedure TFormManutencaoCondicoesPagto.LimparTela;
begin
  EditCodigo.asInteger := 0;
  EditNome.Text        := '';
  ck_avista.Checked    := False;
  EditParcelas.Limpa;
  EditDiaVenc.Limpa;
  Cds_Parcelas.Close;  
end;

function TFormManutencaoCondicoesPagto.RetornaProximaSequencia : Integer;
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
        SQL.Add('  Set CodCondPagto = CodCondPagto + 1');
        ExecSQL;
        DataModulePrin.SQLConnectionPrin.Commit(TransDesc);

        Close;
        SQL.Clear;
        SQL.Add('Select Count(*) as Qtde from CondicoesPagto where Codigo = (Select CodCondPagto from UltimaSequencia)');
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
      SQL.Add('Select CodCondPagto from UltimaSequencia');
      Open;

      Result := FieldByname('CodCondPagto').asInteger;
    end;
  end
  else
    Result := RetornaProximaSequencia;
end;

procedure TFormManutencaoCondicoesPagto.VoltaUltimSequencia;
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
      SQL.Add('  Set CodCondPagto = ' + EditCodigo.Text + ' - 1');
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


procedure TFormManutencaoCondicoesPagto.BitBtnCancelarClick(
  Sender: TObject);
begin
  inherited;
  if iTipo = 1 then
    VoltaUltimSequencia;
end;

procedure TFormManutencaoCondicoesPagto.DS_ManutencaoDataChange(
  Sender: TObject; Field: TField);
begin
  inherited;
  if (CheckBoxFecharTela.Checked = False) and Self.Showing then
    PrepararTelaManutencao;

end;

procedure TFormManutencaoCondicoesPagto.EditNomeExit(Sender: TObject);
begin
  inherited;
  if ActiveControl = BitBtnCancelar then
    Exit;

  if Trim(EditNome.Text) = '' then
  begin
    EditNome.SetFocus;
    Exit;
  end;
end;

procedure TFormManutencaoCondicoesPagto.MontarParcelas;
Var QuantParc : Integer;

  Procedure Gerar_Novas_Parcelas;
  begin
    while QuantParc <= EditParcelas.asInteger do
    begin
      with Cds_Parcelas do
      begin
        Append;
        FieldByName('CODCONDPAGTO').asFloat := EditCodigo.asFloat;
        FieldByName('PARCELA').asFloat      := QuantParc;
        FieldByName('DIAVENC').asFloat      := 0;
        FieldByName('STATUS').asString      := 'I';
        Post;
      end;

      QuantParc := QuantParc + 1;
    end;
    Cds_Parcelas.First;
  end;

  Procedure Apagar_Parcelas;
  begin
    with Cds_Parcelas do
    begin
      DisableControls;
      First;
      while Not EOF do
      begin
        if FieldByName('STATUS').asString = 'A' then
        begin
          Edit;
          FieldByName('STATUS').asString  := 'X';
          Post;
        end
        else
          Delete;  
      end;
      EnableControls;
    end;
  end;

begin
  QuantParc := 1;
  with Cds_Parcelas do
  begin
    SQL.Clear;
    SQL.Add('Select VENC_CONDPAGTO.*, CAST(''A'' as Char(1)) as STATUS from VENC_CONDPAGTO');
    SQL.Add('where CodCondPagto = :CodCondPagto');
    Close;
    CommandText := SQL.Text;
    Params.ParamByName('CodCondPagto').asFloat := EditCodigo.asFloat;
    TratarClientDatasetParaPost(Cds_Parcelas);

    Filtered := False;
    Filter   := 'STATUS <> ''X''';
    Filtered := True;

    if Cds_Parcelas.IsEmpty then
      Gerar_Novas_Parcelas
    else
    begin
      if Manual then
      begin
        If Application.MessageBox('Deseja Gerar Novamente as Parcelas e Perder as Parcelas Atuais Configuradas?','Confirmação',
                                 MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idno then
          Exit;

        Apagar_Parcelas;
        Gerar_Novas_Parcelas;
      end;
    end;
  end;
end;


procedure TFormManutencaoCondicoesPagto.BtnGerarParcClick(Sender: TObject);
begin
  inherited;
  MontarParcelas(True);
end;

procedure TFormManutencaoCondicoesPagto.sp_gravar_parcClick(Sender: TObject);
begin
  inherited;
  if EditDiaVenc.asInteger > 0 then
  begin
    with Cds_Parcelas do
    begin
      Edit;
      FieldByName('DIAVENC').asInteger := EditDiaVenc.asInteger;
      Post;
    end;
    EditDiaVenc.Limpa;
  end;  
end;

procedure TFormManutencaoCondicoesPagto.sp_cancelar_parcClick(
  Sender: TObject);
begin
  inherited;
  EditDiaVenc.Limpa;
  EditDiaVenc.SetFocus;
end;

procedure TFormManutencaoCondicoesPagto.dbg_parcelasDblClick(
  Sender: TObject);
begin
  inherited;
  if (Cds_Parcelas.Active) and (not Cds_Parcelas.IsEmpty) then
  begin
    EditDiaVenc.asInteger := Cds_Parcelas.FieldByname('DIAVENC').asInteger;
    EditDiaVenc.SetFocus;
  end;
end;

function TFormManutencaoCondicoesPagto.Busca_Parcela_Zerada : Boolean;
begin
  Result := False;

  with Cds_Parcelas do
  begin
    if IsEmpty then
      Exit;
      
    DisableControls;
    Result := Locate('DiaVenc',0,[]);
    EnableControls;
  end;
end;

procedure TFormManutencaoCondicoesPagto.GravarParcelas;
Var TransDesc : TTransactionDesc;
begin
  Cds_Parcelas.Filtered := False;
  
  Cds_Parcelas.IndexDefs.Clear;
  Cds_Parcelas.IndexDefs.Add('idxSTATUS', 'STATUS', [ixDescending]);
  Cds_Parcelas.IndexName :=  'idxSTATUS';


  TransDesc.TransactionID  := 1;
  TransDesc.IsolationLevel := xilREADCOMMITTED;
  Try
    with DataModulePrin do
    begin
      SQLConnectionPrin.StartTransaction(TransDesc);
      With SQLQueryExecuta do
      begin
        Cds_Parcelas.First;
        while not Cds_Parcelas.EOF do
        begin
          Close;
          if Cds_Parcelas.FieldByName('STATUS').asString = 'I' then
          begin
            SQL.Clear;
            SQL.Add(' INSERT INTO VENC_CONDPAGTO (');
            SQL.Add('     CODCONDPAGTO, PARCELA, DIAVENC )');
            SQL.Add(' VALUES (');
            SQL.Add('     :CODCONDPAGTO, :PARCELA, :DIAVENC )');
          end
          else if Cds_Parcelas.FieldByName('STATUS').asString = 'A' then
          begin
            SQL.Clear;
            SQL.Add(' UPDATE VENC_CONDPAGTO');
            SQL.Add(' SET DIAVENC = :DIAVENC');
            SQL.Add(' WHERE CODCONDPAGTO  = :CODCONDPAGTO');
            SQL.Add('   AND PARCELA  = :PARCELA');
          end
          else if Cds_Parcelas.FieldByName('STATUS').asString = 'X' then
          begin
            SQL.Clear;
            SQL.Add(' DELETE FROM VENC_CONDPAGTO');
            SQL.Add(' WHERE CODCONDPAGTO  = :CODCONDPAGTO');
            SQL.Add('   AND PARCELA       = :PARCELA');
          end;
          ParamByName('CODCONDPAGTO').asFloat := Cds_Parcelas.FieldByName('CODCONDPAGTO').asFloat;
          ParamByName('PARCELA').asFloat      := Cds_Parcelas.FieldByName('PARCELA').asFloat;
          if Cds_Parcelas.FieldByName('STATUS').asString <> 'X' then
            ParamByName('DIAVENC').asFloat    := Cds_Parcelas.FieldByName('DIAVENC').asFloat;
          ExecSQL;

          Cds_Parcelas.Next;
        end;
        SQLConnectionPrin.Commit(TransDesc);
      end;
      Cds_Parcelas.Filtered := True;
    end;
  Except
    on e: exception do
    begin
      Cds_Parcelas.Filtered := True;
      Application.MessageBox(PChar('Ocorreram Erros ao Gravar as Parcelas! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
    end;
  end;
end;


procedure TFormManutencaoCondicoesPagto.ck_avistaClick(Sender: TObject);
begin
  inherited;
  if ck_avista.Checked then
  begin
    EditParcelas.asInteger := 0;
    BtnGerarParc.OnClick(BtnGerarParc);
  end;
end;

end.

