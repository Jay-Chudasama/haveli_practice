import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/fragments/orders_fragments/orders_event.dart';
import 'package:haveliapp/home/fragments/orders_fragments/orders_repo.dart';
import 'package:haveliapp/home/fragments/orders_fragments/orders_state.dart';
import 'package:haveliapp/model/order_model.dart';

import '../../../constant.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrdersRepo repo = OrdersRepo();

  OrderBloc() : super(Init()) {
    on<Order>((event, emit) async {
      emit(Loading());
      try {
        var response = await repo.orderListApi();
        print(response);
        List<Ordermodel> list =
            response.data['results'].map<Ordermodel>((json) {
          return Ordermodel.fromJson(json);
        }).toList();
        emit(Loaded(list, response.data['next']));
      } catch (value) {
        print(value);
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

    on<LoadMore>((event, emit) async {
      emit(LoadingMore((state as Loaded).list, (state as Loaded).nextUrl));
      try {
        var response = await repo.loadeMore(event.nextUrl);
        List<Ordermodel> list = (state as Loaded).list +
            response.data['results'].map<Ordermodel>((json) {
              return Ordermodel.fromJson(json);
            }).toList();
        emit(Loaded(list, response.data['next']));
      } catch (value) {
        print(value);
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
