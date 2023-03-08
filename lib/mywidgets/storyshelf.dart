
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_state.dart';
import 'package:image_picker/image_picker.dart';

import '../auth/auth_bloc.dart';
import '../auth/auth_state.dart' as AuthState;
import '../constants.dart';
import '../model/User_details.dart';
import 'storyitem.dart';

class StoryShelf extends StatelessWidget {
  HomeState state;
  Function uploadStory,deleteStory;

  StoryShelf(this.state, {required this.uploadStory,required this.deleteStory});

  final ImagePicker _picker = ImagePicker();


  List<XFile>? images;

  List<File> files = [];


  @override
  Widget build(BuildContext context) {
    if (state is LoadingStories) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is StoriesLoaded) {
      print((state as StoriesLoaded).stories.length);
      UserDetails userDetails =
          (BlocProvider.of<AuthBloc>(context).state as AuthState.Authenticated)
              .userDetails;

      return Container(
        height: 140,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {

              return Row(
                children: [
                  if (index == 0 && ((state as StoriesLoaded).stories.length!=0?(state as StoriesLoaded).stories[0].id != userDetails.id:true))
                  Container(
                    width: 80,
                    margin: EdgeInsets.only(left: 8, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.blue, width: 3)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    BASE_URL + userDetails.image,
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 12,
                                    child: Icon(
                                      Icons.add_circle,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("Add Story",
                            textAlign: TextAlign.center, maxLines: 2)
                      ],
                    ),
                  ),
                  if (index == 0 && ((state as StoriesLoaded).stories.length!=0?(state as StoriesLoaded).stories[0].id == userDetails.id:false))
                    GestureDetector(
                      onLongPress: (){
                        pickImage();
                      },
                      child: StoryItem((state as StoriesLoaded).stories, index,deleteStory: deleteStory,),
                    ),
                  if(index!=0 || ((state as StoriesLoaded).stories.length!=0 && (state as StoriesLoaded).stories[0].id != userDetails.id))
                  StoryItem((state as StoriesLoaded).stories, index,deleteStory: deleteStory,),
                ],
              );
          },
          itemCount: (state as StoriesLoaded).stories.length == 0?1:(state as StoriesLoaded).stories.length,
        ),
      );
    }

    return Container();
  }


  void pickImage() async {
    images = await _picker.pickMultiImage();
    if(images!.length==0){
      return;
    }
    images!.forEach((element) {
      files.add(File(element.path));
    });
    uploadStory(files);
    // file = File(image!.path);
    // setState(() {});
  }
}
