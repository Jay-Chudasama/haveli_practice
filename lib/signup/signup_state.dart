abstract class SignUpState {}

class Init extends SignUpState {}

class Submitting extends SignUpState {}

class Submitted extends SignUpState {

}

class Failed extends SignUpState {
  String message;

  Failed(this.message);
}
