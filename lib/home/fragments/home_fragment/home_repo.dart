import 'dart:io';

import 'package:dio/dio.dart';
import 'package:haveliapp/constants.dart';

class HomeRepo {
  Future<dynamic> loadStories() async {
    var response =
        await DIO.get("$BASE_URL/api/stories/", options: TOKEN_HEDER);
    return response;
  }

  Future<dynamic> uploadStories(List<File> files) async {
    var formData = FormData();
    for (File file in files) {
      formData.files.addAll([
        MapEntry("story", await MultipartFile.fromFile(file.path)),
      ]);
    }

    var response = await DIO.post("$BASE_URL/api/uploadstory/",
        data: formData, options: TOKEN_HEDER);
    return response;
  }

  Future<dynamic> deletstory(int id) async {
    var response = await DIO.get("$BASE_URL/api/deletstory/",
        queryParameters: {"id": id}, options: TOKEN_HEDER);
    return response;
  }
}
