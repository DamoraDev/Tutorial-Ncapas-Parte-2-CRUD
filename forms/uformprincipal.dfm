object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Formulario Principal Ejemplo Login'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MenuPrincipal
  WindowState = wsMaximized
  OnShow = FormShow
  TextHeight = 15
  object MenuPrincipal: TMainMenu
    Left = 520
    Top = 32
    object menu_Acciones: TMenuItem
      Caption = '&Acciones'
      object menu_LoginUsuario: TMenuItem
        Caption = '&Login Usuario'
        ShortCut = 16460
        OnClick = menu_LoginUsuarioClick
      end
      object menu_Cerrar: TMenuItem
        Caption = '&Cerrar'
        ShortCut = 16472
        OnClick = menu_CerrarClick
      end
    end
    object menu_Usuarios: TMenuItem
      Caption = 'Usuarios'
      Enabled = False
      object menu_CambioContrasena: TMenuItem
        Caption = 'Cambio Contrase'#241'a'
        ShortCut = 16451
        OnClick = menu_CambioContrasenaClick
      end
      object menu_GestionUsuarios: TMenuItem
        Caption = 'Gestion De Usuarios'
        ShortCut = 16455
        OnClick = menu_GestionUsuariosClick
      end
    end
    object menu_ayuda: TMenuItem
      Caption = '&Ayuda'
    end
  end
end
