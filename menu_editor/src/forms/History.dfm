object fmHistory: TfmHistory
  Left = 0
  Top = 0
  Caption = #1048#1089#1090#1086#1088#1080#1103
  ClientHeight = 578
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlLayout: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 578
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 496
    ExplicitTop = 240
    ExplicitWidth = 185
    ExplicitHeight = 41
    object splMiddle: TSplitter
      Left = 500
      Top = 0
      Height = 578
      ExplicitLeft = 248
      ExplicitTop = 192
      ExplicitHeight = 100
    end
    object pnlLeft: TPanel
      Left = 0
      Top = 0
      Width = 500
      Height = 578
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object splLeft: TSplitter
        Left = 250
        Top = 0
        Height = 578
        ExplicitLeft = 248
        ExplicitTop = 192
        ExplicitHeight = 100
      end
      object pnlLeftLeft: TPanel
        Left = 0
        Top = 0
        Width = 250
        Height = 578
        Align = alLeft
        TabOrder = 0
        object sgSession: TStringGrid
          Left = 1
          Top = 1
          Width = 248
          Height = 576
          Align = alClient
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
          TabOrder = 0
          OnClick = sgSessionClick
          ExplicitLeft = 96
          ExplicitTop = 224
          ExplicitWidth = 320
          ExplicitHeight = 120
        end
      end
      object pnlLeftRight: TPanel
        Left = 253
        Top = 0
        Width = 247
        Height = 578
        Align = alClient
        TabOrder = 1
        ExplicitLeft = 8
        ExplicitWidth = 250
        object sgSales: TStringGrid
          Left = 1
          Top = 1
          Width = 245
          Height = 576
          Align = alClient
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
          TabOrder = 0
          ExplicitLeft = 88
          ExplicitTop = 192
          ExplicitWidth = 320
          ExplicitHeight = 120
        end
      end
    end
    object pnlRight: TPanel
      Left = 503
      Top = 0
      Width = 481
      Height = 578
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitLeft = 720
      ExplicitWidth = 264
      object splRight: TSplitter
        Left = 234
        Top = 0
        Height = 578
        ExplicitLeft = 248
        ExplicitTop = 192
        ExplicitHeight = 100
      end
      object pnlRightLeft: TPanel
        Left = 0
        Top = 0
        Width = 234
        Height = 578
        Align = alLeft
        TabOrder = 0
        ExplicitLeft = 8
        ExplicitWidth = 250
        object sgGoods: TStringGrid
          Left = 1
          Top = 1
          Width = 232
          Height = 576
          Align = alClient
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
          TabOrder = 0
          ExplicitLeft = -86
          ExplicitTop = 192
          ExplicitWidth = 320
          ExplicitHeight = 120
        end
      end
      object pnlRightRight: TPanel
        Left = 237
        Top = 0
        Width = 244
        Height = 578
        Align = alClient
        TabOrder = 1
        ExplicitLeft = 8
        ExplicitWidth = 250
        object sgIngredients: TStringGrid
          Left = 1
          Top = 1
          Width = 242
          Height = 576
          Align = alClient
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
          TabOrder = 0
          ExplicitLeft = 234
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 578
        end
      end
    end
  end
end
