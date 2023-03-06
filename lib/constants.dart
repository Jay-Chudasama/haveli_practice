import 'package:haveliapp/utils.dart';
import 'package:dio/dio.dart';

const BASE_URL = "http://192.168.1.4:8000";

final Dio DIO = Dio();

const String UNAUTHENTICATED = "unauthenticated_user";

Options TOKEN_HEDER = Options(headers: {"Authorization":TOKEN});