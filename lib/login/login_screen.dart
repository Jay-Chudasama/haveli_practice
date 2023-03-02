import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_bloc.dart';
import 'package:haveliapp/auth/auth_event.dart';
import 'package:haveliapp/login/login_bloc.dart';
import 'package:haveliapp/login/login_event.dart';
import 'package:haveliapp/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formkey = GlobalKey<FormState>();

  String email = "", password = "";

  String? emailError, passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBLoc, LoginState>(
        listener: (context, state) {

          if(state is LoggedIn){
            BlocProvider.of<AuthBloc>(context).add(Authenticate());
            Navigator.pop(context);
          //  todo setup account push
          }

          if (state is Failed) {
            if (state.message == "User not found") {
              setState(() {
                emailError = state.message;
              });
            } else if (state.message == "incorrect password") {
              setState(() {
                passwordError = state.message;
              });
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("${state.message}")));
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      "assets/images/logo.png",
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //----------------------->Email<-----------------------------
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (emailValid) {
                          email = value;
                        } else {
                          return "Invalid Email";
                        }
                      },
                      decoration: InputDecoration(
                        errorText: emailError,
                        enabled: !(state is Submitting),
                        hintText: "Email Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
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
                          return "Incorrect password!";
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: passwordError,
                        enabled: !(state is Submitting),
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        suffixIcon: IconButton(
                            //--------------------------hidePassword button-------------------
                            onPressed: () {
                              //todo
                            },
                            icon: const Icon(Icons.visibility_off)),
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 30,
                        ),
                      ),
                    ),
                    //---------------------------------->Forget Password<-----------------------
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: (state is Submitting)
                            ? null
                            : () {
                                //todo
                              },
                        child: const Text(
                          "Forget Password?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    //<--------------------------------indicatior<-----------------------------
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: state is Submitting
                          ? const CircularProgressIndicator(
                              strokeWidth: 2,
                              // value: 0.8,
                            )
                          : null,
                    ),
                    const SizedBox(
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
                        onPressed: (state is Submitting)
                            ? null
                            : () {
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<LoginBLoc>(context)
                                      .add(Login(email, password));
                                }
                              },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //-------------------------->Login-------------------------------------------------
                    TextButton(
                      onPressed: (state is Submitting)
                          ? null
                          : () {
                              Navigator.pop(context);
                            },
                      child: RichText(
                        text: const TextSpan(
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
