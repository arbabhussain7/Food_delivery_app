import 'package:fpdart/fpdart.dart';
import 'package:food_delivery_app/core/error/failures.dart';
import 'package:food_delivery_app/features/orders/domain/entities/cart_item.dart';
import 'package:food_delivery_app/features/trackOrder/domain/entities/order_entity.dart';
import 'package:food_delivery_app/features/trackOrder/domain/repositories/order_repository.dart';

class CreateOrderParams {
  final String userId;
  final List<CartItem> cartItems;
  final double totalAmount;
  final String deliveryAddress;

  const CreateOrderParams({
    required this.userId,
    required this.cartItems,
    required this.totalAmount,
    required this.deliveryAddress,
  });
}

class CreateOrderUseCase {
  final OrderRepository _repository;
  const CreateOrderUseCase(this._repository);

  Future<Either<Failure, String>> call(CreateOrderParams params) {
    final first = params.cartItems.first;
    final totalQty =
        params.cartItems.fold(0, (sum, i) => sum + i.quantity);
    final displayName = params.cartItems.length == 1
        ? first.product.itemName
        : '${params.cartItems.length} Items';

    final order = OrderEntity(
      id: '',
      userId: params.userId,
      itemName: displayName,
      restaurantName: first.product.restaurantName,
      imageUrl: first.product.imageUrl,
      quantity: totalQty,
      unitPrice: params.totalAmount / totalQty,
      totalAmount: params.totalAmount,
      deliveryStatus: 'Order Placed',
      orderPlacedAt: DateTime.now(),
      deliveryTimeRange: first.product.deliveryTime,
      deliveryAddress: params.deliveryAddress,
    );
    return _repository.createOrder(order);
  }
}
