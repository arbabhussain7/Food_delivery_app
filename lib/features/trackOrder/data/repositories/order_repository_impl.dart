import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/exceptions.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/trackOrder/data/datasources/order_remote_datasource.dart';
import 'package:food_delivery_app/features/trackOrder/data/models/order_model.dart';
import 'package:food_delivery_app/features/trackOrder/domain/entities/order_entity.dart';
import 'package:food_delivery_app/features/trackOrder/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _dataSource;
  const OrderRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, String>> createOrder(OrderEntity order) async {
    try {
      final model = OrderModel(
        id: order.id,
        userId: order.userId,
        itemName: order.itemName,
        restaurantName: order.restaurantName,
        imageUrl: order.imageUrl,
        quantity: order.quantity,
        unitPrice: order.unitPrice,
        totalAmount: order.totalAmount,
        deliveryStatus: order.deliveryStatus,
        orderPlacedAt: order.orderPlacedAt,
        deliveryTimeRange: order.deliveryTimeRange,
        deliveryAddress: order.deliveryAddress,
      );
      final id = await _dataSource.createOrder(model);
      return Right(id);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Stream<Either<Failure, OrderEntity>> getOrderStream(String orderId) {
    return _dataSource.getOrderStream(orderId).map(
          (order) => order != null
              ? Right<Failure, OrderEntity>(order)
              : Left<Failure, OrderEntity>(
                  const ServerFailure('Order not found'),
                ),
        );
  }
}
