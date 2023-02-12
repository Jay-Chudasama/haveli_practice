import "package:flutter/material.dart";
import 'package:haveliapp/screen/home_screen.dart';
import 'package:haveliapp/screen/login_screen.dart';
import 'package:haveliapp/utils.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "haveli app",
      home: widget.token == null
          ? LoginScreen((String token) {
              setState(() {
                widget.token = token;
              });
            })
          : HomeScreen((){
            setState(() {
              widget.token=null;
            });
      }),
    );
  }
}
