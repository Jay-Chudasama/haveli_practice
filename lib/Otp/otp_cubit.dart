import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/Otp/otp_repo.dart';
import 'package:haveliapp/Otp/otp_state.dart';
import 'package:haveliapp/utils.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(Init());
  OtpRepo repo = OtpRepo();

  verifyOtp(String otp, String phone) {
    emit(Submitting());
    repo.verifyOtp(phone, otp).then((response) {
      String token = response.data['token'];
      storeToken(token).then((value) {
        emit(Verifyed());
      });
      print(response);
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
          emit(Failed("please check your internate connection"));
        } else {
          emit(Failed(error.message!));
        }
      }
    });
  }

  void resendOtp(String phone) {
    repo.resendOtpApi(phone).then((value) {
      //doNothing
    }).catchError((value) {
      //doNothing
    });
  }
}
