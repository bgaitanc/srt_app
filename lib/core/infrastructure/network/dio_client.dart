import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient({required this.dio});

  Future<Response> get(String path) async => dio.get(path);
  Future<Response> post(String path, Map<String, dynamic> data) async => dio.post(path, data: data);
}
