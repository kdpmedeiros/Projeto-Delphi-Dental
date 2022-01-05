object FormRelatorioModelo: TFormRelatorioModelo
  Left = 207
  Top = 170
  Width = 451
  Height = 97
  BorderIcons = [biSystemMenu]
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object DS_Principal: TDataSource
    Left = 12
    Top = 8
  end
  object ppRelatorio: TppReport
    AutoStop = False
    DataPipeline = ppDBPipelineRel
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297128
    PrinterSetup.mmPaperWidth = 210080
    PrinterSetup.PaperSize = 9
    Units = utScreenPixels
    BeforePrint = ppRelatorioBeforePrint
    DeviceType = 'Screen'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = False
    OutlineSettings.Enabled = False
    Left = 74
    Top = 9
    Version = '7.0'
    mmColumnWidth = 197379
    DataPipelineName = 'ppDBPipelineRel'
    object ppBandaCabecalho: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 28046
      mmPrintPosition = 0
      object ppLabelDescricaoRel: TppLabel
        UserName = 'LabelDescricaoRel'
        Caption = 'Descricao_Relatorio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        mmHeight = 3704
        mmLeft = 79111
        mmTop = 13229
        mmWidth = 36248
        BandType = 0
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'Dental Nova Ribeir'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 16
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 6085
        mmLeft = 64558
        mmTop = 5292
        mmWidth = 67733
        BandType = 0
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3704
        mmLeft = 0
        mmTop = 5821
        mmWidth = 17198
        BandType = 0
      end
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3704
        mmLeft = 0
        mmTop = 10848
        mmWidth = 15346
        BandType = 0
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = 'Pag.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 189707
        mmTop = 5821
        mmWidth = 7673
        BandType = 0
      end
      object ppSystemVariable3: TppSystemVariable
        UserName = 'SystemVariable3'
        VarType = vtPageSet
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 186002
        mmTop = 11642
        mmWidth = 11377
        BandType = 0
      end
      object ppLabel5: TppLabel
        UserName = 'Label11'
        SaveOrder = 0
        Save = True
        AutoSize = False
        Caption = 
          '----------------------------------------------------------------' +
          '---------------------------------------------------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 0
        mmTop = 24342
        mmWidth = 197380
        BandType = 0
      end
      object ppLabel7: TppLabel
        UserName = 'Label3'
        SaveOrder = 1
        Save = True
        AutoSize = False
        Caption = 
          '----------------------------------------------------------------' +
          '---------------------------------------------------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 0
        mmTop = 0
        mmWidth = 197380
        BandType = 0
      end
    end
    object ppBandaDetalhe: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 12965
      mmPrintPosition = 0
      object ppShapeDetalhes: TppShape
        UserName = 'ShapeDetalhes'
        mmHeight = 12965
        mmLeft = 0
        mmTop = 0
        mmWidth = 197644
        BandType = 4
      end
    end
  end
  object ppDBPipelineRel: TppDBPipeline
    DataSource = DS_Principal
    UserName = 'DBPipelineRel'
    Left = 43
    Top = 8
  end
end
