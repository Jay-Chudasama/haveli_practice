import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network("https://assets2.lottiefiles.com/packages/lf20_UgZWvP.json"),
      ),
    );
  }
}
