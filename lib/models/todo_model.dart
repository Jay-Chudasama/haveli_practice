class TodoModel {
  late int id;
  late bool completed;
  late String toDo;
  late String dateTime;
  bool divider = false;

  TodoModel.divider({this.divider = true});

  TodoModel.fromJson(dynamic json) {
    id = json["id"];
    completed = json['completed'];
    toDo = json['todo'];
    dateTime = json['datetime'];
  }
}
