abstract class HomeEvent {}

class MenuLoad extends HomeEvent {
}

class AddToCart extends HomeEvent {
  int id;

  AddToCart(this.id);
}
