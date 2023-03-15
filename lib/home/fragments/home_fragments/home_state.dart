import 'package:haveliapp/model/MenuModel.dart';

abstract class HomeState {}

class Init extends HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {
  MenuModel? menu;
  Loaded(this.menu);
}

class Failed extends HomeState {
  String messsage;
  Failed(this.messsage);
}
