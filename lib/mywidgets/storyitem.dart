import 'package:flutter/material.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/home/story_screen.dart';
import 'package:haveliapp/model/StoryModel.dart';

class StoryItem extends StatelessWidget {
  List<StoryModel> list;
  int index;

  StoryItem(this.list,this.index);

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
              StoryScreen.initailPage = index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryScreen(list),
                  ));
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.blue, width: 3)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  BASE_URL + list[index].story[0].image,
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
          Text(list[index].username, textAlign: TextAlign.center, maxLines: 2)
        ],
      ),
    );
  }
}
