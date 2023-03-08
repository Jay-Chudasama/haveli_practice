import 'package:haveliapp/model/User_details.dart';

import '../../../model/PostModel.dart';

abstract class MyProfileState {}

class Init extends MyProfileState {}

class Loading extends MyProfileState {}

class Loaded extends MyProfileState {
  UserDetails model;

  Loaded(this.model);
}

class Failed extends MyProfileState {
  String message;

  Failed(this.message);
}

class LoadingPost extends Loaded {
  LoadingPost(super.model);
}

class LoadingMorePosts extends PostLoaded {
  LoadingMorePosts(super.model, super.list, super.nextUrl);
}

class PostLoaded extends Loaded {
  List<PostModel> list;

  String? nextUrl;

  PostLoaded(super.model, this.nextUrl, this.list);
}
