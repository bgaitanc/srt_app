class UpdateProfileParams {
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;

  const UpdateProfileParams({
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
