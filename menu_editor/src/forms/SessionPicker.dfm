object fmSessionPicker: TfmSessionPicker
  Left = 0
  Top = 0
  Caption = #1042#1099#1073#1086#1088' '#1089#1077#1089#1089#1080#1080
  ClientHeight = 218
  ClientWidth = 489
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
  object sgSession: TStringGrid
    Left = 0
    Top = 0
    Width = 489
    Height = 218
    Align = alClient
    TabOrder = 0
    OnClick = sgSessionClick
    ExplicitWidth = 320
    ExplicitHeight = 120
  end
end
