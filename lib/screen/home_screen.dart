import 'package:flutter/material.dart';
import 'package:haveliapp/repo.dart';
import 'package:haveliapp/utils.dart';

class HomeScreen extends StatelessWidget {
Function callback;
HomeScreen(this.callback);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      body: Center(
        child: IconButton(
          onPressed: () {
            Repo.like().then((response) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Like Success")));
            }).catchError((error) {
              print(error);
              if(error.response!=null){
                if(error.response.statusCode==401){
                  deletToken().then((value) => callback());
                }
              }
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Like failed")));
            });
          },
          icon: Icon(Icons.thumb_up),
        ),
      ),
    );
  }
}
