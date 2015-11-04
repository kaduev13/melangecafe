object fmGoodCard: TfmGoodCard
  Left = 0
  Top = 0
  Caption = #1050#1072#1088#1090#1072' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 549
  ClientWidth = 762
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
  object pnlBtns: TPanel
    Left = 0
    Top = 479
    Width = 762
    Height = 70
    Align = alBottom
    TabOrder = 0
    object btnCancel: TButton
      Left = 183
      Top = 11
      Width = 161
      Height = 49
      Caption = #1054#1090#1084#1077#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnDelete: TButton
      Left = 350
      Top = 11
      Width = 161
      Height = 49
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnDeleteClick
    end
    object btnSave: TButton
      Left = 16
      Top = 11
      Width = 161
      Height = 49
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnSaveClick
    end
  end
  object pnlGoodInfo: TPanel
    Left = 0
    Top = 0
    Width = 762
    Height = 97
    Align = alTop
    TabOrder = 1
    object cbActionAble: TCheckBox
      Left = 16
      Top = 63
      Width = 169
      Height = 17
      Caption = #1055#1088#1086#1076#1072#1077#1090#1089#1103' '#1087#1086' '#1072#1082#1094#1080#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object cbFlag: TComboBox
      Left = 216
      Top = 58
      Width = 257
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = #1056#1072#1079#1076#1077#1083' '#1074#1099#1073#1086#1088#1082#1080
      Items.Strings = (
        #1041#1072#1088
        #1050#1091#1093#1085#1103)
    end
    object edtName: TLabeledEdit
      Left = 16
      Top = 24
      Width = 513
      Height = 27
      EditLabel.Width = 68
      EditLabel.Height = 19
      EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtPrice: TLabeledEdit
      Left = 560
      Top = 24
      Width = 161
      Height = 27
      EditLabel.Width = 36
      EditLabel.Height = 19
      EditLabel.Caption = #1062#1077#1085#1072
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object pnlRecipe: TPanel
    Left = 0
    Top = 97
    Width = 762
    Height = 382
    Align = alClient
    TabOrder = 2
    object pnlRecipeBtns: TPanel
      Left = 625
      Top = 1
      Width = 136
      Height = 380
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnRecipeCreate: TButton
        Left = 6
        Top = 4
        Width = 122
        Height = 103
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1085#1075#1088#1077#1076#1080#1077#1085#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        WordWrap = True
        OnClick = btnRecipeCreateClick
      end
      object btnRecipeDelete: TButton
        Left = 6
        Top = 220
        Width = 122
        Height = 103
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1080#1085#1075#1088#1077#1076#1080#1077#1085#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        WordWrap = True
        OnClick = btnRecipeDeleteClick
      end
      object btnRecipeEdit: TButton
        Left = 6
        Top = 113
        Width = 122
        Height = 103
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1080#1085#1075#1088#1077#1076#1080#1077#1085#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        WordWrap = True
        OnClick = btnRecipeEditClick
      end
    end
    object sgRecipes: TStringGrid
      Left = 1
      Top = 1
      Width = 624
      Height = 380
      Align = alClient
      ColCount = 4
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentFont = False
      TabOrder = 1
    end
  end
end
