
class OrderDetailsModel {
  OrderDetailsModel({
      required this.id,
      required this.createdAt,
      required this.type,
      required this.orderStatus,
      required this.paymentId,
      required this.paymentStatus,
      required this.address,
      required this.itemsPrice,
      required this.deliveryPrice,
      required this.totalAmount,
      required this.items,});

  OrderDetailsModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    type = json['type'];
    orderStatus = json['order_status'];
    paymentId = json['payment_id'];
    paymentStatus = json['payment_status'];
    address = json['address'];
    itemsPrice = json['items_price'];
    deliveryPrice = json['delivery_price'];
    totalAmount = json['total_amount'];
    rating = json['rating'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
  }
  late String id;
  late String createdAt;
  late String type;
  late String orderStatus;
  late String paymentId;
  late String paymentStatus;
  late String address;
  late int itemsPrice;
  late int deliveryPrice;
  late int totalAmount;
  late int rating;
  late List<Items> items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['type'] = type;
    map['order_status'] = orderStatus;
    map['payment_id'] = paymentId;
    map['payment_status'] = paymentStatus;
    map['address'] = address;
    map['items_price'] = itemsPrice;
    map['delivery_price'] = deliveryPrice;
    map['total_amount'] = totalAmount;
    if (items != null) {
      map['items'] = items.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Items {
  Items({
    required this.id,
    required this.image,
    required this.name,
    required this.price,});

  Items.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    qty = json['quantity'];
  }
  late int id;
  late String image;
  late String name;
  late int price;
  late int qty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name'] = name;
    return map;
  }

}