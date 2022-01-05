inherited FrameCliente: TFrameCliente
  Width = 352
  Height = 30
  inherited SpeedButtonConsulta: TSpeedButton
    Left = 56
    Top = 4
    OnClick = SpeedButtonConsultaClick
  end
  object Label1: TLabel [1]
    Left = 4
    Top = 6
    Width = 48
    Height = 16
    Caption = 'Cliente:.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  inherited EditCodigo: TAdvEdit
    Left = 80
    Top = 5
    OnExit = EditCodigoExit
  end
  inherited EditNome: TAdvEdit
    Left = 120
    Top = 5
  end
end
