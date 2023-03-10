
class NotificationModel {


  NotificationModel.fromJson(dynamic json) {
    id = json['id'];
    notificationBy = json['notification_by'] != null ? NotificationBy.fromJson(json['notification_by']) : null;
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
    createdAt = json['created_at'];
  }
  late int id;
  late NotificationBy? notificationBy;
  late Post? post;
  late String createdAt;



}


class NotificationBy {


  NotificationBy.fromJson(dynamic json) {
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

class Post {


  Post.fromJson(dynamic json) {
    image = json['image'];
    caption = json['caption'];
  }
  late String image;
  late String caption;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = image;
    map['caption'] = caption;
    return map;
  }

}