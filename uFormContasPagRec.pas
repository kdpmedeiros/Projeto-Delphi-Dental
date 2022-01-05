unit uFormContasPagRec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, DBGrids, StdCtrls, TAdvEditP, ExtCtrls, FMTBcd,
  DB, SqlExpr, Provider, DBClient, SqlTimSt, DbXPress, uFrameModelo,
  uFrameDuplicatas, uFrameBancos, uFramePedidoNota, uFrameCliente, DBCtrls,
  uFrameVendedor;

type
  TFormContasPagRec = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    DataIni: TAdvEdit;
    DataFim: TAdvEdit;
    Label2: TLabel;
    BitBtnBuscar: TBitBtn;
    DBGridPrin: TDBGrid;
    PnlBotoes: TPanel;
    BitBtnIncluir: TSpeedButton;
    BitBtnAlterar: TSpeedButton;
    BitBtnExcluir: TSpeedButton;
    Panel3: TPanel;
    BitBtnFechar: TSpeedButton;
    CDSPrincipal: TClientDataSet;
    DSPPrincipal: TDataSetProvider;
    SQLPrincipal: TSQLDataSet;
    DS_Principal: TDataSource;
    ComboBoxTipo: TComboBox;
    Label3: TLabel;
    FrameDuplicatas: TFrameDuplicatas;
    Label4: TLabel;
    FrameCliente: TFrameCliente;
    Label8: TLabel;
    ComboBoxTipoPedido: TComboBox;
    FramePedidoNota: TFramePedidoNota;
    FrameBancos: TFrameBancos;
    CDSPrincipalCODIGO: TFMTBCDField;
    CDSPrincipalCODDUPLICATA: TStringField;
    CDSPrincipalTP: TSmallintField;
    CDSPrincipalTIPO: TStringField;
    CDSPrincipalDATAEMISSAO: TDateField;
    CDSPrincipalVALOR: TFMTBCDField;
    CDSPrincipalCODCLIENTE: TFMTBCDField;
    CDSPrincipalNOME: TStringField;
    lbl_exibe_total: TLabel;
    lblTotal: TLabel;
    FrameVendedor: TFrameVendedor;
    CDSPrincipalDATAPAGAMENTO: TDateTimeField;
    LabelAlterarPrecos: TLabel;
    CDSPrincipalTIPOPEDIDONF: TSmallintField;
    procedure BitBtnFecharClick(Sender: TObject);
    procedure BitBtnIncluirClick(Sender: TObject);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnBuscarClick(Sender: TObject);
    procedure DBGridPrinDblClick(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure ComboBoxTipoChange(Sender: TObject);
    procedure DBGridPrinTitleClick(Column: TColumn);
    procedure ComboBoxTipoPedidoChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    SQL : TStringList;
    procedure CarregaMovimentos;
    procedure ExcluirMovimento;
    procedure ScrollMouse(var Msg: TMsg; var Handled: Boolean);
    procedure CalcularMovimentos;
  public
    { Public declarations }
  end;

var
  FormContasPagRec: TFormContasPagRec;

implementation

uses uFormBaixaDuplicatas, uDataModule, DateUtils;

{$R *.dfm}

procedure TFormContasPagRec.BitBtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormContasPagRec.BitBtnIncluirClick(Sender: TObject);
begin
  Try
    Application.CreateForm(TFormBaixaDuplicatas, FormBaixaDuplicatas);
    FormBaixaDuplicatas.InicializaTela(1,CDSPrincipal);
    FormBaixaDuplicatas.FrameDuplicatas.ComboBoxTipo.ItemIndex := ComboBoxTipo.ItemIndex;
    FormBaixaDuplicatas.ComboBoxTipoPedido.ItemIndex  := ComboBoxTipoPedido.ItemIndex;
    FormBaixaDuplicatas.FrameDuplicatas.i_tipo_ped_nf := ComboBoxTipoPedido.ItemIndex + 1;
    FormBaixaDuplicatas.Visible := False;
    FormBaixaDuplicatas.ShowModal;
  Finally
    CarregaMovimentos;
    FormBaixaDuplicatas.Free;
  end;
end;

procedure TFormContasPagRec.BitBtnAlterarClick(Sender: TObject);
Var BM : TBookMark;
begin
   if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    exit;

  { if (not CDSPrincipal.FieldByName('DATAPAGAMENTO').isNull) then
   begin
     MessageDlg('Duplicata Paga Integralmente!', mtInformation, [mbOk], 0);
     Exit;
   end;       }

  BM := CDSPrincipal.GetBookmark;
  Try
    Application.CreateForm(TFormBaixaDuplicatas, FormBaixaDuplicatas);
    FormBaixaDuplicatas.InicializaTela(2,CDSPrincipal);
    FormBaixaDuplicatas.FrameDuplicatas.ComboBoxTipo.ItemIndex := ComboBoxTipo.ItemIndex;
    FormBaixaDuplicatas.ComboBoxTipoPedido.ItemIndex  := CDSPrincipal.FieldByName('TIPOPEDIDONF').AsInteger - 1;
    FormBaixaDuplicatas.FrameDuplicatas.i_tipo_ped_nf := FormBaixaDuplicatas.ComboBoxTipoPedido.ItemIndex + 1;
    FormBaixaDuplicatas.Visible := False;
    FormBaixaDuplicatas.ShowModal;
  Finally
    CarregaMovimentos;
    Try
      CDSPrincipal.GotoBookmark(BM);
      CDSPrincipal.FreeBookmark(BM);
    Except
      CDSPrincipal.FreeBookmark(BM);
    end;
    FormBaixaDuplicatas.Free;
  end;
end;

procedure TFormContasPagRec.CarregaMovimentos;
begin
  SQL.Clear;
  SQL.Add(' Select Mov.CODIGO, Mov.CODDUPLICATA, Mov.TIPO as Tp,');
  SQL.Add('        CASE WHEN Mov.TIPO = 1 THEN ''RECEBER'' ELSE ''PAGAR'' END AS TIPO,');
  SQL.Add('        Mov.DATAEMISSAO, Mov.VALOR, Dpl.CodCliente, Cli.Nome, ');
  SQL.Add('        Dpl.DataPagamento,  Dpl.TipoPedidoNF ');
  SQL.Add(' from MovFinanceiro Mov');
  SQL.Add(' left outer join Duplicatas Dpl on Dpl.Codigo = Mov.CodDuplicata ');
  SQL.Add(' left outer join Clientes Cli on Cli.Codigo = Dpl.CodCliente');
  SQL.Add(' left outer join PedidoNota PN on PN.Codigo = Dpl.CodPedidoNF  ');
  SQL.Add('                              and PN.Tipo   = Dpl.TipoPedidoNF ');
  SQL.Add(' where Mov.Tipo = ' + IntToStr(ComboBoxTipo.ItemIndex + 1));
  if DataIni.IsDate then
    SQL.Add(' and Mov.DATAEMISSAO >= :DATAINI');
  if DataFim.IsDate then
    SQL.Add(' and Mov.DATAEMISSAO <= :DATAFIM');
  if Trim(FrameDuplicatas.EditCodigo.Text) <> '' then
    SQL.Add(' and Mov.CODDUPLICATA = :CODDUPLICATA');

  if FrameCliente.EditCodigo.asFloat > 0 then
    SQL.Add(' and DPL.CODCLIENTE = ' + FrameCliente.EditCodigo.Text);

  if FrameBancos.EditCodigo.asFloat > 0 then
    SQL.Add(' and DPL.CODBANCO   = ' + FrameBancos.EditCodigo.Text);

  if FramePedidoNota.EditCodigo.asFloat > 0 then
  begin
    SQL.Add(' and DPL.CODPEDIDONF  = ' + FramePedidoNota.EditCodigo.Text);
    SQL.Add(' and DPL.TIPOPEDIDONF = ' + IntToStr(ComboBoxTipoPedido.ItemIndex + 1));
  end;
  if FrameVendedor.EditCodigo.asFloat > 0 then
    SQL.Add(' and PN.CODVENDEDOR = ' + FrameVendedor.EditCodigo.Text);
  SQL.Add(' Order by Mov.DATAEMISSAO ');

  with CDSPrincipal do
  begin
    Close;
    CommandText := SQL.Text;
    if DataIni.IsDate then
      Params.ParamByName('DATAINI').AsSQLTimeStamp := DateTimeToSqlTimesTamp(DataIni.asDate);
    if DataFim.IsDate then
      Params.ParamByName('DATAFIM').AsSQLTimeStamp := DateTimeToSqlTimesTamp(DataFim.asDate);
    if Trim(FrameDuplicatas.EditCodigo.Text) <> '' then
      Params.ParamByName('CODDUPLICATA').asString := FrameDuplicatas.EditCodigo.Text;
    Open;

    FieldByName('DataPagamento').Visible := False;
    (FieldByName('VALOR') as TNumericField).DisplayFormat := '#,##0.00';
  end;
  CalcularMovimentos;
end;


procedure TFormContasPagRec.FormShow(Sender: TObject);
begin
  FrameDuplicatas.ComboBoxTipo.ItemIndex := 0;
  CarregaMovimentos;
end;

procedure TFormContasPagRec.FormCreate(Sender: TObject);
begin
  SQL := TStringList.Create;
  FramePedidoNota.vTipo := ComboBoxTipoPedido.ItemIndex + 1;
  Application.OnMessage := ScrollMouse;
  lblTotal.Caption := FormatFloat('#,##0.00',0);
end;

procedure TFormContasPagRec.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SQL.Free;
end;

procedure TFormContasPagRec.BitBtnBuscarClick(Sender: TObject);
begin
  CarregaMovimentos;
end;

procedure TFormContasPagRec.DBGridPrinDblClick(Sender: TObject);
begin
  BitBtnAlterar.OnClick(BitBtnAlterar);
end;

procedure TFormContasPagRec.ExcluirMovimento;
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
      SQL.Add('Delete From MOVFINANCEIRO ');
      SQL.Add('WHERE CODIGO      = :CODIGO ');
      SQL.Add(' AND CODDUPLICATA = :CODDUPLICATA ');
      SQL.Add(' AND TIPO         = :TIPO ');
      ParamByName('CODIGO').asInteger             := CDSPrincipal.FieldByname('CODIGO').asInteger;
      ParamByname('CODDUPLICATA').asString        := CDSPrincipal.FieldByname('CODDUPLICATA').asString;
      ParamByname('TIPO').asInteger               := CDSPrincipal.FieldByname('Tp').asInteger;
      ExecSQL;
      DataModulePrin.SQLConnectionPrin.Commit(TransDesc);
      CarregaMovimentos;
    end;
  Except
    on e: exception do
    begin
      Application.MessageBox(PChar('Ocorreram Erros ao Excluir o Movimento. O Registro Não Poderá ser Gravado! Erro: '+ e.Message),'Erro',0);
      DataModulePrin.SQLConnectionPrin.Rollback(TransDesc);
      Close;
    end;
  end;
end;


procedure TFormContasPagRec.BitBtnExcluirClick(Sender: TObject);
begin
 if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    exit;

  If Application.MessageBox('Deseja Realmente Excluir o Movimento Selecionado?','Confirmação',
                            MB_ICONQUESTION+ MB_YESNO+MB_DEFBUTTON2)= idyes then
    ExcluirMovimento;
end;




procedure TFormContasPagRec.ComboBoxTipoChange(Sender: TObject);
begin
  FrameDuplicatas.ComboBoxTipo.ItemIndex := ComboBoxTipo.ItemIndex; 
  CarregaMovimentos;
end;

procedure TFormContasPagRec.DBGridPrinTitleClick(Column: TColumn);
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

  for I := 0 to DBGridPrin.Columns.Count - 1 do
    DBGridPrin.Columns[I].Title.Font.Style := [];

  Column.Title.Font.Style := [fsBold];    
end;

procedure TFormContasPagRec.ComboBoxTipoPedidoChange(Sender: TObject);
begin
  FramePedidoNota.vTipo := ComboBoxTipoPedido.ItemIndex + 1;
end;

procedure TFormContasPagRec.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case ord(key) of

    VK_RETURN : begin
                  Self.Perform(WM_NEXTDLGCTL,0,0);
                  key := #0;
                end;
    VK_ESCAPE : begin
                  Self.Perform(WM_NEXTDLGCTL, 1 , 0 );
                  key := #0;
                end;
  end;
end;

procedure TFormContasPagRec.ScrollMouse(var Msg: TMsg; var Handled: Boolean);
var
  i: smallint;
begin
  if Msg.message = WM_MOUSEWHEEL then
  begin
    Msg.message := WM_KEYDOWN;
    Msg.lParam := 0;
    i := HiWord(Msg.wParam) ;
    if i > 0 then
      Msg.wParam := VK_UP
    else
      Msg.wParam := VK_DOWN;
    Handled := False;
  end;
end;

procedure TFormContasPagRec.CalcularMovimentos;
Var Valor : Real;
begin
  with CDSPrincipal do
  begin
    DisableControls;
    First;
    Valor := 0;
    while not EOF do
    begin
      Valor := Valor + FieldByname('VALOR').asFloat;
      Next;
    end;
    EnableControls;
  end;
  lblTotal.Caption := FormatFloat('#,##0.00',Valor);
end;


procedure TFormContasPagRec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F7 then
  begin
    lbl_exibe_total.Visible := (lbl_exibe_total.Visible = False);
    lblTotal.Visible        := (lblTotal.Visible = False);
  end;
end;

end.

