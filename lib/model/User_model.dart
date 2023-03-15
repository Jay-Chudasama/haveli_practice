class UserModel {
  UserModel({
      required this.id,
      required this.phone,
      required this.name,});

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
  }
  late int id;
  late String phone;
  late String name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['phone'] = phone;
    map['name'] = name;
    return map;
  }

}