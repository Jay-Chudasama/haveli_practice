import 'package:dio/dio.dart';

import '../constant.dart';

class PhoneRepo {
  Future<dynamic> getOtpApi(String phone) async{
    print(phone);
//todo
  var response = await DIO.post("");
  return response;
  }
}
