inherited FormVendedores: TFormVendedores
  Caption = 'Cadastro de Vendedores'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlBotoes: TPanel
    inherited BitBtnIncluir: TSpeedButton
      OnClick = BitBtnIncluirClick
    end
    inherited BitBtnAlterar: TSpeedButton
      OnClick = BitBtnAlterarClick
    end
  end
  inherited GroupBoxCabecalho: TGroupBox
    inherited BitBtnImprimir: TSpeedButton
      OnClick = BitBtnImprimirClick
    end
  end
  object CDSVendedorClientes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPPrincipal'
    Left = 583
    Top = 374
    object CDSVendedorClientesCodVendedor: TFMTBCDField
      FieldName = 'CodVendedor'
      Size = 8
    end
    object CDSVendedorClientesVendedor: TStringField
      FieldName = 'Vendedor'
    end
    object CDSVendedorClientesCodCliente: TFMTBCDField
      FieldName = 'CodCliente'
      Size = 8
    end
    object CDSVendedorClientesCliente: TStringField
      FieldName = 'Cliente'
    end
  end
  object DS_VendedorClientes: TDataSource
    DataSet = CDSVendedorClientes
    Left = 551
    Top = 374
  end
  object ppReportVendedorCliente: TppReport
    AutoStop = False
    DataPipeline = ppDBPipelineVendedorClientes
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4, 210x297 mm'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    DeviceType = 'Screen'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    Left = 584
    Top = 312
    Version = '7.0'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipelineVendedorClientes'
    object ppHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 16669
      mmPrintPosition = 0
      object ppShape1: TppShape
        UserName = 'Shape1'
        mmHeight = 14817
        mmLeft = 0
        mmTop = 1323
        mmWidth = 197643
        BandType = 0
      end
      object ppLabelDescricaoRel: TppLabel
        UserName = 'LabelDescricaoRel'
        Caption = 'Relat'#243'rio de Clientes por Vendedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        mmHeight = 3810
        mmLeft = 72440
        mmTop = 11113
        mmWidth = 53298
        BandType = 0
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'Dental Nova Ribeir'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 16
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 6350
        mmLeft = 529
        mmTop = 4233
        mmWidth = 197115
        BandType = 0
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3704
        mmLeft = 1588
        mmTop = 4763
        mmWidth = 12435
        BandType = 0
      end
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3704
        mmLeft = 1588
        mmTop = 9790
        mmWidth = 12700
        BandType = 0
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = 'Pag.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 189442
        mmTop = 4763
        mmWidth = 6615
        BandType = 0
      end
      object ppSystemVariable3: TppSystemVariable
        UserName = 'SystemVariable3'
        VarType = vtPageSet
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 181505
        mmTop = 9260
        mmWidth = 14552
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 5292
      mmPrintPosition = 0
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'CodCliente'
        DataPipeline = ppDBPipelineVendedorClientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipelineVendedorClientes'
        mmHeight = 3704
        mmLeft = 794
        mmTop = 529
        mmWidth = 12171
        BandType = 4
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'Cliente'
        DataPipeline = ppDBPipelineVendedorClientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipelineVendedorClientes'
        mmHeight = 3704
        mmLeft = 14023
        mmTop = 529
        mmWidth = 85990
        BandType = 4
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'CodVendedor'
      DataPipeline = ppDBPipelineVendedorClientes
      OutlineSettings.CreateNode = True
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDBPipelineVendedorClientes'
      object ppGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 11642
        mmPrintPosition = 0
        object ppLabel4: TppLabel
          UserName = 'Label4'
          Caption = 'Vendedor:.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3810
          mmLeft = 794
          mmTop = 794
          mmWidth = 16595
          BandType = 3
          GroupNo = 0
        end
        object ppDBText1: TppDBText
          UserName = 'DBText1'
          DataField = 'CodVendedor'
          DataPipeline = ppDBPipelineVendedorClientes
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'ppDBPipelineVendedorClientes'
          mmHeight = 3704
          mmLeft = 19315
          mmTop = 794
          mmWidth = 17198
          BandType = 3
          GroupNo = 0
        end
        object ppDBText2: TppDBText
          UserName = 'DBText2'
          AutoSize = True
          DataField = 'Vendedor'
          DataPipeline = ppDBPipelineVendedorClientes
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'ppDBPipelineVendedorClientes'
          mmHeight = 3810
          mmLeft = 37571
          mmTop = 794
          mmWidth = 14690
          BandType = 3
          GroupNo = 0
        end
        object ppLabel5: TppLabel
          UserName = 'Label5'
          Caption = 'Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          Transparent = True
          mmHeight = 3598
          mmLeft = 794
          mmTop = 6879
          mmWidth = 9948
          BandType = 3
          GroupNo = 0
        end
        object ppLine1: TppLine
          UserName = 'Line1'
          Position = lpBottom
          Weight = 0.750000000000000000
          mmHeight = 2117
          mmLeft = 0
          mmTop = 9525
          mmWidth = 197644
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 9790
        mmPrintPosition = 0
        object ppLine2: TppLine
          UserName = 'Line2'
          Weight = 0.750000000000000000
          mmHeight = 2117
          mmLeft = 0
          mmTop = 0
          mmWidth = 197644
          BandType = 5
          GroupNo = 0
        end
        object ppLabel9: TppLabel
          UserName = 'Label9'
          Caption = 'Total Clientes:.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3810
          mmLeft = 157364
          mmTop = 1323
          mmWidth = 22818
          BandType = 5
          GroupNo = 0
        end
        object ppDBCalcTotalLista: TppDBCalc
          UserName = 'DBCalcTotalLista'
          DataField = 'CodCliente'
          DataPipeline = ppDBPipelineVendedorClientes
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DBCalcType = dcCount
          DataPipelineName = 'ppDBPipelineVendedorClientes'
          mmHeight = 3704
          mmLeft = 181769
          mmTop = 1323
          mmWidth = 14552
          BandType = 5
          GroupNo = 0
        end
      end
    end
  end
  object ppDBPipelineVendedorClientes: TppDBPipeline
    DataSource = DS_VendedorClientes
    UserName = 'DBPipelineVendedorClientes'
    Left = 552
    Top = 312
    object ppDBPipelineVendedorClientesppField1: TppField
      FieldAlias = 'CodVendedor'
      FieldName = 'CodVendedor'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineVendedorClientesppField2: TppField
      FieldAlias = 'Vendedor'
      FieldName = 'Vendedor'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineVendedorClientesppField3: TppField
      FieldAlias = 'CodCliente'
      FieldName = 'CodCliente'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineVendedorClientesppField4: TppField
      FieldAlias = 'Cliente'
      FieldName = 'Cliente'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
  end
end
