import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final token = json['data']?['token'] ?? '';
    return UserModel(token: token);
  }
}
