import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/features/orders/presentations/bloc/cart_event.dart';
import 'package:food_delivery_app/features/orders/presentations/bloc/cart_state.dart';

export 'cart_event.dart';
export 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>(_onAdded);
    on<CartItemRemoved>(_onRemoved);
    on<CartItemQuantityUpdated>(_onQuantityUpdated);
    on<CartCleared>(_onCleared);
  }

  void _onAdded(CartItemAdded event, Emitter<CartState> emit) {
    final existing = state.itemFor(event.item.product.id);
    if (existing != null) {
      final updated = state.items
          .map(
            (i) => i.product.id == event.item.product.id
                ? i.copyWith(quantity: i.quantity + event.item.quantity)
                : i,
          )
          .toList();
      emit(state.copyWith(items: updated));
    } else {
      emit(state.copyWith(items: [...state.items, event.item]));
    }
  }

  void _onRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    emit(
      state.copyWith(
        items: state.items
            .where((i) => i.product.id != event.productId)
            .toList(),
      ),
    );
  }

  void _onQuantityUpdated(
    CartItemQuantityUpdated event,
    Emitter<CartState> emit,
  ) {
    if (event.quantity <= 0) {
      emit(
        state.copyWith(
          items: state.items
              .where((i) => i.product.id != event.productId)
              .toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          items: state.items
              .map(
                (i) => i.product.id == event.productId
                    ? i.copyWith(quantity: event.quantity)
                    : i,
              )
              .toList(),
        ),
      );
    }
  }

  void _onCleared(CartCleared _, Emitter<CartState> emit) {
    emit(const CartState());
  }
}
