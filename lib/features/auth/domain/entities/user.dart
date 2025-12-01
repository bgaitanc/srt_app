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
    final rawUserId = data['userId'] ?? data['id'] ?? '';
    final userId = rawUserId.toString();
    return User(token: token, refreshToken: refreshToken, userId: userId);
  }
}
