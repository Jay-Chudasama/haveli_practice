import 'package:haveliapp/constant.dart';

class LoginRepo{

  Future<dynamic> loginApi(email,password)async{
    var response = await DIO.post("$BASE_URL/api/login/",data: {
      "email":email,
      "password":password,
    });
    return response;
  }

}