import 'Students.dart';

class Model {


  Model.fromJson(dynamic json) {
    name = json['name'];
    if (json['students'] != null) {
      students = [];
      json['students'].forEach((v) {
        students.add(Students.fromJson(v));
      });
    }
  }
  late String name;
  late List<Students> students;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    if (students != null) {
      map['students'] = students.map((v) => v.toJson()).toList();
    }
    return map;
  }

}