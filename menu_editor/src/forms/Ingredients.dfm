object fmIngredients: TfmIngredients
  Left = 0
  Top = 0
  Caption = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
  ClientHeight = 468
  ClientWidth = 706
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
  object sgIngredients: TStringGrid
    Left = 0
    Top = 0
    Width = 569
    Height = 468
    Align = alClient
    ColCount = 2
    DefaultRowHeight = 40
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = -6
  end
  object pnlBtns: TPanel
    Left = 569
    Top = 0
    Width = 137
    Height = 468
    Align = alRight
    TabOrder = 1
    ExplicitLeft = 561
    ExplicitTop = 48
    object btnEdit: TButton
      Left = 16
      Top = 167
      Width = 105
      Height = 81
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnEditClick
    end
    object btnCreate: TButton
      Left = 16
      Top = 80
      Width = 105
      Height = 81
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCreateClick
    end
    object btnDelete: TButton
      Left = 16
      Top = 254
      Width = 105
      Height = 81
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnDeleteClick
    end
  end
end
