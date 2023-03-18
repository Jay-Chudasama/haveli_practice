import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_repo.dart';
import 'package:haveliapp/auth/auth_state.dart';
import 'package:haveliapp/model/User_model.dart';
import 'package:haveliapp/utils.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(Init());
  AuthRepo repo = AuthRepo();

  Future<void> loaduserDetails() async {
    emit(Authenticating());
    try {
      var response = await repo.userDetailsApi();
      emit(Authenticated(UserModel.fromJson(response.data)));
    } catch (value) {
      print(value);
      DioError error = value as DioError;
      if (error.response != null) {
        if (error.response!.statusCode == 401 ||
            error.response!.statusCode == 403) {
          deletToke();
          emit(UnAuthenticated());
        } else {
          try {
            emit(Failed(error.response!.data));
          } catch (e) {
            emit(Failed(error.response!.data['detail']));
          }
        }
      } else {
        if (error.type == DioErrorType.unknown) {
          emit(Failed("please check your internate connection"));
        } else {
          emit(Failed(error.message!));
        }
      }
    }
  }

  Future<void> logout() async {
    try {
      var response = await repo.logout();
    } catch (value) {
      print(value);
    }
    emit(UnAuthenticated());
  }
}
