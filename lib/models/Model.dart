class Model {
  Model({
      required this.userId,
      required this.id,
      required this.title,
      required this.completed,});

  Model.fromJson(dynamic json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }
  late int userId;
  late int id;
  late String title;
  late bool completed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['id'] = id;
    map['title'] = title;
    map['completed'] = completed;
    return map;
  }

}