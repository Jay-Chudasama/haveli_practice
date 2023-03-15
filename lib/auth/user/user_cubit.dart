import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/user/user_repo.dart';
import 'package:haveliapp/auth/user/user_state.dart';

class UserCubit extends Cubit<UserState>{


  UserCubit(super.initialState);

  UserRepo repo = UserRepo();


  void addToCart(int id) async {

    state.userdata.cart.add(id);
    emit(UserState(state.userdata));

    try {
      var response = await repo.addToCart(id);
      //do nothing
    } catch (value) {
      print(value);
    //  do nothing
    }
  }

  void removeToCart(int id) async {

    state.userdata.cart.remove(id);
    emit(UserState(state.userdata));

    try {
      var response = await repo.removeToCart(id);
      //do nothing
    } catch (value) {
      print(value);
      //  do nothing
    }
  }





}