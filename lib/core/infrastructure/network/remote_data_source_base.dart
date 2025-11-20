import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';

abstract class RemoteDataSourceBase {
  final Dio dio;

  RemoteDataSourceBase(this.dio);

  /// Handle API request with error handling
  Future<T> handleRequest<T>({
    required Future<Response> Function() request,
    required T Function(Map<String, dynamic>) parser,
  }) async {
    try {
      final response = await request();
      return parser(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> safeRequest(Future<Response> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Dio Error');
    }
  }
}