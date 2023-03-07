import 'package:haveliapp/auth/auth_bloc.dart';
import 'package:haveliapp/auth/auth_state.dart' as AuthState;
import 'package:haveliapp/main.dart';
import 'package:haveliapp/profile/profile_event.dart';
import 'package:haveliapp/profile/profile_repo.dart';
import 'package:haveliapp/profile/profile_state.dart';
import 'package:haveliapp/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/User_details.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(Init()) {
    ProfileRepo repo = ProfileRepo();
    on<SetupProfile>((event, emit) async {
      emit(Submitting());
      try {
        print(event.file);
        var response = await repo.setUpAccount(event.username, event.file);
        print(response);

        UserDetails userDetails =
            (authBloc.state as AuthState.Authenticated).userDetails;

        userDetails.image = response.data['image'];
        userDetails.username = response.data['username'];
        authBloc.emit(AuthState.Authenticated(userDetails,false));
        emit(Submited());
      } catch (value) {
        print("valuse is ...$value");
        DioError error = value as DioError;
        print("Dio is..............");
        if (error.response != null) {
          emit(Failed(error.response!.data['detail']));
        } else {
          if (error.type == DioErrorType.unknown) {
            emit(Failed("please check your internate connection"));
          } else {
            emit(Failed("${error.message}"));
          }
        }
      }
    });
  }
}
