unit uformprincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uClassusuario;

type
  TFormPrincipal = class(TForm)
    MenuPrincipal: TMainMenu;
    menu_Acciones: TMenuItem;
    menu_LoginUsuario: TMenuItem;
    menu_Cerrar: TMenuItem;
    menu_Usuarios: TMenuItem;
    menu_CambioContrasena: TMenuItem;
    menu_GestionUsuarios: TMenuItem;
    menu_ayuda: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure menu_CambioContrasenaClick(Sender: TObject);
    procedure menu_LoginUsuarioClick(Sender: TObject);
    procedure menu_GestionUsuariosClick(Sender: TObject);
    procedure menu_CerrarClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;


implementation

{$R *.dfm}
uses logica,uFormCambioContrasena,uFormLogin,uFormGestionUsuarios;

procedure TFormPrincipal.FormShow(Sender: TObject);
var F:TFormLogin;
begin
    F:=TFormLogin.Create(FormPrincipal);
    F.FormStyle:=fsMDIChild;
    F.Show;
//**************Colaborativo con GPT 4 *********************************
if UsuarioGlobal.IdUsuario <> '' then
      Begin
        FormPrincipal.Caption := FormPrincipal.Caption + ' || Usuario : ' +
        UsuarioGlobal.IdUsuario;
        // parte mia
         case UsuarioGlobal.Rol of
                0:Begin
                     menu_gestionusuarios.Visible:=true;
                 End
                else menu_gestionusuarios.Visible:=false;
         end;
      End;

//****** Fin parte de GPT 4 ***************************************
end;

procedure TFormPrincipal.menu_CambioContrasenaClick(Sender: TObject);
var F:TFormCambioContrasena;
begin
   F:=TFormCambioContrasena.Create(FormPrincipal);
   F.FormStyle:=fsMDIChild;
   F.Show;
end;

procedure TFormPrincipal.menu_CerrarClick(Sender: TObject);
begin
   close;
end;

procedure TFormPrincipal.menu_GestionUsuariosClick(Sender: TObject);
var F:TFormGestionUsuarios;
begin
    F:= TFormGestionUsuarios.Create(FormPrincipal);
    F.FormStyle:=fsMDIchild;
    F.Show;
end;

procedure TFormPrincipal.menu_LoginUsuarioClick(Sender: TObject);
var F:TFormLogin;
begin
    F:=TFormLogin.Create(FormPrincipal);
    F.FormStyle:=fsMDIChild;
    F.Show;
end;

end.
