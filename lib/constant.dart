import 'package:dio/dio.dart';
import 'package:haveliapp/utils.dart';

final Dio DIO = Dio();
const String BASE_URL = 'http://192.168.1.14:8000';
const String UNAUTHENTICATED = "unauthenticated_user";

Options TOKEN_HEDER = Options(headers: {'Authorization': TOKEN});
