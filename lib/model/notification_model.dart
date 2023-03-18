/// id : 1
/// title : "fasfadsf"
/// body : "fadsfasdf"
/// image : "/media/notifications/c887f58a-7db9-4b35-85db-15573ce3b515.__CR00970600_PT0_SX970_V1___.jpg"
/// created_at : "2022-03-22T18:36:24.448257+05:30"

class NotificationModel {
  NotificationModel({
    int? id,
    String? title,
    String? body,
    String? image,
    String? createdAt,}){
    _id = id;
    _title = title;
    _body = body;
    _image = image;
    _createdAt = createdAt;
  }

  NotificationModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
    _image = json['image'];
    _createdAt = json['created_at'];
  }
  int? _id;
  String? _title;
  String? _body;
  String? _image;
  String? _createdAt;

  int? get id => _id;
  String? get title => _title;
  String? get body => _body;
  String? get image => _image;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    return map;
  }

}