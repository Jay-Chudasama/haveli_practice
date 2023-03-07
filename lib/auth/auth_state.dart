// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../model/User_details.dart';

abstract class AuthState {}

class Init extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
  bool setupAccount = false;
  UserDetails userDetails;
  Authenticated(this.userDetails,this.setupAccount);
}

class UnAuthenticated extends AuthState {}

class Failed extends AuthState {
  String message;
  Failed(
    this.message,
  );
}
