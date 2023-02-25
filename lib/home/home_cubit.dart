

import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState>{


  HomeCubit() : super(Counter(0));


  void add(){

    int count = (state as Counter).count + 1;
    emit(Counter(count));

  }


  void remove(){
    int count = (state as Counter).count - 1;
    emit(Counter(count));


  }





}