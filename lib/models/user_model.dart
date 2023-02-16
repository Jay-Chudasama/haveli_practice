class UserModel{

  late int id;
  late String email,username,image;

  UserModel.fromJson(dynamic json){
    id = json['id'];
    email = json['email'];
    username = json['username'];
    image = json['image'];
  }


}

