class ArtistModel {
  int? id;
  String? name;
  String? nationality;
  String? birthYear;
  String? deathYear;
  String? photo;

  ArtistModel({
    this.id,
    this.name,
    this.nationality,
    this.birthYear,
    this.deathYear,
    this.photo,
  });

  // Convert Artist object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nationality': nationality,
      'birthYear': birthYear,
      'deathYear': deathYear,
      'photo': photo,
    };
  }

  // Create Artist object from a Map
  factory ArtistModel.fromMap(Map<String, dynamic> map) {
    return ArtistModel(
      id: map['id'],
      name: map['name'],
      nationality: map['nationality'],
      birthYear: map['birthYear'],
      deathYear: map['deathYear'],
      photo: map['photo'],
    );
  }
}
