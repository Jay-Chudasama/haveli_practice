import 'package:haveliapp/auth/auth_event.dart';
import 'package:haveliapp/auth/auth_repo.dart';
import 'package:haveliapp/auth/auth_state.dart';
import 'package:haveliapp/model/user_details.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  Function run;
  AuthRepo repo = AuthRepo();

  AuthBloc(this.run) : super(Init()) {
    on<Authenticat>((event, emit) async {
      emit(Authenticating());
      try {
        var response = await repo.loadUserDetailApi();

        emit(Authenticated(UserDetails.fromJson(response.data),event.setupAccount));
      } catch (value) {
        print(value);
        DioError error = value as DioError;
        if (error.response != null) {
          if (error.response!.statusCode == 403 ||
              error.response!.statusCode == 401) {
            emit(UnAuthenticated());
          } else {
            emit(Failed("Something went wrong!"));
          }
        } else {
          if (error.type == DioErrorType.unknown) {
            emit(Failed("Connection Failed"));
          } else {
            emit(Failed("${error.message}"));
          }
        }
      }
    });
  }
  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    if (change.nextState is Authenticated ||
        change.nextState is Failed ||
        change.nextState is UnAuthenticated) {
      run();
    }
  }
}
