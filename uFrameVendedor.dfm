inherited FrameVendedor: TFrameVendedor
  Width = 374
  Height = 37
  inherited SpeedButtonConsulta: TSpeedButton
    Left = 73
    Top = 7
    OnClick = SpeedButtonConsultaClick
  end
  object Label1: TLabel [1]
    Left = 4
    Top = 10
    Width = 63
    Height = 16
    Caption = 'Vendedor:.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  inherited EditCodigo: TAdvEdit
    Left = 97
    Top = 8
    Width = 40
    CharCase = ecUpperCase
    OnExit = EditCodigoExit
  end
  inherited EditNome: TAdvEdit
    Left = 139
    Top = 8
  end
end
