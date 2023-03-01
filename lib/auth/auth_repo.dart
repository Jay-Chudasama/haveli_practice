import 'package:dio/dio.dart';
import 'package:haveliapp/constant.dart';
import 'package:haveliapp/utils.dart';

import '../mock_adapter.dart';

class AuthRepo {
  Future<dynamic> userDetailsApi() async {
    //todo pass token in header
    var response = await DIO.get("$BASE_URL/api/userdetails/",
        options: Options(headers: {"Authorization": TOKEN}));
    return response;
  }
}
