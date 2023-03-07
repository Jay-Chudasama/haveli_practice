import '../../../model/StoryModel.dart';

abstract class HomeState {}

class Init extends HomeState {}

class LoadingStories extends HomeState {}

class StoriesLoaded extends HomeState {
  List<StoryModel> stories;

  StoriesLoaded(this.stories);
}

class UploadingStory extends StoriesLoaded {
  UploadingStory(super.stories);
}

class DeletingStory extends StoriesLoaded {
  DeletingStory(super.stories);
}

class Failed extends HomeState {
  String message;

  Failed(this.message);
}
