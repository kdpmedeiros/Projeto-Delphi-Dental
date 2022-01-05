unit uFormConsultaPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormModelo, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids,
  DBGrids, StdCtrls, TAdvEditP, Buttons, ExtCtrls, uFrameModelo,
  uFramePedidoNota, uFrameCliente, uFrameVendedor, SqlTimSt;

type
  TFormConsultaPedidos = class(TFormModelo)
    ck_nao_conf: TCheckBox;
    EditDataIni: TAdvEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditDataFim: TAdvEdit;
    FrameVendedor: TFrameVendedor;
    FrameCliente: TFrameCliente;
    procedure BitBtnConsultaClick(Sender: TObject);
    procedure CDSPrincipalAfterOpen(DataSet: TDataSet);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure DBGridPrinDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure MontaConsulta;
  public
    { Public declarations }
  end;

var
  FormConsultaPedidos: TFormConsultaPedidos;

implementation

uses uFormPedidoNota;

{$R *.dfm}

procedure TFormConsultaPedidos.MontaConsulta;
begin
  with CDSPrincipal do
  begin
    SQL.Clear;
    SQL.Add('   Select CASE WHEN PNF.Tipo = 1 then PNF.Codigo else PNF.NumeroID end as Codigo,');
    SQL.Add('   PNF.DataEmissao, PNF.Codigo as CodPedidoNF, PNF.Tipo,  CASE WHEN PNF.Tipo = 1  then ''PED'' ELSE ''NF'' END AS TipoPedNF,');
    SQL.Add('   PNF.ValorComissao as ValorTotalComissao,  (Select Sum( IPNFI.ValorTotal) From ItemPedidoNota IPNFI');
    SQL.Add('   where IPNFI.CodPedidoNF = PNF.Codigo and  IPNFI.Tipo = PNF.Tipo) as ValorTotalPedido,');
    SQL.Add('   V.PercComissao as PercComissVend,  PNF.CodVendedor, V.Nome as NomeVend,');
    SQL.Add('   Case when PNF.FLAGOK = 1 then ''OK'' ELSE '' '' END as Conferido,');
    SQL.Add('   PNF.CodCliente, Cli.Nome as NomeCli');
    SQL.Add('   From PedidoNota PNF');
    SQL.Add('   Left join Vendedores V on V.Codigo  = PNF.CodVendedor');
    SQL.Add('   Left outer Join Clientes Cli on Cli.Codigo    = PNF.CodCliente');
    SQL.Add(' where PNF.CodVendedor = :CodVendedor');
    if EditDataIni.IsDate then
      SQL.Add(' and PNF.DataEmissao >= :DataIni');
    if EditDataFim.IsDate then
      SQL.Add(' and PNF.DataEmissao <= :DataFim');
    if FrameCliente.EditCodigo.asFloat > 0 then
      SQL.Add(' and PNF.CodCliente = :CodCliente');
    if ck_nao_conf.Checked then
      SQL.Add(' and PNF.FlagOK = 0');    
    SQL.Add(' Order by PNF.Tipo, Cli.Nome ');

    Close;
    CommandText := SQL.Text;
    Params.ParamByname('CodVendedor').asInteger  := FrameVendedor.EditCodigo.asInteger;
    if EditDataIni.IsDate then
      Params.ParamByname('DataIni').asSQLTimesTamp := DateTimeToSQLTimesTamp(EditDataIni.asDate);
    if EditDataFim.IsDate then
      Params.ParamByname('DataFim').asSQLTimesTamp := DateTimeToSQLTimesTamp(EditDataFim.asDate);
    if FrameCliente.EditCodigo.asFloat > 0 then
      Params.ParamByname('CodCliente').asFloat  := FrameCliente.EditCodigo.asFloat;
    Open;
  end;
end;

procedure TFormConsultaPedidos.BitBtnConsultaClick(Sender: TObject);
begin
//  inherited;
  if FrameVendedor.EditCodigo.asInteger = 0 then
  begin
    Application.MessageBox('Informe o Vendedor!','Informação',0);
    FrameVendedor.EditCodigo.SetFocus;
    Exit;
  end;
  MontaConsulta;
end;

procedure TFormConsultaPedidos.CDSPrincipalAfterOpen(DataSet: TDataSet);
begin
  inherited;
  with CDSPrincipal do
  begin
    (FieldByName('ValorTotalPedido') as TNumericField).DisplayFormat   := '#,##0.00';
    (FieldByName('PercComissVend') as TNumericField).DisplayFormat     := '#,##0.00';
    (FieldByName('ValorTotalComissao') as TNumericField).DisplayFormat := '#,##0.00';

    FieldByName('Codigo').DisplayWidth         := 10;
    FieldByName('DataEmissao').DisplayWidth    := 12;
    FieldByName('TipoPedNF').DisplayWidth      := 4;
    FieldByName('CodCliente').DisplayWidth     := 8;
    FieldByName('NomeCli').DisplayWidth        := 40;
    FieldByName('ValorTotalPedido').DisplayWidth   := 14;
    FieldByName('PercComissVend').DisplayWidth     := 8;
    FieldByName('ValorTotalComissao').DisplayWidth := 8;
    FieldByName('Conferido').DisplayWidth          := 3;

  end;
end;

procedure TFormConsultaPedidos.BitBtnAlterarClick(Sender: TObject);
Var BM : TBookMark;
begin
  inherited;
  if (CDSPrincipal.Active = False) or (CDSPrincipal.IsEmpty) then
    Exit;

  Try

    Application.CreateForm(TFormPedidoNota, FormPedidoNota);
    FormPedidoNota.InicializaTela(CDSPrincipal.FieldByName('Tipo').AsInteger - 1, CDSPrincipal.FieldByName('CodPedidoNF').asInteger);
    FormPedidoNota.Visible := False;
    FormPedidoNota.ShowModal;
  Finally
    FormPedidoNota.Free;
    BM := CDSPrincipal.GetBookMark;    
    MontaConsulta;
    Try
      CDSPrincipal.GotoBookMark(BM);
      CDSPrincipal.FreeBookMark(BM);
    Except
      CDSPrincipal.FreeBookMark(BM);    
    end;
  end;
end;

procedure TFormConsultaPedidos.DBGridPrinDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if UpperCase(Column.FieldName) = 'CONFERIDO'  then
  begin
    DBGridPrin.Canvas.Font.Color   := clRed;
    DBGridPrin.Canvas.Font.Style   := [fsBold];
    DBGridPrin.Canvas.FillRect(Rect);
    DBGridPrin.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

end.
