class ArtworkShowModel {
  int? id;
  int artworkId;
  int showId;

  ArtworkShowModel({
    this.id,
    required this.artworkId,
    required this.showId,
  });

  // Convert ArtworkShow object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'artwork_id': artworkId,
      'show_id': showId,
    };
  }

  // Create ArtworkShow object from a Map
  factory ArtworkShowModel.fromMap(Map<String, dynamic> map) {
    return ArtworkShowModel(
      id: map['id'],
      artworkId: map['artwork_id'],
      showId: map['show_id'],
    );
  }
}