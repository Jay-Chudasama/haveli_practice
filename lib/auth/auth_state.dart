import '../models/user_model.dart';

abstract class AuthState {}

class Init extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
//  when 200
    User userdata;

    Authenticated(this.userdata);
}

class UnAuthenticated extends AuthState {
//  when  401
}

class Failed extends AuthState {
  String? message;

  Failed(this.message);
}
