abstract class ProfileState {}

class Init extends ProfileState {}
class Submitting extends ProfileState {}
class Submited extends ProfileState {}
class Failed extends ProfileState {
  String message;
  Failed(this.message);
}
