class UserDetails {
  UserDetails({
      required this.id,
      required this.email,
      required this.username,
      required this.image,
      required this.bio,
      required this.followers,
      required this.following,
      required this.posts,
      required this.viewedStories,
      required this.inFollowlist,});

  UserDetails.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    image = json['image'];
    bio = json['bio'];
    followers = json['followers'];
    following = json['following'];
    posts = json['posts'];
    viewedStories = json['viewed_stories'] != null ? json['viewed_stories'].cast<int>() : [];
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
  late List<int> viewedStories;
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
    map['viewed_stories'] = viewedStories;
    map['in_followlist'] = inFollowlist;
    return map;
  }

}