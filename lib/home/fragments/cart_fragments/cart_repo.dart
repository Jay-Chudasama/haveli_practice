import 'package:haveliapp/constant.dart';

class CartRepo {
  Future<dynamic> cartItem() async {
    var response = await DIO.get("$BASE_URL/api/mycart/", options: TOKEN_HEDER);
    return response;
  }
}
