import 'package:flutter_secure_storage/flutter_secure_storage.dart';

bool validEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool validUser(String username) {
  return RegExp("^[A-Za-z][A-Za-z0-9_]{7,29}").hasMatch(username);
}

final storage = FlutterSecureStorage();

Future<void> storeToken(String token) async {
  await storage.write(key: "token", value: token);
}

Future<String> getToken() async {
  String token = await storage.read(key: "token");
  print(token);
  return token;
}

Future<void> deletToken() async {
  await storage.delete(key: "token");
}

Function? reloadMainScreen;
