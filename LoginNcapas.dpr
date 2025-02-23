program LoginNcapas;

uses
  Vcl.Forms,
  uClassUsuario in 'clases\uClassUsuario.pas',
  logica in 'logica\logica.pas',
  uformprincipal in 'forms\uformprincipal.pas' {FormPrincipal},
  uFormLogin in 'forms\uFormLogin.pas' {FormLogin},
  uFormCambioContrasena in 'forms\uFormCambioContrasena.pas' {FormCambioContrasena},
  uFormGestionUsuarios in 'forms\uFormGestionUsuarios.pas' {FormGestionUsuarios};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
