import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/transaction_model.dart';
import '../models/card_model.dart';
import '../services/admin_service.dart';

class AdminProvider with ChangeNotifier {
  final AdminService _adminService;
  List<User> _users = [];
  List<Transaction> _transactions = [];
  List<CardModel> _cards = [];
  Map<String, dynamic> _dashboardStats = {};
  bool _isLoading = false;
  String? _error;

  AdminProvider({required String token}) : _adminService = AdminService(token: token);

  // Getters
  List<User> get users => _users;
  List<Transaction> get transactions => _transactions;
  List<CardModel> get cards => _cards;
  Map<String, dynamic> get dashboardStats => _dashboardStats;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Error handling
  void _setError(String message) {
    _error = message;
    _isLoading = false;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Users Management
  Future<void> fetchUsers() async {
    try {
      _setLoading(true);
      _users = await _adminService.getUsers();
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> updateUserStatus(String userId, String status) async {
    try {
      _setLoading(true);
      final updatedUser = await _adminService.updateUserStatus(userId, status);
      _users = _users.map((user) => user.id == userId ? updatedUser : user).toList();
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Transactions Management
  Future<void> fetchTransactions() async {
    try {
      _setLoading(true);
      _transactions = await _adminService.getTransactions();
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> processDeposit(String accountId, double amount, String notes) async {
    try {
      _setLoading(true);
      final transaction = await _adminService.processDeposit(accountId, amount, notes);
      _transactions.add(transaction);
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> processWithdrawal(
    String accountId,
    double amount,
    String chequeNumber,
    String notes,
  ) async {
    try {
      _setLoading(true);
      final transaction = await _adminService.processWithdrawal(
        accountId,
        amount,
        chequeNumber,
        notes,
      );
      _transactions.add(transaction);
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Cards Management
  Future<void> fetchCards() async {
    try {
      _setLoading(true);
      _cards = await _adminService.getCards();
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> updateCardStatus(String cardId, String status) async {
    try {
      _setLoading(true);
      final updatedCard = await _adminService.updateCardStatus(cardId, status);
      _cards = _cards.map((card) => card.id == cardId ? updatedCard : card).toList();
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Dashboard Stats
  Future<void> fetchDashboardStats() async {
    try {
      _setLoading(true);
      _dashboardStats = await _adminService.getDashboardStats();
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Notifications
  Future<void> sendNotification(String userId, String message, String type) async {
    try {
      _setLoading(true);
      await _adminService.sendNotification(userId, message, type);
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
    }
  }
} 