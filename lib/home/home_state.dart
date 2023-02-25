abstract class HomeState {}

class Init extends HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {
  String joke;

  Loaded(this.joke);
}

class Failed extends HomeState {}
