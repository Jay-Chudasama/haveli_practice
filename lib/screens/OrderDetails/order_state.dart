
import '../../model/Order_details_model.dart';

abstract class OrderDetailsState {}

class Init extends OrderDetailsState {}

class Loading extends OrderDetailsState {}

class Loaded extends OrderDetailsState {
  OrderDetailsModel model;
  Loaded(this.model);
}

class Failed extends OrderDetailsState {
  String message;

  Failed(this.message);
}
