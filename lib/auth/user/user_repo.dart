import '../../constant.dart';

class UserRepo {
  Future<dynamic> addToCart(int id) async {
    var response = await DIO
        .post("$BASE_URL/api/add/", options: TOKEN_HEDER, data: {"id": id});
    return response;
  }

  Future<dynamic> removeToCart(int id) async {
    var response = await DIO
        .post("$BASE_URL/api/remove/", options: TOKEN_HEDER, data: {"id": id});
    return response;
  }
}
