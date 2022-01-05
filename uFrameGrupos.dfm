inherited FrameGrupos: TFrameGrupos
  Width = 344
  Height = 36
  inherited SpeedButtonConsulta: TSpeedButton
    Left = 49
    OnClick = SpeedButtonConsultaClick
  end
  object Label1: TLabel [1]
    Left = 4
    Top = 10
    Width = 43
    Height = 16
    Caption = 'Grupo:.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  inherited EditCodigo: TAdvEdit
    Left = 72
    Top = 8
    OnExit = EditCodigoExit
  end
  inherited EditNome: TAdvEdit
    Left = 112
    Top = 8
  end
end
