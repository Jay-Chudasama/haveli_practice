import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:haveliapp/Otp/otp_cubit.dart';
import 'package:haveliapp/Otp/otp_state.dart';
import 'package:haveliapp/auth/auth_cubit.dart';
import 'package:lottie/lottie.dart';

class OtpScreen extends StatefulWidget {
  String phone;
  int countDown = 0;
  Timer? timer;

  OtpScreen(this.phone);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool enableButton = false;

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
    if (widget.timer != null) {
      widget.timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) async {
          if (state is Failed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is Verifyed) {
            await BlocProvider.of<AuthCubit>(context).loaduserDetails();
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
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
                    height: 60,
                  ),
                  TextButton(
                    onPressed: () {
                      //todo
                    },
                    child: TextButton(
                      onPressed: widget.timer!.isActive
                          ? null
                          : () {
                              startTimer();
                              BlocProvider.of<OtpCubit>(context)
                                  .resendOtp(widget.phone);
                            },
                      child: Text(
                        "Resend ${widget.countDown > 0 ? "in ${widget.countDown}" : ""}",
                        style: TextStyle(
                            fontSize: 20,
                            color: widget.timer!.isActive
                                ? Colors.grey
                                : Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  state is Submitting
                      ? CircularProgressIndicator()
                      : SizedBox(),
                  SizedBox(
                    height: 80,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: !enableButton || state is Submitting
                            ? null
                            : () {
                                BlocProvider.of<OtpCubit>(context)
                                    .verifyOtp(otp, widget.phone);
                              },
                        child: Text(
                          "Verify",
                          style: TextStyle(fontSize: 18),
                        )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void startTimer() {
    widget.countDown = 60;
    widget.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        widget.countDown--;
        if (widget.countDown == 0) {
          timer.cancel();
        }
      });
    });
  }
}
