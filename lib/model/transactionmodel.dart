class TransactionModel {
  final int? id;
  final int? artworkId;
  final String? paymentMethod;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? amount;
  final String? status;
  final String? shippingMethod;
  final String? description;
  final String? address;
  final String? createdAt;

  TransactionModel({
    this.id,
    this.artworkId,
    this.paymentMethod,
    this.name,
    this.phoneNumber,
    this.email,
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
      'artworkId': artworkId,
      'paymentMethod': paymentMethod,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
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
      artworkId: json['artworkId'],
      paymentMethod: json['paymentMethod'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      amount: json['amount'],
      status: json['status'],
      shippingMethod: json['shippingMethod'],
      description: json['description'],
      address: json['address'],
      createdAt: json['createdAt'],
    );
  }
}
