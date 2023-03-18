import 'package:haveliapp/constant.dart';

import '../../../utils.dart';

class CartRepo {
  Future<dynamic> cartItem() async {
    var response = await DIO.get("$BASE_URL/api/mycart/", options: TOKEN_HEDER,queryParameters: {
      "area":AREA
    });
    return response;
  }

  Future<dynamic> updateQty(int id, int qty) async {
    var response = await DIO.get("$BASE_URL/api/updateqty/",
        options: TOKEN_HEDER, queryParameters: {"id": id, "qty": qty});
    return response;
  }

  Future<dynamic> initiatePayment(int totalAmount,String address) async {
    var response = await DIO.post("$BASE_URL/api/initiatepayment/",
        options: TOKEN_HEDER, data: {"total_amount": totalAmount, "area": AREA,'address':address});
    return response;
  }

  Future<dynamic> verifyPayment(String orderId,String paymentId,String signature) async {
    var response = await DIO.post("$BASE_URL/api/verifypayment/",
        options: TOKEN_HEDER, data: {"id": orderId, "py_id": paymentId,'signature':signature});
    return response;
  }

  Future<dynamic> paymentFailed(String orderId) async {
    var response = await DIO.post("$BASE_URL/api/paymentfailed/",
        options: TOKEN_HEDER, data: {"id": orderId});
    return response;
  }
}
