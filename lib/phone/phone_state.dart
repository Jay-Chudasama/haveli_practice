abstract class PhoneState{}

class Init extends PhoneState{}
class Submiting extends PhoneState{}
class Submited extends PhoneState{

}
class Failed extends PhoneState{
  String? msg;
  Failed(this.msg);
}