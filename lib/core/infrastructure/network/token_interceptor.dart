import 'dart:async' show Future;
import 'dart:io' show HttpStatus;

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:srt_app/core/constants/api_endpoints.dart';
import 'package:srt_app/core/infrastructure/storage/session_manager.dart' show SessionManager;

final _dioRefresh = Dio();

class TokenInterceptor extends QueuedInterceptor {
  final Dio dio;
  final baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8080/api';

  Future<(String? token, String? refreshToken)>? _refreshTokenFuture;

  TokenInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SessionManager.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      if (err.requestOptions.path == "$baseUrl${ApiEndpoints.refreshToken}") {
        await SessionManager.clearSession();
        return handler.next(err);
      }

      try {
        // Si _refreshTokenFuture es nulo, significa que no hay una operación de refresco en curso.
        // La iniciamos y guardamos el Future resultante.
        _refreshTokenFuture ??= _refreshToken();

        // Todas las peticiones (la primera y las subsiguientes) esperan al mismo Future.
        final (newToken, newRefreshToken) = await _refreshTokenFuture!;

        _refreshTokenFuture = null;

        if (newToken != null && newRefreshToken != null) {
          // Guardamos los nuevos tokens
          await SessionManager.saveToken(newToken);
          await SessionManager.saveRefreshToken(newRefreshToken);

          // Reintentamos la petición que falló con el nuevo token.
          final response = await _retry(err.requestOptions, newToken);
          return handler.resolve(response);
        } else {
          await SessionManager.clearSession();
          return handler.next(err);
        }
      } catch (e) {
        _refreshTokenFuture = null;
        await SessionManager.clearSession();
        return handler.next(err);
      }
    }
    return handler.next(err);
  }

  Future<(String? token, String? refreshToken)> _refreshToken() async {
    try {
      final token = await SessionManager.getToken();
      final refreshToken = await SessionManager.getRefreshToken();
      //TODO tipar
      final response = await _dioRefresh.post(
        "$baseUrl${ApiEndpoints.refreshToken}",
        data: {'accessToken': token, 'refreshToken': refreshToken},
      );

      if (response.statusCode == HttpStatus.ok) {
        return (
          response.data['data']['token'] as String?,
          response.data['data']['refreshToken'] as String?,
        );
      } else {
        return (null, null);
      }
    } catch (e) {
      return (null, null);
    }
  }

  Future<Response<dynamic>> _retry(
    RequestOptions requestOptions,
    String token,
  ) async {
    final retryDio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
        )
    );

    final options = Options(
      method: requestOptions.method,
      headers: {...requestOptions.headers, 'Authorization': 'Bearer $token'},
    );

    return retryDio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
