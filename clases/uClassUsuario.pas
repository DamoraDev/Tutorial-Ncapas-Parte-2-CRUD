{
Ejemplo Login usuario Basico:
 -sin encripctacion
 -con control de roles
 DamoraDev 28/11/2024, Rad Studio 11
}
unit uClassUsuario;

interface
uses  System.SysUtils,
      System.Classes;
Type IUsuario = interface
  ['{BBEFDB7F-CE14-4589-9FDB-7B52E3F2A922}']
end;
Type TUsuario = Class(TInterfacedObject,IUsuario)
       Private
           FIdUsuario:string;
           FContrasena:String;
           FActivo:boolean;
           FRol:integer;
       Public
         Property IdUsuario:String read FIdUsuario write FIdUsuario;
         Property Contrasena:String read FContrasena write FContrasena;
         Property Activo:boolean read FActivo write FActivo;
         Property Rol:integer read FRol write FRol;
         Constructor Create;
         Destructor Destroy;Override;
         Procedure Free;
End;

implementation

Procedure TUsuario.Free;
Begin
  if self<>nil then destroy;
End;
Destructor TUsuario.Destroy;
Begin
  inherited Destroy;
End;
Constructor TUsuario.create;
  Begin
    idUsuario:='';
    contrasena:='';
    activo:=true;
    rol:=1;  // no crear el usuario 0 o admin por defecto
  End;
end.
