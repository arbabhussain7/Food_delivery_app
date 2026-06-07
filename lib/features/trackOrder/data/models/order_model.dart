import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/features/trackOrder/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.itemName,
    required super.restaurantName,
    required super.imageUrl,
    required super.quantity,
    required super.unitPrice,
    required super.totalAmount,
    required super.deliveryStatus,
    required super.orderPlacedAt,
    required super.deliveryTimeRange,
    required super.deliveryAddress,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      userId: data['userId'] as String? ?? '',
      itemName: data['itemName'] as String? ?? '',
      restaurantName: data['restaurantName'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
      quantity: (data['quantity'] as num?)?.toInt() ?? 1,
      unitPrice: (data['unitPrice'] as num?)?.toDouble() ?? 0,
      totalAmount: (data['totalAmount'] as num?)?.toDouble() ?? 0,
      deliveryStatus: data['deliveryStatus'] as String? ?? 'Order Placed',
      orderPlacedAt:
          (data['orderPlacedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      deliveryTimeRange: data['deliveryTimeRange'] as String? ?? '30–45 min',
      deliveryAddress: data['deliveryAddress'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'itemName': itemName,
      'restaurantName': restaurantName,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalAmount': totalAmount,
      'deliveryStatus': deliveryStatus,
      'orderPlacedAt': Timestamp.fromDate(orderPlacedAt),
      'deliveryTimeRange': deliveryTimeRange,
      'deliveryAddress': deliveryAddress,
    };
  }
}
