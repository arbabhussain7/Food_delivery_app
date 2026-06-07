class OrderEntity {
  final String id;
  final String userId;
  final String itemName;
  final String restaurantName;
  final String imageUrl;
  final int quantity;
  final double unitPrice;
  final double totalAmount;
  final String deliveryStatus;
  final DateTime orderPlacedAt;
  final String deliveryTimeRange;
  final String deliveryAddress;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.itemName,
    required this.restaurantName,
    required this.imageUrl,
    required this.quantity,
    required this.unitPrice,
    required this.totalAmount,
    required this.deliveryStatus,
    required this.orderPlacedAt,
    required this.deliveryTimeRange,
    required this.deliveryAddress,
  });

  // Returns the estimated delivery DateTime
  DateTime get estimatedDelivery {
    final match =
        RegExp(r'(\d+)[–\-](\d+)').firstMatch(deliveryTimeRange);
    final maxMinutes =
        match != null ? int.parse(match.group(2)!) : 45;
    return orderPlacedAt.add(Duration(minutes: maxMinutes));
  }
}
