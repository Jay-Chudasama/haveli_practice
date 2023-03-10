import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';

import '../../../model/NotificationModel.dart';

abstract class NotificationState {}

class Init extends NotificationState {}

class Loading extends NotificationState {}

class Loaded extends NotificationState {
 List <NotificationModel> list;
  String? nextUrl;

  Loaded(this.list, this.nextUrl);
}

class LoadingMore extends Loaded{
  LoadingMore(super.list,super.nextUrl);
}


class Failed extends NotificationState {
  String message;

  Failed(this.message);
}
