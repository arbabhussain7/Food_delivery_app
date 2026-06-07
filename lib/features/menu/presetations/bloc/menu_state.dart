import 'package:food_delivery_app/features/home/domain/entities/product_entity.dart';

abstract class MenuState {
  const MenuState();
}

class MenuInitial extends MenuState {
  const MenuInitial();
}

class MenuLoading extends MenuState {
  const MenuLoading();
}

class MenuLoaded extends MenuState {
  final List<ProductEntity> products;
  final List<ProductEntity> filteredProducts;
  final String searchQuery;

  const MenuLoaded(
    this.products, {
    this.filteredProducts = const [],
    this.searchQuery = '',
  });

  List<ProductEntity> get displayProducts =>
      searchQuery.isEmpty ? products : filteredProducts;

  MenuLoaded copyWith({
    List<ProductEntity>? products,
    List<ProductEntity>? filteredProducts,
    String? searchQuery,
  }) {
    return MenuLoaded(
      products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class MenuFailure extends MenuState {
  final String message;
  const MenuFailure(this.message);
}
