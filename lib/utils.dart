import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

String? TOKEN;

Future<void> storeToken(String token) async{
  TOKEN = token;
  await storage.write(key: "token", value: token);
}


Future<void> getToken() async{
  TOKEN = await storage.read(key: "token");
}

Future<void> deleteToken() async{
  TOKEN = null;
   await storage.delete(key: "token");
}

