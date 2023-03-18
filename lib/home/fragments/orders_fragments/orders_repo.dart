import 'package:haveliapp/constant.dart';
import 'package:haveliapp/utils.dart';

class OrdersRepo {
  Future<dynamic> orderListApi() async {
    var response = await DIO.get("$BASE_URL/api/orders/",
        options: TOKEN_HEDER, queryParameters: {"limit": 2});
    return response;
  }
  Future<dynamic> loadeMore(String nextUrl) async {
    var response = await DIO.get(nextUrl, options: TOKEN_HEDER);
    return response;
  }

}
