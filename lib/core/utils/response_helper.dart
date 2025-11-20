import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';

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

  /// Parse a single object from API response
  static T parseObject<T>(
    Map<String, dynamic> response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final data = response['data'];
    if (data is Map<String, dynamic>) {
      return fromJson(data);
    }
    throw Exception('Invalid response format');
  }

  /// Parse a list of objects from API response
  static List<T> parseList<T>(
    Map<String, dynamic> response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final data = response['data'];
    if (data is List) {
      return data.map((item) => fromJson(item as Map<String, dynamic>)).toList();
    }
    return [];
  }
}
