abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
}

class RegisterRequested extends AuthEvent {
  final String nombre;
  final String apellido;
  final String usuario;
  final String correo;
  final String telefono;
  final String password;

  RegisterRequested({
    required this.nombre,
    required this.apellido,
    required this.usuario,
    required this.correo,
    required this.telefono,
    required this.password,
  });
}
