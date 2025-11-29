//TODO renombrar a token o authentication??
class User {
  final String token;
  final String refreshToken;
  final String userId;

  User({required this.token, required this.refreshToken, required this.userId});

  static User fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final token = data['token'] ?? '';
    final refreshToken = data['refreshToken'] ?? '';
    // TODO corregir esto, creo que no es correcto por el userId
    return User(token: token, refreshToken: refreshToken, userId: '');
  }
}
