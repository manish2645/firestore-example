import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String name;
  final String gender;
  final String email;
  final Timestamp createdAt; // Creation timestamp

  UserData({
    required this.name,
    required this.gender,
    required this.email,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'email': email,
      'createdAt': createdAt,
    };
  }

  Map<String, dynamic> fromMap() {
    return {
      'name': name,
      'gender': gender,
      'email': email,
      'createdAt': createdAt,
    };
  }
}
