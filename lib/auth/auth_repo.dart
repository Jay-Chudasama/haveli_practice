import '../constant.dart';

class AuthRepo {
  Future<dynamic> userDetailsApi() async {
    var response =
        await DIO.get("$BASE_URL/api/userdetails/", options: TOKEN_HEDER);
    return response;
  }
}
