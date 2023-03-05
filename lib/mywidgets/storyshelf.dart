import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_state.dart';

import 'storyitem.dart';

class StoryShelf extends StatelessWidget {
  HomeState state;

  StoryShelf(this.state);

  @override
  Widget build(BuildContext context) {
    if (state is LoadingStories) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(state is StoriesLoaded) {
print((state as StoriesLoaded).stories.length);
      return Container(
        height: 140,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return StoryItem((state as StoriesLoaded).stories[index]);
          },
          itemCount: (state as StoriesLoaded).stories.length,
        ),
      );
    }


    return Container();
  }
}
