

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/models/user_model.dart';
import 'package:haveliapp/profile/profile_repo.dart';
import 'package:haveliapp/profile/profile_state.dart';
import 'package:haveliapp/utils.dart';

import '../auth/auth_state.dart' as AuthState;
import '../constant.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(Init());
  ProfileRepo profilerepo = ProfileRepo();

  void updateProfile(String username,File? file) {
    emit(Submitting());
    profilerepo.postProfileApi(username,file).then((response) {
      authCubit.emit(AuthState.Authenticated(User.fromJson(response.data)));
      emit(Submited());
      //todo
    }).catchError((value) {
      //todo token pending
      DioError error = value;
      if (error.response != null) {
        if(error.response!.statusCode==401 || error.response!.statusCode==403){
          deletToken();
          authCubit.emit(AuthState.UnAuthenticated());
          emit(Failed(UNAUTHENTICATED));

        }else {
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
          emit(Failed(error.message));
        }
      }
    });
  }


  void logout(){
    emit(Submitting());
    profilerepo.logoutApi();
    deletToken();
    authCubit.emit(AuthState.UnAuthenticated());
  }
}
