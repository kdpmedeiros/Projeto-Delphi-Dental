inherited FrameProdutos: TFrameProdutos
  Width = 457
  Height = 34
  inherited SpeedButtonConsulta: TSpeedButton
    Left = 61
    Top = 7
    OnClick = SpeedButtonConsultaClick
  end
  object Label1: TLabel [1]
    Left = 4
    Top = 10
    Width = 53
    Height = 16
    Caption = 'Produto:.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  inherited EditCodigo: TAdvEdit
    Left = 85
    Top = 8
    Width = 68
    OnExit = EditCodigoExit
  end
  inherited EditNome: TAdvEdit
    Left = 154
    Top = 8
    Width = 295
  end
end
