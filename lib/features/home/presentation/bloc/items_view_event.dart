abstract class ItemsViewEvent {
  const ItemsViewEvent();
}

class ExtraCheeseToggled extends ItemsViewEvent {
  const ExtraCheeseToggled();
}

class NoOnionsToggled extends ItemsViewEvent {
  const NoOnionsToggled();
}

class CrispyBaconToggled extends ItemsViewEvent {
  const CrispyBaconToggled();
}

class QuantityIncremented extends ItemsViewEvent {
  const QuantityIncremented();
}

class QuantityDecremented extends ItemsViewEvent {
  const QuantityDecremented();
}
