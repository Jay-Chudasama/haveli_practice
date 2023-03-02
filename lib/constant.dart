import 'package:dio/dio.dart';
import 'package:haveliapp/utils.dart';


final Dio DIO = Dio();
final Options TOKEN_HEADER = Options(
  headers: {
    "Authorization":TOKEN
  }
);

const String BASE_URL = "http://192.168.1.2:8000";

const String UNAUTHENTICATED = "unauthenticated_user";