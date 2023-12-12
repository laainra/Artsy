class TransactionModel {
  final int? id;
  final int? userId;
  final int? artworkId;
  final String? paymentMethod;
  final double? amount;
  final String? status;
  final String? address;
  final String? createdAt;

  TransactionModel({
    this.id,
     this.userId,
     this.artworkId,
     this.paymentMethod,
     this.amount,
     this.status,
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
      address: json['address'],
      createdAt: json['createdAt'],
    );
  }
}
