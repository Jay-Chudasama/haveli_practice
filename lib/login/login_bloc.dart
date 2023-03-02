

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/login/login_event.dart';
import 'package:haveliapp/login/login_repo.dart';
import 'package:haveliapp/login/login_state.dart';
import 'package:haveliapp/utils.dart';

class LoginBLoc extends Bloc<LoginEvent,LoginState>{

  LoginRepo repo = LoginRepo();

  LoginBLoc():super(Init()){

    on<Login>((event,emit)async{

      emit(Submitting());

      try{
        var response = await repo.loginApi(event.email, event.password);
        String token = response.data['token'];

        try {
          await storeToken(token);
        }catch(error){
        //  do nothing
        }

        emit(LoggedIn());

      }catch(value){
        DioError error = value as DioError;

        if(error.response!=null){
          emit(Failed(error.response!.data));
        }else{
          if(error.type == DioErrorType.unknown){
            emit(Failed("Connection Failed"));
          }else{
            emit(Failed("${error.message}"));
          }
        }


      }


    });

  }

}