import 'package:flutter/material.dart';
import 'package:haveliapp/screens/home_screen.dart';

void main(){

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Haveli app",
      home: HomeScreen(),
    );
  }
}
