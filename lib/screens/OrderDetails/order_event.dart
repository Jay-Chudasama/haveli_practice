abstract class OrderDetailsEvent {}

class OrderDetails extends OrderDetailsEvent {
  String id;

  OrderDetails(this.id);
}

class Rating extends OrderDetailsEvent{
  String id;
  int rating;

  Rating(this.id, this.rating);
}