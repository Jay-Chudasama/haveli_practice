import 'dart:io';

import 'package:haveliapp/constants.dart';
import 'package:dio/dio.dart';

class ProfileRepo {
  Future<dynamic> setUpAccount(String username, File? image) async {
    FormData formdata = FormData.fromMap({"username": username});
    if (image != null) {
      String fileName = image.path.split('./').last;
      formdata = FormData.fromMap({
        "username": username,
        "image": await MultipartFile.fromFile(image.path, filename: fileName)
      });
    }
    var response = await DIO.post("$BASE_URL/api/setupaccount/",
        options: TOKEN_HEDER, data: formdata);
    return response;
  }
}
