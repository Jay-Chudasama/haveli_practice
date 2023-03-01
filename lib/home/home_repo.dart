import 'package:dio/dio.dart';
import 'package:haveliapp/constant.dart';
import 'package:haveliapp/utils.dart';

class HomeRepo {
  Future<dynamic> newsApi() async {
    var response = await DIO.get("$BASE_URL/api/news/",options: Options(
      headers: {
        "Authorization":TOKEN
      }
    ));
    return response;
  }
}
