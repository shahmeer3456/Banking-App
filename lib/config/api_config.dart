import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  static const String baseUrl = 'http://localhost:3000/api';
  static const String tokenKey = 'auth_token';

  // API Endpoints
  static String get adminUsers => '$baseUrl/admin/users';
  static String get adminTransactions => '$baseUrl/admin/transactions';
  static String get adminCards => '$baseUrl/admin/cards';
  static String get adminDashboard => '$baseUrl/admin/dashboard';
  static String get adminNotifications => '$baseUrl/admin/notifications';

  static Map<String, String> getHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }
} 