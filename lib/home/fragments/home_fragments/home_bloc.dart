import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/constant.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_event.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_repo.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_state.dart';
import 'package:haveliapp/model/MenuModel.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepo repo = HomeRepo();

  HomeBloc() : super(Init()) {
    on<MenuLoad>((event, emit) async {
      emit(Loading());
      try {
        var response = await repo.loadMenu();

        emit(Loaded(response.data['type'] == null
            ? null
            : MenuModel.fromJson(response.data)));
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
  }
}
