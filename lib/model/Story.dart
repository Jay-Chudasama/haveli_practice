class Story {
  Story({
    required this.id,
    required this.image,
    required this.user,
  });

  Story.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    user = json['user'];
  }

  late int id;
  late String image;
  late int user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['user'] = user;
    return map;
  }
}
