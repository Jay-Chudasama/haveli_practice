import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/otp/otp_repo.dart';
import 'package:haveliapp/otp/otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(Init());
  OtpRepo otprepo = OtpRepo();

  void verifyOtp(String otp) {
    emit(Submiting());
    otprepo.verifyOtp(otp).then((response) {
      emit(Verifyed());

      //todo
    }).catchError((value) {
      DioError error = value;
      if (error.response != null) {
        try {
          emit(FAiled(error.response!.data));
        } catch (e) {
          emit(FAiled(error.response!.data['detail']));
        }
      } else {
        if (error.type == DioErrorType.unknown) {
          emit(FAiled("please check your internate connection"));
        } else {
          print(value);
          emit(FAiled(error.message));
        }
      }
    });
  }

  void resendOtp(String phone) {
    otprepo.resendOtpApi(phone).then((value) {
      //doNothing
    }).catchError((value) {
      //doNothing
    });
  }
}
