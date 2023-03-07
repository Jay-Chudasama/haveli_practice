import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_bloc.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/home/story_screen.dart';
import 'package:haveliapp/model/StoryModel.dart';
import 'package:haveliapp/model/User_details.dart';

import '../auth/auth_state.dart';

class StoryItem extends StatefulWidget {
  List<StoryModel> list;
  int index;

  StoryItem(this.list,this.index);

  @override
  State<StoryItem> createState() => _StoryItemState();
}

class _StoryItemState extends State<StoryItem> {

  @override
  Widget build(BuildContext context) {



    return Container(
      width: 80,
      margin: EdgeInsets.only(left: 8, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              StoryScreen.initailPage = widget.index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryScreen(widget.list),
                  ));
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color:  Colors.blue, width: 3)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  BASE_URL + widget.list[widget.index].story[0].image,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(widget.list[widget.index].username, textAlign: TextAlign.center, maxLines: 2)
        ],
      ),
    );
  }
}
