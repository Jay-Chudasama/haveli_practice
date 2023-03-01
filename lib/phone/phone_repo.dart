
import '../constant.dart';
import '../mock_adapter.dart';

class PhoneRepo {
  Future<dynamic> getOtpApi(String phone) async {
    var response = await DIO.post(
      "$BASE_URL/api/getotp/",data: {
        "phone":phone
    });
    return response;
  }
}
