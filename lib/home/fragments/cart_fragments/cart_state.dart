import '../../../model/cart_model.dart';

abstract class CartState {}

class Init extends CartState {}

class Loading extends CartState {}

class Loaded extends CartState {
  List<CartModel> list;
  Loaded(this.list);
}

class Failed extends CartState {
  String message;

  Failed(this.message);
}
