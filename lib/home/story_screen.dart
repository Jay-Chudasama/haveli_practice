import 'package:flutter/material.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/model/StoryModel.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryScreen extends StatelessWidget {
  List<StoryModel> storyList;
  static int initailPage = 0;

  StoryScreen(this.storyList);


  final controller = StoryController();
  final PageController pageController = PageController(initialPage: initailPage);

  @override
  Widget build(context) {

    return Scaffold(
      body: PageView(
        controller: pageController,
        children: buildStories(context),
      ),
    );
  }

  List<Widget> buildStories(context){


    List<Widget> stories = [];

    storyList.forEach((StoryModel model) {
      List<StoryItem> storyItems = model.story
          .map<StoryItem>((e) => StoryItem.pageImage(
          url: BASE_URL + e.image, controller: controller))
          .toList(); // your list of stories

      stories.add(Stack(
        children: [
          StoryView(
              storyItems: storyItems,
              controller: controller,
              inline: true,
              // pass controller here too
              repeat: false,
              // should the stories be slid forever
              onStoryShow: (s) {},
              onComplete: () {
                if(pageController.page==storyList.length-1){
                  Navigator.pop(context);
                }else {
                  pageController.nextPage(
                      duration: Duration(seconds: 1), curve: Curves.ease);
                }
              },
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }
              } // To disable vertical swipe gestures, ignore this parameter.
            // Preferrably for inline story view.
          ),
          Padding(
            padding: const EdgeInsets.only(top: 44.0, left: 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 16,
                  child: model.image == null
                      ? Icon(Icons.account_circle)
                      : CircleAvatar(
                    radius: 15,
                    backgroundImage:
                    NetworkImage(BASE_URL + model.image),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  model.username,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ));

    });


    return stories;


  }

}
