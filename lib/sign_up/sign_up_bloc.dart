// ignore_for_file: unrelated_type_equality_checks, unused_local_variable

import 'package:haveliapp/sign_up/sign_up_event.dart';
import 'package:haveliapp/sign_up/sign_up_repo.dart';
import 'package:haveliapp/sign_up/sign_up_state.dart';
import 'package:haveliapp/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpRepo repo = SignUpRepo();

  SignUpBloc() : super(Init()) {
    on<SignUp>((event, emit) async {
      emit(Submitting());

      try {
        var response = await repo.signUpApi(event.email, event.password);
        String token = response.data['token'];
        try {
          await storeToken(token);
          print(response.data['token']);
          emit(Submitted());
        } catch (err) {
          //  do nothing
          print(err);
        }
      } catch (value) {
        DioError error = value as DioError;
        if (error.response != null) {
          if (error.response!.statusCode == 400) {
            print(error.response);
            emit(Failed(error.response!.data));
          } else {
            if (error.type == DioErrorType.unknown) {
              emit(Failed("Please check your internate Connection"));
            } else {
              emit(Failed(error.message.toString()));
            }
          }
        }
      }
    });
  }
}
