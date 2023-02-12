import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haveliapp/repo.dart';
import 'package:haveliapp/screen/home_screen.dart';
import 'package:haveliapp/utils.dart';

enum STATUS { init, submitting, loginComplte, loginFailed }

class LoginScreen extends StatefulWidget {
  Function loginCallback;
  LoginScreen(this.loginCallback);
  String email = "";
  String password = "";
  String? emailError;
  String? passwordError;
  var loginSTATUS = STATUS.init;
  var formKey = GlobalKey<FormState>();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.loginSTATUS == STATUS.init
          ? Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              child: Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "required";
                        }
                        widget.email = value;
                      },
                      decoration: InputDecoration(
                        errorText: widget.emailError,
                        hintText: "Enter Your Email",
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        widget.password = value;
                      },
                      decoration: InputDecoration(
                        errorText: widget.passwordError,
                        hintText: "Enter Your Password",
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (widget.formKey.currentState!.validate()) {
                            login();
                            setState(() {
                              widget.loginSTATUS = STATUS.submitting;
                            });
                          }
                        },
                        child: Text("LOGIN"))
                  ],
                ),
              ),
            )
          : widget.loginSTATUS == STATUS.submitting
              ? CircularProgressIndicator()
              : null,
    );
  }

  void login() {
    Repo.postData(widget.email, widget.password).then((response) {
      widget.loginSTATUS = STATUS.loginComplte;
      storeTocken(response.data["token"]).then((value){
        widget.loginCallback(response.data["token"]);
      });
    }).catchError((error) {
      print(error);
      if(error.type == DioErrorType.connectTimeout){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Connection TimeOut")));
      }
      if (error.response != null) {
        print(error.response!.data);
        print(error.response!.statusCode);
        setState(() {
          widget.loginSTATUS = STATUS.init;
          widget.emailError =
              error.response!.statusCode == 404 ? "user not found" : null;
          widget.passwordError = error.response!.statusCode==400?"incorrect password":null;
        });
      }
    });
  }
}
