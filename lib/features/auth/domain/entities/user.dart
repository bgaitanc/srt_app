class User {
  final String token;
  User({required this.token});

  static User fromJson(Map<String, dynamic> json) {
    final token = json['data']?['token'] ?? '';
    return User(token: token);
  }
}
