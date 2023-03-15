abstract class OtpState {}

class Init extends OtpState {}

class Submitting extends OtpState {}

class Verifyed extends OtpState {}

class Failed extends OtpState {
  String message;

  Failed(this.message);
}
