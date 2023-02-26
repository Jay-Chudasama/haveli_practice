abstract class OtpState {}

class Init extends OtpState {}
class Submiting extends OtpState {}
class Verifyed extends OtpState {

}
class FAiled extends OtpState {
  String? msg;
  FAiled(this.msg);
}
