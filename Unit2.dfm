object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 600
  ClientWidth = 950
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Courier'
  Font.Style = [fsBold, fsItalic]
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 20
  object Button1: TButton
    Left = 40
    Top = 472
    Width = 225
    Height = 73
    Caption = 'Start Game'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 664
    Top = 472
    Width = 225
    Height = 73
    Caption = 'Impressum'
    TabOrder = 1
  end
  object Button4: TButton
    Left = 360
    Top = 472
    Width = 225
    Height = 73
    Caption = 'Help'
    TabOrder = 2
  end
end
