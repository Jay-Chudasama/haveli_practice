
import 'dart:io';

abstract class ProfileEvent {}

class SetupProfile extends ProfileEvent {
  String username;
 File? file;
  SetupProfile(this.username,this.file);
}
