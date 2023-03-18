




import '../model/notification_model.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  List<NotificationModel> notifications;
  String? nextUrl;

  NotificationsLoaded(this.notifications,this.nextUrl);
}

class NotificationsFailed extends NotificationsState {
  String message;

  NotificationsFailed(this.message);
}