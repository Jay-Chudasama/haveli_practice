import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/models/msg_model.dart';
import 'package:haveliapp/models/user_model.dart';
import 'package:haveliapp/my_widget/message.dart';
import 'package:haveliapp/repo.dart';
import 'package:haveliapp/utils.dart';

enum STATES { init, loading, loaded, failed }

class ChatScreen extends StatefulWidget {
  UserModel userModel;
  List<MsgModel> list = [];
  bool sendingMsg = false;

  ChatScreen(this.userModel);

  STATES states = STATES.init;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.states == STATES.init) {
      loadChat();
    }
    if (widget.states == STATES.loaded && !widget.sendingMsg) {
      Future.delayed(
        Duration(seconds: 3),
        () {
          if (!widget.sendingMsg) {
            loadChat();
          }
        },
      );
    }else{
      setState(() {

      widget.sendingMsg = false;
      });
    }
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
              child: widget.userModel.image== null ?Icon(Icons.person,color: Colors.black):ClipRRect(
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
              reverse: true,
              itemBuilder: (context, index) {
                return Message(widget.list[index], widget.userModel.id);
              },
              itemCount: widget.list.length,
            ),
          ),
          Container(
            color: Colors.grey,
            padding: EdgeInsets.all(8),
            child: TextField(
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
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMsg();
                    }
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
      _controller.clear();
      widget.sendingMsg = true;
      loadChat(fromMsg: true);
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

  void loadChat({bool fromMsg: false}) {
    print("requested");
    widget.states = STATES.loading;
    Repo.loadChat(widget.userModel.id).then((response) {
      if (!fromMsg && widget.sendingMsg) {
        return;
      }
      setState(() {
        int oldlenth = widget.list.length;
        widget.list = response.data.map<MsgModel>((json) {
          return MsgModel.fromJson(json);
        }).toList();
        if (oldlenth != widget.list.length) {
          scrollEnd();
        }
      widget.states = STATES.loaded;
      });

    }).catchError((error) {
      setState(() {
        widget.states = STATES.failed;
      });
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

  void scrollEnd() {
    _scrollController.jumpTo(20);
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 200), curve: Curves.easeOut);
  }
}
