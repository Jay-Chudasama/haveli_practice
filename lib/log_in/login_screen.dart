// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:haveliapp/auth/auth_bloc.dart';
import 'package:haveliapp/auth/auth_event.dart';
import 'package:haveliapp/forget_password/forget_password_bloc.dart';
import 'package:haveliapp/forget_password/forget_password_screen.dart';
import 'package:haveliapp/log_in/login_bloc.dart';
import 'package:haveliapp/log_in/login_event.dart';
import 'package:haveliapp/log_in/login_state.dart';
import 'package:haveliapp/profile/profile_bloc.dart';
import 'package:haveliapp/profile/profile_screen.dart';
import 'package:haveliapp/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var formkey = GlobalKey<FormState>();

  String? emailError, passwordError;

  String email = "", password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoggedIn) {
            BlocProvider.of<AuthBloc>(context).add(Authenticat(true));
            Navigator.pop(context);
          }
          if (state is Failed) {
            if (state.msg == "User not found") {
              setState(() {
                emailError = state.msg;
              });
            }
            if (state.msg == "incorrect password") {
              setState(() {
                passwordError = state.msg;
              });
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("${state.msg}")));
            }
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        if (validEmail(value)) {
                          email = value;
                        } else {
                          return "Please enter a valid Email Address";
                        }
                      },
                      enabled: !(state is Submitting || state is LoggedIn),
                      decoration: InputDecoration(
                        errorText: emailError,
                        hintText: "Email Address",
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
                      enabled: !(state is Submitting || state is LoggedIn),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        if (value.length > 7) {
                          password = value;
                        } else {
                          return "Incorrect password!";
                        }
                      },
                      decoration: InputDecoration(
                        errorText: passwordError,
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        suffixIcon: IconButton(
                            //--------------------------hidePassword button-------------------

                            onPressed: state is Submitting || state is LoggedIn
                                ? null
                                : () {
                                    //todo
                                  },
                            icon: Icon(Icons.visibility_off)),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 30,
                        ),
                      ),
                    ),
                    //---------------------------------->Forget Password<-----------------------
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: state is Submitting || state is LoggedIn
                            ? null
                            : () {
                                //todo
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) => ForgetBloc(),
                                              child: ForgetPasswordScreen(),
                                            )));
                              },
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    //<--------------------------------indicatior<-----------------------------
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: state is Submitting || state is LoggedIn
                          ? CircularProgressIndicator(
                              strokeWidth: 2,
                              // value: 0.8,
                            )
                          : null,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    //----------------------------->LogIn<---------------------------------
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: state is Submitting || state is LoggedIn
                            ? null
                            : () {
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context)
                                      .add(Login(email, password));
                                }
                              },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //-------------------------->SignUp-------------------------------------------------
                    TextButton(
                      onPressed: state is Submitting || state is LoggedIn
                          ? null
                          : () {
                              Navigator.pop(context);
                            },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an Account?",
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'Kanit-Regular'),
                          children: [
                            TextSpan(
                              text: " Sign Up!",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'Kanit-Regular'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
