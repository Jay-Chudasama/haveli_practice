import 'package:dio/dio.dart';

class Repo {
  static Future<dynamic> loadTodos() async {
    var response = await Dio().get("http://192.168.1.5:8000/api/todos/");
    return response;
  }

  static Future<dynamic> serchTodo(String search) async {
    var response = await Dio().get("http://192.168.1.5:8000/api/searchtodo/",
        queryParameters: {'search': search});
    return response;
  }

  static Future<dynamic> markasComplet(int id) async {
    var responce = await Dio().get(
        "http://192.168.1.5:8000/api/mark_as_complete/",
        queryParameters: {'id': id});
    return responce;
  }

  static Future<dynamic> remove(int id) async {
    var response = await Dio().get("http://192.168.1.5:8000/api/remove/",
        queryParameters: {"id": id});
    return response;
  }

  static Future<dynamic> addTodo(String todo) async {
    var response = await Dio()
        .post("http://192.168.1.5:8000/api/addtodo/", data: {'todo': todo});
    return response;
  }
}
