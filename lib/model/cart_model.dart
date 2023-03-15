class CartModel {
  late String name;
  late String image;
  late int qty;
  late int price;
  late int id;

  CartModel.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
    image = json['image'];
    qty = json['quantity'];
    price = json['price'];
  }
}
