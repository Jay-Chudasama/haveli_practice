// {
// "id": 13,
// "email": "dani@g.com",
// "username": "dani_12",
// "image": "/media/profiles/download.jfif",
// "following": true
// }

class SearchModel{

  late int id;
  late String email,username,image;
  late bool following;

  SearchModel.fromJson(dynamic json){

    id = json['id'];
    email = json['email'];
    username = json['username'];
    image = json['image'];
    following = json['following'];

  }

}