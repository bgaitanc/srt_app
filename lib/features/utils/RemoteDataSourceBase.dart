import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';

abstract class RemoteDataSourceBase {
  final Dio dio;
  RemoteDataSourceBase(this.dio);

  Future<Response> safeRequest(Future<Response> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Dio Error');
    }
  }
}