abstract class ProfileState {}

class Init extends ProfileState {}

class Submitting extends ProfileState {}

class Submited extends ProfileState {}

class Failed extends ProfileState {
  String? msg;

  Failed(this.msg);
}
