abstract class MyProfileEvent {}

class LoadDetails extends MyProfileEvent {
  int? id;
  LoadDetails(this.id);
}

class LoadPost extends MyProfileEvent{
  int id;
  LoadPost(this.id);
}


class LoadMorePost extends MyProfileEvent {
  String nextUrl;

  LoadMorePost(this.nextUrl);
}