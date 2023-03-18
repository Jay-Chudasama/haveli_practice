import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:haveliapp/constant.dart';

class OtpRepo {
  Future<dynamic> verifyOtp(String phone, String otp) async {
    final String? fcmtoken = await FirebaseMessaging.instance.getToken();
    var response = await DIO
        .post("$BASE_URL/api/verifyotp/", data: {"phone": phone, "otp": otp,'fcmtoken':fcmtoken});
    return response;
  }

  Future<dynamic> resendOtpApi(String phone) async {
    var response = await DIO
        .post("$BASE_URL/api/getotp/", data: {"phone": phone});
    return response;
  }
}
