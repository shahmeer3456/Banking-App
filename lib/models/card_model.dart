class CardModel {
  final String id;
  final String cardNumber;
  final String cardType;
  final String status;
  final DateTime expiryDate;
  final String cardHolderName;

  CardModel({
    required this.id,
    required this.cardNumber,
    required this.cardType,
    required this.status,
    required this.expiryDate,
    required this.cardHolderName,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      cardNumber: json['cardNumber'],
      cardType: json['cardType'],
      status: json['status'],
      expiryDate: DateTime.parse(json['expiryDate']),
      cardHolderName: json['cardHolderName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'cardType': cardType,
      'status': status,
      'expiryDate': expiryDate.toIso8601String(),
      'cardHolderName': cardHolderName,
    };
  }
} 