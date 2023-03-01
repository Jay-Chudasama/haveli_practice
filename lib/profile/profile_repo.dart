import 'dart:io';

import 'package:dio/dio.dart';
import 'package:haveliapp/utils.dart';

import '../constant.dart';

class ProfileRepo {
  Future<dynamic> postProfileApi(String username, File? image) async {
    FormData formData = FormData.fromMap({"name": username});
    if (image != null) {
      String fileName = image.path.split('/').last;

      formData = FormData.fromMap({
        "name": username,
        "file": await MultipartFile.fromFile(image.path, filename: fileName),
      });
    }
    var response = await DIO.post("$BASE_URL/api/updateprofile/",options: Options(
      headers: {
        "Authorization":TOKEN
      }
    ), data: formData);
    return response;
  }

  Future<dynamic> logoutApi() async {

    var response = await DIO.get("$BASE_URL/api/logout/",options: Options(
      headers: {
        "Authorization":TOKEN
      }
    ));

    return response;

  }
}
