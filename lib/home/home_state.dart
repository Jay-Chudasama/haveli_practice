import 'package:haveliapp/models/news_model.dart';

abstract class HomeState {}

class Init extends HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {
  List<NewsModel> list = [];

  Loaded(this.list);
}

class Failed extends HomeState {
  String? msg;

  Failed(this.msg);
}
