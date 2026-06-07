import 'package:food_delivery_app/features/orders/domain/entities/cart_item.dart';

abstract class CartEvent {
  const CartEvent();
}

class CartItemAdded extends CartEvent {
  final CartItem item;
  const CartItemAdded(this.item);
}

class CartItemRemoved extends CartEvent {
  final String productId;
  const CartItemRemoved(this.productId);
}

class CartItemQuantityUpdated extends CartEvent {
  final String productId;
  final int quantity;
  const CartItemQuantityUpdated({
    required this.productId,
    required this.quantity,
  });
}

class CartCleared extends CartEvent {
  const CartCleared();
}
