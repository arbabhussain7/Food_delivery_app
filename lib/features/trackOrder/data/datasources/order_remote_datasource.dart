import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/core/error/exceptions.dart';
import 'package:food_delivery_app/features/trackOrder/data/models/order_model.dart';

abstract interface class OrderRemoteDataSource {
  Future<String> createOrder(OrderModel order);
  Stream<OrderModel?> getOrderStream(String orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore _firestore;
  const OrderRemoteDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<String> createOrder(OrderModel order) async {
    try {
      final docRef =
          await _firestore.collection('orders').add(order.toJson());
      return docRef.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<OrderModel?> getOrderStream(String orderId) {
    return _firestore
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .map((doc) => doc.exists ? OrderModel.fromFirestore(doc) : null);
  }
}
