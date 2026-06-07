import 'package:food_delivery_app/features/home/domain/entities/product_entity.dart';

enum ProductsStatus { initial, loading, loaded, failure }

class HomeCarouselItem {
  final String image;
  final String title;
  final String subtitle;

  const HomeCarouselItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class HomeState {
  final List<HomeCarouselItem> carouselItems;
  final int currentIndex;
  final List<ProductEntity> products;
  final ProductsStatus productsStatus;
  final String? errorMessage;

  const HomeState({
    required this.carouselItems,
    required this.currentIndex,
    this.products = const [],
    this.productsStatus = ProductsStatus.initial,
    this.errorMessage,
  });

  HomeState copyWith({
    List<HomeCarouselItem>? carouselItems,
    int? currentIndex,
    List<ProductEntity>? products,
    ProductsStatus? productsStatus,
    String? errorMessage,
  }) {
    return HomeState(
      carouselItems: carouselItems ?? this.carouselItems,
      currentIndex: currentIndex ?? this.currentIndex,
      products: products ?? this.products,
      productsStatus: productsStatus ?? this.productsStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
