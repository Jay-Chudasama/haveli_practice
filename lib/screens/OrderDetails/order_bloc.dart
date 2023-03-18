import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/model/Order_details_model.dart';
import 'package:haveliapp/screens/OrderDetails/order_event.dart';
import 'package:haveliapp/screens/OrderDetails/order_repo.dart';
import 'package:haveliapp/screens/OrderDetails/order_state.dart';

import '../../constant.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsRepo repo = OrderDetailsRepo();

  OrderDetailsBloc() : super(Init()) {
    on<OrderDetails>((event, emit) async {
      emit(Loading());
      try {
        var response = await repo.order_details_repo(event.id);
        OrderDetailsModel model = OrderDetailsModel.fromJson(response.data);
        emit(Loaded(model));
      } catch (value) {
        print(value);
        DioError error = value as DioError;
        if (error.response != null) {
          if (error.response!.statusCode == 403 ||
              error.response!.statusCode == 401) {
            emit(Failed(UNAUTHENTICATED));
          } else if (error.response!.data == "COMMING SOON...") {
            emit(Failed(error.response!.data));
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

    on<Rating>((event, emit) async {
      try {
        var response = await repo.ratingApi(event.id, event.rating);
      } catch (value) {};
    });
  }
}
