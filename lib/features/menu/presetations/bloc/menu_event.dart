abstract class MenuEvent {
  const MenuEvent();
}

class MenuProductsFetchRequested extends MenuEvent {
  const MenuProductsFetchRequested();
}

class MenuSearchChanged extends MenuEvent {
  final String query;
  const MenuSearchChanged(this.query);
}
