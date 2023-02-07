import 'package:dio/dio.dart';

class Repo{


  static Future<dynamic>  getData() async {

    try {
      dynamic response = await Dio().get("https://jsonplaceholder.typicode.com/todos");
      return response;
    } catch (e) {
      print(e);
    }

  }


}