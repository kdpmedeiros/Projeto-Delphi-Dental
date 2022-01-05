inherited FrameBancos: TFrameBancos
  Width = 348
  inherited SpeedButtonConsulta: TSpeedButton
    Left = 53
    OnClick = SpeedButtonConsultaClick
  end
  object Label1: TLabel [1]
    Left = 4
    Top = 10
    Width = 45
    Height = 16
    Caption = 'Banco:.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  inherited EditCodigo: TAdvEdit
    Left = 77
    OnExit = EditCodigoExit
  end
  inherited EditNome: TAdvEdit
    Left = 117
  end
end
