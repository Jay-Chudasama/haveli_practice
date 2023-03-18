import 'package:haveliapp/model/order_model.dart';

abstract class OrderState {}

class Init extends OrderState {}

class Loading extends OrderState {}

class Loaded extends OrderState {
  List<Ordermodel> list;
  String? nextUrl;

  Loaded(this.list, this.nextUrl);
}

class LoadingMore extends Loaded {
  LoadingMore(super.list, super.nextUrl);
}

class Failed extends OrderState {
  String message;

  Failed(this.message);
}
