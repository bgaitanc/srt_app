import '../entities/base_user_data.dart';

class RegisterParams extends BaseUserData {
  final String password;

  const RegisterParams({
    required super.nombres,
    required super.apellidos,
    required super.usuario,
    required super.correo,
    required super.telefono,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'password': password,
    };
  }
}
