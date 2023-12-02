class ShowModel {
  int? id;
  String name;
  String startDate;
  String endDate;
  int galleryId;

  ShowModel({
    this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.galleryId,
  });

  // Convert Show object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'start_date': startDate,
      'end_date': endDate,
      'gallery_id': galleryId,
    };
  }

  // Create Show object from a Map
  factory ShowModel.fromMap(Map<String, dynamic> map) {
    return ShowModel(
      id: map['id'],
      name: map['name'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      galleryId: map['gallery_id'],
    );
  }
}