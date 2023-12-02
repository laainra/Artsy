class ArtworkModel {
  int? id;
  String? title;
  String? medium;
  int? year;
  String? materials;
  String? rarity;
  double? height;
  double? width;
  double? depth;
  String? price;
  String? provenance;
  String? location;
  String? notes;
  String? photos;
  String? condition;
  String? frame;
  String? certificate;
  int? artistId;
  int? galleryId;

  ArtworkModel({
    this.id,
    this.title,
    this.medium,
    this.year,
    this.materials,
    this.rarity,
    this.height,
    this.width,
    this.depth,
    this.price,
    this.provenance,
    this.location,
    this.notes,
    this.photos,
    this.condition,
    this.frame,
    this.certificate,
    this.artistId,
    this.galleryId,
  });

  // Convert Artwork object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'medium': medium,
      'year': year,
      'materials': materials,
      'rarity': rarity,
      'height': height,
      'width': width,
      'depth': depth,
      'price': price,
      'provenance': provenance,
      'location': location,
      'notes': notes,
      'photos': photos,
      'condition': condition,
      'frame': frame,
      'certificate': certificate,
      'artistId': artistId,
      'galleryId': galleryId,
    };
  }

  // Create Artwork object from a Map
  factory ArtworkModel.fromMap(Map<String, dynamic> map) {
    return ArtworkModel(
      id: map['id'],
      title: map['title'],
      medium: map['medium'],
      year: map['year'],
      materials: map['materials'],
      rarity: map['rarity'],
      height: map['height'],
      width: map['width'],
      depth: map['depth'],
      price: map['price'],
      provenance: map['provenance'],
      location: map['location'],
      notes: map['notes'],
      photos: map['photos'],
      condition: map['condition'],
      frame: map['frame'],
      certificate: map['certificate'],
      artistId: map['artistId'],
      galleryId: map['galleryId'],
    );
  }
}
