{
Ejemplo Login usuario Basico:
 -sin encripctacion
 -con control de roles
 DamoraDev 28/11/2024, Rad Studio 11
}
unit logica;

interface
 uses System.SysUtils,
      data.Win.ADODB,
      data.DB,
      vcl.Dialogs,
      system.hash,
      Vcl.ExtCtrls,
      vcl.Controls,
      vcl.StdCtrls,
      uClassUsuario;

function Loginv2(IdUsuario: string; contrasena: string): boolean;
Function NuevoUsuario(IdUsuario:String;Contrasena:string;Rol:integer;activo:boolean):boolean;
Function ModificarUsuario(IdUsuario:String;Contrasena:string;Rol:integer;activo:boolean):boolean;
Function CambioContrasena(IDUsuario:String;ContrasenaActual:string;ContrasenaNueva:string):boolean;
Function EliminarUsuario(IdUsuario:string):boolean;
Function Encriptar(const APassword: string): string;   //SHA256
Function BuscarUsuario(IdUsuario:string):TdataSource;
Procedure ReiniciarCamposGrupo(grupo:TGroupBox); //groupbox
Function VerificarCamposGrupo(grupo:TGroupBox):integer ;//groupbox
procedure ConfigurarProveedorConexion(BD: string);


{const
   mrNone=0
   mrOk=1;
   mrCancel=2 ;
   mrAbort=3;
   mrRetry=4;
   mrIgnore=5 ;
   mrYes=6 ;
   mrNo=7;
   mrAll=8;
   mrNoToAll=9;
   mrYesToAll=10;  }
const mrYes=6;
      colorBlanco=$ffffff;
      colorVerde=$8bfa7a;
      ColorRojo= $0000ff;
      usuarioMySQL='miusuario';
      contrasenaMySQL='micontraseña';
      conexionMSAcces=
      'Provider=Microsoft.Jet.OLEDB.4.0;' +
      'Data Source=dbejemplo.mdb;';
      conexionMySQL=
      'Provider=MSDASQL.1;'+
      'Password='+contrasenaMySQL+';+'+
      'Persist Security Info=True;' +
      'User ID='+usuarioMySQL+';' +
      'Data Source=MySQL32b;' +  // debe estar configurado el conector.
      'Extended Properties="DSN=MySQL32b;UID='+usuarioMySQL+';PWD='+contrasenaMySQL+';"' ;

Var UsuarioGlobal:Tusuario;
    conGlobal:TADOConnection;
    Consulta:string;
    tipoconexion:byte;
    ProveedorConexion: TFunc<string>;

implementation

//Configurar conexiones
procedure ConfigurarProveedorConexion(BD: string);
begin
  if BD = 'MySQL' then
    ProveedorConexion := function: string
      begin
        Result := ConexionMySQL;
      end
  else if BD = 'MSAccess' then
    ProveedorConexion := function: string
      begin
        Result := ConexionMSAcces;
      end
  else
    raise Exception.Create('Base de datos no soportada: ' + BD);
end;

Function CambioContrasena(IDUsuario:String;ContrasenaActual:string;ContrasenaNueva:string):boolean;
var cSQL:TADOQuery;
    con:TADOconnection;
Begin
    contrasenaactual:=encriptar(contrasenaactual);
    contrasenanueva:=encriptar(contrasenanueva);
    result:=false;
    con:=TADOConnection.Create(nil);
    con.ConnectionString:= ProveedorConexion();
    con.LoginPrompt:=false;
    consulta:=
    'UPDATE Usuarios ' +
    'SET Contrasena = :ContrasenaNueva ' +
    'WHERE Contrasena = :ContrasenaActual AND IDUsuario = :IDUsuario ;';
    cSQL:=TADOQuery.Create(nil);
    cSQL.Close;
    cSQL.Connection:=con;
    cSQL.SQL.clear;
    cSQL.SQL.Text:=consulta;
    cSQL.Parameters.ParamByName('IdUsuario').Value:=IDUsuario;
    cSQL.Parameters.ParamByName('ContrasenaActual').Value:=ContrasenaActual;
    cSQL.Parameters.ParamByName('ContrasenaNueva').Value:=ContrasenaNueva;
    try
      con.Connected:=true;
      cSQL.ExecSQL;
      if cSQL.RowsAffected>0 then result:=true;

    finally
      cSQL.Free;
      con.Free;
    end;
End;
//fin prueba
Function VerificarCamposGrupo(grupo:TGroupBox):integer; //groupbox
var i,errores:integer;
    control:Tcontrol;
    uactivo:boolean;
Begin
    errores:=0;
    uactivo:=true; // pode defecto suponemos que el usuario esta activado.
    for i := grupo.ControlCount -1 downto 0 do
       begin
          Control:=grupo.Controls[i];

          if Control is TLabeledEdit then
              Begin
                if TlabeledEdit(Control).Text ='' then
                    Begin
                       errores:=errores+1;
                       TlabeledEdit(Control).Color :=colorRojo;
                    End
                else
                    Begin
                       TlabeledEdit(Control).Color :=colorVerde;
                    End;

              End;
          if Control is TCheckbox then
               begin
                  if Tcheckbox(control).Checked=false then uactivo:=false else uactivo:=true;
               end;
       end;
    if uactivo=false then ShowMessage('Revisa la activación del usuario, esta desactivado.');
    if errores>0 then  ShowMessage(' Tienes '+IntToStr(errores)+' campos sin rellenar. Revisarlos');
    result:=errores;
End;
Procedure ReiniciarCamposGrupo(grupo:TGroupBox); // groupbox
var i:integer;
    control:Tcontrol;
Begin
      for i := grupo.ControlCount -1 downto 0 do
       begin
          Control:=grupo.Controls[i];
          if Control is TLabeledEdit then
              Begin
                TlabeledEdit(Control).Text:='';
                TlabeledEdit(Control).Color :=colorBlanco;
              End;
       end;
End;
Function BuscarUsuario(IdUsuario:string):TDataSource;
var cSQL:TADOQuery;
    DS:TDATASource;
Begin
    consulta:='SELECT IdUsuario,Contrasena,Rol,Activo FROM Usuarios WHERE idUsuario ='+
    QuotedStr(IdUsuario);
    DS:=TDataSource.Create(nil);
    cSQL:=TADOQuery.Create(nil);
    DS.DataSet:=cSQL;
    cSQL.Close;
    cSQL.Connection:=conGlobal;
    cSQL.SQL.Clear;
    cSQL.SQL.Text:=consulta;
    try
      cSQL.Open;
    finally
       result:=DS;
    end;
    if cSQL.Eof=true then ShowMessage('Usuario no encontrado');
   // cSQL.Free;   si se liberra se pierden los datos
   // vamos a cambiar el dbgrid por un stringgrid.
End;

function Encriptar(const APassword: string): string;
var
  SHA256: THashSHA2;
begin
  try
      SHA256 := THashSHA2.Create;
  finally
      Result := SHA256.GetHashString(APassword);
  end;
end;

Function EliminarUsuario(IdUsuario:string):Boolean;
var cSQL:TADOQuery;
    con:TADOConnection;
Begin
    // eliminar usuario
    //DELETE FROM Usuarios WHERE IDUsuario = :IDUsuario AND IDUsuario <> 'admin';
    consulta:='';
    Consulta:='Delete From Usuarios WHERE IdUsuario='+QuotedStr(IdUsuario);
    if MessageDLG ('¿ Esta seguro de Eliminar el usuario :'+IdUsuario+' ?',
       mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
           begin
              con:=TADOConnection.Create(nil);
              con.ConnectionString:=ProveedorConexion();
              cSQL:= TADOQuery.Create(nil);
              csql.Close;
              csql.Connection:=con;
              csql.SQL.Clear;
              csql.SQL.Text:=consulta;
              try
                con.Connected:=true;
                csql.ExecSQL; // no devuelve registros, no se puede usar open
              finally
                showMessage('Usuario '+IdUsuario+' borrado');
                csql.Free;
                con.Free;
                result:=true;
              end;
           end else result:=false;
End;

Function ModificarUsuario(IdUsuario:String;Contrasena:string;Rol:integer;Activo:boolean):boolean;
var cSQL: TADOQuery;
    con: TADOConnection;
Begin
  Result := False;
  // Validar que no se modifique el usuario admin
  if IdUsuario = 'admin' then
  begin
    ShowMessage('El usuario "admin" no puede ser modificado.');
    Exit;
  end;

  con := TADOConnection.Create(nil);
  con.ConnectionString:=ProveedorConexion();
  con.LoginPrompt := false;
  cSQL := TADOQuery.Create(nil);
  cSQL.Close;
    // Asignar parámetros
  try
    cSQL.Connection := con;

    // MySQL trabaja con bit en lugar de true/false 1/0  hay que modificar activo.
    if con.ConnectionString = conexionMySQL then
          begin
             if activo=true then
                 Begin
                   consulta :=
                    'UPDATE Usuarios ' +
                    'SET  Rol = :NuevoRol, Activo = 1 ' +   // solo se puede modificar el rol y el activo
                    'WHERE IdUsuario = :IdUsuarioActual AND Contrasena = :ContrasenaActual';
                 End
             else
                Begin
                   consulta :=
                    'UPDATE Usuarios ' +      // solo se puede modificar el rol y el activo
                    'SET  Rol = :NuevoRol, Activo = 0 ' +
                    'WHERE IdUsuario = :IdUsuarioActual AND Contrasena = :ContrasenaActual';
                End;
             csql.SQL.Clear;
             cSQL.SQL.Text:=consulta;
             cSQL.Parameters.ParamByName('ContrasenaActual').Value:= encriptar(contrasena);
             cSQL.Parameters.ParamByName('IdUsuarioActual').Value:= IdUsuario;
             cSQL.Parameters.ParamByName('NuevoRol').Value:=rol;

          end ;
    if con.ConnectionString = conexionMSAcces then
          Begin
             consulta :=
              'UPDATE Usuarios ' +
              'SET  Rol = :NuevoRol, Activo = :NuevoActivo ' +    // solo se puede modificar el rol y el activo
              'WHERE IdUsuario = :IdUsuarioActual AND Contrasena = :ContrasenaActual';
              csql.SQL.Clear;
              csql.SQL.Text:=consulta;
              cSQL.Parameters.ParamByName('ContrasenaActual').Value:= encriptar(contrasena);
              cSQL.Parameters.ParamByName('IdUsuarioActual').Value:= IdUsuario;
              cSQL.Parameters.ParamByName('NuevoRol').Value:=rol;
              cSQL.Parameters.ParamByName('NuevoActivo').Value:=Activo;
          End;
    // Ejecutar consulta
    con.Connected:=true;
    cSQL.ExecSQL;
    // Comprobar si se afectaron filas
    Result := cSQL.RowsAffected > 0;
    if not Result then
      ShowMessage('El usuario no pudo ser modificado. Verifica los datos ingresados.');
  finally
    cSQL.Free;
    con.Free;
  end;
End;

function NuevoUsuario(IdUsuario: String; Contrasena: String; Rol: Integer; Activo: Boolean): Boolean;
var CSQL: TADOQuery;
    con: TADOConnection;
begin
  Result := False; // Inicializamos el resultado como False en caso de fallo
  CSQL := TADOQuery.Create(nil);
  con := TADOConnection.Create(nil);
  con.ConnectionString:=ProveedorConexion();
  con.LoginPrompt := false;
  cSQL.Close;
  cSQL.SQL.Clear;
  try
    // Consulta de alta de nuevo usuario con parámetros para evitar inyecciones SQL
    CSQL.Connection := con;

    if Proveedorconexion()=conexionMySQL then  // comprobamos si estamos en local ( bool ) o en servidor(bit)
          begin
             if activo=true then
                begin
                  cSQL.SQL.Clear;
                  CSQL.SQL.Text := 'INSERT INTO Usuarios (IdUsuario, Contrasena, Rol, Activo) ' +
                     'VALUES (:nuevousuario, :nuevacontrasena, :nuevorol, 1)'; // valor en bit
                end
             else
                Begin
                  cSQL.SQL.Clear;
                  CSQL.SQL.Text := 'INSERT INTO Usuarios (IdUsuario, Contrasena, Rol, Activo) ' +
                     'VALUES (:nuevousuario, :nuevacontrasena, :nuevorol, 0)'; // valor en bit
                End;
                 // Asignación de parámetros
             CSQL.Parameters.ParamByName('nuevousuario').Value := IdUsuario;
             CSQL.Parameters.ParamByName('nuevacontrasena').Value := encriptar(Contrasena);
             CSQL.Parameters.ParamByName('nuevorol').Value := Rol;

          end ;
    if Proveedorconexion() = conexionMSAcces then
          Begin
           cSQL.SQL.Clear;
           CSQL.SQL.Text := 'INSERT INTO Usuarios (IdUsuario, Contrasena, Rol, Activo) ' +
                     'VALUES (:nuevousuario, :nuevacontrasena, :nuevorol, :nuevoactivo)';
              // Asignación de parámetros
            CSQL.Parameters.ParamByName('nuevousuario').Value := IdUsuario;
            CSQL.Parameters.ParamByName('nuevacontrasena').Value := encriptar(Contrasena);
            CSQL.Parameters.ParamByName('nuevorol').Value := Rol;
            cSQL.Parameters.ParamByName('NuevoActivo').Value := Activo;

          End;
    // Ejecutamos la consulta
    con.Connected:=true;
    CSQL.ExecSQL;
    // Verificamos si se afectaron filas (insertado correctamente)
    if CSQL.RowsAffected > 0 then
      Result := True;  // Retornamos True si la inserción fue exitosa
  except
    on E: Exception do
    begin
      // Capturamos cualquier error durante la ejecución
      ShowMessage('Error al crear el usuario: ' + E.Message);
      Result := False;  // Retornamos False si hubo un error
    end;
  end;
  cSQL.Free;
  con.Free;
end;

// version 2 de login
function Loginv2(IdUsuario: string; contrasena: string): boolean;
var cSQL: TADOQuery;
    con : TADOConnection;
begin
  Result := False;
   // la liberación causa Acces Violation
  //if Assigned(usuarioGlobal) then FreeAndNil(usuarioGlobal); //opcion en comun con GPT4
  try
    cSQL := TADOQuery.Create(nil);
    con := TADOConnection.Create(nil);
    con.ConnectionString := ProveedorConexion();
    con.LoginPrompt := false;
    try
      cSQL.Close;
      cSQL.Connection := con;
      cSQL.SQL.Clear;
      cSQL.SQL.Text := 'SELECT IdUsuario, Contrasena, Activo, Rol ' +
        'FROM usuarios WHERE IdUsuario = ' + QuotedStr(IdUsuario) +
        ' AND Contrasena = ' + QuotedStr(Encriptar(Contrasena)) + ' AND Activo = True';
      con.Connected:=true;
      cSQL.Open;
      if not cSQL.Eof then
      begin
        // Configura los datos del usuario global
        // codigo propio , posteriormente
        //optimizado  con GPT4
        UsuarioGlobal.IdUsuario := cSQL.FieldByName('IdUsuario').AsString;
        UsuarioGlobal.Contrasena := cSQL.FieldByName('Contrasena').AsString;
        UsuarioGlobal.Activo := cSQL.FieldByName('Activo').AsBoolean;
        UsuarioGlobal.Rol := cSQL.FieldByName('Rol').AsInteger;
        Result := True;
      end;
    finally
      cSQL.Free;
      con.Free;
    end;
  finally
    // GPT4 elimito UsuarioGlobal.Free , eso impedia poder utilizar la variable global
  end;
end;
// fin version 2

// la inicializacion y finalizacion las indico GPT4 para que no de errores y se libere bien de memoria
initialization
  ConfigurarProveedorConexion('MSAccess');
  UsuarioGlobal := TUsuario.Create;
  ConGlobal:= TADOCOnnection.Create(nil);
  ConGlobal.ConnectionString:= ProveedorConexion();
  try
    conGlobal.Connected:=true;
  Except
    on E: Exception do
    ShowMessage('Error de Conexion'+ E.Message);
  end;
  conGlobal.LoginPrompt := false;
finalization
  if Assigned(ConGlobal) and ConGlobal.Connected then
  begin
    try
      ConGlobal.Close;
    except
      on E: Exception do
        // Maneja cualquier error al cerrar la conexión (opcionalmente, registra el error).
        ShowMessage('Error cerrando la conexión: ' + E.Message);
    end;
  end;
  FreeAndNil(ConGlobal);
  FreeAndNil(UsuarioGlobal);
  ProveedorConexion := nil;
end.
