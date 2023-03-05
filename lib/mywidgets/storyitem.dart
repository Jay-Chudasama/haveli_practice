import 'package:flutter/material.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/home/story_screen.dart';
import 'package:haveliapp/model/StoryModel.dart';

class StoryItem extends StatelessWidget {
  StoryModel model;

  StoryItem(this.model);

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryScreen(model),
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
                  BASE_URL + model.story[0].image,
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
          Text(model.username, textAlign: TextAlign.center, maxLines: 2)
        ],
      ),
    );
  }
}
