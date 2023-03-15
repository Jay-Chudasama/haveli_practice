import 'package:haveliapp/model/User_model.dart';

abstract class AuthState {}

class Init extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
  UserModel model;
  Authenticated(this.model);
}

class UnAuthenticated extends AuthState {}

class Failed extends AuthState {
  String message;

  Failed(this.message);
}
