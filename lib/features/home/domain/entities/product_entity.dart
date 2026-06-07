class ProductEntity {
  final String id;
  final String itemName;
  final String restaurantName;
  final String category;
  final String deliveryTime;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;

  const ProductEntity({
    required this.id,
    required this.itemName,
    required this.restaurantName,
    required this.category,
    required this.deliveryTime,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });
}
