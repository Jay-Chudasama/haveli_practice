// ignore_for_file: unused_local_variable, avoid_print

import 'package:haveliapp/forget_password/forget_password_event.dart';
import 'package:haveliapp/forget_password/forget_password_repo.dart';
import 'package:haveliapp/forget_password/forget_password_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetBloc extends Bloc<ForgetEvent, ForgetState> {
  Forget repo = Forget();
  ForgetBloc() : super(Init()) {
    on<ForgetPassword>((event, emit) async {
      emit(Submitting());
      try {
        var response = await repo.forgetRepo(event.email);
        print(response);
        emit(Submited());
      } catch (value) {
        print(value);
        print("hoi");
        DioError error = value as DioError;
        if (error.response != null) {
          print("Dio..");
          emit(Failed(error.response!.data));
        } else {
          if (error.type == DioErrorType.unknown) {
            emit(Failed("Please check Your internat Connection"));
          } else {
            // print(value);
            emit(Failed("${error.message}"));
          }
        }
      }
    });
  }
}
