// lib/models/fo
class FoodModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  final double rating;
  final String restaurant;

  FoodModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.rating,
    required this.restaurant,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      description: json['description'],
      rating: json['rating'].toDouble(),
      restaurant: json['restaurant'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'description': description,
      'rating': rating,
      'restaurant': restaurant,
    };
  }
}
