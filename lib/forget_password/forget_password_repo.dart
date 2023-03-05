import 'package:haveliapp/constants.dart';

class Forget {
  Future<dynamic> forgetRepo(String email) async {
   
      var response = await DIO.get(
        "$BASE_URL/api/forgotpassword/",
        queryParameters: {"email": email},
      );
      return response;
    
  }
}
