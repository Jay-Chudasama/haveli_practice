import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
String? TOKEN;

Future<void> storeToken(String token) async {
  TOKEN = token;
  print(TOKEN);
  await storage.write(key: "token", value: token);
}

Future<void> getToken() async {
  TOKEN = await storage.read(key: "token");
}

Future<void> deletToken() async {
  TOKEN = null;
  await storage.delete(key: "token");
}

bool validEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
