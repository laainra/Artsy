class AuctionModel {
  int? id;
  int artworkId;
  String presenter;
  String description;
  String startDatetime;
  String endDatetime;

  AuctionModel({
    this.id,
    required this.artworkId,
    required this.presenter,
    required this.description,
    required this.startDatetime,
    required this.endDatetime,
  });

  // Convert Auction object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'artwork_id': artworkId,
      'presenter': presenter,
      'description': description,
      'start_datetime': startDatetime,
      'end_datetime': endDatetime,
    };
  }

  // Create Auction object from a Map
  factory AuctionModel.fromMap(Map<String, dynamic> map) {
    return AuctionModel(
      id: map['id'],
      artworkId: map['artwork_id'],
      presenter: map['presenter'],
      description: map['description'],
      startDatetime: map['start_datetime'],
      endDatetime: map['end_datetime'],
    );
  }
}