import 'package:food_delivery_app/features/orders/domain/entities/cart_item.dart';

class CartState {
  final List<CartItem> items;

  const CartState({this.items = const []});

  bool containsProduct(String productId) =>
      items.any((i) => i.product.id == productId);

  CartItem? itemFor(String productId) {
    try {
      return items.firstWhere((i) => i.product.id == productId);
    } catch (_) {
      return null;
    }
  }

  double get subTotal =>
      items.fold(0.0, (sum, i) => sum + i.lineTotal);

  double get total =>
      subTotal + (items.isNotEmpty ? CartItem.deliveryFee : 0.0);

  int get totalItemCount =>
      items.fold(0, (sum, i) => sum + i.quantity);

  CartState copyWith({List<CartItem>? items}) =>
      CartState(items: items ?? this.items);
}
