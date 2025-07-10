import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  String? _error;
  bool _hasMore = true;
  int _currentPage = 1;
  static const int _perPage = 10;

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _hasMore;

  Future<void> loadTransactions({
    bool refresh = false,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      _transactions = [];
    }

    if (!_hasMore || _isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await TransactionService.getTransactionHistory(
        page: _currentPage,
        limit: _perPage,
        type: type,
        startDate: startDate,
        endDate: endDate,
      );

      if (response['success'] == true) {
        final List<dynamic> transactionData = response['transactions'] as List<dynamic>;
        final newTransactions = transactionData
            .map((data) => Transaction.fromJson(data as Map<String, dynamic>))
            .toList();

        _transactions.addAll(newTransactions);
        _hasMore = newTransactions.length >= _perPage;
        _currentPage++;
      } else {
        _error = response['message'] as String?;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> transfer({
    required String receiverAccount,
    required double amount,
    String? description,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await TransactionService.transfer(
        receiverAccount: receiverAccount,
        amount: amount,
        description: description,
      );

      if (response['success'] != true) {
        _error = response['message'] as String?;
      }

      return response;
    } catch (e) {
      _error = e.toString();
      return {'success': false, 'message': e.toString()};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> confirmTransfer({
    required String otp,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await TransactionService.confirmTransfer(otp: otp);

      if (response['success'] == true) {
        // Refresh transactions list
        await loadTransactions(refresh: true);
      } else {
        _error = response['message'] as String?;
      }

      return response;
    } catch (e) {
      _error = e.toString();
      return {'success': false, 'message': e.toString()};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> payBill({
    required String billType,
    required String provider,
    required String customerNumber,
    required double amount,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await TransactionService.payBill(
        billType: billType,
        provider: provider,
        customerNumber: customerNumber,
        amount: amount,
      );

      if (response['success'] == true) {
        // Refresh transactions list
        await loadTransactions(refresh: true);
      } else {
        _error = response['message'] as String?;
      }

      return response;
    } catch (e) {
      _error = e.toString();
      return {'success': false, 'message': e.toString()};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> mobileRecharge({
    required String phoneNumber,
    required double amount,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await TransactionService.mobileRecharge(
        phoneNumber: phoneNumber,
        amount: amount,
      );

      if (response['success'] == true) {
        // Refresh transactions list
        await loadTransactions(refresh: true);
      } else {
        _error = response['message'] as String?;
      }

      return response;
    } catch (e) {
      _error = e.toString();
      return {'success': false, 'message': e.toString()};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 