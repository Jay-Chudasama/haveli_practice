import 'package:dio/dio.dart';
import 'package:haveliapp/constant.dart';
import 'package:haveliapp/utils.dart';

import '../mock_adapter.dart';

class OtpRepo {
  Future<dynamic> verifyOtp(String phone,String otp) async {
    var response = await DIO.post(
      "$BASE_URL/api/verifyotp/",data: {
        "phone":phone,
        "otp":otp,
    }
    );
    return response;
  }

  Future<dynamic> resendOtpApi(String phone) async {
    var response = await DIO.post(
        "$BASE_URL/api/getotp/",data: {
      "phone":phone
    });
    return response;
  }
}
