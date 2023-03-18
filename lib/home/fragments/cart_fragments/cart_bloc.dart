import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_event.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_repo.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_state.dart';
import 'package:haveliapp/model/cart_model.dart';

import '../../../constant.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepo cartRepo = CartRepo();

  CartBloc() : super(Init()) {
    on<Cart>((event, emit) async {
      emit(Loading());
      try {
        var response = await cartRepo.cartItem();
        print(response);
        List<CartModel> list = response.data['cart'].map<CartModel>((json) {
          return CartModel.fromJson(json);
        }).toList();
        emit(Loaded(list,response.data['delivery_charge']));
      } catch (value) {
        DioError error = value as DioError;
        if (error.response != null) {
          if (error.response!.statusCode == 403 ||
              error.response!.statusCode == 401) {
            emit(Failed(UNAUTHENTICATED));
          } else {
            emit(Failed("Something went wrong!"));
          }
        } else {
          if (error.type == DioErrorType.unknown) {
            emit(Failed("Connection Failed"));
          } else {
            emit(Failed("${error.message}"));
          }
        }
      }
      ;
    });
    on<Remove>((event, emit) {
      (state as Loaded).list.remove(event.model);
      emit(Loaded((state as Loaded).list,(state as Loaded).deliveryCharge));
    });

    on<UpdateQty>((event, emit) async {
      emit(Loaded((state as Loaded).list,(state as Loaded).deliveryCharge));
      try {
        var response = await cartRepo.updateQty(event.id, event.qty);
      } catch (value) {
        DioError error = value as DioError;
        if (error.response != null) {
          if (error.response!.statusCode == 403 ||
              error.response!.statusCode == 401) {
            emit(Failed(UNAUTHENTICATED));
          } else {
            emit(Failed("Something went wrong!"));
          }
        } else {
          if (error.type == DioErrorType.unknown) {
            emit(Failed("Connection Failed"));
          } else {
            emit(Failed("${error.message}"));
          }
        }
      }
    });

    on<InitiatePayment>((event, emit) async {
      emit(InitiatingPayment((state as Loaded).list,(state as Loaded).deliveryCharge));
      try {
        var response = await cartRepo.initiatePayment(event.totalAmount, event.address);
        emit(PaymentInitiated((state as Loaded).list,(state as Loaded).deliveryCharge,response.data['key'],response.data['orderId']));
      } catch (value) {
        DioError error = value as DioError;
        if (error.response != null) {
          if (error.response!.statusCode == 403 ||
              error.response!.statusCode == 401) {
            emit(Failed(UNAUTHENTICATED));
          } else {
            emit(Failed("Something went wrong!"));
          }
        } else {
          if (error.type == DioErrorType.unknown) {
            emit(Failed("Connection Failed"));
          } else {
            emit(Failed("${error.message}"));
          }
        }
      }
    });

    on<VerifyPayment>((event, emit) async {
      emit(VerifyingPayment((state as Loaded).list,(state as Loaded).deliveryCharge));
      try {
        var response = await cartRepo.verifyPayment(event.orderId, event.paymentId,event.signature);

        emit(Verified());
      } catch (value) {
        DioError error = value as DioError;
        if (error.response != null) {
          if (error.response!.statusCode == 403 ||
              error.response!.statusCode == 401) {
            emit(Failed(UNAUTHENTICATED));
          } else {
            emit(Failed("Something went wrong!"));
          }
        } else {
          if (error.type == DioErrorType.unknown) {
            emit(Failed("Connection Failed"));
          } else {
            emit(Failed("${error.message}"));
          }
        }
      }
    });


    on<PaymentFailure>((event, emit) async {
      emit(VerifyingPayment((state as Loaded).list,(state as Loaded).deliveryCharge));
      try {
        var response = await cartRepo.paymentFailed(event.orderId);
        emit(PaymentFailed((state as Loaded).list, (state as Loaded).deliveryCharge));
      } catch (value) {
        DioError error = value as DioError;
        if (error.response != null) {
          if (error.response!.statusCode == 403 ||
              error.response!.statusCode == 401) {
            emit(Failed(UNAUTHENTICATED));
          } else {
            emit(Failed("Something went wrong!"));
          }
        } else {
          if (error.type == DioErrorType.unknown) {
            emit(Failed("Connection Failed"));
          } else {
            emit(Failed("${error.message}"));
          }
        }
      }
    });


  }
}
