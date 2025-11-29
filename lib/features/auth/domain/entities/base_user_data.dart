class BaseUserData {
  final String name;
  final String surname;
  final String username;
  final String email;
  final String phoneNumber;

  const BaseUserData({
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
