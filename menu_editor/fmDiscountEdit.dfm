object fmDiscountEditor: TfmDiscountEditor
  Left = 0
  Top = 0
  Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1089#1082#1080#1076#1082#1072#1084#1080
  ClientHeight = 401
  ClientWidth = 733
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
  object lbDiscounts: TListBox
    Left = 0
    Top = 0
    Width = 589
    Height = 401
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 19
    ParentFont = False
    TabOrder = 0
    OnClick = lbDiscountsClick
    ExplicitLeft = 80
    ExplicitTop = 32
    ExplicitWidth = 273
    ExplicitHeight = 289
  end
  object pnlTools: TPanel
    Left = 589
    Top = 0
    Width = 144
    Height = 401
    Align = alRight
    TabOrder = 1
    ExplicitLeft = 376
    object btnAddDiscounts: TButton
      Left = 6
      Top = 152
      Width = 129
      Height = 49
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1082#1080#1076#1082#1080
      TabOrder = 0
      OnClick = btnAddDiscountsClick
    end
  end
end
