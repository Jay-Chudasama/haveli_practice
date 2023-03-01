import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_repo.dart';
import 'package:haveliapp/auth/auth_state.dart';
import 'package:haveliapp/utils.dart';

import '../models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(Init());
  AuthRepo repo = AuthRepo();

  Future<void> loadUserDetails() async {
    print("authenticating....");
    try{
      var response = await repo.userDetailsApi();
      print(response);
      emit(Authenticated(User.fromJson(response.data)));
    }catch(value){
      print(value);
      DioError error = value as DioError;
      if (error.response != null) {
        if (error.response!.statusCode == 401 || error.response!.statusCode == 403) {
          emit(UnAuthenticated());
          deletToken();
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
          print(value);
          emit(Failed(error.message));
        }
      }
    }


   return;
  }
}
