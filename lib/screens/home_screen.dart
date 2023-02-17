import 'package:flutter/material.dart';
import 'package:haveliapp/models/user_model.dart';
import 'package:haveliapp/my_widget/chat_item.dart';
import 'package:haveliapp/repo.dart';
import 'package:haveliapp/screens/chat_screen.dart';
import 'package:haveliapp/screens/users_screen.dart';

enum STATE { init, loading, loded, failed }

class HomeScreen extends StatefulWidget {
  var status = STATE.init;
  List<UserModel> list = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.status == STATE.init) {
      loadChatList();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ChatItem(widget.list[index]);
        },
        itemCount: widget.list.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => UsersScreen()))
              .then((model) {
            if (model != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(model),
                  ));
            }
          });
        },
        child: Icon(Icons.chat),
      ),
    );
  }

  void loadChatList() {
    widget.status = STATE.loading;
    Repo.chatList().then((response) {
      setState(() {
        widget.status = STATE.loded;
        widget.list = response.data.map<UserModel>((object){
          return UserModel.fromJson(object);
        }).toList();
      });
      print(response);
    }).catchError((error) {
      print(error);
      setState(() {
        widget.status = STATE.failed;
      });
    });
  }
}
