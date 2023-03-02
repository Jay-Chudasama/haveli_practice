abstract class LoginEvent{}

class Login extends LoginEvent{
  String email,password;

  Login(this.email, this.password);
}