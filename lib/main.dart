import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haveliapp/screens/home_screen.dart';
import 'package:haveliapp/utils.dart';

import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? token = await getToken();

  runApp(MyApp(token));
}

class MyApp extends StatefulWidget {
  String? token;

  MyApp(this.token);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    reloadMainScreen =(String token){
      setState(() {
        widget.token = token;
      });
    };

    return MaterialApp(
      title: "ChatApp",
      debugShowCheckedModeBanner: false,
      home: widget.token == null ? LoginScreen() : HomeScreen(),
    );
  }
}
