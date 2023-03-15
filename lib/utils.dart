import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:haveliapp/auth/auth_cubit.dart';

final storage = FlutterSecureStorage();

String? TOKEN;
AuthCubit authCubit = AuthCubit();
Future<void> storeToken(String token)async{
  TOKEN = token;
  await storage.write(key: "token", value: token);
}

Future<void> getToken()async{
  TOKEN = await storage.read(key: "token");
}

Future<void> deletToke()async{
  TOKEN = null;
await storage.delete(key: "token");
}