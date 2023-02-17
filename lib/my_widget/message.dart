import 'package:flutter/material.dart';
import 'package:haveliapp/models/msg_model.dart';

class Message extends StatelessWidget {
  bool reply = true;
  MsgModel msg;
  int chatwithid;

  Message(this.msg, this.chatwithid) {
    reply = msg.user != chatwithid;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (reply) Spacer(),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: reply ? Colors.white : Colors.blue,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(reply ? 0 : 25),
                  bottomLeft: Radius.circular(reply ? 25 : 0),
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25))),
          child: Text(
            msg.msg,
            style: TextStyle(color: reply ? Colors.blue : Colors.white),
          ),
        ),
        if (!reply) Spacer(),
      ],
    );
  }
}
