import 'package:haveliapp/constants.dart';

class LoginRepo {
  Future<dynamic> loginApi(String email, String password) async {
    var response = await DIO.post("$BASE_URL/api/login/", data: {
      "email": email,
      "password":password,
    });
    return response;
  }
}
