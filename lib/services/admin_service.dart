import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/user_model.dart';
import '../models/transaction_model.dart';
import '../models/card_model.dart';

class AdminService {
  final String token;

  AdminService({required this.token});

  // Users Management
  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.adminUsers),
        headers: ApiConfig.getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((user) => User.fromJson(user)).toList();
      }
      throw Exception('Failed to fetch users');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<User> updateUserStatus(String userId, String status) async {
    try {
      final response = await http.patch(
        Uri.parse('${ApiConfig.adminUsers}/$userId/status'),
        headers: ApiConfig.getHeaders(token),
        body: json.encode({'status': status}),
      );

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to update user status');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Transactions Management
  Future<List<Transaction>> getTransactions() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.adminTransactions),
        headers: ApiConfig.getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((transaction) => Transaction.fromJson(transaction)).toList();
      }
      throw Exception('Failed to fetch transactions');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Transaction> processDeposit(String accountId, double amount, String notes) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.adminTransactions}/deposit'),
        headers: ApiConfig.getHeaders(token),
        body: json.encode({
          'accountId': accountId,
          'amount': amount,
          'notes': notes,
        }),
      );

      if (response.statusCode == 200) {
        return Transaction.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to process deposit');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Transaction> processWithdrawal(
    String accountId,
    double amount,
    String chequeNumber,
    String notes,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.adminTransactions}/withdraw'),
        headers: ApiConfig.getHeaders(token),
        body: json.encode({
          'accountId': accountId,
          'amount': amount,
          'chequeNumber': chequeNumber,
          'notes': notes,
        }),
      );

      if (response.statusCode == 200) {
        return Transaction.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to process withdrawal');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Cards Management
  Future<List<CardModel>> getCards() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.adminCards),
        headers: ApiConfig.getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((card) => CardModel.fromJson(card)).toList();
      }
      throw Exception('Failed to fetch cards');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<CardModel> updateCardStatus(String cardId, String status) async {
    try {
      final response = await http.patch(
        Uri.parse('${ApiConfig.adminCards}/$cardId/status'),
        headers: ApiConfig.getHeaders(token),
        body: json.encode({'status': status}),
      );

      if (response.statusCode == 200) {
        return CardModel.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to update card status');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Dashboard Data
  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.adminDashboard),
        headers: ApiConfig.getHeaders(token),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to fetch dashboard stats');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Notifications
  Future<void> sendNotification(String userId, String message, String type) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.adminNotifications),
        headers: ApiConfig.getHeaders(token),
        body: json.encode({
          'userId': userId,
          'message': message,
          'type': type,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send notification');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
} 