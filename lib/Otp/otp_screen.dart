import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:lottie/lottie.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, right: 24, left: 24),
          child: Column(
            children: [
              Lottie.network(
                  'https://assets3.lottiefiles.com/packages/lf20_ed9hgtrb.json',
                  height: 200),
              SizedBox(
                height: 20,
              ),
              OtpTextField(
                numberOfFields: 4,
                showFieldAsBox: true,
                borderWidth: 2,
                borderColor: Color(0xFF512DA8),
              ),
              SizedBox(
                height: 60,
              ),
              TextButton(
                onPressed: () {
                  //todo
                },
                child: Text(
                  "Resend",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              CircularProgressIndicator(),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      //todo
                    },
                    child: Text(
                      "Verify",
                      style: TextStyle(fontSize: 18),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
