import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bank/config/api_config.dart';

class ApiService {
  final String baseUrl = ApiConfig.baseUrl;
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  ApiService() {
    _initializeHeaders();
  }

  Future<void> _initializeHeaders() async {
    final token = await ApiConfig.getToken();
    if (token != null) {
      _headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );

      return _handleResponse(response);
    } catch (e) {
      throw 'API request failed: ${e.toString()}';
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, [Map<String, dynamic>? body]) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: body != null ? jsonEncode(body) : null,
      );

      return _handleResponse(response);
    } catch (e) {
      throw 'API request failed: ${e.toString()}';
    }
  }

  Future<Map<String, dynamic>> put(String endpoint, [Map<String, dynamic>? body]) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: body != null ? jsonEncode(body) : null,
      );

      return _handleResponse(response);
    } catch (e) {
      throw 'API request failed: ${e.toString()}';
    }
  }

  Future<Map<String, dynamic>> patch(String endpoint, [Map<String, dynamic>? body]) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: body != null ? jsonEncode(body) : null,
      );

      return _handleResponse(response);
    } catch (e) {
      throw 'API request failed: ${e.toString()}';
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );

      return _handleResponse(response);
    } catch (e) {
      throw 'API request failed: ${e.toString()}';
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    } else {
      throw body['message'] ?? 'Request failed with status: ${response.statusCode}';
    }
  }

  Future<void> updateToken(String token) async {
    await ApiConfig.setToken(token);
    _headers['Authorization'] = 'Bearer $token';
  }

  Future<void> clearToken() async {
    await ApiConfig.clearToken();
    _headers.remove('Authorization');
  }
} 