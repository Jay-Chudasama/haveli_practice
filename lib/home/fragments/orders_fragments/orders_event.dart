abstract class OrderEvent {}

class Order extends OrderEvent {}

class LoadMore extends OrderEvent {
  String nextUrl;

  LoadMore(this.nextUrl);
}
