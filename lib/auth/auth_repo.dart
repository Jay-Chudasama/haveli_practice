import 'package:dio/dio.dart';
import 'package:haveliapp/constant.dart';

class AuthRepo {
  Future<dynamic> loadUserDetailsApi() async {
    var response =
        await DIO.get("$BASE_URL/api/userdetails/", options: TOKEN_HEADER);
    return response;
  }
}
