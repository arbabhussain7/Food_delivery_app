import 'package:food_delivery_app/features/home/domain/entities/product_entity.dart';

class CartItem {
  final ProductEntity product;
  final int quantity;
  final bool isExtraCheeseSelected;
  final bool isNoOnionsSelected;
  final bool isCrispyBaconSelected;

  static const double extraCheesePrice = 1.50;
  static const double crispyBaconPrice = 2.00;
  static const double deliveryFee = 3.49;

  const CartItem({
    required this.product,
    required this.quantity,
    required this.isExtraCheeseSelected,
    required this.isNoOnionsSelected,
    required this.isCrispyBaconSelected,
  });

  double get extrasPrice =>
      (isExtraCheeseSelected ? extraCheesePrice : 0) +
      (isCrispyBaconSelected ? crispyBaconPrice : 0);

  // price per single item including extras
  double get unitPrice => product.price + extrasPrice;

  // total for this line (unit price × quantity)
  double get lineTotal => unitPrice * quantity;

  List<String> get customizationLabels {
    return [
      if (isExtraCheeseSelected)
        'Extra Cheese (+\$${extraCheesePrice.toStringAsFixed(2)})',
      if (isNoOnionsSelected) 'No Onions',
      if (isCrispyBaconSelected)
        'Crispy Bacon (+\$${crispyBaconPrice.toStringAsFixed(2)})',
    ];
  }

  CartItem copyWith({int? quantity}) => CartItem(
        product: product,
        quantity: quantity ?? this.quantity,
        isExtraCheeseSelected: isExtraCheeseSelected,
        isNoOnionsSelected: isNoOnionsSelected,
        isCrispyBaconSelected: isCrispyBaconSelected,
      );
}
