unit uFormFiltrosProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, uFrameListaPreco, uFrameFornecedor, StdCtrls,
  TAdvEditP, uFrameModelo, uFrameGrupos;

type
  TFormFiltrosProdutos = class(TForm)
    PnlBotoes: TPanel;
    BitBtnFechar: TSpeedButton;
    GroupBoxFiltros: TGroupBox;
    FrameGruposIni: TFrameGrupos;
    FrameGruposFim: TFrameGrupos;
    EditClassificacao: TAdvEdit;
    Label1: TLabel;
    FrameFornecedorIni: TFrameFornecedor;
    FrameFornecedorFim: TFrameFornecedor;
    Label2: TLabel;
    EditQtdeEstoque: TAdvEdit;
    Label3: TLabel;
    EditUnidade: TAdvEdit;
    SpeedButtonFiltrar: TSpeedButton;
    Label4: TLabel;
    EditFiltroVlrVenda: TAdvEdit;
    RadioGroupTipoProduto: TRadioGroup;
    CheckBoxConsiderarFiltroProd: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonFiltrarClick(Sender: TObject);
    procedure BitBtnFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure CheckBoxConsiderarFiltroProdClick(Sender: TObject);
  private
    { Private declarations }
    procedure AlimentarFiltros;
  public
    { Public declarations }
    MrOk : Boolean;
    refFormConsultaProdutos : TForm;
  end;

var
  FormFiltrosProdutos: TFormFiltrosProdutos;

implementation

{$R *.dfm}

Uses uFormConsultaProdutos, uFuncoes;

procedure TFormFiltrosProdutos.FormCreate(Sender: TObject);
begin
  MrOk := False;
end;

procedure TFormFiltrosProdutos.SpeedButtonFiltrarClick(Sender: TObject);
begin
  AlimentarFiltros;
  MrOk := True;
  Close;
end;

procedure TFormFiltrosProdutos.AlimentarFiltros;
begin
  with TFormConsultaProdutos(refFormConsultaProdutos).Filtros do
  begin
    Clear;
    if FrameGruposIni.EditCodigo.asInteger <> 0 then
      Add(' and Prod.CodGrupo >= ' + IntToStr(FrameGruposIni.EditCodigo.asInteger));
    if FrameGruposFim.EditCodigo.asInteger <> 0 then
      Add(' and Prod.CodGrupo <= ' + IntToStr(FrameGruposFim.EditCodigo.asInteger));

    if FrameFornecedorIni.EditCodigo.asInteger <> 0 then
      Add(' and Prod.CodFornecedor >= ' + IntToStr(FrameFornecedorIni.EditCodigo.asInteger));
    if FrameFornecedorFim.EditCodigo.asInteger <> 0 then
      Add(' and Prod.CodFornecedor <= ' + IntToStr(FrameFornecedorFim.EditCodigo.asInteger));

    if Trim(EditClassificacao.Text) <> '' then
    begin
      Add(' and (Exists(Select Codigo from Produtos Prod2');
      Add('                   where Prod2.CodGrupo      = Prod.CodGrupo');
      Add('                     and Prod2.Codigo        = Prod.Codigo');
      Add('                     and Prod2.Classificacao = ' + QuotedStr(EditClassificacao.Text) + '))');
    end;

    if Trim(EditUnidade.Text) <> '' then
      Add(' and Prod.Unidade = ' + QuotedStr(EditUnidade.Text));
    if EditFiltroVlrVenda.asFloat > 0 then
      Add(' and Lp.ValorVendaFrete > ' + FloatToStr(EditFiltroVlrVenda.asFloat));
    if EditQtdeEstoque.asInteger > 0 then
      Add(' and Ep.Quantidade > ' + IntToStr(EditQtdeEstoque.asInteger));

    if CheckBoxConsiderarFiltroProd.Checked then
    begin
      if RadioGroupTipoProduto.ItemIndex = 0 then
      begin
        Add(' and (Exists(Select Codigo from Produtos Prod2');
        Add('                   where Prod2.CodGrupo = Prod.CodGrupo');
        Add('                     and Prod2.Codigo   = Prod.Codigo');
        Add('                     and Prod2.Classificacao <> ''''))');
      end
      else
      begin
        Add(' and (not Exists(Select Codigo from Produtos Prod2');
        Add('                   where Prod2.CodGrupo = Prod.CodGrupo');
        Add('                     and Prod2.Codigo   = Prod.Codigo');
        Add('                     and Prod2.Classificacao <> ''''))');
      end;
    end;  
  end;

  with TFormConsultaProdutos(refFormConsultaProdutos).FiltrosClassificacao do
  begin
    Clear;
    if Trim(EditClassificacao.Text) <> '' then
      Add(' and Prod.Classificacao = ' + QuotedStr(EditClassificacao.Text));
  end;
end;

procedure TFormFiltrosProdutos.BitBtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormFiltrosProdutos.FormKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TFormFiltrosProdutos.FormShow(Sender: TObject);
begin
  MrOk := False;
end;

procedure TFormFiltrosProdutos.CheckBoxConsiderarFiltroProdClick(
  Sender: TObject);
begin
  RadioGroupTipoProduto.Enabled := CheckBoxConsiderarFiltroProd.Checked;
end;

end.
