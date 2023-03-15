import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/phone/phone_state.dart';

import 'phone_repo.dart';

class PhoneCubit extends Cubit<PhoneState> {
  PhoneCubit() : super(Init());
  PhoneRepo repo = PhoneRepo();

  void getOtp(String phone) {
    emit(Submitting());
    repo.getOtpApi(phone).then((response) {
      print(response);
      emit(Submitted());
    }).catchError((value) {
      print(value);
      DioError error = value;
      if (error.response != null) {
        try {
          emit(Failed(error.response!.data));
        } catch (e) {
          emit(Failed(error.response!.data['detail']));
        }
      } else {
        if (error.type == DioErrorType.unknown) {
          emit(Failed("please check your internate"));
        } else {
          emit(Failed(error.message!));
        }
      }
    });
  }
}
