class Transaction {
  final String id;
  final String userId;
  final String type;
  final double amount;
  final String? description;
  final String status;
  final String? receiverAccount;
  final String? billType;
  final String? provider;
  final String? customerNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    this.description,
    required this.status,
    this.receiverAccount,
    this.billType,
    this.provider,
    this.customerNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      type: json['type'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      description: json['description'],
      status: json['status'] ?? 'pending',
      receiverAccount: json['receiverAccount'],
      billType: json['billType'],
      provider: json['provider'],
      customerNumber: json['customerNumber'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'type': type,
      'amount': amount,
      'description': description,
      'status': status,
      'receiverAccount': receiverAccount,
      'billType': billType,
      'provider': provider,
      'customerNumber': customerNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class BillDetails {
  final String provider;
  final String customerNumber;
  final String? billType;

  BillDetails({
    required this.provider,
    required this.customerNumber,
    this.billType,
  });

  factory BillDetails.fromJson(Map<String, dynamic> json) {
    return BillDetails(
      provider: json['provider'],
      customerNumber: json['customerNumber'],
      billType: json['billType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'customerNumber': customerNumber,
      'billType': billType,
    };
  }
}

class ChequeDetails {
  final String chequeNumber;
  final String bankBranch;

  ChequeDetails({
    required this.chequeNumber,
    required this.bankBranch,
  });

  factory ChequeDetails.fromJson(Map<String, dynamic> json) {
    return ChequeDetails(
      chequeNumber: json['chequeNumber'],
      bankBranch: json['bankBranch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chequeNumber': chequeNumber,
      'bankBranch': bankBranch,
    };
  }
} 