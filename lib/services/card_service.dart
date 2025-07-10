import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/card_model.dart';
import '../services/auth_service.dart';

class CardService {
  Future<List<CardModel>> getUserCards() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/cards'),
        headers: ApiConfig.getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['cards'];
        return data.map((json) => CardModel.fromJson(json)).toList();
      }

      throw Exception('Failed to fetch cards');
    } catch (e) {
      throw Exception('Failed to fetch cards: $e');
    }
  }

  Future<Map<String, dynamic>> requestCard({required String cardType}) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/cards/request'),
        headers: ApiConfig.getHeaders(token),
        body: json.encode({'cardType': cardType}),
      );

      final data = json.decode(response.body);
      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Card request submitted successfully',
          'cardId': data['cardId'],
        };
      }

      return {
        'success': false,
        'message': data['message'] ?? 'Failed to request card',
      };
    } catch (e) {
      throw Exception('Failed to request card: $e');
    }
  }

  Future<CardModel> getCardDetails(String cardId) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/cards/$cardId'),
        headers: ApiConfig.getHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['card'];
        return CardModel.fromJson(data);
      }

      throw Exception('Failed to fetch card details');
    } catch (e) {
      throw Exception('Failed to fetch card details: $e');
    }
  }

  Future<Map<String, dynamic>> blockCard(String cardId) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/cards/$cardId/block'),
        headers: ApiConfig.getHeaders(token),
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Card blocked successfully',
        };
      }

      return {
        'success': false,
        'message': data['message'] ?? 'Failed to block card',
      };
    } catch (e) {
      throw Exception('Failed to block card: $e');
    }
  }

  Future<Map<String, dynamic>> changePin({
    required String cardId,
    required String currentPin,
    required String newPin,
  }) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/cards/$cardId/change-pin'),
        headers: ApiConfig.getHeaders(token),
        body: json.encode({
          'currentPin': currentPin,
          'newPin': newPin,
        }),
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'PIN changed successfully',
        };
      }

      return {
        'success': false,
        'message': data['message'] ?? 'Failed to change PIN',
      };
    } catch (e) {
      throw Exception('Failed to change PIN: $e');
    }
  }
} 