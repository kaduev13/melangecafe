object fmExtInfo: TfmExtInfo
  Left = 0
  Top = 0
  Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
  ClientHeight = 268
  ClientWidth = 778
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object sgGoods: TStringGrid
    Left = 154
    Top = 0
    Width = 624
    Height = 268
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 184
    ExplicitTop = 24
    ExplicitWidth = 249
    ExplicitHeight = 225
  end
  object pnlCommonInfo: TPanel
    Left = 0
    Top = 0
    Width = 154
    Height = 268
    Align = alLeft
    TabOrder = 1
    ExplicitHeight = 305
    object edtSaleType: TEdit
      Left = 8
      Top = 24
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object edtSum: TEdit
      Left = 8
      Top = 99
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object edtDt: TEdit
      Left = 8
      Top = 62
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
  end
end
