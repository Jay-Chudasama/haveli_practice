import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haveliapp/repo.dart';
import 'package:haveliapp/utils.dart';

enum STATES { init, submitting, loggedIn, failed }

class LoginScreen extends StatefulWidget {



  LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();

  var formkey = GlobalKey<FormState>();
  bool showPassword = false;

  String email = "";
  String password = "";
  String? emailError, passwordError;

  STATES status = STATES.init;
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.all(24),
          child: Form(
            key: widget.formkey,
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
                  enabled: widget.status != STATES.submitting,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }

                    if (validEmail(value)) {
                      widget.email = value;
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
                    errorText: widget.emailError,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                  enabled: widget.status != STATES.submitting,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }

                    if (value.length < 8) {
                      return "Incorrect Password!";
                    }

                    widget.password = value;
                  },
                  obscureText: widget.showPassword,
                  decoration: InputDecoration(
                      errorText: widget.passwordError,
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
                          !widget.showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.showPassword = !widget.showPassword;
                          });
                        },
                      )),
                ),
                SizedBox(
                  height: 32,
                ),
                if (widget.status == STATES.submitting)
                  SizedBox(
                    child: LinearProgressIndicator(),
                    width: 80,
                  ),
                SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: widget.status == STATES.submitting
                      ? null
                      : () {
                          if (widget.formkey.currentState!.validate()) {
                            login();
                          }
                        },
                  child: Text("Login"),
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

  void login() {
    setState(() {
      widget.status = STATES.submitting;
      Repo.login(widget.email, widget.password).then((response) {
        String token = response.data["token"];
        storeToken(token)
            .then((value) => reloadMainScreen!(token))
            .catchError((error) => print(error));
      }).catchError((error) {
        if (error.type == DioErrorType.connectTimeout) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Connection TimeOut")));
        }

        if (error.response != null) {
          setState(() {
            widget.status = STATES.init;
            widget.emailError =
                error.response!.statusCode == 404 ? "user not found" : null;
            widget.passwordError =
                error.response!.statusCode == 400 ? "incorrect password" : null;
          });
        }
      });
    });
  }
}
