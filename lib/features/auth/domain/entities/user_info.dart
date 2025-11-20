import 'base_user_data.dart';
import '../../../../core/utils/json_parser_helper.dart';

class UserInfo extends BaseUserData {
  final int usuarioId;

  const UserInfo({
    required this.usuarioId,
    required super.nombres,
    required super.apellidos,
    required super.usuario,
    required super.correo,
    required super.telefono,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final data = JsonParserHelper.getNestedMap(json, 'data');
    return UserInfo(
      usuarioId: JsonParserHelper.getValueOrDefault(data, 'usuarioId', 0),
      nombres: JsonParserHelper.getValueOrDefault(data, 'nombres', ''),
      apellidos: JsonParserHelper.getValueOrDefault(data, 'apellidos', ''),
      usuario: JsonParserHelper.getValueOrDefault(data, 'usuario', ''),
      correo: JsonParserHelper.getValueOrDefault(data, 'correo', ''),
      telefono: JsonParserHelper.getValueOrDefault(data, 'telefono', ''),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
      ...super.toJson(),
    };
  }
}
