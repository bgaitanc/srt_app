import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _tokenKey = 'auth_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userIdKey = 'user_id';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_refreshTokenKey);
  }

  // Deprecated: Use clearSession() instead
  @Deprecated('Use clearSession() instead')
  static Future<void> clearToken() async {
    await clearSession();
  }

  static Future<List<String>?> getUserRoles() async {
    final token = await getToken();
    if (token == null || token.isEmpty) return null;

    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalized = base64.normalize(payload);
      final decoded = utf8.decode(base64.decode(normalized));
      final json = jsonDecode(decoded) as Map<String, dynamic>;

      final possibleKeys = [
        'role',
        'roles', 
        'http://schemas.microsoft.com/ws/2008/06/identity/claims/role',
      ];

      for (final key in possibleKeys) {
        if (json.containsKey(key)) {
          final roleValue = json[key];
          
          if (roleValue is List) {
            return roleValue.cast<String>();
          } else if (roleValue is String) {
            if (roleValue.startsWith('[') && roleValue.endsWith(']')) {
              try {
                final parsed = jsonDecode(roleValue);
                if (parsed is List) {
                  return parsed.cast<String>();
                }
              } catch (e) {
              }
            }
            return [roleValue];
          }
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
