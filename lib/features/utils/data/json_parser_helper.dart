/// Helper para parsear JSON de forma segura
class JsonParserHelper {
  JsonParserHelper._();

  /// Obtiene un valor de un Map de forma segura
  static T? getValue<T>(Map<String, dynamic>? json, String key) {
    if (json == null) return null;
    final value = json[key];
    if (value is T) return value;
    return null;
  }

  /// Obtiene un valor con valor por defecto
  static T getValueOrDefault<T>(
    Map<String, dynamic>? json,
    String key,
    T defaultValue,
  ) {
    return getValue<T>(json, key) ?? defaultValue;
  }

  /// Obtiene un Map anidado de forma segura
  static Map<String, dynamic> getNestedMap(
    Map<String, dynamic>? json,
    String key,
  ) {
    return getValue<Map<String, dynamic>>(json, key) ?? {};
  }

  /// Obtiene una lista de forma segura
  static List<T> getList<T>(
    Map<String, dynamic>? json,
    String key,
    T Function(dynamic) mapper,
  ) {
    final list = getValue<List>(json, key);
    if (list == null) return [];
    return list.map(mapper).toList();
  }

  /// Parsea un DateTime de forma segura
  static DateTime? parseDateTime(dynamic value) {
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  /// Parsea un double de forma segura
  static double parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }
}

