import 'dart:io';
import 'package:srt_app/core/constants/api_endpoints.dart';
import 'package:srt_app/core/infrastructure/network/remote_data_source_base.dart';
import 'package:srt_app/core/errors/exceptions.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_info.dart';
import '../../domain/usecases/register_params.dart';
import '../../domain/usecases/update_profile_params.dart';
import '../../../../core/utils/response_helper.dart';

class AuthRemoteDataSource extends RemoteDataSourceBase {
  AuthRemoteDataSource(super.dio);

  Future<User> login(String email, String password) async {
    final response = await safeRequest(() => dio.post(
      ApiEndpoints.login,
      data: {'username': email, 'password': password},
    ));
    if (response.statusCode == HttpStatus.ok) {
      return User.fromJson(response.data);
    }
    throw ServerException('Login failed: ${response.statusCode}');
  }

  Future<User> register(RegisterParams params) async {
    final response = await safeRequest(() => dio.post(
      ApiEndpoints.register,
      data: {
        'name': params.name,
        'surname': params.surname,
        'username': params.username,
        'password': params.password,
        'email': params.email,
        'phoneNumber': params.phoneNumber,
      },
    ));
    if (response.statusCode == HttpStatus.created) {
      return User.fromJson(response.data);
    }
    throw ServerException('Registro fallido: ${response.statusCode}');
  }

  Future<UserInfo> getUserInfo() async {
    final response = await safeRequest(() => dio.get(
      ApiEndpoints.userInfo,
    ));
    
    return ResponseHelper.extractObject<UserInfo>(
      response,
      'data',
      (json) => UserInfo.fromJson({'data': json}),
    );
  }

  Future<UserInfo> updateUserProfile(UpdateProfileParams params) async {
    final response = await safeRequest(() => dio.put(
      ApiEndpoints.updateProfile,
      data: params.toJson(),
    ));
    
    return ResponseHelper.extractObject<UserInfo>(
      response,
      'data',
      (json) => UserInfo.fromJson({'data': json}),
    );
  }
}
