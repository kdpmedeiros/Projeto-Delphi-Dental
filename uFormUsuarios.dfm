inherited FormUsuarios: TFormUsuarios
  Caption = 'Cadastro de Usu'#225'rios do Sistema'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlBotoes: TPanel
    inherited BitBtnIncluir: TSpeedButton
      OnClick = BitBtnIncluirClick
    end
    inherited BitBtnAlterar: TSpeedButton
      OnClick = BitBtnAlterarClick
    end
  end
  inherited GroupBoxCabecalho: TGroupBox
    inherited BitBtnImprimir: TSpeedButton
      OnClick = BitBtnImprimirClick
    end
  end
end
