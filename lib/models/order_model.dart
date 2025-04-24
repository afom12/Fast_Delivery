// lib/models/order_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import 'food_model.dart';

enum OrderStatus { pending, processing, delivered, cancelled }

class OrderModel {
  final String id;
  final String userId;
  final FoodModel food;
  final int quantity;
  final double total;
  final OrderStatus status;
  final DateTime createdAt;
  final String? deliveryAddress;

  OrderModel({
    required this.id,
    required this.userId,
    required this.food,
    required this.quantity,
    required this.total,
    required this.status,
    required this.createdAt,
    this.deliveryAddress,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'],
      food: FoodModel.fromJson(json['food']),
      quantity: json['quantity'],
      total: json['total'].toDouble(),
      status: OrderStatus.values[json['status']],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      deliveryAddress: json['deliveryAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'food': food.toJson(),
      'quantity': quantity,
      'total': total,
      'status': status.index,
      'createdAt': Timestamp.fromDate(createdAt),
      'deliveryAddress': deliveryAddress,
    };
  }
}
