import 'package:haveliapp/constants.dart';

class AuthRepo {
  Future<dynamic> loadUserDetailApi() async {
    var response =
        await DIO.get("$BASE_URL/api/userdetails/", options: TOKEN_HEDER);
    return response;
  }
}
