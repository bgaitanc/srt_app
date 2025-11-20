import 'package:dio/dio.dart';
import '../services/toast_service.dart';
import '../storage/session_manager.dart';
import '../../../app.dart';
import '../../../routes.dart';

/// Interceptor to handle HTTP responses globally and show toast messages
class HttpResponseInterceptor extends Interceptor {
  // Endpoints to exclude from showing toasts
  final List<String> _excludedEndpoints = [
    '/Users/info',
  ];

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _handleResponse(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _handleError(err);
    super.onError(err, handler);
  }

  void _handleResponse(Response response) {
    // Check if endpoint should be excluded
    if (_shouldExclude(response.requestOptions.path)) {
      return;
    }

    final statusCode = response.statusCode;
    
    switch (statusCode) {
      case 200:
        final message = response.data['message'] ?? 'Operación exitosa';
        if (response.requestOptions.method != 'GET') {
          ToastService.showSuccess(message);
        }
        break;
      case 201:
        final message = response.data['message'] ?? 'Creado exitosamente';
        ToastService.showSuccess(message);
        break;
      case 204:
        final message = response.data['message'] ?? 'Actualizado exitosamente';
        ToastService.showSuccess(message);
        break;
      default:
        break;
    }
  }

  void _handleError(DioException err) {
    // Check if endpoint should be excluded
    if (_shouldExclude(err.requestOptions.path)) {
      return;
    }

    final statusCode = err.response?.statusCode;
    
    switch (statusCode) {
      case 400:
        ToastService.showError('Solicitud inválida');
        break;
      case 401:
        final message = err.response?.data?['message'] ?? 'Tu sesión ha expirado';
        ToastService.showError(message);
        _handleUnauthorized();
        break;
      case 403:
        ToastService.showError('No tienes permisos para esta acción');
        break;
      case 404:
        // Don't show toast for 404, let the UI handle it
        break;
      case 500:
      case 502:
      case 503:
        ToastService.showError('Error del servidor. Intenta más tarde');
        break;
      default:
        if (statusCode != null && statusCode >= 400) {
          ToastService.showError('Ocurrió un error inesperado');
        }
    }
  }

  bool _shouldExclude(String path) {
    return _excludedEndpoints.any((endpoint) => path.contains(endpoint));
  }

  Future<void> _handleUnauthorized() async {
    // Clear session
    await SessionManager.clearSession();
    
    // Navigate to login
    final navigatorKey = MyApp.navigatorKey;
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        Routes.login,
        (route) => false,
      );
    }
  }
}
