import 'package:haveliapp/constant.dart';
import 'package:haveliapp/utils.dart';

class ProfileRepo {
  Future<dynamic> name(String name) async {
    var response = await DIO.post("$BASE_URL/api/name/",
        options: TOKEN_HEDER, data: {"name": name});
    return response;
  }
}