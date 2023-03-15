abstract class PhoneState {}

class Init extends PhoneState {}

class Submitting extends PhoneState {}

class Submitted extends PhoneState {}

class Failed extends PhoneState {
  String message;

  Failed(this.message);
}
