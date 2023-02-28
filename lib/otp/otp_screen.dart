import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:haveliapp/otp/otp_cubit.dart';
import 'package:haveliapp/otp/otp_state.dart';
import 'package:haveliapp/profile/profile_cubit.dart';
import 'package:haveliapp/profile/profile_screen.dart';

import '../auth/auth_cubit.dart';

class OtpScreen extends StatefulWidget {
  String phone;

  OtpScreen(this.phone);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool enableButton = false;
  Timer? timer;
  int countDown = 60;
  String otp = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(timer!=null){

    timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocConsumer<OtpCubit, OtpState>(
            listener: (context, state) {
              if (state is FAiled) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.msg!)));
              }
              if (state is Verifyed) {
                BlocProvider.of<AuthCubit>(context).loadUserDetails();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (context) => ProfileCubit(),
                          child: ProfileScreen()),
                    ));
              }
            },
            builder: (context, OtpState state) {
              return Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Image.asset("assets/images/otp.png"),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enter Verification Code",
                    style: TextStyle(fontSize: 27),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    showFieldAsBox: true,
                    onSubmit: (value) {
                      setState(() {
                        enableButton = true;
                      });
                      otp = value;
                      print(value);
                    },
                    onCodeChanged: (value) {
                      // print(value);
                      setState(() {
                        enableButton = false;
                      });
                    },
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  TextButton(
                    onPressed: timer!.isActive
                        ? null
                        : () {
                            startTimer();
                            BlocProvider.of<OtpCubit>(context)
                                .resendOtp(widget.phone);
                          },
                    child: Text(
                      "RESEND ${countDown > 0 ? " in $countDown seconds" : ""}",
                      style: TextStyle(
                          fontSize: 20,
                          color: timer!.isActive ? Colors.grey : Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: 80,
                      child: state is Submiting
                          ? LinearProgressIndicator(
                              color: Colors.black,
                            )
                          : null),
                  SizedBox(
                    height: 80,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: !enableButton || state is Submiting
                          ? null
                          : () {
                              BlocProvider.of<OtpCubit>(context).verifyOtp(otp);
                            },
                      child: Text(
                        "VERIFY",
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void startTimer() {
    countDown = 60;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countDown--;
        if (countDown == 0) {
          timer.cancel();
        }
      });
    });
  }
}
