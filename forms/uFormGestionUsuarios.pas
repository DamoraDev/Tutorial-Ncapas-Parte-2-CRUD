unit uFormGestionUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Mask;

type
  TFormGestionUsuarios = class(TForm)
    contenedor_botones: TPanel;
    btn_usuarioEliminar: TButton;
    btn_usuarioDeshacer: TButton;
    btn_usuarioModificar: TButton;
    btn_usuarioNuevo: TButton;
    btn_usuarioBuscar: TButton;
    grupo_datosusuario: TGroupBox;
    contenedor_busqueda: TGroupBox;
    Panel_busqueda: TPanel;
    usuario_busqueda: TLabeledEdit;
    dbg_buscarUsuarios: TDBGrid;
    usuario_contrasena2: TLabeledEdit;
    usuario_contrasena1: TLabeledEdit;
    usuario_idusuario: TLabeledEdit;
    usuario_rol: TComboBox;
    usuario_activo: TCheckBox;
    btn_guardarusuario: TButton;
    btn_buscarIdUsuario: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_guardarusuarioClick(Sender: TObject);
    procedure btn_usuarioDeshacerClick(Sender: TObject);
    procedure btn_usuarioBuscarClick(Sender: TObject);
    procedure btn_usuarioNuevoClick(Sender: TObject);
    procedure btn_buscarIdUsuarioClick(Sender: TObject);
    procedure dbg_buscarUsuariosCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure btn_usuarioModificarClick(Sender: TObject);
    procedure btn_usuarioEliminarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGestionUsuarios: TFormGestionUsuarios;
  esnuevo:boolean;

implementation
uses logica;
{$R *.dfm}

procedure TFormGestionUsuarios.btn_buscarIdUsuarioClick(Sender: TObject);
begin
  dbg_buscarusuarios.DataSource:=BuscarUsuario(usuario_busqueda.Text);
  dbg_buscarusuarios.Columns[0].Width:=50;
  dbg_buscarusuarios.Columns[1].Width:=350;
  dbg_buscarusuarios.Columns[2].Width:=50;
  dbg_buscarusuarios.Columns[3].Width:=50;
end;

procedure TFormGestionUsuarios.btn_guardarusuarioClick(Sender: TObject);

begin
  if (VerificarCamposGrupo(grupo_datosusuario)=0 ) AND (btn_usuarioModificar.Enabled=false)
      then
      begin
         if usuario_contrasena1.text=usuario_contrasena2.Text then
            Begin
              if NuevoUsuario(usuario_IdUsuario.Text,
               usuario_contrasena1.Text,
               usuario_rol.ItemIndex,
               usuario_activo.Checked
               ) = true
              then
                ShowMessage('Nuevo usuario Guardado')
              else
                ShowMessage('Error al guardar el Nuevo Usuario.');

            End else ShowMessage('Las contraseñas no coinciden');

      end;
  if (VerificarCamposGrupo(grupo_datosusuario)=0 ) AND (btn_usuarioNuevo.Enabled=false)
      then
      begin
         if usuario_contrasena1.Text=usuario_contrasena2.Text then
              begin
                if encriptar(usuario_contrasena1.Text)=dbg_buscarusuarios.Fields[1].AsString then
                        Begin
                          ModificarUsuario(usuario_IdUsuario.Text,
                                          usuario_contrasena1.Text,
                                          usuario_rol.ItemIndex,
                                          usuario_activo.Checked);
                          ShowMessage('Usuario Modificado');
                        End else ShowMessage('No esta autorizado a modificar el usuario. Escriba la contraseña adecuada.');
              end;

      end;
end;

procedure TFormGestionUsuarios.btn_usuarioBuscarClick(Sender: TObject);
begin
  contenedor_busqueda.Visible:=true;
end;

procedure TFormGestionUsuarios.btn_usuarioDeshacerClick(Sender: TObject);
begin
  ReiniciarCamposGrupo(grupo_datosusuario);
  contenedor_busqueda.Visible:=false;
  btn_usuarioNuevo.Enabled:=true;
  btn_usuarioModificar.Enabled:=false;
  btn_usuarioEliminar.Enabled:=false;
  btn_guardarUsuario.Enabled:=false;
  usuario_idusuario.Enabled:=false;
  usuario_contrasena1.Enabled:=false;
  usuario_contrasena2.Enabled:=false;
  usuario_activo.Enabled:=false;
  usuario_rol.Enabled:=false;
end;
procedure TFormGestionUsuarios.btn_usuarioEliminarClick(Sender: TObject);
begin
 if EliminarUsuario(usuario_Idusuario.Text)=true then ShowMessage('Usuario Eliminado')
     else
        ShowMessage('Error al borrar el usuario.Verifique que no sea el usuario admin');
end;

procedure TFormGestionUsuarios.btn_usuarioModificarClick(Sender: TObject);
begin
  esnuevo:=false;
  usuario_idusuario.Enabled:=false;
 // las contraseñas no se modifican aqui se comprueba que sea el usuario legitimo
  usuario_activo.Enabled:=true;
  usuario_rol.Enabled:=true;
  if usuario_IdUsuario.Text='admin' then
    begin
      usuario_idusuario.Enabled:=false;
      usuario_activo.Enabled:=false;
      usuario_rol.Enabled:=false;
      usuario_contrasena1.Enabled:=false;
      usuario_contrasena2.Enabled:=false;
      showMessage('El usuario administrador no se puede modificar.');
    end
  else
    begin
      usuario_idusuario.Enabled:=true;
      usuario_activo.Enabled:=true;
      usuario_rol.Enabled:=true;
      usuario_contrasena1.Enabled:=true;
      usuario_contrasena2.Enabled:=true;
    end;
  btn_guardarUsuario.Enabled:=true;
end;

procedure TFormGestionUsuarios.btn_usuarioNuevoClick(Sender: TObject);
begin
   contenedor_busqueda.Visible:=false;
   ReiniciarCamposGrupo(grupo_datosusuario);
   esnuevo:=true;
   usuario_idusuario.Enabled:=true;
   usuario_contrasena1.Enabled:=true;
   usuario_contrasena2.Enabled:=true;
   usuario_activo.Enabled:=true;
   usuario_rol.Enabled:=true;
   btn_guardarUsuario.Enabled:=true;
end;

procedure TFormGestionUsuarios.dbg_buscarUsuariosCellClick(Column: TColumn);
begin
    btn_usuarioNuevo.Enabled:=false;
    btn_usuarioModificar.Enabled:=true;
    btn_usuarioEliminar.Enabled:=true;
    usuario_idusuario.text:=dbg_buscarusuarios.Fields[0].AsString;
    usuario_activo.checked:=dbg_buscarusuarios.Fields[3].AsBoolean;
    usuario_rol.Text:=dbg_buscarusuarios.Fields[2].AsString;
    if usuario_idusuario.text='admin' then btn_usuarioEliminar.Enabled:=false;

end;

procedure TFormGestionUsuarios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure TFormGestionUsuarios.FormShow(Sender: TObject);
begin
 esnuevo:=true;
end;

end.
