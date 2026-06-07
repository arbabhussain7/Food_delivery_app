import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/trackOrder/domain/entities/order_entity.dart';
import 'package:food_delivery_app/features/trackOrder/domain/repositories/order_repository.dart';

class GetOrderStreamUseCase {
  final OrderRepository _repository;
  const GetOrderStreamUseCase(this._repository);

  Stream<Either<Failure, OrderEntity>> call(String orderId) {
    return _repository.getOrderStream(orderId);
  }
}
