import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/bill_model.dart';
import '../services/auth_service.dart';

class TransactionService {
  static Future<Map<String, dynamic>> getTransactionHistory({
    required int page,
    required int limit,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        if (type != null) 'type': type,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };

      final uri = Uri.parse('${ApiConfig.baseUrl}/transactions')
          .replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: ApiConfig.getHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'transactions': data['transactions'],
          'message': data['message'],
        };
      }

      final error = json.decode(response.body);
      return {
        'success': false,
        'message': error['message'] ?? 'Failed to fetch transactions',
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> transfer({
    required String receiverAccount,
    required double amount,
    String? description,
  }) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/transactions/transfer'),
        headers: ApiConfig.getHeaders(token),
        body: json.encode({
          'receiverAccount': receiverAccount,
          'amount': amount,
          if (description != null) 'description': description,
        }),
      );

      final data = json.decode(response.body);
      return {
        'success': response.statusCode == 200,
        'message': data['message'],
        'transactionId': data['transactionId'],
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> confirmTransfer({
    required String otp,
  }) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/transactions/confirm'),
        headers: ApiConfig.getHeaders(token),
        body: json.encode({'otp': otp}),
      );

      final data = json.decode(response.body);
      return {
        'success': response.statusCode == 200,
        'message': data['message'],
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  Future<List<Bill>> getBills() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/bills'),
        headers: ApiConfig.getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['bills'];
        return data.map((json) => Bill.fromJson(json)).toList();
      }

      throw Exception('Failed to fetch bills');
    } catch (e) {
      throw Exception('Failed to fetch bills: $e');
    }
  }

  Future<Map<String, dynamic>> payBill({
    required String billType,
    required String provider,
    required String customerNumber,
    required double amount,
  }) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/transactions/bill-payment'),
        headers: ApiConfig.getHeaders(token),
        body: json.encode({
          'billType': billType,
          'provider': provider,
          'customerNumber': customerNumber,
          'amount': amount,
        }),
      );

      final data = json.decode(response.body);
      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Payment successful',
          'transaction': data['transaction'],
        };
      }

      return {
        'success': false,
        'message': data['message'] ?? 'Payment failed',
      };
    } catch (e) {
      throw Exception('Failed to process payment: $e');
    }
  }

  static Future<Map<String, dynamic>> mobileRecharge({
    required String phoneNumber,
    required double amount,
  }) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/transactions/mobile-recharge'),
        headers: ApiConfig.getHeaders(token),
        body: json.encode({
          'phoneNumber': phoneNumber,
          'amount': amount,
        }),
      );

      final data = json.decode(response.body);
      return {
        'success': response.statusCode == 200,
        'message': data['message'],
        'transactionId': data['transactionId'],
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
} 