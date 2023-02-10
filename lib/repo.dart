import 'package:dio/dio.dart';

class Repo {

  static Future<dynamic> search(String query) async {
    dynamic response =
        await Dio().get("http://192.168.1.5:8000/api/searchorder/",queryParameters: {
          "search":query
        });
    return response;
  }

}
