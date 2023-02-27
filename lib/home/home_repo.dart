import 'package:haveliapp/constant.dart';

class HomeRepo {
  Future<dynamic> newsApi() async {
    var response = await DIO.get("$BASE_URL/newslist/");
    return response;
  }
}
