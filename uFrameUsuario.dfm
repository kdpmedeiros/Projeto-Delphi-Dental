inherited FrameUsuario: TFrameUsuario
  Width = 356
  inherited SpeedButtonConsulta: TSpeedButton
    Left = 60
    OnClick = SpeedButtonConsultaClick
  end
  object Label1: TLabel [1]
    Left = 5
    Top = 10
    Width = 52
    Height = 16
    Caption = 'Usu'#225'rio:.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  inherited EditCodigo: TAdvEdit
    Left = 84
    OnExit = EditCodigoExit
  end
  inherited EditNome: TAdvEdit
    Left = 124
  end
end
