import 'dart:io';

import 'package:dio/dio.dart';
import 'package:haveliapp/utils.dart';

import '../constant.dart';

class NotificationsRepository {
  final Dio dio = Dio();

  Future<Response> notifications() async {
    final response = await dio.get(BASE_URL + "/api/notifications/",
        queryParameters: {'limit': 8},
        options:TOKEN_HEDER
    );
    return response;
  }

  Future<Response> loadMore({required String nextUrl}) async {
    final response = await dio.get(nextUrl,
        options:TOKEN_HEDER);
    return response;
  }
}