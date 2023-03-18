import '../../../model/cart_model.dart';

abstract class CartState {}

class Init extends CartState {}

class Loading extends CartState {}

class Loaded extends CartState {
  List<CartModel> list;
  int deliveryCharge;
  Loaded(this.list,this.deliveryCharge);
}

class InitiatingPayment extends Loaded{
  InitiatingPayment(super.list, super.deliveryCharge);

}

class VerifyingPayment extends Loaded{
  VerifyingPayment(super.list, super.deliveryCharge);

}

class Verified extends CartState{}

class PaymentInitiated extends Loaded{

  String key,orderId;

  PaymentInitiated(super.list, super.deliveryCharge,this.key,this.orderId);

}

class PaymentFailed extends Loaded{

  PaymentFailed(super.list, super.deliveryCharge);

}

class Failed extends CartState {
  String message;

  Failed(this.message);
}
