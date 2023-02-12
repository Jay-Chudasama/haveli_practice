import 'package:dio/dio.dart';
import 'package:haveliapp/utils.dart';

class Repo {

  static Future<dynamic> postData(String email, String password) async{
    var reponce = await Dio().post("http://192.168.1.5:8000/api/login/", data: {
      'email': email,
      'password': password,
    });
    return reponce;
  }

  static Future<dynamic> like() async{
    String token = await getToken();
    var responce = await Dio().get("http://192.168.1.5:8000/api/like/",options: Options(headers: {
      'authorization' : token
    }));
    return responce;
  }
}

