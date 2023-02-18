import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haveliapp/repo.dart';
import 'package:haveliapp/utils.dart';

import '../models/user_model.dart';

enum STATES { init, submitting, loggedIn, failed }

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formkey = GlobalKey<FormState>();

  bool showPassword = false;

  String username = "";

  String email = "";

  String password = "";

  String? emailError, passwordError, usernameerror;

  STATES status = STATES.init;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body:SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.all(24),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 80,
                  width: 80,
                ),
                SizedBox(
                  height: 48,
                ),
                TextFormField(
                  enabled: status != STATES.submitting,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    if(validUser(value)) {
                      username = value;
                    }
                    else{
                      return "invalid user name";
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.redAccent)),
                    hintText: "User name",
                    errorText: usernameerror,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                TextFormField(
                  enabled: status != STATES.submitting,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }

                    if (validEmail(value)) {
                      email = value;
                    } else {
                      return "Inavalid Email Address";
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.redAccent)),
                    hintText: "Email address",
                    errorText: emailError,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                TextFormField(
                  enabled: status != STATES.submitting,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }

                    if (value.length < 8) {
                      return "Incorrect Password!";
                    }

                    password = value;
                  },
                  obscureText: showPassword,
                  decoration: InputDecoration(
                      errorText: passwordError,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.redAccent)),
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      )),
                ),
                SizedBox(
                  height: 32,
                ),
                if (status == STATES.submitting)
                  SizedBox(
                    child: LinearProgressIndicator(),
                    width: 80,
                  ),
                SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {if (formkey.currentState!.validate()) {
                    Signup();
                  }},
                  child: Text("Sign Up"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(
                        40), // fromHeight use double.infinity as width and 40 is the height
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void Signup(){
    Repo.SighUp(username, email, password).then((response){
      print(response);
      String token = response.data["token"];
      storeToken(token)
          .then((value) {
            Navigator.pop(context);
        reloadMainScreen!(token);
      })
          .catchError((error) => print(error));
    }).catchError((error){
      print(error);
      if (error.type == DioErrorType.connectTimeout) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Connection TimeOut")));
      }
      if (error.response != null) {
        setState(() {
          status = STATES.init;
          usernameerror=error.response!.data == "username_already_exists" ? "username already exists" : null;
          emailError =
          error.response!.data == "email_already_exists" ? "email already exists" : null;
        });
      }
    });
  }
}
