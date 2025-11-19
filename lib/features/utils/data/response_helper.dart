import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';

/// Helper para manejar respuestas HTTP de forma consistente
class ResponseHelper {
  ResponseHelper._();

  /// Valida que el status code sea exitoso
  static void validateStatusCode(Response response, {int expectedStatus = 200}) {
    if (response.statusCode != expectedStatus) {
      throw ServerException(
        'Request failed with status ${response.statusCode}',
      );
    }
  }

  /// Extrae la lista de datos de una respuesta
  static List<T> extractList<T>(
    Response response,
    String dataKey,
    T Function(Map<String, dynamic>) mapper,
  ) {
    validateStatusCode(response);
    final data = response.data[dataKey] as List?;
    if (data == null) return [];
    return data
        .map((e) => mapper(e as Map<String, dynamic>))
        .toList();
  }

  /// Extrae un objeto único de una respuesta
  static T extractObject<T>(
    Response response,
    String dataKey,
    T Function(Map<String, dynamic>) mapper,
  ) {
    validateStatusCode(response);
    final data = response.data[dataKey] as Map<String, dynamic>?;
    if (data == null) {
      throw ServerException('Expected object at key "$dataKey" but found null');
    }
    return mapper(data);
  }
}

