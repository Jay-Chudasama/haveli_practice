class Ordermodel {
  Ordermodel({
    required this.id,
    required this.createdAt,
    required this.type,
    required this.orderStatus,
  });

  Ordermodel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    type = json['type'];
    orderStatus = json['order_status'];
  }

  late String id;
  late String createdAt;
  late String type;
  late String orderStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['type'] = type;
    map['order_status'] = orderStatus;
    return map;
  }
}
