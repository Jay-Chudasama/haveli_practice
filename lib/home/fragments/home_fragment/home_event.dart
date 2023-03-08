import 'dart:io';

import 'package:haveliapp/home/home_screen.dart';

abstract class HomeEvent {}

class LoadStories extends HomeEvent {
  int userId;

  LoadStories(this.userId);
}

class UploadStory extends HomeEvent {
  List<File> files;

  UploadStory(this.files);
}

class DeletStory extends HomeEvent {
  int id;

  DeletStory(this.id);
}

class LoadFeeds extends HomeEvent {}

class LoadMoreFeeds extends HomeEvent {
  String nextUrl;

  LoadMoreFeeds(this.nextUrl);
}

class AddPost extends HomeEvent {
  String caption;
  File file;

  AddPost(this.file, this.caption);
}
