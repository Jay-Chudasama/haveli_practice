import 'package:dio/dio.dart';
import 'package:haveliapp/utils.dart';

import 'constants.dart';

class Repo{


 static Future<dynamic> login(String email,password) async {
    var response = await Dio().post("$BASE_URL/api/login/",data: {
      "email":email,
      "password":password,
    });
    return response;
  }


 static Future<dynamic> loadUsers() async {
   String? token = await getToken();
   var response = await Dio().get("$BASE_URL/api/users/",options: Options(headers: {
     "Authorization":token
   }));
   return response;
 }

}