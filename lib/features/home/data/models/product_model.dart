import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/features/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.itemName,
    required super.restaurantName,
    required super.category,
    required super.deliveryTime,
    required super.description,
    required super.imageUrl,
    required super.price,
    required super.rating,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      itemName: data['itemName'] as String? ?? '',
      restaurantName: data['restaurantName'] as String? ?? '',
      category: data['category'] as String? ?? '',
      deliveryTime: data['deliveryTime'] as String? ?? '',
      description: data['description'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
