class SavingsAccount {
  final String id;
  final String accountNumber;
  final String userId;
  final String accountType;
  final double amount;
  final double interestRate;
  final DateTime? maturityDate;
  final bool autoRenew;
  final String status;
  final DateTime createdAt;

  SavingsAccount({
    required this.id,
    required this.accountNumber,
    required this.userId,
    required this.accountType,
    required this.amount,
    required this.interestRate,
    this.maturityDate,
    required this.autoRenew,
    required this.status,
    required this.createdAt,
  });

  factory SavingsAccount.fromJson(Map<String, dynamic> json) {
    return SavingsAccount(
      id: json['id'],
      accountNumber: json['accountNumber'],
      userId: json['user'],
      accountType: json['accountType'],
      amount: json['amount'].toDouble(),
      interestRate: json['interestRate'].toDouble(),
      maturityDate: json['maturityDate'] != null
          ? DateTime.parse(json['maturityDate'])
          : null,
      autoRenew: json['autoRenew'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountNumber': accountNumber,
      'user': userId,
      'accountType': accountType,
      'amount': amount,
      'interestRate': interestRate,
      'maturityDate': maturityDate?.toIso8601String(),
      'autoRenew': autoRenew,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  double get projectedInterest {
    if (maturityDate == null) return 0;
    final daysToMaturity = maturityDate!.difference(DateTime.now()).inDays;
    return (amount * interestRate * daysToMaturity) / (365 * 100);
  }

  double get totalAmount {
    return amount + projectedInterest;
  }
} 