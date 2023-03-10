abstract class AuthEvent {}

class Authenticat extends AuthEvent {
  bool setupAccount;
  Authenticat(this.setupAccount);
}

class Logout extends AuthEvent{}
