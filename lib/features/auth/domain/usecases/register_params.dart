import '../entities/base_user_data.dart';

class RegisterParams extends BaseUserData {
  final String password;

  const RegisterParams({
    required super.name,
    required super.surname,
    required super.username,
    required super.email,
    required super.phoneNumber,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), 'password': password};
  }
}
