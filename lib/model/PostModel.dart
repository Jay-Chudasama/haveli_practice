
class PostModel {
  PostModel({
      required this.id,
      required this.user,
      required this.image,
      required this.caption,
      required this.likes,
      required this.createdAt,});

  PostModel.fromJson(dynamic json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    image = json['image'];
    caption = json['caption'];
    likes = json['likes'];
    createdAt = json['created_at'];
    liked = json['liked'];
  }
  late int id;
  late User? user;
  late String image;
  late String caption;
  late int likes;
  late bool liked;
  late String createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    map['image'] = image;
    map['caption'] = caption;
    map['likes'] = likes;
    map['created_at'] = createdAt;
    return map;
  }

}

class User {
  User({
    required this.id,
    required this.email,
    required this.username,
    required this.image,});

  User.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    image = json['image'];
  }
  late int id;
  late String email;
  late String username;
  late String image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['username'] = username;
    map['image'] = image;
    return map;
  }

}