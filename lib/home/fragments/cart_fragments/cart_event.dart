import 'package:haveliapp/model/cart_model.dart';

abstract class CartEvent {}

class Cart extends CartEvent {}

class Remove extends CartEvent {
  CartModel model;

  Remove(this.model);
}

class UpdateQty extends CartEvent {
  int id;
  int qty;

  UpdateQty(this.id, this.qty);
}

class InitiatePayment extends CartEvent{
  String address;
  int totalAmount;

  InitiatePayment(this.address, this.totalAmount);
}


class VerifyPayment extends CartEvent{
  String orderId,paymentId,signature;

  VerifyPayment(this.orderId, this.paymentId, this.signature);
}

class PaymentFailure extends CartEvent{
  String orderId;

  PaymentFailure(this.orderId);
}