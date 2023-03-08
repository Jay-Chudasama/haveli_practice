import '../../../model/PostModel.dart';
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

class LoadingFeeds extends StoriesLoaded {
  LoadingFeeds(super.stories);
}

class LoadingMoreFeeds extends FeedLoded {
  LoadingMoreFeeds(super.stories, super.feeds, super.nextUrl);
}

class FeedLoded extends StoriesLoaded {
  FeedLoded(super.stories, this.feeds, this.nextUrl);

  List<PostModel> feeds;
  String? nextUrl;
}

class Posting extends FeedLoded {
  Posting(super.stories, super.feeds, super.nextUrl);
}

class Posted extends FeedLoded {
  Posted(super.stories, super.feeds, super.nextUrl);
}

