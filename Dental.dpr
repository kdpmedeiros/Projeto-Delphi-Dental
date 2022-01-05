program Dental;

uses
  Forms,
  uFormSobre in 'uFormSobre.pas' {FormSobre},
  uFormModelo in 'uFormModelo.pas' {FormModelo},
  uFormClientes in 'uFormClientes.pas' {FormClientes},
  uFormFornecedores in 'uFormFornecedores.pas' {FormFornecedores},
  uFormVendedores in 'uFormVendedores.pas' {FormVendedores},
  uFormPrincipal in 'uFormPrincipal.pas' {FormPrincipal},
  uDataModule in 'uDataModule.pas' {DataModulePrin: TDataModule},
  uFormManutencaoModelo in 'uFormManutencaoModelo.pas' {FormManutencao},
  uFormProdutos in 'uFormProdutos.pas' {FormProdutos},
  uFormGruposProdutos in 'uFormGruposProdutos.pas' {FormGruposProdutos},
  uFormListaPreco in 'uFormListaPreco.pas' {FormListaPreco},
  uFormUsuarios in 'uFormUsuarios.pas' {FormUsuarios},
  uFormEmpresa in 'uFormEmpresa.pas' {FormEmpresa},
  uFormManutencaoClientes in 'uFormManutencaoClientes.pas' {FormManutencaoClientes},
  uFrameModelo in 'uFrameModelo.pas' {FrameModelo: TFrame},
  uFrameVendedor in 'uFrameVendedor.pas' {FrameVendedor: TFrame},
  uFormConsultaFrame in 'uFormConsultaFrame.pas' {FormConsultaFrame},
  uFormManutencaoVendedores in 'uFormManutencaoVendedores.pas' {FormManutencaoVendedores},
  uFormManutencaoFornecedores in 'uFormManutencaoFornecedores.pas' {FormManutencaoFornecedores},
  uFormManutencoUsuarios in 'uFormManutencoUsuarios.pas' {FormManutencaoUsuarios},
  uFormManutencaoEmpresa in 'uFormManutencaoEmpresa.pas' {FormManutencaoEmpresa},
  uFormManutencaoGrupos in 'uFormManutencaoGrupos.pas' {FormManutencaoGrupos},
  uFormManutencaoListaPreco in 'uFormManutencaoListaPreco.pas' {FormManutencaoListaPreco},
  uFuncoes in 'uFuncoes.pas',
  uRelatorioModelo in 'uRelatorioModelo.pas' {FormRelatorioModelo},
  uFormManutencaoProdutos in 'uFormManutencaoProdutos.pas' {FormManutencaoProdutos},
  uFrameGrupos in 'uFrameGrupos.pas' {FrameGrupos: TFrame},
  uFrameFornecedor in 'uFrameFornecedor.pas' {FrameFornecedor: TFrame},
  uFrameListaPreco in 'uFrameListaPreco.pas' {FrameListaPreco: TFrame},
  uFormTipoRelatorio in 'uFormTipoRelatorio.pas' {FormTipoRelatorio},
  uFormConsultaProdutos in 'uFormConsultaProdutos.pas' {FormConsultaProdutos},
  uFormFiltrosProdutos in 'uFormFiltrosProdutos.pas' {FormFiltrosProdutos},
  uFrameProdutos in 'uFrameProdutos.pas' {FrameProdutos: TFrame},
  uFormConexao in 'uFormConexao.pas' {FormConexao},
  uFormCondicoesPagto in 'uFormCondicoesPagto.pas' {FormCondicoesPagto},
  uFormManutencaoCondicoesPagto in 'uFormManutencaoCondicoesPagto.pas' {FormManutencaoCondicoesPagto},
  uFormPedidoNota in 'uFormPedidoNota.pas' {FormPedidoNota},
  uFrameCliente in 'uFrameCliente.pas' {FrameCliente: TFrame},
  uFrameCondicoesPagto in 'uFrameCondicoesPagto.pas' {FrameCondicoesPagto: TFrame},
  uFormManutencaoItemPedidoNF in 'uFormManutencaoItemPedidoNF.pas' {FormManutencaoItemPedidoNF},
  uFramePedidoNota in 'uFramePedidoNota.pas' {FramePedidoNota: TFrame},
  uFormProcessamento in 'uFormProcessamento.pas' {FormProcessamento},
  uFormCupom in 'uFormCupom.pas' {FormCupom},
  uFormCotacoes in 'uFormCotacoes.pas' {FormCotacoes},
  uFormManutencaoItemCotacao in 'uFormManutencaoItemCotacao.pas' {FormManutencaoItemCotacao},
  uFormDuplicatas in 'uFormDuplicatas.pas' {FormDuplicatas},
  uFormManutencaoDuplicatas in 'uFormManutencaoDuplicatas.pas' {FormManutencaoDuplicatas},
  uFrameBancos in 'uFrameBancos.pas' {FrameBancos: TFrame},
  uFormBanco in 'uFormBanco.pas' {FormBancos},
  uFormManutencaoBancos in 'uFormManutencaoBancos.pas' {FormManutencaoBancos},
  uFormRelatoriosGerais in 'uFormRelatoriosGerais.pas' {FormRelatoriosGerais},
  uFormLogin in 'uFormLogin.pas' {FormLogin},
  uFormPermissoes in 'uFormPermissoes.pas' {FormPermissoes},
  uFrameUsuario in 'uFrameUsuario.pas' {FrameUsuario: TFrame},
  uFormContasPagRec in 'uFormContasPagRec.pas' {FormContasPagRec},
  uFrameDuplicatas in 'uFrameDuplicatas.pas' {FrameDuplicatas: TFrame},
  uFormBaixaDuplicatas in 'uFormBaixaDuplicatas.pas' {FormBaixaDuplicatas},
  uFormConsultaPedidos in 'uFormConsultaPedidos.pas' {FormConsultaPedidos};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
