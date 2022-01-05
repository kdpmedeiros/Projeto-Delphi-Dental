inherited FrameCondicoesPagto: TFrameCondicoesPagto
  Width = 318
  Height = 28
  inherited SpeedButtonConsulta: TSpeedButton
    Left = 87
    Top = 3
    OnClick = SpeedButtonConsultaClick
  end
  object Label1: TLabel [1]
    Left = 4
    Top = 6
    Width = 80
    Height = 16
    Caption = 'Cond. Pagto:.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  inherited EditCodigo: TAdvEdit
    Left = 111
    Top = 4
    Width = 31
    OnExit = EditCodigoExit
  end
  inherited EditNome: TAdvEdit
    Left = 143
    Top = 4
    Width = 170
  end
end
