import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/signup/signup_event.dart';
import 'package:haveliapp/signup/signup_repo.dart';
import 'package:haveliapp/signup/signup_state.dart';
import 'package:haveliapp/utils.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpRepo repo = SignUpRepo();

  SignUpBloc() : super(Init()) {
    on<SignUp>((event, emit) async {
      emit(Submitting());

      try{
        var response = await repo.signUpApi(event.email, event.password);
        String token = response.data['token'];
        try{
          await storeToken(token);
          emit(Submitted());
        }catch(err){
        //  do nothing
        }
      }catch(value){
        DioError error = value as DioError;

        if (error.response != null) {
          emit(Failed(error.response!.data));
        } else {
          if(error.type==DioErrorType.unknown){
            emit(Failed("Please check your internet connection"));
          }else{
            emit(Failed("${error.message}"));
          }
        }
      }


    });
  }
}
