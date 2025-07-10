class Bill {
  final String id;
  final String provider;
  final String billNumber;
  final double amount;
  final DateTime dueDate;
  final String status;
  final String customerNumber;

  Bill({
    required this.id,
    required this.provider,
    required this.billNumber,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.customerNumber,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'],
      provider: json['provider'],
      billNumber: json['billNumber'],
      amount: (json['amount'] as num).toDouble(),
      dueDate: DateTime.parse(json['dueDate']),
      status: json['status'],
      customerNumber: json['customerNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider': provider,
      'billNumber': billNumber,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'status': status,
      'customerNumber': customerNumber,
    };
  }
} 