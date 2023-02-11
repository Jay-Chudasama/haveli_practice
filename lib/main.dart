import "package:flutter/material.dart";
import 'package:haveliapp/screens/home_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "haveli app",
      home: HomeScreen(),
    );
  }
}
