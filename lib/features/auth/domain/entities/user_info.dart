import 'base_user_data.dart';
import '../../../../core/utils/json_parser_helper.dart';

class UserInfo extends BaseUserData {
  final String userId;

  const UserInfo({
    required this.userId,
    required super.name,
    required super.surname,
    required super.username,
    required super.email,
    required super.phoneNumber,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final data = JsonParserHelper.getNestedMap(json, 'data');
    return UserInfo(
      userId: JsonParserHelper.getValueOrDefault(data, 'id', ''),
      name: JsonParserHelper.getValueOrDefault(data, 'name', ''),
      surname: JsonParserHelper.getValueOrDefault(data, 'surname', ''),
      username: JsonParserHelper.getValueOrDefault(data, 'username', ''),
      email: JsonParserHelper.getValueOrDefault(data, 'email', ''),
      phoneNumber: JsonParserHelper.getValueOrDefault(data, 'phoneNumber', ''),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'userId': userId, ...super.toJson()};
  }
}
