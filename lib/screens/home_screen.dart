import 'package:flutter/material.dart';
import 'package:haveliapp/screens/users_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>UsersScreen()));
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
