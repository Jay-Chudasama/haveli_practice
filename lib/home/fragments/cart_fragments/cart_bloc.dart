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
        List<CartModel> list = response.data.map<CartModel>((json) {
          return CartModel.fromJson(json);
        }).toList();
        emit(Loaded(list));
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
  }
}
