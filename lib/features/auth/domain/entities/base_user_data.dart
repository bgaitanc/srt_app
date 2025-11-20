class BaseUserData {
  final String nombres;
  final String apellidos;
  final String usuario;
  final String correo;
  final String telefono;

  const BaseUserData({
    required this.nombres,
    required this.apellidos,
    required this.usuario,
    required this.correo,
    required this.telefono,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombres': nombres,
      'apellidos': apellidos,
      'usuario': usuario,
      'correo': correo,
      'telefono': telefono,
    };
  }
}
