import 'package:haveliapp/constant.dart';

import '../../../utils.dart';

class HomeRepo {
  Future<dynamic> loadMenu(String area) async {
    var response = await DIO.get("$BASE_URL/api/menu/", options: TOKEN_HEDER,queryParameters: {
      "area":area
    });
    return response;
  }


}
