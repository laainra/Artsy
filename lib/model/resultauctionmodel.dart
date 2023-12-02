class ResultAuctionModel {
  int? id;
  int auctionId;
  int userId;
  double amount;

  ResultAuctionModel({
    this.id,
    required this.auctionId,
    required this.userId,
    required this.amount,
  });

  // Convert ResultAuction object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'auction_id': auctionId,
      'user_id': userId,
      'amount': amount,
    };
  }

  // Create ResultAuction object from a Map
  factory ResultAuctionModel.fromMap(Map<String, dynamic> map) {
    return ResultAuctionModel(
      id: map['id'],
      auctionId: map['auction_id'],
      userId: map['user_id'],
      amount: map['amount'],
    );
  }
}
