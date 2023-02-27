import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/home_cubit.dart';
import 'package:haveliapp/home/home_screen.dart';
import 'package:haveliapp/phone/phone_cubit.dart';
import 'package:haveliapp/phone/phone_screen.dart';
import 'package:haveliapp/profile/profile_cubit.dart';
import 'package:haveliapp/profile/profile_screen.dart';

import 'mock_adapter.dart';

void main() {
  runApp(const MyApp());
  mockResponseAdapter();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) => HomeCubit(),
          child: HomeScreen(),
        ));
  }
}
