class User {
  final String token;
  final int usuarioId;

  User({required this.token, required this.usuarioId});

  static User fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final token = data['token'] ?? '';
    final usuarioId = data['usuarioId'] ?? 0;
    return User(token: token, usuarioId: usuarioId);
  }
}
