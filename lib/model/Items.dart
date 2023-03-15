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
  }
  late int id;
  late String image;
  late String name;
  late int price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name'] = name;
    return map;
  }

}