object fmGoodEditor: TfmGoodEditor
  Left = 0
  Top = 0
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1090#1086#1074#1072#1088#1086#1074
  ClientHeight = 456
  ClientWidth = 769
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lstGoods: TListBox
    Left = 0
    Top = 0
    Width = 608
    Height = 456
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 19
    ParentFont = False
    TabOrder = 0
    OnClick = lstGoodsClick
  end
  object pnlbtns: TPanel
    Left = 608
    Top = 0
    Width = 161
    Height = 456
    Align = alRight
    TabOrder = 1
    object btnExit: TButton
      Left = 4
      Top = 213
      Width = 153
      Height = 75
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnExitClick
    end
    object btnAddNew: TButton
      Left = 4
      Top = 131
      Width = 153
      Height = 75
      Caption = #1053#1086#1074#1099#1081' '#1090#1086#1074#1072#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnAddNewClick
    end
  end
end
