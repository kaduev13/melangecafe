object fmSaleShot: TfmSaleShot
  Left = 0
  Top = 0
  Caption = #1057#1085#1080#1084#1082#1080' '#1087#1088#1086#1076#1072#1078
  ClientHeight = 201
  ClientWidth = 447
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
    Top = 0
    Width = 447
    Height = 57
    Align = alTop
    TabOrder = 0
    object edtBaseName: TEdit
      Left = 16
      Top = 8
      Width = 417
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 57
    Width = 447
    Height = 144
    Align = alClient
    TabOrder = 1
    object sgSess: TStringGrid
      Left = 1
      Top = 1
      Width = 445
      Height = 142
      Align = alClient
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      TabOrder = 0
      OnClick = sgSessClick
    end
  end
end
