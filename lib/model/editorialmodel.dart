class EditorialModel {
  int? id;
  String title;
  String createdAt;
  String author;
  String content;
  String image;

  EditorialModel({
    this.id,
    required this.title,
    required this.createdAt,
    required this.author,
    required this.content,
    required this.image,
  });

  // Convert EditorialModel object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'created_at': createdAt,
      'author': author,
      'content': content,
      'image': image,
    };
  }

  // Create EditorialModel object from a Map
  factory EditorialModel.fromMap(Map<String, dynamic> map) {
    return EditorialModel(
      id: map['id'],
      title: map['title'],
      createdAt: map['created_at'],
      author: map['author'],
      content: map['content'],
      image: map['image'],
    );
  }
}
