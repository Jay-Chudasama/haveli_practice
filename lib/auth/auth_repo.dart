import 'package:haveliapp/constants.dart';

class AuthRepo {
  Future<dynamic> loadUserDetailApi() async {
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
