unit uFormManutencaoGrupos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormManutencaoModelo, Buttons, ExtCtrls, StdCtrls, DBXpress, SqlTimSt, math, db,
  TAdvEditP, DBCtrls;

type
  TFormManutencaoGrupos = class(TFormManutencao)
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label23: TLabel;
    EditNome: TAdvEdit;
    EditCodigo: TAdvEdit;
    procedure FormShow(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure DS_ManutencaoDataChange(Sender: TObject; Field: TField);
    procedure EditNomeExit(Sender: TObject);
  private
    { Private declarations }
    procedure PrepararTelaManutencao;
    procedure Gravar;
    procedure LimparTela;
  public
    { Public declarations }
  end;

var
  FormManutencaoGrupos: TFormManutencaoGrupos;

implementation

uses uDataModule;

{$R *.dfm}

procedure TFormManutencaoGrupos.PrepararTelaManutencao;
begin
  with CDSCadastro do
  begin
    if iTipo = 1 then
    begin
      LimparTela;
      with DataModulePrin.SQLQueryExecuta do
      begin
        Close;
        SQL.Clear;
        SQL.Add('Select Max(Codigo) + 1 as Proximo from GRUPOS');
        Open;
        if IsEmpty then
          EditCodigo.asInteger := 1
        else
        begin
          if FieldByname('Proximo').IsNull then
            EditCodigo.asInteger := 1
          else
            EditCodigo.asInteger := FieldByname('Proximo').asInteger;
        end
      end;
    end
    else if iTipo = 2 then
    begin
      EditCodigo.asInteger := FieldByName('Codigo').asInteger;
      EditNome.Text   := FieldByName('Descricao').asString;
    end;
  end;
end;


procedure TFormManutencaoGrupos.FormShow(Sender: TObject);
begin
  inherited;
  PrepararTelaManutencao;
end;


procedure TFormManutencaoGrupos.Gravar;
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
          SQL.Add(' INSERT INTO GRUPOS (');
          SQL.Add('     CODIGO , DESCRICAO)');
          SQL.Add(' VALUES (');
          SQL.Add('     :CODIGO , :DESCRICAO)');
        end
        else if iTipo = 2 then
        begin
          SQL.Clear;
          SQL.Add(' UPDATE GRUPOS');
          SQL.Add(' SET DESCRICAO = :DESCRICAO');
          SQL.Add(' WHERE CODIGO  = :CODIGO');
        end;
        ParamByName('Codigo').asFloat     := EditCodigo.asFloat;
        ParamByName('Descricao').asString := EditNome.Text;
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


procedure TFormManutencaoGrupos.BitBtnConfirmarClick(Sender: TObject);
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

procedure TFormManutencaoGrupos.LimparTela;
begin
  EditCodigo.asInteger := 0;
  EditNome.Text        := '';
end;

procedure TFormManutencaoGrupos.DS_ManutencaoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if (CheckBoxFecharTela.Checked = False) and Self.Showing then
    PrepararTelaManutencao;

end;

procedure TFormManutencaoGrupos.EditNomeExit(Sender: TObject);
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

end.
