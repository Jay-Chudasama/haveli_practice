abstract class ForgetState {}

class Init extends ForgetState {}

class Submitting extends ForgetState {}

class Submited extends ForgetState {}

class Failed extends ForgetState {
  String message;
  Failed(this.message);
}
