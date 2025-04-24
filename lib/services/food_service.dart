// lib/services/food_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/food_model.dart';

class FoodService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future<List<FoodModel>> getFoods() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('foods').get();
      
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return FoodModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw 'Failed to get foods: $e';
    }
  }
  
  Future<FoodModel> getFoodById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('foods').doc(id).get();
      
      if (!doc.exists) {
        throw 'Food not found';
      }
      
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      
      return FoodModel.fromJson(data);
    } catch (e) {
      throw 'Failed to get food: $e';
    }
  }
}
