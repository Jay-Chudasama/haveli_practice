import 'package:dio/dio.dart';

class HomeRepo{


  Future<dynamic> loadJoke() async {

    var response = await Dio().get("https://official-joke-api.appspot.com/random_joke");
    return response;

  }


}