import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/models/msg_model.dart';
import 'package:haveliapp/models/user_model.dart';
import 'package:haveliapp/my_widget/message.dart';
import 'package:haveliapp/repo.dart';
import 'package:haveliapp/utils.dart';

class ChatScreen extends StatefulWidget {
  UserModel userModel;
  List<MsgModel> list = [];

  ChatScreen(this.userModel);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leadingWidth: 24,
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              child: ClipRRect(
                child: Image.network(
                  "$BASE_URL${widget.userModel.image}",
                  height: 40,
                  width: 40,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userModel.username,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text("online",
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                ],
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Message(widget.list[index]);
              },
              itemCount: widget.list.length,
            ),
          ),
          Container(
            color: Colors.grey,
            padding: EdgeInsets.all(8),
            child: TextField(
              onChanged: (value) {
                setState(() {

                });
              },
              controller: _controller,
              decoration: InputDecoration(
                hintText: "type hear....",
                isDense: true,
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(24),
                ),
                suffixIcon: IconButton(
                  onPressed: _controller.text.isEmpty
                      ? null
                      : () {
                          sendMsg();
                        },
                  icon: Icon(
                    Icons.send,
                    size: 24,
                  ),
                ),
              ),
              maxLines: 3,
              minLines: 1,
            ),
          )
        ],
      ),
    );
  }

  void sendMsg() {
    Repo.sendMsg(widget.userModel.id, _controller.text).then((response) {
      print(response);
      setState(() {
        loadChat();
        _controller.text = "";
      });
    }).catchError((error) {
      print(error);
      if (error.response != null) {
        if (error.response.statusCode == 403) {
          deletToken().then((value) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            reloadMainScreen!(null);
          });
        }
      }
    });
  }

  void loadChat() {
    Repo.loadChat(widget.userModel.id).then((response) {
      print(response);
      widget.list = response.data.map<MsgModel>((json) {
        return MsgModel.fromJson(json);
      }).toList();
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }).catchError((error) {
      print(error);
      if (error.response != null) {
        if (error.response.statusCode == 403) {
          deletToken().then((value) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            reloadMainScreen!(null);
          });
        }
      }
    });
  }
}
