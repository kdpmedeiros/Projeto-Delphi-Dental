inherited FrameDuplicatas: TFrameDuplicatas
  Width = 195
  Height = 30
  inherited SpeedButtonConsulta: TSpeedButton
    Left = 91
    Top = 3
    OnClick = SpeedButtonConsultaClick
  end
  inherited EditNome: TAdvEdit [1]
    Left = 56
    Top = 7
    Width = 17
    Height = 17
    Visible = False
  end
  inherited EditCodigo: TAdvEdit [2]
    Left = 115
    Top = 4
    Width = 73
    Text = ''
    OnExit = EditCodigoExit
    advTratamento = Geral
    advMask = '%s'
    advValorPadrao = ''
  end
  object ComboBoxTipo: TComboBox
    Left = 4
    Top = 4
    Width = 81
    Height = 21
    Style = csDropDownList
    Color = 15496704
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 13
    ItemIndex = 0
    ParentFont = False
    TabOrder = 2
    Text = 'Receber'
    Items.Strings = (
      'Receber'
      'Pagar')
  end
end
