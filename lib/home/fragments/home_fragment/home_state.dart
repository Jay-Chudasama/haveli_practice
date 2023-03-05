import '../../../model/StoryModel.dart';

abstract class HomeState {}

class Init extends HomeState {}

class LoadingStories extends HomeState {}

class StoriesLoaded extends HomeState {
  List<StoryModel> stories;

  StoriesLoaded(this.stories);
}

class Failed extends HomeState {

  String message;

  Failed(this.message);
}

