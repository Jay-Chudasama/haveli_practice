import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/phone/phone_repo.dart';
import 'package:haveliapp/phone/phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {
  PhoneCubit() : super(Init());
  PhoneRepo phonerepo = PhoneRepo();

  void getOtp() {
    emit(Submiting());
    phonerepo.getOtpApi().then((response) {
      emit(Submited());
    }).catchError(
      (value) {
        DioError error = value;
        if (error.response != null) {
          try {
            emit(Failed(error.response!.data));
          } catch (e) {
            emit(Failed(error.response!.data['detail']));
          }
        } else {
          if (error.type == DioErrorType.connectionTimeout) {
            emit(Failed("Please check your internt connection"));
          } else {
            emit(Failed(error.message));
          }
        }
      },
    );
  }
}
