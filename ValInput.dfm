object fmInputQuery: TfmInputQuery
  Left = 0
  Top = 0
  Caption = #1042#1074#1086#1076
  ClientHeight = 561
  ClientWidth = 654
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object kbdMain: TTouchKeyboard
    Left = 0
    Top = 178
    Width = 654
    Height = 383
    Align = alClient
    GradientEnd = clBlack
    GradientStart = clGray
    Layout = 'Standard'
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 654
    Height = 178
    Align = alTop
    Caption = 'pnlMain'
    TabOrder = 1
    object lblPromt: TLabel
      Left = 1
      Top = 1
      Width = 86
      Height = 29
      Align = alTop
      Alignment = taCenter
      Caption = 'lblPromt'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object mmoInput: TMemo
      Left = 1
      Top = 30
      Width = 652
      Height = 147
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyDown = FormKeyDown
    end
  end
end
