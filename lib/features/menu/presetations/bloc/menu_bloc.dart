import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/features/home/domain/usecases/get_products_usecase.dart';
import 'package:food_delivery_app/features/menu/presetations/bloc/menu_event.dart';
import 'package:food_delivery_app/features/menu/presetations/bloc/menu_state.dart';

export 'menu_event.dart';
export 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetProductsUseCase _getProductsUseCase;

  MenuBloc({required GetProductsUseCase getProductsUseCase})
      : _getProductsUseCase = getProductsUseCase,
        super(const MenuInitial()) {
    on<MenuProductsFetchRequested>(_onFetch);
    on<MenuSearchChanged>(_onSearchChanged);
  }

  Future<void> _onFetch(
    MenuProductsFetchRequested event,
    Emitter<MenuState> emit,
  ) async {
    emit(const MenuLoading());
    final result = await _getProductsUseCase();
    result.fold(
      (failure) => emit(MenuFailure(failure.message)),
      (products) => emit(MenuLoaded(products)),
    );
  }

  void _onSearchChanged(MenuSearchChanged event, Emitter<MenuState> emit) {
    if (state is! MenuLoaded) return;
    final loaded = state as MenuLoaded;
    final q = event.query.toLowerCase().trim();
    if (q.isEmpty) {
      emit(loaded.copyWith(searchQuery: '', filteredProducts: const []));
      return;
    }
    final filtered = loaded.products.where((p) {
      return p.itemName.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q) ||
          p.restaurantName.toLowerCase().contains(q);
    }).toList();
    emit(loaded.copyWith(filteredProducts: filtered, searchQuery: event.query));
  }
}
