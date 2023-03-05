// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:haveliapp/auth/auth_bloc.dart';
import 'package:haveliapp/auth/auth_event.dart';
import 'package:haveliapp/log_in/login_bloc.dart';
import 'package:haveliapp/log_in/login_screen.dart';
import 'package:haveliapp/profile/profile_bloc.dart';
import 'package:haveliapp/profile/profile_screen.dart';
import 'package:haveliapp/sign_up/sign_up_bloc.dart';
import 'package:haveliapp/sign_up/sign_up_event.dart';
import 'package:haveliapp/sign_up/sign_up_state.dart';
import 'package:haveliapp/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();

  String? emailError, passwordError;

  String? email, password, confrimPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is Submitted) {
            BlocProvider.of<AuthBloc>(context).add(Authenticat(true));
          }

          if (state is Failed) {
            if (state.message == "Email already taken!") {
              emailError = state.message;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  //----------------------->Email<-----------------------------
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "resquired";
                            }
                            if (validEmail(value)) {
                              email = value;
                            } else {
                              return "Please enter a valid Email Address";
                            }
                          },
                          enabled: !(state is Submitting || state is Submitted),
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            errorText: emailError,
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.redAccent)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              size: 30,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 40,
                        ),

                        //-------------------->password<-------------------------------------
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                            if (value.length > 7) {
                              password = value;
                            } else {
                              return "min 8 charcter required";
                            }
                          },
                          enabled: !(state is Submitting || state is Submitted),
                          decoration: InputDecoration(
                            hintText: "Password",
                            errorText: passwordError,
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.redAccent)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        //---------------------------->ConformPassword<----------------------
                        TextFormField(
                          validator: (value) {
                            if (password == value) {
                              confrimPassword = value;
                            } else {
                              return "password miss match";
                            }
                          },
                          enabled: !(state is Submitting || state is Submitted),
                          decoration: InputDecoration(
                            hintText: "Confrim Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  //<--------------------------------indicatior<-----------------------------
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: state is Submitting || state is Submitted
                        ? CircularProgressIndicator(
                            strokeWidth: 2,
                            // value: 0.8,
                          )
                        : null,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  //----------------------------->CreateAccount<---------------------------------
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: state is Submitting || state is Submitted
                          ? null
                          : () {
                              if (formkey.currentState!.validate()) {
                                BlocProvider.of<SignUpBloc>(context)
                                    .add(SignUp(email!, password!));
                              }
                            },
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  //-------------------------->Login-------------------------------------------------
                  TextButton(
                    onPressed: state is Submitting || state is Submitted
                        ? null
                        : () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => LoginBloc(),
                                    child: LogIn(),
                                  ),
                                ));
                          },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an Account?",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
