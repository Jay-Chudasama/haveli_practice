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
    var response = await DIO.get("$BASE_URL/api/deletestory/",
        queryParameters: {"id": id}, options: TOKEN_HEDER);
    return response;
  }

  Future<dynamic> loadFeeds() async {
    var response = await DIO.get("$BASE_URL/api/homefeeds/",
        queryParameters: {"limit": 1}, options: TOKEN_HEDER);
    return response;
  }

  Future<dynamic> loadeMore(String nextUrl) async {
    var response = await DIO.get(nextUrl, options: TOKEN_HEDER);
    return response;
  }
  Future<dynamic> addPost(String caption, File? image) async {
    FormData formdata = FormData.fromMap({"caption": caption});
    if (image != null) {
      String fileName = image.path.split('./').last;
      formdata = FormData.fromMap({
        "caption": caption,
        "image": await MultipartFile.fromFile(image.path, filename: fileName)
      });
    }
    var response = await DIO.post("$BASE_URL/api/addpost/",
        options: TOKEN_HEDER, data: formdata);
    return response;
  }
}
