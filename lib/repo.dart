import 'package:dio/dio.dart';

class Repo {
  static Future<dynamic> loadTodos() async {
    var response = await Dio().get("http://192.168.1.5:8000/api/todos/");
    return response;
  }

  static Future<dynamic> serchTodo(String search) async{
    var response = await Dio().get("http://192.168.1.5:8000/api/searchtodo/",queryParameters:{'search' : search});
    return response;
  }
}


