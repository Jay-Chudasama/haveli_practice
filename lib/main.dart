import 'package:flutter/material.dart';
import 'package:haveliapp/Otp/otp_screen.dart';
import 'package:haveliapp/home/home_screen.dart';
import 'package:haveliapp/phone/phone_screen.dart';

import 'Location/location_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
