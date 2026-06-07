import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/core/constant/app_assets.dart';
import 'package:food_delivery_app/features/home/domain/usecases/get_products_usecase.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUseCase _getProductsUseCase;

  HomeBloc({required GetProductsUseCase getProductsUseCase})
      : _getProductsUseCase = getProductsUseCase,
        super(
          const HomeState(
            carouselItems: [
              HomeCarouselItem(
                image: AppAssets.cardImg,
                title: '50% Off Your First Pizza',
                subtitle: 'Valid until Friday. T&Cs apply.',
              ),
              HomeCarouselItem(
                image: AppAssets.cardImgTwo,
                title: 'Buy One Get One Free',
                subtitle: 'Only this weekend. Order now.',
              ),
              HomeCarouselItem(
                image: AppAssets.cardImgThree,
                title: r'Free Delivery Over $20',
                subtitle: 'Enjoy fast delivery to your door.',
              ),
            ],
            currentIndex: 0,
          ),
        ) {
    on<HomeCarouselChanged>(_onCarouselChanged);
    on<ProductsFetchRequested>(_onProductsFetch);
  }

  void _onCarouselChanged(HomeCarouselChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentIndex: event.index));
  }

  Future<void> _onProductsFetch(
    ProductsFetchRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(productsStatus: ProductsStatus.loading));
    final result = await _getProductsUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        productsStatus: ProductsStatus.failure,
        errorMessage: failure.message,
      )),
      (products) => emit(state.copyWith(
        productsStatus: ProductsStatus.loaded,
        products: products,
      )),
    );
  }
}
