import '../constant.dart';
import '../utils.dart';

class AuthRepo {
  Future<dynamic> userDetailsApi() async {
    var response =
        await DIO.get("$BASE_URL/api/userdetails/", options: TOKEN_HEDER);
    return response;
  }

  Future<dynamic> logout() async {
    var response =
    await DIO.get("$BASE_URL/api/logout/", options: TOKEN_HEDER);
    return response;
  }
}
