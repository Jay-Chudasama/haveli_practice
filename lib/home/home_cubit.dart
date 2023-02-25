import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/home_repo.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(Init());
  HomeRepo repo = HomeRepo();

  void loadJoke() {
    emit(Loading());
    repo.loadJoke().then((response) {
      String joke = response.data["setup"];
      emit(Loaded(joke));
    }).catchError((error) {
      emit(Failed());
    });
  }
}
