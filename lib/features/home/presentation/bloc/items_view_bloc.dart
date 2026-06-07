import 'package:flutter_bloc/flutter_bloc.dart';
import 'items_view_event.dart';
import 'items_view_state.dart';

class ItemsViewBloc extends Bloc<ItemsViewEvent, ItemsViewState> {
  ItemsViewBloc() : super(const ItemsViewState()) {
    on<ExtraCheeseToggled>(_onExtraCheeseToggled);
    on<NoOnionsToggled>(_onNoOnionsToggled);
    on<CrispyBaconToggled>(_onCrispyBaconToggled);
    on<QuantityIncremented>(_onQuantityIncremented);
    on<QuantityDecremented>(_onQuantityDecremented);
  }

  void _onExtraCheeseToggled(
    ExtraCheeseToggled event,
    Emitter<ItemsViewState> emit,
  ) {
    emit(state.copyWith(isExtraCheeseSelected: !state.isExtraCheeseSelected));
  }

  void _onNoOnionsToggled(
    NoOnionsToggled event,
    Emitter<ItemsViewState> emit,
  ) {
    emit(state.copyWith(isNoOnionsSelected: !state.isNoOnionsSelected));
  }

  void _onCrispyBaconToggled(
    CrispyBaconToggled event,
    Emitter<ItemsViewState> emit,
  ) {
    emit(state.copyWith(isCrispyBaconSelected: !state.isCrispyBaconSelected));
  }

  void _onQuantityIncremented(
    QuantityIncremented event,
    Emitter<ItemsViewState> emit,
  ) {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void _onQuantityDecremented(
    QuantityDecremented event,
    Emitter<ItemsViewState> emit,
  ) {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }
}
