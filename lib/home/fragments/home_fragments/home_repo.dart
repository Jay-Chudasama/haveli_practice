import 'package:haveliapp/constant.dart';

class HomeRepo {
  Future<dynamic> loadMenu() async {
    var response = await DIO.get("$BASE_URL/api/menu/", options: TOKEN_HEDER);
    return response;
  }


}
