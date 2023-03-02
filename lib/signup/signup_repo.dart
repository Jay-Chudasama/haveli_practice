import 'package:haveliapp/constant.dart';

class SignUpRepo {
  Future<dynamic> signUpApi(String email, String password) async {
    var response = await DIO.post("$BASE_URL/api/createaccount/", data: {
      "email": email,
      "password": password,
    });
    return response;
  }
}
