import 'package:dio/dio.dart';
import 'package:srt_app/core/constants/api_endpoints.dart';
import 'package:srt_app/features/utils/RemoteDataSourceBase.dart';
import 'package:srt_app/core/errors/exceptions.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/register_params.dart';

class AuthRemoteDataSource extends RemoteDataSourceBase {
  AuthRemoteDataSource(Dio dio) : super(dio);

  Future<User> login(String email, String password) async {
    final response = await safeRequest(() => dio.post(
      ApiEndpoints.login,
      data: {'User': email, 'Password': password},
    ));
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    }
    throw ServerException('Login failed: ${response.statusCode}');
  }

  Future<User> register(RegisterParams params) async {
    final response = await safeRequest(() => dio.post(
      ApiEndpoints.register,
      data: {
        'Nombres': params.nombre,
        'Apellidos': params.apellido,
        'Usuario': params.usuario,
        'Contrasena': params.password,
        'Correo': params.correo,
        'Telefono': params.telefono,
      },
    ));
    if (response.statusCode == 201) {
      return User.fromJson(response.data);
    }
    throw ServerException('Registro fallido: ${response.statusCode}');
  }
}
