class Results {
  Results({
      required this.id,
      required this.email,
      required this.username,
      required this.image,
      required this.following,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    image = json['image'];
    following = json['following'];
  }
  late int id;
  late String email;
  late String username;
  late String image;
  late bool following;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['username'] = username;
    map['image'] = image;
    map['following'] = following;
    return map;
  }

}