inherited FrameListaPreco: TFrameListaPreco
  Width = 393
  Height = 37
  inherited SpeedButtonConsulta: TSpeedButton
    Left = 98
    Top = 9
    Height = 21
    OnClick = SpeedButtonConsultaClick
  end
  object Label1: TLabel [1]
    Left = 4
    Top = 10
    Width = 92
    Height = 16
    Caption = 'Lista de Pre'#231'o:.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  inherited EditCodigo: TAdvEdit
    Left = 122
    OnExit = EditCodigoExit
  end
  inherited EditNome: TAdvEdit
    Left = 160
  end
end
