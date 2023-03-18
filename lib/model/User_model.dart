class UserModel {
  UserModel({
      required this.id,
      required this.phone,
    required this.address,
    required this.orders,
      required this.name,});

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    orders = json['orders'];
    notifications = json['notifications'];
    address = json['address'];
    cart = json['cart'].map<int>((dynamic id)=>id as int).toList();
  }
  late int id;
  late String phone;
  late String name,address;
  late int orders,notifications;
  late List<int> cart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['phone'] = phone;
    map['name'] = name;
    return map;
  }

}