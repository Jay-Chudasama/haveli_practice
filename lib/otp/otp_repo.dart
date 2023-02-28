import 'package:dio/dio.dart';
import 'package:haveliapp/constant.dart';
import 'package:haveliapp/utils.dart';

import '../mock_adapter.dart';

class OtpRepo {
  Future<dynamic> verifyOtp(String otp) async {
    print(otp);
    var response = await DIO.post(
      "$BASE_URL/verifyotp/"
    );
    return response;
  }

  Future<dynamic> resendOtpApi(String phone) async {
    print(phone);
    var response = await DIO.post("$BASE_URL/getotp/");
    return response;
  }
}
