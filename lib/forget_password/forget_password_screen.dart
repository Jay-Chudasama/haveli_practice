// ignore_for_file: unnecessary_string_escapes, prefer_const_constructors, use_build_context_synchronously

import 'package:haveliapp/forget_password/forget_password_bloc.dart';
import 'package:haveliapp/forget_password/forget_password_event.dart';
import 'package:haveliapp/forget_password/forget_password_state.dart';
import 'package:haveliapp/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_mail_app/open_mail_app.dart';

class ForgetPasswordScreen extends StatelessWidget {
  String email = "";
  String? emailError;
  var formkey = GlobalKey<FormState>();
  Uri mail = Uri.parse("https://gmail.google.com/mail/u/0/#inbox");

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetBloc, ForgetState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is Failed) {
          if (state.message == "User not found!") {
            emailError = state.message;
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: state is Submited ? Colors.blue : null,
            body: state is Submited
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Image.asset(
                            "assets/images/email_sent.png",
                            height: 250,
                            width: 250,
                          ),
                          Text(
                            "Check Your Inbox",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Password resate email has been sent successfully!",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: Colors.white),
                              //------------------------------------------openGmail<-----------------------------
                              onPressed: () async {
                                // Android: Will open mail app or show native picker.
                                // iOS: Will open mail app if single mail app found.
                                var result = await OpenMailApp.openMailApp(
                                  nativePickerTitle: 'Select email app to open',
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "https://image.similarpng.com/very-thumbnail/2020/12/Gmail-logo-design-on-transparent-background-PNG.png",
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Open Gmail",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 170,
                          ),
                          TextButton(
                            onPressed: () {
                              //todo
                            },
                            child: Text(
                              "<<Back to Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/forget_password.png",
                            height: 250,
                            width: 250,
                          ),
                          Text(
                            "Forget Password?",
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            "Don\'t worry we just need your registered email Address and it\'s done",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          //------------------------------------------->email<-------------------------------------
                          Form(
                            key: formkey,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "REquired";
                                }
                                if (validEmail(value)) {
                                  email = value;
                                }
                              },
                              decoration: InputDecoration(
                                errorText: emailError,
                                hintText: "Email Addresss",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          //------------------------>indicatior<---------------------------------
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: state is Submitting
                                ? CircularProgressIndicator(
                                    strokeWidth: 2,
                                    // value: 0.8,
                                  )
                                : null,
                          ),
                          SizedBox(
                            height: 80,
                          ),

                          //------------------------>resate password<--------------------------------
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<ForgetBloc>(context)
                                      .add(ForgetPassword(email));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              child: Text(
                                "Resate Password",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextButton(
                            onPressed: () {
                              //todo
                            },
                            child: Text(
                              "<<Back to Login",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ));
      },
    );
  }
}
