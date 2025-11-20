class JsonParserHelper {
  /// Get a nested map from JSON, returns empty map if not found
  static Map<String, dynamic> getNestedMap(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];
    if (value is Map<String, dynamic>) {
      return value;
    }
    return {};
  }

  /// Get a value from JSON with a default fallback
  static T getValueOrDefault<T>(
    Map<String, dynamic> json,
    String key,
    T defaultValue,
  ) {
    final value = json[key];
    if (value is T) {
      return value;
    }
    return defaultValue;
  }

  /// Get a value from JSON, returns null if not found or wrong type
  static T? getValue<T>(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is T) {
      return value;
    }
    return null;
  }

  /// Parse a DateTime from JSON string
  static DateTime? parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Parse a double from JSON (handles int and string)
  static double parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  /// Get a list from JSON with type safety
  static List<T> getList<T>(
    Map<String, dynamic> json,
    String key,
    T Function(dynamic) mapper,
  ) {
    final value = json[key];
    if (value is List) {
      return value.map((e) => mapper(e)).toList();
    }
    return [];
  }
}
