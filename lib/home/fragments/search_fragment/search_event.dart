abstract class SearchEvent {}

class Search extends SearchEvent {
  String searchUser;

  Search(this.searchUser);
}


class LoadMore extends SearchEvent{
  String nextUrl;

  LoadMore(this.nextUrl);
}
