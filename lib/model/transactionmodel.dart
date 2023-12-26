class TransactionModel {
  final int? id;
  final int? userId;
  final int? artworkId;
  final String? paymentMethod;
  final double? amount;
  final String? status;
  final String? shippingMethod;
  final String? description;
  final String? address;
  final String? createdAt;

  TransactionModel({
    this.id,
    this.userId,
    this.artworkId,
    this.paymentMethod,
    this.amount,
    this.status,
    this.shippingMethod,
    this.description,
    this.address,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'artworkId': artworkId,
      'paymentMethod': paymentMethod,
      'amount': amount,
      'status': status,
      'shippingMethod': shippingMethod,
      'description': description,
      'address': address,
      'createdAt': createdAt,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      userId: json['userId'],
      artworkId: json['artworkId'],
      paymentMethod: json['paymentMethod'],
      amount: json['amount'],
      status: json['status'],
      shippingMethod: json['shippingMethod'],
      description: json['description'],
      address: json['address'],
      createdAt: json['createdAt'],
    );
  }
}
