class User{

  late int id;
  late String name,image,phone;

  User.fromJson(dynamic json){
    id = json['id'];
    image = json['image'];
    name = json['name'];
    phone = json['phone'];
  }


}