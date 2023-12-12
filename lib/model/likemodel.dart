class LikeModel {
  final int? id;
  final int? userId;
  final int? artworkId;
  final String? createdAt;

  LikeModel({
     this.id,
     this.userId,
     this.artworkId,
     this.createdAt,
  });

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      id: map['id'],
      userId: map['user_id'],
      artworkId: map['artwork_id'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'artwork_id': artworkId,
      'created_at': createdAt,
    };
  }
}
