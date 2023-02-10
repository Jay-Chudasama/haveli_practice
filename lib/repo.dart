import 'package:dio/dio.dart';

class Repo {

  static Future<dynamic> getData() async {
    dynamic response =
        await Dio().get("http://192.168.1.5:8000/api/schooldetail/");
    return response;
  }

}
