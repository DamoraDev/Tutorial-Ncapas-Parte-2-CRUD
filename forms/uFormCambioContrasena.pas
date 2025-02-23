unit uFormCambioContrasena;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask;

type
  TFormCambioContrasena = class(TForm)
    grupo_datosusuario: TGroupBox;
    usuario_contrasenaNueva2: TLabeledEdit;
    usuario_contrasenaNueva1: TLabeledEdit;
    usuario_contrasenaActual: TLabeledEdit;
    usuario_IdUsuario: TLabeledEdit;
    Panel1: TPanel;
    btn_Cerrar: TButton;
    btn_CambiarContrasena: TButton;
    procedure btn_CerrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_CambiarContrasenaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCambioContrasena: TFormCambioContrasena;

implementation

{$R *.dfm}
uses logica,uformprincipal;

procedure TFormCambioContrasena.btn_CambiarContrasenaClick(Sender: TObject);
begin
  if VerificarCamposGrupo(grupo_datosusuario)=0  then
       Begin
        if usuario_contrasenanueva1.Text=usuario_contrasenanueva2.Text then
                      Begin
                        if   CambioContrasena(Usuario_IdUsuario.Text,usuario_contrasenaActual.Text,usuario_contrasenanueva2.Text)= true
                        then
                          begin
                             ShowMessage('Contraseña modificada correctamente.');
                             ReiniciarCamposGrupo(grupo_datosusuario);
                             ShowMessage('Debes cerrar la aplicación para poder iniciar sesión con la nueva contraseña.');

                          end
                        else ShowMessage('No se pudo modificar la contraseña. Verifique los datos ingresados.');
                      End
                      else
                      ShowMessage('Las contraseñas no coinciden');
       End;

end;

procedure TFormCambioContrasena.btn_CerrarClick(Sender: TObject);
begin
   close;
end;

procedure TFormCambioContrasena.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= CAFree;
end;

end.
