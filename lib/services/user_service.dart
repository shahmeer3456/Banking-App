import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/user_model.dart';
import 'auth_service.dart';

class UserService {
  static Future<User> getCurrentUser() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/users/me'),
        headers: ApiConfig.getHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return User.fromJson(data);
      }

      throw Exception('Failed to get user profile');
    } catch (e) {
      print('Get current user error: $e');
      rethrow;
    }
  }

  static Future<User> updateUser(Map<String, dynamic> userData) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/users/me'),
        headers: ApiConfig.getHeaders(token),
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return User.fromJson(data);
      }

      throw Exception('Failed to update user profile');
    } catch (e) {
      print('Update user error: $e');
      rethrow;
    }
  }

  static Future<void> updateAvatar(String imagePath) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      // Create multipart request
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('${ApiConfig.baseUrl}/users/me/avatar'),
      );

      // Add authorization header
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Add file
      request.files.add(await http.MultipartFile.fromPath(
        'avatar',
        imagePath,
      ));

      // Send request
      final response = await request.send();
      if (response.statusCode != 200) {
        throw Exception('Failed to update avatar');
      }
    } catch (e) {
      print('Update avatar error: $e');
      rethrow;
    }
  }

  static Future<void> deleteAccount() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}/users/me'),
        headers: ApiConfig.getHeaders(token),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete account');
      }
    } catch (e) {
      print('Delete account error: $e');
      rethrow;
    }
  }
} 