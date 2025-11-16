import 'package:dio/dio.dart';
import 'package:srt_app/core/constants/api_endpoints.dart';
import 'package:srt_app/core/errors/exceptions.dart';
import 'package:srt_app/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        ApiEndpoints.login,
        data: {'User': email, 'Password': password},
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
      throw ServerException('Login failed: ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'DioException');
    }
  }

  Future<UserModel> register({
    required String nombre,
    required String apellido,
    required String usuario,
    required String correo,
    required String telefono,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.register,
        data: {
          'Nombres': nombre,
          'Apellidos': apellido,
          'Usuario': usuario,
          'Contrasena': password,
          'Correo': correo,
          'Telefono': telefono,
        },
      );
      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      }
      throw ServerException('Registro Exitoso: ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'DioException');
    }
  }
}
