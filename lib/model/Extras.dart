class Extras {
  Extras({
      required this.id,
      required this.image,
      required this.name,});

  Extras.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
  late int id;
  late String image;
  late String name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name'] = name;
    return map;
  }

}