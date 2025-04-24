// lib/services/order_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_market/models/food_model.dart';
import 'package:food_market/models/order_model.dart';
import 'package:get/get.dart';


class OrderService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<void> createOrder({
    required FoodModel food,
    required int quantity,
    required double total,
    required String deliveryAddress,
  }) async {
    try {
      String userId = _auth.currentUser!.uid;
      
      await _firestore.collection('orders').add({
        'userId': userId,
        'food': food.toJson(),
        'quantity': quantity,
        'total': total,
        'status': OrderStatus.pending.index,
        'createdAt': FieldValue.serverTimestamp(),
        'deliveryAddress': deliveryAddress,
      });
    } catch (e) {
      throw 'Failed to create order: $e';
    }
  }
  
  Future<List<OrderModel>> getOrdersByStatus(OrderStatus status) async {
    try {
      String userId = _auth.currentUser!.uid;
      
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: status.index)
          .orderBy('createdAt', descending: true)
          .get();
      
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return OrderModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw 'Failed to get orders: $e';
    }
  }
  
  Future<List<OrderModel>> getAllOrders() async {
    try {
      String userId = _auth.currentUser!.uid;
      
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();
      
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return OrderModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw 'Failed to get orders: $e';
    }
  }
  
  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': status.index,
      });
    } catch (e) {
      throw 'Failed to update order status: $e';
    }
  }
}
