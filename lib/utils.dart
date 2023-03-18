import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:haveliapp/auth/auth_cubit.dart';

final storage = FlutterSecureStorage();

String? TOKEN;
late Options TOKEN_HEDER;
String AREA = "...";

AuthCubit authCubit = AuthCubit();
Future<void> storeToken(String token)async{
  TOKEN = token;
  TOKEN_HEDER = Options(headers: {'Authorization': TOKEN});
  await storage.write(key: "token", value: token);
}

Future<void> getToken()async{
  TOKEN = await storage.read(key: "token");
  TOKEN_HEDER = Options(headers: {'Authorization': TOKEN});
}

Future<void> deletToke()async{
  TOKEN = null;
  TOKEN_HEDER = Options(headers: {'Authorization': TOKEN});
  await storage.delete(key: "token");
}


class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack!();
        }
        break;
    }
  }
}