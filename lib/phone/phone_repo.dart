
import '../constant.dart';
import '../mock_adapter.dart';

class PhoneRepo {
  Future<dynamic> getOtpApi(String phone) async {
print(phone);
    var response = await DIO.post(
      "$BASE_URL/getotp/");
    return response;
  }
}
