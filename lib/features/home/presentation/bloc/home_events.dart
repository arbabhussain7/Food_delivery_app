abstract class HomeEvent {
  const HomeEvent();
}

class HomeCarouselChanged extends HomeEvent {
  final int index;
  const HomeCarouselChanged(this.index);
}

class ProductsFetchRequested extends HomeEvent {
  const ProductsFetchRequested();
}
