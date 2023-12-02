class GalleryModel {
  int? id;
  String? name;
  String? location;
  String? description;
  String? photo;

  GalleryModel({
    this.id,
    this.name,
    this.location,
    this.description,
    this.photo,
  });

  // Convert Gallery object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'photo': photo,
    };
  }

  // Create Gallery object from a Map
  factory GalleryModel.fromMap(Map<String, dynamic> map) {
    return GalleryModel(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      description: map['description'],
      photo: map['photo'],
    );
  }
}