class Userdetails {


  Userdetails.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    image = json['image'];
    bio = json['bio'];
    followers = json['followers'];
    following = json['following'];
    posts = json['posts'];
    inFollowlist = json['in_followlist'];
  }
  late int id;
  late String email;
  late String username;
  late String image;
  late String bio;
  late int followers;
  late int following;
  late int posts;
  late bool inFollowlist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['username'] = username;
    map['image'] = image;
    map['bio'] = bio;
    map['followers'] = followers;
    map['following'] = following;
    map['posts'] = posts;
    map['in_followlist'] = inFollowlist;
    return map;
  }

}