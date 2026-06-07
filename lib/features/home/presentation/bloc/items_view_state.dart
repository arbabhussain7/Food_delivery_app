class ItemsViewState {
  final bool isExtraCheeseSelected;
  final bool isNoOnionsSelected;
  final bool isCrispyBaconSelected;
  final int quantity;

  const ItemsViewState({
    this.isExtraCheeseSelected = false,
    this.isNoOnionsSelected = false,
    this.isCrispyBaconSelected = false,
    this.quantity = 1,
  });

  ItemsViewState copyWith({
    bool? isExtraCheeseSelected,
    bool? isNoOnionsSelected,
    bool? isCrispyBaconSelected,
    int? quantity,
  }) {
    return ItemsViewState(
      isExtraCheeseSelected:
          isExtraCheeseSelected ?? this.isExtraCheeseSelected,
      isNoOnionsSelected: isNoOnionsSelected ?? this.isNoOnionsSelected,
      isCrispyBaconSelected:
          isCrispyBaconSelected ?? this.isCrispyBaconSelected,
      quantity: quantity ?? this.quantity,
    );
  }
}
