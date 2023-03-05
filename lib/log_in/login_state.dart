abstract class LoginState {}

class Init extends LoginState {}

class Submitting extends LoginState {}

class LoggedIn extends LoginState {}

class Failed extends LoginState {
  String msg;
  Failed(this.msg);
}
