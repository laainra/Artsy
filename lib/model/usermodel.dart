import 'package:intl/intl.dart';

class UserModel {
  int? id;
  String? email;
  String? password;
  String? name;
  String? profileImage;
  String? location;
  String? profession;
  String? positions;
  String? about;
  String? createdAt;

  UserModel({
    this.id,
    this.email,
    this.password,
    this.name,
    this.profileImage,
    this.location,
    this.profession,
    this.positions,
    this.about,
    this.createdAt,
  });

  UserModel.withCurrentTime({
    this.id,
    required this.email,
    required this.password,
    required this.profileImage,
    required this.name,
    required this.location,
    required this.profession,
    required this.positions,
    required this.about,
  }) : createdAt = _getCurrentTime();

  static String _getCurrentTime() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(now);
  }

   @override
  String toString() {
    return 'UserModel{id: $id, name: $name, location: $location, '
           'profession: $profession, positions: $positions, '
           'about: $about, profileImage: $profileImage}';
  }

  // Convert User object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'profileImage': profileImage,
      'name': name,
      'location': location,
      'profession': profession,
      'positions': positions,
      'about': about,
      'createdAt': createdAt,
    };
  }

  // Create User object from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      profileImage: map['profileImage'],
      name: map['name'],
      location: map['location'],
      profession: map['profession'],
      positions: map['positions'],
      about: map['about'],
      createdAt: map['createdAt'],
    );
  }
}
