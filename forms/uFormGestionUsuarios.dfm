object FormGestionUsuarios: TFormGestionUsuarios
  Left = 0
  Top = 0
  Caption = ' Gestion de Usuarios'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = [fsBold]
  FormStyle = fsMDIChild
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object contenedor_botones: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 105
    Height = 435
    Align = alLeft
    TabOrder = 0
    object btn_usuarioEliminar: TButton
      AlignWithMargins = True
      Left = 4
      Top = 176
      Width = 97
      Height = 37
      Align = alTop
      Caption = 'Eliminar'
      Enabled = False
      TabOrder = 0
      OnClick = btn_usuarioEliminarClick
    end
    object btn_usuarioDeshacer: TButton
      AlignWithMargins = True
      Left = 4
      Top = 133
      Width = 97
      Height = 37
      Align = alTop
      Caption = 'Deshacer'
      TabOrder = 1
      OnClick = btn_usuarioDeshacerClick
    end
    object btn_usuarioModificar: TButton
      AlignWithMargins = True
      Left = 4
      Top = 90
      Width = 97
      Height = 37
      Align = alTop
      Caption = 'Modificar'
      Enabled = False
      TabOrder = 2
      OnClick = btn_usuarioModificarClick
    end
    object btn_usuarioNuevo: TButton
      AlignWithMargins = True
      Left = 4
      Top = 47
      Width = 97
      Height = 37
      Align = alTop
      Caption = 'Nuevo'
      TabOrder = 3
      OnClick = btn_usuarioNuevoClick
    end
    object btn_usuarioBuscar: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 97
      Height = 37
      Align = alTop
      Caption = 'Buscar'
      TabOrder = 4
      OnClick = btn_usuarioBuscarClick
    end
  end
  object grupo_datosusuario: TGroupBox
    AlignWithMargins = True
    Left = 114
    Top = 3
    Width = 218
    Height = 435
    Align = alLeft
    Caption = 'Datos del Usuario'
    TabOrder = 1
    object usuario_contrasena2: TLabeledEdit
      AlignWithMargins = True
      Left = 7
      Top = 133
      Width = 204
      Height = 23
      Margins.Left = 5
      Margins.Top = 20
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      EditLabel.Width = 104
      EditLabel.Height = 15
      EditLabel.Caption = 'RepetirContrasena'
      Enabled = False
      MaxLength = 8
      PasswordChar = '#'
      TabOrder = 0
      Text = ''
    end
    object usuario_contrasena1: TLabeledEdit
      AlignWithMargins = True
      Left = 7
      Top = 85
      Width = 204
      Height = 23
      Margins.Left = 5
      Margins.Top = 20
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      EditLabel.Width = 62
      EditLabel.Height = 15
      EditLabel.Caption = 'Contrasena'
      Enabled = False
      MaxLength = 8
      PasswordChar = '#'
      TabOrder = 1
      Text = ''
    end
    object usuario_idusuario: TLabeledEdit
      AlignWithMargins = True
      Left = 7
      Top = 37
      Width = 204
      Height = 23
      Margins.Left = 5
      Margins.Top = 20
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      EditLabel.Width = 53
      EditLabel.Height = 15
      EditLabel.Caption = 'IdUsuario'
      Enabled = False
      MaxLength = 10
      TabOrder = 2
      Text = ''
    end
    object usuario_rol: TComboBox
      AlignWithMargins = True
      Left = 7
      Top = 171
      Width = 204
      Height = 23
      Margins.Left = 5
      Margins.Top = 10
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Enabled = False
      TabOrder = 3
      Text = 'Selecci'#243'n de Rol'
      Items.Strings = (
        'Administrador'
        'Desarrollador'
        'Administrativo')
    end
    object usuario_activo: TCheckBox
      AlignWithMargins = True
      Left = 7
      Top = 209
      Width = 204
      Height = 17
      Margins.Left = 5
      Margins.Top = 10
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Activo'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 4
    end
    object btn_guardarusuario: TButton
      AlignWithMargins = True
      Left = 32
      Top = 246
      Width = 154
      Height = 41
      Margins.Left = 30
      Margins.Top = 15
      Margins.Right = 30
      Margins.Bottom = 15
      Align = alTop
      Caption = 'Guardar'
      Enabled = False
      TabOrder = 5
      OnClick = btn_guardarusuarioClick
    end
  end
  object contenedor_busqueda: TGroupBox
    AlignWithMargins = True
    Left = 338
    Top = 3
    Width = 283
    Height = 435
    Align = alClient
    Caption = 'Busqueda de Usuarios'
    TabOrder = 2
    Visible = False
    object Panel_busqueda: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 273
      Height = 67
      Align = alTop
      TabOrder = 0
      object usuario_busqueda: TLabeledEdit
        AlignWithMargins = True
        Left = 4
        Top = 26
        Width = 173
        Height = 25
        Margins.Top = 25
        Margins.Bottom = 15
        Align = alLeft
        EditLabel.Width = 97
        EditLabel.Height = 15
        EditLabel.Caption = 'Usuario a Buscar :'
        TabOrder = 0
        Text = ''
        ExplicitHeight = 23
      end
      object btn_buscarIdUsuario: TButton
        Left = 183
        Top = 25
        Width = 75
        Height = 25
        Caption = 'Buscar'
        TabOrder = 1
        OnClick = btn_buscarIdUsuarioClick
      end
    end
    object dbg_buscarUsuarios: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 93
      Width = 273
      Height = 337
      Align = alClient
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      OnCellClick = dbg_buscarUsuariosCellClick
    end
  end
end
