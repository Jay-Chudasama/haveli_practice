import 'package:flutter/material.dart';
import 'package:haveliapp/models/user_model.dart';
import 'package:haveliapp/screens/chat_screen.dart';
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
          Navigator.push(context, MaterialPageRoute(builder: (_)=>UsersScreen())).then((model) {
            if(model!=null){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(model),));
            }
          });
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
