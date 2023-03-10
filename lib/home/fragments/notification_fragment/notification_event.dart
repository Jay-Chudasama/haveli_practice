abstract class NotificationEvent {}

class LoadNotification extends NotificationEvent {

  LoadNotification();
}


class LoadMore extends NotificationEvent{
  String nextUrl;

  LoadMore(this.nextUrl);
}
