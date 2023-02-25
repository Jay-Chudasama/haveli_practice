

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<int>{


  HomeCubit() : super(0);


  void add(){

    int newstate = state + 1;
    emit(newstate);

  }


  void remove(){
    int newstate = state - 1;
    emit(newstate);


  }





}