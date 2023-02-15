import 'package:flutter/material.dart';
import 'package:haveliapp/models/user_model.dart';

import '../constants.dart';

class ChatItem extends StatelessWidget {

  UserModel userModel;


  ChatItem(this.userModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white
      ),
      child: Row(
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: ClipRRect(

              child: Image.network("$BASE_URL${userModel.image}", height: 60, width: 60),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          SizedBox(width: 16,),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userModel.username,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                userModel.email,
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              )
            ],
          ))
        ],
      ),
    );
  }
}
