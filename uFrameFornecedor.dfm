inherited FrameFornecedor: TFrameFornecedor
  Width = 392
  Height = 37
  inherited SpeedButtonConsulta: TSpeedButton
    Left = 81
    Height = 21
    OnClick = SpeedButtonConsultaClick
  end
  object Label1: TLabel [1]
    Left = 4
    Top = 10
    Width = 73
    Height = 16
    Caption = 'Fornecedor:.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  inherited EditCodigo: TAdvEdit
    Left = 105
    Top = 8
    Width = 48
    OnExit = EditCodigoExit
  end
  inherited EditNome: TAdvEdit
    Left = 153
    Top = 8
  end
end
