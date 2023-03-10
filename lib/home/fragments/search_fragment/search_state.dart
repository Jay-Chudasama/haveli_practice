import 'package:haveliapp/model/SearchModel.dart';

abstract class SearchState {}

class Init extends SearchState {}

class Loading extends SearchState {}

class Loaded extends SearchState {
 List <SearchModel> list;
  String? nextUrl;

  Loaded(this.list, this.nextUrl);
}

class LoadingMore extends Loaded{
  LoadingMore(super.list,super.nextUrl);
}


class Failed extends SearchState {
  String message;

  Failed(this.message);
}
