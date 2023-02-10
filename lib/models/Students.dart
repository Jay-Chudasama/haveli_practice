class Students {


  Students.fromJson(dynamic json) {
    name = json['name'];
    age = json['age'];
  }
  late String name;
  late int age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['age'] = age;
    return map;
  }

}