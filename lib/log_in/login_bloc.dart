import 'package:haveliapp/log_in/login_event.dart';
import 'package:haveliapp/log_in/login_repo.dart';
import 'package:haveliapp/log_in/login_state.dart';
import 'package:haveliapp/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(Init()) {
    LoginRepo repo = LoginRepo();
    on<Login>((event, emit) async { 
      emit(Submitting());
      try {
        var response = await repo.loginApi(event.email, event.password);
        String token = response.data['token'];
        try {
          await storeToken(token);
        } catch (e) {
          //todo nothing
        }
        emit(LoggedIn());
      } catch (value) {
        DioError error = value as DioError;
        if (error.response != null) {
          emit(Failed(error.response!.data));
        } else {
          if (error.type == DioErrorType.unknown) {
            emit(Failed("please check your internate connection"));
          } else {
            emit(Failed("${error.message}"));
          }
        }
      }
    });
  }
}
