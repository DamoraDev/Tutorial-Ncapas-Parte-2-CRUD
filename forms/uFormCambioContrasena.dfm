object FormCambioContrasena: TFormCambioContrasena
  Left = 477
  Top = 221
  BorderStyle = bsToolWindow
  Caption = 'Cambio de Contrase'#241'a'
  ClientHeight = 249
  ClientWidth = 338
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poDesigned
  Visible = True
  OnClose = FormClose
  TextHeight = 15
  object grupo_datosusuario: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 217
    Height = 243
    Align = alLeft
    Caption = 'Datos del Usuario'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object usuario_contrasenaNueva2: TLabeledEdit
      AlignWithMargins = True
      Left = 5
      Top = 195
      Width = 207
      Height = 23
      Margins.Top = 25
      Align = alTop
      EditLabel.Width = 146
      EditLabel.Height = 15
      EditLabel.Caption = 'Repetir Contrase'#241'a Nueva'
      MaxLength = 8
      PasswordChar = '#'
      TabOrder = 3
      Text = ''
    end
    object usuario_contrasenaNueva1: TLabeledEdit
      AlignWithMargins = True
      Left = 5
      Top = 144
      Width = 207
      Height = 23
      Margins.Top = 25
      Align = alTop
      EditLabel.Width = 101
      EditLabel.Height = 15
      EditLabel.Caption = 'Contrase'#241'a Nueva'
      MaxLength = 8
      PasswordChar = '#'
      TabOrder = 2
      Text = ''
    end
    object usuario_contrasenaActual: TLabeledEdit
      AlignWithMargins = True
      Left = 5
      Top = 93
      Width = 207
      Height = 23
      Margins.Top = 25
      Align = alTop
      EditLabel.Width = 100
      EditLabel.Height = 15
      EditLabel.Caption = 'Contrase'#241'a Actual'
      MaxLength = 8
      PasswordChar = '#'
      TabOrder = 1
      Text = ''
    end
    object usuario_IdUsuario: TLabeledEdit
      AlignWithMargins = True
      Left = 5
      Top = 42
      Width = 207
      Height = 23
      Margins.Top = 25
      Align = alTop
      EditLabel.Width = 42
      EditLabel.Height = 15
      EditLabel.Caption = 'Usuario'
      MaxLength = 10
      TabOrder = 0
      Text = ''
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 226
    Top = 3
    Width = 109
    Height = 243
    Align = alClient
    TabOrder = 1
    object btn_Cerrar: TButton
      Left = 1
      Top = 202
      Width = 107
      Height = 40
      Align = alBottom
      Caption = '&Cerrar'
      TabOrder = 1
      OnClick = btn_CerrarClick
    end
    object btn_CambiarContrasena: TButton
      Left = 1
      Top = 1
      Width = 107
      Height = 40
      Align = alTop
      Caption = 'Guardar Cambios'
      TabOrder = 0
      OnClick = btn_CambiarContrasenaClick
    end
  end
end
