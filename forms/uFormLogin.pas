{
Ejemplo Login usuario Basico:
 -sin encripctacion
 -con control de roles
 DamoraDev 28/11/2024, Rad Studio 11
}
unit uFormLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,ShellAPI,
  Vcl.Imaging.pngimage;

type
  TFormLogin = class(TForm)
    contenedor_camposLogin: TPanel;
    usuario_contrasena: TLabeledEdit;
    usuario_id: TLabeledEdit;
    btn_Login: TButton;
    imagen_login: TImage;
    atribucion_imagen: TLinkLabel;
    procedure atribucion_imagenClick(Sender: TObject);
    procedure btn_LoginClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.dfm}
uses logica, uformprincipal;

procedure TFormLogin.atribucion_imagenClick(Sender: TObject);
var url:Pwidechar  ;
begin
 url:='https://es.vecteezy.com/png-gratis/login';
 ShellExecute(handle,'open', url, nil, nil, SW_NORMAL);
 end;

procedure TFormLogin.btn_LoginClick(Sender: TObject);
begin
  if Loginv2(usuario_id.text,usuario_contrasena.text)= true then
     Begin
         ShowMessage('Bienvenido '+usuario_id.Text);
         //habilitar/deshabilitar menus del formppal atendiendo al rol
         if UsuarioGlobal.Rol=0 then
           Begin
             FormPrincipal.menu_Usuarios.Enabled:=true;
             FormPrincipal.menu_CambioContrasena.Enabled:=true;
             FormPrincipal.menu_GestionUsuarios.Enabled:=true;
             FormPrincipal.menu_LoginUsuario.Enabled:=false; // ya ha iniciado sesion
           End
         else
           Begin
             FormPrincipal.menu_Usuarios.Enabled:=true;
             FormPrincipal.menu_CambioContrasena.Enabled:=true;
             FormPrincipal.menu_GestionUsuarios.Enabled:=false;
             FormPrincipal.menu_LoginUsuario.Enabled:=false;// ya ha iniciado sesion
           End;
         close;
     end
      else
     begin
       ShowMessage('Error de usuario y Contrasena') ;
     end;
end;



procedure TFormLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caFree;
end;

end.
