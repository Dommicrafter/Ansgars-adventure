object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Select Load  Profile!'
  ClientHeight = 446
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 48
    Top = 32
    Width = 609
    Height = 97
    Caption = 'Empty Save Place'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 48
    Top = 160
    Width = 609
    Height = 97
    Caption = 'Empty Save Place'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 48
    Top = 280
    Width = 609
    Height = 97
    Caption = 'Empty Save Place'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 640
    Top = 400
    Width = 97
    Height = 38
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button4Click
  end
end
