import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/trackOrder/domain/entities/order_entity.dart';

abstract interface class OrderRepository {
  Future<Either<Failure, String>> createOrder(OrderEntity order);
  Stream<Either<Failure, OrderEntity>> getOrderStream(String orderId);
}
