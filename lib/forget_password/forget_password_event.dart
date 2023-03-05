abstract class ForgetEvent {}

class ForgetPassword extends ForgetEvent {
  String email;
  ForgetPassword(this.email);
}
