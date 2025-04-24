// lib/models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? phoneNumber;
  final String? address;
  final String? houseNumber;
  final String? city;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.phoneNumber,
    this.address,
    this.houseNumber,
    this.city,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      houseNumber: json['houseNumber'],
      city: json['city'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'address': address,
      'houseNumber': houseNumber,
      'city': city,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Create a copy of this user with updated fields
  UserModel copyWith({
    String? name,
    String? phoneNumber,
    String? address,
    String? houseNumber,
    String? city,
    String? photoUrl,
  }) {
    return UserModel(
      id: this.id,
      name: name ?? this.name,
      email: this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      houseNumber: houseNumber ?? this.houseNumber,
      city: city ?? this.city,
      createdAt: this.createdAt,
    );
  }
}
