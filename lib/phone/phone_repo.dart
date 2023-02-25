import 'package:dio/dio.dart';

import '../constant.dart';

class PhoneRepo {
  Future<dynamic> getOtpApi() async{
//todo
  var response = await DIO.post("");
  return response;
  }
}
