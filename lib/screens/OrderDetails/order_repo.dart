import 'package:haveliapp/constant.dart';
import 'package:haveliapp/utils.dart';

class OrderDetailsRepo {
  Future<dynamic> order_details_repo(String id) async {
    var response = await DIO.get("$BASE_URL/api/orderdetails/",
        options: TOKEN_HEDER, queryParameters: {"id": id});
    return response;
  }

  Future<dynamic> ratingApi(String id, int rating) async {
    var response = await DIO.get("$BASE_URL/api/rating/",
        options: TOKEN_HEDER, queryParameters: {"id": id, "rating": rating});
    return response;
  }
}
