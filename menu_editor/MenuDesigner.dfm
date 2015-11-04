object fmMenuDesigner: TfmMenuDesigner
  Left = 0
  Top = 0
  Caption = #1050#1086#1085#1089#1090#1088#1091#1082#1090#1086#1088' '#1084#1077#1085#1102
  ClientHeight = 388
  ClientWidth = 826
  Color = clBtnFace
  Constraints.MinWidth = 255
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    826
    388)
  PixelsPerInch = 96
  TextHeight = 12
  object pnlTools: TPanel
    Left = 0
    Top = 0
    Width = 826
    Height = 37
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    object lblPoint: TLabel
      Left = 18
      Top = 12
      Width = 83
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1086#1095#1082#1091':'
    end
    object cbPoint: TComboBox
      Left = 104
      Top = 12
      Width = 109
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbPointChange
    end
    object btnSave: TButton
      Left = 232
      Top = 7
      Width = 97
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 1
      OnClick = btnSaveClick
    end
  end
  object treeMenu: TTreeView
    Left = 0
    Top = 36
    Width = 826
    Height = 352
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight, akBottom]
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Indent = 19
    ParentFont = False
    PopupMenu = pmTree
    TabOrder = 1
    OnCustomDrawItem = treeMenuCustomDrawItem
    OnDblClick = treeMenuDblClick
    OnDragDrop = treeMenuDragDrop
    OnDragOver = treeMenuDragOver
    OnEdited = treeMenuEdited
    OnEditing = treeMenuEditing
    OnMouseUp = treeMenuMouseUp
    Items.NodeData = {
      0302000000260000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      000000000001041C0435043D044E042A0000000000000000000000FFFFFFFFFF
      FFFFFF000000000000000000000000010622043E043204300440044B04}
  end
  object pmTree: TPopupMenu
    AutoPopup = False
    Left = 272
    Top = 112
    object cmiAddSubcategory: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1076#1082#1072#1090#1077#1075#1086#1088#1080#1102
      OnClick = cmiAddSubcategoryClick
    end
    object cmiDeleteCategory: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = cmiDeleteCategoryClick
    end
  end
end
